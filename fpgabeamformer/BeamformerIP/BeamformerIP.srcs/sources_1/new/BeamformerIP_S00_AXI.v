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

module BeamformerIP_S00_AXI #
        (
            // Users to add parameters here
            // Number of transducers in the probe
            parameter integer NAPPE_BUFFER_DEPTH = 3,
            parameter integer FIFO_CHAN_WIDTH = 16,
            // User parameters ends
            // Do not modify the parameters beyond this line
            
            // Width of ID for for write address, write data, read address and read data
            parameter integer C_S_AXI_ID_WIDTH    = 1,
            // Width of S_AXI data bus
            parameter integer C_S_AXI_DATA_WIDTH    = 32,
            // Width of S_AXI address bus
            parameter integer C_S_AXI_ADDR_WIDTH    = 10,
            parameter integer C_S00_AXI_AWUSER_WIDTH = 0,
            parameter integer C_S00_AXI_ARUSER_WIDTH = 0,
            parameter integer C_S00_AXI_WUSER_WIDTH = 0,
            parameter integer C_S00_AXI_RUSER_WIDTH = 0,
            parameter integer C_S00_AXI_BUSER_WIDTH = 0
        )
        (
            // Users to add ports here
            // Interface to the AXI Master
            output wire [31 : 0] fifo_data,             // Voxels from the nappe buffer
            output wire fifo_output_valid,              // Strobe signal for the above
            input  wire [15 : 0] saved_nappes,          // Counter of nappes saved by the AXI Master
            input  wire fifo_output_ready,              // AXI Master's readiness to accept voxels
            output reg compound_not_zone_imaging,       // Whether we are running zone imaging or compound imaging
            output wire [6 : 0] run_cnt,                // Count of volumes we are running (total zone count or compounding count)
            output wire [6 : 0] zone_width,             // Width in voxels of each zone
            output wire [6 : 0] zone_height,            // Height in voxels of each zone
            output reg [3 : 0] azimuth_zones,           // Zone count on the azimuth axis
            output reg [3 : 0] elevation_zones,         // Zone count on the elevation axis
            // User ports ends
            // Do not modify the ports beyond this line
            
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
            output wire [C_S_AXI_ID_WIDTH - 1 : 0] S_AXI_RID,
            // Read Data
            output wire [C_S_AXI_DATA_WIDTH - 1 : 0] S_AXI_RDATA,
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
            
            // AXI Stream FIFO connection (probe data)
            input  wire [31 : 0] fifo_axis_rd_data_count, // Elements in AXI stream FIFO
            output wire stall_aurora_fifo,
            input wire valid_aurora_fifo,
            input wire [FIFO_CHAN_WIDTH - 1 : 0] data_aurora_fifo
        );
        
        // AXI 4 signals
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
        reg [7 : 0] axi_awlen_cntr;
        reg [7 : 0] axi_arlen_cntr;
        
        // From the parameters.v file
        localparam TRANSDUCER_ELEMENTS_X = `TRANSDUCER_ELEMENTS_X;
        localparam TRANSDUCER_ELEMENTS_Y = `TRANSDUCER_ELEMENTS_Y;
        localparam FILTER_DEPTH = `FILTER_DEPTH;
        localparam ELEVATION_LINES = `ELEVATION_LINES;
        localparam AZIMUTH_LINES = `AZIMUTH_LINES;
        localparam RADIAL_LINES = `RADIAL_LINES;
        localparam ADC_PRECISION = `ADC_PRECISION;
        localparam APODIZATION_PRECISION = `APODIZATION_PRECISION;
        localparam LP_PRECISION = `LP_PRECISION;
        // How many input samples to load in each BRAM before starting a nappe calculation 
        localparam BRAM_SAMPLES_PER_NAPPE = `BRAM_SAMPLES_PER_NAPPE;
        
        //local parameter for addressing 32 bit / 64 bit C_S_AXI_DATA_WIDTH
        //ADDR_LSB is used for addressing 32/64 bit registers/memories
        //ADDR_LSB = 2 for 32 bits (n downto 2) 
        //ADDR_LSB = 3 for 64 bits (n downto 3)
        localparam integer ADDR_LSB = (C_S_AXI_DATA_WIDTH / 32) + 1;

        // Number of stages in the adder tree
        localparam integer LEVELS = `log2(TRANSDUCER_ELEMENTS_X * TRANSDUCER_ELEMENTS_Y - 1);
        
        // Depth of the voxel FIFO. Needed to ensure we avoid overruns.
        localparam integer FIFO_DEPTH = NAPPE_BUFFER_DEPTH * ELEVATION_LINES * AZIMUTH_LINES;
        
        // Memory map of the register interface
        localparam integer STATUS_REG_ADDRESS = 'h0;
        localparam integer BRAM_REG_ADDRESS = 'h8;
        localparam integer COMMAND_REG_ADDRESS = 'hC;
        localparam integer OPTIONS_REG_ADDRESS = 'h10;
        localparam integer RF_DEPTH_REG_ADDRESS = 'h14;
        localparam integer ZERO_OFFSET_REG_ADDRESS = 'h18;
        localparam integer STATUS2_REG_ADDRESS = 'h1C;
        localparam integer STATUS3_REG_ADDRESS = 'h20;
        localparam integer STATUS4_REG_ADDRESS = 'h24;
        localparam integer STATUS5_REG_ADDRESS = 'h28;
        localparam integer STATUS6_REG_ADDRESS = 'h2C;
        localparam integer STATUS7_REG_ADDRESS = 'h30;

`ifdef IMAGING2D
        localparam integer IMAGING2D = 1;
        localparam integer LAST_TRANSDUCER_ELEMENT = TRANSDUCER_ELEMENTS_X;
