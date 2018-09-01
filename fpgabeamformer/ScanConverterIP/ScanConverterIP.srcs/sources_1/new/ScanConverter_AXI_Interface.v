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
`include "./sc_parameters.v"

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


module ScanConverter_AXI_Interface #
        (
            // Users to add parameters here
            // Number of transducers in the probe
            // User parameters ends
            // Do not modify the parameters beyond this line
            
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
            
            // Burst Length. Supports 1, 2, 4, 8, 16, 32, 64, 128, 256 burst lengths
            parameter integer C_M_AXI_BURST_LEN     = 1,
            
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
            input wire  S_AXI_ACLK,
            // Global Reset Signal. This Signal is Active LOW
            input wire  S_AXI_ARESETN,
            // Write Address ID
            input wire [C_S_AXI_ID_WIDTH-1 : 0] S_AXI_AWID,
            // Write address
            input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_AWADDR,
            // Burst length. The burst length gives the exact number of transfers in a burst
            input wire [7 : 0] S_AXI_AWLEN,
            // Burst size. This signal indicates the size of each transfer in the burst
            input wire [2 : 0] S_AXI_AWSIZE,
            // Burst type. The burst type and the size information, 
            // determine how the address for each transfer within the burst is calculated.
            input wire [1 : 0] S_AXI_AWBURST,
            // Lock type. Provides additional information about the
            // atomic characteristics of the transfer.
            input wire  S_AXI_AWLOCK,
            // Memory type. This signal indicates how transactions
            // are required to progress through a system.
            input wire [3 : 0] S_AXI_AWCACHE,
            // Protection type. This signal indicates the privilege
            // and security level of the transaction, and whether
            // the transaction is a data access or an instruction access.
            input wire [2 : 0] S_AXI_AWPROT,
            // Quality of Service, QoS identifier sent for each
            // write transaction.
            input wire [3 : 0] S_AXI_AWQOS,
            // Region identifier. Permits a single physical interface
            // on a slave to be used for multiple logical interfaces.
            input wire [3 : 0] S_AXI_AWREGION,
            // Write address valid. This signal indicates that
            // the channel is signaling valid write address and
            // control information.
            input wire  S_AXI_AWVALID,
            // Write address ready. This signal indicates that
            // the slave is ready to accept an address and associated
            // control signals.
            output wire  S_AXI_AWREADY,
            // Write Data
            input wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_WDATA,
            // Write strobes. This signal indicates which byte
            // lanes hold valid data. There is one write strobe
            // bit for each eight bits of the write data bus.
            input wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] S_AXI_WSTRB,
            // Write last. This signal indicates the last transfer
            // in a write burst.
            input wire  S_AXI_WLAST,
            // Write valid. This signal indicates that valid write
            // data and strobes are available.
            input wire  S_AXI_WVALID,
            // Write ready. This signal indicates that the slave
            // can accept the write data.
            output wire  S_AXI_WREADY,
            // Response ID tag. This signal is the ID tag of the
            // write response.
            output wire [C_S_AXI_ID_WIDTH-1 : 0] S_AXI_BID,
            // Write response. This signal indicates the status
            // of the write transaction.
            output wire [1 : 0] S_AXI_BRESP,
            // Write response valid. This signal indicates that the
            // channel is signaling a valid write response.
            output wire  S_AXI_BVALID,
            // Response ready. This signal indicates that the master
            // can accept a write response.
            input wire  S_AXI_BREADY,
            // Read address ID. This signal is the identification
            // tag for the read address group of signals.
            input wire [C_S_AXI_ID_WIDTH-1 : 0] S_AXI_ARID,
            // Read address. This signal indicates the initial
            // address of a read burst transaction.
            input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_ARADDR,
            // Burst length. The burst length gives the exact number of transfers in a burst
            input wire [7 : 0] S_AXI_ARLEN,
            // Burst size. This signal indicates the size of each transfer in the burst
            input wire [2 : 0] S_AXI_ARSIZE,
            // Burst type. The burst type and the size information, 
            // determine how the address for each transfer within the burst is calculated.
            input wire [1 : 0] S_AXI_ARBURST,
            // Lock type. Provides additional information about the
            // atomic characteristics of the transfer.
            input wire  S_AXI_ARLOCK,
            // Memory type. This signal indicates how transactions
            // are required to progress through a system.
            input wire [3 : 0] S_AXI_ARCACHE,
            // Protection type. This signal indicates the privilege
            // and security level of the transaction, and whether
            // the transaction is a data access or an instruction access.
            input wire [2 : 0] S_AXI_ARPROT,
            // Quality of Service, QoS identifier sent for each
            // read transaction.
            input wire [3 : 0] S_AXI_ARQOS,
            // Region identifier. Permits a single physical interface
            // on a slave to be used for multiple logical interfaces.
            input wire [3 : 0] S_AXI_ARREGION,
            // Write address valid. This signal indicates that
            // the channel is signaling valid read address and
            // control information.
            input wire  S_AXI_ARVALID,
            // Read address ready. This signal indicates that
            // the slave is ready to accept an address and associated
            // control signals.
            output wire  S_AXI_ARREADY,
            // Read ID tag. This signal is the identification tag
            // for the read data group of signals generated by the slave.
            output wire [C_S_AXI_ID_WIDTH-1 : 0] S_AXI_RID,
            // Read Data
            output wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_RDATA,
            // Read response. This signal indicates the status of
            // the read transfer.
            output wire [1 : 0] S_AXI_RRESP,
            // Read last. This signal indicates the last transfer
            // in a read burst.
            output wire  S_AXI_RLAST,
            // Read valid. This signal indicates that the channel
            // is signaling the required read data.
            output wire  S_AXI_RVALID,
            // Read ready. This signal indicates that the master can
            // accept the read data and response information.
            input wire  S_AXI_RREADY,
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////// Ports of Axi Master Bus Interface M00_AXI ///////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            // AXI clock signal
            input wire  M_AXI_ACLK,
            // AXI active low reset signal
            input wire  M_AXI_ARESETN,
            // Master Interface Write Address Channel ports.
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
            // Write address ready. 
            // This signal indicates that the slave is ready to accept an address and associated control signals.
            input wire  M_AXI_AWREADY,
            // Master Interface Write Data Channel ports. Write data (issued by master)
            output wire [C_M_AXI_DATA_WIDTH-1 : 0] M_AXI_WDATA,
            // Write strobes. 
            // This signal indicates which byte lanes hold valid data.
            // There is one write strobe bit for each eight bits of the write data bus.
            output wire [C_M_AXI_DATA_WIDTH/8-1 : 0] M_AXI_WSTRB,
            // Write last. This signal indicates the last transfer in a write burst.
            output wire  M_AXI_WLAST,            
            // Write valid. This signal indicates that valid write data and strobes are available.
            output wire  M_AXI_WVALID,
            // Write ready. This signal indicates that the slave can accept the write data.
            input wire  M_AXI_WREADY,
            // Master Interface Write Response Channel ports.
            input wire [C_M_AXI_ID_WIDTH - 1 : 0] M_AXI_BID,
            // This signal indicates the status of the write transaction.
            input wire [1 : 0] M_AXI_BRESP,
            // Write response valid. 
            // This signal indicates that the channel is signaling a valid write response
            input wire  M_AXI_BVALID,
            // Response ready. This signal indicates that the master can accept a write response.
            output wire  M_AXI_BREADY,
            // Master Interface Read Address Channel ports.
            output wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_ARID,
            // Master Interface Read address
            output wire [C_M_AXI_ADDR_WIDTH - 1 : 0] M_AXI_ARADDR,
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
            // This signal indicates that the channel is signaling valid read address and control information.
            output wire  M_AXI_ARVALID,
            // Read address ready. 
            // This signal indicates that the slave is ready to accept an address and associated control signals.
            input wire  M_AXI_ARREADY,
            // Master Interface Read Data Channel ports.
            // Read ID tag. This signal is the identification tag
            // for the read data group of signals generated by the slave.
            input wire [C_M_AXI_ID_WIDTH - 1 : 0] M_AXI_RID,
            // Read data (issued by slave)
            input wire [C_M_AXI_DATA_WIDTH - 1 : 0] M_AXI_RDATA,
            // Read response. This signal indicates the status of the read transfer.
            input wire [1 : 0] M_AXI_RRESP,
            // Read last. This signal indicates the last transfer
            // in a read burst.
            input wire M_AXI_RLAST,
            // Read valid. This signal indicates that the channel is signaling the required read data.
            input wire  M_AXI_RVALID,
            // Read ready. This signal indicates that the master can accept the read data and response information.
            output wire  M_AXI_RREADY
        );
        
        // AXI4FULL signals
        reg [C_S_AXI_ADDR_WIDTH-1 : 0]   axi_awaddr;
        reg [7 : 0]                      axi_awlen;
        reg [1 : 0]                      axi_awburst;
        reg                              axi_awready;
        reg                              axi_wready;
        reg [1 : 0]                      axi_bresp;
        reg                              axi_bvalid;
        reg [C_S_AXI_ADDR_WIDTH-1 : 0]   axi_araddr;
        reg [7 : 0]                      axi_arlen;
        reg [1 : 0]                      axi_arburst;
        reg                              axi_arready;
        wire [C_S_AXI_DATA_WIDTH-1 : 0]  axi_rdata;
        wire [1 : 0]                     axi_rresp;
        wire                             axi_rlast;
        wire                             axi_rvalid;
        reg [C_S_AXI_DATA_WIDTH-1 : 0]   axi_wdata;
        reg                              axi_wvalid;
        // Wrap boundary and enables wrapping
        wire aw_wrap_en;
        wire ar_wrap_en;
        // Size of the write/read transfer, the address wraps to a lower address if upper address limit is reached
        wire integer aw_wrap_size; 
        wire integer ar_wrap_size;
        // Marks the presence of write/read address valid
        reg axi_awv_awr_flag;
        reg axi_arv_arr_flag; 
        // Address counters to keep track of beats in a burst transaction
        reg [7:0] axi_awlen_cntr;
        reg [7:0] axi_arlen_cntr;
        
        reg [C_S_AXI_ADDR_WIDTH-1 : 0] sc_awaddr;
        reg [C_S_AXI_DATA_WIDTH-1 : 0] sc_wdata;
        reg sc_wvalid = 'b0;
        
        //local parameter for addressing 32 bit / 64 bit C_S_AXI_DATA_WIDTH
        //ADDR_LSB is used for addressing 32/64 bit registers/memories
        //ADDR_LSB = 2 for 32 bits (n downto 2) 
        //ADDR_LSB = 3 for 64 bits (n downto 3)
        localparam integer ADDR_LSB = (C_S_AXI_DATA_WIDTH/32)+ 1;
        
        //params for the master interface
        // function called clogb2 that returns an integer which has the 
        // value of the ceiling of the log base 2.                      
        function integer clogb2 (input integer bit_depth);              
        begin                                                           
            for(clogb2=0; bit_depth>0; clogb2=clogb2+1)                   
                bit_depth = bit_depth >> 1;                                 
        end                                                           
        endfunction                                                     
    
        // C_TRANSACTIONS_NUM is the width of the index counter for 
        // number of write or read transaction.
        localparam integer C_TRANSACTIONS_NUM = clogb2(C_M_AXI_BURST_LEN-1);
        
        // Burst length for transactions, in C_M_AXI_DATA_WIDTHs.
        // Non-2^n lengths will eventually cause bursts across 4K address boundaries.
        localparam integer C_MASTER_LENGTH    = 12;
        // total number of burst transfers is master length divided by burst length and burst size
        localparam integer C_NO_BURSTS_REQ = C_MASTER_LENGTH-clogb2((C_M_AXI_BURST_LEN*C_M_AXI_DATA_WIDTH/8)-1);

        // I/O Connections assignments
        assign S_AXI_AWREADY  = axi_awready;
        assign S_AXI_WREADY   = axi_wready;
        assign S_AXI_BRESP    = axi_bresp;
        assign S_AXI_BVALID   = axi_bvalid;
        assign S_AXI_ARREADY  = axi_arready;
        assign S_AXI_RRESP    = axi_rresp;
        assign S_AXI_RLAST    = axi_rlast;
        assign S_AXI_RVALID   = axi_rvalid;
        assign S_AXI_BID      = S_AXI_AWID;
        assign S_AXI_RID      = S_AXI_ARID;
        assign aw_wrap_size   = (C_S_AXI_DATA_WIDTH/8 * (S_AXI_AWLEN)); 
        assign ar_wrap_size   = (C_S_AXI_DATA_WIDTH/8 * (S_AXI_ARLEN)); 
        assign aw_wrap_en     = ((axi_awaddr & aw_wrap_size) == aw_wrap_size)? 1'b1: 1'b0;
        assign ar_wrap_en     = ((axi_araddr & ar_wrap_size) == ar_wrap_size)? 1'b1: 1'b0;

        // =======================
        // AXI Slave Port Write Channel Logic
        // =======================

        // AWREADY and WREADY are always high. We don't need wait states to accept writes.
        always @(posedge S_AXI_ACLK)
        begin
            if (S_AXI_ARESETN == 1'b0)
            begin
                axi_awready <= 1'b0;
                axi_wready <= 1'b0;
            end
            else
            begin
                axi_awready <= 1'b1;
                axi_wready <= 1'b1;
            end
        end

        // Implementation of "axi_awv_awr_flag", which is used to remember if we have a valid write address onto which
        // to issue writes and the subsequent BRESPs.
        always @(posedge S_AXI_ACLK)
        begin
            if (S_AXI_ARESETN == 1'b0)
                axi_awv_awr_flag <= 1'b0;
            else
            begin
                // Flag goes high upon receiving the address of a burst (AWVALID && AWREADY).
                if (S_AXI_AWVALID && axi_awready)
                    axi_awv_awr_flag <= 1'b1; // We'll be able to generate a BRESP next time a WVALID comes.
                // Flag goes down whenever the last write for that address has been issued (WVALID && WLAST && WREADY).
                else if (S_AXI_WVALID && S_AXI_WLAST && axi_wready)
                    axi_awv_awr_flag <= 1'b0; // Last BRESP coming out now.
            end
        end
        
        // Implementation of BVALID and BRESP: high once a write has been successfully requested.
        always @(posedge S_AXI_ACLK)
        begin
            if (S_AXI_ARESETN == 1'b0)
            begin
                axi_bvalid <= 1'b0;
                axi_bresp <= 2'b00;
            end
            else
            begin
                // BVALID goes high upon receiving the last beat of a burst (WREADY && WVALID && WLAST)
                // provided that we had also had received a valid write address
                // TODO assumes that address comes before write data
                if (~axi_bvalid && axi_wready && S_AXI_WVALID && S_AXI_WLAST && (axi_awv_awr_flag || (S_AXI_AWVALID && axi_awready)))
                begin
                    axi_bvalid <= 1'b1;
                    axi_bresp  <= 2'b00; // OKAY
                end
                else
                // BVALID goes low once it's been accepted (BVALID && BREADY)
                begin
                    if (axi_bvalid && S_AXI_BREADY)
                        axi_bvalid <= 1'b0;
                end
            end
        end
    
        // Handling of AWADDR especially during bursts. 
        always @(posedge S_AXI_ACLK)
        begin
            if (S_AXI_ARESETN == 1'b0)
            begin
                axi_awaddr <= 'h0;
                axi_awlen <= 'h0;
                axi_awburst <= 'h0;
                axi_awlen_cntr <= 'h0;
            end
            else
            begin
                // Latch AWADDR, AWLEN and AWBURST when they are issued (AWVALID && AWREADY).
                if (axi_awready && S_AXI_AWVALID)
                begin
                    axi_awaddr <= S_AXI_AWADDR[C_S_AXI_ADDR_WIDTH - 1 : 0];
                    axi_awlen <= S_AXI_AWLEN;
                    axi_awburst <= S_AXI_AWBURST;
                    axi_awlen_cntr <= 'h0;
                end
                // Whenever a burst beat is issued (WVALID && WREADY), increment the address.
                // TODO this code relies on a 32-bit interface with AWSIZE = 010 (4 bytes). Same below for the read code.
                else if ((axi_awlen_cntr <= axi_awlen) && axi_wready && S_AXI_WVALID)
                begin
                  axi_awlen_cntr <= axi_awlen_cntr + 1;
                  case (axi_awburst)
                      2'b00:  // Fixed burst; the write address for each beat is always the same.
                          axi_awaddr <= axi_awaddr;
                      2'b01:  // Incremental burst; the write address for each beat is incremented by AWSIZE.
                          axi_awaddr <= {axi_awaddr[C_S_AXI_ADDR_WIDTH - 1 : ADDR_LSB] + 1, {ADDR_LSB{1'b0}}};   
                      2'b10:  // Wrapping burst; the write address for each beat increments and wraps when reaching a boundary 
                      if (aw_wrap_en)
                          axi_awaddr <= (axi_awaddr - aw_wrap_size); 
                      else 
                          axi_awaddr <= {axi_awaddr[C_S_AXI_ADDR_WIDTH - 1 : ADDR_LSB] + 1, {ADDR_LSB{1'b0}}};   
                      default:  // Reserved
                      begin
                          axi_awaddr <= axi_awaddr;
                      end
                  endcase              
                end
            end
        end
        
        // Handling of WDATA
        always @(posedge S_AXI_ACLK)
        begin
            if (S_AXI_ARESETN == 1'b0)
            begin
                axi_wdata <= 'h0;
                axi_wvalid <= 1'b0;
            end
            else
            begin
                if (axi_wready && S_AXI_WVALID)
                begin
                    sc_wdata <= S_AXI_WDATA;
                    sc_wvalid <= 'b1;
                    if (S_AXI_AWVALID)
                    begin
                        sc_awaddr <= S_AXI_AWADDR;
                    end 
                    else if (!S_AXI_AWVALID)  
                    begin
                        sc_awaddr <= axi_awaddr;
                    end
                end
                else
                begin
                    sc_wvalid <= 'b0;
                end
            end
        end
        
        // ======================
        // AXI Slave Port Read Channel Logic
        // ======================
    
        // ARREADY is always high. We don't need wait states to accept reads.
        always @(posedge S_AXI_ACLK)
        begin
            if (S_AXI_ARESETN == 1'b0)
                axi_arready <= 1'b0;
            else
                axi_arready <= 1'b1;
        end

        // Implementation of "axi_arv_arr_flag", which is used to remember if we have a valid read address onto which
        // to issue reads and the subsequent RRESPs.
        always @(posedge S_AXI_ACLK)
        begin
            if (S_AXI_ARESETN == 1'b0)
                axi_arv_arr_flag <= 1'b0;
            else
            begin
                // Flag goes high upon receiving the address of a burst (ARVALID && ARREADY).
                if (S_AXI_ARVALID && axi_arready)
                    axi_arv_arr_flag <= 1'b1; // We'll be able to generate a RRESP next time a RVALID comes.
                // Flag goes down whenever the last read for that address has been issued (RVALID && RLAST && RREADY).
                else if (S_AXI_RVALID && (axi_arlen_cntr == axi_arlen) && S_AXI_RREADY)
                    axi_arv_arr_flag <= 1'b0; // Last RRESP coming out now.
            end
        end
    
        // Implementation of RVALID, RRESP and RLAST: high once a read has been successfully requested.
        assign axi_rvalid = axi_arv_arr_flag;
        assign axi_rresp = 2'b00; // Always 'OKAY'
        assign axi_rlast = axi_rvalid && (axi_arlen_cntr == axi_arlen);

        // Handling of ARADDR especially during bursts. 
        always @(posedge S_AXI_ACLK)
        begin
            if (S_AXI_ARESETN == 1'b0)
            begin
                axi_araddr <= 'h0;
                axi_arlen <= 'h0;
                axi_arburst <= 'h0;
                axi_arlen_cntr <= 'h0;
            end
            else
            begin
                // Latch ARADDR, ARLEN and ARBURST when they are issued (ARVALID && ARREADY).
                if (axi_arready && S_AXI_ARVALID)
                begin
                    axi_araddr <= S_AXI_ARADDR[C_S_AXI_ADDR_WIDTH - 1:0];
                    axi_arlen <= S_AXI_ARLEN;
                    axi_arburst <= S_AXI_ARBURST;
                    axi_arlen_cntr <= 'h0;
                end
                // Whenever a burst beat is issued (RVALID && RREADY), increment the address.
                else if ((axi_arlen_cntr <= axi_arlen) && axi_rvalid && S_AXI_RREADY)        
                begin
                  axi_arlen_cntr <= axi_arlen_cntr + 1;
                  case (axi_arburst)
                      2'b00:  // Fixed burst; the write address for each beat is always the same.
                          axi_araddr <= axi_araddr;
                      2'b01:  // Incremental burst; the write address for each beat is incremented by ARSIZE.
                          axi_araddr <= {axi_araddr[C_S_AXI_ADDR_WIDTH - 1 : ADDR_LSB] + 1, {ADDR_LSB{1'b0}}};   
                      2'b10:  // Wrapping burst; the write address for each beat increments and wraps when reaching a boundary 
                      if (ar_wrap_en)
                          axi_araddr <= (axi_araddr - ar_wrap_size); 
                      else 
                          axi_araddr <= {axi_araddr[C_S_AXI_ADDR_WIDTH - 1 : ADDR_LSB] + 1, {ADDR_LSB{1'b0}}};   
                      default:  // Reserved
                      begin
                          axi_araddr <= axi_araddr;
                      end
                  endcase              
                end
            end 
        end
        
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////// MASTER LOGIC ////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        reg [1:0] mst_exec_state;
        
        // AXI4LITE signals
        //AXI4 internal temp signals
        reg [C_M_AXI_ADDR_WIDTH-1 : 0]     axi_m_awaddr;
        wire      axi_m_awvalid;
        reg      deassert_axi_m_awvalid;
        reg [C_M_AXI_DATA_WIDTH-1 : 0]     axi_m_wdata;
        reg      axi_m_wlast;
        reg      axi_m_wvalid;
        wire     axi_m_bready;
        reg [C_M_AXI_ADDR_WIDTH-1 : 0]     axi_m_araddr;
        reg      axi_m_arvalid;
        wire     axi_m_rready;
        
        wire [31 : 0] sc_read_data;
        wire sc_read_start;
        wire sc_read_done;
        
        wire [31 : 0] sc_write_data;
        wire sc_write_start;
        wire sc_write_done;
                
        // I/O Connections assignments
           
        //I/O Connections. Write Address (AW)
        assign M_AXI_AWID    = 'b0;
        //Burst LENgth is number of transaction beats, minus 1
        assign M_AXI_AWLEN    = C_M_AXI_BURST_LEN - 1;
        //Size should be C_M_AXI_DATA_WIDTH, in 2^SIZE bytes, otherwise narrow bursts are used
        assign M_AXI_AWSIZE    = clogb2((C_M_AXI_DATA_WIDTH/8)-1);
        //INCR burst type is usually used, except for keyhole bursts
        assign M_AXI_AWBURST    = 2'b01;
        assign M_AXI_AWLOCK    = 1'b0;
        //Update value to 4'b0011 if coherent accesses to be used via the Zynq ACP port. Not Allocated, Modifiable, not Bufferable. Not Bufferable since this example is meant to test memory, not intermediate cache. 
        assign M_AXI_AWCACHE    = 4'b0010;
        assign M_AXI_AWPROT    = 3'h0;
        assign M_AXI_AWQOS    = 4'h0;
        assign M_AXI_AWVALID    = axi_m_awvalid;
        //Write Data(W)
        assign M_AXI_WDATA    = axi_m_wdata;
        //Read Data (R)
        assign sc_read_data = M_AXI_RDATA;
        //All bursts are complete and aligned in this example
        assign M_AXI_WSTRB    = {(C_M_AXI_DATA_WIDTH/8){1'b1}};
        assign M_AXI_WLAST    = axi_m_wlast;
        assign M_AXI_WVALID    = axi_m_wvalid;
        //Write Response (B)
        assign M_AXI_BREADY    = axi_m_bready;
        //Read Address (AR)
        assign M_AXI_ARID    = 'b0;
        //Burst LENgth is number of transaction beats, minus 1
        assign M_AXI_ARLEN    = C_M_AXI_BURST_LEN - 1;
        //Size should be C_M_AXI_DATA_WIDTH, in 2^n bytes, otherwise narrow bursts are used
        assign M_AXI_ARSIZE    = clogb2((C_M_AXI_DATA_WIDTH/8)-1);
        //INCR burst type is usually used, except for keyhole bursts
        assign M_AXI_ARBURST    = 2'b01;
        assign M_AXI_ARLOCK    = 1'b0;
        //Update value to 4'b0011 if coherent accesses to be used via the Zynq ACP port. Not Allocated, Modifiable, not Bufferable. Not Bufferable since this example is meant to test memory, not intermediate cache. 
        assign M_AXI_ARCACHE    = 4'b0010;
        assign M_AXI_ARPROT    = 3'h0;
        assign M_AXI_ARQOS    = 4'h0;
        assign M_AXI_ARVALID    = axi_m_arvalid;
        //Read and Read Response (R)
        assign M_AXI_RREADY    = axi_m_rready;
        
        // Add user logic here
                
           //--------------------
           //Write Address Channel
           //--------------------
        
           // The purpose of the write address channel is to request the address and 
           // command information for the entire transaction.  It is a single beat
           // of information.
        
           // Note for this example the axi_m_awvalid/axi_m_wvalid are asserted at the same
           // time, and then each is deasserted independent from each other.
           // This is a lower-performance, but simplier control scheme.
        
           // AXI VALID signals must be held active until accepted by the partner.
        
           // A data transfer is accepted by the slave when a master has
           // VALID data and the slave acknoledges it is also READY. While the master
           // is allowed to generated multiple, back-to-back requests by not 
           // deasserting VALID, this design will add rest cycle for
           // simplicity.
        
           // Since only one outstanding transaction is issued by the user design,
           // there will not be a collision between a new request and an accepted
           // request on the same clock cycle. 
        
           always @(posedge M_AXI_ACLK)                                              
           begin
               // Only VALID signals must be deasserted during reset per AXI spec          
               if (M_AXI_ARESETN == 1'b0)                                                   
               begin                                                                    
                   deassert_axi_m_awvalid <= 1'b1;
               end                                                                      
               // Signal a new address/data command is available by user logic           
               else                                                                       
               begin
                   if (sc_write_start == 1'b1)                                                
                       deassert_axi_m_awvalid <= 1'b0;
                   // Address accepted by interconnect/slave (issue of M_AXI_AWREADY by slave)
                   else if (M_AXI_AWREADY && axi_m_awvalid)                                 
                       deassert_axi_m_awvalid <= 1'b1;
               end                                                                      
           end
           
           assign axi_m_awvalid = sc_write_start || !deassert_axi_m_awvalid;
           
           //--------------------
           //Write Data Channel
           //--------------------
           always @(posedge M_AXI_ACLK)                                        
           begin                                                                         
               if (M_AXI_ARESETN == 1'b0)                                                    
               begin                                                                     
                   axi_m_wvalid <= 1'b0;
                   axi_m_wdata <= 'hdeadbeef;
                   axi_m_wlast <= 1'b0;
               end                                                                       
               //Signal a new address/data command is available by user logic              
               else if (sc_write_start == 1'b1)                                                
               begin                                                                     
                   axi_m_wvalid <= 1'b1;  
                   axi_m_wdata <= sc_write_data;
                   axi_m_wlast <= 1'b1;
               end                                                                       
               //Data accepted by interconnect/slave (issue of M_AXI_WREADY by slave)      
               else if (M_AXI_WREADY && axi_m_wvalid)                                        
               begin                                                                     
                   axi_m_wvalid <= 1'b0; 
                   axi_m_wdata <= 'hdeadbeef;
                   axi_m_wlast <= 1'b0;
               end                                                                       
           end
        
           //----------------------------
           //Write Response (B) Channel
           //----------------------------
        
           //The write response channel provides feedback that the write has committed
           //to memory. BREADY will occur after both the data and the write address
           //has arrived and been accepted by the slave, and can guarantee that no
           //other accesses launched afterwards will be able to be reordered before it.
        
           //The BRESP bit [1] is used indicate any errors from the interconnect or
           //slave for the entire write burst. This example will capture the error.
        
             //While not necessary per spec, it is advisable to reset READY signals in
             //case of differing reset latencies between master/slave.
             assign axi_m_bready = 1'b1;                                                                  
                                                            
             // A new axi_m_arvalid is asserted when there is a valid read address              
             // available by the master. sc_read_start triggers a new read                
             // transaction                                                                   
             always @(posedge M_AXI_ACLK)                                                     
             begin                                                                            
               if (M_AXI_ARESETN == 1'b0)                                                       
                 begin                                                                        
                   axi_m_arvalid <= 1'b0;                                                       
                 end                                                                          
               //Signal a new read address command is available by user logic                 
               else if (sc_read_start == 1'b1)                                                    
                 begin                                                                        
                   axi_m_arvalid <= 1'b1;                                                       
                 end                                                                          
               //RAddress accepted by interconnect/slave (issue of M_AXI_ARREADY by slave)    
               else if (M_AXI_ARREADY && axi_m_arvalid)                            
                 begin                                                                        
                   axi_m_arvalid <= 1'b0;                                                       
                 end                                                                          
               // retain the previous value                                                   
             end
        
             assign axi_m_rready = 1'b1;
             assign sc_write_done = M_AXI_WREADY && axi_m_wvalid;
             assign sc_read_done = M_AXI_RVALID && axi_m_rready;
        
        ScanConverter # (
            .C_S_AXI_ID_WIDTH(C_S_AXI_ID_WIDTH),
            .C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
            .C_S_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH),
            .C_S_AXI_AWUSER_WIDTH(C_S_AXI_AWUSER_WIDTH),
            .C_S_AXI_ARUSER_WIDTH(C_S_AXI_ARUSER_WIDTH),
            .C_S_AXI_WUSER_WIDTH(C_S_AXI_WUSER_WIDTH),
            .C_S_AXI_RUSER_WIDTH(C_S_AXI_RUSER_WIDTH),
            .C_S_AXI_BUSER_WIDTH(C_S_AXI_BUSER_WIDTH),
            .C_M_AXI_ID_WIDTH(C_M_AXI_ID_WIDTH),
            .C_M_AXI_DATA_WIDTH(C_M_AXI_DATA_WIDTH),
            .C_M_AXI_ADDR_WIDTH(C_M_AXI_ADDR_WIDTH),
            .C_M_AXI_AWUSER_WIDTH(C_M_AXI_AWUSER_WIDTH),
            .C_M_AXI_ARUSER_WIDTH(C_M_AXI_ARUSER_WIDTH),
            .C_M_AXI_WUSER_WIDTH(C_M_AXI_WUSER_WIDTH),
            .C_M_AXI_RUSER_WIDTH(C_M_AXI_RUSER_WIDTH),
            .C_M_AXI_BUSER_WIDTH(C_M_AXI_BUSER_WIDTH),
            .VOXEL_DATA_WIDTH(VOXEL_DATA_WIDTH),
            .PIXEL_DATA_WIDTH(PIXEL_DATA_WIDTH),
            .MAX_SUPPORTED_BF_IMAGE_WIDTH(MAX_SUPPORTED_BF_IMAGE_WIDTH),
            .MAX_SUPPORTED_BF_IMAGE_HEIGHT(MAX_SUPPORTED_BF_IMAGE_HEIGHT)
        ) ScanConverter_inst (
            .clk(S_AXI_ACLK),
            .resetn(S_AXI_ARESETN),
            .wdata(sc_wdata),
            .waddr(sc_awaddr),
            .wvalid(sc_wvalid),
            .rdata(S_AXI_RDATA),
            .raddr(S_AXI_ARADDR),
            .rvalid(S_AXI_ARVALID),
            
            .master_read_address(M_AXI_ARADDR),
            .master_read_data(sc_read_data),
            .master_read_start(sc_read_start),
            .master_read_done(sc_read_done),
            
            .master_write_address(M_AXI_AWADDR),
            .master_write_data(sc_write_data),
            .master_write_start(sc_write_start),
            .master_write_done(sc_write_done)
        );
        
endmodule