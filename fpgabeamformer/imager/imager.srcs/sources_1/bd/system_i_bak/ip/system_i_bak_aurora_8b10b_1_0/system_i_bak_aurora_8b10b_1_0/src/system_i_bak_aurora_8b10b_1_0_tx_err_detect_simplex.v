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
//  TX_ERR_DETECT_SIMPLEX
//
//
//  Description : The ERR_DETECT module monitors the V5 to detect hard
//                errors.All errors are reported to the Global Logic Interface.
//
//                * Supports V5
//

`timescale 1 ns / 1 ps

module system_i_bak_aurora_8b10b_1_0_TX_ERR_DETECT_SIMPLEX
(
    // Lane Init SM Interface
    ENABLE_ERR_DETECT,

    HARD_ERR_RESET,

    // Global Logic Interface
    HARD_ERR,

    // V5 Interface
    TX_K_ERR,
    TX_BUF_ERR,

    // System Interface
    USER_CLK

);

// for test
`define DLY #1

//***********************************Port Declarations*******************************

    // Lane Init SM Interface
    input           ENABLE_ERR_DETECT;

    output          HARD_ERR_RESET;

    // Global Logic Interface
    output          HARD_ERR;

    // V5 Interface
    input   [1:0]   TX_K_ERR;
    input           TX_BUF_ERR;

    // System Interface
    input           USER_CLK;

//**************************External Register Declarations****************************

    reg             HARD_ERR;

//**************************Internal Register Declarations****************************

    reg             hard_err_flop_r;  // Traveling flop for timing.

//*********************************Wire Declarations**********************************


//*********************************Main Body of Code**********************************


    // Detect Hard Errors
    always @(posedge USER_CLK)
        if(ENABLE_ERR_DETECT)
        begin
            hard_err_flop_r  <=  `DLY     ((TX_K_ERR != 2'b00)| TX_BUF_ERR);
            HARD_ERR         <=  `DLY     hard_err_flop_r;
        end
        else
        begin
            hard_err_flop_r   <=  `DLY    1'b0;
            HARD_ERR          <=  `DLY    1'b0;
        end


    // Assert hard error reset when there is a hard error.  This assignment
    // just renames the two fanout branches of the hard error signal.
    assign HARD_ERR_RESET =   hard_err_flop_r;

endmodule
