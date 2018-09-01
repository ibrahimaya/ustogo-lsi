///////////////////////////////////////////////////////////////////////////////
// (c) Copyright 2008 Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//
//
///////////////////////////////////////////////////////////////////////////////
//
//  system_i_bak_aurora_8b10b_0_0
//
//
//  Description: This is the top level module for a 4 2-byte lane
//               Simplex Aurora reference design module.
//
//               This is a Simplex RX module.  All GTs are only used for
//               receive only.
//               This module supports the following features:
//
//

`timescale 1 ns / 1 ps
(* core_generation_info = "system_i_bak_aurora_8b10b_0_0,aurora_8b10b_v11_0_4,{user_interface=AXI_4_Streaming,backchannel_mode=Timer,c_aurora_lanes=4,c_column_used=left,c_gt_clock_1=GTHQ0,c_gt_clock_2=None,c_gt_loc_1=1,c_gt_loc_10=X,c_gt_loc_11=X,c_gt_loc_12=X,c_gt_loc_13=X,c_gt_loc_14=X,c_gt_loc_15=X,c_gt_loc_16=X,c_gt_loc_17=X,c_gt_loc_18=X,c_gt_loc_19=X,c_gt_loc_2=2,c_gt_loc_20=X,c_gt_loc_21=X,c_gt_loc_22=X,c_gt_loc_23=X,c_gt_loc_24=X,c_gt_loc_25=X,c_gt_loc_26=X,c_gt_loc_27=X,c_gt_loc_28=X,c_gt_loc_29=X,c_gt_loc_3=3,c_gt_loc_30=X,c_gt_loc_31=X,c_gt_loc_32=X,c_gt_loc_33=X,c_gt_loc_34=X,c_gt_loc_35=X,c_gt_loc_36=X,c_gt_loc_37=X,c_gt_loc_38=X,c_gt_loc_39=X,c_gt_loc_4=4,c_gt_loc_40=X,c_gt_loc_41=X,c_gt_loc_42=X,c_gt_loc_43=X,c_gt_loc_44=X,c_gt_loc_45=X,c_gt_loc_46=X,c_gt_loc_47=X,c_gt_loc_48=X,c_gt_loc_5=X,c_gt_loc_6=X,c_gt_loc_7=X,c_gt_loc_8=X,c_gt_loc_9=X,c_lane_width=2,c_line_rate=62500,c_nfc=false,c_nfc_mode=IMM,c_refclk_frequency=125000,c_simplex=true,c_simplex_mode=RX,c_stream=false,c_ufc=false,flow_mode=None,interface_mode=Framing,dataflow_config=RX-only_Simplex}" *)
module system_i_bak_aurora_8b10b_0_0_core #
 (
     parameter   WATCHDOG_TIMEOUT     =  14,
     // Simplex timer parameters
     parameter   C_SIMPLEX_TIMER      =  18,      // Simplex Timer 
     parameter   C_ALIGNED_TIMER      =  158990,  // Timer to assert tx_aligned signal 
     parameter   C_BONDED_TIMER       =  C_ALIGNED_TIMER + 4096,  // Timer to assert tx_bonded signal 
     parameter   C_VERIFY_TIMER       =  C_BONDED_TIMER  + 512,   // Timer to assert tx_verify signal 
     parameter   EXAMPLE_SIMULATION   =   0      
 )
(

    // AXI RX Interface
    m_axi_rx_tdata,
    m_axi_rx_tkeep,
    m_axi_rx_tvalid,
    m_axi_rx_tlast,



    // GT Serial I/O
    rxp,
    rxn,

    // GT Reference Clock Interface
    gt_refclk1,

    // Error Detection Interface
    rx_hard_err,
    soft_err,
    frame_err,

    // Status
    rx_channel_up,
    rx_lane_up,


    // System Interface
    user_clk,
    sync_clk,
    rx_system_reset,
    rx_resetdone_out,
    link_reset_out,
    power_down,
    gt_reset,
    tx_lock,
    init_clk_in,
    pll_not_locked,
    gt0_drpaddr_in,
    gt0_drpdi_in,
    gt0_drpdo_out,
    gt0_drpen_in,
    gt0_drprdy_out,
    gt0_drpwe_in,
    gt1_drpaddr_in,
    gt1_drpdi_in,
    gt1_drpdo_out,
    gt1_drpen_in,
    gt1_drprdy_out,
    gt1_drpwe_in,
    gt2_drpaddr_in,
    gt2_drpdi_in,
    gt2_drpdo_out,
    gt2_drpen_in,
    gt2_drprdy_out,
    gt2_drpwe_in,
    gt3_drpaddr_in,
    gt3_drpdi_in,
    gt3_drpdo_out,
    gt3_drpen_in,
    gt3_drprdy_out,
    gt3_drpwe_in,
    tx_out_clk,
//------------------{
//------------------}
    bufg_gt_clr_out,

    sys_reset_out,
    loopback
);


`define DLY #1

