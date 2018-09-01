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
// Create Date: 12/19/2016 10:15:19 AM
// Design Name: 
// Module Name: sc_identity
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


module sc_identity #
        (    
            parameter integer VOXEL_DATA_WIDTH = 32,
            parameter integer PIXEL_DATA_WIDTH = 8,
            parameter integer BRAM_ADDR_WIDTH = 16
        )
        (
            input wire  clk,
            // Global Reset Signal. This Signal is Active LOW
            input wire  resetn,
            
            input wire [VOXEL_DATA_WIDTH - 1 : 0] in_voxel_data,
            output reg [BRAM_ADDR_WIDTH - 1 : 0] in_voxel_addr,
            output reg in_voxel_next,
            
            output reg [PIXEL_DATA_WIDTH - 1 : 0] out_pixel,
            output reg [31 : 0] out_pos_x = 'b0,
            output reg [31 : 0] out_pos_y = 'b0,
            
            input wire start,
            output reg valid_data = 'b0,
            output reg finished = 'b0,
            input wire enable
        );
        
        integer pos_x = 0;
        integer pos_y = 0;
        
        // TODO what are these meant to do?
        localparam VOXEL_MEM_HEIGHT = 20;
        localparam VOXEL_MEM_WIDTH = 64;
        
        reg started = 'b0;
        reg [VOXEL_DATA_WIDTH-1 : 0] reg_voxel_in = 'b0;
        reg [7 : 0] bram_read_counter = 'b0;
        
        always @(posedge clk)
        begin
            if ( start == 'b1 )
            begin
                started <= 'b1;
                finished <= 'b0;
                pos_x <= 0;
                pos_y <= 0;
                bram_read_counter <= 'd5;
                reg_voxel_in <= 'b0;
            end
            
            valid_data <= 'b0;
            in_voxel_next <= 'b0;
            
            if(started == 'b1 && bram_read_counter == 'd5)
            begin
                in_voxel_addr <= pos_y * VOXEL_MEM_WIDTH + pos_x;
                in_voxel_next <= 'b1;
                //bram_read_counter = bram_read_counter - 1;
            end
            
            if(started == 'b1 && bram_read_counter >= 'd1)
            begin
               bram_read_counter <= bram_read_counter - 1;
            end
            
            if(started == 'b1 && bram_read_counter == 'd0)
            begin
                reg_voxel_in <= in_voxel_data;
            end
            
            if (started == 'b1 && enable == 'b1)
            begin
                
                bram_read_counter <= 'd5; //delay to get the data
                
                out_pixel <= reg_voxel_in;
                out_pos_x <= pos_x;
                out_pos_y <= pos_y;
                valid_data <= 'b1;
                
                if (pos_x + 1 == VOXEL_MEM_WIDTH)
                begin
                    pos_x <= 0;
                    if (pos_y == VOXEL_MEM_HEIGHT - 1)
                    begin
                        pos_y <= 0;
                        started <= 'b0;
                        finished <= 'b1;
                    end
                    else
                    begin
                        pos_y <= pos_y + 1;
                    end
                end
                else
                begin
                    pos_x <= pos_x + 1;
                end
            end
        end
        
endmodule
