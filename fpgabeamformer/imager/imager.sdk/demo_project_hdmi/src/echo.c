/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

#include <stdio.h>
#include <string.h>
#include <xtmrctr.h>

#include "lwip/err.h"
#include "lwip/tcp.h"
#include "params.h"
#include "xil_io.h"
#if defined (__arm__) || defined (__aarch64__)
#include "xil_printf.h"
#endif

// Scan converter includes and parameters
#include "scanconverter.h"
#include "hdmi_control.h"
#include "xbasic_types.h"
#include "../library/microblaze/inc/atv_platform.h"
#include "transmitter.h"
#include "xuartlite_l.h"
#include "cf_hdmi.h"
#include "pres_old_sphere_complete_2D.h"

#define HDMI_CALL_INTERVAL_MS 10

// Formatting of the options string. Allows to add fields in a slightly
// less painful way. To do so, just add an (OFFSET, SIZE) pair as in the template that follows,
// and increase OPTIONS_STRING_LENGTH.

// Three characters and a space
#define PREAMBLE_START_OFFSET    0
#define PREAMBLE_SIZE            4
// Three digits and a space
#define NAPPE_START_OFFSET       (PREAMBLE_START_OFFSET + PREAMBLE_SIZE)
#define NAPPE_SIZE               4
// Four digits and a space
#define RADIAL_START_OFFSET      (NAPPE_START_OFFSET + NAPPE_SIZE)
#define RADIAL_SIZE              5
// Three digits and a space
#define AZIMUTH_START_OFFSET     (RADIAL_START_OFFSET + RADIAL_SIZE)
#define AZIMUTH_SIZE             4
// Three digits and a space
#define ELEVATION_START_OFFSET   (AZIMUTH_START_OFFSET + AZIMUTH_SIZE)
#define ELEVATION_SIZE           4
// Five digits and a space
#define RFD_START_OFFSET         (ELEVATION_START_OFFSET + ELEVATION_SIZE)
#define RFD_SIZE                 6
// Five digits (signed: -9999 to 99999) and a space
#define ZERO_START_OFFSET        (RFD_START_OFFSET + RFD_SIZE)
#define ZERO_SIZE                6
// Three digits and a space
#define LC_START_OFFSET          (ZERO_START_OFFSET + ZERO_SIZE)
#define LC_SIZE                  4
// Three digits and a space
#define BRIGHTNESS_START_OFFSET  (LC_START_OFFSET + LC_SIZE)
#define BRIGHTNESS_SIZE          4
// Three digits and a space
#define CUT_VALUE_START_OFFSET   (BRIGHTNESS_START_OFFSET + BRIGHTNESS_SIZE)
#define CUT_VALUE_SIZE           4
// Three digits and a space
#define CUT_DIR_START_OFFSET     (CUT_VALUE_START_OFFSET + CUT_VALUE_SIZE)
#define CUT_DIR_SIZE             4
// Either "SWSC " or "HWSC "
#define SWHW_SC_START_OFFSET     (CUT_DIR_START_OFFSET + CUT_DIR_SIZE)
#define SWHW_SC_SIZE             5
// Three digits and a space
#define SC_RES_X_START_OFFSET    (SWHW_SC_START_OFFSET + SWHW_SC_SIZE)
#define SC_RES_X_SIZE            4
// Three digits and a space
#define SC_RES_Y_START_OFFSET    (SC_RES_X_START_OFFSET + SC_RES_Y_SIZE)
#define SC_RES_Y_SIZE            4
// "FIFO", "STRM", "UBLZ" or "RESC"
#define CMD_START_OFFSET         (SC_RES_Y_START_OFFSET + SC_RES_Y_SIZE)
#define CMD_SIZE                 4
// The sum of all the previous string blocks, plus 1 (so that we can append a \0)
#define OPTIONS_STRING_LENGTH    (PREAMBLE_SIZE + NAPPE_SIZE + RADIAL_SIZE + AZIMUTH_SIZE + ELEVATION_SIZE + RFD_SIZE + ZERO_SIZE + LC_SIZE + BRIGHTNESS_SIZE + CUT_VALUE_SIZE + CUT_DIR_SIZE + SWHW_SC_SIZE + SC_RES_X_SIZE + SC_RES_Y_SIZE + CMD_SIZE + 1)

// Enable this #define for additional debug messages
//#define DEEP_DEBUG 1
// Enable this #define to display SC images on an HDMI-attached screen.
#define HDMI_OUTPUT_ENABLED

// 2D
//#define RF_DEPTH                (2622)
//#define ZERO_OFF                (20)
// 3D 16x16
//#define RF_DEPTH                (2578)
//#define ZERO_OFF                (19)

enum fsm_state {
  AWAITING,
  RECEIVEDOPTIONS,
  RECEIVINGRF,
  RUNNINGBF,
  WAITINGBF,
  SENDINGNAPPES
};

enum OPMODE {
  MODE_FIFO,
  MODE_STRM,
  MODE_UBLZ,
  MODE_RESC
};

// "MAX" Macro:
#define MAX(a, b) ((a) > (b) ? (a) : (b))

// "MIN" Macro:
#define MIN(a, b) ((a) < (b) ? (a) : (b))

/* //"MAX" function:
 uint32_t MAX (uint32_t a, uint32_t b)
{
    return a ^ ((a ^ b) & -(a < b));
} // ((a >= b) ? a : b)

// "MIN" function:
uint32_t MIN (uint32_t a, uint32_t b)
{
    return b ^ ((a ^ b) & -(a < b));
} // ((a <= b) ? a : b) */

int send_nappes(struct tcp_pcb *tpcb, int k);
int send_pixels(struct tcp_pcb *tpcb, int k);

static const unsigned long detailedTiming[7][9] =
{
    {25180000, 640, 144, 16, 96, 480, 29, 10, 2},
    {40000000, 800, 256, 40, 128, 600, 28, 1, 4},
    {65000000, 1024, 320, 136, 24, 768, 38, 3, 6},
    {74250000, 1280, 370, 110, 40, 720, 30, 5, 5},
    {84750000, 1360, 416, 136, 72, 768, 30, 3, 5},
    {108000000, 1600, 400, 32, 48, 900, 12, 3, 6},
    {148500000, 1920, 280, 44, 88, 1080, 45, 4, 5}
};

// TODO should just rename this file.

// Counters of the nappe index, total (across insonifications)
int abs_current_nappe = 0;
int abs_next_rf_nappe = 0;
int transmissions_to_perform = 0;
int current_run = 0;
int ready_nappe_count = 0;
// Counter of the nappe index, relative (within this insonification)
int rel_current_nappe = 0;

int compounding_operator = 0;
int compounding_count = 0;
int azimuth_zone_count = 0;
int elevation_zone_count = 0;
int total_zone_count = 0;
volatile char *tx_ok = "ok#";
void *nappe_pointer = (void *)NAPPE_MEMORY;
void *image_pointer = (void *)SC_IMAGE_MEMORY;
char rx_message[OPTIONS_STRING_LENGTH];
int counter = 0;
int LC_value = 45;
unsigned int brightness_value = 0;
int use_hw_sc = 0;              // 0: send back BF voxels and let the GUI SC them; 1: send back the SCIP output
unsigned int sc_res_x = 0, sc_res_y = 0;
unsigned int cut_value = 0;
unsigned int cut_direction = 0; // 0: AZI/RAD; 1: ELE/AZI; 2: ELE/RAD (only AZI/RAD in 2D)
unsigned int radial_lines = 0;
unsigned int azimuth_lines = 0;
unsigned int elevation_lines = 0;
unsigned int rf_depth = 0;
int zero_offset = 0;
int transmitted_voxels = 0, transmitted_pixels = 0;
enum fsm_state state = AWAITING;
enum OPMODE op_mode = MODE_FIFO;
struct tcp_pcb *pcb2;
unsigned int old_sc_res_x = BOOT_IMG_WIDTH;
unsigned int old_sc_res_y = BOOT_IMG_HEIGHT;

