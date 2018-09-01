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

`timescale 1 ns / 1 ps
`include "./utilities.v"
`include "./parameters.v"

module BeamformerIP_M00_AXI #
(
    // Users to add parameters here
    // User parameters ends

    // Do not modify the parameters beyond this line    
    // Base address of targeted slave
    parameter  C_M_TARGET_SLAVE_BASE_ADDR   = 32'hC0000000,
    // Burst Length. Supports 1, 2, 4, 8, 16, 32, 64, 128, 256 burst lengths
    parameter integer C_M_AXI_BURST_LEN     = 8,
    // Thread ID Width
    parameter integer C_M_AXI_ID_WIDTH      = 1,
    // Width of Address Bus
    parameter integer C_M_AXI_ADDR_WIDTH    = 32,
    // Width of Data Bus
    parameter integer C_M_AXI_DATA_WIDTH    = 32,
    // Width of User Write Address Bus
    parameter integer C_M_AXI_AWUSER_WIDTH  = 0,
    // Width of User Read Address Bus
    parameter integer C_M_AXI_ARUSER_WIDTH  = 0,
    // Width of User Write Data Bus
    parameter integer C_M_AXI_WUSER_WIDTH   = 0,
    // Width of User Read Data Bus
    parameter integer C_M_AXI_RUSER_WIDTH   = 0,
    // Width of User Response Bus
    parameter integer C_M_AXI_BUSER_WIDTH   = 0,
    
    parameter integer TRANSDUCER_ELEMENTS_X = `TRANSDUCER_ELEMENTS_X,
    parameter integer TRANSDUCER_ELEMENTS_Y = `TRANSDUCER_ELEMENTS_Y,
    parameter integer ELEVATION_LINES = `ELEVATION_LINES,
    parameter integer AZIMUTH_LINES = `AZIMUTH_LINES,
    parameter integer RADIAL_LINES = `RADIAL_LINES
    )
    (
    // Users to add ports here
    input  wire [31 : 0] fifo_data,
    input  wire fifo_output_valid,
    output wire fifo_output_ready,

    input  wire [3 : 0] azimuth_zones,
    input  wire [3 : 0] elevation_zones,
    input  wire compound_not_zone_imaging,
    input  wire [6 : 0] run_cnt,
    input  wire [6 : 0] zone_width,
    input  wire [6 : 0] zone_height,
    output reg [15 : 0] saved_nappes,
    // User ports ends
    // Do not modify the ports beyond this line
    
    // Global Clock Signal.
    input wire  M_AXI_ACLK,
    // Global Reset Singal. This Signal is Active Low
    input wire  M_AXI_ARESETN,
    // Master Interface Write Address ID
    output wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_AWID,
    // Master Interface Write Address
    output wire [C_M_AXI_ADDR_WIDTH-1 : 0] M_AXI_AWADDR,
    // Burst length. The burst length gives the exact number of transfers in a burst
    output wire [7 : 0] M_AXI_AWLEN,
    // Burst size. This signal indicates the size of each transfer in the burst
    output wire [2 : 0] M_AXI_AWSIZE,
    // Burst type. The burst type and the size information, 
    // determine how the address for each transfer within the burst is calculated.
    output wire [1 : 0] M_AXI_AWBURST,
    // Lock type. Provides additional information about the
    // atomic characteristics of the transfer.
    output wire  M_AXI_AWLOCK,
    // Memory type. This signal indicates how transactions
    // are required to progress through a system.
    output wire [3 : 0] M_AXI_AWCACHE,
    // Protection type. This signal indicates the privilege
    // and security level of the transaction, and whether
    // the transaction is a data access or an instruction access.
    output wire [2 : 0] M_AXI_AWPROT,
    // Quality of Service, QoS identifier sent for each write transaction.
    output wire [3 : 0] M_AXI_AWQOS,
    // Write address valid. This signal indicates that
    // the channel is signaling valid write address and control information.
    output wire  M_AXI_AWVALID,
    // Write address ready. This signal indicates that
    // the slave is ready to accept an address and associated control signals
    input wire  M_AXI_AWREADY,
    // Master Interface Write Data.
    output wire [C_M_AXI_DATA_WIDTH-1 : 0] M_AXI_WDATA,
    // Write strobes. This signal indicates which byte
    // lanes hold valid data. There is one write strobe
    // bit for each eight bits of the write data bus.
    output wire [C_M_AXI_DATA_WIDTH/8-1 : 0] M_AXI_WSTRB,
    // Write last. This signal indicates the last transfer in a write burst.
    output wire  M_AXI_WLAST,
    // Write valid. This signal indicates that valid write
    // data and strobes are available
    output wire  M_AXI_WVALID,
    // Write ready. This signal indicates that the slave
    // can accept the write data.
    input wire  M_AXI_WREADY,
    // Master Interface Write Response.
    input wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_BID,
    // Write response. This signal indicates the status of the write transaction.
    input wire [1 : 0] M_AXI_BRESP,
    // Write response valid. This signal indicates that the
    // channel is signaling a valid write response.
    input wire  M_AXI_BVALID,
    // Response ready. This signal indicates that the master
    // can accept a write response.
    output wire  M_AXI_BREADY,
    // Master Interface Read Address.
    output wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_ARID,
    // Read address. This signal indicates the initial
    // address of a read burst transaction.
    output wire [C_M_AXI_ADDR_WIDTH-1 : 0] M_AXI_ARADDR,
    // Burst length. The burst length gives the exact number of transfers in a burst
    output wire [7 : 0] M_AXI_ARLEN,
    // Burst size. This signal indicates the size of each transfer in the burst
    output wire [2 : 0] M_AXI_ARSIZE,
    // Burst type. The burst type and the size information, 
    // determine how the address for each transfer within the burst is calculated.
    output wire [1 : 0] M_AXI_ARBURST,
    // Lock type. Provides additional information about the
    // atomic characteristics of the transfer.
    output wire  M_AXI_ARLOCK,
    // Memory type. This signal indicates how transactions
    // are required to progress through a system.
    output wire [3 : 0] M_AXI_ARCACHE,
    // Protection type. This signal indicates the privilege
    // and security level of the transaction, and whether
    // the transaction is a data access or an instruction access.
    output wire [2 : 0] M_AXI_ARPROT,
    // Quality of Service, QoS identifier sent for each read transaction
    output wire [3 : 0] M_AXI_ARQOS,
    // Write address valid. This signal indicates that
    // the channel is signaling valid read address and control information
    output wire  M_AXI_ARVALID,
    // Read address ready. This signal indicates that
    // the slave is ready to accept an address and associated control signals
    input wire  M_AXI_ARREADY,
    // Read ID tag. This signal is the identification tag
    // for the read data group of signals generated by the slave.
    input wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_RID,
    // Master Read Data
    input wire [C_M_AXI_DATA_WIDTH-1 : 0] M_AXI_RDATA,
    // Read response. This signal indicates the status of the read transfer
    input wire [1 : 0] M_AXI_RRESP,
    // Read last. This signal indicates the last transfer in a read burst
    input wire  M_AXI_RLAST,
    // Read valid. This signal indicates that the channel
    // is signaling the required read data.
    input wire  M_AXI_RVALID,
    // Read ready. This signal indicates that the master can
    // accept the read data and response information.
    output wire  M_AXI_RREADY
    );
    
    // function called clogb2 that returns an integer which has the 
    // value of the ceiling of the log base 2.                      
    function integer clogb2 (input integer bit_depth);              
    begin                                                           
        for (clogb2=0; bit_depth>0; clogb2=clogb2+1)                   
            bit_depth = bit_depth >> 1;                                 
        end                                                           
    endfunction                                                     
    
    // Width of the counter for write or read transaction in a burst.
    localparam integer C_TRANSACTIONS_NUM = clogb2(C_M_AXI_BURST_LEN - 1);
    
    // Burst length for transactions, in C_M_AXI_DATA_WIDTHs.
    // Non-2^n lengths will eventually cause bursts across 4K address boundaries.
    localparam integer C_MASTER_LENGTH = 14;
    // Total number of burst transfers is master length divided by burst length and burst size
    localparam integer C_NO_BURSTS_REQ = C_MASTER_LENGTH - clogb2((C_M_AXI_BURST_LEN * C_M_AXI_DATA_WIDTH / 8) - 1);

    // AXI 4 signals
    wire [C_M_AXI_ADDR_WIDTH - 1 : 0] axi_awaddr;
    reg  	                          axi_awvalid;
    wire [C_M_AXI_DATA_WIDTH - 1 : 0] axi_wdata;
    reg                               axi_wlast;
    reg                               axi_wvalid;
    reg                               axi_bready;
    reg [C_M_AXI_ADDR_WIDTH - 1 : 0]  axi_araddr;
    reg                               axi_arvalid;
    reg                               axi_rready;
    reg [C_TRANSACTIONS_NUM : 0]      write_index;    // Write beat count in a burst
    reg [C_TRANSACTIONS_NUM : 0]      read_index;     // Read beat count in a burst
    wire [C_TRANSACTIONS_NUM + 2 : 0] burst_size_bytes;
    reg [C_NO_BURSTS_REQ - 1 : 0]     write_burst_counter;
    reg                               start_burst_write, start_burst_read;
    reg                               burst_write_active, burst_read_active;
    wire                              write_resp_error, read_resp_error;    //Interface response error flags
    wire                              wnext, rnext;
    
    // User added wires and regs
    // Wires and regs for calculating the Write address
    wire [12 : 0] zone_area;                            // zone_width * zone_height
    reg [C_M_AXI_ADDR_WIDTH-1 : 0] curr_voxel;          // Tracks the current voxel in the current azimuth line of voxels
    reg [4 : 0] curr_comp;                              // Tracks the current compound volume
    reg [5 : 0] curr_elev;                              // Tracks the current elevation of the current azimuth line
    reg [9 : 0] curr_nappe;                             // Tracks the current nappe
    reg [3 : 0] curr_zone_azi;                          // Tracks the current zone in the azimuth axis
    reg [3 : 0] curr_zone_elev;                         // Tracks the current zone in the elevation axis
    reg [5 : 0] curr_zone;                              // Tracks the current zone out of total zones
    reg [C_M_AXI_ADDR_WIDTH-1 : 0] compound_offset;     // Value is the number of compound volumes to offset the write address value
    reg [C_M_AXI_ADDR_WIDTH-1 : 0] voxel_offset;        // Tracks the current voxel in the current azimuth line of voxels
    reg [C_M_AXI_ADDR_WIDTH-1 : 0] elev_offset;         // Value is the number of elevation lines to offset the write address value
    reg [C_M_AXI_ADDR_WIDTH-1 : 0] nappe_offset;        // Value is the number of nappes to offset the write address value
    reg [C_M_AXI_ADDR_WIDTH-1 : 0] zone_azi_offset;     // Value is the number of zones in the azimuth direction to offset the write address value                                                         
    reg [C_M_AXI_ADDR_WIDTH-1 : 0] zone_elev_offset;    // Value is the number of zones in the elevation to offset the write address value
    reg [12 : 0] saved_voxels;                          // Tracks number of saved voxels in the current nappe

    // The data from the beamformer is placed in a FIFO as deep as a burst length.
    // The FIFO must be full before starting an AXI write, and will be completely emptied.
    // This simplifies the AXI control logic.
    reg [31 : 0] voxel_fifo [C_M_AXI_BURST_LEN - 1 : 0];
    reg [C_TRANSACTIONS_NUM - 1 : 0] voxel_fifo_read_pointer;
    reg [C_TRANSACTIONS_NUM - 1 : 0] voxel_fifo_write_pointer;
    reg voxel_fifo_data_valid;
    integer i;
    always @(posedge M_AXI_ACLK)
    begin
        if (M_AXI_ARESETN == 1'b0)
        begin
            voxel_fifo_read_pointer <= 'h0;
            voxel_fifo_write_pointer <= 'h0;
            voxel_fifo_data_valid <= 1'b0;
            for (i = 0; i < C_M_AXI_BURST_LEN; i = i + 1)
                voxel_fifo[i] <= 'h0;
        end
        else
        begin
            // When a new input comes
            if (fifo_output_valid == 1'b1 && fifo_output_ready == 1'b1)
            begin
                voxel_fifo[voxel_fifo_write_pointer] <= fifo_data;
                if (voxel_fifo_write_pointer == C_M_AXI_BURST_LEN - 1)
                // Enable sending data on the AXI bus only when the FIFO is full
                // (simplifies control logic).
                    voxel_fifo_data_valid <= 1'b1;
                voxel_fifo_write_pointer <= (voxel_fifo_write_pointer + 1) % C_M_AXI_BURST_LEN;
            end
            
            // When an old output goes
            if (voxel_fifo_data_valid == 1'b1 && wnext == 1'b1)
            begin
                if (voxel_fifo_read_pointer == C_M_AXI_BURST_LEN - 1)
                    voxel_fifo_data_valid <= 1'b0;
                 voxel_fifo_read_pointer <= (voxel_fifo_read_pointer + 1) % C_M_AXI_BURST_LEN;
            end
        end
    end
    assign fifo_output_ready = ~(voxel_fifo_write_pointer == voxel_fifo_read_pointer && voxel_fifo_data_valid == 1'b1);
    assign axi_wdata = voxel_fifo[voxel_fifo_read_pointer];
    
    // I/O Connections. Write Address (AW)
    assign M_AXI_AWID     = 'b0;
    // The AXI address is a concatenation of the target base address + active offset range
    assign M_AXI_AWADDR   = C_M_TARGET_SLAVE_BASE_ADDR + axi_awaddr;
    // Burst LENgth is number of transaction beats, minus 1
    assign M_AXI_AWLEN    = C_M_AXI_BURST_LEN - 1;
    // Size should be C_M_AXI_DATA_WIDTH, in 2^SIZE bytes, otherwise narrow bursts are used
    assign M_AXI_AWSIZE   = clogb2((C_M_AXI_DATA_WIDTH/8)-1);
    // INCR burst type is usually used, except for keyhole bursts
    assign M_AXI_AWBURST  = 2'b01;
    assign M_AXI_AWLOCK   = 1'b0;
    // Update value to 4'b0011 if coherent accesses to be used via the Zynq ACP port. Not Allocated, Modifiable, not Bufferable. Not Bufferable since this example is meant to test memory, not intermediate cache. 
    assign M_AXI_AWCACHE  = 4'b0010;
    assign M_AXI_AWPROT   = 3'h0;
    assign M_AXI_AWQOS    = 4'h0;
    assign M_AXI_AWVALID  = axi_awvalid;
    // Write Data(W)
    assign M_AXI_WDATA    = axi_wdata;
    // All bursts are complete and aligned in this example
    assign M_AXI_WSTRB    = {(C_M_AXI_DATA_WIDTH/8){1'b1}};
    assign M_AXI_WLAST    = axi_wlast;
    assign M_AXI_WVALID   = axi_wvalid;
    // Write Response (B)
    assign M_AXI_BREADY   = axi_bready;
    // Read Address (AR)
    assign M_AXI_ARID     = 'b0;
    assign M_AXI_ARADDR   = C_M_TARGET_SLAVE_BASE_ADDR + axi_araddr;
    // Burst LENgth is number of transaction beats, minus 1
    assign M_AXI_ARLEN    = C_M_AXI_BURST_LEN - 1;
    // Size should be C_M_AXI_DATA_WIDTH, in 2^n bytes, otherwise narrow bursts are used
    assign M_AXI_ARSIZE   = clogb2((C_M_AXI_DATA_WIDTH/8)-1);
    // INCR burst type is usually used, except for keyhole bursts
    assign M_AXI_ARBURST  = 2'b01;
    assign M_AXI_ARLOCK   = 1'b0;
    // Update value to 4'b0011 if coherent accesses to be used via the Zynq ACP port. Not Allocated, Modifiable, not Bufferable. Not Bufferable since this example is meant to test memory, not intermediate cache. 
    assign M_AXI_ARCACHE  = 4'b0010;
    assign M_AXI_ARPROT   = 3'h0;
    assign M_AXI_ARQOS    = 4'h0;
    assign M_AXI_ARVALID  = axi_arvalid;
    // Read and Read Response (R)
    assign M_AXI_RREADY   = axi_rready;
    // Burst size in bytes
    assign burst_size_bytes	= C_M_AXI_BURST_LEN * C_M_AXI_DATA_WIDTH / 8;
    // How many voxels in a zone
    // TODO assumes that run_cnt is a power of 2
    assign zone_area = (compound_not_zone_imaging == 1) ? ELEVATION_LINES * AZIMUTH_LINES : (ELEVATION_LINES * AZIMUTH_LINES >> `log2(run_cnt - 1));

    //--------------------
    // Write Address Channel
    //--------------------
    // The purpose of the write address channel is to request the address and 
    // command information for the entire transaction.  It is a single beat
    // of information.
    // The AXI4 Write address channel in this example will continue to initiate
    // write commands as fast as it is allowed by the slave/interconnect.
    // The address will be incremented on each accepted address transaction,
    // by burst_size_byte to point to the next address.
    always @(posedge M_AXI_ACLK)
    begin
        if (M_AXI_ARESETN == 1'b0)
            axi_awvalid <= 1'b0;
        // If previously not valid, start next transaction
        else if (~axi_awvalid && start_burst_write)
            axi_awvalid <= 1'b1;
        // Once asserted, VALIDs cannot be deasserted, so axi_awvalid must wait until transaction is accepted
        else if (M_AXI_AWREADY)
            axi_awvalid <= 1'b0;
    end
    
    //------------------------
    // Write Address Calculator
    //------------------------
    // The purpose of the write address calculator is to track the current burst
    // of voxels in space and provide the correct write address to memory based
    // on the current zone, nappe, elevation line and location in the line
    always @(posedge M_AXI_ACLK)
    begin
        if (M_AXI_ARESETN == 0)
        begin
            curr_voxel <= 'h0;
            curr_elev <= 'h0;
            curr_comp <= 'h0;
            curr_nappe <= 'h0;
            curr_zone <= 'h0;
            curr_zone_azi <= 'h0;
            curr_zone_elev <= 'h0;

            voxel_offset <= 'h0;
            elev_offset <= 'h0;
            compound_offset <= 'h0;
            nappe_offset <= 'h0;
            zone_azi_offset <= 'h0;
            zone_elev_offset <= 'h0;
        end
        else if (M_AXI_AWREADY && axi_awvalid)
        begin
            // In 3D, we get elevation lines in the inner loop
            if (curr_voxel < zone_width / C_M_AXI_BURST_LEN - 1)        //The current burst of voxels in the current azimuth line, divided by burst length
            begin
                voxel_offset <= voxel_offset + burst_size_bytes;
                curr_voxel <= curr_voxel + 1;
            end
            else 
            begin    
                voxel_offset <= 'h0;
                curr_voxel <= 'h0;            
                if (curr_elev < zone_height - 1)                       //The current elevation line in the current zone and nappe, defined by the zone width (height)
                begin
                    elev_offset <= elev_offset + ELEVATION_LINES * C_M_AXI_DATA_WIDTH / 8;
                    curr_elev <= curr_elev + 1;
                end
                else
                begin
                    elev_offset <= 'h0;
                    curr_elev <= 'h0;
                    if (curr_nappe < RADIAL_LINES - 1)                             //The current nappe in the current zone
                    begin
                        nappe_offset <= nappe_offset + ELEVATION_LINES * AZIMUTH_LINES * C_M_AXI_DATA_WIDTH / 8;
                        curr_nappe <= curr_nappe + 1;
                    end
                    else
                    begin
                        nappe_offset <= 'h0;
                        curr_nappe <= 'h0;
                        if (compound_not_zone_imaging == 1)
                        begin
                            if (curr_comp < run_cnt - 1)
                            begin
                                curr_comp <= curr_comp + 1;
                                compound_offset <= compound_offset + (ELEVATION_LINES * AZIMUTH_LINES * RADIAL_LINES) * C_M_AXI_DATA_WIDTH / 8;
                            end
                            else
                            begin
                                curr_comp <= 'h0;
                                compound_offset <= 'h0;
                            end
                        end
                        else
                        begin
                            if (curr_zone < run_cnt - 1)                                                  //Current zone in the total number of zones
                            begin
                                curr_zone <= curr_zone + 1;
                                if (curr_zone_azi < azimuth_zones - 1)                                    //Current zone in the azimuth direction. Necessary to know because all
                                begin                                                                     //write addresses will need to be offset by the zone width 
                                    zone_azi_offset <= zone_azi_offset + ELEVATION_LINES * zone_width * C_M_AXI_DATA_WIDTH / 8;  //times the number of zones in the azimuth direction
                                    curr_zone_azi <= curr_zone_azi + 1;          
                                end
                                else                                            
                                begin
                                    zone_azi_offset <= 0;
                                    curr_zone_azi <= 0;
                                    if (curr_zone_elev < elevation_zones - 1)    // Current zone in the elevation direction. Necessary to know because all write addresses
                                    begin
                                        zone_elev_offset <= zone_elev_offset + zone_height * C_M_AXI_DATA_WIDTH / 8;
                                        curr_zone_elev <= curr_zone_elev + 1;    //will need to be offset by the TOTAL length of an azimuth line times the zone width (height)
                                    end
                                    else                                        //times the number of zones in the elevation direction
                                        zone_elev_offset <= 'h0;
                                        curr_zone_elev <= 'h0;
                                end
                            end
                            else
                            begin
                                curr_zone <= 'h0;
                                zone_azi_offset <= 'h0;
                                zone_elev_offset <= 'h0;
                                curr_zone_azi <= 'h0;
                                curr_zone_elev <= 'h0;
                            end
                        end
                    end
                end
            end
        end
    end                                                        
    
    // Next address after AWREADY indicates previous address acceptance    
    // The write address is the sum of:
    // - The base address of the compound image index, PLUS
    // - The offset of the nappe, PLUS
    // - If zone imaging, the offset of the azimuth line in this zone, PLUS
    // - If zone imaging, the offset of the elevation line in this zone, PLUS
    // - The offset of the elevation line, PLUS
    // - The voxel index in the azimuth line
    assign axi_awaddr = compound_offset + nappe_offset + zone_azi_offset + zone_elev_offset + elev_offset + voxel_offset;
    
    //--------------------
    // Write Data Channel
    //--------------------
    // The write data will continually try to push write data across the interface.
    // The amount of data accepted will depend on the AXI slave and the AXI
    // Interconnect settings, such as if there are FIFOs enabled in interconnect.
    // Note that there is no explicit timing relationship to the write address channel.
    // The write channel has its own throttling flag, separate from the AW channel.
    // Synchronization between the channels must be determined by the user.
    // The simpliest but lowest performance would be to only issue one address write
    // and write data burst at a time.
    // In this example they are kept in sync by using the same address increment
    // and burst sizes. Then the AW and W channels have their transactions measured
    // with threshold counters as part of the user logic, to make sure neither 
    // channel gets too far ahead of each other.
    // Forward movement occurs when the write channel is valid and ready
    assign wnext = M_AXI_WREADY & axi_wvalid;                                   
                                                                                    
    // WVALID logic, similar to the axi_awvalid always block above                      
    always @(posedge M_AXI_ACLK)                                                      
    begin                                                                             
        if (M_AXI_ARESETN == 1'b0)
            axi_wvalid <= 1'b0;
        // If previously not valid, start next transaction                              
        else if (~axi_wvalid && start_burst_write)
            axi_wvalid <= 1'b1;
        // If WREADY and too many writes, throttle WVALID
        // Once asserted, VALIDs cannot be deasserted, so WVALID
        // must wait until burst is complete with WLAST
        else if (wnext && axi_wlast)
            axi_wvalid <= 1'b0;
    end
    
    always @(posedge M_AXI_ACLK)                                                      
    begin                                                                             
        if (M_AXI_ARESETN == 1'b0)
            axi_wlast <= 1'b0;
        // axi_wlast is asserted when the write index                                   
        // count reaches the penultimate count to synchronize                           
        // with the last write data when write_index is b1111                           
        // else if (&(write_index[C_TRANSACTIONS_NUM-1:1])&& ~write_index[0] && wnext)  
        else if ((C_M_AXI_BURST_LEN == 1) || (C_M_AXI_BURST_LEN != 1 && write_index == C_M_AXI_BURST_LEN - 2 && wnext))
            axi_wlast <= 1'b1;
        // Deassert axi_wlast when the last write data has been                          
        // accepted by the slave with a valid response                                  
        else if (wnext || C_M_AXI_BURST_LEN == 1)
            axi_wlast <= 1'b0;
    end
    
    // Increments the register containing the number of saved voxels in the current nappe and the saved nappe counter
    always @(posedge M_AXI_ACLK)    
    begin
        if (M_AXI_ARESETN == 0)
        begin
            saved_voxels <= 'h0;
            saved_nappes <= 'h0;
        end
        else if (axi_wlast == 1 && M_AXI_WREADY == 1)                     // If the last burst has completed, increment the counter by the burst length
            // At the end of the current nappe reset the counter
            // Careful: at reset zone_area can briefly flash at 0
            if (zone_area != 0 && saved_voxels + C_M_AXI_BURST_LEN == zone_area)
            begin
                saved_voxels <= 'h0;
                saved_nappes <= saved_nappes + 1;
            end
            else
                saved_voxels <= saved_voxels + C_M_AXI_BURST_LEN;
        end
    
    // Burst length counter.
    always @(posedge M_AXI_ACLK)
    begin
        if (M_AXI_ARESETN == 1'b0)
            write_index <= 1'b0;
        else if (wnext)
            write_index <= (write_index + 1) % C_M_AXI_BURST_LEN;
    end
        
    //----------------------------
    // Write Response (B) Channel
    //----------------------------
    // The write response channel provides feedback that the write has committed
    // to memory. BREADY will occur when all of the data and the write address
    // has arrived and been accepted by the slave.
    // The write is started by the Address Write transfer, and is completed
    // by a BREADY/BRESP. BRESP[1] is used indicate any errors from the
    // interconnect or slave for the entire write burst.
    always @(posedge M_AXI_ACLK)
    begin
        if (M_AXI_ARESETN == 1'b0)
            axi_bready <= 1'b0;
        // Accept/acknowledge bresp with axi_bready by the master
        // Left asserted all the time.
        else
            axi_bready <= 1'b1;
    end
    
    // Flag any write response errors
    assign write_resp_error = axi_bready & M_AXI_BVALID & M_AXI_BRESP[1];
    
    //----------------------------
    // Read Address Channel
    //----------------------------
    // The Read Address Channel (AW) provides a similar function to the
    // Write Address channel- to provide the tranfer qualifiers for the burst.
    // The read address increments in the same manner as the write address channel.
    always @(posedge M_AXI_ACLK)
    begin
        if (M_AXI_ARESETN == 1'b0)
            axi_arvalid <= 1'b0;
        // If previously not valid, start next transaction
        else if (~axi_arvalid && start_burst_read)
            axi_arvalid <= 1'b1;
        else if (M_AXI_ARREADY && axi_arvalid)
            axi_arvalid <= 1'b0;
    end
    
    // Next address after ARREADY indicates previous address acceptance
    always @(posedge M_AXI_ACLK)
    begin
        if (M_AXI_ARESETN == 1'b0)
            axi_araddr <= 'h0;
        else if (M_AXI_ARREADY && axi_arvalid)
            axi_araddr <= axi_araddr + burst_size_bytes;
    end
    
    //--------------------------------
    //Read Data (and Response) Channel
    //--------------------------------
    // Forward movement occurs when the channel is valid and ready
    assign rnext = M_AXI_RVALID && axi_rready;
    
    // Burst length counter
    always @(posedge M_AXI_ACLK)
    begin
        if (M_AXI_ARESETN == 1'b0)
            read_index <= 1'b0;
        else if (rnext)
            read_index <= (read_index + 1) % C_M_AXI_BURST_LEN;
    end
    
    // The Read Data channel returns the results of the read request
    // In this example we are always able to accept more data, so no need to throttle the RREADY signal
    always @(posedge M_AXI_ACLK)
    begin
        if (M_AXI_ARESETN == 1'b0)
            axi_rready <= 1'b0;
        // accept/acknowledge rdata/rresp with axi_rready by the master
        // when M_AXI_RVALID is asserted by slave
        else if (M_AXI_RVALID)
        begin
            if (M_AXI_RLAST && axi_rready)
                axi_rready <= 1'b0;
            else
                axi_rready <= 1'b1;
        end
    end
    
    // Flag any read response errors
    assign read_resp_error = axi_rready & M_AXI_RVALID & M_AXI_RRESP[1];
    
    always @(posedge M_AXI_ACLK)
    begin
        if (M_AXI_ARESETN == 1'b0)
            write_burst_counter <= 'b0;
        else if (M_AXI_AWREADY && axi_awvalid)
            // TODO Seems to assume zone_area is a multiple of CMABL
            write_burst_counter <= (write_burst_counter + 1'b1) % (zone_area / C_M_AXI_BURST_LEN);
    end
    
    // Master command interface state machine
    always @(posedge M_AXI_ACLK)
    begin
        if (M_AXI_ARESETN == 1'b0)
        begin
            start_burst_write <= 1'b0;
            start_burst_read  <= 1'b0;
        end
        else
        begin
            // Trigger operations when there is input data (voxel_fifo_data_valid)
            if (voxel_fifo_data_valid && ~axi_awvalid && ~start_burst_write && ~burst_write_active)
                start_burst_write <= 1'b1;
            else
                start_burst_write <= 1'b0; //Negate to generate a pulse
            
            // Some logic here to initiate reads, if necessary.
            // if (~axi_arvalid && ~burst_read_active && ~start_burst_read)
            //     start_burst_read <= 1'b1;
            // else
            //     start_burst_read <= 1'b0; //Negate to generate a pulse
        end
    end
    
    // burst_write_active signal is asserted when there is a burst write transaction
    // is initiated by the assertion of start_burst_write. burst_write_active
    // remains asserted until the burst write is accepted by the slave
    always @(posedge M_AXI_ACLK)
    begin
        if (M_AXI_ARESETN == 1'b0)
            burst_write_active <= 1'b0;
        else if (start_burst_write)
            burst_write_active <= 1'b1;
        else if (M_AXI_BVALID && axi_bready)
            burst_write_active <= 1'b0;
    end
    
    // burst_read_active signal is asserted when there is a burst write transaction
    // is initiated by the assertion of start_burst_read. burst_read_active
    // remains asserted until the burst read is accepted by the master
    always @(posedge M_AXI_ACLK)
    begin
        if (M_AXI_ARESETN == 1'b0)
            burst_read_active <= 1'b0;
        else if (start_burst_read)
            burst_read_active <= 1'b1;
        else if (M_AXI_RVALID && axi_rready && M_AXI_RLAST)
            burst_read_active <= 1'b0;
    end
    
    // TODO Compounding Module
    
endmodule
