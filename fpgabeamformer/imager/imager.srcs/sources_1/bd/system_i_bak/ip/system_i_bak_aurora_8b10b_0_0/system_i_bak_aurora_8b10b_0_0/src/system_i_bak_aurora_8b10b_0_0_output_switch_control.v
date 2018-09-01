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
//  OUTPUT_COUNT_CONTROL
//
//
//  Description: OUTPUT_SWITCH_CONTROL selects the input chunk for each output chunk mux
//
//              This module supports 4 2-byte lane designs
//
//

`timescale 1 ns / 1 ps

module system_i_bak_aurora_8b10b_0_0_OUTPUT_SWITCH_CONTROL
(
    LEFT_ALIGNED_COUNT,
    STORAGE_COUNT,
    END_STORAGE,
    START_WITH_DATA,

    OUTPUT_SELECT,

    USER_CLK

);


`define DLY #1


//***********************************Port Declarations*******************************
    input   [0:2]   LEFT_ALIGNED_COUNT;
    input   [0:2]   STORAGE_COUNT;
    input           END_STORAGE;
    input           START_WITH_DATA;

    output   [0:19]   OUTPUT_SELECT;

    input           USER_CLK;

//****************************External Register Declarations*************************

    reg     [0:19]   OUTPUT_SELECT;


//****************************Internal Register Declarations*************************
    reg     [0:19]   output_select_c;


//*********************************** Wire Declarations *****************************
    wire            take_storage_c;

