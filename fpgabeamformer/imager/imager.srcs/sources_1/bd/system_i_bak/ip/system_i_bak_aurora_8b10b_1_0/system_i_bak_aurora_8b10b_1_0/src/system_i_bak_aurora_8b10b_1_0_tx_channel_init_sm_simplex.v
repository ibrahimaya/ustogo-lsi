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
//  TX_CHANNEL_INIT_SM_SIMPLEX
//
//
//  Description: the TX_CHANNEL_INIT_SM_SIMPLEX module is a state machine for managing channel
//               bonding and verification in simplex mode.
//
//               The channel init state machine is reset until the lane up signals
//               of all the lanes that constitute the channel are asserted.  It then
//               requests channel bonding until the lanes have been bonded and
//               checks to make sure the bonding was successful.  Channel bonding is
//               skipped if there is only one lane in the channel.  If bonding is
//               unsuccessful, the lanes are reset.The RX side indicates that bonding is complete
//               using the sideband signal TX_BONDED.
//
//               After the bonding phase is complete, the state machine sends
//               verification sequences through the channel until it is clear that
//               the channel is ready to be used.  If verification is successful,
//               the CHANNEL_UP signal is asserted.  If it is unsuccessful, the
//               lanes are reset. Verification is complete when the RX lane partner asserts the
//               sideband TX_VERIFIED signal.
//
//               After CHANNEL_UP goes high, the state machine is quiescent, and will
//               reset only if one of the lanes goes down, a hard error is detected, or
//               a general reset is requested.
//
//               This module supports 4 2-byte lane designs
//

`timescale 1 ns / 1 ps

module system_i_bak_aurora_8b10b_1_0_TX_CHANNEL_INIT_SM_SIMPLEX #
(
     parameter   WATCHDOG_TIMEOUT =  15
)
(

    // Aurora Lane Interface
   RESET_LANES,
  
    // Sideband Signal
    TX_BONDED,
    TX_VERIFY,
   
    // System Interface
    USER_CLK,
    RESET,

    CHANNEL_UP,

    // Idle and Verification Sequence Generator Interface

    GEN_VER,


    // Channel Error Management Interface
    RESET_CHANNEL

);

`define DLY #1

//***********************************Port Declarations*******************************







    // Aurora Lane Interface
output  [0:3]      RESET_LANES;

    // Sideband Signal
    input              TX_BONDED;
    input              TX_VERIFY;

    // System Interface
    input              USER_CLK;
    input              RESET;

    output             CHANNEL_UP;
    // Idle and Verification Sequence Generator Interface
    output             GEN_VER;


    // Channel Init State Machine Interface
    input              RESET_CHANNEL;




//***************************Internal Register Declarations***************************

    reg     [0:WATCHDOG_TIMEOUT-1]   free_count_r;
    reg     [0:15]  verify_watchdog_r;
   wire            bonding_watchdog_done_r;

    reg             tx_verify_r;
    reg             tx_bonded_r;
   
    // State registers
    reg     [0:15]  bonding_watchdog_r;
    reg             channel_bond_r;
    reg             wait_for_lane_up_r;
    reg             verify_r;
    reg             ready_r;

    //FF for timing closure
    reg             ready_r2;

//*********************************Wire Declarations**********************************

    wire            verify_watchdog_done_r;
    wire            reset_lanes_c;
    wire            free_count_done_w;


    // Next state signals
    wire            next_verify_c;
    wire            next_ready_c;
    wire            next_channel_bond_c;


