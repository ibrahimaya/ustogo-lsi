//
//  hdmi_control.h
//  
//
//  Created by Aya Ibrahim on 21/03/17.
//
//

#ifndef hdmi_control_h
#define hdmi_control_h

#include <stdio.h>
#include "../library/microblaze/inc/atv_platform.h"

void APP_EnableDriver (BOOL Enable);
BOOL APP_DriverEnabled (void);
void APP_PrintRevisions (void);
void APP_ChangeResolution (unsigned int img_width, unsigned int img_height);
void HDMI_MainInit (unsigned char resolution);

#endif /* hdmi_control_h */
