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
// Module Name: demodulator
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
`include "./parameters.v"

module demodulator #(
                        parameter FILTER_DEPTH = 5,
                        parameter DATA_WIDTH = 36,
                        parameter BRAMS_PER_NAPPE = 4,
                        // Decimal bits of the low-pass filter coefficients
                        parameter LP_PRECISION = 28
                    )
                    (
                        input wire CLK,
                        input wire RSTN,
                        input wire [`log2(FILTER_DEPTH) - 1 : 0] nappe_index,
                        input [(DATA_WIDTH * FILTER_DEPTH) - 1 : 0] mod_data, // Array of modulated data, in abs(), in 2's complement notation
                        input mod_data_valid,
                        input [9 : 0] voxel_pointer_in,
                        input [`log2(BRAMS_PER_NAPPE - 1) - 1 : 0] bram_pointer_in,
                        output reg [DATA_WIDTH - 1 : 0] demod_data,
                        output reg demod_data_valid,
                        output reg [9 : 0] voxel_pointer_out,
                        output reg [`log2(BRAMS_PER_NAPPE - 1) - 1 : 0] bram_pointer_out,
                        output [7 : 0] demodulator_latency
                    );
        
        wire signed [DATA_WIDTH - 1 : 0] filter_coeff [FILTER_DEPTH - 1 : 0];
        reg [(2 * DATA_WIDTH) - 1 : 0] sign_extended_filter_coeff [FILTER_DEPTH - 1 : 0];
        reg [DATA_WIDTH - 1 : 0] data_sample [FILTER_DEPTH - 1 : 0];
        reg [(2 * DATA_WIDTH) - 1 : 0] sign_extended_data_sample [FILTER_DEPTH - 1 : 0];
        reg [(2 * DATA_WIDTH) - 1 : 0] sign_extended_data_sample_sampled [FILTER_DEPTH - 1 : 0];
        reg [(4 * DATA_WIDTH) - 1 : 0] multip [FILTER_DEPTH - 1 : 0];
        reg [(4 * DATA_WIDTH) - 1 : 0] multip_sampled [FILTER_DEPTH - 1 : 0];
        reg [(4 * DATA_WIDTH) + FILTER_DEPTH - 1 : 0] demod_data_full;
        reg [9 : 0] delayed_voxel_pointer;
        reg [`log2(BRAMS_PER_NAPPE - 1) - 1 : 0] delayed_bram_pointer;
        reg delayed_valid;
        
        // Array of coefficients, in 2's complement notation                
        `include "./demod_coeffs.v"
        // This file populates the filter_coeff array
        
        // This wire tells the outside world how many cycles demodulation takes.
        // At the moment, we sample the inputs, then take one cycle to multiply, and provide the addition in the next cycle.
        // May increase with pipelining.
        assign demodulator_latency = 'h2;
        
        // Uses sign extension to perform 2's complement multiplication.
        // See e.g. http://pages.cs.wisc.edu/~smoler/cs354/beyond354/int.mult.html
        always @(*)
        begin: unroll_sign_extend
            integer i, bitloop;
            for (i = 0; i < FILTER_DEPTH; i = i + 1)
            begin: bititer
                for (bitloop = 0; bitloop < DATA_WIDTH; bitloop = bitloop + 1)
                    // At the beginning of the volume (for the first FILTER_DEPTH nappes)
                    // ensure that we use 0s as inputs into the low-pass filter, or we will
                    // accidentally use the last nappes of the previous volume instead
                    if (i < $unsigned(nappe_index))
                        data_sample[i][bitloop] = mod_data[i * DATA_WIDTH + bitloop];
                    else
                        data_sample[i][bitloop] = 'b0;
                sign_extended_filter_coeff[i] = {{DATA_WIDTH{filter_coeff[i][DATA_WIDTH - 1]}}, filter_coeff[i]};
                sign_extended_data_sample[i] = {{DATA_WIDTH{data_sample[i][DATA_WIDTH - 1]}}, data_sample[i]};
            end
        end

        always @(*)
        begin: multiply
            integer i;
            for (i = 0; i < FILTER_DEPTH; i = i + 1)
                multip[i] <= sign_extended_filter_coeff[i] * sign_extended_data_sample_sampled[i];
        end
        
        // Synchronous reset only, as this improves performance (can be merged with DSP registers, which have sync reset only)
        always @(posedge CLK)
        begin: sample_data
            integer i;
            if (RSTN == 1'b0)
            begin
                for (i = 0; i < FILTER_DEPTH; i = i + 1)
                begin
                    sign_extended_data_sample_sampled[i] <= 'h0;
                    multip_sampled[i] <= 'h0;
                end
                // These two pointers and flow control signal travel with the data, and they must be delayed by the same number of cycles.
                delayed_voxel_pointer <= 'h0;
                voxel_pointer_out <= 'h0;
                delayed_bram_pointer <= 'h0;
                bram_pointer_out <= 'h0;
                delayed_valid <= 1'b0;
                demod_data_valid <= 1'b0;
            end
            else
            begin
                for (i = 0; i < FILTER_DEPTH; i = i + 1)
                begin
                    sign_extended_data_sample_sampled[i] <= sign_extended_data_sample[i];
                    multip_sampled[i] <= multip[i][(2 * DATA_WIDTH) - 1 : 0];
                end
                delayed_voxel_pointer <= voxel_pointer_in;
                voxel_pointer_out <= delayed_voxel_pointer;
                delayed_bram_pointer <= bram_pointer_in;
                bram_pointer_out <= delayed_bram_pointer;
                delayed_valid <= mod_data_valid;
                demod_data_valid <= delayed_valid;
            end
        end

        always @(*)
        begin: demodulate_data
            integer i;
            // TODO we may need to pipeline this for speed
            demod_data_full = 'h0;
            for (i = 0; i < FILTER_DEPTH; i = i + 1)
                demod_data_full = demod_data_full + multip_sampled[i];
            // The multiplication by the coefficients of the filter adds lots of
            // decimal bits, scale back up to the FP precision of the rest of the datapath
            // TODO this creates lots of warnings
            demod_data = demod_data_full[LP_PRECISION + DATA_WIDTH - 1 : LP_PRECISION];
        end

endmodule
