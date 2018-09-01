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
// Create Date: 07/26/2016 12:08:25 PM
// Design Name: 
// Module Name: nappe_buffer
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

// Architecture:
//
//    pre-demodulation buffer    -> demodulator ->     post_demodulation buffer
// (depth: FILTER_DEPTH nappes)                    (depth: NAPPE_BUFFER_DEPTH nappes)

module nappe_buffer #(
                        // How many beamformed/unfiltered nappes to store, to filter them
                        parameter FILTER_DEPTH = 5,
                        // How many beamformed/filtered nappes to store, for performance
                        parameter NAPPE_BUFFER_DEPTH = 3,
                        parameter ELEVATION_LINES = 64,
                        parameter AZIMUTH_LINES = 64,
                        parameter RADIAL_LINES = 600,
                        parameter LP_PRECISION = 28
                    )
                    (
                        input wire CLK,
                        input wire RSTN,
                        input wire [35 : 0] DIN,
                        input wire DIN_VALID,
                        output [31 : 0] DOUT,
                        output wire DOUT_VALID,
                        input wire DOUT_READY,
                        // Note that this wire is not a cycle-by-cycle flow control
                        // but rather a nappe-by-nappe stall signal
                        output reg stall_beamformer,
                        input wire [`log2(RADIAL_LINES - 1) - 1 : 0] nappe_index,
                        input wire compound_not_zone_imaging,
                        input wire [3 : 0] azimuth_zones,
                        input wire [3 : 0] elevation_zones,
                        input wire end_of_nappe,
                        output reg [15 : 0] fifo_ready_voxels,
                        output reg [35 : 0] max_value
                    );
    // Always generate the maximum number of BRAMs we would need to hold a maximum-size nappe (i.e. zone imaging disabled)
    // In the case of a 64x64-voxel nappe, we need 4 BRAMs to hold all of the voxels per nappe
    localparam MAX_VOXELS_PER_NAPPE = ELEVATION_LINES * AZIMUTH_LINES;
    // Since "/" unfortunately rounds down, the following is equivalent of: ceiling(VOXELS_PER_NAPPE / 1024)
    localparam MAX_BRAMS_PER_NAPPE = (MAX_VOXELS_PER_NAPPE + 1023) / 1024;
    
    // Pointers for the pre-demodulation nappe buffer
    // TODO these signals can become [-1 : 0]
    reg [`log2(FILTER_DEPTH - 1) - 1 : 0] pre_nappe_pointer;
    reg [`log2(MAX_BRAMS_PER_NAPPE - 1) - 1 : 0] pre_bram_store_pointer;
    reg [`log2(MAX_BRAMS_PER_NAPPE - 1) - 1 : 0] pre_bram_fetch_pointer;
    reg [`log2(MAX_BRAMS_PER_NAPPE - 1) - 1 : 0] delayed_pre_bram_fetch_pointer;
    reg [9 : 0] pre_voxel_store_pointer;
    reg [9 : 0] pre_voxel_fetch_pointer;
    reg [9 : 0] delayed_pre_voxel_fetch_pointer;
    wire [`log2(MAX_BRAMS_PER_NAPPE) - 1 : 0] brams_per_nappe;
    wire [9 : 0] leftover_voxels;         // How many voxels in the last BRAM of the nappe (may be non-full)
    wire pre_buffer_empty;
    wire pre_buffer_full;
    reg [`log2(FILTER_DEPTH - 1) - 1 : 0] sample_order_pointer [FILTER_DEPTH - 1 : 0];
    reg [`log2(FILTER_DEPTH - 1) - 1 : 0] delayed_sample_order_pointer [FILTER_DEPTH - 1 : 0];
    reg [`log2(FILTER_DEPTH - 1) - 1 : 0] delayed_delayed_sample_order_pointer [FILTER_DEPTH - 1 : 0];

    // Pointers for the post-demodulation nappe buffer
    reg [`log2(NAPPE_BUFFER_DEPTH - 1) - 1 : 0] post_nappe_store_pointer;
    reg [`log2(NAPPE_BUFFER_DEPTH - 1) - 1 : 0] post_nappe_fetch_pointer_prev;
    reg [`log2(NAPPE_BUFFER_DEPTH - 1) - 1 : 0] post_nappe_fetch_pointer_next;
    wire [`log2(NAPPE_BUFFER_DEPTH - 1) - 1 : 0] post_nappe_fetch_pointer;
    reg [`log2(NAPPE_BUFFER_DEPTH - 1) - 1 : 0] post_nappe_fetch_pointer_delayed;
    
    wire [`log2(MAX_BRAMS_PER_NAPPE - 1) - 1 : 0] post_bram_store_pointer;
    reg [`log2(MAX_BRAMS_PER_NAPPE - 1) - 1 : 0] post_bram_fetch_pointer_prev;
    reg [`log2(MAX_BRAMS_PER_NAPPE - 1) - 1 : 0] post_bram_fetch_pointer_next;
    wire [`log2(MAX_BRAMS_PER_NAPPE - 1) - 1 : 0] post_bram_fetch_pointer;
    reg [`log2(MAX_BRAMS_PER_NAPPE - 1) - 1 : 0] post_bram_fetch_pointer_delayed;
    
    wire [9 : 0] post_voxel_store_pointer;
    reg [9 : 0] post_voxel_fetch_pointer_prev;
    reg [9 : 0] post_voxel_fetch_pointer_next;
    wire [9 : 0] post_voxel_fetch_pointer;

    wire post_buffer_empty;
    reg post_buffer_empty_delayed;
    wire [35 : 0] output_voxels [NAPPE_BUFFER_DEPTH - 1 : 0][MAX_BRAMS_PER_NAPPE - 1 : 0];
    
    // Communication wires around the demodulator
    reg DIN_VALID_delayed, mod_data_valid;
    wire demod_data_valid;
    wire [35 : 0] bf_voxels [FILTER_DEPTH - 1 : 0][MAX_BRAMS_PER_NAPPE - 1 : 0];
    wire [35 : 0] mod_data [FILTER_DEPTH - 1 : 0];
    reg [(FILTER_DEPTH * 36) - 1 : 0] reshuffled_mod_data;
    wire [35 : 0] demod_data;
    wire [7 : 0] demodulator_latency;
    reg [`log2(FILTER_DEPTH) - 1 : 0] nappe_index_trimmed;

    // Designates the needed number of BRAMs per nappe based on if we are zone imaging or compounding and the number of voxels per nappe
    // TODO only power-of-2 zones supported.
    assign brams_per_nappe = (compound_not_zone_imaging == 1) ? MAX_BRAMS_PER_NAPPE  // Compounding
                                                              : `max(1, MAX_BRAMS_PER_NAPPE >> (`log2(azimuth_zones - 1) + `log2(elevation_zones - 1)));  // NxN zone imaging
    // Designates how many leftover voxels will be in the last BRAM
    // ex. If we are storing 16 * 16 = 256 voxels per nappe, there will be 256 voxels in the last BRAM, not a complete 1024 voxel
    assign leftover_voxels = (ELEVATION_LINES * AZIMUTH_LINES >> (`log2(azimuth_zones - 1) + `log2(elevation_zones - 1))) % 1024;

    // Instantiate the pre-demodulation nappe buffer
    // These BRAMS contain the last FILTER_DEPTH nappes that will be demodulated through a 
    // FILTER_DEPTH FIR filter. To demodulate voxel 0,0 of nappe 6 for example, run 
    // voxels 0,0 of nappes [6 : 6 - FILTER_DEPTH + 1] through the FIR demodulator
    // For a 64x64 voxel nappe, we need FILTER_DEPTH * 4 BRAMS to hold all voxels
    genvar i, j;
    generate
        // As many levels as the depth of the nappe buffer
        for (i = 0; i < FILTER_DEPTH; i = i + 1)
        begin: gen_pre_buffer
            // For each nappe, possibly more than one BRAM
            for (j = 0; j < MAX_BRAMS_PER_NAPPE; j = j + 1)
            begin: gen_pre_nappe_chunks
                // Xilinx True Dual Port RAM, Write First with Single Clock
                dpbram #(.RAM_WIDTH(36),
                         .RAM_DEPTH(1024),
                         .RAM_PERFORMANCE("HIGH_PERFORMANCE"),
                         .INIT_FILE("")
                       )
                       pre_bram(.addra(pre_voxel_store_pointer),
                                .addrb('h0),
                                .dina(DIN),
                                .dinb('h0),
                                .clka(CLK),
                                .wea(DIN_VALID == 1'b1 && pre_nappe_pointer == i && pre_bram_store_pointer == j), // Pointers decide which depth of the filter we are on, 
                                .web(1'b0),                                                                       // and which BRAM we are writing to for that depth
                                .ena(1'b1),
                                .enb(1'b0),
                                .rsta(RSTN),
                                .rstb(RSTN),
                                .regcea(1'b1),
                                .regceb(1'b0),
                                .douta(bf_voxels[i][j]),
                                .doutb()
                               );
            end
            // Note: delayed_pre_bram_fetch_pointer instead of pre_bram_store_pointer, as
            // we need this signal to flip two cycles later than the BRAM read addresses
            assign mod_data[i] = bf_voxels[i][delayed_pre_bram_fetch_pointer];
        end
    endgenerate
    
    // Manage the pointers of the pre-demodulation nappe buffer
    always @(posedge CLK or negedge RSTN)
    begin: pre_demodulation_pointers
        integer i;
        if (RSTN == 1'b0)
        begin
            pre_nappe_pointer <= 'h0;
            pre_bram_store_pointer <= 'h0;
            pre_voxel_store_pointer <= 'h0;
            // Initialize the ring pointers as follows (0 to FILTER_DEPTH - 1 == newest to oldest):
            // e.g. FILTER_DEPTH = 4: 0 3 2 1
            // e.g. FILTER_DEPTH = 6: 0 5 4 3 2 1            
            for (i = 0; i < FILTER_DEPTH; i = i + 1)
            begin
                sample_order_pointer[FILTER_DEPTH - 1 - i] <= (i + 1) % FILTER_DEPTH;
                delayed_sample_order_pointer[i] <= 'h0;
                delayed_delayed_sample_order_pointer[i] <= 'h0;
            end
        end
        else
        begin
            if (DIN_VALID == 1'b1)
            begin
                // If we have reached the end of the current BRAM or the end of
                // the partial use of the BRAM designated by leftover_voxels, move to the next
                if (pre_voxel_store_pointer == 1023 || (leftover_voxels != 0 && pre_voxel_store_pointer == leftover_voxels - 1))
                begin
                    if (pre_bram_store_pointer < brams_per_nappe - 1)
                        pre_bram_store_pointer <= post_bram_store_pointer + 'h1;
                    else
                    begin
                        pre_bram_store_pointer <= 'h0;
                        // If we have reached the end of the BRAMs needed per nappe, move to the next filter depth
                        if (pre_nappe_pointer < FILTER_DEPTH - 1)
                            pre_nappe_pointer <= pre_nappe_pointer + 'h1;
                        else
                            pre_nappe_pointer <= 'h0;
                        // Rotate the pointers every time we shift a nappe.
                        for (i = 0; i < FILTER_DEPTH; i = i + 1)
                            sample_order_pointer[(i + 1) % FILTER_DEPTH] <= sample_order_pointer[i]; 
                    end
                    pre_voxel_store_pointer <= 'h0;
                end
                else
                    pre_voxel_store_pointer <= pre_voxel_store_pointer + 'h1;
            end
            for (i = 0; i < FILTER_DEPTH; i = i + 1)
            begin
                delayed_sample_order_pointer[i] <= sample_order_pointer[i];
                delayed_delayed_sample_order_pointer[i] <= delayed_sample_order_pointer[i];
            end
        end
    end

    // Pass forward the control signals of the pre-demodulation buffer towards the demodulator and post-demodulation buffer
    always @(posedge CLK or negedge RSTN)
    begin
        if (RSTN == 1'b0)
        begin
            DIN_VALID_delayed <= 1'b0;
            mod_data_valid <= 'h0;
            pre_bram_fetch_pointer <= 'h0;
            delayed_pre_bram_fetch_pointer <= 'h0;
            pre_voxel_fetch_pointer <= 'h0;
            delayed_pre_voxel_fetch_pointer <= 'h0;
            nappe_index_trimmed <= 'h0;
        end
        else
        begin
            DIN_VALID_delayed <= DIN_VALID;
            mod_data_valid <= DIN_VALID_delayed;
            pre_bram_fetch_pointer <= pre_bram_store_pointer;
            delayed_pre_bram_fetch_pointer <= pre_bram_fetch_pointer;
            pre_voxel_fetch_pointer <= pre_voxel_store_pointer;
            delayed_pre_voxel_fetch_pointer <= pre_voxel_fetch_pointer;
            // At the beginning of each nappe sent to the demodulator, update the
            // nappe_index pointer. Uses the _fetch_ pointers, which yields a delay
            // of one cycle, to be in sync with the demodulator.
            if (pre_voxel_fetch_pointer == 0 && pre_bram_fetch_pointer == 0)
            begin
                // At the beginning of a volume, the FIR filter has the last nappes of the previous volume in memory.
                // This signal informs it to use 0s for the stale inputs
                // This optimization in a sequential path is meant to improve the critical path
                // inside the demodulator (combinational full-width comparison)
                if (nappe_index <= FILTER_DEPTH)
                    nappe_index_trimmed <= nappe_index[`log2(FILTER_DEPTH) - 1 : 0];
                else
                    nappe_index_trimmed <= FILTER_DEPTH;
            end

        end
    end
        
    always @(*)
    begin: reshuffle_mod_data
        integer i, j;
        for (i = 0; i < FILTER_DEPTH; i = i + 1)
            for (j = 0; j < 36; j = j + 1)
                 reshuffled_mod_data[36 * i + j] = mod_data[delayed_delayed_sample_order_pointer[i]][j];
    end
    
    // Instantiate the demodulator    
    demodulator #(.FILTER_DEPTH(FILTER_DEPTH),
                  .DATA_WIDTH(36),
                  .BRAMS_PER_NAPPE(MAX_BRAMS_PER_NAPPE),
                  .LP_PRECISION(LP_PRECISION)
                )
                demod(.CLK(CLK),
                      .RSTN(RSTN),
                      .nappe_index(nappe_index_trimmed),
                      .mod_data(reshuffled_mod_data),
                      .mod_data_valid(mod_data_valid),
                      // Note: delayed_pre_bram/voxel_fetch_pointer instead of pre_bram/voxel_store_pointer, as
                      // we need these signals to flip two cycles later than the BRAM read addresses
                      .voxel_pointer_in(delayed_pre_voxel_fetch_pointer),
                      .bram_pointer_in(delayed_pre_bram_fetch_pointer),
                      .demod_data(demod_data),
                      .demod_data_valid(demod_data_valid),
                      .voxel_pointer_out(post_voxel_store_pointer),
                      .bram_pointer_out(post_bram_store_pointer),
                      .demodulator_latency(demodulator_latency)
                     );

    // Instantiate the post-demodulation nappe buffer
    // We will retain NAPPE_BUFFER_DEPTH nappes after demodulation
    // For a 64x64 voxel nappe, we need NAPPE_BUFFER_DEPTH * 4 BRAMs to do this
    genvar k, l;
    generate
        // As many levels as the depth of the nappe buffer
        for (k = 0; k < NAPPE_BUFFER_DEPTH; k = k + 1)
        begin: gen_post_buffer
            // For each nappe, possibly more than one BRAM
            for (l = 0; l < MAX_BRAMS_PER_NAPPE; l = l + 1)
            begin: gen_post_nappe_chunks
                // Xilinx True Dual Port RAM, Write First with Single Clock
                dpbram #(.RAM_WIDTH(36),
                         .RAM_DEPTH(1024),
                         .RAM_PERFORMANCE("LOW_LATENCY"),
                         .INIT_FILE("")
                       )
                       post_bram(.addra(post_voxel_store_pointer),
                                 .addrb(post_voxel_fetch_pointer),
                                 .dina(demod_data),
                                 .dinb('h0),
                                 .clka(CLK),
                                 .wea(demod_data_valid == 1'b1 && post_nappe_store_pointer == k && post_bram_store_pointer == l),
                                 .web(1'b0),
                                 .ena(1'b1),
                                 .enb(1'b1),
                                 .rsta(RSTN),
                                 .rstb(RSTN),
                                 .regcea(1'b1),
                                 .regceb(1'b1),
                                 .douta(),
                                 .doutb(output_voxels[k][l])
                                );
            end
        end
    endgenerate

    // Manage the pointers of the post-demodulation nappe buffer
    always @(posedge CLK or negedge RSTN)
    begin: post_demodulation_pointers
        if (RSTN == 1'b0)
        begin
            post_nappe_store_pointer <= 'h0;
            // post_bram_store_pointer is derived from the pre-demodulation buffer via the demodulator
            // post_voxel_store_pointer is derived from the pre-demodulation buffer via the demodulator
            max_value <= 'h0;
            
            post_bram_fetch_pointer_next <= 'h0;
            post_nappe_fetch_pointer_next <= 'h0;
            post_voxel_fetch_pointer_next <= 'h0;
            
            post_bram_fetch_pointer_prev <= 'h0;
            post_nappe_fetch_pointer_prev <= 'h0;
            post_voxel_fetch_pointer_prev <= 'h0;

            stall_beamformer <= 1'b0;
        end
        else
        begin
            // Input pointers
            if (demod_data_valid)
            begin
                // If we have reached the end of the current BRAM or the end of the partial use of the BRAM designated by leftover_voxels 
                // and we are on the last BRAM of the current nappe move to the next NAPPE_BUFFER
                // Note that post_voxel_store_pointer comes from the demodulator and is just a delayed version of pre_voxel_store_pointer
                if ((post_voxel_store_pointer == 1023 || (leftover_voxels != 0 && post_voxel_store_pointer == leftover_voxels - 1)) && post_bram_store_pointer == brams_per_nappe - 1)
                begin
                    if (post_nappe_store_pointer < NAPPE_BUFFER_DEPTH - 1)
                        post_nappe_store_pointer <= post_nappe_store_pointer + 'h1;
                    else
                        post_nappe_store_pointer <= 'h0;
                end
            end
            
            // Asserts a stall if there is one free buffer slot left. This is because the stall signal 
            // is only checked upon starting a nappe - which means that the stall will be
            // honored, potentially, one full nappe later.
            if ((post_nappe_store_pointer + 1) % NAPPE_BUFFER_DEPTH == post_nappe_fetch_pointer)
                stall_beamformer <= 1'b1;
            
            // Output pointers
            // Check this condition because at the very first voxel, we are in a situation where the write and read pointers
            // both point to the first location in the BRAM. The read must wait at least one cycle before it can read valid data.
            // After this wait, the synchronization will be in place correctly.
            if (post_buffer_empty == 1'b0)
            begin
                if (post_voxel_fetch_pointer == 1023 || (leftover_voxels != 0 && post_voxel_fetch_pointer == leftover_voxels - 1))
                begin
                    if (post_bram_fetch_pointer < brams_per_nappe - 1)
                        post_bram_fetch_pointer_next <= post_bram_fetch_pointer + 'h1;
                    else
                    begin
                        post_bram_fetch_pointer_next <= 'h0;
                        // If we have reached the end of the nappe buffer designated by NAPPE_BUFFER_DEPTH
                        // return to the first BRAM set
                        if (post_nappe_fetch_pointer < NAPPE_BUFFER_DEPTH - 1)
                            post_nappe_fetch_pointer_next <= post_nappe_fetch_pointer + 'h1;
                        else
                            post_nappe_fetch_pointer_next <= 'h0;
                    end
                    post_voxel_fetch_pointer_next <= 'h0;
                end
                else
                    post_voxel_fetch_pointer_next <= post_voxel_fetch_pointer + 'h1;
            end
            
            post_bram_fetch_pointer_prev <= post_bram_fetch_pointer;
            post_nappe_fetch_pointer_prev <= post_nappe_fetch_pointer;
            post_voxel_fetch_pointer_prev <= post_voxel_fetch_pointer;

            // Deassert the stall when there are again free buffer slots.
            if ((post_nappe_store_pointer + 2) % NAPPE_BUFFER_DEPTH == post_nappe_fetch_pointer)
                stall_beamformer <= 1'b0;
        end
    end
    
    // Manage the read pointers of the post-demodulation nappe buffer
    assign post_bram_fetch_pointer = (DOUT_VALID == 1'b1 && DOUT_READY == 1'b1) ? post_bram_fetch_pointer_next : post_bram_fetch_pointer_prev;
    assign post_nappe_fetch_pointer = (DOUT_VALID == 1'b1 && DOUT_READY == 1'b1) ? post_nappe_fetch_pointer_next : post_nappe_fetch_pointer_prev;
    assign post_voxel_fetch_pointer = (DOUT_VALID == 1'b1 && DOUT_READY == 1'b1) ? post_voxel_fetch_pointer_next : post_voxel_fetch_pointer_prev;

    // Fullness of the post-demodulation nappe buffer
    always @(posedge CLK or negedge RSTN)
    begin
        if (RSTN == 1'b0)
            fifo_ready_voxels <= 'h0;
        else
        begin
            // One in, none out
            if (demod_data_valid == 1'b1 && (DOUT_VALID == 1'b0 || DOUT_READY == 1'b0))
                fifo_ready_voxels <= fifo_ready_voxels + 'h1;
            // One out, none in
            else if (DOUT_VALID == 1'b1 && DOUT_READY == 1'b1 && demod_data_valid == 1'b0)
                fifo_ready_voxels <= fifo_ready_voxels - 'h1;
            // Either one in, one out or none in, none out: counter unchanged
        end
    end
    
    // Overall handshake handling
    assign DOUT = output_voxels[post_nappe_fetch_pointer_prev][post_bram_fetch_pointer_prev][31 : 0];
    assign post_buffer_empty = (fifo_ready_voxels == 'h0);

    // Valid output
    // Use a registered system (i.e. one cycle of delay) for the same type of reason that output fetch pointers must also be delayed
    // by one cycle: cannot write and read from the first buffer location in the same cycle.
    always @(posedge CLK or negedge RSTN)
    begin
        if (RSTN == 1'b0)
            post_buffer_empty_delayed <= 1'b0;
        else
            post_buffer_empty_delayed <= post_buffer_empty;
    end
    assign DOUT_VALID = (~post_buffer_empty & ~post_buffer_empty_delayed);

endmodule
