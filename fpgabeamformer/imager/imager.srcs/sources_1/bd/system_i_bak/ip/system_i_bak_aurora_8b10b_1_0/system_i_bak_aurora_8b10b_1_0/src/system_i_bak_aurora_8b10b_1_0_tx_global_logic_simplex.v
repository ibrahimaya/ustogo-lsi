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
//  TX_GLOBAL_LOGIC_SIMPLEX
//
//
//  Description: The TX_GLOBAL_LOGIC_SIMPLEX module handles channel bonding, channel
//               verification, channel error manangement and idle generation in simplex mode.
//
//               This module supports 4 2-byte lane designs
//

`timescale 1 ns / 1 ps

module system_i_bak_aurora_8b10b_1_0_TX_GLOBAL_LOGIC_SIMPLEX
(
    // Aurora Lane Interface
    LANE_UP,
    HARD_ERR,

    GEN_A,
    GEN_K,
    GEN_R,
    GEN_V,
    RESET_LANES,

    // Sideband Signal
    TX_BONDED,
    TX_VERIFY,
   
    // System Interface
    USER_CLK,
    RESET,
    POWER_DOWN,

    CHANNEL_UP,
    CHANNEL_HARD_ERR

);

`define DLY #1


//***********************************Port Declarations*******************************



    // Aurora Lane Interface
input   [0:3]      LANE_UP;
input   [0:3]      HARD_ERR;

output  [0:3]      GEN_A;
output  [0:7]      GEN_K;
output  [0:7]      GEN_R;
output  [0:7]      GEN_V;
output  [0:3]      RESET_LANES;

    // Sideband Signals
    input         TX_BONDED;
    input         TX_VERIFY;

    // System Interface
input              USER_CLK;
input              RESET;
input              POWER_DOWN;

output             CHANNEL_UP;
output             CHANNEL_HARD_ERR;



//*********************************Wire Declarations**********************************

wire               gen_ver_i;
wire               did_ver_i;
wire               reset_channel_i;

//*********************************Main Body of Code**********************************

   
    // State Machine for channel bonding and verification.
    system_i_bak_aurora_8b10b_1_0_TX_CHANNEL_INIT_SM_SIMPLEX tx_channel_init_sm_simplex_i
    (
        // Aurora Lane Interface

        .RESET_LANES(RESET_LANES),

    // Sideband Signal

        .TX_BONDED(TX_BONDED),
        .TX_VERIFY(TX_VERIFY),

        // System Interface
        .USER_CLK(USER_CLK),
        .RESET(RESET),

        .CHANNEL_UP(CHANNEL_UP),


        // Idle and Verification Sequence Generator Interface

        .GEN_VER(gen_ver_i),


        // Channel Error Management Module Interface
        .RESET_CHANNEL(reset_channel_i)

    );



    // Idle and verification sequence generator module.
    system_i_bak_aurora_8b10b_1_0_IDLE_AND_VER_GEN idle_and_ver_gen_i
    (
        // Channel Init SM Interface
        .GEN_VER(gen_ver_i),
        .DID_VER(did_ver_i),

        // Aurora Lane Interface
        .GEN_A(GEN_A),
        .GEN_K(GEN_K),
        .GEN_R(GEN_R),
        .GEN_V(GEN_V),


        // System Interface
        .RESET(RESET),
        .USER_CLK(USER_CLK)
    );



    // Channel Error Management module.
    system_i_bak_aurora_8b10b_1_0_TX_CHANNEL_ERR_DETECT_SIMPLEX tx_channel_err_detect_simplex_i
    (
        // Aurora Lane Interface
        .HARD_ERR(HARD_ERR),
        .LANE_UP(LANE_UP),


        // System Interface
        .USER_CLK(USER_CLK),
        .POWER_DOWN(POWER_DOWN),

        .CHANNEL_HARD_ERR(CHANNEL_HARD_ERR),


        // Channel Init State Machine Interface
        .RESET_CHANNEL(reset_channel_i)
    );

endmodule
