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
//  RX_AURORA_LANE_SIMPLEX_V5
//
//
//  Description: The AURORA_LANE module provides a simplex 2-byte aurora
//               lane connection using a single V5.  The module handles
//               lane initialization, symbol decoding as well as error
//               detection.  It also decodes some of the channel bonding
//               indicator signals needed by the Global logic.
//
//               The parameter USE_NFC is expected to be FALSE for simplex
//               since Native Flow Control is not supported in Simplex mode.
//
//               * Supports V5

`timescale 1 ns / 1 ps

module system_i_bak_aurora_8b10b_0_0_RX_AURORA_LANE_SIMPLEX_V5 #
(
   parameter   EXAMPLE_SIMULATION =   0      
)
(
    // GT Interface
    RX_DATA,
    RX_NOT_IN_TABLE,
    RX_DISP_ERR,
    RX_CHAR_IS_K,
    RX_CHAR_IS_COMMA,
    RX_STATUS,
    RX_BUF_ERR,
    RX_REALIGN,
    RX_POLARITY,
    V5_RX_RESET,
    LINK_RESET_OUT,
    HPCNT_RESET,

    // Comma Detect Phase Align Interface
    ENA_COMMA_ALIGN,

    // RX_LL Interface
    RX_PAD,
    RX_PE_DATA,
    RX_PE_DATA_V,
    RX_SCP,
    RX_ECP,

    // Global Logic Interface
    CHANNEL_UP,
    LANE_UP,
    SOFT_ERR,
    HARD_ERR,
    CHANNEL_BOND_LOAD,
    GOT_A,
    GOT_V,

    //System Interface
    INIT_CLK,
    USER_CLK,
    RESET

);

//***********************************Port Declarations*******************************

    // GT Interface
    input   [15:0]  RX_DATA;                // 2-byte data bus from the V5.
    input   [1:0]   RX_NOT_IN_TABLE;        // Invalid 10-bit code was recieved.
    input   [1:0]   RX_DISP_ERR;            // Disparity error detected on RX interface.
    input   [1:0]   RX_CHAR_IS_K;           // Indicates which bytes of RX_DATA are control.
    input   [1:0]   RX_CHAR_IS_COMMA;       // Comma received on given byte.
    input   [5:0]   RX_STATUS;              // GT status and error bus
    input           RX_BUF_ERR;             // Part of GT status and error bus
    input           RX_REALIGN;             // SERDES was realigned because of a new comma.
    output          RX_POLARITY;            // Controls interpreted polarity of serial data inputs.
    output          V5_RX_RESET;            // Reset RX side of GT logic.
    output          LINK_RESET_OUT;         // Link reset for hotplug scenerio.
    input           HPCNT_RESET;            // Hotplug count reset input. 
    input           INIT_CLK;

    // Comma Detect Phase Align Interface
    output          ENA_COMMA_ALIGN;        // Request comma alignment.

    // RX_LL Interface
    output          RX_PAD;                 // Indicates lane received PAD.
    output  [0:15]  RX_PE_DATA;             // RX data from lane to RX_LL.
    output          RX_PE_DATA_V;           // RX_PE_DATA is data, not control symbol.
    output          RX_SCP;                 // Indicates lane received SCP.
    output          RX_ECP;                 // Indicates lane received ECP.

    // Global Logic Interface
    input           CHANNEL_UP;             // Channel is bonded and verified
    output          LANE_UP;                // Lane is ready for bonding and verification.
    output          SOFT_ERR;             // Soft error detected.
    output          HARD_ERR;             // Hard error detected.
    output          CHANNEL_BOND_LOAD;      // Channel Bonding done code recieved.
    output  [0:1]   GOT_A;                  // Indicates lane recieved 'A character' bytes.
    output          GOT_V;                  // Verification symbols received.

    // System Interface
    input           USER_CLK;               // System clock for all non-V5 Aurora Logic.
    input           RESET;                  // Reset the lane.

//*********************************Wire Declarations**********************************

    wire            rx_cc_i;
    wire            rx_sp_i;
    wire            rx_spa_i;
    wire            rx_neg_i;
    wire            enable_err_detect_i;
    wire            do_word_align_i;
    wire            hard_err_reset_i;


//*********************************Main Body of Code**********************************

    // Lane Initialization state machine
    system_i_bak_aurora_8b10b_0_0_RX_LANE_INIT_SM_SIMPLEX rx_lane_init_sm_simplex_i
    (
        // GT Interface
        .RX_NOT_IN_TABLE(RX_NOT_IN_TABLE),
        .RX_DISP_ERR(RX_DISP_ERR),
        .RX_CHAR_IS_COMMA(RX_CHAR_IS_COMMA),
        .RX_REALIGN(RX_REALIGN),
        .V5_RX_RESET(V5_RX_RESET),
        .RX_POLARITY(RX_POLARITY),

        // Comma Detect Phase Alignment Interface
        .ENA_COMMA_ALIGN(ENA_COMMA_ALIGN),

        // Symbol Decoder Interface
        .RX_SP(rx_sp_i),
        .RX_NEG(rx_neg_i),

        .DO_WORD_ALIGN(do_word_align_i),

        // Error Detection Logic Interface
        .HARD_ERR_RESET(hard_err_reset_i),

        .ENABLE_ERR_DETECT(enable_err_detect_i),

        // Global Logic Interface
        .LANE_UP(LANE_UP),
        .CHANNEL_UP(CHANNEL_UP),

        // System Interface
        .USER_CLK(USER_CLK),
        .RESET(RESET)
    );


    // Channel Bonding Count Decode module
    system_i_bak_aurora_8b10b_0_0_CHBOND_COUNT_DEC chbond_count_dec_i
    (
        .RX_STATUS(RX_STATUS),
        .CHANNEL_BOND_LOAD(CHANNEL_BOND_LOAD),
        .USER_CLK(USER_CLK)
    );


    // Symbol Decode module
    system_i_bak_aurora_8b10b_0_0_SYM_DEC sym_dec_i
    (
        // RX_LL Interface
        .RX_PAD(RX_PAD),
        .RX_PE_DATA(RX_PE_DATA),
        .RX_PE_DATA_V(RX_PE_DATA_V),
        .RX_SCP(RX_SCP),
        .RX_ECP(RX_ECP),

        // Lane Init SM Interface
        .DO_WORD_ALIGN(do_word_align_i),
        .RX_SP(rx_sp_i),
        .RX_SPA(rx_spa_i),
        .RX_NEG(rx_neg_i),

        // Global Logic Interface
        .GOT_A(GOT_A),
        .GOT_V(GOT_V),

        .RX_CC(rx_cc_i),

        // GT Interface
        .RX_DATA({RX_DATA[7:0],RX_DATA[15:8]}),
        .RX_CHAR_IS_K({RX_CHAR_IS_K[0],RX_CHAR_IS_K[1]}),
        .RX_CHAR_IS_COMMA({RX_CHAR_IS_COMMA[0],RX_CHAR_IS_COMMA[1]}),

        // System Interface
        .USER_CLK(USER_CLK),
        .RESET(RESET)
    );


    // Error Detection module
    system_i_bak_aurora_8b10b_0_0_RX_ERR_DETECT_SIMPLEX_V5 rx_err_detect_simplex_gtp_i
    (
        // Lane Init SM Interface
        .ENABLE_ERR_DETECT(enable_err_detect_i),

        .HARD_ERR_RESET(hard_err_reset_i),

        // Global Logic Interface
        .SOFT_ERR(SOFT_ERR),
        .HARD_ERR(HARD_ERR),

        // GT Interface
        .RX_DISP_ERR({RX_DISP_ERR[0],RX_DISP_ERR[1]}),
        .RX_NOT_IN_TABLE({RX_NOT_IN_TABLE[0],RX_NOT_IN_TABLE[1]}),
        .RX_BUF_ERR(RX_BUF_ERR),
        .RX_REALIGN(RX_REALIGN),

        // System Interface
        .USER_CLK(USER_CLK)
    );

    // Hot Plug module
    system_i_bak_aurora_8b10b_0_0_hotplug #
    ( 
        .EXAMPLE_SIMULATION (EXAMPLE_SIMULATION)
    )
    system_i_bak_aurora_8b10b_0_0_hotplug_i
    (
        // Sym Dec Interface
        .RX_CC(rx_cc_i),
        .RX_SP(rx_sp_i),
        .RX_SPA(rx_spa_i),

        // GT Wrapper Interface
        .LINK_RESET_OUT(LINK_RESET_OUT),
        .HPCNT_RESET(HPCNT_RESET),

        // System Interface
        .INIT_CLK(INIT_CLK),
        .USER_CLK(USER_CLK),
        .RESET(RESET)
    );


endmodule
