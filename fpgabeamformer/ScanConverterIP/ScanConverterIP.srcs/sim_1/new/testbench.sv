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
`include "../../sources_1/new/sc_parameters.v"

// `define DEBUG

module testbench();

    // Whether to operate in master or slave mode
    // (SC automatically gets its input focal points and puts its pixels,
    // vs. having the Microblaze push and pull the same data)
    localparam SC_MASTER_MODE          = 1;
    // Size of the output image
    localparam IMG_WIDTH               = 32'd38;
    localparam IMG_HEIGHT              = 32'd32;
    localparam CUT_AZI_RAD    = 2'b00;
    localparam CUT_ELE_AZI    = 2'b01;
    localparam CUT_ELE_RAD    = 2'b10;
    localparam CUT_DIRECTION           = CUT_AZI_RAD;
    localparam CUT_VALUE               = (`SC_ELEVATION_LINES / 2);
//    localparam CUT_DIRECTION           = CUT_ELE_AZI;
//    localparam CUT_VALUE               = (`SC_RADIAL_LINES / 2);
//    localparam CUT_DIRECTION           = CUT_ELE_RAD;
//    localparam CUT_VALUE               = (`SC_AZIMUTH_LINES / 2);
    localparam LC_DB                   = 32'd45;
    localparam MAX_VOXEL               = 32'd0; //32'd100000; // Maximum brightness of an input BF voxel. Set to <= 0 for auto detection
    localparam DDR_ADDRESS             = 32'h80000000;
    localparam ADDR_WAIT_CYCLES        = 0;             // By how many cycles to delay AXI address transaction AR/AWREADY (TODO 0 gets 1 WS)
    localparam DATA_WAIT_CYCLES        = 1;             // By how many cycles to delay AXI data transaction WREADY
    localparam ADDRESS_WIDTH           = 32;
    localparam DATA_WIDTH              = 32;
    localparam INPUT_DELAY             = 0.25;          // By how much to delay inputs to the testbench
    localparam CLOCK_PERIOD            = 10;
    localparam WRITE                   = 1;
    localparam READ                    = 0;
    localparam ELEVATION_LINES         = `SC_ELEVATION_LINES;
    localparam AZIMUTH_LINES           = `SC_AZIMUTH_LINES;
    localparam RADIAL_LINES            = `SC_RADIAL_LINES;
    localparam BENCHMARK               = `BENCHMARK;
    static string path                 = `SIM_PATH;
    // Register map
    localparam STATUS_REGISTER         = 32'h00000000;
    localparam START_REGISTER          = 32'h00000004;
    localparam CUT_DIRECTION_REGISTER  = 32'h00000008;
    localparam MODE_REGISTER           = 32'h0000000C;
    localparam IN_VOXEL_REGISTER       = 32'h00000010;
    localparam SC_PIXEL_REGISTER       = 32'h00000014;
    localparam OUT_WIDTH_REGISTER      = 32'h00000018;
    localparam OUT_HEIGHT_REGISTER     = 32'h0000001C;
    localparam ELEVATION_REGISTER      = 32'h00000020;
    localparam AZIMUTH_REGISTER        = 32'h00000024;
    localparam RADIAL_REGISTER         = 32'h00000028;
    // unused                          = 32'h0000002C;
    localparam VERSION_REGISTER        = 32'h00000030;
    localparam DDR_IN_REGISTER         = 32'h00000034;
    localparam DDR_OUT_REGISTER        = 32'h00000038;
    localparam NEXT_PIXEL_REGISTER     = 32'h0000003C;
    localparam MAX_VOXEL_MODE_REGISTER = 32'h00000040;
    localparam MAX_VOXEL_REGISTER      = 32'h00000044;
    localparam LC_DB_REGISTER          = 32'h00000048;
    localparam CUT_VALUE_REGISTER      = 32'h0000004C;
    localparam INVALID_REGISTER        = 32'h00000100;
        
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
    
    // Signals to handle flow control
    // Response buffer (max 1 transaction may be pending)
    reg [DATA_WIDTH - 1 : 0]         response_data_queue;
    reg                              response_present;
    reg                              response_ttype;
    reg [ADDRESS_WIDTH - 1 : 0]      response_address;
    reg [DATA_WIDTH - 1 : 0]         returned_data;
    logic                            quit_simulation;
    integer                          error_count;

    reg [10 : 0]                         read_ctr = 'b0;
    reg signed [DATA_WIDTH - 1 : 0]      input_image[RADIAL_LINES - 1 : 0][ELEVATION_LINES - 1 : 0][AZIMUTH_LINES - 1 : 0];
    reg signed [DATA_WIDTH - 1 : 0]      input_memory[RADIAL_LINES * ELEVATION_LINES * AZIMUTH_LINES - 1 : 0];
    reg [31 : 0] input_memory_address;
    reg signed [DATA_WIDTH - 1 : 0]      output_image[IMG_HEIGHT - 1 : 0][IMG_WIDTH - 1 : 0];
    reg [`log2(IMG_HEIGHT - 1) - 1 : 0]  height_pointer;
    reg [`log2(IMG_WIDTH - 1) - 1 : 0]   width_pointer;
    reg [`max(0, `log2(ELEVATION_LINES - 1) - 1) : 0]  elevation_pointer;
    reg [`log2(AZIMUTH_LINES - 1) - 1 : 0]    azimuth_pointer;
    reg [`log2(RADIAL_LINES - 1) - 1 : 0]     radial_pointer;
    reg [7 : 0]                          pixel_output;
    integer                              aw_wait_count, ar_wait_count;
    
    integer fp, s, t, u, memptr;
    string filename;
    string nappe_filename;

    ScanConverterIP #(.C_S00_AXI_ID_WIDTH(1),
                      .C_S00_AXI_DATA_WIDTH(DATA_WIDTH),
                      .C_S00_AXI_ADDR_WIDTH(ADDRESS_WIDTH),
                      .C_S00_AXI_AWUSER_WIDTH(0),
                      .C_S00_AXI_ARUSER_WIDTH(0),
                      .C_S00_AXI_WUSER_WIDTH(0),
                      .C_S00_AXI_RUSER_WIDTH(0),
                      .C_S00_AXI_BUSER_WIDTH(0),
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
                else
                    $display("OK: detected matching response %x for address %x at %0t", response_data, response_address, $time);
            end
            else if (response_ttype == WRITE && bvalid)
            begin
                response_data = 'hX;
                $display("OK: detected write acceptance for address %x at %0t", response_address, $time);
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
    always @(posedge clk or negedge rstn)  
    begin
        if (rstn == 1'b0)
        begin
            height_pointer <= 'h0;
            width_pointer <= 'h0;
        end
        else if (m_wready == 1'b1 && m_wvalid == 1'b1)
        begin
            // TODO relies on knowing the output size and does not check the master's awaddr output at all
            output_image[height_pointer][width_pointer] = m_wdata;
            if (width_pointer == IMG_WIDTH - 1)
            begin
                width_pointer <= 'h0;
                if (height_pointer == IMG_HEIGHT - 1)
                begin
                    height_pointer <= 'h0;

                    // Save the image to disk.
                    $sformat(filename, "%s/%s_output.txt", path, BENCHMARK);
                    fp = $fopen(filename, "w");
                    for (s = 0; s < IMG_HEIGHT; s = s + 1)
                    begin
                        for (t = 0; t < IMG_WIDTH; t = t + 1)
                        begin
                            // The voxels generated by the master mode are encoded in ARGB.
                            // Each of the bottom three bytes contains the same gray level value.
                            $fwrite(fp, "%d,", output_image[s][t][7 : 0]);
                        end
                        $fwrite(fp, "\n");
                    end
                    $fclose(fp);
                end
                else
                begin
                    height_pointer <= height_pointer + 1;
                end
            end
            else
            begin
                width_pointer <= width_pointer + 1;
            end
        end
    end
    
    // ================================================
    // Read handling
    // ================================================ 
    always @(posedge clk)  
    begin
        if (rstn == 0)
        begin
            input_memory_address = 'h0;
            m_rdata = 'hX;
            m_rvalid = 1'b0;
            m_rresp = 2'bXX;
            m_rlast = 1'b0;
            elevation_pointer = 'h0;
            azimuth_pointer = 'h0;
            radial_pointer = 'h0;
        end
        else
        begin
            if (m_arready == 1'b1 && m_arvalid == 1'b1 && m_rvalid == 1'b0)
            begin
                //m_rdata = input_image[radial_pointer][elevation_pointer][azimuth_pointer];
                input_memory_address = (m_araddr - (DDR_ADDRESS + 32'h40000000)) / 4;
                m_rdata = input_memory[input_memory_address];
                m_rvalid = 1'b1;
                m_rresp = 2'b00;
                m_rlast = 1'b1;
            end
            else if (m_rvalid == 1'b1 && m_rready == 1'b1)
            begin
                if (elevation_pointer < ELEVATION_LINES - 1)
                    elevation_pointer = elevation_pointer + 'h1;
                else // elevation_pointer == ELEVATION_LINES - 1;
                begin
                    elevation_pointer = 'h0;
                    if (azimuth_pointer < AZIMUTH_LINES - 1)
                        azimuth_pointer = azimuth_pointer + 'h1;
                    else // azimuth_pointer == AZIMUTH_LINES - 1;
                    begin
                        azimuth_pointer = 'h0;
                        if (radial_pointer < RADIAL_LINES - 1)
                            radial_pointer = radial_pointer + 'h1;
                        else // radial_pointer == RADIAL_LINES - 1;
                        begin
                            radial_pointer = 'h0;
                        end
                    end
                end
                m_rdata = {DATA_WIDTH{1'bX}};
                m_rvalid = 1'b0;
                m_rresp = 2'bXX;
                m_rlast = 1'b0;
            end
        end
    end

    // ================================================
    // Utility functions
    // ================================================

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
    // Provide semi-slow flow control to the AXI Master port (read side) to test the timing
    // ================================================
    always @(posedge clk)
    begin
        if (rstn == 1'b0)
        begin
            ar_wait_count = ADDR_WAIT_CYCLES;
            m_arready <= 1'b0;
        end
        else
        begin
            if (m_arvalid == 1'b1 && m_arready == 1'b0)
            begin
                if (ar_wait_count == 0)
                begin
                    ar_wait_count = ADDR_WAIT_CYCLES;
                    m_arready <= 1'b1;
                end
                else
                begin
                    ar_wait_count = ar_wait_count - 1;
                end
            end
            else
                m_arready <= 1'b0;
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
        NOP();           // Initializes inputs and waits until next clock edge
        #(INPUT_DELAY);
        rstn <= 1'b0;    // Trigger reset
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        #(INPUT_DELAY);
        rstn <= 1'b1;   // Ready for operation now
        @(posedge clk);
        @(posedge clk);

        error_count = 0;

        $display("================= Starting Test Initialization & Configuration Interface at %0t", $time);

        // Read to illegal address should return special value
        BLOCKING_READ(.address(INVALID_REGISTER), .ret_rdata(returned_data));
        if (returned_data != 'hdeadbeef)
        begin
            $display("ERROR: unexpected response %x at %0t", returned_data, $time);
            error_count = error_count + 1;
        end
        
        // Read to version register should return special value
        BLOCKING_READ(.address(VERSION_REGISTER), .ret_rdata(returned_data));
        if (returned_data != 'hcafe145)
        begin
            $display("ERROR: unexpected response %x at %0t", returned_data, $time);
            error_count = error_count + 1;
        end
        
        // Block configuration. These are done by "scanconv_configure()" on the MB
        TRANS_REQUEST(WRITE, .address(RADIAL_REGISTER), .exp_rdata(32'hX), .in_wdata(RADIAL_LINES));
        TRANS_REQUEST(WRITE, .address(AZIMUTH_REGISTER), .exp_rdata(32'hX), .in_wdata(AZIMUTH_LINES));
        TRANS_REQUEST(WRITE, .address(ELEVATION_REGISTER), .exp_rdata(32'hX), .in_wdata(ELEVATION_LINES));
        TRANS_REQUEST(WRITE, .address(OUT_WIDTH_REGISTER), .exp_rdata(32'hX), .in_wdata(IMG_WIDTH));
        TRANS_REQUEST(WRITE, .address(OUT_HEIGHT_REGISTER), .exp_rdata(32'hX), .in_wdata(IMG_HEIGHT));
        if (SC_MASTER_MODE == 1)
        begin
			TRANS_REQUEST(WRITE, .address(DDR_IN_REGISTER), .exp_rdata(32'hX), .in_wdata(DDR_ADDRESS + 32'h40000000));
            TRANS_REQUEST(WRITE, .address(DDR_OUT_REGISTER), .exp_rdata(32'hX), .in_wdata(DDR_ADDRESS + 32'h08000000));
            TRANS_REQUEST(WRITE, .address(CUT_DIRECTION_REGISTER), .exp_rdata(32'hX), .in_wdata(CUT_DIRECTION));
            TRANS_REQUEST(WRITE, .address(CUT_VALUE_REGISTER), .exp_rdata(32'hX), .in_wdata(CUT_VALUE));
            TRANS_REQUEST(WRITE, .address(MODE_REGISTER), .exp_rdata(32'hX), .in_wdata(32'h1)); // Master mode
        end
        else
            TRANS_REQUEST(WRITE, .address(MODE_REGISTER), .exp_rdata(32'hX), .in_wdata(32'h5)); // Slave mode (value-by-value input)
        // Block configuration. These are done by "run_scanconversion()" on the MB
        TRANS_REQUEST(WRITE, .address(LC_DB_REGISTER), .exp_rdata(32'hX), .in_wdata(LC_DB));
        if (MAX_VOXEL > 'h0)
        begin
            TRANS_REQUEST(WRITE, .address(MAX_VOXEL_MODE_REGISTER), .exp_rdata(32'hX), .in_wdata(1'd1)); //Bit 0: 1 indicates that the lc_max_value in 0x44 will be used for the log compression
            TRANS_REQUEST(WRITE, .address(MAX_VOXEL_REGISTER), .exp_rdata(32'hX), .in_wdata(MAX_VOXEL)); // lc_max_value
        end
        else
        begin
            TRANS_REQUEST(WRITE, .address(MAX_VOXEL_MODE_REGISTER), .exp_rdata(32'hX), .in_wdata(1'd0)); //Bit 0: 0 indicates that the max voxel in the image will be used for the log compression
            TRANS_REQUEST(WRITE, .address(START_REGISTER), .exp_rdata(32'hX), .in_wdata('h20)); // Clears the auto-detected value of the previous scan-conversion
        end
        NOP;
        
        // Send inputs to the SC. This is done by "load_nappe_data_scanconv()" on the MB.
        memptr = 0;
        for (s = 1; s <= RADIAL_LINES; s = s + 1)
        begin: for_write
            integer ret_val;
            real read_val;
            integer file_ptr;
            // $sformat(nappe_filename, "%s/matlab_nappes/%s_nappe_%0d.txt", path, BENCHMARK, s);
            $sformat(nappe_filename, "%s/sim_nappes/%s_nappe_%0d.txt", path, BENCHMARK, s);
            file_ptr = $fopen(nappe_filename, "r");
            
            if (file_ptr == 0)
            begin
                $display("Error: cannot find nappe file %s", nappe_filename);
                $stop();
            end
            $display("Reading data from nappe file %s", nappe_filename);
            
            for (u = 0; u < AZIMUTH_LINES; u = u + 1)
            begin
                for (t = 0; t < ELEVATION_LINES; t = t + 1)
                begin
                    ret_val = $fscanf(file_ptr, "%f\n", read_val);
                    if (ret_val != 1)
                    begin
                        $error("ERROR: unexpected error or end of file in file %s at r=%d a=%d e=%d", nappe_filename, s, u, t);
                    end
                    input_image[s - 1][t][u] = read_val * 4; // The files on disk contain numbers with 2 decimal bits = 0.25 resolution
                    input_memory[memptr] = read_val * 4;
                    memptr = memptr + 1;
                    if (SC_MASTER_MODE == 0)
                    begin
                        if ((CUT_DIRECTION == CUT_AZI_RAD && t == CUT_VALUE) ||
                            (CUT_DIRECTION == CUT_ELE_AZI && s == CUT_VALUE) ||
                            (CUT_DIRECTION == CUT_ELE_RAD && u == CUT_VALUE))
                        begin
                            TRANS_REQUEST(WRITE, .address(IN_VOXEL_REGISTER), .exp_rdata(32'hX), .in_wdata(read_val * 4));
                        end
                        NOP;
                    end
                end
            end
            $fclose(file_ptr);
        end
        
        // Start the Scan Converter. This is done by "start_scanconv()" on the MB
        if (SC_MASTER_MODE == 1)
            TRANS_REQUEST(WRITE, .address(START_REGISTER), .exp_rdata(32'hX), .in_wdata('h10)); 
        else
            TRANS_REQUEST(WRITE, .address(START_REGISTER), .exp_rdata(32'hX), .in_wdata('h4)); 
        NOP;
        
        // Wait for end of processing by polling the Status Register
        do
        begin
            t = 'h0;
            BLOCKING_READ(.address(STATUS_REGISTER), .ret_rdata(t));
        end
        while ((SC_MASTER_MODE == 1 && t[7] == 'b0) || (SC_MASTER_MODE == 0 && t[3] == 'b1));
        // Master mode and still ongoing, or slave mode and log compression still ongoing
        
        // Read back the data. This is done by "output_nappes()" on the MB
        if (SC_MASTER_MODE == 0)
        begin
            $sformat(filename, "%s/%s_output.txt", path, BENCHMARK);
            fp = $fopen(filename, "w");
            for (s = 0; s < IMG_HEIGHT; s = s + 1)
            begin
                for (t = 0; t < IMG_WIDTH; t = t + 1)
                begin
                    // Wait for a ready pixel
                    do
                    begin
                        u = 0;
                        BLOCKING_READ(.address(STATUS_REGISTER), .ret_rdata(u)); //read status register
                    end
                    while (u[2] != 1'b1); // -> Until there is a ready pixel
    
                    // Read the SC pixel, then write it to file
                    BLOCKING_READ(.address(SC_PIXEL_REGISTER), .ret_rdata(pixel_output));
                    read_ctr <= read_ctr + 1;
                    output_image[s][t] = pixel_output;
                    $fwrite(fp, "%d,", pixel_output);
                    NOP;
                    
                    // Ask the SC to move to the next pixel
                    TRANS_REQUEST(WRITE, .address(NEXT_PIXEL_REGISTER), .exp_rdata(32'hX), .in_wdata('b1));
                end
                $fwrite(fp, "\n");
            end
            $fclose(fp);
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