// These two take care of fragmentation of input RF samples across packets
u_char leftovers[4];
int leftover_bytes;

XTmrCtr xps_timer_0;
XTmrCtr* timer_0 = &xps_timer_0;
unsigned int start_time, end_time;

void change_state(enum fsm_state new_state)
{
	state = new_state;
#ifdef DEEP_DEBUG
	xil_printf("Moving to new state %s\n\r", (new_state == AWAITING ? "AWAITING" :
											 (new_state == RECEIVEDOPTIONS ? "RECEIVEDOPTIONS" :
											 (new_state == RECEIVINGRF ? "RECEIVINGRF" :
											 (new_state == RUNNINGBF ? "RUNNINGBF" :
											 (new_state == WAITINGBF ? "WAITINGBF" :
											 (new_state == SENDINGNAPPES ? "SENDINGNAPPES" : "UNKNOWN")))))));
#endif
}

void change_mode(enum OPMODE new_mode)
{
	op_mode = new_mode;
#ifdef DEEP_DEBUG
	xil_printf("Moving to new mode %s\n\r", (new_mode == MODE_FIFO ? "MODE_FIFO" :
											(new_mode == MODE_STRM ? "MODE_STRM" :
											(new_mode == MODE_UBLZ ? "MODE_UBLZ" :
											(new_mode == MODE_RESC ? "MODE_RESC" : "UNKNOWN")))));
#endif
}

// Compounding function
err_t do_compounding()
{
    err_t err = 0;
    uint32_t i = 0, j = 0, k = 0, c = 0;
    int current_value = 0, comp_data = 0, max_value = 0;
    uint32_t base_address = NAPPE_MEMORY;   // Location in memory where the BF has to write outputs
    
    for (k = 0; k < elevation_lines; k ++)
    {
        for (j = 0; j < azimuth_lines; j ++)
        {
            for (i = 0; i < radial_lines; i ++)
            {
                for (c = 0; c < compounding_count; c ++)
                {
                    current_value = Xil_In32(base_address + c * radial_lines * azimuth_lines * elevation_lines * 4);
                    if (compounding_operator == 1)    // compounding_operator is "averaging"
                    {
                        // The accumulation should not overflow and the integer division should
                        // have minimal accuracy effects
                        comp_data = comp_data + current_value;
                        if (c == compounding_count - 1)
                            comp_data = comp_data / compounding_count;
                    }
                    else if (compounding_operator == 2)  // compounding_operator is "averaging - maximum"
                    {
                        // The accumulation should not overflow and the integer division should
                        // have minimal accuracy effects
                        comp_data = comp_data + current_value;
                        max_value = MAX (max_value, current_value);
                        if (c == compounding_count - 1)
                            comp_data = (comp_data - max_value) / compounding_count;
                    }
                    else if (compounding_operator == 3)  // compounding_operator is "minimum"
                    {
                        if (c == 0)
                            comp_data = current_value;
                        
                        comp_data = MIN (comp_data, current_value);
                    }
                    else if (compounding_operator == 4)  // compounding_operator is "Mean/Standard Deviation (MSD)"
                    {
                        // TODO
                    }
                    else if (compounding_operator == 5)  // compounding_operator is "Zero-Reversal (ZREV)"
                    {
                        // TODO
                    }
                }
                Xil_Out32(base_address, comp_data);
                base_address = base_address + 4;
                comp_data = 0;
                max_value = 0;
            }
        }
    }
    return err;
}

// Scan conversion function
err_t run_scanconversion()
{
	err_t err = 0;
#ifdef HDMI_OUTPUT_ENABLED
	XStatus status = XTmrCtr_Initialize(timer_0, XPAR_TMRCTR_0_DEVICE_ID);
	if (status != XST_SUCCESS)
	{
		printf("Problem with timer initialization. Exiting. \n");
		return 1;
	}

	start_time =  XTmrCtr_GetValue(timer_0, 0);
	XTmrCtr_Start(timer_0, 0);

#ifdef DEEP_DEBUG
	xil_printf("run_scanconversion stage 1\n\r");
#endif

	//Feed the log-compression value to the LC register at address 0x48
	Xil_Out32(SC_LC_DB_REGISTER, LC_value);
	Xil_Out32(SC_CUT_VALUE_REGISTER, cut_value);
	Xil_Out32(SC_CUT_DIRECTION_REGISTER, cut_direction);

	if (brightness_value == 0)
	{
		// Assign 0 to bit 0 of register 0x40, which indicates calculating the brightness gain value
		// at runtime by taking the highest voxel value of the image
		Xil_Out32(SC_MAX_VOXEL_MODE_REGISTER, 0);
		// This resets the auto-detected max voxel value from the previous reconstruction, if any
		Xil_Out32(SC_START_REGISTER, 0x20);
	}
	else
	{
		// Assign 1 to bit 0 of register 0x40, which indicates the use of "brightness_value" fed to
		// the lc_max_value register - of address 0x44 - as the brightness gain value to adjust the image brightness
		Xil_Out32(SC_MAX_VOXEL_MODE_REGISTER, 1);
		// Feed the brightness gain value to the lc_max_value register at address 0x44.
		// The value in dB must be converted into an absolute voxel brightness value;
		// the dB input has a range [1, 192] (== 32-bit dynamic range)
		// To achieve a bright image, we need to pass a small value into
		// "SC_MAX_VOXEL_REGISTER", so the exponent is taken with inverted sign
		if (brightness_value > 192)
			xil_printf("ERROR: brightness max value is 192 dB, received %u\n\r", brightness_value);
		brightness_value = 193 - brightness_value;
		// +20 dB => 10 times smaller reference voxel intensity
		brightness_value = pow(10, ((float)brightness_value) / 20);
		//xil_printf("test precision of calc = %u\n\r", brightness_value);
		Xil_Out32(SC_MAX_VOXEL_REGISTER, brightness_value);
	}

	// Scan Conversion
#if (USE_SC_MASTER == 1)
	scanconv_configure(radial_lines, azimuth_lines, elevation_lines, sc_res_x, sc_res_y, USE_SC_MASTER);

	Xil_Out32(SC_DDR_IN_REGISTER,  NAPPE_MEMORY);
	Xil_Out32(SC_DDR_OUT_REGISTER, SC_IMAGE_MEMORY);

	#ifdef DEEP_DEBUG
	xil_printf("run_scanconversion stage 2 master\n\r");
	#endif

	// Test input (only works in 2D): overwrite the BF data with
	// a custom image, all black with a central white line
	// uint32_t ptr = 0;
	// for (uint32_t j = 0; j < radial_lines; j ++){
	//     for (uint32_t i = 0; i < azimuth_lines; i ++, ptr ++){
	//          Xil_Out32(DDR_BASEADDR + 0x40000000 + ptr * 4, 0);
	//          if (i == azimuth_lines / 2)
	//              Xil_Out32(DDR_BASEADDR + 0x40000000 + ptr * 4, 0x0000FFFF);
	//     }
	//}

	Xil_Out32(SC_START_REGISTER, 0x10); //start master mode SC ---> i.e. start the read of voxels from memory, and LC and SC processes automatically

	#ifdef DEEP_DEBUG
	xil_printf("run_scanconversion stage 3 master\n\r");
	#endif

	// Wait until bit 7 becomes 1 which indicates that the master has finished everything and we should write on the screen
	uint32_t status_read = 0;
	while ((status_read & 0x80) == 0)
	{
		status_read = Xil_In32(SC_STATUS_REGISTER);
	#ifdef DEEP_DEBUG
		xil_printf("111 %x, 0x28:%d, 0x48:%d, 0xa0:%x, 0xa4:%x, 0xa8:%x, 0xb0:%x, 0xb4:%x, 0xb8:%x, 0xbc:%x, 0x0c:%x \n\r", status_read,
									Xil_In32(SC_RADIAL_REGISTER), Xil_In32(SC_LC_DB_REGISTER),
									Xil_In32(XPAR_SCANCONVERTERIP_0_BASEADDR + 0xa0), Xil_In32(XPAR_SCANCONVERTERIP_0_BASEADDR + 0xa4),
									Xil_In32(XPAR_SCANCONVERTERIP_0_BASEADDR + 0xa8), Xil_In32(XPAR_SCANCONVERTERIP_0_BASEADDR + 0xb0),
									Xil_In32(XPAR_SCANCONVERTERIP_0_BASEADDR + 0xb4), Xil_In32(XPAR_SCANCONVERTERIP_0_BASEADDR + 0xb8),
									Xil_In32(XPAR_SCANCONVERTERIP_0_BASEADDR + 0xbc), Xil_In32(XPAR_SCANCONVERTERIP_0_BASEADDR + 0x0c));
	#endif
	}

	#ifdef DEEP_DEBUG
	xil_printf("run_scanconversion stage 4 master\n\r");
	#endif

	// The image is automatically saved to the DDR memory at a specific location where the HDMI function
	// "DDRVideoWr" will use to draw on screen
	// term_print_nappes(sc_res_x, sc_res_y);
#else
	scanconv_configure(radial_lines, azimuth_lines, elevation_lines, sc_res_x, sc_res_y, USE_SC_MASTER);
	#ifdef DEEP_DEBUG
	xil_printf("run_scanconversion stage 2 slave\n\r");
	#endif
	// Give the nappe voxels to the scan converter module from the NAPPE_DATA array
	// load_nappe_data_scanconv_debug(NAPPES_DATA, SC_SIZE_X, SC_SIZE_Y, cut_direction, cut_value, radial_lines, azimuth_lines, elevation_lines);
	// Xil_Out32(DDR_BASEADDR+0x40000000 + (180*64+32)*4, 88888);
	load_nappe_data_scanconv(NAPPE_MEMORY, sc_res_x, sc_res_y, cut_direction, cut_value, radial_lines, azimuth_lines, elevation_lines);

	#ifdef DEEP_DEBUG
	xil_printf("run_scanconversion stage 3 slave\n\r");
	#endif

	Xil_Out32(SC_START_REGISTER, 0x04); //start SC process based on that the data already loaded into the block using "load_nappe_data_scanconv" function (i.e. slave mode)

	// Save the image to the DDR memory at a specific location where the HDMI function
	// "DDRVideoWr" will use to draw on screen
	// term_print_nappes(sc_res_x, sc_res_y);
	output_nappes(SC_IMAGE_MEMORY, sc_res_x, sc_res_y);
	// Xil_Out32(SC_IMAGE_MEMORY + (1920*10+200)*4, 0xff00);
	#ifdef DEEP_DEBUG
	xil_printf("run_scanconversion stage 4 slave\n\r");
	#endif
#endif

	//term_print_nappes(sc_res_x, sc_res_y);
	DDRVideoWr(detailedTiming[RESOLUTION][1], detailedTiming[RESOLUTION][5], sc_res_x, sc_res_y);

	//uint32_t StartCount = HAL_GetCurrentMsCount();
	//for(uint32_t i=0; i<10; i++)
	//{
	//	if (ATV_GetElapsedMs (StartCount, NULL) >= HDMI_CALL_INTERVAL_MS)
	//	{
	//		StartCount = HAL_GetCurrentMsCount();
	//		if (APP_DriverEnabled())
	//			ADIAPI_TransmitterMain();
	//	}
	//}

	XTmrCtr_Stop(timer_0, 0);
	end_time = XTmrCtr_GetValue(timer_0, 0);
	int elapsed_time = end_time - start_time; // in clks
	int frequency = 133000; // Divided by 1000 not to run into int32 overflows
	int seconds = (elapsed_time / 1000 / frequency);
	int hundredths = ((elapsed_time / 1000 - (seconds * frequency)) * 100) / frequency;
	xil_printf("The SC and HDMI elapsed time is %d ticks and %d.%02d s\n\r", elapsed_time, seconds, hundredths);
#endif
	return err;
}

