//Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2016.1 (win64) Build 1538259 Fri Apr  8 15:45:27 MDT 2016
//Date        : Mon Feb 26 03:04:06 2018
//Host        : SHADOWFAX running 64-bit major release  (build 9200)
//Command     : generate_target bd_4236.bd
//Design      : bd_4236
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "bd_4236,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=bd_4236,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=3,numReposBlks=3,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=SBD,synth_mode=Global}" *) (* HW_HANDOFF = "system_i_bak_axi_ethernet_0_0.hwdef" *) 
module bd_4236
   (axi_rxd_arstn,
    axi_rxs_arstn,
    axi_txc_arstn,
    axi_txd_arstn,
    axis_clk,
    clk125m,
    clk312,
    clk625,
    idelay_rdy_in,
    interrupt,
    m_axis_rxd_tdata,
    m_axis_rxd_tkeep,
    m_axis_rxd_tlast,
    m_axis_rxd_tready,
    m_axis_rxd_tvalid,
    m_axis_rxs_tdata,
    m_axis_rxs_tkeep,
    m_axis_rxs_tlast,
    m_axis_rxs_tready,
    m_axis_rxs_tvalid,
    mac_irq,
    mdio_mdc,
    mdio_mdio_i,
    mdio_mdio_o,
    mdio_mdio_t,
    mmcm_locked,
    phy_rst_n,
    rst_125,
    s_axi_araddr,
    s_axi_arready,
    s_axi_arvalid,
    s_axi_awaddr,
    s_axi_awready,
    s_axi_awvalid,
    s_axi_bready,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_lite_clk,
    s_axi_lite_resetn,
    s_axi_rdata,
    s_axi_rready,
    s_axi_rresp,
    s_axi_rvalid,
    s_axi_wdata,
    s_axi_wready,
    s_axi_wstrb,
    s_axi_wvalid,
    s_axis_txc_tdata,
    s_axis_txc_tkeep,
    s_axis_txc_tlast,
    s_axis_txc_tready,
    s_axis_txc_tvalid,
    s_axis_txd_tdata,
    s_axis_txd_tkeep,
    s_axis_txd_tlast,
    s_axis_txd_tready,
    s_axis_txd_tvalid,
    sgmii_rxn,
    sgmii_rxp,
    sgmii_txn,
    sgmii_txp,
    signal_detect);
  input axi_rxd_arstn;
  input axi_rxs_arstn;
  input axi_txc_arstn;
  input axi_txd_arstn;
  input axis_clk;
  input clk125m;
  input clk312;
  input clk625;
  input idelay_rdy_in;
  output interrupt;
  output [31:0]m_axis_rxd_tdata;
  output [3:0]m_axis_rxd_tkeep;
  output m_axis_rxd_tlast;
  input m_axis_rxd_tready;
  output m_axis_rxd_tvalid;
  output [31:0]m_axis_rxs_tdata;
  output [3:0]m_axis_rxs_tkeep;
  output m_axis_rxs_tlast;
  input m_axis_rxs_tready;
  output m_axis_rxs_tvalid;
  output mac_irq;
  output mdio_mdc;
  input mdio_mdio_i;
  output mdio_mdio_o;
  output mdio_mdio_t;
  input mmcm_locked;
  output phy_rst_n;
  input rst_125;
  input [17:0]s_axi_araddr;
  output s_axi_arready;
  input s_axi_arvalid;
  input [17:0]s_axi_awaddr;
  output s_axi_awready;
  input s_axi_awvalid;
  input s_axi_bready;
  output [1:0]s_axi_bresp;
  output s_axi_bvalid;
  input s_axi_lite_clk;
  input s_axi_lite_resetn;
  output [31:0]s_axi_rdata;
  input s_axi_rready;
  output [1:0]s_axi_rresp;
  output s_axi_rvalid;
  input [31:0]s_axi_wdata;
  output s_axi_wready;
  input [3:0]s_axi_wstrb;
  input s_axi_wvalid;
  input [31:0]s_axis_txc_tdata;
  input [3:0]s_axis_txc_tkeep;
  input s_axis_txc_tlast;
  output s_axis_txc_tready;
  input s_axis_txc_tvalid;
  input [31:0]s_axis_txd_tdata;
  input [3:0]s_axis_txd_tkeep;
  input s_axis_txd_tlast;
  output s_axis_txd_tready;
  input s_axis_txd_tvalid;
  input sgmii_rxn;
  input sgmii_rxp;
  output sgmii_txn;
  output sgmii_txp;
  input signal_detect;

  wire axi_rxd_arstn_1;
  wire axi_rxs_arstn_1;
  wire axi_txc_arstn_1;
  wire axi_txd_arstn_1;
  wire axis_clk_1;
  wire clk125m_1;
  wire clk312_1;
  wire clk625_1;
  wire [31:0]eth_buf_AXI_STR_RXD_TDATA;
  wire [3:0]eth_buf_AXI_STR_RXD_TKEEP;
  wire eth_buf_AXI_STR_RXD_TLAST;
  wire eth_buf_AXI_STR_RXD_TREADY;
  wire eth_buf_AXI_STR_RXD_TVALID;
  wire [31:0]eth_buf_AXI_STR_RXS_TDATA;
  wire [3:0]eth_buf_AXI_STR_RXS_TKEEP;
  wire eth_buf_AXI_STR_RXS_TLAST;
  wire eth_buf_AXI_STR_RXS_TREADY;
  wire eth_buf_AXI_STR_RXS_TVALID;
  wire eth_buf_INTERRUPT;
  wire eth_buf_PHY_RST_N;
  wire eth_buf_RESET2TEMACn;
  wire [11:0]eth_buf_S_AXI_2TEMAC_ARADDR;
  wire eth_buf_S_AXI_2TEMAC_ARREADY;
  wire eth_buf_S_AXI_2TEMAC_ARVALID;
  wire [11:0]eth_buf_S_AXI_2TEMAC_AWADDR;
  wire eth_buf_S_AXI_2TEMAC_AWREADY;
  wire eth_buf_S_AXI_2TEMAC_AWVALID;
  wire eth_buf_S_AXI_2TEMAC_BREADY;
  wire [1:0]eth_buf_S_AXI_2TEMAC_BRESP;
  wire eth_buf_S_AXI_2TEMAC_BVALID;
  wire [31:0]eth_buf_S_AXI_2TEMAC_RDATA;
  wire eth_buf_S_AXI_2TEMAC_RREADY;
  wire [1:0]eth_buf_S_AXI_2TEMAC_RRESP;
  wire eth_buf_S_AXI_2TEMAC_RVALID;
  wire [31:0]eth_buf_S_AXI_2TEMAC_WDATA;
  wire eth_buf_S_AXI_2TEMAC_WREADY;
  wire eth_buf_S_AXI_2TEMAC_WVALID;
  wire [7:0]eth_buf_TX_AXIS_MAC_TDATA;
  wire eth_buf_TX_AXIS_MAC_TLAST;
  wire eth_buf_TX_AXIS_MAC_TREADY;
  wire [0:0]eth_buf_TX_AXIS_MAC_TUSER;
  wire eth_buf_TX_AXIS_MAC_TVALID;
  wire eth_buf_pause_req;
  wire [16:31]eth_buf_pause_val;
  wire [24:31]eth_buf_tx_ifg_delay;
  wire [7:0]eth_mac_gmii_RXD;
  wire eth_mac_gmii_RX_DV;
  wire eth_mac_gmii_RX_ER;
  wire [7:0]eth_mac_gmii_TXD;
  wire eth_mac_gmii_TX_EN;
  wire eth_mac_gmii_TX_ER;
  wire [7:0]eth_mac_m_axis_rx_TDATA;
  wire eth_mac_m_axis_rx_TLAST;
  wire eth_mac_m_axis_rx_TUSER;
  wire eth_mac_m_axis_rx_TVALID;
  wire eth_mac_mac_irq;
  wire eth_mac_mdc;
  wire eth_mac_mdio_o;
  wire eth_mac_mdio_t;
  wire eth_mac_rx_mac_aclk;
  wire eth_mac_rx_reset;
  wire eth_mac_rx_statistics_valid;
  wire [27:0]eth_mac_rx_statistics_vector;
  wire eth_mac_speedis100;
  wire eth_mac_speedis10100;
  wire eth_mac_tx_mac_aclk;
  wire eth_mac_tx_reset;
  wire idelay_rdy_in_1;
  wire mmcm_locked_1;
  wire pcs_pma_an_interrupt;
  wire pcs_pma_ext_mdio_pcs_pma_MDC;
  wire pcs_pma_ext_mdio_pcs_pma_MDIO_I;
  wire pcs_pma_ext_mdio_pcs_pma_MDIO_O;
  wire pcs_pma_ext_mdio_pcs_pma_MDIO_T;
  wire pcs_pma_mdio_o;
  wire pcs_pma_sgmii_RXN;
  wire pcs_pma_sgmii_RXP;
  wire pcs_pma_sgmii_TXN;
  wire pcs_pma_sgmii_TXP;
  wire pcs_pma_sgmii_clk_en;
  wire [15:0]pcs_pma_status_vector;
  wire rst_125_1;
  wire [17:0]s_axi_1_ARADDR;
  wire s_axi_1_ARREADY;
  wire s_axi_1_ARVALID;
  wire [17:0]s_axi_1_AWADDR;
  wire s_axi_1_AWREADY;
  wire s_axi_1_AWVALID;
  wire s_axi_1_BREADY;
  wire [1:0]s_axi_1_BRESP;
  wire s_axi_1_BVALID;
  wire [31:0]s_axi_1_RDATA;
  wire s_axi_1_RREADY;
  wire [1:0]s_axi_1_RRESP;
  wire s_axi_1_RVALID;
  wire [31:0]s_axi_1_WDATA;
  wire s_axi_1_WREADY;
  wire [3:0]s_axi_1_WSTRB;
  wire s_axi_1_WVALID;
  wire s_axi_lite_clk_1;
  wire s_axi_lite_resetn_1;
  wire [31:0]s_axis_txc_1_TDATA;
  wire [3:0]s_axis_txc_1_TKEEP;
  wire s_axis_txc_1_TLAST;
  wire s_axis_txc_1_TREADY;
  wire s_axis_txc_1_TVALID;
  wire [31:0]s_axis_txd_1_TDATA;
  wire [3:0]s_axis_txd_1_TKEEP;
  wire s_axis_txd_1_TLAST;
  wire s_axis_txd_1_TREADY;
  wire s_axis_txd_1_TVALID;
  wire signal_detect_1;

  assign axi_rxd_arstn_1 = axi_rxd_arstn;
  assign axi_rxs_arstn_1 = axi_rxs_arstn;
  assign axi_txc_arstn_1 = axi_txc_arstn;
  assign axi_txd_arstn_1 = axi_txd_arstn;
  assign axis_clk_1 = axis_clk;
  assign clk125m_1 = clk125m;
  assign clk312_1 = clk312;
  assign clk625_1 = clk625;
  assign eth_buf_AXI_STR_RXD_TREADY = m_axis_rxd_tready;
  assign eth_buf_AXI_STR_RXS_TREADY = m_axis_rxs_tready;
  assign idelay_rdy_in_1 = idelay_rdy_in;
  assign interrupt = eth_buf_INTERRUPT;
  assign m_axis_rxd_tdata[31:0] = eth_buf_AXI_STR_RXD_TDATA;
  assign m_axis_rxd_tkeep[3:0] = eth_buf_AXI_STR_RXD_TKEEP;
  assign m_axis_rxd_tlast = eth_buf_AXI_STR_RXD_TLAST;
  assign m_axis_rxd_tvalid = eth_buf_AXI_STR_RXD_TVALID;
  assign m_axis_rxs_tdata[31:0] = eth_buf_AXI_STR_RXS_TDATA;
  assign m_axis_rxs_tkeep[3:0] = eth_buf_AXI_STR_RXS_TKEEP;
  assign m_axis_rxs_tlast = eth_buf_AXI_STR_RXS_TLAST;
  assign m_axis_rxs_tvalid = eth_buf_AXI_STR_RXS_TVALID;
  assign mac_irq = eth_mac_mac_irq;
  assign mdio_mdc = pcs_pma_ext_mdio_pcs_pma_MDC;
  assign mdio_mdio_o = pcs_pma_ext_mdio_pcs_pma_MDIO_O;
  assign mdio_mdio_t = pcs_pma_ext_mdio_pcs_pma_MDIO_T;
  assign mmcm_locked_1 = mmcm_locked;
  assign pcs_pma_ext_mdio_pcs_pma_MDIO_I = mdio_mdio_i;
  assign pcs_pma_sgmii_RXN = sgmii_rxn;
  assign pcs_pma_sgmii_RXP = sgmii_rxp;
  assign phy_rst_n = eth_buf_PHY_RST_N;
  assign rst_125_1 = rst_125;
  assign s_axi_1_ARADDR = s_axi_araddr[17:0];
  assign s_axi_1_ARVALID = s_axi_arvalid;
  assign s_axi_1_AWADDR = s_axi_awaddr[17:0];
  assign s_axi_1_AWVALID = s_axi_awvalid;
  assign s_axi_1_BREADY = s_axi_bready;
  assign s_axi_1_RREADY = s_axi_rready;
  assign s_axi_1_WDATA = s_axi_wdata[31:0];
  assign s_axi_1_WSTRB = s_axi_wstrb[3:0];
  assign s_axi_1_WVALID = s_axi_wvalid;
  assign s_axi_arready = s_axi_1_ARREADY;
  assign s_axi_awready = s_axi_1_AWREADY;
  assign s_axi_bresp[1:0] = s_axi_1_BRESP;
  assign s_axi_bvalid = s_axi_1_BVALID;
  assign s_axi_lite_clk_1 = s_axi_lite_clk;
  assign s_axi_lite_resetn_1 = s_axi_lite_resetn;
  assign s_axi_rdata[31:0] = s_axi_1_RDATA;
  assign s_axi_rresp[1:0] = s_axi_1_RRESP;
  assign s_axi_rvalid = s_axi_1_RVALID;
  assign s_axi_wready = s_axi_1_WREADY;
  assign s_axis_txc_1_TDATA = s_axis_txc_tdata[31:0];
  assign s_axis_txc_1_TKEEP = s_axis_txc_tkeep[3:0];
  assign s_axis_txc_1_TLAST = s_axis_txc_tlast;
  assign s_axis_txc_1_TVALID = s_axis_txc_tvalid;
  assign s_axis_txc_tready = s_axis_txc_1_TREADY;
  assign s_axis_txd_1_TDATA = s_axis_txd_tdata[31:0];
  assign s_axis_txd_1_TKEEP = s_axis_txd_tkeep[3:0];
  assign s_axis_txd_1_TLAST = s_axis_txd_tlast;
  assign s_axis_txd_1_TVALID = s_axis_txd_tvalid;
  assign s_axis_txd_tready = s_axis_txd_1_TREADY;
  assign sgmii_txn = pcs_pma_sgmii_TXN;
  assign sgmii_txp = pcs_pma_sgmii_TXP;
  assign signal_detect_1 = signal_detect;
  bd_4236_eth_buf_0 eth_buf
       (.AXI_STR_RXD_ACLK(axis_clk_1),
        .AXI_STR_RXD_ARESETN(axi_rxd_arstn_1),
        .AXI_STR_RXD_DATA(eth_buf_AXI_STR_RXD_TDATA),
        .AXI_STR_RXD_KEEP(eth_buf_AXI_STR_RXD_TKEEP),
        .AXI_STR_RXD_LAST(eth_buf_AXI_STR_RXD_TLAST),
        .AXI_STR_RXD_READY(eth_buf_AXI_STR_RXD_TREADY),
        .AXI_STR_RXD_VALID(eth_buf_AXI_STR_RXD_TVALID),
        .AXI_STR_RXS_ACLK(axis_clk_1),
        .AXI_STR_RXS_ARESETN(axi_rxs_arstn_1),
        .AXI_STR_RXS_DATA(eth_buf_AXI_STR_RXS_TDATA),
        .AXI_STR_RXS_KEEP(eth_buf_AXI_STR_RXS_TKEEP),
        .AXI_STR_RXS_LAST(eth_buf_AXI_STR_RXS_TLAST),
        .AXI_STR_RXS_READY(eth_buf_AXI_STR_RXS_TREADY),
        .AXI_STR_RXS_VALID(eth_buf_AXI_STR_RXS_TVALID),
        .AXI_STR_TXC_ACLK(axis_clk_1),
        .AXI_STR_TXC_ARESETN(axi_txc_arstn_1),
        .AXI_STR_TXC_TDATA(s_axis_txc_1_TDATA),
        .AXI_STR_TXC_TKEEP(s_axis_txc_1_TKEEP),
        .AXI_STR_TXC_TLAST(s_axis_txc_1_TLAST),
        .AXI_STR_TXC_TREADY(s_axis_txc_1_TREADY),
        .AXI_STR_TXC_TVALID(s_axis_txc_1_TVALID),
        .AXI_STR_TXD_ACLK(axis_clk_1),
        .AXI_STR_TXD_ARESETN(axi_txd_arstn_1),
        .AXI_STR_TXD_TDATA(s_axis_txd_1_TDATA),
        .AXI_STR_TXD_TKEEP(s_axis_txd_1_TKEEP),
        .AXI_STR_TXD_TLAST(s_axis_txd_1_TLAST),
        .AXI_STR_TXD_TREADY(s_axis_txd_1_TREADY),
        .AXI_STR_TXD_TVALID(s_axis_txd_1_TVALID),
        .EMAC_CLIENT_AUTONEG_INT(pcs_pma_an_interrupt),
        .EMAC_RESET_DONE_INT(1'b1),
        .EMAC_RX_DCM_LOCKED_INT(mmcm_locked_1),
        .GTX_CLK(clk125m_1),
        .INTERRUPT(eth_buf_INTERRUPT),
        .PCSPMA_STATUS_VECTOR(pcs_pma_status_vector),
        .PHY_RST_N(eth_buf_PHY_RST_N),
        .RESET2TEMACn(eth_buf_RESET2TEMACn),
        .RX_CLK_ENABLE_IN(pcs_pma_sgmii_clk_en),
        .S_AXI_2TEMAC_ARADDR(eth_buf_S_AXI_2TEMAC_ARADDR),
        .S_AXI_2TEMAC_ARREADY(eth_buf_S_AXI_2TEMAC_ARREADY),
        .S_AXI_2TEMAC_ARVALID(eth_buf_S_AXI_2TEMAC_ARVALID),
        .S_AXI_2TEMAC_AWADDR(eth_buf_S_AXI_2TEMAC_AWADDR),
        .S_AXI_2TEMAC_AWREADY(eth_buf_S_AXI_2TEMAC_AWREADY),
        .S_AXI_2TEMAC_AWVALID(eth_buf_S_AXI_2TEMAC_AWVALID),
        .S_AXI_2TEMAC_BREADY(eth_buf_S_AXI_2TEMAC_BREADY),
        .S_AXI_2TEMAC_BRESP(eth_buf_S_AXI_2TEMAC_BRESP),
        .S_AXI_2TEMAC_BVALID(eth_buf_S_AXI_2TEMAC_BVALID),
        .S_AXI_2TEMAC_RDATA(eth_buf_S_AXI_2TEMAC_RDATA),
        .S_AXI_2TEMAC_RREADY(eth_buf_S_AXI_2TEMAC_RREADY),
        .S_AXI_2TEMAC_RRESP(eth_buf_S_AXI_2TEMAC_RRESP),
        .S_AXI_2TEMAC_RVALID(eth_buf_S_AXI_2TEMAC_RVALID),
        .S_AXI_2TEMAC_WDATA(eth_buf_S_AXI_2TEMAC_WDATA),
        .S_AXI_2TEMAC_WREADY(eth_buf_S_AXI_2TEMAC_WREADY),
        .S_AXI_2TEMAC_WVALID(eth_buf_S_AXI_2TEMAC_WVALID),
        .S_AXI_ACLK(s_axi_lite_clk_1),
        .S_AXI_ARADDR(s_axi_1_ARADDR),
        .S_AXI_ARESETN(s_axi_lite_resetn_1),
        .S_AXI_ARREADY(s_axi_1_ARREADY),
        .S_AXI_ARVALID(s_axi_1_ARVALID),
        .S_AXI_AWADDR(s_axi_1_AWADDR),
        .S_AXI_AWREADY(s_axi_1_AWREADY),
        .S_AXI_AWVALID(s_axi_1_AWVALID),
        .S_AXI_BREADY(s_axi_1_BREADY),
        .S_AXI_BRESP(s_axi_1_BRESP),
        .S_AXI_BVALID(s_axi_1_BVALID),
        .S_AXI_RDATA(s_axi_1_RDATA),
        .S_AXI_RREADY(s_axi_1_RREADY),
        .S_AXI_RRESP(s_axi_1_RRESP),
        .S_AXI_RVALID(s_axi_1_RVALID),
        .S_AXI_WDATA(s_axi_1_WDATA),
        .S_AXI_WREADY(s_axi_1_WREADY),
        .S_AXI_WSTRB(s_axi_1_WSTRB),
        .S_AXI_WVALID(s_axi_1_WVALID),
        .mdc_temac(1'b1),
        .mdio_i_top(1'b1),
        .mdio_o_pcspma(1'b0),
        .mdio_o_temac(1'b1),
        .mdio_t_pcspma(1'b0),
        .mdio_t_temac(1'b1),
        .pause_req(eth_buf_pause_req),
        .pause_val(eth_buf_pause_val),
        .rx_axis_mac_tdata(eth_mac_m_axis_rx_TDATA),
        .rx_axis_mac_tlast(eth_mac_m_axis_rx_TLAST),
        .rx_axis_mac_tuser(eth_mac_m_axis_rx_TUSER),
        .rx_axis_mac_tvalid(eth_mac_m_axis_rx_TVALID),
        .rx_mac_aclk(eth_mac_rx_mac_aclk),
        .rx_reset(eth_mac_rx_reset),
        .rx_statistics_valid(eth_mac_rx_statistics_valid),
        .rx_statistics_vector(eth_mac_rx_statistics_vector),
        .speed_is_10_100(eth_mac_speedis10100),
        .tx_axis_mac_tdata(eth_buf_TX_AXIS_MAC_TDATA),
        .tx_axis_mac_tlast(eth_buf_TX_AXIS_MAC_TLAST),
        .tx_axis_mac_tready(eth_buf_TX_AXIS_MAC_TREADY),
        .tx_axis_mac_tuser(eth_buf_TX_AXIS_MAC_TUSER),
        .tx_axis_mac_tvalid(eth_buf_TX_AXIS_MAC_TVALID),
        .tx_ifg_delay(eth_buf_tx_ifg_delay),
        .tx_mac_aclk(eth_mac_tx_mac_aclk),
        .tx_reset(eth_mac_tx_reset));
  bd_4236_eth_mac_0 eth_mac
       (.clk_enable(pcs_pma_sgmii_clk_en),
        .glbl_rstn(eth_buf_RESET2TEMACn),
        .gmii_rx_dv(eth_mac_gmii_RX_DV),
        .gmii_rx_er(eth_mac_gmii_RX_ER),
        .gmii_rxd(eth_mac_gmii_RXD),
        .gmii_tx_en(eth_mac_gmii_TX_EN),
        .gmii_tx_er(eth_mac_gmii_TX_ER),
        .gmii_txd(eth_mac_gmii_TXD),
        .gtx_clk(clk125m_1),
        .mac_irq(eth_mac_mac_irq),
        .mdc(eth_mac_mdc),
        .mdio_i(pcs_pma_mdio_o),
        .mdio_o(eth_mac_mdio_o),
        .mdio_t(eth_mac_mdio_t),
        .pause_req(eth_buf_pause_req),
        .pause_val({eth_buf_pause_val[16],eth_buf_pause_val[17],eth_buf_pause_val[18],eth_buf_pause_val[19],eth_buf_pause_val[20],eth_buf_pause_val[21],eth_buf_pause_val[22],eth_buf_pause_val[23],eth_buf_pause_val[24],eth_buf_pause_val[25],eth_buf_pause_val[26],eth_buf_pause_val[27],eth_buf_pause_val[28],eth_buf_pause_val[29],eth_buf_pause_val[30],eth_buf_pause_val[31]}),
        .rx_axi_rstn(eth_buf_RESET2TEMACn),
        .rx_axis_mac_tdata(eth_mac_m_axis_rx_TDATA),
        .rx_axis_mac_tlast(eth_mac_m_axis_rx_TLAST),
        .rx_axis_mac_tuser(eth_mac_m_axis_rx_TUSER),
        .rx_axis_mac_tvalid(eth_mac_m_axis_rx_TVALID),
        .rx_mac_aclk(eth_mac_rx_mac_aclk),
        .rx_reset(eth_mac_rx_reset),
        .rx_statistics_valid(eth_mac_rx_statistics_valid),
        .rx_statistics_vector(eth_mac_rx_statistics_vector),
        .s_axi_aclk(s_axi_lite_clk_1),
        .s_axi_araddr(eth_buf_S_AXI_2TEMAC_ARADDR),
        .s_axi_arready(eth_buf_S_AXI_2TEMAC_ARREADY),
        .s_axi_arvalid(eth_buf_S_AXI_2TEMAC_ARVALID),
        .s_axi_awaddr(eth_buf_S_AXI_2TEMAC_AWADDR),
        .s_axi_awready(eth_buf_S_AXI_2TEMAC_AWREADY),
        .s_axi_awvalid(eth_buf_S_AXI_2TEMAC_AWVALID),
        .s_axi_bready(eth_buf_S_AXI_2TEMAC_BREADY),
        .s_axi_bresp(eth_buf_S_AXI_2TEMAC_BRESP),
        .s_axi_bvalid(eth_buf_S_AXI_2TEMAC_BVALID),
        .s_axi_rdata(eth_buf_S_AXI_2TEMAC_RDATA),
        .s_axi_resetn(s_axi_lite_resetn_1),
        .s_axi_rready(eth_buf_S_AXI_2TEMAC_RREADY),
        .s_axi_rresp(eth_buf_S_AXI_2TEMAC_RRESP),
        .s_axi_rvalid(eth_buf_S_AXI_2TEMAC_RVALID),
        .s_axi_wdata(eth_buf_S_AXI_2TEMAC_WDATA),
        .s_axi_wready(eth_buf_S_AXI_2TEMAC_WREADY),
        .s_axi_wvalid(eth_buf_S_AXI_2TEMAC_WVALID),
        .speedis100(eth_mac_speedis100),
        .speedis10100(eth_mac_speedis10100),
        .tx_axi_rstn(eth_buf_RESET2TEMACn),
        .tx_axis_mac_tdata(eth_buf_TX_AXIS_MAC_TDATA),
        .tx_axis_mac_tlast(eth_buf_TX_AXIS_MAC_TLAST),
        .tx_axis_mac_tready(eth_buf_TX_AXIS_MAC_TREADY),
        .tx_axis_mac_tuser(eth_buf_TX_AXIS_MAC_TUSER),
        .tx_axis_mac_tvalid(eth_buf_TX_AXIS_MAC_TVALID),
        .tx_ifg_delay({eth_buf_tx_ifg_delay[24],eth_buf_tx_ifg_delay[25],eth_buf_tx_ifg_delay[26],eth_buf_tx_ifg_delay[27],eth_buf_tx_ifg_delay[28],eth_buf_tx_ifg_delay[29],eth_buf_tx_ifg_delay[30],eth_buf_tx_ifg_delay[31]}),
        .tx_mac_aclk(eth_mac_tx_mac_aclk),
        .tx_reset(eth_mac_tx_reset));
  bd_4236_pcs_pma_0 pcs_pma
       (.an_adv_config_val(1'b0),
        .an_adv_config_vector({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .an_interrupt(pcs_pma_an_interrupt),
        .an_restart_config(1'b0),
        .clk125m(clk125m_1),
        .clk312(clk312_1),
        .clk625(clk625_1),
        .configuration_valid(1'b0),
        .configuration_vector({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .ext_mdc(pcs_pma_ext_mdio_pcs_pma_MDC),
        .ext_mdio_i(pcs_pma_ext_mdio_pcs_pma_MDIO_I),
        .ext_mdio_o(pcs_pma_ext_mdio_pcs_pma_MDIO_O),
        .ext_mdio_t(pcs_pma_ext_mdio_pcs_pma_MDIO_T),
        .gmii_rx_dv(eth_mac_gmii_RX_DV),
        .gmii_rx_er(eth_mac_gmii_RX_ER),
        .gmii_rxd(eth_mac_gmii_RXD),
        .gmii_tx_en(eth_mac_gmii_TX_EN),
        .gmii_tx_er(eth_mac_gmii_TX_ER),
        .gmii_txd(eth_mac_gmii_TXD),
        .idelay_rdy_in(idelay_rdy_in_1),
        .mdc(eth_mac_mdc),
        .mdio_i(eth_mac_mdio_o),
        .mdio_o(pcs_pma_mdio_o),
        .mdio_t_in(eth_mac_mdio_t),
        .mmcm_locked(mmcm_locked_1),
        .reset(rst_125_1),
        .rxn(pcs_pma_sgmii_RXN),
        .rxp(pcs_pma_sgmii_RXP),
        .sgmii_clk_en(pcs_pma_sgmii_clk_en),
        .signal_detect(signal_detect_1),
        .speed_is_100(eth_mac_speedis100),
        .speed_is_10_100(eth_mac_speedis10100),
        .status_vector(pcs_pma_status_vector),
        .txn(pcs_pma_sgmii_TXN),
        .txp(pcs_pma_sgmii_TXP));
endmodule
