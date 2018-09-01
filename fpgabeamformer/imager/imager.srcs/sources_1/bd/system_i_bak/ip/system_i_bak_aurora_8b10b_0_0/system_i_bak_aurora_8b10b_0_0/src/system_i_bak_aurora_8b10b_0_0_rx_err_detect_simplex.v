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
//  RX_ERR_DETECT_SIMPLEX_V5
//
//
//  Description : The RX_ERR_DETECT_SIMPLEX_V5 module monitors the V5
//                to detect hard errors.  It accumulates the Soft errors
//                according to the leaky bucket algorithm described in the
//                Aurora Specification to detect Hard errors.  All errors
//                are reported to the Global Logic Interface.
//
//                * Supports V5
//

`timescale 1 ns / 1 ps

module system_i_bak_aurora_8b10b_0_0_RX_ERR_DETECT_SIMPLEX_V5 #
(
   parameter ENABLE_SOFT_ERR_MONITOR  =  1
)
(
    // Lane Init SM Interface
    ENABLE_ERR_DETECT,

    HARD_ERR_RESET,


    // Global Logic Interface
    SOFT_ERR,
    HARD_ERR,


    // V5 Interface
    RX_DISP_ERR,
    RX_NOT_IN_TABLE,
    RX_BUF_ERR,
    RX_REALIGN,

    // System Interface
    USER_CLK

);


`define DLY #1

//***********************************Port Declarations*******************************

    // Lane Init SM Interface
    input           ENABLE_ERR_DETECT;
    output          HARD_ERR_RESET;

    // Global Logic Interface
    output          SOFT_ERR;
    output          HARD_ERR;

    // V5 Interface
    input   [1:0]   RX_DISP_ERR;
    input   [1:0]   RX_NOT_IN_TABLE;
    input           RX_BUF_ERR;
    input           RX_REALIGN;

    // System Interface
    input           USER_CLK;

//**************************External Register Declarations****************************

    reg             HARD_ERR;
    reg             SOFT_ERR;

//**************************Internal Register Declarations****************************

    reg     [0:1]   count_r;
    reg             bucket_full_r;
    reg     [0:1]   soft_err_r;
    reg     [0:1]   good_count_r;
    reg             soft_err_flop_r;  // Traveling flop for timing.
    reg             hard_err_flop_r;  // Traveling flop for timing.

    wire            bucket_full_r_temp;

//*********************************Main Body of Code**********************************

    //____________________________ Error Processing _________________________________

    // Detect Soft Errors
    always @(posedge USER_CLK)
    if(ENABLE_ERR_DETECT)
    begin
        soft_err_r[0] <=  `DLY   RX_DISP_ERR[1]|RX_NOT_IN_TABLE[1];
        soft_err_r[1] <=  `DLY   RX_DISP_ERR[0]|RX_NOT_IN_TABLE[0];
    end
    else
    begin
        soft_err_r[0] <=  `DLY   1'b0;
        soft_err_r[1] <=  `DLY   1'b0;
    end


    always @(posedge USER_CLK)
    begin
        soft_err_flop_r   <=  `DLY    |soft_err_r;
        SOFT_ERR          <=  `DLY    soft_err_flop_r;
    end

generate
  if(ENABLE_SOFT_ERR_MONITOR == 1)
    begin
      assign bucket_full_r_temp        = bucket_full_r;
    end
  else
    begin
      assign bucket_full_r_temp        = 1'b0;
    end
endgenerate

    // Detect Hard Errors
    always @(posedge USER_CLK)
        if(ENABLE_ERR_DETECT)
        begin
            hard_err_flop_r  <=  `DLY (RX_BUF_ERR | RX_REALIGN|bucket_full_r_temp);
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


    //_______________________________Leaky Bucket__________________________________


    // Good cycle counter: it takes 2 consecutive good cycles to remove a demerit from
    // the leaky bucket
    always @(posedge USER_CLK)
        if(!ENABLE_ERR_DETECT)    good_count_r    <=  `DLY    2'b01;
        else
        begin
            case({soft_err_r, good_count_r})
                4'b0000 :   good_count_r    <=  `DLY    2'b01;
                4'b0001 :   good_count_r    <=  `DLY    2'b10;
                4'b0010 :   good_count_r    <=  `DLY    2'b01;
                4'b0011 :   good_count_r    <=  `DLY    2'b01;
                default :   good_count_r    <=  `DLY    2'b00;
            endcase
        end


    // Perform the leaky bucket algorithm using an up/down counter.  A drop is
    // added to the bucket whenever a soft error occurs and is allowed to leak
    // out whenever the good cycles counter reaches 2.  Once the bucket fills
    // (3 drops) it stays full until it is reset by disabling and then enabling
    // the error detection circuit.
    always @(posedge USER_CLK)
        if(!ENABLE_ERR_DETECT)    count_r <=  `DLY    2'b00;
        else
        begin
            case({soft_err_r,good_count_r[0],count_r})

                5'b00000    :   count_r <=  `DLY    count_r;
                5'b00001    :   count_r <=  `DLY    count_r;
                5'b00010    :   count_r <=  `DLY    count_r;
                5'b00011    :   count_r <=  `DLY    count_r;

                5'b00100    :   count_r <=  `DLY    2'b00;
                5'b00101    :   count_r <=  `DLY    2'b00;
                5'b00110    :   count_r <=  `DLY    2'b01;
                5'b00111    :   count_r <=  `DLY    2'b11;

                5'b01000    :   count_r <=  `DLY    2'b01;
                5'b01001    :   count_r <=  `DLY    2'b10;
                5'b01010    :   count_r <=  `DLY    2'b11;
                5'b01011    :   count_r <=  `DLY    2'b11;

                5'b01100    :   count_r <=  `DLY    2'b01;
                5'b01101    :   count_r <=  `DLY    2'b10;
                5'b01110    :   count_r <=  `DLY    2'b11;
                5'b01111    :   count_r <=  `DLY    2'b11;

                5'b10000    :   count_r <=  `DLY    2'b01;
                5'b10001    :   count_r <=  `DLY    2'b10;
                5'b10010    :   count_r <=  `DLY    2'b11;
                5'b10011    :   count_r <=  `DLY    2'b11;

                5'b10100    :   count_r <=  `DLY    2'b01;
                5'b10101    :   count_r <=  `DLY    2'b10;
                5'b10110    :   count_r <=  `DLY    2'b11;
                5'b10111    :   count_r <=  `DLY    2'b11;

                5'b11000    :   count_r <=  `DLY    2'b10;
                5'b11001    :   count_r <=  `DLY    2'b11;
                5'b11010    :   count_r <=  `DLY    2'b11;
                5'b11011    :   count_r <=  `DLY    2'b11;

                5'b11100    :   count_r <=  `DLY    2'b10;
                5'b11101    :   count_r <=  `DLY    2'b11;
                5'b11110    :   count_r <=  `DLY    2'b11;
                5'b11111    :   count_r <=  `DLY    2'b11;

                default     :   count_r <=  `DLY    2'b00;
            endcase
        end


    // Detect when the bucket is full and register the signal.
    always  @(posedge USER_CLK)
        bucket_full_r   <= `DLY (count_r == 2'h3);

endmodule