int process_data()
{
	// This state is for UBLZ mode.
	if (state == RUNNINGBF)
	{
		int status_reg_value = (int)Xil_In32(BEAMFORMER_STATUS_REG);
		// bit [0]
		int ready_bit = status_reg_value & 0x00000001;
		if (ready_bit == 0)
		{
			xil_printf("ERROR: Beamformer is not ready at RECEIVINGRF! Status: %d\n\r", status_reg_value);
		}
#ifdef DEEP_DEBUG
		else
		{
			xil_printf("Beamformer is ready at RUNNINGBF, status: 0x%x\n\r", status_reg_value);
			xil_printf("Telling beamformer to start a nappe... \n\r");
		}
#endif

		// Run until we reach the next nappe needing fresh RF data
		while (abs_current_nappe < abs_next_rf_nappe || (abs_current_nappe > 32768 && abs_next_rf_nappe < 32768))
		{
			// This command tells the beamformer to start calculating
			Xil_Out32(BEAMFORMER_COMMAND_REG, 1);

			// Wait until there are nappes in the output buffer of the beamformer
			do
			{
				status_reg_value = (int)Xil_In32(BEAMFORMER_STATUS_REG);
				// The ready counter is in the 16 MSBs
				ready_nappe_count = (status_reg_value & 0xFFFF0000) >> 16;
			} while (ready_nappe_count == abs_current_nappe);

			// We have moved one up
			abs_current_nappe = ready_nappe_count;
		}
		
		// TODO this check will probably fail when the abs_next_rf_nappe counter wraps around 65535 -> 0
		// (after ~100 frames)
		if (abs_current_nappe % radial_lines == 0)
			transmissions_to_perform --;
			
		// In UBLZ mode, reaching abs_next_rf_nappe is not a guarantee of reaching the end
		// of an image, even more so because compounding/zone imaging may require further transmissions.
		// Thus, rely on this flag to see when we're really done.
		if (transmissions_to_perform == 0)
		{
			// xil_printf("Actual ready nappe count %d\n\r", ready_nappe_count);
			// Image compounding
			if (compounding_count > 1)
			{
				// xil_printf("Applying compounding for the images. \n\r");
				do_compounding();
			}
			// Scan Conversion
			run_scanconversion();
		}

#ifdef DEEP_DEBUG
		int status2_reg_value = (int)Xil_In32(BEAMFORMER_STATUS2_REG);
		int status3_reg_value = (int)Xil_In32(BEAMFORMER_STATUS3_REG);
		int status4_reg_value = (int)Xil_In32(BEAMFORMER_STATUS4_REG);
		int status5_reg_value = (int)Xil_In32(BEAMFORMER_STATUS5_REG);
		int status6_reg_value = (int)Xil_In32(BEAMFORMER_STATUS6_REG);
		int status7_reg_value = (int)Xil_In32(BEAMFORMER_STATUS7_REG);
		xil_printf("Nappe %d reached, status 0x%08x, status2 0x%08x, status3 0x%08x, status4 0x%08x, status5 0x%08x, status6 0x%08x, status7 0x%08x\n\r", ready_nappe_count, status_reg_value, status2_reg_value, status3_reg_value, status4_reg_value, status5_reg_value, status6_reg_value, status7_reg_value);
		// bit [1]
		int busy_bit = (status_reg_value & 0x00000002) >> 1;
		err_t err = 0;
		// bit [0]
		ready_bit = status_reg_value & 0x00000001;
		if (busy_bit == 1 && ready_bit == 1)
		{
			xil_printf("ERROR: Beamformer claims to be both busy and ready!\n\r");
			err = 2;
		}
		if (busy_bit == 0 && ready_bit == 0)
		{
			xil_printf("ERROR: Beamformer claims to be neither busy nor ready!\n\r");
			err = 3;
		}
#endif
	}
	// This state is for STRM/FIFO mode.
	else if (state == WAITINGBF)
	{
		int status_reg_value = (int)Xil_In32(BEAMFORMER_STATUS_REG);
		// The ready counter is in the 16 MSBs
		int ready_nappe_count = (status_reg_value & 0xFFFF0000) >> 16;
#ifdef DEEP_DEBUG
		int status2_reg_value = (int)Xil_In32(BEAMFORMER_STATUS2_REG);
		int status3_reg_value = (int)Xil_In32(BEAMFORMER_STATUS3_REG);
		int status4_reg_value = (int)Xil_In32(BEAMFORMER_STATUS4_REG);
		int status5_reg_value = (int)Xil_In32(BEAMFORMER_STATUS5_REG);
		int status6_reg_value = (int)Xil_In32(BEAMFORMER_STATUS6_REG);
		int status7_reg_value = (int)Xil_In32(BEAMFORMER_STATUS7_REG);
		xil_printf("Still waiting, at nappe %d of target %d, status 0x%08x, status2 0x%08x, status3 0x%08x, status4 0x%08x, status5 0x%08x, status6 0x%08x, status7 0x%08x\n\r", ready_nappe_count, abs_next_rf_nappe, status_reg_value, status2_reg_value, status3_reg_value, status4_reg_value, status5_reg_value, status6_reg_value, status7_reg_value);
#endif
		if (ready_nappe_count >= abs_next_rf_nappe && (ready_nappe_count < 32768 || abs_next_rf_nappe > 32768))
		{
			abs_current_nappe = abs_next_rf_nappe;
#ifdef DEEP_DEBUG
			int status2_reg_value = (int)Xil_In32(BEAMFORMER_STATUS2_REG);
			int status3_reg_value = (int)Xil_In32(BEAMFORMER_STATUS3_REG);
			int status4_reg_value = (int)Xil_In32(BEAMFORMER_STATUS4_REG);
			int status5_reg_value = (int)Xil_In32(BEAMFORMER_STATUS5_REG);
			int status6_reg_value = (int)Xil_In32(BEAMFORMER_STATUS6_REG);
			int status7_reg_value = (int)Xil_In32(BEAMFORMER_STATUS7_REG);
			xil_printf("Nappe %d reached, status 0x%08x, status2 0x%08x, status3 0x%08x, status4 0x%08x, status5 0x%08x, status6 0x%08x, status7 0x%08x\n\r", ready_nappe_count, status_reg_value, status2_reg_value, status3_reg_value, status4_reg_value, status5_reg_value, status6_reg_value, status7_reg_value);
#endif

			// In STRM mode, anytime we reach abs_next_rf_nappe, the whole image
			// is done - proceed to compounding & SC
			// Image compounding
			if (compounding_count > 1)
			{
				// xil_printf("Applying compounding for the images. \n\r");
				do_compounding();
			}
			// Scan Conversion
			run_scanconversion();
			change_state(SENDINGNAPPES);
		}
	}
	else if (state == SENDINGNAPPES)
	{
		// Send out a packet of nappe voxels. "transmitted_voxels" accumulates the count of
		// how many voxels have gone. When "transmitted_voxels" reaches the end of the nappe,
		// the function send_nappes itself will finalize the transmission and
		// reset "transmitted_voxels" to 0.
		// The function will be called multiple times, at each process_data() invocation.
		// Over a few runs, it will send out a nappe. Then, it will move on to subsequent nappes.
		// Eventually, it will send out the last nappe and change the FSM state, thus
		// readying the board for a new command.
		// TODO the check below is quite unclear and numbers are hardcoded
		// TODO with this approach, we avoid timing problems but we send out at most one packet per
		// timer interval. This packet may not even be completely full (see this "if").
		// Optimize performance!!!!!!!!!!
		if (pcb2->snd_buf > TCP_MSS && pcb2->snd_queuelen < TCP_SND_QUEUELEN / 2)
		{
			// SW SC: send out the BF voxels and let the GUI sort out SC.
			if (use_hw_sc == 0)
				transmitted_voxels = send_nappes(pcb2, transmitted_voxels);
			// HW SC: send out the SC pixels.
			else
				transmitted_pixels = send_pixels(pcb2, transmitted_pixels);
		}
	}

	return ERR_OK;
}

