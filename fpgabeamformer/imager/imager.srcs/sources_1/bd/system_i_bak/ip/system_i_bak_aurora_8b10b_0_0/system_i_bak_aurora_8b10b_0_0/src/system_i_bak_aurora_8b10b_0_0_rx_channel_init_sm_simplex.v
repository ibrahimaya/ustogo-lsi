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
//  RX_CHANNEL_INIT_SM_SIMPLEX
//
//
//  Description: the RX_CHANNEL_INIT_SM_SIMPLEX module is a state machine for managing channel
//               bonding and verification on the receive side in simplex mode.
//
//               The channel init state machine is reset until the lane up signals
//               of all the lanes that constitute the channel are asserted.  It then
//               requests channel bonding until the lanes have been bonded and
//               checks to make sure the bonding was successful.  Channel bonding is
//               skipped if there is only one lane in the channel.  If bonding is
//               unsuccessful, the lanes are reset. the RX side indicates to the TX lane partner
//               that channel bonding is successful
//
//               After the bonding phase is complete, the state machine receives
//               verification sequences through the channel until it is clear that
//               the channel is ready to be used.  If verification is successful,
//               the CHANNEL_UP signal is asserted.  If it is unsuccessful, the
//               lanes are reset.
//
//               After CHANNEL_UP goes high, the state machine is quiescent, and will
//               reset only if one of the lanes goes down, a hard error is detected, or
//               a general reset is requested.
//
//               This module supports 4 2-byte lane designs
//

`timescale 1 ns / 1 ps

module system_i_bak_aurora_8b10b_0_0_RX_CHANNEL_INIT_SM_SIMPLEX #
(
     parameter   WATCHDOG_TIMEOUT =  14
)
(
    // GT Interface
    CH_BOND_DONE,

    EN_CHAN_SYNC,


    // Aurora Lane Interface
    CHANNEL_BOND_LOAD,
    GOT_A,
    GOT_V,

    RESET_LANES,


    // System Interface
    USER_CLK,
    RESET,

    CHANNEL_UP,
    START_RX,

    //Sideband Signals
    RX_BONDED,

    // Channel Error Management Interface
    GTRXRESET_OUT,
    RESET_CHANNEL

);

`define DLY #1

//***********************************Port Declarations*******************************

    // GTP Interface
input   [0:3]      CH_BOND_DONE;

    output             EN_CHAN_SYNC;

    // Aurora Lane Interface
input   [0:3]      CHANNEL_BOND_LOAD;
input   [0:7]      GOT_A;
input   [0:3]      GOT_V;
output  [0:3]      RESET_LANES;

    // System Interface
    input              USER_CLK;
    input              RESET;

    output             CHANNEL_UP;
    output             START_RX;

    //Sideband Signals
    output             RX_BONDED;

    // Channel Init State Machine Interface
    output             GTRXRESET_OUT;
    input              RESET_CHANNEL;



//***************************External Register Declarations***************************

    reg             START_RX;
    reg             RX_BONDED;
//***************************Internal Register Declarations***************************

    reg     [0:WATCHDOG_TIMEOUT-1]   free_count_r;
    reg     [0:15]  verify_watchdog_r;
    reg     [0:15]  bonding_watchdog_r;
    reg             all_ch_bond_done_r;
    reg             all_channel_bond_load_r;
    reg             bond_passed_r;
    reg             good_as_r;
    reg             bad_as_r;
    reg     [0:2]   a_count_r;
    reg     [0:3]  ch_bond_done_r;
    reg     [0:3]  channel_bond_load_r;
    reg             all_lanes_v_r;
    reg             got_first_v_r;
    reg     [0:31]  v_count_r;
    reg             bad_v_r;
    reg     [0:2]   rxver_count_r;

    // State registers
    reg             wait_for_lane_up_r;
    reg             channel_bond_r;
    reg             check_bond_r;
    reg             verify_r;
    reg             ready_r;
    reg             CHANNEL_UP;

    //FF for timing closure
    reg             ready_r2;

   wire               gtreset_c;
   wire               gtrxreset_nxt;

   reg   [7:0]        gtrxreset_extend_r =  8'd0;
   reg                GTRXRESET_OUT = 1'b0;  

//*********************************Wire Declarations**********************************

    wire            insert_ver_c;
    wire            verify_watchdog_done_r;
    wire            rxver_3d_done_r;
    wire            reset_lanes_c;
    wire            free_count_done_w;

    wire            all_ch_bond_done_c;
    wire            all_channel_bond_load_c;
    wire    [0:3]   all_as_c;
    wire    [0:3]   any_as_c;
    wire            four_as_r;
    wire            bonding_watchdog_done_r;
    wire            all_lanes_v_c;


    // Next state signals
    wire            next_channel_bond_c;
    wire            next_check_bond_c;
    wire            next_verify_c;
    wire            next_ready_c;


