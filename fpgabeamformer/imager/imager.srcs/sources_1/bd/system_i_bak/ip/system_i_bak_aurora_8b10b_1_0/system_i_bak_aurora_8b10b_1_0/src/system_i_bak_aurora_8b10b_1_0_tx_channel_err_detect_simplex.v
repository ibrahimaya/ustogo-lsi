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
//  TX_CHANNEL_ERR_DETECT_SIMPLEX
//
//
//  Description: the CHANNEL_ERR_DETECT module monitors the error signals
//               from the Aurora Lanes in the channel. If a hard error is detected,
//               it sends a message to the channel initialization state machine to reset the channel.
//
//               This module supports 4 2-byte lane designs
//

`timescale 1 ns / 1 ps

module system_i_bak_aurora_8b10b_1_0_TX_CHANNEL_ERR_DETECT_SIMPLEX
(
    // Aurora Lane Interface
    HARD_ERR,
    LANE_UP,


    // System Interface
    USER_CLK,
    POWER_DOWN,

    CHANNEL_HARD_ERR,


    // Channel Init SM Interface
    RESET_CHANNEL
);

`define DLY #1


//***********************************Port Declarations*******************************

    //Aurora Lane Interface
input   [0:3]      HARD_ERR;
input   [0:3]      LANE_UP;


    //System Interface
    input              USER_CLK;
    input              POWER_DOWN;

    output             CHANNEL_HARD_ERR;


    //Channel Init SM Interface
    output             RESET_CHANNEL;


//*****************************External Register Declarations*************************

    reg                CHANNEL_HARD_ERR;
    reg                RESET_CHANNEL;


//***************************Internal Register Declarations***************************

reg     [0:3]      hard_err_r;
reg     [0:3]      lane_up_r;


//*********************************Wire Declarations**********************************

    wire               channel_hard_err_c;
    wire               reset_channel_c;


//*********************************Main Body of Code**********************************


    // Register all of the incoming error signals.  This is necessary for timing.
    always @(posedge USER_CLK)
    begin
        hard_err_r    <=  `DLY    HARD_ERR;
    end

    // Assert Channel hard error if any of the hard error signals are asserted.
    initial
        CHANNEL_HARD_ERR = 1'b1;

    assign channel_hard_err_c = hard_err_r[0] |
                                  hard_err_r[1] |
                                  hard_err_r[2] |
                                  hard_err_r[3];

    always @(posedge USER_CLK)
        CHANNEL_HARD_ERR  <=  `DLY    channel_hard_err_c;


    //FF stage added for timing closure
    always @ (posedge USER_CLK)
      lane_up_r <= `DLY LANE_UP;

    // "reset_channel_c" is asserted when any of the LANE_UP signals are low.
    initial
        RESET_CHANNEL   =  1'b1;

    assign reset_channel_c = !lane_up_r[0] |
                             !lane_up_r[1] |
                             !lane_up_r[2] |
                             !lane_up_r[3];

    always @(posedge USER_CLK)
        RESET_CHANNEL    <=  `DLY    reset_channel_c | POWER_DOWN;

endmodule
