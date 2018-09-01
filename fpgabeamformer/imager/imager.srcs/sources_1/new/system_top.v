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

`timescale 1ns/100ps

module system_top (

  sys_rst,
  sys_clk_p,
  sys_clk_n,

  uart_sin,
  uart_sout,
  
  GT_DIFF_REFCLK1_clk_n,
  GT_DIFF_REFCLK1_clk_p,
  GT_SERIAL_RX_rxn,
  GT_SERIAL_RX_rxp,
  GT_SERIAL_TX_txn,
  GT_SERIAL_TX_txp,

  ddr4_act_n,
  ddr4_addr,
  ddr4_ba,
  ddr4_bg,
  ddr4_ck_p,
  ddr4_ck_n,
  ddr4_cke,
  ddr4_cs_n,
  ddr4_dm_n,
  ddr4_dq,
  ddr4_dqs_p,
  ddr4_dqs_n,
  ddr4_odt,
  ddr4_reset_n,

  mdio_mdc,
  mdio_mdio,
  phy_clk_p,
  phy_clk_n,
  phy_rst_n,
  phy_rx_p,
  phy_rx_n,
  phy_tx_p,
  phy_tx_n,

  fan_pwm,

  iic_scl,
  iic_sda,

  hdmi_out_clk,
  hdmi_hsync,
  hdmi_vsync,
  hdmi_data_e,
  hdmi_data,
  
  push_buttons,
  leds
  );

  input           sys_rst;
  input           sys_clk_p;
  input           sys_clk_n;

  input           uart_sin;
  output          uart_sout;
  
  input           GT_DIFF_REFCLK1_clk_n;
  input           GT_DIFF_REFCLK1_clk_p;
  input [0 : 3]   GT_SERIAL_RX_rxn;
  input [0 : 3]   GT_SERIAL_RX_rxp;
  output [0 : 3]  GT_SERIAL_TX_txn;
  output [0 : 3]  GT_SERIAL_TX_txp;
  
  output          ddr4_act_n;
  output  [16:0]  ddr4_addr;
  output  [ 1:0]  ddr4_ba;
  output  [ 0:0]  ddr4_bg;
  output          ddr4_ck_p;
  output          ddr4_ck_n;
  output  [ 0:0]  ddr4_cke;
  output  [ 0:0]  ddr4_cs_n;
  inout   [ 7:0]  ddr4_dm_n;
  inout   [63:0]  ddr4_dq;
  inout   [ 7:0]  ddr4_dqs_p;
  inout   [ 7:0]  ddr4_dqs_n;
  output  [ 0:0]  ddr4_odt;
  output          ddr4_reset_n;

  output          mdio_mdc;
  inout           mdio_mdio;
  input           phy_clk_p;
  input           phy_clk_n;
  output          phy_rst_n;
  input           phy_rx_p;
  input           phy_rx_n;
  output          phy_tx_p;
  output          phy_tx_n;

  output          fan_pwm;

  inout           iic_scl;
  inout           iic_sda;

  output          hdmi_out_clk;
  output          hdmi_hsync;
  output          hdmi_vsync;
  output          hdmi_data_e;
  output  [15:0]  hdmi_data;

  input [4:0]     push_buttons;
  output [7:0]    leds;

  assign fan_pwm = 1'b1; //TODO too noisy

  system_i_bak_wrapper i_system_wrapper (
    .GT_DIFF_REFCLK1_clk_n(GT_DIFF_REFCLK1_clk_n),
    .GT_DIFF_REFCLK1_clk_p(GT_DIFF_REFCLK1_clk_p),
    .GT_SERIAL_RX_rxn(GT_SERIAL_RX_rxn),
    .GT_SERIAL_RX_rxp(GT_SERIAL_RX_rxp),
    .GT_SERIAL_TX_txn(GT_SERIAL_TX_txn),
    .GT_SERIAL_TX_txp(GT_SERIAL_TX_txp),
    .aurora_reset_button(push_buttons[4]),
    .c0_ddr4_act_n (ddr4_act_n),
    .c0_ddr4_adr (ddr4_addr),
    .c0_ddr4_ba (ddr4_ba),
    .c0_ddr4_bg (ddr4_bg),
    .c0_ddr4_ck_c (ddr4_ck_n),
    .c0_ddr4_ck_t (ddr4_ck_p),
    .c0_ddr4_cke (ddr4_cke),
    .c0_ddr4_cs_n (ddr4_cs_n),
    .c0_ddr4_dm_n (ddr4_dm_n),
    .c0_ddr4_dq (ddr4_dq),
    .c0_ddr4_dqs_c (ddr4_dqs_n),
    .c0_ddr4_dqs_t (ddr4_dqs_p),
    .c0_ddr4_odt (ddr4_odt),
    .c0_ddr4_reset_n (ddr4_reset_n),
    .gpio2_tri_i (push_buttons[3 : 0]),
    .gpio_tri_o (leds[6 : 0]),
    .hdmi_16_data (hdmi_data),
    .hdmi_16_data_e (hdmi_data_e),
    .hdmi_16_hsync (hdmi_hsync),
    .hdmi_16_vsync (hdmi_vsync),
    .hdmi_out_clk (hdmi_out_clk),
    .iic_main_scl_io (iic_scl),
    .iic_main_sda_io (iic_sda),
    .mb_intr_05 (1'b0),
    .mb_intr_06 (1'b0),
    .mb_intr_12 (1'b0),
    .mb_intr_13 (1'b0),
    .mb_intr_14 (1'b0),
    .mb_intr_15 (1'b0),
    .mdio_mdc_mdc (mdio_mdc),
    .mdio_mdc_mdio_io (mdio_mdio),
    .phy_clk_clk_n (phy_clk_n),
    .phy_clk_clk_p (phy_clk_p),
    .phy_rst_n (phy_rst_n),
    .rx_channel_up(leds[7]),
    .sgmii_rxn (phy_rx_n),
    .sgmii_rxp (phy_rx_p),
    .sgmii_txn (phy_tx_n),
    .sgmii_txp (phy_tx_p),
    .sys_clk_clk_n (sys_clk_n),
    .sys_clk_clk_p (sys_clk_p),
    .sys_rst (sys_rst),
    .uart_sin (uart_sin),
    .uart_sout (uart_sout));

endmodule
