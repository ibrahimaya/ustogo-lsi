// ***************************************************************************
// ***************************************************************************
//  Copyright (C) 2014-2018  EPFL
//  "BeamformerIP" custom IP
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
// Create Date: 07/27/2016 09:05:02 AM
// Design Name: 
// Module Name: absvalue
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

`include "./utilities.v"

module absvalue #(
                    parameter DATA_WIDTH = 36
                )
                (
                    input wire CLK,
                    input wire RSTN,
                    input [DATA_WIDTH - 1 : 0] data_in,
                    input data_in_valid,
                    output reg [DATA_WIDTH - 1 : 0] data_out,
                    output reg data_out_valid
                );
        
        always @(posedge CLK or negedge RSTN)
        begin: abs_value
            integer i;
            if (RSTN == 1'b0)
            begin
                data_out <= 'h0;
                data_out_valid <= 1'b0;
            end
            else
            begin
                // Negative number: bitwise invert then add 1
                if (data_in[DATA_WIDTH - 1])
                    data_out <= (~data_in) + 'h1;
                // Positive number: do nothing
                else
                    data_out <= data_in;
                data_out_valid <= data_in_valid;
            end
        end

endmodule
