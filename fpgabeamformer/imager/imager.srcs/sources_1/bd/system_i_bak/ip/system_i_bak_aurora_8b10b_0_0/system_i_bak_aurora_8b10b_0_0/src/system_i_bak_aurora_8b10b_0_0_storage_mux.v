
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
//  STORAGE_MUX
//
//
//  Description: the STORAGE_MUX has a set of 16 bit muxes to control the
//               flow of data. Every output position has its own N:1 mux.
//             
//
//               This module supports 4 2-byte lane designs
//             

`timescale 1 ns / 1 ps

module system_i_bak_aurora_8b10b_0_0_STORAGE_MUX
(

    RAW_DATA,
    MUX_SELECT,
    STORAGE_CE,
    USER_CLK,
   
    STORAGE_DATA

);

`define DLY #1


//***********************************Port Declarations*******************************
   
  
    input   [0:63]  RAW_DATA;
    input   [0:19]  MUX_SELECT;
    input   [0:3]  STORAGE_CE;
    input           USER_CLK;

    output  [0:63]  STORAGE_DATA;

   

      

//**************************External Register Declarations****************************
   
    reg     [0:63]  STORAGE_DATA;
   

//**************************Internal Register Declarations****************************   
  
    reg     [0:63]  storage_data_c;
  
//*********************************Main Body of Code**********************************
   
   
    //Each lane has a set of 16 N:1 muxes connected to all the raw data lanes


    //Data for Lane 0
    always @(MUX_SELECT[0:4] or RAW_DATA)
    case(MUX_SELECT[0:4])
        5'd0  :  storage_data_c[0:15] = RAW_DATA[0:15]; 
        5'd1  :  storage_data_c[0:15] = RAW_DATA[16:31]; 
        5'd2  :  storage_data_c[0:15] = RAW_DATA[32:47]; 
        5'd3  :  storage_data_c[0:15] = RAW_DATA[48:63]; 
       
        default  :  storage_data_c[0:15] = 16'h0;  
    endcase
   
    //Data for Lane 1
    always @(MUX_SELECT[5:9] or RAW_DATA)
    case(MUX_SELECT[5:9])
        5'd0  :  storage_data_c[16:31] = RAW_DATA[0:15]; 
        5'd1  :  storage_data_c[16:31] = RAW_DATA[16:31]; 
        5'd2  :  storage_data_c[16:31] = RAW_DATA[32:47]; 
        5'd3  :  storage_data_c[16:31] = RAW_DATA[48:63]; 
       
        default  :  storage_data_c[16:31] = 16'h0;  
    endcase
   
    //Data for Lane 2
    always @(MUX_SELECT[10:14] or RAW_DATA)
    case(MUX_SELECT[10:14])
        5'd0  :  storage_data_c[32:47] = RAW_DATA[0:15]; 
        5'd1  :  storage_data_c[32:47] = RAW_DATA[16:31]; 
        5'd2  :  storage_data_c[32:47] = RAW_DATA[32:47]; 
        5'd3  :  storage_data_c[32:47] = RAW_DATA[48:63]; 
       
        default  :  storage_data_c[32:47] = 16'h0;  
    endcase
   
    //Data for Lane 3
    always @(MUX_SELECT[15:19] or RAW_DATA)
    case(MUX_SELECT[15:19])
        5'd0  :  storage_data_c[48:63] = RAW_DATA[0:15]; 
        5'd1  :  storage_data_c[48:63] = RAW_DATA[16:31]; 
        5'd2  :  storage_data_c[48:63] = RAW_DATA[32:47]; 
        5'd3  :  storage_data_c[48:63] = RAW_DATA[48:63]; 
       
        default  :  storage_data_c[48:63] = 16'h0;  
    endcase
   


    //Register the stored data
    always @(posedge USER_CLK)
    begin
   
        if(STORAGE_CE[0])    STORAGE_DATA[0:15]    <=  `DLY storage_data_c[0:15];
   
        if(STORAGE_CE[1])    STORAGE_DATA[16:31]    <=  `DLY storage_data_c[16:31];
   
        if(STORAGE_CE[2])    STORAGE_DATA[32:47]    <=  `DLY storage_data_c[32:47];
   
        if(STORAGE_CE[3])    STORAGE_DATA[48:63]    <=  `DLY storage_data_c[48:63];
    end
       
   

endmodule