`else
        localparam integer IMAGING2D = 0;
        localparam integer LAST_TRANSDUCER_ELEMENT = TRANSDUCER_ELEMENTS_X * TRANSDUCER_ELEMENTS_Y / 2;
`endif

        // Delay offsets: minimum and maximum time samples needed for the reconstruction of a given nappe.
        // Needed to synchronize the flow of incoming data with the progress of the beamformer.
        `include "./offset_top.v"
        // This array in incremented by `BRAM_SAMPLES_PER_NAPPE, so it means: "when processing nappe X,
        // don't load samples beyond offset_bottom[X] or you will overwrite (circular buffer) samples
        // still needed by nappe X"
        `include "./offset_bottom.v"
        // Non-streaming mode offset handling
        // TODO this looks quite ugly though
        `include "./offset_info.v"
        reg [`log2(`OFFSET_BASES) : 0] current_offset_limit;
        
        // This signal tracks whether we have received enough inputs to process the corresponding nappe.
        reg [`log2(RADIAL_LINES) - 1 : 0] ready_nappes;

        // Order in which the BF receives the data: mapping of physical channels to time ordering of the samples.
        `include "./reorder.v"

        // I/O Connections assignments
        assign S_AXI_AWREADY  = axi_awready;
        assign S_AXI_WREADY   = axi_wready;
        assign S_AXI_BRESP    = axi_bresp;
        assign S_AXI_BVALID   = axi_bvalid;
        assign S_AXI_ARREADY  = axi_arready;
        assign S_AXI_RDATA    = axi_rdata;
        assign S_AXI_RRESP    = axi_rresp;
        assign S_AXI_RLAST    = axi_rlast;
        assign S_AXI_RVALID   = axi_rvalid;
        assign S_AXI_BID      = S_AXI_AWID;
        assign S_AXI_RID      = S_AXI_ARID;
        assign aw_wrap_size   = (C_S_AXI_DATA_WIDTH/8 * (S_AXI_AWLEN)); 
        assign ar_wrap_size   = (C_S_AXI_DATA_WIDTH/8 * (S_AXI_ARLEN)); 
        assign aw_wrap_en     = ((axi_awaddr & aw_wrap_size) == aw_wrap_size)? 1'b1: 1'b0;
        assign ar_wrap_en     = ((axi_araddr & ar_wrap_size) == ar_wrap_size)? 1'b1: 1'b0;

        // ===================
        // In-beamformer wires
        // ===================
        wire [TRANSDUCER_ELEMENTS_X * TRANSDUCER_ELEMENTS_Y * 14 - 1 : 0] delay;
        wire [13 : 0] delay_bus [TRANSDUCER_ELEMENTS_X * TRANSDUCER_ELEMENTS_Y - 1 : 0];
        wire [18 * TRANSDUCER_ELEMENTS_X * TRANSDUCER_ELEMENTS_Y - 1 : 0] adder_wires [LEVELS : 0];
        wire [17 : 0] adder_input [TRANSDUCER_ELEMENTS_X - 1 : 0][TRANSDUCER_ELEMENTS_Y - 1 : 0];
        wire [LEVELS : 0] adder_data_valid;
        wire delay_gen_valid;
        reg delay_gen_valid_delayed;
        wire signed [18 - 1 : 0] apod1, apod2;
        wire signed [18 - 1 : 0] tgc1, tgc2;
        wire signed [16 - 1 : 0] sample_1, sample_2;
        wire signed [16 + 18 - 1 : 0] apod_sample_1_full, apod_sample_2_full;
        wire signed [17 : 0] apod_sample_1, apod_sample_2;
        reg signed [17 : 0] apod_sample_1_reg, apod_sample_2_reg;
        wire signed [18 + 18 - 1 : 0] tgc_sample_1_full, tgc_sample_2_full;
        wire signed [17 : 0] tgc_sample_1, tgc_sample_2;
        wire [9 : 0] apodization_index_1, apodization_index_2;
        reg [9 : 0] waddr1;
        reg [9 : 0] waddr2;
        reg [`log2(TRANSDUCER_ELEMENTS_X * TRANSDUCER_ELEMENTS_Y - 1) : 0] transducer_counter;
        reg [`log2(TRANSDUCER_ELEMENTS_X * TRANSDUCER_ELEMENTS_Y - 1) : 0] transducer_counter_reg;
        reg [`log2(TRANSDUCER_ELEMENTS_X * TRANSDUCER_ELEMENTS_Y - 1) : 0] transducer_counter_reg_reg;
        reg [31 : 0] status_reg, status2_reg, status3_reg, status4_reg, status5_reg, status6_reg, status7_reg;
        reg [31 : 0] options_reg;
        reg [31 : 0] rf_depth_reg;
        reg signed [31 : 0] zero_offset_reg;
        reg reset_zero_offset;
        wire mem_wren;
        reg mem_wren_reg;
        reg mem_wren_reg_reg;
        wire fifo_input_valid;
        // High throughout the processing of a nappe
        reg process_nappe;
        // Pulses high for one cycle at the beginning of the processing of a nappe
        reg start_nappe;
        wire stall_beamformer;
        wire [`log2(RADIAL_LINES - 1) - 1 : 0] nappe_index;
        wire end_of_nappe;
        wire [35 : 0] abs_bf_voxel;
        wire abs_bf_voxel_valid;
        wire [35 : 0] adder_output;
        reg [4 : 0] compounding_count;
        reg signed [31 : 0] offset; // Must be wider than `LOG_SAMPLES_DEPTH bits
        wire [`LOG_SAMPLES_DEPTH - 1 : 0] tgc_index;
        // 0: take BF inputs from the AXI Slave interface (Microblaze).
        // 1: take BF inputs from the AXI Stream interface (physical probe via a FIFO).
        reg use_aurora_interface;
        // 0: load BRAMs fully, then await a Command Register command to start BF nappe-by-nappe.
        // 1: keep receiving data (on the AXI Slave or AXI Stream ports) and automatically BF when the offset reaches a threshold.
        reg use_streaming_inputs;
        reg [FIFO_CHAN_WIDTH - 1 : 0] data_aurora_fifo_reg;
        reg [8 : 0] start_counter;
        
        // =======================
        // The data pipeline is as follows:
        // If 2D imaging, one 16-bit piece of data per cycle; if 3D imaging, two pieces of data per cycle in a 32-bit word
        // - At cycle 0, the data comes from either the AXI slave port or the output of the Reorder Channel.
        // - At cycle 1, the data is multiplied by the apodization coefficient. 
        // - At cycle 2, the data is multiplied by the TGC.
        // - At the end of cycle 2, the data is stored in a data BRAM upon mem_wren_reg_reg
        // The transaction_counter signal follows the same timing as the data.
        // The mem_wren signal follows the same timing as the data.
        // The offset signal follows the data by one cycle.
        // =======================
        
        // =======================
        // Aurora FIFO handling
        // =======================
        wire [31 : 0] fifo_rdata;
        reg flush_aurora_fifo;
        assign stall_aurora_fifo = !flush_aurora_fifo && (~use_aurora_interface || offset == $signed(offset_bottom_blanket[nappe_index]));
        // assign valid_data = (offset > offset_top_blanket[nappe_index])? 1'b1 : 1'b0;
        
`ifdef WITH_ILAS
        ila_0 bf_aurora_data_ila(.clk(S_AXI_ACLK),
                                 .probe0(data_aurora_fifo),
                                 .probe1(valid_aurora_fifo),
                                 .probe2(stall_aurora_fifo)
                                 );
`endif

        // =======================
        // AXI Write Channel Logic
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
                // This throttling avoids buffer overruns when operating in streaming mode
                // and receiving lots of input data faster than the beamformer can process
                // it (e.g. in 3D with low element counts). Note that the throttling is
                // "global" - it applies to any incoming write - but the triggering condition
                // in practice only occurs when receiving heavy streams of data to the BRAM_REGISTER,
                // which is what needs to be throttled.
                if (offset == $signed(offset_bottom_blanket[nappe_index]))
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
                mem_wren_reg <= 1'b0;
                mem_wren_reg_reg <= 1'b0;
                options_reg <= 'h0;
                compound_not_zone_imaging <= 1'b0;
                azimuth_zones <= 'h0;
                elevation_zones <= 'h0;
                compounding_count <= 'h0;
                rf_depth_reg <= 'h0;
                zero_offset_reg <= 'h0;
                reset_zero_offset <= 1'b0;
                use_aurora_interface <= 1'b0;
                use_streaming_inputs <= 1'b0;
                data_aurora_fifo_reg <= 'h0;
                flush_aurora_fifo <= 1'b0;
            end
            else
            begin
                axi_wdata <= S_AXI_WDATA;
                axi_wvalid <= S_AXI_WVALID;
                if (axi_wready && S_AXI_WVALID)
                begin
                    // If the write is to the COMMAND_REG_ADDRESS (either AWADDR in this cycle, or previously latched)
                    if (((S_AXI_AWVALID && S_AXI_AWADDR == COMMAND_REG_ADDRESS) || (!S_AXI_AWVALID && axi_awaddr == COMMAND_REG_ADDRESS)))
                    begin
                        use_aurora_interface <= S_AXI_WDATA[1];
                        use_streaming_inputs <= S_AXI_WDATA[2];
                        flush_aurora_fifo <= S_AXI_WDATA[3];
                    end
                    // This condition is captured in the "assign" below instead of here.
                    // else if ((S_AXI_AWVALID && S_AXI_AWADDR == BRAM_REG_ADDRESS) || (!S_AXI_AWVALID && axi_awaddr == BRAM_REG_ADDRESS))
                    else if (((S_AXI_AWVALID && S_AXI_AWADDR == OPTIONS_REG_ADDRESS) || (!S_AXI_AWVALID && axi_awaddr == OPTIONS_REG_ADDRESS)))
                    begin
                        options_reg <= S_AXI_WDATA;
                        if (S_AXI_WDATA[14 : 10] > 'h1)
                            compound_not_zone_imaging <= 1'b1;
                        else
                            compound_not_zone_imaging <= 1'b0;
                        azimuth_zones <= S_AXI_WDATA[4 : 0];
                        elevation_zones <= S_AXI_WDATA[9 : 5];
                        compounding_count <= S_AXI_WDATA[14 : 10];
                    end
                    else if (((S_AXI_AWVALID && S_AXI_AWADDR == RF_DEPTH_REG_ADDRESS) || (!S_AXI_AWVALID && axi_awaddr == RF_DEPTH_REG_ADDRESS)))
                    begin
                        rf_depth_reg <= S_AXI_WDATA;
                    end
                    else if (((S_AXI_AWVALID && S_AXI_AWADDR == ZERO_OFFSET_REG_ADDRESS) || (!S_AXI_AWVALID && axi_awaddr == ZERO_OFFSET_REG_ADDRESS)))
                    begin
                        zero_offset_reg <= S_AXI_WDATA;
                        reset_zero_offset <= 1'b1;
                    end
                end
                // Ensure that this is only a pulse
                if (reset_zero_offset == 1'b1)
                    reset_zero_offset <= 1'b0;
                mem_wren_reg <= mem_wren;
                mem_wren_reg_reg <= mem_wren_reg;
                data_aurora_fifo_reg <= data_aurora_fifo;
            end
        end
        
        assign mem_wren = (use_aurora_interface == 1'b1) ? (!flush_aurora_fifo && valid_aurora_fifo && !stall_aurora_fifo) : 
                                                           axi_wready && S_AXI_WVALID && ((S_AXI_AWVALID && S_AXI_AWADDR == BRAM_REG_ADDRESS) || (!S_AXI_AWVALID && axi_awaddr == BRAM_REG_ADDRESS));

        always @(posedge S_AXI_ACLK)
        begin
            if (S_AXI_ARESETN == 1'b0)
            begin
                process_nappe <= 1'b0;
                start_nappe <= 1'b0;
                start_counter <= 'h0;
                ready_nappes <= 'h0;
            end
            else
            begin
                // Decide that we are ready to beamform the next nappe when:
                // 1) We receive (mem_wren_reg) the last
                //    (transducer_counter_reg == LAST_TRANSDUCER_ELEMENT - 1)
                //    data sample required (offset_top_blanket[]) by the nappe
                //    after the last currently ready one (ready_nappes)
                // 2) Or, if the nappe after the currently ready one requires just
                //    the same set of samples (edge case), and therefore is ready too
                // ready_nappes starts at 0 (no nappes ready) and counts
                // up to RADIAL_LINES inclusive, so that it can always be == nappe_index + 1.
                // It needs possibly an extra bit compared to nappe_index to do so.
                if ((ready_nappes < RADIAL_LINES && offset == $signed(offset_top_blanket[ready_nappes]) - 1 && mem_wren_reg && transducer_counter_reg == LAST_TRANSDUCER_ELEMENT - 1) ||
                    (ready_nappes > 1 && offset_top_blanket[ready_nappes] == offset_top_blanket[$unsigned(ready_nappes - 1)]))
                begin
                    ready_nappes <= ready_nappes + 1;
                end
                // When started beamforming the last nappe, it is appropriate to reset
                // the ready counter back to 0. Note: don't do that right away when that
                // nappe becomes ready (but BF may not be there yet) or the readiness
                // check "ready_nappes > nappe_index" will fail
                else if (nappe_index == RADIAL_LINES - 1 && start_nappe)
                begin
                    ready_nappes <= 'h0;
                end
                
                if ((use_streaming_inputs == 1'b1 && process_nappe == 1'b0 && stall_beamformer == 1'b0 && $unsigned(ready_nappes) > $unsigned(nappe_index)) ||
                    (use_streaming_inputs == 1'b0 && axi_wready && S_AXI_WVALID && ((S_AXI_AWVALID && S_AXI_AWADDR == COMMAND_REG_ADDRESS) || (!S_AXI_AWVALID && axi_awaddr == COMMAND_REG_ADDRESS)) && S_AXI_WDATA[0] == 1'b1))
                begin
                    start_nappe <= 1'b1;
                    process_nappe <= 1'b1;
                end

                if (process_nappe == 1'b1 && end_of_nappe == 1'b1)
                    process_nappe <= 1'b0;
                // Ensure that this is only a pulse
                if (start_nappe == 1'b1)
                begin
                    start_nappe <= 1'b0;
                    start_counter <= start_counter + 1;
                end
            end
        end
        
        // ======================
        // AXI Read Channel Logic
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
        
        // Handling of RDATA
        always @(posedge S_AXI_ACLK)
        begin
            if (S_AXI_ARESETN == 1'b0)
            begin
                status_reg <= 'h0;
                status2_reg <= 'h0;
                status3_reg <= 'h0;
                status4_reg <= 'h0;
                status5_reg <= 'h0;
                status6_reg <= 'h0;
                status7_reg <= 'h0;
            end
            else
            begin
                status_reg[0] = ~process_nappe;     // Ready for a new nappe at boot, then not ready once the nappe is underway
                status_reg[1] = process_nappe;      // Busy when the nappe is underway
                status_reg[15 : 2] = 'h0;
                status_reg[31 : 16] = saved_nappes;
                status2_reg[15 : 0] = offset[15 : 0];
                status2_reg[16] = reset_zero_offset;
                status2_reg[17] = use_aurora_interface;
                status2_reg[18] = use_streaming_inputs;
                status2_reg[19] = 1'b0;
                status2_reg[20] = stall_aurora_fifo;
                status2_reg[21] = valid_aurora_fifo;
                status2_reg[22] = stall_beamformer;
                status2_reg[31 : 23] = start_counter;
                status3_reg[9 : 0] = waddr1;
                status3_reg[10] = flush_aurora_fifo;
                status3_reg[15 : 11] = chan_phy_order[0][4 : 0];
                status3_reg[31 : 16] = fifo_axis_rd_data_count[15 : 0];
                status4_reg[`log2(RADIAL_LINES - 1) - 1 : 0] = nappe_index;
                status4_reg[31 : 16] = offset_top_blanket[nappe_index][15 : 0];
                status5_reg[15 : 0] = offset_top_blanket[0][15 : 0];
                status5_reg[31 : 16] = offset_top_blanket[1][15 : 0];
                // This assignment (with a constant index) seems critical to Vivado
                // not "optimizing away" the whole offset_bottom_blanket array.
                status6_reg[15 : 0] = offset_bottom_blanket[0][15 : 0];
                status6_reg[31 : 16] = offset_bottom_blanket[1][15 : 0];
                status7_reg[15 : 0] = non_streaming_offset_bases[0][15 : 0];
                status7_reg[31 : 16] = non_streaming_offset_bases[1][15 : 0];
            end
        end
        
        assign axi_rdata = (axi_rvalid && (axi_araddr == STATUS_REG_ADDRESS) ? status_reg :
                           (axi_rvalid && (axi_araddr == OPTIONS_REG_ADDRESS) ? options_reg :
                           (axi_rvalid && (axi_araddr == RF_DEPTH_REG_ADDRESS) ? rf_depth_reg :
                           (axi_rvalid && (axi_araddr == ZERO_OFFSET_REG_ADDRESS) ? zero_offset_reg : 
                           (axi_rvalid && (axi_araddr == STATUS2_REG_ADDRESS) ? status2_reg :
                           (axi_rvalid && (axi_araddr == STATUS3_REG_ADDRESS) ? status3_reg :
                           (axi_rvalid && (axi_araddr == STATUS4_REG_ADDRESS) ? status4_reg :
                           (axi_rvalid && (axi_araddr == STATUS5_REG_ADDRESS) ? status5_reg :
                           (axi_rvalid && (axi_araddr == STATUS6_REG_ADDRESS) ? status6_reg :
                           (axi_rvalid && (axi_araddr == STATUS7_REG_ADDRESS) ? status7_reg :'h0))))))))));
        
        // ==================================
        // (Static) apodization
        // ==================================
        // TODO may choose to add a register for speed, if critical
        // Xilinx True Dual Port RAM, Write First with Single Clock
        dpbram #(.RAM_WIDTH(18),
                 .RAM_DEPTH(1024),
                 .RAM_PERFORMANCE("LOW_LATENCY"),
                 .INIT_FILE("mem_init_apodization.txt")
                )
                apod_bram(.addra(apodization_index_1),
                          .addrb(apodization_index_2),
                          .dina('h0),
                          .dinb('h0),
                          .clka(S_AXI_ACLK),
                          .wea(1'b0),
                          .web(1'b0),
                          .ena(1'b1),
                          .enb(1'b1),
                          .rsta(S_AXI_ARESETN),
                          .rstb(S_AXI_ARESETN),
                          .regcea(1'b1),
                          .regceb(1'b1),
                          .douta(apod1),
                          .doutb(apod2)
                         );
                         
        // ==================================
        // TGC
        // ==================================
        assign tgc_index = offset < 'h0 ? {`LOG_SAMPLES_DEPTH{1'b0}} : offset[`LOG_SAMPLES_DEPTH - 1 : 0];
        // Xilinx True Dual Port RAM, Write First with Single Clock
        dpbram #(.RAM_WIDTH(18),
                 .RAM_DEPTH(8192),
                 .RAM_PERFORMANCE("LOW_LATENCY"),
                 .INIT_FILE("mem_init_tgc.txt")
                )
                tgc_bram(.addra(tgc_index),
                         .addrb(tgc_index),
                         .dina('h0),
                         .dinb('h0),
                         .clka(S_AXI_ACLK),
                         .wea(1'b0),
                         .web(1'b0),
                         .ena(1'b1),
                         .enb(1'b1),
                         .rsta(S_AXI_ARESETN),
                         .rstb(S_AXI_ARESETN),
                         .regcea(1'b1),
                         .regceb(1'b1),
                         .douta(tgc1),
                         .doutb(tgc2)
                        );
             
        // The input samples are 16-bit integers (limited by AXI datapath)
        // The apodization value is 18-bit fixed point positive, with ii.APODIZATION_PRECISION notation
        assign sample_1 = (use_aurora_interface == 1'b1 ? data_aurora_fifo_reg : axi_wdata[15 : 0]);
        assign sample_2 = axi_wdata[31 : 16];
        
        assign apod_sample_1_full = sample_1 * apod1;
        assign apod_sample_2_full = sample_2 * apod2;
        // We want a 16.2 output encoding considering that:
        // - After the multiplication the decimal point is "APODIZATION_PRECISION" bits left
        // - Since the apodization multiplies by a number between 0 and 1, without loss of dynamic
        // range, we can take the output's integer part as wide as the input's (16 bits)
        assign apod_sample_1 = apod_sample_1_full[16 + APODIZATION_PRECISION - 1 : APODIZATION_PRECISION - 2];
        assign apod_sample_2 = apod_sample_2_full[16 + APODIZATION_PRECISION - 1 : APODIZATION_PRECISION - 2];
        
        always @(posedge S_AXI_ACLK or negedge S_AXI_ARESETN)
        begin
            if (S_AXI_ARESETN == 1'b0)
            begin
                apod_sample_1_reg <= 'h0;
                apod_sample_2_reg <= 'h0;
            end
            else
            begin
                apod_sample_1_reg <= apod_sample_1;
                apod_sample_2_reg <= apod_sample_2;
            end
        end
        
        // Now apply TGC to the samples. TGC is encoded as 9.9 bits.
        assign tgc_sample_1_full = apod_sample_1_reg * tgc1;
        assign tgc_sample_2_full = apod_sample_2_reg * tgc2;
        // Recompress again into a 16.2 output considering that:
        // - After the multiplication, the output will have 11 bits of fractional part.
        // - The integer part may now overflow its 16 bits due to the multiplication, but this is
        //   unlikely since the highest amplifications occur deep down (where samples have lower
        //   amplitude anyway) and since we apply TGC after apodization (which is an attenuation).
        assign tgc_sample_1 = tgc_sample_1_full[26 : 9];
        assign tgc_sample_2 = tgc_sample_2_full[26 : 9];
        
        // ==================================
        // BRAM bank matrix for input samples
        // ==================================
        genvar row, column;
        generate
            // Columns of the transducer
            for (column = 0; column < TRANSDUCER_ELEMENTS_X; column = column + 1)
            begin: gen_ram_block_column
                // Rows of the transducer (skips by 2 since we put two rows on each BRAM; in 2D there's a single row anyway)
                for (row = 0; row < TRANSDUCER_ELEMENTS_Y; row = row + 2)
                begin: gen_ram_block_row

                    wire local_mem_wren;
                    wire [9 : 0] input_delay1;
                    wire [9 : 0] input_delay2;
                    
                    assign delay_bus[column * TRANSDUCER_ELEMENTS_Y + row] = delay[14 * (column * TRANSDUCER_ELEMENTS_Y + row + 1) - 1 : 14 * (column * TRANSDUCER_ELEMENTS_Y + row)];
`ifdef IMAGING2D
                    assign local_mem_wren = mem_wren_reg_reg && (use_aurora_interface == 1'b1 ? (chan_phy_order[transducer_counter_reg_reg][`log2(TRANSDUCER_ELEMENTS_X * TRANSDUCER_ELEMENTS_Y - 1) : 0] == (column * TRANSDUCER_ELEMENTS_Y + row)) : (transducer_counter_reg_reg == column));
                    assign input_delay1 = delay_bus[row * TRANSDUCER_ELEMENTS_X + column][9 : 0] % 1024;
`else
                    assign delay_bus[column * TRANSDUCER_ELEMENTS_Y + row + 1] = delay[14 * (column * TRANSDUCER_ELEMENTS_Y + row + 2) - 1 : 14 * (column * TRANSDUCER_ELEMENTS_Y + row + 1)];
                    assign local_mem_wren = mem_wren_reg_reg && (transducer_counter_reg_reg == (column * TRANSDUCER_ELEMENTS_Y + row) / 2);
                    assign input_delay1 = delay_bus[row * TRANSDUCER_ELEMENTS_X + column][9 : 0];
                    // Note that "+ 512" only flips the MSB of the address, and is therefore fast.
                    assign input_delay2 = delay_bus[(row + 1) * TRANSDUCER_ELEMENTS_X + column][9 : 0] + BRAM_SAMPLES_PER_NAPPE;
`endif
                    
                    // Verify that the generated addresses are OK
/*                    always @(posedge S_AXI_ACLK or negedge S_AXI_ARESETN)
                    begin
                        if (S_AXI_ARESETN == 1'b0)
                        begin
                        end
                        else
                        begin
                            `assert((^input_delay1 === 1'bX || input_delay1 < 512), 1'b1)
                            `assert((^input_delay2 === 1'bX || input_delay2 > 511), 1'b1)
                        end
                    end
*/                                        
                    // Xilinx True Dual Port RAM, Write First with Single Clock
                    dpbram #(.RAM_WIDTH(18),
                             .RAM_DEPTH(1024),
                             .RAM_PERFORMANCE("LOW_LATENCY"),
                             .INIT_FILE({"mem_init_echoes_",
`ifdef IMAGING2D
                                         ((column * TRANSDUCER_ELEMENTS_Y + row)) < 10 ?    {"000", ((column * TRANSDUCER_ELEMENTS_Y + row)) + 48} :
                                         ((column * TRANSDUCER_ELEMENTS_Y + row)) < 100 ?   {"00", ((column * TRANSDUCER_ELEMENTS_Y + row)) / 10 + 48, ((column * TRANSDUCER_ELEMENTS_Y + row)) % 10 + 48} :
                                         ((column * TRANSDUCER_ELEMENTS_Y + row)) < 1000 ?  {"0", ((column * TRANSDUCER_ELEMENTS_Y + row)) / 100 + 48, (((column * TRANSDUCER_ELEMENTS_Y + row)) % 100) / 10 + 48, ((column * TRANSDUCER_ELEMENTS_Y + row)) % 10 + 48} :
                                                                                       {((column * TRANSDUCER_ELEMENTS_Y + row)) / 1000 + 48, (((column * TRANSDUCER_ELEMENTS_Y + row)) % 1000) / 100 + 48, (((column * TRANSDUCER_ELEMENTS_Y + row)) % 100) / 10 + 48, ((column * TRANSDUCER_ELEMENTS_Y + row)) % 10 + 48},
`else
                                         ((column * TRANSDUCER_ELEMENTS_Y + row) / 2) < 10 ?    {"000", ((column * TRANSDUCER_ELEMENTS_Y + row) / 2) + 48} :
                                         ((column * TRANSDUCER_ELEMENTS_Y + row) / 2) < 100 ?   {"00", ((column * TRANSDUCER_ELEMENTS_Y + row) / 2) / 10 + 48, ((column * TRANSDUCER_ELEMENTS_Y + row) / 2) % 10 + 48} :
                                         ((column * TRANSDUCER_ELEMENTS_Y + row) / 2) < 1000 ?  {"0", ((column * TRANSDUCER_ELEMENTS_Y + row) / 2) / 100 + 48, (((column * TRANSDUCER_ELEMENTS_Y + row) / 2) % 100) / 10 + 48, ((column * TRANSDUCER_ELEMENTS_Y + row) / 2) % 10 + 48} :
                                                                                       {((column * TRANSDUCER_ELEMENTS_Y + row) / 2) / 1000 + 48, (((column * TRANSDUCER_ELEMENTS_Y + row) / 2) % 1000) / 100 + 48, (((column * TRANSDUCER_ELEMENTS_Y + row) / 2) % 100) / 10 + 48, ((column * TRANSDUCER_ELEMENTS_Y + row) / 2) % 10 + 48},
`endif
                                         ".txt"})
                            )
`ifdef IMAGING2D
                            sample_bram(.addra(local_mem_wren ? waddr1 : 10'h0),
`else
                            sample_bram(.addra(local_mem_wren ? waddr1 : input_delay1),
`endif
                                        .dina(tgc_sample_1),
                                        .clka(S_AXI_ACLK),
                                        .wea(local_mem_wren),
                                        .ena(1'b1),
                                        .rsta(S_AXI_ARESETN),
                                        .rstb(S_AXI_ARESETN),
                                        .regcea(1'b1),
                                        .regceb(1'b1),
`ifdef IMAGING2D
// TODO won't be able to do streaming in 3D (yet) because we need Port B for reads
                                        .douta(),
                                        .addrb(input_delay1),
                                        .dinb(18'h0),
                                        .web(1'b0),
                                        .enb(1'b1),
                                        .doutb(adder_input[column][row])
`else
                                        .douta(adder_input[column][row]),
                                        .addrb(local_mem_wren ? waddr2 : input_delay2),
                                        .dinb(tgc_sample_2),
                                        .web(local_mem_wren),
                                        .enb(1'b1),
                                        .doutb(adder_input[column][row + 1])
`endif
                                       );
                    
                    assign adder_wires[0][18 * (column * TRANSDUCER_ELEMENTS_Y + row + 1) - 1 : 18 * (column * TRANSDUCER_ELEMENTS_Y + row)] = adder_input[column][row];
`ifdef IMAGING2D
`else
                    assign adder_wires[0][18 * (column * TRANSDUCER_ELEMENTS_Y + row + 2) - 1 : 18 * (column * TRANSDUCER_ELEMENTS_Y + row + 1)] = adder_input[column][row + 1];
`endif
                end
            end
        endgenerate
        
`ifdef WITH_ILAS
        ila_1 bram_write_ila(.clk(S_AXI_ACLK),
                             .probe0(tgc_sample_1),
                             .probe1(waddr1),
                             .probe2(mem_wren_reg_reg),
                             .probe3(chan_phy_order[transducer_counter_reg_reg])
                            );
`endif
        
        always @(posedge S_AXI_ACLK or negedge S_AXI_ARESETN)
        begin
            if (S_AXI_ARESETN == 1'b0)
            begin
                transducer_counter <= 'h0;
                transducer_counter_reg <= 'h0;
                transducer_counter_reg_reg <= 'h0;
                waddr1 <= 'h0;
                waddr2 <= BRAM_SAMPLES_PER_NAPPE;
                offset <= 'h0;
                current_offset_limit <= 'h0;
            end
            else
            begin
                if (reset_zero_offset == 1'b1)
                    offset <= $signed(zero_offset_reg);
                
                // If we were writing to the BRAMs last cycle...
                if (mem_wren)
                begin
                    if (transducer_counter == LAST_TRANSDUCER_ELEMENT - 1)
                        transducer_counter <= 'h0;
                    else
                        transducer_counter <= transducer_counter + 1;
                end
                transducer_counter_reg <= transducer_counter;
                transducer_counter_reg_reg <= transducer_counter_reg;
                
                // We are receiving the last input sample for a given depth.
                if (mem_wren_reg && transducer_counter_reg == LAST_TRANSDUCER_ELEMENT - 1)
                begin
                    // In streaming mode, for every echo sample input, the BF knows what
                    // time offset it represents - starting from "zero_offset_reg" and counting
                    // up "rf_depth_reg" times, then back to "zero_offset_reg".
                    if (use_streaming_inputs == 1'b1)
                    begin
                        // Reset the offset when we're out of input data.
                        if (offset + 1 == $signed(rf_depth_reg) + $signed(zero_offset_reg))
                            offset <= $signed(zero_offset_reg);
                        else
                            offset <= offset + 1;
                    end
                    // This code serves for non-streaming input mode (Microblaze control).
                    // In non-streaming mode, the first batch of data behaves like in streaming mode,
                    // but at the second batch of refill, the offsets first must "come down" a bit
                    // since there is overlap between the inputs for the previous and next nappe.
                    // The offset must be a bit lower than "zero_offset_reg + BRAM_SAMPLES_PER_NAPPE - 1".
                    // Same for all subsequent refills. "non_streaming_offset_bases" stores:
                    // - non_streaming_offset_bases[0] should be the same as "zero_offset_reg"
                    // - at non_streaming_offset_bases[0] + BRAM_SAMPLES_PER_NAPPE - 1,
                    //   the offset is supposed to wrap down a bit to non_streaming_offset_bases[1]
                    // - etc.
                    // - at non_streaming_offset_bases[OFFSET_BASES - 1] + BRAM_SAMPLES_PER_NAPPE - 1,
                    //   which is the last offset that will be reached in the loading of the RF data,
                    //   the offset must go back down to non_streaming_offset_bases[0] i.e.
                    //   "zero_offset_reg"
                    // The counter "current_offset_limit" basically tracks the refills, and OFFSET_BASES
                    // is the total required refill count.
                    else // use_streaming_inputs == 1'b0
                    begin
                        if (offset + 1 == $signed(non_streaming_offset_bases[current_offset_limit]) + $signed(BRAM_SAMPLES_PER_NAPPE))
                        begin
                            if (current_offset_limit + 1 == `OFFSET_BASES)
                            begin
                                current_offset_limit <= 'h0;
                                offset <= $signed(non_streaming_offset_bases[0]);
                            end
                            else
                            begin
                                current_offset_limit <= current_offset_limit + 1;
                                offset <= $signed(non_streaming_offset_bases[current_offset_limit + 1]);
                            end
                        end
                        else
                            offset <= offset + 1;
                    end
                end
                
                // When writing input samples belonging to the last element
                if (mem_wren_reg_reg && transducer_counter_reg_reg == LAST_TRANSDUCER_ELEMENT - 1)
                begin
                    // Reset the BRAM address either when we fill in the BRAM completely,
                    // or when the offset has been just reset last cycle (e.g. for when
                    // data is coming in streaming fashion and the last samples did not reach
                    // the BRAM edge)
                    if (waddr1 == BRAM_SAMPLES_PER_NAPPE - 1 || offset == $signed(zero_offset_reg))
                    begin
                        waddr1 <= 'h0;
                        waddr2 <= BRAM_SAMPLES_PER_NAPPE;
                    end
                    else
                    begin
                        waddr1 <= waddr1 + 1;
                        waddr2 <= waddr2 + 1;
                    end
                end
            end
        end
`ifdef IMAGING2D
        assign apodization_index_1 = (use_aurora_interface == 1'b1 ? chan_phy_order[transducer_counter] : transducer_counter);
`else
        assign apodization_index_1 = transducer_counter * 2;
`endif
        assign apodization_index_2 = transducer_counter * 2 + 1;
        
        // ==========
        // Adder tree
        // ==========
        genvar g;
        generate
            for (g = 0; g < LEVELS; g = g + 1)
            begin: gen_adder_level
                // TODO The binding code only works for power-of-2 element counts.
                adder_stage #(.INPUTS(TRANSDUCER_ELEMENTS_X * TRANSDUCER_ELEMENTS_Y / (2 ** g)),
                              .INPUT_WIDTH(18 + g)
                            )
                            adder_i (.CLK(S_AXI_ACLK),
                                     .RSTN(S_AXI_ARESETN),
                                     .VALID_IN(adder_data_valid[g]),
                                     .VALID_OUT(adder_data_valid[g + 1]),
                                     .DATA_IN(adder_wires[g][TRANSDUCER_ELEMENTS_X * TRANSDUCER_ELEMENTS_Y / (2 ** g) * (18 + g) - 1 : 0]),
                                     .DATA_OUT(adder_wires[g + 1][TRANSDUCER_ELEMENTS_X * TRANSDUCER_ELEMENTS_Y / (2 ** g) / 2 * ((18 + g) + 1) - 1 : 0])
                                    );
                // The LSBs come from above; pad to 0 the MSBs
                assign adder_wires[g + 1][18 * TRANSDUCER_ELEMENTS_X * TRANSDUCER_ELEMENTS_Y - 1 : TRANSDUCER_ELEMENTS_X * TRANSDUCER_ELEMENTS_Y / (2 ** g) / 2 * ((18 + g) + 1)] = 'h0;
            end
        endgenerate
        // The final output is the output of the last level of adders, sign-extended to 36 bits.
        assign adder_output = {{(36 - (18 + LEVELS)){adder_wires[LEVELS][18 + LEVELS - 1]}}, adder_wires[LEVELS][18 + LEVELS - 1 : 0]};
        assign fifo_input_valid = adder_data_valid[LEVELS];
        
        // =======================
        // Delay calculation logic
        // =======================
        delay_top #(.TRANSDUCER_ELEMENTS_X(TRANSDUCER_ELEMENTS_X),
                    .TRANSDUCER_ELEMENTS_Y(TRANSDUCER_ELEMENTS_Y),
                    .RADIAL_LINES_LOG(`log2(RADIAL_LINES - 1)),
                    .IMAGING2D(IMAGING2D)
                  )
                  delay_generation(.clk(S_AXI_ACLK),
                                   .rst_n(S_AXI_ARESETN),
                                   .start_nappe(start_nappe),
                                   .phi_cnt_out(),
                                   .theta_cnt_out(),
                                   .nt_cnt(nappe_index),
                                   .compound_not_zone_imaging(compound_not_zone_imaging),
                                   .azimuth_zones(azimuth_zones),
                                   .elevation_zones(elevation_zones),
                                   .compounding_count(compounding_count),
                                   .run_cnt(run_cnt),
                                   .zone_width(zone_width),
                                   .zone_height(zone_height),
                                   .delay_valid(delay_gen_valid),
                                   .end_of_nappe(end_of_nappe),
                                   .delay(delay),
                                   .zone_cnt_out(),
                                   .zero_offset(zero_offset_reg[13 : 0]),
                                   // TODO is this going to trigger a recalculation in time for nappe 0?
                                   .streaming_not_fixed(use_streaming_inputs)
                                  );
                  
        // ===================
        // Output nappe buffer
        // ===================
        absvalue #(.DATA_WIDTH(36)
                 )
                 abs(.CLK(S_AXI_ACLK),
                     .RSTN(S_AXI_ARESETN),
                     .data_in(adder_output),
                     .data_in_valid(fifo_input_valid),
                     .data_out(abs_bf_voxel),
                     .data_out_valid(abs_bf_voxel_valid)
                    );
                    
        // Check that the abs() module never receives an X input marked valid
        // (bitwise XOR the bus to detect any X on any bit)
/*        always @(posedge S_AXI_ACLK or negedge S_AXI_ARESETN)
        begin
            if (S_AXI_ARESETN == 1'b0)
            begin
            end
            else
                `assert((^adder_output === 1'bX) & fifo_input_valid, 1'b0)
        end
*/                        
        nappe_buffer #(.FILTER_DEPTH(FILTER_DEPTH),
                       .NAPPE_BUFFER_DEPTH(NAPPE_BUFFER_DEPTH),
                       .ELEVATION_LINES(ELEVATION_LINES),
                       .AZIMUTH_LINES(AZIMUTH_LINES),
                       .RADIAL_LINES(RADIAL_LINES),
                       .LP_PRECISION(LP_PRECISION)
                     )
                     nb (.CLK(S_AXI_ACLK),
                         .RSTN(S_AXI_ARESETN),
                         .DIN(abs_bf_voxel),
                         .DIN_VALID(abs_bf_voxel_valid),
                         .DOUT(fifo_data),
                         .DOUT_VALID(fifo_output_valid),
                         .DOUT_READY(fifo_output_ready),
                         .stall_beamformer(stall_beamformer),
                         .nappe_index(nappe_index),
                         .azimuth_zones(azimuth_zones),
                         .elevation_zones(elevation_zones),
                         .compound_not_zone_imaging(compound_not_zone_imaging),
                         .end_of_nappe(end_of_nappe),
                         .fifo_ready_voxels(),
                         .max_value()
                        );
        
        // delay_gen_valid must be delayed by one cycle as it represents the
        // validity of the delay indices, but the BRAMs churn out data one cycle later
        always @(posedge S_AXI_ACLK or negedge S_AXI_ARESETN)
        begin
            if (S_AXI_ARESETN == 1'b0)
                delay_gen_valid_delayed <= 1'b0;
            else
                delay_gen_valid_delayed <= delay_gen_valid;
        end
        assign adder_data_valid[0] = delay_gen_valid_delayed;
        
endmodule