//*********************************Main Body of Code**********************************


    //________________Main state machine for bonding and verification________________


    // State registers
    always @(posedge USER_CLK)
        if(RESET|RESET_CHANNEL)
        begin
            wait_for_lane_up_r <=  `DLY    1'b1;
            channel_bond_r     <=  `DLY    1'b0;
            check_bond_r       <=  `DLY    1'b0;
            verify_r           <=  `DLY    1'b0;
            ready_r            <=  `DLY    1'b0;
        end
        else
        begin
            wait_for_lane_up_r <=  `DLY    1'b0;
            channel_bond_r     <=  `DLY    next_channel_bond_c;
            check_bond_r       <=  `DLY    next_check_bond_c;
            verify_r           <=  `DLY    next_verify_c;
            ready_r            <=  `DLY    next_ready_c;
        end



    // Next state logic
    assign  next_channel_bond_c =   wait_for_lane_up_r |
                                    (channel_bond_r & !bond_passed_r)|
                                    (check_bond_r & bad_as_r);


    assign  next_check_bond_c   =   (channel_bond_r & bond_passed_r )|
                                    (check_bond_r & !four_as_r & !bad_as_r);


    assign  next_verify_c       =   (check_bond_r & four_as_r & !bad_as_r)|
                                    (verify_r & !rxver_3d_done_r);


    assign  next_ready_c        =   (verify_r & rxver_3d_done_r)|
                                     ready_r;



    // Output Logic
    always @(posedge USER_CLK)
      ready_r2          <=  `DLY  ready_r;

    // Channel up is high as long as the Global Logic is in the ready state.
    always @(posedge USER_CLK)
      CHANNEL_UP          <=  `DLY  ready_r2;


    // Turn the receive engine on as soon as all the lanes are up.
    always @(posedge USER_CLK)
        if(RESET)   START_RX    <=  `DLY    1'b0;
        else        START_RX    <=  `DLY    !wait_for_lane_up_r;

    always @(posedge USER_CLK)
      RX_BONDED           <= `DLY  verify_r;

    
    //__________________________Channel Reset _________________________________


    // Some problems during channel bonding and verification require the lanes to
    // be reset.  When this happens, we assert the Reset Lanes signal, which gets
    // sent to all Aurora Lanes.  When the Aurora Lanes reset, their LANE_UP signals
    // go down.  This causes the Channel Error Detector to assert the Reset Channel
    // signal.
    assign reset_lanes_c =              (verify_r & verify_watchdog_done_r)|
                                        (verify_r & bad_v_r & !rxver_3d_done_r)|
                                        (channel_bond_r & bonding_watchdog_done_r)|
                                        (check_bond_r & bonding_watchdog_done_r)|
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


      assign gtreset_c =              (verify_r & verify_watchdog_done_r)|
                                      (verify_r & bad_v_r & !rxver_3d_done_r)|
                                      (channel_bond_r & bonding_watchdog_done_r)|
                                      (check_bond_r & bonding_watchdog_done_r);
  

    FD #(.INIT(1'b1)) gtreset_flop_0_i
    (
        .D(gtreset_c),
        .C(USER_CLK),
        .Q(gtrxreset_nxt)

    );
   							    
always @ (posedge USER_CLK)
begin
  if(RESET)
    gtrxreset_extend_r  <= `DLY  8'd0; 
  else
    gtrxreset_extend_r  <= {gtrxreset_nxt,gtrxreset_extend_r[7:1]}; 
end

