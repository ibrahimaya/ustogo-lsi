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
// Create Date: 12/20/2016 06:41:17 PM
// Design Name: 
// Module Name: sc_log_compression
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


module sc_log_compression#
        (    
            parameter integer VOXEL_DATA_WIDTH = 32,
            parameter integer BRAM_ADDR_WIDTH = 16
        )
        (
            input wire  clk,
            // Global Reset Signal. This Signal is Active LOW
            input wire  resetn,
            
            //input wire [VOXEL_DATA_WIDTH-1 : 0] in_voxel_mem [VOXEL_MEM_HEIGHT-1:0] [VOXEL_MEM_WIDTH-1:0],
            output reg [VOXEL_DATA_WIDTH-1 : 0] out_data,
            
            input wire [VOXEL_DATA_WIDTH-1 : 0] in_voxel_data,
            output reg [BRAM_ADDR_WIDTH-1 : 0] in_voxel_addr,
            output reg in_voxel_next = 'b0,
            
            input wire [31 : 0] lc_max_value,
            input wire [31 : 0] lc_const,
            output reg [31 : 0] out_pos_x,
            output reg [31 : 0] out_pos_y,
            output reg valid_output,
            
            //bit 0: start, [15 : 1] max size x, [30 : 16] max size y (sizes of 15bits, 32K max)
            //[45 : 31]  start pos x, [60 : 46] start pos y
            input wire [63 : 0] start_values, 
            output reg finished = 'b0,
            input wire reset_finished_signal
        );
        
        function [63 : 0] fixed_div64;
                
        input [63 : 0] a;
        input [63 : 0] b;
        
        fixed_div64 = {(a[63] == 1)?~a:a, 32'b1} / ((b[63] == 1)?~b:b);
        fixed_div64[62 : 0] = (a[63]^b[63] == 1'b1)?~fixed_div64[62:0]:fixed_div64[62:0];
        fixed_div64[63] = a[63]^b[63];
        
        endfunction
        
        function [47 : 0] fixed_div48;
        
        input [47 : 0] a;
        input [47 : 0] b;
        
        fixed_div48 = {(a[47] == 1)?~a:a, 32'b1} / ((b[47] == 1)?~b:b);
        fixed_div48[46 : 0] = (a[47]^b[47] == 1'b1)?~fixed_div48[46:0]:fixed_div48[46:0];
        fixed_div48[47] = a[47]^b[47];
        
        endfunction
        
        function [31 : 0] fixed_div32; //14:18
                
        input [31 : 0] a;
        input [31 : 0] b;
        
        fixed_div32 = {(a[31] == 1)?~a:a, 18'b1} / ((b[31] == 1)?~b:b);
        fixed_div32[30 : 0] = (a[31]^b[31] == 1'b1)?~fixed_div32[30:0]:fixed_div32[30:0];
        fixed_div32[31] = a[31]^b[31];
        
        endfunction
        
        function [31 : 0] fixed_div_step1; //14:18
                        
        input [31 : 0] a;
        input [13 : 0] b;
        
        fixed_div_step1[22 : 0] = {(a[31] == 1)?~a[22 : 0]:a[22 : 0]} / b; //b always positive
        fixed_div_step1[30 : 23] = 'h0;
        fixed_div_step1[30 : 0] = (a[31] == 1'b1)?~fixed_div_step1[30:0]:fixed_div_step1[30:0];
        fixed_div_step1[31] = a[31];
        
        endfunction
        
        function [31 : 0] fixed_div_forlog; //14:18
                        
        input [31 : 0] a;
        input [31 : 0] b;
        
        fixed_div_forlog = {(a[31] == 1)?~a:a, 36'b0} / {(b[31] == 1)?~b:b, 18'b0};
        fixed_div_forlog[30 : 0] = (a[31]^b[31] == 1'b1)?~fixed_div_forlog[30:0]:fixed_div_forlog[30:0];
        fixed_div_forlog[31] = a[31]^b[31];
        
        endfunction
        
        function [95 : 0] fixed_mult48;
        
        input [47 : 0] a;
        input [47 : 0] b;
        
        fixed_mult48 = (((a[47] == 'b1) ? ({~(a[47:32]), -(a[31:0])}) : a)*((b[47] == 'b1) ? ({~(b[47:32]), -(b[31:0])}) : b))>>32;
        fixed_mult48[46 : 0] = ((a[47]^b[47]) == 'b1) ? ({~(fixed_mult48[46:32]), -(fixed_mult48[31:0])}) : fixed_mult48[46:0];
        fixed_mult48[47] = a[47]^b[47];
        
        endfunction
        
        function [63 : 0] fixed_mult32;
            
        input [31 : 0] a;
        input [31 : 0] b;
        
        fixed_mult32 = ( ((a[31] == 'b1)?{32'hFFFFFFFF, a} : a)* ((b[31] == 'b1)?{32'hFFFFFFFF, b} : b))>>18;
        fixed_mult32[31] = a[31]^b[31];
        
        endfunction
        
        integer pos_x_initial = 0;
        integer pos_y_initial = 0;
        
        reg [9 : 0] voxel_mem_width, voxel_mem_height;
        
        integer pos_x_input;
        integer pos_y_input;
        integer pos_x_output;
        integer pos_y_output;
        
        //bit 0 to say that we have started, bit 1 tell us that 
        reg [1 : 0] started = 'b0;
        
        //reg voxel_asked = 'b0;
        reg [VOXEL_DATA_WIDTH-1 : 0] reg_voxel_in = 'b0;
        reg [15 : 0] bram_read_counter = 'b0;
        
        reg [31 : 0] in_voxel_data_fixed;
        reg [31 : 0] lc_max_value_fixed;
        reg [31 : 0] relative_val_fixed;
        wire [31 : 0] out_relative_val_float;
        wire [31 : 0] out_log_output_float;
        wire [31 : 0] out_log_output_interm_fixed;
        reg [31 : 0] log_output_fixed;
        reg [31 : 0] log_output_capped_fixed; //is it useful?
        reg [31 : 0] real_out_fixed_step_1;
        reg [31 : 0] real_out_fixed_step_2;
        reg [31 : 0] real_out_fixed;
        reg [31 : 0] voxel_out_fixed;
        //wire [47 : 0] GSMAX_fixed = {16'd255, 32'h0};
        wire [31 : 0] gsmax_fixed = {14'd255, 18'h0};
        reg [31 : 0] lcconst_fixed = 'h0;
        wire [31 : 0] MAX_PIXEL_VALUE_fixed = {14'd255, 18'h0};
        
        reg divider_int_active = 'h0;
        wire [31 : 0] divider_int_out;
        
        reg [14 : 0] divider_int_divisor_step1 = 'hFFFFFFFE;
        reg divider_int_active_step1 = 'h0;
        reg [14 : 0] divider_int_dividend_step1 = 'hFFFFFFFF;
        wire [31 : 0] divider_int_out_step1;
        
        reg [37 : 0][18 : 0] buffer_comp;
        reg [5: 0] buffer_comp_ptr;
        
        reg [67 : 0] pipeline_content;
        
        reg [31 : 0] mult_clock_1;
        
        
        always @(posedge clk)
        begin
            if ( start_values[0] == 'b1 )
            begin
                started <= 'b1;
                finished <= 'b0;
                pos_x_initial <= start_values[45 : 31];
                pos_x_input <= start_values[45 : 31];
                pos_x_output <= start_values[45 : 31];
                pos_y_initial <= start_values[60 : 46];
                pos_y_input <= start_values[60 : 46];
                pos_y_output <= start_values[60 : 46];
                voxel_mem_width <= start_values[10 : 1];
                voxel_mem_height <= start_values[25 : 16];
                bram_read_counter <= 'd20;
                buffer_comp_ptr <= 'h0;
                pipeline_content <= 'h0;
            end
            
            if ( reset_finished_signal == 'b1 )
            begin
                finished <= 'b0;
            end
            
            valid_output <= 'b0;
            in_voxel_next <= 'b0;
            
            
            lc_max_value_fixed <= lc_max_value[31 : 0];
            lcconst_fixed <= {lc_const[13 : 0] , 18'h0};
            
            log_output_fixed <= ( buffer_comp[(buffer_comp_ptr)] < 19'h10) ? {14'h3FF5, 18'h0} : out_log_output_interm_fixed; //if relative_val_fixed < 1e-12 then log_output = -10
            log_output_capped_fixed <= (log_output_fixed[31] == 0)? 32'b0 : log_output_fixed; //if log_output > 0.0 log_output_capped = 0
            //real_out_fixed <= {14'd255, 18'b0}+fixed_mult32(log_output_capped_fixed, {14'h031, 18'h3854}); //real_out = 255+log_output_capped*49.220043
            //real_out_fixed_step_1 <= fixed_div32(gsmax_fixed, lcconst_fixed);
            
            real_out_fixed_step_2 <= fixed_mult32({14'h008, 18'h2BEAE}, log_output_capped_fixed);
            
            voxel_out_fixed <= (real_out_fixed[31] == 'b1)? 32'h0 : ((real_out_fixed > MAX_PIXEL_VALUE_fixed)? MAX_PIXEL_VALUE_fixed : real_out_fixed);
            
            mult_clock_1 <= gsmax_fixed+fixed_mult32(real_out_fixed_step_1, real_out_fixed_step_2) ; //real_out = GSMAX+GSMAX*8.686210641*log_output/LC_CONST
            real_out_fixed <= mult_clock_1;
            
            pipeline_content = pipeline_content >> 1;
            
            buffer_comp[(buffer_comp_ptr+37)%38] = relative_val_fixed;
            buffer_comp_ptr = (buffer_comp_ptr+1)%38;
            
            divider_int_active <= 'h1;
            divider_int_divisor_step1 <= lcconst_fixed[31 : 18]; //1cycle
            divider_int_active_step1 <= 'h1;
            divider_int_dividend_step1 <= gsmax_fixed[31: 18]; //1cycle
                        
            //divider_int_out_step1 is the output of a int14_divider, which is a bit clunky with the
            //fractional part
            real_out_fixed_step_1[31 : 18] <= (divider_int_out_step1[17] == 1) ? (divider_int_out_step1[31 : 18]-1) : divider_int_out_step1[31 : 18];
            real_out_fixed_step_1[17 : 1] <= divider_int_out_step1[16 : 0];
            real_out_fixed_step_1[0] <= 1'b0;
                         
            relative_val_fixed <= divider_int_out;
            
            // If started, move to the next voxel
            if (started == 'b1 && bram_read_counter == 'd10)
            begin
                in_voxel_addr <= pos_y_input * voxel_mem_width + pos_x_input;
                in_voxel_next <= 'b1;
                
                if (pos_x_input + 1 == voxel_mem_width)
                begin
                    pos_x_input <= pos_x_initial;
                    if (pos_y_input + 1 == voxel_mem_height)
                    begin
                        pos_y_input <= pos_y_initial;
                    end else begin
                        pos_y_input <= pos_y_input + 1;
                    end
                end else begin
                    pos_x_input <= pos_x_input + 1;
                end
            end
            
            if (started == 'b1 && bram_read_counter == 'd5)
            begin
                in_voxel_data_fixed <= in_voxel_data[31 : 0];
                pipeline_content[67] = 1'b1;
            end
            
            if (started == 'b1 && bram_read_counter >= 'd1)
            begin
               bram_read_counter <= bram_read_counter - 1;
            end
            
            if (started[0] == 'b1 && bram_read_counter == 'd0)
            begin
                bram_read_counter <= 'd10; //delay to get the data
            end
            
            if (started[0] == 'b1 && pipeline_content[0] == 'b1)
            begin: log_comp
                out_data <= {18'h0, voxel_out_fixed[31 : 18]};
                out_pos_x <= pos_x_output;
                out_pos_y <= pos_y_output;
                valid_output <= 'b1;
                
                if (pos_x_output + 1 == voxel_mem_width)
                begin
                    pos_x_output <= pos_x_initial;
                    if (pos_y_output + 1 == voxel_mem_height)
                    begin
                        pos_y_output <= pos_y_initial;
                        started <= 'b0;
                        finished <= 'b1;
                    end else begin
                        pos_y_output <= pos_y_output + 1;
                    end
                end else begin
                    pos_x_output <= pos_x_output + 1;
                end
            end
            // not started
            else
            begin
                valid_output <= 'b0;
            end
        end
        
        fixed32_to_float32 fixed32_to_float32_0(
            .aclk(clk),
            .s_axis_a_tvalid('b1),
            .s_axis_a_tready(),
            .s_axis_a_tdata(relative_val_fixed),
            .m_axis_result_tvalid(),
            .m_axis_result_tdata(out_relative_val_float)
        );
        
        float32_log float32_log_0(
            .aclk(clk),
            .s_axis_a_tvalid('b1),
            .s_axis_a_tready(),
            .s_axis_a_tdata(out_relative_val_float),
            .m_axis_result_tvalid(),
            .m_axis_result_tdata(out_log_output_float)
        );
        
        float32_to_fixed32 float32_to_fixed32_0(
            .aclk(clk),
            .s_axis_a_tvalid('b1),
            .s_axis_a_tready(),
            .s_axis_a_tdata(out_log_output_float),
            .m_axis_result_tvalid(),
            .m_axis_result_tdata(out_log_output_interm_fixed)
        );
        
        int_divider int_divider_0(
            .aclk(clk),
            .s_axis_divisor_tvalid(divider_int_active),
            .s_axis_divisor_tdata(lc_max_value_fixed),
            .s_axis_dividend_tvalid(divider_int_active),
            .s_axis_dividend_tdata(in_voxel_data_fixed),
            .m_axis_dout_tvalid(),
            .m_axis_dout_tdata(divider_int_out)
        );
        
        int14_divider int14_divider_0(
            .aclk(clk),
            .s_axis_divisor_tvalid(divider_int_active_step1),
            .s_axis_divisor_tdata({1'b0, divider_int_divisor_step1}),
            .s_axis_dividend_tvalid(divider_int_active_step1),
            .s_axis_dividend_tdata({1'b0, divider_int_dividend_step1}),
            .m_axis_dout_tvalid(),
            .m_axis_dout_tdata(divider_int_out_step1)
        );
        
endmodule
