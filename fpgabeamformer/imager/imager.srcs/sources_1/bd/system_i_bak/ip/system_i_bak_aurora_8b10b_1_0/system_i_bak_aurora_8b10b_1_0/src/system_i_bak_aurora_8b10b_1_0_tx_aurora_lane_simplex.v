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
//  TX_AURORA_LANE_SIMPLEX_V5
//
//
//  Description: The AURORA_LANE_Simplex module provides a simplex 2-byte
//               aurora lane connection using a single V5.  The module
//               handles lane initialization and symbol generation.
//
//               * Supports V5
//

`timescale 1 ns / 1 ps

module system_i_bak_aurora_8b10b_1_0_TX_AURORA_LANE_SIMPLEX_V5
(

    // V5 Interface
    TX_BUF_ERR,
    TX_K_ERR,

    TX_CHAR_IS_K,
    TX_DATA,
    V5_TX_RESET,

    // TX_LL Interface
    GEN_SCP,
    GEN_ECP,
    GEN_PAD,
    TX_PE_DATA,
    TX_PE_DATA_V,
    GEN_CC,

    //Sideband Interface
    TX_ALIGNED,

    // Global Logic Interface
    GEN_A,
    GEN_K,
    GEN_R,
    GEN_V,
    CHANNEL_UP,

    LANE_UP,
    HARD_ERR,

    // System Interface
    USER_CLK,
    RESET_SYMGEN,
    RESET

);

//***********************************Port Declarations*******************************

    // V5 Interface
    input           TX_BUF_ERR;             // Overflow/Underflow of TX buffer detected.
    input   [1:0]   TX_K_ERR;               // Attempt to send bad control byte detected.

    output  [1:0]   TX_CHAR_IS_K;           // TX_DATA byte is a control character.
    output  [15:0]  TX_DATA;                // 2-byte data bus to the V5.
    output          V5_TX_RESET;            // Reset TX side of V5 logic.


    // TX_LL Interface
    input           GEN_SCP;                // SCP generation request from TX_LL.
    input           GEN_ECP;                // ECP generation request from TX_LL.
    input           GEN_PAD;                // PAD generation request from TX_LL.
    input   [0:15]  TX_PE_DATA;             // Data from TX_LL to send over lane.
    input           TX_PE_DATA_V;           // Indicates TX_PE_DATA is Valid.
    input           GEN_CC;                 // CC generation request from TX_LL.


    // Sideband Interface
    input           TX_ALIGNED;             // Input from RX Lane partner to indicate alignment

    // Global Logic Interface
    input           GEN_A;                  // 'A character' generation request from Global Logic.
    input   [0:1]   GEN_K;                  // 'K character' generation request from Global Logic.
    input   [0:1]   GEN_R;                  // 'R character' generation request from Global Logic.
    input   [0:1]   GEN_V;                  // Verification data generation request.
    input           CHANNEL_UP;

    output          LANE_UP;                // Lane is ready for bonding and verification.
    output          HARD_ERR;             // Hard error detected.

    // System Interface
    input           USER_CLK;               // System clock for all non-V5 Aurora Logic.
    input           RESET_SYMGEN;           // Reset the SYM_GEN module.
    input           RESET;                  // Reset the lane.


//*********************************Wire Declarations**********************************

    wire            gen_k_i;
    wire    [0:1]   gen_sp_data_i;
    wire    [0:1]   gen_spa_data_i;
    wire            rx_sp_i;
    wire            rx_spa_i;
    wire            rx_neg_i;
    wire            enable_err_detect_i;
    wire            do_word_align_i;
    wire            hard_err_reset_i;


//*********************************Main Body of Code**********************************


    // ____________________Lane Initialization state machine__________________________

    system_i_bak_aurora_8b10b_1_0_TX_LANE_INIT_SM_SIMPLEX tx_lane_init_sm_simplex_i
    (
        // V5 Interface
        .V5_TX_RESET(V5_TX_RESET),

        // Symbol Generator Interface
        .GEN_K(gen_k_i),
        .GEN_SP_DATA(gen_sp_data_i),

        // Error Detection Logic Interface
        .HARD_ERR_RESET(hard_err_reset_i),

        .ENABLE_ERR_DETECT(enable_err_detect_i),

        // Global Logic Interface
        .LANE_UP(LANE_UP),

        // Sideband Signals
        .TX_ALIGNED(TX_ALIGNED),

        // System Interface
        .USER_CLK(USER_CLK),
        .RESET(RESET)

    );


    //_________________________ Symbol Generation module _______________________________


    // The simplex module does not use SPA symbols, so gen_spa_data is tied low.

    assign gen_spa_data_i = 2'b00;

    system_i_bak_aurora_8b10b_1_0_SYM_GEN sym_gen_i
    (
        // TX_LL Interface
        .GEN_SCP(GEN_SCP),
        .GEN_ECP(GEN_ECP),
        .GEN_PAD(GEN_PAD),
        .TX_PE_DATA(TX_PE_DATA),
        .TX_PE_DATA_V(TX_PE_DATA_V),
        .GEN_CC(GEN_CC),

        // Global Logic Interface
        .GEN_A(GEN_A),
        .GEN_K(GEN_K),
        .GEN_R(GEN_R),
        .GEN_V(GEN_V),

        // Lane Init SM Interface
        .GEN_K_FSM(gen_k_i),
        .GEN_SP_DATA(gen_sp_data_i),
        .GEN_SPA_DATA(gen_spa_data_i),

        // GT Interface
        .TX_CHAR_IS_K({TX_CHAR_IS_K[0],TX_CHAR_IS_K[1]}),
        .TX_DATA({TX_DATA[7:0],TX_DATA[15:8]}),

        // System Interface
        .USER_CLK(USER_CLK),
        .RESET(RESET_SYMGEN)
    );


    //_______________________________ Error Detection module ______________________________

    system_i_bak_aurora_8b10b_1_0_TX_ERR_DETECT_SIMPLEX tx_err_detect_simplex_i
    (
        // Lane Init SM Interface
        .ENABLE_ERR_DETECT(enable_err_detect_i),

        .HARD_ERR_RESET(hard_err_reset_i),

        // Global Logic Interface
        .HARD_ERR(HARD_ERR),

        // V5 Interface
        .TX_K_ERR(TX_K_ERR),
        .TX_BUF_ERR(TX_BUF_ERR),

        // System Interface
        .USER_CLK(USER_CLK)
    );


endmodule
