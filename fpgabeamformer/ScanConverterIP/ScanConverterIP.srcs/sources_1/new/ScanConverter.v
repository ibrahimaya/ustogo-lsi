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
`include "./utilities.v"

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/15/2016 05:11:12 PM
// Design Name: 
// Module Name: ScanConverter
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


module ScanConverter #
        (
            // Parameters of Axi Slave Bus Interface S00_AXI
            parameter integer C_S_AXI_ID_WIDTH      = 1,
            parameter integer C_S_AXI_DATA_WIDTH    = 32,
            parameter integer C_S_AXI_ADDR_WIDTH    = 10,
            parameter integer C_S_AXI_AWUSER_WIDTH  = 0,
            parameter integer C_S_AXI_ARUSER_WIDTH  = 0,
            parameter integer C_S_AXI_WUSER_WIDTH   = 0,
            parameter integer C_S_AXI_RUSER_WIDTH   = 0,
            parameter integer C_S_AXI_BUSER_WIDTH   = 0,
            
            // Parameters of Axi Master Bus Interface M00_AXI
            parameter integer C_M_AXI_ID_WIDTH      = 1,
            parameter integer C_M_AXI_ADDR_WIDTH    = 32,
            parameter integer C_M_AXI_DATA_WIDTH    = 32,
            parameter integer C_M_AXI_AWUSER_WIDTH  = 0,
            parameter integer C_M_AXI_ARUSER_WIDTH  = 0,
            parameter integer C_M_AXI_WUSER_WIDTH   = 0,
            parameter integer C_M_AXI_RUSER_WIDTH   = 0,
            parameter integer C_M_AXI_BUSER_WIDTH   = 0,
            
            // Width of the data from the BF (32-bit fixed point 30.2)
            parameter integer VOXEL_DATA_WIDTH = 32,
            // Width of the SC outputs (8-bit greyscale)
            parameter integer PIXEL_DATA_WIDTH = 8,
            
            // Max supported BF image size. Controls the size
            // of a BRAM buffer.
            parameter integer MAX_SUPPORTED_BF_IMAGE_WIDTH = 64,
            parameter integer MAX_SUPPORTED_BF_IMAGE_HEIGHT = 600
        )
        (
            // Users to add ports here
            
            // User ports ends
            // Do not modify the ports beyond this line
            
            // Ports of Axi Slave Bus Interface S00_AXI
            // Global Clock Signal
            input wire  clk,
            // Global Reset Signal. This Signal is Active LOW
            input wire  resetn,
            
            input reg [C_S_AXI_DATA_WIDTH-1 : 0] wdata,
            input reg [C_S_AXI_ADDR_WIDTH-1 : 0] waddr,
            input wire wvalid,
            
            output reg [C_S_AXI_DATA_WIDTH-1 : 0] rdata,
            input wire [C_S_AXI_ADDR_WIDTH-1 : 0] raddr,
            input wire rvalid,
            
            output reg [C_M_AXI_ADDR_WIDTH-1 : 0] master_read_address,
            input wire [C_M_AXI_DATA_WIDTH-1 : 0] master_read_data,
            output reg master_read_start,
            input wire master_read_done,
            
            output reg [C_M_AXI_ADDR_WIDTH-1 : 0] master_write_address,
            output reg [C_M_AXI_DATA_WIDTH-1 : 0] master_write_data,
            output reg master_write_start,
            input wire master_write_done
            
        );
        
        localparam BRAM_ADDR_WIDTH = 16;
        localparam CUT_AZI_RAD = 2'b00;
        localparam CUT_ELE_AZI = 2'b01;
        localparam CUT_ELE_RAD = 2'b10;
        
        reg [C_S_AXI_DATA_WIDTH-1 : 0] reg_status;
        reg [1 : 0] reg_cut_direction;
        reg [C_S_AXI_DATA_WIDTH-1 : 0] reg_IO_mode;
        reg [C_S_AXI_DATA_WIDTH-1 : 0] reg_out_width;
        reg [C_S_AXI_DATA_WIDTH-1 : 0] reg_out_height;
        reg [C_S_AXI_DATA_WIDTH-1 : 0] reg_address_in;
        reg [C_S_AXI_DATA_WIDTH-1 : 0] reg_address_out;
        reg [C_S_AXI_DATA_WIDTH-1 : 0] reg_config_log_comp;
        reg [C_S_AXI_DATA_WIDTH-1 : 0] reg_lc_max;
        reg [C_S_AXI_DATA_WIDTH-1 : 0] reg_lcconst;
        
        // Limited to 10 bits (0 - 1023) to minimize resources
        reg [9 : 0] reg_in_azimuth, reg_in_elevation, reg_in_radial, reg_cut_value;
        reg [9 : 0] in_voxel_x_bound, in_voxel_y_bound;
        // Address in external memory where the BF left the voxels we need.
        // The address is calculated from "ddr_address_base" and then
        // "ddr_address_stride_short" is added for every next voxel. After
        // every "ddr_address_short_boundary", add a "ddr_address_stride_long"
        // (needed because the voxels can be distributed in memory in complicated ways)
        reg [C_S_AXI_DATA_WIDTH - 1 : 0] ddr_address_base, ddr_address_stride_short, ddr_address_stride_long;
        reg [9 : 0] ddr_address_short_boundary, ddr_address_stride_counter;
                
        // If Vivado complains that in_voxel_mem is too large, run
        //set_param synth.elaboration.rodinMoreOptions "rt::set_parameter var_size_limit 2000000"
        //reg [PIXEL_DATA_WIDTH - 1 : 0] out_pixel_mem [PIXEL_MEM_HEIGHT - 1 : 0][PIXEL_MEM_WIDTH - 1 : 0];
        
        reg [BRAM_ADDR_WIDTH - 1 : 0] bram_read_addr;
        reg [BRAM_ADDR_WIDTH - 1 : 0] bram_write_addr;
        reg [31 : 0] bram_data_in = 'b0;
        wire [31 : 0] bram_data_out;
        reg bram_write_enable;
                
        integer voxel_input_stream_coord_x = 0;
        integer voxel_input_stream_coord_y = 0;
        
        integer pixel_output_stream_coord_x = 0;
        integer pixel_output_stream_coord_y = 0;
        
        reg master_read_mode = 'b0;
        reg master_read_ptr_x = 'b0;
        reg master_read_ptr_y = 'b0;
                
        reg identity_start = 'b0;
        wire identity_finished;
        wire [7 : 0] identity_out_pixel;
        wire identity_valid_output;
        wire [31 : 0] identity_pos_x;
        wire [31 : 0] identity_pos_y;
        
        integer auto_lc_max_value = 0;
        reg [31 : 0] reg_input_lc_max_value;
        reg [C_S_AXI_DATA_WIDTH-1 : 0] out_pixel_buffer;
        reg activate_sc_proc = 'b0;
        reg ask_next_identity = 'b0;
        
        //i/o for the log compression sub module
        wire [VOXEL_DATA_WIDTH - 1 : 0] lc_out_data;
        wire [31 : 0] lc_out_pos_x;
        wire [31 : 0] lc_out_pos_y;
        wire lc_valid_output;
        reg [63 : 0] lc_start_vals; 
        wire lc_finished;
        reg lc_reset_signal = 'b0;
        
        wire [VOXEL_DATA_WIDTH - 1 : 0] lc_out_data_2;
        wire [31 : 0] lc_out_pos_x_2;
        wire [31 : 0] lc_out_pos_y_2;
        wire lc_valid_output_2;
        reg [63 : 0] lc_start_vals_2; 
        wire lc_finished_2;
        reg lc_reset_signal_2 = 'b0;
        
        //i/o signals for the scan converter sub-module
        wire [PIXEL_DATA_WIDTH-1 : 0] sc_proc_out_data;
        //wire [31 : 0] sc_proc_out_pos_x;
        //wire [31 : 0] sc_proc_out_pos_y;
        wire sc_proc_valid_output;
        reg [128 : 0] sc_proc_start_vals; 
        wire sc_proc_finished;
        
        wire [PIXEL_DATA_WIDTH-1 : 0] sc_proc_out_data_2;
        //wire [31 : 0] sc_proc_out_pos_x_2;
        //wire [31 : 0] sc_proc_out_pos_y_2;
        wire sc_proc_valid_output_2;
        reg [128 : 0] sc_proc_start_vals_2; 
        wire sc_proc_finished_2;
        
        reg [VOXEL_DATA_WIDTH - 1 : 0] identity_voxel_data;
        wire [BRAM_ADDR_WIDTH - 1 : 0] identity_voxel_address;
        wire identity_voxel_next;
        
        reg [VOXEL_DATA_WIDTH - 1 : 0] lc_voxel_data;
        wire [BRAM_ADDR_WIDTH - 1 : 0] lc_voxel_address;
        wire lc_voxel_next;
        
        reg [VOXEL_DATA_WIDTH - 1 : 0] sc_proc_voxel_data;
        wire [BRAM_ADDR_WIDTH - 1 : 0] sc_proc_voxel_address;
        wire sc_proc_voxel_next;
        
        reg master_reading = 'h0;
        reg [16 : 0] mst_read_voxel_counter_x;
        reg [16 : 0] mst_read_voxel_counter_y;
        reg master_writing = 'h0;
        reg [16 : 0] mst_write_voxel_counter;
        
        reg debug_valid_output = 'b0;
        
        always @(posedge clk)
        begin
            if (resetn == 1'b0)
            begin
                reg_status <= 'h0;
                reg_cut_direction <= CUT_AZI_RAD;
                reg_IO_mode <= 'b001; //default voxel by voxel feed
                reg_out_width <= 'h0;
                reg_out_height <= 'h0;
                reg_in_elevation <= 'h0;
                reg_in_azimuth <= 'h0;
                reg_in_radial <= 'h0;
                reg_address_in <= 'h0;
                reg_address_out <= 'h0;
                reg_lc_max <= 'h0;
                reg_lcconst <= 'h0;
                reg_config_log_comp <= 'h0;
                reg_cut_value <= 'h0;
                auto_lc_max_value <= 0;
                master_read_mode <= 'b0;
                master_read_ptr_x <= 'b0;
                master_read_ptr_y <= 'b0;
                master_read_address <= 'h0;
                activate_sc_proc <= 'b0;
                ask_next_identity <= 'b0;
                master_reading <= 'b0;
                mst_read_voxel_counter_x <= 'b0;
                mst_read_voxel_counter_y <= 'b0;
                master_writing <= 'b0;
                mst_write_voxel_counter <= 'b0;
                debug_valid_output <= 'b0;
                master_read_start <= 1'b0;
                master_write_start <= 1'b0;
                master_write_address <= 'h0;
                master_write_data <= 'h0;
                in_voxel_x_bound <= 'h0;
                in_voxel_y_bound <= 'h0;
                ddr_address_base <= 'h0;
                ddr_address_stride_short <= 'h0;
                ddr_address_stride_long <= 'h0;
                ddr_address_short_boundary <= 'h0;
                ddr_address_stride_counter <= 'h0;
                bram_read_addr <= 'h0;
                bram_write_addr <= 'h0;
            end
            else
            begin
                lc_start_vals <= 'b0;
                lc_start_vals_2 <= 'b0;
                sc_proc_start_vals <= 'b0;
                sc_proc_start_vals_2 <= 'b0;
                lc_reset_signal <= 'b0;
                lc_reset_signal_2 <= 'b0;
                identity_start <= 'b0;
                master_read_start <= 'b0;
                master_write_start <= 'b0;
                ask_next_identity <= 'b0;
                activate_sc_proc <= 'b0;
                bram_data_in <= 'b0;
                bram_write_enable <= 'b0;
            
                if (sc_proc_voxel_next == 'b1)
                    bram_read_addr <= sc_proc_voxel_address;
                else if (lc_voxel_next == 'b1)
                    bram_read_addr <= lc_voxel_address;
                else if (identity_voxel_next == 'b1)
                    bram_read_addr <= identity_voxel_address;
                
                identity_voxel_data <= bram_data_out;
                lc_voxel_data <= bram_data_out;
                sc_proc_voxel_data <= bram_data_out;
                
                //out_pixel_mem[identity_pos_y][identity_pos_x] <= identity_out_pixel;
                if (lc_valid_output == 'b1)
                begin
                    bram_write_addr <= lc_out_pos_y * in_voxel_x_bound + lc_out_pos_x;
                    bram_data_in <= lc_out_data;
                    bram_write_enable <= 'b1;
                end
                /*if(lc_valid_output_2 == 'b1)
                begin
                    in_voxel_mem[lc_out_pos_y_2][lc_out_pos_x_2] = lc_out_data_2;
                end*/
                
                case (reg_cut_direction)
                    // In 2D, CUT_AZI_RAD is the only meaningful choice
                    CUT_AZI_RAD:
                    begin
                        in_voxel_x_bound <= reg_in_azimuth;
                        in_voxel_y_bound <= reg_in_radial;
                        // Starts after "reg_cut_value" words of elevation
                        // (In 2D, reg_cut_value == 0 so it just starts at the given DDR address)
                        ddr_address_base <= reg_address_in + reg_cut_value * 'h4;
                        // Shifts by "reg_in_elevation" words for every new voxel
                        // (In 2D, reg_in_elevation == 1 so it just moves to the next voxel/word)
                        // After "reg_in_azimuth" voxels, go up by a long stride, which happens to
                        // be the same amount again
                        ddr_address_stride_short <= reg_in_elevation * 'h4;
                        ddr_address_short_boundary <= reg_in_azimuth;
                        ddr_address_stride_long <= reg_in_elevation * 'h4;
                    end
                    CUT_ELE_AZI:
                    // TODO it would be nicer to have azimuth on the X axis and elevation on the Y axis,
                    // but that requires a little recoding due to the ordering of the BF voxels
                    begin
                        in_voxel_x_bound <= reg_in_elevation;
                        in_voxel_y_bound <= reg_in_azimuth;
                        // Starts after "reg_cut_value" nappes
                        ddr_address_base <= reg_address_in + reg_cut_value * reg_in_elevation * reg_in_azimuth * 'h4;
                        // Up by one word at a time in the elevation direction.
                        // After "reg_in_elevation" voxels, go up by one word
                        // because the next azimuth line is just adjacent
                        ddr_address_stride_short <= 'h4;
                        ddr_address_short_boundary <= reg_in_elevation;
                        ddr_address_stride_long <= 'h4;
                    end
                    CUT_ELE_RAD:
                    begin
                        in_voxel_x_bound <= reg_in_elevation;
                        in_voxel_y_bound <= reg_in_radial;
                        // Starts after "reg_cut_value" azimuth lines
                        ddr_address_base <= reg_address_in + reg_cut_value * reg_in_elevation * 'h4;
                        // Up by one word at a time in the elevation direction.
                        // After "reg_in_elevation" voxels, go up by a long
                        // stride, which is in the next nappe
                        ddr_address_stride_short <= 'h4;
                        ddr_address_short_boundary <= reg_in_elevation;
                        ddr_address_stride_long <= (reg_in_azimuth - 1) * reg_in_elevation * 'h4 + 'h4;
                    end
                default:
                    begin
                        in_voxel_x_bound <= 'h0;
                        in_voxel_y_bound <= 'h0;
                        ddr_address_base <= 'h0;
                        ddr_address_stride_short <= 'h0;
                        ddr_address_short_boundary <= 'h0;
                        ddr_address_stride_long <= 'h0;
                    end
                endcase
                
                if (master_reading == 1'b1)
                begin
                    master_read_start <= 1'b0;
                    if (bram_write_enable == 'b1)
                        bram_write_addr <= bram_write_addr + 'h1;

                    // A read was just completed
                    if (master_read_done == 'b1)
                    begin
                        // End of the reading
                        if (mst_read_voxel_counter_x + 1 == in_voxel_x_bound && mst_read_voxel_counter_y + 1 == in_voxel_y_bound)
                        begin
                            master_reading <= 'b0;
                            ddr_address_stride_counter <= 'h0;

                            // Define the intput for the log comp depending on the config bit
                            if (reg_config_log_comp[0] == 1'b1)
                                // Fixed lc_max_value as defined in register
                                reg_input_lc_max_value <= reg_lc_max;
                            else
                                // Auto max value
                                reg_input_lc_max_value <= auto_lc_max_value;
                                
                            lc_start_vals <= {15'h0, 15'h0, 5'h0, in_voxel_y_bound, 5'h0, in_voxel_x_bound, 1'b1}; //y, x, maxy, maxx, start
                            //lc_start_vals_2 <= {15'b0, 15'(reg_in_azimuth[14:0]/2), reg_in_radial[14 : 0], reg_in_azimuth[14:0], 1'b1}; //y, x, maxy, maxx, start
                            reg_status[1 : 0] <= 2'b01;
                            reg_status[3] <= 1'b1;
                            reg_status[4] <= 1'b0;
                            bram_write_enable <= 1'b0;
                        end
                        // Not done yet, read the next BF voxel
                        else
                        begin
                            if (ddr_address_stride_counter + 1 < ddr_address_short_boundary)
                            begin
                                ddr_address_stride_counter <= ddr_address_stride_counter + 1;
                                master_read_address <= master_read_address + ddr_address_stride_short;
                            end
                            else
                            begin
                                ddr_address_stride_counter <= 'h0;
                                master_read_address <= master_read_address + ddr_address_stride_long;
                            end
                            master_read_start <= 'b1;
                            if (mst_read_voxel_counter_x + 1 == in_voxel_x_bound)
                            begin
                                mst_read_voxel_counter_x <= 0;
                                if (mst_read_voxel_counter_y + 1 == in_voxel_y_bound)
                                    mst_read_voxel_counter_y <= 0;
                                else
                                    mst_read_voxel_counter_y <= mst_read_voxel_counter_y + 1;
                            end
                            else
                            begin
                                mst_read_voxel_counter_x <= mst_read_voxel_counter_x + 1;
                            end
                        
                            // Keep largest value for the log conversion
                            if ($signed(auto_lc_max_value) < $signed(master_read_data))
                                auto_lc_max_value <= master_read_data;
                            bram_data_in <= ($signed(master_read_data) < 0) ? 'h0 : master_read_data;
                            bram_write_enable <= 'b1;
                        end
                    end
                end
            
                if (master_writing == 'b1)
                begin
                    if (sc_proc_valid_output == 'b1) //pixel finished
                    begin
                        debug_valid_output <= 'b1;
                        master_write_data <= {8'h0, sc_proc_out_data[7 : 0], sc_proc_out_data[7 : 0], sc_proc_out_data[7 : 0]};
                        master_write_address <= master_write_address + 'h4;
                        master_write_start <= 'b1;
                    end
                
                    if (master_write_done == 'b1)
                    begin
                        activate_sc_proc <= 'b1;
                    end                
                end // master_writing == 'b1
            
                if (lc_finished == 'b1 /*& lc_finished_2 == 'b1*/)
                begin
                    //img height, img width, voxel height, voxel width, y, x, maxy(sub), maxx(sub), start
                    sc_proc_start_vals <= {reg_out_height[14:0], reg_out_width[14:0], 5'h0, in_voxel_y_bound, 5'h0, in_voxel_x_bound, 15'b0, 15'b0, reg_out_height[14:0], reg_out_width[14:0], 1'b1};
                    //sc_proc_start_vals_2 <= {reg_out_height[14:0], reg_out_width[14:0], reg_in_radial[14:0], reg_in_azimuth[14:0], 15'b0, 15'(reg_out_width[14:0]/2), reg_out_height[14:0], reg_out_width[14:0], 1'b1};
                
                    if (reg_IO_mode[2] == 'b0)
                    begin
                        master_writing <= 1'b1;
                        mst_write_voxel_counter <= 'b0;
                        master_write_address <= reg_address_out - 'd4; //we will increase address at each write so first one will be addr-4+4
                        activate_sc_proc <= 'b1;
                    end
                    activate_sc_proc <= 'b1;
                
                    lc_reset_signal <= 'b1;
                    lc_reset_signal_2 <= 'b1;
                    reg_status[3] <= 1'b0;
                end
            
                if (sc_proc_valid_output == 'b1)
                begin
                    if (reg_IO_mode[2] == 1'b0)
                    begin
                        //out_pixel_mem[sc_proc_out_pos_y][sc_proc_out_pos_x] <= sc_proc_out_data;
                    end
                    else
                    begin
                        reg_status[2] <= 1'b1;
                        out_pixel_buffer <= sc_proc_out_data;
                    end
                end
            
                // if (sc_proc_valid_output_2 == 'b1) begin out_pixel_mem[sc_proc_out_pos_y_2][sc_proc_out_pos_x_2] <= sc_proc_out_data_2; end
            
                if (identity_valid_output == 'b1)
                begin
                    if (reg_IO_mode[2] == 1'b0)
                    begin
                        //out_pixel_mem[identity_pos_y][identity_pos_x] <= identity_out_pixel;
                    end
                    else
                    begin
                        reg_status[2] <= 1'b1;
                        out_pixel_buffer <= identity_out_pixel;
                    end
                end
            
                if (sc_proc_finished == 'b1 /*& sc_proc_finished_2 == 'b1*/)
                begin
                    reg_status[1 : 0] <= 2'b10 ; //put bit 0 at 0 and bit 1 at 1
                    reg_status[7] <= 'b1; // finished
                    master_writing <= 'b0;
                end
            
                if (identity_finished == 'b1)
                begin
                    reg_status[1 : 0] <= 2'b10 ; //put bit 0 at 0 and bit 1 at 1
                end
            
                /////////////////WE ARE WRITING TO THE SCAN CONV
                if (wvalid == 1'b1)
                begin
                    case (waddr)
                        10'h08 : reg_cut_direction <= wdata[1 : 0];
                        10'h0C : reg_IO_mode <= wdata;
                        10'h18 : reg_out_width <= wdata;
                        10'h1C : reg_out_height <= wdata;
                        10'h20 : reg_in_elevation <= wdata[9 : 0];
                        10'h24 : reg_in_azimuth <= wdata[9 : 0];
                        10'h28 : reg_in_radial <= wdata[9 : 0];
                        10'h34 : reg_address_in <= wdata;
                        10'h38 : reg_address_out <= wdata;
                        10'h40 : reg_config_log_comp <= wdata;
                        10'h44 : reg_lc_max <= wdata;
                        10'h48 : reg_lcconst <= wdata;
                        10'h4C : reg_cut_value <= wdata[9 : 0];
                    endcase
                
                    if (waddr == 10'h04) //the start bit field
                    begin
                        if (wdata[0] == 1'b1) //reset input pointer (for voxel-by-voxel input by the cpu)
                        begin
                            voxel_input_stream_coord_x <= 0;
                            voxel_input_stream_coord_y <= 0;
                        end 
                        if (wdata[1] == 'b1 ) //reset output pointer
                        begin
                            pixel_output_stream_coord_x <= 0;
                            pixel_output_stream_coord_y <= 0;
                        end
                        if (wdata[2] == 1'b1) //start the SC
                        begin
                            lc_start_vals <= {15'b0, 15'b0, 5'h0, reg_in_radial, 5'h0, reg_in_azimuth, 1'b1}; //y, x, maxy, maxx, start
                            //lc_start_vals_2 <= {15'b0, 15'(reg_in_azimuth[14:0]/2), reg_in_radial[14 : 0], reg_in_azimuth[14:0], 1'b1}; //y, x, maxy, maxx, start
                            reg_status[1 : 0] <= 'b01;
                            reg_status[3] <= 1'b1;
                        end
                        if (wdata[3] == 1'b1) //start the identity
                        begin
                            identity_start <= 'b1;
                            reg_status[1 : 0] <= 'b01;
                        end
                        if (wdata[4] == 1'b1) // start master reading + sc
                        begin
                            master_reading <= 1'b1;
                            mst_read_voxel_counter_x <= 'h0;
                            mst_read_voxel_counter_y <= 'h0;
                            master_read_address <= ddr_address_base;
                            master_read_start <= 1'b1;
                            bram_read_addr <= 'h0;
                            bram_write_addr <= 'h0;
                            reg_status[7] <= 1'b0;
                            reg_status[4] <= 1'b1;
                        end
                        if (wdata[5] == 1'b1)
                        begin
                            auto_lc_max_value <= 0;
                        end
                        
                        //define the intput for the log comp depending on the config bit
                        if(reg_config_log_comp[0] == 1'b1)
                        begin //fixed lc_max_value as defined in register
                            reg_input_lc_max_value <= reg_lc_max;
                        end
                        else
                        begin //auto max value
                            reg_input_lc_max_value <= auto_lc_max_value;
                        end
                    end
                    // Saves the voxels in a streaming way. The first voxel will be saved
                    // at nappe 0, voxel 0; subsequent voxels will automatically increment this value
                    if (waddr == 10'h10 /*&& reg_IO_mode[0] == 'b1*/) //a voxel is arriving
                    begin
                        // TODO so long as the initialization is fine, a +1 here should be enough 
                        bram_write_addr <= voxel_input_stream_coord_y * in_voxel_x_bound + voxel_input_stream_coord_x;
                        bram_data_in <= ($signed(wdata) < 0) ? 'h0 : wdata; // Ensure no negatives
                        bram_write_enable <= 'b1;
                    
                        //keep largest value for the log conversion
                        if($signed(auto_lc_max_value) < $signed(wdata))
                            auto_lc_max_value <= wdata;
                    
                        if (voxel_input_stream_coord_x + 1 == reg_in_azimuth)
                        begin
                            voxel_input_stream_coord_x <= 0;
                            if (voxel_input_stream_coord_y + 1 == reg_in_radial)
                            begin
                                voxel_input_stream_coord_y <= 0;
                            end else begin
                                voxel_input_stream_coord_y <= voxel_input_stream_coord_y + 1;
                            end
                        end else begin
                            voxel_input_stream_coord_x <= voxel_input_stream_coord_x + 1;
                        end
                    end
                
                    if (waddr == 'h3c)
                    begin
                        if (wdata[0] == 1'b1)
                        begin
                            ask_next_identity <= 'b0;
                            activate_sc_proc <= 'b1;
                        end
                        else if (wdata[1] == 1'b1)
                        begin
                            ask_next_identity <= 'b1;
                            activate_sc_proc <= 'b0;
                        end
                        reg_status[2] <= 1'b0;
                    end
                end //end read
            
                ////////////////////READING///////////////////
                if (rvalid == 1'b1)
                begin
                    case (raddr)
                        10'h00 : rdata <= reg_status;
                        10'h08 : rdata <= {{(C_S_AXI_DATA_WIDTH - 2){1'b0}}, reg_cut_direction};
                        10'h0C : rdata <= reg_IO_mode;
                        10'h18 : rdata <= reg_out_width;
                        10'h1C : rdata <= reg_out_height;
                        10'h20 : rdata <= {{(C_S_AXI_DATA_WIDTH - 10){1'b0}}, reg_in_elevation};
                        10'h24 : rdata <= {{(C_S_AXI_DATA_WIDTH - 10){1'b0}}, reg_in_azimuth};
                        10'h28 : rdata <= {{(C_S_AXI_DATA_WIDTH - 10){1'b0}}, reg_in_radial};
                        10'h30 : rdata <= 'hcafe145;
                        10'h34 : rdata <= reg_address_in;
                        10'h38 : rdata <= reg_address_out;
                        10'h40 : rdata <= reg_config_log_comp;
                        10'h44 : rdata <= reg_lc_max;
                        10'h48 : rdata <= reg_lcconst;
                        10'h4C : rdata <= {{(C_S_AXI_DATA_WIDTH - 10){1'b0}}, reg_cut_value};
                        //debug output
                        10'hA0 : rdata <= mst_read_voxel_counter_x;
                        10'hB0 : rdata <= master_write_address;
                        10'hB4 : rdata <= master_writing;
                        10'hBC : rdata <= debug_valid_output;
                        default : rdata <= 'hdeadbeef; //deadbeef means illegal read
                    endcase
                
                    if (raddr == 10'h14) //reading pixel
                    begin
                        if (reg_IO_mode[2] == 'b0)
                        begin
                            //rdata <= out_pixel_mem [pixel_output_stream_coord_y] [pixel_output_stream_coord_x];
                        end
                        else
                        begin
                            rdata <= out_pixel_buffer;
                        end
                    
                        if (pixel_output_stream_coord_x + 1 == reg_out_width)
                        begin
                            pixel_output_stream_coord_x <= 0;
                            if (pixel_output_stream_coord_y+1 == reg_out_height)
                            begin
                                pixel_output_stream_coord_y <= 0;
                            end else begin
                                pixel_output_stream_coord_y <= pixel_output_stream_coord_y + 1;
                            end
                        end else begin
                            pixel_output_stream_coord_x <= pixel_output_stream_coord_x + 1;
                        end
                    end
                end
            end //end read
        end //end clock
        
        sc_log_compression #( 
            .VOXEL_DATA_WIDTH(VOXEL_DATA_WIDTH),
            .BRAM_ADDR_WIDTH(BRAM_ADDR_WIDTH)
        ) log_comp (
            .clk(clk),
            .resetn(resetn),
            .out_data(lc_out_data),
            .lc_max_value(reg_input_lc_max_value),
            .lc_const(reg_lcconst),
            .out_pos_x(lc_out_pos_x),
            .out_pos_y(lc_out_pos_y),
            .valid_output(lc_valid_output),
            .start_values(lc_start_vals),
            .finished(lc_finished),
            .reset_finished_signal(lc_reset_signal),
            .in_voxel_data(lc_voxel_data),
            .in_voxel_addr(lc_voxel_address),
            .in_voxel_next(lc_voxel_next)
        );
        
        /*sc_log_compression # ( 
            .VOXEL_DATA_WIDTH(VOXEL_DATA_WIDTH),
            .BRAM_ADDR_WIDTH(BRAM_ADDR_WIDTH)
        ) log_comp_2 (
            .clk(clk),
            .resetn(resetn),
            .out_data(lc_out_data_2),
            .lc_max_value(auto_lc_max_value),
            .out_pos_x(lc_out_pos_x_2),
            .out_pos_y(lc_out_pos_y_2),
            .valid_output(lc_valid_output_2),
            .start_values(lc_start_vals_2),
            .finished(lc_finished_2),
            .reset_finished_signal(lc_reset_signal_2)
        );*/
        
        sc_processing # (
            .VOXEL_DATA_WIDTH(VOXEL_DATA_WIDTH),
            .PIXEL_DATA_WIDTH(PIXEL_DATA_WIDTH),
            .BRAM_ADDR_WIDTH(BRAM_ADDR_WIDTH)
        ) sc_proc (
            .clk(clk),
            .resetn(resetn),
            .out_data(sc_proc_out_data),
            //.out_pos_x(sc_proc_out_pos_x),
            //.out_pos_y(sc_proc_out_pos_y),
            .valid_output(sc_proc_valid_output),
            .start_values(sc_proc_start_vals),
            .finished(sc_proc_finished),
            .enabled(activate_sc_proc),
            .in_voxel_data(sc_proc_voxel_data),
            .in_voxel_addr(sc_proc_voxel_address),
            .in_voxel_next(sc_proc_voxel_next)
        );
        
        /*sc_processing # (
            .VOXEL_DATA_WIDTH(VOXEL_DATA_WIDTH),
            .PIXEL_DATA_WIDTH(PIXEL_DATA_WIDTH),
            .BRAM_ADDR_WIDTH(BRAM_ADDR_WIDTH)
        ) sc_proc_2 (
            .clk(clk),
            .resetn(resetn),
            .out_data(sc_proc_out_data_2),
            .out_pos_x(sc_proc_out_pos_x_2),
            .out_pos_y(sc_proc_out_pos_y_2),
            .valid_output(sc_proc_valid_output_2),
            .start_values(sc_proc_start_vals_2),
            .finished(sc_proc_finished_2)
        );*/
        
        sc_identity # ( 
            .VOXEL_DATA_WIDTH(VOXEL_DATA_WIDTH),
            .PIXEL_DATA_WIDTH(PIXEL_DATA_WIDTH),
            .BRAM_ADDR_WIDTH(BRAM_ADDR_WIDTH)
        ) identity_op (
            .clk(clk),
            .resetn(resetn),
            .out_pixel(identity_out_pixel),
            .out_pos_x(identity_pos_x),
            .out_pos_y(identity_pos_y),
            .start(identity_start),
            .valid_data(identity_valid_output),
            .finished(identity_finished),
            .enable(ask_next_identity),
            .in_voxel_data(identity_voxel_data),
            .in_voxel_addr(identity_voxel_address),
            .in_voxel_next(identity_voxel_next)
        );
        
        // TODO now that a DP BRAM is instantiated, can optimize performance
        // by parallelizing read and write accesses
        dp_bram #(.RAM_WIDTH(32),
                  // Sized to contain the max-sized BF image slice.
                  // At the last line, due to interpolation, the SC
                  // also needs the voxel "down and right" so need
                  // that extra margin.
                  .RAM_DEPTH(MAX_SUPPORTED_BF_IMAGE_WIDTH * (MAX_SUPPORTED_BF_IMAGE_HEIGHT + 1) + 1),
                  .RAM_PERFORMANCE("HIGH_PERFORMANCE"),
                  .INIT_FILE("")
                 )
                 bram_voxel_mem_0(.addra(bram_write_addr),
                                  .addrb(bram_read_addr),
                                  .dina(bram_data_in),
                                  .dinb('h0),
                                  .clka(clk),
                                  .wea(bram_write_enable),
                                  .web(1'b0),
                                  .ena(1'b1),
                                  .enb(1'b1),
                                  .rsta(resetn),
                                  .rstb(resetn),
                                  .regcea(1'b1),
                                  .regceb(1'b1),
                                  .douta(),
                                  .doutb(bram_data_out)
                                 );

endmodule