always @ (posedge USER_CLK)
    GTRXRESET_OUT  <= |gtrxreset_extend_r; 

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

    // The channel bonding watchdog is triggered when the channel_bond_load
    // signal has been asserted 16 times in the channel_bonding state without
    // continuing or resetting.  If this happens, we reset the lanes.

    always @(posedge USER_CLK)
        if(!(channel_bond_r || check_bond_r) || all_channel_bond_load_r || free_count_done_w)
            bonding_watchdog_r <= `DLY {(channel_bond_r || check_bond_r),bonding_watchdog_r[0:14]};

    assign  bonding_watchdog_done_r =   bonding_watchdog_r[15];

    //_____________________________Channel Bonding_______________________________



    // We send the EN_CHAN_SYNC signal to the master lane.

    FD #(.INIT(1'b0)) en_chan_sync_flop_i
    (
        .D(channel_bond_r),
        .C(USER_CLK),
        .Q(EN_CHAN_SYNC)
    );




    // This first wide AND gate collects the CH_BOND_DONE signals.  We register the
    // output of the AND gate.  Note that register is a one shot that is reset
    // only when the state changes.

    always @(posedge USER_CLK)
        ch_bond_done_r  <=  `DLY    CH_BOND_DONE;

    assign all_ch_bond_done_c = ch_bond_done_r[0] &
                                ch_bond_done_r[1] &
                                ch_bond_done_r[2] &
                                ch_bond_done_r[3];

    always @(posedge USER_CLK)
        if(!channel_bond_r)             all_ch_bond_done_r  <=  `DLY    1'b0;
        else                            all_ch_bond_done_r  <=  `DLY    all_ch_bond_done_c;


    //This FF stage added for timing closure
    always @ (posedge USER_CLK)
      channel_bond_load_r <= `DLY CHANNEL_BOND_LOAD;

    // This wide AND gate collects the CHANNEL_BOND_LOAD signals from each lane.
    // We register the output of the AND gate.

    assign all_channel_bond_load_c = channel_bond_load_r[0] &
                                     channel_bond_load_r[1] &
                                     channel_bond_load_r[2] &
                                     channel_bond_load_r[3];

    always @(posedge USER_CLK)
        all_channel_bond_load_r      <=  `DLY    all_channel_bond_load_c;



    // Assert bond_passed_r if all_ch_bond_done_r high.
    always @(posedge USER_CLK)
        bond_passed_r   <=  `DLY    all_ch_bond_done_r ;



    // Good_as_r is asserted as long as no bad As are detected.  Bad As are As that do
    // not arrive with the rest of the As in the channel.
    assign all_as_c[0] = GOT_A[0] &
                         GOT_A[2] &
                         GOT_A[4] &
                         GOT_A[6];

    assign all_as_c[1] = GOT_A[1] &
                         GOT_A[3] &
                         GOT_A[5] &
                         GOT_A[7];



    assign any_as_c[0] = GOT_A[0] |
                         GOT_A[2] |
                         GOT_A[4] |
                         GOT_A[6];

    assign any_as_c[1] = GOT_A[1] |
                         GOT_A[3] |
                         GOT_A[5] |
                         GOT_A[7];



    always @(posedge USER_CLK)
        good_as_r   <=  `DLY    all_as_c[0] | all_as_c[1];


    always @(posedge USER_CLK)
        bad_as_r    <=  `DLY    ( any_as_c[0] & !all_as_c[0] ) |
                                ( any_as_c[1] & !all_as_c[1] );


    // Four_as_r is asserted when you get 4 consecutive good As in check_bond state.
    always @(posedge USER_CLK)
        if(!check_bond_r)   a_count_r   <=  `DLY    3'b000;
        else if(good_as_r)  a_count_r   <=  `DLY    a_count_r + 3'b001;


    assign  four_as_r   =   a_count_r[0];



    //________________________________Verification__________________________


    // Vs need to appear on all lanes simultaneously.
    assign all_lanes_v_c = GOT_V[0] &
                           GOT_V[1] &
                           GOT_V[2] &
                           GOT_V[3];


    always @(posedge USER_CLK)
        all_lanes_v_r <=  `DLY  all_lanes_v_c;


    // Vs need to be decoded by the aurora lane and then checked by the
    // Global logic.  They must appear periodically.
    always @(posedge USER_CLK)
        if(!verify_r)                   got_first_v_r   <=  `DLY    1'b0;
        else if(all_lanes_v_r)          got_first_v_r   <=  `DLY    1'b1;


    assign  insert_ver_c    =   all_lanes_v_r & !got_first_v_r | (v_count_r[31] & verify_r);


    // Shift register for measuring the time between V counts.
    always @(posedge USER_CLK)
        v_count_r   <=  `DLY    {insert_ver_c,v_count_r[0:30]};


    // Assert bad_v_r if a V does not arrive when expected.
    always @(posedge USER_CLK)
        bad_v_r     <=  `DLY    (v_count_r[31] ^ all_lanes_v_r) & got_first_v_r;



    // Count the number of Ver sequences received.  You're done after you receive four.
    always @(posedge USER_CLK)
        if((v_count_r[31] & all_lanes_v_r) |!verify_r)
            rxver_count_r   <=  `DLY    {verify_r,rxver_count_r[0:1]};


    assign  rxver_3d_done_r     =   rxver_count_r[2];


endmodule