err_t send_ok(struct tcp_pcb *tpcb)
{
	err_t err = tcp_write(tpcb, (void *)tx_ok, 3, 1);
	if (err != 0)
		xil_printf("ERROR: transmission error %d\n\r", err);
	tcp_output(tpcb);
	return err;
}

err_t recv_callback(void *arg, struct tcp_pcb *tpcb,
                               struct pbuf *p, err_t err)
{
	/* do not read the packet if we are not in ESTABLISHED state */
	if (!p) {
		tcp_close(tpcb);
		tcp_recv(tpcb, NULL);
		return ERR_OK;
	}

	/* indicate that the packet has been received */
	tcp_recved(tpcb, p->len);
	pcb2 = tpcb;

	int end_rf = 0;

	/* process the communication */
	switch (state)
	{
		case AWAITING:
			// TODO if resc, could this line be trying to copy too many chars?
			memcpy(rx_message, p->payload + p->len - 11, 11); //TODO this operation could be functionized
			rx_message[11] = '\0';

			if (strstr(rx_message, "#") != NULL)
			{
				// Char [1 : 0] is the azimuth zone count
				azimuth_zone_count = (rx_message[0] - '0') * 10 + (rx_message[1] - '0');
				// Char [2] is an 'x'
				// Char [4 : 3] is the elevation zone count
				elevation_zone_count = (rx_message[3] - '0') * 10 + (rx_message[4] - '0');
				total_zone_count = azimuth_zone_count * elevation_zone_count;
				// Char [5] is an underscore
				// Char [7 : 6] is the compounding count
				compounding_count = (rx_message[6] - '0') * 10 + (rx_message[7] - '0');
				// Char [8] is an underscore
				// Char [9] is the compounding operator
				compounding_operator = (rx_message[9] - '0');
				// Char [10] is a #
				// Communicate the parameters to the beamformer
				int options_reg_value = azimuth_zone_count + (elevation_zone_count << 5) + (compounding_count << 10);
				Xil_Out32(BEAMFORMER_OPTIONS_REG, options_reg_value);
#ifdef DEEP_DEBUG
				xil_printf("Azimuth Zone Count: %d, Elevation Zone Count: %d, Compound Count: %d, Compounding_Operator: %d, options: %x\n\r", azimuth_zone_count, elevation_zone_count, compounding_count, compounding_operator, options_reg_value);
#endif
			}
			else if (strstr(rx_message, "$") != NULL)
			{
#ifdef DEEP_DEBUG
				xil_printf("Re-Scan-Conversion flow.\n\r");
#endif
			}
			change_state(RECEIVEDOPTIONS);
			send_ok(tpcb);
		break;
		case RECEIVEDOPTIONS:
			memcpy(rx_message, p->payload + p->len - OPTIONS_STRING_LENGTH + 1, OPTIONS_STRING_LENGTH - 1);
			rx_message[OPTIONS_STRING_LENGTH - 1] = '\0';
#ifdef DEEP_DEBUG
			xil_printf(rx_message);
#endif

			if (strstr(rx_message, "NN:") != NULL)
			{
				// In UBLZ mode, next_nappe is the next syncing point.
				// In STRM/FIFO modes, next_nappe will be the same as radial_lines + 1,
				// but in actual fact the BF may need to run more nappes if zone/compound
				// imaging is enabled. Adjust accordingly.
				int next_nappe = (rx_message[NAPPE_START_OFFSET + 0] - '0') * 100 + (rx_message[NAPPE_START_OFFSET + 1] - '0') * 10 + (rx_message[NAPPE_START_OFFSET + 2] - '0');
				radial_lines = (rx_message[RADIAL_START_OFFSET + 0] - '0') * 1000 + (rx_message[RADIAL_START_OFFSET + 1] - '0') * 100 + (rx_message[RADIAL_START_OFFSET + 2] - '0') * 10 + (rx_message[RADIAL_START_OFFSET + 3] - '0');
				azimuth_lines = (rx_message[AZIMUTH_START_OFFSET + 0] - '0') * 100 + (rx_message[AZIMUTH_START_OFFSET + 1] - '0') * 10 + (rx_message[AZIMUTH_START_OFFSET + 2] - '0');
				elevation_lines = (rx_message[ELEVATION_START_OFFSET + 0] - '0') * 100 + (rx_message[ELEVATION_START_OFFSET + 1] - '0') * 10 + (rx_message[ELEVATION_START_OFFSET + 2] - '0');
				rf_depth = (rx_message[RFD_START_OFFSET + 0] - '0') * 10000 + (rx_message[RFD_START_OFFSET + 1] - '0') * 1000 + (rx_message[RFD_START_OFFSET + 2] - '0') * 100 + (rx_message[RFD_START_OFFSET + 3] - '0') * 10 + (rx_message[RFD_START_OFFSET + 4] - '0');
				if (rx_message[ZERO_START_OFFSET + 0] == '-')
					zero_offset = - (rx_message[ZERO_START_OFFSET + 1] - '0') * 1000 - (rx_message[ZERO_START_OFFSET + 2] - '0') * 100 - (rx_message[ZERO_START_OFFSET + 3] - '0') * 10 - (rx_message[ZERO_START_OFFSET + 4] - '0');
				else
					zero_offset = (rx_message[ZERO_START_OFFSET + 0] - '0') * 10000 + (rx_message[ZERO_START_OFFSET + 1] - '0') * 1000 + (rx_message[ZERO_START_OFFSET + 2] - '0') * 100 + (rx_message[ZERO_START_OFFSET + 3] - '0') * 10 + (rx_message[ZERO_START_OFFSET + 4] - '0');
				LC_value = (rx_message[LC_START_OFFSET + 0] - '0') * 100 + (rx_message[LC_START_OFFSET + 1] - '0') * 10 + (rx_message[LC_START_OFFSET + 2] - '0');
				brightness_value = (rx_message[BRIGHTNESS_START_OFFSET + 0] - '0') * 100 + (rx_message[BRIGHTNESS_START_OFFSET + 1] - '0') * 10 + (rx_message[BRIGHTNESS_START_OFFSET + 2] - '0');
				cut_value = (rx_message[CUT_VALUE_START_OFFSET + 0] - '0') * 100 + (rx_message[CUT_VALUE_START_OFFSET + 1] - '0') * 10 + (rx_message[CUT_VALUE_START_OFFSET + 2] - '0');
				cut_direction = (rx_message[CUT_DIR_START_OFFSET + 0] - '0') * 100 + (rx_message[CUT_DIR_START_OFFSET + 1] - '0') * 10 + (rx_message[CUT_DIR_START_OFFSET + 2] - '0');
				if (rx_message[SWHW_SC_START_OFFSET] == 'H')
					use_hw_sc = 1;
				else if (rx_message[SWHW_SC_START_OFFSET] == 'S')
					use_hw_sc = 0;
				else
					xil_printf("ERROR: Incorrect SW/HW SC specification while RECEIVEDOPTIONS (expected: 'HWSC' or 'SWSC')\n\r");
				sc_res_x = (rx_message[SC_RES_X_START_OFFSET + 0] - '0') * 100 + (rx_message[SC_RES_X_START_OFFSET + 1] - '0') * 10 + (rx_message[SC_RES_X_START_OFFSET + 2] - '0');
				sc_res_y = (rx_message[SC_RES_Y_START_OFFSET + 0] - '0') * 100 + (rx_message[SC_RES_Y_START_OFFSET + 1] - '0') * 10 + (rx_message[SC_RES_Y_START_OFFSET + 2] - '0');
				if (sc_res_x != old_sc_res_x || sc_res_y != old_sc_res_y)
				{
					// Remember the new resolution and reinitialize the HDMI output
					old_sc_res_x = sc_res_x;
					old_sc_res_y = sc_res_y;
					// This function is lightweight enough to be called in the packet handler.
					SetVideoResolution((unsigned char)RESOLUTION, sc_res_x, sc_res_y);
				}
				if (rx_message[CMD_START_OFFSET + 0] == 'F' && rx_message[CMD_START_OFFSET + 1] == 'I' && rx_message[CMD_START_OFFSET + 2] == 'F' && rx_message[CMD_START_OFFSET + 3] == 'O')
				{
					abs_next_rf_nappe = (current_run * radial_lines + (next_nappe - 1) * total_zone_count * compounding_count) % 65536; // lines swapped to have radial_lines
					// Flush the AXI Stream FIFO for a bit (bit [3])
					Xil_Out32(BEAMFORMER_COMMAND_REG, 14);
					int status_reg_value;
					// Just bide some time in a way that the compiler won't optimize away
					for (int cnt = 0; cnt < 100; cnt ++)
						status_reg_value = (int)Xil_In32(BEAMFORMER_STATUS_REG);
					// Flushing done, just configure it for the imaging mode
					Xil_Out32(BEAMFORMER_COMMAND_REG, 6);
					change_mode(MODE_FIFO);
				}
				else if (rx_message[CMD_START_OFFSET + 0] == 'S' && rx_message[CMD_START_OFFSET + 1] == 'T' && rx_message[CMD_START_OFFSET + 2] == 'R' && rx_message[CMD_START_OFFSET + 3] == 'M')
				{
					abs_next_rf_nappe = (current_run * radial_lines + (next_nappe - 1) * total_zone_count * compounding_count) % 65536; // lines swapped to have radial_lines
					Xil_Out32(BEAMFORMER_COMMAND_REG, 4);
					change_mode(MODE_STRM);
				}
				else if (rx_message[CMD_START_OFFSET + 0] == 'U' && rx_message[CMD_START_OFFSET + 1] == 'B' && rx_message[CMD_START_OFFSET + 2] == 'L' && rx_message[CMD_START_OFFSET + 3] == 'Z')
				{
					abs_next_rf_nappe = (current_run * radial_lines + next_nappe - 1) % 65536; // lines swapped to have radial_lines
					if (transmissions_to_perform == 0)
						transmissions_to_perform = total_zone_count * compounding_count;
					Xil_Out32(BEAMFORMER_COMMAND_REG, 0);
					change_mode(MODE_UBLZ);
				}
				else
					xil_printf("ERROR: Received message '%s' while RECEIVEDOPTIONS (expected: 'NN: xxx XXXX')\n\r", rx_message);

				Xil_Out32(BEAMFORMER_RF_DEPTH_REG, rf_depth);

				// Reprogram the zero offset only if necessary, because this operation
				// resets the offset, which we don't want in between RF transmissions
				// of a single frame.
				int current_zero_offset = (int)Xil_In32(BEAMFORMER_ZERO_OFF_REG);
				if (current_zero_offset != zero_offset)
					Xil_Out32(BEAMFORMER_ZERO_OFF_REG, zero_offset);

#ifdef DEEP_DEBUG
				int status_reg_value = (int)Xil_In32(BEAMFORMER_STATUS_REG);
				ready_nappe_count = (status_reg_value & 0xFFFF0000) >> 16;
				int status2_reg_value = (int)Xil_In32(BEAMFORMER_STATUS2_REG);
				xil_printf("Programmed samples = %d; reached offset %d and nappe %d\n\r", counter, status2_reg_value & 0x0000FFFF, ready_nappe_count);
#endif
				// This is a workaround to move on to the next run
				if (next_nappe > radial_lines)
				{
					if (op_mode == MODE_UBLZ)
					{
						current_run++;
					}
					else if (op_mode == MODE_STRM || op_mode == MODE_FIFO)
					{
						current_run = current_run + total_zone_count * compounding_count;
					}
				}

#ifdef DEEP_DEBUG
				xil_printf("current_run: %d\n\r", current_run);
				xil_printf("Next relative nappe with rf data: %d\n\r", next_nappe);
				xil_printf("Next absolute nappe with rf data: %d\n\r", (abs_next_rf_nappe + 1) % 65536);
#endif
			}
			else if (strstr(rx_message, "SC:") != NULL)
			{
				if (rx_message[CMD_START_OFFSET + 0] == 'R' && rx_message[CMD_START_OFFSET + 1] == 'E' && rx_message[CMD_START_OFFSET + 2] == 'S' && rx_message[CMD_START_OFFSET + 3] == 'C')
				{
					radial_lines = (rx_message[RADIAL_START_OFFSET + 0] - '0') * 1000 + (rx_message[RADIAL_START_OFFSET + 1] - '0') * 100 + (rx_message[RADIAL_START_OFFSET + 2] - '0') * 10 + (rx_message[RADIAL_START_OFFSET + 3] - '0');
					azimuth_lines = (rx_message[AZIMUTH_START_OFFSET + 0] - '0') * 100 + (rx_message[AZIMUTH_START_OFFSET + 1] - '0') * 10 + (rx_message[AZIMUTH_START_OFFSET + 2] - '0');
					elevation_lines = (rx_message[ELEVATION_START_OFFSET + 0] - '0') * 100 + (rx_message[ELEVATION_START_OFFSET + 1] - '0') * 10 + (rx_message[ELEVATION_START_OFFSET + 2] - '0');
					rf_depth = (rx_message[RFD_START_OFFSET + 0] - '0') * 10000 + (rx_message[RFD_START_OFFSET + 1] - '0') * 1000 + (rx_message[RFD_START_OFFSET + 2] - '0') * 100 + (rx_message[RFD_START_OFFSET + 3] - '0') * 10 + (rx_message[RFD_START_OFFSET + 4] - '0');
					if (rx_message[ZERO_START_OFFSET + 0] == '-')
						zero_offset = - (rx_message[ZERO_START_OFFSET + 1] - '0') * 1000 - (rx_message[ZERO_START_OFFSET + 2] - '0') * 100 - (rx_message[ZERO_START_OFFSET + 3] - '0') * 10 - (rx_message[ZERO_START_OFFSET + 4] - '0');
					else
						zero_offset = (rx_message[ZERO_START_OFFSET + 0] - '0') * 10000 + (rx_message[ZERO_START_OFFSET + 1] - '0') * 1000 + (rx_message[ZERO_START_OFFSET + 2] - '0') * 100 + (rx_message[ZERO_START_OFFSET + 3] - '0') * 10 + (rx_message[ZERO_START_OFFSET + 4] - '0');
					LC_value = (rx_message[LC_START_OFFSET + 0] - '0') * 100 + (rx_message[LC_START_OFFSET + 1] - '0') * 10 + (rx_message[LC_START_OFFSET + 2] - '0');
					brightness_value = (rx_message[BRIGHTNESS_START_OFFSET + 0] - '0') * 100 + (rx_message[BRIGHTNESS_START_OFFSET + 1] - '0') * 10 + (rx_message[BRIGHTNESS_START_OFFSET + 2] - '0');
					cut_value = (rx_message[CUT_VALUE_START_OFFSET + 0] - '0') * 100 + (rx_message[CUT_VALUE_START_OFFSET + 1] - '0') * 10 + (rx_message[CUT_VALUE_START_OFFSET + 2] - '0');
					cut_direction = (rx_message[CUT_DIR_START_OFFSET + 0] - '0') * 100 + (rx_message[CUT_DIR_START_OFFSET + 1] - '0') * 10 + (rx_message[CUT_DIR_START_OFFSET + 2] - '0');
					if (rx_message[SWHW_SC_START_OFFSET] == 'H')
						use_hw_sc = 1;
					else if (rx_message[SWHW_SC_START_OFFSET] == 'S')
						use_hw_sc = 0;
					else
						xil_printf("ERROR: Incorrect SW/HW SC specification while RECEIVEDOPTIONS (expected: 'HWSC' or 'SWSC')\n\r");
					sc_res_x = (rx_message[SC_RES_X_START_OFFSET + 0] - '0') * 100 + (rx_message[SC_RES_X_START_OFFSET + 1] - '0') * 10 + (rx_message[SC_RES_X_START_OFFSET + 2] - '0');
					sc_res_y = (rx_message[SC_RES_Y_START_OFFSET + 0] - '0') * 100 + (rx_message[SC_RES_Y_START_OFFSET + 1] - '0') * 10 + (rx_message[SC_RES_Y_START_OFFSET + 2] - '0');
					if (sc_res_x != old_sc_res_x || sc_res_y != old_sc_res_y)
					{
						// Remember the new resolution and reinitialize the HDMI output
						old_sc_res_x = sc_res_x;
						old_sc_res_y = sc_res_y;
						// This function is lightweight enough to be called in the packet handler.
						SetVideoResolution((unsigned char)RESOLUTION, sc_res_x, sc_res_y);
					}
					change_mode(MODE_RESC);
#ifdef DEEP_DEBUG
					xil_printf("Re-scan converting with brightness %u, contrast %d, cut %d, direction %d\n\r", brightness_value, LC_value, cut_value, cut_direction);
#endif
				}
			}
			else
				xil_printf("ERROR: Received message '%s' while RECEIVEDOPTIONS (expected: 'NN: xxx' or 'SC: xxx')\n\r", rx_message);
#ifdef DEEP_DEBUG
			int status_reg_value = (int)Xil_In32(BEAMFORMER_STATUS_REG);
		   	xil_printf("Beamformer status in RECEIVEDOPTIONS: 0x%x\n\r", status_reg_value);

			xil_printf("Received the following string:\n\r");
			xil_printf(rx_message);
			xil_printf("\n\rInterpreted as:\n\r");
			xil_printf("(abs_)next_nappe = %d\n\r", abs_next_rf_nappe);
			xil_printf("radial_lines = %d\n\r", radial_lines);
			xil_printf("azimuth_lines = %d\n\r", azimuth_lines);
			xil_printf("elevation_lines = %d\n\r", elevation_lines);
			xil_printf("rf_depth = %d\n\r", rf_depth);
			xil_printf("zero_offset = %d\n\r", zero_offset);
			xil_printf("LC_value = %d\n\r", LC_value);
			xil_printf("brightness_value = %u\n\r", brightness_value);
			xil_printf("cut_value = %d\n\r", cut_value);
			xil_printf("cut_direction = %d\n\r", cut_direction);
			xil_printf("use_hw_sc = %d\n\r", use_hw_sc);
			xil_printf("sc_res_x = %d\n\r", sc_res_x);
			xil_printf("sc_res_y = %d\n\r", sc_res_y);
			xil_printf("command[0] = %c\n\r", rx_message[CMD_START_OFFSET + 0]);
#endif

			if (op_mode == MODE_STRM || op_mode == MODE_UBLZ)
			{
				change_state(RECEIVINGRF);
				send_ok(tpcb);
			}
			else if (op_mode == MODE_FIFO)
			{
				change_state(WAITINGBF);
				// Do not send an "ok" for this message!! It is not expected in listen only mode.
			}
			else if (op_mode == MODE_RESC)
			{
				// In case of compound imaging, when we do RESC there will be no need to apply compounding
				// since the image is supposed to be already compounded from the first full run.
				run_scanconversion();
				change_state(AWAITING);
				send_ok(tpcb);
			}
		break;
		case RECEIVINGRF:
			if (op_mode == MODE_UBLZ)
			{
				// First check for "startbf#" at the end of the packet
				memcpy(rx_message, p->payload + p->len - 8, 8);
				rx_message[8] = '\0';
				if (strstr(rx_message, "startbf#") != NULL)
				{
					end_rf = 1;
					p->len = p->len - 8;
#ifdef DEEP_DEBUG
					xil_printf("Received startbf# command!\n\r");
#endif
				}
			}
			else if (op_mode == MODE_STRM)
			{
				// First check for "sendnappes#" at the end of the packet
				memcpy(rx_message, p->payload + p->len - 11, 11);
				rx_message[11] = '\0';
				if (strstr(rx_message, "sendnappes#") != NULL)
				{
					end_rf = 1;
					p->len = p->len - 11;
#ifdef DEEP_DEBUG
					xil_printf("Received sendnappes# command!\n\r");
#endif
				}
			}
			// Then check for anything else or anything before
			if (p->len > 0)
			{
				// Input RF sample from the Ethernet port
				volatile u32 input_rf_sample = 0;

				// First check if there are 1-3 leftover bytes from the previous packet, and if so,
				// add them in together with the first bytes of this packet
				for (int i = 0; i < 4; i ++)
				{
					// The first few bytes of the word may be leftovers
					if (i < leftover_bytes)
						input_rf_sample = input_rf_sample + (leftovers[i] << 8 * i);
					// The rest come from the packet
					else
						input_rf_sample = input_rf_sample + (((u_char *)p->payload)[i - leftover_bytes] << 8 * i);
				}
				Xil_Out32(BEAMFORMER_BRAM_REG, input_rf_sample);
#ifdef DEEP_DEBUG
				if ((counter % 64) < 30)
					// TODO does not handle negative samples (also below)
					xil_printf("Programmed sample %d %0d.%0d\n\r", counter, input_rf_sample / 4, (input_rf_sample & 0x3) * 25);
				if (counter % 2048 == 0)
					xil_printf("Programmed sample %d\n\r", counter);
				int status2_reg_value = (int)Xil_In32(BEAMFORMER_STATUS2_REG);
				xil_printf("Beamformer status2: 0x%08x\n\r", status2_reg_value);
#endif
				counter ++;

				// Now that this is done, pretend that the packet we got has fewer bytes
				p->payload = p->payload + (4 - leftover_bytes);
				p->len = p->len - (4 - leftover_bytes);
				// Now work on the samples arrived with this packet
				for (int i = 0; i < p->len / 4; i ++)
				{
					// TODO there should be a faster way to do this manipulation
					input_rf_sample = ((u_char *)p->payload)[i * 4] | ((u_char *)p->payload)[i * 4 + 1] << 8 | ((u_char *)p->payload)[i * 4 + 2] << 16 | ((u_char *)p->payload)[i * 4 + 3] << 24;
					Xil_Out32(BEAMFORMER_BRAM_REG, input_rf_sample);
#ifdef DEEP_DEBUG
					if ((counter % 64) < 30)
						xil_printf("Programmed sample %d %0d.%0d\n\r", counter, input_rf_sample / 4, (input_rf_sample & 0x3) * 25);
					// In some conditions, this useless printf fixes the transition from a streaming image to a UBLZ image. Seems fixed now (?)
					if (counter % 32768 == 0)
					{
						int status_reg_value = (int)Xil_In32(BEAMFORMER_STATUS_REG);
						// The ready counter is in the 16 MSBs
						ready_nappe_count = (status_reg_value & 0xFFFF0000) >> 16;
						int status2_reg_value = (int)Xil_In32(BEAMFORMER_STATUS2_REG);
						xil_printf("Programmed sample %d; reached offset %d and nappe %d\n\r", counter, status2_reg_value & 0x0000FFFF, ready_nappe_count);

					}
#endif
					counter ++;
				}
				// Finally, remember any leftovers from this packet to merge into the next one
				leftover_bytes = 0;
				for (int i = (p->len / 4) * 4; i < p->len; i ++)
				{
					leftovers[leftover_bytes] = ((u_char *)p->payload)[i];
					leftover_bytes ++;
				}
			}
			// At the end of the reception of RF data
			if (end_rf == 1)
			{
#ifdef DEEP_DEBUG
				int status_reg_value = (int)Xil_In32(BEAMFORMER_STATUS_REG);
				int status2_reg_value = (int)Xil_In32(BEAMFORMER_STATUS2_REG);
				int status3_reg_value = (int)Xil_In32(BEAMFORMER_STATUS3_REG);
				xil_printf("In total, written %d samples, status2 = 0x%08x status3 = 0x%08x\n\r", counter, status2_reg_value, status3_reg_value);
				ready_nappe_count = (status_reg_value & 0xFFFF0000) >> 16;
				xil_printf("Programmed samples = %d; reached offset %d and nappe %d. Leftover bytes = %d\n\r", counter, status2_reg_value & 0x0000FFFF, ready_nappe_count, leftover_bytes);
#endif
				counter = 0;
				if (op_mode == MODE_UBLZ)
				{
					send_ok(tpcb);
					change_state(RUNNINGBF);
				}
				else if (op_mode == MODE_STRM)
				{
					change_state(WAITINGBF);
				}
			}
		break;
		case RUNNINGBF:
			memcpy(rx_message, p->payload + p->len - 11, 11);
			rx_message[11] = '\0';
			if (strstr(rx_message, "sendnappes#") != NULL)
			{
				change_state(SENDINGNAPPES);
			}
			// TODO strange msg, but it won't work unless the string is as long as rx_message
			else if (strstr(rx_message, "####sendrf#") != NULL)
			{
				change_state(RECEIVEDOPTIONS);
				send_ok(tpcb);
			}
			break;
		case WAITINGBF:
			// Do nothing. The process_data() function detects we are in this state and keeps checking
			// for nappe readiness, then takes the FSM into SENDINGNAPPES. That is done
			// out-of-thread to avoid lockups (lengthy while() polling makes Ethernet unresponsive)
			break;
		case SENDINGNAPPES:
			// Do nothing. The process_data() function detects we are in this state and sends
			// data out, then takes the FSM out of this state. That is done
			// out-of-thread to avoid memory allocation problems
			break;
		default:
			break;
	}

