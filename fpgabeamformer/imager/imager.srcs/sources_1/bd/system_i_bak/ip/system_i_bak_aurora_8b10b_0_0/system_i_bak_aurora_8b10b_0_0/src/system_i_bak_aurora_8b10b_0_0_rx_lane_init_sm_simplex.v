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
//  RX_LANE_INIT_SM_SIMPLEX
//
//
//  Description: This logic manages the initialization of the RX V5 in simplex 2-byte mode.
//               It consists of a small state machine, a set of counters for
//               tracking the progress of initializtion and detecting problems,
//               and some additional support logic.
//

`timescale 1 ns / 1 ps

module system_i_bak_aurora_8b10b_0_0_RX_LANE_INIT_SM_SIMPLEX
(
    // V5 Interface
    RX_NOT_IN_TABLE,
    RX_DISP_ERR,
    RX_CHAR_IS_COMMA,
    RX_REALIGN,

    V5_RX_RESET,
    RX_POLARITY,

    // Comma Detect Phase Alignment Interface
    ENA_COMMA_ALIGN,

    // Symbol Decoder Interface
    RX_SP,
    RX_NEG,

    DO_WORD_ALIGN,

    // Error Detection Logic Interface
    ENABLE_ERR_DETECT,
    HARD_ERR_RESET,

    // Global Logic Interface
    LANE_UP,
    CHANNEL_UP,

    // System Interface
    USER_CLK,
    RESET
);

`define DLY #1

//***********************************Port Declarations*******************************

    // V5 Interface
    input   [1:0]   RX_NOT_IN_TABLE;     // V5 received invalid 10b code.
    input   [1:0]   RX_DISP_ERR;         // V5 received 10b code w/ wrong disparity.
    input   [1:0]   RX_CHAR_IS_COMMA;    // V5 received a Comma.
    input           RX_REALIGN;          // V5 had to change alignment due to new comma.

    output          V5_RX_RESET;        // Reset the RX side of the V5.
    output          RX_POLARITY;         // Sets polarity used to interpet rx'ed symbols.

    // Comma Detect Phase Alignment Interface
    output          ENA_COMMA_ALIGN;     // Turn on SERDES Alignment in V5.

    // Symbol Decoder Interface
    input           RX_SP;               // Lane rx'ed SP sequence w/ + or - data.
    input           RX_NEG;              // Lane rx'ed inverted SP or SPA data.

    output          DO_WORD_ALIGN;       // Enable word alignment.

    // Error Detection Logic Interface
    input           HARD_ERR_RESET;    // Reset lane due to hard error.

    output          ENABLE_ERR_DETECT; // Turn on Soft Error detection.

    // Global Logic Interface
    output          LANE_UP;             // Lane is initialized.
    input           CHANNEL_UP;          // Channels are bonded and verified

    // System Interface
    input           USER_CLK;            // Clock for all non-V5 Aurora logic.
    input           RESET;               // Reset Aurora Lane.

//**************************External Register Declarations****************************

    reg             ENABLE_ERR_DETECT;
    reg   [1:0]     RX_CHAR_IS_COMMA_R;    // Register Comma.
//**************************Internal Register Declarations****************************

    reg     [0:7]   counter1_r;
    reg     [0:15]  counter2_r;
    reg             rx_polarity_r;
    reg             prev_char_was_comma_r;
    reg             comma_over_two_cycles_r;
    reg             reset_count_r;

    // FSM states, encoded for one-hot implementation
    reg             begin_r;        //Begin initialization
    reg             rst_r;          //Reset V5s
    reg             align_r;        //Align SERDES
    reg             realign_r;      //Verify no spurious realignment
    reg             polarity_r;     //Verify polarity of rx'ed symbols
    reg             ready_r;        //Lane ready for Bonding/Verification

//*********************************Wire Declarations**********************************

    wire            count_8d_done_r;
    wire            count_32d_done_r;
    wire            count_128d_done_r;
    wire            symbol_err_c;
    wire            sp_polarity_c;
    wire            inc_count_c;
    wire            change_in_state_c;
    wire            remote_reset_watchdog_done_r;

    wire            next_begin_c;
    wire            next_rst_c;
    wire            next_align_c;
    wire            next_realign_c;
    wire            next_polarity_c;
    wire            next_ready_c;

