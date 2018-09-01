
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
//  VALID_DATA_COUNTER
//
//
//  Description: the VALID_DATA_COUNTER module counts the of lanes in the channel
//               containing valid data. The module is presented with a register
//               representing the lanes that were valid on the previous clock cycle.
//               Each 2-byte lane in the channel is represented by a single bit:
//               when the bit is high the corresponding lane holds valid data. The
//               COUNT output indicated the total number of lanes found with valid
//               data bits.
//
//
//               This module supports 4 2-byte lane designs
//             
//

`timescale 1 ns / 1 ps

module system_i_bak_aurora_8b10b_0_0_VALID_DATA_COUNTER
(
    PREVIOUS_STAGE_VALID,       //One bit per 2-byte lane in channel, 1 = valid data in lane
    USER_CLK,                  
    RESET,
   
   
    COUNT           //Number of lanes that were marked valid      
   
);

`define DLY #1


//***********************************Port Declarations*******************************
      
input   [0:3]      PREVIOUS_STAGE_VALID;
input              USER_CLK;
input              RESET;    

   
output  [0:2]      COUNT;  
   
   
   
//****************************External Register Declarations*************************

   
reg     [0:2]      COUNT;   
   


//****************************Internal Register Declarations*************************
  
   
reg     [0:2]      count_c;   
     
  
//*********************************Main Body of Code*********************************

   
    //Count the number of 1's in PREVIOUS_STAGE_VALID

    always @(PREVIOUS_STAGE_VALID)
        count_c = (PREVIOUS_STAGE_VALID[0]
                             + PREVIOUS_STAGE_VALID[1]                           
                             + PREVIOUS_STAGE_VALID[2]                           
                             + PREVIOUS_STAGE_VALID[3]                           
                                                        );
   
    //Register the count
    always @(posedge USER_CLK)
        if(RESET)   COUNT   <=  `DLY    3'd0;
        else        COUNT   <=  `DLY    count_c;


   
endmodule


