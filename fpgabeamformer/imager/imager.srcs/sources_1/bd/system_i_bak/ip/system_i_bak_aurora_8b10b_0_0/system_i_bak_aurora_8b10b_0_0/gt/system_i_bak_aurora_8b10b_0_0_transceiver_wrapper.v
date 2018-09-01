///////////////////////////////////////////////////////////////////////////////
// (c) Copyright 2014 Xilinx, Inc. All rights reserved.
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
////////////////////////////////////////////////////////////////////////////////
//
// Module system_i_bak_aurora_8b10b_0_0_GT_WRAPPER
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
(* core_generation_info = "system_i_bak_aurora_8b10b_0_0,aurora_8b10b_v11_0_4,{user_interface=AXI_4_Streaming,backchannel_mode=Timer,c_aurora_lanes=4,c_column_used=left,c_gt_clock_1=GTHQ0,c_gt_clock_2=None,c_gt_loc_1=1,c_gt_loc_10=X,c_gt_loc_11=X,c_gt_loc_12=X,c_gt_loc_13=X,c_gt_loc_14=X,c_gt_loc_15=X,c_gt_loc_16=X,c_gt_loc_17=X,c_gt_loc_18=X,c_gt_loc_19=X,c_gt_loc_2=2,c_gt_loc_20=X,c_gt_loc_21=X,c_gt_loc_22=X,c_gt_loc_23=X,c_gt_loc_24=X,c_gt_loc_25=X,c_gt_loc_26=X,c_gt_loc_27=X,c_gt_loc_28=X,c_gt_loc_29=X,c_gt_loc_3=3,c_gt_loc_30=X,c_gt_loc_31=X,c_gt_loc_32=X,c_gt_loc_33=X,c_gt_loc_34=X,c_gt_loc_35=X,c_gt_loc_36=X,c_gt_loc_37=X,c_gt_loc_38=X,c_gt_loc_39=X,c_gt_loc_4=4,c_gt_loc_40=X,c_gt_loc_41=X,c_gt_loc_42=X,c_gt_loc_43=X,c_gt_loc_44=X,c_gt_loc_45=X,c_gt_loc_46=X,c_gt_loc_47=X,c_gt_loc_48=X,c_gt_loc_5=X,c_gt_loc_6=X,c_gt_loc_7=X,c_gt_loc_8=X,c_gt_loc_9=X,c_lane_width=2,c_line_rate=62500,c_nfc=false,c_nfc_mode=IMM,c_refclk_frequency=125000,c_simplex=true,c_simplex_mode=RX,c_stream=false,c_ufc=false,flow_mode=None,interface_mode=Framing,dataflow_config=RX-only_Simplex}" *)
(* DowngradeIPIdentifiedWarnings="yes" *)
module system_i_bak_aurora_8b10b_0_0_GT_WRAPPER 
(

//---------------------- Loopback and Powerdown Ports ----------------------
    LOOPBACK_IN,
//--------------------- Receive Ports - 8b10b Decoder ----------------------
RXCHARISCOMMA_OUT,
RXCHARISCOMMA_OUT_LANE1,
RXCHARISCOMMA_OUT_LANE2,
RXCHARISCOMMA_OUT_LANE3,
RXCHARISK_OUT,
RXCHARISK_OUT_LANE1,
RXCHARISK_OUT_LANE2,
RXCHARISK_OUT_LANE3,
RXDISPERR_OUT,
RXDISPERR_OUT_LANE1,
RXDISPERR_OUT_LANE2,
RXDISPERR_OUT_LANE3,
RXNOTINTABLE_OUT,
RXNOTINTABLE_OUT_LANE1,
RXNOTINTABLE_OUT_LANE2,
RXNOTINTABLE_OUT_LANE3,
//----------------- Receive Ports - Channel Bonding Ports -----------------
ENCHANSYNC_IN,
ENCHANSYNC_IN_LANE1,
ENCHANSYNC_IN_LANE2,
ENCHANSYNC_IN_LANE3,
CHBONDDONE_OUT,
CHBONDDONE_OUT_LANE1,
CHBONDDONE_OUT_LANE2,
CHBONDDONE_OUT_LANE3,
//----------------- Receive Ports - Clock Correction Ports -----------------
RXBUFERR_OUT,
RXBUFERR_OUT_LANE1,
RXBUFERR_OUT_LANE2,
RXBUFERR_OUT_LANE3,
//------------- Receive Ports - Comma Detection and Alignment --------------
RXREALIGN_OUT,
RXREALIGN_OUT_LANE1,
RXREALIGN_OUT_LANE2,
RXREALIGN_OUT_LANE3,
ENMCOMMAALIGN_IN,
ENMCOMMAALIGN_IN_LANE1,
ENMCOMMAALIGN_IN_LANE2,
ENMCOMMAALIGN_IN_LANE3,
ENPCOMMAALIGN_IN,
ENPCOMMAALIGN_IN_LANE1,
ENPCOMMAALIGN_IN_LANE2,
ENPCOMMAALIGN_IN_LANE3,
//----------------- Receive Ports - RX Data Path interface -----------------
RXDATA_OUT,
RXDATA_OUT_LANE1,
RXDATA_OUT_LANE2,
RXDATA_OUT_LANE3,
RXRESET_IN,
RXRESET_IN_LANE1,
RXRESET_IN_LANE2,
RXRESET_IN_LANE3,
    RXUSRCLK_IN,
    RXUSRCLK2_IN,
//----- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
RX1N_IN,
RX1N_IN_LANE1,
RX1N_IN_LANE2,
RX1N_IN_LANE3,
RX1P_IN,
RX1P_IN_LANE1,
RX1P_IN_LANE2,
RX1P_IN_LANE3,
//--------------- Receive Ports - RX Polarity Control Ports ----------------
RXPOLARITY_IN,
RXPOLARITY_IN_LANE1,
RXPOLARITY_IN_LANE2,
RXPOLARITY_IN_LANE3,
//------------------- Shared Ports - Tile and PLL Ports --------------------
    REFCLK,
    INIT_CLK_IN,
    PLL_NOT_LOCKED,
    GTRESET_IN,
PLLLKDET_OUT,
PLLLKDET_OUT_LANE1,
PLLLKDET_OUT_LANE2,
PLLLKDET_OUT_LANE3,
    TX_RESETDONE_OUT,
    RX_RESETDONE_OUT,
//-------------- Transmit Ports - 8b10b Encoder Control Ports --------------
TXCHARISK_IN,
TXCHARISK_IN_LANE1,
TXCHARISK_IN_LANE2,
TXCHARISK_IN_LANE3,
//---------------- Transmit Ports - TX Data Path interface -----------------
TXDATA_IN,
TXDATA_IN_LANE1,
TXDATA_IN_LANE2,
TXDATA_IN_LANE3,
TXOUTCLK1_OUT,
TXOUTCLK1_OUT_LANE1,
TXOUTCLK1_OUT_LANE2,
TXOUTCLK1_OUT_LANE3,
TXRESET_IN,
TXRESET_IN_LANE1,
TXRESET_IN_LANE2,
TXRESET_IN_LANE3,
    TXUSRCLK_IN,
    TXUSRCLK2_IN,
TXBUFERR_OUT,
TXBUFERR_OUT_LANE1,
TXBUFERR_OUT_LANE2,
TXBUFERR_OUT_LANE3,
//------------- Transmit Ports - TX Driver and OOB signalling --------------
TX1N_OUT,
TX1N_OUT_LANE1,
TX1N_OUT_LANE2,
TX1N_OUT_LANE3,
TX1P_OUT,
TX1P_OUT_LANE1,
TX1P_OUT_LANE2,
TX1P_OUT_LANE3,
    //-------------- Channel - Dynamic Reconfiguration Port (DRP) --------------
DRPADDR_IN,
DRPCLK_IN,
DRPDI_IN,
DRPDO_OUT,
DRPEN_IN,
DRPRDY_OUT,
DRPWE_IN,
DRPADDR_IN_LANE1,
DRPCLK_IN_LANE1,
DRPDI_IN_LANE1,
DRPDO_OUT_LANE1,
DRPEN_IN_LANE1,
DRPRDY_OUT_LANE1,
DRPWE_IN_LANE1,
DRPADDR_IN_LANE2,
DRPCLK_IN_LANE2,
DRPDI_IN_LANE2,
DRPDO_OUT_LANE2,
DRPEN_IN_LANE2,
DRPRDY_OUT_LANE2,
DRPWE_IN_LANE2,
DRPADDR_IN_LANE3,
DRPCLK_IN_LANE3,
DRPDI_IN_LANE3,
DRPDO_OUT_LANE3,
DRPEN_IN_LANE3,
DRPRDY_OUT_LANE3,
DRPWE_IN_LANE3,
    gtwiz_userclk_tx_reset_in,
    gt_rxpmaresetdone,
    gt_txpmaresetdone,
    GTRXRESET_IN,
    LINK_RESET_IN,
    RXFSM_DATA_VALID,
    POWERDOWN_IN
);