//*********************************Main Body of Code*********************************



    //______________________________Combine the End signals_________________________

    assign  take_storage_c   =   END_STORAGE | START_WITH_DATA;



    //____________________________Generate switch signals________________________

    // Lane 0 is always connected to storage lane 0.

    // Calculate switch setting for lane 1.

    always @(take_storage_c or LEFT_ALIGNED_COUNT or STORAGE_COUNT)
        if(take_storage_c)   output_select_c[5:9] = 5'd0;
        else
            case({LEFT_ALIGNED_COUNT,STORAGE_COUNT})
{3'd0,3'd1}   :   output_select_c[5:9] = 5'd1;
{3'd0,3'd2}   :   output_select_c[5:9] = 5'd0;
{3'd0,3'd3}   :   output_select_c[5:9] = 5'd0;
{3'd0,3'd4}   :   output_select_c[5:9] = 5'd0;
{3'd1,3'd1}   :   output_select_c[5:9] = 5'd1;
{3'd1,3'd2}   :   output_select_c[5:9] = 5'd0;
{3'd1,3'd3}   :   output_select_c[5:9] = 5'd0;
{3'd1,3'd4}   :   output_select_c[5:9] = 5'd0;
{3'd2,3'd1}   :   output_select_c[5:9] = 5'd1;
{3'd2,3'd2}   :   output_select_c[5:9] = 5'd0;
{3'd2,3'd3}   :   output_select_c[5:9] = 5'd0;
{3'd2,3'd4}   :   output_select_c[5:9] = 5'd0;
{3'd3,3'd1}   :   output_select_c[5:9] = 5'd1;
{3'd3,3'd2}   :   output_select_c[5:9] = 5'd0;
{3'd3,3'd3}   :   output_select_c[5:9] = 5'd0;
{3'd3,3'd4}   :   output_select_c[5:9] = 5'd0;
{3'd4,3'd1}   :   output_select_c[5:9] = 5'd1;
{3'd4,3'd2}   :   output_select_c[5:9] = 5'd0;
{3'd4,3'd3}   :   output_select_c[5:9] = 5'd0;
{3'd4,3'd4}   :   output_select_c[5:9] = 5'd0;
                default   : output_select_c[5:9] = 5'h0;
            endcase
    // Calculate switch setting for lane 2.

    always @(take_storage_c or LEFT_ALIGNED_COUNT or STORAGE_COUNT)
        if(take_storage_c)   output_select_c[10:14] = 5'd0;
        else
            case({LEFT_ALIGNED_COUNT,STORAGE_COUNT})
{3'd0,3'd1}   :   output_select_c[10:14] = 5'd2;
{3'd0,3'd2}   :   output_select_c[10:14] = 5'd1;
{3'd0,3'd3}   :   output_select_c[10:14] = 5'd0;
{3'd0,3'd4}   :   output_select_c[10:14] = 5'd0;
{3'd1,3'd1}   :   output_select_c[10:14] = 5'd2;
{3'd1,3'd2}   :   output_select_c[10:14] = 5'd1;
{3'd1,3'd3}   :   output_select_c[10:14] = 5'd0;
{3'd1,3'd4}   :   output_select_c[10:14] = 5'd0;
{3'd2,3'd1}   :   output_select_c[10:14] = 5'd2;
{3'd2,3'd2}   :   output_select_c[10:14] = 5'd1;
{3'd2,3'd3}   :   output_select_c[10:14] = 5'd0;
{3'd2,3'd4}   :   output_select_c[10:14] = 5'd0;
{3'd3,3'd1}   :   output_select_c[10:14] = 5'd2;
{3'd3,3'd2}   :   output_select_c[10:14] = 5'd1;
{3'd3,3'd3}   :   output_select_c[10:14] = 5'd0;
{3'd3,3'd4}   :   output_select_c[10:14] = 5'd0;
{3'd4,3'd1}   :   output_select_c[10:14] = 5'd2;
{3'd4,3'd2}   :   output_select_c[10:14] = 5'd1;
{3'd4,3'd3}   :   output_select_c[10:14] = 5'd0;
{3'd4,3'd4}   :   output_select_c[10:14] = 5'd0;
                default   : output_select_c[10:14] = 5'h0;
            endcase
    // Calculate switch setting for lane 3.

    always @(take_storage_c or LEFT_ALIGNED_COUNT or STORAGE_COUNT)
        if(take_storage_c)   output_select_c[15:19] = 5'd0;
        else
            case({LEFT_ALIGNED_COUNT,STORAGE_COUNT})
{3'd0,3'd1}   :   output_select_c[15:19] = 5'd3;
{3'd0,3'd2}   :   output_select_c[15:19] = 5'd2;
{3'd0,3'd3}   :   output_select_c[15:19] = 5'd1;
{3'd0,3'd4}   :   output_select_c[15:19] = 5'd0;
{3'd1,3'd1}   :   output_select_c[15:19] = 5'd3;
{3'd1,3'd2}   :   output_select_c[15:19] = 5'd2;
{3'd1,3'd3}   :   output_select_c[15:19] = 5'd1;
{3'd1,3'd4}   :   output_select_c[15:19] = 5'd0;
{3'd2,3'd1}   :   output_select_c[15:19] = 5'd3;
{3'd2,3'd2}   :   output_select_c[15:19] = 5'd2;
{3'd2,3'd3}   :   output_select_c[15:19] = 5'd1;
{3'd2,3'd4}   :   output_select_c[15:19] = 5'd0;
{3'd3,3'd1}   :   output_select_c[15:19] = 5'd3;
{3'd3,3'd2}   :   output_select_c[15:19] = 5'd2;
{3'd3,3'd3}   :   output_select_c[15:19] = 5'd1;
{3'd3,3'd4}   :   output_select_c[15:19] = 5'd0;
{3'd4,3'd1}   :   output_select_c[15:19] = 5'd3;
{3'd4,3'd2}   :   output_select_c[15:19] = 5'd2;
{3'd4,3'd3}   :   output_select_c[15:19] = 5'd1;
{3'd4,3'd4}   :   output_select_c[15:19] = 5'd0;
                default   : output_select_c[15:19] = 5'h0;
            endcase






    // Register the output select values.

    always @(posedge USER_CLK)
        OUTPUT_SELECT   <=  `DLY    {5'd0,output_select_c[5:19]};


endmodule


