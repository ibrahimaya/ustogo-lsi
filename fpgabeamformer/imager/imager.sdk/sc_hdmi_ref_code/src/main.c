/***************************************************************************//**
 *   @file   main.c
********************************************************************************
 * Copyright 2013(c) Analog Devices, Inc.
 *
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *  - Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *  - Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in
 *    the documentation and/or other materials provided with the
 *    distribution.
 *  - Neither the name of Analog Devices, Inc. nor the names of its
 *    contributors may be used to endorse or promote products derived
 *    from this software without specific prior written permission.
 *  - The use of this software may or may not infringe the patent rights
 *    of one or more patent holders.  This license does not release you
 *    from the requirement that you obtain separate licenses from these
 *    patent holders to use this software.
 *  - Use of the software either in source or binary form, must be run
 *    on or directly connected to an Analog Devices Inc. component.
 *
 * THIS SOFTWARE IS PROVIDED BY ANALOG DEVICES "AS IS" AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, NON-INFRINGEMENT,
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL ANALOG DEVICES BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, INTELLECTUAL PROPERTY RIGHTS, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
********************************************************************************
 *   SVN Revision: $WCREV$
*******************************************************************************/

/******************************************************************************/
/***************************** Include Files **********************************/
/******************************************************************************/
#include <stdio.h>
#include "xil_cache.h"
#include "xbasic_types.h"
#include "xil_io.h"
#if defined (__arm__) || defined (__aarch64__)
#include "xil_printf.h"
#endif
#include "cf_hdmi.h"
#include "../library/microblaze/inc/atv_platform.h"
#include "transmitter.h"
#include "xil_exception.h"
#include "xuartlite_l.h"
#include "pres_old_sphere_complete_2D.h"

#define CUT_FRONT 1
#define CUT_SIDE 2

#define NAPPES_READ 200
#define CUT_VAL 0        //32 AYA: Should be removed (No need in 2D imaging)
uint8_t current_resolution = 2;
uint32_t buttons;
int32_t cut_val = 0;
uint32_t cut_type = CUT_FRONT;  //AYA: Should be removed (No need in 2D imaging)
extern void delay_ms(u32 ms_count);
extern char inbyte(void);

/******************************************************************************/
/************************** Macros Definitions ********************************/
/******************************************************************************/
#define HDMI_CALL_INTERVAL_MS	10			/* Interval between two         */
											/* iterations of the main loop  */
#define DBG_MSG                 xil_printf

/******************************************************************************/
/************************ Variables Definitions *******************************/
/******************************************************************************/
static UCHAR    MajorRev;      /* Major Release Number */
static UCHAR    MinorRev;      /* Usually used for code-drops */
static UCHAR    RcRev;         /* Release Candidate Number */
static BOOL     DriverEnable;
static BOOL     LastEnable;



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

/***************************************************************************//**
 * @brief Enables the driver.
 *
 * @return Returns ATVERR_OK.
*******************************************************************************/
void APP_EnableDriver (BOOL Enable)
{
    DriverEnable = Enable;
}

/***************************************************************************//**
 * @brief Returns the driver enable status.
 *
 * @return Returns the driver enable status.
*******************************************************************************/
static BOOL APP_DriverEnabled (void)
{
    if ((DriverEnable && HAL_GetMBSwitchState()) != LastEnable)
    {
        LastEnable = DriverEnable && HAL_GetMBSwitchState();
        DBG_MSG ("APP: Driver %s\n\r", LastEnable? "Enabled": "Disabled");
    }
    return (LastEnable);
}

/***************************************************************************//**
 * @brief Displays the application version and the chip revision.
 *
 * @return None.
*******************************************************************************/
static void APP_PrintRevisions (void)
{
	UINT16 TxRev;

	ADIAPI_TxGetChipRevision(&TxRev);

	//DBG_MSG("\n\r********************************************************************\r\n");
	//DBG_MSG("  ADI HDMI Trasmitter Application Ver R%d.%d.%d\n\r", MajorRev, MinorRev, RcRev);
	//DBG_MSG("  HDMI-TX:  ADV7511 Rev 0x%x\r\n", TxRev);
	//DBG_MSG("  Created:  %s At %s\n\r", __DATE__, __TIME__);
	//DBG_MSG("********************************************************************\r\n\n\r");
}