//*********************************Main Body of Code**********************************

    //________________Main state machine for managing initialization________________

    // State registers
    always @(posedge USER_CLK)
        if(RESET|HARD_ERR_RESET)
            {begin_r,rst_r,align_r,realign_r,polarity_r,ready_r}  <=  `DLY    6'b100000;
        else
        begin
            begin_r     <=  `DLY    next_begin_c;
            rst_r       <=  `DLY    next_rst_c;
            align_r     <=  `DLY    next_align_c;
            realign_r   <=  `DLY    next_realign_c;
            polarity_r  <=  `DLY    next_polarity_c;
            ready_r     <=  `DLY    next_ready_c;
        end

    // Next state logic
    assign  next_begin_c    =   (realign_r & RX_REALIGN)  |
                                (polarity_r & !sp_polarity_c)|
                                (ready_r & remote_reset_watchdog_done_r);

    assign  next_rst_c      =   begin_r |
                                (rst_r & !count_8d_done_r);

    assign  next_align_c    =   (rst_r & count_8d_done_r)|
                                (align_r & !count_128d_done_r);

    assign  next_realign_c  =   (align_r & count_128d_done_r)|
                                (realign_r & !count_32d_done_r & !RX_REALIGN);

    assign  next_polarity_c =   (realign_r & count_32d_done_r & !RX_REALIGN);

    assign  next_ready_c    =   (polarity_r & sp_polarity_c)|
                                (ready_r & !remote_reset_watchdog_done_r);

    // Output Logic

    // Enable comma align when in the ALIGN state.
    assign  ENA_COMMA_ALIGN =   align_r;

    // Hold RX_RESET when in the RST state.
    assign  V5_RX_RESET    =   rst_r;


    // LANE_UP is asserted when in the READY state.
    FDR lane_up_flop_i
    (
        .D(ready_r),
        .C(USER_CLK),
        .R(RESET),
        .Q(LANE_UP)
    );

    // ENABLE_ERR_DETECT is asserted when in the ACK or READY states.
    // Asserting it earlier will result in too many false errors.  After
    // it is asserted, higher level modules can respond to Hard Errors by
    // resetting the Aurora Lane.  We register the signal before it leaves
    // the lane_init_sm submodule.

    always @(posedge USER_CLK)
        ENABLE_ERR_DETECT <=  `DLY    ready_r;

    // Do word alignment when in the ALIGN state.
    assign  DO_WORD_ALIGN   =   align_r | ready_r;

    //_________Counter 1, for reset cycles, align cycles and realign cycles____________

    // The initial statement is to ensure that the counter comes up at some value other than X.
    // We have tried different initial values and it does not matter what the value is, as long
    // as it is not X since X breaks the state machine
    initial
        counter1_r = 8'h01;

    //Core of the counter
    always @(posedge USER_CLK)
        if(reset_count_r || ready_r)           counter1_r   <=  `DLY    8'd1;
        else if(inc_count_c)        counter1_r   <=  `DLY    counter1_r + 8'd1;

    // Assert count_8d_done_r when bit 4 in the register first goes high.
    assign  count_8d_done_r     =   counter1_r[4];

    // Assert count_32d_done_r when bit 2 in the register first goes high.
    assign  count_32d_done_r    =   counter1_r[2];

    // Assert count_128d_done_r when bit 0 in the register first goes high.
    assign  count_128d_done_r   =   counter1_r[0];

    // The counter resets any time the RESET signal is asserted, there is a change in
    // state, there is a symbol error, or commas are not consecutive in the align state.
    always @(posedge USER_CLK)
        reset_count_r <= `DLY RESET | change_in_state_c |( !rst_r & ( symbol_err_c |!comma_over_two_cycles_r));

    // The counter should be reset when entering and leaving the reset state.
    assign  change_in_state_c   =   rst_r != next_rst_c;

    // Symbol error is asserted whenever there is a disparity error or an invalid
    // 10b code.
    assign  symbol_err_c  =   (RX_DISP_ERR != 2'b00) | (RX_NOT_IN_TABLE != 2'b00);

    // Pipeline stage to meet timing
    always @(posedge USER_CLK)
        RX_CHAR_IS_COMMA_R <=  `DLY    RX_CHAR_IS_COMMA;

    // Previous cycle comma is used to check for consecutive commas.
    always @(posedge USER_CLK)
        prev_char_was_comma_r <=  `DLY    (RX_CHAR_IS_COMMA_R[1] | RX_CHAR_IS_COMMA_R[0]);


    // Check to see that commas are consecutive in the align state.
    always @(posedge USER_CLK)
        comma_over_two_cycles_r <= `DLY   (prev_char_was_comma_r ^
                                          (RX_CHAR_IS_COMMA_R[1] | RX_CHAR_IS_COMMA_R[0])) |
					  !align_r;


    // Increment count is always asserted, except in the ALIGN state when it is asserted
    // only upon the arrival of a comma character.

    assign  inc_count_c =   !align_r | (align_r & (RX_CHAR_IS_COMMA_R[1] | RX_CHAR_IS_COMMA_R[0]));


    //_____________________Counter 2, remote reset watchdog timer __________________

    // Another counter implemented as a shift register.  This counter puts
    // an upper limit on the number of SPs that can be received in the
    // Ready state once the CHANNEL_UP signal is high.  If the number of
    // SPs exceeds the limit, the Aurora Lane resets itself.  The Global
    // logic module will reset all the lanes if this occurs while they are
    // all in the channel ready state (i.e. CHANNEL_UP is asserted for all).

    // Counter logic
    always @(posedge USER_CLK)
        if((RX_SP & CHANNEL_UP)|!ready_r)  counter2_r  <=  `DLY    {ready_r,counter2_r[0:14]};

    // The counter is done when bit 15 of the shift register goes high.
    assign remote_reset_watchdog_done_r = counter2_r[15];


    //___________________________Polarity Control_____________________________

    // sp_polarity_c, is low if neg symbols received, otherwise high.
    assign  sp_polarity_c   =   !RX_NEG;


    // The Polarity flop drives the polarity setting of the V5.  We initialize it for the
    // sake of simulation. In hardware, it is initialized after configuration.
    initial
        rx_polarity_r <=  1'b0;

    always @(posedge USER_CLK)
        if(polarity_r & !sp_polarity_c)  rx_polarity_r <=  `DLY    ~rx_polarity_r;


    // Drive the rx_polarity register value on the interface.
    assign  RX_POLARITY =   rx_polarity_r;

endmodule
