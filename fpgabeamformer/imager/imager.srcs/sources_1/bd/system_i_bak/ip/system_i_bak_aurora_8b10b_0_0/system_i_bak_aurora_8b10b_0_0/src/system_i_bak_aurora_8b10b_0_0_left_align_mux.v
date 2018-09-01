
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
//  LEFT_ALIGN_MUX
//
//
//  Description: the left align mux is used to shift incoming data symbols
//               leftwards in the channel during the RX_LL left align step.
//               It consists of a set of muxes, one for each position in the
//               channel. The number of inputs for each mux decrements as the
//               position gets further from the left: the muxes for the leftmost
//               position are N:1. The 'muxes' for the rightmost position are 1:1
//
//               This module supports 4 2-byte lane designs
//             

`timescale 1 ns / 1 ps

module system_i_bak_aurora_8b10b_0_0_LEFT_ALIGN_MUX
(
    RAW_DATA,
    MUX_SELECT,
    USER_CLK,
   
    MUXED_DATA 

);

`define DLY #1


//***********************************Port Declarations*******************************
   
    input   [0:63]  RAW_DATA;
    input   [0:11]   MUX_SELECT;
    input           USER_CLK;

    output  [0:63]  MUXED_DATA;


//**************************External Register Declarations****************************
   
    reg     [0:63]   MUXED_DATA;
   
   
//**************************Internal Register Declarations****************************   
  
    reg     [0:63]   muxed_data_c;
   
  
//*********************************Main Body of Code**********************************
  
   
   
   
    //We create muxes for each of the positions


    //Data for lane 0
    always @(MUX_SELECT[0:2] or RAW_DATA)
    case(MUX_SELECT[0:2])
        3'd0  :  muxed_data_c[0:15] = RAW_DATA[0:15]; 
        3'd1  :  muxed_data_c[0:15] = RAW_DATA[16:31]; 
        3'd2  :  muxed_data_c[0:15] = RAW_DATA[32:47]; 
        3'd3  :  muxed_data_c[0:15] = RAW_DATA[48:63]; 
       
        default  :  muxed_data_c[0:15] = 16'h0;  
    endcase
   
    //Data for lane 1
    always @(MUX_SELECT[3:5] or RAW_DATA)
    case(MUX_SELECT[3:5])
        3'd0  :  muxed_data_c[16:31] = RAW_DATA[16:31]; 
        3'd1  :  muxed_data_c[16:31] = RAW_DATA[32:47]; 
        3'd2  :  muxed_data_c[16:31] = RAW_DATA[48:63]; 
       
        default  :  muxed_data_c[16:31] = 16'h0;  
    endcase
   
    //Data for lane 2
    always @(MUX_SELECT[6:8] or RAW_DATA)
    case(MUX_SELECT[6:8])
        3'd0  :  muxed_data_c[32:47] = RAW_DATA[32:47]; 
        3'd1  :  muxed_data_c[32:47] = RAW_DATA[48:63]; 
       
        default  :  muxed_data_c[32:47] = 16'h0;  
    endcase
   
    //Data for lane 3
    always @(MUX_SELECT[9:11] or RAW_DATA)
    case(MUX_SELECT[9:11])
        3'd0  :  muxed_data_c[48:63] = RAW_DATA[48:63]; 
       
        default  :  muxed_data_c[48:63] = 16'h0;  
    endcase
   









   
    //Register the muxed data
    always @(posedge USER_CLK)
        MUXED_DATA  <=  `DLY    muxed_data_c;




endmodule