/***************************************************************************//**
 * @brief Changes the video resolution.
 *
 * @return None.
*******************************************************************************/
static void APP_ChangeResolution (void)
{
	char *resolutions[7] = {"640x480", "800x600", "1024x768", "1280x720", "1360x768", "1600x900", "1920x1080"};
	char receivedChar    = 0;

	if(!XUartLite_IsReceiveEmpty(UART_BASEADDR))
	{
		receivedChar = inbyte();
		if((receivedChar >= 0x30) && (receivedChar <= 0x36))
		{
			current_resolution = receivedChar - 0x30;
			SetVideoResolution(receivedChar - 0x30, IMG_WIDTH, IMG_HEIGHT);
			DBG_MSG("Resolution was changed to %s \r\n", resolutions[receivedChar - 0x30]);
		}
		else
		{
			if((receivedChar != 0x0A) && (receivedChar != 0x0D))
			{
				current_resolution = 0;
				SetVideoResolution(RESOLUTION_640x480, IMG_WIDTH, IMG_HEIGHT);
				DBG_MSG("Resolution was changed to %s \r\n", resolutions[0]);
			}
		}
	}
}

/* send the nappes data stored in @param address_start to the scan converter at @param scanconv_addr
 * @param width and @param height specify the width and height of the nappes data (default: 64 and 600)
 * @param cut_orient specify the direction of the cut {side, front} and the @param cut_val specify
 * the depth of the cut (a cut_val of 32 means the middle of the scan)
 */
int load_nappe_data_scanconv(uint32_t *address_start, uint32_t width, uint32_t height,
		uint32_t cut_orient, uint32_t cut_val, uint32_t scanconv_addr){

	uint32_t i = 0;
	uint32_t j = 0;
	uint32_t ptr = 0;
	uint32_t val;

	//if(cut_orient == CUT_FRONT){
		for (j=0; j<height; j++){
			////// ptr = cut_val*width+width*width*j-j;
			for (i=0; i<width; i++){
				val = address_start[ptr];
				Xil_Out32(scanconv_addr+0x10, val);
				ptr++;
			}
		}

 /*  }
	else{
		ptr = cut_val;
		for (j=0; j<height; j++){
			ptr = cut_val+width*width*j-j;
			for (i=0; i<width; i++){
				val = address_start[ptr];

				Xil_Out32(scanconv_addr+0x10, val);
				ptr+=(width);
			}
		}
	} */

	return 0;
}

/*
 * output the nappes of the scan converter to the @param output_addr emplacement in memory.
 * @param img_width and @param img_height are the size of the output image as it was parametrized
 * in the scan conversion module
 */
void output_nappes(uint32_t scanconv_addr, uint32_t output_addr, uint32_t img_width, uint32_t img_height){
	uint32_t ptr_x = 0;
	uint32_t ptr_y = 0;
	uint32_t status_reg = 0;
	uint32_t value = 0;
	uint32_t t = 0xFFFF;
	//xil_printf("A7scan conversion load!!!!\n\r");
	while( (t & 0x08) != 0){
		t = Xil_In32(scanconv_addr+0x00);
	}
	//xil_printf("K9scan conversion load!!!!%lx \n\r", Xil_In32(output_addr+(200*img_width+200)*4));

	//xil_printf("B7scan conversion load!!!!\n\r");
	for (ptr_y = 0; ptr_y<img_height; ptr_y++){
		for (ptr_x = 0; ptr_x<img_width; ptr_x++){
			status_reg = 0;

			Xil_Out32(scanconv_addr+0x3C, 0x1);
			//xil_printf("C7scan conversion load!!!!\n\r");
			while( (status_reg&0x4) == 0){
				status_reg = Xil_In32(scanconv_addr+0x00);
				//xil_printf("D7scan conversion load!!!!%lx \n\r", status_reg);

			}
			//xil_printf("DD7scan conversion load!!!!\n\r");

			value = Xil_In32(scanconv_addr+0x14);

			value = (value<<16)+(value<<8)+value;

			Xil_Out32(output_addr+(ptr_y*img_width+ptr_x)*4, value);

		}
	}
	//xil_printf("E7scan conversion load!!!!\n\r");
	//xil_printf("D9scan conversion load!!!!%lx \n\r", Xil_In32(output_addr+(200*img_width+200)*4));

	Xil_Out32(scanconv_addr+0x3C, 0x1);
}