//***********************************Port Declarations*******************************
output        sys_reset_out;

//------------------{
//------------------}


    // AXI RX Interface
output  [63:0]     m_axi_rx_tdata;
output  [7:0]      m_axi_rx_tkeep;
 
output             m_axi_rx_tvalid;
output             m_axi_rx_tlast;



    // GT Serial I/O
input   [0:3]      rxp;
input   [0:3]      rxn;
    // GT Reference Clock Interface
input              gt_refclk1;

    // Error Detection Interface
output             rx_hard_err;
output             soft_err;
output             frame_err;

    // Status
output             rx_channel_up;
output  [0:3]      rx_lane_up;



    // System Interface
input              user_clk;
input              sync_clk;
input              rx_system_reset;
    output             rx_resetdone_out;
    output             link_reset_out;
    output             bufg_gt_clr_out;

input              power_down;
input              gt_reset;
output             tx_lock;    
output             tx_out_clk;
    input              init_clk_in;
    input              pll_not_locked;

    //DRP Ports
    input   [8:0]     gt0_drpaddr_in;  
    input             gt0_drpen_in;  
    input   [15:0]    gt0_drpdi_in;  
    output            gt0_drprdy_out;  
    output  [15:0]    gt0_drpdo_out;  
    input             gt0_drpwe_in;  
    input   [8:0]     gt1_drpaddr_in;  
    input             gt1_drpen_in;  
    input   [15:0]    gt1_drpdi_in;  
    output            gt1_drprdy_out;  
    output  [15:0]    gt1_drpdo_out;  
    input             gt1_drpwe_in;  
    input   [8:0]     gt2_drpaddr_in;  
    input             gt2_drpen_in;  
    input   [15:0]    gt2_drpdi_in;  
    output            gt2_drprdy_out;  
    output  [15:0]    gt2_drpdo_out;  
    input             gt2_drpwe_in;  
    input   [8:0]     gt3_drpaddr_in;  
    input             gt3_drpen_in;  
    input   [15:0]    gt3_drpdi_in;  
    output            gt3_drprdy_out;  
    output  [15:0]    gt3_drpdo_out;  
    input             gt3_drpwe_in;  
input   [2:0]      loopback;
//*********************************Wire Declarations**********************************
wire    [15:0]     open_i;

wire    [0:3]      TX1N_OUT_unused;
wire    [0:3]      TX1P_OUT_unused;
wire    [0:3]      RX1N_IN_unused;
wire    [0:3]      RX1P_IN_unused;
wire    [3:0]      ch_bond_done_i_unused;
wire    [7:0]      rx_char_is_comma_i_unused;
wire    [3:0]      rx_buf_err_i_unused;
wire    [7:0]      rx_char_is_k_i_unused;
wire    [63:0]     rx_data_i_unused;
wire    [7:0]      rx_disp_err_i_unused;
wire    [7:0]      rx_not_in_table_i_unused;
wire    [3:0]      rx_realign_i_unused;
wire    [3:0]      tx_buf_err_i_unused;

wire    [3:0]      ch_bond_done_i;
reg     [3:0]      ch_bond_done_r1;
reg     [3:0]      ch_bond_done_r2;
wire               en_chan_sync_i;
wire    [3:0]      ena_comma_align_i;
wire    [0:7]      got_a_i;
wire    [0:3]      got_v_i;
wire    [3:0]      gtp_rx_reset_i;
wire    [3:0]      gtp_tx_reset_i;
wire    [3:0]      open_rx_rec1_clk_i;
wire    [3:0]      open_rx_rec2_clk_i;
wire    [3:0]      raw_rx_rec_clk_i;
wire    [0:3]      raw_tx_out_clk_i;
wire    [3:0]      rx_buf_err_i;
wire               rx_channel_up_i;
wire    [7:0]      rx_char_is_comma_i;
wire    [7:0]      rx_char_is_k_i;
wire    [11:0]     rx_clk_cor_cnt_i;
wire    [63:0]     rx_data_i;
wire    [7:0]      rx_disp_err_i;
wire    [0:3]      rx_ecp_i;
wire    [0:3]      rx_hard_err_i;
wire    [0:3]      rx_lane_up_i;
wire    [7:0]      rx_not_in_table_i;
wire    [0:3]      rx_pad_i;
wire    [0:63]     rx_pe_data_i;
wire    [0:3]      rx_pe_data_v_i;
wire    [3:0]      rx_polarity_i;
wire    [3:0]      rx_realign_i;
wire    [3:0]      rx_rec_clk_i;
wire    [0:3]      rx_reset_lanes_i;
wire    [0:3]      rx_scp_i;
wire    [0:3]      soft_err_i;
wire               start_rx_i;
wire               tied_to_ground_i;
wire    [63:0]     tied_to_ground_vec_i;
wire               tied_to_vcc_i;
wire    [3:0]      tx_buf_err_i;
wire    [7:0]      tx_char_is_k_i;
wire    [63:0]     tx_data_i;
wire    [3:0]      tx_lock_i;
wire    [0:3]      tx_out_clk_i;

