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
//  LEFT_ALIGN_CONTROL
//
//
//  Description: The LEFT_ALIGN_CONTROL is used to control the Left Align Muxes in
//               the RX_LL module.  Each module supports up to 8 lanes.  Modules can
//               be combined in stages to support channels with more than 8 lanes.
//
//               This module supports 4 2-byte lane designs
//

`timescale 1 ns / 1 ps

module system_i_bak_aurora_8b10b_0_0_LEFT_ALIGN_CONTROL
(
    PREVIOUS_STAGE_VALID,

    MUX_SELECT,
    VALID,

    USER_CLK,
    RESET

);

`define DLY #1


//***********************************Port Declarations*******************************

    input   [0:3]   PREVIOUS_STAGE_VALID;

    output   [0:11]   MUX_SELECT;
    output   [0:3]   VALID;

    input           USER_CLK;
    input           RESET;


//****************************External Register Declarations*************************

    reg     [0:11]   MUX_SELECT;
    reg     [0:3]  VALID;


//****************************Internal Register Declarations*************************

    reg     [0:11]   mux_select_c;
    reg     [0:3]  valid_c;


//*********************************Main Body of Code*********************************




    //_______________________________SELECT___________________________________


    // Lane 0
    always @(PREVIOUS_STAGE_VALID[0:3])
        case(PREVIOUS_STAGE_VALID[0:3])
4'd1  :   mux_select_c[0:2]  = 3'd3;
4'd2  :   mux_select_c[0:2]  = 3'd2;
4'd3  :   mux_select_c[0:2]  = 3'd2;
4'd4  :   mux_select_c[0:2]  = 3'd1;
4'd5  :   mux_select_c[0:2]  = 3'd1;
4'd6  :   mux_select_c[0:2]  = 3'd1;
4'd7  :   mux_select_c[0:2]  = 3'd1;
4'd8  :   mux_select_c[0:2]  = 3'd0;
4'd9  :   mux_select_c[0:2]  = 3'd0;
4'd10  :   mux_select_c[0:2]  = 3'd0;
4'd11  :   mux_select_c[0:2]  = 3'd0;
4'd12  :   mux_select_c[0:2]  = 3'd0;
4'd13  :   mux_select_c[0:2]  = 3'd0;
4'd14  :   mux_select_c[0:2]  = 3'd0;
4'd15  :   mux_select_c[0:2]  = 3'd0;
            default  :   mux_select_c[0:2]  = 3'b0;
        endcase

    // Lane 1
    always @(PREVIOUS_STAGE_VALID[0:3])
        case(PREVIOUS_STAGE_VALID[0:3])
4'd3  :   mux_select_c[3:5]  = 3'd2;
4'd5  :   mux_select_c[3:5]  = 3'd2;
4'd6  :   mux_select_c[3:5]  = 3'd1;
4'd7  :   mux_select_c[3:5]  = 3'd1;
4'd9  :   mux_select_c[3:5]  = 3'd2;
4'd10  :   mux_select_c[3:5]  = 3'd1;
4'd11  :   mux_select_c[3:5]  = 3'd1;
4'd12  :   mux_select_c[3:5]  = 3'd0;
4'd13  :   mux_select_c[3:5]  = 3'd0;
4'd14  :   mux_select_c[3:5]  = 3'd0;
4'd15  :   mux_select_c[3:5]  = 3'd0;
            default  :   mux_select_c[3:5]  = 3'b0;
        endcase

    // Lane 2
    always @(PREVIOUS_STAGE_VALID[0:3])
        case(PREVIOUS_STAGE_VALID[0:3])
4'd7  :   mux_select_c[6:8]  = 3'd1;
4'd11  :   mux_select_c[6:8]  = 3'd1;
4'd13  :   mux_select_c[6:8]  = 3'd1;
4'd14  :   mux_select_c[6:8]  = 3'd0;
4'd15  :   mux_select_c[6:8]  = 3'd0;
            default  :   mux_select_c[6:8]  = 3'b0;
        endcase

    // Lane 3
    always @(PREVIOUS_STAGE_VALID[0:3])
        case(PREVIOUS_STAGE_VALID[0:3])
4'd15  :   mux_select_c[9:11]  = 3'd0;
            default  :   mux_select_c[9:11]  = 3'b0;
        endcase







    // Register the select signals.
    always @(posedge USER_CLK)
        MUX_SELECT  <=  `DLY    mux_select_c;


    //_______________________________VALID___________________________________


    // Lane 0
    always @(PREVIOUS_STAGE_VALID[0:3])
        case(PREVIOUS_STAGE_VALID[0:3])
            4'd 1  :   valid_c[0] = 1'b1;
            4'd 2  :   valid_c[0] = 1'b1;
            4'd 3  :   valid_c[0] = 1'b1;
            4'd 4  :   valid_c[0] = 1'b1;
            4'd 5  :   valid_c[0] = 1'b1;
            4'd 6  :   valid_c[0] = 1'b1;
            4'd 7  :   valid_c[0] = 1'b1;
            4'd 8  :   valid_c[0] = 1'b1;
            4'd 9  :   valid_c[0] = 1'b1;
            4'd 10  :   valid_c[0] = 1'b1;
            4'd 11  :   valid_c[0] = 1'b1;
            4'd 12  :   valid_c[0] = 1'b1;
            4'd 13  :   valid_c[0] = 1'b1;
            4'd 14  :   valid_c[0] = 1'b1;
            4'd 15  :   valid_c[0] = 1'b1;
            default  :   valid_c[0] = 1'b0;
        endcase
    // Lane 1
    always @(PREVIOUS_STAGE_VALID[0:3])
        case(PREVIOUS_STAGE_VALID[0:3])
            4'd 3  :   valid_c[1] = 1'b1;
            4'd 5  :   valid_c[1] = 1'b1;
            4'd 6  :   valid_c[1] = 1'b1;
            4'd 7  :   valid_c[1] = 1'b1;
            4'd 9  :   valid_c[1] = 1'b1;
            4'd 10  :   valid_c[1] = 1'b1;
            4'd 11  :   valid_c[1] = 1'b1;
            4'd 12  :   valid_c[1] = 1'b1;
            4'd 13  :   valid_c[1] = 1'b1;
            4'd 14  :   valid_c[1] = 1'b1;
            4'd 15  :   valid_c[1] = 1'b1;
            default  :   valid_c[1] = 1'b0;
        endcase
    // Lane 2
    always @(PREVIOUS_STAGE_VALID[0:3])
        case(PREVIOUS_STAGE_VALID[0:3])
            4'd 7  :   valid_c[2] = 1'b1;
            4'd 11  :   valid_c[2] = 1'b1;
            4'd 13  :   valid_c[2] = 1'b1;
            4'd 14  :   valid_c[2] = 1'b1;
            4'd 15  :   valid_c[2] = 1'b1;
            default  :   valid_c[2] = 1'b0;
        endcase
    // Lane 3
    always @(PREVIOUS_STAGE_VALID[0:3])
        case(PREVIOUS_STAGE_VALID[0:3])
            4'd 15  :   valid_c[3] = 1'b1;
            default  :   valid_c[3] = 1'b0;
        endcase








    // Register the valid signals for the next stage.
    always @(posedge USER_CLK)
        if(RESET)   VALID   <=  `DLY    4'd0;
        else        VALID   <=  `DLY    valid_c;

endmodule