/*
 * Debug function: instead of output the scan converted image in memory, output it
 * to the standard out
 */
void term_print_nappes(uint32_t scanconv_addr, uint32_t img_width, uint32_t img_height){
	uint32_t ptr_x = 0;
	uint32_t ptr_y = 0;
	uint32_t status_reg = 0;
	uint32_t value = 0;

	uint32_t t = 0xFFFF;

	while( (t & 0x08) != 0){
		t = Xil_In32(scanconv_addr+0x00);
	}

	for (ptr_y = 0; ptr_y<img_height; ptr_y++){
		for (ptr_x = 0; ptr_x<img_width; ptr_x++){
			status_reg = 0;
			Xil_Out32(scanconv_addr+0x3C, 0x1);

			while( (status_reg&0x4) == 0){
				status_reg = Xil_In32(scanconv_addr+0x00);
			}

			value = Xil_In32(scanconv_addr+0x14);
			xil_printf("%d,", value);
			if (ptr_x == img_width-1){
				xil_printf("\n\r");
			}

		}
	}
	Xil_Out32(scanconv_addr+0x3C, 0x1);
}

void start_scanconv(uint32_t scanconv_addr){
	Xil_Out32(scanconv_addr+0x04, 0x04); //start
	//xil_printf("D7scan conversion load!!!!%lx \n\r", Xil_In32(scanconv_addr + 0x0));

}

/*
 * configure the scan converter
 * @param nb_nappes: the number of nappes that will be feed to the converted (usually 600, could be less)
 * @param nappes_width width of the nappes (usually 64) currently cannot support any other values
 * @param img_out_width, dimention of the output image, in pixels, that will be displayed on the screen.
 */
void scanconv_configure(uint32_t scanconv_addr, uint32_t nb_nappes, uint32_t nappes_width, uint32_t img_out_width, uint32_t img_out_height){
	//write nb nappes in 0x28
	Xil_Out32(scanconv_addr+0x28, nb_nappes);
	//write nappe width in 0x24
	Xil_Out32(scanconv_addr+0x24, 64);
	//write img width in 0x18
	Xil_Out32(scanconv_addr+0x18, img_out_width);
	//write img height in 0x1c
	Xil_Out32(scanconv_addr+0x1C, img_out_height);
	//write b101 in 0x0c (val by val)
	Xil_Out32(scanconv_addr+0x0C, 0x5);

}