	/* free the received pbuf */
	pbuf_free(p);

	return ERR_OK;
}

// This function reads voxels from the beamformer and sends them out over the Ethernet.
int send_nappes(struct tcp_pcb *tpcb, int prev_sent_voxels)
{
#ifdef DEEP_DEBUG
	xil_printf("Sending out as requested nappe %d from address %x (previous count is %d)\n\r", rel_current_nappe, nappe_pointer, prev_sent_voxels);
#endif
	// Read out all the nappe data. Place a limit on the amount we read out so we
	// don't overflow the TCP buffers
	int voxels_to_send = TCP_MSS / 4;
	if (prev_sent_voxels + voxels_to_send > elevation_lines * azimuth_lines)
		voxels_to_send = elevation_lines * azimuth_lines - prev_sent_voxels;
	int total_sent_voxels = prev_sent_voxels + voxels_to_send;

#ifdef DEEP_DEBUG
	xil_printf("Sending now %d voxels\n\r", voxels_to_send);
#endif
#ifdef DEEP_DEBUG
	if (prev_sent_voxels == 0)
	{
		int *int_ptr = (int *)nappe_pointer;
		for (int deb = 0; deb < 30; deb ++)
			xil_printf("Returning from %x sample %d: %0d.%0d\n\r", int_ptr, deb, int_ptr[deb] / 4, (int_ptr[deb] & 0x3) * 25);
	}
#endif

	// nappe_pointer points to a location in external memory where the beamformer
	// stores the finished nappes. After every transfer, increase the pointer.
	err_t err = tcp_write(tpcb, nappe_pointer, voxels_to_send * 4, 1);
	if (err != 0)
		xil_printf("ERROR: transmission error %d\n\r", err);
	tcp_output(tpcb);
	nappe_pointer = nappe_pointer + voxels_to_send * 4;

	if (total_sent_voxels == elevation_lines * azimuth_lines)
	{
#ifdef DEEP_DEBUG
		xil_printf("Sending nappe %d done!\n\r", rel_current_nappe + 1);
		int status_reg_value = (int)Xil_In32(BEAMFORMER_STATUS_REG);
		// The ready counter is in the 16 MSBs
		int ready_nappe_count = (status_reg_value & 0xFFFF0000) >> 16;
		// bit [1]
		int busy_bit = (status_reg_value & 0x00000002) >> 1;
		// bit [0]
		int ready_bit = status_reg_value & 0x00000001;
		if (busy_bit == 1 && ready_bit == 1)
			xil_printf("ERROR: Beamformer claims to be both busy and ready!\n\r");
		if (busy_bit == 0 && ready_bit == 0)
			xil_printf("ERROR: Beamformer claims to be neither busy nor ready!\n\r");
#endif

		// Reset this counter for the next nappe.
		total_sent_voxels = 0;
		send_ok(tpcb);
		if (rel_current_nappe == radial_lines - 1)
		{
			rel_current_nappe = 0;
			// Reset the memory pointer to the beginning of the volume
			nappe_pointer = (void *)NAPPE_MEMORY;
			change_state(AWAITING);
#ifdef DEEP_DEBUG
			int status_reg_value = (int)Xil_In32(BEAMFORMER_STATUS_REG);
			int status2_reg_value = (int)Xil_In32(BEAMFORMER_STATUS2_REG);
			int status3_reg_value = (int)Xil_In32(BEAMFORMER_STATUS3_REG);
			int status4_reg_value = (int)Xil_In32(BEAMFORMER_STATUS4_REG);
			int status5_reg_value = (int)Xil_In32(BEAMFORMER_STATUS5_REG);
			int status6_reg_value = (int)Xil_In32(BEAMFORMER_STATUS6_REG);
			int status7_reg_value = (int)Xil_In32(BEAMFORMER_STATUS7_REG);
			xil_printf("Beamformer status just after last nappe: 0x%08x, 0x%08x, 0x%08x, 0x%08x, 0x%08x, 0x%08x, 0x%08x\n\r", status_reg_value, status2_reg_value, status3_reg_value, status4_reg_value, status5_reg_value, status6_reg_value, status7_reg_value);
#endif
		}
		else
			rel_current_nappe ++;
	}

	return total_sent_voxels;
}

