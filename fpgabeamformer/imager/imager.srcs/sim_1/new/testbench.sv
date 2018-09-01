// ***************************************************************************
// ***************************************************************************
//  Copyright (C) 2014-2018  EPFL
//  "imager" toplevel block design.
//
//   Permission is hereby granted, free of charge, to any person
//   obtaining a copy of this software and associated documentation
//   files (the "Software"), to deal in the Software without
//   restriction, including without limitation the rights to use,
//   copy, modify, merge, publish, distribute, sublicense, and/or sell
//   copies of the Software, and to permit persons to whom the
//   Software is furnished to do so, subject to the following
//   conditions:
//
//   The above copyright notice and this permission notice shall be
//   included in all copies or substantial portions of the Software.
//
//   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//   OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//   NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//   HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//   WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//   OTHER DEALINGS IN THE SOFTWARE.
// ***************************************************************************
// ***************************************************************************
// ***************************************************************************
// ***************************************************************************

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/29/2016 11:46:17 PM
// Design Name: 
// Module Name: testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`define CLKPERIOD 3.332

module testbench();

  reg           sys_rst;
  reg           sys_clk_p;
  wire          sys_clk_n;
  
  system_top system(
    .ddr4_act_n(),
    .ddr4_addr(),
    .ddr4_ba(),
    .ddr4_bg(),
    .ddr4_ck_p(),
    .ddr4_ck_n(),
    .ddr4_cke(),
    .ddr4_cs_n(),
    .ddr4_dm_n(),
    .ddr4_dq(),
    .ddr4_dqs_p(),
    .ddr4_dqs_n(),
    .ddr4_odt(),
    .ddr4_reset_n(),
    .mdio_mdc(),
    .mdio_mdio(),
    .phy_clk_n(1'b0),
    .phy_clk_p(1'b1),
    .phy_rst_n(),
    .phy_rx_n(1'b1),
    .phy_rx_p(1'b0),
    .phy_tx_n(),
    .phy_tx_p(),
    .sys_clk_n(sys_clk_n),
    .sys_clk_p(sys_clk_p),
    .sys_rst(sys_rst),
    .uart_sin(1'b0),
    .uart_sout(),
    .fan_pwm());
    
    // Clock gen
    initial begin
       sys_clk_p = 1'b0;
       forever sys_clk_p = #(`CLKPERIOD / 2) ~sys_clk_p;
    end
    // Differential clock
    assign sys_clk_n = ~sys_clk_p;
  
    // reset logic
    initial begin
       sys_rst = 1'b1;
       #100 sys_rst = 1'b0;
    end

endmodule