/***************************************************************************//**
 * @brief Main function.
 *
 * @return Returns 0.
*******************************************************************************/
int main()
{
	UINT32 StartCount;

	MajorRev     = 1;
	MinorRev     = 1;
	RcRev        = 1;
	DriverEnable = TRUE;
	LastEnable   = FALSE;

	Xil_ICacheEnable();
	Xil_DCacheEnable();

#ifdef XPAR_AXI_IIC_0_BASEADDR
	HAL_PlatformInit(XPAR_AXI_IIC_0_BASEADDR,	/* Perform any required platform init */
				 XPAR_AXI_TIMER_BASEADDR,		/* including hardware reset to HDMI devices */
				 XPAR_AXI_TIMER_INTERRUPT_MASK,
				 XPAR_AXI_INTC_BASEADDR);
#else
	HAL_PlatformInit(XPAR_AXI_IIC_MAIN_BASEADDR,	/* Perform any required platform init */
				 XPAR_AXI_TIMER_BASEADDR,		/* including hardware reset to HDMI devices */
				 XPAR_AXI_TIMER_INTERRUPT_MASK,
				 XPAR_INTC_0_BASEADDR);
#endif

	Xil_ExceptionEnable();

	//configure the scan converter
	scanconv_configure(XPAR_SCANCONVERTERIP_0_BASEADDR, NAPPES_READ, 64, IMG_WIDTH, IMG_HEIGHT);

	xil_printf("scan conversion load!!!!\n\r");
	//give the nappes voxels to the scan converter module from the NAPPE_DATA array
	load_nappe_data_scanconv(NAPPES_DATA, 64, NAPPES_READ,
					CUT_FRONT, CUT_VAL, XPAR_SCANCONVERTERIP_0_BASEADDR);

	xil_printf("0scan conversion start!!!\n\r");

	start_scanconv(XPAR_SCANCONVERTERIP_0_BASEADDR);


	//save the image to the DDR memory at a specific emplacement where the HDMI function
		// "DDRVideoWr" will use to draw on screen
		///term_print_nappes(XPAR_SCANCONVERTERIP_0_BASEADDR, IMG_WIDTH, IMG_HEIGHT);
		output_nappes(XPAR_SCANCONVERTERIP_0_BASEADDR, DDR_BASEADDR+0x8000000, IMG_WIDTH, IMG_HEIGHT);

	//SetVideoResolution(RESOLUTION_1600x900, IMG_WIDTH, IMG_HEIGHT);
	//SetVideoResolution(RESOLUTION_1280x720, IMG_WIDTH, IMG_HEIGHT);

	SetVideoResolution(RESOLUTION_1920x1080, IMG_WIDTH, IMG_HEIGHT);
	//SetVideoResolution(RESOLUTION_1024x768, IMG_WIDTH, IMG_HEIGHT);
	//SetVideoResolution(RESOLUTION_800x600, IMG_WIDTH, IMG_HEIGHT);
	//SetVideoResolution(RESOLUTION_640x480, IMG_WIDTH, IMG_HEIGHT);
	current_resolution = 6; //6; //2; //3;

	InitHdmiAudioPcore();

	APP_PrintRevisions();       /* Display S/W and H/W revisions */

	ADIAPI_TransmitterInit();   /* Initialize ADI repeater software and h/w */

	ADIAPI_TransmitterSetPowerMode(REP_POWER_UP);

	StartCount = HAL_GetCurrentMsCount();

	while(1)
	{

		/*	if( (buttons&0x8000) != 0){
					xil_printf("lower\n\r");
					if(cut_val > -30)
						cut_val -= 10;

				}
				if( (buttons&0x2000) != 0){
					xil_printf("higher\n\r");
					if (cut_val < 30)
						cut_val += 10;
				}
				if( (buttons&0x10000) != 0){
					xil_printf("change cut type\n\r");
					if(cut_type == CUT_FRONT)
						cut_type = CUT_SIDE;
					else
						cut_type = CUT_FRONT;
				} */

				//configure the scan converter
				scanconv_configure(XPAR_SCANCONVERTERIP_0_BASEADDR, NAPPES_READ, 64, IMG_WIDTH, IMG_HEIGHT);

				//give the nappes voxels to the scan converter module from the NAPPE_DATA array
				load_nappe_data_scanconv(NAPPES_DATA, 64, NAPPES_READ,
						cut_type, CUT_VAL+cut_val, XPAR_SCANCONVERTERIP_0_BASEADDR);

				xil_printf("scan conversion start!!!!\n\r");
				start_scanconv(XPAR_SCANCONVERTERIP_0_BASEADDR);

				//save the image to the DDR memory at a specific emplacement where the HDMI function
				// "DDRVideoWr" will use to draw on screen
				output_nappes(XPAR_SCANCONVERTERIP_0_BASEADDR, DDR_BASEADDR+0x8000000, IMG_WIDTH, IMG_HEIGHT);
				//term_print_nappes(XPAR_SCANCONVERTERIP_0_BASEADDR, IMG_WIDTH, IMG_HEIGHT);
				//TODO: CHange here for resolution
			DDRVideoWr(detailedTiming[current_resolution][1],	detailedTiming[current_resolution][5], IMG_WIDTH, IMG_HEIGHT);
			//			DDRVideoWr(detailedTiming[current_resolution][1], detailedTiming[current_resolution][5]);// IMG_WIDTH, IMG_HEIGHT);


		if (ATV_GetElapsedMs (StartCount, NULL) >= HDMI_CALL_INTERVAL_MS)
		{
			StartCount = HAL_GetCurrentMsCount();
			if (APP_DriverEnabled())
			{
				ADIAPI_TransmitterMain();
			}
		}
		APP_ChangeResolution();
	}

	Xil_DCacheDisable();
	Xil_ICacheDisable();

	return(0);
}
