// ***************************************************************************
// ***************************************************************************
//  Copyright (C) 2014-2018  EPFL
//  "BeamformerIP" custom IP.
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
// Create Date: 04/28/2016 03:43:00 PM
// Design Name: 
// Module Name: testbench
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

`timescale 1 ns / 1 ps
`include "../../sources_1/new/utilities.v"
`include "../../sources_1/new/parameters.v"

// `define DEBUG

module testbench();

    localparam USE_AXI_FIFO            = 0;
    localparam STREAMING_RF_INPUT      = 0;
    localparam BENCHMARK               = `BENCHMARK;
    localparam ADDR_WAIT_CYCLES        = 15;            // By how many cycles to delay AXI address transaction AR/AWREADY (TODO 0 gets 1 WS)
    localparam DATA_WAIT_CYCLES        = 1;             // By how many cycles to delay AXI data transaction WREADY
    localparam ADDRESS_WIDTH           = 32;
    localparam DATA_WIDTH              = 32;
    localparam INPUT_DELAY             = 0.25;          // By how much to delay inputs to the testbench
    localparam CLOCK_PERIOD            = 10;
    localparam WRITE                   = 1;
    localparam READ                    = 0;
    localparam ELEVATION_LINES         = `ELEVATION_LINES;
    localparam AZIMUTH_LINES           = `AZIMUTH_LINES;
    localparam RADIAL_LINES            = `RADIAL_LINES;
    localparam BRAM_SAMPLES_PER_NAPPE  = (STREAMING_RF_INPUT == 1 ? `RF_DEPTH : `BRAM_SAMPLES_PER_NAPPE);
    localparam RF_TRANSMISSIONS        = (STREAMING_RF_INPUT == 1 ? 1 : RADIAL_LINES);
    localparam TRANSDUCER_ELEMENTS_X   = `TRANSDUCER_ELEMENTS_X;
    localparam TRANSDUCER_ELEMENTS_Y   = `TRANSDUCER_ELEMENTS_Y;
    localparam TRANSDUCER_MEMORY_COUNT = (TRANSDUCER_ELEMENTS_Y > 1 ? TRANSDUCER_ELEMENTS_X * TRANSDUCER_ELEMENTS_Y / 2 : TRANSDUCER_ELEMENTS_X); 
    localparam COMPOUND_COUNT          = `COMPOUND_COUNT;       // If compounding, of how many frames
    // Set to 1 to simulate the FPGA's behaviour (processor writes into BRAMs for every nappe);
    // Set to 0 to use pre-generated BRAM contents (will only work for the first nappes)
    localparam FILL_FROM_FILE          = 1;
    localparam NAPPE_BUFFER_DEPTH      = 3;
    static string path                 = `SIM_PATH;
    // Register map
    localparam STATUS_REGISTER         = 32'h00000000;
    localparam BRAM_REGISTER           = 32'h00000008;
    localparam COMMAND_REGISTER        = 32'h0000000C;
    localparam OPTIONS_REGISTER        = 32'h00000010;
    localparam RF_DEPTH_REGISTER       = 32'h00000014;
    localparam ZERO_OFFSET_REGISTER    = 32'h00000018;
    localparam ZONE_COUNT              = `ELEVATION_ZONES * `AZIMUTH_ZONES;
    localparam FIFO_CHAN_WIDTH         = DATA_WIDTH / 2;
    localparam FIFO_WIDTH              = 64;
    
    logic clk;
    logic rstn;

    // =================
    // AXI SLAVE PORT
    // =================
    
    // Write address channel
    logic [ADDRESS_WIDTH - 1 : 0] awaddr;
    logic [7 : 0] awlen;
    logic [2 : 0] awsize;
    logic [1 : 0] awburst;
    logic awvalid;
    logic awready;
    
    // Read address channel
    logic [ADDRESS_WIDTH - 1 : 0] araddr;
    logic [7 : 0] arlen;
    logic [2 : 0] arsize;
    logic [1 : 0] arburst;
    logic arvalid;
    logic arready;

    // Write data channel
    logic [DATA_WIDTH - 1 : 0] wdata;
    logic wlast;
    logic wvalid;
    logic wready;

    // Read response channel
    logic [DATA_WIDTH - 1 : 0] rdata;
    logic [1 : 0] rresp;
    logic rlast;
    logic rvalid;
    logic rready;

    // Write response channel
    logic [1 : 0] bresp;
    logic bvalid;
    logic bready;
    
    // =================
    // AXI MASTER PORT
    // =================
        
    // Write address channel
    logic [ADDRESS_WIDTH - 1 : 0] m_awaddr;
    logic m_awid;
    logic [7 : 0] m_awlen;
    logic [2 : 0] m_awsize;
    logic [1 : 0] m_awburst;
    logic m_awvalid;
    logic m_awready;
    logic m_awlock;
    logic [3 : 0] m_awcache;
    logic [2 : 0] m_awprot;
    logic [3 : 0] m_awqos;
    logic [3 : 0] m_wstrb;
    
    // Read address channel
    logic [ADDRESS_WIDTH - 1 : 0] m_araddr;
    logic m_arid;
    logic [7 : 0] m_arlen;
    logic [2 : 0] m_arsize;
    logic [1 : 0] m_arburst;
    logic m_arvalid;
    logic m_arready;
    logic m_arlock;
    logic [3 : 0] m_arcache;
    logic [2 : 0] m_arprot;
    logic [3 : 0] m_arqos;
    logic [3 : 0] m_arregion;
    
    // Write data channel
    logic [DATA_WIDTH - 1 : 0] m_wdata;
    logic m_wlast;
    logic m_wvalid;
    logic m_wready;
    
    // Read response channel
    logic [DATA_WIDTH - 1 : 0] m_rdata;
    logic [1 : 0] m_rresp;
    logic m_rlast;
    logic m_rvalid;
    logic m_rready;
    
    // Write response channel
    logic [1 : 0] m_bresp;
    logic m_bvalid;
    logic m_bready;
    
    // =================
    // AXI STREAM PORT
    // =================

    logic fifo_axis_tready;
    logic fifo_axis_tvalid;
    logic [FIFO_WIDTH - 1 : 0] fifo_axis_tdata;
    
    // Signals to handle flow control
    // Response buffer (max 1 transaction may be pending)
    reg [DATA_WIDTH - 1 : 0]         response_data_queue;
    reg                              response_present;
    reg                              response_ttype;
    reg [ADDRESS_WIDTH - 1 : 0]      response_address;
    reg [DATA_WIDTH - 1 : 0]         returned_data, old_returned_data;
    logic                            quit_simulation;
    integer                          error_count;
    
    logic [DATA_WIDTH - 1 : 0]       options_reg;                 // The set of options to pass to the beamformer
    integer                          iterations, iteration_index; // Either how many zones or images (for compounding) to iterate on
    reg                              busy_bit, ready_bit;         // Busy and ready bits of the Status Register
    integer                          file_pointers[(`COMPOUND_NOT_ZONE ? COMPOUND_COUNT : ZONE_COUNT) - 1 : 0];       // Array of file pointers to iteration data
    string                           nappe_filename, echoes_filename1, echoes_filename2;              // Filenames (output nappes, input RF data)
    integer                          a, b, compound_total, i, j, e1, e2, f, k, nappe_index, s, t, wait_index, zone_index;
    integer                          fifo_data_count;
    reg [31 : 0]                     voxel_elevation_index, voxel_azimuth_index;                      // Current voxel indices, to store BF voxel outputs
    integer                          echo_counter, element_counter, echo_sample1, echo_sample2, nappe_counter;
    integer                          ret_code;
    real                             avg_voxel, voxel, min_voxel;
    integer                          aw_wait_count, ar_wait_count;

    reg signed [DATA_WIDTH - 1 : 0] zone [ELEVATION_LINES / `ELEVATION_ZONES - 1 : 0][AZIMUTH_LINES / `AZIMUTH_ZONES - 1 : 0];
    reg [DATA_WIDTH - 1 : 0] echo_data [BRAM_SAMPLES_PER_NAPPE - 1 : 0] [(TRANSDUCER_ELEMENTS_Y > 1 ? (TRANSDUCER_ELEMENTS_X * TRANSDUCER_ELEMENTS_Y / 2) : TRANSDUCER_ELEMENTS_X) - 1 : 0];
    reg [63 : 0] echo_data_shuffled [BRAM_SAMPLES_PER_NAPPE - 1 : 0] [11 : 0];
    reg [`log2(ELEVATION_LINES - 1) - 1 : 0]  elevation_pointer;
    reg [`log2(AZIMUTH_LINES - 1) - 1 : 0]  azimuth_pointer;
    reg [`log2(BRAM_SAMPLES_PER_NAPPE) - 1 : 0] sample_index;
    reg [`log2(TRANSDUCER_ELEMENTS_X * TRANSDUCER_ELEMENTS_Y / 2) - 1 : 0] transducer_index;

    BeamformerIP #(.NAPPE_BUFFER_DEPTH(NAPPE_BUFFER_DEPTH),
                   .FIFO_CHAN_WIDTH(FIFO_CHAN_WIDTH),
                   .FIFO_WIDTH(FIFO_WIDTH),
                   .C_S00_AXI_ID_WIDTH(1),
                   .C_S00_AXI_DATA_WIDTH(DATA_WIDTH),
                   .C_S00_AXI_ADDR_WIDTH(ADDRESS_WIDTH),
                   .C_S00_AXI_AWUSER_WIDTH(0),
                   .C_S00_AXI_ARUSER_WIDTH(0),
                   .C_S00_AXI_WUSER_WIDTH(0),
                   .C_S00_AXI_RUSER_WIDTH(0),
                   .C_S00_AXI_BUSER_WIDTH(0),
                   .C_M00_AXI_TARGET_SLAVE_BASE_ADDR(32'hC0000000),
                   .C_M00_AXI_BURST_LEN(8),
                   .C_M00_AXI_ID_WIDTH(1),
                   .C_M00_AXI_DATA_WIDTH(DATA_WIDTH),
                   .C_M00_AXI_ADDR_WIDTH(ADDRESS_WIDTH),
                   .C_M00_AXI_AWUSER_WIDTH(0),
                   .C_M00_AXI_ARUSER_WIDTH(0),
                   .C_M00_AXI_WUSER_WIDTH(0),
                   .C_M00_AXI_RUSER_WIDTH(0),
                   .C_M00_AXI_BUSER_WIDTH(0)
                  ) dut
                  (
                   // AXI Stream Ports
                   .fifo_axis_aresetn(rstn),
                   .fifo_axis_aclk(clk),
                   .fifo_axis_tready(fifo_axis_tready),
                   .fifo_axis_tvalid(fifo_axis_tvalid),
                   .fifo_axis_rd_data_count('h0),
                   .fifo_axis_tdata(fifo_axis_tdata),
                   // Slave Ports
                   .s00_axi_aclk(clk),
                   .s00_axi_aresetn(rstn),
                   .s00_axi_awid(1'b0),
                   .s00_axi_awaddr(awaddr),
                   .s00_axi_awlen(awlen),
                   .s00_axi_awsize(awsize),
                   .s00_axi_awburst(awburst),
                   .s00_axi_awlock(1'b0),
                   .s00_axi_awcache(4'b0000),
                   .s00_axi_awprot(3'b000),
                   .s00_axi_awqos(4'b0000),
                   .s00_axi_awregion(4'b000),
                   .s00_axi_awvalid(awvalid),
                   .s00_axi_awready(awready),
                   .s00_axi_wdata(wdata),
                   .s00_axi_wstrb(4'b1111),
                   .s00_axi_wlast(wlast),
                   .s00_axi_wvalid(wvalid),
                   .s00_axi_wready(wready),
                   .s00_axi_bid(),
                   .s00_axi_bresp(bresp),
                   .s00_axi_bvalid(bvalid),
                   .s00_axi_bready(bready),
                   .s00_axi_arid(1'b0),
                   .s00_axi_araddr(araddr),
                   .s00_axi_arlen(arlen),
                   .s00_axi_arsize(arsize),
                   .s00_axi_arburst(arburst),
                   .s00_axi_arlock(1'b0),
                   .s00_axi_arcache(4'b0000),
                   .s00_axi_arprot(3'b000),
                   .s00_axi_arqos(4'b0000),
                   .s00_axi_arregion(4'b000),
                   .s00_axi_arvalid(arvalid),
                   .s00_axi_arready(arready),
                   .s00_axi_rid(),
                   .s00_axi_rdata(rdata),
                   .s00_axi_rresp(rresp),
                   .s00_axi_rlast(rlast),
                   .s00_axi_rvalid(rvalid),
                   .s00_axi_rready(rready),
                   // Master Ports
                   .m00_axi_aclk(clk),
                   .m00_axi_aresetn(rstn),
                   .m00_axi_awid(m_awid),
                   .m00_axi_awaddr(m_awaddr),
                   .m00_axi_awlen(m_awlen),
                   .m00_axi_awsize(m_awsize),
                   .m00_axi_awburst(m_awburst),
                   .m00_axi_awlock(m_awlock),
                   .m00_axi_awcache(m_awcache),
                   .m00_axi_awprot(m_awprot),
                   .m00_axi_awqos(m_awqos),
                   .m00_axi_awvalid(m_awvalid),
                   .m00_axi_awready(m_awready),
                   .m00_axi_wdata(m_wdata),
                   .m00_axi_wstrb(m_wstrb),
                   .m00_axi_wlast(m_wlast),
                   .m00_axi_wvalid(m_wvalid),
                   .m00_axi_wready(m_wready),
                   .m00_axi_bid('h0),
                   .m00_axi_bresp(m_bresp),
                   .m00_axi_bvalid(m_bvalid),
                   .m00_axi_bready(m_bready),
                   .m00_axi_arid(m_arid),
                   .m00_axi_araddr(m_araddr),
                   .m00_axi_arlen(m_arlen),
                   .m00_axi_arsize(m_arsize),
                   .m00_axi_arburst(m_arburst),
                   .m00_axi_arlock(m_arlock),
                   .m00_axi_arcache(m_arcache),
                   .m00_axi_arprot(m_arprot),
                   .m00_axi_arqos(m_arqos),
                   .m00_axi_arvalid(m_arvalid),
                   .m00_axi_arready(m_arready),
                   .m00_axi_rid('h0),
                   .m00_axi_rdata(m_rdata),
                   .m00_axi_rresp(m_rresp),
                   .m00_axi_rlast(m_rlast),
                   .m00_axi_rvalid(m_rvalid),
                   .m00_axi_rready(m_rready)
                  );
    
    // ================================================
    // Event trigger when the beamformer accepts a request and it is time to move to the next
    // ================================================
    event exit_addresschannel_task;
    always @(posedge clk)
    begin
        if ((arvalid && arready) || (awvalid && awready))
            -> exit_addresschannel_task; 
    end

    event exit_datachannel_task;
    always @(posedge clk)
    begin
        if (wvalid && wready)
            -> exit_datachannel_task; 
    end
    
    event exit_fifo_inject_task;
    always @(posedge clk)
    begin
        if (fifo_axis_tvalid && fifo_axis_tready)
            -> exit_fifo_inject_task; 
    end

    // ================================================
    // Clock tick
    // ================================================
    always
    begin
        #(CLOCK_PERIOD / 2.0);
        clk = ~clk;
    end

    // ================================================
    // Response checking
    // ================================================ 
    always @(posedge clk)
    begin: check_response
        reg [DATA_WIDTH - 1 : 0] response_data;
        integer loop;
        reg error_found;

        if (rstn == 0)
        begin
            response_present = 1'b0;
            response_data_queue = 'h0;
            response_ttype = READ;
            response_address = 1'b0;
        end
        else if (rvalid || bvalid)
        begin
            // Check that there is indeed a pending response for this ID on this interface
            if (!response_present)
            begin
                $display("ERROR: unexpected response %x at %0t", response_data, $time);
                error_count = error_count + 1;
            end
            // Check if the response we just got matches what we were expecting
            else if (response_ttype == READ && rvalid)
            begin
                response_data = rdata;
                error_found = 1'b0;
                for (loop = 0; loop < DATA_WIDTH && !error_found; loop = loop + 1)
                    if (response_data_queue[loop] !== 1'bX && response_data_queue[loop] !== 1'bZ && response_data_queue[loop] !== response_data[loop])
                        error_found = 1'b1;
                if (error_found)
                begin
                    $display("ERROR: not matching response %x (expected %x) for address %x at %0t", response_data, response_data_queue, response_address, $time);
                    error_count = error_count + 1;
                end
                //else
                //    $display("OK: detected matching response %x for address %x at %0t", response_data, response_address, $time);
            end
            else if (response_ttype == WRITE && bvalid)
            begin
                response_data = 'hX;
                // $display("OK: detected write acceptance for address %x at %0t", response_address, $time);
            end
            else
            begin
                $display("ERROR: received the wrong response type (expected %x) at %0t", response_ttype, $time);
                error_count = error_count + 1;
            end

            response_present = 1'b0;
            response_data_queue = 'hX;
            response_ttype = 1'bX;
            response_address = 'hX;
        end
    end
    
    // ================================================
    // Write handling
    // ================================================ 
    always @(posedge clk)  
    begin
        if (m_wready == 1 && m_wvalid == 1)
        begin
            // TODO relies on knowing the output size and does not check the master's awaddr output at all
            zone[voxel_elevation_index][voxel_azimuth_index] = m_wdata;
            if (voxel_elevation_index == ELEVATION_LINES / `ELEVATION_ZONES - 1)
            begin
                voxel_elevation_index <= 'h0;
                if (voxel_azimuth_index == AZIMUTH_LINES / `AZIMUTH_ZONES - 1)
                begin
                    voxel_azimuth_index <= 'h0;

                    nappe_counter ++;
                    // Save the nappe (zone) to disk.
                    // Zone imaging
                    if (`COMPOUND_NOT_ZONE == 0)
                    begin
                        $sformat(nappe_filename, "%s/sim_nappes/%s_nappe_%0d_zone_%0d.txt", path, BENCHMARK, nappe_counter, iteration_index + 1);
                        f = $fopen(nappe_filename, "w");
                        for (j = 0; j <  AZIMUTH_LINES / `AZIMUTH_ZONES;  j ++)
                        begin
                            for (i = 0; i < ELEVATION_LINES / `ELEVATION_ZONES; i ++)
                            begin
                                voxel = zone[i][j];
                                $fwrite(f, "%.2f\n", voxel / 4);
                            end
                        end
                        $fclose(f);
                    end
                    // Compound imaging
                    else
                    begin
                        $sformat(nappe_filename, "%s/sim_nappes/%s_nappe_%0d_compounding_%0d.txt", path, BENCHMARK, nappe_counter, iteration_index + 1);
                        f = $fopen(nappe_filename, "w");
                        for (j = 0; j < AZIMUTH_LINES; j = j + 1)
                        begin
                            for (i = 0; i < ELEVATION_LINES; i = i + 1)
                            begin
                                voxel = zone[i][j];
                                $fwrite(f, "%.2f\n", voxel / 4);
                            end
                        end
                        $fclose(f);
                    end
                end
                else
                begin
                    voxel_azimuth_index <= voxel_azimuth_index + 1;
                end
            end
            else
            begin
                voxel_elevation_index <= voxel_elevation_index + 1;
            end
        end
    end
    
    // ================================================
    // Utility functions
    // ================================================

    // ================================================
    // FIFO injection task: tries to inject data from the FIFO into the AXI Stream port
    // ================================================      
    task FIFO_INJECT;
    input [FIFO_WIDTH - 1 : 0]      data;
    begin
        #(INPUT_DELAY);

        fifo_axis_tvalid <= 1'b1;
        fifo_axis_tdata <= data;
        
        // Wait until request is accepted.
        @(exit_fifo_inject_task);
        fifo_axis_tvalid <= 1'b0;
        fifo_data_count --;
        end
    endtask

    // ================================================
    // Idle pinout: all interfaces (AXI Slave port) to rest state
    // ================================================
    task IDLE_PINOUT;
    begin
        #(INPUT_DELAY);

        // Write address channel
        awaddr <= 'hX;
        awlen <= 'hX;
        awsize <= 'hX;
        awburst <= 'hX;
        awvalid <= 1'b0;
               
        // Read address channel
        araddr <= 'hX;
        arlen <= 'hX;
        arsize <= 'hX;
        arburst <= 'hX;
        arvalid <= 1'b0;
            
        // Write data channel
        wdata <= 'hX;
        wlast <= 1'bX;
        wvalid <= 1'b0;
            
        // Read response channel
        rready <= 1'b1;
          
        // Write response channel
        bready <= 1'b1;
    end
    endtask
    
    // ================================================
    // Idle task: do nothing this cycle
    // ================================================
    task NOP;
    begin
        IDLE_PINOUT();
        @(posedge clk);
    end
    endtask
    
    // ================================================
    // Before injecting a new transaction this cycle, ensures there aren't too many outstanding
    // ================================================
    task PREPARE_INJECTION;
        begin    
            #(INPUT_DELAY);
    
            IDLE_PINOUT();
    
            // Ensure we don't push out requests if there is an outstanding one.
            while (response_present)
            begin
                NOP;
                #(INPUT_DELAY);
            end
        end
    endtask
    
    // ================================================
    // Transaction injection task: ask the beamformer to read or write something
    // ================================================
    task TRANS_REQUEST;
        input                            ttype;
        input [ADDRESS_WIDTH - 1 : 0]    address;
        input [DATA_WIDTH - 1 : 0]       in_wdata;   // Only matters for writes
        input [DATA_WIDTH - 1 : 0]       exp_rdata;  // Only matters for reads
        begin
            PREPARE_INJECTION();
            
            if (ttype == READ)
            begin
                araddr <= address;
                arlen <= 'h0;
                arsize <= 3'b010;
                arburst <= 2'b01;
                arvalid <= 1'b1;
            end
            else
            begin
                awaddr <= address;
                awlen <= 'h0;
                awsize <= 3'b010;
                awburst <= 2'b01;
                awvalid <= 1'b1;
                
                wdata <= in_wdata;
                wlast <= 1'b1;
                wvalid <= 1'b1;
            end
            
            // Wait until request is accepted.
            @(exit_addresschannel_task);
            wvalid <= 1'b0; // Ensure we deassert the write request, if any
            // TODO for wvalid, we should also wait for _datachannel_, which may come at a different time
            // TODO we don't support bursts, even wrapping.    
            PUSH_EXP_QUEUE(ttype, address, exp_rdata);
        end
    endtask
    
    // ================================================
    // Read task: ask the beamformer to read something and stall until the response comes back, also returns the response
    // ================================================      
    task BLOCKING_READ;
        input [ADDRESS_WIDTH - 1 : 0]    address;
        output [DATA_WIDTH - 1 : 0]      ret_rdata;
        begin
            TRANS_REQUEST(READ, address, 'X, 'X);
    
            IDLE_PINOUT();
    
            // Wait until a response comes. Note that the response processing logic
            // will also process this event and thus unlock "response_present".
            while (response_present)
            begin
                ret_rdata = rdata;
                NOP;
            end
`ifdef DEBUG
            $display("INFO: blocking read returned %x at %0t", ret_rdata, $time);
`endif
        end
    endtask
    
    // ================================================
    // Expected data back queue: push the expected data into the response queue
    // ================================================
    task PUSH_EXP_QUEUE;
        input ttype;
        input [ADDRESS_WIDTH - 1 : 0] address;
        input [DATA_WIDTH - 1 : 0] exp_rdata;
        begin
            if (response_present)
            begin
                $display("ERROR: unexpected new outstanding %s response %x as there is already one at time %0t", (ttype == READ ? "read" : "write"), exp_rdata, $time);
                error_count = error_count + 1;
            end
`ifdef DEBUG
            if (ttype == READ)
                $display("INFO: queuing new expected read response %x for address %x at time %0t", exp_rdata, address, $time);
            else
                $display("INFO: queuing new expected write response for address %x at time %0t", address, $time);
`endif
            response_present <= 1'b1;
            response_data_queue <= exp_rdata;
            response_ttype <= ttype;
            response_address <= address;
        end
    endtask
    
    // ================================================
    // Continue the simulation until all pending transactions are drained
    // ================================================      
    task WAIT_ALL_PENDING;
    begin
        integer loop;
        quit_simulation = 1'b0;
        while (!quit_simulation)
        begin
            if (response_present)
                quit_simulation = 1'b0;
            else
                quit_simulation = 1'b1;
            NOP;
        end
    end
    endtask
    
    // ================================================
    // Provide semi-slow flow control to the AXI Master port (write side) to test the timing
    // ================================================
    always @(posedge clk)
    begin
        if (rstn == 1'b0)
        begin
            aw_wait_count = ADDR_WAIT_CYCLES;
            m_awready <= 1'b0;
        end
        else
        begin
            if (m_awvalid == 1'b1 && m_awready == 1'b0)
            begin
                if (aw_wait_count == 0)
                begin
                    aw_wait_count = ADDR_WAIT_CYCLES;
                    m_awready <= 1'b1;
                end
                else
                begin
                    aw_wait_count = aw_wait_count - 1;
                end
            end
            else
                m_awready <= 1'b0;
        end
    end

    always
    begin
        // Just pretend that the write cannot be accepted right away (models a slow memory)
        m_wready <= 1'b0;
        #(CLOCK_PERIOD * DATA_WAIT_CYCLES)
        m_wready <= 1'b1;
        #(CLOCK_PERIOD)
        m_wready <= 1'b0;
    end

    always @(posedge clk)
    begin
        if (rstn == 1'b0)
        begin
            m_bvalid <= 1'b0;
            m_bresp = 2'b00;
        end
        else
        begin
            if (m_wlast == 1'b1 && m_wvalid == 1'b1 && m_wready == 1'b1)
            begin
                m_bvalid <= 1'b1;
                m_bresp = 2'b00;
            end
            else if (m_bready == 1'b1)
            begin
                m_bvalid <= 1'b0;
                m_bresp = 2'bXX;
            end
        end
    end
    
    // ================================================
    // Testbench behaviour
    // ================================================ 
    initial
    begin: test
        clk <= 1'b1;
        rstn <= 1'b0;    // Reset is active since boot. Avoids failing asserts pre-reset.
        @(posedge clk);
        // Initializes the options for the Options Register
        iterations = `COMPOUND_NOT_ZONE ? COMPOUND_COUNT : ZONE_COUNT;
        options_reg[4 : 0] <= `AZIMUTH_ZONES;
        options_reg[9 : 5] <= `ELEVATION_ZONES;
        options_reg[14 : 10] <= COMPOUND_COUNT;
        options_reg[31 : 15] <= 'h0;
        NOP();           // Initializes inputs and waits until next clock edge
        #(INPUT_DELAY);
        rstn <= 1'b0;    // Trigger reset
        voxel_azimuth_index <= 'h0;
        voxel_elevation_index <= 'h0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        #(INPUT_DELAY);
        rstn <= 1'b1;   // Ready for operation now
        @(posedge clk);
        @(posedge clk);

        error_count = 0;

        $display("================= Starting Test Initialization & Configuration Interface at %0t", $time);

        TRANS_REQUEST(WRITE, .address(OPTIONS_REGISTER), .exp_rdata(32'hX), .in_wdata(options_reg));
        TRANS_REQUEST(WRITE, .address(RF_DEPTH_REGISTER), .exp_rdata(32'hX), .in_wdata(`RF_DEPTH));
        TRANS_REQUEST(WRITE, .address(ZERO_OFFSET_REGISTER), .exp_rdata(32'hX), .in_wdata(`ZERO_OFFSET));
        
        // Enable the Aurora interface if needed
        if (USE_AXI_FIFO == 1)
        begin
            // Flush the FIFO for a while
            TRANS_REQUEST(WRITE, .address(COMMAND_REGISTER), .exp_rdata(32'hX), .in_wdata('he));
            for (wait_index = 0; wait_index < 100; wait_index ++)
                @(posedge clk);
            // Now just get listening
            TRANS_REQUEST(WRITE, .address(COMMAND_REGISTER), .exp_rdata(32'hX), .in_wdata('h6));
        end
        else if (STREAMING_RF_INPUT == 1)
            TRANS_REQUEST(WRITE, .address(COMMAND_REGISTER), .exp_rdata(32'hX), .in_wdata('h4));
        
        // Just to locate this more easily on waveforms
        for (wait_index = 0; wait_index < 1200; wait_index ++)
            @(posedge clk);

        // The beamformer logic may take a while to initialize. Monitor the Status Register until
        // we detect that the beamformer is ready to beamform the first nappe;
        // this is indicated by bit 0 at 1
        do
        begin
            returned_data = 'h0;
            BLOCKING_READ(.address(STATUS_REGISTER), .ret_rdata(returned_data));
        end
        while (returned_data != {31'hX, 1'b1});

        for (iteration_index = 0; iteration_index < iterations; iteration_index ++)
        begin
            $display("================= Start of Iteration %03d/%03d at %0t", iteration_index + 1, iterations, $time);

            nappe_counter = 0;
            
            for (nappe_index = 0; nappe_index < RF_TRANSMISSIONS; nappe_index ++)
            begin
                $display("========= Sending data for nappe %d at %0t", nappe_index, $time);
                
                // Now fill the BRAMs with data
                if (FILL_FROM_FILE == 1) // && (iteration_index != 0 || nappe_index != 0)) TODO: this speedup trick causes issues with TGC of later nappes since "offset" will be wrong,
                begin                                                                      // but can be used to decode only the first set of nappes.
                    // To save memory, could also load from disk word by word as needed to put on bus;
                    // This arrangement is easier for debugging and works best when a single RF file is reused for multiple nappes.
                    // Load echo data from disk
                    if (STREAMING_RF_INPUT == 0)
                    begin
                        if (`COMPOUND_NOT_ZONE == 0)
                        begin
                            $sformat(echoes_filename1, "%s/%s_rfa_%03d_zone_%0d.txt", path, BENCHMARK, nappe_index + 1, iteration_index + 1);
                            $sformat(echoes_filename2, "%s/%s_rfb_%03d_zone_%0d.txt", path, BENCHMARK, nappe_index + 1, iteration_index + 1);
                        end
                        else
                        begin
                            $sformat(echoes_filename1, "%s/%s_rfa_%03d_compounding_%0d.txt", path, BENCHMARK, nappe_index + 1, iteration_index + 1);
                            $sformat(echoes_filename2, "%s/%s_rfb_%03d_compounding_%0d.txt", path, BENCHMARK, nappe_index + 1, iteration_index + 1);
                        end
                    end
                    else
                    begin
                        if (`COMPOUND_NOT_ZONE == 0)
                        begin
                            $sformat(echoes_filename1, "%s/%s_rfa_000_zone_%0d.txt", path, BENCHMARK, iteration_index + 1);
                            $sformat(echoes_filename2, "%s/%s_rfb_000_zone_%0d.txt", path, BENCHMARK, iteration_index + 1);
                        end
                        else
                        begin
                            $sformat(echoes_filename1, "%s/%s_rfa_000_compounding_%0d.txt", path, BENCHMARK, iteration_index + 1);
                            $sformat(echoes_filename2, "%s/%s_rfb_000_compounding_%0d.txt", path, BENCHMARK, iteration_index + 1);
                        end
                    end
                    $display("Loading raw echo data from files %s and %s", echoes_filename1, echoes_filename2);
                    e1 = $fopen(echoes_filename1, "r");
                    e2 = $fopen(echoes_filename2, "r");
                    if (e1 == 0 || (TRANSDUCER_ELEMENTS_Y > 1 && e2 == 0))
                    begin
                        $display("Warning: could not find echo files for nappe %d, reusing previous nappe data", nappe_index);
                        // Just to locate this more easily on waveforms
                        for (wait_index = 0; wait_index < 100; wait_index ++)
                            @(posedge clk);
                    end
                    else
                    begin
                        echo_counter = 0;
                        element_counter = 0;
                        fifo_data_count = 0;
                        while (!$feof(e1) && (TRANSDUCER_ELEMENTS_Y == 1 || !$feof(e2)))
                        begin
                            ret_code = $fscanf(e1, "%b\n", echo_sample1);
                            echo_data[echo_counter][element_counter][DATA_WIDTH / 2 - 1 : 0] <= echo_sample1;
                            if (TRANSDUCER_ELEMENTS_Y > 1)
                            begin
                                ret_code = $fscanf(e2, "%b\n", echo_sample2);
                                echo_data[echo_counter][element_counter][DATA_WIDTH - 1 : DATA_WIDTH / 2] <= echo_sample2;
                            end
                            else
                            begin
                                echo_data[echo_counter][element_counter][DATA_WIDTH - 1 : DATA_WIDTH / 2] <= 'h0;
                            end
                            if (element_counter < TRANSDUCER_MEMORY_COUNT - 1)
                                element_counter = element_counter + 1;
                            else
                            begin
                                element_counter = 0;
                                if (echo_counter < BRAM_SAMPLES_PER_NAPPE - 1)
                                    echo_counter = echo_counter + 1;
                                else
                                    echo_counter = 0;
                            end
                        end
                        $fclose(e1);
                        $fclose(e2);
                        
                        NOP;
                    
                        if (USE_AXI_FIFO == 1)
                        begin
                            for (s = 0; s < BRAM_SAMPLES_PER_NAPPE; s ++)
                            begin
                                // TODO inflexible formatting (also in the loop below)
                                echo_data_shuffled[s][0] <= {echo_data[s][21][7 : 4], echo_data[s][17][15 : 4], echo_data[s][2][15 : 4], echo_data[s][6][15 : 4], echo_data[s][10][15 : 4], echo_data[s][14][15 : 4]};
                                echo_data_shuffled[s][1] <= {echo_data[s][41][11 : 4], echo_data[s][37][15 : 4], echo_data[s][33][15 : 4], echo_data[s][29][15 : 4], echo_data[s][25][15 : 4], echo_data[s][21][15 : 8]};
                                echo_data_shuffled[s][2] <= {echo_data[s][50][15 : 4], echo_data[s][54][15 : 4], echo_data[s][58][15 : 4], echo_data[s][62][15 : 4], echo_data[s][45][15 : 4], echo_data[s][41][15 : 12]};

                                echo_data_shuffled[s][3] <= {echo_data[s][23][7 : 4], echo_data[s][19][15 : 4], echo_data[s][0][15 : 4], echo_data[s][4][15 : 4], echo_data[s][8][15 : 4], echo_data[s][12][15 : 4]};
                                echo_data_shuffled[s][4] <= {echo_data[s][43][11 : 4], echo_data[s][39][15 : 4], echo_data[s][35][15 : 4], echo_data[s][31][15 : 4], echo_data[s][27][15 : 4], echo_data[s][23][15 : 8]};
                                echo_data_shuffled[s][5] <= {echo_data[s][48][15 : 4], echo_data[s][52][15 : 4], echo_data[s][56][15 : 4], echo_data[s][60][15 : 4], echo_data[s][47][15 : 4], echo_data[s][43][15 : 12]};

                                echo_data_shuffled[s][6] <= {echo_data[s][20][7 : 4], echo_data[s][16][15 : 4], echo_data[s][3][15 : 4], echo_data[s][7][15 : 4], echo_data[s][11][15 : 4], echo_data[s][15][15 : 4]};
                                echo_data_shuffled[s][7] <= {echo_data[s][40][11 : 4], echo_data[s][36][15 : 4], echo_data[s][32][15 : 4], echo_data[s][28][15 : 4], echo_data[s][24][15 : 4], echo_data[s][20][15 : 8]};
                                echo_data_shuffled[s][8] <= {echo_data[s][51][15 : 4], echo_data[s][55][15 : 4], echo_data[s][59][15 : 4], echo_data[s][63][15 : 4], echo_data[s][44][15 : 4], echo_data[s][40][15 : 12]};

                                echo_data_shuffled[s][9] <= {echo_data[s][22][7 : 4], echo_data[s][18][15 : 4], echo_data[s][1][15 : 4], echo_data[s][5][15 : 4], echo_data[s][9][15 : 4], echo_data[s][13][15 : 4]};
                                echo_data_shuffled[s][10] <= {echo_data[s][42][11 : 4], echo_data[s][38][15 : 4], echo_data[s][34][15 : 4], echo_data[s][30][15 : 4], echo_data[s][26][15 : 4], echo_data[s][22][15 : 8]};
                                echo_data_shuffled[s][11] <= {echo_data[s][49][15 : 4], echo_data[s][53][15 : 4], echo_data[s][57][15 : 4], echo_data[s][61][15 : 4], echo_data[s][46][15 : 4], echo_data[s][42][15 : 12]};
                            end
                            fifo_data_count = 12 * BRAM_SAMPLES_PER_NAPPE;
                        end
                    
                        NOP;
                            
                        // Iterate most frequently on the elements, and once a whole set of samples is written in,
                        // switch to the next set of samples
                        for (s = 0; s < BRAM_SAMPLES_PER_NAPPE; s ++)
                        begin
                            sample_index <= s;
                            if (USE_AXI_FIFO == 0)
                            begin
                                for (t = 0; t < TRANSDUCER_MEMORY_COUNT; t ++)
                                begin
                                    transducer_index <= t;
                                    TRANS_REQUEST(WRITE, .address(BRAM_REGISTER), .exp_rdata(32'hX), .in_wdata(echo_data[s][t]));
                                end
                            end
                            else
                            begin
                                for (t = 0; t < 12; t ++)
                                begin
                                    transducer_index <= t;
                                    FIFO_INJECT(.data(echo_data_shuffled[s][t]));
                                end
                            end
                        end
                    end
                end
                else // FILL_FROM_FILE == 0
                begin
                    // Just to locate this more easily on waveforms
                    for (wait_index = 0; wait_index < 100; wait_index ++)
                        @(posedge clk);
                end
                // ... or else, rely on pre-loaded data into the BRAMs.

                if (STREAMING_RF_INPUT == 0)
                begin
                    // Now tell the beamformer to start working on the nappe by issuing a Command Register
                    // transaction with bit 0 at 1
                    TRANS_REQUEST(WRITE, .address(COMMAND_REGISTER), .exp_rdata(32'hX), .in_wdata(32'h1));
                end
                // Else, the beamformer is figuring out when to start beamforming on its own, as data comes in.
                    
                // The beamformer logic will take a while to compute the nappe. Now monitor the Status Register until
                // we detect that the beamformer has finished one nappe and written it out to DDR. The nappe count is
                // indicated by bits 31:16.
                // When a nappe is ready, read from the FIFO all the ready voxels.
                // As voxels come out ready, we store them for later comparison.
                azimuth_pointer = 'h0;
                elevation_pointer = 'h0;
                // Check if the count of finished nappes has gone up
                old_returned_data = returned_data;
                while (old_returned_data[31 : 16] == returned_data[31 : 16])
                begin
                    // Wait until there is a done nappe. While waiting,
                    // either busy_bit == 1 (the beamformer is still churning) or ready_bit == 1
                    // (the beamformer processed the last voxel and is ready for the next nappe).
                    BLOCKING_READ(.address(STATUS_REGISTER), .ret_rdata(returned_data));
                    
                    busy_bit = returned_data[1];
                    ready_bit = returned_data[0];
                    if ((busy_bit && ready_bit) || (~busy_bit && ~ready_bit))
                    begin
                        $display("ERROR: the beamformer cannot be both busy and ready, or neither, at %0t", $time);
                        error_count = error_count + 1;
                    end
                end
            end

            // Wait ample time to give the nappe buffer/master time to write everything out
            for (wait_index = 0; wait_index < 10 * NAPPE_BUFFER_DEPTH * AZIMUTH_LINES * ELEVATION_LINES; wait_index ++)
                NOP;

            // Now verify that indeed the beamformer is done.
            TRANS_REQUEST(READ, .address(STATUS_REGISTER), .exp_rdata({31'hX, 1'b1}), .in_wdata(32'hX));
            
            NOP;
            NOP;
            NOP;

            $display("================= End of Iteration %03d/%03d at %0t", iteration_index + 1, iterations, $time);

            NOP;
            NOP;
            NOP;
            NOP;
            WAIT_ALL_PENDING;
                
        end // for iteration_index

        for (nappe_index = 0; nappe_index < RADIAL_LINES; nappe_index ++)
        begin
            $display("========= Collecting nappe %d at %0t", nappe_index, $time);
            
            // ----------------------------
            // Zone imaging post-processing
            // ----------------------------
            if (`COMPOUND_NOT_ZONE == 0)
            begin
                // Identify the min-value voxel across all zones of this nappe.
                // This helps us fill in incomplete nappes (i.e. because we have only
                // processed a part of the zones) to display a sensible image
                min_voxel = 32768;
                for (a = 0; a < ZONE_COUNT; a ++)
                begin
                    $sformat(nappe_filename, "%s/sim_nappes/%s_nappe_%0d_zone_%0d.txt", path, BENCHMARK, nappe_index + 1, a + 1);
                    file_pointers[a] = $fopen(nappe_filename, "r");
                    if (file_pointers[a] != 0)
                    begin
                        for (b = 0; b < ELEVATION_LINES / `ELEVATION_ZONES * AZIMUTH_LINES / `AZIMUTH_ZONES; b ++)
                        begin
                            ret_code = $fscanf(file_pointers[a], "%f", voxel);  
                            if (voxel < min_voxel)
                                min_voxel = voxel;
                        end
                        // Rewind the file pointer so that when we read from it later, it's from the beginning
                        ret_code = $rewind(file_pointers[a]);
                    end
                end
                
                // Save a complete nappe to disk.
                $sformat(nappe_filename, "%s/sim_nappes/%s_nappe_%0d.txt", path, BENCHMARK, nappe_index + 1);
                f = $fopen(nappe_filename, "w");
                for (i = 0; i < AZIMUTH_LINES; i ++)
                begin
                    for (j = 0; j < ELEVATION_LINES; j ++)
                    begin
                        zone_index = `AZIMUTH_ZONES * (j / (ELEVATION_LINES / `ELEVATION_ZONES)) + (i / (AZIMUTH_LINES / `AZIMUTH_ZONES));
                        if (file_pointers[zone_index] != 0)
                            ret_code = $fscanf(file_pointers[zone_index], "%f", voxel);
                        else
                            voxel = min_voxel;
                        $fwrite(f, "%.2f\n", voxel);
                    end
                end
                $fclose(f);
                
                for (a = 0; a < ZONE_COUNT; a ++)
                     $fclose(file_pointers[a]);
            end
            // --------------------------------
            // Compound imaging post-processing
            // --------------------------------
            else
            begin
                // Implements a simple averaging scheme over COMPOUND_COUNT frames
                $sformat(nappe_filename, "%s/sim_nappes/%s_nappe_%0d.txt", path, BENCHMARK, nappe_index + 1);
                f = $fopen(nappe_filename, "w");
                
                for (a = 0; a < COMPOUND_COUNT; a ++)
                begin
                    $sformat(nappe_filename, "%s/sim_nappes/%s_nappe_%0d_compounding_%0d.txt", path, BENCHMARK, nappe_index + 1, a + 1);
                    file_pointers[a] = $fopen(nappe_filename, "r");
                end
        
                for (i = 0; i < AZIMUTH_LINES * ELEVATION_LINES; i ++)
                begin
                    avg_voxel = 0;
                    compound_total = 0;
                    for (a = 0; a < COMPOUND_COUNT; a ++)
                    begin
                        if (file_pointers[a] != 0)
                        begin
                            ret_code = $fscanf(file_pointers[a], "%f", voxel);                                                                                  
                            avg_voxel = avg_voxel + voxel;
                            compound_total ++;
                        end
                    end
                    avg_voxel = avg_voxel / compound_total;
                    $fwrite(f, "%f\n", avg_voxel);
                end
                $fclose(f);
        
                for (a = 0; a < COMPOUND_COUNT; a ++)
                    $fclose(file_pointers[a]);
            end
        end

        $display("================= End of Testing at %0t", $time);

        NOP;
        NOP;
        NOP;
        NOP;
        WAIT_ALL_PENDING;

        $display("INFO: total %d errors in execution", error_count);

        $stop();

    end

endmodule