// This function reads pixels from the scan converter and sends them out over the Ethernet.
int send_pixels(struct tcp_pcb *tpcb, int prev_sent_pixels)
{
#ifdef DEEP_DEBUG
	xil_printf("Sending out as requested pixel from address %x (previous count is %d)\n\r", image_pointer, prev_sent_pixels);
#endif
	// Read out all the image data. Place a limit on the amount we read out so we
	// don't overflow the TCP buffers
	int pixels_to_send = TCP_MSS / 4;
	if (prev_sent_pixels + pixels_to_send > sc_res_x * sc_res_y)
		pixels_to_send = sc_res_x * sc_res_y - prev_sent_pixels;
	int total_sent_pixels = prev_sent_pixels + pixels_to_send;

#ifdef DEEP_DEBUG
	xil_printf("Sending now %d pixels\n\r", pixels_to_send);
#endif
#ifdef DEEP_DEBUG
	if (prev_sent_pixels == 0)
	{
		int *int_ptr = (int *)image_pointer;
		for (int deb = 0; deb < 30; deb ++)
			xil_printf("Returning from %x pixel %d: grey level %d\n\r", int_ptr, deb, int_ptr[deb] & 0xFF);
	}
#endif

	// image_pointer points to a location in external memory where the scan converter
	// stores the finished image. After every transfer, increase the pointer.
	err_t err = tcp_write(tpcb, image_pointer, pixels_to_send * 4, 1);
	if (err != 0)
		xil_printf("ERROR: transmission error %d\n\r", err);
	tcp_output(tpcb);
	image_pointer = image_pointer + pixels_to_send * 4;

	if (total_sent_pixels == sc_res_x * sc_res_y)
	{
#ifdef DEEP_DEBUG
		xil_printf("Sending pixels done!\n\r");
#endif

		// Reset this counter for the next reconstruction.
		total_sent_pixels = 0;
		send_ok(tpcb);
		// Reset the memory pointer to the beginning of the image
		image_pointer = (void *)SC_IMAGE_MEMORY;
		change_state(AWAITING);
	}

	return total_sent_pixels;
}