`define DLY #1
//***************************** Port Declarations *****************************
//---------------------- Loopback and Powerdown Ports ----------------------
 input    [2:0]    LOOPBACK_IN;
//--------------------- Receive Ports - 8b10b Decoder ----------------------
output  [1:0]  RXCHARISCOMMA_OUT;
output  [1:0]  RXCHARISK_OUT;
output  [1:0]  RXDISPERR_OUT;
output  [1:0]  RXNOTINTABLE_OUT;
output  [1:0]  RXCHARISCOMMA_OUT_LANE1;
output  [1:0]  RXCHARISK_OUT_LANE1;
output  [1:0]  RXDISPERR_OUT_LANE1;
output  [1:0]  RXNOTINTABLE_OUT_LANE1;
output  [1:0]  RXCHARISCOMMA_OUT_LANE2;
output  [1:0]  RXCHARISK_OUT_LANE2;
output  [1:0]  RXDISPERR_OUT_LANE2;
output  [1:0]  RXNOTINTABLE_OUT_LANE2;
output  [1:0]  RXCHARISCOMMA_OUT_LANE3;
output  [1:0]  RXCHARISK_OUT_LANE3;
output  [1:0]  RXDISPERR_OUT_LANE3;
output  [1:0]  RXNOTINTABLE_OUT_LANE3;
//----------------- Receive Ports - Channel Bonding Ports -----------------
input             ENCHANSYNC_IN;
output            CHBONDDONE_OUT;
//----------------- Receive Ports - Clock Correction Ports -----------------
output            RXBUFERR_OUT;
//------------- Receive Ports - Comma Detection and Alignment --------------
output            RXREALIGN_OUT;
input             ENMCOMMAALIGN_IN;
input             ENPCOMMAALIGN_IN;
//----------------- Receive Ports - RX Data Path interface -----------------
output  [15:0]   RXDATA_OUT;
input             RXRESET_IN;
input             ENCHANSYNC_IN_LANE1;
output            CHBONDDONE_OUT_LANE1;
//----------------- Receive Ports - Clock Correction Ports -----------------
output            RXBUFERR_OUT_LANE1;
//------------- Receive Ports - Comma Detection and Alignment --------------
output            RXREALIGN_OUT_LANE1;
input             ENMCOMMAALIGN_IN_LANE1;
input             ENPCOMMAALIGN_IN_LANE1;
//----------------- Receive Ports - RX Data Path interface -----------------
output  [15:0]   RXDATA_OUT_LANE1;
input             RXRESET_IN_LANE1;
input             ENCHANSYNC_IN_LANE2;
output            CHBONDDONE_OUT_LANE2;
//----------------- Receive Ports - Clock Correction Ports -----------------
output            RXBUFERR_OUT_LANE2;
//------------- Receive Ports - Comma Detection and Alignment --------------
output            RXREALIGN_OUT_LANE2;
input             ENMCOMMAALIGN_IN_LANE2;
input             ENPCOMMAALIGN_IN_LANE2;
//----------------- Receive Ports - RX Data Path interface -----------------
output  [15:0]   RXDATA_OUT_LANE2;
input             RXRESET_IN_LANE2;
input             ENCHANSYNC_IN_LANE3;
output            CHBONDDONE_OUT_LANE3;
//----------------- Receive Ports - Clock Correction Ports -----------------
output            RXBUFERR_OUT_LANE3;
//------------- Receive Ports - Comma Detection and Alignment --------------
output            RXREALIGN_OUT_LANE3;
input             ENMCOMMAALIGN_IN_LANE3;
input             ENPCOMMAALIGN_IN_LANE3;
//----------------- Receive Ports - RX Data Path interface -----------------
output  [15:0]   RXDATA_OUT_LANE3;
input             RXRESET_IN_LANE3;
 input             RXUSRCLK_IN;
 input             RXUSRCLK2_IN;
//----- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
input             RX1N_IN;
input             RX1P_IN;
//--------------- Receive Ports - RX Polarity Control Ports ----------------
input             RXPOLARITY_IN;
input             RX1N_IN_LANE1;
input             RX1P_IN_LANE1;
//--------------- Receive Ports - RX Polarity Control Ports ----------------
input             RXPOLARITY_IN_LANE1;
input             RX1N_IN_LANE2;
input             RX1P_IN_LANE2;
//--------------- Receive Ports - RX Polarity Control Ports ----------------
input             RXPOLARITY_IN_LANE2;
input             RX1N_IN_LANE3;
input             RX1P_IN_LANE3;
//--------------- Receive Ports - RX Polarity Control Ports ----------------
input             RXPOLARITY_IN_LANE3;
//------------------- Shared Ports - Tile and PLL Ports --------------------
 input             REFCLK;
 input             INIT_CLK_IN;
 input             PLL_NOT_LOCKED;
 input             GTRESET_IN;
output            PLLLKDET_OUT;
output            PLLLKDET_OUT_LANE1;
output            PLLLKDET_OUT_LANE2;
output            PLLLKDET_OUT_LANE3;
 output            TX_RESETDONE_OUT;
 output            RX_RESETDONE_OUT;
 input             POWERDOWN_IN;
 input             GTRXRESET_IN;  
 input             LINK_RESET_IN;
 input             RXFSM_DATA_VALID;
 input             gtwiz_userclk_tx_reset_in;
 output  [3 : 0]          gt_rxpmaresetdone;
 output  [3 : 0]          gt_txpmaresetdone;


//-------------- Transmit Ports - 8b10b Encoder Control Ports --------------
input    [1:0]  TXCHARISK_IN;
//---------------- Transmit Ports - TX Data Path interface -----------------
input    [15:0]  TXDATA_IN;
output            TXOUTCLK1_OUT;
input             TXRESET_IN;
output            TXBUFERR_OUT;
input    [1:0]  TXCHARISK_IN_LANE1;
//---------------- Transmit Ports - TX Data Path interface -----------------
input    [15:0]  TXDATA_IN_LANE1;
output            TXOUTCLK1_OUT_LANE1;
input             TXRESET_IN_LANE1;
output            TXBUFERR_OUT_LANE1;
input    [1:0]  TXCHARISK_IN_LANE2;
//---------------- Transmit Ports - TX Data Path interface -----------------
input    [15:0]  TXDATA_IN_LANE2;
output            TXOUTCLK1_OUT_LANE2;
input             TXRESET_IN_LANE2;
output            TXBUFERR_OUT_LANE2;
input    [1:0]  TXCHARISK_IN_LANE3;
//---------------- Transmit Ports - TX Data Path interface -----------------
input    [15:0]  TXDATA_IN_LANE3;
output            TXOUTCLK1_OUT_LANE3;
input             TXRESET_IN_LANE3;
output            TXBUFERR_OUT_LANE3;
 input             TXUSRCLK_IN;
 input             TXUSRCLK2_IN;
//------------- Transmit Ports - TX Driver and OOB signalling --------------
output            TX1N_OUT;
output            TX1P_OUT;
output            TX1N_OUT_LANE1;
output            TX1P_OUT_LANE1;
output            TX1N_OUT_LANE2;
output            TX1P_OUT_LANE2;
output            TX1N_OUT_LANE3;
output            TX1P_OUT_LANE3;
//-------------- Channel - Dynamic Reconfiguration Port (DRP) --------------
input   [8:0]   DRPADDR_IN;
input           DRPCLK_IN;
input   [15:0]  DRPDI_IN;
output  [15:0]  DRPDO_OUT;
input           DRPEN_IN;
output          DRPRDY_OUT;
input           DRPWE_IN;
input   [8:0]   DRPADDR_IN_LANE1;
input           DRPCLK_IN_LANE1;
input   [15:0]  DRPDI_IN_LANE1;
output  [15:0]  DRPDO_OUT_LANE1;
input           DRPEN_IN_LANE1;
output          DRPRDY_OUT_LANE1;
input           DRPWE_IN_LANE1;
input   [8:0]   DRPADDR_IN_LANE2;
input           DRPCLK_IN_LANE2;
input   [15:0]  DRPDI_IN_LANE2;
output  [15:0]  DRPDO_OUT_LANE2;
input           DRPEN_IN_LANE2;
output          DRPRDY_OUT_LANE2;
input           DRPWE_IN_LANE2;
input   [8:0]   DRPADDR_IN_LANE3;
input           DRPCLK_IN_LANE3;
input   [15:0]  DRPDI_IN_LANE3;
output  [15:0]  DRPDO_OUT_LANE3;
input           DRPEN_IN_LANE3;
output          DRPRDY_OUT_LANE3;
input           DRPWE_IN_LANE3;



 // Timing closure flipflops
 reg              gt_rxresetdone_r;
 reg              gt_rxresetdone_r2;
 reg              gt_rxresetdone_r3;
 reg              gt_txresetdone_r;
 reg              gt_txresetdone_r2;
 reg              gt_txresetdone_r3;

    (* keep = "TRUE" *) reg [ 0 : 0 ]  gtwiz_userclk_rx_active_in;
    (* keep = "TRUE" *) reg [ 0 : 0 ]  gtwiz_userclk_tx_active_in;

    wire  [ 0 : 0 ]  gtwiz_reset_rx_cdr_stable_out;
    wire  [ 0 : 0 ]  gtwiz_reset_all_in;
    wire  [ 0 : 0 ]  gtwiz_reset_clk_freerun_in;
    wire  [ 0 : 0 ]  gtwiz_reset_rx_data_good_in;
    wire  [ 0 : 0 ]  gtwiz_reset_rx_datapath_in;
    wire  [ 0 : 0 ]  gtwiz_reset_rx_pll_and_datapath_in;
    wire  [ 0 : 0 ]  gtwiz_reset_tx_datapath_in;
    wire  [ 0 : 0 ]  gtwiz_reset_tx_pll_and_datapath_in;
    wire  [ 0 : 0 ]  gtwiz_userclk_rx_active_in_t;
    wire  [ 0 : 0 ]  gtwiz_userclk_tx_active_in_t;
    wire  [ 0 : 0 ]  gtwiz_reset_tx_done_out;
    wire  [ 0 : 0 ]  gtwiz_reset_rx_done_out;

    wire  [3 : 0] cplllock_out ;
    wire  [3 : 0] gtrefclk0_in      ;
    wire  [35 : 0 ] drpaddr_in;
    wire  [3 : 0 ] drpclk_in;
    wire  [63 : 0 ] drpdi_in  ;
    wire  [63 : 0 ] drpdo_out ;
    wire  [3 : 0 ] drpen_in  ;
    wire  [3 : 0 ] drprdy_out;
    wire  [3 : 0 ] drpwe_in  ;
    wire  [11 : 0 ] loopback_in;
    wire  [3 : 0 ] rxpolarity_in ;
    wire  [63: 0 ] gtwiz_userdata_rx_out;
    wire  [3 : 0 ] gthrxn_in     ;
    wire  [3 : 0 ] gthrxp_in     ;
    wire  [11 : 0 ] rxbufstatus_out    ;//      (2:0
    wire  [3 : 0 ] rxresetdone_out    ;//
    wire  [63 : 0 ] gtwiz_userdata_tx_in;  
    wire  [3 : 0 ] gthtxn_out         ;//
    wire  [3 : 0 ] gthtxp_out         ;//
    wire  [3 : 0 ] txoutclk_out       ;//
    wire  [3 : 0 ] rxoutclk_out       ;//
    wire  [3 : 0 ] rxpmaresetdone_out ;//
    wire  [7 : 0 ] txbufstatus_out    ;//      (1:0
    wire  [3 : 0 ] txresetdone_out    ;//
    wire  [3 : 0 ] txusrclk_in;
    wire  [3 : 0 ] txusrclk2_in;
    wire  [3 : 0 ] rxusrclk_in;
    wire  [3 : 0 ] rxusrclk2_in;
    wire  [3 : 0 ] txpmaresetdone_out;
    wire  [7 : 0 ] rxpd_in;
    wire  [7 : 0 ] txpd_in;
    wire  [3 : 0 ] txdetectrx_in;
    wire  [3 : 0 ] txelecidle_in;
    wire  [3 : 0 ] rx8b10ben_in;
    wire  [3 : 0 ] tx8b10ben_in;
    wire  [3 : 0 ] rxmcommaalignen_in;
    wire  [3 : 0 ] rxpcommaalignen_in;
    wire  [3 : 0 ] rxbyterealign_out;
    wire  [63 : 0 ] rxctrl0_out;
    wire  [63 : 0 ] rxctrl1_out;
    wire  [31 : 0 ] rxctrl2_out;
    wire  [31 : 0 ] rxctrl3_out;
    wire  [63 : 0 ] txctrl0_in;
    wire  [63 : 0 ] txctrl1_in;
    wire  [31 : 0 ] txctrl2_in;
    wire  [7 : 0 ] rxclkcorcnt_out       ;//      (2:0
    wire  [3 : 0 ] rxcommadeten_in;
    wire  [3 : 0 ] rxbufreset_in      ;//
    wire  [3 : 0 ] rxcommadet_out;
    // Channel Bonding Signals
    wire  [3 : 0 ] rxchanbondseq_out;
    wire  [3 : 0 ] rxbyteisaligned_out;
    wire  [3 : 0 ] rxchanisaligned_out;
    wire  [3 : 0 ] rxchanrealign_out;
    wire  [3 : 0 ] rxchbonden_in;
    wire  [3 : 0 ] rxchbondmaster_in;
    wire  [3 : 0 ] rxchbondslave_in;
    wire  [11 : 0 ] rxchbondlevel_in;
    wire  [19 : 0 ] rxchbondi_in;
    wire  [19 : 0 ] rxchbondo_out;
    wire     [4:0]    chbondi_unused_i;

   wire               gtrxreset_sync; 
   reg                gtrxreset_r1; 
   reg                gtrxreset_r2; 
   reg                gtrxreset_r3; 
   reg                gtrxreset_pulse;
   reg                link_reset_r;
   reg                link_reset_r2;
   reg                rxfsm_soft_reset_r;

//********************************* Main Body of Code**************************

     // Clock domain crossing from USER_CLK to INIT_CLK
      system_i_bak_aurora_8b10b_0_0_cdc_sync
        #(
           .c_cdc_type      (1             ),   
           .c_flop_input    (1             ),  
           .c_reset_state   (0             ),  
           .c_single_bit    (1             ),  
           .c_vector_width  (2             ),  
           .c_mtbf_stages   (3              )
         )gtrxreset_cdc_sync 
         (
           .prmry_aclk      (RXUSRCLK2_IN        ),
           .prmry_rst_n     (1'b1                ),
           .prmry_in        (GTRXRESET_IN        ),
           .prmry_vect_in   (2'd0                ),
           .scndry_aclk     (INIT_CLK_IN         ),
           .scndry_rst_n    (1'b1                ),
           .prmry_ack       (                    ),
           .scndry_out      (gtrxreset_sync      ),
           .scndry_vect_out (                    ) 
          );

    always @ (posedge INIT_CLK_IN)
    begin
      gtrxreset_r1    <=  `DLY  gtrxreset_sync;
      gtrxreset_r2    <=  `DLY  gtrxreset_r1;
      gtrxreset_r3    <=  `DLY  gtrxreset_r2;
      gtrxreset_pulse <=  `DLY  gtrxreset_r2 && !gtrxreset_r3; 
    end 

      always @(posedge INIT_CLK_IN)
      begin
        link_reset_r        <= `DLY  LINK_RESET_IN;
        link_reset_r2       <= `DLY  link_reset_r;
        rxfsm_soft_reset_r  <= `DLY  link_reset_r2 || gtrxreset_pulse;
      end

