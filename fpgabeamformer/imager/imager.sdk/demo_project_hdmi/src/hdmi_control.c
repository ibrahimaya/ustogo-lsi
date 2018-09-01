//
//  hdmi_control.c
//  
//
//  Created by Aya Ibrahim on 21/03/17.
//
//

#include "hdmi_control.h"
//#include "xbasic_types.h"
//#include "../library/microblaze/inc/atv_platform.h"
#include "transmitter.h"
#include "xuartlite_l.h"
#include "cf_hdmi.h"
#include "xil_io.h"
#include <string.h>
#include "params.h"

uint8_t current_resolution;
UINT32 StartCount;
#define HDMI_CALL_INTERVAL_MS	10			/* Interval between two         */

extern char inbyte(void);

static UCHAR    MajorRev = 1;      /* Major Release Number */
static UCHAR    MinorRev = 1;      /* Usually used for code-drops */
static UCHAR    RcRev = 1;         /* Release Candidate Number */
static BOOL     DriverEnable = TRUE;
static BOOL     LastEnable = FALSE;

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
BOOL APP_DriverEnabled (void)
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
void APP_PrintRevisions (void)
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
void APP_ChangeResolution (unsigned int img_width, unsigned int img_height)
{
    char *resolutions[7] = {"640x480", "800x600", "1024x768", "1280x720", "1360x768", "1600x900", "1920x1080"};
    char receivedChar    = 0;
    
    if(!XUartLite_IsReceiveEmpty(UART_BASEADDR))
    {
        receivedChar = inbyte();
        if((receivedChar >= 0x30) && (receivedChar <= 0x36))
        {
            current_resolution = receivedChar - 0x30;
            SetVideoResolution(receivedChar - 0x30, img_width, img_height);
            DBG_MSG("Resolution was changed to %s \r\n", resolutions[receivedChar - 0x30]);
        }
        else
        {
            if((receivedChar != 0x0A) && (receivedChar != 0x0D))
            {
                current_resolution = 0;
                SetVideoResolution(RESOLUTION_640x480, img_width, img_height);
                DBG_MSG("Resolution was changed to %s \r\n", resolutions[0]);
            }
        }
    }
}


/***************************************************************************//**
* @brief Initialize the HDMI in the main. It is a function that combines the hdmi
* lines that should be added in the main to make the HDMI works
* @return None.
*******************************************************************************/
void HDMI_MainInit (unsigned char resolution)
{
	    //InitHdmiAudioPcore();

		APP_PrintRevisions();       /* Display S/W and H/W revisions */

		ADIAPI_TransmitterInit();   /* Initialize ADI repeater software and h/w */

		ADIAPI_TransmitterSetPowerMode(REP_POWER_UP);

		StartCount = HAL_GetCurrentMsCount();

		DDRVideoWr_uponinit(detailedTiming[resolution][1], detailedTiming[resolution][5]);

		for(uint32_t i=0; i<10; i++)
		{
		if (ATV_GetElapsedMs (StartCount, NULL) >= HDMI_CALL_INTERVAL_MS)
				{
				StartCount = HAL_GetCurrentMsCount();
					if (APP_DriverEnabled())
					{
						ADIAPI_TransmitterMain();
					}
				}
		  }
}


