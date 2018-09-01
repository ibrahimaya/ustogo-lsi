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
//  RX_LL_DEFRAMER
//
//
//  Description: the RX_LL_DEFRAMER extracts framing information from incoming channel
//               data beats. It detects the start and end of frames, invalidates data
//               that is outside of a frame, and generates signals that go to the Output
//               and Storage blocks to indicate when the end of a frame has been detected.
//
//               This module supports 4 2-byte lane designs
//

`timescale 1 ns / 1 ps

module system_i_bak_aurora_8b10b_0_0_RX_LL_DEFRAMER
(
    PDU_DATA_V,
    PDU_SCP,
    PDU_ECP,
    USER_CLK,
    RESET,

    DEFRAMED_DATA_V,
    IN_FRAME,
    AFTER_SCP

);

`define DLY #1


//***********************************Port Declarations*******************************

    input   [0:3]  PDU_DATA_V;
    input   [0:3]  PDU_SCP;
    input   [0:3]  PDU_ECP;
    input           USER_CLK;
    input           RESET;


    //Pdu Left Align Interface
    output  [0:3]  DEFRAMED_DATA_V;
    output  [0:3]  AFTER_SCP;
    output  [0:3]  IN_FRAME;


//*****************************External Register Declarations*************************

    reg     [0:3]  DEFRAMED_DATA_V;
    reg     [0:3]  AFTER_SCP;
    reg     [0:3]  IN_FRAME;


//*****************************Internal Register Declarations*************************

    reg             in_frame_r;


//*********************************Wire Declarations**********************************

    wire    [0:3]  carry_select_c;
    wire    [0:3]  after_scp_select_c;
    wire    [0:3]  in_frame_c;
    wire    [0:3]  after_scp_c;


//*********************************Main Body of Code**********************************



    //____________________________Mask Invalid data__________________________


    // Keep track of inframe status between clock cycles.
    always @(posedge USER_CLK)
        if(RESET)   in_frame_r  <=  `DLY    1'b0;
        else        in_frame_r  <=  `DLY    in_frame_c[3];


    // Combinatorial inframe detect for lane 0.
    assign carry_select_c[0]   =    !PDU_ECP[0] & !PDU_SCP[0];

    MUXCY in_frame_muxcy_0
    (
        .O (in_frame_c[0]),
        .CI (in_frame_r),
        .DI (PDU_SCP[0]),
        .S (carry_select_c[0])
    );


    // Combinatorial inframe detect for 2-byte chunk 1.
    assign carry_select_c[1]   =  !PDU_ECP[1] & !PDU_SCP[1];

    MUXCY in_frame_muxcy_1
    (
        .O(in_frame_c[1]),
        .CI(in_frame_c[0]),
        .DI(PDU_SCP[1]),
        .S(carry_select_c[1])
    );


    // Combinatorial inframe detect for 2-byte chunk 2.
    assign carry_select_c[2]   =  !PDU_ECP[2] & !PDU_SCP[2];

    MUXCY in_frame_muxcy_2
    (
        .O(in_frame_c[2]),
        .CI(in_frame_c[1]),
        .DI(PDU_SCP[2]),
        .S(carry_select_c[2])
    );


    // Combinatorial inframe detect for 2-byte chunk 3.
    assign carry_select_c[3]   =  !PDU_ECP[3] & !PDU_SCP[3];

    MUXCY in_frame_muxcy_3
    (
        .O(in_frame_c[3]),
        .CI(in_frame_c[2]),
        .DI(PDU_SCP[3]),
        .S(carry_select_c[3])
    );




    // The data from a lane is valid if its valid signal is asserted and it is
    // inside a frame.  Note the use of Bitwise AND.

    always @(posedge USER_CLK)
        if(RESET)   DEFRAMED_DATA_V <=  `DLY    4'd0;
        else        DEFRAMED_DATA_V <=  `DLY    in_frame_c & PDU_DATA_V;


    // Register the inframe status.
    always @(posedge USER_CLK)
        if(RESET)   IN_FRAME    <=  `DLY    4'd0;
        else        IN_FRAME    <=  `DLY    {in_frame_r,in_frame_c[0:2]};



    //___________Mark lanes that could contain data that occurs after an SCP__________________
    //

    // Combinatorial data after start detect for lane 0.
    assign after_scp_select_c[0]   =    !PDU_SCP[0];

    MUXCY data_after_start_muxcy_0
    (
        .O (after_scp_c[0]),
        .CI (1'b0),
        .DI (1'b1),
        .S (after_scp_select_c[0])
    );


    // Combinatorial data after start detect for lane1.
    assign after_scp_select_c[1]   =  !PDU_SCP[1];

    MUXCY data_after_start_muxcy_1
    (
        .O(after_scp_c[1]),
        .CI(after_scp_c[0]),
        .DI(1'b1),
        .S(after_scp_select_c[1])
    );


    // Combinatorial data after start detect for lane2.
    assign after_scp_select_c[2]   =  !PDU_SCP[2];

    MUXCY data_after_start_muxcy_2
    (
        .O(after_scp_c[2]),
        .CI(after_scp_c[1]),
        .DI(1'b1),
        .S(after_scp_select_c[2])
    );


    // Combinatorial data after start detect for lane3.
    assign after_scp_select_c[3]   =  !PDU_SCP[3];

    MUXCY data_after_start_muxcy_3
    (
        .O(after_scp_c[3]),
        .CI(after_scp_c[2]),
        .DI(1'b1),
        .S(after_scp_select_c[3])
    );




    // Register the output.
    always @(posedge USER_CLK)
        if(RESET)   AFTER_SCP   <=  4'd0;
        else        AFTER_SCP   <=  after_scp_c;


endmodule
