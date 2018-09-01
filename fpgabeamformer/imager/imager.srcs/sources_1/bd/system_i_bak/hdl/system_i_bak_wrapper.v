//Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2016.1 (win64) Build 1538259 Fri Apr  8 15:45:27 MDT 2016
//Date        : Mon Feb 26 03:04:04 2018
//Host        : SHADOWFAX running 64-bit major release  (build 9200)
//Command     : generate_target system_i_bak_wrapper.bd
//Design      : system_i_bak_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module system_i_bak_wrapper
   (GT_DIFF_REFCLK1_clk_n,
    GT_DIFF_REFCLK1_clk_p,
    GT_SERIAL_RX_rxn,
    GT_SERIAL_RX_rxp,
    GT_SERIAL_TX_txn,
    GT_SERIAL_TX_txp,
    aurora_reset_button,
    c0_ddr4_act_n,
    c0_ddr4_adr,
    c0_ddr4_ba,
    c0_ddr4_bg,
    c0_ddr4_ck_c,
    c0_ddr4_ck_t,
    c0_ddr4_cke,
    c0_ddr4_cs_n,
    c0_ddr4_dm_n,
    c0_ddr4_dq,
    c0_ddr4_dqs_c,
    c0_ddr4_dqs_t,
    c0_ddr4_odt,
    c0_ddr4_reset_n,
    gpio2_tri_i,
    gpio_tri_o,
    hdmi_16_data,
    hdmi_16_data_e,
    hdmi_16_hsync,
    hdmi_16_vsync,
    hdmi_out_clk,
    iic_main_scl_io,
    iic_main_sda_io,
    mb_intr_05,
    mb_intr_06,
    mb_intr_12,
    mb_intr_13,
    mb_intr_14,
    mb_intr_15,
    mdio_mdc_mdc,
    mdio_mdc_mdio_io,
    phy_clk_clk_n,
    phy_clk_clk_p,
    phy_rst_n,
    rx_channel_up,
    sgmii_rxn,
    sgmii_rxp,
    sgmii_txn,
    sgmii_txp,
    sys_clk_clk_n,
    sys_clk_clk_p,
    sys_rst,
    uart_sin,
    uart_sout);
  input GT_DIFF_REFCLK1_clk_n;
  input GT_DIFF_REFCLK1_clk_p;
  input [0:3]GT_SERIAL_RX_rxn;
  input [0:3]GT_SERIAL_RX_rxp;
  output [0:3]GT_SERIAL_TX_txn;
  output [0:3]GT_SERIAL_TX_txp;
  input aurora_reset_button;
  output c0_ddr4_act_n;
  output [16:0]c0_ddr4_adr;
  output [1:0]c0_ddr4_ba;
  output c0_ddr4_bg;
  output c0_ddr4_ck_c;
  output c0_ddr4_ck_t;
  output c0_ddr4_cke;
  output c0_ddr4_cs_n;
  inout [7:0]c0_ddr4_dm_n;
  inout [63:0]c0_ddr4_dq;
  inout [7:0]c0_ddr4_dqs_c;
  inout [7:0]c0_ddr4_dqs_t;
  output c0_ddr4_odt;
  output c0_ddr4_reset_n;
  input [3:0]gpio2_tri_i;
  output [6:0]gpio_tri_o;
  output [15:0]hdmi_16_data;
  output hdmi_16_data_e;
  output hdmi_16_hsync;
  output hdmi_16_vsync;
  output hdmi_out_clk;
  inout iic_main_scl_io;
  inout iic_main_sda_io;
  input mb_intr_05;
  input mb_intr_06;
  input mb_intr_12;
  input mb_intr_13;
  input mb_intr_14;
  input mb_intr_15;
  output mdio_mdc_mdc;
  inout mdio_mdc_mdio_io;
  input phy_clk_clk_n;
  input phy_clk_clk_p;
  output [0:0]phy_rst_n;
  output rx_channel_up;
  input sgmii_rxn;
  input sgmii_rxp;
  output sgmii_txn;
  output sgmii_txp;
  input sys_clk_clk_n;
  input sys_clk_clk_p;
  input sys_rst;
  input uart_sin;
  output uart_sout;

  wire GT_DIFF_REFCLK1_clk_n;
  wire GT_DIFF_REFCLK1_clk_p;
  wire [0:3]GT_SERIAL_RX_rxn;
  wire [0:3]GT_SERIAL_RX_rxp;
  wire [0:3]GT_SERIAL_TX_txn;
  wire [0:3]GT_SERIAL_TX_txp;
  wire aurora_reset_button;
  wire c0_ddr4_act_n;
  wire [16:0]c0_ddr4_adr;
  wire [1:0]c0_ddr4_ba;
  wire c0_ddr4_bg;
  wire c0_ddr4_ck_c;
  wire c0_ddr4_ck_t;
  wire c0_ddr4_cke;
  wire c0_ddr4_cs_n;
  wire [7:0]c0_ddr4_dm_n;
  wire [63:0]c0_ddr4_dq;
  wire [7:0]c0_ddr4_dqs_c;
  wire [7:0]c0_ddr4_dqs_t;
  wire c0_ddr4_odt;
  wire c0_ddr4_reset_n;
  wire [3:0]gpio2_tri_i;
  wire [6:0]gpio_tri_o;
  wire [15:0]hdmi_16_data;
  wire hdmi_16_data_e;
  wire hdmi_16_hsync;
  wire hdmi_16_vsync;
  wire hdmi_out_clk;
  wire iic_main_scl_i;
  wire iic_main_scl_io;
  wire iic_main_scl_o;
  wire iic_main_scl_t;
  wire iic_main_sda_i;
  wire iic_main_sda_io;
  wire iic_main_sda_o;
  wire iic_main_sda_t;
  wire mb_intr_05;
  wire mb_intr_06;
  wire mb_intr_12;
  wire mb_intr_13;
  wire mb_intr_14;
  wire mb_intr_15;
  wire mdio_mdc_mdc;
  wire mdio_mdc_mdio_i;
  wire mdio_mdc_mdio_io;
  wire mdio_mdc_mdio_o;
  wire mdio_mdc_mdio_t;
  wire phy_clk_clk_n;
  wire phy_clk_clk_p;
  wire [0:0]phy_rst_n;
  wire rx_channel_up;
  wire sgmii_rxn;
  wire sgmii_rxp;
  wire sgmii_txn;
  wire sgmii_txp;
  wire sys_clk_clk_n;
  wire sys_clk_clk_p;
  wire sys_rst;
  wire uart_sin;
  wire uart_sout;

  IOBUF iic_main_scl_iobuf
       (.I(iic_main_scl_o),
        .IO(iic_main_scl_io),
        .O(iic_main_scl_i),
        .T(iic_main_scl_t));
  IOBUF iic_main_sda_iobuf
       (.I(iic_main_sda_o),
        .IO(iic_main_sda_io),
        .O(iic_main_sda_i),
        .T(iic_main_sda_t));
  IOBUF mdio_mdc_mdio_iobuf
       (.I(mdio_mdc_mdio_o),
        .IO(mdio_mdc_mdio_io),
        .O(mdio_mdc_mdio_i),
        .T(mdio_mdc_mdio_t));
  system_i_bak system_i_bak_i
       (.GPIO2_tri_i(gpio2_tri_i),
        .GPIO_tri_o(gpio_tri_o),
        .GT_DIFF_REFCLK1_clk_n(GT_DIFF_REFCLK1_clk_n),
        .GT_DIFF_REFCLK1_clk_p(GT_DIFF_REFCLK1_clk_p),
        .GT_SERIAL_RX_rxn(GT_SERIAL_RX_rxn),
        .GT_SERIAL_RX_rxp(GT_SERIAL_RX_rxp),
        .GT_SERIAL_TX_txn(GT_SERIAL_TX_txn),
        .GT_SERIAL_TX_txp(GT_SERIAL_TX_txp),
        .aurora_reset_button(aurora_reset_button),
        .c0_ddr4_act_n(c0_ddr4_act_n),
        .c0_ddr4_adr(c0_ddr4_adr),
        .c0_ddr4_ba(c0_ddr4_ba),
        .c0_ddr4_bg(c0_ddr4_bg),
        .c0_ddr4_ck_c(c0_ddr4_ck_c),
        .c0_ddr4_ck_t(c0_ddr4_ck_t),
        .c0_ddr4_cke(c0_ddr4_cke),
        .c0_ddr4_cs_n(c0_ddr4_cs_n),
        .c0_ddr4_dm_n(c0_ddr4_dm_n),
        .c0_ddr4_dq(c0_ddr4_dq),
        .c0_ddr4_dqs_c(c0_ddr4_dqs_c),
        .c0_ddr4_dqs_t(c0_ddr4_dqs_t),
        .c0_ddr4_odt(c0_ddr4_odt),
        .c0_ddr4_reset_n(c0_ddr4_reset_n),
        .hdmi_16_data(hdmi_16_data),
        .hdmi_16_data_e(hdmi_16_data_e),
        .hdmi_16_hsync(hdmi_16_hsync),
        .hdmi_16_vsync(hdmi_16_vsync),
        .hdmi_out_clk(hdmi_out_clk),
        .iic_main_scl_i(iic_main_scl_i),
        .iic_main_scl_o(iic_main_scl_o),
        .iic_main_scl_t(iic_main_scl_t),
        .iic_main_sda_i(iic_main_sda_i),
        .iic_main_sda_o(iic_main_sda_o),
        .iic_main_sda_t(iic_main_sda_t),
        .mb_intr_05(mb_intr_05),
        .mb_intr_06(mb_intr_06),
        .mb_intr_12(mb_intr_12),
        .mb_intr_13(mb_intr_13),
        .mb_intr_14(mb_intr_14),
        .mb_intr_15(mb_intr_15),
        .mdio_mdc_mdc(mdio_mdc_mdc),
        .mdio_mdc_mdio_i(mdio_mdc_mdio_i),
        .mdio_mdc_mdio_o(mdio_mdc_mdio_o),
        .mdio_mdc_mdio_t(mdio_mdc_mdio_t),
        .phy_clk_clk_n(phy_clk_clk_n),
        .phy_clk_clk_p(phy_clk_clk_p),
        .phy_rst_n(phy_rst_n),
        .rx_channel_up(rx_channel_up),
        .sgmii_rxn(sgmii_rxn),
        .sgmii_rxp(sgmii_rxp),
        .sgmii_txn(sgmii_txn),
        .sgmii_txp(sgmii_txp),
        .sys_clk_clk_n(sys_clk_clk_n),
        .sys_clk_clk_p(sys_clk_clk_p),
        .sys_rst(sys_rst),
        .uart_sin(uart_sin),
        .uart_sout(uart_sout));
endmodule
