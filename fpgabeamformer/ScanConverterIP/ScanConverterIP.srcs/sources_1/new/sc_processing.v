// ***************************************************************************
// ***************************************************************************
//  Copyright (C) 2014-2018  EPFL
//  "ScanConverterIP" custom IP.
//
//   Permission is hereby granted, free of charge, to any person
//   obtaining a copy of this software and associated documentation
//   files (the "Software"), to deal in the Software without
//   restriction, including without limitation the rights to use,
//   copy, modify, merge, publish, distribute, sublicense, and/or sell
//   copies of the Software, and to permit persons to whom the
//   Software is furnished to do so, subject to the following
//   conditions:
//
//   The above copyright notice and this permission notice shall be
//   included in all copies or substantial portions of the Software.
//
//   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//   OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//   NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//   HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//   WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//   OTHER DEALINGS IN THE SOFTWARE.
// ***************************************************************************
// ***************************************************************************
// ***************************************************************************
// ***************************************************************************

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/20/2016 06:16:15 PM
// Design Name: 
// Module Name: sc_processing
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module sc_processing #(
        
        parameter integer VOXEL_DATA_WIDTH = 32,
        parameter integer PIXEL_DATA_WIDTH = 8,
        parameter integer BRAM_ADDR_WIDTH = 16
    )
    (
        input wire  clk,
        // Global Reset Signal. This Signal is Active LOW
        input wire  resetn,
        
        output reg [PIXEL_DATA_WIDTH - 1 : 0] out_data,
        //output reg [31 : 0] out_pos_x,
        //output reg [31 : 0] out_pos_y,
        output reg valid_output,
        
        input wire [VOXEL_DATA_WIDTH - 1 : 0] in_voxel_data,
        output reg [BRAM_ADDR_WIDTH - 1 : 0] in_voxel_addr,
        output reg in_voxel_next,
        
        //bit 0: start, [15 : 1] max size x, [30 : 16] max size y //size for sub square the sc_proc is operating on
        //[45 : 31]  start pos x, [60 : 46] start pos y
        //[75 : 61]  voxels width [90 : 76] voxels height
        //[105: 91]  image_width  [120:106] image_height 
        input wire [128 : 0] start_values, 
        output reg finished = 'b0,
        input wire enabled
    );
    
    function [47 : 0] fixed_div48;
        input [47 : 0] a, b;
        fixed_div48 = {(a[47] == 1)?~a:a, 32'b1} / ((b[47] == 1)?~b:b);
        fixed_div48[46 : 0] = (a[47]^b[47] == 1'b1)?~fixed_div48[46:0]:fixed_div48[46:0];
        fixed_div48[47] = a[47]^b[47];
    endfunction
    
    function [31 : 0] fixed_div32;
        input [31 : 0] a, b;
        fixed_div32 = {(a[31] == 1)?~a:a, 18'b1} / ((b[31] == 1)?~b:b);
        fixed_div32[30 : 0] = (a[31] ^ b[31] == 1'b1) ? ~fixed_div32[30 : 0] : fixed_div32[30 : 0];
        fixed_div32[31] = a[31] ^ b[31];
    endfunction
    
    function [31 : 0] fixed_div14;
        input [13 : 0] a, b;
        fixed_div14 = {(a[13] == 1) ? -a : a, 18'b1} / ((b[13] == 1)? -b : b);
        fixed_div14[30 : 0] = (a[13] ^ b[13] == 1'b1) ? -fixed_div14[30 : 0] : fixed_div14[30:0];
        fixed_div14[31] = a[13] ^ b[13];
    endfunction
    
    function [95 : 0] fixed_mult48;
        input [47 : 0] a, b;
        fixed_mult48 = (((a[47] == 'b1) ? {48'hFFFFFFFFFFFF, a} : a) * ((b[47] == 'b1) ? {48'hFFFFFFFFFFFF, b} : b))>>32;
        fixed_mult48[47] = a[47] ^ b[47];
    endfunction
    
    function [63 : 0] fixed_mult32;
        input [31 : 0] a, b;
        fixed_mult32 = (((a[31] == 'b1) ? {32'hFFFFFFFF, a} : a) * ((b[31] == 'b1) ? {32'hFFFFFFFF, b} : b)) >> 18;
        fixed_mult32[31] = a[31] ^ b[31];
    endfunction
    
    function [46 : 0] fixed_mult1418_1400_unsigned;
        input [31 : 0] a;
        input [13 : 0] b;
        fixed_mult1418_1400_unsigned = a * b;
    endfunction
    
    function [46 : 0] fixed_mult1418_1400;
        input [31 : 0] a;
        input [13 : 0] b;
        fixed_mult1418_1400 = (((a[31] == 'b1) ? {14'h3FFF, a} : a) * ((b[13] == 'b1) ? {32'hFFFFFFFF, b} : b));
        fixed_mult1418_1400[31] = a[31] ^ b[13];
    endfunction
    
    function [39 : 0] fixed_mult2_18;
        input [19 : 0] a;
        input [19 : 0] b;
        fixed_mult2_18 = (((a[19] == 'b1)?{20'hFFFFF, a} : a)* ((b[19] == 'b1)?{20'hFFFFF, b} : b)) >> 18;
        fixed_mult2_18[19] = a[19] ^ b[19];
    endfunction
    
    function unsigned [37 : 0] fixed_mult14_19_unsigned;
        input unsigned [14 : 0] a;
        input unsigned [19 : 0] b;
        fixed_mult14_19_unsigned[31 : 0] = a * b;
    endfunction
    
    function unsigned [BRAM_ADDR_WIDTH - 1 : 0] input_voxel_address;
        input unsigned [31 : 0] x, y;
        input_voxel_address = y * voxel_width + x;
    endfunction
      
    //for master
    reg [31 : 0] output_val = 32'h10101010;
    reg ready;
    reg [31 : 0] current_voxel;
    reg scan_conv_started;
    reg [31 : 0] out_data_reg, out_data_reg_1, out_data_reg_2;
    reg [15 : 0] bram_read_counter;
    wire [31 : 0] old_pos_x, old_pos_y;
    
    ///////////read from bram for the data//////////
    reg [31 : 0] reg_voxel_in_rightdown;
    reg [31 : 0] reg_voxel_in_down;
    reg [31 : 0] reg_voxel_in_right;
    reg [31 : 0] reg_voxel_in_mid;
    
    /////////////////for calculation of scan conversion//////////
    reg [31 : 0] relative_new_pos_x_int;
    reg [31 : 0] relative_new_pos_x_norm_fixed;
    reg [31 : 0] relative_new_pos_y_fixed;
    reg [31 : 0] relative_new_pos_y_fixed_copytest;
    reg [31 : 0] relative_new_pos_y_norm_fixed;
    reg [31 : 0] relative_new_pos_x_forx_fixed;
    reg [31 : 0] relative_new_pos_x_fory_fixed;
    reg [31 : 0] relative_new_pos_x_fory_fixed_copy;
    reg [31 : 0] sqrt_in_fixed_1;
    reg [31 : 0] sqrt_in_fixed_2;
    reg [31 : 0] sqrt_in_fixed;
    wire [20 : 0] atan_out_wire;
    wire [20 : 0] sqrt_out_wire;
    reg [31 : 0] atan_out_fixed;
    reg [31 : 0] sqrt_out_fixed;
    wire [31 : 0] width_corr_fixed = {32'b00000000000001010011001100110011}; // 1.3
    wire [31 : 0] height_corr_fixed = {14'b0, 18'h24924}; // 0.571428571
    reg [31 : 0] old_pos_x_fixed;
    reg [31 : 0] old_pos_x_fixed_copytest;
    reg [31 : 0] old_pos_y_fixed;
    reg [31 : 0] sub_x_1, sub_x_2;
    reg unsigned [31 : 0] sub_x_1_1, sub_x_1_2;
    reg unsigned [31 : 0] sub_x_2_1, sub_x_2_2;
    
    reg divider_int_active_x = 'h0;
    wire [31 : 0] divider_int_out_x;
    reg divider_int_active_y = 'h0;
    wire [31 : 0] divider_int_out_y;
    
    // Buffers to make the pipelining possible
    reg [31 : 0] buffer_atan_sqrt_1, buffer_atan_sqrt_2;
    reg [31 : 0] buffer_sqrt_1;
    reg [31 : 0] buffer_final_mult_1, buffer_final_mult_2, buffer_final_mult_3;
    reg [31 : 0] buffer_bubble_1, buffer_bubble_2, buffer_bubble_3, buffer_bubble_4;
    reg [31 : 0] buffer_bubble_5, buffer_bubble_6, buffer_bubble_7, buffer_bubble_8;
    reg [60 : 0] pipeline_content;
    reg [13 : 0] pipeline_atan_test_result;
    reg [14 : 0] pipeline_sqrt_test_result;
    reg outputing = 'b0;
    reg reg_enabled = 'b0;
    
    integer pos_x_initial, pos_y_initial = 0;
    integer local_img_width, local_img_height;
    integer new_x, new_y = 0;
    integer voxel_width, voxel_height;
    integer image_width, image_height;
    
    assign old_pos_x = {18'b0, old_pos_x_fixed[31 : 18]};
    assign old_pos_y = {18'b0, old_pos_y_fixed[31 : 18]};

    always @(posedge clk or negedge resetn)
    begin: return_something
        if(resetn == 'b0)
        begin: reset
                buffer_bubble_1 <= 'h0;
                buffer_bubble_2 <= 'h0;
                buffer_bubble_3 <= 'h0;
                buffer_bubble_4 <= 'h0;
                buffer_bubble_5 <= 'h0;
                buffer_bubble_6 <= 'h0;
                buffer_bubble_7 <= 'h0;
                buffer_bubble_8 <= 'h0;
                sub_x_1_1 <= 'h0;
                sub_x_1_2 <= 'h0;
                sub_x_1 <= 'h0;
                sub_x_2_1 <= 'h0;
                sub_x_2_2 <= 'h0;
                sub_x_2 <= 'h0;
                out_data_reg <= 'h0;
                out_data_reg_1 <= 'h0;
                out_data_reg_2 <= 'h0;
                scan_conv_started <= 'h0;
                finished <= 'h0;
                pos_x_initial <= 'h0;
                new_x <= 'h0;
                pos_y_initial <= 'h0;
                new_y <= 'h0;
                local_img_width <= 'h0;
                local_img_height <= 'h0;
                voxel_width <= 'h0;
                voxel_height <= 'h0;
                image_width <= 'h0;
                image_height <= 'h0;
                valid_output <= 'h0;
                bram_read_counter <= 'h0;
                reg_enabled <= 'h0;
                pipeline_content <= 'h0;
                outputing <= 'h0;
                atan_out_fixed <= 'h0;
                pipeline_atan_test_result <= 'h0;
                sqrt_out_fixed <= 'h0;
                pipeline_sqrt_test_result <= 'h0;
                relative_new_pos_x_int <= 'h0;
                relative_new_pos_x_forx_fixed <= 'h0;
                relative_new_pos_x_fory_fixed <= 'h0;
                relative_new_pos_x_fory_fixed_copy <= 'h0;
                sqrt_in_fixed_1 <= 'h0;
                sqrt_in_fixed_2 <= 'h0;
                buffer_sqrt_1 <= 'h0;
                sqrt_in_fixed <= 'h0;
                old_pos_x_fixed <= 'h0;
                old_pos_x_fixed_copytest <= 'h0;
                buffer_final_mult_1 <= 'h0;
                old_pos_y_fixed <= 'h0;
                buffer_final_mult_2 <= 'h0;
                buffer_final_mult_3 <= 'h0;
                buffer_atan_sqrt_2 <= 'h0;
                relative_new_pos_y_fixed <= 'h0;
                relative_new_pos_y_fixed_copytest <= 'h0;
                relative_new_pos_x_norm_fixed <= 'h0;
                buffer_atan_sqrt_1 <= 'h0;
                divider_int_active_x <= 'h0;
                divider_int_active_y <= 'h0;
                in_voxel_next <= 'h0;
                in_voxel_addr <= 'h0;
                reg_voxel_in_rightdown <= 'h0;
                reg_voxel_in_down <= 'h0;
                reg_voxel_in_right <= 'h0;
                reg_voxel_in_mid <= 'h0;
                out_data <= 'h0;
        end
        else
        begin
            if (start_values[0] == 'b1)
            begin
                scan_conv_started <= 'b1;
                finished <= 'b0;
                pos_x_initial <= start_values[45 : 31];
                new_x <= start_values[45 : 31];
                pos_y_initial <= start_values[60 : 46];
                new_y <= start_values[60 : 46];
                local_img_width <= start_values[15 : 1];
                local_img_height <= start_values[30 : 16];
                voxel_width <= start_values[75 : 61];
                voxel_height <= start_values[90 : 76];
                image_width <= start_values[105 : 91];
                image_height <= start_values[120 : 106];
                valid_output <= 'b0;
                bram_read_counter <= 'd70;
                reg_enabled <= 'b0;
                pipeline_content <= {1'b1, 60'h0};
                outputing <= 'b0;
            end
            
            finished <= 'b0;
            
            if (reg_enabled == 'b1)
            begin
                //since atan can by negative, extend the sign
                atan_out_fixed <= ((atan_out_wire[19] == 'b1) ? {11'h7FF, atan_out_wire, 1'b0} : {11'b0, atan_out_wire, 1'b0});
                // Checks if this voxel ends beyond the edges of the volume
                pipeline_atan_test_result[13] <= (atan_out_fixed < {14'h3FFF, 18'h0} && atan_out_fixed > {14'h1, 18'h0});
                sqrt_out_fixed <= {13'b0, sqrt_out_wire[19 : 1]};
                // Checks if this voxel ends beyond the bottom of the BF volume (sqrt > 1).
                // Note: if the sqrt is exactly 1 and we need precisely the last BF line for this SC pixel,
                // we will still exceed the end of the volume because the interpolation code looks at the
                // voxel "below" too. Fixed by ensuring the BRAM that contains the input frame has one extra
                // row below the last BF line. This will be initialized at 0 in both simulation and HW.
                pipeline_sqrt_test_result[14] <= (sqrt_out_fixed > {14'h1, 18'h0});                
                relative_new_pos_x_int <= new_x*2-(image_width)+1;
                relative_new_pos_x_forx_fixed <= fixed_mult32(relative_new_pos_x_norm_fixed, width_corr_fixed);
                //relative_new_pos_x_fory_fixed <= fixed_div32(relative_new_pos_x_norm_fixed, height_corr_fixed); //div_version
                relative_new_pos_x_fory_fixed <= fixed_mult32(relative_new_pos_x_norm_fixed, height_corr_fixed);
                //do a copy of relative_new_pos_x_fory_fixed since it will be used as both parameters of a function
                //==> this caused bad timing
                relative_new_pos_x_fory_fixed_copy <= relative_new_pos_x_fory_fixed;
                sqrt_in_fixed_1 <= {12'b0, fixed_mult2_18(relative_new_pos_x_fory_fixed_copy[19:0], relative_new_pos_x_fory_fixed[19:0])};
                sqrt_in_fixed_2 <= {12'b0, fixed_mult2_18(relative_new_pos_y_fixed[19:0], relative_new_pos_y_fixed_copytest[19:0])};
                buffer_sqrt_1 <= sqrt_in_fixed_2;
                sqrt_in_fixed <= sqrt_in_fixed_1+buffer_sqrt_1;
                old_pos_x_fixed <= fixed_mult1418_1400(atan_out_fixed+{13'b0, 1'b1, 18'b0}, voxel_width[13:0]/2);//fixed_div32({voxel_width[13:0], 18'b0}, {12'b0, 2'b10, 18'b0})); //(atan_out+1)*/(nappe_width/2)
                old_pos_x_fixed_copytest <= old_pos_x_fixed; 
                buffer_final_mult_1 <= fixed_mult1418_1400_unsigned(sqrt_out_fixed, voxel_height[13 : 0]); //sqrt_out*height_nappes
                old_pos_y_fixed <= buffer_final_mult_1;
                buffer_final_mult_2 <= old_pos_y_fixed;
                buffer_final_mult_3 <= buffer_final_mult_2;
                buffer_bubble_1 <= buffer_final_mult_3;
                buffer_bubble_2 <= buffer_bubble_1;
                buffer_bubble_3 <= buffer_bubble_2;
                buffer_bubble_4 <= buffer_bubble_3;
                buffer_bubble_5 <= buffer_bubble_4;
                buffer_bubble_6 <= buffer_bubble_5;
                buffer_bubble_7 <= buffer_bubble_6;
                buffer_bubble_8 <= buffer_bubble_7;

                sub_x_1_1 <= fixed_mult14_19_unsigned(reg_voxel_in_mid[13 : 0], {1'b0, ~old_pos_x_fixed[17 : 0]});
                sub_x_1_2 <= fixed_mult14_19_unsigned(reg_voxel_in_right[13 : 0], {1'b0, old_pos_x_fixed_copytest[17 : 0]});
                sub_x_1 <= sub_x_1_1 + sub_x_1_2;
                sub_x_2_1 <= fixed_mult14_19_unsigned(reg_voxel_in_down[13 : 0], {1'b0, (~old_pos_x_fixed[17 : 0])});
                sub_x_2_2 <= fixed_mult14_19_unsigned(reg_voxel_in_rightdown[13 : 0], {1'b0, old_pos_x_fixed_copytest[17 : 0]});
                sub_x_2 <= sub_x_2_1 + sub_x_2_2;
                out_data_reg_1 <= fixed_mult32(sub_x_1, ({14'b0, ~buffer_bubble_8[17 : 0]}));
                out_data_reg_2 <= fixed_mult32(sub_x_2, ({14'b0, buffer_bubble_8[17 : 0]}));
                out_data_reg <= (out_data_reg_1+out_data_reg_2) >> 18;
                buffer_atan_sqrt_2 <= buffer_atan_sqrt_1;
                relative_new_pos_y_fixed <= buffer_atan_sqrt_2;
                //since relative_new_pos_y_fixed  will be used as two parameters in the same function
                //we separate it in order to avoid bad timing
                relative_new_pos_y_fixed_copytest <= buffer_atan_sqrt_2;
                
                /////////////////////////LOG COMPRESSION/////////////////////////
                //START THE SCAN CONVERSION (for now just put the nappe slice in a img memory)
                //scan_conv_started <= 'b1
                
                //!!!warning to the strange fractional ordering in the int14_divider where the fractional
                //part is only 17bits instead of 18 (TODO: ?????)
                relative_new_pos_x_norm_fixed <= {(divider_int_out_x[17] == 1)? (divider_int_out_x[31:18]-1) : divider_int_out_x[31:18], divider_int_out_x[16:0], 1'b0};
                buffer_atan_sqrt_1 <= ((new_y == 'b0)? 32'b1 : {(divider_int_out_y[17] == 1)? (divider_int_out_y[31:18]-1) : divider_int_out_y[31:18], divider_int_out_y[16:0], 1'b0});
                
                divider_int_active_x <= 'b1;
                divider_int_active_y <= 'b1;
                
                pipeline_content = pipeline_content >> 1;
                pipeline_sqrt_test_result = pipeline_sqrt_test_result >> 1;
                pipeline_atan_test_result = pipeline_atan_test_result >> 1;
                
                valid_output <= 'b0;
                in_voxel_next <= 'b0;
                divider_int_active_x <= 'b0;
                divider_int_active_y <= 'b0;
            end
            
            if (scan_conv_started == 'h1 && reg_enabled == 'b1)
            begin
                // Ask for right down diagonal voxel
                if (pipeline_content[13] == 'b1)// bram_read_counter == 'd18)
                begin
                   in_voxel_addr <= input_voxel_address(old_pos_x + 1, old_pos_y + 1);
                   in_voxel_next <= 'b1;
                end
                
                // Ask for down voxel
                if (pipeline_content[12] == 'b1)
                begin
                   in_voxel_addr <= input_voxel_address(old_pos_x, old_pos_y + 1);
                   in_voxel_next <= 'b1;
                end
                
                // Ask for right voxel
                if (pipeline_content[11] == 'b1)//bram_read_counter == 'd16)
                begin
                   in_voxel_addr <= input_voxel_address(old_pos_x + 1, old_pos_y);
                   in_voxel_next <= 'b1;
                end
                
                // Ask for central voxel
                if (pipeline_content[10] == 'b1)//bram_read_counter == 'd15)
                begin
                    in_voxel_addr <= input_voxel_address(old_pos_x, old_pos_y);
                    in_voxel_next <= 'b1;
                end
                
                if (pipeline_content[9] == 'b1)
                begin
                    // Do nothing, wait for data
                end
                
                if (pipeline_content[8] == 'b1)//bram_read_counter == 'd13)
                begin
                    reg_voxel_in_rightdown <= in_voxel_data;
                end
                
                if (pipeline_content[7] == 'b1)//bram_read_counter == 'd12)
                begin
                    reg_voxel_in_down <= in_voxel_data;
                end
                
                if (pipeline_content[6] == 'b1)//bram_read_counter == 'd11)
                begin
                    reg_voxel_in_right <= in_voxel_data;
                end
                
                if (pipeline_content[5] == 'b1)//bram_read_counter == 'd10)
                begin
                    reg_voxel_in_mid <= in_voxel_data;
                    //the pipeline is then free to move
                end
                
                if (bram_read_counter >= 'd1)
                begin
                   bram_read_counter <= bram_read_counter - 1;
                end
                
            end
            
            if(outputing == 'b1)
            begin
                reg_enabled <= 'b0;
                outputing <= 'b0;
                
                if (new_x + 1 == local_img_width)
                begin
                    //if we have nothing in the pipeline anymore and are at the last
                    //pixel ==> stop the sc_proc
                    if(new_y + 1 == local_img_height && pipeline_content == 'b0) 
                    begin
                        scan_conv_started <= 'b0;
                        finished <= 'b1;
                        scan_conv_started <= 'b0;
                    end
                end
            end
            
            if (scan_conv_started == 'h1 && enabled == 'b1)
            begin
                reg_enabled <= 'b1;
            end
            
            if (bram_read_counter == 'b0 && reg_enabled == 'b1)
            begin
                if (new_x + 1 == local_img_width)
                begin
                    new_x <= pos_x_initial;
                    if (new_y + 1 == local_img_height)
                        new_y <= pos_y_initial;
                    else
                        new_y <= new_y + 1;
                end
                else
                    new_x <= new_x + 1;
                bram_read_counter <= 'd70; // delay to get the data
                pipeline_content[60] <= 1'b1;
            end
            
            if (scan_conv_started == 'h1 && reg_enabled == 'b1 && pipeline_content[0] == 'b1)//&& bram_read_counter == 'b0)
            begin: sc_conv_proc
            
                outputing <= 'b1; 
                valid_output <= 'b1;
                out_data <= 'hff;
                
                if (pipeline_atan_test_result[0] == 'b1 || pipeline_sqrt_test_result[0] == 'b1)
                    out_data <= 'h7f;
                else
                begin
                    //linear interpolation
                    //out_data = $bitstoreal(sub_x_1)*(1.0-$bitstoreal(new_y_pos_decimal))+$bitstoreal(sub_x_2)*$bitstoreal(new_y_pos_decimal);
                    //out_data <= out_data_wire;
                    //out_data <= 'hff;
                    
                    //no interpolation
                    //out_data <= reg_voxel_in_mid;
                    //with interpolation
                    out_data <= out_data_reg;
                end
            end  
        end
    end
    
    cordic_atan cordic_atan_0 (
        .s_axis_cartesian_tdata({relative_new_pos_x_forx_fixed[19 : 4], relative_new_pos_y_fixed[19 : 4]}),
        .s_axis_cartesian_tvalid(1'b1),
        .aclk(clk),
        .m_axis_dout_tdata(atan_out_wire),
        .m_axis_dout_tvalid()
    );
    
    cordic_fixed_sqrt cordic_sqrt_0 (
        .s_axis_cartesian_tdata({4'b0000, sqrt_in_fixed[18:0], 1'b0}),
        .s_axis_cartesian_tvalid(1'b1),
        .aclk(clk),
        .m_axis_dout_tdata(sqrt_out_wire),
        .m_axis_dout_tvalid()
    );
    
    int14_divider int14_divider_x (
        .aclk(clk),
        .s_axis_divisor_tvalid(divider_int_active_x),
        .s_axis_divisor_tdata({2'b00, image_width[13:0]}),
        .s_axis_dividend_tvalid(divider_int_active_x),
        .s_axis_dividend_tdata({2'b00, relative_new_pos_x_int[13 : 0]}),
        .m_axis_dout_tvalid(),
        .m_axis_dout_tdata(divider_int_out_x)
    );
    
    int14_divider int14_divider_y (
        .aclk(clk),
        .s_axis_divisor_tvalid(divider_int_active_y),
        .s_axis_divisor_tdata({2'b00, image_height[13 : 0]}),
        .s_axis_dividend_tvalid(divider_int_active_y),
        .s_axis_dividend_tdata({2'b00, new_y[13 : 0]}),
        .m_axis_dout_tvalid(),
        .m_axis_dout_tdata(divider_int_out_y)
    );
    
endmodule