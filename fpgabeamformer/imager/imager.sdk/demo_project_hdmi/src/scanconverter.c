/*
 * scanconverter.c
 *
 *  Created on: Mar 20, 2017
 *      Author: Aya Ibrahim
 */

#include "xil_io.h"
#include "xparameters.h"
#include "xuartlite_l.h"
#include "scanconverter.h"
#include "params.h"
//#include "pres_old_sphere_complete_2D.h"

/* send the nappes data stored in @param address_start to the scan converter
 * @param width and @param height specify the width and height of the nappes data (default: 64 and 600)
 * @param cut_orient specify the direction of the cut {side, front} and the @param cut_val specify
 * the depth of the cut (a cut_val of 32 means the middle of the scan)
 */
int load_nappe_data_scanconv(uint32_t bf_nappes_addr, uint32_t width, uint32_t height,
		uint32_t cut_orient, uint32_t cut_val, uint32_t radial_lines, uint32_t azimuth_lines, uint32_t elevation_lines){

	uint32_t i = 0, j = 0, val;

	if (cut_orient == CUT_AZI_RAD)
	{
		bf_nappes_addr += cut_val * 4;
		for (j = 0; j < height; j ++)
		{
			for (i = 0; i < width; i ++)
			{
				val = Xil_In32(bf_nappes_addr);
				bf_nappes_addr += elevation_lines * 4;
				Xil_Out32(SC_IN_VOXEL_REGISTER, val);
			}
		}
	}
	else if (cut_orient == CUT_ELE_AZI)
	{
		bf_nappes_addr += cut_val * elevation_lines * radial_lines * 4;
		for (j = 0; j < height; j ++)
		{
			for (i = 0; i < width; i ++)
			{
				val = Xil_In32(bf_nappes_addr);
				bf_nappes_addr += 4;
				Xil_Out32(SC_IN_VOXEL_REGISTER, val);
			}
		}
	}
	else if (cut_orient == CUT_ELE_RAD)
	{
		bf_nappes_addr += cut_val * elevation_lines * 4;
		for (j = 0; j < height; j ++)
		{
			for (i = 0; i < width; i ++)
			{
				val = Xil_In32(bf_nappes_addr);
				bf_nappes_addr += 4;
				Xil_Out32(SC_IN_VOXEL_REGISTER, val);
			}
			bf_nappes_addr += (azimuth_lines - 1) * elevation_lines * 4 + 4;
		}
	}

	return 0;
}

int load_nappe_data_scanconv_debug(uint32_t *address_start, uint32_t width, uint32_t height,
		uint32_t cut_orient, uint32_t cut_val, uint32_t radial_lines, uint32_t azimuth_lines, uint32_t elevation_lines){

	// TODO this routine is broken
	uint32_t i = 0, j = 0, ptr = 0;

	//if(cut_orient == CUT_FRONT){
		for (j=0; j<height; j++){
			////// ptr = cut_val*width+width*width*j-j;
			for (i=0; i<width; i++){
				uint32_t val = address_start[ptr];
				Xil_Out32(SC_IN_VOXEL_REGISTER, val);
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

				Xil_Out32(SC_IN_VOXEL_REGISTER, val);
				ptr+=(width);
			}
		}
	} */

	return 0;
}

/*
 * output the nappes of the scan converter to the @param output_addr memory location.
 * @param img_width and @param img_height are the size of the output image as it was parameterized
 * in the scan conversion module
 */
void output_nappes(uint32_t output_addr, uint32_t img_width, uint32_t img_height){
	uint32_t ptr_x = 0, ptr_y = 0, status_reg = 0xFFFF;

	while ((status_reg & 0x08) != 0){
		status_reg = Xil_In32(SC_STATUS_REGISTER);
	}

	for (ptr_y = 0; ptr_y<img_height; ptr_y++){
		for (ptr_x = 0; ptr_x<img_width; ptr_x++){
			status_reg = 0;

			while ((status_reg & 0x4) == 0){
				status_reg = Xil_In32(SC_STATUS_REGISTER);
			}

			uint32_t value = Xil_In32(SC_SC_PIXEL_REGISTER);
			Xil_Out32(SC_NEXT_PIXEL_REGISTER, 0x1);
			value = (value << 16) + (value << 8) + value;
			Xil_Out32(output_addr + (ptr_y * img_width + ptr_x) * 4, value);
		}
	}
}

/*
 * Debug function: instead of output the scan converted image in memory, output it
 * to the standard out
 */
void term_print_nappes(uint32_t img_width, uint32_t img_height){
	uint32_t ptr_x = 0, ptr_y = 0, status_reg = 0xFFFF;

	while ((status_reg & 0x08) != 0){
		status_reg = Xil_In32(SC_STATUS_REGISTER);
	}

	for (ptr_y = 0; ptr_y<img_height; ptr_y++){
		for (ptr_x = 0; ptr_x<img_width; ptr_x++){
			status_reg = 0;
			Xil_Out32(SC_NEXT_PIXEL_REGISTER, 0x1);

			while( (status_reg&0x4) == 0){
				status_reg = Xil_In32(SC_STATUS_REGISTER);
			}

			uint32_t value = Xil_In32(SC_SC_PIXEL_REGISTER);
			xil_printf("%d,", value);
			if (ptr_x == img_width-1){
				xil_printf("\n\r");
			}

		}
	}
	Xil_Out32(SC_NEXT_PIXEL_REGISTER, 0x1);
}

/*
 * configure the scan converter
 * @param img_rad: the number of nappes that will be fed to the converted
 * @param img_azi: azimuth dimension of the nappes
 * @param img_ele: elevation dimension of the nappes
 * @param img_out_width, dimension of the output image, in pixels, that will be displayed on the screen.
 */
void scanconv_configure(uint32_t img_rad, uint32_t img_azi, uint32_t img_ele, uint32_t img_out_width, uint32_t img_out_height, uint32_t use_master){
	Xil_Out32(SC_RADIAL_REGISTER, img_rad);
	Xil_Out32(SC_AZIMUTH_REGISTER, img_azi);
	Xil_Out32(SC_ELEVATION_REGISTER, img_ele);
	Xil_Out32(SC_OUT_WIDTH_REGISTER, img_out_width);
	Xil_Out32(SC_OUT_HEIGHT_REGISTER, img_out_height);
	if (use_master == 1)
		// The output voxels are written automatically by the SC AXI master
		// to the address specified in SC_DDR_OUT_REGISTER
		Xil_Out32(SC_MODE_REGISTER, 0x1);
	else
	   // The voxels will need to be written and read manually
	   Xil_Out32(SC_MODE_REGISTER, 0x5);
}
