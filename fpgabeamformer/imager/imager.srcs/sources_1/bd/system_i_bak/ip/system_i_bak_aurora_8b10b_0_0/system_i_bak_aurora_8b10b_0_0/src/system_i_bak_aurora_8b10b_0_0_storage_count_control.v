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
//  STORAGE_COUNT_CONTROL
//
//
//  Description: STORAGE_COUNT_CONTROL sets the storage count value for the
//               next clock cycle.
//
//               This module supports 4 2-byte lane designs.
//

`timescale 1 ns / 1 ps

module system_i_bak_aurora_8b10b_0_0_STORAGE_COUNT_CONTROL
(
    LEFT_ALIGNED_COUNT,
    END_STORAGE,
    START_WITH_DATA,
    FRAME_ERR,

    STORAGE_COUNT,

    USER_CLK,
    RESET

 );

`define DLY #1

//***********************************Port Declarations*******************************

    input   [0:2]   LEFT_ALIGNED_COUNT;
    input           END_STORAGE;
    input           START_WITH_DATA;
    input           FRAME_ERR;

    output   [0:2]   STORAGE_COUNT;

    input           USER_CLK;
    input           RESET;

//****************************Internal Register Declarations*************************

    reg     [0:2]   storage_count_c;
    reg     [0:2]   storage_count_r;


//*********************************Wire Declarations*********************************

    wire                overwrite_c;
    wire    [0:3]   sum_c;
    wire    [0:3]   remainder_c;
    wire                overflow_c;

//*********************************Main Body of Code*********************************


    // Calculate the value that will be used for the switch.

    assign  sum_c           =   LEFT_ALIGNED_COUNT + storage_count_r;
    assign  remainder_c     =   sum_c - 4'd4;

    assign  overwrite_c     =   END_STORAGE | START_WITH_DATA;
    assign  overflow_c      =   sum_c > 4'd4;


    always @(overwrite_c or overflow_c or sum_c or remainder_c or LEFT_ALIGNED_COUNT)
        case({overwrite_c,overflow_c})
            2'b00   :   storage_count_c  =   sum_c;
            2'b01   :   storage_count_c  =   remainder_c;
            2'b10   :   storage_count_c  =   LEFT_ALIGNED_COUNT;
            2'b11   :   storage_count_c  =   LEFT_ALIGNED_COUNT;
            default :   storage_count_c  =   3'b0;
        endcase


    // Register the Storage Count for the next cycle.

    always @(posedge USER_CLK)
        if(RESET||FRAME_ERR)   storage_count_r <=  `DLY    3'd0;
        else                     storage_count_r <=  `DLY    storage_count_c;


    // Make the output of the storage count register available to other modules.

    assign  STORAGE_COUNT   =    storage_count_r;

endmodule
