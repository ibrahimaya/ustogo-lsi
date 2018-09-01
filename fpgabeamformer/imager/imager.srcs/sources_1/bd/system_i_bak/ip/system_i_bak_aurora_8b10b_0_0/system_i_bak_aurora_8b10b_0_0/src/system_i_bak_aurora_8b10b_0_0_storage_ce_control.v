
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
//  STORAGE_CE_CONTROL
//
//
//  Description: the STORAGE_CE controls the enable signals of the the Storage register
//
//              This module supports 4 2-byte lane designs
//             
//

`timescale 1 ns / 1 ps

module system_i_bak_aurora_8b10b_0_0_STORAGE_CE_CONTROL
(
    LEFT_ALIGNED_COUNT,
    STORAGE_COUNT,
    END_STORAGE,
    START_WITH_DATA,
   
    STORAGE_CE,
   
    USER_CLK,
    RESET
     
);

`define DLY #1

   
//***********************************Port Declarations*******************************

 
    input   [0:2]   LEFT_ALIGNED_COUNT;
    input   [0:2]   STORAGE_COUNT;
    input           END_STORAGE;
    input           START_WITH_DATA;
   
    output   [0:3]   STORAGE_CE;   
   
    input           USER_CLK;
    input           RESET;

//******************************External Register Declarations***********************

    reg     [0:3]  STORAGE_CE;


//*********************************Wire Declarations*********************************
    wire            overwrite_c;
    wire            excess_c;
    wire    [0:3]  ce_command_c;
  
  
//*********************************Main Body of Code*********************************


   
    //Combine the end signals
    assign  overwrite_c   =   END_STORAGE | START_WITH_DATA;
   
   
    //For each lane, determine the appropriate CE value
    assign  excess_c = (LEFT_ALIGNED_COUNT + STORAGE_COUNT > 4);
   
    assign  ce_command_c[0] = excess_c | (STORAGE_COUNT < 1) | overwrite_c;
    assign  ce_command_c[1] = excess_c | (STORAGE_COUNT < 2) | overwrite_c;
    assign  ce_command_c[2] = excess_c | (STORAGE_COUNT < 3) | overwrite_c;
    assign  ce_command_c[3] = excess_c | (STORAGE_COUNT < 4) | overwrite_c;


    //Register the output
    always @(posedge USER_CLK)
        if(RESET)   STORAGE_CE  <=  `DLY    4'd0;
        else        STORAGE_CE  <=  `DLY    ce_command_c;

       
   
endmodule