//*********************************Main Body of Code**********************************


    //________________Main state machine for bonding and verification________________


    // State registers
    always @(posedge USER_CLK)
        if(RESET|RESET_CHANNEL)
        begin
            wait_for_lane_up_r <=  `DLY    1'b1;
            channel_bond_r     <=  `DLY    1'b0;
            verify_r           <=  `DLY    1'b0;
            ready_r            <=  `DLY    1'b0;
        end
        else
        begin
            wait_for_lane_up_r <=  `DLY    1'b0;
            channel_bond_r     <=  `DLY    next_channel_bond_c;
            verify_r           <=  `DLY    next_verify_c;
            ready_r            <=  `DLY    next_ready_c;
        end



    // Next state logic
    assign  next_channel_bond_c =   wait_for_lane_up_r |
                                    (channel_bond_r & !tx_bonded_r);

    assign  next_verify_c       =   (channel_bond_r & tx_bonded_r)|
                                    (verify_r & !tx_verify_r);


    assign  next_ready_c        =   (verify_r & tx_verify_r)|
                                    ready_r;



    // Output Logic
    always @(posedge USER_CLK)
      ready_r2          <=  `DLY  ready_r;

    // Channel up is high as long as the Global Logic is in the ready state.
    FD tx_channel_up_i
    (
        .D(ready_r2),
        .C(USER_CLK),
        .Q(CHANNEL_UP)
    );


    // Generate the Verification sequence when in the verify state.
    assign  GEN_VER             =   verify_r;

    // Registering Sideband signal

// Initialising sideband signal for simulation. We know that the system will
// work if this signal is initialised to 0 so we initialise to 1 to test for worst case
    initial
        tx_bonded_r = 1'b1;
       
    always @(posedge USER_CLK)
        tx_bonded_r <= TX_BONDED;
    initial
        tx_verify_r = 1'b1;

    always @(posedge USER_CLK)
        tx_verify_r <= TX_VERIFY;



    //__________________________Channel Reset _________________________________


    // Some problems during channel bonding and verification require the lanes to
    // be reset.  When this happens, we assert the Reset Lanes signal, which gets
    // sent to all Aurora Lanes on the RX side as well as to the TX lane partner on
    // the sideband reset signal.When the Aurora Lanes reset, their LANE_UP signals
    // go down.  This causes the Channel Error Detector to assert the Reset Channel
    // signal.
    assign reset_lanes_c =              (verify_r & verify_watchdog_done_r)|
                                        (channel_bond_r & bonding_watchdog_done_r)|
                                        (RESET_CHANNEL & !wait_for_lane_up_r)|
                                         RESET;



    FD #(.INIT(1'b1)) reset_lanes_flop_0_i
    (
        .D(reset_lanes_c),
        .C(USER_CLK),
        .Q(RESET_LANES[0])

    );


    FD #(.INIT(1'b1)) reset_lanes_flop_1_i
    (
        .D(reset_lanes_c),
        .C(USER_CLK),
        .Q(RESET_LANES[1])

    );


    FD #(.INIT(1'b1)) reset_lanes_flop_2_i
    (
        .D(reset_lanes_c),
        .C(USER_CLK),
        .Q(RESET_LANES[2])

    );


    FD #(.INIT(1'b1)) reset_lanes_flop_3_i
    (
        .D(reset_lanes_c),
        .C(USER_CLK),
        .Q(RESET_LANES[3])

    );





    //___________________________Watchdog timers____________________________________

    always @ (posedge USER_CLK)
        if(RESET | RESET_CHANNEL)
            free_count_r <= `DLY {WATCHDOG_TIMEOUT{1'b1}};
        else
            free_count_r <= `DLY free_count_r - 1'b1;

    assign free_count_done_w = (free_count_r == 0);

    // We use the freerunning count as a CE for the verify watchdog.  The
    // count runs continuously so the watchdog will vary between a count of 4096
    // and 3840 cycles - acceptable for this application.
    always @(posedge USER_CLK)
        if(free_count_done_w | !verify_r)
            verify_watchdog_r   <=  `DLY    {verify_r,verify_watchdog_r[0:14]};

    assign  verify_watchdog_done_r  =   verify_watchdog_r[15];

    // The channel bonding watchdog is a freerunning counter.

    always @(posedge USER_CLK)
        if(!channel_bond_r | free_count_done_w)
            bonding_watchdog_r <= `DLY {channel_bond_r,bonding_watchdog_r[0:14]};

    assign  bonding_watchdog_done_r =   bonding_watchdog_r[15];
   
endmodule
