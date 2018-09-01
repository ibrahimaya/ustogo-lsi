/*
 * scanconverter.h
 *
 *  Created on: Mar 20, 2017
 *      Author: Aya Ibrahim
 */

#ifndef SRC_SCANCONVERTER_H_
#define SRC_SCANCONVERTER_H_

#include <stdio.h>
#include <string.h>

#define CUT_AZI_RAD 0
#define CUT_ELE_AZI 1
#define CUT_ELE_RAD 2

int load_nappe_data_scanconv(uint32_t bf_nappes_addr, uint32_t width, uint32_t height,
		uint32_t cut_orient, uint32_t cut_val, uint32_t radial_lines, uint32_t azimuth_lines, uint32_t elevation_lines);
int load_nappe_data_scanconv_debug(uint32_t *address_start, uint32_t width, uint32_t height,
		uint32_t cut_orient, uint32_t cut_val, uint32_t radial_lines, uint32_t azimuth_lines, uint32_t elevation_lines);
void output_nappes(uint32_t output_addr, uint32_t img_width, uint32_t img_height);
void term_print_nappes(uint32_t img_width, uint32_t img_height);
void scanconv_configure(uint32_t img_rad, uint32_t img_azi, uint32_t img_ele, uint32_t img_out_width, uint32_t img_out_height, uint32_t use_master);

// Register map
#define SC_STATUS_REGISTER         (XPAR_SCANCONVERTERIP_0_BASEADDR + 0x00)
#define SC_START_REGISTER          (XPAR_SCANCONVERTERIP_0_BASEADDR + 0x04)
#define SC_CUT_DIRECTION_REGISTER  (XPAR_SCANCONVERTERIP_0_BASEADDR + 0x08)
#define SC_MODE_REGISTER           (XPAR_SCANCONVERTERIP_0_BASEADDR + 0x0C)
#define SC_IN_VOXEL_REGISTER       (XPAR_SCANCONVERTERIP_0_BASEADDR + 0x10)
#define SC_SC_PIXEL_REGISTER       (XPAR_SCANCONVERTERIP_0_BASEADDR + 0x14)
#define SC_OUT_WIDTH_REGISTER      (XPAR_SCANCONVERTERIP_0_BASEADDR + 0x18)
#define SC_OUT_HEIGHT_REGISTER     (XPAR_SCANCONVERTERIP_0_BASEADDR + 0x1C)
#define SC_ELEVATION_REGISTER      (XPAR_SCANCONVERTERIP_0_BASEADDR + 0x20)
#define SC_AZIMUTH_REGISTER        (XPAR_SCANCONVERTERIP_0_BASEADDR + 0x24)
#define SC_RADIAL_REGISTER         (XPAR_SCANCONVERTERIP_0_BASEADDR + 0x28)
// unused                          (XPAR_SCANCONVERTERIP_0_BASEADDR + 0x2C)
#define SC_VERSION_REGISTER        (XPAR_SCANCONVERTERIP_0_BASEADDR + 0x30)
#define SC_DDR_IN_REGISTER         (XPAR_SCANCONVERTERIP_0_BASEADDR + 0x34)
#define SC_DDR_OUT_REGISTER        (XPAR_SCANCONVERTERIP_0_BASEADDR + 0x38)
#define SC_NEXT_PIXEL_REGISTER     (XPAR_SCANCONVERTERIP_0_BASEADDR + 0x3C)
#define SC_MAX_VOXEL_MODE_REGISTER (XPAR_SCANCONVERTERIP_0_BASEADDR + 0x40)
#define SC_MAX_VOXEL_REGISTER      (XPAR_SCANCONVERTERIP_0_BASEADDR + 0x44)
#define SC_LC_DB_REGISTER          (XPAR_SCANCONVERTERIP_0_BASEADDR + 0x48)
#define SC_CUT_VALUE_REGISTER      (XPAR_SCANCONVERTERIP_0_BASEADDR + 0x4C)
#define SC_INVALID_REGISTER        (XPAR_SCANCONVERTERIP_0_BASEADDR + 0x100)

#endif /* SRC_SCANCONVERTER_H_ */
