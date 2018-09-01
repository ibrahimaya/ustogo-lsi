/******************************************************************************
// (c) Copyright 2013 - 2014 Xilinx, Inc. All rights reserved.
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
******************************************************************************/
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor             : Xilinx
// \   \   \/     Version            : 1.1
//  \   \         Application        : MIG
//  /   /         Filename           : ddr4_v2_0_0_cal_read.sv
// /___/   /\     Date Last Modified : $Date: 2015/04/23 $
// \   \  /  \    Date Created       : Thu Apr 18 2013
//  \___\/\___\
//
// Device           : UltraScale
// Design Name      : DDR4 SDRAM & DDR3 SDRAM
// Purpose          :
//                   ddr4_v2_0_0_cal_bfifo module
// Reference        :
// Revision History :
//*****************************************************************************

`timescale 1ns/100ps

module ddr4_v2_0_0_cal_bfifo #(parameter
    TCQ = 0.1
    ,DBAW = 5
)(
    input clk
   ,input rst

   ,output reg            fifoEmptyB
   ,output reg [DBAW-1:0] rdDataAddr
   ,output reg            nValRd
   ,output reg            rdInj
   ,output reg            rdRmw

   ,input     [12:0] fifoEmpty
   ,input            fifoRead
   ,input            rdCAS
   ,input            winInjTxn
   ,input            winRmw
   ,input [DBAW-1:0] winBuf
);

reg [DBAW+2:0] bufFifo[0:31];
reg    [4:0] rdPtr;
reg    [4:0] wrPtr;
reg          valRd;

always @(posedge clk) fifoEmptyB <= #TCQ |fifoEmpty;

always @(posedge clk) if (rst) begin
   rdPtr <= 'b0;
   wrPtr <= 'b0;
   rdDataAddr <= 'bx;
   valRd <= 1'b0;
   rdInj <= 1'b0;
   rdRmw <= 1'b0;
end else begin
   bufFifo[wrPtr] <= #TCQ {winRmw, winInjTxn, rdCAS, winBuf};
   wrPtr <= #TCQ wrPtr + 1'b1;
   if ((!valRd || fifoRead) && (rdPtr != wrPtr)) begin
      rdPtr <= #TCQ rdPtr + 1'b1;
      {rdRmw, rdInj, valRd, rdDataAddr} <= #TCQ bufFifo[rdPtr];
   end
end

always @(*) if ((!valRd || fifoRead) && (rdPtr != wrPtr))
   nValRd = bufFifo[rdPtr][DBAW];
else nValRd = valRd;

endmodule