reg   [0:3]      ch_bond_load_pulse_i;
reg   [0:3]      ch_bond_done_dly_i;
wire    [0:63]     tied_to_gnd_vec_i;
    // RX AXI PDU I/F wires
wire    [0:63]     rx_data;
wire    [0:2]      rx_rem_int;
wire               rx_src_rdy;
wire               rx_sof;
wire               rx_eof;
    wire          link_reset_lane0_i;
    wire          link_reset_lane1_i;
    wire          link_reset_lane2_i;
    wire          link_reset_lane3_i;
    wire          link_reset_i;

wire   gtrxreset_i;
wire   system_reset_i;
wire   tx_lock_comb_i;
wire   hpcnt_reset_i;
wire   rx_resetdone_i;
wire   reset_sync_init_clk;
wire   reset_sync_user_clk;
wire   gt_reset_sync_init_clk;
reg    rxfsm_data_valid_r;
wire   gtwiz_userclk_tx_reset_int;
wire  [3 : 0]          gt_txpmaresetdone_int;
wire  [3 : 0]          gt_rxpmaresetdone_int;
//*********************************Main Body of Code**********************************

    // Tie off constant signals
    assign          tied_to_gnd_vec_i        = 64'd0;
    assign          tied_to_ground_i         = 1'b0;
    assign          tied_to_ground_vec_i     = 64'd0;
    assign          tied_to_vcc_i            = 1'b1;

    assign  link_reset_i   =  link_reset_lane0_i || link_reset_lane1_i || link_reset_lane2_i || link_reset_lane3_i ;

    always @ (posedge user_clk)
      rxfsm_data_valid_r  <= `DLY &rx_lane_up_i;

    assign  link_reset_out = link_reset_i;



    assign          tx_lock     =   tx_lock_comb_i;
    assign          sys_reset_out    =  system_reset_i;



    // Connect global top level signals to their internal equivalents

    assign          rx_channel_up       =   rx_channel_up_i;
    assign          rx_resetdone_out =  rx_resetdone_i;

    //Connect the TXOUTCLK of lane 0 to tx_out_clk
assign  tx_out_clk  =  tx_out_clk_i[2] ;
 
 

    assign reset_sync_user_clk = rx_system_reset;
    assign gt_reset_sync_init_clk = gt_reset;
   
    // Connect the tx_lock signal to tx_lock_i from lane 0
    assign  tx_lock_comb_i     =  &tx_lock_i;

    // RESET_LOGIC instance
    system_i_bak_aurora_8b10b_0_0_RESET_LOGIC core_reset_logic_i
    (
        .RESET(reset_sync_user_clk),
        .USER_CLK(user_clk),
        .INIT_CLK_IN(init_clk_in),
        .TX_LOCK_IN(tx_lock_comb_i),
        .PLL_NOT_LOCKED(pll_not_locked),
 
  	     .RX_RESETDONE_IN(rx_resetdone_i),
        .LINK_RESET_IN(link_reset_i),
 
        .SYSTEM_RESET(system_reset_i)
    );

  system_i_bak_aurora_8b10b_0_0_cdc_sync
     #(
        .c_cdc_type      (1             ),   
        .c_flop_input    (1             ),  
        .c_reset_state   (0             ),  
        .c_single_bit    (1             ),  
        .c_vector_width  (2             ),  
        .c_mtbf_stages   (3              )
      )hpcnt_reset_cdc_sync
      (
        .prmry_aclk      (user_clk           ),
        .prmry_rst_n     (1'b1               ),
        .prmry_in        (rx_system_reset    ),
        .prmry_vect_in   (2'd0               ),
        .scndry_aclk     (init_clk_in        ),
        .scndry_rst_n    (1'b1               ),
        .prmry_ack       (                   ),
        .scndry_out      (reset_sync_init_clk),
        .scndry_vect_out (                   ) 
      );

assign hpcnt_reset_i = gt_reset_sync_init_clk | reset_sync_init_clk;
 





    //_________________________Instantiate RX Lane 0______________________________

assign          rx_lane_up [0] =   rx_lane_up_i [0];

    system_i_bak_aurora_8b10b_0_0_RX_AURORA_LANE_SIMPLEX_V5 # 
    (   
        .EXAMPLE_SIMULATION (EXAMPLE_SIMULATION)
    )
    rx_aurora_lane_simplex_v5_0_i
    (
        // GT Interface
        .RX_DATA(rx_data_i[15:0]),
        .RX_NOT_IN_TABLE(rx_not_in_table_i[1:0]),
        .RX_DISP_ERR(rx_disp_err_i[1:0]),
        .RX_CHAR_IS_K(rx_char_is_k_i[1:0]),
        .RX_CHAR_IS_COMMA(rx_char_is_comma_i[1:0]),
        .RX_STATUS(tied_to_ground_vec_i[5:0]),
        .RX_BUF_ERR(rx_buf_err_i [0]),
        .RX_REALIGN(rx_realign_i [0]),
        .RX_POLARITY(rx_polarity_i [0]),
        .V5_RX_RESET(gtp_rx_reset_i [0]),
        .INIT_CLK(init_clk_in),
        .LINK_RESET_OUT(link_reset_lane0_i),
        .HPCNT_RESET   (hpcnt_reset_i),

        // Comma Detect Phase Align Interface
        .ENA_COMMA_ALIGN(ena_comma_align_i [0]),

        // RX_LL Interface
        .RX_PAD(rx_pad_i [0]),
        .RX_PE_DATA(rx_pe_data_i[0:15]),
        .RX_PE_DATA_V(rx_pe_data_v_i [0]),
        .RX_SCP(rx_scp_i [0]),
        .RX_ECP(rx_ecp_i [0]),

        // Global Logic Interface
        .CHANNEL_UP(rx_channel_up_i),
        .LANE_UP(rx_lane_up_i [0]),
        .SOFT_ERR(soft_err_i [0]),
        .HARD_ERR(rx_hard_err_i [0]),
        .CHANNEL_BOND_LOAD(),
        .GOT_A(got_a_i[0:1]),
        .GOT_V(got_v_i [0]),

        // System Interface
        .USER_CLK(user_clk),
        .RESET(rx_reset_lanes_i [0])
    );


    // Tie off TX signals to the GT
    assign  tx_char_is_k_i[1:0]   =   2'b00;
    assign  tx_data_i[15:0]     =   16'h0000;
assign  gtp_tx_reset_i [0]  =   1'b0;






    //_________________________Instantiate RX Lane 1______________________________

assign          rx_lane_up [1] =   rx_lane_up_i [1];

    system_i_bak_aurora_8b10b_0_0_RX_AURORA_LANE_SIMPLEX_V5 # 
    (   
        .EXAMPLE_SIMULATION (EXAMPLE_SIMULATION)
    )
    rx_aurora_lane_simplex_v5_1_i
    (
        // GT Interface
        .RX_DATA(rx_data_i[31:16]),
        .RX_NOT_IN_TABLE(rx_not_in_table_i[3:2]),
        .RX_DISP_ERR(rx_disp_err_i[3:2]),
        .RX_CHAR_IS_K(rx_char_is_k_i[3:2]),
        .RX_CHAR_IS_COMMA(rx_char_is_comma_i[3:2]),
        .RX_STATUS(tied_to_ground_vec_i[5:0]),
        .RX_BUF_ERR(rx_buf_err_i [1]),
        .RX_REALIGN(rx_realign_i [1]),
        .RX_POLARITY(rx_polarity_i [1]),
        .V5_RX_RESET(gtp_rx_reset_i [1]),
        .INIT_CLK(init_clk_in),
        .LINK_RESET_OUT(link_reset_lane1_i),
        .HPCNT_RESET   (hpcnt_reset_i),

        // Comma Detect Phase Align Interface
        .ENA_COMMA_ALIGN(ena_comma_align_i [1]),

        // RX_LL Interface
        .RX_PAD(rx_pad_i [1]),
        .RX_PE_DATA(rx_pe_data_i[16:31]),
        .RX_PE_DATA_V(rx_pe_data_v_i [1]),
        .RX_SCP(rx_scp_i [1]),
        .RX_ECP(rx_ecp_i [1]),

        // Global Logic Interface
        .CHANNEL_UP(rx_channel_up_i),
        .LANE_UP(rx_lane_up_i [1]),
        .SOFT_ERR(soft_err_i [1]),
        .HARD_ERR(rx_hard_err_i [1]),
        .CHANNEL_BOND_LOAD(),
        .GOT_A(got_a_i[2:3]),
        .GOT_V(got_v_i [1]),

        // System Interface
        .USER_CLK(user_clk),
        .RESET(rx_reset_lanes_i [1])
    );


    // Tie off TX signals to the GT
    assign  tx_char_is_k_i[3:2]   =   2'b00;
    assign  tx_data_i[31:16]     =   16'h0000;
assign  gtp_tx_reset_i [1]  =   1'b0;






    //_________________________Instantiate RX Lane 2______________________________

assign          rx_lane_up [2] =   rx_lane_up_i [2];

    system_i_bak_aurora_8b10b_0_0_RX_AURORA_LANE_SIMPLEX_V5 # 
    (   
        .EXAMPLE_SIMULATION (EXAMPLE_SIMULATION)
    )
    rx_aurora_lane_simplex_v5_2_i
    (
        // GT Interface
        .RX_DATA(rx_data_i[47:32]),
        .RX_NOT_IN_TABLE(rx_not_in_table_i[5:4]),
        .RX_DISP_ERR(rx_disp_err_i[5:4]),
        .RX_CHAR_IS_K(rx_char_is_k_i[5:4]),
        .RX_CHAR_IS_COMMA(rx_char_is_comma_i[5:4]),
        .RX_STATUS(tied_to_ground_vec_i[5:0]),
        .RX_BUF_ERR(rx_buf_err_i [2]),
        .RX_REALIGN(rx_realign_i [2]),
        .RX_POLARITY(rx_polarity_i [2]),
        .V5_RX_RESET(gtp_rx_reset_i [2]),
        .INIT_CLK(init_clk_in),
        .LINK_RESET_OUT(link_reset_lane2_i),
        .HPCNT_RESET   (hpcnt_reset_i),

        // Comma Detect Phase Align Interface
        .ENA_COMMA_ALIGN(ena_comma_align_i [2]),

        // RX_LL Interface
        .RX_PAD(rx_pad_i [2]),
        .RX_PE_DATA(rx_pe_data_i[32:47]),
        .RX_PE_DATA_V(rx_pe_data_v_i [2]),
        .RX_SCP(rx_scp_i [2]),
        .RX_ECP(rx_ecp_i [2]),

        // Global Logic Interface
        .CHANNEL_UP(rx_channel_up_i),
        .LANE_UP(rx_lane_up_i [2]),
        .SOFT_ERR(soft_err_i [2]),
        .HARD_ERR(rx_hard_err_i [2]),
        .CHANNEL_BOND_LOAD(),
        .GOT_A(got_a_i[4:5]),
        .GOT_V(got_v_i [2]),

        // System Interface
        .USER_CLK(user_clk),
        .RESET(rx_reset_lanes_i [2])
    );


    // Tie off TX signals to the GT
    assign  tx_char_is_k_i[5:4]   =   2'b00;
    assign  tx_data_i[47:32]     =   16'h0000;
assign  gtp_tx_reset_i [2]  =   1'b0;






    //_________________________Instantiate RX Lane 3______________________________

assign          rx_lane_up [3] =   rx_lane_up_i [3];

    system_i_bak_aurora_8b10b_0_0_RX_AURORA_LANE_SIMPLEX_V5 # 
    (   
        .EXAMPLE_SIMULATION (EXAMPLE_SIMULATION)
    )
    rx_aurora_lane_simplex_v5_3_i
    (
        // GT Interface
        .RX_DATA(rx_data_i[63:48]),
        .RX_NOT_IN_TABLE(rx_not_in_table_i[7:6]),
        .RX_DISP_ERR(rx_disp_err_i[7:6]),
        .RX_CHAR_IS_K(rx_char_is_k_i[7:6]),
        .RX_CHAR_IS_COMMA(rx_char_is_comma_i[7:6]),
        .RX_STATUS(tied_to_ground_vec_i[5:0]),
        .RX_BUF_ERR(rx_buf_err_i [3]),
        .RX_REALIGN(rx_realign_i [3]),
        .RX_POLARITY(rx_polarity_i [3]),
        .V5_RX_RESET(gtp_rx_reset_i [3]),
        .INIT_CLK(init_clk_in),
        .LINK_RESET_OUT(link_reset_lane3_i),
        .HPCNT_RESET   (hpcnt_reset_i),

        // Comma Detect Phase Align Interface
        .ENA_COMMA_ALIGN(ena_comma_align_i [3]),

        // RX_LL Interface
        .RX_PAD(rx_pad_i [3]),
        .RX_PE_DATA(rx_pe_data_i[48:63]),
        .RX_PE_DATA_V(rx_pe_data_v_i [3]),
        .RX_SCP(rx_scp_i [3]),
        .RX_ECP(rx_ecp_i [3]),

        // Global Logic Interface
        .CHANNEL_UP(rx_channel_up_i),
        .LANE_UP(rx_lane_up_i [3]),
        .SOFT_ERR(soft_err_i [3]),
        .HARD_ERR(rx_hard_err_i [3]),
        .CHANNEL_BOND_LOAD(),
        .GOT_A(got_a_i[6:7]),
        .GOT_V(got_v_i [3]),

        // System Interface
        .USER_CLK(user_clk),
        .RESET(rx_reset_lanes_i [3])
    );


    // Tie off TX signals to the GT
    assign  tx_char_is_k_i[7:6]   =   2'b00;
    assign  tx_data_i[63:48]     =   16'h0000;
assign  gtp_tx_reset_i [3]  =   1'b0;




  assign gtwiz_userclk_tx_reset_int  =  !(&gt_rxpmaresetdone_int);
  assign bufg_gt_clr_out             =  gtwiz_userclk_tx_reset_int;

    //_________________________Instantiate GT Wrapper ______________________________

    system_i_bak_aurora_8b10b_0_0_GT_WRAPPER  gt_wrapper_i
    (
     .gtwiz_userclk_tx_reset_in      (gtwiz_userclk_tx_reset_int),
    .gt_txpmaresetdone       (),
    .gt_rxpmaresetdone       (gt_rxpmaresetdone_int),


        // DRP I/F
.DRPADDR_IN                     (gt0_drpaddr_in),
.DRPCLK_IN                      (init_clk_in),
.DRPDI_IN                       (gt0_drpdi_in),
.DRPDO_OUT                      (gt0_drpdo_out),
.DRPEN_IN                       (gt0_drpen_in),
.DRPRDY_OUT                     (gt0_drprdy_out),
.DRPWE_IN                       (gt0_drpwe_in),
.DRPADDR_IN_LANE1                     (gt1_drpaddr_in),
.DRPCLK_IN_LANE1                      (init_clk_in),
.DRPDI_IN_LANE1                       (gt1_drpdi_in),
.DRPDO_OUT_LANE1                      (gt1_drpdo_out),
.DRPEN_IN_LANE1                       (gt1_drpen_in),
.DRPRDY_OUT_LANE1                     (gt1_drprdy_out),
.DRPWE_IN_LANE1                       (gt1_drpwe_in),
.DRPADDR_IN_LANE2                     (gt2_drpaddr_in),
.DRPCLK_IN_LANE2                      (init_clk_in),
.DRPDI_IN_LANE2                       (gt2_drpdi_in),
.DRPDO_OUT_LANE2                      (gt2_drpdo_out),
.DRPEN_IN_LANE2                       (gt2_drpen_in),
.DRPRDY_OUT_LANE2                     (gt2_drprdy_out),
.DRPWE_IN_LANE2                       (gt2_drpwe_in),
.DRPADDR_IN_LANE3                     (gt3_drpaddr_in),
.DRPCLK_IN_LANE3                      (init_clk_in),
.DRPDI_IN_LANE3                       (gt3_drpdi_in),
.DRPDO_OUT_LANE3                      (gt3_drpdo_out),
.DRPEN_IN_LANE3                       (gt3_drpen_in),
.DRPRDY_OUT_LANE3                     (gt3_drprdy_out),
.DRPWE_IN_LANE3                       (gt3_drpwe_in),

        .INIT_CLK_IN                    (init_clk_in),   
	.PLL_NOT_LOCKED                 (pll_not_locked),
        .RXFSM_DATA_VALID            (rxfsm_data_valid_r),
	.TX_RESETDONE_OUT               (),
	.RX_RESETDONE_OUT               (rx_resetdone_i),
        // Aurora Lane Interface
.RXPOLARITY_IN(rx_polarity_i [0]),
.RXPOLARITY_IN_LANE1(rx_polarity_i [1]),
.RXPOLARITY_IN_LANE2(rx_polarity_i [2]),
.RXPOLARITY_IN_LANE3(rx_polarity_i [3]),
.RXRESET_IN(gtp_rx_reset_i [0]),
.RXRESET_IN_LANE1(gtp_rx_reset_i [1]),
.RXRESET_IN_LANE2(gtp_rx_reset_i [2]),
.RXRESET_IN_LANE3(gtp_rx_reset_i [3]),
.TXCHARISK_IN(tx_char_is_k_i[1:0]),
.TXCHARISK_IN_LANE1(tx_char_is_k_i[3:2]),
.TXCHARISK_IN_LANE2(tx_char_is_k_i[5:4]),
.TXCHARISK_IN_LANE3(tx_char_is_k_i[7:6]),
.TXDATA_IN(tx_data_i[15:0]),
.TXDATA_IN_LANE1(tx_data_i[31:16]),
.TXDATA_IN_LANE2(tx_data_i[47:32]),
.TXDATA_IN_LANE3(tx_data_i[63:48]),
.TXRESET_IN(gtp_tx_reset_i [0]),
.TXRESET_IN_LANE1(gtp_tx_reset_i [1]),
.TXRESET_IN_LANE2(gtp_tx_reset_i [2]),
.TXRESET_IN_LANE3(gtp_tx_reset_i [3]),
.RXDATA_OUT(rx_data_i[15:0]),
.RXDATA_OUT_LANE1(rx_data_i[31:16]),
.RXDATA_OUT_LANE2(rx_data_i[47:32]),
.RXDATA_OUT_LANE3(rx_data_i[63:48]),
.RXNOTINTABLE_OUT(rx_not_in_table_i[1:0]),
.RXNOTINTABLE_OUT_LANE1(rx_not_in_table_i[3:2]),
.RXNOTINTABLE_OUT_LANE2(rx_not_in_table_i[5:4]),
.RXNOTINTABLE_OUT_LANE3(rx_not_in_table_i[7:6]),
.RXDISPERR_OUT(rx_disp_err_i[1:0]),
.RXDISPERR_OUT_LANE1(rx_disp_err_i[3:2]),
.RXDISPERR_OUT_LANE2(rx_disp_err_i[5:4]),
.RXDISPERR_OUT_LANE3(rx_disp_err_i[7:6]),
.RXCHARISK_OUT(rx_char_is_k_i[1:0]),
.RXCHARISK_OUT_LANE1(rx_char_is_k_i[3:2]),
.RXCHARISK_OUT_LANE2(rx_char_is_k_i[5:4]),
.RXCHARISK_OUT_LANE3(rx_char_is_k_i[7:6]),
.RXCHARISCOMMA_OUT(rx_char_is_comma_i[1:0]),
.RXCHARISCOMMA_OUT_LANE1(rx_char_is_comma_i[3:2]),
.RXCHARISCOMMA_OUT_LANE2(rx_char_is_comma_i[5:4]),
.RXCHARISCOMMA_OUT_LANE3(rx_char_is_comma_i[7:6]),
.RXREALIGN_OUT(rx_realign_i [0]),
.RXREALIGN_OUT_LANE1(rx_realign_i [1]),
.RXREALIGN_OUT_LANE2(rx_realign_i [2]),
.RXREALIGN_OUT_LANE3(rx_realign_i [3]),
.RXBUFERR_OUT(rx_buf_err_i [0]),
.RXBUFERR_OUT_LANE1(rx_buf_err_i [1]),
.RXBUFERR_OUT_LANE2(rx_buf_err_i [2]),
.RXBUFERR_OUT_LANE3(rx_buf_err_i [3]),
.TXBUFERR_OUT(tx_buf_err_i [0]),
.TXBUFERR_OUT_LANE1(tx_buf_err_i [1]),
.TXBUFERR_OUT_LANE2(tx_buf_err_i [2]),
.TXBUFERR_OUT_LANE3(tx_buf_err_i [3]),

        // Reset due to channel initialization watchdog timer expiry
        .GTRXRESET_IN(gtrxreset_i),

        // reset for hot plug
        .LINK_RESET_IN(link_reset_i),

        // Phase Align Interface
.ENMCOMMAALIGN_IN(ena_comma_align_i [0]),
.ENMCOMMAALIGN_IN_LANE1(ena_comma_align_i [1]),
.ENMCOMMAALIGN_IN_LANE2(ena_comma_align_i [2]),
.ENMCOMMAALIGN_IN_LANE3(ena_comma_align_i [3]),
.ENPCOMMAALIGN_IN(ena_comma_align_i [0]),
.ENPCOMMAALIGN_IN_LANE1(ena_comma_align_i [1]),
.ENPCOMMAALIGN_IN_LANE2(ena_comma_align_i [2]),
.ENPCOMMAALIGN_IN_LANE3(ena_comma_align_i [3]),
        // Global Logic Interface
.ENCHANSYNC_IN(tied_to_vcc_i),
.ENCHANSYNC_IN_LANE1(en_chan_sync_i),
.ENCHANSYNC_IN_LANE2(tied_to_vcc_i),
.ENCHANSYNC_IN_LANE3(tied_to_vcc_i),
.CHBONDDONE_OUT(ch_bond_done_i [0]),
.CHBONDDONE_OUT_LANE1(ch_bond_done_i [1]),
.CHBONDDONE_OUT_LANE2(ch_bond_done_i [2]),
.CHBONDDONE_OUT_LANE3(ch_bond_done_i [3]),

        // Serial IO
.RX1N_IN(rxn [0]),
.RX1N_IN_LANE1(rxn [1]),
.RX1N_IN_LANE2(rxn [2]),
.RX1N_IN_LANE3(rxn [3]),
.RX1P_IN(rxp [0]),
.RX1P_IN_LANE1(rxp [1]),
.RX1P_IN_LANE2(rxp [2]),
.RX1P_IN_LANE3(rxp [3]),
.TX1N_OUT(),
.TX1N_OUT_LANE1(),
.TX1N_OUT_LANE2(),
.TX1N_OUT_LANE3(),
.TX1P_OUT(),
.TX1P_OUT_LANE1(),
.TX1P_OUT_LANE2(),
.TX1P_OUT_LANE3(),
        // Clocks and Clock Status
        .RXUSRCLK_IN(sync_clk),
        .RXUSRCLK2_IN(user_clk),
        .TXUSRCLK_IN(sync_clk),
        .TXUSRCLK2_IN(user_clk),
        .REFCLK(gt_refclk1),

.TXOUTCLK1_OUT(tx_out_clk_i [0]),
.TXOUTCLK1_OUT_LANE1(tx_out_clk_i [1]),
.TXOUTCLK1_OUT_LANE2(tx_out_clk_i [2]),
.TXOUTCLK1_OUT_LANE3(tx_out_clk_i [3]),
.PLLLKDET_OUT(tx_lock_i [0]),
.PLLLKDET_OUT_LANE1(tx_lock_i [1]),
.PLLLKDET_OUT_LANE2(tx_lock_i [2]),
.PLLLKDET_OUT_LANE3(tx_lock_i [3]),
        // System Interface
        .GTRESET_IN(gt_reset_sync_init_clk),
        .LOOPBACK_IN(loopback),


//------------------{
//------------------}

    .POWERDOWN_IN(power_down)
    );


  // FF stages added for timing closure
  always @(posedge user_clk)
        ch_bond_done_r1  <=  `DLY    ch_bond_done_i;

  always @(posedge user_clk)
        ch_bond_done_r2  <=  `DLY    ch_bond_done_r1;

  always @(posedge user_clk)
       if (system_reset_i)
         ch_bond_done_dly_i <= 4'b0;
       else if (en_chan_sync_i)
         ch_bond_done_dly_i <= ch_bond_done_r2;
       else
         ch_bond_done_dly_i <= 4'b0;

  always @(posedge user_clk)
      if (system_reset_i)
        ch_bond_load_pulse_i <= 4'b0;
      else if(en_chan_sync_i)
        ch_bond_load_pulse_i <= ch_bond_done_r2 & ~ch_bond_done_dly_i;
      else
        ch_bond_load_pulse_i <= 4'b0;

    //_____________________________Instantiate RX Global Logic ___________________________

    system_i_bak_aurora_8b10b_0_0_RX_GLOBAL_LOGIC_SIMPLEX #
    (
       .WATCHDOG_TIMEOUT (WATCHDOG_TIMEOUT)
    )
    rx_global_logic_simplex_i
    (
        // GT Interface
        .CH_BOND_DONE(ch_bond_done_i),

        .EN_CHAN_SYNC(en_chan_sync_i),

        // Aurora Lane Interface
        .LANE_UP(rx_lane_up_i),
        .SOFT_ERR(soft_err_i),
        .HARD_ERR(rx_hard_err_i),
        .CHANNEL_BOND_LOAD(ch_bond_load_pulse_i),
        .GOT_A(got_a_i),
        .GOT_V(got_v_i),

        .RESET_LANES(rx_reset_lanes_i),
        .GTRXRESET_OUT(gtrxreset_i),

        // Sideband Signals
        .RX_ALIGNED(),
        .RX_BONDED(),
        .RX_VERIFY(),

        // System Interface
        .USER_CLK(user_clk),
        .RESET(system_reset_i),
        .POWER_DOWN(power_down),

        .CHANNEL_UP(rx_channel_up_i),
        .START_RX(start_rx_i),
        .CHANNEL_SOFT_ERR(soft_err),
        .CHANNEL_HARD_ERR(rx_hard_err)
    );




    //_____________________________ RX AXI SHIM _______________________________
    system_i_bak_aurora_8b10b_0_0_LL_TO_AXI #
    (
       .DATA_WIDTH(64),
       .STRB_WIDTH(8),
       .REM_WIDTH (3)
    )

    ll_to_axi_pdu_i
    (
     .LL_IP_DATA(rx_data),
     .LL_IP_SOF_N(rx_sof),
     .LL_IP_EOF_N(rx_eof),
     .LL_IP_REM(rx_rem_int),
     .LL_IP_SRC_RDY_N(rx_src_rdy),
     .LL_OP_DST_RDY_N(),

     .AXI4_S_OP_TVALID(m_axi_rx_tvalid),
     .AXI4_S_OP_TDATA(m_axi_rx_tdata),
     .AXI4_S_OP_TKEEP(m_axi_rx_tkeep),
     .AXI4_S_OP_TLAST(m_axi_rx_tlast),
     .AXI4_S_IP_TREADY()

    );



    //______________________________________Instantiate RX_LL__________________________________

    system_i_bak_aurora_8b10b_0_0_RX_LL   rx_ll_i
    (
        // AXI PDU Interface
        .RX_D(rx_data),
        .RX_REM(rx_rem_int),
        .RX_SRC_RDY_N(rx_src_rdy),
        .RX_SOF_N(rx_sof),
        .RX_EOF_N(rx_eof),


        // Global Logic Interface
        .START_RX(start_rx_i),

        // Aurora Lane Interface
        .RX_PAD(rx_pad_i),
        .RX_PE_DATA(rx_pe_data_i),
        .RX_PE_DATA_V(rx_pe_data_v_i),
        .RX_SCP(rx_scp_i),
        .RX_ECP(rx_ecp_i),

        // Error Interface
        .FRAME_ERR(frame_err),

        // System Interface
        .USER_CLK(user_clk)
    );

endmodule