err_t accept_callback(void *arg, struct tcp_pcb *newpcb, err_t err)
{
	static int connection = 1;

	/* set the receive callback for this connection */
	tcp_recv(newpcb, recv_callback);

	/* just use an integer number indicating the connection id as the
	   callback argument */
	tcp_arg(newpcb, (void*)(UINTPTR)connection);

	/* increment for subsequent accepted connections */
	connection++;

	return ERR_OK;
}

int start_application()
{
	err_t err;
	unsigned port = 7;

	/* create new TCP PCB structure */
	struct tcp_pcb *pcb = tcp_new();
	if (!pcb) {
		xil_printf("ERROR: Out of memory while creating PCB!\n\r");
		return -1;
	}

	/* bind to specified @port */
	err = tcp_bind(pcb, IP_ADDR_ANY, port);
	if (err != ERR_OK) {
		xil_printf("ERROR: Unable to bind to port %d: err = %d\n\r", port, err);
		return -2;
	}

	/* we do not need any arguments to callback functions */
	tcp_arg(pcb, NULL);

	/* listen for connections */
	pcb = tcp_listen(pcb);
	if (!pcb) {
		xil_printf("ERROR: Out of memory while tcp_listen\n\r");
		return -3;
	}

	/* specify callback to use for incoming connections */
	tcp_accept(pcb, accept_callback);

	xil_printf("Application started @ port %d\n\r", port);

	change_state(AWAITING);
#ifdef DEEP_DEBUG
	int status_reg_value = (int)Xil_In32(BEAMFORMER_STATUS_REG);
	int status2_reg_value = (int)Xil_In32(BEAMFORMER_STATUS2_REG);
	int status3_reg_value = (int)Xil_In32(BEAMFORMER_STATUS3_REG);
	int status4_reg_value = (int)Xil_In32(BEAMFORMER_STATUS4_REG);
	int status5_reg_value = (int)Xil_In32(BEAMFORMER_STATUS5_REG);
	int status6_reg_value = (int)Xil_In32(BEAMFORMER_STATUS6_REG);
	int status7_reg_value = (int)Xil_In32(BEAMFORMER_STATUS7_REG);
	xil_printf("Beamformer status just after boot: 0x%08x, 0x%08x, 0x%08x, 0x%08x, 0x%08x, 0x%08x, 0x%08x\n\r", status_reg_value, status2_reg_value, status3_reg_value, status4_reg_value, status5_reg_value, status6_reg_value, status7_reg_value);
#endif

	// White-out the target memory areas, to help with debugging possible problems.
	nappe_pointer = (void *)NAPPE_MEMORY;
	for (int count = 0; count < elevation_lines * azimuth_lines * radial_lines * 4; count ++)
	{
		*(char *)nappe_pointer = 0xff;
		nappe_pointer ++;
	}
	nappe_pointer = (void *)NAPPE_MEMORY;

	image_pointer = (void *)SC_IMAGE_MEMORY;
	for (int count = 0; count < sc_res_x * sc_res_y * 4; count ++)
	{
		*(char *)image_pointer = 0xff;
		image_pointer ++;
	}
	image_pointer = (void *)SC_IMAGE_MEMORY;

	return 0;
}
