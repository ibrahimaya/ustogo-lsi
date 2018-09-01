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
// Create Date: 04/24/2016 07:05:31 PM
// Design Name: 
// Module Name: adder_stage
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


module adder_stage #(
                        parameter INPUTS = 1024,
                        parameter INPUT_WIDTH = 21
                    )
                    (
                        input wire CLK,
                        input wire RSTN,
                        input wire VALID_IN,
                        output reg VALID_OUT,
                        input [INPUTS * INPUT_WIDTH - 1 : 0] DATA_IN,
                        output [INPUTS / 2 * (INPUT_WIDTH + 1) - 1 : 0] DATA_OUT
                    );    

    wire signed [INPUT_WIDTH - 1 : 0] inputs [INPUTS - 1 : 0];
    reg signed [INPUT_WIDTH : 0] outputs [INPUTS / 2 - 1 : 0];
    reg [INPUTS / 2 * (INPUT_WIDTH + 1) - 1 : 0] int_outputs;
    
    genvar j;
    generate
        for (j = 0; j < INPUTS / 2; j = j + 1)
        begin: gen_adder

            assign inputs[2 * j] = DATA_IN[INPUT_WIDTH * (2 * j + 1) - 1 : INPUT_WIDTH * 2 * j];
            assign inputs[2 * j + 1] = DATA_IN[INPUT_WIDTH * (2 * j + 2) - 1 : INPUT_WIDTH * (2 * j + 1)];
                             
            always @(posedge CLK or negedge RSTN)
            begin    
                if (RSTN == 1'b0)
                begin
                    outputs[j] <= 'h0;
                end
                else
                begin
                    outputs[j] <= inputs[2 * j] + inputs[2 * j + 1];
                end
            end
        end
    endgenerate
    
    always @(posedge CLK or negedge RSTN)
    begin    
        if (RSTN == 1'b0)
        begin
            VALID_OUT <= 1'b0;
        end
        else
        begin
            VALID_OUT <= VALID_IN;
        end
    end
    
    always @(*)
    begin: packing
        integer i, j;
        for (i = 0; i < INPUTS / 2; i = i + 1)
        begin
            for (j = 0; j < INPUT_WIDTH + 1; j = j + 1)
            begin
                int_outputs[(INPUT_WIDTH + 1) * i + j] = outputs[i][j];
            end
        end
    end
    
    assign DATA_OUT = int_outputs;

endmodule