//-------------------------  Static signal Assigments ---------------------
    assign gtwiz_reset_all_in                   =  1'b0 ;
    assign gtwiz_reset_rx_datapath_in           =  rxfsm_soft_reset_r ;
    assign gtwiz_reset_rx_pll_and_datapath_in   =  GTRESET_IN ;
    assign gtwiz_reset_tx_pll_and_datapath_in	=  GTRESET_IN ;
    assign gtwiz_reset_tx_datapath_in    	=  1'b0 ;
    assign gtwiz_reset_clk_freerun_in           =  INIT_CLK_IN ;
    assign gtwiz_reset_rx_data_good_in          =  1'b1;
    assign gtwiz_userclk_tx_active_in_t         =  !PLL_NOT_LOCKED ;  
    assign gtwiz_userclk_rx_active_in_t         =  !PLL_NOT_LOCKED ;     
    
    always @ (posedge RXUSRCLK2_IN) 
    begin 
      gtwiz_userclk_tx_active_in <= `DLY gtwiz_userclk_tx_active_in_t;
      gtwiz_userclk_rx_active_in <= `DLY gtwiz_userclk_rx_active_in_t;
    end 
 
    // Channel bonding signals
    assign chbondi_unused_i  = 5'b00000;

    assign rxchbonden_in[0]        =  ENCHANSYNC_IN ;
    assign CHBONDDONE_OUT  =  rxchanisaligned_out[0] ;
    assign rxchbonden_in[1]        =  ENCHANSYNC_IN_LANE1 ;
    assign CHBONDDONE_OUT_LANE1  =  rxchanisaligned_out[1] ;
    assign rxchbonden_in[2]        =  ENCHANSYNC_IN_LANE2 ;
    assign CHBONDDONE_OUT_LANE2  =  rxchanisaligned_out[2] ;
    assign rxchbonden_in[3]        =  ENCHANSYNC_IN_LANE3 ;
    assign CHBONDDONE_OUT_LANE3  =  rxchanisaligned_out[3] ;
    // Channel bond MASTER/SLAVE connection
    assign rxchbondmaster_in[0] = 1'b0 ;
    assign rxchbondslave_in[0] = 1'b1 ;
    assign rxchbondlevel_in[2:0] = 3'd1 ;
    assign rxchbondmaster_in[1] = 1'b1 ;
    assign rxchbondslave_in[1] = 1'b0 ;
    assign rxchbondlevel_in[5:3] = 3'd2 ;
    assign rxchbondmaster_in[2] = 1'b0 ;
    assign rxchbondslave_in[2] = 1'b1 ;
    assign rxchbondlevel_in[8:6] = 3'd1 ;
    assign rxchbondmaster_in[3] = 1'b0 ;
    assign rxchbondslave_in[3] = 1'b1 ;
    assign rxchbondlevel_in[11:9] = 3'd0 ;

 assign  rxchbondi_in[4:0] = rxchbondo_out[9:5];
 assign  rxchbondi_in[9:5] = chbondi_unused_i;
 assign  rxchbondi_in[14:10] = rxchbondo_out[9:5];
 assign  rxchbondi_in[19:15] = rxchbondo_out[14:10];


    //CPLL Interface for GT0 
    assign PLLLKDET_OUT       =  cplllock_out[0] ;
    assign gtrefclk0_in[0]        =  REFCLK ;


    //DRP Interface for GT0 
    assign DRPDO_OUT        =  drpdo_out[15 : 0] ;
    assign DRPRDY_OUT       =  drprdy_out[0] ;
    assign drpclk_in[0]         =  DRPCLK_IN ;
    assign drpen_in[0]          =  DRPEN_IN ;
    assign drpwe_in[0]          =  DRPWE_IN ;
    assign drpaddr_in[8 : 0] =  DRPADDR_IN ;
    assign drpdi_in[15 : 0] =  DRPDI_IN ;

    //Powerdown Interface for GT0 
    assign rxpd_in[1 : 0]             =  {POWERDOWN_IN, POWERDOWN_IN} ;
    assign txpd_in[1 : 0]             =  {POWERDOWN_IN, POWERDOWN_IN} ;
    assign txdetectrx_in[0]          =  POWERDOWN_IN ;
    assign txelecidle_in[0]          =  POWERDOWN_IN ;

    assign gthrxn_in[0]                 =  RX1N_IN ;
    assign gthrxp_in[0]                 =  RX1P_IN ;
    assign TX1N_OUT               =  gthtxn_out[0] ;
    assign TX1P_OUT               =  gthtxp_out[0] ;
    assign RXDATA_OUT       =  gtwiz_userdata_rx_out[15 : 0] ;
    assign gtwiz_userdata_tx_in[15 : 0] =  TXDATA_IN ;
    assign loopback_in[2 : 0]     =  LOOPBACK_IN ;
    assign rx8b10ben_in[0]        =  1'b1 ;
    assign RXREALIGN_OUT             =  rxbyterealign_out[0]  ;
    assign RXCHARISK_OUT             =  rxctrl0_out[1 : 0] ;
    assign RXDISPERR_OUT             =  rxctrl1_out[1 : 0] ;
    assign RXCHARISCOMMA_OUT             =  rxctrl2_out[1 : 0] ;
    assign RXNOTINTABLE_OUT             =  rxctrl3_out[1 : 0] ;
    assign rxmcommaalignen_in[0]             =  ENMCOMMAALIGN_IN ;
    assign rxpcommaalignen_in[0]             =  ENPCOMMAALIGN_IN ;
    assign rxpolarity_in[0]             =  RXPOLARITY_IN ;
    assign TXBUFERR_OUT  =  txbufstatus_out[1] ;
    assign RXBUFERR_OUT  =  rxbufstatus_out[2] ;
    assign rxusrclk_in[0]               =  RXUSRCLK_IN ;
    assign rxusrclk2_in[0]             =  RXUSRCLK2_IN ;
    assign txusrclk_in[0]               =  TXUSRCLK_IN ;
    assign txusrclk2_in[0]             =  TXUSRCLK2_IN ;
    assign tx8b10ben_in[0]        =  1'b1 ;
    assign txctrl0_in[15 : 0]          =  16'd0 ;
    assign txctrl1_in[15 : 0]          =  16'd0 ;
    assign txctrl2_in[7 : 0]          =  {6'd0,TXCHARISK_IN} ;
    assign TXOUTCLK1_OUT             =  txoutclk_out[0] ;
    assign rxcommadeten_in[0]        =  1'b1 ;


    //CPLL Interface for GT1 
    assign PLLLKDET_OUT_LANE1       =  cplllock_out[1] ;
    assign gtrefclk0_in[1]        =  REFCLK ;


    //DRP Interface for GT1 
    assign DRPDO_OUT_LANE1        =  drpdo_out[31 : 16] ;
    assign DRPRDY_OUT_LANE1       =  drprdy_out[1] ;
    assign drpclk_in[1]         =  DRPCLK_IN_LANE1 ;
    assign drpen_in[1]          =  DRPEN_IN_LANE1 ;
    assign drpwe_in[1]          =  DRPWE_IN_LANE1 ;
    assign drpaddr_in[17 : 9] =  DRPADDR_IN_LANE1 ;
    assign drpdi_in[31 : 16] =  DRPDI_IN_LANE1 ;

    //Powerdown Interface for GT1 
    assign rxpd_in[3 : 2]             =  {POWERDOWN_IN, POWERDOWN_IN} ;
    assign txpd_in[3 : 2]             =  {POWERDOWN_IN, POWERDOWN_IN} ;
    assign txdetectrx_in[1]          =  POWERDOWN_IN ;
    assign txelecidle_in[1]          =  POWERDOWN_IN ;

    assign gthrxn_in[1]                 =  RX1N_IN_LANE1 ;
    assign gthrxp_in[1]                 =  RX1P_IN_LANE1 ;
    assign TX1N_OUT_LANE1               =  gthtxn_out[1] ;
    assign TX1P_OUT_LANE1               =  gthtxp_out[1] ;
    assign RXDATA_OUT_LANE1       =  gtwiz_userdata_rx_out[31 : 16] ;
    assign gtwiz_userdata_tx_in[31 : 16] =  TXDATA_IN_LANE1 ;
    assign loopback_in[5 : 3]     =  LOOPBACK_IN ;
    assign rx8b10ben_in[1]        =  1'b1 ;
    assign RXREALIGN_OUT_LANE1             =  rxbyterealign_out[1]  ;
    assign RXCHARISK_OUT_LANE1             =  rxctrl0_out[17 : 16] ;
    assign RXDISPERR_OUT_LANE1             =  rxctrl1_out[17 : 16] ;
    assign RXCHARISCOMMA_OUT_LANE1             =  rxctrl2_out[9 : 8] ;
    assign RXNOTINTABLE_OUT_LANE1             =  rxctrl3_out[9 : 8] ;
    assign rxmcommaalignen_in[1]             =  ENMCOMMAALIGN_IN_LANE1 ;
    assign rxpcommaalignen_in[1]             =  ENPCOMMAALIGN_IN_LANE1 ;
    assign rxpolarity_in[1]             =  RXPOLARITY_IN_LANE1 ;
    assign TXBUFERR_OUT_LANE1  =  txbufstatus_out[3] ;
    assign RXBUFERR_OUT_LANE1  =  rxbufstatus_out[5] ;
    assign rxusrclk_in[1]               =  RXUSRCLK_IN ;
    assign rxusrclk2_in[1]             =  RXUSRCLK2_IN ;
    assign txusrclk_in[1]               =  TXUSRCLK_IN ;
    assign txusrclk2_in[1]             =  TXUSRCLK2_IN ;
    assign tx8b10ben_in[1]        =  1'b1 ;
    assign txctrl0_in[31 : 16]          =  16'd0 ;
    assign txctrl1_in[31 : 16]          =  16'd0 ;
    assign txctrl2_in[15 : 8]          =  {6'd0,TXCHARISK_IN_LANE1} ;
    assign TXOUTCLK1_OUT_LANE1             =  txoutclk_out[1] ;
    assign rxcommadeten_in[1]        =  1'b1 ;


    //CPLL Interface for GT2 
    assign PLLLKDET_OUT_LANE2       =  cplllock_out[2] ;
    assign gtrefclk0_in[2]        =  REFCLK ;


    //DRP Interface for GT2 
    assign DRPDO_OUT_LANE2        =  drpdo_out[47 : 32] ;
    assign DRPRDY_OUT_LANE2       =  drprdy_out[2] ;
    assign drpclk_in[2]         =  DRPCLK_IN_LANE2 ;
    assign drpen_in[2]          =  DRPEN_IN_LANE2 ;
    assign drpwe_in[2]          =  DRPWE_IN_LANE2 ;
    assign drpaddr_in[26 : 18] =  DRPADDR_IN_LANE2 ;
    assign drpdi_in[47 : 32] =  DRPDI_IN_LANE2 ;

    //Powerdown Interface for GT2 
    assign rxpd_in[5 : 4]             =  {POWERDOWN_IN, POWERDOWN_IN} ;
    assign txpd_in[5 : 4]             =  {POWERDOWN_IN, POWERDOWN_IN} ;
    assign txdetectrx_in[2]          =  POWERDOWN_IN ;
    assign txelecidle_in[2]          =  POWERDOWN_IN ;

    assign gthrxn_in[2]                 =  RX1N_IN_LANE2 ;
    assign gthrxp_in[2]                 =  RX1P_IN_LANE2 ;
    assign TX1N_OUT_LANE2               =  gthtxn_out[2] ;
    assign TX1P_OUT_LANE2               =  gthtxp_out[2] ;
    assign RXDATA_OUT_LANE2       =  gtwiz_userdata_rx_out[47 : 32] ;
    assign gtwiz_userdata_tx_in[47 : 32] =  TXDATA_IN_LANE2 ;
    assign loopback_in[8 : 6]     =  LOOPBACK_IN ;
    assign rx8b10ben_in[2]        =  1'b1 ;
    assign RXREALIGN_OUT_LANE2             =  rxbyterealign_out[2]  ;
    assign RXCHARISK_OUT_LANE2             =  rxctrl0_out[33 : 32] ;
    assign RXDISPERR_OUT_LANE2             =  rxctrl1_out[33 : 32] ;
    assign RXCHARISCOMMA_OUT_LANE2             =  rxctrl2_out[17 : 16] ;
    assign RXNOTINTABLE_OUT_LANE2             =  rxctrl3_out[17 : 16] ;
    assign rxmcommaalignen_in[2]             =  ENMCOMMAALIGN_IN_LANE2 ;
    assign rxpcommaalignen_in[2]             =  ENPCOMMAALIGN_IN_LANE2 ;
    assign rxpolarity_in[2]             =  RXPOLARITY_IN_LANE2 ;
    assign TXBUFERR_OUT_LANE2  =  txbufstatus_out[5] ;
    assign RXBUFERR_OUT_LANE2  =  rxbufstatus_out[8] ;
    assign rxusrclk_in[2]               =  RXUSRCLK_IN ;
    assign rxusrclk2_in[2]             =  RXUSRCLK2_IN ;
    assign txusrclk_in[2]               =  TXUSRCLK_IN ;
    assign txusrclk2_in[2]             =  TXUSRCLK2_IN ;
    assign tx8b10ben_in[2]        =  1'b1 ;
    assign txctrl0_in[47 : 32]          =  16'd0 ;
    assign txctrl1_in[47 : 32]          =  16'd0 ;
    assign txctrl2_in[23 : 16]          =  {6'd0,TXCHARISK_IN_LANE2} ;
    assign TXOUTCLK1_OUT_LANE2             =  txoutclk_out[2] ;
    assign rxcommadeten_in[2]        =  1'b1 ;


    //CPLL Interface for GT3 
    assign PLLLKDET_OUT_LANE3       =  cplllock_out[3] ;
    assign gtrefclk0_in[3]        =  REFCLK ;


    //DRP Interface for GT3 
    assign DRPDO_OUT_LANE3        =  drpdo_out[63 : 48] ;
    assign DRPRDY_OUT_LANE3       =  drprdy_out[3] ;
    assign drpclk_in[3]         =  DRPCLK_IN_LANE3 ;
    assign drpen_in[3]          =  DRPEN_IN_LANE3 ;
    assign drpwe_in[3]          =  DRPWE_IN_LANE3 ;
    assign drpaddr_in[35 : 27] =  DRPADDR_IN_LANE3 ;
    assign drpdi_in[63 : 48] =  DRPDI_IN_LANE3 ;

    //Powerdown Interface for GT3 
    assign rxpd_in[7 : 6]             =  {POWERDOWN_IN, POWERDOWN_IN} ;
    assign txpd_in[7 : 6]             =  {POWERDOWN_IN, POWERDOWN_IN} ;
    assign txdetectrx_in[3]          =  POWERDOWN_IN ;
    assign txelecidle_in[3]          =  POWERDOWN_IN ;

    assign gthrxn_in[3]                 =  RX1N_IN_LANE3 ;
    assign gthrxp_in[3]                 =  RX1P_IN_LANE3 ;
    assign TX1N_OUT_LANE3               =  gthtxn_out[3] ;
    assign TX1P_OUT_LANE3               =  gthtxp_out[3] ;
    assign RXDATA_OUT_LANE3       =  gtwiz_userdata_rx_out[63 : 48] ;
    assign gtwiz_userdata_tx_in[63 : 48] =  TXDATA_IN_LANE3 ;
    assign loopback_in[11 : 9]     =  LOOPBACK_IN ;
    assign rx8b10ben_in[3]        =  1'b1 ;
    assign RXREALIGN_OUT_LANE3             =  rxbyterealign_out[3]  ;
    assign RXCHARISK_OUT_LANE3             =  rxctrl0_out[49 : 48] ;
    assign RXDISPERR_OUT_LANE3             =  rxctrl1_out[49 : 48] ;
    assign RXCHARISCOMMA_OUT_LANE3             =  rxctrl2_out[25 : 24] ;
    assign RXNOTINTABLE_OUT_LANE3             =  rxctrl3_out[25 : 24] ;
    assign rxmcommaalignen_in[3]             =  ENMCOMMAALIGN_IN_LANE3 ;
    assign rxpcommaalignen_in[3]             =  ENPCOMMAALIGN_IN_LANE3 ;
    assign rxpolarity_in[3]             =  RXPOLARITY_IN_LANE3 ;
    assign TXBUFERR_OUT_LANE3  =  txbufstatus_out[7] ;
    assign RXBUFERR_OUT_LANE3  =  rxbufstatus_out[11] ;
    assign rxusrclk_in[3]               =  RXUSRCLK_IN ;
    assign rxusrclk2_in[3]             =  RXUSRCLK2_IN ;
    assign txusrclk_in[3]               =  TXUSRCLK_IN ;
    assign txusrclk2_in[3]             =  TXUSRCLK2_IN ;
    assign tx8b10ben_in[3]        =  1'b1 ;
    assign txctrl0_in[63 : 48]          =  16'd0 ;
    assign txctrl1_in[63 : 48]          =  16'd0 ;
    assign txctrl2_in[31 : 24]          =  {6'd0,TXCHARISK_IN_LANE3} ;
    assign TXOUTCLK1_OUT_LANE3             =  txoutclk_out[3] ;
    assign rxcommadeten_in[3]        =  1'b1 ;


    assign gt_rxpmaresetdone       =  rxpmaresetdone_out ;
    assign gt_txpmaresetdone       =  txpmaresetdone_out ;
    assign rxbufreset_in             =  1'b0 ;


      // RXRESETDONE in USER_CLK domain
      always @ (posedge RXUSRCLK2_IN)
      begin
        gt_rxresetdone_r    <=  `DLY gtwiz_reset_rx_done_out;
        gt_rxresetdone_r2   <=  `DLY gt_rxresetdone_r;
        gt_rxresetdone_r3   <=  `DLY gt_rxresetdone_r2;
      end

      assign RX_RESETDONE_OUT  = gt_rxresetdone_r3;

      // TXRESETDONE in USER_CLK domain
      always @ (posedge TXUSRCLK2_IN)
      begin
        gt_txresetdone_r    <=  `DLY gtwiz_reset_tx_done_out;
        gt_txresetdone_r2   <=  `DLY gt_txresetdone_r;
        gt_txresetdone_r3   <=  `DLY gt_txresetdone_r2;
      end

      assign TX_RESETDONE_OUT  = gt_txresetdone_r3;

 // Dynamic GT instance call
   system_i_bak_aurora_8b10b_0_0_gt system_i_bak_aurora_8b10b_0_0_gt_i
  (
   .cplllock_out(cplllock_out),
   .drpaddr_in(drpaddr_in),
   .drpclk_in(drpclk_in),
   .drpdi_in(drpdi_in),
   .drpdo_out(drpdo_out),
   .drpen_in(drpen_in),
   .drprdy_out(drprdy_out),
   .drpwe_in(drpwe_in),
   .gthrxn_in(gthrxn_in),
   .gthrxp_in(gthrxp_in),
   .gthtxn_out(gthtxn_out),
   .gthtxp_out(gthtxp_out),
   .gtrefclk0_in(gtrefclk0_in),
   .gtwiz_reset_all_in(gtwiz_reset_all_in),
   .gtwiz_reset_clk_freerun_in(gtwiz_reset_clk_freerun_in),
   .gtwiz_reset_rx_cdr_stable_out(gtwiz_reset_rx_cdr_stable_out),
   .gtwiz_reset_rx_datapath_in(gtwiz_reset_rx_datapath_in),
   .gtwiz_reset_rx_done_out(gtwiz_reset_rx_done_out),
   .gtwiz_reset_rx_pll_and_datapath_in(gtwiz_reset_rx_pll_and_datapath_in),
   .gtwiz_reset_tx_datapath_in(gtwiz_reset_tx_datapath_in),
   .gtwiz_reset_tx_done_out(gtwiz_reset_tx_done_out),
   .gtwiz_reset_tx_pll_and_datapath_in(gtwiz_reset_tx_pll_and_datapath_in),
   .gtwiz_userclk_rx_active_in(gtwiz_userclk_rx_active_in),
   .gtwiz_userclk_tx_active_in(gtwiz_userclk_tx_active_in),
   .gtwiz_userdata_rx_out(gtwiz_userdata_rx_out),
   .gtwiz_userdata_tx_in(gtwiz_userdata_tx_in),
   .loopback_in(loopback_in),
   .rx8b10ben_in(rx8b10ben_in),
   .rxbufreset_in(rxbufreset_in),
   .rxbufstatus_out(rxbufstatus_out),
   .rxbyteisaligned_out(rxbyteisaligned_out),
   .rxbyterealign_out(rxbyterealign_out),
   .rxchanbondseq_out(rxchanbondseq_out),
   .rxchanisaligned_out(rxchanisaligned_out),
   .rxchanrealign_out(rxchanrealign_out),
   .rxchbonden_in(rxchbonden_in),
   .rxchbondi_in(rxchbondi_in),
   .rxchbondlevel_in(rxchbondlevel_in),
   .rxchbondmaster_in(rxchbondmaster_in),
   .rxchbondo_out(rxchbondo_out),
   .rxchbondslave_in(rxchbondslave_in),
   .rxclkcorcnt_out(rxclkcorcnt_out),
   .rxcommadet_out(rxcommadet_out),
   .rxcommadeten_in(rxcommadeten_in),
   .rxctrl0_out(rxctrl0_out),
   .rxctrl1_out(rxctrl1_out),
   .rxctrl2_out(rxctrl2_out),
   .rxctrl3_out(rxctrl3_out),
   .rxmcommaalignen_in(rxmcommaalignen_in),
   .rxoutclk_out(rxoutclk_out),
   .rxpcommaalignen_in(rxpcommaalignen_in),
   .rxpd_in(rxpd_in),
   .rxpmaresetdone_out(rxpmaresetdone_out),
   .rxpolarity_in(rxpolarity_in),
   .rxresetdone_out(rxresetdone_out),
   .rxusrclk2_in(rxusrclk2_in),
   .rxusrclk_in(rxusrclk_in),
   .tx8b10ben_in(tx8b10ben_in),
   .txbufstatus_out(txbufstatus_out),
   .txctrl0_in(txctrl0_in),
   .txctrl1_in(txctrl1_in),
   .txctrl2_in(txctrl2_in),
   .txdetectrx_in(txdetectrx_in),
   .txelecidle_in(txelecidle_in),
   .txoutclk_out(txoutclk_out),
   .txpd_in(txpd_in),
   .txpmaresetdone_out(txpmaresetdone_out),
   .txresetdone_out(txresetdone_out),
   .txusrclk2_in(txusrclk2_in),
   .txusrclk_in(txusrclk_in)
  );


endmodule
