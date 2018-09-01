//Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2016.1 (win64) Build 1538259 Fri Apr  8 15:45:27 MDT 2016
//Date        : Mon Feb 26 03:04:01 2018
//Host        : SHADOWFAX running 64-bit major release  (build 9200)
//Command     : generate_target system_i_bak.bd
//Design      : system_i_bak
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module m00_couplers_imp_18LXGZ
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arburst,
    M_AXI_arcache,
    M_AXI_arid,
    M_AXI_arlen,
    M_AXI_arlock,
    M_AXI_arprot,
    M_AXI_arqos,
    M_AXI_arready,
    M_AXI_arsize,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awburst,
    M_AXI_awcache,
    M_AXI_awid,
    M_AXI_awlen,
    M_AXI_awlock,
    M_AXI_awprot,
    M_AXI_awqos,
    M_AXI_awready,
    M_AXI_awsize,
    M_AXI_awvalid,
    M_AXI_bid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rid,
    M_AXI_rlast,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wlast,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arburst,
    S_AXI_arcache,
    S_AXI_arid,
    S_AXI_arlen,
    S_AXI_arlock,
    S_AXI_arprot,
    S_AXI_arqos,
    S_AXI_arready,
    S_AXI_arregion,
    S_AXI_arsize,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awburst,
    S_AXI_awcache,
    S_AXI_awid,
    S_AXI_awlen,
    S_AXI_awlock,
    S_AXI_awprot,
    S_AXI_awqos,
    S_AXI_awready,
    S_AXI_awregion,
    S_AXI_awsize,
    S_AXI_awvalid,
    S_AXI_bid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rid,
    S_AXI_rlast,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wlast,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input [0:0]M_ARESETN;
  output [30:0]M_AXI_araddr;
  output [1:0]M_AXI_arburst;
  output [3:0]M_AXI_arcache;
  output [1:0]M_AXI_arid;
  output [7:0]M_AXI_arlen;
  output [0:0]M_AXI_arlock;
  output [2:0]M_AXI_arprot;
  output [3:0]M_AXI_arqos;
  input M_AXI_arready;
  output [2:0]M_AXI_arsize;
  output M_AXI_arvalid;
  output [30:0]M_AXI_awaddr;
  output [1:0]M_AXI_awburst;
  output [3:0]M_AXI_awcache;
  output [1:0]M_AXI_awid;
  output [7:0]M_AXI_awlen;
  output [0:0]M_AXI_awlock;
  output [2:0]M_AXI_awprot;
  output [3:0]M_AXI_awqos;
  input M_AXI_awready;
  output [2:0]M_AXI_awsize;
  output M_AXI_awvalid;
  input [1:0]M_AXI_bid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [511:0]M_AXI_rdata;
  input [1:0]M_AXI_rid;
  input M_AXI_rlast;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [511:0]M_AXI_wdata;
  output M_AXI_wlast;
  input M_AXI_wready;
  output [63:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input [0:0]S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [1:0]S_AXI_arburst;
  input [3:0]S_AXI_arcache;
  input [1:0]S_AXI_arid;
  input [7:0]S_AXI_arlen;
  input [0:0]S_AXI_arlock;
  input [2:0]S_AXI_arprot;
  input [3:0]S_AXI_arqos;
  output S_AXI_arready;
  input [3:0]S_AXI_arregion;
  input [2:0]S_AXI_arsize;
  input S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  input [1:0]S_AXI_awburst;
  input [3:0]S_AXI_awcache;
  input [1:0]S_AXI_awid;
  input [7:0]S_AXI_awlen;
  input [0:0]S_AXI_awlock;
  input [2:0]S_AXI_awprot;
  input [3:0]S_AXI_awqos;
  output S_AXI_awready;
  input [3:0]S_AXI_awregion;
  input [2:0]S_AXI_awsize;
  input S_AXI_awvalid;
  output [1:0]S_AXI_bid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [511:0]S_AXI_rdata;
  output [1:0]S_AXI_rid;
  output S_AXI_rlast;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [511:0]S_AXI_wdata;
  input S_AXI_wlast;
  output S_AXI_wready;
  input [63:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire M_ACLK_1;
  wire [0:0]M_ARESETN_1;
  wire S_ACLK_1;
  wire [0:0]S_ARESETN_1;
  wire [30:0]auto_cc_to_m00_couplers_ARADDR;
  wire [1:0]auto_cc_to_m00_couplers_ARBURST;
  wire [3:0]auto_cc_to_m00_couplers_ARCACHE;
  wire [1:0]auto_cc_to_m00_couplers_ARID;
  wire [7:0]auto_cc_to_m00_couplers_ARLEN;
  wire [0:0]auto_cc_to_m00_couplers_ARLOCK;
  wire [2:0]auto_cc_to_m00_couplers_ARPROT;
  wire [3:0]auto_cc_to_m00_couplers_ARQOS;
  wire auto_cc_to_m00_couplers_ARREADY;
  wire [2:0]auto_cc_to_m00_couplers_ARSIZE;
  wire auto_cc_to_m00_couplers_ARVALID;
  wire [30:0]auto_cc_to_m00_couplers_AWADDR;
  wire [1:0]auto_cc_to_m00_couplers_AWBURST;
  wire [3:0]auto_cc_to_m00_couplers_AWCACHE;
  wire [1:0]auto_cc_to_m00_couplers_AWID;
  wire [7:0]auto_cc_to_m00_couplers_AWLEN;
  wire [0:0]auto_cc_to_m00_couplers_AWLOCK;
  wire [2:0]auto_cc_to_m00_couplers_AWPROT;
  wire [3:0]auto_cc_to_m00_couplers_AWQOS;
  wire auto_cc_to_m00_couplers_AWREADY;
  wire [2:0]auto_cc_to_m00_couplers_AWSIZE;
  wire auto_cc_to_m00_couplers_AWVALID;
  wire [1:0]auto_cc_to_m00_couplers_BID;
  wire auto_cc_to_m00_couplers_BREADY;
  wire [1:0]auto_cc_to_m00_couplers_BRESP;
  wire auto_cc_to_m00_couplers_BVALID;
  wire [511:0]auto_cc_to_m00_couplers_RDATA;
  wire [1:0]auto_cc_to_m00_couplers_RID;
  wire auto_cc_to_m00_couplers_RLAST;
  wire auto_cc_to_m00_couplers_RREADY;
  wire [1:0]auto_cc_to_m00_couplers_RRESP;
  wire auto_cc_to_m00_couplers_RVALID;
  wire [511:0]auto_cc_to_m00_couplers_WDATA;
  wire auto_cc_to_m00_couplers_WLAST;
  wire auto_cc_to_m00_couplers_WREADY;
  wire [63:0]auto_cc_to_m00_couplers_WSTRB;
  wire auto_cc_to_m00_couplers_WVALID;
  wire [31:0]m00_couplers_to_auto_cc_ARADDR;
  wire [1:0]m00_couplers_to_auto_cc_ARBURST;
  wire [3:0]m00_couplers_to_auto_cc_ARCACHE;
  wire [1:0]m00_couplers_to_auto_cc_ARID;
  wire [7:0]m00_couplers_to_auto_cc_ARLEN;
  wire [0:0]m00_couplers_to_auto_cc_ARLOCK;
  wire [2:0]m00_couplers_to_auto_cc_ARPROT;
  wire [3:0]m00_couplers_to_auto_cc_ARQOS;
  wire m00_couplers_to_auto_cc_ARREADY;
  wire [3:0]m00_couplers_to_auto_cc_ARREGION;
  wire [2:0]m00_couplers_to_auto_cc_ARSIZE;
  wire m00_couplers_to_auto_cc_ARVALID;
  wire [31:0]m00_couplers_to_auto_cc_AWADDR;
  wire [1:0]m00_couplers_to_auto_cc_AWBURST;
  wire [3:0]m00_couplers_to_auto_cc_AWCACHE;
  wire [1:0]m00_couplers_to_auto_cc_AWID;
  wire [7:0]m00_couplers_to_auto_cc_AWLEN;
  wire [0:0]m00_couplers_to_auto_cc_AWLOCK;
  wire [2:0]m00_couplers_to_auto_cc_AWPROT;
  wire [3:0]m00_couplers_to_auto_cc_AWQOS;
  wire m00_couplers_to_auto_cc_AWREADY;
  wire [3:0]m00_couplers_to_auto_cc_AWREGION;
  wire [2:0]m00_couplers_to_auto_cc_AWSIZE;
  wire m00_couplers_to_auto_cc_AWVALID;
  wire [1:0]m00_couplers_to_auto_cc_BID;
  wire m00_couplers_to_auto_cc_BREADY;
  wire [1:0]m00_couplers_to_auto_cc_BRESP;
  wire m00_couplers_to_auto_cc_BVALID;
  wire [511:0]m00_couplers_to_auto_cc_RDATA;
  wire [1:0]m00_couplers_to_auto_cc_RID;
  wire m00_couplers_to_auto_cc_RLAST;
  wire m00_couplers_to_auto_cc_RREADY;
  wire [1:0]m00_couplers_to_auto_cc_RRESP;
  wire m00_couplers_to_auto_cc_RVALID;
  wire [511:0]m00_couplers_to_auto_cc_WDATA;
  wire m00_couplers_to_auto_cc_WLAST;
  wire m00_couplers_to_auto_cc_WREADY;
  wire [63:0]m00_couplers_to_auto_cc_WSTRB;
  wire m00_couplers_to_auto_cc_WVALID;

  assign M_ACLK_1 = M_ACLK;
  assign M_ARESETN_1 = M_ARESETN[0];
  assign M_AXI_araddr[30:0] = auto_cc_to_m00_couplers_ARADDR;
  assign M_AXI_arburst[1:0] = auto_cc_to_m00_couplers_ARBURST;
  assign M_AXI_arcache[3:0] = auto_cc_to_m00_couplers_ARCACHE;
  assign M_AXI_arid[1:0] = auto_cc_to_m00_couplers_ARID;
  assign M_AXI_arlen[7:0] = auto_cc_to_m00_couplers_ARLEN;
  assign M_AXI_arlock[0] = auto_cc_to_m00_couplers_ARLOCK;
  assign M_AXI_arprot[2:0] = auto_cc_to_m00_couplers_ARPROT;
  assign M_AXI_arqos[3:0] = auto_cc_to_m00_couplers_ARQOS;
  assign M_AXI_arsize[2:0] = auto_cc_to_m00_couplers_ARSIZE;
  assign M_AXI_arvalid = auto_cc_to_m00_couplers_ARVALID;
  assign M_AXI_awaddr[30:0] = auto_cc_to_m00_couplers_AWADDR;
  assign M_AXI_awburst[1:0] = auto_cc_to_m00_couplers_AWBURST;
  assign M_AXI_awcache[3:0] = auto_cc_to_m00_couplers_AWCACHE;
  assign M_AXI_awid[1:0] = auto_cc_to_m00_couplers_AWID;
  assign M_AXI_awlen[7:0] = auto_cc_to_m00_couplers_AWLEN;
  assign M_AXI_awlock[0] = auto_cc_to_m00_couplers_AWLOCK;
  assign M_AXI_awprot[2:0] = auto_cc_to_m00_couplers_AWPROT;
  assign M_AXI_awqos[3:0] = auto_cc_to_m00_couplers_AWQOS;
  assign M_AXI_awsize[2:0] = auto_cc_to_m00_couplers_AWSIZE;
  assign M_AXI_awvalid = auto_cc_to_m00_couplers_AWVALID;
  assign M_AXI_bready = auto_cc_to_m00_couplers_BREADY;
  assign M_AXI_rready = auto_cc_to_m00_couplers_RREADY;
  assign M_AXI_wdata[511:0] = auto_cc_to_m00_couplers_WDATA;
  assign M_AXI_wlast = auto_cc_to_m00_couplers_WLAST;
  assign M_AXI_wstrb[63:0] = auto_cc_to_m00_couplers_WSTRB;
  assign M_AXI_wvalid = auto_cc_to_m00_couplers_WVALID;
  assign S_ACLK_1 = S_ACLK;
  assign S_ARESETN_1 = S_ARESETN[0];
  assign S_AXI_arready = m00_couplers_to_auto_cc_ARREADY;
  assign S_AXI_awready = m00_couplers_to_auto_cc_AWREADY;
  assign S_AXI_bid[1:0] = m00_couplers_to_auto_cc_BID;
  assign S_AXI_bresp[1:0] = m00_couplers_to_auto_cc_BRESP;
  assign S_AXI_bvalid = m00_couplers_to_auto_cc_BVALID;
  assign S_AXI_rdata[511:0] = m00_couplers_to_auto_cc_RDATA;
  assign S_AXI_rid[1:0] = m00_couplers_to_auto_cc_RID;
  assign S_AXI_rlast = m00_couplers_to_auto_cc_RLAST;
  assign S_AXI_rresp[1:0] = m00_couplers_to_auto_cc_RRESP;
  assign S_AXI_rvalid = m00_couplers_to_auto_cc_RVALID;
  assign S_AXI_wready = m00_couplers_to_auto_cc_WREADY;
  assign auto_cc_to_m00_couplers_ARREADY = M_AXI_arready;
  assign auto_cc_to_m00_couplers_AWREADY = M_AXI_awready;
  assign auto_cc_to_m00_couplers_BID = M_AXI_bid[1:0];
  assign auto_cc_to_m00_couplers_BRESP = M_AXI_bresp[1:0];
  assign auto_cc_to_m00_couplers_BVALID = M_AXI_bvalid;
  assign auto_cc_to_m00_couplers_RDATA = M_AXI_rdata[511:0];
  assign auto_cc_to_m00_couplers_RID = M_AXI_rid[1:0];
  assign auto_cc_to_m00_couplers_RLAST = M_AXI_rlast;
  assign auto_cc_to_m00_couplers_RRESP = M_AXI_rresp[1:0];
  assign auto_cc_to_m00_couplers_RVALID = M_AXI_rvalid;
  assign auto_cc_to_m00_couplers_WREADY = M_AXI_wready;
  assign m00_couplers_to_auto_cc_ARADDR = S_AXI_araddr[31:0];
  assign m00_couplers_to_auto_cc_ARBURST = S_AXI_arburst[1:0];
  assign m00_couplers_to_auto_cc_ARCACHE = S_AXI_arcache[3:0];
  assign m00_couplers_to_auto_cc_ARID = S_AXI_arid[1:0];
  assign m00_couplers_to_auto_cc_ARLEN = S_AXI_arlen[7:0];
  assign m00_couplers_to_auto_cc_ARLOCK = S_AXI_arlock[0];
  assign m00_couplers_to_auto_cc_ARPROT = S_AXI_arprot[2:0];
  assign m00_couplers_to_auto_cc_ARQOS = S_AXI_arqos[3:0];
  assign m00_couplers_to_auto_cc_ARREGION = S_AXI_arregion[3:0];
  assign m00_couplers_to_auto_cc_ARSIZE = S_AXI_arsize[2:0];
  assign m00_couplers_to_auto_cc_ARVALID = S_AXI_arvalid;
  assign m00_couplers_to_auto_cc_AWADDR = S_AXI_awaddr[31:0];
  assign m00_couplers_to_auto_cc_AWBURST = S_AXI_awburst[1:0];
  assign m00_couplers_to_auto_cc_AWCACHE = S_AXI_awcache[3:0];
  assign m00_couplers_to_auto_cc_AWID = S_AXI_awid[1:0];
  assign m00_couplers_to_auto_cc_AWLEN = S_AXI_awlen[7:0];
  assign m00_couplers_to_auto_cc_AWLOCK = S_AXI_awlock[0];
  assign m00_couplers_to_auto_cc_AWPROT = S_AXI_awprot[2:0];
  assign m00_couplers_to_auto_cc_AWQOS = S_AXI_awqos[3:0];
  assign m00_couplers_to_auto_cc_AWREGION = S_AXI_awregion[3:0];
  assign m00_couplers_to_auto_cc_AWSIZE = S_AXI_awsize[2:0];
  assign m00_couplers_to_auto_cc_AWVALID = S_AXI_awvalid;
  assign m00_couplers_to_auto_cc_BREADY = S_AXI_bready;
  assign m00_couplers_to_auto_cc_RREADY = S_AXI_rready;
  assign m00_couplers_to_auto_cc_WDATA = S_AXI_wdata[511:0];
  assign m00_couplers_to_auto_cc_WLAST = S_AXI_wlast;
  assign m00_couplers_to_auto_cc_WSTRB = S_AXI_wstrb[63:0];
  assign m00_couplers_to_auto_cc_WVALID = S_AXI_wvalid;
  system_i_bak_auto_cc_0 auto_cc
       (.m_axi_aclk(M_ACLK_1),
        .m_axi_araddr(auto_cc_to_m00_couplers_ARADDR),
        .m_axi_arburst(auto_cc_to_m00_couplers_ARBURST),
        .m_axi_arcache(auto_cc_to_m00_couplers_ARCACHE),
        .m_axi_aresetn(M_ARESETN_1),
        .m_axi_arid(auto_cc_to_m00_couplers_ARID),
        .m_axi_arlen(auto_cc_to_m00_couplers_ARLEN),
        .m_axi_arlock(auto_cc_to_m00_couplers_ARLOCK),
        .m_axi_arprot(auto_cc_to_m00_couplers_ARPROT),
        .m_axi_arqos(auto_cc_to_m00_couplers_ARQOS),
        .m_axi_arready(auto_cc_to_m00_couplers_ARREADY),
        .m_axi_arsize(auto_cc_to_m00_couplers_ARSIZE),
        .m_axi_arvalid(auto_cc_to_m00_couplers_ARVALID),
        .m_axi_awaddr(auto_cc_to_m00_couplers_AWADDR),
        .m_axi_awburst(auto_cc_to_m00_couplers_AWBURST),
        .m_axi_awcache(auto_cc_to_m00_couplers_AWCACHE),
        .m_axi_awid(auto_cc_to_m00_couplers_AWID),
        .m_axi_awlen(auto_cc_to_m00_couplers_AWLEN),
        .m_axi_awlock(auto_cc_to_m00_couplers_AWLOCK),
        .m_axi_awprot(auto_cc_to_m00_couplers_AWPROT),
        .m_axi_awqos(auto_cc_to_m00_couplers_AWQOS),
        .m_axi_awready(auto_cc_to_m00_couplers_AWREADY),
        .m_axi_awsize(auto_cc_to_m00_couplers_AWSIZE),
        .m_axi_awvalid(auto_cc_to_m00_couplers_AWVALID),
        .m_axi_bid(auto_cc_to_m00_couplers_BID),
        .m_axi_bready(auto_cc_to_m00_couplers_BREADY),
        .m_axi_bresp(auto_cc_to_m00_couplers_BRESP),
        .m_axi_bvalid(auto_cc_to_m00_couplers_BVALID),
        .m_axi_rdata(auto_cc_to_m00_couplers_RDATA),
        .m_axi_rid(auto_cc_to_m00_couplers_RID),
        .m_axi_rlast(auto_cc_to_m00_couplers_RLAST),
        .m_axi_rready(auto_cc_to_m00_couplers_RREADY),
        .m_axi_rresp(auto_cc_to_m00_couplers_RRESP),
        .m_axi_rvalid(auto_cc_to_m00_couplers_RVALID),
        .m_axi_wdata(auto_cc_to_m00_couplers_WDATA),
        .m_axi_wlast(auto_cc_to_m00_couplers_WLAST),
        .m_axi_wready(auto_cc_to_m00_couplers_WREADY),
        .m_axi_wstrb(auto_cc_to_m00_couplers_WSTRB),
        .m_axi_wvalid(auto_cc_to_m00_couplers_WVALID),
        .s_axi_aclk(S_ACLK_1),
        .s_axi_araddr(m00_couplers_to_auto_cc_ARADDR[30:0]),
        .s_axi_arburst(m00_couplers_to_auto_cc_ARBURST),
        .s_axi_arcache(m00_couplers_to_auto_cc_ARCACHE),
        .s_axi_aresetn(S_ARESETN_1),
        .s_axi_arid(m00_couplers_to_auto_cc_ARID),
        .s_axi_arlen(m00_couplers_to_auto_cc_ARLEN),
        .s_axi_arlock(m00_couplers_to_auto_cc_ARLOCK),
        .s_axi_arprot(m00_couplers_to_auto_cc_ARPROT),
        .s_axi_arqos(m00_couplers_to_auto_cc_ARQOS),
        .s_axi_arready(m00_couplers_to_auto_cc_ARREADY),
        .s_axi_arregion(m00_couplers_to_auto_cc_ARREGION),
        .s_axi_arsize(m00_couplers_to_auto_cc_ARSIZE),
        .s_axi_arvalid(m00_couplers_to_auto_cc_ARVALID),
        .s_axi_awaddr(m00_couplers_to_auto_cc_AWADDR[30:0]),
        .s_axi_awburst(m00_couplers_to_auto_cc_AWBURST),
        .s_axi_awcache(m00_couplers_to_auto_cc_AWCACHE),
        .s_axi_awid(m00_couplers_to_auto_cc_AWID),
        .s_axi_awlen(m00_couplers_to_auto_cc_AWLEN),
        .s_axi_awlock(m00_couplers_to_auto_cc_AWLOCK),
        .s_axi_awprot(m00_couplers_to_auto_cc_AWPROT),
        .s_axi_awqos(m00_couplers_to_auto_cc_AWQOS),
        .s_axi_awready(m00_couplers_to_auto_cc_AWREADY),
        .s_axi_awregion(m00_couplers_to_auto_cc_AWREGION),
        .s_axi_awsize(m00_couplers_to_auto_cc_AWSIZE),
        .s_axi_awvalid(m00_couplers_to_auto_cc_AWVALID),
        .s_axi_bid(m00_couplers_to_auto_cc_BID),
        .s_axi_bready(m00_couplers_to_auto_cc_BREADY),
        .s_axi_bresp(m00_couplers_to_auto_cc_BRESP),
        .s_axi_bvalid(m00_couplers_to_auto_cc_BVALID),
        .s_axi_rdata(m00_couplers_to_auto_cc_RDATA),
        .s_axi_rid(m00_couplers_to_auto_cc_RID),
        .s_axi_rlast(m00_couplers_to_auto_cc_RLAST),
        .s_axi_rready(m00_couplers_to_auto_cc_RREADY),
        .s_axi_rresp(m00_couplers_to_auto_cc_RRESP),
        .s_axi_rvalid(m00_couplers_to_auto_cc_RVALID),
        .s_axi_wdata(m00_couplers_to_auto_cc_WDATA),
        .s_axi_wlast(m00_couplers_to_auto_cc_WLAST),
        .s_axi_wready(m00_couplers_to_auto_cc_WREADY),
        .s_axi_wstrb(m00_couplers_to_auto_cc_WSTRB),
        .s_axi_wvalid(m00_couplers_to_auto_cc_WVALID));
endmodule

module m00_couplers_imp_WL3GAE
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arburst,
    S_AXI_arcache,
    S_AXI_arlen,
    S_AXI_arlock,
    S_AXI_arprot,
    S_AXI_arqos,
    S_AXI_arready,
    S_AXI_arregion,
    S_AXI_arsize,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awburst,
    S_AXI_awcache,
    S_AXI_awlen,
    S_AXI_awlock,
    S_AXI_awprot,
    S_AXI_awqos,
    S_AXI_awready,
    S_AXI_awregion,
    S_AXI_awsize,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rlast,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wlast,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input [0:0]M_ARESETN;
  output [31:0]M_AXI_araddr;
  input M_AXI_arready;
  output M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  input M_AXI_awready;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  input M_AXI_wready;
  output [3:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input [0:0]S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [1:0]S_AXI_arburst;
  input [3:0]S_AXI_arcache;
  input [7:0]S_AXI_arlen;
  input [0:0]S_AXI_arlock;
  input [2:0]S_AXI_arprot;
  input [3:0]S_AXI_arqos;
  output S_AXI_arready;
  input [3:0]S_AXI_arregion;
  input [2:0]S_AXI_arsize;
  input S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  input [1:0]S_AXI_awburst;
  input [3:0]S_AXI_awcache;
  input [7:0]S_AXI_awlen;
  input [0:0]S_AXI_awlock;
  input [2:0]S_AXI_awprot;
  input [3:0]S_AXI_awqos;
  output S_AXI_awready;
  input [3:0]S_AXI_awregion;
  input [2:0]S_AXI_awsize;
  input S_AXI_awvalid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [511:0]S_AXI_rdata;
  output S_AXI_rlast;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [511:0]S_AXI_wdata;
  input S_AXI_wlast;
  output S_AXI_wready;
  input [63:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire S_ACLK_1;
  wire [0:0]S_ARESETN_1;
  wire [31:0]auto_ds_to_auto_pc_ARADDR;
  wire [1:0]auto_ds_to_auto_pc_ARBURST;
  wire [3:0]auto_ds_to_auto_pc_ARCACHE;
  wire [7:0]auto_ds_to_auto_pc_ARLEN;
  wire [0:0]auto_ds_to_auto_pc_ARLOCK;
  wire [2:0]auto_ds_to_auto_pc_ARPROT;
  wire [3:0]auto_ds_to_auto_pc_ARQOS;
  wire auto_ds_to_auto_pc_ARREADY;
  wire [3:0]auto_ds_to_auto_pc_ARREGION;
  wire [2:0]auto_ds_to_auto_pc_ARSIZE;
  wire auto_ds_to_auto_pc_ARVALID;
  wire [31:0]auto_ds_to_auto_pc_AWADDR;
  wire [1:0]auto_ds_to_auto_pc_AWBURST;
  wire [3:0]auto_ds_to_auto_pc_AWCACHE;
  wire [7:0]auto_ds_to_auto_pc_AWLEN;
  wire [0:0]auto_ds_to_auto_pc_AWLOCK;
  wire [2:0]auto_ds_to_auto_pc_AWPROT;
  wire [3:0]auto_ds_to_auto_pc_AWQOS;
  wire auto_ds_to_auto_pc_AWREADY;
  wire [3:0]auto_ds_to_auto_pc_AWREGION;
  wire [2:0]auto_ds_to_auto_pc_AWSIZE;
  wire auto_ds_to_auto_pc_AWVALID;
  wire auto_ds_to_auto_pc_BREADY;
  wire [1:0]auto_ds_to_auto_pc_BRESP;
  wire auto_ds_to_auto_pc_BVALID;
  wire [31:0]auto_ds_to_auto_pc_RDATA;
  wire auto_ds_to_auto_pc_RLAST;
  wire auto_ds_to_auto_pc_RREADY;
  wire [1:0]auto_ds_to_auto_pc_RRESP;
  wire auto_ds_to_auto_pc_RVALID;
  wire [31:0]auto_ds_to_auto_pc_WDATA;
  wire auto_ds_to_auto_pc_WLAST;
  wire auto_ds_to_auto_pc_WREADY;
  wire [3:0]auto_ds_to_auto_pc_WSTRB;
  wire auto_ds_to_auto_pc_WVALID;
  wire [31:0]auto_pc_to_m00_couplers_ARADDR;
  wire auto_pc_to_m00_couplers_ARREADY;
  wire auto_pc_to_m00_couplers_ARVALID;
  wire [31:0]auto_pc_to_m00_couplers_AWADDR;
  wire auto_pc_to_m00_couplers_AWREADY;
  wire auto_pc_to_m00_couplers_AWVALID;
  wire auto_pc_to_m00_couplers_BREADY;
  wire [1:0]auto_pc_to_m00_couplers_BRESP;
  wire auto_pc_to_m00_couplers_BVALID;
  wire [31:0]auto_pc_to_m00_couplers_RDATA;
  wire auto_pc_to_m00_couplers_RREADY;
  wire [1:0]auto_pc_to_m00_couplers_RRESP;
  wire auto_pc_to_m00_couplers_RVALID;
  wire [31:0]auto_pc_to_m00_couplers_WDATA;
  wire auto_pc_to_m00_couplers_WREADY;
  wire [3:0]auto_pc_to_m00_couplers_WSTRB;
  wire auto_pc_to_m00_couplers_WVALID;
  wire [31:0]m00_couplers_to_auto_ds_ARADDR;
  wire [1:0]m00_couplers_to_auto_ds_ARBURST;
  wire [3:0]m00_couplers_to_auto_ds_ARCACHE;
  wire [7:0]m00_couplers_to_auto_ds_ARLEN;
  wire [0:0]m00_couplers_to_auto_ds_ARLOCK;
  wire [2:0]m00_couplers_to_auto_ds_ARPROT;
  wire [3:0]m00_couplers_to_auto_ds_ARQOS;
  wire m00_couplers_to_auto_ds_ARREADY;
  wire [3:0]m00_couplers_to_auto_ds_ARREGION;
  wire [2:0]m00_couplers_to_auto_ds_ARSIZE;
  wire m00_couplers_to_auto_ds_ARVALID;
  wire [31:0]m00_couplers_to_auto_ds_AWADDR;
  wire [1:0]m00_couplers_to_auto_ds_AWBURST;
  wire [3:0]m00_couplers_to_auto_ds_AWCACHE;
  wire [7:0]m00_couplers_to_auto_ds_AWLEN;
  wire [0:0]m00_couplers_to_auto_ds_AWLOCK;
  wire [2:0]m00_couplers_to_auto_ds_AWPROT;
  wire [3:0]m00_couplers_to_auto_ds_AWQOS;
  wire m00_couplers_to_auto_ds_AWREADY;
  wire [3:0]m00_couplers_to_auto_ds_AWREGION;
  wire [2:0]m00_couplers_to_auto_ds_AWSIZE;
  wire m00_couplers_to_auto_ds_AWVALID;
  wire m00_couplers_to_auto_ds_BREADY;
  wire [1:0]m00_couplers_to_auto_ds_BRESP;
  wire m00_couplers_to_auto_ds_BVALID;
  wire [511:0]m00_couplers_to_auto_ds_RDATA;
  wire m00_couplers_to_auto_ds_RLAST;
  wire m00_couplers_to_auto_ds_RREADY;
  wire [1:0]m00_couplers_to_auto_ds_RRESP;
  wire m00_couplers_to_auto_ds_RVALID;
  wire [511:0]m00_couplers_to_auto_ds_WDATA;
  wire m00_couplers_to_auto_ds_WLAST;
  wire m00_couplers_to_auto_ds_WREADY;
  wire [63:0]m00_couplers_to_auto_ds_WSTRB;
  wire m00_couplers_to_auto_ds_WVALID;

  assign M_AXI_araddr[31:0] = auto_pc_to_m00_couplers_ARADDR;
  assign M_AXI_arvalid = auto_pc_to_m00_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = auto_pc_to_m00_couplers_AWADDR;
  assign M_AXI_awvalid = auto_pc_to_m00_couplers_AWVALID;
  assign M_AXI_bready = auto_pc_to_m00_couplers_BREADY;
  assign M_AXI_rready = auto_pc_to_m00_couplers_RREADY;
  assign M_AXI_wdata[31:0] = auto_pc_to_m00_couplers_WDATA;
  assign M_AXI_wstrb[3:0] = auto_pc_to_m00_couplers_WSTRB;
  assign M_AXI_wvalid = auto_pc_to_m00_couplers_WVALID;
  assign S_ACLK_1 = S_ACLK;
  assign S_ARESETN_1 = S_ARESETN[0];
  assign S_AXI_arready = m00_couplers_to_auto_ds_ARREADY;
  assign S_AXI_awready = m00_couplers_to_auto_ds_AWREADY;
  assign S_AXI_bresp[1:0] = m00_couplers_to_auto_ds_BRESP;
  assign S_AXI_bvalid = m00_couplers_to_auto_ds_BVALID;
  assign S_AXI_rdata[511:0] = m00_couplers_to_auto_ds_RDATA;
  assign S_AXI_rlast = m00_couplers_to_auto_ds_RLAST;
  assign S_AXI_rresp[1:0] = m00_couplers_to_auto_ds_RRESP;
  assign S_AXI_rvalid = m00_couplers_to_auto_ds_RVALID;
  assign S_AXI_wready = m00_couplers_to_auto_ds_WREADY;
  assign auto_pc_to_m00_couplers_ARREADY = M_AXI_arready;
  assign auto_pc_to_m00_couplers_AWREADY = M_AXI_awready;
  assign auto_pc_to_m00_couplers_BRESP = M_AXI_bresp[1:0];
  assign auto_pc_to_m00_couplers_BVALID = M_AXI_bvalid;
  assign auto_pc_to_m00_couplers_RDATA = M_AXI_rdata[31:0];
  assign auto_pc_to_m00_couplers_RRESP = M_AXI_rresp[1:0];
  assign auto_pc_to_m00_couplers_RVALID = M_AXI_rvalid;
  assign auto_pc_to_m00_couplers_WREADY = M_AXI_wready;
  assign m00_couplers_to_auto_ds_ARADDR = S_AXI_araddr[31:0];
  assign m00_couplers_to_auto_ds_ARBURST = S_AXI_arburst[1:0];
  assign m00_couplers_to_auto_ds_ARCACHE = S_AXI_arcache[3:0];
  assign m00_couplers_to_auto_ds_ARLEN = S_AXI_arlen[7:0];
  assign m00_couplers_to_auto_ds_ARLOCK = S_AXI_arlock[0];
  assign m00_couplers_to_auto_ds_ARPROT = S_AXI_arprot[2:0];
  assign m00_couplers_to_auto_ds_ARQOS = S_AXI_arqos[3:0];
  assign m00_couplers_to_auto_ds_ARREGION = S_AXI_arregion[3:0];
  assign m00_couplers_to_auto_ds_ARSIZE = S_AXI_arsize[2:0];
  assign m00_couplers_to_auto_ds_ARVALID = S_AXI_arvalid;
  assign m00_couplers_to_auto_ds_AWADDR = S_AXI_awaddr[31:0];
  assign m00_couplers_to_auto_ds_AWBURST = S_AXI_awburst[1:0];
  assign m00_couplers_to_auto_ds_AWCACHE = S_AXI_awcache[3:0];
  assign m00_couplers_to_auto_ds_AWLEN = S_AXI_awlen[7:0];
  assign m00_couplers_to_auto_ds_AWLOCK = S_AXI_awlock[0];
  assign m00_couplers_to_auto_ds_AWPROT = S_AXI_awprot[2:0];
  assign m00_couplers_to_auto_ds_AWQOS = S_AXI_awqos[3:0];
  assign m00_couplers_to_auto_ds_AWREGION = S_AXI_awregion[3:0];
  assign m00_couplers_to_auto_ds_AWSIZE = S_AXI_awsize[2:0];
  assign m00_couplers_to_auto_ds_AWVALID = S_AXI_awvalid;
  assign m00_couplers_to_auto_ds_BREADY = S_AXI_bready;
  assign m00_couplers_to_auto_ds_RREADY = S_AXI_rready;
  assign m00_couplers_to_auto_ds_WDATA = S_AXI_wdata[511:0];
  assign m00_couplers_to_auto_ds_WLAST = S_AXI_wlast;
  assign m00_couplers_to_auto_ds_WSTRB = S_AXI_wstrb[63:0];
  assign m00_couplers_to_auto_ds_WVALID = S_AXI_wvalid;
  system_i_bak_auto_ds_0 auto_ds
       (.m_axi_araddr(auto_ds_to_auto_pc_ARADDR),
        .m_axi_arburst(auto_ds_to_auto_pc_ARBURST),
        .m_axi_arcache(auto_ds_to_auto_pc_ARCACHE),
        .m_axi_arlen(auto_ds_to_auto_pc_ARLEN),
        .m_axi_arlock(auto_ds_to_auto_pc_ARLOCK),
        .m_axi_arprot(auto_ds_to_auto_pc_ARPROT),
        .m_axi_arqos(auto_ds_to_auto_pc_ARQOS),
        .m_axi_arready(auto_ds_to_auto_pc_ARREADY),
        .m_axi_arregion(auto_ds_to_auto_pc_ARREGION),
        .m_axi_arsize(auto_ds_to_auto_pc_ARSIZE),
        .m_axi_arvalid(auto_ds_to_auto_pc_ARVALID),
        .m_axi_awaddr(auto_ds_to_auto_pc_AWADDR),
        .m_axi_awburst(auto_ds_to_auto_pc_AWBURST),
        .m_axi_awcache(auto_ds_to_auto_pc_AWCACHE),
        .m_axi_awlen(auto_ds_to_auto_pc_AWLEN),
        .m_axi_awlock(auto_ds_to_auto_pc_AWLOCK),
        .m_axi_awprot(auto_ds_to_auto_pc_AWPROT),
        .m_axi_awqos(auto_ds_to_auto_pc_AWQOS),
        .m_axi_awready(auto_ds_to_auto_pc_AWREADY),
        .m_axi_awregion(auto_ds_to_auto_pc_AWREGION),
        .m_axi_awsize(auto_ds_to_auto_pc_AWSIZE),
        .m_axi_awvalid(auto_ds_to_auto_pc_AWVALID),
        .m_axi_bready(auto_ds_to_auto_pc_BREADY),
        .m_axi_bresp(auto_ds_to_auto_pc_BRESP),
        .m_axi_bvalid(auto_ds_to_auto_pc_BVALID),
        .m_axi_rdata(auto_ds_to_auto_pc_RDATA),
        .m_axi_rlast(auto_ds_to_auto_pc_RLAST),
        .m_axi_rready(auto_ds_to_auto_pc_RREADY),
        .m_axi_rresp(auto_ds_to_auto_pc_RRESP),
        .m_axi_rvalid(auto_ds_to_auto_pc_RVALID),
        .m_axi_wdata(auto_ds_to_auto_pc_WDATA),
        .m_axi_wlast(auto_ds_to_auto_pc_WLAST),
        .m_axi_wready(auto_ds_to_auto_pc_WREADY),
        .m_axi_wstrb(auto_ds_to_auto_pc_WSTRB),
        .m_axi_wvalid(auto_ds_to_auto_pc_WVALID),
        .s_axi_aclk(S_ACLK_1),
        .s_axi_araddr(m00_couplers_to_auto_ds_ARADDR),
        .s_axi_arburst(m00_couplers_to_auto_ds_ARBURST),
        .s_axi_arcache(m00_couplers_to_auto_ds_ARCACHE),
        .s_axi_aresetn(S_ARESETN_1),
        .s_axi_arlen(m00_couplers_to_auto_ds_ARLEN),
        .s_axi_arlock(m00_couplers_to_auto_ds_ARLOCK),
        .s_axi_arprot(m00_couplers_to_auto_ds_ARPROT),
        .s_axi_arqos(m00_couplers_to_auto_ds_ARQOS),
        .s_axi_arready(m00_couplers_to_auto_ds_ARREADY),
        .s_axi_arregion(m00_couplers_to_auto_ds_ARREGION),
        .s_axi_arsize(m00_couplers_to_auto_ds_ARSIZE),
        .s_axi_arvalid(m00_couplers_to_auto_ds_ARVALID),
        .s_axi_awaddr(m00_couplers_to_auto_ds_AWADDR),
        .s_axi_awburst(m00_couplers_to_auto_ds_AWBURST),
        .s_axi_awcache(m00_couplers_to_auto_ds_AWCACHE),
        .s_axi_awlen(m00_couplers_to_auto_ds_AWLEN),
        .s_axi_awlock(m00_couplers_to_auto_ds_AWLOCK),
        .s_axi_awprot(m00_couplers_to_auto_ds_AWPROT),
        .s_axi_awqos(m00_couplers_to_auto_ds_AWQOS),
        .s_axi_awready(m00_couplers_to_auto_ds_AWREADY),
        .s_axi_awregion(m00_couplers_to_auto_ds_AWREGION),
        .s_axi_awsize(m00_couplers_to_auto_ds_AWSIZE),
        .s_axi_awvalid(m00_couplers_to_auto_ds_AWVALID),
        .s_axi_bready(m00_couplers_to_auto_ds_BREADY),
        .s_axi_bresp(m00_couplers_to_auto_ds_BRESP),
        .s_axi_bvalid(m00_couplers_to_auto_ds_BVALID),
        .s_axi_rdata(m00_couplers_to_auto_ds_RDATA),
        .s_axi_rlast(m00_couplers_to_auto_ds_RLAST),
        .s_axi_rready(m00_couplers_to_auto_ds_RREADY),
        .s_axi_rresp(m00_couplers_to_auto_ds_RRESP),
        .s_axi_rvalid(m00_couplers_to_auto_ds_RVALID),
        .s_axi_wdata(m00_couplers_to_auto_ds_WDATA),
        .s_axi_wlast(m00_couplers_to_auto_ds_WLAST),
        .s_axi_wready(m00_couplers_to_auto_ds_WREADY),
        .s_axi_wstrb(m00_couplers_to_auto_ds_WSTRB),
        .s_axi_wvalid(m00_couplers_to_auto_ds_WVALID));
  system_i_bak_auto_pc_0 auto_pc
       (.aclk(S_ACLK_1),
        .aresetn(S_ARESETN_1),
        .m_axi_araddr(auto_pc_to_m00_couplers_ARADDR),
        .m_axi_arready(auto_pc_to_m00_couplers_ARREADY),
        .m_axi_arvalid(auto_pc_to_m00_couplers_ARVALID),
        .m_axi_awaddr(auto_pc_to_m00_couplers_AWADDR),
        .m_axi_awready(auto_pc_to_m00_couplers_AWREADY),
        .m_axi_awvalid(auto_pc_to_m00_couplers_AWVALID),
        .m_axi_bready(auto_pc_to_m00_couplers_BREADY),
        .m_axi_bresp(auto_pc_to_m00_couplers_BRESP),
        .m_axi_bvalid(auto_pc_to_m00_couplers_BVALID),
        .m_axi_rdata(auto_pc_to_m00_couplers_RDATA),
        .m_axi_rready(auto_pc_to_m00_couplers_RREADY),
        .m_axi_rresp(auto_pc_to_m00_couplers_RRESP),
        .m_axi_rvalid(auto_pc_to_m00_couplers_RVALID),
        .m_axi_wdata(auto_pc_to_m00_couplers_WDATA),
        .m_axi_wready(auto_pc_to_m00_couplers_WREADY),
        .m_axi_wstrb(auto_pc_to_m00_couplers_WSTRB),
        .m_axi_wvalid(auto_pc_to_m00_couplers_WVALID),
        .s_axi_araddr(auto_ds_to_auto_pc_ARADDR),
        .s_axi_arburst(auto_ds_to_auto_pc_ARBURST),
        .s_axi_arcache(auto_ds_to_auto_pc_ARCACHE),
        .s_axi_arlen(auto_ds_to_auto_pc_ARLEN),
        .s_axi_arlock(auto_ds_to_auto_pc_ARLOCK),
        .s_axi_arprot(auto_ds_to_auto_pc_ARPROT),
        .s_axi_arqos(auto_ds_to_auto_pc_ARQOS),
        .s_axi_arready(auto_ds_to_auto_pc_ARREADY),
        .s_axi_arregion(auto_ds_to_auto_pc_ARREGION),
        .s_axi_arsize(auto_ds_to_auto_pc_ARSIZE),
        .s_axi_arvalid(auto_ds_to_auto_pc_ARVALID),
        .s_axi_awaddr(auto_ds_to_auto_pc_AWADDR),
        .s_axi_awburst(auto_ds_to_auto_pc_AWBURST),
        .s_axi_awcache(auto_ds_to_auto_pc_AWCACHE),
        .s_axi_awlen(auto_ds_to_auto_pc_AWLEN),
        .s_axi_awlock(auto_ds_to_auto_pc_AWLOCK),
        .s_axi_awprot(auto_ds_to_auto_pc_AWPROT),
        .s_axi_awqos(auto_ds_to_auto_pc_AWQOS),
        .s_axi_awready(auto_ds_to_auto_pc_AWREADY),
        .s_axi_awregion(auto_ds_to_auto_pc_AWREGION),
        .s_axi_awsize(auto_ds_to_auto_pc_AWSIZE),
        .s_axi_awvalid(auto_ds_to_auto_pc_AWVALID),
        .s_axi_bready(auto_ds_to_auto_pc_BREADY),
        .s_axi_bresp(auto_ds_to_auto_pc_BRESP),
        .s_axi_bvalid(auto_ds_to_auto_pc_BVALID),
        .s_axi_rdata(auto_ds_to_auto_pc_RDATA),
        .s_axi_rlast(auto_ds_to_auto_pc_RLAST),
        .s_axi_rready(auto_ds_to_auto_pc_RREADY),
        .s_axi_rresp(auto_ds_to_auto_pc_RRESP),
        .s_axi_rvalid(auto_ds_to_auto_pc_RVALID),
        .s_axi_wdata(auto_ds_to_auto_pc_WDATA),
        .s_axi_wlast(auto_ds_to_auto_pc_WLAST),
        .s_axi_wready(auto_ds_to_auto_pc_WREADY),
        .s_axi_wstrb(auto_ds_to_auto_pc_WSTRB),
        .s_axi_wvalid(auto_ds_to_auto_pc_WVALID));
endmodule

module m01_couplers_imp_RADNNA
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arburst,
    M_AXI_arcache,
    M_AXI_arlen,
    M_AXI_arlock,
    M_AXI_arprot,
    M_AXI_arqos,
    M_AXI_arready,
    M_AXI_arregion,
    M_AXI_arsize,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awburst,
    M_AXI_awcache,
    M_AXI_awlen,
    M_AXI_awlock,
    M_AXI_awprot,
    M_AXI_awqos,
    M_AXI_awready,
    M_AXI_awregion,
    M_AXI_awsize,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rlast,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wlast,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arburst,
    S_AXI_arcache,
    S_AXI_arlen,
    S_AXI_arlock,
    S_AXI_arprot,
    S_AXI_arqos,
    S_AXI_arready,
    S_AXI_arregion,
    S_AXI_arsize,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awburst,
    S_AXI_awcache,
    S_AXI_awlen,
    S_AXI_awlock,
    S_AXI_awprot,
    S_AXI_awqos,
    S_AXI_awready,
    S_AXI_awregion,
    S_AXI_awsize,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rlast,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wlast,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input [0:0]M_ARESETN;
  output [31:0]M_AXI_araddr;
  output [1:0]M_AXI_arburst;
  output [3:0]M_AXI_arcache;
  output [7:0]M_AXI_arlen;
  output M_AXI_arlock;
  output [2:0]M_AXI_arprot;
  output [3:0]M_AXI_arqos;
  input M_AXI_arready;
  output [3:0]M_AXI_arregion;
  output [2:0]M_AXI_arsize;
  output M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  output [1:0]M_AXI_awburst;
  output [3:0]M_AXI_awcache;
  output [7:0]M_AXI_awlen;
  output M_AXI_awlock;
  output [2:0]M_AXI_awprot;
  output [3:0]M_AXI_awqos;
  input M_AXI_awready;
  output [3:0]M_AXI_awregion;
  output [2:0]M_AXI_awsize;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  input M_AXI_rlast;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  output M_AXI_wlast;
  input M_AXI_wready;
  output [3:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input [0:0]S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [1:0]S_AXI_arburst;
  input [3:0]S_AXI_arcache;
  input [7:0]S_AXI_arlen;
  input [0:0]S_AXI_arlock;
  input [2:0]S_AXI_arprot;
  input [3:0]S_AXI_arqos;
  output S_AXI_arready;
  input [3:0]S_AXI_arregion;
  input [2:0]S_AXI_arsize;
  input S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  input [1:0]S_AXI_awburst;
  input [3:0]S_AXI_awcache;
  input [7:0]S_AXI_awlen;
  input [0:0]S_AXI_awlock;
  input [2:0]S_AXI_awprot;
  input [3:0]S_AXI_awqos;
  output S_AXI_awready;
  input [3:0]S_AXI_awregion;
  input [2:0]S_AXI_awsize;
  input S_AXI_awvalid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [511:0]S_AXI_rdata;
  output S_AXI_rlast;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [511:0]S_AXI_wdata;
  input S_AXI_wlast;
  output S_AXI_wready;
  input [63:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire S_ACLK_1;
  wire [0:0]S_ARESETN_1;
  wire [31:0]auto_ds_to_m01_couplers_ARADDR;
  wire [1:0]auto_ds_to_m01_couplers_ARBURST;
  wire [3:0]auto_ds_to_m01_couplers_ARCACHE;
  wire [7:0]auto_ds_to_m01_couplers_ARLEN;
  wire [0:0]auto_ds_to_m01_couplers_ARLOCK;
  wire [2:0]auto_ds_to_m01_couplers_ARPROT;
  wire [3:0]auto_ds_to_m01_couplers_ARQOS;
  wire auto_ds_to_m01_couplers_ARREADY;
  wire [3:0]auto_ds_to_m01_couplers_ARREGION;
  wire [2:0]auto_ds_to_m01_couplers_ARSIZE;
  wire auto_ds_to_m01_couplers_ARVALID;
  wire [31:0]auto_ds_to_m01_couplers_AWADDR;
  wire [1:0]auto_ds_to_m01_couplers_AWBURST;
  wire [3:0]auto_ds_to_m01_couplers_AWCACHE;
  wire [7:0]auto_ds_to_m01_couplers_AWLEN;
  wire [0:0]auto_ds_to_m01_couplers_AWLOCK;
  wire [2:0]auto_ds_to_m01_couplers_AWPROT;
  wire [3:0]auto_ds_to_m01_couplers_AWQOS;
  wire auto_ds_to_m01_couplers_AWREADY;
  wire [3:0]auto_ds_to_m01_couplers_AWREGION;
  wire [2:0]auto_ds_to_m01_couplers_AWSIZE;
  wire auto_ds_to_m01_couplers_AWVALID;
  wire auto_ds_to_m01_couplers_BREADY;
  wire [1:0]auto_ds_to_m01_couplers_BRESP;
  wire auto_ds_to_m01_couplers_BVALID;
  wire [31:0]auto_ds_to_m01_couplers_RDATA;
  wire auto_ds_to_m01_couplers_RLAST;
  wire auto_ds_to_m01_couplers_RREADY;
  wire [1:0]auto_ds_to_m01_couplers_RRESP;
  wire auto_ds_to_m01_couplers_RVALID;
  wire [31:0]auto_ds_to_m01_couplers_WDATA;
  wire auto_ds_to_m01_couplers_WLAST;
  wire auto_ds_to_m01_couplers_WREADY;
  wire [3:0]auto_ds_to_m01_couplers_WSTRB;
  wire auto_ds_to_m01_couplers_WVALID;
  wire [31:0]m01_couplers_to_auto_ds_ARADDR;
  wire [1:0]m01_couplers_to_auto_ds_ARBURST;
  wire [3:0]m01_couplers_to_auto_ds_ARCACHE;
  wire [7:0]m01_couplers_to_auto_ds_ARLEN;
  wire [0:0]m01_couplers_to_auto_ds_ARLOCK;
  wire [2:0]m01_couplers_to_auto_ds_ARPROT;
  wire [3:0]m01_couplers_to_auto_ds_ARQOS;
  wire m01_couplers_to_auto_ds_ARREADY;
  wire [3:0]m01_couplers_to_auto_ds_ARREGION;
  wire [2:0]m01_couplers_to_auto_ds_ARSIZE;
  wire m01_couplers_to_auto_ds_ARVALID;
  wire [31:0]m01_couplers_to_auto_ds_AWADDR;
  wire [1:0]m01_couplers_to_auto_ds_AWBURST;
  wire [3:0]m01_couplers_to_auto_ds_AWCACHE;
  wire [7:0]m01_couplers_to_auto_ds_AWLEN;
  wire [0:0]m01_couplers_to_auto_ds_AWLOCK;
  wire [2:0]m01_couplers_to_auto_ds_AWPROT;
  wire [3:0]m01_couplers_to_auto_ds_AWQOS;
  wire m01_couplers_to_auto_ds_AWREADY;
  wire [3:0]m01_couplers_to_auto_ds_AWREGION;
  wire [2:0]m01_couplers_to_auto_ds_AWSIZE;
  wire m01_couplers_to_auto_ds_AWVALID;
  wire m01_couplers_to_auto_ds_BREADY;
  wire [1:0]m01_couplers_to_auto_ds_BRESP;
  wire m01_couplers_to_auto_ds_BVALID;
  wire [511:0]m01_couplers_to_auto_ds_RDATA;
  wire m01_couplers_to_auto_ds_RLAST;
  wire m01_couplers_to_auto_ds_RREADY;
  wire [1:0]m01_couplers_to_auto_ds_RRESP;
  wire m01_couplers_to_auto_ds_RVALID;
  wire [511:0]m01_couplers_to_auto_ds_WDATA;
  wire m01_couplers_to_auto_ds_WLAST;
  wire m01_couplers_to_auto_ds_WREADY;
  wire [63:0]m01_couplers_to_auto_ds_WSTRB;
  wire m01_couplers_to_auto_ds_WVALID;

  assign M_AXI_araddr[31:0] = auto_ds_to_m01_couplers_ARADDR;
  assign M_AXI_arburst[1:0] = auto_ds_to_m01_couplers_ARBURST;
  assign M_AXI_arcache[3:0] = auto_ds_to_m01_couplers_ARCACHE;
  assign M_AXI_arlen[7:0] = auto_ds_to_m01_couplers_ARLEN;
  assign M_AXI_arlock = auto_ds_to_m01_couplers_ARLOCK;
  assign M_AXI_arprot[2:0] = auto_ds_to_m01_couplers_ARPROT;
  assign M_AXI_arqos[3:0] = auto_ds_to_m01_couplers_ARQOS;
  assign M_AXI_arregion[3:0] = auto_ds_to_m01_couplers_ARREGION;
  assign M_AXI_arsize[2:0] = auto_ds_to_m01_couplers_ARSIZE;
  assign M_AXI_arvalid = auto_ds_to_m01_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = auto_ds_to_m01_couplers_AWADDR;
  assign M_AXI_awburst[1:0] = auto_ds_to_m01_couplers_AWBURST;
  assign M_AXI_awcache[3:0] = auto_ds_to_m01_couplers_AWCACHE;
  assign M_AXI_awlen[7:0] = auto_ds_to_m01_couplers_AWLEN;
  assign M_AXI_awlock = auto_ds_to_m01_couplers_AWLOCK;
  assign M_AXI_awprot[2:0] = auto_ds_to_m01_couplers_AWPROT;
  assign M_AXI_awqos[3:0] = auto_ds_to_m01_couplers_AWQOS;
  assign M_AXI_awregion[3:0] = auto_ds_to_m01_couplers_AWREGION;
  assign M_AXI_awsize[2:0] = auto_ds_to_m01_couplers_AWSIZE;
  assign M_AXI_awvalid = auto_ds_to_m01_couplers_AWVALID;
  assign M_AXI_bready = auto_ds_to_m01_couplers_BREADY;
  assign M_AXI_rready = auto_ds_to_m01_couplers_RREADY;
  assign M_AXI_wdata[31:0] = auto_ds_to_m01_couplers_WDATA;
  assign M_AXI_wlast = auto_ds_to_m01_couplers_WLAST;
  assign M_AXI_wstrb[3:0] = auto_ds_to_m01_couplers_WSTRB;
  assign M_AXI_wvalid = auto_ds_to_m01_couplers_WVALID;
  assign S_ACLK_1 = S_ACLK;
  assign S_ARESETN_1 = S_ARESETN[0];
  assign S_AXI_arready = m01_couplers_to_auto_ds_ARREADY;
  assign S_AXI_awready = m01_couplers_to_auto_ds_AWREADY;
  assign S_AXI_bresp[1:0] = m01_couplers_to_auto_ds_BRESP;
  assign S_AXI_bvalid = m01_couplers_to_auto_ds_BVALID;
  assign S_AXI_rdata[511:0] = m01_couplers_to_auto_ds_RDATA;
  assign S_AXI_rlast = m01_couplers_to_auto_ds_RLAST;
  assign S_AXI_rresp[1:0] = m01_couplers_to_auto_ds_RRESP;
  assign S_AXI_rvalid = m01_couplers_to_auto_ds_RVALID;
  assign S_AXI_wready = m01_couplers_to_auto_ds_WREADY;
  assign auto_ds_to_m01_couplers_ARREADY = M_AXI_arready;
  assign auto_ds_to_m01_couplers_AWREADY = M_AXI_awready;
  assign auto_ds_to_m01_couplers_BRESP = M_AXI_bresp[1:0];
  assign auto_ds_to_m01_couplers_BVALID = M_AXI_bvalid;
  assign auto_ds_to_m01_couplers_RDATA = M_AXI_rdata[31:0];
  assign auto_ds_to_m01_couplers_RLAST = M_AXI_rlast;
  assign auto_ds_to_m01_couplers_RRESP = M_AXI_rresp[1:0];
  assign auto_ds_to_m01_couplers_RVALID = M_AXI_rvalid;
  assign auto_ds_to_m01_couplers_WREADY = M_AXI_wready;
  assign m01_couplers_to_auto_ds_ARADDR = S_AXI_araddr[31:0];
  assign m01_couplers_to_auto_ds_ARBURST = S_AXI_arburst[1:0];
  assign m01_couplers_to_auto_ds_ARCACHE = S_AXI_arcache[3:0];
  assign m01_couplers_to_auto_ds_ARLEN = S_AXI_arlen[7:0];
  assign m01_couplers_to_auto_ds_ARLOCK = S_AXI_arlock[0];
  assign m01_couplers_to_auto_ds_ARPROT = S_AXI_arprot[2:0];
  assign m01_couplers_to_auto_ds_ARQOS = S_AXI_arqos[3:0];
  assign m01_couplers_to_auto_ds_ARREGION = S_AXI_arregion[3:0];
  assign m01_couplers_to_auto_ds_ARSIZE = S_AXI_arsize[2:0];
  assign m01_couplers_to_auto_ds_ARVALID = S_AXI_arvalid;
  assign m01_couplers_to_auto_ds_AWADDR = S_AXI_awaddr[31:0];
  assign m01_couplers_to_auto_ds_AWBURST = S_AXI_awburst[1:0];
  assign m01_couplers_to_auto_ds_AWCACHE = S_AXI_awcache[3:0];
  assign m01_couplers_to_auto_ds_AWLEN = S_AXI_awlen[7:0];
  assign m01_couplers_to_auto_ds_AWLOCK = S_AXI_awlock[0];
  assign m01_couplers_to_auto_ds_AWPROT = S_AXI_awprot[2:0];
  assign m01_couplers_to_auto_ds_AWQOS = S_AXI_awqos[3:0];
  assign m01_couplers_to_auto_ds_AWREGION = S_AXI_awregion[3:0];
  assign m01_couplers_to_auto_ds_AWSIZE = S_AXI_awsize[2:0];
  assign m01_couplers_to_auto_ds_AWVALID = S_AXI_awvalid;
  assign m01_couplers_to_auto_ds_BREADY = S_AXI_bready;
  assign m01_couplers_to_auto_ds_RREADY = S_AXI_rready;
  assign m01_couplers_to_auto_ds_WDATA = S_AXI_wdata[511:0];
  assign m01_couplers_to_auto_ds_WLAST = S_AXI_wlast;
  assign m01_couplers_to_auto_ds_WSTRB = S_AXI_wstrb[63:0];
  assign m01_couplers_to_auto_ds_WVALID = S_AXI_wvalid;
  system_i_bak_auto_ds_1 auto_ds
       (.m_axi_araddr(auto_ds_to_m01_couplers_ARADDR),
        .m_axi_arburst(auto_ds_to_m01_couplers_ARBURST),
        .m_axi_arcache(auto_ds_to_m01_couplers_ARCACHE),
        .m_axi_arlen(auto_ds_to_m01_couplers_ARLEN),
        .m_axi_arlock(auto_ds_to_m01_couplers_ARLOCK),
        .m_axi_arprot(auto_ds_to_m01_couplers_ARPROT),
        .m_axi_arqos(auto_ds_to_m01_couplers_ARQOS),
        .m_axi_arready(auto_ds_to_m01_couplers_ARREADY),
        .m_axi_arregion(auto_ds_to_m01_couplers_ARREGION),
        .m_axi_arsize(auto_ds_to_m01_couplers_ARSIZE),
        .m_axi_arvalid(auto_ds_to_m01_couplers_ARVALID),
        .m_axi_awaddr(auto_ds_to_m01_couplers_AWADDR),
        .m_axi_awburst(auto_ds_to_m01_couplers_AWBURST),
        .m_axi_awcache(auto_ds_to_m01_couplers_AWCACHE),
        .m_axi_awlen(auto_ds_to_m01_couplers_AWLEN),
        .m_axi_awlock(auto_ds_to_m01_couplers_AWLOCK),
        .m_axi_awprot(auto_ds_to_m01_couplers_AWPROT),
        .m_axi_awqos(auto_ds_to_m01_couplers_AWQOS),
        .m_axi_awready(auto_ds_to_m01_couplers_AWREADY),
        .m_axi_awregion(auto_ds_to_m01_couplers_AWREGION),
        .m_axi_awsize(auto_ds_to_m01_couplers_AWSIZE),
        .m_axi_awvalid(auto_ds_to_m01_couplers_AWVALID),
        .m_axi_bready(auto_ds_to_m01_couplers_BREADY),
        .m_axi_bresp(auto_ds_to_m01_couplers_BRESP),
        .m_axi_bvalid(auto_ds_to_m01_couplers_BVALID),
        .m_axi_rdata(auto_ds_to_m01_couplers_RDATA),
        .m_axi_rlast(auto_ds_to_m01_couplers_RLAST),
        .m_axi_rready(auto_ds_to_m01_couplers_RREADY),
        .m_axi_rresp(auto_ds_to_m01_couplers_RRESP),
        .m_axi_rvalid(auto_ds_to_m01_couplers_RVALID),
        .m_axi_wdata(auto_ds_to_m01_couplers_WDATA),
        .m_axi_wlast(auto_ds_to_m01_couplers_WLAST),
        .m_axi_wready(auto_ds_to_m01_couplers_WREADY),
        .m_axi_wstrb(auto_ds_to_m01_couplers_WSTRB),
        .m_axi_wvalid(auto_ds_to_m01_couplers_WVALID),
        .s_axi_aclk(S_ACLK_1),
        .s_axi_araddr(m01_couplers_to_auto_ds_ARADDR),
        .s_axi_arburst(m01_couplers_to_auto_ds_ARBURST),
        .s_axi_arcache(m01_couplers_to_auto_ds_ARCACHE),
        .s_axi_aresetn(S_ARESETN_1),
        .s_axi_arlen(m01_couplers_to_auto_ds_ARLEN),
        .s_axi_arlock(m01_couplers_to_auto_ds_ARLOCK),
        .s_axi_arprot(m01_couplers_to_auto_ds_ARPROT),
        .s_axi_arqos(m01_couplers_to_auto_ds_ARQOS),
        .s_axi_arready(m01_couplers_to_auto_ds_ARREADY),
        .s_axi_arregion(m01_couplers_to_auto_ds_ARREGION),
        .s_axi_arsize(m01_couplers_to_auto_ds_ARSIZE),
        .s_axi_arvalid(m01_couplers_to_auto_ds_ARVALID),
        .s_axi_awaddr(m01_couplers_to_auto_ds_AWADDR),
        .s_axi_awburst(m01_couplers_to_auto_ds_AWBURST),
        .s_axi_awcache(m01_couplers_to_auto_ds_AWCACHE),
        .s_axi_awlen(m01_couplers_to_auto_ds_AWLEN),
        .s_axi_awlock(m01_couplers_to_auto_ds_AWLOCK),
        .s_axi_awprot(m01_couplers_to_auto_ds_AWPROT),
        .s_axi_awqos(m01_couplers_to_auto_ds_AWQOS),
        .s_axi_awready(m01_couplers_to_auto_ds_AWREADY),
        .s_axi_awregion(m01_couplers_to_auto_ds_AWREGION),
        .s_axi_awsize(m01_couplers_to_auto_ds_AWSIZE),
        .s_axi_awvalid(m01_couplers_to_auto_ds_AWVALID),
        .s_axi_bready(m01_couplers_to_auto_ds_BREADY),
        .s_axi_bresp(m01_couplers_to_auto_ds_BRESP),
        .s_axi_bvalid(m01_couplers_to_auto_ds_BVALID),
        .s_axi_rdata(m01_couplers_to_auto_ds_RDATA),
        .s_axi_rlast(m01_couplers_to_auto_ds_RLAST),
        .s_axi_rready(m01_couplers_to_auto_ds_RREADY),
        .s_axi_rresp(m01_couplers_to_auto_ds_RRESP),
        .s_axi_rvalid(m01_couplers_to_auto_ds_RVALID),
        .s_axi_wdata(m01_couplers_to_auto_ds_WDATA),
        .s_axi_wlast(m01_couplers_to_auto_ds_WLAST),
        .s_axi_wready(m01_couplers_to_auto_ds_WREADY),
        .s_axi_wstrb(m01_couplers_to_auto_ds_WSTRB),
        .s_axi_wvalid(m01_couplers_to_auto_ds_WVALID));
endmodule

module m02_couplers_imp_PAANJQ
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arburst,
    S_AXI_arcache,
    S_AXI_arlen,
    S_AXI_arlock,
    S_AXI_arprot,
    S_AXI_arqos,
    S_AXI_arready,
    S_AXI_arregion,
    S_AXI_arsize,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awburst,
    S_AXI_awcache,
    S_AXI_awlen,
    S_AXI_awlock,
    S_AXI_awprot,
    S_AXI_awqos,
    S_AXI_awready,
    S_AXI_awregion,
    S_AXI_awsize,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rlast,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wlast,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input [0:0]M_ARESETN;
  output [31:0]M_AXI_araddr;
  input M_AXI_arready;
  output M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  input M_AXI_awready;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  input M_AXI_wready;
  output M_AXI_wvalid;
  input S_ACLK;
  input [0:0]S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [1:0]S_AXI_arburst;
  input [3:0]S_AXI_arcache;
  input [7:0]S_AXI_arlen;
  input [0:0]S_AXI_arlock;
  input [2:0]S_AXI_arprot;
  input [3:0]S_AXI_arqos;
  output S_AXI_arready;
  input [3:0]S_AXI_arregion;
  input [2:0]S_AXI_arsize;
  input S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  input [1:0]S_AXI_awburst;
  input [3:0]S_AXI_awcache;
  input [7:0]S_AXI_awlen;
  input [0:0]S_AXI_awlock;
  input [2:0]S_AXI_awprot;
  input [3:0]S_AXI_awqos;
  output S_AXI_awready;
  input [3:0]S_AXI_awregion;
  input [2:0]S_AXI_awsize;
  input S_AXI_awvalid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [511:0]S_AXI_rdata;
  output S_AXI_rlast;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [511:0]S_AXI_wdata;
  input S_AXI_wlast;
  output S_AXI_wready;
  input [63:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire S_ACLK_1;
  wire [0:0]S_ARESETN_1;
  wire [31:0]auto_ds_to_auto_pc_ARADDR;
  wire [1:0]auto_ds_to_auto_pc_ARBURST;
  wire [3:0]auto_ds_to_auto_pc_ARCACHE;
  wire [7:0]auto_ds_to_auto_pc_ARLEN;
  wire [0:0]auto_ds_to_auto_pc_ARLOCK;
  wire [2:0]auto_ds_to_auto_pc_ARPROT;
  wire [3:0]auto_ds_to_auto_pc_ARQOS;
  wire auto_ds_to_auto_pc_ARREADY;
  wire [3:0]auto_ds_to_auto_pc_ARREGION;
  wire [2:0]auto_ds_to_auto_pc_ARSIZE;
  wire auto_ds_to_auto_pc_ARVALID;
  wire [31:0]auto_ds_to_auto_pc_AWADDR;
  wire [1:0]auto_ds_to_auto_pc_AWBURST;
  wire [3:0]auto_ds_to_auto_pc_AWCACHE;
  wire [7:0]auto_ds_to_auto_pc_AWLEN;
  wire [0:0]auto_ds_to_auto_pc_AWLOCK;
  wire [2:0]auto_ds_to_auto_pc_AWPROT;
  wire [3:0]auto_ds_to_auto_pc_AWQOS;
  wire auto_ds_to_auto_pc_AWREADY;
  wire [3:0]auto_ds_to_auto_pc_AWREGION;
  wire [2:0]auto_ds_to_auto_pc_AWSIZE;
  wire auto_ds_to_auto_pc_AWVALID;
  wire auto_ds_to_auto_pc_BREADY;
  wire [1:0]auto_ds_to_auto_pc_BRESP;
  wire auto_ds_to_auto_pc_BVALID;
  wire [31:0]auto_ds_to_auto_pc_RDATA;
  wire auto_ds_to_auto_pc_RLAST;
  wire auto_ds_to_auto_pc_RREADY;
  wire [1:0]auto_ds_to_auto_pc_RRESP;
  wire auto_ds_to_auto_pc_RVALID;
  wire [31:0]auto_ds_to_auto_pc_WDATA;
  wire auto_ds_to_auto_pc_WLAST;
  wire auto_ds_to_auto_pc_WREADY;
  wire [3:0]auto_ds_to_auto_pc_WSTRB;
  wire auto_ds_to_auto_pc_WVALID;
  wire [31:0]auto_pc_to_m02_couplers_ARADDR;
  wire auto_pc_to_m02_couplers_ARREADY;
  wire auto_pc_to_m02_couplers_ARVALID;
  wire [31:0]auto_pc_to_m02_couplers_AWADDR;
  wire auto_pc_to_m02_couplers_AWREADY;
  wire auto_pc_to_m02_couplers_AWVALID;
  wire auto_pc_to_m02_couplers_BREADY;
  wire [1:0]auto_pc_to_m02_couplers_BRESP;
  wire auto_pc_to_m02_couplers_BVALID;
  wire [31:0]auto_pc_to_m02_couplers_RDATA;
  wire auto_pc_to_m02_couplers_RREADY;
  wire [1:0]auto_pc_to_m02_couplers_RRESP;
  wire auto_pc_to_m02_couplers_RVALID;
  wire [31:0]auto_pc_to_m02_couplers_WDATA;
  wire auto_pc_to_m02_couplers_WREADY;
  wire auto_pc_to_m02_couplers_WVALID;
  wire [31:0]m02_couplers_to_auto_ds_ARADDR;
  wire [1:0]m02_couplers_to_auto_ds_ARBURST;
  wire [3:0]m02_couplers_to_auto_ds_ARCACHE;
  wire [7:0]m02_couplers_to_auto_ds_ARLEN;
  wire [0:0]m02_couplers_to_auto_ds_ARLOCK;
  wire [2:0]m02_couplers_to_auto_ds_ARPROT;
  wire [3:0]m02_couplers_to_auto_ds_ARQOS;
  wire m02_couplers_to_auto_ds_ARREADY;
  wire [3:0]m02_couplers_to_auto_ds_ARREGION;
  wire [2:0]m02_couplers_to_auto_ds_ARSIZE;
  wire m02_couplers_to_auto_ds_ARVALID;
  wire [31:0]m02_couplers_to_auto_ds_AWADDR;
  wire [1:0]m02_couplers_to_auto_ds_AWBURST;
  wire [3:0]m02_couplers_to_auto_ds_AWCACHE;
  wire [7:0]m02_couplers_to_auto_ds_AWLEN;
  wire [0:0]m02_couplers_to_auto_ds_AWLOCK;
  wire [2:0]m02_couplers_to_auto_ds_AWPROT;
  wire [3:0]m02_couplers_to_auto_ds_AWQOS;
  wire m02_couplers_to_auto_ds_AWREADY;
  wire [3:0]m02_couplers_to_auto_ds_AWREGION;
  wire [2:0]m02_couplers_to_auto_ds_AWSIZE;
  wire m02_couplers_to_auto_ds_AWVALID;
  wire m02_couplers_to_auto_ds_BREADY;
  wire [1:0]m02_couplers_to_auto_ds_BRESP;
  wire m02_couplers_to_auto_ds_BVALID;
  wire [511:0]m02_couplers_to_auto_ds_RDATA;
  wire m02_couplers_to_auto_ds_RLAST;
  wire m02_couplers_to_auto_ds_RREADY;
  wire [1:0]m02_couplers_to_auto_ds_RRESP;
  wire m02_couplers_to_auto_ds_RVALID;
  wire [511:0]m02_couplers_to_auto_ds_WDATA;
  wire m02_couplers_to_auto_ds_WLAST;
  wire m02_couplers_to_auto_ds_WREADY;
  wire [63:0]m02_couplers_to_auto_ds_WSTRB;
  wire m02_couplers_to_auto_ds_WVALID;

  assign M_AXI_araddr[31:0] = auto_pc_to_m02_couplers_ARADDR;
  assign M_AXI_arvalid = auto_pc_to_m02_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = auto_pc_to_m02_couplers_AWADDR;
  assign M_AXI_awvalid = auto_pc_to_m02_couplers_AWVALID;
  assign M_AXI_bready = auto_pc_to_m02_couplers_BREADY;
  assign M_AXI_rready = auto_pc_to_m02_couplers_RREADY;
  assign M_AXI_wdata[31:0] = auto_pc_to_m02_couplers_WDATA;
  assign M_AXI_wvalid = auto_pc_to_m02_couplers_WVALID;
  assign S_ACLK_1 = S_ACLK;
  assign S_ARESETN_1 = S_ARESETN[0];
  assign S_AXI_arready = m02_couplers_to_auto_ds_ARREADY;
  assign S_AXI_awready = m02_couplers_to_auto_ds_AWREADY;
  assign S_AXI_bresp[1:0] = m02_couplers_to_auto_ds_BRESP;
  assign S_AXI_bvalid = m02_couplers_to_auto_ds_BVALID;
  assign S_AXI_rdata[511:0] = m02_couplers_to_auto_ds_RDATA;
  assign S_AXI_rlast = m02_couplers_to_auto_ds_RLAST;
  assign S_AXI_rresp[1:0] = m02_couplers_to_auto_ds_RRESP;
  assign S_AXI_rvalid = m02_couplers_to_auto_ds_RVALID;
  assign S_AXI_wready = m02_couplers_to_auto_ds_WREADY;
  assign auto_pc_to_m02_couplers_ARREADY = M_AXI_arready;
  assign auto_pc_to_m02_couplers_AWREADY = M_AXI_awready;
  assign auto_pc_to_m02_couplers_BRESP = M_AXI_bresp[1:0];
  assign auto_pc_to_m02_couplers_BVALID = M_AXI_bvalid;
  assign auto_pc_to_m02_couplers_RDATA = M_AXI_rdata[31:0];
  assign auto_pc_to_m02_couplers_RRESP = M_AXI_rresp[1:0];
  assign auto_pc_to_m02_couplers_RVALID = M_AXI_rvalid;
  assign auto_pc_to_m02_couplers_WREADY = M_AXI_wready;
  assign m02_couplers_to_auto_ds_ARADDR = S_AXI_araddr[31:0];
  assign m02_couplers_to_auto_ds_ARBURST = S_AXI_arburst[1:0];
  assign m02_couplers_to_auto_ds_ARCACHE = S_AXI_arcache[3:0];
  assign m02_couplers_to_auto_ds_ARLEN = S_AXI_arlen[7:0];
  assign m02_couplers_to_auto_ds_ARLOCK = S_AXI_arlock[0];
  assign m02_couplers_to_auto_ds_ARPROT = S_AXI_arprot[2:0];
  assign m02_couplers_to_auto_ds_ARQOS = S_AXI_arqos[3:0];
  assign m02_couplers_to_auto_ds_ARREGION = S_AXI_arregion[3:0];
  assign m02_couplers_to_auto_ds_ARSIZE = S_AXI_arsize[2:0];
  assign m02_couplers_to_auto_ds_ARVALID = S_AXI_arvalid;
  assign m02_couplers_to_auto_ds_AWADDR = S_AXI_awaddr[31:0];
  assign m02_couplers_to_auto_ds_AWBURST = S_AXI_awburst[1:0];
  assign m02_couplers_to_auto_ds_AWCACHE = S_AXI_awcache[3:0];
  assign m02_couplers_to_auto_ds_AWLEN = S_AXI_awlen[7:0];
  assign m02_couplers_to_auto_ds_AWLOCK = S_AXI_awlock[0];
  assign m02_couplers_to_auto_ds_AWPROT = S_AXI_awprot[2:0];
  assign m02_couplers_to_auto_ds_AWQOS = S_AXI_awqos[3:0];
  assign m02_couplers_to_auto_ds_AWREGION = S_AXI_awregion[3:0];
  assign m02_couplers_to_auto_ds_AWSIZE = S_AXI_awsize[2:0];
  assign m02_couplers_to_auto_ds_AWVALID = S_AXI_awvalid;
  assign m02_couplers_to_auto_ds_BREADY = S_AXI_bready;
  assign m02_couplers_to_auto_ds_RREADY = S_AXI_rready;
  assign m02_couplers_to_auto_ds_WDATA = S_AXI_wdata[511:0];
  assign m02_couplers_to_auto_ds_WLAST = S_AXI_wlast;
  assign m02_couplers_to_auto_ds_WSTRB = S_AXI_wstrb[63:0];
  assign m02_couplers_to_auto_ds_WVALID = S_AXI_wvalid;
  system_i_bak_auto_ds_2 auto_ds
       (.m_axi_araddr(auto_ds_to_auto_pc_ARADDR),
        .m_axi_arburst(auto_ds_to_auto_pc_ARBURST),
        .m_axi_arcache(auto_ds_to_auto_pc_ARCACHE),
        .m_axi_arlen(auto_ds_to_auto_pc_ARLEN),
        .m_axi_arlock(auto_ds_to_auto_pc_ARLOCK),
        .m_axi_arprot(auto_ds_to_auto_pc_ARPROT),
        .m_axi_arqos(auto_ds_to_auto_pc_ARQOS),
        .m_axi_arready(auto_ds_to_auto_pc_ARREADY),
        .m_axi_arregion(auto_ds_to_auto_pc_ARREGION),
        .m_axi_arsize(auto_ds_to_auto_pc_ARSIZE),
        .m_axi_arvalid(auto_ds_to_auto_pc_ARVALID),
        .m_axi_awaddr(auto_ds_to_auto_pc_AWADDR),
        .m_axi_awburst(auto_ds_to_auto_pc_AWBURST),
        .m_axi_awcache(auto_ds_to_auto_pc_AWCACHE),
        .m_axi_awlen(auto_ds_to_auto_pc_AWLEN),
        .m_axi_awlock(auto_ds_to_auto_pc_AWLOCK),
        .m_axi_awprot(auto_ds_to_auto_pc_AWPROT),
        .m_axi_awqos(auto_ds_to_auto_pc_AWQOS),
        .m_axi_awready(auto_ds_to_auto_pc_AWREADY),
        .m_axi_awregion(auto_ds_to_auto_pc_AWREGION),
        .m_axi_awsize(auto_ds_to_auto_pc_AWSIZE),
        .m_axi_awvalid(auto_ds_to_auto_pc_AWVALID),
        .m_axi_bready(auto_ds_to_auto_pc_BREADY),
        .m_axi_bresp(auto_ds_to_auto_pc_BRESP),
        .m_axi_bvalid(auto_ds_to_auto_pc_BVALID),
        .m_axi_rdata(auto_ds_to_auto_pc_RDATA),
        .m_axi_rlast(auto_ds_to_auto_pc_RLAST),
        .m_axi_rready(auto_ds_to_auto_pc_RREADY),
        .m_axi_rresp(auto_ds_to_auto_pc_RRESP),
        .m_axi_rvalid(auto_ds_to_auto_pc_RVALID),
        .m_axi_wdata(auto_ds_to_auto_pc_WDATA),
        .m_axi_wlast(auto_ds_to_auto_pc_WLAST),
        .m_axi_wready(auto_ds_to_auto_pc_WREADY),
        .m_axi_wstrb(auto_ds_to_auto_pc_WSTRB),
        .m_axi_wvalid(auto_ds_to_auto_pc_WVALID),
        .s_axi_aclk(S_ACLK_1),
        .s_axi_araddr(m02_couplers_to_auto_ds_ARADDR),
        .s_axi_arburst(m02_couplers_to_auto_ds_ARBURST),
        .s_axi_arcache(m02_couplers_to_auto_ds_ARCACHE),
        .s_axi_aresetn(S_ARESETN_1),
        .s_axi_arlen(m02_couplers_to_auto_ds_ARLEN),
        .s_axi_arlock(m02_couplers_to_auto_ds_ARLOCK),
        .s_axi_arprot(m02_couplers_to_auto_ds_ARPROT),
        .s_axi_arqos(m02_couplers_to_auto_ds_ARQOS),
        .s_axi_arready(m02_couplers_to_auto_ds_ARREADY),
        .s_axi_arregion(m02_couplers_to_auto_ds_ARREGION),
        .s_axi_arsize(m02_couplers_to_auto_ds_ARSIZE),
        .s_axi_arvalid(m02_couplers_to_auto_ds_ARVALID),
        .s_axi_awaddr(m02_couplers_to_auto_ds_AWADDR),
        .s_axi_awburst(m02_couplers_to_auto_ds_AWBURST),
        .s_axi_awcache(m02_couplers_to_auto_ds_AWCACHE),
        .s_axi_awlen(m02_couplers_to_auto_ds_AWLEN),
        .s_axi_awlock(m02_couplers_to_auto_ds_AWLOCK),
        .s_axi_awprot(m02_couplers_to_auto_ds_AWPROT),
        .s_axi_awqos(m02_couplers_to_auto_ds_AWQOS),
        .s_axi_awready(m02_couplers_to_auto_ds_AWREADY),
        .s_axi_awregion(m02_couplers_to_auto_ds_AWREGION),
        .s_axi_awsize(m02_couplers_to_auto_ds_AWSIZE),
        .s_axi_awvalid(m02_couplers_to_auto_ds_AWVALID),
        .s_axi_bready(m02_couplers_to_auto_ds_BREADY),
        .s_axi_bresp(m02_couplers_to_auto_ds_BRESP),
        .s_axi_bvalid(m02_couplers_to_auto_ds_BVALID),
        .s_axi_rdata(m02_couplers_to_auto_ds_RDATA),
        .s_axi_rlast(m02_couplers_to_auto_ds_RLAST),
        .s_axi_rready(m02_couplers_to_auto_ds_RREADY),
        .s_axi_rresp(m02_couplers_to_auto_ds_RRESP),
        .s_axi_rvalid(m02_couplers_to_auto_ds_RVALID),
        .s_axi_wdata(m02_couplers_to_auto_ds_WDATA),
        .s_axi_wlast(m02_couplers_to_auto_ds_WLAST),
        .s_axi_wready(m02_couplers_to_auto_ds_WREADY),
        .s_axi_wstrb(m02_couplers_to_auto_ds_WSTRB),
        .s_axi_wvalid(m02_couplers_to_auto_ds_WVALID));
  system_i_bak_auto_pc_1 auto_pc
       (.aclk(S_ACLK_1),
        .aresetn(S_ARESETN_1),
        .m_axi_araddr(auto_pc_to_m02_couplers_ARADDR),
        .m_axi_arready(auto_pc_to_m02_couplers_ARREADY),
        .m_axi_arvalid(auto_pc_to_m02_couplers_ARVALID),
        .m_axi_awaddr(auto_pc_to_m02_couplers_AWADDR),
        .m_axi_awready(auto_pc_to_m02_couplers_AWREADY),
        .m_axi_awvalid(auto_pc_to_m02_couplers_AWVALID),
        .m_axi_bready(auto_pc_to_m02_couplers_BREADY),
        .m_axi_bresp(auto_pc_to_m02_couplers_BRESP),
        .m_axi_bvalid(auto_pc_to_m02_couplers_BVALID),
        .m_axi_rdata(auto_pc_to_m02_couplers_RDATA),
        .m_axi_rready(auto_pc_to_m02_couplers_RREADY),
        .m_axi_rresp(auto_pc_to_m02_couplers_RRESP),
        .m_axi_rvalid(auto_pc_to_m02_couplers_RVALID),
        .m_axi_wdata(auto_pc_to_m02_couplers_WDATA),
        .m_axi_wready(auto_pc_to_m02_couplers_WREADY),
        .m_axi_wvalid(auto_pc_to_m02_couplers_WVALID),
        .s_axi_araddr(auto_ds_to_auto_pc_ARADDR),
        .s_axi_arburst(auto_ds_to_auto_pc_ARBURST),
        .s_axi_arcache(auto_ds_to_auto_pc_ARCACHE),
        .s_axi_arlen(auto_ds_to_auto_pc_ARLEN),
        .s_axi_arlock(auto_ds_to_auto_pc_ARLOCK),
        .s_axi_arprot(auto_ds_to_auto_pc_ARPROT),
        .s_axi_arqos(auto_ds_to_auto_pc_ARQOS),
        .s_axi_arready(auto_ds_to_auto_pc_ARREADY),
        .s_axi_arregion(auto_ds_to_auto_pc_ARREGION),
        .s_axi_arsize(auto_ds_to_auto_pc_ARSIZE),
        .s_axi_arvalid(auto_ds_to_auto_pc_ARVALID),
        .s_axi_awaddr(auto_ds_to_auto_pc_AWADDR),
        .s_axi_awburst(auto_ds_to_auto_pc_AWBURST),
        .s_axi_awcache(auto_ds_to_auto_pc_AWCACHE),
        .s_axi_awlen(auto_ds_to_auto_pc_AWLEN),
        .s_axi_awlock(auto_ds_to_auto_pc_AWLOCK),
        .s_axi_awprot(auto_ds_to_auto_pc_AWPROT),
        .s_axi_awqos(auto_ds_to_auto_pc_AWQOS),
        .s_axi_awready(auto_ds_to_auto_pc_AWREADY),
        .s_axi_awregion(auto_ds_to_auto_pc_AWREGION),
        .s_axi_awsize(auto_ds_to_auto_pc_AWSIZE),
        .s_axi_awvalid(auto_ds_to_auto_pc_AWVALID),
        .s_axi_bready(auto_ds_to_auto_pc_BREADY),
        .s_axi_bresp(auto_ds_to_auto_pc_BRESP),
        .s_axi_bvalid(auto_ds_to_auto_pc_BVALID),
        .s_axi_rdata(auto_ds_to_auto_pc_RDATA),
        .s_axi_rlast(auto_ds_to_auto_pc_RLAST),
        .s_axi_rready(auto_ds_to_auto_pc_RREADY),
        .s_axi_rresp(auto_ds_to_auto_pc_RRESP),
        .s_axi_rvalid(auto_ds_to_auto_pc_RVALID),
        .s_axi_wdata(auto_ds_to_auto_pc_WDATA),
        .s_axi_wlast(auto_ds_to_auto_pc_WLAST),
        .s_axi_wready(auto_ds_to_auto_pc_WREADY),
        .s_axi_wstrb(auto_ds_to_auto_pc_WSTRB),
        .s_axi_wvalid(auto_ds_to_auto_pc_WVALID));
endmodule

module m03_couplers_imp_L3IIYE
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arburst,
    S_AXI_arcache,
    S_AXI_arlen,
    S_AXI_arlock,
    S_AXI_arprot,
    S_AXI_arqos,
    S_AXI_arready,
    S_AXI_arregion,
    S_AXI_arsize,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awburst,
    S_AXI_awcache,
    S_AXI_awlen,
    S_AXI_awlock,
    S_AXI_awprot,
    S_AXI_awqos,
    S_AXI_awready,
    S_AXI_awregion,
    S_AXI_awsize,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rlast,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wlast,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input [0:0]M_ARESETN;
  output [31:0]M_AXI_araddr;
  input M_AXI_arready;
  output M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  input M_AXI_awready;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  input M_AXI_wready;
  output [3:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input [0:0]S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [1:0]S_AXI_arburst;
  input [3:0]S_AXI_arcache;
  input [7:0]S_AXI_arlen;
  input [0:0]S_AXI_arlock;
  input [2:0]S_AXI_arprot;
  input [3:0]S_AXI_arqos;
  output S_AXI_arready;
  input [3:0]S_AXI_arregion;
  input [2:0]S_AXI_arsize;
  input S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  input [1:0]S_AXI_awburst;
  input [3:0]S_AXI_awcache;
  input [7:0]S_AXI_awlen;
  input [0:0]S_AXI_awlock;
  input [2:0]S_AXI_awprot;
  input [3:0]S_AXI_awqos;
  output S_AXI_awready;
  input [3:0]S_AXI_awregion;
  input [2:0]S_AXI_awsize;
  input S_AXI_awvalid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [511:0]S_AXI_rdata;
  output S_AXI_rlast;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [511:0]S_AXI_wdata;
  input S_AXI_wlast;
  output S_AXI_wready;
  input [63:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire S_ACLK_1;
  wire [0:0]S_ARESETN_1;
  wire [31:0]auto_ds_to_auto_pc_ARADDR;
  wire [1:0]auto_ds_to_auto_pc_ARBURST;
  wire [3:0]auto_ds_to_auto_pc_ARCACHE;
  wire [7:0]auto_ds_to_auto_pc_ARLEN;
  wire [0:0]auto_ds_to_auto_pc_ARLOCK;
  wire [2:0]auto_ds_to_auto_pc_ARPROT;
  wire [3:0]auto_ds_to_auto_pc_ARQOS;
  wire auto_ds_to_auto_pc_ARREADY;
  wire [3:0]auto_ds_to_auto_pc_ARREGION;
  wire [2:0]auto_ds_to_auto_pc_ARSIZE;
  wire auto_ds_to_auto_pc_ARVALID;
  wire [31:0]auto_ds_to_auto_pc_AWADDR;
  wire [1:0]auto_ds_to_auto_pc_AWBURST;
  wire [3:0]auto_ds_to_auto_pc_AWCACHE;
  wire [7:0]auto_ds_to_auto_pc_AWLEN;
  wire [0:0]auto_ds_to_auto_pc_AWLOCK;
  wire [2:0]auto_ds_to_auto_pc_AWPROT;
  wire [3:0]auto_ds_to_auto_pc_AWQOS;
  wire auto_ds_to_auto_pc_AWREADY;
  wire [3:0]auto_ds_to_auto_pc_AWREGION;
  wire [2:0]auto_ds_to_auto_pc_AWSIZE;
  wire auto_ds_to_auto_pc_AWVALID;
  wire auto_ds_to_auto_pc_BREADY;
  wire [1:0]auto_ds_to_auto_pc_BRESP;
  wire auto_ds_to_auto_pc_BVALID;
  wire [31:0]auto_ds_to_auto_pc_RDATA;
  wire auto_ds_to_auto_pc_RLAST;
  wire auto_ds_to_auto_pc_RREADY;
  wire [1:0]auto_ds_to_auto_pc_RRESP;
  wire auto_ds_to_auto_pc_RVALID;
  wire [31:0]auto_ds_to_auto_pc_WDATA;
  wire auto_ds_to_auto_pc_WLAST;
  wire auto_ds_to_auto_pc_WREADY;
  wire [3:0]auto_ds_to_auto_pc_WSTRB;
  wire auto_ds_to_auto_pc_WVALID;
  wire [31:0]auto_pc_to_m03_couplers_ARADDR;
  wire auto_pc_to_m03_couplers_ARREADY;
  wire auto_pc_to_m03_couplers_ARVALID;
  wire [31:0]auto_pc_to_m03_couplers_AWADDR;
  wire auto_pc_to_m03_couplers_AWREADY;
  wire auto_pc_to_m03_couplers_AWVALID;
  wire auto_pc_to_m03_couplers_BREADY;
  wire [1:0]auto_pc_to_m03_couplers_BRESP;
  wire auto_pc_to_m03_couplers_BVALID;
  wire [31:0]auto_pc_to_m03_couplers_RDATA;
  wire auto_pc_to_m03_couplers_RREADY;
  wire [1:0]auto_pc_to_m03_couplers_RRESP;
  wire auto_pc_to_m03_couplers_RVALID;
  wire [31:0]auto_pc_to_m03_couplers_WDATA;
  wire auto_pc_to_m03_couplers_WREADY;
  wire [3:0]auto_pc_to_m03_couplers_WSTRB;
  wire auto_pc_to_m03_couplers_WVALID;
  wire [31:0]m03_couplers_to_auto_ds_ARADDR;
  wire [1:0]m03_couplers_to_auto_ds_ARBURST;
  wire [3:0]m03_couplers_to_auto_ds_ARCACHE;
  wire [7:0]m03_couplers_to_auto_ds_ARLEN;
  wire [0:0]m03_couplers_to_auto_ds_ARLOCK;
  wire [2:0]m03_couplers_to_auto_ds_ARPROT;
  wire [3:0]m03_couplers_to_auto_ds_ARQOS;
  wire m03_couplers_to_auto_ds_ARREADY;
  wire [3:0]m03_couplers_to_auto_ds_ARREGION;
  wire [2:0]m03_couplers_to_auto_ds_ARSIZE;
  wire m03_couplers_to_auto_ds_ARVALID;
  wire [31:0]m03_couplers_to_auto_ds_AWADDR;
  wire [1:0]m03_couplers_to_auto_ds_AWBURST;
  wire [3:0]m03_couplers_to_auto_ds_AWCACHE;
  wire [7:0]m03_couplers_to_auto_ds_AWLEN;
  wire [0:0]m03_couplers_to_auto_ds_AWLOCK;
  wire [2:0]m03_couplers_to_auto_ds_AWPROT;
  wire [3:0]m03_couplers_to_auto_ds_AWQOS;
  wire m03_couplers_to_auto_ds_AWREADY;
  wire [3:0]m03_couplers_to_auto_ds_AWREGION;
  wire [2:0]m03_couplers_to_auto_ds_AWSIZE;
  wire m03_couplers_to_auto_ds_AWVALID;
  wire m03_couplers_to_auto_ds_BREADY;
  wire [1:0]m03_couplers_to_auto_ds_BRESP;
  wire m03_couplers_to_auto_ds_BVALID;
  wire [511:0]m03_couplers_to_auto_ds_RDATA;
  wire m03_couplers_to_auto_ds_RLAST;
  wire m03_couplers_to_auto_ds_RREADY;
  wire [1:0]m03_couplers_to_auto_ds_RRESP;
  wire m03_couplers_to_auto_ds_RVALID;
  wire [511:0]m03_couplers_to_auto_ds_WDATA;
  wire m03_couplers_to_auto_ds_WLAST;
  wire m03_couplers_to_auto_ds_WREADY;
  wire [63:0]m03_couplers_to_auto_ds_WSTRB;
  wire m03_couplers_to_auto_ds_WVALID;

  assign M_AXI_araddr[31:0] = auto_pc_to_m03_couplers_ARADDR;
  assign M_AXI_arvalid = auto_pc_to_m03_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = auto_pc_to_m03_couplers_AWADDR;
  assign M_AXI_awvalid = auto_pc_to_m03_couplers_AWVALID;
  assign M_AXI_bready = auto_pc_to_m03_couplers_BREADY;
  assign M_AXI_rready = auto_pc_to_m03_couplers_RREADY;
  assign M_AXI_wdata[31:0] = auto_pc_to_m03_couplers_WDATA;
  assign M_AXI_wstrb[3:0] = auto_pc_to_m03_couplers_WSTRB;
  assign M_AXI_wvalid = auto_pc_to_m03_couplers_WVALID;
  assign S_ACLK_1 = S_ACLK;
  assign S_ARESETN_1 = S_ARESETN[0];
  assign S_AXI_arready = m03_couplers_to_auto_ds_ARREADY;
  assign S_AXI_awready = m03_couplers_to_auto_ds_AWREADY;
  assign S_AXI_bresp[1:0] = m03_couplers_to_auto_ds_BRESP;
  assign S_AXI_bvalid = m03_couplers_to_auto_ds_BVALID;
  assign S_AXI_rdata[511:0] = m03_couplers_to_auto_ds_RDATA;
  assign S_AXI_rlast = m03_couplers_to_auto_ds_RLAST;
  assign S_AXI_rresp[1:0] = m03_couplers_to_auto_ds_RRESP;
  assign S_AXI_rvalid = m03_couplers_to_auto_ds_RVALID;
  assign S_AXI_wready = m03_couplers_to_auto_ds_WREADY;
  assign auto_pc_to_m03_couplers_ARREADY = M_AXI_arready;
  assign auto_pc_to_m03_couplers_AWREADY = M_AXI_awready;
  assign auto_pc_to_m03_couplers_BRESP = M_AXI_bresp[1:0];
  assign auto_pc_to_m03_couplers_BVALID = M_AXI_bvalid;
  assign auto_pc_to_m03_couplers_RDATA = M_AXI_rdata[31:0];
  assign auto_pc_to_m03_couplers_RRESP = M_AXI_rresp[1:0];
  assign auto_pc_to_m03_couplers_RVALID = M_AXI_rvalid;
  assign auto_pc_to_m03_couplers_WREADY = M_AXI_wready;
  assign m03_couplers_to_auto_ds_ARADDR = S_AXI_araddr[31:0];
  assign m03_couplers_to_auto_ds_ARBURST = S_AXI_arburst[1:0];
  assign m03_couplers_to_auto_ds_ARCACHE = S_AXI_arcache[3:0];
  assign m03_couplers_to_auto_ds_ARLEN = S_AXI_arlen[7:0];
  assign m03_couplers_to_auto_ds_ARLOCK = S_AXI_arlock[0];
  assign m03_couplers_to_auto_ds_ARPROT = S_AXI_arprot[2:0];
  assign m03_couplers_to_auto_ds_ARQOS = S_AXI_arqos[3:0];
  assign m03_couplers_to_auto_ds_ARREGION = S_AXI_arregion[3:0];
  assign m03_couplers_to_auto_ds_ARSIZE = S_AXI_arsize[2:0];
  assign m03_couplers_to_auto_ds_ARVALID = S_AXI_arvalid;
  assign m03_couplers_to_auto_ds_AWADDR = S_AXI_awaddr[31:0];
  assign m03_couplers_to_auto_ds_AWBURST = S_AXI_awburst[1:0];
  assign m03_couplers_to_auto_ds_AWCACHE = S_AXI_awcache[3:0];
  assign m03_couplers_to_auto_ds_AWLEN = S_AXI_awlen[7:0];
  assign m03_couplers_to_auto_ds_AWLOCK = S_AXI_awlock[0];
  assign m03_couplers_to_auto_ds_AWPROT = S_AXI_awprot[2:0];
  assign m03_couplers_to_auto_ds_AWQOS = S_AXI_awqos[3:0];
  assign m03_couplers_to_auto_ds_AWREGION = S_AXI_awregion[3:0];
  assign m03_couplers_to_auto_ds_AWSIZE = S_AXI_awsize[2:0];
  assign m03_couplers_to_auto_ds_AWVALID = S_AXI_awvalid;
  assign m03_couplers_to_auto_ds_BREADY = S_AXI_bready;
  assign m03_couplers_to_auto_ds_RREADY = S_AXI_rready;
  assign m03_couplers_to_auto_ds_WDATA = S_AXI_wdata[511:0];
  assign m03_couplers_to_auto_ds_WLAST = S_AXI_wlast;
  assign m03_couplers_to_auto_ds_WSTRB = S_AXI_wstrb[63:0];
  assign m03_couplers_to_auto_ds_WVALID = S_AXI_wvalid;
  system_i_bak_auto_ds_3 auto_ds
       (.m_axi_araddr(auto_ds_to_auto_pc_ARADDR),
        .m_axi_arburst(auto_ds_to_auto_pc_ARBURST),
        .m_axi_arcache(auto_ds_to_auto_pc_ARCACHE),
        .m_axi_arlen(auto_ds_to_auto_pc_ARLEN),
        .m_axi_arlock(auto_ds_to_auto_pc_ARLOCK),
        .m_axi_arprot(auto_ds_to_auto_pc_ARPROT),
        .m_axi_arqos(auto_ds_to_auto_pc_ARQOS),
        .m_axi_arready(auto_ds_to_auto_pc_ARREADY),
        .m_axi_arregion(auto_ds_to_auto_pc_ARREGION),
        .m_axi_arsize(auto_ds_to_auto_pc_ARSIZE),
        .m_axi_arvalid(auto_ds_to_auto_pc_ARVALID),
        .m_axi_awaddr(auto_ds_to_auto_pc_AWADDR),
        .m_axi_awburst(auto_ds_to_auto_pc_AWBURST),
        .m_axi_awcache(auto_ds_to_auto_pc_AWCACHE),
        .m_axi_awlen(auto_ds_to_auto_pc_AWLEN),
        .m_axi_awlock(auto_ds_to_auto_pc_AWLOCK),
        .m_axi_awprot(auto_ds_to_auto_pc_AWPROT),
        .m_axi_awqos(auto_ds_to_auto_pc_AWQOS),
        .m_axi_awready(auto_ds_to_auto_pc_AWREADY),
        .m_axi_awregion(auto_ds_to_auto_pc_AWREGION),
        .m_axi_awsize(auto_ds_to_auto_pc_AWSIZE),
        .m_axi_awvalid(auto_ds_to_auto_pc_AWVALID),
        .m_axi_bready(auto_ds_to_auto_pc_BREADY),
        .m_axi_bresp(auto_ds_to_auto_pc_BRESP),
        .m_axi_bvalid(auto_ds_to_auto_pc_BVALID),
        .m_axi_rdata(auto_ds_to_auto_pc_RDATA),
        .m_axi_rlast(auto_ds_to_auto_pc_RLAST),
        .m_axi_rready(auto_ds_to_auto_pc_RREADY),
        .m_axi_rresp(auto_ds_to_auto_pc_RRESP),
        .m_axi_rvalid(auto_ds_to_auto_pc_RVALID),
        .m_axi_wdata(auto_ds_to_auto_pc_WDATA),
        .m_axi_wlast(auto_ds_to_auto_pc_WLAST),
        .m_axi_wready(auto_ds_to_auto_pc_WREADY),
        .m_axi_wstrb(auto_ds_to_auto_pc_WSTRB),
        .m_axi_wvalid(auto_ds_to_auto_pc_WVALID),
        .s_axi_aclk(S_ACLK_1),
        .s_axi_araddr(m03_couplers_to_auto_ds_ARADDR),
        .s_axi_arburst(m03_couplers_to_auto_ds_ARBURST),
        .s_axi_arcache(m03_couplers_to_auto_ds_ARCACHE),
        .s_axi_aresetn(S_ARESETN_1),
        .s_axi_arlen(m03_couplers_to_auto_ds_ARLEN),
        .s_axi_arlock(m03_couplers_to_auto_ds_ARLOCK),
        .s_axi_arprot(m03_couplers_to_auto_ds_ARPROT),
        .s_axi_arqos(m03_couplers_to_auto_ds_ARQOS),
        .s_axi_arready(m03_couplers_to_auto_ds_ARREADY),
        .s_axi_arregion(m03_couplers_to_auto_ds_ARREGION),
        .s_axi_arsize(m03_couplers_to_auto_ds_ARSIZE),
        .s_axi_arvalid(m03_couplers_to_auto_ds_ARVALID),
        .s_axi_awaddr(m03_couplers_to_auto_ds_AWADDR),
        .s_axi_awburst(m03_couplers_to_auto_ds_AWBURST),
        .s_axi_awcache(m03_couplers_to_auto_ds_AWCACHE),
        .s_axi_awlen(m03_couplers_to_auto_ds_AWLEN),
        .s_axi_awlock(m03_couplers_to_auto_ds_AWLOCK),
        .s_axi_awprot(m03_couplers_to_auto_ds_AWPROT),
        .s_axi_awqos(m03_couplers_to_auto_ds_AWQOS),
        .s_axi_awready(m03_couplers_to_auto_ds_AWREADY),
        .s_axi_awregion(m03_couplers_to_auto_ds_AWREGION),
        .s_axi_awsize(m03_couplers_to_auto_ds_AWSIZE),
        .s_axi_awvalid(m03_couplers_to_auto_ds_AWVALID),
        .s_axi_bready(m03_couplers_to_auto_ds_BREADY),
        .s_axi_bresp(m03_couplers_to_auto_ds_BRESP),
        .s_axi_bvalid(m03_couplers_to_auto_ds_BVALID),
        .s_axi_rdata(m03_couplers_to_auto_ds_RDATA),
        .s_axi_rlast(m03_couplers_to_auto_ds_RLAST),
        .s_axi_rready(m03_couplers_to_auto_ds_RREADY),
        .s_axi_rresp(m03_couplers_to_auto_ds_RRESP),
        .s_axi_rvalid(m03_couplers_to_auto_ds_RVALID),
        .s_axi_wdata(m03_couplers_to_auto_ds_WDATA),
        .s_axi_wlast(m03_couplers_to_auto_ds_WLAST),
        .s_axi_wready(m03_couplers_to_auto_ds_WREADY),
        .s_axi_wstrb(m03_couplers_to_auto_ds_WSTRB),
        .s_axi_wvalid(m03_couplers_to_auto_ds_WVALID));
  system_i_bak_auto_pc_2 auto_pc
       (.aclk(S_ACLK_1),
        .aresetn(S_ARESETN_1),
        .m_axi_araddr(auto_pc_to_m03_couplers_ARADDR),
        .m_axi_arready(auto_pc_to_m03_couplers_ARREADY),
        .m_axi_arvalid(auto_pc_to_m03_couplers_ARVALID),
        .m_axi_awaddr(auto_pc_to_m03_couplers_AWADDR),
        .m_axi_awready(auto_pc_to_m03_couplers_AWREADY),
        .m_axi_awvalid(auto_pc_to_m03_couplers_AWVALID),
        .m_axi_bready(auto_pc_to_m03_couplers_BREADY),
        .m_axi_bresp(auto_pc_to_m03_couplers_BRESP),
        .m_axi_bvalid(auto_pc_to_m03_couplers_BVALID),
        .m_axi_rdata(auto_pc_to_m03_couplers_RDATA),
        .m_axi_rready(auto_pc_to_m03_couplers_RREADY),
        .m_axi_rresp(auto_pc_to_m03_couplers_RRESP),
        .m_axi_rvalid(auto_pc_to_m03_couplers_RVALID),
        .m_axi_wdata(auto_pc_to_m03_couplers_WDATA),
        .m_axi_wready(auto_pc_to_m03_couplers_WREADY),
        .m_axi_wstrb(auto_pc_to_m03_couplers_WSTRB),
        .m_axi_wvalid(auto_pc_to_m03_couplers_WVALID),
        .s_axi_araddr(auto_ds_to_auto_pc_ARADDR),
        .s_axi_arburst(auto_ds_to_auto_pc_ARBURST),
        .s_axi_arcache(auto_ds_to_auto_pc_ARCACHE),
        .s_axi_arlen(auto_ds_to_auto_pc_ARLEN),
        .s_axi_arlock(auto_ds_to_auto_pc_ARLOCK),
        .s_axi_arprot(auto_ds_to_auto_pc_ARPROT),
        .s_axi_arqos(auto_ds_to_auto_pc_ARQOS),
        .s_axi_arready(auto_ds_to_auto_pc_ARREADY),
        .s_axi_arregion(auto_ds_to_auto_pc_ARREGION),
        .s_axi_arsize(auto_ds_to_auto_pc_ARSIZE),
        .s_axi_arvalid(auto_ds_to_auto_pc_ARVALID),
        .s_axi_awaddr(auto_ds_to_auto_pc_AWADDR),
        .s_axi_awburst(auto_ds_to_auto_pc_AWBURST),
        .s_axi_awcache(auto_ds_to_auto_pc_AWCACHE),
        .s_axi_awlen(auto_ds_to_auto_pc_AWLEN),
        .s_axi_awlock(auto_ds_to_auto_pc_AWLOCK),
        .s_axi_awprot(auto_ds_to_auto_pc_AWPROT),
        .s_axi_awqos(auto_ds_to_auto_pc_AWQOS),
        .s_axi_awready(auto_ds_to_auto_pc_AWREADY),
        .s_axi_awregion(auto_ds_to_auto_pc_AWREGION),
        .s_axi_awsize(auto_ds_to_auto_pc_AWSIZE),
        .s_axi_awvalid(auto_ds_to_auto_pc_AWVALID),
        .s_axi_bready(auto_ds_to_auto_pc_BREADY),
        .s_axi_bresp(auto_ds_to_auto_pc_BRESP),
        .s_axi_bvalid(auto_ds_to_auto_pc_BVALID),
        .s_axi_rdata(auto_ds_to_auto_pc_RDATA),
        .s_axi_rlast(auto_ds_to_auto_pc_RLAST),
        .s_axi_rready(auto_ds_to_auto_pc_RREADY),
        .s_axi_rresp(auto_ds_to_auto_pc_RRESP),
        .s_axi_rvalid(auto_ds_to_auto_pc_RVALID),
        .s_axi_wdata(auto_ds_to_auto_pc_WDATA),
        .s_axi_wlast(auto_ds_to_auto_pc_WLAST),
        .s_axi_wready(auto_ds_to_auto_pc_WREADY),
        .s_axi_wstrb(auto_ds_to_auto_pc_WSTRB),
        .s_axi_wvalid(auto_ds_to_auto_pc_WVALID));
endmodule

module m04_couplers_imp_BLOJEE
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arburst,
    S_AXI_arcache,
    S_AXI_arlen,
    S_AXI_arlock,
    S_AXI_arprot,
    S_AXI_arqos,
    S_AXI_arready,
    S_AXI_arregion,
    S_AXI_arsize,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awburst,
    S_AXI_awcache,
    S_AXI_awlen,
    S_AXI_awlock,
    S_AXI_awprot,
    S_AXI_awqos,
    S_AXI_awready,
    S_AXI_awregion,
    S_AXI_awsize,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rlast,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wlast,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input [0:0]M_ARESETN;
  output [31:0]M_AXI_araddr;
  input M_AXI_arready;
  output M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  input M_AXI_awready;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  input M_AXI_wready;
  output [3:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input [0:0]S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [1:0]S_AXI_arburst;
  input [3:0]S_AXI_arcache;
  input [7:0]S_AXI_arlen;
  input [0:0]S_AXI_arlock;
  input [2:0]S_AXI_arprot;
  input [3:0]S_AXI_arqos;
  output S_AXI_arready;
  input [3:0]S_AXI_arregion;
  input [2:0]S_AXI_arsize;
  input S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  input [1:0]S_AXI_awburst;
  input [3:0]S_AXI_awcache;
  input [7:0]S_AXI_awlen;
  input [0:0]S_AXI_awlock;
  input [2:0]S_AXI_awprot;
  input [3:0]S_AXI_awqos;
  output S_AXI_awready;
  input [3:0]S_AXI_awregion;
  input [2:0]S_AXI_awsize;
  input S_AXI_awvalid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [511:0]S_AXI_rdata;
  output S_AXI_rlast;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [511:0]S_AXI_wdata;
  input S_AXI_wlast;
  output S_AXI_wready;
  input [63:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire S_ACLK_1;
  wire [0:0]S_ARESETN_1;
  wire [31:0]auto_ds_to_auto_pc_ARADDR;
  wire [1:0]auto_ds_to_auto_pc_ARBURST;
  wire [3:0]auto_ds_to_auto_pc_ARCACHE;
  wire [7:0]auto_ds_to_auto_pc_ARLEN;
  wire [0:0]auto_ds_to_auto_pc_ARLOCK;
  wire [2:0]auto_ds_to_auto_pc_ARPROT;
  wire [3:0]auto_ds_to_auto_pc_ARQOS;
  wire auto_ds_to_auto_pc_ARREADY;
  wire [3:0]auto_ds_to_auto_pc_ARREGION;
  wire [2:0]auto_ds_to_auto_pc_ARSIZE;
  wire auto_ds_to_auto_pc_ARVALID;
  wire [31:0]auto_ds_to_auto_pc_AWADDR;
  wire [1:0]auto_ds_to_auto_pc_AWBURST;
  wire [3:0]auto_ds_to_auto_pc_AWCACHE;
  wire [7:0]auto_ds_to_auto_pc_AWLEN;
  wire [0:0]auto_ds_to_auto_pc_AWLOCK;
  wire [2:0]auto_ds_to_auto_pc_AWPROT;
  wire [3:0]auto_ds_to_auto_pc_AWQOS;
  wire auto_ds_to_auto_pc_AWREADY;
  wire [3:0]auto_ds_to_auto_pc_AWREGION;
  wire [2:0]auto_ds_to_auto_pc_AWSIZE;
  wire auto_ds_to_auto_pc_AWVALID;
  wire auto_ds_to_auto_pc_BREADY;
  wire [1:0]auto_ds_to_auto_pc_BRESP;
  wire auto_ds_to_auto_pc_BVALID;
  wire [31:0]auto_ds_to_auto_pc_RDATA;
  wire auto_ds_to_auto_pc_RLAST;
  wire auto_ds_to_auto_pc_RREADY;
  wire [1:0]auto_ds_to_auto_pc_RRESP;
  wire auto_ds_to_auto_pc_RVALID;
  wire [31:0]auto_ds_to_auto_pc_WDATA;
  wire auto_ds_to_auto_pc_WLAST;
  wire auto_ds_to_auto_pc_WREADY;
  wire [3:0]auto_ds_to_auto_pc_WSTRB;
  wire auto_ds_to_auto_pc_WVALID;
  wire [31:0]auto_pc_to_m04_couplers_ARADDR;
  wire auto_pc_to_m04_couplers_ARREADY;
  wire auto_pc_to_m04_couplers_ARVALID;
  wire [31:0]auto_pc_to_m04_couplers_AWADDR;
  wire auto_pc_to_m04_couplers_AWREADY;
  wire auto_pc_to_m04_couplers_AWVALID;
  wire auto_pc_to_m04_couplers_BREADY;
  wire [1:0]auto_pc_to_m04_couplers_BRESP;
  wire auto_pc_to_m04_couplers_BVALID;
  wire [31:0]auto_pc_to_m04_couplers_RDATA;
  wire auto_pc_to_m04_couplers_RREADY;
  wire [1:0]auto_pc_to_m04_couplers_RRESP;
  wire auto_pc_to_m04_couplers_RVALID;
  wire [31:0]auto_pc_to_m04_couplers_WDATA;
  wire auto_pc_to_m04_couplers_WREADY;
  wire [3:0]auto_pc_to_m04_couplers_WSTRB;
  wire auto_pc_to_m04_couplers_WVALID;
  wire [31:0]m04_couplers_to_auto_ds_ARADDR;
  wire [1:0]m04_couplers_to_auto_ds_ARBURST;
  wire [3:0]m04_couplers_to_auto_ds_ARCACHE;
  wire [7:0]m04_couplers_to_auto_ds_ARLEN;
  wire [0:0]m04_couplers_to_auto_ds_ARLOCK;
  wire [2:0]m04_couplers_to_auto_ds_ARPROT;
  wire [3:0]m04_couplers_to_auto_ds_ARQOS;
  wire m04_couplers_to_auto_ds_ARREADY;
  wire [3:0]m04_couplers_to_auto_ds_ARREGION;
  wire [2:0]m04_couplers_to_auto_ds_ARSIZE;
  wire m04_couplers_to_auto_ds_ARVALID;
  wire [31:0]m04_couplers_to_auto_ds_AWADDR;
  wire [1:0]m04_couplers_to_auto_ds_AWBURST;
  wire [3:0]m04_couplers_to_auto_ds_AWCACHE;
  wire [7:0]m04_couplers_to_auto_ds_AWLEN;
  wire [0:0]m04_couplers_to_auto_ds_AWLOCK;
  wire [2:0]m04_couplers_to_auto_ds_AWPROT;
  wire [3:0]m04_couplers_to_auto_ds_AWQOS;
  wire m04_couplers_to_auto_ds_AWREADY;
  wire [3:0]m04_couplers_to_auto_ds_AWREGION;
  wire [2:0]m04_couplers_to_auto_ds_AWSIZE;
  wire m04_couplers_to_auto_ds_AWVALID;
  wire m04_couplers_to_auto_ds_BREADY;
  wire [1:0]m04_couplers_to_auto_ds_BRESP;
  wire m04_couplers_to_auto_ds_BVALID;
  wire [511:0]m04_couplers_to_auto_ds_RDATA;
  wire m04_couplers_to_auto_ds_RLAST;
  wire m04_couplers_to_auto_ds_RREADY;
  wire [1:0]m04_couplers_to_auto_ds_RRESP;
  wire m04_couplers_to_auto_ds_RVALID;
  wire [511:0]m04_couplers_to_auto_ds_WDATA;
  wire m04_couplers_to_auto_ds_WLAST;
  wire m04_couplers_to_auto_ds_WREADY;
  wire [63:0]m04_couplers_to_auto_ds_WSTRB;
  wire m04_couplers_to_auto_ds_WVALID;

  assign M_AXI_araddr[31:0] = auto_pc_to_m04_couplers_ARADDR;
  assign M_AXI_arvalid = auto_pc_to_m04_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = auto_pc_to_m04_couplers_AWADDR;
  assign M_AXI_awvalid = auto_pc_to_m04_couplers_AWVALID;
  assign M_AXI_bready = auto_pc_to_m04_couplers_BREADY;
  assign M_AXI_rready = auto_pc_to_m04_couplers_RREADY;
  assign M_AXI_wdata[31:0] = auto_pc_to_m04_couplers_WDATA;
  assign M_AXI_wstrb[3:0] = auto_pc_to_m04_couplers_WSTRB;
  assign M_AXI_wvalid = auto_pc_to_m04_couplers_WVALID;
  assign S_ACLK_1 = S_ACLK;
  assign S_ARESETN_1 = S_ARESETN[0];
  assign S_AXI_arready = m04_couplers_to_auto_ds_ARREADY;
  assign S_AXI_awready = m04_couplers_to_auto_ds_AWREADY;
  assign S_AXI_bresp[1:0] = m04_couplers_to_auto_ds_BRESP;
  assign S_AXI_bvalid = m04_couplers_to_auto_ds_BVALID;
  assign S_AXI_rdata[511:0] = m04_couplers_to_auto_ds_RDATA;
  assign S_AXI_rlast = m04_couplers_to_auto_ds_RLAST;
  assign S_AXI_rresp[1:0] = m04_couplers_to_auto_ds_RRESP;
  assign S_AXI_rvalid = m04_couplers_to_auto_ds_RVALID;
  assign S_AXI_wready = m04_couplers_to_auto_ds_WREADY;
  assign auto_pc_to_m04_couplers_ARREADY = M_AXI_arready;
  assign auto_pc_to_m04_couplers_AWREADY = M_AXI_awready;
  assign auto_pc_to_m04_couplers_BRESP = M_AXI_bresp[1:0];
  assign auto_pc_to_m04_couplers_BVALID = M_AXI_bvalid;
  assign auto_pc_to_m04_couplers_RDATA = M_AXI_rdata[31:0];
  assign auto_pc_to_m04_couplers_RRESP = M_AXI_rresp[1:0];
  assign auto_pc_to_m04_couplers_RVALID = M_AXI_rvalid;
  assign auto_pc_to_m04_couplers_WREADY = M_AXI_wready;
  assign m04_couplers_to_auto_ds_ARADDR = S_AXI_araddr[31:0];
  assign m04_couplers_to_auto_ds_ARBURST = S_AXI_arburst[1:0];
  assign m04_couplers_to_auto_ds_ARCACHE = S_AXI_arcache[3:0];
  assign m04_couplers_to_auto_ds_ARLEN = S_AXI_arlen[7:0];
  assign m04_couplers_to_auto_ds_ARLOCK = S_AXI_arlock[0];
  assign m04_couplers_to_auto_ds_ARPROT = S_AXI_arprot[2:0];
  assign m04_couplers_to_auto_ds_ARQOS = S_AXI_arqos[3:0];
  assign m04_couplers_to_auto_ds_ARREGION = S_AXI_arregion[3:0];
  assign m04_couplers_to_auto_ds_ARSIZE = S_AXI_arsize[2:0];
  assign m04_couplers_to_auto_ds_ARVALID = S_AXI_arvalid;
  assign m04_couplers_to_auto_ds_AWADDR = S_AXI_awaddr[31:0];
  assign m04_couplers_to_auto_ds_AWBURST = S_AXI_awburst[1:0];
  assign m04_couplers_to_auto_ds_AWCACHE = S_AXI_awcache[3:0];
  assign m04_couplers_to_auto_ds_AWLEN = S_AXI_awlen[7:0];
  assign m04_couplers_to_auto_ds_AWLOCK = S_AXI_awlock[0];
  assign m04_couplers_to_auto_ds_AWPROT = S_AXI_awprot[2:0];
  assign m04_couplers_to_auto_ds_AWQOS = S_AXI_awqos[3:0];
  assign m04_couplers_to_auto_ds_AWREGION = S_AXI_awregion[3:0];
  assign m04_couplers_to_auto_ds_AWSIZE = S_AXI_awsize[2:0];
  assign m04_couplers_to_auto_ds_AWVALID = S_AXI_awvalid;
  assign m04_couplers_to_auto_ds_BREADY = S_AXI_bready;
  assign m04_couplers_to_auto_ds_RREADY = S_AXI_rready;
  assign m04_couplers_to_auto_ds_WDATA = S_AXI_wdata[511:0];
  assign m04_couplers_to_auto_ds_WLAST = S_AXI_wlast;
  assign m04_couplers_to_auto_ds_WSTRB = S_AXI_wstrb[63:0];
  assign m04_couplers_to_auto_ds_WVALID = S_AXI_wvalid;
  system_i_bak_auto_ds_4 auto_ds
       (.m_axi_araddr(auto_ds_to_auto_pc_ARADDR),
        .m_axi_arburst(auto_ds_to_auto_pc_ARBURST),
        .m_axi_arcache(auto_ds_to_auto_pc_ARCACHE),
        .m_axi_arlen(auto_ds_to_auto_pc_ARLEN),
        .m_axi_arlock(auto_ds_to_auto_pc_ARLOCK),
        .m_axi_arprot(auto_ds_to_auto_pc_ARPROT),
        .m_axi_arqos(auto_ds_to_auto_pc_ARQOS),
        .m_axi_arready(auto_ds_to_auto_pc_ARREADY),
        .m_axi_arregion(auto_ds_to_auto_pc_ARREGION),
        .m_axi_arsize(auto_ds_to_auto_pc_ARSIZE),
        .m_axi_arvalid(auto_ds_to_auto_pc_ARVALID),
        .m_axi_awaddr(auto_ds_to_auto_pc_AWADDR),
        .m_axi_awburst(auto_ds_to_auto_pc_AWBURST),
        .m_axi_awcache(auto_ds_to_auto_pc_AWCACHE),
        .m_axi_awlen(auto_ds_to_auto_pc_AWLEN),
        .m_axi_awlock(auto_ds_to_auto_pc_AWLOCK),
        .m_axi_awprot(auto_ds_to_auto_pc_AWPROT),
        .m_axi_awqos(auto_ds_to_auto_pc_AWQOS),
        .m_axi_awready(auto_ds_to_auto_pc_AWREADY),
        .m_axi_awregion(auto_ds_to_auto_pc_AWREGION),
        .m_axi_awsize(auto_ds_to_auto_pc_AWSIZE),
        .m_axi_awvalid(auto_ds_to_auto_pc_AWVALID),
        .m_axi_bready(auto_ds_to_auto_pc_BREADY),
        .m_axi_bresp(auto_ds_to_auto_pc_BRESP),
        .m_axi_bvalid(auto_ds_to_auto_pc_BVALID),
        .m_axi_rdata(auto_ds_to_auto_pc_RDATA),
        .m_axi_rlast(auto_ds_to_auto_pc_RLAST),
        .m_axi_rready(auto_ds_to_auto_pc_RREADY),
        .m_axi_rresp(auto_ds_to_auto_pc_RRESP),
        .m_axi_rvalid(auto_ds_to_auto_pc_RVALID),
        .m_axi_wdata(auto_ds_to_auto_pc_WDATA),
        .m_axi_wlast(auto_ds_to_auto_pc_WLAST),
        .m_axi_wready(auto_ds_to_auto_pc_WREADY),
        .m_axi_wstrb(auto_ds_to_auto_pc_WSTRB),
        .m_axi_wvalid(auto_ds_to_auto_pc_WVALID),
        .s_axi_aclk(S_ACLK_1),
        .s_axi_araddr(m04_couplers_to_auto_ds_ARADDR),
        .s_axi_arburst(m04_couplers_to_auto_ds_ARBURST),
        .s_axi_arcache(m04_couplers_to_auto_ds_ARCACHE),
        .s_axi_aresetn(S_ARESETN_1),
        .s_axi_arlen(m04_couplers_to_auto_ds_ARLEN),
        .s_axi_arlock(m04_couplers_to_auto_ds_ARLOCK),
        .s_axi_arprot(m04_couplers_to_auto_ds_ARPROT),
        .s_axi_arqos(m04_couplers_to_auto_ds_ARQOS),
        .s_axi_arready(m04_couplers_to_auto_ds_ARREADY),
        .s_axi_arregion(m04_couplers_to_auto_ds_ARREGION),
        .s_axi_arsize(m04_couplers_to_auto_ds_ARSIZE),
        .s_axi_arvalid(m04_couplers_to_auto_ds_ARVALID),
        .s_axi_awaddr(m04_couplers_to_auto_ds_AWADDR),
        .s_axi_awburst(m04_couplers_to_auto_ds_AWBURST),
        .s_axi_awcache(m04_couplers_to_auto_ds_AWCACHE),
        .s_axi_awlen(m04_couplers_to_auto_ds_AWLEN),
        .s_axi_awlock(m04_couplers_to_auto_ds_AWLOCK),
        .s_axi_awprot(m04_couplers_to_auto_ds_AWPROT),
        .s_axi_awqos(m04_couplers_to_auto_ds_AWQOS),
        .s_axi_awready(m04_couplers_to_auto_ds_AWREADY),
        .s_axi_awregion(m04_couplers_to_auto_ds_AWREGION),
        .s_axi_awsize(m04_couplers_to_auto_ds_AWSIZE),
        .s_axi_awvalid(m04_couplers_to_auto_ds_AWVALID),
        .s_axi_bready(m04_couplers_to_auto_ds_BREADY),
        .s_axi_bresp(m04_couplers_to_auto_ds_BRESP),
        .s_axi_bvalid(m04_couplers_to_auto_ds_BVALID),
        .s_axi_rdata(m04_couplers_to_auto_ds_RDATA),
        .s_axi_rlast(m04_couplers_to_auto_ds_RLAST),
        .s_axi_rready(m04_couplers_to_auto_ds_RREADY),
        .s_axi_rresp(m04_couplers_to_auto_ds_RRESP),
        .s_axi_rvalid(m04_couplers_to_auto_ds_RVALID),
        .s_axi_wdata(m04_couplers_to_auto_ds_WDATA),
        .s_axi_wlast(m04_couplers_to_auto_ds_WLAST),
        .s_axi_wready(m04_couplers_to_auto_ds_WREADY),
        .s_axi_wstrb(m04_couplers_to_auto_ds_WSTRB),
        .s_axi_wvalid(m04_couplers_to_auto_ds_WVALID));
  system_i_bak_auto_pc_3 auto_pc
       (.aclk(S_ACLK_1),
        .aresetn(S_ARESETN_1),
        .m_axi_araddr(auto_pc_to_m04_couplers_ARADDR),
        .m_axi_arready(auto_pc_to_m04_couplers_ARREADY),
        .m_axi_arvalid(auto_pc_to_m04_couplers_ARVALID),
        .m_axi_awaddr(auto_pc_to_m04_couplers_AWADDR),
        .m_axi_awready(auto_pc_to_m04_couplers_AWREADY),
        .m_axi_awvalid(auto_pc_to_m04_couplers_AWVALID),
        .m_axi_bready(auto_pc_to_m04_couplers_BREADY),
        .m_axi_bresp(auto_pc_to_m04_couplers_BRESP),
        .m_axi_bvalid(auto_pc_to_m04_couplers_BVALID),
        .m_axi_rdata(auto_pc_to_m04_couplers_RDATA),
        .m_axi_rready(auto_pc_to_m04_couplers_RREADY),
        .m_axi_rresp(auto_pc_to_m04_couplers_RRESP),
        .m_axi_rvalid(auto_pc_to_m04_couplers_RVALID),
        .m_axi_wdata(auto_pc_to_m04_couplers_WDATA),
        .m_axi_wready(auto_pc_to_m04_couplers_WREADY),
        .m_axi_wstrb(auto_pc_to_m04_couplers_WSTRB),
        .m_axi_wvalid(auto_pc_to_m04_couplers_WVALID),
        .s_axi_araddr(auto_ds_to_auto_pc_ARADDR),
        .s_axi_arburst(auto_ds_to_auto_pc_ARBURST),
        .s_axi_arcache(auto_ds_to_auto_pc_ARCACHE),
        .s_axi_arlen(auto_ds_to_auto_pc_ARLEN),
        .s_axi_arlock(auto_ds_to_auto_pc_ARLOCK),
        .s_axi_arprot(auto_ds_to_auto_pc_ARPROT),
        .s_axi_arqos(auto_ds_to_auto_pc_ARQOS),
        .s_axi_arready(auto_ds_to_auto_pc_ARREADY),
        .s_axi_arregion(auto_ds_to_auto_pc_ARREGION),
        .s_axi_arsize(auto_ds_to_auto_pc_ARSIZE),
        .s_axi_arvalid(auto_ds_to_auto_pc_ARVALID),
        .s_axi_awaddr(auto_ds_to_auto_pc_AWADDR),
        .s_axi_awburst(auto_ds_to_auto_pc_AWBURST),
        .s_axi_awcache(auto_ds_to_auto_pc_AWCACHE),
        .s_axi_awlen(auto_ds_to_auto_pc_AWLEN),
        .s_axi_awlock(auto_ds_to_auto_pc_AWLOCK),
        .s_axi_awprot(auto_ds_to_auto_pc_AWPROT),
        .s_axi_awqos(auto_ds_to_auto_pc_AWQOS),
        .s_axi_awready(auto_ds_to_auto_pc_AWREADY),
        .s_axi_awregion(auto_ds_to_auto_pc_AWREGION),
        .s_axi_awsize(auto_ds_to_auto_pc_AWSIZE),
        .s_axi_awvalid(auto_ds_to_auto_pc_AWVALID),
        .s_axi_bready(auto_ds_to_auto_pc_BREADY),
        .s_axi_bresp(auto_ds_to_auto_pc_BRESP),
        .s_axi_bvalid(auto_ds_to_auto_pc_BVALID),
        .s_axi_rdata(auto_ds_to_auto_pc_RDATA),
        .s_axi_rlast(auto_ds_to_auto_pc_RLAST),
        .s_axi_rready(auto_ds_to_auto_pc_RREADY),
        .s_axi_rresp(auto_ds_to_auto_pc_RRESP),
        .s_axi_rvalid(auto_ds_to_auto_pc_RVALID),
        .s_axi_wdata(auto_ds_to_auto_pc_WDATA),
        .s_axi_wlast(auto_ds_to_auto_pc_WLAST),
        .s_axi_wready(auto_ds_to_auto_pc_WREADY),
        .s_axi_wstrb(auto_ds_to_auto_pc_WSTRB),
        .s_axi_wvalid(auto_ds_to_auto_pc_WVALID));
endmodule

module m05_couplers_imp_HH0EEU
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arburst,
    S_AXI_arcache,
    S_AXI_arlen,
    S_AXI_arlock,
    S_AXI_arprot,
    S_AXI_arqos,
    S_AXI_arready,
    S_AXI_arregion,
    S_AXI_arsize,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awburst,
    S_AXI_awcache,
    S_AXI_awlen,
    S_AXI_awlock,
    S_AXI_awprot,
    S_AXI_awqos,
    S_AXI_awready,
    S_AXI_awregion,
    S_AXI_awsize,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rlast,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wlast,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input [0:0]M_ARESETN;
  output [31:0]M_AXI_araddr;
  input M_AXI_arready;
  output M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  input M_AXI_awready;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  input M_AXI_wready;
  output [3:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input [0:0]S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [1:0]S_AXI_arburst;
  input [3:0]S_AXI_arcache;
  input [7:0]S_AXI_arlen;
  input [0:0]S_AXI_arlock;
  input [2:0]S_AXI_arprot;
  input [3:0]S_AXI_arqos;
  output S_AXI_arready;
  input [3:0]S_AXI_arregion;
  input [2:0]S_AXI_arsize;
  input S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  input [1:0]S_AXI_awburst;
  input [3:0]S_AXI_awcache;
  input [7:0]S_AXI_awlen;
  input [0:0]S_AXI_awlock;
  input [2:0]S_AXI_awprot;
  input [3:0]S_AXI_awqos;
  output S_AXI_awready;
  input [3:0]S_AXI_awregion;
  input [2:0]S_AXI_awsize;
  input S_AXI_awvalid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [511:0]S_AXI_rdata;
  output S_AXI_rlast;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [511:0]S_AXI_wdata;
  input S_AXI_wlast;
  output S_AXI_wready;
  input [63:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire S_ACLK_1;
  wire [0:0]S_ARESETN_1;
  wire [31:0]auto_ds_to_auto_pc_ARADDR;
  wire [1:0]auto_ds_to_auto_pc_ARBURST;
  wire [3:0]auto_ds_to_auto_pc_ARCACHE;
  wire [7:0]auto_ds_to_auto_pc_ARLEN;
  wire [0:0]auto_ds_to_auto_pc_ARLOCK;
  wire [2:0]auto_ds_to_auto_pc_ARPROT;
  wire [3:0]auto_ds_to_auto_pc_ARQOS;
  wire auto_ds_to_auto_pc_ARREADY;
  wire [3:0]auto_ds_to_auto_pc_ARREGION;
  wire [2:0]auto_ds_to_auto_pc_ARSIZE;
  wire auto_ds_to_auto_pc_ARVALID;
  wire [31:0]auto_ds_to_auto_pc_AWADDR;
  wire [1:0]auto_ds_to_auto_pc_AWBURST;
  wire [3:0]auto_ds_to_auto_pc_AWCACHE;
  wire [7:0]auto_ds_to_auto_pc_AWLEN;
  wire [0:0]auto_ds_to_auto_pc_AWLOCK;
  wire [2:0]auto_ds_to_auto_pc_AWPROT;
  wire [3:0]auto_ds_to_auto_pc_AWQOS;
  wire auto_ds_to_auto_pc_AWREADY;
  wire [3:0]auto_ds_to_auto_pc_AWREGION;
  wire [2:0]auto_ds_to_auto_pc_AWSIZE;
  wire auto_ds_to_auto_pc_AWVALID;
  wire auto_ds_to_auto_pc_BREADY;
  wire [1:0]auto_ds_to_auto_pc_BRESP;
  wire auto_ds_to_auto_pc_BVALID;
  wire [31:0]auto_ds_to_auto_pc_RDATA;
  wire auto_ds_to_auto_pc_RLAST;
  wire auto_ds_to_auto_pc_RREADY;
  wire [1:0]auto_ds_to_auto_pc_RRESP;
  wire auto_ds_to_auto_pc_RVALID;
  wire [31:0]auto_ds_to_auto_pc_WDATA;
  wire auto_ds_to_auto_pc_WLAST;
  wire auto_ds_to_auto_pc_WREADY;
  wire [3:0]auto_ds_to_auto_pc_WSTRB;
  wire auto_ds_to_auto_pc_WVALID;
  wire [31:0]auto_pc_to_m05_couplers_ARADDR;
  wire auto_pc_to_m05_couplers_ARREADY;
  wire auto_pc_to_m05_couplers_ARVALID;
  wire [31:0]auto_pc_to_m05_couplers_AWADDR;
  wire auto_pc_to_m05_couplers_AWREADY;
  wire auto_pc_to_m05_couplers_AWVALID;
  wire auto_pc_to_m05_couplers_BREADY;
  wire [1:0]auto_pc_to_m05_couplers_BRESP;
  wire auto_pc_to_m05_couplers_BVALID;
  wire [31:0]auto_pc_to_m05_couplers_RDATA;
  wire auto_pc_to_m05_couplers_RREADY;
  wire [1:0]auto_pc_to_m05_couplers_RRESP;
  wire auto_pc_to_m05_couplers_RVALID;
  wire [31:0]auto_pc_to_m05_couplers_WDATA;
  wire auto_pc_to_m05_couplers_WREADY;
  wire [3:0]auto_pc_to_m05_couplers_WSTRB;
  wire auto_pc_to_m05_couplers_WVALID;
  wire [31:0]m05_couplers_to_auto_ds_ARADDR;
  wire [1:0]m05_couplers_to_auto_ds_ARBURST;
  wire [3:0]m05_couplers_to_auto_ds_ARCACHE;
  wire [7:0]m05_couplers_to_auto_ds_ARLEN;
  wire [0:0]m05_couplers_to_auto_ds_ARLOCK;
  wire [2:0]m05_couplers_to_auto_ds_ARPROT;
  wire [3:0]m05_couplers_to_auto_ds_ARQOS;
  wire m05_couplers_to_auto_ds_ARREADY;
  wire [3:0]m05_couplers_to_auto_ds_ARREGION;
  wire [2:0]m05_couplers_to_auto_ds_ARSIZE;
  wire m05_couplers_to_auto_ds_ARVALID;
  wire [31:0]m05_couplers_to_auto_ds_AWADDR;
  wire [1:0]m05_couplers_to_auto_ds_AWBURST;
  wire [3:0]m05_couplers_to_auto_ds_AWCACHE;
  wire [7:0]m05_couplers_to_auto_ds_AWLEN;
  wire [0:0]m05_couplers_to_auto_ds_AWLOCK;
  wire [2:0]m05_couplers_to_auto_ds_AWPROT;
  wire [3:0]m05_couplers_to_auto_ds_AWQOS;
  wire m05_couplers_to_auto_ds_AWREADY;
  wire [3:0]m05_couplers_to_auto_ds_AWREGION;
  wire [2:0]m05_couplers_to_auto_ds_AWSIZE;
  wire m05_couplers_to_auto_ds_AWVALID;
  wire m05_couplers_to_auto_ds_BREADY;
  wire [1:0]m05_couplers_to_auto_ds_BRESP;
  wire m05_couplers_to_auto_ds_BVALID;
  wire [511:0]m05_couplers_to_auto_ds_RDATA;
  wire m05_couplers_to_auto_ds_RLAST;
  wire m05_couplers_to_auto_ds_RREADY;
  wire [1:0]m05_couplers_to_auto_ds_RRESP;
  wire m05_couplers_to_auto_ds_RVALID;
  wire [511:0]m05_couplers_to_auto_ds_WDATA;
  wire m05_couplers_to_auto_ds_WLAST;
  wire m05_couplers_to_auto_ds_WREADY;
  wire [63:0]m05_couplers_to_auto_ds_WSTRB;
  wire m05_couplers_to_auto_ds_WVALID;

  assign M_AXI_araddr[31:0] = auto_pc_to_m05_couplers_ARADDR;
  assign M_AXI_arvalid = auto_pc_to_m05_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = auto_pc_to_m05_couplers_AWADDR;
  assign M_AXI_awvalid = auto_pc_to_m05_couplers_AWVALID;
  assign M_AXI_bready = auto_pc_to_m05_couplers_BREADY;
  assign M_AXI_rready = auto_pc_to_m05_couplers_RREADY;
  assign M_AXI_wdata[31:0] = auto_pc_to_m05_couplers_WDATA;
  assign M_AXI_wstrb[3:0] = auto_pc_to_m05_couplers_WSTRB;
  assign M_AXI_wvalid = auto_pc_to_m05_couplers_WVALID;
  assign S_ACLK_1 = S_ACLK;
  assign S_ARESETN_1 = S_ARESETN[0];
  assign S_AXI_arready = m05_couplers_to_auto_ds_ARREADY;
  assign S_AXI_awready = m05_couplers_to_auto_ds_AWREADY;
  assign S_AXI_bresp[1:0] = m05_couplers_to_auto_ds_BRESP;
  assign S_AXI_bvalid = m05_couplers_to_auto_ds_BVALID;
  assign S_AXI_rdata[511:0] = m05_couplers_to_auto_ds_RDATA;
  assign S_AXI_rlast = m05_couplers_to_auto_ds_RLAST;
  assign S_AXI_rresp[1:0] = m05_couplers_to_auto_ds_RRESP;
  assign S_AXI_rvalid = m05_couplers_to_auto_ds_RVALID;
  assign S_AXI_wready = m05_couplers_to_auto_ds_WREADY;
  assign auto_pc_to_m05_couplers_ARREADY = M_AXI_arready;
  assign auto_pc_to_m05_couplers_AWREADY = M_AXI_awready;
  assign auto_pc_to_m05_couplers_BRESP = M_AXI_bresp[1:0];
  assign auto_pc_to_m05_couplers_BVALID = M_AXI_bvalid;
  assign auto_pc_to_m05_couplers_RDATA = M_AXI_rdata[31:0];
  assign auto_pc_to_m05_couplers_RRESP = M_AXI_rresp[1:0];
  assign auto_pc_to_m05_couplers_RVALID = M_AXI_rvalid;
  assign auto_pc_to_m05_couplers_WREADY = M_AXI_wready;
  assign m05_couplers_to_auto_ds_ARADDR = S_AXI_araddr[31:0];
  assign m05_couplers_to_auto_ds_ARBURST = S_AXI_arburst[1:0];
  assign m05_couplers_to_auto_ds_ARCACHE = S_AXI_arcache[3:0];
  assign m05_couplers_to_auto_ds_ARLEN = S_AXI_arlen[7:0];
  assign m05_couplers_to_auto_ds_ARLOCK = S_AXI_arlock[0];
  assign m05_couplers_to_auto_ds_ARPROT = S_AXI_arprot[2:0];
  assign m05_couplers_to_auto_ds_ARQOS = S_AXI_arqos[3:0];
  assign m05_couplers_to_auto_ds_ARREGION = S_AXI_arregion[3:0];
  assign m05_couplers_to_auto_ds_ARSIZE = S_AXI_arsize[2:0];
  assign m05_couplers_to_auto_ds_ARVALID = S_AXI_arvalid;
  assign m05_couplers_to_auto_ds_AWADDR = S_AXI_awaddr[31:0];
  assign m05_couplers_to_auto_ds_AWBURST = S_AXI_awburst[1:0];
  assign m05_couplers_to_auto_ds_AWCACHE = S_AXI_awcache[3:0];
  assign m05_couplers_to_auto_ds_AWLEN = S_AXI_awlen[7:0];
  assign m05_couplers_to_auto_ds_AWLOCK = S_AXI_awlock[0];
  assign m05_couplers_to_auto_ds_AWPROT = S_AXI_awprot[2:0];
  assign m05_couplers_to_auto_ds_AWQOS = S_AXI_awqos[3:0];
  assign m05_couplers_to_auto_ds_AWREGION = S_AXI_awregion[3:0];
  assign m05_couplers_to_auto_ds_AWSIZE = S_AXI_awsize[2:0];
  assign m05_couplers_to_auto_ds_AWVALID = S_AXI_awvalid;
  assign m05_couplers_to_auto_ds_BREADY = S_AXI_bready;
  assign m05_couplers_to_auto_ds_RREADY = S_AXI_rready;
  assign m05_couplers_to_auto_ds_WDATA = S_AXI_wdata[511:0];
  assign m05_couplers_to_auto_ds_WLAST = S_AXI_wlast;
  assign m05_couplers_to_auto_ds_WSTRB = S_AXI_wstrb[63:0];
  assign m05_couplers_to_auto_ds_WVALID = S_AXI_wvalid;
  system_i_bak_auto_ds_5 auto_ds
       (.m_axi_araddr(auto_ds_to_auto_pc_ARADDR),
        .m_axi_arburst(auto_ds_to_auto_pc_ARBURST),
        .m_axi_arcache(auto_ds_to_auto_pc_ARCACHE),
        .m_axi_arlen(auto_ds_to_auto_pc_ARLEN),
        .m_axi_arlock(auto_ds_to_auto_pc_ARLOCK),
        .m_axi_arprot(auto_ds_to_auto_pc_ARPROT),
        .m_axi_arqos(auto_ds_to_auto_pc_ARQOS),
        .m_axi_arready(auto_ds_to_auto_pc_ARREADY),
        .m_axi_arregion(auto_ds_to_auto_pc_ARREGION),
        .m_axi_arsize(auto_ds_to_auto_pc_ARSIZE),
        .m_axi_arvalid(auto_ds_to_auto_pc_ARVALID),
        .m_axi_awaddr(auto_ds_to_auto_pc_AWADDR),
        .m_axi_awburst(auto_ds_to_auto_pc_AWBURST),
        .m_axi_awcache(auto_ds_to_auto_pc_AWCACHE),
        .m_axi_awlen(auto_ds_to_auto_pc_AWLEN),
        .m_axi_awlock(auto_ds_to_auto_pc_AWLOCK),
        .m_axi_awprot(auto_ds_to_auto_pc_AWPROT),
        .m_axi_awqos(auto_ds_to_auto_pc_AWQOS),
        .m_axi_awready(auto_ds_to_auto_pc_AWREADY),
        .m_axi_awregion(auto_ds_to_auto_pc_AWREGION),
        .m_axi_awsize(auto_ds_to_auto_pc_AWSIZE),
        .m_axi_awvalid(auto_ds_to_auto_pc_AWVALID),
        .m_axi_bready(auto_ds_to_auto_pc_BREADY),
        .m_axi_bresp(auto_ds_to_auto_pc_BRESP),
        .m_axi_bvalid(auto_ds_to_auto_pc_BVALID),
        .m_axi_rdata(auto_ds_to_auto_pc_RDATA),
        .m_axi_rlast(auto_ds_to_auto_pc_RLAST),
        .m_axi_rready(auto_ds_to_auto_pc_RREADY),
        .m_axi_rresp(auto_ds_to_auto_pc_RRESP),
        .m_axi_rvalid(auto_ds_to_auto_pc_RVALID),
        .m_axi_wdata(auto_ds_to_auto_pc_WDATA),
        .m_axi_wlast(auto_ds_to_auto_pc_WLAST),
        .m_axi_wready(auto_ds_to_auto_pc_WREADY),
        .m_axi_wstrb(auto_ds_to_auto_pc_WSTRB),
        .m_axi_wvalid(auto_ds_to_auto_pc_WVALID),
        .s_axi_aclk(S_ACLK_1),
        .s_axi_araddr(m05_couplers_to_auto_ds_ARADDR),
        .s_axi_arburst(m05_couplers_to_auto_ds_ARBURST),
        .s_axi_arcache(m05_couplers_to_auto_ds_ARCACHE),
        .s_axi_aresetn(S_ARESETN_1),
        .s_axi_arlen(m05_couplers_to_auto_ds_ARLEN),
        .s_axi_arlock(m05_couplers_to_auto_ds_ARLOCK),
        .s_axi_arprot(m05_couplers_to_auto_ds_ARPROT),
        .s_axi_arqos(m05_couplers_to_auto_ds_ARQOS),
        .s_axi_arready(m05_couplers_to_auto_ds_ARREADY),
        .s_axi_arregion(m05_couplers_to_auto_ds_ARREGION),
        .s_axi_arsize(m05_couplers_to_auto_ds_ARSIZE),
        .s_axi_arvalid(m05_couplers_to_auto_ds_ARVALID),
        .s_axi_awaddr(m05_couplers_to_auto_ds_AWADDR),
        .s_axi_awburst(m05_couplers_to_auto_ds_AWBURST),
        .s_axi_awcache(m05_couplers_to_auto_ds_AWCACHE),
        .s_axi_awlen(m05_couplers_to_auto_ds_AWLEN),
        .s_axi_awlock(m05_couplers_to_auto_ds_AWLOCK),
        .s_axi_awprot(m05_couplers_to_auto_ds_AWPROT),
        .s_axi_awqos(m05_couplers_to_auto_ds_AWQOS),
        .s_axi_awready(m05_couplers_to_auto_ds_AWREADY),
        .s_axi_awregion(m05_couplers_to_auto_ds_AWREGION),
        .s_axi_awsize(m05_couplers_to_auto_ds_AWSIZE),
        .s_axi_awvalid(m05_couplers_to_auto_ds_AWVALID),
        .s_axi_bready(m05_couplers_to_auto_ds_BREADY),
        .s_axi_bresp(m05_couplers_to_auto_ds_BRESP),
        .s_axi_bvalid(m05_couplers_to_auto_ds_BVALID),
        .s_axi_rdata(m05_couplers_to_auto_ds_RDATA),
        .s_axi_rlast(m05_couplers_to_auto_ds_RLAST),
        .s_axi_rready(m05_couplers_to_auto_ds_RREADY),
        .s_axi_rresp(m05_couplers_to_auto_ds_RRESP),
        .s_axi_rvalid(m05_couplers_to_auto_ds_RVALID),
        .s_axi_wdata(m05_couplers_to_auto_ds_WDATA),
        .s_axi_wlast(m05_couplers_to_auto_ds_WLAST),
        .s_axi_wready(m05_couplers_to_auto_ds_WREADY),
        .s_axi_wstrb(m05_couplers_to_auto_ds_WSTRB),
        .s_axi_wvalid(m05_couplers_to_auto_ds_WVALID));
  system_i_bak_auto_pc_4 auto_pc
       (.aclk(S_ACLK_1),
        .aresetn(S_ARESETN_1),
        .m_axi_araddr(auto_pc_to_m05_couplers_ARADDR),
        .m_axi_arready(auto_pc_to_m05_couplers_ARREADY),
        .m_axi_arvalid(auto_pc_to_m05_couplers_ARVALID),
        .m_axi_awaddr(auto_pc_to_m05_couplers_AWADDR),
        .m_axi_awready(auto_pc_to_m05_couplers_AWREADY),
        .m_axi_awvalid(auto_pc_to_m05_couplers_AWVALID),
        .m_axi_bready(auto_pc_to_m05_couplers_BREADY),
        .m_axi_bresp(auto_pc_to_m05_couplers_BRESP),
        .m_axi_bvalid(auto_pc_to_m05_couplers_BVALID),
        .m_axi_rdata(auto_pc_to_m05_couplers_RDATA),
        .m_axi_rready(auto_pc_to_m05_couplers_RREADY),
        .m_axi_rresp(auto_pc_to_m05_couplers_RRESP),
        .m_axi_rvalid(auto_pc_to_m05_couplers_RVALID),
        .m_axi_wdata(auto_pc_to_m05_couplers_WDATA),
        .m_axi_wready(auto_pc_to_m05_couplers_WREADY),
        .m_axi_wstrb(auto_pc_to_m05_couplers_WSTRB),
        .m_axi_wvalid(auto_pc_to_m05_couplers_WVALID),
        .s_axi_araddr(auto_ds_to_auto_pc_ARADDR),
        .s_axi_arburst(auto_ds_to_auto_pc_ARBURST),
        .s_axi_arcache(auto_ds_to_auto_pc_ARCACHE),
        .s_axi_arlen(auto_ds_to_auto_pc_ARLEN),
        .s_axi_arlock(auto_ds_to_auto_pc_ARLOCK),
        .s_axi_arprot(auto_ds_to_auto_pc_ARPROT),
        .s_axi_arqos(auto_ds_to_auto_pc_ARQOS),
        .s_axi_arready(auto_ds_to_auto_pc_ARREADY),
        .s_axi_arregion(auto_ds_to_auto_pc_ARREGION),
        .s_axi_arsize(auto_ds_to_auto_pc_ARSIZE),
        .s_axi_arvalid(auto_ds_to_auto_pc_ARVALID),
        .s_axi_awaddr(auto_ds_to_auto_pc_AWADDR),
        .s_axi_awburst(auto_ds_to_auto_pc_AWBURST),
        .s_axi_awcache(auto_ds_to_auto_pc_AWCACHE),
        .s_axi_awlen(auto_ds_to_auto_pc_AWLEN),
        .s_axi_awlock(auto_ds_to_auto_pc_AWLOCK),
        .s_axi_awprot(auto_ds_to_auto_pc_AWPROT),
        .s_axi_awqos(auto_ds_to_auto_pc_AWQOS),
        .s_axi_awready(auto_ds_to_auto_pc_AWREADY),
        .s_axi_awregion(auto_ds_to_auto_pc_AWREGION),
        .s_axi_awsize(auto_ds_to_auto_pc_AWSIZE),
        .s_axi_awvalid(auto_ds_to_auto_pc_AWVALID),
        .s_axi_bready(auto_ds_to_auto_pc_BREADY),
        .s_axi_bresp(auto_ds_to_auto_pc_BRESP),
        .s_axi_bvalid(auto_ds_to_auto_pc_BVALID),
        .s_axi_rdata(auto_ds_to_auto_pc_RDATA),
        .s_axi_rlast(auto_ds_to_auto_pc_RLAST),
        .s_axi_rready(auto_ds_to_auto_pc_RREADY),
        .s_axi_rresp(auto_ds_to_auto_pc_RRESP),
        .s_axi_rvalid(auto_ds_to_auto_pc_RVALID),
        .s_axi_wdata(auto_ds_to_auto_pc_WDATA),
        .s_axi_wlast(auto_ds_to_auto_pc_WLAST),
        .s_axi_wready(auto_ds_to_auto_pc_WREADY),
        .s_axi_wstrb(auto_ds_to_auto_pc_WSTRB),
        .s_axi_wvalid(auto_ds_to_auto_pc_WVALID));
endmodule

module m06_couplers_imp_22XKMU
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arburst,
    S_AXI_arcache,
    S_AXI_arlen,
    S_AXI_arlock,
    S_AXI_arprot,
    S_AXI_arqos,
    S_AXI_arready,
    S_AXI_arregion,
    S_AXI_arsize,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awburst,
    S_AXI_awcache,
    S_AXI_awlen,
    S_AXI_awlock,
    S_AXI_awprot,
    S_AXI_awqos,
    S_AXI_awready,
    S_AXI_awregion,
    S_AXI_awsize,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rlast,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wlast,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input [0:0]M_ARESETN;
  output [31:0]M_AXI_araddr;
  input M_AXI_arready;
  output M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  input M_AXI_awready;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  input M_AXI_wready;
  output [3:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input [0:0]S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [1:0]S_AXI_arburst;
  input [3:0]S_AXI_arcache;
  input [7:0]S_AXI_arlen;
  input [0:0]S_AXI_arlock;
  input [2:0]S_AXI_arprot;
  input [3:0]S_AXI_arqos;
  output S_AXI_arready;
  input [3:0]S_AXI_arregion;
  input [2:0]S_AXI_arsize;
  input S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  input [1:0]S_AXI_awburst;
  input [3:0]S_AXI_awcache;
  input [7:0]S_AXI_awlen;
  input [0:0]S_AXI_awlock;
  input [2:0]S_AXI_awprot;
  input [3:0]S_AXI_awqos;
  output S_AXI_awready;
  input [3:0]S_AXI_awregion;
  input [2:0]S_AXI_awsize;
  input S_AXI_awvalid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [511:0]S_AXI_rdata;
  output S_AXI_rlast;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [511:0]S_AXI_wdata;
  input S_AXI_wlast;
  output S_AXI_wready;
  input [63:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire S_ACLK_1;
  wire [0:0]S_ARESETN_1;
  wire [31:0]auto_ds_to_auto_pc_ARADDR;
  wire [1:0]auto_ds_to_auto_pc_ARBURST;
  wire [3:0]auto_ds_to_auto_pc_ARCACHE;
  wire [7:0]auto_ds_to_auto_pc_ARLEN;
  wire [0:0]auto_ds_to_auto_pc_ARLOCK;
  wire [2:0]auto_ds_to_auto_pc_ARPROT;
  wire [3:0]auto_ds_to_auto_pc_ARQOS;
  wire auto_ds_to_auto_pc_ARREADY;
  wire [3:0]auto_ds_to_auto_pc_ARREGION;
  wire [2:0]auto_ds_to_auto_pc_ARSIZE;
  wire auto_ds_to_auto_pc_ARVALID;
  wire [31:0]auto_ds_to_auto_pc_AWADDR;
  wire [1:0]auto_ds_to_auto_pc_AWBURST;
  wire [3:0]auto_ds_to_auto_pc_AWCACHE;
  wire [7:0]auto_ds_to_auto_pc_AWLEN;
  wire [0:0]auto_ds_to_auto_pc_AWLOCK;
  wire [2:0]auto_ds_to_auto_pc_AWPROT;
  wire [3:0]auto_ds_to_auto_pc_AWQOS;
  wire auto_ds_to_auto_pc_AWREADY;
  wire [3:0]auto_ds_to_auto_pc_AWREGION;
  wire [2:0]auto_ds_to_auto_pc_AWSIZE;
  wire auto_ds_to_auto_pc_AWVALID;
  wire auto_ds_to_auto_pc_BREADY;
  wire [1:0]auto_ds_to_auto_pc_BRESP;
  wire auto_ds_to_auto_pc_BVALID;
  wire [31:0]auto_ds_to_auto_pc_RDATA;
  wire auto_ds_to_auto_pc_RLAST;
  wire auto_ds_to_auto_pc_RREADY;
  wire [1:0]auto_ds_to_auto_pc_RRESP;
  wire auto_ds_to_auto_pc_RVALID;
  wire [31:0]auto_ds_to_auto_pc_WDATA;
  wire auto_ds_to_auto_pc_WLAST;
  wire auto_ds_to_auto_pc_WREADY;
  wire [3:0]auto_ds_to_auto_pc_WSTRB;
  wire auto_ds_to_auto_pc_WVALID;
  wire [31:0]auto_pc_to_m06_couplers_ARADDR;
  wire auto_pc_to_m06_couplers_ARREADY;
  wire auto_pc_to_m06_couplers_ARVALID;
  wire [31:0]auto_pc_to_m06_couplers_AWADDR;
  wire auto_pc_to_m06_couplers_AWREADY;
  wire auto_pc_to_m06_couplers_AWVALID;
  wire auto_pc_to_m06_couplers_BREADY;
  wire [1:0]auto_pc_to_m06_couplers_BRESP;
  wire auto_pc_to_m06_couplers_BVALID;
  wire [31:0]auto_pc_to_m06_couplers_RDATA;
  wire auto_pc_to_m06_couplers_RREADY;
  wire [1:0]auto_pc_to_m06_couplers_RRESP;
  wire auto_pc_to_m06_couplers_RVALID;
  wire [31:0]auto_pc_to_m06_couplers_WDATA;
  wire auto_pc_to_m06_couplers_WREADY;
  wire [3:0]auto_pc_to_m06_couplers_WSTRB;
  wire auto_pc_to_m06_couplers_WVALID;
  wire [31:0]m06_couplers_to_auto_ds_ARADDR;
  wire [1:0]m06_couplers_to_auto_ds_ARBURST;
  wire [3:0]m06_couplers_to_auto_ds_ARCACHE;
  wire [7:0]m06_couplers_to_auto_ds_ARLEN;
  wire [0:0]m06_couplers_to_auto_ds_ARLOCK;
  wire [2:0]m06_couplers_to_auto_ds_ARPROT;
  wire [3:0]m06_couplers_to_auto_ds_ARQOS;
  wire m06_couplers_to_auto_ds_ARREADY;
  wire [3:0]m06_couplers_to_auto_ds_ARREGION;
  wire [2:0]m06_couplers_to_auto_ds_ARSIZE;
  wire m06_couplers_to_auto_ds_ARVALID;
  wire [31:0]m06_couplers_to_auto_ds_AWADDR;
  wire [1:0]m06_couplers_to_auto_ds_AWBURST;
  wire [3:0]m06_couplers_to_auto_ds_AWCACHE;
  wire [7:0]m06_couplers_to_auto_ds_AWLEN;
  wire [0:0]m06_couplers_to_auto_ds_AWLOCK;
  wire [2:0]m06_couplers_to_auto_ds_AWPROT;
  wire [3:0]m06_couplers_to_auto_ds_AWQOS;
  wire m06_couplers_to_auto_ds_AWREADY;
  wire [3:0]m06_couplers_to_auto_ds_AWREGION;
  wire [2:0]m06_couplers_to_auto_ds_AWSIZE;
  wire m06_couplers_to_auto_ds_AWVALID;
  wire m06_couplers_to_auto_ds_BREADY;
  wire [1:0]m06_couplers_to_auto_ds_BRESP;
  wire m06_couplers_to_auto_ds_BVALID;
  wire [511:0]m06_couplers_to_auto_ds_RDATA;
  wire m06_couplers_to_auto_ds_RLAST;
  wire m06_couplers_to_auto_ds_RREADY;
  wire [1:0]m06_couplers_to_auto_ds_RRESP;
  wire m06_couplers_to_auto_ds_RVALID;
  wire [511:0]m06_couplers_to_auto_ds_WDATA;
  wire m06_couplers_to_auto_ds_WLAST;
  wire m06_couplers_to_auto_ds_WREADY;
  wire [63:0]m06_couplers_to_auto_ds_WSTRB;
  wire m06_couplers_to_auto_ds_WVALID;

  assign M_AXI_araddr[31:0] = auto_pc_to_m06_couplers_ARADDR;
  assign M_AXI_arvalid = auto_pc_to_m06_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = auto_pc_to_m06_couplers_AWADDR;
  assign M_AXI_awvalid = auto_pc_to_m06_couplers_AWVALID;
  assign M_AXI_bready = auto_pc_to_m06_couplers_BREADY;
  assign M_AXI_rready = auto_pc_to_m06_couplers_RREADY;
  assign M_AXI_wdata[31:0] = auto_pc_to_m06_couplers_WDATA;
  assign M_AXI_wstrb[3:0] = auto_pc_to_m06_couplers_WSTRB;
  assign M_AXI_wvalid = auto_pc_to_m06_couplers_WVALID;
  assign S_ACLK_1 = S_ACLK;
  assign S_ARESETN_1 = S_ARESETN[0];
  assign S_AXI_arready = m06_couplers_to_auto_ds_ARREADY;
  assign S_AXI_awready = m06_couplers_to_auto_ds_AWREADY;
  assign S_AXI_bresp[1:0] = m06_couplers_to_auto_ds_BRESP;
  assign S_AXI_bvalid = m06_couplers_to_auto_ds_BVALID;
  assign S_AXI_rdata[511:0] = m06_couplers_to_auto_ds_RDATA;
  assign S_AXI_rlast = m06_couplers_to_auto_ds_RLAST;
  assign S_AXI_rresp[1:0] = m06_couplers_to_auto_ds_RRESP;
  assign S_AXI_rvalid = m06_couplers_to_auto_ds_RVALID;
  assign S_AXI_wready = m06_couplers_to_auto_ds_WREADY;
  assign auto_pc_to_m06_couplers_ARREADY = M_AXI_arready;
  assign auto_pc_to_m06_couplers_AWREADY = M_AXI_awready;
  assign auto_pc_to_m06_couplers_BRESP = M_AXI_bresp[1:0];
  assign auto_pc_to_m06_couplers_BVALID = M_AXI_bvalid;
  assign auto_pc_to_m06_couplers_RDATA = M_AXI_rdata[31:0];
  assign auto_pc_to_m06_couplers_RRESP = M_AXI_rresp[1:0];
  assign auto_pc_to_m06_couplers_RVALID = M_AXI_rvalid;
  assign auto_pc_to_m06_couplers_WREADY = M_AXI_wready;
  assign m06_couplers_to_auto_ds_ARADDR = S_AXI_araddr[31:0];
  assign m06_couplers_to_auto_ds_ARBURST = S_AXI_arburst[1:0];
  assign m06_couplers_to_auto_ds_ARCACHE = S_AXI_arcache[3:0];
  assign m06_couplers_to_auto_ds_ARLEN = S_AXI_arlen[7:0];
  assign m06_couplers_to_auto_ds_ARLOCK = S_AXI_arlock[0];
  assign m06_couplers_to_auto_ds_ARPROT = S_AXI_arprot[2:0];
  assign m06_couplers_to_auto_ds_ARQOS = S_AXI_arqos[3:0];
  assign m06_couplers_to_auto_ds_ARREGION = S_AXI_arregion[3:0];
  assign m06_couplers_to_auto_ds_ARSIZE = S_AXI_arsize[2:0];
  assign m06_couplers_to_auto_ds_ARVALID = S_AXI_arvalid;
  assign m06_couplers_to_auto_ds_AWADDR = S_AXI_awaddr[31:0];
  assign m06_couplers_to_auto_ds_AWBURST = S_AXI_awburst[1:0];
  assign m06_couplers_to_auto_ds_AWCACHE = S_AXI_awcache[3:0];
  assign m06_couplers_to_auto_ds_AWLEN = S_AXI_awlen[7:0];
  assign m06_couplers_to_auto_ds_AWLOCK = S_AXI_awlock[0];
  assign m06_couplers_to_auto_ds_AWPROT = S_AXI_awprot[2:0];
  assign m06_couplers_to_auto_ds_AWQOS = S_AXI_awqos[3:0];
  assign m06_couplers_to_auto_ds_AWREGION = S_AXI_awregion[3:0];
  assign m06_couplers_to_auto_ds_AWSIZE = S_AXI_awsize[2:0];
  assign m06_couplers_to_auto_ds_AWVALID = S_AXI_awvalid;
  assign m06_couplers_to_auto_ds_BREADY = S_AXI_bready;
  assign m06_couplers_to_auto_ds_RREADY = S_AXI_rready;
  assign m06_couplers_to_auto_ds_WDATA = S_AXI_wdata[511:0];
  assign m06_couplers_to_auto_ds_WLAST = S_AXI_wlast;
  assign m06_couplers_to_auto_ds_WSTRB = S_AXI_wstrb[63:0];
  assign m06_couplers_to_auto_ds_WVALID = S_AXI_wvalid;
  system_i_bak_auto_ds_6 auto_ds
       (.m_axi_araddr(auto_ds_to_auto_pc_ARADDR),
        .m_axi_arburst(auto_ds_to_auto_pc_ARBURST),
        .m_axi_arcache(auto_ds_to_auto_pc_ARCACHE),
        .m_axi_arlen(auto_ds_to_auto_pc_ARLEN),
        .m_axi_arlock(auto_ds_to_auto_pc_ARLOCK),
        .m_axi_arprot(auto_ds_to_auto_pc_ARPROT),
        .m_axi_arqos(auto_ds_to_auto_pc_ARQOS),
        .m_axi_arready(auto_ds_to_auto_pc_ARREADY),
        .m_axi_arregion(auto_ds_to_auto_pc_ARREGION),
        .m_axi_arsize(auto_ds_to_auto_pc_ARSIZE),
        .m_axi_arvalid(auto_ds_to_auto_pc_ARVALID),
        .m_axi_awaddr(auto_ds_to_auto_pc_AWADDR),
        .m_axi_awburst(auto_ds_to_auto_pc_AWBURST),
        .m_axi_awcache(auto_ds_to_auto_pc_AWCACHE),
        .m_axi_awlen(auto_ds_to_auto_pc_AWLEN),
        .m_axi_awlock(auto_ds_to_auto_pc_AWLOCK),
        .m_axi_awprot(auto_ds_to_auto_pc_AWPROT),
        .m_axi_awqos(auto_ds_to_auto_pc_AWQOS),
        .m_axi_awready(auto_ds_to_auto_pc_AWREADY),
        .m_axi_awregion(auto_ds_to_auto_pc_AWREGION),
        .m_axi_awsize(auto_ds_to_auto_pc_AWSIZE),
        .m_axi_awvalid(auto_ds_to_auto_pc_AWVALID),
        .m_axi_bready(auto_ds_to_auto_pc_BREADY),
        .m_axi_bresp(auto_ds_to_auto_pc_BRESP),
        .m_axi_bvalid(auto_ds_to_auto_pc_BVALID),
        .m_axi_rdata(auto_ds_to_auto_pc_RDATA),
        .m_axi_rlast(auto_ds_to_auto_pc_RLAST),
        .m_axi_rready(auto_ds_to_auto_pc_RREADY),
        .m_axi_rresp(auto_ds_to_auto_pc_RRESP),
        .m_axi_rvalid(auto_ds_to_auto_pc_RVALID),
        .m_axi_wdata(auto_ds_to_auto_pc_WDATA),
        .m_axi_wlast(auto_ds_to_auto_pc_WLAST),
        .m_axi_wready(auto_ds_to_auto_pc_WREADY),
        .m_axi_wstrb(auto_ds_to_auto_pc_WSTRB),
        .m_axi_wvalid(auto_ds_to_auto_pc_WVALID),
        .s_axi_aclk(S_ACLK_1),
        .s_axi_araddr(m06_couplers_to_auto_ds_ARADDR),
        .s_axi_arburst(m06_couplers_to_auto_ds_ARBURST),
        .s_axi_arcache(m06_couplers_to_auto_ds_ARCACHE),
        .s_axi_aresetn(S_ARESETN_1),
        .s_axi_arlen(m06_couplers_to_auto_ds_ARLEN),
        .s_axi_arlock(m06_couplers_to_auto_ds_ARLOCK),
        .s_axi_arprot(m06_couplers_to_auto_ds_ARPROT),
        .s_axi_arqos(m06_couplers_to_auto_ds_ARQOS),
        .s_axi_arready(m06_couplers_to_auto_ds_ARREADY),
        .s_axi_arregion(m06_couplers_to_auto_ds_ARREGION),
        .s_axi_arsize(m06_couplers_to_auto_ds_ARSIZE),
        .s_axi_arvalid(m06_couplers_to_auto_ds_ARVALID),
        .s_axi_awaddr(m06_couplers_to_auto_ds_AWADDR),
        .s_axi_awburst(m06_couplers_to_auto_ds_AWBURST),
        .s_axi_awcache(m06_couplers_to_auto_ds_AWCACHE),
        .s_axi_awlen(m06_couplers_to_auto_ds_AWLEN),
        .s_axi_awlock(m06_couplers_to_auto_ds_AWLOCK),
        .s_axi_awprot(m06_couplers_to_auto_ds_AWPROT),
        .s_axi_awqos(m06_couplers_to_auto_ds_AWQOS),
        .s_axi_awready(m06_couplers_to_auto_ds_AWREADY),
        .s_axi_awregion(m06_couplers_to_auto_ds_AWREGION),
        .s_axi_awsize(m06_couplers_to_auto_ds_AWSIZE),
        .s_axi_awvalid(m06_couplers_to_auto_ds_AWVALID),
        .s_axi_bready(m06_couplers_to_auto_ds_BREADY),
        .s_axi_bresp(m06_couplers_to_auto_ds_BRESP),
        .s_axi_bvalid(m06_couplers_to_auto_ds_BVALID),
        .s_axi_rdata(m06_couplers_to_auto_ds_RDATA),
        .s_axi_rlast(m06_couplers_to_auto_ds_RLAST),
        .s_axi_rready(m06_couplers_to_auto_ds_RREADY),
        .s_axi_rresp(m06_couplers_to_auto_ds_RRESP),
        .s_axi_rvalid(m06_couplers_to_auto_ds_RVALID),
        .s_axi_wdata(m06_couplers_to_auto_ds_WDATA),
        .s_axi_wlast(m06_couplers_to_auto_ds_WLAST),
        .s_axi_wready(m06_couplers_to_auto_ds_WREADY),
        .s_axi_wstrb(m06_couplers_to_auto_ds_WSTRB),
        .s_axi_wvalid(m06_couplers_to_auto_ds_WVALID));
  system_i_bak_auto_pc_5 auto_pc
       (.aclk(S_ACLK_1),
        .aresetn(S_ARESETN_1),
        .m_axi_araddr(auto_pc_to_m06_couplers_ARADDR),
        .m_axi_arready(auto_pc_to_m06_couplers_ARREADY),
        .m_axi_arvalid(auto_pc_to_m06_couplers_ARVALID),
        .m_axi_awaddr(auto_pc_to_m06_couplers_AWADDR),
        .m_axi_awready(auto_pc_to_m06_couplers_AWREADY),
        .m_axi_awvalid(auto_pc_to_m06_couplers_AWVALID),
        .m_axi_bready(auto_pc_to_m06_couplers_BREADY),
        .m_axi_bresp(auto_pc_to_m06_couplers_BRESP),
        .m_axi_bvalid(auto_pc_to_m06_couplers_BVALID),
        .m_axi_rdata(auto_pc_to_m06_couplers_RDATA),
        .m_axi_rready(auto_pc_to_m06_couplers_RREADY),
        .m_axi_rresp(auto_pc_to_m06_couplers_RRESP),
        .m_axi_rvalid(auto_pc_to_m06_couplers_RVALID),
        .m_axi_wdata(auto_pc_to_m06_couplers_WDATA),
        .m_axi_wready(auto_pc_to_m06_couplers_WREADY),
        .m_axi_wstrb(auto_pc_to_m06_couplers_WSTRB),
        .m_axi_wvalid(auto_pc_to_m06_couplers_WVALID),
        .s_axi_araddr(auto_ds_to_auto_pc_ARADDR),
        .s_axi_arburst(auto_ds_to_auto_pc_ARBURST),
        .s_axi_arcache(auto_ds_to_auto_pc_ARCACHE),
        .s_axi_arlen(auto_ds_to_auto_pc_ARLEN),
        .s_axi_arlock(auto_ds_to_auto_pc_ARLOCK),
        .s_axi_arprot(auto_ds_to_auto_pc_ARPROT),
        .s_axi_arqos(auto_ds_to_auto_pc_ARQOS),
        .s_axi_arready(auto_ds_to_auto_pc_ARREADY),
        .s_axi_arregion(auto_ds_to_auto_pc_ARREGION),
        .s_axi_arsize(auto_ds_to_auto_pc_ARSIZE),
        .s_axi_arvalid(auto_ds_to_auto_pc_ARVALID),
        .s_axi_awaddr(auto_ds_to_auto_pc_AWADDR),
        .s_axi_awburst(auto_ds_to_auto_pc_AWBURST),
        .s_axi_awcache(auto_ds_to_auto_pc_AWCACHE),
        .s_axi_awlen(auto_ds_to_auto_pc_AWLEN),
        .s_axi_awlock(auto_ds_to_auto_pc_AWLOCK),
        .s_axi_awprot(auto_ds_to_auto_pc_AWPROT),
        .s_axi_awqos(auto_ds_to_auto_pc_AWQOS),
        .s_axi_awready(auto_ds_to_auto_pc_AWREADY),
        .s_axi_awregion(auto_ds_to_auto_pc_AWREGION),
        .s_axi_awsize(auto_ds_to_auto_pc_AWSIZE),
        .s_axi_awvalid(auto_ds_to_auto_pc_AWVALID),
        .s_axi_bready(auto_ds_to_auto_pc_BREADY),
        .s_axi_bresp(auto_ds_to_auto_pc_BRESP),
        .s_axi_bvalid(auto_ds_to_auto_pc_BVALID),
        .s_axi_rdata(auto_ds_to_auto_pc_RDATA),
        .s_axi_rlast(auto_ds_to_auto_pc_RLAST),
        .s_axi_rready(auto_ds_to_auto_pc_RREADY),
        .s_axi_rresp(auto_ds_to_auto_pc_RRESP),
        .s_axi_rvalid(auto_ds_to_auto_pc_RVALID),
        .s_axi_wdata(auto_ds_to_auto_pc_WDATA),
        .s_axi_wlast(auto_ds_to_auto_pc_WLAST),
        .s_axi_wready(auto_ds_to_auto_pc_WREADY),
        .s_axi_wstrb(auto_ds_to_auto_pc_WSTRB),
        .s_axi_wvalid(auto_ds_to_auto_pc_WVALID));
endmodule

module m07_couplers_imp_4MDLKM
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arburst,
    M_AXI_arcache,
    M_AXI_arlen,
    M_AXI_arlock,
    M_AXI_arprot,
    M_AXI_arqos,
    M_AXI_arready,
    M_AXI_arregion,
    M_AXI_arsize,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awburst,
    M_AXI_awcache,
    M_AXI_awlen,
    M_AXI_awlock,
    M_AXI_awprot,
    M_AXI_awqos,
    M_AXI_awready,
    M_AXI_awregion,
    M_AXI_awsize,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rlast,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wlast,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arburst,
    S_AXI_arcache,
    S_AXI_arlen,
    S_AXI_arlock,
    S_AXI_arprot,
    S_AXI_arqos,
    S_AXI_arready,
    S_AXI_arregion,
    S_AXI_arsize,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awburst,
    S_AXI_awcache,
    S_AXI_awlen,
    S_AXI_awlock,
    S_AXI_awprot,
    S_AXI_awqos,
    S_AXI_awready,
    S_AXI_awregion,
    S_AXI_awsize,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rlast,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wlast,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input [0:0]M_ARESETN;
  output [31:0]M_AXI_araddr;
  output [1:0]M_AXI_arburst;
  output [3:0]M_AXI_arcache;
  output [7:0]M_AXI_arlen;
  output [0:0]M_AXI_arlock;
  output [2:0]M_AXI_arprot;
  output [3:0]M_AXI_arqos;
  input M_AXI_arready;
  output [3:0]M_AXI_arregion;
  output [2:0]M_AXI_arsize;
  output M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  output [1:0]M_AXI_awburst;
  output [3:0]M_AXI_awcache;
  output [7:0]M_AXI_awlen;
  output [0:0]M_AXI_awlock;
  output [2:0]M_AXI_awprot;
  output [3:0]M_AXI_awqos;
  input M_AXI_awready;
  output [3:0]M_AXI_awregion;
  output [2:0]M_AXI_awsize;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [511:0]M_AXI_rdata;
  input M_AXI_rlast;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [511:0]M_AXI_wdata;
  output M_AXI_wlast;
  input M_AXI_wready;
  output [63:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input [0:0]S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [1:0]S_AXI_arburst;
  input [3:0]S_AXI_arcache;
  input [7:0]S_AXI_arlen;
  input [0:0]S_AXI_arlock;
  input [2:0]S_AXI_arprot;
  input [3:0]S_AXI_arqos;
  output S_AXI_arready;
  input [3:0]S_AXI_arregion;
  input [2:0]S_AXI_arsize;
  input S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  input [1:0]S_AXI_awburst;
  input [3:0]S_AXI_awcache;
  input [7:0]S_AXI_awlen;
  input [0:0]S_AXI_awlock;
  input [2:0]S_AXI_awprot;
  input [3:0]S_AXI_awqos;
  output S_AXI_awready;
  input [3:0]S_AXI_awregion;
  input [2:0]S_AXI_awsize;
  input S_AXI_awvalid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [511:0]S_AXI_rdata;
  output S_AXI_rlast;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [511:0]S_AXI_wdata;
  input S_AXI_wlast;
  output S_AXI_wready;
  input [63:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire [31:0]m07_couplers_to_m07_couplers_ARADDR;
  wire [1:0]m07_couplers_to_m07_couplers_ARBURST;
  wire [3:0]m07_couplers_to_m07_couplers_ARCACHE;
  wire [7:0]m07_couplers_to_m07_couplers_ARLEN;
  wire [0:0]m07_couplers_to_m07_couplers_ARLOCK;
  wire [2:0]m07_couplers_to_m07_couplers_ARPROT;
  wire [3:0]m07_couplers_to_m07_couplers_ARQOS;
  wire m07_couplers_to_m07_couplers_ARREADY;
  wire [3:0]m07_couplers_to_m07_couplers_ARREGION;
  wire [2:0]m07_couplers_to_m07_couplers_ARSIZE;
  wire m07_couplers_to_m07_couplers_ARVALID;
  wire [31:0]m07_couplers_to_m07_couplers_AWADDR;
  wire [1:0]m07_couplers_to_m07_couplers_AWBURST;
  wire [3:0]m07_couplers_to_m07_couplers_AWCACHE;
  wire [7:0]m07_couplers_to_m07_couplers_AWLEN;
  wire [0:0]m07_couplers_to_m07_couplers_AWLOCK;
  wire [2:0]m07_couplers_to_m07_couplers_AWPROT;
  wire [3:0]m07_couplers_to_m07_couplers_AWQOS;
  wire m07_couplers_to_m07_couplers_AWREADY;
  wire [3:0]m07_couplers_to_m07_couplers_AWREGION;
  wire [2:0]m07_couplers_to_m07_couplers_AWSIZE;
  wire m07_couplers_to_m07_couplers_AWVALID;
  wire m07_couplers_to_m07_couplers_BREADY;
  wire [1:0]m07_couplers_to_m07_couplers_BRESP;
  wire m07_couplers_to_m07_couplers_BVALID;
  wire [511:0]m07_couplers_to_m07_couplers_RDATA;
  wire m07_couplers_to_m07_couplers_RLAST;
  wire m07_couplers_to_m07_couplers_RREADY;
  wire [1:0]m07_couplers_to_m07_couplers_RRESP;
  wire m07_couplers_to_m07_couplers_RVALID;
  wire [511:0]m07_couplers_to_m07_couplers_WDATA;
  wire m07_couplers_to_m07_couplers_WLAST;
  wire m07_couplers_to_m07_couplers_WREADY;
  wire [63:0]m07_couplers_to_m07_couplers_WSTRB;
  wire m07_couplers_to_m07_couplers_WVALID;

  assign M_AXI_araddr[31:0] = m07_couplers_to_m07_couplers_ARADDR;
  assign M_AXI_arburst[1:0] = m07_couplers_to_m07_couplers_ARBURST;
  assign M_AXI_arcache[3:0] = m07_couplers_to_m07_couplers_ARCACHE;
  assign M_AXI_arlen[7:0] = m07_couplers_to_m07_couplers_ARLEN;
  assign M_AXI_arlock[0] = m07_couplers_to_m07_couplers_ARLOCK;
  assign M_AXI_arprot[2:0] = m07_couplers_to_m07_couplers_ARPROT;
  assign M_AXI_arqos[3:0] = m07_couplers_to_m07_couplers_ARQOS;
  assign M_AXI_arregion[3:0] = m07_couplers_to_m07_couplers_ARREGION;
  assign M_AXI_arsize[2:0] = m07_couplers_to_m07_couplers_ARSIZE;
  assign M_AXI_arvalid = m07_couplers_to_m07_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = m07_couplers_to_m07_couplers_AWADDR;
  assign M_AXI_awburst[1:0] = m07_couplers_to_m07_couplers_AWBURST;
  assign M_AXI_awcache[3:0] = m07_couplers_to_m07_couplers_AWCACHE;
  assign M_AXI_awlen[7:0] = m07_couplers_to_m07_couplers_AWLEN;
  assign M_AXI_awlock[0] = m07_couplers_to_m07_couplers_AWLOCK;
  assign M_AXI_awprot[2:0] = m07_couplers_to_m07_couplers_AWPROT;
  assign M_AXI_awqos[3:0] = m07_couplers_to_m07_couplers_AWQOS;
  assign M_AXI_awregion[3:0] = m07_couplers_to_m07_couplers_AWREGION;
  assign M_AXI_awsize[2:0] = m07_couplers_to_m07_couplers_AWSIZE;
  assign M_AXI_awvalid = m07_couplers_to_m07_couplers_AWVALID;
  assign M_AXI_bready = m07_couplers_to_m07_couplers_BREADY;
  assign M_AXI_rready = m07_couplers_to_m07_couplers_RREADY;
  assign M_AXI_wdata[511:0] = m07_couplers_to_m07_couplers_WDATA;
  assign M_AXI_wlast = m07_couplers_to_m07_couplers_WLAST;
  assign M_AXI_wstrb[63:0] = m07_couplers_to_m07_couplers_WSTRB;
  assign M_AXI_wvalid = m07_couplers_to_m07_couplers_WVALID;
  assign S_AXI_arready = m07_couplers_to_m07_couplers_ARREADY;
  assign S_AXI_awready = m07_couplers_to_m07_couplers_AWREADY;
  assign S_AXI_bresp[1:0] = m07_couplers_to_m07_couplers_BRESP;
  assign S_AXI_bvalid = m07_couplers_to_m07_couplers_BVALID;
  assign S_AXI_rdata[511:0] = m07_couplers_to_m07_couplers_RDATA;
  assign S_AXI_rlast = m07_couplers_to_m07_couplers_RLAST;
  assign S_AXI_rresp[1:0] = m07_couplers_to_m07_couplers_RRESP;
  assign S_AXI_rvalid = m07_couplers_to_m07_couplers_RVALID;
  assign S_AXI_wready = m07_couplers_to_m07_couplers_WREADY;
  assign m07_couplers_to_m07_couplers_ARADDR = S_AXI_araddr[31:0];
  assign m07_couplers_to_m07_couplers_ARBURST = S_AXI_arburst[1:0];
  assign m07_couplers_to_m07_couplers_ARCACHE = S_AXI_arcache[3:0];
  assign m07_couplers_to_m07_couplers_ARLEN = S_AXI_arlen[7:0];
  assign m07_couplers_to_m07_couplers_ARLOCK = S_AXI_arlock[0];
  assign m07_couplers_to_m07_couplers_ARPROT = S_AXI_arprot[2:0];
  assign m07_couplers_to_m07_couplers_ARQOS = S_AXI_arqos[3:0];
  assign m07_couplers_to_m07_couplers_ARREADY = M_AXI_arready;
  assign m07_couplers_to_m07_couplers_ARREGION = S_AXI_arregion[3:0];
  assign m07_couplers_to_m07_couplers_ARSIZE = S_AXI_arsize[2:0];
  assign m07_couplers_to_m07_couplers_ARVALID = S_AXI_arvalid;
  assign m07_couplers_to_m07_couplers_AWADDR = S_AXI_awaddr[31:0];
  assign m07_couplers_to_m07_couplers_AWBURST = S_AXI_awburst[1:0];
  assign m07_couplers_to_m07_couplers_AWCACHE = S_AXI_awcache[3:0];
  assign m07_couplers_to_m07_couplers_AWLEN = S_AXI_awlen[7:0];
  assign m07_couplers_to_m07_couplers_AWLOCK = S_AXI_awlock[0];
  assign m07_couplers_to_m07_couplers_AWPROT = S_AXI_awprot[2:0];
  assign m07_couplers_to_m07_couplers_AWQOS = S_AXI_awqos[3:0];
  assign m07_couplers_to_m07_couplers_AWREADY = M_AXI_awready;
  assign m07_couplers_to_m07_couplers_AWREGION = S_AXI_awregion[3:0];
  assign m07_couplers_to_m07_couplers_AWSIZE = S_AXI_awsize[2:0];
  assign m07_couplers_to_m07_couplers_AWVALID = S_AXI_awvalid;
  assign m07_couplers_to_m07_couplers_BREADY = S_AXI_bready;
  assign m07_couplers_to_m07_couplers_BRESP = M_AXI_bresp[1:0];
  assign m07_couplers_to_m07_couplers_BVALID = M_AXI_bvalid;
  assign m07_couplers_to_m07_couplers_RDATA = M_AXI_rdata[511:0];
  assign m07_couplers_to_m07_couplers_RLAST = M_AXI_rlast;
  assign m07_couplers_to_m07_couplers_RREADY = S_AXI_rready;
  assign m07_couplers_to_m07_couplers_RRESP = M_AXI_rresp[1:0];
  assign m07_couplers_to_m07_couplers_RVALID = M_AXI_rvalid;
  assign m07_couplers_to_m07_couplers_WDATA = S_AXI_wdata[511:0];
  assign m07_couplers_to_m07_couplers_WLAST = S_AXI_wlast;
  assign m07_couplers_to_m07_couplers_WREADY = M_AXI_wready;
  assign m07_couplers_to_m07_couplers_WSTRB = S_AXI_wstrb[63:0];
  assign m07_couplers_to_m07_couplers_WVALID = S_AXI_wvalid;
endmodule

module m08_couplers_imp_1KNNGVQ
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arburst,
    S_AXI_arcache,
    S_AXI_arlen,
    S_AXI_arlock,
    S_AXI_arprot,
    S_AXI_arqos,
    S_AXI_arready,
    S_AXI_arregion,
    S_AXI_arsize,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awburst,
    S_AXI_awcache,
    S_AXI_awlen,
    S_AXI_awlock,
    S_AXI_awprot,
    S_AXI_awqos,
    S_AXI_awready,
    S_AXI_awregion,
    S_AXI_awsize,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rlast,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wlast,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input [0:0]M_ARESETN;
  output [17:0]M_AXI_araddr;
  input M_AXI_arready;
  output M_AXI_arvalid;
  output [17:0]M_AXI_awaddr;
  input M_AXI_awready;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  input M_AXI_wready;
  output [3:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input [0:0]S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [1:0]S_AXI_arburst;
  input [3:0]S_AXI_arcache;
  input [7:0]S_AXI_arlen;
  input [0:0]S_AXI_arlock;
  input [2:0]S_AXI_arprot;
  input [3:0]S_AXI_arqos;
  output S_AXI_arready;
  input [3:0]S_AXI_arregion;
  input [2:0]S_AXI_arsize;
  input S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  input [1:0]S_AXI_awburst;
  input [3:0]S_AXI_awcache;
  input [7:0]S_AXI_awlen;
  input [0:0]S_AXI_awlock;
  input [2:0]S_AXI_awprot;
  input [3:0]S_AXI_awqos;
  output S_AXI_awready;
  input [3:0]S_AXI_awregion;
  input [2:0]S_AXI_awsize;
  input S_AXI_awvalid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [511:0]S_AXI_rdata;
  output S_AXI_rlast;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [511:0]S_AXI_wdata;
  input S_AXI_wlast;
  output S_AXI_wready;
  input [63:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire S_ACLK_1;
  wire [0:0]S_ARESETN_1;
  wire [17:0]auto_ds_to_auto_pc_ARADDR;
  wire [1:0]auto_ds_to_auto_pc_ARBURST;
  wire [3:0]auto_ds_to_auto_pc_ARCACHE;
  wire [7:0]auto_ds_to_auto_pc_ARLEN;
  wire [0:0]auto_ds_to_auto_pc_ARLOCK;
  wire [2:0]auto_ds_to_auto_pc_ARPROT;
  wire [3:0]auto_ds_to_auto_pc_ARQOS;
  wire auto_ds_to_auto_pc_ARREADY;
  wire [3:0]auto_ds_to_auto_pc_ARREGION;
  wire [2:0]auto_ds_to_auto_pc_ARSIZE;
  wire auto_ds_to_auto_pc_ARVALID;
  wire [17:0]auto_ds_to_auto_pc_AWADDR;
  wire [1:0]auto_ds_to_auto_pc_AWBURST;
  wire [3:0]auto_ds_to_auto_pc_AWCACHE;
  wire [7:0]auto_ds_to_auto_pc_AWLEN;
  wire [0:0]auto_ds_to_auto_pc_AWLOCK;
  wire [2:0]auto_ds_to_auto_pc_AWPROT;
  wire [3:0]auto_ds_to_auto_pc_AWQOS;
  wire auto_ds_to_auto_pc_AWREADY;
  wire [3:0]auto_ds_to_auto_pc_AWREGION;
  wire [2:0]auto_ds_to_auto_pc_AWSIZE;
  wire auto_ds_to_auto_pc_AWVALID;
  wire auto_ds_to_auto_pc_BREADY;
  wire [1:0]auto_ds_to_auto_pc_BRESP;
  wire auto_ds_to_auto_pc_BVALID;
  wire [31:0]auto_ds_to_auto_pc_RDATA;
  wire auto_ds_to_auto_pc_RLAST;
  wire auto_ds_to_auto_pc_RREADY;
  wire [1:0]auto_ds_to_auto_pc_RRESP;
  wire auto_ds_to_auto_pc_RVALID;
  wire [31:0]auto_ds_to_auto_pc_WDATA;
  wire auto_ds_to_auto_pc_WLAST;
  wire auto_ds_to_auto_pc_WREADY;
  wire [3:0]auto_ds_to_auto_pc_WSTRB;
  wire auto_ds_to_auto_pc_WVALID;
  wire [17:0]auto_pc_to_m08_couplers_ARADDR;
  wire auto_pc_to_m08_couplers_ARREADY;
  wire auto_pc_to_m08_couplers_ARVALID;
  wire [17:0]auto_pc_to_m08_couplers_AWADDR;
  wire auto_pc_to_m08_couplers_AWREADY;
  wire auto_pc_to_m08_couplers_AWVALID;
  wire auto_pc_to_m08_couplers_BREADY;
  wire [1:0]auto_pc_to_m08_couplers_BRESP;
  wire auto_pc_to_m08_couplers_BVALID;
  wire [31:0]auto_pc_to_m08_couplers_RDATA;
  wire auto_pc_to_m08_couplers_RREADY;
  wire [1:0]auto_pc_to_m08_couplers_RRESP;
  wire auto_pc_to_m08_couplers_RVALID;
  wire [31:0]auto_pc_to_m08_couplers_WDATA;
  wire auto_pc_to_m08_couplers_WREADY;
  wire [3:0]auto_pc_to_m08_couplers_WSTRB;
  wire auto_pc_to_m08_couplers_WVALID;
  wire [31:0]m08_couplers_to_auto_ds_ARADDR;
  wire [1:0]m08_couplers_to_auto_ds_ARBURST;
  wire [3:0]m08_couplers_to_auto_ds_ARCACHE;
  wire [7:0]m08_couplers_to_auto_ds_ARLEN;
  wire [0:0]m08_couplers_to_auto_ds_ARLOCK;
  wire [2:0]m08_couplers_to_auto_ds_ARPROT;
  wire [3:0]m08_couplers_to_auto_ds_ARQOS;
  wire m08_couplers_to_auto_ds_ARREADY;
  wire [3:0]m08_couplers_to_auto_ds_ARREGION;
  wire [2:0]m08_couplers_to_auto_ds_ARSIZE;
  wire m08_couplers_to_auto_ds_ARVALID;
  wire [31:0]m08_couplers_to_auto_ds_AWADDR;
  wire [1:0]m08_couplers_to_auto_ds_AWBURST;
  wire [3:0]m08_couplers_to_auto_ds_AWCACHE;
  wire [7:0]m08_couplers_to_auto_ds_AWLEN;
  wire [0:0]m08_couplers_to_auto_ds_AWLOCK;
  wire [2:0]m08_couplers_to_auto_ds_AWPROT;
  wire [3:0]m08_couplers_to_auto_ds_AWQOS;
  wire m08_couplers_to_auto_ds_AWREADY;
  wire [3:0]m08_couplers_to_auto_ds_AWREGION;
  wire [2:0]m08_couplers_to_auto_ds_AWSIZE;
  wire m08_couplers_to_auto_ds_AWVALID;
  wire m08_couplers_to_auto_ds_BREADY;
  wire [1:0]m08_couplers_to_auto_ds_BRESP;
  wire m08_couplers_to_auto_ds_BVALID;
  wire [511:0]m08_couplers_to_auto_ds_RDATA;
  wire m08_couplers_to_auto_ds_RLAST;
  wire m08_couplers_to_auto_ds_RREADY;
  wire [1:0]m08_couplers_to_auto_ds_RRESP;
  wire m08_couplers_to_auto_ds_RVALID;
  wire [511:0]m08_couplers_to_auto_ds_WDATA;
  wire m08_couplers_to_auto_ds_WLAST;
  wire m08_couplers_to_auto_ds_WREADY;
  wire [63:0]m08_couplers_to_auto_ds_WSTRB;
  wire m08_couplers_to_auto_ds_WVALID;

  assign M_AXI_araddr[17:0] = auto_pc_to_m08_couplers_ARADDR;
  assign M_AXI_arvalid = auto_pc_to_m08_couplers_ARVALID;
  assign M_AXI_awaddr[17:0] = auto_pc_to_m08_couplers_AWADDR;
  assign M_AXI_awvalid = auto_pc_to_m08_couplers_AWVALID;
  assign M_AXI_bready = auto_pc_to_m08_couplers_BREADY;
  assign M_AXI_rready = auto_pc_to_m08_couplers_RREADY;
  assign M_AXI_wdata[31:0] = auto_pc_to_m08_couplers_WDATA;
  assign M_AXI_wstrb[3:0] = auto_pc_to_m08_couplers_WSTRB;
  assign M_AXI_wvalid = auto_pc_to_m08_couplers_WVALID;
  assign S_ACLK_1 = S_ACLK;
  assign S_ARESETN_1 = S_ARESETN[0];
  assign S_AXI_arready = m08_couplers_to_auto_ds_ARREADY;
  assign S_AXI_awready = m08_couplers_to_auto_ds_AWREADY;
  assign S_AXI_bresp[1:0] = m08_couplers_to_auto_ds_BRESP;
  assign S_AXI_bvalid = m08_couplers_to_auto_ds_BVALID;
  assign S_AXI_rdata[511:0] = m08_couplers_to_auto_ds_RDATA;
  assign S_AXI_rlast = m08_couplers_to_auto_ds_RLAST;
  assign S_AXI_rresp[1:0] = m08_couplers_to_auto_ds_RRESP;
  assign S_AXI_rvalid = m08_couplers_to_auto_ds_RVALID;
  assign S_AXI_wready = m08_couplers_to_auto_ds_WREADY;
  assign auto_pc_to_m08_couplers_ARREADY = M_AXI_arready;
  assign auto_pc_to_m08_couplers_AWREADY = M_AXI_awready;
  assign auto_pc_to_m08_couplers_BRESP = M_AXI_bresp[1:0];
  assign auto_pc_to_m08_couplers_BVALID = M_AXI_bvalid;
  assign auto_pc_to_m08_couplers_RDATA = M_AXI_rdata[31:0];
  assign auto_pc_to_m08_couplers_RRESP = M_AXI_rresp[1:0];
  assign auto_pc_to_m08_couplers_RVALID = M_AXI_rvalid;
  assign auto_pc_to_m08_couplers_WREADY = M_AXI_wready;
  assign m08_couplers_to_auto_ds_ARADDR = S_AXI_araddr[31:0];
  assign m08_couplers_to_auto_ds_ARBURST = S_AXI_arburst[1:0];
  assign m08_couplers_to_auto_ds_ARCACHE = S_AXI_arcache[3:0];
  assign m08_couplers_to_auto_ds_ARLEN = S_AXI_arlen[7:0];
  assign m08_couplers_to_auto_ds_ARLOCK = S_AXI_arlock[0];
  assign m08_couplers_to_auto_ds_ARPROT = S_AXI_arprot[2:0];
  assign m08_couplers_to_auto_ds_ARQOS = S_AXI_arqos[3:0];
  assign m08_couplers_to_auto_ds_ARREGION = S_AXI_arregion[3:0];
  assign m08_couplers_to_auto_ds_ARSIZE = S_AXI_arsize[2:0];
  assign m08_couplers_to_auto_ds_ARVALID = S_AXI_arvalid;
  assign m08_couplers_to_auto_ds_AWADDR = S_AXI_awaddr[31:0];
  assign m08_couplers_to_auto_ds_AWBURST = S_AXI_awburst[1:0];
  assign m08_couplers_to_auto_ds_AWCACHE = S_AXI_awcache[3:0];
  assign m08_couplers_to_auto_ds_AWLEN = S_AXI_awlen[7:0];
  assign m08_couplers_to_auto_ds_AWLOCK = S_AXI_awlock[0];
  assign m08_couplers_to_auto_ds_AWPROT = S_AXI_awprot[2:0];
  assign m08_couplers_to_auto_ds_AWQOS = S_AXI_awqos[3:0];
  assign m08_couplers_to_auto_ds_AWREGION = S_AXI_awregion[3:0];
  assign m08_couplers_to_auto_ds_AWSIZE = S_AXI_awsize[2:0];
  assign m08_couplers_to_auto_ds_AWVALID = S_AXI_awvalid;
  assign m08_couplers_to_auto_ds_BREADY = S_AXI_bready;
  assign m08_couplers_to_auto_ds_RREADY = S_AXI_rready;
  assign m08_couplers_to_auto_ds_WDATA = S_AXI_wdata[511:0];
  assign m08_couplers_to_auto_ds_WLAST = S_AXI_wlast;
  assign m08_couplers_to_auto_ds_WSTRB = S_AXI_wstrb[63:0];
  assign m08_couplers_to_auto_ds_WVALID = S_AXI_wvalid;
  system_i_bak_auto_ds_7 auto_ds
       (.m_axi_araddr(auto_ds_to_auto_pc_ARADDR),
        .m_axi_arburst(auto_ds_to_auto_pc_ARBURST),
        .m_axi_arcache(auto_ds_to_auto_pc_ARCACHE),
        .m_axi_arlen(auto_ds_to_auto_pc_ARLEN),
        .m_axi_arlock(auto_ds_to_auto_pc_ARLOCK),
        .m_axi_arprot(auto_ds_to_auto_pc_ARPROT),
        .m_axi_arqos(auto_ds_to_auto_pc_ARQOS),
        .m_axi_arready(auto_ds_to_auto_pc_ARREADY),
        .m_axi_arregion(auto_ds_to_auto_pc_ARREGION),
        .m_axi_arsize(auto_ds_to_auto_pc_ARSIZE),
        .m_axi_arvalid(auto_ds_to_auto_pc_ARVALID),
        .m_axi_awaddr(auto_ds_to_auto_pc_AWADDR),
        .m_axi_awburst(auto_ds_to_auto_pc_AWBURST),
        .m_axi_awcache(auto_ds_to_auto_pc_AWCACHE),
        .m_axi_awlen(auto_ds_to_auto_pc_AWLEN),
        .m_axi_awlock(auto_ds_to_auto_pc_AWLOCK),
        .m_axi_awprot(auto_ds_to_auto_pc_AWPROT),
        .m_axi_awqos(auto_ds_to_auto_pc_AWQOS),
        .m_axi_awready(auto_ds_to_auto_pc_AWREADY),
        .m_axi_awregion(auto_ds_to_auto_pc_AWREGION),
        .m_axi_awsize(auto_ds_to_auto_pc_AWSIZE),
        .m_axi_awvalid(auto_ds_to_auto_pc_AWVALID),
        .m_axi_bready(auto_ds_to_auto_pc_BREADY),
        .m_axi_bresp(auto_ds_to_auto_pc_BRESP),
        .m_axi_bvalid(auto_ds_to_auto_pc_BVALID),
        .m_axi_rdata(auto_ds_to_auto_pc_RDATA),
        .m_axi_rlast(auto_ds_to_auto_pc_RLAST),
        .m_axi_rready(auto_ds_to_auto_pc_RREADY),
        .m_axi_rresp(auto_ds_to_auto_pc_RRESP),
        .m_axi_rvalid(auto_ds_to_auto_pc_RVALID),
        .m_axi_wdata(auto_ds_to_auto_pc_WDATA),
        .m_axi_wlast(auto_ds_to_auto_pc_WLAST),
        .m_axi_wready(auto_ds_to_auto_pc_WREADY),
        .m_axi_wstrb(auto_ds_to_auto_pc_WSTRB),
        .m_axi_wvalid(auto_ds_to_auto_pc_WVALID),
        .s_axi_aclk(S_ACLK_1),
        .s_axi_araddr(m08_couplers_to_auto_ds_ARADDR[17:0]),
        .s_axi_arburst(m08_couplers_to_auto_ds_ARBURST),
        .s_axi_arcache(m08_couplers_to_auto_ds_ARCACHE),
        .s_axi_aresetn(S_ARESETN_1),
        .s_axi_arlen(m08_couplers_to_auto_ds_ARLEN),
        .s_axi_arlock(m08_couplers_to_auto_ds_ARLOCK),
        .s_axi_arprot(m08_couplers_to_auto_ds_ARPROT),
        .s_axi_arqos(m08_couplers_to_auto_ds_ARQOS),
        .s_axi_arready(m08_couplers_to_auto_ds_ARREADY),
        .s_axi_arregion(m08_couplers_to_auto_ds_ARREGION),
        .s_axi_arsize(m08_couplers_to_auto_ds_ARSIZE),
        .s_axi_arvalid(m08_couplers_to_auto_ds_ARVALID),
        .s_axi_awaddr(m08_couplers_to_auto_ds_AWADDR[17:0]),
        .s_axi_awburst(m08_couplers_to_auto_ds_AWBURST),
        .s_axi_awcache(m08_couplers_to_auto_ds_AWCACHE),
        .s_axi_awlen(m08_couplers_to_auto_ds_AWLEN),
        .s_axi_awlock(m08_couplers_to_auto_ds_AWLOCK),
        .s_axi_awprot(m08_couplers_to_auto_ds_AWPROT),
        .s_axi_awqos(m08_couplers_to_auto_ds_AWQOS),
        .s_axi_awready(m08_couplers_to_auto_ds_AWREADY),
        .s_axi_awregion(m08_couplers_to_auto_ds_AWREGION),
        .s_axi_awsize(m08_couplers_to_auto_ds_AWSIZE),
        .s_axi_awvalid(m08_couplers_to_auto_ds_AWVALID),
        .s_axi_bready(m08_couplers_to_auto_ds_BREADY),
        .s_axi_bresp(m08_couplers_to_auto_ds_BRESP),
        .s_axi_bvalid(m08_couplers_to_auto_ds_BVALID),
        .s_axi_rdata(m08_couplers_to_auto_ds_RDATA),
        .s_axi_rlast(m08_couplers_to_auto_ds_RLAST),
        .s_axi_rready(m08_couplers_to_auto_ds_RREADY),
        .s_axi_rresp(m08_couplers_to_auto_ds_RRESP),
        .s_axi_rvalid(m08_couplers_to_auto_ds_RVALID),
        .s_axi_wdata(m08_couplers_to_auto_ds_WDATA),
        .s_axi_wlast(m08_couplers_to_auto_ds_WLAST),
        .s_axi_wready(m08_couplers_to_auto_ds_WREADY),
        .s_axi_wstrb(m08_couplers_to_auto_ds_WSTRB),
        .s_axi_wvalid(m08_couplers_to_auto_ds_WVALID));
  system_i_bak_auto_pc_6 auto_pc
       (.aclk(S_ACLK_1),
        .aresetn(S_ARESETN_1),
        .m_axi_araddr(auto_pc_to_m08_couplers_ARADDR),
        .m_axi_arready(auto_pc_to_m08_couplers_ARREADY),
        .m_axi_arvalid(auto_pc_to_m08_couplers_ARVALID),
        .m_axi_awaddr(auto_pc_to_m08_couplers_AWADDR),
        .m_axi_awready(auto_pc_to_m08_couplers_AWREADY),
        .m_axi_awvalid(auto_pc_to_m08_couplers_AWVALID),
        .m_axi_bready(auto_pc_to_m08_couplers_BREADY),
        .m_axi_bresp(auto_pc_to_m08_couplers_BRESP),
        .m_axi_bvalid(auto_pc_to_m08_couplers_BVALID),
        .m_axi_rdata(auto_pc_to_m08_couplers_RDATA),
        .m_axi_rready(auto_pc_to_m08_couplers_RREADY),
        .m_axi_rresp(auto_pc_to_m08_couplers_RRESP),
        .m_axi_rvalid(auto_pc_to_m08_couplers_RVALID),
        .m_axi_wdata(auto_pc_to_m08_couplers_WDATA),
        .m_axi_wready(auto_pc_to_m08_couplers_WREADY),
        .m_axi_wstrb(auto_pc_to_m08_couplers_WSTRB),
        .m_axi_wvalid(auto_pc_to_m08_couplers_WVALID),
        .s_axi_araddr(auto_ds_to_auto_pc_ARADDR),
        .s_axi_arburst(auto_ds_to_auto_pc_ARBURST),
        .s_axi_arcache(auto_ds_to_auto_pc_ARCACHE),
        .s_axi_arlen(auto_ds_to_auto_pc_ARLEN),
        .s_axi_arlock(auto_ds_to_auto_pc_ARLOCK),
        .s_axi_arprot(auto_ds_to_auto_pc_ARPROT),
        .s_axi_arqos(auto_ds_to_auto_pc_ARQOS),
        .s_axi_arready(auto_ds_to_auto_pc_ARREADY),
        .s_axi_arregion(auto_ds_to_auto_pc_ARREGION),
        .s_axi_arsize(auto_ds_to_auto_pc_ARSIZE),
        .s_axi_arvalid(auto_ds_to_auto_pc_ARVALID),
        .s_axi_awaddr(auto_ds_to_auto_pc_AWADDR),
        .s_axi_awburst(auto_ds_to_auto_pc_AWBURST),
        .s_axi_awcache(auto_ds_to_auto_pc_AWCACHE),
        .s_axi_awlen(auto_ds_to_auto_pc_AWLEN),
        .s_axi_awlock(auto_ds_to_auto_pc_AWLOCK),
        .s_axi_awprot(auto_ds_to_auto_pc_AWPROT),
        .s_axi_awqos(auto_ds_to_auto_pc_AWQOS),
        .s_axi_awready(auto_ds_to_auto_pc_AWREADY),
        .s_axi_awregion(auto_ds_to_auto_pc_AWREGION),
        .s_axi_awsize(auto_ds_to_auto_pc_AWSIZE),
        .s_axi_awvalid(auto_ds_to_auto_pc_AWVALID),
        .s_axi_bready(auto_ds_to_auto_pc_BREADY),
        .s_axi_bresp(auto_ds_to_auto_pc_BRESP),
        .s_axi_bvalid(auto_ds_to_auto_pc_BVALID),
        .s_axi_rdata(auto_ds_to_auto_pc_RDATA),
        .s_axi_rlast(auto_ds_to_auto_pc_RLAST),
        .s_axi_rready(auto_ds_to_auto_pc_RREADY),
        .s_axi_rresp(auto_ds_to_auto_pc_RRESP),
        .s_axi_rvalid(auto_ds_to_auto_pc_RVALID),
        .s_axi_wdata(auto_ds_to_auto_pc_WDATA),
        .s_axi_wlast(auto_ds_to_auto_pc_WLAST),
        .s_axi_wready(auto_ds_to_auto_pc_WREADY),
        .s_axi_wstrb(auto_ds_to_auto_pc_WSTRB),
        .s_axi_wvalid(auto_ds_to_auto_pc_WVALID));
endmodule

module m09_couplers_imp_1OSK6BA
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arburst,
    S_AXI_arcache,
    S_AXI_arlen,
    S_AXI_arlock,
    S_AXI_arprot,
    S_AXI_arqos,
    S_AXI_arready,
    S_AXI_arregion,
    S_AXI_arsize,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awburst,
    S_AXI_awcache,
    S_AXI_awlen,
    S_AXI_awlock,
    S_AXI_awprot,
    S_AXI_awqos,
    S_AXI_awready,
    S_AXI_awregion,
    S_AXI_awsize,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rlast,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wlast,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input [0:0]M_ARESETN;
  output [31:0]M_AXI_araddr;
  input M_AXI_arready;
  output M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  input M_AXI_awready;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  input M_AXI_wready;
  output [3:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input [0:0]S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [1:0]S_AXI_arburst;
  input [3:0]S_AXI_arcache;
  input [7:0]S_AXI_arlen;
  input [0:0]S_AXI_arlock;
  input [2:0]S_AXI_arprot;
  input [3:0]S_AXI_arqos;
  output S_AXI_arready;
  input [3:0]S_AXI_arregion;
  input [2:0]S_AXI_arsize;
  input S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  input [1:0]S_AXI_awburst;
  input [3:0]S_AXI_awcache;
  input [7:0]S_AXI_awlen;
  input [0:0]S_AXI_awlock;
  input [2:0]S_AXI_awprot;
  input [3:0]S_AXI_awqos;
  output S_AXI_awready;
  input [3:0]S_AXI_awregion;
  input [2:0]S_AXI_awsize;
  input S_AXI_awvalid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [511:0]S_AXI_rdata;
  output S_AXI_rlast;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [511:0]S_AXI_wdata;
  input S_AXI_wlast;
  output S_AXI_wready;
  input [63:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire S_ACLK_1;
  wire [0:0]S_ARESETN_1;
  wire [31:0]auto_ds_to_auto_pc_ARADDR;
  wire [1:0]auto_ds_to_auto_pc_ARBURST;
  wire [3:0]auto_ds_to_auto_pc_ARCACHE;
  wire [7:0]auto_ds_to_auto_pc_ARLEN;
  wire [0:0]auto_ds_to_auto_pc_ARLOCK;
  wire [2:0]auto_ds_to_auto_pc_ARPROT;
  wire [3:0]auto_ds_to_auto_pc_ARQOS;
  wire auto_ds_to_auto_pc_ARREADY;
  wire [3:0]auto_ds_to_auto_pc_ARREGION;
  wire [2:0]auto_ds_to_auto_pc_ARSIZE;
  wire auto_ds_to_auto_pc_ARVALID;
  wire [31:0]auto_ds_to_auto_pc_AWADDR;
  wire [1:0]auto_ds_to_auto_pc_AWBURST;
  wire [3:0]auto_ds_to_auto_pc_AWCACHE;
  wire [7:0]auto_ds_to_auto_pc_AWLEN;
  wire [0:0]auto_ds_to_auto_pc_AWLOCK;
  wire [2:0]auto_ds_to_auto_pc_AWPROT;
  wire [3:0]auto_ds_to_auto_pc_AWQOS;
  wire auto_ds_to_auto_pc_AWREADY;
  wire [3:0]auto_ds_to_auto_pc_AWREGION;
  wire [2:0]auto_ds_to_auto_pc_AWSIZE;
  wire auto_ds_to_auto_pc_AWVALID;
  wire auto_ds_to_auto_pc_BREADY;
  wire [1:0]auto_ds_to_auto_pc_BRESP;
  wire auto_ds_to_auto_pc_BVALID;
  wire [31:0]auto_ds_to_auto_pc_RDATA;
  wire auto_ds_to_auto_pc_RLAST;
  wire auto_ds_to_auto_pc_RREADY;
  wire [1:0]auto_ds_to_auto_pc_RRESP;
  wire auto_ds_to_auto_pc_RVALID;
  wire [31:0]auto_ds_to_auto_pc_WDATA;
  wire auto_ds_to_auto_pc_WLAST;
  wire auto_ds_to_auto_pc_WREADY;
  wire [3:0]auto_ds_to_auto_pc_WSTRB;
  wire auto_ds_to_auto_pc_WVALID;
  wire [31:0]auto_pc_to_m09_couplers_ARADDR;
  wire auto_pc_to_m09_couplers_ARREADY;
  wire auto_pc_to_m09_couplers_ARVALID;
  wire [31:0]auto_pc_to_m09_couplers_AWADDR;
  wire auto_pc_to_m09_couplers_AWREADY;
  wire auto_pc_to_m09_couplers_AWVALID;
  wire auto_pc_to_m09_couplers_BREADY;
  wire [1:0]auto_pc_to_m09_couplers_BRESP;
  wire auto_pc_to_m09_couplers_BVALID;
  wire [31:0]auto_pc_to_m09_couplers_RDATA;
  wire auto_pc_to_m09_couplers_RREADY;
  wire [1:0]auto_pc_to_m09_couplers_RRESP;
  wire auto_pc_to_m09_couplers_RVALID;
  wire [31:0]auto_pc_to_m09_couplers_WDATA;
  wire auto_pc_to_m09_couplers_WREADY;
  wire [3:0]auto_pc_to_m09_couplers_WSTRB;
  wire auto_pc_to_m09_couplers_WVALID;
  wire [31:0]m09_couplers_to_auto_ds_ARADDR;
  wire [1:0]m09_couplers_to_auto_ds_ARBURST;
  wire [3:0]m09_couplers_to_auto_ds_ARCACHE;
  wire [7:0]m09_couplers_to_auto_ds_ARLEN;
  wire [0:0]m09_couplers_to_auto_ds_ARLOCK;
  wire [2:0]m09_couplers_to_auto_ds_ARPROT;
  wire [3:0]m09_couplers_to_auto_ds_ARQOS;
  wire m09_couplers_to_auto_ds_ARREADY;
  wire [3:0]m09_couplers_to_auto_ds_ARREGION;
  wire [2:0]m09_couplers_to_auto_ds_ARSIZE;
  wire m09_couplers_to_auto_ds_ARVALID;
  wire [31:0]m09_couplers_to_auto_ds_AWADDR;
  wire [1:0]m09_couplers_to_auto_ds_AWBURST;
  wire [3:0]m09_couplers_to_auto_ds_AWCACHE;
  wire [7:0]m09_couplers_to_auto_ds_AWLEN;
  wire [0:0]m09_couplers_to_auto_ds_AWLOCK;
  wire [2:0]m09_couplers_to_auto_ds_AWPROT;
  wire [3:0]m09_couplers_to_auto_ds_AWQOS;
  wire m09_couplers_to_auto_ds_AWREADY;
  wire [3:0]m09_couplers_to_auto_ds_AWREGION;
  wire [2:0]m09_couplers_to_auto_ds_AWSIZE;
  wire m09_couplers_to_auto_ds_AWVALID;
  wire m09_couplers_to_auto_ds_BREADY;
  wire [1:0]m09_couplers_to_auto_ds_BRESP;
  wire m09_couplers_to_auto_ds_BVALID;
  wire [511:0]m09_couplers_to_auto_ds_RDATA;
  wire m09_couplers_to_auto_ds_RLAST;
  wire m09_couplers_to_auto_ds_RREADY;
  wire [1:0]m09_couplers_to_auto_ds_RRESP;
  wire m09_couplers_to_auto_ds_RVALID;
  wire [511:0]m09_couplers_to_auto_ds_WDATA;
  wire m09_couplers_to_auto_ds_WLAST;
  wire m09_couplers_to_auto_ds_WREADY;
  wire [63:0]m09_couplers_to_auto_ds_WSTRB;
  wire m09_couplers_to_auto_ds_WVALID;

  assign M_AXI_araddr[31:0] = auto_pc_to_m09_couplers_ARADDR;
  assign M_AXI_arvalid = auto_pc_to_m09_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = auto_pc_to_m09_couplers_AWADDR;
  assign M_AXI_awvalid = auto_pc_to_m09_couplers_AWVALID;
  assign M_AXI_bready = auto_pc_to_m09_couplers_BREADY;
  assign M_AXI_rready = auto_pc_to_m09_couplers_RREADY;
  assign M_AXI_wdata[31:0] = auto_pc_to_m09_couplers_WDATA;
  assign M_AXI_wstrb[3:0] = auto_pc_to_m09_couplers_WSTRB;
  assign M_AXI_wvalid = auto_pc_to_m09_couplers_WVALID;
  assign S_ACLK_1 = S_ACLK;
  assign S_ARESETN_1 = S_ARESETN[0];
  assign S_AXI_arready = m09_couplers_to_auto_ds_ARREADY;
  assign S_AXI_awready = m09_couplers_to_auto_ds_AWREADY;
  assign S_AXI_bresp[1:0] = m09_couplers_to_auto_ds_BRESP;
  assign S_AXI_bvalid = m09_couplers_to_auto_ds_BVALID;
  assign S_AXI_rdata[511:0] = m09_couplers_to_auto_ds_RDATA;
  assign S_AXI_rlast = m09_couplers_to_auto_ds_RLAST;
  assign S_AXI_rresp[1:0] = m09_couplers_to_auto_ds_RRESP;
  assign S_AXI_rvalid = m09_couplers_to_auto_ds_RVALID;
  assign S_AXI_wready = m09_couplers_to_auto_ds_WREADY;
  assign auto_pc_to_m09_couplers_ARREADY = M_AXI_arready;
  assign auto_pc_to_m09_couplers_AWREADY = M_AXI_awready;
  assign auto_pc_to_m09_couplers_BRESP = M_AXI_bresp[1:0];
  assign auto_pc_to_m09_couplers_BVALID = M_AXI_bvalid;
  assign auto_pc_to_m09_couplers_RDATA = M_AXI_rdata[31:0];
  assign auto_pc_to_m09_couplers_RRESP = M_AXI_rresp[1:0];
  assign auto_pc_to_m09_couplers_RVALID = M_AXI_rvalid;
  assign auto_pc_to_m09_couplers_WREADY = M_AXI_wready;
  assign m09_couplers_to_auto_ds_ARADDR = S_AXI_araddr[31:0];
  assign m09_couplers_to_auto_ds_ARBURST = S_AXI_arburst[1:0];
  assign m09_couplers_to_auto_ds_ARCACHE = S_AXI_arcache[3:0];
  assign m09_couplers_to_auto_ds_ARLEN = S_AXI_arlen[7:0];
  assign m09_couplers_to_auto_ds_ARLOCK = S_AXI_arlock[0];
  assign m09_couplers_to_auto_ds_ARPROT = S_AXI_arprot[2:0];
  assign m09_couplers_to_auto_ds_ARQOS = S_AXI_arqos[3:0];
  assign m09_couplers_to_auto_ds_ARREGION = S_AXI_arregion[3:0];
  assign m09_couplers_to_auto_ds_ARSIZE = S_AXI_arsize[2:0];
  assign m09_couplers_to_auto_ds_ARVALID = S_AXI_arvalid;
  assign m09_couplers_to_auto_ds_AWADDR = S_AXI_awaddr[31:0];
  assign m09_couplers_to_auto_ds_AWBURST = S_AXI_awburst[1:0];
  assign m09_couplers_to_auto_ds_AWCACHE = S_AXI_awcache[3:0];
  assign m09_couplers_to_auto_ds_AWLEN = S_AXI_awlen[7:0];
  assign m09_couplers_to_auto_ds_AWLOCK = S_AXI_awlock[0];
  assign m09_couplers_to_auto_ds_AWPROT = S_AXI_awprot[2:0];
  assign m09_couplers_to_auto_ds_AWQOS = S_AXI_awqos[3:0];
  assign m09_couplers_to_auto_ds_AWREGION = S_AXI_awregion[3:0];
  assign m09_couplers_to_auto_ds_AWSIZE = S_AXI_awsize[2:0];
  assign m09_couplers_to_auto_ds_AWVALID = S_AXI_awvalid;
  assign m09_couplers_to_auto_ds_BREADY = S_AXI_bready;
  assign m09_couplers_to_auto_ds_RREADY = S_AXI_rready;
  assign m09_couplers_to_auto_ds_WDATA = S_AXI_wdata[511:0];
  assign m09_couplers_to_auto_ds_WLAST = S_AXI_wlast;
  assign m09_couplers_to_auto_ds_WSTRB = S_AXI_wstrb[63:0];
  assign m09_couplers_to_auto_ds_WVALID = S_AXI_wvalid;
  system_i_bak_auto_ds_8 auto_ds
       (.m_axi_araddr(auto_ds_to_auto_pc_ARADDR),
        .m_axi_arburst(auto_ds_to_auto_pc_ARBURST),
        .m_axi_arcache(auto_ds_to_auto_pc_ARCACHE),
        .m_axi_arlen(auto_ds_to_auto_pc_ARLEN),
        .m_axi_arlock(auto_ds_to_auto_pc_ARLOCK),
        .m_axi_arprot(auto_ds_to_auto_pc_ARPROT),
        .m_axi_arqos(auto_ds_to_auto_pc_ARQOS),
        .m_axi_arready(auto_ds_to_auto_pc_ARREADY),
        .m_axi_arregion(auto_ds_to_auto_pc_ARREGION),
        .m_axi_arsize(auto_ds_to_auto_pc_ARSIZE),
        .m_axi_arvalid(auto_ds_to_auto_pc_ARVALID),
        .m_axi_awaddr(auto_ds_to_auto_pc_AWADDR),
        .m_axi_awburst(auto_ds_to_auto_pc_AWBURST),
        .m_axi_awcache(auto_ds_to_auto_pc_AWCACHE),
        .m_axi_awlen(auto_ds_to_auto_pc_AWLEN),
        .m_axi_awlock(auto_ds_to_auto_pc_AWLOCK),
        .m_axi_awprot(auto_ds_to_auto_pc_AWPROT),
        .m_axi_awqos(auto_ds_to_auto_pc_AWQOS),
        .m_axi_awready(auto_ds_to_auto_pc_AWREADY),
        .m_axi_awregion(auto_ds_to_auto_pc_AWREGION),
        .m_axi_awsize(auto_ds_to_auto_pc_AWSIZE),
        .m_axi_awvalid(auto_ds_to_auto_pc_AWVALID),
        .m_axi_bready(auto_ds_to_auto_pc_BREADY),
        .m_axi_bresp(auto_ds_to_auto_pc_BRESP),
        .m_axi_bvalid(auto_ds_to_auto_pc_BVALID),
        .m_axi_rdata(auto_ds_to_auto_pc_RDATA),
        .m_axi_rlast(auto_ds_to_auto_pc_RLAST),
        .m_axi_rready(auto_ds_to_auto_pc_RREADY),
        .m_axi_rresp(auto_ds_to_auto_pc_RRESP),
        .m_axi_rvalid(auto_ds_to_auto_pc_RVALID),
        .m_axi_wdata(auto_ds_to_auto_pc_WDATA),
        .m_axi_wlast(auto_ds_to_auto_pc_WLAST),
        .m_axi_wready(auto_ds_to_auto_pc_WREADY),
        .m_axi_wstrb(auto_ds_to_auto_pc_WSTRB),
        .m_axi_wvalid(auto_ds_to_auto_pc_WVALID),
        .s_axi_aclk(S_ACLK_1),
        .s_axi_araddr(m09_couplers_to_auto_ds_ARADDR),
        .s_axi_arburst(m09_couplers_to_auto_ds_ARBURST),
        .s_axi_arcache(m09_couplers_to_auto_ds_ARCACHE),
        .s_axi_aresetn(S_ARESETN_1),
        .s_axi_arlen(m09_couplers_to_auto_ds_ARLEN),
        .s_axi_arlock(m09_couplers_to_auto_ds_ARLOCK),
        .s_axi_arprot(m09_couplers_to_auto_ds_ARPROT),
        .s_axi_arqos(m09_couplers_to_auto_ds_ARQOS),
        .s_axi_arready(m09_couplers_to_auto_ds_ARREADY),
        .s_axi_arregion(m09_couplers_to_auto_ds_ARREGION),
        .s_axi_arsize(m09_couplers_to_auto_ds_ARSIZE),
        .s_axi_arvalid(m09_couplers_to_auto_ds_ARVALID),
        .s_axi_awaddr(m09_couplers_to_auto_ds_AWADDR),
        .s_axi_awburst(m09_couplers_to_auto_ds_AWBURST),
        .s_axi_awcache(m09_couplers_to_auto_ds_AWCACHE),
        .s_axi_awlen(m09_couplers_to_auto_ds_AWLEN),
        .s_axi_awlock(m09_couplers_to_auto_ds_AWLOCK),
        .s_axi_awprot(m09_couplers_to_auto_ds_AWPROT),
        .s_axi_awqos(m09_couplers_to_auto_ds_AWQOS),
        .s_axi_awready(m09_couplers_to_auto_ds_AWREADY),
        .s_axi_awregion(m09_couplers_to_auto_ds_AWREGION),
        .s_axi_awsize(m09_couplers_to_auto_ds_AWSIZE),
        .s_axi_awvalid(m09_couplers_to_auto_ds_AWVALID),
        .s_axi_bready(m09_couplers_to_auto_ds_BREADY),
        .s_axi_bresp(m09_couplers_to_auto_ds_BRESP),
        .s_axi_bvalid(m09_couplers_to_auto_ds_BVALID),
        .s_axi_rdata(m09_couplers_to_auto_ds_RDATA),
        .s_axi_rlast(m09_couplers_to_auto_ds_RLAST),
        .s_axi_rready(m09_couplers_to_auto_ds_RREADY),
        .s_axi_rresp(m09_couplers_to_auto_ds_RRESP),
        .s_axi_rvalid(m09_couplers_to_auto_ds_RVALID),
        .s_axi_wdata(m09_couplers_to_auto_ds_WDATA),
        .s_axi_wlast(m09_couplers_to_auto_ds_WLAST),
        .s_axi_wready(m09_couplers_to_auto_ds_WREADY),
        .s_axi_wstrb(m09_couplers_to_auto_ds_WSTRB),
        .s_axi_wvalid(m09_couplers_to_auto_ds_WVALID));
  system_i_bak_auto_pc_7 auto_pc
       (.aclk(S_ACLK_1),
        .aresetn(S_ARESETN_1),
        .m_axi_araddr(auto_pc_to_m09_couplers_ARADDR),
        .m_axi_arready(auto_pc_to_m09_couplers_ARREADY),
        .m_axi_arvalid(auto_pc_to_m09_couplers_ARVALID),
        .m_axi_awaddr(auto_pc_to_m09_couplers_AWADDR),
        .m_axi_awready(auto_pc_to_m09_couplers_AWREADY),
        .m_axi_awvalid(auto_pc_to_m09_couplers_AWVALID),
        .m_axi_bready(auto_pc_to_m09_couplers_BREADY),
        .m_axi_bresp(auto_pc_to_m09_couplers_BRESP),
        .m_axi_bvalid(auto_pc_to_m09_couplers_BVALID),
        .m_axi_rdata(auto_pc_to_m09_couplers_RDATA),
        .m_axi_rready(auto_pc_to_m09_couplers_RREADY),
        .m_axi_rresp(auto_pc_to_m09_couplers_RRESP),
        .m_axi_rvalid(auto_pc_to_m09_couplers_RVALID),
        .m_axi_wdata(auto_pc_to_m09_couplers_WDATA),
        .m_axi_wready(auto_pc_to_m09_couplers_WREADY),
        .m_axi_wstrb(auto_pc_to_m09_couplers_WSTRB),
        .m_axi_wvalid(auto_pc_to_m09_couplers_WVALID),
        .s_axi_araddr(auto_ds_to_auto_pc_ARADDR),
        .s_axi_arburst(auto_ds_to_auto_pc_ARBURST),
        .s_axi_arcache(auto_ds_to_auto_pc_ARCACHE),
        .s_axi_arlen(auto_ds_to_auto_pc_ARLEN),
        .s_axi_arlock(auto_ds_to_auto_pc_ARLOCK),
        .s_axi_arprot(auto_ds_to_auto_pc_ARPROT),
        .s_axi_arqos(auto_ds_to_auto_pc_ARQOS),
        .s_axi_arready(auto_ds_to_auto_pc_ARREADY),
        .s_axi_arregion(auto_ds_to_auto_pc_ARREGION),
        .s_axi_arsize(auto_ds_to_auto_pc_ARSIZE),
        .s_axi_arvalid(auto_ds_to_auto_pc_ARVALID),
        .s_axi_awaddr(auto_ds_to_auto_pc_AWADDR),
        .s_axi_awburst(auto_ds_to_auto_pc_AWBURST),
        .s_axi_awcache(auto_ds_to_auto_pc_AWCACHE),
        .s_axi_awlen(auto_ds_to_auto_pc_AWLEN),
        .s_axi_awlock(auto_ds_to_auto_pc_AWLOCK),
        .s_axi_awprot(auto_ds_to_auto_pc_AWPROT),
        .s_axi_awqos(auto_ds_to_auto_pc_AWQOS),
        .s_axi_awready(auto_ds_to_auto_pc_AWREADY),
        .s_axi_awregion(auto_ds_to_auto_pc_AWREGION),
        .s_axi_awsize(auto_ds_to_auto_pc_AWSIZE),
        .s_axi_awvalid(auto_ds_to_auto_pc_AWVALID),
        .s_axi_bready(auto_ds_to_auto_pc_BREADY),
        .s_axi_bresp(auto_ds_to_auto_pc_BRESP),
        .s_axi_bvalid(auto_ds_to_auto_pc_BVALID),
        .s_axi_rdata(auto_ds_to_auto_pc_RDATA),
        .s_axi_rlast(auto_ds_to_auto_pc_RLAST),
        .s_axi_rready(auto_ds_to_auto_pc_RREADY),
        .s_axi_rresp(auto_ds_to_auto_pc_RRESP),
        .s_axi_rvalid(auto_ds_to_auto_pc_RVALID),
        .s_axi_wdata(auto_ds_to_auto_pc_WDATA),
        .s_axi_wlast(auto_ds_to_auto_pc_WLAST),
        .s_axi_wready(auto_ds_to_auto_pc_WREADY),
        .s_axi_wstrb(auto_ds_to_auto_pc_WSTRB),
        .s_axi_wvalid(auto_ds_to_auto_pc_WVALID));
endmodule

module m10_couplers_imp_1U1F8BM
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arburst,
    S_AXI_arcache,
    S_AXI_arlen,
    S_AXI_arlock,
    S_AXI_arprot,
    S_AXI_arqos,
    S_AXI_arready,
    S_AXI_arregion,
    S_AXI_arsize,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awburst,
    S_AXI_awcache,
    S_AXI_awlen,
    S_AXI_awlock,
    S_AXI_awprot,
    S_AXI_awqos,
    S_AXI_awready,
    S_AXI_awregion,
    S_AXI_awsize,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rlast,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wlast,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input [0:0]M_ARESETN;
  output [31:0]M_AXI_araddr;
  input M_AXI_arready;
  output M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  input M_AXI_awready;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  input M_AXI_wready;
  output M_AXI_wvalid;
  input S_ACLK;
  input [0:0]S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [1:0]S_AXI_arburst;
  input [3:0]S_AXI_arcache;
  input [7:0]S_AXI_arlen;
  input [0:0]S_AXI_arlock;
  input [2:0]S_AXI_arprot;
  input [3:0]S_AXI_arqos;
  output S_AXI_arready;
  input [3:0]S_AXI_arregion;
  input [2:0]S_AXI_arsize;
  input S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  input [1:0]S_AXI_awburst;
  input [3:0]S_AXI_awcache;
  input [7:0]S_AXI_awlen;
  input [0:0]S_AXI_awlock;
  input [2:0]S_AXI_awprot;
  input [3:0]S_AXI_awqos;
  output S_AXI_awready;
  input [3:0]S_AXI_awregion;
  input [2:0]S_AXI_awsize;
  input S_AXI_awvalid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [511:0]S_AXI_rdata;
  output S_AXI_rlast;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [511:0]S_AXI_wdata;
  input S_AXI_wlast;
  output S_AXI_wready;
  input [63:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire S_ACLK_1;
  wire [0:0]S_ARESETN_1;
  wire [31:0]auto_ds_to_auto_pc_ARADDR;
  wire [1:0]auto_ds_to_auto_pc_ARBURST;
  wire [3:0]auto_ds_to_auto_pc_ARCACHE;
  wire [7:0]auto_ds_to_auto_pc_ARLEN;
  wire [0:0]auto_ds_to_auto_pc_ARLOCK;
  wire [2:0]auto_ds_to_auto_pc_ARPROT;
  wire [3:0]auto_ds_to_auto_pc_ARQOS;
  wire auto_ds_to_auto_pc_ARREADY;
  wire [3:0]auto_ds_to_auto_pc_ARREGION;
  wire [2:0]auto_ds_to_auto_pc_ARSIZE;
  wire auto_ds_to_auto_pc_ARVALID;
  wire [31:0]auto_ds_to_auto_pc_AWADDR;
  wire [1:0]auto_ds_to_auto_pc_AWBURST;
  wire [3:0]auto_ds_to_auto_pc_AWCACHE;
  wire [7:0]auto_ds_to_auto_pc_AWLEN;
  wire [0:0]auto_ds_to_auto_pc_AWLOCK;
  wire [2:0]auto_ds_to_auto_pc_AWPROT;
  wire [3:0]auto_ds_to_auto_pc_AWQOS;
  wire auto_ds_to_auto_pc_AWREADY;
  wire [3:0]auto_ds_to_auto_pc_AWREGION;
  wire [2:0]auto_ds_to_auto_pc_AWSIZE;
  wire auto_ds_to_auto_pc_AWVALID;
  wire auto_ds_to_auto_pc_BREADY;
  wire [1:0]auto_ds_to_auto_pc_BRESP;
  wire auto_ds_to_auto_pc_BVALID;
  wire [31:0]auto_ds_to_auto_pc_RDATA;
  wire auto_ds_to_auto_pc_RLAST;
  wire auto_ds_to_auto_pc_RREADY;
  wire [1:0]auto_ds_to_auto_pc_RRESP;
  wire auto_ds_to_auto_pc_RVALID;
  wire [31:0]auto_ds_to_auto_pc_WDATA;
  wire auto_ds_to_auto_pc_WLAST;
  wire auto_ds_to_auto_pc_WREADY;
  wire [3:0]auto_ds_to_auto_pc_WSTRB;
  wire auto_ds_to_auto_pc_WVALID;
  wire [31:0]auto_pc_to_m10_couplers_ARADDR;
  wire auto_pc_to_m10_couplers_ARREADY;
  wire auto_pc_to_m10_couplers_ARVALID;
  wire [31:0]auto_pc_to_m10_couplers_AWADDR;
  wire auto_pc_to_m10_couplers_AWREADY;
  wire auto_pc_to_m10_couplers_AWVALID;
  wire auto_pc_to_m10_couplers_BREADY;
  wire [1:0]auto_pc_to_m10_couplers_BRESP;
  wire auto_pc_to_m10_couplers_BVALID;
  wire [31:0]auto_pc_to_m10_couplers_RDATA;
  wire auto_pc_to_m10_couplers_RREADY;
  wire [1:0]auto_pc_to_m10_couplers_RRESP;
  wire auto_pc_to_m10_couplers_RVALID;
  wire [31:0]auto_pc_to_m10_couplers_WDATA;
  wire auto_pc_to_m10_couplers_WREADY;
  wire auto_pc_to_m10_couplers_WVALID;
  wire [31:0]m10_couplers_to_auto_ds_ARADDR;
  wire [1:0]m10_couplers_to_auto_ds_ARBURST;
  wire [3:0]m10_couplers_to_auto_ds_ARCACHE;
  wire [7:0]m10_couplers_to_auto_ds_ARLEN;
  wire [0:0]m10_couplers_to_auto_ds_ARLOCK;
  wire [2:0]m10_couplers_to_auto_ds_ARPROT;
  wire [3:0]m10_couplers_to_auto_ds_ARQOS;
  wire m10_couplers_to_auto_ds_ARREADY;
  wire [3:0]m10_couplers_to_auto_ds_ARREGION;
  wire [2:0]m10_couplers_to_auto_ds_ARSIZE;
  wire m10_couplers_to_auto_ds_ARVALID;
  wire [31:0]m10_couplers_to_auto_ds_AWADDR;
  wire [1:0]m10_couplers_to_auto_ds_AWBURST;
  wire [3:0]m10_couplers_to_auto_ds_AWCACHE;
  wire [7:0]m10_couplers_to_auto_ds_AWLEN;
  wire [0:0]m10_couplers_to_auto_ds_AWLOCK;
  wire [2:0]m10_couplers_to_auto_ds_AWPROT;
  wire [3:0]m10_couplers_to_auto_ds_AWQOS;
  wire m10_couplers_to_auto_ds_AWREADY;
  wire [3:0]m10_couplers_to_auto_ds_AWREGION;
  wire [2:0]m10_couplers_to_auto_ds_AWSIZE;
  wire m10_couplers_to_auto_ds_AWVALID;
  wire m10_couplers_to_auto_ds_BREADY;
  wire [1:0]m10_couplers_to_auto_ds_BRESP;
  wire m10_couplers_to_auto_ds_BVALID;
  wire [511:0]m10_couplers_to_auto_ds_RDATA;
  wire m10_couplers_to_auto_ds_RLAST;
  wire m10_couplers_to_auto_ds_RREADY;
  wire [1:0]m10_couplers_to_auto_ds_RRESP;
  wire m10_couplers_to_auto_ds_RVALID;
  wire [511:0]m10_couplers_to_auto_ds_WDATA;
  wire m10_couplers_to_auto_ds_WLAST;
  wire m10_couplers_to_auto_ds_WREADY;
  wire [63:0]m10_couplers_to_auto_ds_WSTRB;
  wire m10_couplers_to_auto_ds_WVALID;

  assign M_AXI_araddr[31:0] = auto_pc_to_m10_couplers_ARADDR;
  assign M_AXI_arvalid = auto_pc_to_m10_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = auto_pc_to_m10_couplers_AWADDR;
  assign M_AXI_awvalid = auto_pc_to_m10_couplers_AWVALID;
  assign M_AXI_bready = auto_pc_to_m10_couplers_BREADY;
  assign M_AXI_rready = auto_pc_to_m10_couplers_RREADY;
  assign M_AXI_wdata[31:0] = auto_pc_to_m10_couplers_WDATA;
  assign M_AXI_wvalid = auto_pc_to_m10_couplers_WVALID;
  assign S_ACLK_1 = S_ACLK;
  assign S_ARESETN_1 = S_ARESETN[0];
  assign S_AXI_arready = m10_couplers_to_auto_ds_ARREADY;
  assign S_AXI_awready = m10_couplers_to_auto_ds_AWREADY;
  assign S_AXI_bresp[1:0] = m10_couplers_to_auto_ds_BRESP;
  assign S_AXI_bvalid = m10_couplers_to_auto_ds_BVALID;
  assign S_AXI_rdata[511:0] = m10_couplers_to_auto_ds_RDATA;
  assign S_AXI_rlast = m10_couplers_to_auto_ds_RLAST;
  assign S_AXI_rresp[1:0] = m10_couplers_to_auto_ds_RRESP;
  assign S_AXI_rvalid = m10_couplers_to_auto_ds_RVALID;
  assign S_AXI_wready = m10_couplers_to_auto_ds_WREADY;
  assign auto_pc_to_m10_couplers_ARREADY = M_AXI_arready;
  assign auto_pc_to_m10_couplers_AWREADY = M_AXI_awready;
  assign auto_pc_to_m10_couplers_BRESP = M_AXI_bresp[1:0];
  assign auto_pc_to_m10_couplers_BVALID = M_AXI_bvalid;
  assign auto_pc_to_m10_couplers_RDATA = M_AXI_rdata[31:0];
  assign auto_pc_to_m10_couplers_RRESP = M_AXI_rresp[1:0];
  assign auto_pc_to_m10_couplers_RVALID = M_AXI_rvalid;
  assign auto_pc_to_m10_couplers_WREADY = M_AXI_wready;
  assign m10_couplers_to_auto_ds_ARADDR = S_AXI_araddr[31:0];
  assign m10_couplers_to_auto_ds_ARBURST = S_AXI_arburst[1:0];
  assign m10_couplers_to_auto_ds_ARCACHE = S_AXI_arcache[3:0];
  assign m10_couplers_to_auto_ds_ARLEN = S_AXI_arlen[7:0];
  assign m10_couplers_to_auto_ds_ARLOCK = S_AXI_arlock[0];
  assign m10_couplers_to_auto_ds_ARPROT = S_AXI_arprot[2:0];
  assign m10_couplers_to_auto_ds_ARQOS = S_AXI_arqos[3:0];
  assign m10_couplers_to_auto_ds_ARREGION = S_AXI_arregion[3:0];
  assign m10_couplers_to_auto_ds_ARSIZE = S_AXI_arsize[2:0];
  assign m10_couplers_to_auto_ds_ARVALID = S_AXI_arvalid;
  assign m10_couplers_to_auto_ds_AWADDR = S_AXI_awaddr[31:0];
  assign m10_couplers_to_auto_ds_AWBURST = S_AXI_awburst[1:0];
  assign m10_couplers_to_auto_ds_AWCACHE = S_AXI_awcache[3:0];
  assign m10_couplers_to_auto_ds_AWLEN = S_AXI_awlen[7:0];
  assign m10_couplers_to_auto_ds_AWLOCK = S_AXI_awlock[0];
  assign m10_couplers_to_auto_ds_AWPROT = S_AXI_awprot[2:0];
  assign m10_couplers_to_auto_ds_AWQOS = S_AXI_awqos[3:0];
  assign m10_couplers_to_auto_ds_AWREGION = S_AXI_awregion[3:0];
  assign m10_couplers_to_auto_ds_AWSIZE = S_AXI_awsize[2:0];
  assign m10_couplers_to_auto_ds_AWVALID = S_AXI_awvalid;
  assign m10_couplers_to_auto_ds_BREADY = S_AXI_bready;
  assign m10_couplers_to_auto_ds_RREADY = S_AXI_rready;
  assign m10_couplers_to_auto_ds_WDATA = S_AXI_wdata[511:0];
  assign m10_couplers_to_auto_ds_WLAST = S_AXI_wlast;
  assign m10_couplers_to_auto_ds_WSTRB = S_AXI_wstrb[63:0];
  assign m10_couplers_to_auto_ds_WVALID = S_AXI_wvalid;
  system_i_bak_auto_ds_9 auto_ds
       (.m_axi_araddr(auto_ds_to_auto_pc_ARADDR),
        .m_axi_arburst(auto_ds_to_auto_pc_ARBURST),
        .m_axi_arcache(auto_ds_to_auto_pc_ARCACHE),
        .m_axi_arlen(auto_ds_to_auto_pc_ARLEN),
        .m_axi_arlock(auto_ds_to_auto_pc_ARLOCK),
        .m_axi_arprot(auto_ds_to_auto_pc_ARPROT),
        .m_axi_arqos(auto_ds_to_auto_pc_ARQOS),
        .m_axi_arready(auto_ds_to_auto_pc_ARREADY),
        .m_axi_arregion(auto_ds_to_auto_pc_ARREGION),
        .m_axi_arsize(auto_ds_to_auto_pc_ARSIZE),
        .m_axi_arvalid(auto_ds_to_auto_pc_ARVALID),
        .m_axi_awaddr(auto_ds_to_auto_pc_AWADDR),
        .m_axi_awburst(auto_ds_to_auto_pc_AWBURST),
        .m_axi_awcache(auto_ds_to_auto_pc_AWCACHE),
        .m_axi_awlen(auto_ds_to_auto_pc_AWLEN),
        .m_axi_awlock(auto_ds_to_auto_pc_AWLOCK),
        .m_axi_awprot(auto_ds_to_auto_pc_AWPROT),
        .m_axi_awqos(auto_ds_to_auto_pc_AWQOS),
        .m_axi_awready(auto_ds_to_auto_pc_AWREADY),
        .m_axi_awregion(auto_ds_to_auto_pc_AWREGION),
        .m_axi_awsize(auto_ds_to_auto_pc_AWSIZE),
        .m_axi_awvalid(auto_ds_to_auto_pc_AWVALID),
        .m_axi_bready(auto_ds_to_auto_pc_BREADY),
        .m_axi_bresp(auto_ds_to_auto_pc_BRESP),
        .m_axi_bvalid(auto_ds_to_auto_pc_BVALID),
        .m_axi_rdata(auto_ds_to_auto_pc_RDATA),
        .m_axi_rlast(auto_ds_to_auto_pc_RLAST),
        .m_axi_rready(auto_ds_to_auto_pc_RREADY),
        .m_axi_rresp(auto_ds_to_auto_pc_RRESP),
        .m_axi_rvalid(auto_ds_to_auto_pc_RVALID),
        .m_axi_wdata(auto_ds_to_auto_pc_WDATA),
        .m_axi_wlast(auto_ds_to_auto_pc_WLAST),
        .m_axi_wready(auto_ds_to_auto_pc_WREADY),
        .m_axi_wstrb(auto_ds_to_auto_pc_WSTRB),
        .m_axi_wvalid(auto_ds_to_auto_pc_WVALID),
        .s_axi_aclk(S_ACLK_1),
        .s_axi_araddr(m10_couplers_to_auto_ds_ARADDR),
        .s_axi_arburst(m10_couplers_to_auto_ds_ARBURST),
        .s_axi_arcache(m10_couplers_to_auto_ds_ARCACHE),
        .s_axi_aresetn(S_ARESETN_1),
        .s_axi_arlen(m10_couplers_to_auto_ds_ARLEN),
        .s_axi_arlock(m10_couplers_to_auto_ds_ARLOCK),
        .s_axi_arprot(m10_couplers_to_auto_ds_ARPROT),
        .s_axi_arqos(m10_couplers_to_auto_ds_ARQOS),
        .s_axi_arready(m10_couplers_to_auto_ds_ARREADY),
        .s_axi_arregion(m10_couplers_to_auto_ds_ARREGION),
        .s_axi_arsize(m10_couplers_to_auto_ds_ARSIZE),
        .s_axi_arvalid(m10_couplers_to_auto_ds_ARVALID),
        .s_axi_awaddr(m10_couplers_to_auto_ds_AWADDR),
        .s_axi_awburst(m10_couplers_to_auto_ds_AWBURST),
        .s_axi_awcache(m10_couplers_to_auto_ds_AWCACHE),
        .s_axi_awlen(m10_couplers_to_auto_ds_AWLEN),
        .s_axi_awlock(m10_couplers_to_auto_ds_AWLOCK),
        .s_axi_awprot(m10_couplers_to_auto_ds_AWPROT),
        .s_axi_awqos(m10_couplers_to_auto_ds_AWQOS),
        .s_axi_awready(m10_couplers_to_auto_ds_AWREADY),
        .s_axi_awregion(m10_couplers_to_auto_ds_AWREGION),
        .s_axi_awsize(m10_couplers_to_auto_ds_AWSIZE),
        .s_axi_awvalid(m10_couplers_to_auto_ds_AWVALID),
        .s_axi_bready(m10_couplers_to_auto_ds_BREADY),
        .s_axi_bresp(m10_couplers_to_auto_ds_BRESP),
        .s_axi_bvalid(m10_couplers_to_auto_ds_BVALID),
        .s_axi_rdata(m10_couplers_to_auto_ds_RDATA),
        .s_axi_rlast(m10_couplers_to_auto_ds_RLAST),
        .s_axi_rready(m10_couplers_to_auto_ds_RREADY),
        .s_axi_rresp(m10_couplers_to_auto_ds_RRESP),
        .s_axi_rvalid(m10_couplers_to_auto_ds_RVALID),
        .s_axi_wdata(m10_couplers_to_auto_ds_WDATA),
        .s_axi_wlast(m10_couplers_to_auto_ds_WLAST),
        .s_axi_wready(m10_couplers_to_auto_ds_WREADY),
        .s_axi_wstrb(m10_couplers_to_auto_ds_WSTRB),
        .s_axi_wvalid(m10_couplers_to_auto_ds_WVALID));
  system_i_bak_auto_pc_8 auto_pc
       (.aclk(S_ACLK_1),
        .aresetn(S_ARESETN_1),
        .m_axi_araddr(auto_pc_to_m10_couplers_ARADDR),
        .m_axi_arready(auto_pc_to_m10_couplers_ARREADY),
        .m_axi_arvalid(auto_pc_to_m10_couplers_ARVALID),
        .m_axi_awaddr(auto_pc_to_m10_couplers_AWADDR),
        .m_axi_awready(auto_pc_to_m10_couplers_AWREADY),
        .m_axi_awvalid(auto_pc_to_m10_couplers_AWVALID),
        .m_axi_bready(auto_pc_to_m10_couplers_BREADY),
        .m_axi_bresp(auto_pc_to_m10_couplers_BRESP),
        .m_axi_bvalid(auto_pc_to_m10_couplers_BVALID),
        .m_axi_rdata(auto_pc_to_m10_couplers_RDATA),
        .m_axi_rready(auto_pc_to_m10_couplers_RREADY),
        .m_axi_rresp(auto_pc_to_m10_couplers_RRESP),
        .m_axi_rvalid(auto_pc_to_m10_couplers_RVALID),
        .m_axi_wdata(auto_pc_to_m10_couplers_WDATA),
        .m_axi_wready(auto_pc_to_m10_couplers_WREADY),
        .m_axi_wvalid(auto_pc_to_m10_couplers_WVALID),
        .s_axi_araddr(auto_ds_to_auto_pc_ARADDR),
        .s_axi_arburst(auto_ds_to_auto_pc_ARBURST),
        .s_axi_arcache(auto_ds_to_auto_pc_ARCACHE),
        .s_axi_arlen(auto_ds_to_auto_pc_ARLEN),
        .s_axi_arlock(auto_ds_to_auto_pc_ARLOCK),
        .s_axi_arprot(auto_ds_to_auto_pc_ARPROT),
        .s_axi_arqos(auto_ds_to_auto_pc_ARQOS),
        .s_axi_arready(auto_ds_to_auto_pc_ARREADY),
        .s_axi_arregion(auto_ds_to_auto_pc_ARREGION),
        .s_axi_arsize(auto_ds_to_auto_pc_ARSIZE),
        .s_axi_arvalid(auto_ds_to_auto_pc_ARVALID),
        .s_axi_awaddr(auto_ds_to_auto_pc_AWADDR),
        .s_axi_awburst(auto_ds_to_auto_pc_AWBURST),
        .s_axi_awcache(auto_ds_to_auto_pc_AWCACHE),
        .s_axi_awlen(auto_ds_to_auto_pc_AWLEN),
        .s_axi_awlock(auto_ds_to_auto_pc_AWLOCK),
        .s_axi_awprot(auto_ds_to_auto_pc_AWPROT),
        .s_axi_awqos(auto_ds_to_auto_pc_AWQOS),
        .s_axi_awready(auto_ds_to_auto_pc_AWREADY),
        .s_axi_awregion(auto_ds_to_auto_pc_AWREGION),
        .s_axi_awsize(auto_ds_to_auto_pc_AWSIZE),
        .s_axi_awvalid(auto_ds_to_auto_pc_AWVALID),
        .s_axi_bready(auto_ds_to_auto_pc_BREADY),
        .s_axi_bresp(auto_ds_to_auto_pc_BRESP),
        .s_axi_bvalid(auto_ds_to_auto_pc_BVALID),
        .s_axi_rdata(auto_ds_to_auto_pc_RDATA),
        .s_axi_rlast(auto_ds_to_auto_pc_RLAST),
        .s_axi_rready(auto_ds_to_auto_pc_RREADY),
        .s_axi_rresp(auto_ds_to_auto_pc_RRESP),
        .s_axi_rvalid(auto_ds_to_auto_pc_RVALID),
        .s_axi_wdata(auto_ds_to_auto_pc_WDATA),
        .s_axi_wlast(auto_ds_to_auto_pc_WLAST),
        .s_axi_wready(auto_ds_to_auto_pc_WREADY),
        .s_axi_wstrb(auto_ds_to_auto_pc_WSTRB),
        .s_axi_wvalid(auto_ds_to_auto_pc_WVALID));
endmodule

module m11_couplers_imp_1X4USKI
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arprot,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awprot,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arburst,
    S_AXI_arcache,
    S_AXI_arlen,
    S_AXI_arlock,
    S_AXI_arprot,
    S_AXI_arqos,
    S_AXI_arready,
    S_AXI_arregion,
    S_AXI_arsize,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awburst,
    S_AXI_awcache,
    S_AXI_awlen,
    S_AXI_awlock,
    S_AXI_awprot,
    S_AXI_awqos,
    S_AXI_awready,
    S_AXI_awregion,
    S_AXI_awsize,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rlast,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wlast,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input [0:0]M_ARESETN;
  output [31:0]M_AXI_araddr;
  output [2:0]M_AXI_arprot;
  input M_AXI_arready;
  output M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  output [2:0]M_AXI_awprot;
  input M_AXI_awready;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  input M_AXI_wready;
  output [3:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input [0:0]S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [1:0]S_AXI_arburst;
  input [3:0]S_AXI_arcache;
  input [7:0]S_AXI_arlen;
  input [0:0]S_AXI_arlock;
  input [2:0]S_AXI_arprot;
  input [3:0]S_AXI_arqos;
  output S_AXI_arready;
  input [3:0]S_AXI_arregion;
  input [2:0]S_AXI_arsize;
  input S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  input [1:0]S_AXI_awburst;
  input [3:0]S_AXI_awcache;
  input [7:0]S_AXI_awlen;
  input [0:0]S_AXI_awlock;
  input [2:0]S_AXI_awprot;
  input [3:0]S_AXI_awqos;
  output S_AXI_awready;
  input [3:0]S_AXI_awregion;
  input [2:0]S_AXI_awsize;
  input S_AXI_awvalid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [511:0]S_AXI_rdata;
  output S_AXI_rlast;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [511:0]S_AXI_wdata;
  input S_AXI_wlast;
  output S_AXI_wready;
  input [63:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire S_ACLK_1;
  wire [0:0]S_ARESETN_1;
  wire [31:0]auto_ds_to_auto_pc_ARADDR;
  wire [1:0]auto_ds_to_auto_pc_ARBURST;
  wire [3:0]auto_ds_to_auto_pc_ARCACHE;
  wire [7:0]auto_ds_to_auto_pc_ARLEN;
  wire [0:0]auto_ds_to_auto_pc_ARLOCK;
  wire [2:0]auto_ds_to_auto_pc_ARPROT;
  wire [3:0]auto_ds_to_auto_pc_ARQOS;
  wire auto_ds_to_auto_pc_ARREADY;
  wire [3:0]auto_ds_to_auto_pc_ARREGION;
  wire [2:0]auto_ds_to_auto_pc_ARSIZE;
  wire auto_ds_to_auto_pc_ARVALID;
  wire [31:0]auto_ds_to_auto_pc_AWADDR;
  wire [1:0]auto_ds_to_auto_pc_AWBURST;
  wire [3:0]auto_ds_to_auto_pc_AWCACHE;
  wire [7:0]auto_ds_to_auto_pc_AWLEN;
  wire [0:0]auto_ds_to_auto_pc_AWLOCK;
  wire [2:0]auto_ds_to_auto_pc_AWPROT;
  wire [3:0]auto_ds_to_auto_pc_AWQOS;
  wire auto_ds_to_auto_pc_AWREADY;
  wire [3:0]auto_ds_to_auto_pc_AWREGION;
  wire [2:0]auto_ds_to_auto_pc_AWSIZE;
  wire auto_ds_to_auto_pc_AWVALID;
  wire auto_ds_to_auto_pc_BREADY;
  wire [1:0]auto_ds_to_auto_pc_BRESP;
  wire auto_ds_to_auto_pc_BVALID;
  wire [31:0]auto_ds_to_auto_pc_RDATA;
  wire auto_ds_to_auto_pc_RLAST;
  wire auto_ds_to_auto_pc_RREADY;
  wire [1:0]auto_ds_to_auto_pc_RRESP;
  wire auto_ds_to_auto_pc_RVALID;
  wire [31:0]auto_ds_to_auto_pc_WDATA;
  wire auto_ds_to_auto_pc_WLAST;
  wire auto_ds_to_auto_pc_WREADY;
  wire [3:0]auto_ds_to_auto_pc_WSTRB;
  wire auto_ds_to_auto_pc_WVALID;
  wire [31:0]auto_pc_to_m11_couplers_ARADDR;
  wire [2:0]auto_pc_to_m11_couplers_ARPROT;
  wire auto_pc_to_m11_couplers_ARREADY;
  wire auto_pc_to_m11_couplers_ARVALID;
  wire [31:0]auto_pc_to_m11_couplers_AWADDR;
  wire [2:0]auto_pc_to_m11_couplers_AWPROT;
  wire auto_pc_to_m11_couplers_AWREADY;
  wire auto_pc_to_m11_couplers_AWVALID;
  wire auto_pc_to_m11_couplers_BREADY;
  wire [1:0]auto_pc_to_m11_couplers_BRESP;
  wire auto_pc_to_m11_couplers_BVALID;
  wire [31:0]auto_pc_to_m11_couplers_RDATA;
  wire auto_pc_to_m11_couplers_RREADY;
  wire [1:0]auto_pc_to_m11_couplers_RRESP;
  wire auto_pc_to_m11_couplers_RVALID;
  wire [31:0]auto_pc_to_m11_couplers_WDATA;
  wire auto_pc_to_m11_couplers_WREADY;
  wire [3:0]auto_pc_to_m11_couplers_WSTRB;
  wire auto_pc_to_m11_couplers_WVALID;
  wire [31:0]m11_couplers_to_auto_ds_ARADDR;
  wire [1:0]m11_couplers_to_auto_ds_ARBURST;
  wire [3:0]m11_couplers_to_auto_ds_ARCACHE;
  wire [7:0]m11_couplers_to_auto_ds_ARLEN;
  wire [0:0]m11_couplers_to_auto_ds_ARLOCK;
  wire [2:0]m11_couplers_to_auto_ds_ARPROT;
  wire [3:0]m11_couplers_to_auto_ds_ARQOS;
  wire m11_couplers_to_auto_ds_ARREADY;
  wire [3:0]m11_couplers_to_auto_ds_ARREGION;
  wire [2:0]m11_couplers_to_auto_ds_ARSIZE;
  wire m11_couplers_to_auto_ds_ARVALID;
  wire [31:0]m11_couplers_to_auto_ds_AWADDR;
  wire [1:0]m11_couplers_to_auto_ds_AWBURST;
  wire [3:0]m11_couplers_to_auto_ds_AWCACHE;
  wire [7:0]m11_couplers_to_auto_ds_AWLEN;
  wire [0:0]m11_couplers_to_auto_ds_AWLOCK;
  wire [2:0]m11_couplers_to_auto_ds_AWPROT;
  wire [3:0]m11_couplers_to_auto_ds_AWQOS;
  wire m11_couplers_to_auto_ds_AWREADY;
  wire [3:0]m11_couplers_to_auto_ds_AWREGION;
  wire [2:0]m11_couplers_to_auto_ds_AWSIZE;
  wire m11_couplers_to_auto_ds_AWVALID;
  wire m11_couplers_to_auto_ds_BREADY;
  wire [1:0]m11_couplers_to_auto_ds_BRESP;
  wire m11_couplers_to_auto_ds_BVALID;
  wire [511:0]m11_couplers_to_auto_ds_RDATA;
  wire m11_couplers_to_auto_ds_RLAST;
  wire m11_couplers_to_auto_ds_RREADY;
  wire [1:0]m11_couplers_to_auto_ds_RRESP;
  wire m11_couplers_to_auto_ds_RVALID;
  wire [511:0]m11_couplers_to_auto_ds_WDATA;
  wire m11_couplers_to_auto_ds_WLAST;
  wire m11_couplers_to_auto_ds_WREADY;
  wire [63:0]m11_couplers_to_auto_ds_WSTRB;
  wire m11_couplers_to_auto_ds_WVALID;

  assign M_AXI_araddr[31:0] = auto_pc_to_m11_couplers_ARADDR;
  assign M_AXI_arprot[2:0] = auto_pc_to_m11_couplers_ARPROT;
  assign M_AXI_arvalid = auto_pc_to_m11_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = auto_pc_to_m11_couplers_AWADDR;
  assign M_AXI_awprot[2:0] = auto_pc_to_m11_couplers_AWPROT;
  assign M_AXI_awvalid = auto_pc_to_m11_couplers_AWVALID;
  assign M_AXI_bready = auto_pc_to_m11_couplers_BREADY;
  assign M_AXI_rready = auto_pc_to_m11_couplers_RREADY;
  assign M_AXI_wdata[31:0] = auto_pc_to_m11_couplers_WDATA;
  assign M_AXI_wstrb[3:0] = auto_pc_to_m11_couplers_WSTRB;
  assign M_AXI_wvalid = auto_pc_to_m11_couplers_WVALID;
  assign S_ACLK_1 = S_ACLK;
  assign S_ARESETN_1 = S_ARESETN[0];
  assign S_AXI_arready = m11_couplers_to_auto_ds_ARREADY;
  assign S_AXI_awready = m11_couplers_to_auto_ds_AWREADY;
  assign S_AXI_bresp[1:0] = m11_couplers_to_auto_ds_BRESP;
  assign S_AXI_bvalid = m11_couplers_to_auto_ds_BVALID;
  assign S_AXI_rdata[511:0] = m11_couplers_to_auto_ds_RDATA;
  assign S_AXI_rlast = m11_couplers_to_auto_ds_RLAST;
  assign S_AXI_rresp[1:0] = m11_couplers_to_auto_ds_RRESP;
  assign S_AXI_rvalid = m11_couplers_to_auto_ds_RVALID;
  assign S_AXI_wready = m11_couplers_to_auto_ds_WREADY;
  assign auto_pc_to_m11_couplers_ARREADY = M_AXI_arready;
  assign auto_pc_to_m11_couplers_AWREADY = M_AXI_awready;
  assign auto_pc_to_m11_couplers_BRESP = M_AXI_bresp[1:0];
  assign auto_pc_to_m11_couplers_BVALID = M_AXI_bvalid;
  assign auto_pc_to_m11_couplers_RDATA = M_AXI_rdata[31:0];
  assign auto_pc_to_m11_couplers_RRESP = M_AXI_rresp[1:0];
  assign auto_pc_to_m11_couplers_RVALID = M_AXI_rvalid;
  assign auto_pc_to_m11_couplers_WREADY = M_AXI_wready;
  assign m11_couplers_to_auto_ds_ARADDR = S_AXI_araddr[31:0];
  assign m11_couplers_to_auto_ds_ARBURST = S_AXI_arburst[1:0];
  assign m11_couplers_to_auto_ds_ARCACHE = S_AXI_arcache[3:0];
  assign m11_couplers_to_auto_ds_ARLEN = S_AXI_arlen[7:0];
  assign m11_couplers_to_auto_ds_ARLOCK = S_AXI_arlock[0];
  assign m11_couplers_to_auto_ds_ARPROT = S_AXI_arprot[2:0];
  assign m11_couplers_to_auto_ds_ARQOS = S_AXI_arqos[3:0];
  assign m11_couplers_to_auto_ds_ARREGION = S_AXI_arregion[3:0];
  assign m11_couplers_to_auto_ds_ARSIZE = S_AXI_arsize[2:0];
  assign m11_couplers_to_auto_ds_ARVALID = S_AXI_arvalid;
  assign m11_couplers_to_auto_ds_AWADDR = S_AXI_awaddr[31:0];
  assign m11_couplers_to_auto_ds_AWBURST = S_AXI_awburst[1:0];
  assign m11_couplers_to_auto_ds_AWCACHE = S_AXI_awcache[3:0];
  assign m11_couplers_to_auto_ds_AWLEN = S_AXI_awlen[7:0];
  assign m11_couplers_to_auto_ds_AWLOCK = S_AXI_awlock[0];
  assign m11_couplers_to_auto_ds_AWPROT = S_AXI_awprot[2:0];
  assign m11_couplers_to_auto_ds_AWQOS = S_AXI_awqos[3:0];
  assign m11_couplers_to_auto_ds_AWREGION = S_AXI_awregion[3:0];
  assign m11_couplers_to_auto_ds_AWSIZE = S_AXI_awsize[2:0];
  assign m11_couplers_to_auto_ds_AWVALID = S_AXI_awvalid;
  assign m11_couplers_to_auto_ds_BREADY = S_AXI_bready;
  assign m11_couplers_to_auto_ds_RREADY = S_AXI_rready;
  assign m11_couplers_to_auto_ds_WDATA = S_AXI_wdata[511:0];
  assign m11_couplers_to_auto_ds_WLAST = S_AXI_wlast;
  assign m11_couplers_to_auto_ds_WSTRB = S_AXI_wstrb[63:0];
  assign m11_couplers_to_auto_ds_WVALID = S_AXI_wvalid;
  system_i_bak_auto_ds_10 auto_ds
       (.m_axi_araddr(auto_ds_to_auto_pc_ARADDR),
        .m_axi_arburst(auto_ds_to_auto_pc_ARBURST),
        .m_axi_arcache(auto_ds_to_auto_pc_ARCACHE),
        .m_axi_arlen(auto_ds_to_auto_pc_ARLEN),
        .m_axi_arlock(auto_ds_to_auto_pc_ARLOCK),
        .m_axi_arprot(auto_ds_to_auto_pc_ARPROT),
        .m_axi_arqos(auto_ds_to_auto_pc_ARQOS),
        .m_axi_arready(auto_ds_to_auto_pc_ARREADY),
        .m_axi_arregion(auto_ds_to_auto_pc_ARREGION),
        .m_axi_arsize(auto_ds_to_auto_pc_ARSIZE),
        .m_axi_arvalid(auto_ds_to_auto_pc_ARVALID),
        .m_axi_awaddr(auto_ds_to_auto_pc_AWADDR),
        .m_axi_awburst(auto_ds_to_auto_pc_AWBURST),
        .m_axi_awcache(auto_ds_to_auto_pc_AWCACHE),
        .m_axi_awlen(auto_ds_to_auto_pc_AWLEN),
        .m_axi_awlock(auto_ds_to_auto_pc_AWLOCK),
        .m_axi_awprot(auto_ds_to_auto_pc_AWPROT),
        .m_axi_awqos(auto_ds_to_auto_pc_AWQOS),
        .m_axi_awready(auto_ds_to_auto_pc_AWREADY),
        .m_axi_awregion(auto_ds_to_auto_pc_AWREGION),
        .m_axi_awsize(auto_ds_to_auto_pc_AWSIZE),
        .m_axi_awvalid(auto_ds_to_auto_pc_AWVALID),
        .m_axi_bready(auto_ds_to_auto_pc_BREADY),
        .m_axi_bresp(auto_ds_to_auto_pc_BRESP),
        .m_axi_bvalid(auto_ds_to_auto_pc_BVALID),
        .m_axi_rdata(auto_ds_to_auto_pc_RDATA),
        .m_axi_rlast(auto_ds_to_auto_pc_RLAST),
        .m_axi_rready(auto_ds_to_auto_pc_RREADY),
        .m_axi_rresp(auto_ds_to_auto_pc_RRESP),
        .m_axi_rvalid(auto_ds_to_auto_pc_RVALID),
        .m_axi_wdata(auto_ds_to_auto_pc_WDATA),
        .m_axi_wlast(auto_ds_to_auto_pc_WLAST),
        .m_axi_wready(auto_ds_to_auto_pc_WREADY),
        .m_axi_wstrb(auto_ds_to_auto_pc_WSTRB),
        .m_axi_wvalid(auto_ds_to_auto_pc_WVALID),
        .s_axi_aclk(S_ACLK_1),
        .s_axi_araddr(m11_couplers_to_auto_ds_ARADDR),
        .s_axi_arburst(m11_couplers_to_auto_ds_ARBURST),
        .s_axi_arcache(m11_couplers_to_auto_ds_ARCACHE),
        .s_axi_aresetn(S_ARESETN_1),
        .s_axi_arlen(m11_couplers_to_auto_ds_ARLEN),
        .s_axi_arlock(m11_couplers_to_auto_ds_ARLOCK),
        .s_axi_arprot(m11_couplers_to_auto_ds_ARPROT),
        .s_axi_arqos(m11_couplers_to_auto_ds_ARQOS),
        .s_axi_arready(m11_couplers_to_auto_ds_ARREADY),
        .s_axi_arregion(m11_couplers_to_auto_ds_ARREGION),
        .s_axi_arsize(m11_couplers_to_auto_ds_ARSIZE),
        .s_axi_arvalid(m11_couplers_to_auto_ds_ARVALID),
        .s_axi_awaddr(m11_couplers_to_auto_ds_AWADDR),
        .s_axi_awburst(m11_couplers_to_auto_ds_AWBURST),
        .s_axi_awcache(m11_couplers_to_auto_ds_AWCACHE),
        .s_axi_awlen(m11_couplers_to_auto_ds_AWLEN),
        .s_axi_awlock(m11_couplers_to_auto_ds_AWLOCK),
        .s_axi_awprot(m11_couplers_to_auto_ds_AWPROT),
        .s_axi_awqos(m11_couplers_to_auto_ds_AWQOS),
        .s_axi_awready(m11_couplers_to_auto_ds_AWREADY),
        .s_axi_awregion(m11_couplers_to_auto_ds_AWREGION),
        .s_axi_awsize(m11_couplers_to_auto_ds_AWSIZE),
        .s_axi_awvalid(m11_couplers_to_auto_ds_AWVALID),
        .s_axi_bready(m11_couplers_to_auto_ds_BREADY),
        .s_axi_bresp(m11_couplers_to_auto_ds_BRESP),
        .s_axi_bvalid(m11_couplers_to_auto_ds_BVALID),
        .s_axi_rdata(m11_couplers_to_auto_ds_RDATA),
        .s_axi_rlast(m11_couplers_to_auto_ds_RLAST),
        .s_axi_rready(m11_couplers_to_auto_ds_RREADY),
        .s_axi_rresp(m11_couplers_to_auto_ds_RRESP),
        .s_axi_rvalid(m11_couplers_to_auto_ds_RVALID),
        .s_axi_wdata(m11_couplers_to_auto_ds_WDATA),
        .s_axi_wlast(m11_couplers_to_auto_ds_WLAST),
        .s_axi_wready(m11_couplers_to_auto_ds_WREADY),
        .s_axi_wstrb(m11_couplers_to_auto_ds_WSTRB),
        .s_axi_wvalid(m11_couplers_to_auto_ds_WVALID));
  system_i_bak_auto_pc_9 auto_pc
       (.aclk(S_ACLK_1),
        .aresetn(S_ARESETN_1),
        .m_axi_araddr(auto_pc_to_m11_couplers_ARADDR),
        .m_axi_arprot(auto_pc_to_m11_couplers_ARPROT),
        .m_axi_arready(auto_pc_to_m11_couplers_ARREADY),
        .m_axi_arvalid(auto_pc_to_m11_couplers_ARVALID),
        .m_axi_awaddr(auto_pc_to_m11_couplers_AWADDR),
        .m_axi_awprot(auto_pc_to_m11_couplers_AWPROT),
        .m_axi_awready(auto_pc_to_m11_couplers_AWREADY),
        .m_axi_awvalid(auto_pc_to_m11_couplers_AWVALID),
        .m_axi_bready(auto_pc_to_m11_couplers_BREADY),
        .m_axi_bresp(auto_pc_to_m11_couplers_BRESP),
        .m_axi_bvalid(auto_pc_to_m11_couplers_BVALID),
        .m_axi_rdata(auto_pc_to_m11_couplers_RDATA),
        .m_axi_rready(auto_pc_to_m11_couplers_RREADY),
        .m_axi_rresp(auto_pc_to_m11_couplers_RRESP),
        .m_axi_rvalid(auto_pc_to_m11_couplers_RVALID),
        .m_axi_wdata(auto_pc_to_m11_couplers_WDATA),
        .m_axi_wready(auto_pc_to_m11_couplers_WREADY),
        .m_axi_wstrb(auto_pc_to_m11_couplers_WSTRB),
        .m_axi_wvalid(auto_pc_to_m11_couplers_WVALID),
        .s_axi_araddr(auto_ds_to_auto_pc_ARADDR),
        .s_axi_arburst(auto_ds_to_auto_pc_ARBURST),
        .s_axi_arcache(auto_ds_to_auto_pc_ARCACHE),
        .s_axi_arlen(auto_ds_to_auto_pc_ARLEN),
        .s_axi_arlock(auto_ds_to_auto_pc_ARLOCK),
        .s_axi_arprot(auto_ds_to_auto_pc_ARPROT),
        .s_axi_arqos(auto_ds_to_auto_pc_ARQOS),
        .s_axi_arready(auto_ds_to_auto_pc_ARREADY),
        .s_axi_arregion(auto_ds_to_auto_pc_ARREGION),
        .s_axi_arsize(auto_ds_to_auto_pc_ARSIZE),
        .s_axi_arvalid(auto_ds_to_auto_pc_ARVALID),
        .s_axi_awaddr(auto_ds_to_auto_pc_AWADDR),
        .s_axi_awburst(auto_ds_to_auto_pc_AWBURST),
        .s_axi_awcache(auto_ds_to_auto_pc_AWCACHE),
        .s_axi_awlen(auto_ds_to_auto_pc_AWLEN),
        .s_axi_awlock(auto_ds_to_auto_pc_AWLOCK),
        .s_axi_awprot(auto_ds_to_auto_pc_AWPROT),
        .s_axi_awqos(auto_ds_to_auto_pc_AWQOS),
        .s_axi_awready(auto_ds_to_auto_pc_AWREADY),
        .s_axi_awregion(auto_ds_to_auto_pc_AWREGION),
        .s_axi_awsize(auto_ds_to_auto_pc_AWSIZE),
        .s_axi_awvalid(auto_ds_to_auto_pc_AWVALID),
        .s_axi_bready(auto_ds_to_auto_pc_BREADY),
        .s_axi_bresp(auto_ds_to_auto_pc_BRESP),
        .s_axi_bvalid(auto_ds_to_auto_pc_BVALID),
        .s_axi_rdata(auto_ds_to_auto_pc_RDATA),
        .s_axi_rlast(auto_ds_to_auto_pc_RLAST),
        .s_axi_rready(auto_ds_to_auto_pc_RREADY),
        .s_axi_rresp(auto_ds_to_auto_pc_RRESP),
        .s_axi_rvalid(auto_ds_to_auto_pc_RVALID),
        .s_axi_wdata(auto_ds_to_auto_pc_WDATA),
        .s_axi_wlast(auto_ds_to_auto_pc_WLAST),
        .s_axi_wready(auto_ds_to_auto_pc_WREADY),
        .s_axi_wstrb(auto_ds_to_auto_pc_WSTRB),
        .s_axi_wvalid(auto_ds_to_auto_pc_WVALID));
endmodule

module m12_couplers_imp_1HD19WI
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arburst,
    S_AXI_arcache,
    S_AXI_arlen,
    S_AXI_arlock,
    S_AXI_arprot,
    S_AXI_arqos,
    S_AXI_arready,
    S_AXI_arregion,
    S_AXI_arsize,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awburst,
    S_AXI_awcache,
    S_AXI_awlen,
    S_AXI_awlock,
    S_AXI_awprot,
    S_AXI_awqos,
    S_AXI_awready,
    S_AXI_awregion,
    S_AXI_awsize,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rlast,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wlast,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input [0:0]M_ARESETN;
  output [31:0]M_AXI_araddr;
  input M_AXI_arready;
  output M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  input M_AXI_awready;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  input M_AXI_wready;
  output [3:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input [0:0]S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [1:0]S_AXI_arburst;
  input [3:0]S_AXI_arcache;
  input [7:0]S_AXI_arlen;
  input [0:0]S_AXI_arlock;
  input [2:0]S_AXI_arprot;
  input [3:0]S_AXI_arqos;
  output S_AXI_arready;
  input [3:0]S_AXI_arregion;
  input [2:0]S_AXI_arsize;
  input S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  input [1:0]S_AXI_awburst;
  input [3:0]S_AXI_awcache;
  input [7:0]S_AXI_awlen;
  input [0:0]S_AXI_awlock;
  input [2:0]S_AXI_awprot;
  input [3:0]S_AXI_awqos;
  output S_AXI_awready;
  input [3:0]S_AXI_awregion;
  input [2:0]S_AXI_awsize;
  input S_AXI_awvalid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [511:0]S_AXI_rdata;
  output S_AXI_rlast;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [511:0]S_AXI_wdata;
  input S_AXI_wlast;
  output S_AXI_wready;
  input [63:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire S_ACLK_1;
  wire [0:0]S_ARESETN_1;
  wire [31:0]auto_ds_to_auto_pc_ARADDR;
  wire [1:0]auto_ds_to_auto_pc_ARBURST;
  wire [3:0]auto_ds_to_auto_pc_ARCACHE;
  wire [7:0]auto_ds_to_auto_pc_ARLEN;
  wire [0:0]auto_ds_to_auto_pc_ARLOCK;
  wire [2:0]auto_ds_to_auto_pc_ARPROT;
  wire [3:0]auto_ds_to_auto_pc_ARQOS;
  wire auto_ds_to_auto_pc_ARREADY;
  wire [3:0]auto_ds_to_auto_pc_ARREGION;
  wire [2:0]auto_ds_to_auto_pc_ARSIZE;
  wire auto_ds_to_auto_pc_ARVALID;
  wire [31:0]auto_ds_to_auto_pc_AWADDR;
  wire [1:0]auto_ds_to_auto_pc_AWBURST;
  wire [3:0]auto_ds_to_auto_pc_AWCACHE;
  wire [7:0]auto_ds_to_auto_pc_AWLEN;
  wire [0:0]auto_ds_to_auto_pc_AWLOCK;
  wire [2:0]auto_ds_to_auto_pc_AWPROT;
  wire [3:0]auto_ds_to_auto_pc_AWQOS;
  wire auto_ds_to_auto_pc_AWREADY;
  wire [3:0]auto_ds_to_auto_pc_AWREGION;
  wire [2:0]auto_ds_to_auto_pc_AWSIZE;
  wire auto_ds_to_auto_pc_AWVALID;
  wire auto_ds_to_auto_pc_BREADY;
  wire [1:0]auto_ds_to_auto_pc_BRESP;
  wire auto_ds_to_auto_pc_BVALID;
  wire [31:0]auto_ds_to_auto_pc_RDATA;
  wire auto_ds_to_auto_pc_RLAST;
  wire auto_ds_to_auto_pc_RREADY;
  wire [1:0]auto_ds_to_auto_pc_RRESP;
  wire auto_ds_to_auto_pc_RVALID;
  wire [31:0]auto_ds_to_auto_pc_WDATA;
  wire auto_ds_to_auto_pc_WLAST;
  wire auto_ds_to_auto_pc_WREADY;
  wire [3:0]auto_ds_to_auto_pc_WSTRB;
  wire auto_ds_to_auto_pc_WVALID;
  wire [31:0]auto_pc_to_m12_couplers_ARADDR;
  wire auto_pc_to_m12_couplers_ARREADY;
  wire auto_pc_to_m12_couplers_ARVALID;
  wire [31:0]auto_pc_to_m12_couplers_AWADDR;
  wire auto_pc_to_m12_couplers_AWREADY;
  wire auto_pc_to_m12_couplers_AWVALID;
  wire auto_pc_to_m12_couplers_BREADY;
  wire [1:0]auto_pc_to_m12_couplers_BRESP;
  wire auto_pc_to_m12_couplers_BVALID;
  wire [31:0]auto_pc_to_m12_couplers_RDATA;
  wire auto_pc_to_m12_couplers_RREADY;
  wire [1:0]auto_pc_to_m12_couplers_RRESP;
  wire auto_pc_to_m12_couplers_RVALID;
  wire [31:0]auto_pc_to_m12_couplers_WDATA;
  wire auto_pc_to_m12_couplers_WREADY;
  wire [3:0]auto_pc_to_m12_couplers_WSTRB;
  wire auto_pc_to_m12_couplers_WVALID;
  wire [31:0]m12_couplers_to_auto_ds_ARADDR;
  wire [1:0]m12_couplers_to_auto_ds_ARBURST;
  wire [3:0]m12_couplers_to_auto_ds_ARCACHE;
  wire [7:0]m12_couplers_to_auto_ds_ARLEN;
  wire [0:0]m12_couplers_to_auto_ds_ARLOCK;
  wire [2:0]m12_couplers_to_auto_ds_ARPROT;
  wire [3:0]m12_couplers_to_auto_ds_ARQOS;
  wire m12_couplers_to_auto_ds_ARREADY;
  wire [3:0]m12_couplers_to_auto_ds_ARREGION;
  wire [2:0]m12_couplers_to_auto_ds_ARSIZE;
  wire m12_couplers_to_auto_ds_ARVALID;
  wire [31:0]m12_couplers_to_auto_ds_AWADDR;
  wire [1:0]m12_couplers_to_auto_ds_AWBURST;
  wire [3:0]m12_couplers_to_auto_ds_AWCACHE;
  wire [7:0]m12_couplers_to_auto_ds_AWLEN;
  wire [0:0]m12_couplers_to_auto_ds_AWLOCK;
  wire [2:0]m12_couplers_to_auto_ds_AWPROT;
  wire [3:0]m12_couplers_to_auto_ds_AWQOS;
  wire m12_couplers_to_auto_ds_AWREADY;
  wire [3:0]m12_couplers_to_auto_ds_AWREGION;
  wire [2:0]m12_couplers_to_auto_ds_AWSIZE;
  wire m12_couplers_to_auto_ds_AWVALID;
  wire m12_couplers_to_auto_ds_BREADY;
  wire [1:0]m12_couplers_to_auto_ds_BRESP;
  wire m12_couplers_to_auto_ds_BVALID;
  wire [511:0]m12_couplers_to_auto_ds_RDATA;
  wire m12_couplers_to_auto_ds_RLAST;
  wire m12_couplers_to_auto_ds_RREADY;
  wire [1:0]m12_couplers_to_auto_ds_RRESP;
  wire m12_couplers_to_auto_ds_RVALID;
  wire [511:0]m12_couplers_to_auto_ds_WDATA;
  wire m12_couplers_to_auto_ds_WLAST;
  wire m12_couplers_to_auto_ds_WREADY;
  wire [63:0]m12_couplers_to_auto_ds_WSTRB;
  wire m12_couplers_to_auto_ds_WVALID;

  assign M_AXI_araddr[31:0] = auto_pc_to_m12_couplers_ARADDR;
  assign M_AXI_arvalid = auto_pc_to_m12_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = auto_pc_to_m12_couplers_AWADDR;
  assign M_AXI_awvalid = auto_pc_to_m12_couplers_AWVALID;
  assign M_AXI_bready = auto_pc_to_m12_couplers_BREADY;
  assign M_AXI_rready = auto_pc_to_m12_couplers_RREADY;
  assign M_AXI_wdata[31:0] = auto_pc_to_m12_couplers_WDATA;
  assign M_AXI_wstrb[3:0] = auto_pc_to_m12_couplers_WSTRB;
  assign M_AXI_wvalid = auto_pc_to_m12_couplers_WVALID;
  assign S_ACLK_1 = S_ACLK;
  assign S_ARESETN_1 = S_ARESETN[0];
  assign S_AXI_arready = m12_couplers_to_auto_ds_ARREADY;
  assign S_AXI_awready = m12_couplers_to_auto_ds_AWREADY;
  assign S_AXI_bresp[1:0] = m12_couplers_to_auto_ds_BRESP;
  assign S_AXI_bvalid = m12_couplers_to_auto_ds_BVALID;
  assign S_AXI_rdata[511:0] = m12_couplers_to_auto_ds_RDATA;
  assign S_AXI_rlast = m12_couplers_to_auto_ds_RLAST;
  assign S_AXI_rresp[1:0] = m12_couplers_to_auto_ds_RRESP;
  assign S_AXI_rvalid = m12_couplers_to_auto_ds_RVALID;
  assign S_AXI_wready = m12_couplers_to_auto_ds_WREADY;
  assign auto_pc_to_m12_couplers_ARREADY = M_AXI_arready;
  assign auto_pc_to_m12_couplers_AWREADY = M_AXI_awready;
  assign auto_pc_to_m12_couplers_BRESP = M_AXI_bresp[1:0];
  assign auto_pc_to_m12_couplers_BVALID = M_AXI_bvalid;
  assign auto_pc_to_m12_couplers_RDATA = M_AXI_rdata[31:0];
  assign auto_pc_to_m12_couplers_RRESP = M_AXI_rresp[1:0];
  assign auto_pc_to_m12_couplers_RVALID = M_AXI_rvalid;
  assign auto_pc_to_m12_couplers_WREADY = M_AXI_wready;
  assign m12_couplers_to_auto_ds_ARADDR = S_AXI_araddr[31:0];
  assign m12_couplers_to_auto_ds_ARBURST = S_AXI_arburst[1:0];
  assign m12_couplers_to_auto_ds_ARCACHE = S_AXI_arcache[3:0];
  assign m12_couplers_to_auto_ds_ARLEN = S_AXI_arlen[7:0];
  assign m12_couplers_to_auto_ds_ARLOCK = S_AXI_arlock[0];
  assign m12_couplers_to_auto_ds_ARPROT = S_AXI_arprot[2:0];
  assign m12_couplers_to_auto_ds_ARQOS = S_AXI_arqos[3:0];
  assign m12_couplers_to_auto_ds_ARREGION = S_AXI_arregion[3:0];
  assign m12_couplers_to_auto_ds_ARSIZE = S_AXI_arsize[2:0];
  assign m12_couplers_to_auto_ds_ARVALID = S_AXI_arvalid;
  assign m12_couplers_to_auto_ds_AWADDR = S_AXI_awaddr[31:0];
  assign m12_couplers_to_auto_ds_AWBURST = S_AXI_awburst[1:0];
  assign m12_couplers_to_auto_ds_AWCACHE = S_AXI_awcache[3:0];
  assign m12_couplers_to_auto_ds_AWLEN = S_AXI_awlen[7:0];
  assign m12_couplers_to_auto_ds_AWLOCK = S_AXI_awlock[0];
  assign m12_couplers_to_auto_ds_AWPROT = S_AXI_awprot[2:0];
  assign m12_couplers_to_auto_ds_AWQOS = S_AXI_awqos[3:0];
  assign m12_couplers_to_auto_ds_AWREGION = S_AXI_awregion[3:0];
  assign m12_couplers_to_auto_ds_AWSIZE = S_AXI_awsize[2:0];
  assign m12_couplers_to_auto_ds_AWVALID = S_AXI_awvalid;
  assign m12_couplers_to_auto_ds_BREADY = S_AXI_bready;
  assign m12_couplers_to_auto_ds_RREADY = S_AXI_rready;
  assign m12_couplers_to_auto_ds_WDATA = S_AXI_wdata[511:0];
  assign m12_couplers_to_auto_ds_WLAST = S_AXI_wlast;
  assign m12_couplers_to_auto_ds_WSTRB = S_AXI_wstrb[63:0];
  assign m12_couplers_to_auto_ds_WVALID = S_AXI_wvalid;
  system_i_bak_auto_ds_11 auto_ds
       (.m_axi_araddr(auto_ds_to_auto_pc_ARADDR),
        .m_axi_arburst(auto_ds_to_auto_pc_ARBURST),
        .m_axi_arcache(auto_ds_to_auto_pc_ARCACHE),
        .m_axi_arlen(auto_ds_to_auto_pc_ARLEN),
        .m_axi_arlock(auto_ds_to_auto_pc_ARLOCK),
        .m_axi_arprot(auto_ds_to_auto_pc_ARPROT),
        .m_axi_arqos(auto_ds_to_auto_pc_ARQOS),
        .m_axi_arready(auto_ds_to_auto_pc_ARREADY),
        .m_axi_arregion(auto_ds_to_auto_pc_ARREGION),
        .m_axi_arsize(auto_ds_to_auto_pc_ARSIZE),
        .m_axi_arvalid(auto_ds_to_auto_pc_ARVALID),
        .m_axi_awaddr(auto_ds_to_auto_pc_AWADDR),
        .m_axi_awburst(auto_ds_to_auto_pc_AWBURST),
        .m_axi_awcache(auto_ds_to_auto_pc_AWCACHE),
        .m_axi_awlen(auto_ds_to_auto_pc_AWLEN),
        .m_axi_awlock(auto_ds_to_auto_pc_AWLOCK),
        .m_axi_awprot(auto_ds_to_auto_pc_AWPROT),
        .m_axi_awqos(auto_ds_to_auto_pc_AWQOS),
        .m_axi_awready(auto_ds_to_auto_pc_AWREADY),
        .m_axi_awregion(auto_ds_to_auto_pc_AWREGION),
        .m_axi_awsize(auto_ds_to_auto_pc_AWSIZE),
        .m_axi_awvalid(auto_ds_to_auto_pc_AWVALID),
        .m_axi_bready(auto_ds_to_auto_pc_BREADY),
        .m_axi_bresp(auto_ds_to_auto_pc_BRESP),
        .m_axi_bvalid(auto_ds_to_auto_pc_BVALID),
        .m_axi_rdata(auto_ds_to_auto_pc_RDATA),
        .m_axi_rlast(auto_ds_to_auto_pc_RLAST),
        .m_axi_rready(auto_ds_to_auto_pc_RREADY),
        .m_axi_rresp(auto_ds_to_auto_pc_RRESP),
        .m_axi_rvalid(auto_ds_to_auto_pc_RVALID),
        .m_axi_wdata(auto_ds_to_auto_pc_WDATA),
        .m_axi_wlast(auto_ds_to_auto_pc_WLAST),
        .m_axi_wready(auto_ds_to_auto_pc_WREADY),
        .m_axi_wstrb(auto_ds_to_auto_pc_WSTRB),
        .m_axi_wvalid(auto_ds_to_auto_pc_WVALID),
        .s_axi_aclk(S_ACLK_1),
        .s_axi_araddr(m12_couplers_to_auto_ds_ARADDR),
        .s_axi_arburst(m12_couplers_to_auto_ds_ARBURST),
        .s_axi_arcache(m12_couplers_to_auto_ds_ARCACHE),
        .s_axi_aresetn(S_ARESETN_1),
        .s_axi_arlen(m12_couplers_to_auto_ds_ARLEN),
        .s_axi_arlock(m12_couplers_to_auto_ds_ARLOCK),
        .s_axi_arprot(m12_couplers_to_auto_ds_ARPROT),
        .s_axi_arqos(m12_couplers_to_auto_ds_ARQOS),
        .s_axi_arready(m12_couplers_to_auto_ds_ARREADY),
        .s_axi_arregion(m12_couplers_to_auto_ds_ARREGION),
        .s_axi_arsize(m12_couplers_to_auto_ds_ARSIZE),
        .s_axi_arvalid(m12_couplers_to_auto_ds_ARVALID),
        .s_axi_awaddr(m12_couplers_to_auto_ds_AWADDR),
        .s_axi_awburst(m12_couplers_to_auto_ds_AWBURST),
        .s_axi_awcache(m12_couplers_to_auto_ds_AWCACHE),
        .s_axi_awlen(m12_couplers_to_auto_ds_AWLEN),
        .s_axi_awlock(m12_couplers_to_auto_ds_AWLOCK),
        .s_axi_awprot(m12_couplers_to_auto_ds_AWPROT),
        .s_axi_awqos(m12_couplers_to_auto_ds_AWQOS),
        .s_axi_awready(m12_couplers_to_auto_ds_AWREADY),
        .s_axi_awregion(m12_couplers_to_auto_ds_AWREGION),
        .s_axi_awsize(m12_couplers_to_auto_ds_AWSIZE),
        .s_axi_awvalid(m12_couplers_to_auto_ds_AWVALID),
        .s_axi_bready(m12_couplers_to_auto_ds_BREADY),
        .s_axi_bresp(m12_couplers_to_auto_ds_BRESP),
        .s_axi_bvalid(m12_couplers_to_auto_ds_BVALID),
        .s_axi_rdata(m12_couplers_to_auto_ds_RDATA),
        .s_axi_rlast(m12_couplers_to_auto_ds_RLAST),
        .s_axi_rready(m12_couplers_to_auto_ds_RREADY),
        .s_axi_rresp(m12_couplers_to_auto_ds_RRESP),
        .s_axi_rvalid(m12_couplers_to_auto_ds_RVALID),
        .s_axi_wdata(m12_couplers_to_auto_ds_WDATA),
        .s_axi_wlast(m12_couplers_to_auto_ds_WLAST),
        .s_axi_wready(m12_couplers_to_auto_ds_WREADY),
        .s_axi_wstrb(m12_couplers_to_auto_ds_WSTRB),
        .s_axi_wvalid(m12_couplers_to_auto_ds_WVALID));
  system_i_bak_auto_pc_10 auto_pc
       (.aclk(S_ACLK_1),
        .aresetn(S_ARESETN_1),
        .m_axi_araddr(auto_pc_to_m12_couplers_ARADDR),
        .m_axi_arready(auto_pc_to_m12_couplers_ARREADY),
        .m_axi_arvalid(auto_pc_to_m12_couplers_ARVALID),
        .m_axi_awaddr(auto_pc_to_m12_couplers_AWADDR),
        .m_axi_awready(auto_pc_to_m12_couplers_AWREADY),
        .m_axi_awvalid(auto_pc_to_m12_couplers_AWVALID),
        .m_axi_bready(auto_pc_to_m12_couplers_BREADY),
        .m_axi_bresp(auto_pc_to_m12_couplers_BRESP),
        .m_axi_bvalid(auto_pc_to_m12_couplers_BVALID),
        .m_axi_rdata(auto_pc_to_m12_couplers_RDATA),
        .m_axi_rready(auto_pc_to_m12_couplers_RREADY),
        .m_axi_rresp(auto_pc_to_m12_couplers_RRESP),
        .m_axi_rvalid(auto_pc_to_m12_couplers_RVALID),
        .m_axi_wdata(auto_pc_to_m12_couplers_WDATA),
        .m_axi_wready(auto_pc_to_m12_couplers_WREADY),
        .m_axi_wstrb(auto_pc_to_m12_couplers_WSTRB),
        .m_axi_wvalid(auto_pc_to_m12_couplers_WVALID),
        .s_axi_araddr(auto_ds_to_auto_pc_ARADDR),
        .s_axi_arburst(auto_ds_to_auto_pc_ARBURST),
        .s_axi_arcache(auto_ds_to_auto_pc_ARCACHE),
        .s_axi_arlen(auto_ds_to_auto_pc_ARLEN),
        .s_axi_arlock(auto_ds_to_auto_pc_ARLOCK),
        .s_axi_arprot(auto_ds_to_auto_pc_ARPROT),
        .s_axi_arqos(auto_ds_to_auto_pc_ARQOS),
        .s_axi_arready(auto_ds_to_auto_pc_ARREADY),
        .s_axi_arregion(auto_ds_to_auto_pc_ARREGION),
        .s_axi_arsize(auto_ds_to_auto_pc_ARSIZE),
        .s_axi_arvalid(auto_ds_to_auto_pc_ARVALID),
        .s_axi_awaddr(auto_ds_to_auto_pc_AWADDR),
        .s_axi_awburst(auto_ds_to_auto_pc_AWBURST),
        .s_axi_awcache(auto_ds_to_auto_pc_AWCACHE),
        .s_axi_awlen(auto_ds_to_auto_pc_AWLEN),
        .s_axi_awlock(auto_ds_to_auto_pc_AWLOCK),
        .s_axi_awprot(auto_ds_to_auto_pc_AWPROT),
        .s_axi_awqos(auto_ds_to_auto_pc_AWQOS),
        .s_axi_awready(auto_ds_to_auto_pc_AWREADY),
        .s_axi_awregion(auto_ds_to_auto_pc_AWREGION),
        .s_axi_awsize(auto_ds_to_auto_pc_AWSIZE),
        .s_axi_awvalid(auto_ds_to_auto_pc_AWVALID),
        .s_axi_bready(auto_ds_to_auto_pc_BREADY),
        .s_axi_bresp(auto_ds_to_auto_pc_BRESP),
        .s_axi_bvalid(auto_ds_to_auto_pc_BVALID),
        .s_axi_rdata(auto_ds_to_auto_pc_RDATA),
        .s_axi_rlast(auto_ds_to_auto_pc_RLAST),
        .s_axi_rready(auto_ds_to_auto_pc_RREADY),
        .s_axi_rresp(auto_ds_to_auto_pc_RRESP),
        .s_axi_rvalid(auto_ds_to_auto_pc_RVALID),
        .s_axi_wdata(auto_ds_to_auto_pc_WDATA),
        .s_axi_wlast(auto_ds_to_auto_pc_WLAST),
        .s_axi_wready(auto_ds_to_auto_pc_WREADY),
        .s_axi_wstrb(auto_ds_to_auto_pc_WSTRB),
        .s_axi_wvalid(auto_ds_to_auto_pc_WVALID));
endmodule

module m13_couplers_imp_1NSCO82
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arprot,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awprot,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arburst,
    S_AXI_arcache,
    S_AXI_arlen,
    S_AXI_arlock,
    S_AXI_arprot,
    S_AXI_arqos,
    S_AXI_arready,
    S_AXI_arregion,
    S_AXI_arsize,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awburst,
    S_AXI_awcache,
    S_AXI_awlen,
    S_AXI_awlock,
    S_AXI_awprot,
    S_AXI_awqos,
    S_AXI_awready,
    S_AXI_awregion,
    S_AXI_awsize,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rlast,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wlast,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input [0:0]M_ARESETN;
  output [31:0]M_AXI_araddr;
  output [2:0]M_AXI_arprot;
  input M_AXI_arready;
  output M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  output [2:0]M_AXI_awprot;
  input M_AXI_awready;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  input M_AXI_wready;
  output [3:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input [0:0]S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [1:0]S_AXI_arburst;
  input [3:0]S_AXI_arcache;
  input [7:0]S_AXI_arlen;
  input [0:0]S_AXI_arlock;
  input [2:0]S_AXI_arprot;
  input [3:0]S_AXI_arqos;
  output S_AXI_arready;
  input [3:0]S_AXI_arregion;
  input [2:0]S_AXI_arsize;
  input S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  input [1:0]S_AXI_awburst;
  input [3:0]S_AXI_awcache;
  input [7:0]S_AXI_awlen;
  input [0:0]S_AXI_awlock;
  input [2:0]S_AXI_awprot;
  input [3:0]S_AXI_awqos;
  output S_AXI_awready;
  input [3:0]S_AXI_awregion;
  input [2:0]S_AXI_awsize;
  input S_AXI_awvalid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [511:0]S_AXI_rdata;
  output S_AXI_rlast;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [511:0]S_AXI_wdata;
  input S_AXI_wlast;
  output S_AXI_wready;
  input [63:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire S_ACLK_1;
  wire [0:0]S_ARESETN_1;
  wire [31:0]auto_ds_to_auto_pc_ARADDR;
  wire [1:0]auto_ds_to_auto_pc_ARBURST;
  wire [3:0]auto_ds_to_auto_pc_ARCACHE;
  wire [7:0]auto_ds_to_auto_pc_ARLEN;
  wire [0:0]auto_ds_to_auto_pc_ARLOCK;
  wire [2:0]auto_ds_to_auto_pc_ARPROT;
  wire [3:0]auto_ds_to_auto_pc_ARQOS;
  wire auto_ds_to_auto_pc_ARREADY;
  wire [3:0]auto_ds_to_auto_pc_ARREGION;
  wire [2:0]auto_ds_to_auto_pc_ARSIZE;
  wire auto_ds_to_auto_pc_ARVALID;
  wire [31:0]auto_ds_to_auto_pc_AWADDR;
  wire [1:0]auto_ds_to_auto_pc_AWBURST;
  wire [3:0]auto_ds_to_auto_pc_AWCACHE;
  wire [7:0]auto_ds_to_auto_pc_AWLEN;
  wire [0:0]auto_ds_to_auto_pc_AWLOCK;
  wire [2:0]auto_ds_to_auto_pc_AWPROT;
  wire [3:0]auto_ds_to_auto_pc_AWQOS;
  wire auto_ds_to_auto_pc_AWREADY;
  wire [3:0]auto_ds_to_auto_pc_AWREGION;
  wire [2:0]auto_ds_to_auto_pc_AWSIZE;
  wire auto_ds_to_auto_pc_AWVALID;
  wire auto_ds_to_auto_pc_BREADY;
  wire [1:0]auto_ds_to_auto_pc_BRESP;
  wire auto_ds_to_auto_pc_BVALID;
  wire [31:0]auto_ds_to_auto_pc_RDATA;
  wire auto_ds_to_auto_pc_RLAST;
  wire auto_ds_to_auto_pc_RREADY;
  wire [1:0]auto_ds_to_auto_pc_RRESP;
  wire auto_ds_to_auto_pc_RVALID;
  wire [31:0]auto_ds_to_auto_pc_WDATA;
  wire auto_ds_to_auto_pc_WLAST;
  wire auto_ds_to_auto_pc_WREADY;
  wire [3:0]auto_ds_to_auto_pc_WSTRB;
  wire auto_ds_to_auto_pc_WVALID;
  wire [31:0]auto_pc_to_m13_couplers_ARADDR;
  wire [2:0]auto_pc_to_m13_couplers_ARPROT;
  wire auto_pc_to_m13_couplers_ARREADY;
  wire auto_pc_to_m13_couplers_ARVALID;
  wire [31:0]auto_pc_to_m13_couplers_AWADDR;
  wire [2:0]auto_pc_to_m13_couplers_AWPROT;
  wire auto_pc_to_m13_couplers_AWREADY;
  wire auto_pc_to_m13_couplers_AWVALID;
  wire auto_pc_to_m13_couplers_BREADY;
  wire [1:0]auto_pc_to_m13_couplers_BRESP;
  wire auto_pc_to_m13_couplers_BVALID;
  wire [31:0]auto_pc_to_m13_couplers_RDATA;
  wire auto_pc_to_m13_couplers_RREADY;
  wire [1:0]auto_pc_to_m13_couplers_RRESP;
  wire auto_pc_to_m13_couplers_RVALID;
  wire [31:0]auto_pc_to_m13_couplers_WDATA;
  wire auto_pc_to_m13_couplers_WREADY;
  wire [3:0]auto_pc_to_m13_couplers_WSTRB;
  wire auto_pc_to_m13_couplers_WVALID;
  wire [31:0]m13_couplers_to_auto_ds_ARADDR;
  wire [1:0]m13_couplers_to_auto_ds_ARBURST;
  wire [3:0]m13_couplers_to_auto_ds_ARCACHE;
  wire [7:0]m13_couplers_to_auto_ds_ARLEN;
  wire [0:0]m13_couplers_to_auto_ds_ARLOCK;
  wire [2:0]m13_couplers_to_auto_ds_ARPROT;
  wire [3:0]m13_couplers_to_auto_ds_ARQOS;
  wire m13_couplers_to_auto_ds_ARREADY;
  wire [3:0]m13_couplers_to_auto_ds_ARREGION;
  wire [2:0]m13_couplers_to_auto_ds_ARSIZE;
  wire m13_couplers_to_auto_ds_ARVALID;
  wire [31:0]m13_couplers_to_auto_ds_AWADDR;
  wire [1:0]m13_couplers_to_auto_ds_AWBURST;
  wire [3:0]m13_couplers_to_auto_ds_AWCACHE;
  wire [7:0]m13_couplers_to_auto_ds_AWLEN;
  wire [0:0]m13_couplers_to_auto_ds_AWLOCK;
  wire [2:0]m13_couplers_to_auto_ds_AWPROT;
  wire [3:0]m13_couplers_to_auto_ds_AWQOS;
  wire m13_couplers_to_auto_ds_AWREADY;
  wire [3:0]m13_couplers_to_auto_ds_AWREGION;
  wire [2:0]m13_couplers_to_auto_ds_AWSIZE;
  wire m13_couplers_to_auto_ds_AWVALID;
  wire m13_couplers_to_auto_ds_BREADY;
  wire [1:0]m13_couplers_to_auto_ds_BRESP;
  wire m13_couplers_to_auto_ds_BVALID;
  wire [511:0]m13_couplers_to_auto_ds_RDATA;
  wire m13_couplers_to_auto_ds_RLAST;
  wire m13_couplers_to_auto_ds_RREADY;
  wire [1:0]m13_couplers_to_auto_ds_RRESP;
  wire m13_couplers_to_auto_ds_RVALID;
  wire [511:0]m13_couplers_to_auto_ds_WDATA;
  wire m13_couplers_to_auto_ds_WLAST;
  wire m13_couplers_to_auto_ds_WREADY;
  wire [63:0]m13_couplers_to_auto_ds_WSTRB;
  wire m13_couplers_to_auto_ds_WVALID;

  assign M_AXI_araddr[31:0] = auto_pc_to_m13_couplers_ARADDR;
  assign M_AXI_arprot[2:0] = auto_pc_to_m13_couplers_ARPROT;
  assign M_AXI_arvalid = auto_pc_to_m13_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = auto_pc_to_m13_couplers_AWADDR;
  assign M_AXI_awprot[2:0] = auto_pc_to_m13_couplers_AWPROT;
  assign M_AXI_awvalid = auto_pc_to_m13_couplers_AWVALID;
  assign M_AXI_bready = auto_pc_to_m13_couplers_BREADY;
  assign M_AXI_rready = auto_pc_to_m13_couplers_RREADY;
  assign M_AXI_wdata[31:0] = auto_pc_to_m13_couplers_WDATA;
  assign M_AXI_wstrb[3:0] = auto_pc_to_m13_couplers_WSTRB;
  assign M_AXI_wvalid = auto_pc_to_m13_couplers_WVALID;
  assign S_ACLK_1 = S_ACLK;
  assign S_ARESETN_1 = S_ARESETN[0];
  assign S_AXI_arready = m13_couplers_to_auto_ds_ARREADY;
  assign S_AXI_awready = m13_couplers_to_auto_ds_AWREADY;
  assign S_AXI_bresp[1:0] = m13_couplers_to_auto_ds_BRESP;
  assign S_AXI_bvalid = m13_couplers_to_auto_ds_BVALID;
  assign S_AXI_rdata[511:0] = m13_couplers_to_auto_ds_RDATA;
  assign S_AXI_rlast = m13_couplers_to_auto_ds_RLAST;
  assign S_AXI_rresp[1:0] = m13_couplers_to_auto_ds_RRESP;
  assign S_AXI_rvalid = m13_couplers_to_auto_ds_RVALID;
  assign S_AXI_wready = m13_couplers_to_auto_ds_WREADY;
  assign auto_pc_to_m13_couplers_ARREADY = M_AXI_arready;
  assign auto_pc_to_m13_couplers_AWREADY = M_AXI_awready;
  assign auto_pc_to_m13_couplers_BRESP = M_AXI_bresp[1:0];
  assign auto_pc_to_m13_couplers_BVALID = M_AXI_bvalid;
  assign auto_pc_to_m13_couplers_RDATA = M_AXI_rdata[31:0];
  assign auto_pc_to_m13_couplers_RRESP = M_AXI_rresp[1:0];
  assign auto_pc_to_m13_couplers_RVALID = M_AXI_rvalid;
  assign auto_pc_to_m13_couplers_WREADY = M_AXI_wready;
  assign m13_couplers_to_auto_ds_ARADDR = S_AXI_araddr[31:0];
  assign m13_couplers_to_auto_ds_ARBURST = S_AXI_arburst[1:0];
  assign m13_couplers_to_auto_ds_ARCACHE = S_AXI_arcache[3:0];
  assign m13_couplers_to_auto_ds_ARLEN = S_AXI_arlen[7:0];
  assign m13_couplers_to_auto_ds_ARLOCK = S_AXI_arlock[0];
  assign m13_couplers_to_auto_ds_ARPROT = S_AXI_arprot[2:0];
  assign m13_couplers_to_auto_ds_ARQOS = S_AXI_arqos[3:0];
  assign m13_couplers_to_auto_ds_ARREGION = S_AXI_arregion[3:0];
  assign m13_couplers_to_auto_ds_ARSIZE = S_AXI_arsize[2:0];
  assign m13_couplers_to_auto_ds_ARVALID = S_AXI_arvalid;
  assign m13_couplers_to_auto_ds_AWADDR = S_AXI_awaddr[31:0];
  assign m13_couplers_to_auto_ds_AWBURST = S_AXI_awburst[1:0];
  assign m13_couplers_to_auto_ds_AWCACHE = S_AXI_awcache[3:0];
  assign m13_couplers_to_auto_ds_AWLEN = S_AXI_awlen[7:0];
  assign m13_couplers_to_auto_ds_AWLOCK = S_AXI_awlock[0];
  assign m13_couplers_to_auto_ds_AWPROT = S_AXI_awprot[2:0];
  assign m13_couplers_to_auto_ds_AWQOS = S_AXI_awqos[3:0];
  assign m13_couplers_to_auto_ds_AWREGION = S_AXI_awregion[3:0];
  assign m13_couplers_to_auto_ds_AWSIZE = S_AXI_awsize[2:0];
  assign m13_couplers_to_auto_ds_AWVALID = S_AXI_awvalid;
  assign m13_couplers_to_auto_ds_BREADY = S_AXI_bready;
  assign m13_couplers_to_auto_ds_RREADY = S_AXI_rready;
  assign m13_couplers_to_auto_ds_WDATA = S_AXI_wdata[511:0];
  assign m13_couplers_to_auto_ds_WLAST = S_AXI_wlast;
  assign m13_couplers_to_auto_ds_WSTRB = S_AXI_wstrb[63:0];
  assign m13_couplers_to_auto_ds_WVALID = S_AXI_wvalid;
  system_i_bak_auto_ds_12 auto_ds
       (.m_axi_araddr(auto_ds_to_auto_pc_ARADDR),
        .m_axi_arburst(auto_ds_to_auto_pc_ARBURST),
        .m_axi_arcache(auto_ds_to_auto_pc_ARCACHE),
        .m_axi_arlen(auto_ds_to_auto_pc_ARLEN),
        .m_axi_arlock(auto_ds_to_auto_pc_ARLOCK),
        .m_axi_arprot(auto_ds_to_auto_pc_ARPROT),
        .m_axi_arqos(auto_ds_to_auto_pc_ARQOS),
        .m_axi_arready(auto_ds_to_auto_pc_ARREADY),
        .m_axi_arregion(auto_ds_to_auto_pc_ARREGION),
        .m_axi_arsize(auto_ds_to_auto_pc_ARSIZE),
        .m_axi_arvalid(auto_ds_to_auto_pc_ARVALID),
        .m_axi_awaddr(auto_ds_to_auto_pc_AWADDR),
        .m_axi_awburst(auto_ds_to_auto_pc_AWBURST),
        .m_axi_awcache(auto_ds_to_auto_pc_AWCACHE),
        .m_axi_awlen(auto_ds_to_auto_pc_AWLEN),
        .m_axi_awlock(auto_ds_to_auto_pc_AWLOCK),
        .m_axi_awprot(auto_ds_to_auto_pc_AWPROT),
        .m_axi_awqos(auto_ds_to_auto_pc_AWQOS),
        .m_axi_awready(auto_ds_to_auto_pc_AWREADY),
        .m_axi_awregion(auto_ds_to_auto_pc_AWREGION),
        .m_axi_awsize(auto_ds_to_auto_pc_AWSIZE),
        .m_axi_awvalid(auto_ds_to_auto_pc_AWVALID),
        .m_axi_bready(auto_ds_to_auto_pc_BREADY),
        .m_axi_bresp(auto_ds_to_auto_pc_BRESP),
        .m_axi_bvalid(auto_ds_to_auto_pc_BVALID),
        .m_axi_rdata(auto_ds_to_auto_pc_RDATA),
        .m_axi_rlast(auto_ds_to_auto_pc_RLAST),
        .m_axi_rready(auto_ds_to_auto_pc_RREADY),
        .m_axi_rresp(auto_ds_to_auto_pc_RRESP),
        .m_axi_rvalid(auto_ds_to_auto_pc_RVALID),
        .m_axi_wdata(auto_ds_to_auto_pc_WDATA),
        .m_axi_wlast(auto_ds_to_auto_pc_WLAST),
        .m_axi_wready(auto_ds_to_auto_pc_WREADY),
        .m_axi_wstrb(auto_ds_to_auto_pc_WSTRB),
        .m_axi_wvalid(auto_ds_to_auto_pc_WVALID),
        .s_axi_aclk(S_ACLK_1),
        .s_axi_araddr(m13_couplers_to_auto_ds_ARADDR),
        .s_axi_arburst(m13_couplers_to_auto_ds_ARBURST),
        .s_axi_arcache(m13_couplers_to_auto_ds_ARCACHE),
        .s_axi_aresetn(S_ARESETN_1),
        .s_axi_arlen(m13_couplers_to_auto_ds_ARLEN),
        .s_axi_arlock(m13_couplers_to_auto_ds_ARLOCK),
        .s_axi_arprot(m13_couplers_to_auto_ds_ARPROT),
        .s_axi_arqos(m13_couplers_to_auto_ds_ARQOS),
        .s_axi_arready(m13_couplers_to_auto_ds_ARREADY),
        .s_axi_arregion(m13_couplers_to_auto_ds_ARREGION),
        .s_axi_arsize(m13_couplers_to_auto_ds_ARSIZE),
        .s_axi_arvalid(m13_couplers_to_auto_ds_ARVALID),
        .s_axi_awaddr(m13_couplers_to_auto_ds_AWADDR),
        .s_axi_awburst(m13_couplers_to_auto_ds_AWBURST),
        .s_axi_awcache(m13_couplers_to_auto_ds_AWCACHE),
        .s_axi_awlen(m13_couplers_to_auto_ds_AWLEN),
        .s_axi_awlock(m13_couplers_to_auto_ds_AWLOCK),
        .s_axi_awprot(m13_couplers_to_auto_ds_AWPROT),
        .s_axi_awqos(m13_couplers_to_auto_ds_AWQOS),
        .s_axi_awready(m13_couplers_to_auto_ds_AWREADY),
        .s_axi_awregion(m13_couplers_to_auto_ds_AWREGION),
        .s_axi_awsize(m13_couplers_to_auto_ds_AWSIZE),
        .s_axi_awvalid(m13_couplers_to_auto_ds_AWVALID),
        .s_axi_bready(m13_couplers_to_auto_ds_BREADY),
        .s_axi_bresp(m13_couplers_to_auto_ds_BRESP),
        .s_axi_bvalid(m13_couplers_to_auto_ds_BVALID),
        .s_axi_rdata(m13_couplers_to_auto_ds_RDATA),
        .s_axi_rlast(m13_couplers_to_auto_ds_RLAST),
        .s_axi_rready(m13_couplers_to_auto_ds_RREADY),
        .s_axi_rresp(m13_couplers_to_auto_ds_RRESP),
        .s_axi_rvalid(m13_couplers_to_auto_ds_RVALID),
        .s_axi_wdata(m13_couplers_to_auto_ds_WDATA),
        .s_axi_wlast(m13_couplers_to_auto_ds_WLAST),
        .s_axi_wready(m13_couplers_to_auto_ds_WREADY),
        .s_axi_wstrb(m13_couplers_to_auto_ds_WSTRB),
        .s_axi_wvalid(m13_couplers_to_auto_ds_WVALID));
  system_i_bak_auto_pc_11 auto_pc
       (.aclk(S_ACLK_1),
        .aresetn(S_ARESETN_1),
        .m_axi_araddr(auto_pc_to_m13_couplers_ARADDR),
        .m_axi_arprot(auto_pc_to_m13_couplers_ARPROT),
        .m_axi_arready(auto_pc_to_m13_couplers_ARREADY),
        .m_axi_arvalid(auto_pc_to_m13_couplers_ARVALID),
        .m_axi_awaddr(auto_pc_to_m13_couplers_AWADDR),
        .m_axi_awprot(auto_pc_to_m13_couplers_AWPROT),
        .m_axi_awready(auto_pc_to_m13_couplers_AWREADY),
        .m_axi_awvalid(auto_pc_to_m13_couplers_AWVALID),
        .m_axi_bready(auto_pc_to_m13_couplers_BREADY),
        .m_axi_bresp(auto_pc_to_m13_couplers_BRESP),
        .m_axi_bvalid(auto_pc_to_m13_couplers_BVALID),
        .m_axi_rdata(auto_pc_to_m13_couplers_RDATA),
        .m_axi_rready(auto_pc_to_m13_couplers_RREADY),
        .m_axi_rresp(auto_pc_to_m13_couplers_RRESP),
        .m_axi_rvalid(auto_pc_to_m13_couplers_RVALID),
        .m_axi_wdata(auto_pc_to_m13_couplers_WDATA),
        .m_axi_wready(auto_pc_to_m13_couplers_WREADY),
        .m_axi_wstrb(auto_pc_to_m13_couplers_WSTRB),
        .m_axi_wvalid(auto_pc_to_m13_couplers_WVALID),
        .s_axi_araddr(auto_ds_to_auto_pc_ARADDR),
        .s_axi_arburst(auto_ds_to_auto_pc_ARBURST),
        .s_axi_arcache(auto_ds_to_auto_pc_ARCACHE),
        .s_axi_arlen(auto_ds_to_auto_pc_ARLEN),
        .s_axi_arlock(auto_ds_to_auto_pc_ARLOCK),
        .s_axi_arprot(auto_ds_to_auto_pc_ARPROT),
        .s_axi_arqos(auto_ds_to_auto_pc_ARQOS),
        .s_axi_arready(auto_ds_to_auto_pc_ARREADY),
        .s_axi_arregion(auto_ds_to_auto_pc_ARREGION),
        .s_axi_arsize(auto_ds_to_auto_pc_ARSIZE),
        .s_axi_arvalid(auto_ds_to_auto_pc_ARVALID),
        .s_axi_awaddr(auto_ds_to_auto_pc_AWADDR),
        .s_axi_awburst(auto_ds_to_auto_pc_AWBURST),
        .s_axi_awcache(auto_ds_to_auto_pc_AWCACHE),
        .s_axi_awlen(auto_ds_to_auto_pc_AWLEN),
        .s_axi_awlock(auto_ds_to_auto_pc_AWLOCK),
        .s_axi_awprot(auto_ds_to_auto_pc_AWPROT),
        .s_axi_awqos(auto_ds_to_auto_pc_AWQOS),
        .s_axi_awready(auto_ds_to_auto_pc_AWREADY),
        .s_axi_awregion(auto_ds_to_auto_pc_AWREGION),
        .s_axi_awsize(auto_ds_to_auto_pc_AWSIZE),
        .s_axi_awvalid(auto_ds_to_auto_pc_AWVALID),
        .s_axi_bready(auto_ds_to_auto_pc_BREADY),
        .s_axi_bresp(auto_ds_to_auto_pc_BRESP),
        .s_axi_bvalid(auto_ds_to_auto_pc_BVALID),
        .s_axi_rdata(auto_ds_to_auto_pc_RDATA),
        .s_axi_rlast(auto_ds_to_auto_pc_RLAST),
        .s_axi_rready(auto_ds_to_auto_pc_RREADY),
        .s_axi_rresp(auto_ds_to_auto_pc_RRESP),
        .s_axi_rvalid(auto_ds_to_auto_pc_RVALID),
        .s_axi_wdata(auto_ds_to_auto_pc_WDATA),
        .s_axi_wlast(auto_ds_to_auto_pc_WLAST),
        .s_axi_wready(auto_ds_to_auto_pc_WREADY),
        .s_axi_wstrb(auto_ds_to_auto_pc_WSTRB),
        .s_axi_wvalid(auto_ds_to_auto_pc_WVALID));
endmodule

module m14_couplers_imp_1DKD59E
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arburst,
    M_AXI_arcache,
    M_AXI_arlen,
    M_AXI_arlock,
    M_AXI_arprot,
    M_AXI_arqos,
    M_AXI_arready,
    M_AXI_arregion,
    M_AXI_arsize,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awburst,
    M_AXI_awcache,
    M_AXI_awlen,
    M_AXI_awlock,
    M_AXI_awprot,
    M_AXI_awqos,
    M_AXI_awready,
    M_AXI_awregion,
    M_AXI_awsize,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rlast,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wlast,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arburst,
    S_AXI_arcache,
    S_AXI_arlen,
    S_AXI_arlock,
    S_AXI_arprot,
    S_AXI_arqos,
    S_AXI_arready,
    S_AXI_arregion,
    S_AXI_arsize,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awburst,
    S_AXI_awcache,
    S_AXI_awlen,
    S_AXI_awlock,
    S_AXI_awprot,
    S_AXI_awqos,
    S_AXI_awready,
    S_AXI_awregion,
    S_AXI_awsize,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rlast,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wlast,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input [0:0]M_ARESETN;
  output [31:0]M_AXI_araddr;
  output [1:0]M_AXI_arburst;
  output [3:0]M_AXI_arcache;
  output [7:0]M_AXI_arlen;
  output M_AXI_arlock;
  output [2:0]M_AXI_arprot;
  output [3:0]M_AXI_arqos;
  input M_AXI_arready;
  output [3:0]M_AXI_arregion;
  output [2:0]M_AXI_arsize;
  output M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  output [1:0]M_AXI_awburst;
  output [3:0]M_AXI_awcache;
  output [7:0]M_AXI_awlen;
  output M_AXI_awlock;
  output [2:0]M_AXI_awprot;
  output [3:0]M_AXI_awqos;
  input M_AXI_awready;
  output [3:0]M_AXI_awregion;
  output [2:0]M_AXI_awsize;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  input M_AXI_rlast;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  output M_AXI_wlast;
  input M_AXI_wready;
  output [3:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input [0:0]S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [1:0]S_AXI_arburst;
  input [3:0]S_AXI_arcache;
  input [7:0]S_AXI_arlen;
  input [0:0]S_AXI_arlock;
  input [2:0]S_AXI_arprot;
  input [3:0]S_AXI_arqos;
  output S_AXI_arready;
  input [3:0]S_AXI_arregion;
  input [2:0]S_AXI_arsize;
  input S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  input [1:0]S_AXI_awburst;
  input [3:0]S_AXI_awcache;
  input [7:0]S_AXI_awlen;
  input [0:0]S_AXI_awlock;
  input [2:0]S_AXI_awprot;
  input [3:0]S_AXI_awqos;
  output S_AXI_awready;
  input [3:0]S_AXI_awregion;
  input [2:0]S_AXI_awsize;
  input S_AXI_awvalid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [511:0]S_AXI_rdata;
  output S_AXI_rlast;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [511:0]S_AXI_wdata;
  input S_AXI_wlast;
  output S_AXI_wready;
  input [63:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire S_ACLK_1;
  wire [0:0]S_ARESETN_1;
  wire [31:0]auto_ds_to_m14_couplers_ARADDR;
  wire [1:0]auto_ds_to_m14_couplers_ARBURST;
  wire [3:0]auto_ds_to_m14_couplers_ARCACHE;
  wire [7:0]auto_ds_to_m14_couplers_ARLEN;
  wire [0:0]auto_ds_to_m14_couplers_ARLOCK;
  wire [2:0]auto_ds_to_m14_couplers_ARPROT;
  wire [3:0]auto_ds_to_m14_couplers_ARQOS;
  wire auto_ds_to_m14_couplers_ARREADY;
  wire [3:0]auto_ds_to_m14_couplers_ARREGION;
  wire [2:0]auto_ds_to_m14_couplers_ARSIZE;
  wire auto_ds_to_m14_couplers_ARVALID;
  wire [31:0]auto_ds_to_m14_couplers_AWADDR;
  wire [1:0]auto_ds_to_m14_couplers_AWBURST;
  wire [3:0]auto_ds_to_m14_couplers_AWCACHE;
  wire [7:0]auto_ds_to_m14_couplers_AWLEN;
  wire [0:0]auto_ds_to_m14_couplers_AWLOCK;
  wire [2:0]auto_ds_to_m14_couplers_AWPROT;
  wire [3:0]auto_ds_to_m14_couplers_AWQOS;
  wire auto_ds_to_m14_couplers_AWREADY;
  wire [3:0]auto_ds_to_m14_couplers_AWREGION;
  wire [2:0]auto_ds_to_m14_couplers_AWSIZE;
  wire auto_ds_to_m14_couplers_AWVALID;
  wire auto_ds_to_m14_couplers_BREADY;
  wire [1:0]auto_ds_to_m14_couplers_BRESP;
  wire auto_ds_to_m14_couplers_BVALID;
  wire [31:0]auto_ds_to_m14_couplers_RDATA;
  wire auto_ds_to_m14_couplers_RLAST;
  wire auto_ds_to_m14_couplers_RREADY;
  wire [1:0]auto_ds_to_m14_couplers_RRESP;
  wire auto_ds_to_m14_couplers_RVALID;
  wire [31:0]auto_ds_to_m14_couplers_WDATA;
  wire auto_ds_to_m14_couplers_WLAST;
  wire auto_ds_to_m14_couplers_WREADY;
  wire [3:0]auto_ds_to_m14_couplers_WSTRB;
  wire auto_ds_to_m14_couplers_WVALID;
  wire [31:0]m14_couplers_to_auto_ds_ARADDR;
  wire [1:0]m14_couplers_to_auto_ds_ARBURST;
  wire [3:0]m14_couplers_to_auto_ds_ARCACHE;
  wire [7:0]m14_couplers_to_auto_ds_ARLEN;
  wire [0:0]m14_couplers_to_auto_ds_ARLOCK;
  wire [2:0]m14_couplers_to_auto_ds_ARPROT;
  wire [3:0]m14_couplers_to_auto_ds_ARQOS;
  wire m14_couplers_to_auto_ds_ARREADY;
  wire [3:0]m14_couplers_to_auto_ds_ARREGION;
  wire [2:0]m14_couplers_to_auto_ds_ARSIZE;
  wire m14_couplers_to_auto_ds_ARVALID;
  wire [31:0]m14_couplers_to_auto_ds_AWADDR;
  wire [1:0]m14_couplers_to_auto_ds_AWBURST;
  wire [3:0]m14_couplers_to_auto_ds_AWCACHE;
  wire [7:0]m14_couplers_to_auto_ds_AWLEN;
  wire [0:0]m14_couplers_to_auto_ds_AWLOCK;
  wire [2:0]m14_couplers_to_auto_ds_AWPROT;
  wire [3:0]m14_couplers_to_auto_ds_AWQOS;
  wire m14_couplers_to_auto_ds_AWREADY;
  wire [3:0]m14_couplers_to_auto_ds_AWREGION;
  wire [2:0]m14_couplers_to_auto_ds_AWSIZE;
  wire m14_couplers_to_auto_ds_AWVALID;
  wire m14_couplers_to_auto_ds_BREADY;
  wire [1:0]m14_couplers_to_auto_ds_BRESP;
  wire m14_couplers_to_auto_ds_BVALID;
  wire [511:0]m14_couplers_to_auto_ds_RDATA;
  wire m14_couplers_to_auto_ds_RLAST;
  wire m14_couplers_to_auto_ds_RREADY;
  wire [1:0]m14_couplers_to_auto_ds_RRESP;
  wire m14_couplers_to_auto_ds_RVALID;
  wire [511:0]m14_couplers_to_auto_ds_WDATA;
  wire m14_couplers_to_auto_ds_WLAST;
  wire m14_couplers_to_auto_ds_WREADY;
  wire [63:0]m14_couplers_to_auto_ds_WSTRB;
  wire m14_couplers_to_auto_ds_WVALID;

  assign M_AXI_araddr[31:0] = auto_ds_to_m14_couplers_ARADDR;
  assign M_AXI_arburst[1:0] = auto_ds_to_m14_couplers_ARBURST;
  assign M_AXI_arcache[3:0] = auto_ds_to_m14_couplers_ARCACHE;
  assign M_AXI_arlen[7:0] = auto_ds_to_m14_couplers_ARLEN;
  assign M_AXI_arlock = auto_ds_to_m14_couplers_ARLOCK;
  assign M_AXI_arprot[2:0] = auto_ds_to_m14_couplers_ARPROT;
  assign M_AXI_arqos[3:0] = auto_ds_to_m14_couplers_ARQOS;
  assign M_AXI_arregion[3:0] = auto_ds_to_m14_couplers_ARREGION;
  assign M_AXI_arsize[2:0] = auto_ds_to_m14_couplers_ARSIZE;
  assign M_AXI_arvalid = auto_ds_to_m14_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = auto_ds_to_m14_couplers_AWADDR;
  assign M_AXI_awburst[1:0] = auto_ds_to_m14_couplers_AWBURST;
  assign M_AXI_awcache[3:0] = auto_ds_to_m14_couplers_AWCACHE;
  assign M_AXI_awlen[7:0] = auto_ds_to_m14_couplers_AWLEN;
  assign M_AXI_awlock = auto_ds_to_m14_couplers_AWLOCK;
  assign M_AXI_awprot[2:0] = auto_ds_to_m14_couplers_AWPROT;
  assign M_AXI_awqos[3:0] = auto_ds_to_m14_couplers_AWQOS;
  assign M_AXI_awregion[3:0] = auto_ds_to_m14_couplers_AWREGION;
  assign M_AXI_awsize[2:0] = auto_ds_to_m14_couplers_AWSIZE;
  assign M_AXI_awvalid = auto_ds_to_m14_couplers_AWVALID;
  assign M_AXI_bready = auto_ds_to_m14_couplers_BREADY;
  assign M_AXI_rready = auto_ds_to_m14_couplers_RREADY;
  assign M_AXI_wdata[31:0] = auto_ds_to_m14_couplers_WDATA;
  assign M_AXI_wlast = auto_ds_to_m14_couplers_WLAST;
  assign M_AXI_wstrb[3:0] = auto_ds_to_m14_couplers_WSTRB;
  assign M_AXI_wvalid = auto_ds_to_m14_couplers_WVALID;
  assign S_ACLK_1 = S_ACLK;
  assign S_ARESETN_1 = S_ARESETN[0];
  assign S_AXI_arready = m14_couplers_to_auto_ds_ARREADY;
  assign S_AXI_awready = m14_couplers_to_auto_ds_AWREADY;
  assign S_AXI_bresp[1:0] = m14_couplers_to_auto_ds_BRESP;
  assign S_AXI_bvalid = m14_couplers_to_auto_ds_BVALID;
  assign S_AXI_rdata[511:0] = m14_couplers_to_auto_ds_RDATA;
  assign S_AXI_rlast = m14_couplers_to_auto_ds_RLAST;
  assign S_AXI_rresp[1:0] = m14_couplers_to_auto_ds_RRESP;
  assign S_AXI_rvalid = m14_couplers_to_auto_ds_RVALID;
  assign S_AXI_wready = m14_couplers_to_auto_ds_WREADY;
  assign auto_ds_to_m14_couplers_ARREADY = M_AXI_arready;
  assign auto_ds_to_m14_couplers_AWREADY = M_AXI_awready;
  assign auto_ds_to_m14_couplers_BRESP = M_AXI_bresp[1:0];
  assign auto_ds_to_m14_couplers_BVALID = M_AXI_bvalid;
  assign auto_ds_to_m14_couplers_RDATA = M_AXI_rdata[31:0];
  assign auto_ds_to_m14_couplers_RLAST = M_AXI_rlast;
  assign auto_ds_to_m14_couplers_RRESP = M_AXI_rresp[1:0];
  assign auto_ds_to_m14_couplers_RVALID = M_AXI_rvalid;
  assign auto_ds_to_m14_couplers_WREADY = M_AXI_wready;
  assign m14_couplers_to_auto_ds_ARADDR = S_AXI_araddr[31:0];
  assign m14_couplers_to_auto_ds_ARBURST = S_AXI_arburst[1:0];
  assign m14_couplers_to_auto_ds_ARCACHE = S_AXI_arcache[3:0];
  assign m14_couplers_to_auto_ds_ARLEN = S_AXI_arlen[7:0];
  assign m14_couplers_to_auto_ds_ARLOCK = S_AXI_arlock[0];
  assign m14_couplers_to_auto_ds_ARPROT = S_AXI_arprot[2:0];
  assign m14_couplers_to_auto_ds_ARQOS = S_AXI_arqos[3:0];
  assign m14_couplers_to_auto_ds_ARREGION = S_AXI_arregion[3:0];
  assign m14_couplers_to_auto_ds_ARSIZE = S_AXI_arsize[2:0];
  assign m14_couplers_to_auto_ds_ARVALID = S_AXI_arvalid;
  assign m14_couplers_to_auto_ds_AWADDR = S_AXI_awaddr[31:0];
  assign m14_couplers_to_auto_ds_AWBURST = S_AXI_awburst[1:0];
  assign m14_couplers_to_auto_ds_AWCACHE = S_AXI_awcache[3:0];
  assign m14_couplers_to_auto_ds_AWLEN = S_AXI_awlen[7:0];
  assign m14_couplers_to_auto_ds_AWLOCK = S_AXI_awlock[0];
  assign m14_couplers_to_auto_ds_AWPROT = S_AXI_awprot[2:0];
  assign m14_couplers_to_auto_ds_AWQOS = S_AXI_awqos[3:0];
  assign m14_couplers_to_auto_ds_AWREGION = S_AXI_awregion[3:0];
  assign m14_couplers_to_auto_ds_AWSIZE = S_AXI_awsize[2:0];
  assign m14_couplers_to_auto_ds_AWVALID = S_AXI_awvalid;
  assign m14_couplers_to_auto_ds_BREADY = S_AXI_bready;
  assign m14_couplers_to_auto_ds_RREADY = S_AXI_rready;
  assign m14_couplers_to_auto_ds_WDATA = S_AXI_wdata[511:0];
  assign m14_couplers_to_auto_ds_WLAST = S_AXI_wlast;
  assign m14_couplers_to_auto_ds_WSTRB = S_AXI_wstrb[63:0];
  assign m14_couplers_to_auto_ds_WVALID = S_AXI_wvalid;
  system_i_bak_auto_ds_13 auto_ds
       (.m_axi_araddr(auto_ds_to_m14_couplers_ARADDR),
        .m_axi_arburst(auto_ds_to_m14_couplers_ARBURST),
        .m_axi_arcache(auto_ds_to_m14_couplers_ARCACHE),
        .m_axi_arlen(auto_ds_to_m14_couplers_ARLEN),
        .m_axi_arlock(auto_ds_to_m14_couplers_ARLOCK),
        .m_axi_arprot(auto_ds_to_m14_couplers_ARPROT),
        .m_axi_arqos(auto_ds_to_m14_couplers_ARQOS),
        .m_axi_arready(auto_ds_to_m14_couplers_ARREADY),
        .m_axi_arregion(auto_ds_to_m14_couplers_ARREGION),
        .m_axi_arsize(auto_ds_to_m14_couplers_ARSIZE),
        .m_axi_arvalid(auto_ds_to_m14_couplers_ARVALID),
        .m_axi_awaddr(auto_ds_to_m14_couplers_AWADDR),
        .m_axi_awburst(auto_ds_to_m14_couplers_AWBURST),
        .m_axi_awcache(auto_ds_to_m14_couplers_AWCACHE),
        .m_axi_awlen(auto_ds_to_m14_couplers_AWLEN),
        .m_axi_awlock(auto_ds_to_m14_couplers_AWLOCK),
        .m_axi_awprot(auto_ds_to_m14_couplers_AWPROT),
        .m_axi_awqos(auto_ds_to_m14_couplers_AWQOS),
        .m_axi_awready(auto_ds_to_m14_couplers_AWREADY),
        .m_axi_awregion(auto_ds_to_m14_couplers_AWREGION),
        .m_axi_awsize(auto_ds_to_m14_couplers_AWSIZE),
        .m_axi_awvalid(auto_ds_to_m14_couplers_AWVALID),
        .m_axi_bready(auto_ds_to_m14_couplers_BREADY),
        .m_axi_bresp(auto_ds_to_m14_couplers_BRESP),
        .m_axi_bvalid(auto_ds_to_m14_couplers_BVALID),
        .m_axi_rdata(auto_ds_to_m14_couplers_RDATA),
        .m_axi_rlast(auto_ds_to_m14_couplers_RLAST),
        .m_axi_rready(auto_ds_to_m14_couplers_RREADY),
        .m_axi_rresp(auto_ds_to_m14_couplers_RRESP),
        .m_axi_rvalid(auto_ds_to_m14_couplers_RVALID),
        .m_axi_wdata(auto_ds_to_m14_couplers_WDATA),
        .m_axi_wlast(auto_ds_to_m14_couplers_WLAST),
        .m_axi_wready(auto_ds_to_m14_couplers_WREADY),
        .m_axi_wstrb(auto_ds_to_m14_couplers_WSTRB),
        .m_axi_wvalid(auto_ds_to_m14_couplers_WVALID),
        .s_axi_aclk(S_ACLK_1),
        .s_axi_araddr(m14_couplers_to_auto_ds_ARADDR),
        .s_axi_arburst(m14_couplers_to_auto_ds_ARBURST),
        .s_axi_arcache(m14_couplers_to_auto_ds_ARCACHE),
        .s_axi_aresetn(S_ARESETN_1),
        .s_axi_arlen(m14_couplers_to_auto_ds_ARLEN),
        .s_axi_arlock(m14_couplers_to_auto_ds_ARLOCK),
        .s_axi_arprot(m14_couplers_to_auto_ds_ARPROT),
        .s_axi_arqos(m14_couplers_to_auto_ds_ARQOS),
        .s_axi_arready(m14_couplers_to_auto_ds_ARREADY),
        .s_axi_arregion(m14_couplers_to_auto_ds_ARREGION),
        .s_axi_arsize(m14_couplers_to_auto_ds_ARSIZE),
        .s_axi_arvalid(m14_couplers_to_auto_ds_ARVALID),
        .s_axi_awaddr(m14_couplers_to_auto_ds_AWADDR),
        .s_axi_awburst(m14_couplers_to_auto_ds_AWBURST),
        .s_axi_awcache(m14_couplers_to_auto_ds_AWCACHE),
        .s_axi_awlen(m14_couplers_to_auto_ds_AWLEN),
        .s_axi_awlock(m14_couplers_to_auto_ds_AWLOCK),
        .s_axi_awprot(m14_couplers_to_auto_ds_AWPROT),
        .s_axi_awqos(m14_couplers_to_auto_ds_AWQOS),
        .s_axi_awready(m14_couplers_to_auto_ds_AWREADY),
        .s_axi_awregion(m14_couplers_to_auto_ds_AWREGION),
        .s_axi_awsize(m14_couplers_to_auto_ds_AWSIZE),
        .s_axi_awvalid(m14_couplers_to_auto_ds_AWVALID),
        .s_axi_bready(m14_couplers_to_auto_ds_BREADY),
        .s_axi_bresp(m14_couplers_to_auto_ds_BRESP),
        .s_axi_bvalid(m14_couplers_to_auto_ds_BVALID),
        .s_axi_rdata(m14_couplers_to_auto_ds_RDATA),
        .s_axi_rlast(m14_couplers_to_auto_ds_RLAST),
        .s_axi_rready(m14_couplers_to_auto_ds_RREADY),
        .s_axi_rresp(m14_couplers_to_auto_ds_RRESP),
        .s_axi_rvalid(m14_couplers_to_auto_ds_RVALID),
        .s_axi_wdata(m14_couplers_to_auto_ds_WDATA),
        .s_axi_wlast(m14_couplers_to_auto_ds_WLAST),
        .s_axi_wready(m14_couplers_to_auto_ds_WREADY),
        .s_axi_wstrb(m14_couplers_to_auto_ds_WSTRB),
        .s_axi_wvalid(m14_couplers_to_auto_ds_WVALID));
endmodule

module microblaze_0_local_memory_imp_D4M65J
   (DLMB_abus,
    DLMB_addrstrobe,
    DLMB_be,
    DLMB_ce,
    DLMB_readdbus,
    DLMB_readstrobe,
    DLMB_ready,
    DLMB_ue,
    DLMB_wait,
    DLMB_writedbus,
    DLMB_writestrobe,
    ILMB_abus,
    ILMB_addrstrobe,
    ILMB_ce,
    ILMB_readdbus,
    ILMB_readstrobe,
    ILMB_ready,
    ILMB_ue,
    ILMB_wait,
    LMB_Clk,
    SYS_Rst);
  input [0:31]DLMB_abus;
  input DLMB_addrstrobe;
  input [0:3]DLMB_be;
  output DLMB_ce;
  output [0:31]DLMB_readdbus;
  input DLMB_readstrobe;
  output DLMB_ready;
  output DLMB_ue;
  output DLMB_wait;
  input [0:31]DLMB_writedbus;
  input DLMB_writestrobe;
  input [0:31]ILMB_abus;
  input ILMB_addrstrobe;
  output ILMB_ce;
  output [0:31]ILMB_readdbus;
  input ILMB_readstrobe;
  output ILMB_ready;
  output ILMB_ue;
  output ILMB_wait;
  input LMB_Clk;
  input [0:0]SYS_Rst;

  wire [0:0]SYS_Rst_1;
  wire microblaze_0_Clk;
  wire [0:31]microblaze_0_dlmb_ABUS;
  wire microblaze_0_dlmb_ADDRSTROBE;
  wire [0:3]microblaze_0_dlmb_BE;
  wire microblaze_0_dlmb_CE;
  wire [0:31]microblaze_0_dlmb_READDBUS;
  wire microblaze_0_dlmb_READSTROBE;
  wire microblaze_0_dlmb_READY;
  wire microblaze_0_dlmb_UE;
  wire microblaze_0_dlmb_WAIT;
  wire [0:31]microblaze_0_dlmb_WRITEDBUS;
  wire microblaze_0_dlmb_WRITESTROBE;
  wire [0:31]microblaze_0_dlmb_bus_ABUS;
  wire microblaze_0_dlmb_bus_ADDRSTROBE;
  wire [0:3]microblaze_0_dlmb_bus_BE;
  wire microblaze_0_dlmb_bus_CE;
  wire [0:31]microblaze_0_dlmb_bus_READDBUS;
  wire microblaze_0_dlmb_bus_READSTROBE;
  wire microblaze_0_dlmb_bus_READY;
  wire microblaze_0_dlmb_bus_UE;
  wire microblaze_0_dlmb_bus_WAIT;
  wire [0:31]microblaze_0_dlmb_bus_WRITEDBUS;
  wire microblaze_0_dlmb_bus_WRITESTROBE;
  wire [0:31]microblaze_0_dlmb_cntlr_ADDR;
  wire microblaze_0_dlmb_cntlr_CLK;
  wire [0:31]microblaze_0_dlmb_cntlr_DIN;
  wire [31:0]microblaze_0_dlmb_cntlr_DOUT;
  wire microblaze_0_dlmb_cntlr_EN;
  wire microblaze_0_dlmb_cntlr_RST;
  wire [0:3]microblaze_0_dlmb_cntlr_WE;
  wire [0:31]microblaze_0_ilmb_ABUS;
  wire microblaze_0_ilmb_ADDRSTROBE;
  wire microblaze_0_ilmb_CE;
  wire [0:31]microblaze_0_ilmb_READDBUS;
  wire microblaze_0_ilmb_READSTROBE;
  wire microblaze_0_ilmb_READY;
  wire microblaze_0_ilmb_UE;
  wire microblaze_0_ilmb_WAIT;
  wire [0:31]microblaze_0_ilmb_bus_ABUS;
  wire microblaze_0_ilmb_bus_ADDRSTROBE;
  wire [0:3]microblaze_0_ilmb_bus_BE;
  wire microblaze_0_ilmb_bus_CE;
  wire [0:31]microblaze_0_ilmb_bus_READDBUS;
  wire microblaze_0_ilmb_bus_READSTROBE;
  wire microblaze_0_ilmb_bus_READY;
  wire microblaze_0_ilmb_bus_UE;
  wire microblaze_0_ilmb_bus_WAIT;
  wire [0:31]microblaze_0_ilmb_bus_WRITEDBUS;
  wire microblaze_0_ilmb_bus_WRITESTROBE;
  wire [0:31]microblaze_0_ilmb_cntlr_ADDR;
  wire microblaze_0_ilmb_cntlr_CLK;
  wire [0:31]microblaze_0_ilmb_cntlr_DIN;
  wire [31:0]microblaze_0_ilmb_cntlr_DOUT;
  wire microblaze_0_ilmb_cntlr_EN;
  wire microblaze_0_ilmb_cntlr_RST;
  wire [0:3]microblaze_0_ilmb_cntlr_WE;

  assign DLMB_ce = microblaze_0_dlmb_CE;
  assign DLMB_readdbus[0:31] = microblaze_0_dlmb_READDBUS;
  assign DLMB_ready = microblaze_0_dlmb_READY;
  assign DLMB_ue = microblaze_0_dlmb_UE;
  assign DLMB_wait = microblaze_0_dlmb_WAIT;
  assign ILMB_ce = microblaze_0_ilmb_CE;
  assign ILMB_readdbus[0:31] = microblaze_0_ilmb_READDBUS;
  assign ILMB_ready = microblaze_0_ilmb_READY;
  assign ILMB_ue = microblaze_0_ilmb_UE;
  assign ILMB_wait = microblaze_0_ilmb_WAIT;
  assign SYS_Rst_1 = SYS_Rst[0];
  assign microblaze_0_Clk = LMB_Clk;
  assign microblaze_0_dlmb_ABUS = DLMB_abus[0:31];
  assign microblaze_0_dlmb_ADDRSTROBE = DLMB_addrstrobe;
  assign microblaze_0_dlmb_BE = DLMB_be[0:3];
  assign microblaze_0_dlmb_READSTROBE = DLMB_readstrobe;
  assign microblaze_0_dlmb_WRITEDBUS = DLMB_writedbus[0:31];
  assign microblaze_0_dlmb_WRITESTROBE = DLMB_writestrobe;
  assign microblaze_0_ilmb_ABUS = ILMB_abus[0:31];
  assign microblaze_0_ilmb_ADDRSTROBE = ILMB_addrstrobe;
  assign microblaze_0_ilmb_READSTROBE = ILMB_readstrobe;
  (* BMM_INFO_ADDRESS_SPACE = "byte  0x00000000 32 > system_i_bak microblaze_0_local_memory/lmb_bram" *) 
  (* KEEP_HIERARCHY = "yes" *) 
  system_i_bak_dlmb_bram_if_cntlr_0 dlmb_bram_if_cntlr
       (.BRAM_Addr_A(microblaze_0_dlmb_cntlr_ADDR),
        .BRAM_Clk_A(microblaze_0_dlmb_cntlr_CLK),
        .BRAM_Din_A({microblaze_0_dlmb_cntlr_DOUT[31],microblaze_0_dlmb_cntlr_DOUT[30],microblaze_0_dlmb_cntlr_DOUT[29],microblaze_0_dlmb_cntlr_DOUT[28],microblaze_0_dlmb_cntlr_DOUT[27],microblaze_0_dlmb_cntlr_DOUT[26],microblaze_0_dlmb_cntlr_DOUT[25],microblaze_0_dlmb_cntlr_DOUT[24],microblaze_0_dlmb_cntlr_DOUT[23],microblaze_0_dlmb_cntlr_DOUT[22],microblaze_0_dlmb_cntlr_DOUT[21],microblaze_0_dlmb_cntlr_DOUT[20],microblaze_0_dlmb_cntlr_DOUT[19],microblaze_0_dlmb_cntlr_DOUT[18],microblaze_0_dlmb_cntlr_DOUT[17],microblaze_0_dlmb_cntlr_DOUT[16],microblaze_0_dlmb_cntlr_DOUT[15],microblaze_0_dlmb_cntlr_DOUT[14],microblaze_0_dlmb_cntlr_DOUT[13],microblaze_0_dlmb_cntlr_DOUT[12],microblaze_0_dlmb_cntlr_DOUT[11],microblaze_0_dlmb_cntlr_DOUT[10],microblaze_0_dlmb_cntlr_DOUT[9],microblaze_0_dlmb_cntlr_DOUT[8],microblaze_0_dlmb_cntlr_DOUT[7],microblaze_0_dlmb_cntlr_DOUT[6],microblaze_0_dlmb_cntlr_DOUT[5],microblaze_0_dlmb_cntlr_DOUT[4],microblaze_0_dlmb_cntlr_DOUT[3],microblaze_0_dlmb_cntlr_DOUT[2],microblaze_0_dlmb_cntlr_DOUT[1],microblaze_0_dlmb_cntlr_DOUT[0]}),
        .BRAM_Dout_A(microblaze_0_dlmb_cntlr_DIN),
        .BRAM_EN_A(microblaze_0_dlmb_cntlr_EN),
        .BRAM_Rst_A(microblaze_0_dlmb_cntlr_RST),
        .BRAM_WEN_A(microblaze_0_dlmb_cntlr_WE),
        .LMB_ABus(microblaze_0_dlmb_bus_ABUS),
        .LMB_AddrStrobe(microblaze_0_dlmb_bus_ADDRSTROBE),
        .LMB_BE(microblaze_0_dlmb_bus_BE),
        .LMB_Clk(microblaze_0_Clk),
        .LMB_ReadStrobe(microblaze_0_dlmb_bus_READSTROBE),
        .LMB_Rst(SYS_Rst_1),
        .LMB_WriteDBus(microblaze_0_dlmb_bus_WRITEDBUS),
        .LMB_WriteStrobe(microblaze_0_dlmb_bus_WRITESTROBE),
        .Sl_CE(microblaze_0_dlmb_bus_CE),
        .Sl_DBus(microblaze_0_dlmb_bus_READDBUS),
        .Sl_Ready(microblaze_0_dlmb_bus_READY),
        .Sl_UE(microblaze_0_dlmb_bus_UE),
        .Sl_Wait(microblaze_0_dlmb_bus_WAIT));
  system_i_bak_dlmb_v10_0 dlmb_v10
       (.LMB_ABus(microblaze_0_dlmb_bus_ABUS),
        .LMB_AddrStrobe(microblaze_0_dlmb_bus_ADDRSTROBE),
        .LMB_BE(microblaze_0_dlmb_bus_BE),
        .LMB_CE(microblaze_0_dlmb_CE),
        .LMB_Clk(microblaze_0_Clk),
        .LMB_ReadDBus(microblaze_0_dlmb_READDBUS),
        .LMB_ReadStrobe(microblaze_0_dlmb_bus_READSTROBE),
        .LMB_Ready(microblaze_0_dlmb_READY),
        .LMB_UE(microblaze_0_dlmb_UE),
        .LMB_Wait(microblaze_0_dlmb_WAIT),
        .LMB_WriteDBus(microblaze_0_dlmb_bus_WRITEDBUS),
        .LMB_WriteStrobe(microblaze_0_dlmb_bus_WRITESTROBE),
        .M_ABus(microblaze_0_dlmb_ABUS),
        .M_AddrStrobe(microblaze_0_dlmb_ADDRSTROBE),
        .M_BE(microblaze_0_dlmb_BE),
        .M_DBus(microblaze_0_dlmb_WRITEDBUS),
        .M_ReadStrobe(microblaze_0_dlmb_READSTROBE),
        .M_WriteStrobe(microblaze_0_dlmb_WRITESTROBE),
        .SYS_Rst(SYS_Rst_1),
        .Sl_CE(microblaze_0_dlmb_bus_CE),
        .Sl_DBus(microblaze_0_dlmb_bus_READDBUS),
        .Sl_Ready(microblaze_0_dlmb_bus_READY),
        .Sl_UE(microblaze_0_dlmb_bus_UE),
        .Sl_Wait(microblaze_0_dlmb_bus_WAIT));
  system_i_bak_ilmb_bram_if_cntlr_0 ilmb_bram_if_cntlr
       (.BRAM_Addr_A(microblaze_0_ilmb_cntlr_ADDR),
        .BRAM_Clk_A(microblaze_0_ilmb_cntlr_CLK),
        .BRAM_Din_A({microblaze_0_ilmb_cntlr_DOUT[31],microblaze_0_ilmb_cntlr_DOUT[30],microblaze_0_ilmb_cntlr_DOUT[29],microblaze_0_ilmb_cntlr_DOUT[28],microblaze_0_ilmb_cntlr_DOUT[27],microblaze_0_ilmb_cntlr_DOUT[26],microblaze_0_ilmb_cntlr_DOUT[25],microblaze_0_ilmb_cntlr_DOUT[24],microblaze_0_ilmb_cntlr_DOUT[23],microblaze_0_ilmb_cntlr_DOUT[22],microblaze_0_ilmb_cntlr_DOUT[21],microblaze_0_ilmb_cntlr_DOUT[20],microblaze_0_ilmb_cntlr_DOUT[19],microblaze_0_ilmb_cntlr_DOUT[18],microblaze_0_ilmb_cntlr_DOUT[17],microblaze_0_ilmb_cntlr_DOUT[16],microblaze_0_ilmb_cntlr_DOUT[15],microblaze_0_ilmb_cntlr_DOUT[14],microblaze_0_ilmb_cntlr_DOUT[13],microblaze_0_ilmb_cntlr_DOUT[12],microblaze_0_ilmb_cntlr_DOUT[11],microblaze_0_ilmb_cntlr_DOUT[10],microblaze_0_ilmb_cntlr_DOUT[9],microblaze_0_ilmb_cntlr_DOUT[8],microblaze_0_ilmb_cntlr_DOUT[7],microblaze_0_ilmb_cntlr_DOUT[6],microblaze_0_ilmb_cntlr_DOUT[5],microblaze_0_ilmb_cntlr_DOUT[4],microblaze_0_ilmb_cntlr_DOUT[3],microblaze_0_ilmb_cntlr_DOUT[2],microblaze_0_ilmb_cntlr_DOUT[1],microblaze_0_ilmb_cntlr_DOUT[0]}),
        .BRAM_Dout_A(microblaze_0_ilmb_cntlr_DIN),
        .BRAM_EN_A(microblaze_0_ilmb_cntlr_EN),
        .BRAM_Rst_A(microblaze_0_ilmb_cntlr_RST),
        .BRAM_WEN_A(microblaze_0_ilmb_cntlr_WE),
        .LMB_ABus(microblaze_0_ilmb_bus_ABUS),
        .LMB_AddrStrobe(microblaze_0_ilmb_bus_ADDRSTROBE),
        .LMB_BE(microblaze_0_ilmb_bus_BE),
        .LMB_Clk(microblaze_0_Clk),
        .LMB_ReadStrobe(microblaze_0_ilmb_bus_READSTROBE),
        .LMB_Rst(SYS_Rst_1),
        .LMB_WriteDBus(microblaze_0_ilmb_bus_WRITEDBUS),
        .LMB_WriteStrobe(microblaze_0_ilmb_bus_WRITESTROBE),
        .Sl_CE(microblaze_0_ilmb_bus_CE),
        .Sl_DBus(microblaze_0_ilmb_bus_READDBUS),
        .Sl_Ready(microblaze_0_ilmb_bus_READY),
        .Sl_UE(microblaze_0_ilmb_bus_UE),
        .Sl_Wait(microblaze_0_ilmb_bus_WAIT));
  system_i_bak_ilmb_v10_0 ilmb_v10
       (.LMB_ABus(microblaze_0_ilmb_bus_ABUS),
        .LMB_AddrStrobe(microblaze_0_ilmb_bus_ADDRSTROBE),
        .LMB_BE(microblaze_0_ilmb_bus_BE),
        .LMB_CE(microblaze_0_ilmb_CE),
        .LMB_Clk(microblaze_0_Clk),
        .LMB_ReadDBus(microblaze_0_ilmb_READDBUS),
        .LMB_ReadStrobe(microblaze_0_ilmb_bus_READSTROBE),
        .LMB_Ready(microblaze_0_ilmb_READY),
        .LMB_UE(microblaze_0_ilmb_UE),
        .LMB_Wait(microblaze_0_ilmb_WAIT),
        .LMB_WriteDBus(microblaze_0_ilmb_bus_WRITEDBUS),
        .LMB_WriteStrobe(microblaze_0_ilmb_bus_WRITESTROBE),
        .M_ABus(microblaze_0_ilmb_ABUS),
        .M_AddrStrobe(microblaze_0_ilmb_ADDRSTROBE),
        .M_BE({1'b0,1'b0,1'b0,1'b0}),
        .M_DBus({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .M_ReadStrobe(microblaze_0_ilmb_READSTROBE),
        .M_WriteStrobe(1'b0),
        .SYS_Rst(SYS_Rst_1),
        .Sl_CE(microblaze_0_ilmb_bus_CE),
        .Sl_DBus(microblaze_0_ilmb_bus_READDBUS),
        .Sl_Ready(microblaze_0_ilmb_bus_READY),
        .Sl_UE(microblaze_0_ilmb_bus_UE),
        .Sl_Wait(microblaze_0_ilmb_bus_WAIT));
  system_i_bak_lmb_bram_0 lmb_bram
       (.addra({microblaze_0_dlmb_cntlr_ADDR[0],microblaze_0_dlmb_cntlr_ADDR[1],microblaze_0_dlmb_cntlr_ADDR[2],microblaze_0_dlmb_cntlr_ADDR[3],microblaze_0_dlmb_cntlr_ADDR[4],microblaze_0_dlmb_cntlr_ADDR[5],microblaze_0_dlmb_cntlr_ADDR[6],microblaze_0_dlmb_cntlr_ADDR[7],microblaze_0_dlmb_cntlr_ADDR[8],microblaze_0_dlmb_cntlr_ADDR[9],microblaze_0_dlmb_cntlr_ADDR[10],microblaze_0_dlmb_cntlr_ADDR[11],microblaze_0_dlmb_cntlr_ADDR[12],microblaze_0_dlmb_cntlr_ADDR[13],microblaze_0_dlmb_cntlr_ADDR[14],microblaze_0_dlmb_cntlr_ADDR[15],microblaze_0_dlmb_cntlr_ADDR[16],microblaze_0_dlmb_cntlr_ADDR[17],microblaze_0_dlmb_cntlr_ADDR[18],microblaze_0_dlmb_cntlr_ADDR[19],microblaze_0_dlmb_cntlr_ADDR[20],microblaze_0_dlmb_cntlr_ADDR[21],microblaze_0_dlmb_cntlr_ADDR[22],microblaze_0_dlmb_cntlr_ADDR[23],microblaze_0_dlmb_cntlr_ADDR[24],microblaze_0_dlmb_cntlr_ADDR[25],microblaze_0_dlmb_cntlr_ADDR[26],microblaze_0_dlmb_cntlr_ADDR[27],microblaze_0_dlmb_cntlr_ADDR[28],microblaze_0_dlmb_cntlr_ADDR[29],microblaze_0_dlmb_cntlr_ADDR[30],microblaze_0_dlmb_cntlr_ADDR[31]}),
        .addrb({microblaze_0_ilmb_cntlr_ADDR[0],microblaze_0_ilmb_cntlr_ADDR[1],microblaze_0_ilmb_cntlr_ADDR[2],microblaze_0_ilmb_cntlr_ADDR[3],microblaze_0_ilmb_cntlr_ADDR[4],microblaze_0_ilmb_cntlr_ADDR[5],microblaze_0_ilmb_cntlr_ADDR[6],microblaze_0_ilmb_cntlr_ADDR[7],microblaze_0_ilmb_cntlr_ADDR[8],microblaze_0_ilmb_cntlr_ADDR[9],microblaze_0_ilmb_cntlr_ADDR[10],microblaze_0_ilmb_cntlr_ADDR[11],microblaze_0_ilmb_cntlr_ADDR[12],microblaze_0_ilmb_cntlr_ADDR[13],microblaze_0_ilmb_cntlr_ADDR[14],microblaze_0_ilmb_cntlr_ADDR[15],microblaze_0_ilmb_cntlr_ADDR[16],microblaze_0_ilmb_cntlr_ADDR[17],microblaze_0_ilmb_cntlr_ADDR[18],microblaze_0_ilmb_cntlr_ADDR[19],microblaze_0_ilmb_cntlr_ADDR[20],microblaze_0_ilmb_cntlr_ADDR[21],microblaze_0_ilmb_cntlr_ADDR[22],microblaze_0_ilmb_cntlr_ADDR[23],microblaze_0_ilmb_cntlr_ADDR[24],microblaze_0_ilmb_cntlr_ADDR[25],microblaze_0_ilmb_cntlr_ADDR[26],microblaze_0_ilmb_cntlr_ADDR[27],microblaze_0_ilmb_cntlr_ADDR[28],microblaze_0_ilmb_cntlr_ADDR[29],microblaze_0_ilmb_cntlr_ADDR[30],microblaze_0_ilmb_cntlr_ADDR[31]}),
        .clka(microblaze_0_dlmb_cntlr_CLK),
        .clkb(microblaze_0_ilmb_cntlr_CLK),
        .dina({microblaze_0_dlmb_cntlr_DIN[0],microblaze_0_dlmb_cntlr_DIN[1],microblaze_0_dlmb_cntlr_DIN[2],microblaze_0_dlmb_cntlr_DIN[3],microblaze_0_dlmb_cntlr_DIN[4],microblaze_0_dlmb_cntlr_DIN[5],microblaze_0_dlmb_cntlr_DIN[6],microblaze_0_dlmb_cntlr_DIN[7],microblaze_0_dlmb_cntlr_DIN[8],microblaze_0_dlmb_cntlr_DIN[9],microblaze_0_dlmb_cntlr_DIN[10],microblaze_0_dlmb_cntlr_DIN[11],microblaze_0_dlmb_cntlr_DIN[12],microblaze_0_dlmb_cntlr_DIN[13],microblaze_0_dlmb_cntlr_DIN[14],microblaze_0_dlmb_cntlr_DIN[15],microblaze_0_dlmb_cntlr_DIN[16],microblaze_0_dlmb_cntlr_DIN[17],microblaze_0_dlmb_cntlr_DIN[18],microblaze_0_dlmb_cntlr_DIN[19],microblaze_0_dlmb_cntlr_DIN[20],microblaze_0_dlmb_cntlr_DIN[21],microblaze_0_dlmb_cntlr_DIN[22],microblaze_0_dlmb_cntlr_DIN[23],microblaze_0_dlmb_cntlr_DIN[24],microblaze_0_dlmb_cntlr_DIN[25],microblaze_0_dlmb_cntlr_DIN[26],microblaze_0_dlmb_cntlr_DIN[27],microblaze_0_dlmb_cntlr_DIN[28],microblaze_0_dlmb_cntlr_DIN[29],microblaze_0_dlmb_cntlr_DIN[30],microblaze_0_dlmb_cntlr_DIN[31]}),
        .dinb({microblaze_0_ilmb_cntlr_DIN[0],microblaze_0_ilmb_cntlr_DIN[1],microblaze_0_ilmb_cntlr_DIN[2],microblaze_0_ilmb_cntlr_DIN[3],microblaze_0_ilmb_cntlr_DIN[4],microblaze_0_ilmb_cntlr_DIN[5],microblaze_0_ilmb_cntlr_DIN[6],microblaze_0_ilmb_cntlr_DIN[7],microblaze_0_ilmb_cntlr_DIN[8],microblaze_0_ilmb_cntlr_DIN[9],microblaze_0_ilmb_cntlr_DIN[10],microblaze_0_ilmb_cntlr_DIN[11],microblaze_0_ilmb_cntlr_DIN[12],microblaze_0_ilmb_cntlr_DIN[13],microblaze_0_ilmb_cntlr_DIN[14],microblaze_0_ilmb_cntlr_DIN[15],microblaze_0_ilmb_cntlr_DIN[16],microblaze_0_ilmb_cntlr_DIN[17],microblaze_0_ilmb_cntlr_DIN[18],microblaze_0_ilmb_cntlr_DIN[19],microblaze_0_ilmb_cntlr_DIN[20],microblaze_0_ilmb_cntlr_DIN[21],microblaze_0_ilmb_cntlr_DIN[22],microblaze_0_ilmb_cntlr_DIN[23],microblaze_0_ilmb_cntlr_DIN[24],microblaze_0_ilmb_cntlr_DIN[25],microblaze_0_ilmb_cntlr_DIN[26],microblaze_0_ilmb_cntlr_DIN[27],microblaze_0_ilmb_cntlr_DIN[28],microblaze_0_ilmb_cntlr_DIN[29],microblaze_0_ilmb_cntlr_DIN[30],microblaze_0_ilmb_cntlr_DIN[31]}),
        .douta(microblaze_0_dlmb_cntlr_DOUT),
        .doutb(microblaze_0_ilmb_cntlr_DOUT),
        .ena(microblaze_0_dlmb_cntlr_EN),
        .enb(microblaze_0_ilmb_cntlr_EN),
        .rsta(microblaze_0_dlmb_cntlr_RST),
        .rstb(microblaze_0_ilmb_cntlr_RST),
        .wea({microblaze_0_dlmb_cntlr_WE[0],microblaze_0_dlmb_cntlr_WE[1],microblaze_0_dlmb_cntlr_WE[2],microblaze_0_dlmb_cntlr_WE[3]}),
        .web({microblaze_0_ilmb_cntlr_WE[0],microblaze_0_ilmb_cntlr_WE[1],microblaze_0_ilmb_cntlr_WE[2],microblaze_0_ilmb_cntlr_WE[3]}));
endmodule

module s00_couplers_imp_6ZG57K
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arburst,
    M_AXI_arcache,
    M_AXI_arlen,
    M_AXI_arlock,
    M_AXI_arprot,
    M_AXI_arqos,
    M_AXI_arready,
    M_AXI_arsize,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awburst,
    M_AXI_awcache,
    M_AXI_awlen,
    M_AXI_awlock,
    M_AXI_awprot,
    M_AXI_awqos,
    M_AXI_awready,
    M_AXI_awsize,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rlast,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wlast,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arburst,
    S_AXI_arcache,
    S_AXI_arlen,
    S_AXI_arlock,
    S_AXI_arprot,
    S_AXI_arqos,
    S_AXI_arready,
    S_AXI_arsize,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awburst,
    S_AXI_awcache,
    S_AXI_awlen,
    S_AXI_awlock,
    S_AXI_awprot,
    S_AXI_awqos,
    S_AXI_awready,
    S_AXI_awsize,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rlast,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wlast,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input [0:0]M_ARESETN;
  output [31:0]M_AXI_araddr;
  output [1:0]M_AXI_arburst;
  output [3:0]M_AXI_arcache;
  output [7:0]M_AXI_arlen;
  output [0:0]M_AXI_arlock;
  output [2:0]M_AXI_arprot;
  output [3:0]M_AXI_arqos;
  input M_AXI_arready;
  output [2:0]M_AXI_arsize;
  output M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  output [1:0]M_AXI_awburst;
  output [3:0]M_AXI_awcache;
  output [7:0]M_AXI_awlen;
  output [0:0]M_AXI_awlock;
  output [2:0]M_AXI_awprot;
  output [3:0]M_AXI_awqos;
  input M_AXI_awready;
  output [2:0]M_AXI_awsize;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [511:0]M_AXI_rdata;
  input M_AXI_rlast;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [511:0]M_AXI_wdata;
  output M_AXI_wlast;
  input M_AXI_wready;
  output [63:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input [0:0]S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [1:0]S_AXI_arburst;
  input [3:0]S_AXI_arcache;
  input [7:0]S_AXI_arlen;
  input [0:0]S_AXI_arlock;
  input [2:0]S_AXI_arprot;
  input [3:0]S_AXI_arqos;
  output S_AXI_arready;
  input [2:0]S_AXI_arsize;
  input S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  input [1:0]S_AXI_awburst;
  input [3:0]S_AXI_awcache;
  input [7:0]S_AXI_awlen;
  input [0:0]S_AXI_awlock;
  input [2:0]S_AXI_awprot;
  input [3:0]S_AXI_awqos;
  output S_AXI_awready;
  input [2:0]S_AXI_awsize;
  input S_AXI_awvalid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [31:0]S_AXI_rdata;
  output S_AXI_rlast;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [31:0]S_AXI_wdata;
  input S_AXI_wlast;
  output S_AXI_wready;
  input [3:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire M_ACLK_1;
  wire [0:0]M_ARESETN_1;
  wire S_ACLK_1;
  wire [0:0]S_ARESETN_1;
  wire [31:0]auto_us_df_to_s00_couplers_ARADDR;
  wire [1:0]auto_us_df_to_s00_couplers_ARBURST;
  wire [3:0]auto_us_df_to_s00_couplers_ARCACHE;
  wire [7:0]auto_us_df_to_s00_couplers_ARLEN;
  wire [0:0]auto_us_df_to_s00_couplers_ARLOCK;
  wire [2:0]auto_us_df_to_s00_couplers_ARPROT;
  wire [3:0]auto_us_df_to_s00_couplers_ARQOS;
  wire auto_us_df_to_s00_couplers_ARREADY;
  wire [2:0]auto_us_df_to_s00_couplers_ARSIZE;
  wire auto_us_df_to_s00_couplers_ARVALID;
  wire [31:0]auto_us_df_to_s00_couplers_AWADDR;
  wire [1:0]auto_us_df_to_s00_couplers_AWBURST;
  wire [3:0]auto_us_df_to_s00_couplers_AWCACHE;
  wire [7:0]auto_us_df_to_s00_couplers_AWLEN;
  wire [0:0]auto_us_df_to_s00_couplers_AWLOCK;
  wire [2:0]auto_us_df_to_s00_couplers_AWPROT;
  wire [3:0]auto_us_df_to_s00_couplers_AWQOS;
  wire auto_us_df_to_s00_couplers_AWREADY;
  wire [2:0]auto_us_df_to_s00_couplers_AWSIZE;
  wire auto_us_df_to_s00_couplers_AWVALID;
  wire auto_us_df_to_s00_couplers_BREADY;
  wire [1:0]auto_us_df_to_s00_couplers_BRESP;
  wire auto_us_df_to_s00_couplers_BVALID;
  wire [511:0]auto_us_df_to_s00_couplers_RDATA;
  wire auto_us_df_to_s00_couplers_RLAST;
  wire auto_us_df_to_s00_couplers_RREADY;
  wire [1:0]auto_us_df_to_s00_couplers_RRESP;
  wire auto_us_df_to_s00_couplers_RVALID;
  wire [511:0]auto_us_df_to_s00_couplers_WDATA;
  wire auto_us_df_to_s00_couplers_WLAST;
  wire auto_us_df_to_s00_couplers_WREADY;
  wire [63:0]auto_us_df_to_s00_couplers_WSTRB;
  wire auto_us_df_to_s00_couplers_WVALID;
  wire [31:0]s00_couplers_to_auto_us_df_ARADDR;
  wire [1:0]s00_couplers_to_auto_us_df_ARBURST;
  wire [3:0]s00_couplers_to_auto_us_df_ARCACHE;
  wire [7:0]s00_couplers_to_auto_us_df_ARLEN;
  wire [0:0]s00_couplers_to_auto_us_df_ARLOCK;
  wire [2:0]s00_couplers_to_auto_us_df_ARPROT;
  wire [3:0]s00_couplers_to_auto_us_df_ARQOS;
  wire s00_couplers_to_auto_us_df_ARREADY;
  wire [2:0]s00_couplers_to_auto_us_df_ARSIZE;
  wire s00_couplers_to_auto_us_df_ARVALID;
  wire [31:0]s00_couplers_to_auto_us_df_AWADDR;
  wire [1:0]s00_couplers_to_auto_us_df_AWBURST;
  wire [3:0]s00_couplers_to_auto_us_df_AWCACHE;
  wire [7:0]s00_couplers_to_auto_us_df_AWLEN;
  wire [0:0]s00_couplers_to_auto_us_df_AWLOCK;
  wire [2:0]s00_couplers_to_auto_us_df_AWPROT;
  wire [3:0]s00_couplers_to_auto_us_df_AWQOS;
  wire s00_couplers_to_auto_us_df_AWREADY;
  wire [2:0]s00_couplers_to_auto_us_df_AWSIZE;
  wire s00_couplers_to_auto_us_df_AWVALID;
  wire s00_couplers_to_auto_us_df_BREADY;
  wire [1:0]s00_couplers_to_auto_us_df_BRESP;
  wire s00_couplers_to_auto_us_df_BVALID;
  wire [31:0]s00_couplers_to_auto_us_df_RDATA;
  wire s00_couplers_to_auto_us_df_RLAST;
  wire s00_couplers_to_auto_us_df_RREADY;
  wire [1:0]s00_couplers_to_auto_us_df_RRESP;
  wire s00_couplers_to_auto_us_df_RVALID;
  wire [31:0]s00_couplers_to_auto_us_df_WDATA;
  wire s00_couplers_to_auto_us_df_WLAST;
  wire s00_couplers_to_auto_us_df_WREADY;
  wire [3:0]s00_couplers_to_auto_us_df_WSTRB;
  wire s00_couplers_to_auto_us_df_WVALID;

  assign M_ACLK_1 = M_ACLK;
  assign M_ARESETN_1 = M_ARESETN[0];
  assign M_AXI_araddr[31:0] = auto_us_df_to_s00_couplers_ARADDR;
  assign M_AXI_arburst[1:0] = auto_us_df_to_s00_couplers_ARBURST;
  assign M_AXI_arcache[3:0] = auto_us_df_to_s00_couplers_ARCACHE;
  assign M_AXI_arlen[7:0] = auto_us_df_to_s00_couplers_ARLEN;
  assign M_AXI_arlock[0] = auto_us_df_to_s00_couplers_ARLOCK;
  assign M_AXI_arprot[2:0] = auto_us_df_to_s00_couplers_ARPROT;
  assign M_AXI_arqos[3:0] = auto_us_df_to_s00_couplers_ARQOS;
  assign M_AXI_arsize[2:0] = auto_us_df_to_s00_couplers_ARSIZE;
  assign M_AXI_arvalid = auto_us_df_to_s00_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = auto_us_df_to_s00_couplers_AWADDR;
  assign M_AXI_awburst[1:0] = auto_us_df_to_s00_couplers_AWBURST;
  assign M_AXI_awcache[3:0] = auto_us_df_to_s00_couplers_AWCACHE;
  assign M_AXI_awlen[7:0] = auto_us_df_to_s00_couplers_AWLEN;
  assign M_AXI_awlock[0] = auto_us_df_to_s00_couplers_AWLOCK;
  assign M_AXI_awprot[2:0] = auto_us_df_to_s00_couplers_AWPROT;
  assign M_AXI_awqos[3:0] = auto_us_df_to_s00_couplers_AWQOS;
  assign M_AXI_awsize[2:0] = auto_us_df_to_s00_couplers_AWSIZE;
  assign M_AXI_awvalid = auto_us_df_to_s00_couplers_AWVALID;
  assign M_AXI_bready = auto_us_df_to_s00_couplers_BREADY;
  assign M_AXI_rready = auto_us_df_to_s00_couplers_RREADY;
  assign M_AXI_wdata[511:0] = auto_us_df_to_s00_couplers_WDATA;
  assign M_AXI_wlast = auto_us_df_to_s00_couplers_WLAST;
  assign M_AXI_wstrb[63:0] = auto_us_df_to_s00_couplers_WSTRB;
  assign M_AXI_wvalid = auto_us_df_to_s00_couplers_WVALID;
  assign S_ACLK_1 = S_ACLK;
  assign S_ARESETN_1 = S_ARESETN[0];
  assign S_AXI_arready = s00_couplers_to_auto_us_df_ARREADY;
  assign S_AXI_awready = s00_couplers_to_auto_us_df_AWREADY;
  assign S_AXI_bresp[1:0] = s00_couplers_to_auto_us_df_BRESP;
  assign S_AXI_bvalid = s00_couplers_to_auto_us_df_BVALID;
  assign S_AXI_rdata[31:0] = s00_couplers_to_auto_us_df_RDATA;
  assign S_AXI_rlast = s00_couplers_to_auto_us_df_RLAST;
  assign S_AXI_rresp[1:0] = s00_couplers_to_auto_us_df_RRESP;
  assign S_AXI_rvalid = s00_couplers_to_auto_us_df_RVALID;
  assign S_AXI_wready = s00_couplers_to_auto_us_df_WREADY;
  assign auto_us_df_to_s00_couplers_ARREADY = M_AXI_arready;
  assign auto_us_df_to_s00_couplers_AWREADY = M_AXI_awready;
  assign auto_us_df_to_s00_couplers_BRESP = M_AXI_bresp[1:0];
  assign auto_us_df_to_s00_couplers_BVALID = M_AXI_bvalid;
  assign auto_us_df_to_s00_couplers_RDATA = M_AXI_rdata[511:0];
  assign auto_us_df_to_s00_couplers_RLAST = M_AXI_rlast;
  assign auto_us_df_to_s00_couplers_RRESP = M_AXI_rresp[1:0];
  assign auto_us_df_to_s00_couplers_RVALID = M_AXI_rvalid;
  assign auto_us_df_to_s00_couplers_WREADY = M_AXI_wready;
  assign s00_couplers_to_auto_us_df_ARADDR = S_AXI_araddr[31:0];
  assign s00_couplers_to_auto_us_df_ARBURST = S_AXI_arburst[1:0];
  assign s00_couplers_to_auto_us_df_ARCACHE = S_AXI_arcache[3:0];
  assign s00_couplers_to_auto_us_df_ARLEN = S_AXI_arlen[7:0];
  assign s00_couplers_to_auto_us_df_ARLOCK = S_AXI_arlock[0];
  assign s00_couplers_to_auto_us_df_ARPROT = S_AXI_arprot[2:0];
  assign s00_couplers_to_auto_us_df_ARQOS = S_AXI_arqos[3:0];
  assign s00_couplers_to_auto_us_df_ARSIZE = S_AXI_arsize[2:0];
  assign s00_couplers_to_auto_us_df_ARVALID = S_AXI_arvalid;
  assign s00_couplers_to_auto_us_df_AWADDR = S_AXI_awaddr[31:0];
  assign s00_couplers_to_auto_us_df_AWBURST = S_AXI_awburst[1:0];
  assign s00_couplers_to_auto_us_df_AWCACHE = S_AXI_awcache[3:0];
  assign s00_couplers_to_auto_us_df_AWLEN = S_AXI_awlen[7:0];
  assign s00_couplers_to_auto_us_df_AWLOCK = S_AXI_awlock[0];
  assign s00_couplers_to_auto_us_df_AWPROT = S_AXI_awprot[2:0];
  assign s00_couplers_to_auto_us_df_AWQOS = S_AXI_awqos[3:0];
  assign s00_couplers_to_auto_us_df_AWSIZE = S_AXI_awsize[2:0];
  assign s00_couplers_to_auto_us_df_AWVALID = S_AXI_awvalid;
  assign s00_couplers_to_auto_us_df_BREADY = S_AXI_bready;
  assign s00_couplers_to_auto_us_df_RREADY = S_AXI_rready;
  assign s00_couplers_to_auto_us_df_WDATA = S_AXI_wdata[31:0];
  assign s00_couplers_to_auto_us_df_WLAST = S_AXI_wlast;
  assign s00_couplers_to_auto_us_df_WSTRB = S_AXI_wstrb[3:0];
  assign s00_couplers_to_auto_us_df_WVALID = S_AXI_wvalid;
  system_i_bak_auto_us_df_3 auto_us_df
       (.m_axi_araddr(auto_us_df_to_s00_couplers_ARADDR),
        .m_axi_arburst(auto_us_df_to_s00_couplers_ARBURST),
        .m_axi_arcache(auto_us_df_to_s00_couplers_ARCACHE),
        .m_axi_arlen(auto_us_df_to_s00_couplers_ARLEN),
        .m_axi_arlock(auto_us_df_to_s00_couplers_ARLOCK),
        .m_axi_arprot(auto_us_df_to_s00_couplers_ARPROT),
        .m_axi_arqos(auto_us_df_to_s00_couplers_ARQOS),
        .m_axi_arready(auto_us_df_to_s00_couplers_ARREADY),
        .m_axi_arsize(auto_us_df_to_s00_couplers_ARSIZE),
        .m_axi_arvalid(auto_us_df_to_s00_couplers_ARVALID),
        .m_axi_awaddr(auto_us_df_to_s00_couplers_AWADDR),
        .m_axi_awburst(auto_us_df_to_s00_couplers_AWBURST),
        .m_axi_awcache(auto_us_df_to_s00_couplers_AWCACHE),
        .m_axi_awlen(auto_us_df_to_s00_couplers_AWLEN),
        .m_axi_awlock(auto_us_df_to_s00_couplers_AWLOCK),
        .m_axi_awprot(auto_us_df_to_s00_couplers_AWPROT),
        .m_axi_awqos(auto_us_df_to_s00_couplers_AWQOS),
        .m_axi_awready(auto_us_df_to_s00_couplers_AWREADY),
        .m_axi_awsize(auto_us_df_to_s00_couplers_AWSIZE),
        .m_axi_awvalid(auto_us_df_to_s00_couplers_AWVALID),
        .m_axi_bready(auto_us_df_to_s00_couplers_BREADY),
        .m_axi_bresp(auto_us_df_to_s00_couplers_BRESP),
        .m_axi_bvalid(auto_us_df_to_s00_couplers_BVALID),
        .m_axi_rdata(auto_us_df_to_s00_couplers_RDATA),
        .m_axi_rlast(auto_us_df_to_s00_couplers_RLAST),
        .m_axi_rready(auto_us_df_to_s00_couplers_RREADY),
        .m_axi_rresp(auto_us_df_to_s00_couplers_RRESP),
        .m_axi_rvalid(auto_us_df_to_s00_couplers_RVALID),
        .m_axi_wdata(auto_us_df_to_s00_couplers_WDATA),
        .m_axi_wlast(auto_us_df_to_s00_couplers_WLAST),
        .m_axi_wready(auto_us_df_to_s00_couplers_WREADY),
        .m_axi_wstrb(auto_us_df_to_s00_couplers_WSTRB),
        .m_axi_wvalid(auto_us_df_to_s00_couplers_WVALID),
        .s_axi_aclk(S_ACLK_1),
        .s_axi_araddr(s00_couplers_to_auto_us_df_ARADDR),
        .s_axi_arburst(s00_couplers_to_auto_us_df_ARBURST),
        .s_axi_arcache(s00_couplers_to_auto_us_df_ARCACHE),
        .s_axi_aresetn(S_ARESETN_1),
        .s_axi_arlen(s00_couplers_to_auto_us_df_ARLEN),
        .s_axi_arlock(s00_couplers_to_auto_us_df_ARLOCK),
        .s_axi_arprot(s00_couplers_to_auto_us_df_ARPROT),
        .s_axi_arqos(s00_couplers_to_auto_us_df_ARQOS),
        .s_axi_arready(s00_couplers_to_auto_us_df_ARREADY),
        .s_axi_arregion({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arsize(s00_couplers_to_auto_us_df_ARSIZE),
        .s_axi_arvalid(s00_couplers_to_auto_us_df_ARVALID),
        .s_axi_awaddr(s00_couplers_to_auto_us_df_AWADDR),
        .s_axi_awburst(s00_couplers_to_auto_us_df_AWBURST),
        .s_axi_awcache(s00_couplers_to_auto_us_df_AWCACHE),
        .s_axi_awlen(s00_couplers_to_auto_us_df_AWLEN),
        .s_axi_awlock(s00_couplers_to_auto_us_df_AWLOCK),
        .s_axi_awprot(s00_couplers_to_auto_us_df_AWPROT),
        .s_axi_awqos(s00_couplers_to_auto_us_df_AWQOS),
        .s_axi_awready(s00_couplers_to_auto_us_df_AWREADY),
        .s_axi_awregion({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awsize(s00_couplers_to_auto_us_df_AWSIZE),
        .s_axi_awvalid(s00_couplers_to_auto_us_df_AWVALID),
        .s_axi_bready(s00_couplers_to_auto_us_df_BREADY),
        .s_axi_bresp(s00_couplers_to_auto_us_df_BRESP),
        .s_axi_bvalid(s00_couplers_to_auto_us_df_BVALID),
        .s_axi_rdata(s00_couplers_to_auto_us_df_RDATA),
        .s_axi_rlast(s00_couplers_to_auto_us_df_RLAST),
        .s_axi_rready(s00_couplers_to_auto_us_df_RREADY),
        .s_axi_rresp(s00_couplers_to_auto_us_df_RRESP),
        .s_axi_rvalid(s00_couplers_to_auto_us_df_RVALID),
        .s_axi_wdata(s00_couplers_to_auto_us_df_WDATA),
        .s_axi_wlast(s00_couplers_to_auto_us_df_WLAST),
        .s_axi_wready(s00_couplers_to_auto_us_df_WREADY),
        .s_axi_wstrb(s00_couplers_to_auto_us_df_WSTRB),
        .s_axi_wvalid(s00_couplers_to_auto_us_df_WVALID));
endmodule

module s00_couplers_imp_SWH3HH
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arburst,
    M_AXI_arcache,
    M_AXI_arlen,
    M_AXI_arlock,
    M_AXI_arprot,
    M_AXI_arqos,
    M_AXI_arready,
    M_AXI_arsize,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awburst,
    M_AXI_awcache,
    M_AXI_awlen,
    M_AXI_awlock,
    M_AXI_awprot,
    M_AXI_awqos,
    M_AXI_awready,
    M_AXI_awsize,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rlast,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wlast,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arprot,
    S_AXI_arready,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awprot,
    S_AXI_awready,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input [0:0]M_ARESETN;
  output [31:0]M_AXI_araddr;
  output [1:0]M_AXI_arburst;
  output [3:0]M_AXI_arcache;
  output [7:0]M_AXI_arlen;
  output [0:0]M_AXI_arlock;
  output [2:0]M_AXI_arprot;
  output [3:0]M_AXI_arqos;
  input M_AXI_arready;
  output [2:0]M_AXI_arsize;
  output M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  output [1:0]M_AXI_awburst;
  output [3:0]M_AXI_awcache;
  output [7:0]M_AXI_awlen;
  output [0:0]M_AXI_awlock;
  output [2:0]M_AXI_awprot;
  output [3:0]M_AXI_awqos;
  input M_AXI_awready;
  output [2:0]M_AXI_awsize;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [511:0]M_AXI_rdata;
  input M_AXI_rlast;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [511:0]M_AXI_wdata;
  output M_AXI_wlast;
  input M_AXI_wready;
  output [63:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input [0:0]S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [2:0]S_AXI_arprot;
  output S_AXI_arready;
  input S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  input [2:0]S_AXI_awprot;
  output S_AXI_awready;
  input S_AXI_awvalid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [31:0]S_AXI_rdata;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [31:0]S_AXI_wdata;
  output S_AXI_wready;
  input [3:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire M_ACLK_1;
  wire [0:0]M_ARESETN_1;
  wire S_ACLK_1;
  wire [0:0]S_ARESETN_1;
  wire [31:0]auto_pc_to_auto_us_ARADDR;
  wire [1:0]auto_pc_to_auto_us_ARBURST;
  wire [3:0]auto_pc_to_auto_us_ARCACHE;
  wire [7:0]auto_pc_to_auto_us_ARLEN;
  wire [0:0]auto_pc_to_auto_us_ARLOCK;
  wire [2:0]auto_pc_to_auto_us_ARPROT;
  wire [3:0]auto_pc_to_auto_us_ARQOS;
  wire auto_pc_to_auto_us_ARREADY;
  wire [3:0]auto_pc_to_auto_us_ARREGION;
  wire [2:0]auto_pc_to_auto_us_ARSIZE;
  wire auto_pc_to_auto_us_ARVALID;
  wire [31:0]auto_pc_to_auto_us_AWADDR;
  wire [1:0]auto_pc_to_auto_us_AWBURST;
  wire [3:0]auto_pc_to_auto_us_AWCACHE;
  wire [7:0]auto_pc_to_auto_us_AWLEN;
  wire [0:0]auto_pc_to_auto_us_AWLOCK;
  wire [2:0]auto_pc_to_auto_us_AWPROT;
  wire [3:0]auto_pc_to_auto_us_AWQOS;
  wire auto_pc_to_auto_us_AWREADY;
  wire [3:0]auto_pc_to_auto_us_AWREGION;
  wire [2:0]auto_pc_to_auto_us_AWSIZE;
  wire auto_pc_to_auto_us_AWVALID;
  wire auto_pc_to_auto_us_BREADY;
  wire [1:0]auto_pc_to_auto_us_BRESP;
  wire auto_pc_to_auto_us_BVALID;
  wire [31:0]auto_pc_to_auto_us_RDATA;
  wire auto_pc_to_auto_us_RLAST;
  wire auto_pc_to_auto_us_RREADY;
  wire [1:0]auto_pc_to_auto_us_RRESP;
  wire auto_pc_to_auto_us_RVALID;
  wire [31:0]auto_pc_to_auto_us_WDATA;
  wire auto_pc_to_auto_us_WLAST;
  wire auto_pc_to_auto_us_WREADY;
  wire [3:0]auto_pc_to_auto_us_WSTRB;
  wire auto_pc_to_auto_us_WVALID;
  wire [31:0]auto_us_to_s00_data_fifo_ARADDR;
  wire [1:0]auto_us_to_s00_data_fifo_ARBURST;
  wire [3:0]auto_us_to_s00_data_fifo_ARCACHE;
  wire [7:0]auto_us_to_s00_data_fifo_ARLEN;
  wire [0:0]auto_us_to_s00_data_fifo_ARLOCK;
  wire [2:0]auto_us_to_s00_data_fifo_ARPROT;
  wire [3:0]auto_us_to_s00_data_fifo_ARQOS;
  wire auto_us_to_s00_data_fifo_ARREADY;
  wire [3:0]auto_us_to_s00_data_fifo_ARREGION;
  wire [2:0]auto_us_to_s00_data_fifo_ARSIZE;
  wire auto_us_to_s00_data_fifo_ARVALID;
  wire [31:0]auto_us_to_s00_data_fifo_AWADDR;
  wire [1:0]auto_us_to_s00_data_fifo_AWBURST;
  wire [3:0]auto_us_to_s00_data_fifo_AWCACHE;
  wire [7:0]auto_us_to_s00_data_fifo_AWLEN;
  wire [0:0]auto_us_to_s00_data_fifo_AWLOCK;
  wire [2:0]auto_us_to_s00_data_fifo_AWPROT;
  wire [3:0]auto_us_to_s00_data_fifo_AWQOS;
  wire auto_us_to_s00_data_fifo_AWREADY;
  wire [3:0]auto_us_to_s00_data_fifo_AWREGION;
  wire [2:0]auto_us_to_s00_data_fifo_AWSIZE;
  wire auto_us_to_s00_data_fifo_AWVALID;
  wire auto_us_to_s00_data_fifo_BREADY;
  wire [1:0]auto_us_to_s00_data_fifo_BRESP;
  wire auto_us_to_s00_data_fifo_BVALID;
  wire [511:0]auto_us_to_s00_data_fifo_RDATA;
  wire auto_us_to_s00_data_fifo_RLAST;
  wire auto_us_to_s00_data_fifo_RREADY;
  wire [1:0]auto_us_to_s00_data_fifo_RRESP;
  wire auto_us_to_s00_data_fifo_RVALID;
  wire [511:0]auto_us_to_s00_data_fifo_WDATA;
  wire auto_us_to_s00_data_fifo_WLAST;
  wire auto_us_to_s00_data_fifo_WREADY;
  wire [63:0]auto_us_to_s00_data_fifo_WSTRB;
  wire auto_us_to_s00_data_fifo_WVALID;
  wire [31:0]s00_couplers_to_auto_pc_ARADDR;
  wire [2:0]s00_couplers_to_auto_pc_ARPROT;
  wire s00_couplers_to_auto_pc_ARREADY;
  wire s00_couplers_to_auto_pc_ARVALID;
  wire [31:0]s00_couplers_to_auto_pc_AWADDR;
  wire [2:0]s00_couplers_to_auto_pc_AWPROT;
  wire s00_couplers_to_auto_pc_AWREADY;
  wire s00_couplers_to_auto_pc_AWVALID;
  wire s00_couplers_to_auto_pc_BREADY;
  wire [1:0]s00_couplers_to_auto_pc_BRESP;
  wire s00_couplers_to_auto_pc_BVALID;
  wire [31:0]s00_couplers_to_auto_pc_RDATA;
  wire s00_couplers_to_auto_pc_RREADY;
  wire [1:0]s00_couplers_to_auto_pc_RRESP;
  wire s00_couplers_to_auto_pc_RVALID;
  wire [31:0]s00_couplers_to_auto_pc_WDATA;
  wire s00_couplers_to_auto_pc_WREADY;
  wire [3:0]s00_couplers_to_auto_pc_WSTRB;
  wire s00_couplers_to_auto_pc_WVALID;
  wire [31:0]s00_data_fifo_to_s00_couplers_ARADDR;
  wire [1:0]s00_data_fifo_to_s00_couplers_ARBURST;
  wire [3:0]s00_data_fifo_to_s00_couplers_ARCACHE;
  wire [7:0]s00_data_fifo_to_s00_couplers_ARLEN;
  wire [0:0]s00_data_fifo_to_s00_couplers_ARLOCK;
  wire [2:0]s00_data_fifo_to_s00_couplers_ARPROT;
  wire [3:0]s00_data_fifo_to_s00_couplers_ARQOS;
  wire s00_data_fifo_to_s00_couplers_ARREADY;
  wire [2:0]s00_data_fifo_to_s00_couplers_ARSIZE;
  wire s00_data_fifo_to_s00_couplers_ARVALID;
  wire [31:0]s00_data_fifo_to_s00_couplers_AWADDR;
  wire [1:0]s00_data_fifo_to_s00_couplers_AWBURST;
  wire [3:0]s00_data_fifo_to_s00_couplers_AWCACHE;
  wire [7:0]s00_data_fifo_to_s00_couplers_AWLEN;
  wire [0:0]s00_data_fifo_to_s00_couplers_AWLOCK;
  wire [2:0]s00_data_fifo_to_s00_couplers_AWPROT;
  wire [3:0]s00_data_fifo_to_s00_couplers_AWQOS;
  wire s00_data_fifo_to_s00_couplers_AWREADY;
  wire [2:0]s00_data_fifo_to_s00_couplers_AWSIZE;
  wire s00_data_fifo_to_s00_couplers_AWVALID;
  wire s00_data_fifo_to_s00_couplers_BREADY;
  wire [1:0]s00_data_fifo_to_s00_couplers_BRESP;
  wire s00_data_fifo_to_s00_couplers_BVALID;
  wire [511:0]s00_data_fifo_to_s00_couplers_RDATA;
  wire s00_data_fifo_to_s00_couplers_RLAST;
  wire s00_data_fifo_to_s00_couplers_RREADY;
  wire [1:0]s00_data_fifo_to_s00_couplers_RRESP;
  wire s00_data_fifo_to_s00_couplers_RVALID;
  wire [511:0]s00_data_fifo_to_s00_couplers_WDATA;
  wire s00_data_fifo_to_s00_couplers_WLAST;
  wire s00_data_fifo_to_s00_couplers_WREADY;
  wire [63:0]s00_data_fifo_to_s00_couplers_WSTRB;
  wire s00_data_fifo_to_s00_couplers_WVALID;

  assign M_ACLK_1 = M_ACLK;
  assign M_ARESETN_1 = M_ARESETN[0];
  assign M_AXI_araddr[31:0] = s00_data_fifo_to_s00_couplers_ARADDR;
  assign M_AXI_arburst[1:0] = s00_data_fifo_to_s00_couplers_ARBURST;
  assign M_AXI_arcache[3:0] = s00_data_fifo_to_s00_couplers_ARCACHE;
  assign M_AXI_arlen[7:0] = s00_data_fifo_to_s00_couplers_ARLEN;
  assign M_AXI_arlock[0] = s00_data_fifo_to_s00_couplers_ARLOCK;
  assign M_AXI_arprot[2:0] = s00_data_fifo_to_s00_couplers_ARPROT;
  assign M_AXI_arqos[3:0] = s00_data_fifo_to_s00_couplers_ARQOS;
  assign M_AXI_arsize[2:0] = s00_data_fifo_to_s00_couplers_ARSIZE;
  assign M_AXI_arvalid = s00_data_fifo_to_s00_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = s00_data_fifo_to_s00_couplers_AWADDR;
  assign M_AXI_awburst[1:0] = s00_data_fifo_to_s00_couplers_AWBURST;
  assign M_AXI_awcache[3:0] = s00_data_fifo_to_s00_couplers_AWCACHE;
  assign M_AXI_awlen[7:0] = s00_data_fifo_to_s00_couplers_AWLEN;
  assign M_AXI_awlock[0] = s00_data_fifo_to_s00_couplers_AWLOCK;
  assign M_AXI_awprot[2:0] = s00_data_fifo_to_s00_couplers_AWPROT;
  assign M_AXI_awqos[3:0] = s00_data_fifo_to_s00_couplers_AWQOS;
  assign M_AXI_awsize[2:0] = s00_data_fifo_to_s00_couplers_AWSIZE;
  assign M_AXI_awvalid = s00_data_fifo_to_s00_couplers_AWVALID;
  assign M_AXI_bready = s00_data_fifo_to_s00_couplers_BREADY;
  assign M_AXI_rready = s00_data_fifo_to_s00_couplers_RREADY;
  assign M_AXI_wdata[511:0] = s00_data_fifo_to_s00_couplers_WDATA;
  assign M_AXI_wlast = s00_data_fifo_to_s00_couplers_WLAST;
  assign M_AXI_wstrb[63:0] = s00_data_fifo_to_s00_couplers_WSTRB;
  assign M_AXI_wvalid = s00_data_fifo_to_s00_couplers_WVALID;
  assign S_ACLK_1 = S_ACLK;
  assign S_ARESETN_1 = S_ARESETN[0];
  assign S_AXI_arready = s00_couplers_to_auto_pc_ARREADY;
  assign S_AXI_awready = s00_couplers_to_auto_pc_AWREADY;
  assign S_AXI_bresp[1:0] = s00_couplers_to_auto_pc_BRESP;
  assign S_AXI_bvalid = s00_couplers_to_auto_pc_BVALID;
  assign S_AXI_rdata[31:0] = s00_couplers_to_auto_pc_RDATA;
  assign S_AXI_rresp[1:0] = s00_couplers_to_auto_pc_RRESP;
  assign S_AXI_rvalid = s00_couplers_to_auto_pc_RVALID;
  assign S_AXI_wready = s00_couplers_to_auto_pc_WREADY;
  assign s00_couplers_to_auto_pc_ARADDR = S_AXI_araddr[31:0];
  assign s00_couplers_to_auto_pc_ARPROT = S_AXI_arprot[2:0];
  assign s00_couplers_to_auto_pc_ARVALID = S_AXI_arvalid;
  assign s00_couplers_to_auto_pc_AWADDR = S_AXI_awaddr[31:0];
  assign s00_couplers_to_auto_pc_AWPROT = S_AXI_awprot[2:0];
  assign s00_couplers_to_auto_pc_AWVALID = S_AXI_awvalid;
  assign s00_couplers_to_auto_pc_BREADY = S_AXI_bready;
  assign s00_couplers_to_auto_pc_RREADY = S_AXI_rready;
  assign s00_couplers_to_auto_pc_WDATA = S_AXI_wdata[31:0];
  assign s00_couplers_to_auto_pc_WSTRB = S_AXI_wstrb[3:0];
  assign s00_couplers_to_auto_pc_WVALID = S_AXI_wvalid;
  assign s00_data_fifo_to_s00_couplers_ARREADY = M_AXI_arready;
  assign s00_data_fifo_to_s00_couplers_AWREADY = M_AXI_awready;
  assign s00_data_fifo_to_s00_couplers_BRESP = M_AXI_bresp[1:0];
  assign s00_data_fifo_to_s00_couplers_BVALID = M_AXI_bvalid;
  assign s00_data_fifo_to_s00_couplers_RDATA = M_AXI_rdata[511:0];
  assign s00_data_fifo_to_s00_couplers_RLAST = M_AXI_rlast;
  assign s00_data_fifo_to_s00_couplers_RRESP = M_AXI_rresp[1:0];
  assign s00_data_fifo_to_s00_couplers_RVALID = M_AXI_rvalid;
  assign s00_data_fifo_to_s00_couplers_WREADY = M_AXI_wready;
  system_i_bak_auto_pc_12 auto_pc
       (.aclk(S_ACLK_1),
        .aresetn(S_ARESETN_1),
        .m_axi_araddr(auto_pc_to_auto_us_ARADDR),
        .m_axi_arburst(auto_pc_to_auto_us_ARBURST),
        .m_axi_arcache(auto_pc_to_auto_us_ARCACHE),
        .m_axi_arlen(auto_pc_to_auto_us_ARLEN),
        .m_axi_arlock(auto_pc_to_auto_us_ARLOCK),
        .m_axi_arprot(auto_pc_to_auto_us_ARPROT),
        .m_axi_arqos(auto_pc_to_auto_us_ARQOS),
        .m_axi_arready(auto_pc_to_auto_us_ARREADY),
        .m_axi_arregion(auto_pc_to_auto_us_ARREGION),
        .m_axi_arsize(auto_pc_to_auto_us_ARSIZE),
        .m_axi_arvalid(auto_pc_to_auto_us_ARVALID),
        .m_axi_awaddr(auto_pc_to_auto_us_AWADDR),
        .m_axi_awburst(auto_pc_to_auto_us_AWBURST),
        .m_axi_awcache(auto_pc_to_auto_us_AWCACHE),
        .m_axi_awlen(auto_pc_to_auto_us_AWLEN),
        .m_axi_awlock(auto_pc_to_auto_us_AWLOCK),
        .m_axi_awprot(auto_pc_to_auto_us_AWPROT),
        .m_axi_awqos(auto_pc_to_auto_us_AWQOS),
        .m_axi_awready(auto_pc_to_auto_us_AWREADY),
        .m_axi_awregion(auto_pc_to_auto_us_AWREGION),
        .m_axi_awsize(auto_pc_to_auto_us_AWSIZE),
        .m_axi_awvalid(auto_pc_to_auto_us_AWVALID),
        .m_axi_bready(auto_pc_to_auto_us_BREADY),
        .m_axi_bresp(auto_pc_to_auto_us_BRESP),
        .m_axi_bvalid(auto_pc_to_auto_us_BVALID),
        .m_axi_rdata(auto_pc_to_auto_us_RDATA),
        .m_axi_rlast(auto_pc_to_auto_us_RLAST),
        .m_axi_rready(auto_pc_to_auto_us_RREADY),
        .m_axi_rresp(auto_pc_to_auto_us_RRESP),
        .m_axi_rvalid(auto_pc_to_auto_us_RVALID),
        .m_axi_wdata(auto_pc_to_auto_us_WDATA),
        .m_axi_wlast(auto_pc_to_auto_us_WLAST),
        .m_axi_wready(auto_pc_to_auto_us_WREADY),
        .m_axi_wstrb(auto_pc_to_auto_us_WSTRB),
        .m_axi_wvalid(auto_pc_to_auto_us_WVALID),
        .s_axi_araddr(s00_couplers_to_auto_pc_ARADDR),
        .s_axi_arprot(s00_couplers_to_auto_pc_ARPROT),
        .s_axi_arready(s00_couplers_to_auto_pc_ARREADY),
        .s_axi_arvalid(s00_couplers_to_auto_pc_ARVALID),
        .s_axi_awaddr(s00_couplers_to_auto_pc_AWADDR),
        .s_axi_awprot(s00_couplers_to_auto_pc_AWPROT),
        .s_axi_awready(s00_couplers_to_auto_pc_AWREADY),
        .s_axi_awvalid(s00_couplers_to_auto_pc_AWVALID),
        .s_axi_bready(s00_couplers_to_auto_pc_BREADY),
        .s_axi_bresp(s00_couplers_to_auto_pc_BRESP),
        .s_axi_bvalid(s00_couplers_to_auto_pc_BVALID),
        .s_axi_rdata(s00_couplers_to_auto_pc_RDATA),
        .s_axi_rready(s00_couplers_to_auto_pc_RREADY),
        .s_axi_rresp(s00_couplers_to_auto_pc_RRESP),
        .s_axi_rvalid(s00_couplers_to_auto_pc_RVALID),
        .s_axi_wdata(s00_couplers_to_auto_pc_WDATA),
        .s_axi_wready(s00_couplers_to_auto_pc_WREADY),
        .s_axi_wstrb(s00_couplers_to_auto_pc_WSTRB),
        .s_axi_wvalid(s00_couplers_to_auto_pc_WVALID));
  system_i_bak_auto_us_0 auto_us
       (.m_axi_araddr(auto_us_to_s00_data_fifo_ARADDR),
        .m_axi_arburst(auto_us_to_s00_data_fifo_ARBURST),
        .m_axi_arcache(auto_us_to_s00_data_fifo_ARCACHE),
        .m_axi_arlen(auto_us_to_s00_data_fifo_ARLEN),
        .m_axi_arlock(auto_us_to_s00_data_fifo_ARLOCK),
        .m_axi_arprot(auto_us_to_s00_data_fifo_ARPROT),
        .m_axi_arqos(auto_us_to_s00_data_fifo_ARQOS),
        .m_axi_arready(auto_us_to_s00_data_fifo_ARREADY),
        .m_axi_arregion(auto_us_to_s00_data_fifo_ARREGION),
        .m_axi_arsize(auto_us_to_s00_data_fifo_ARSIZE),
        .m_axi_arvalid(auto_us_to_s00_data_fifo_ARVALID),
        .m_axi_awaddr(auto_us_to_s00_data_fifo_AWADDR),
        .m_axi_awburst(auto_us_to_s00_data_fifo_AWBURST),
        .m_axi_awcache(auto_us_to_s00_data_fifo_AWCACHE),
        .m_axi_awlen(auto_us_to_s00_data_fifo_AWLEN),
        .m_axi_awlock(auto_us_to_s00_data_fifo_AWLOCK),
        .m_axi_awprot(auto_us_to_s00_data_fifo_AWPROT),
        .m_axi_awqos(auto_us_to_s00_data_fifo_AWQOS),
        .m_axi_awready(auto_us_to_s00_data_fifo_AWREADY),
        .m_axi_awregion(auto_us_to_s00_data_fifo_AWREGION),
        .m_axi_awsize(auto_us_to_s00_data_fifo_AWSIZE),
        .m_axi_awvalid(auto_us_to_s00_data_fifo_AWVALID),
        .m_axi_bready(auto_us_to_s00_data_fifo_BREADY),
        .m_axi_bresp(auto_us_to_s00_data_fifo_BRESP),
        .m_axi_bvalid(auto_us_to_s00_data_fifo_BVALID),
        .m_axi_rdata(auto_us_to_s00_data_fifo_RDATA),
        .m_axi_rlast(auto_us_to_s00_data_fifo_RLAST),
        .m_axi_rready(auto_us_to_s00_data_fifo_RREADY),
        .m_axi_rresp(auto_us_to_s00_data_fifo_RRESP),
        .m_axi_rvalid(auto_us_to_s00_data_fifo_RVALID),
        .m_axi_wdata(auto_us_to_s00_data_fifo_WDATA),
        .m_axi_wlast(auto_us_to_s00_data_fifo_WLAST),
        .m_axi_wready(auto_us_to_s00_data_fifo_WREADY),
        .m_axi_wstrb(auto_us_to_s00_data_fifo_WSTRB),
        .m_axi_wvalid(auto_us_to_s00_data_fifo_WVALID),
        .s_axi_aclk(S_ACLK_1),
        .s_axi_araddr(auto_pc_to_auto_us_ARADDR),
        .s_axi_arburst(auto_pc_to_auto_us_ARBURST),
        .s_axi_arcache(auto_pc_to_auto_us_ARCACHE),
        .s_axi_aresetn(S_ARESETN_1),
        .s_axi_arlen(auto_pc_to_auto_us_ARLEN),
        .s_axi_arlock(auto_pc_to_auto_us_ARLOCK),
        .s_axi_arprot(auto_pc_to_auto_us_ARPROT),
        .s_axi_arqos(auto_pc_to_auto_us_ARQOS),
        .s_axi_arready(auto_pc_to_auto_us_ARREADY),
        .s_axi_arregion(auto_pc_to_auto_us_ARREGION),
        .s_axi_arsize(auto_pc_to_auto_us_ARSIZE),
        .s_axi_arvalid(auto_pc_to_auto_us_ARVALID),
        .s_axi_awaddr(auto_pc_to_auto_us_AWADDR),
        .s_axi_awburst(auto_pc_to_auto_us_AWBURST),
        .s_axi_awcache(auto_pc_to_auto_us_AWCACHE),
        .s_axi_awlen(auto_pc_to_auto_us_AWLEN),
        .s_axi_awlock(auto_pc_to_auto_us_AWLOCK),
        .s_axi_awprot(auto_pc_to_auto_us_AWPROT),
        .s_axi_awqos(auto_pc_to_auto_us_AWQOS),
        .s_axi_awready(auto_pc_to_auto_us_AWREADY),
        .s_axi_awregion(auto_pc_to_auto_us_AWREGION),
        .s_axi_awsize(auto_pc_to_auto_us_AWSIZE),
        .s_axi_awvalid(auto_pc_to_auto_us_AWVALID),
        .s_axi_bready(auto_pc_to_auto_us_BREADY),
        .s_axi_bresp(auto_pc_to_auto_us_BRESP),
        .s_axi_bvalid(auto_pc_to_auto_us_BVALID),
        .s_axi_rdata(auto_pc_to_auto_us_RDATA),
        .s_axi_rlast(auto_pc_to_auto_us_RLAST),
        .s_axi_rready(auto_pc_to_auto_us_RREADY),
        .s_axi_rresp(auto_pc_to_auto_us_RRESP),
        .s_axi_rvalid(auto_pc_to_auto_us_RVALID),
        .s_axi_wdata(auto_pc_to_auto_us_WDATA),
        .s_axi_wlast(auto_pc_to_auto_us_WLAST),
        .s_axi_wready(auto_pc_to_auto_us_WREADY),
        .s_axi_wstrb(auto_pc_to_auto_us_WSTRB),
        .s_axi_wvalid(auto_pc_to_auto_us_WVALID));
  system_i_bak_s00_data_fifo_0 s00_data_fifo
       (.aclk(M_ACLK_1),
        .aresetn(M_ARESETN_1),
        .m_axi_araddr(s00_data_fifo_to_s00_couplers_ARADDR),
        .m_axi_arburst(s00_data_fifo_to_s00_couplers_ARBURST),
        .m_axi_arcache(s00_data_fifo_to_s00_couplers_ARCACHE),
        .m_axi_arlen(s00_data_fifo_to_s00_couplers_ARLEN),
        .m_axi_arlock(s00_data_fifo_to_s00_couplers_ARLOCK),
        .m_axi_arprot(s00_data_fifo_to_s00_couplers_ARPROT),
        .m_axi_arqos(s00_data_fifo_to_s00_couplers_ARQOS),
        .m_axi_arready(s00_data_fifo_to_s00_couplers_ARREADY),
        .m_axi_arsize(s00_data_fifo_to_s00_couplers_ARSIZE),
        .m_axi_arvalid(s00_data_fifo_to_s00_couplers_ARVALID),
        .m_axi_awaddr(s00_data_fifo_to_s00_couplers_AWADDR),
        .m_axi_awburst(s00_data_fifo_to_s00_couplers_AWBURST),
        .m_axi_awcache(s00_data_fifo_to_s00_couplers_AWCACHE),
        .m_axi_awlen(s00_data_fifo_to_s00_couplers_AWLEN),
        .m_axi_awlock(s00_data_fifo_to_s00_couplers_AWLOCK),
        .m_axi_awprot(s00_data_fifo_to_s00_couplers_AWPROT),
        .m_axi_awqos(s00_data_fifo_to_s00_couplers_AWQOS),
        .m_axi_awready(s00_data_fifo_to_s00_couplers_AWREADY),
        .m_axi_awsize(s00_data_fifo_to_s00_couplers_AWSIZE),
        .m_axi_awvalid(s00_data_fifo_to_s00_couplers_AWVALID),
        .m_axi_bready(s00_data_fifo_to_s00_couplers_BREADY),
        .m_axi_bresp(s00_data_fifo_to_s00_couplers_BRESP),
        .m_axi_bvalid(s00_data_fifo_to_s00_couplers_BVALID),
        .m_axi_rdata(s00_data_fifo_to_s00_couplers_RDATA),
        .m_axi_rlast(s00_data_fifo_to_s00_couplers_RLAST),
        .m_axi_rready(s00_data_fifo_to_s00_couplers_RREADY),
        .m_axi_rresp(s00_data_fifo_to_s00_couplers_RRESP),
        .m_axi_rvalid(s00_data_fifo_to_s00_couplers_RVALID),
        .m_axi_wdata(s00_data_fifo_to_s00_couplers_WDATA),
        .m_axi_wlast(s00_data_fifo_to_s00_couplers_WLAST),
        .m_axi_wready(s00_data_fifo_to_s00_couplers_WREADY),
        .m_axi_wstrb(s00_data_fifo_to_s00_couplers_WSTRB),
        .m_axi_wvalid(s00_data_fifo_to_s00_couplers_WVALID),
        .s_axi_araddr(auto_us_to_s00_data_fifo_ARADDR),
        .s_axi_arburst(auto_us_to_s00_data_fifo_ARBURST),
        .s_axi_arcache(auto_us_to_s00_data_fifo_ARCACHE),
        .s_axi_arlen(auto_us_to_s00_data_fifo_ARLEN),
        .s_axi_arlock(auto_us_to_s00_data_fifo_ARLOCK),
        .s_axi_arprot(auto_us_to_s00_data_fifo_ARPROT),
        .s_axi_arqos(auto_us_to_s00_data_fifo_ARQOS),
        .s_axi_arready(auto_us_to_s00_data_fifo_ARREADY),
        .s_axi_arregion(auto_us_to_s00_data_fifo_ARREGION),
        .s_axi_arsize(auto_us_to_s00_data_fifo_ARSIZE),
        .s_axi_arvalid(auto_us_to_s00_data_fifo_ARVALID),
        .s_axi_awaddr(auto_us_to_s00_data_fifo_AWADDR),
        .s_axi_awburst(auto_us_to_s00_data_fifo_AWBURST),
        .s_axi_awcache(auto_us_to_s00_data_fifo_AWCACHE),
        .s_axi_awlen(auto_us_to_s00_data_fifo_AWLEN),
        .s_axi_awlock(auto_us_to_s00_data_fifo_AWLOCK),
        .s_axi_awprot(auto_us_to_s00_data_fifo_AWPROT),
        .s_axi_awqos(auto_us_to_s00_data_fifo_AWQOS),
        .s_axi_awready(auto_us_to_s00_data_fifo_AWREADY),
        .s_axi_awregion(auto_us_to_s00_data_fifo_AWREGION),
        .s_axi_awsize(auto_us_to_s00_data_fifo_AWSIZE),
        .s_axi_awvalid(auto_us_to_s00_data_fifo_AWVALID),
        .s_axi_bready(auto_us_to_s00_data_fifo_BREADY),
        .s_axi_bresp(auto_us_to_s00_data_fifo_BRESP),
        .s_axi_bvalid(auto_us_to_s00_data_fifo_BVALID),
        .s_axi_rdata(auto_us_to_s00_data_fifo_RDATA),
        .s_axi_rlast(auto_us_to_s00_data_fifo_RLAST),
        .s_axi_rready(auto_us_to_s00_data_fifo_RREADY),
        .s_axi_rresp(auto_us_to_s00_data_fifo_RRESP),
        .s_axi_rvalid(auto_us_to_s00_data_fifo_RVALID),
        .s_axi_wdata(auto_us_to_s00_data_fifo_WDATA),
        .s_axi_wlast(auto_us_to_s00_data_fifo_WLAST),
        .s_axi_wready(auto_us_to_s00_data_fifo_WREADY),
        .s_axi_wstrb(auto_us_to_s00_data_fifo_WSTRB),
        .s_axi_wvalid(auto_us_to_s00_data_fifo_WVALID));
endmodule

module s01_couplers_imp_3W09SW
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arburst,
    M_AXI_arcache,
    M_AXI_arlen,
    M_AXI_arlock,
    M_AXI_arprot,
    M_AXI_arqos,
    M_AXI_arready,
    M_AXI_arsize,
    M_AXI_arvalid,
    M_AXI_rdata,
    M_AXI_rlast,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arburst,
    S_AXI_arcache,
    S_AXI_arlen,
    S_AXI_arlock,
    S_AXI_arprot,
    S_AXI_arqos,
    S_AXI_arready,
    S_AXI_arsize,
    S_AXI_arvalid,
    S_AXI_rdata,
    S_AXI_rlast,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid);
  input M_ACLK;
  input [0:0]M_ARESETN;
  output [31:0]M_AXI_araddr;
  output [1:0]M_AXI_arburst;
  output [3:0]M_AXI_arcache;
  output [7:0]M_AXI_arlen;
  output [0:0]M_AXI_arlock;
  output [2:0]M_AXI_arprot;
  output [3:0]M_AXI_arqos;
  input M_AXI_arready;
  output [2:0]M_AXI_arsize;
  output M_AXI_arvalid;
  input [511:0]M_AXI_rdata;
  input M_AXI_rlast;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  input S_ACLK;
  input [0:0]S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [1:0]S_AXI_arburst;
  input [3:0]S_AXI_arcache;
  input [7:0]S_AXI_arlen;
  input [0:0]S_AXI_arlock;
  input [2:0]S_AXI_arprot;
  input [3:0]S_AXI_arqos;
  output S_AXI_arready;
  input [2:0]S_AXI_arsize;
  input S_AXI_arvalid;
  output [31:0]S_AXI_rdata;
  output S_AXI_rlast;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;

  wire M_ACLK_1;
  wire [0:0]M_ARESETN_1;
  wire S_ACLK_1;
  wire [0:0]S_ARESETN_1;
  wire [31:0]auto_us_df_to_s01_couplers_ARADDR;
  wire [1:0]auto_us_df_to_s01_couplers_ARBURST;
  wire [3:0]auto_us_df_to_s01_couplers_ARCACHE;
  wire [7:0]auto_us_df_to_s01_couplers_ARLEN;
  wire [0:0]auto_us_df_to_s01_couplers_ARLOCK;
  wire [2:0]auto_us_df_to_s01_couplers_ARPROT;
  wire [3:0]auto_us_df_to_s01_couplers_ARQOS;
  wire auto_us_df_to_s01_couplers_ARREADY;
  wire [2:0]auto_us_df_to_s01_couplers_ARSIZE;
  wire auto_us_df_to_s01_couplers_ARVALID;
  wire [511:0]auto_us_df_to_s01_couplers_RDATA;
  wire auto_us_df_to_s01_couplers_RLAST;
  wire auto_us_df_to_s01_couplers_RREADY;
  wire [1:0]auto_us_df_to_s01_couplers_RRESP;
  wire auto_us_df_to_s01_couplers_RVALID;
  wire [31:0]s01_couplers_to_auto_us_df_ARADDR;
  wire [1:0]s01_couplers_to_auto_us_df_ARBURST;
  wire [3:0]s01_couplers_to_auto_us_df_ARCACHE;
  wire [7:0]s01_couplers_to_auto_us_df_ARLEN;
  wire [0:0]s01_couplers_to_auto_us_df_ARLOCK;
  wire [2:0]s01_couplers_to_auto_us_df_ARPROT;
  wire [3:0]s01_couplers_to_auto_us_df_ARQOS;
  wire s01_couplers_to_auto_us_df_ARREADY;
  wire [2:0]s01_couplers_to_auto_us_df_ARSIZE;
  wire s01_couplers_to_auto_us_df_ARVALID;
  wire [31:0]s01_couplers_to_auto_us_df_RDATA;
  wire s01_couplers_to_auto_us_df_RLAST;
  wire s01_couplers_to_auto_us_df_RREADY;
  wire [1:0]s01_couplers_to_auto_us_df_RRESP;
  wire s01_couplers_to_auto_us_df_RVALID;

  assign M_ACLK_1 = M_ACLK;
  assign M_ARESETN_1 = M_ARESETN[0];
  assign M_AXI_araddr[31:0] = auto_us_df_to_s01_couplers_ARADDR;
  assign M_AXI_arburst[1:0] = auto_us_df_to_s01_couplers_ARBURST;
  assign M_AXI_arcache[3:0] = auto_us_df_to_s01_couplers_ARCACHE;
  assign M_AXI_arlen[7:0] = auto_us_df_to_s01_couplers_ARLEN;
  assign M_AXI_arlock[0] = auto_us_df_to_s01_couplers_ARLOCK;
  assign M_AXI_arprot[2:0] = auto_us_df_to_s01_couplers_ARPROT;
  assign M_AXI_arqos[3:0] = auto_us_df_to_s01_couplers_ARQOS;
  assign M_AXI_arsize[2:0] = auto_us_df_to_s01_couplers_ARSIZE;
  assign M_AXI_arvalid = auto_us_df_to_s01_couplers_ARVALID;
  assign M_AXI_rready = auto_us_df_to_s01_couplers_RREADY;
  assign S_ACLK_1 = S_ACLK;
  assign S_ARESETN_1 = S_ARESETN[0];
  assign S_AXI_arready = s01_couplers_to_auto_us_df_ARREADY;
  assign S_AXI_rdata[31:0] = s01_couplers_to_auto_us_df_RDATA;
  assign S_AXI_rlast = s01_couplers_to_auto_us_df_RLAST;
  assign S_AXI_rresp[1:0] = s01_couplers_to_auto_us_df_RRESP;
  assign S_AXI_rvalid = s01_couplers_to_auto_us_df_RVALID;
  assign auto_us_df_to_s01_couplers_ARREADY = M_AXI_arready;
  assign auto_us_df_to_s01_couplers_RDATA = M_AXI_rdata[511:0];
  assign auto_us_df_to_s01_couplers_RLAST = M_AXI_rlast;
  assign auto_us_df_to_s01_couplers_RRESP = M_AXI_rresp[1:0];
  assign auto_us_df_to_s01_couplers_RVALID = M_AXI_rvalid;
  assign s01_couplers_to_auto_us_df_ARADDR = S_AXI_araddr[31:0];
  assign s01_couplers_to_auto_us_df_ARBURST = S_AXI_arburst[1:0];
  assign s01_couplers_to_auto_us_df_ARCACHE = S_AXI_arcache[3:0];
  assign s01_couplers_to_auto_us_df_ARLEN = S_AXI_arlen[7:0];
  assign s01_couplers_to_auto_us_df_ARLOCK = S_AXI_arlock[0];
  assign s01_couplers_to_auto_us_df_ARPROT = S_AXI_arprot[2:0];
  assign s01_couplers_to_auto_us_df_ARQOS = S_AXI_arqos[3:0];
  assign s01_couplers_to_auto_us_df_ARSIZE = S_AXI_arsize[2:0];
  assign s01_couplers_to_auto_us_df_ARVALID = S_AXI_arvalid;
  assign s01_couplers_to_auto_us_df_RREADY = S_AXI_rready;
  system_i_bak_auto_us_df_4 auto_us_df
       (.m_axi_araddr(auto_us_df_to_s01_couplers_ARADDR),
        .m_axi_arburst(auto_us_df_to_s01_couplers_ARBURST),
        .m_axi_arcache(auto_us_df_to_s01_couplers_ARCACHE),
        .m_axi_arlen(auto_us_df_to_s01_couplers_ARLEN),
        .m_axi_arlock(auto_us_df_to_s01_couplers_ARLOCK),
        .m_axi_arprot(auto_us_df_to_s01_couplers_ARPROT),
        .m_axi_arqos(auto_us_df_to_s01_couplers_ARQOS),
        .m_axi_arready(auto_us_df_to_s01_couplers_ARREADY),
        .m_axi_arsize(auto_us_df_to_s01_couplers_ARSIZE),
        .m_axi_arvalid(auto_us_df_to_s01_couplers_ARVALID),
        .m_axi_rdata(auto_us_df_to_s01_couplers_RDATA),
        .m_axi_rlast(auto_us_df_to_s01_couplers_RLAST),
        .m_axi_rready(auto_us_df_to_s01_couplers_RREADY),
        .m_axi_rresp(auto_us_df_to_s01_couplers_RRESP),
        .m_axi_rvalid(auto_us_df_to_s01_couplers_RVALID),
        .s_axi_aclk(S_ACLK_1),
        .s_axi_araddr(s01_couplers_to_auto_us_df_ARADDR),
        .s_axi_arburst(s01_couplers_to_auto_us_df_ARBURST),
        .s_axi_arcache(s01_couplers_to_auto_us_df_ARCACHE),
        .s_axi_aresetn(S_ARESETN_1),
        .s_axi_arlen(s01_couplers_to_auto_us_df_ARLEN),
        .s_axi_arlock(s01_couplers_to_auto_us_df_ARLOCK),
        .s_axi_arprot(s01_couplers_to_auto_us_df_ARPROT),
        .s_axi_arqos(s01_couplers_to_auto_us_df_ARQOS),
        .s_axi_arready(s01_couplers_to_auto_us_df_ARREADY),
        .s_axi_arregion({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arsize(s01_couplers_to_auto_us_df_ARSIZE),
        .s_axi_arvalid(s01_couplers_to_auto_us_df_ARVALID),
        .s_axi_rdata(s01_couplers_to_auto_us_df_RDATA),
        .s_axi_rlast(s01_couplers_to_auto_us_df_RLAST),
        .s_axi_rready(s01_couplers_to_auto_us_df_RREADY),
        .s_axi_rresp(s01_couplers_to_auto_us_df_RRESP),
        .s_axi_rvalid(s01_couplers_to_auto_us_df_RVALID));
endmodule

module s01_couplers_imp_Z8NRJ9
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arburst,
    M_AXI_arcache,
    M_AXI_arlen,
    M_AXI_arlock,
    M_AXI_arprot,
    M_AXI_arqos,
    M_AXI_arready,
    M_AXI_arsize,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awburst,
    M_AXI_awcache,
    M_AXI_awlen,
    M_AXI_awlock,
    M_AXI_awprot,
    M_AXI_awqos,
    M_AXI_awready,
    M_AXI_awsize,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rlast,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wlast,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arburst,
    S_AXI_arcache,
    S_AXI_arlen,
    S_AXI_arprot,
    S_AXI_arready,
    S_AXI_arsize,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awburst,
    S_AXI_awcache,
    S_AXI_awlen,
    S_AXI_awprot,
    S_AXI_awready,
    S_AXI_awsize,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rlast,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wlast,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input [0:0]M_ARESETN;
  output [31:0]M_AXI_araddr;
  output [1:0]M_AXI_arburst;
  output [3:0]M_AXI_arcache;
  output [7:0]M_AXI_arlen;
  output [0:0]M_AXI_arlock;
  output [2:0]M_AXI_arprot;
  output [3:0]M_AXI_arqos;
  input M_AXI_arready;
  output [2:0]M_AXI_arsize;
  output M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  output [1:0]M_AXI_awburst;
  output [3:0]M_AXI_awcache;
  output [7:0]M_AXI_awlen;
  output [0:0]M_AXI_awlock;
  output [2:0]M_AXI_awprot;
  output [3:0]M_AXI_awqos;
  input M_AXI_awready;
  output [2:0]M_AXI_awsize;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [511:0]M_AXI_rdata;
  input M_AXI_rlast;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [511:0]M_AXI_wdata;
  output M_AXI_wlast;
  input M_AXI_wready;
  output [63:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input [0:0]S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [1:0]S_AXI_arburst;
  input [3:0]S_AXI_arcache;
  input [7:0]S_AXI_arlen;
  input [2:0]S_AXI_arprot;
  output S_AXI_arready;
  input [2:0]S_AXI_arsize;
  input S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  input [1:0]S_AXI_awburst;
  input [3:0]S_AXI_awcache;
  input [7:0]S_AXI_awlen;
  input [2:0]S_AXI_awprot;
  output S_AXI_awready;
  input [2:0]S_AXI_awsize;
  input S_AXI_awvalid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [31:0]S_AXI_rdata;
  output S_AXI_rlast;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [31:0]S_AXI_wdata;
  input S_AXI_wlast;
  output S_AXI_wready;
  input [3:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire M_ACLK_1;
  wire [0:0]M_ARESETN_1;
  wire S_ACLK_1;
  wire [0:0]S_ARESETN_1;
  wire [31:0]auto_us_to_s01_data_fifo_ARADDR;
  wire [1:0]auto_us_to_s01_data_fifo_ARBURST;
  wire [3:0]auto_us_to_s01_data_fifo_ARCACHE;
  wire [7:0]auto_us_to_s01_data_fifo_ARLEN;
  wire [0:0]auto_us_to_s01_data_fifo_ARLOCK;
  wire [2:0]auto_us_to_s01_data_fifo_ARPROT;
  wire [3:0]auto_us_to_s01_data_fifo_ARQOS;
  wire auto_us_to_s01_data_fifo_ARREADY;
  wire [3:0]auto_us_to_s01_data_fifo_ARREGION;
  wire [2:0]auto_us_to_s01_data_fifo_ARSIZE;
  wire auto_us_to_s01_data_fifo_ARVALID;
  wire [31:0]auto_us_to_s01_data_fifo_AWADDR;
  wire [1:0]auto_us_to_s01_data_fifo_AWBURST;
  wire [3:0]auto_us_to_s01_data_fifo_AWCACHE;
  wire [7:0]auto_us_to_s01_data_fifo_AWLEN;
  wire [0:0]auto_us_to_s01_data_fifo_AWLOCK;
  wire [2:0]auto_us_to_s01_data_fifo_AWPROT;
  wire [3:0]auto_us_to_s01_data_fifo_AWQOS;
  wire auto_us_to_s01_data_fifo_AWREADY;
  wire [3:0]auto_us_to_s01_data_fifo_AWREGION;
  wire [2:0]auto_us_to_s01_data_fifo_AWSIZE;
  wire auto_us_to_s01_data_fifo_AWVALID;
  wire auto_us_to_s01_data_fifo_BREADY;
  wire [1:0]auto_us_to_s01_data_fifo_BRESP;
  wire auto_us_to_s01_data_fifo_BVALID;
  wire [511:0]auto_us_to_s01_data_fifo_RDATA;
  wire auto_us_to_s01_data_fifo_RLAST;
  wire auto_us_to_s01_data_fifo_RREADY;
  wire [1:0]auto_us_to_s01_data_fifo_RRESP;
  wire auto_us_to_s01_data_fifo_RVALID;
  wire [511:0]auto_us_to_s01_data_fifo_WDATA;
  wire auto_us_to_s01_data_fifo_WLAST;
  wire auto_us_to_s01_data_fifo_WREADY;
  wire [63:0]auto_us_to_s01_data_fifo_WSTRB;
  wire auto_us_to_s01_data_fifo_WVALID;
  wire [31:0]s01_couplers_to_auto_us_ARADDR;
  wire [1:0]s01_couplers_to_auto_us_ARBURST;
  wire [3:0]s01_couplers_to_auto_us_ARCACHE;
  wire [7:0]s01_couplers_to_auto_us_ARLEN;
  wire [2:0]s01_couplers_to_auto_us_ARPROT;
  wire s01_couplers_to_auto_us_ARREADY;
  wire [2:0]s01_couplers_to_auto_us_ARSIZE;
  wire s01_couplers_to_auto_us_ARVALID;
  wire [31:0]s01_couplers_to_auto_us_AWADDR;
  wire [1:0]s01_couplers_to_auto_us_AWBURST;
  wire [3:0]s01_couplers_to_auto_us_AWCACHE;
  wire [7:0]s01_couplers_to_auto_us_AWLEN;
  wire [2:0]s01_couplers_to_auto_us_AWPROT;
  wire s01_couplers_to_auto_us_AWREADY;
  wire [2:0]s01_couplers_to_auto_us_AWSIZE;
  wire s01_couplers_to_auto_us_AWVALID;
  wire s01_couplers_to_auto_us_BREADY;
  wire [1:0]s01_couplers_to_auto_us_BRESP;
  wire s01_couplers_to_auto_us_BVALID;
  wire [31:0]s01_couplers_to_auto_us_RDATA;
  wire s01_couplers_to_auto_us_RLAST;
  wire s01_couplers_to_auto_us_RREADY;
  wire [1:0]s01_couplers_to_auto_us_RRESP;
  wire s01_couplers_to_auto_us_RVALID;
  wire [31:0]s01_couplers_to_auto_us_WDATA;
  wire s01_couplers_to_auto_us_WLAST;
  wire s01_couplers_to_auto_us_WREADY;
  wire [3:0]s01_couplers_to_auto_us_WSTRB;
  wire s01_couplers_to_auto_us_WVALID;
  wire [31:0]s01_data_fifo_to_s01_couplers_ARADDR;
  wire [1:0]s01_data_fifo_to_s01_couplers_ARBURST;
  wire [3:0]s01_data_fifo_to_s01_couplers_ARCACHE;
  wire [7:0]s01_data_fifo_to_s01_couplers_ARLEN;
  wire [0:0]s01_data_fifo_to_s01_couplers_ARLOCK;
  wire [2:0]s01_data_fifo_to_s01_couplers_ARPROT;
  wire [3:0]s01_data_fifo_to_s01_couplers_ARQOS;
  wire s01_data_fifo_to_s01_couplers_ARREADY;
  wire [2:0]s01_data_fifo_to_s01_couplers_ARSIZE;
  wire s01_data_fifo_to_s01_couplers_ARVALID;
  wire [31:0]s01_data_fifo_to_s01_couplers_AWADDR;
  wire [1:0]s01_data_fifo_to_s01_couplers_AWBURST;
  wire [3:0]s01_data_fifo_to_s01_couplers_AWCACHE;
  wire [7:0]s01_data_fifo_to_s01_couplers_AWLEN;
  wire [0:0]s01_data_fifo_to_s01_couplers_AWLOCK;
  wire [2:0]s01_data_fifo_to_s01_couplers_AWPROT;
  wire [3:0]s01_data_fifo_to_s01_couplers_AWQOS;
  wire s01_data_fifo_to_s01_couplers_AWREADY;
  wire [2:0]s01_data_fifo_to_s01_couplers_AWSIZE;
  wire s01_data_fifo_to_s01_couplers_AWVALID;
  wire s01_data_fifo_to_s01_couplers_BREADY;
  wire [1:0]s01_data_fifo_to_s01_couplers_BRESP;
  wire s01_data_fifo_to_s01_couplers_BVALID;
  wire [511:0]s01_data_fifo_to_s01_couplers_RDATA;
  wire s01_data_fifo_to_s01_couplers_RLAST;
  wire s01_data_fifo_to_s01_couplers_RREADY;
  wire [1:0]s01_data_fifo_to_s01_couplers_RRESP;
  wire s01_data_fifo_to_s01_couplers_RVALID;
  wire [511:0]s01_data_fifo_to_s01_couplers_WDATA;
  wire s01_data_fifo_to_s01_couplers_WLAST;
  wire s01_data_fifo_to_s01_couplers_WREADY;
  wire [63:0]s01_data_fifo_to_s01_couplers_WSTRB;
  wire s01_data_fifo_to_s01_couplers_WVALID;

  assign M_ACLK_1 = M_ACLK;
  assign M_ARESETN_1 = M_ARESETN[0];
  assign M_AXI_araddr[31:0] = s01_data_fifo_to_s01_couplers_ARADDR;
  assign M_AXI_arburst[1:0] = s01_data_fifo_to_s01_couplers_ARBURST;
  assign M_AXI_arcache[3:0] = s01_data_fifo_to_s01_couplers_ARCACHE;
  assign M_AXI_arlen[7:0] = s01_data_fifo_to_s01_couplers_ARLEN;
  assign M_AXI_arlock[0] = s01_data_fifo_to_s01_couplers_ARLOCK;
  assign M_AXI_arprot[2:0] = s01_data_fifo_to_s01_couplers_ARPROT;
  assign M_AXI_arqos[3:0] = s01_data_fifo_to_s01_couplers_ARQOS;
  assign M_AXI_arsize[2:0] = s01_data_fifo_to_s01_couplers_ARSIZE;
  assign M_AXI_arvalid = s01_data_fifo_to_s01_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = s01_data_fifo_to_s01_couplers_AWADDR;
  assign M_AXI_awburst[1:0] = s01_data_fifo_to_s01_couplers_AWBURST;
  assign M_AXI_awcache[3:0] = s01_data_fifo_to_s01_couplers_AWCACHE;
  assign M_AXI_awlen[7:0] = s01_data_fifo_to_s01_couplers_AWLEN;
  assign M_AXI_awlock[0] = s01_data_fifo_to_s01_couplers_AWLOCK;
  assign M_AXI_awprot[2:0] = s01_data_fifo_to_s01_couplers_AWPROT;
  assign M_AXI_awqos[3:0] = s01_data_fifo_to_s01_couplers_AWQOS;
  assign M_AXI_awsize[2:0] = s01_data_fifo_to_s01_couplers_AWSIZE;
  assign M_AXI_awvalid = s01_data_fifo_to_s01_couplers_AWVALID;
  assign M_AXI_bready = s01_data_fifo_to_s01_couplers_BREADY;
  assign M_AXI_rready = s01_data_fifo_to_s01_couplers_RREADY;
  assign M_AXI_wdata[511:0] = s01_data_fifo_to_s01_couplers_WDATA;
  assign M_AXI_wlast = s01_data_fifo_to_s01_couplers_WLAST;
  assign M_AXI_wstrb[63:0] = s01_data_fifo_to_s01_couplers_WSTRB;
  assign M_AXI_wvalid = s01_data_fifo_to_s01_couplers_WVALID;
  assign S_ACLK_1 = S_ACLK;
  assign S_ARESETN_1 = S_ARESETN[0];
  assign S_AXI_arready = s01_couplers_to_auto_us_ARREADY;
  assign S_AXI_awready = s01_couplers_to_auto_us_AWREADY;
  assign S_AXI_bresp[1:0] = s01_couplers_to_auto_us_BRESP;
  assign S_AXI_bvalid = s01_couplers_to_auto_us_BVALID;
  assign S_AXI_rdata[31:0] = s01_couplers_to_auto_us_RDATA;
  assign S_AXI_rlast = s01_couplers_to_auto_us_RLAST;
  assign S_AXI_rresp[1:0] = s01_couplers_to_auto_us_RRESP;
  assign S_AXI_rvalid = s01_couplers_to_auto_us_RVALID;
  assign S_AXI_wready = s01_couplers_to_auto_us_WREADY;
  assign s01_couplers_to_auto_us_ARADDR = S_AXI_araddr[31:0];
  assign s01_couplers_to_auto_us_ARBURST = S_AXI_arburst[1:0];
  assign s01_couplers_to_auto_us_ARCACHE = S_AXI_arcache[3:0];
  assign s01_couplers_to_auto_us_ARLEN = S_AXI_arlen[7:0];
  assign s01_couplers_to_auto_us_ARPROT = S_AXI_arprot[2:0];
  assign s01_couplers_to_auto_us_ARSIZE = S_AXI_arsize[2:0];
  assign s01_couplers_to_auto_us_ARVALID = S_AXI_arvalid;
  assign s01_couplers_to_auto_us_AWADDR = S_AXI_awaddr[31:0];
  assign s01_couplers_to_auto_us_AWBURST = S_AXI_awburst[1:0];
  assign s01_couplers_to_auto_us_AWCACHE = S_AXI_awcache[3:0];
  assign s01_couplers_to_auto_us_AWLEN = S_AXI_awlen[7:0];
  assign s01_couplers_to_auto_us_AWPROT = S_AXI_awprot[2:0];
  assign s01_couplers_to_auto_us_AWSIZE = S_AXI_awsize[2:0];
  assign s01_couplers_to_auto_us_AWVALID = S_AXI_awvalid;
  assign s01_couplers_to_auto_us_BREADY = S_AXI_bready;
  assign s01_couplers_to_auto_us_RREADY = S_AXI_rready;
  assign s01_couplers_to_auto_us_WDATA = S_AXI_wdata[31:0];
  assign s01_couplers_to_auto_us_WLAST = S_AXI_wlast;
  assign s01_couplers_to_auto_us_WSTRB = S_AXI_wstrb[3:0];
  assign s01_couplers_to_auto_us_WVALID = S_AXI_wvalid;
  assign s01_data_fifo_to_s01_couplers_ARREADY = M_AXI_arready;
  assign s01_data_fifo_to_s01_couplers_AWREADY = M_AXI_awready;
  assign s01_data_fifo_to_s01_couplers_BRESP = M_AXI_bresp[1:0];
  assign s01_data_fifo_to_s01_couplers_BVALID = M_AXI_bvalid;
  assign s01_data_fifo_to_s01_couplers_RDATA = M_AXI_rdata[511:0];
  assign s01_data_fifo_to_s01_couplers_RLAST = M_AXI_rlast;
  assign s01_data_fifo_to_s01_couplers_RRESP = M_AXI_rresp[1:0];
  assign s01_data_fifo_to_s01_couplers_RVALID = M_AXI_rvalid;
  assign s01_data_fifo_to_s01_couplers_WREADY = M_AXI_wready;
  system_i_bak_auto_us_1 auto_us
       (.m_axi_araddr(auto_us_to_s01_data_fifo_ARADDR),
        .m_axi_arburst(auto_us_to_s01_data_fifo_ARBURST),
        .m_axi_arcache(auto_us_to_s01_data_fifo_ARCACHE),
        .m_axi_arlen(auto_us_to_s01_data_fifo_ARLEN),
        .m_axi_arlock(auto_us_to_s01_data_fifo_ARLOCK),
        .m_axi_arprot(auto_us_to_s01_data_fifo_ARPROT),
        .m_axi_arqos(auto_us_to_s01_data_fifo_ARQOS),
        .m_axi_arready(auto_us_to_s01_data_fifo_ARREADY),
        .m_axi_arregion(auto_us_to_s01_data_fifo_ARREGION),
        .m_axi_arsize(auto_us_to_s01_data_fifo_ARSIZE),
        .m_axi_arvalid(auto_us_to_s01_data_fifo_ARVALID),
        .m_axi_awaddr(auto_us_to_s01_data_fifo_AWADDR),
        .m_axi_awburst(auto_us_to_s01_data_fifo_AWBURST),
        .m_axi_awcache(auto_us_to_s01_data_fifo_AWCACHE),
        .m_axi_awlen(auto_us_to_s01_data_fifo_AWLEN),
        .m_axi_awlock(auto_us_to_s01_data_fifo_AWLOCK),
        .m_axi_awprot(auto_us_to_s01_data_fifo_AWPROT),
        .m_axi_awqos(auto_us_to_s01_data_fifo_AWQOS),
        .m_axi_awready(auto_us_to_s01_data_fifo_AWREADY),
        .m_axi_awregion(auto_us_to_s01_data_fifo_AWREGION),
        .m_axi_awsize(auto_us_to_s01_data_fifo_AWSIZE),
        .m_axi_awvalid(auto_us_to_s01_data_fifo_AWVALID),
        .m_axi_bready(auto_us_to_s01_data_fifo_BREADY),
        .m_axi_bresp(auto_us_to_s01_data_fifo_BRESP),
        .m_axi_bvalid(auto_us_to_s01_data_fifo_BVALID),
        .m_axi_rdata(auto_us_to_s01_data_fifo_RDATA),
        .m_axi_rlast(auto_us_to_s01_data_fifo_RLAST),
        .m_axi_rready(auto_us_to_s01_data_fifo_RREADY),
        .m_axi_rresp(auto_us_to_s01_data_fifo_RRESP),
        .m_axi_rvalid(auto_us_to_s01_data_fifo_RVALID),
        .m_axi_wdata(auto_us_to_s01_data_fifo_WDATA),
        .m_axi_wlast(auto_us_to_s01_data_fifo_WLAST),
        .m_axi_wready(auto_us_to_s01_data_fifo_WREADY),
        .m_axi_wstrb(auto_us_to_s01_data_fifo_WSTRB),
        .m_axi_wvalid(auto_us_to_s01_data_fifo_WVALID),
        .s_axi_aclk(S_ACLK_1),
        .s_axi_araddr(s01_couplers_to_auto_us_ARADDR),
        .s_axi_arburst(s01_couplers_to_auto_us_ARBURST),
        .s_axi_arcache(s01_couplers_to_auto_us_ARCACHE),
        .s_axi_aresetn(S_ARESETN_1),
        .s_axi_arlen(s01_couplers_to_auto_us_ARLEN),
        .s_axi_arlock(1'b0),
        .s_axi_arprot(s01_couplers_to_auto_us_ARPROT),
        .s_axi_arqos({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(s01_couplers_to_auto_us_ARREADY),
        .s_axi_arregion({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arsize(s01_couplers_to_auto_us_ARSIZE),
        .s_axi_arvalid(s01_couplers_to_auto_us_ARVALID),
        .s_axi_awaddr(s01_couplers_to_auto_us_AWADDR),
        .s_axi_awburst(s01_couplers_to_auto_us_AWBURST),
        .s_axi_awcache(s01_couplers_to_auto_us_AWCACHE),
        .s_axi_awlen(s01_couplers_to_auto_us_AWLEN),
        .s_axi_awlock(1'b0),
        .s_axi_awprot(s01_couplers_to_auto_us_AWPROT),
        .s_axi_awqos({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(s01_couplers_to_auto_us_AWREADY),
        .s_axi_awregion({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awsize(s01_couplers_to_auto_us_AWSIZE),
        .s_axi_awvalid(s01_couplers_to_auto_us_AWVALID),
        .s_axi_bready(s01_couplers_to_auto_us_BREADY),
        .s_axi_bresp(s01_couplers_to_auto_us_BRESP),
        .s_axi_bvalid(s01_couplers_to_auto_us_BVALID),
        .s_axi_rdata(s01_couplers_to_auto_us_RDATA),
        .s_axi_rlast(s01_couplers_to_auto_us_RLAST),
        .s_axi_rready(s01_couplers_to_auto_us_RREADY),
        .s_axi_rresp(s01_couplers_to_auto_us_RRESP),
        .s_axi_rvalid(s01_couplers_to_auto_us_RVALID),
        .s_axi_wdata(s01_couplers_to_auto_us_WDATA),
        .s_axi_wlast(s01_couplers_to_auto_us_WLAST),
        .s_axi_wready(s01_couplers_to_auto_us_WREADY),
        .s_axi_wstrb(s01_couplers_to_auto_us_WSTRB),
        .s_axi_wvalid(s01_couplers_to_auto_us_WVALID));
  system_i_bak_s01_data_fifo_0 s01_data_fifo
       (.aclk(M_ACLK_1),
        .aresetn(M_ARESETN_1),
        .m_axi_araddr(s01_data_fifo_to_s01_couplers_ARADDR),
        .m_axi_arburst(s01_data_fifo_to_s01_couplers_ARBURST),
        .m_axi_arcache(s01_data_fifo_to_s01_couplers_ARCACHE),
        .m_axi_arlen(s01_data_fifo_to_s01_couplers_ARLEN),
        .m_axi_arlock(s01_data_fifo_to_s01_couplers_ARLOCK),
        .m_axi_arprot(s01_data_fifo_to_s01_couplers_ARPROT),
        .m_axi_arqos(s01_data_fifo_to_s01_couplers_ARQOS),
        .m_axi_arready(s01_data_fifo_to_s01_couplers_ARREADY),
        .m_axi_arsize(s01_data_fifo_to_s01_couplers_ARSIZE),
        .m_axi_arvalid(s01_data_fifo_to_s01_couplers_ARVALID),
        .m_axi_awaddr(s01_data_fifo_to_s01_couplers_AWADDR),
        .m_axi_awburst(s01_data_fifo_to_s01_couplers_AWBURST),
        .m_axi_awcache(s01_data_fifo_to_s01_couplers_AWCACHE),
        .m_axi_awlen(s01_data_fifo_to_s01_couplers_AWLEN),
        .m_axi_awlock(s01_data_fifo_to_s01_couplers_AWLOCK),
        .m_axi_awprot(s01_data_fifo_to_s01_couplers_AWPROT),
        .m_axi_awqos(s01_data_fifo_to_s01_couplers_AWQOS),
        .m_axi_awready(s01_data_fifo_to_s01_couplers_AWREADY),
        .m_axi_awsize(s01_data_fifo_to_s01_couplers_AWSIZE),
        .m_axi_awvalid(s01_data_fifo_to_s01_couplers_AWVALID),
        .m_axi_bready(s01_data_fifo_to_s01_couplers_BREADY),
        .m_axi_bresp(s01_data_fifo_to_s01_couplers_BRESP),
        .m_axi_bvalid(s01_data_fifo_to_s01_couplers_BVALID),
        .m_axi_rdata(s01_data_fifo_to_s01_couplers_RDATA),
        .m_axi_rlast(s01_data_fifo_to_s01_couplers_RLAST),
        .m_axi_rready(s01_data_fifo_to_s01_couplers_RREADY),
        .m_axi_rresp(s01_data_fifo_to_s01_couplers_RRESP),
        .m_axi_rvalid(s01_data_fifo_to_s01_couplers_RVALID),
        .m_axi_wdata(s01_data_fifo_to_s01_couplers_WDATA),
        .m_axi_wlast(s01_data_fifo_to_s01_couplers_WLAST),
        .m_axi_wready(s01_data_fifo_to_s01_couplers_WREADY),
        .m_axi_wstrb(s01_data_fifo_to_s01_couplers_WSTRB),
        .m_axi_wvalid(s01_data_fifo_to_s01_couplers_WVALID),
        .s_axi_araddr(auto_us_to_s01_data_fifo_ARADDR),
        .s_axi_arburst(auto_us_to_s01_data_fifo_ARBURST),
        .s_axi_arcache(auto_us_to_s01_data_fifo_ARCACHE),
        .s_axi_arlen(auto_us_to_s01_data_fifo_ARLEN),
        .s_axi_arlock(auto_us_to_s01_data_fifo_ARLOCK),
        .s_axi_arprot(auto_us_to_s01_data_fifo_ARPROT),
        .s_axi_arqos(auto_us_to_s01_data_fifo_ARQOS),
        .s_axi_arready(auto_us_to_s01_data_fifo_ARREADY),
        .s_axi_arregion(auto_us_to_s01_data_fifo_ARREGION),
        .s_axi_arsize(auto_us_to_s01_data_fifo_ARSIZE),
        .s_axi_arvalid(auto_us_to_s01_data_fifo_ARVALID),
        .s_axi_awaddr(auto_us_to_s01_data_fifo_AWADDR),
        .s_axi_awburst(auto_us_to_s01_data_fifo_AWBURST),
        .s_axi_awcache(auto_us_to_s01_data_fifo_AWCACHE),
        .s_axi_awlen(auto_us_to_s01_data_fifo_AWLEN),
        .s_axi_awlock(auto_us_to_s01_data_fifo_AWLOCK),
        .s_axi_awprot(auto_us_to_s01_data_fifo_AWPROT),
        .s_axi_awqos(auto_us_to_s01_data_fifo_AWQOS),
        .s_axi_awready(auto_us_to_s01_data_fifo_AWREADY),
        .s_axi_awregion(auto_us_to_s01_data_fifo_AWREGION),
        .s_axi_awsize(auto_us_to_s01_data_fifo_AWSIZE),
        .s_axi_awvalid(auto_us_to_s01_data_fifo_AWVALID),
        .s_axi_bready(auto_us_to_s01_data_fifo_BREADY),
        .s_axi_bresp(auto_us_to_s01_data_fifo_BRESP),
        .s_axi_bvalid(auto_us_to_s01_data_fifo_BVALID),
        .s_axi_rdata(auto_us_to_s01_data_fifo_RDATA),
        .s_axi_rlast(auto_us_to_s01_data_fifo_RLAST),
        .s_axi_rready(auto_us_to_s01_data_fifo_RREADY),
        .s_axi_rresp(auto_us_to_s01_data_fifo_RRESP),
        .s_axi_rvalid(auto_us_to_s01_data_fifo_RVALID),
        .s_axi_wdata(auto_us_to_s01_data_fifo_WDATA),
        .s_axi_wlast(auto_us_to_s01_data_fifo_WLAST),
        .s_axi_wready(auto_us_to_s01_data_fifo_WREADY),
        .s_axi_wstrb(auto_us_to_s01_data_fifo_WSTRB),
        .s_axi_wvalid(auto_us_to_s01_data_fifo_WVALID));
endmodule

module s02_couplers_imp_FE8N34
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arburst,
    M_AXI_arcache,
    M_AXI_arlen,
    M_AXI_arlock,
    M_AXI_arprot,
    M_AXI_arqos,
    M_AXI_arready,
    M_AXI_arsize,
    M_AXI_arvalid,
    M_AXI_rdata,
    M_AXI_rlast,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arburst,
    S_AXI_arcache,
    S_AXI_arlen,
    S_AXI_arprot,
    S_AXI_arready,
    S_AXI_arsize,
    S_AXI_arvalid,
    S_AXI_rdata,
    S_AXI_rlast,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid);
  input M_ACLK;
  input [0:0]M_ARESETN;
  output [31:0]M_AXI_araddr;
  output [1:0]M_AXI_arburst;
  output [3:0]M_AXI_arcache;
  output [7:0]M_AXI_arlen;
  output [0:0]M_AXI_arlock;
  output [2:0]M_AXI_arprot;
  output [3:0]M_AXI_arqos;
  input M_AXI_arready;
  output [2:0]M_AXI_arsize;
  output M_AXI_arvalid;
  input [511:0]M_AXI_rdata;
  input M_AXI_rlast;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  input S_ACLK;
  input [0:0]S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [1:0]S_AXI_arburst;
  input [3:0]S_AXI_arcache;
  input [7:0]S_AXI_arlen;
  input [2:0]S_AXI_arprot;
  output S_AXI_arready;
  input [2:0]S_AXI_arsize;
  input S_AXI_arvalid;
  output [63:0]S_AXI_rdata;
  output S_AXI_rlast;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;

  wire M_ACLK_1;
  wire [0:0]M_ARESETN_1;
  wire S_ACLK_1;
  wire [0:0]S_ARESETN_1;
  wire [31:0]auto_us_df_to_s02_couplers_ARADDR;
  wire [1:0]auto_us_df_to_s02_couplers_ARBURST;
  wire [3:0]auto_us_df_to_s02_couplers_ARCACHE;
  wire [7:0]auto_us_df_to_s02_couplers_ARLEN;
  wire [0:0]auto_us_df_to_s02_couplers_ARLOCK;
  wire [2:0]auto_us_df_to_s02_couplers_ARPROT;
  wire [3:0]auto_us_df_to_s02_couplers_ARQOS;
  wire auto_us_df_to_s02_couplers_ARREADY;
  wire [2:0]auto_us_df_to_s02_couplers_ARSIZE;
  wire auto_us_df_to_s02_couplers_ARVALID;
  wire [511:0]auto_us_df_to_s02_couplers_RDATA;
  wire auto_us_df_to_s02_couplers_RLAST;
  wire auto_us_df_to_s02_couplers_RREADY;
  wire [1:0]auto_us_df_to_s02_couplers_RRESP;
  wire auto_us_df_to_s02_couplers_RVALID;
  wire [31:0]s02_couplers_to_auto_us_df_ARADDR;
  wire [1:0]s02_couplers_to_auto_us_df_ARBURST;
  wire [3:0]s02_couplers_to_auto_us_df_ARCACHE;
  wire [7:0]s02_couplers_to_auto_us_df_ARLEN;
  wire [2:0]s02_couplers_to_auto_us_df_ARPROT;
  wire s02_couplers_to_auto_us_df_ARREADY;
  wire [2:0]s02_couplers_to_auto_us_df_ARSIZE;
  wire s02_couplers_to_auto_us_df_ARVALID;
  wire [63:0]s02_couplers_to_auto_us_df_RDATA;
  wire s02_couplers_to_auto_us_df_RLAST;
  wire s02_couplers_to_auto_us_df_RREADY;
  wire [1:0]s02_couplers_to_auto_us_df_RRESP;
  wire s02_couplers_to_auto_us_df_RVALID;

  assign M_ACLK_1 = M_ACLK;
  assign M_ARESETN_1 = M_ARESETN[0];
  assign M_AXI_araddr[31:0] = auto_us_df_to_s02_couplers_ARADDR;
  assign M_AXI_arburst[1:0] = auto_us_df_to_s02_couplers_ARBURST;
  assign M_AXI_arcache[3:0] = auto_us_df_to_s02_couplers_ARCACHE;
  assign M_AXI_arlen[7:0] = auto_us_df_to_s02_couplers_ARLEN;
  assign M_AXI_arlock[0] = auto_us_df_to_s02_couplers_ARLOCK;
  assign M_AXI_arprot[2:0] = auto_us_df_to_s02_couplers_ARPROT;
  assign M_AXI_arqos[3:0] = auto_us_df_to_s02_couplers_ARQOS;
  assign M_AXI_arsize[2:0] = auto_us_df_to_s02_couplers_ARSIZE;
  assign M_AXI_arvalid = auto_us_df_to_s02_couplers_ARVALID;
  assign M_AXI_rready = auto_us_df_to_s02_couplers_RREADY;
  assign S_ACLK_1 = S_ACLK;
  assign S_ARESETN_1 = S_ARESETN[0];
  assign S_AXI_arready = s02_couplers_to_auto_us_df_ARREADY;
  assign S_AXI_rdata[63:0] = s02_couplers_to_auto_us_df_RDATA;
  assign S_AXI_rlast = s02_couplers_to_auto_us_df_RLAST;
  assign S_AXI_rresp[1:0] = s02_couplers_to_auto_us_df_RRESP;
  assign S_AXI_rvalid = s02_couplers_to_auto_us_df_RVALID;
  assign auto_us_df_to_s02_couplers_ARREADY = M_AXI_arready;
  assign auto_us_df_to_s02_couplers_RDATA = M_AXI_rdata[511:0];
  assign auto_us_df_to_s02_couplers_RLAST = M_AXI_rlast;
  assign auto_us_df_to_s02_couplers_RRESP = M_AXI_rresp[1:0];
  assign auto_us_df_to_s02_couplers_RVALID = M_AXI_rvalid;
  assign s02_couplers_to_auto_us_df_ARADDR = S_AXI_araddr[31:0];
  assign s02_couplers_to_auto_us_df_ARBURST = S_AXI_arburst[1:0];
  assign s02_couplers_to_auto_us_df_ARCACHE = S_AXI_arcache[3:0];
  assign s02_couplers_to_auto_us_df_ARLEN = S_AXI_arlen[7:0];
  assign s02_couplers_to_auto_us_df_ARPROT = S_AXI_arprot[2:0];
  assign s02_couplers_to_auto_us_df_ARSIZE = S_AXI_arsize[2:0];
  assign s02_couplers_to_auto_us_df_ARVALID = S_AXI_arvalid;
  assign s02_couplers_to_auto_us_df_RREADY = S_AXI_rready;
  system_i_bak_auto_us_df_5 auto_us_df
       (.m_axi_araddr(auto_us_df_to_s02_couplers_ARADDR),
        .m_axi_arburst(auto_us_df_to_s02_couplers_ARBURST),
        .m_axi_arcache(auto_us_df_to_s02_couplers_ARCACHE),
        .m_axi_arlen(auto_us_df_to_s02_couplers_ARLEN),
        .m_axi_arlock(auto_us_df_to_s02_couplers_ARLOCK),
        .m_axi_arprot(auto_us_df_to_s02_couplers_ARPROT),
        .m_axi_arqos(auto_us_df_to_s02_couplers_ARQOS),
        .m_axi_arready(auto_us_df_to_s02_couplers_ARREADY),
        .m_axi_arsize(auto_us_df_to_s02_couplers_ARSIZE),
        .m_axi_arvalid(auto_us_df_to_s02_couplers_ARVALID),
        .m_axi_rdata(auto_us_df_to_s02_couplers_RDATA),
        .m_axi_rlast(auto_us_df_to_s02_couplers_RLAST),
        .m_axi_rready(auto_us_df_to_s02_couplers_RREADY),
        .m_axi_rresp(auto_us_df_to_s02_couplers_RRESP),
        .m_axi_rvalid(auto_us_df_to_s02_couplers_RVALID),
        .s_axi_aclk(S_ACLK_1),
        .s_axi_araddr(s02_couplers_to_auto_us_df_ARADDR),
        .s_axi_arburst(s02_couplers_to_auto_us_df_ARBURST),
        .s_axi_arcache(s02_couplers_to_auto_us_df_ARCACHE),
        .s_axi_aresetn(S_ARESETN_1),
        .s_axi_arlen(s02_couplers_to_auto_us_df_ARLEN),
        .s_axi_arlock(1'b0),
        .s_axi_arprot(s02_couplers_to_auto_us_df_ARPROT),
        .s_axi_arqos({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(s02_couplers_to_auto_us_df_ARREADY),
        .s_axi_arregion({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arsize(s02_couplers_to_auto_us_df_ARSIZE),
        .s_axi_arvalid(s02_couplers_to_auto_us_df_ARVALID),
        .s_axi_rdata(s02_couplers_to_auto_us_df_RDATA),
        .s_axi_rlast(s02_couplers_to_auto_us_df_RLAST),
        .s_axi_rready(s02_couplers_to_auto_us_df_RREADY),
        .s_axi_rresp(s02_couplers_to_auto_us_df_RRESP),
        .s_axi_rvalid(s02_couplers_to_auto_us_df_RVALID));
endmodule

module s02_couplers_imp_JK09YD
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arburst,
    M_AXI_arcache,
    M_AXI_arlen,
    M_AXI_arlock,
    M_AXI_arprot,
    M_AXI_arqos,
    M_AXI_arready,
    M_AXI_arsize,
    M_AXI_arvalid,
    M_AXI_rdata,
    M_AXI_rlast,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arburst,
    S_AXI_arcache,
    S_AXI_arlen,
    S_AXI_arprot,
    S_AXI_arready,
    S_AXI_arsize,
    S_AXI_arvalid,
    S_AXI_rdata,
    S_AXI_rlast,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid);
  input M_ACLK;
  input [0:0]M_ARESETN;
  output [31:0]M_AXI_araddr;
  output [1:0]M_AXI_arburst;
  output [3:0]M_AXI_arcache;
  output [7:0]M_AXI_arlen;
  output [0:0]M_AXI_arlock;
  output [2:0]M_AXI_arprot;
  output [3:0]M_AXI_arqos;
  input M_AXI_arready;
  output [2:0]M_AXI_arsize;
  output M_AXI_arvalid;
  input [511:0]M_AXI_rdata;
  input M_AXI_rlast;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  input S_ACLK;
  input [0:0]S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [1:0]S_AXI_arburst;
  input [3:0]S_AXI_arcache;
  input [7:0]S_AXI_arlen;
  input [2:0]S_AXI_arprot;
  output S_AXI_arready;
  input [2:0]S_AXI_arsize;
  input S_AXI_arvalid;
  output [31:0]S_AXI_rdata;
  output S_AXI_rlast;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;

  wire M_ACLK_1;
  wire [0:0]M_ARESETN_1;
  wire S_ACLK_1;
  wire [0:0]S_ARESETN_1;
  wire [31:0]auto_us_to_s02_data_fifo_ARADDR;
  wire [1:0]auto_us_to_s02_data_fifo_ARBURST;
  wire [3:0]auto_us_to_s02_data_fifo_ARCACHE;
  wire [7:0]auto_us_to_s02_data_fifo_ARLEN;
  wire [0:0]auto_us_to_s02_data_fifo_ARLOCK;
  wire [2:0]auto_us_to_s02_data_fifo_ARPROT;
  wire [3:0]auto_us_to_s02_data_fifo_ARQOS;
  wire auto_us_to_s02_data_fifo_ARREADY;
  wire [3:0]auto_us_to_s02_data_fifo_ARREGION;
  wire [2:0]auto_us_to_s02_data_fifo_ARSIZE;
  wire auto_us_to_s02_data_fifo_ARVALID;
  wire [511:0]auto_us_to_s02_data_fifo_RDATA;
  wire auto_us_to_s02_data_fifo_RLAST;
  wire auto_us_to_s02_data_fifo_RREADY;
  wire [1:0]auto_us_to_s02_data_fifo_RRESP;
  wire auto_us_to_s02_data_fifo_RVALID;
  wire [31:0]s02_couplers_to_auto_us_ARADDR;
  wire [1:0]s02_couplers_to_auto_us_ARBURST;
  wire [3:0]s02_couplers_to_auto_us_ARCACHE;
  wire [7:0]s02_couplers_to_auto_us_ARLEN;
  wire [2:0]s02_couplers_to_auto_us_ARPROT;
  wire s02_couplers_to_auto_us_ARREADY;
  wire [2:0]s02_couplers_to_auto_us_ARSIZE;
  wire s02_couplers_to_auto_us_ARVALID;
  wire [31:0]s02_couplers_to_auto_us_RDATA;
  wire s02_couplers_to_auto_us_RLAST;
  wire s02_couplers_to_auto_us_RREADY;
  wire [1:0]s02_couplers_to_auto_us_RRESP;
  wire s02_couplers_to_auto_us_RVALID;
  wire [31:0]s02_data_fifo_to_s02_couplers_ARADDR;
  wire [1:0]s02_data_fifo_to_s02_couplers_ARBURST;
  wire [3:0]s02_data_fifo_to_s02_couplers_ARCACHE;
  wire [7:0]s02_data_fifo_to_s02_couplers_ARLEN;
  wire [0:0]s02_data_fifo_to_s02_couplers_ARLOCK;
  wire [2:0]s02_data_fifo_to_s02_couplers_ARPROT;
  wire [3:0]s02_data_fifo_to_s02_couplers_ARQOS;
  wire s02_data_fifo_to_s02_couplers_ARREADY;
  wire [2:0]s02_data_fifo_to_s02_couplers_ARSIZE;
  wire s02_data_fifo_to_s02_couplers_ARVALID;
  wire [511:0]s02_data_fifo_to_s02_couplers_RDATA;
  wire s02_data_fifo_to_s02_couplers_RLAST;
  wire s02_data_fifo_to_s02_couplers_RREADY;
  wire [1:0]s02_data_fifo_to_s02_couplers_RRESP;
  wire s02_data_fifo_to_s02_couplers_RVALID;

  assign M_ACLK_1 = M_ACLK;
  assign M_ARESETN_1 = M_ARESETN[0];
  assign M_AXI_araddr[31:0] = s02_data_fifo_to_s02_couplers_ARADDR;
  assign M_AXI_arburst[1:0] = s02_data_fifo_to_s02_couplers_ARBURST;
  assign M_AXI_arcache[3:0] = s02_data_fifo_to_s02_couplers_ARCACHE;
  assign M_AXI_arlen[7:0] = s02_data_fifo_to_s02_couplers_ARLEN;
  assign M_AXI_arlock[0] = s02_data_fifo_to_s02_couplers_ARLOCK;
  assign M_AXI_arprot[2:0] = s02_data_fifo_to_s02_couplers_ARPROT;
  assign M_AXI_arqos[3:0] = s02_data_fifo_to_s02_couplers_ARQOS;
  assign M_AXI_arsize[2:0] = s02_data_fifo_to_s02_couplers_ARSIZE;
  assign M_AXI_arvalid = s02_data_fifo_to_s02_couplers_ARVALID;
  assign M_AXI_rready = s02_data_fifo_to_s02_couplers_RREADY;
  assign S_ACLK_1 = S_ACLK;
  assign S_ARESETN_1 = S_ARESETN[0];
  assign S_AXI_arready = s02_couplers_to_auto_us_ARREADY;
  assign S_AXI_rdata[31:0] = s02_couplers_to_auto_us_RDATA;
  assign S_AXI_rlast = s02_couplers_to_auto_us_RLAST;
  assign S_AXI_rresp[1:0] = s02_couplers_to_auto_us_RRESP;
  assign S_AXI_rvalid = s02_couplers_to_auto_us_RVALID;
  assign s02_couplers_to_auto_us_ARADDR = S_AXI_araddr[31:0];
  assign s02_couplers_to_auto_us_ARBURST = S_AXI_arburst[1:0];
  assign s02_couplers_to_auto_us_ARCACHE = S_AXI_arcache[3:0];
  assign s02_couplers_to_auto_us_ARLEN = S_AXI_arlen[7:0];
  assign s02_couplers_to_auto_us_ARPROT = S_AXI_arprot[2:0];
  assign s02_couplers_to_auto_us_ARSIZE = S_AXI_arsize[2:0];
  assign s02_couplers_to_auto_us_ARVALID = S_AXI_arvalid;
  assign s02_couplers_to_auto_us_RREADY = S_AXI_rready;
  assign s02_data_fifo_to_s02_couplers_ARREADY = M_AXI_arready;
  assign s02_data_fifo_to_s02_couplers_RDATA = M_AXI_rdata[511:0];
  assign s02_data_fifo_to_s02_couplers_RLAST = M_AXI_rlast;
  assign s02_data_fifo_to_s02_couplers_RRESP = M_AXI_rresp[1:0];
  assign s02_data_fifo_to_s02_couplers_RVALID = M_AXI_rvalid;
  system_i_bak_auto_us_2 auto_us
       (.m_axi_araddr(auto_us_to_s02_data_fifo_ARADDR),
        .m_axi_arburst(auto_us_to_s02_data_fifo_ARBURST),
        .m_axi_arcache(auto_us_to_s02_data_fifo_ARCACHE),
        .m_axi_arlen(auto_us_to_s02_data_fifo_ARLEN),
        .m_axi_arlock(auto_us_to_s02_data_fifo_ARLOCK),
        .m_axi_arprot(auto_us_to_s02_data_fifo_ARPROT),
        .m_axi_arqos(auto_us_to_s02_data_fifo_ARQOS),
        .m_axi_arready(auto_us_to_s02_data_fifo_ARREADY),
        .m_axi_arregion(auto_us_to_s02_data_fifo_ARREGION),
        .m_axi_arsize(auto_us_to_s02_data_fifo_ARSIZE),
        .m_axi_arvalid(auto_us_to_s02_data_fifo_ARVALID),
        .m_axi_rdata(auto_us_to_s02_data_fifo_RDATA),
        .m_axi_rlast(auto_us_to_s02_data_fifo_RLAST),
        .m_axi_rready(auto_us_to_s02_data_fifo_RREADY),
        .m_axi_rresp(auto_us_to_s02_data_fifo_RRESP),
        .m_axi_rvalid(auto_us_to_s02_data_fifo_RVALID),
        .s_axi_aclk(S_ACLK_1),
        .s_axi_araddr(s02_couplers_to_auto_us_ARADDR),
        .s_axi_arburst(s02_couplers_to_auto_us_ARBURST),
        .s_axi_arcache(s02_couplers_to_auto_us_ARCACHE),
        .s_axi_aresetn(S_ARESETN_1),
        .s_axi_arlen(s02_couplers_to_auto_us_ARLEN),
        .s_axi_arlock(1'b0),
        .s_axi_arprot(s02_couplers_to_auto_us_ARPROT),
        .s_axi_arqos({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(s02_couplers_to_auto_us_ARREADY),
        .s_axi_arregion({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arsize(s02_couplers_to_auto_us_ARSIZE),
        .s_axi_arvalid(s02_couplers_to_auto_us_ARVALID),
        .s_axi_rdata(s02_couplers_to_auto_us_RDATA),
        .s_axi_rlast(s02_couplers_to_auto_us_RLAST),
        .s_axi_rready(s02_couplers_to_auto_us_RREADY),
        .s_axi_rresp(s02_couplers_to_auto_us_RRESP),
        .s_axi_rvalid(s02_couplers_to_auto_us_RVALID));
  system_i_bak_s02_data_fifo_0 s02_data_fifo
       (.aclk(M_ACLK_1),
        .aresetn(M_ARESETN_1),
        .m_axi_araddr(s02_data_fifo_to_s02_couplers_ARADDR),
        .m_axi_arburst(s02_data_fifo_to_s02_couplers_ARBURST),
        .m_axi_arcache(s02_data_fifo_to_s02_couplers_ARCACHE),
        .m_axi_arlen(s02_data_fifo_to_s02_couplers_ARLEN),
        .m_axi_arlock(s02_data_fifo_to_s02_couplers_ARLOCK),
        .m_axi_arprot(s02_data_fifo_to_s02_couplers_ARPROT),
        .m_axi_arqos(s02_data_fifo_to_s02_couplers_ARQOS),
        .m_axi_arready(s02_data_fifo_to_s02_couplers_ARREADY),
        .m_axi_arsize(s02_data_fifo_to_s02_couplers_ARSIZE),
        .m_axi_arvalid(s02_data_fifo_to_s02_couplers_ARVALID),
        .m_axi_rdata(s02_data_fifo_to_s02_couplers_RDATA),
        .m_axi_rlast(s02_data_fifo_to_s02_couplers_RLAST),
        .m_axi_rready(s02_data_fifo_to_s02_couplers_RREADY),
        .m_axi_rresp(s02_data_fifo_to_s02_couplers_RRESP),
        .m_axi_rvalid(s02_data_fifo_to_s02_couplers_RVALID),
        .s_axi_araddr(auto_us_to_s02_data_fifo_ARADDR),
        .s_axi_arburst(auto_us_to_s02_data_fifo_ARBURST),
        .s_axi_arcache(auto_us_to_s02_data_fifo_ARCACHE),
        .s_axi_arlen(auto_us_to_s02_data_fifo_ARLEN),
        .s_axi_arlock(auto_us_to_s02_data_fifo_ARLOCK),
        .s_axi_arprot(auto_us_to_s02_data_fifo_ARPROT),
        .s_axi_arqos(auto_us_to_s02_data_fifo_ARQOS),
        .s_axi_arready(auto_us_to_s02_data_fifo_ARREADY),
        .s_axi_arregion(auto_us_to_s02_data_fifo_ARREGION),
        .s_axi_arsize(auto_us_to_s02_data_fifo_ARSIZE),
        .s_axi_arvalid(auto_us_to_s02_data_fifo_ARVALID),
        .s_axi_rdata(auto_us_to_s02_data_fifo_RDATA),
        .s_axi_rlast(auto_us_to_s02_data_fifo_RLAST),
        .s_axi_rready(auto_us_to_s02_data_fifo_RREADY),
        .s_axi_rresp(auto_us_to_s02_data_fifo_RRESP),
        .s_axi_rvalid(auto_us_to_s02_data_fifo_RVALID));
endmodule

module s03_couplers_imp_8YYC68
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arburst,
    M_AXI_arcache,
    M_AXI_arlen,
    M_AXI_arlock,
    M_AXI_arprot,
    M_AXI_arqos,
    M_AXI_arready,
    M_AXI_arsize,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awburst,
    M_AXI_awcache,
    M_AXI_awlen,
    M_AXI_awlock,
    M_AXI_awprot,
    M_AXI_awqos,
    M_AXI_awready,
    M_AXI_awsize,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rlast,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wlast,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arburst,
    S_AXI_arcache,
    S_AXI_arlen,
    S_AXI_arlock,
    S_AXI_arprot,
    S_AXI_arqos,
    S_AXI_arready,
    S_AXI_arregion,
    S_AXI_arsize,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awburst,
    S_AXI_awcache,
    S_AXI_awlen,
    S_AXI_awlock,
    S_AXI_awprot,
    S_AXI_awqos,
    S_AXI_awready,
    S_AXI_awregion,
    S_AXI_awsize,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rlast,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wlast,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input [0:0]M_ARESETN;
  output [31:0]M_AXI_araddr;
  output [1:0]M_AXI_arburst;
  output [3:0]M_AXI_arcache;
  output [7:0]M_AXI_arlen;
  output [0:0]M_AXI_arlock;
  output [2:0]M_AXI_arprot;
  output [3:0]M_AXI_arqos;
  input M_AXI_arready;
  output [2:0]M_AXI_arsize;
  output M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  output [1:0]M_AXI_awburst;
  output [3:0]M_AXI_awcache;
  output [7:0]M_AXI_awlen;
  output [0:0]M_AXI_awlock;
  output [2:0]M_AXI_awprot;
  output [3:0]M_AXI_awqos;
  input M_AXI_awready;
  output [2:0]M_AXI_awsize;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [511:0]M_AXI_rdata;
  input M_AXI_rlast;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [511:0]M_AXI_wdata;
  output M_AXI_wlast;
  input M_AXI_wready;
  output [63:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input [0:0]S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [1:0]S_AXI_arburst;
  input [3:0]S_AXI_arcache;
  input [7:0]S_AXI_arlen;
  input [0:0]S_AXI_arlock;
  input [2:0]S_AXI_arprot;
  input [3:0]S_AXI_arqos;
  output S_AXI_arready;
  input [3:0]S_AXI_arregion;
  input [2:0]S_AXI_arsize;
  input S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  input [1:0]S_AXI_awburst;
  input [3:0]S_AXI_awcache;
  input [7:0]S_AXI_awlen;
  input [0:0]S_AXI_awlock;
  input [2:0]S_AXI_awprot;
  input [3:0]S_AXI_awqos;
  output S_AXI_awready;
  input [3:0]S_AXI_awregion;
  input [2:0]S_AXI_awsize;
  input S_AXI_awvalid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [511:0]S_AXI_rdata;
  output S_AXI_rlast;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [511:0]S_AXI_wdata;
  input S_AXI_wlast;
  output S_AXI_wready;
  input [63:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire M_ACLK_1;
  wire [0:0]M_ARESETN_1;
  wire [31:0]s03_couplers_to_s03_data_fifo_ARADDR;
  wire [1:0]s03_couplers_to_s03_data_fifo_ARBURST;
  wire [3:0]s03_couplers_to_s03_data_fifo_ARCACHE;
  wire [7:0]s03_couplers_to_s03_data_fifo_ARLEN;
  wire [0:0]s03_couplers_to_s03_data_fifo_ARLOCK;
  wire [2:0]s03_couplers_to_s03_data_fifo_ARPROT;
  wire [3:0]s03_couplers_to_s03_data_fifo_ARQOS;
  wire s03_couplers_to_s03_data_fifo_ARREADY;
  wire [3:0]s03_couplers_to_s03_data_fifo_ARREGION;
  wire [2:0]s03_couplers_to_s03_data_fifo_ARSIZE;
  wire s03_couplers_to_s03_data_fifo_ARVALID;
  wire [31:0]s03_couplers_to_s03_data_fifo_AWADDR;
  wire [1:0]s03_couplers_to_s03_data_fifo_AWBURST;
  wire [3:0]s03_couplers_to_s03_data_fifo_AWCACHE;
  wire [7:0]s03_couplers_to_s03_data_fifo_AWLEN;
  wire [0:0]s03_couplers_to_s03_data_fifo_AWLOCK;
  wire [2:0]s03_couplers_to_s03_data_fifo_AWPROT;
  wire [3:0]s03_couplers_to_s03_data_fifo_AWQOS;
  wire s03_couplers_to_s03_data_fifo_AWREADY;
  wire [3:0]s03_couplers_to_s03_data_fifo_AWREGION;
  wire [2:0]s03_couplers_to_s03_data_fifo_AWSIZE;
  wire s03_couplers_to_s03_data_fifo_AWVALID;
  wire s03_couplers_to_s03_data_fifo_BREADY;
  wire [1:0]s03_couplers_to_s03_data_fifo_BRESP;
  wire s03_couplers_to_s03_data_fifo_BVALID;
  wire [511:0]s03_couplers_to_s03_data_fifo_RDATA;
  wire s03_couplers_to_s03_data_fifo_RLAST;
  wire s03_couplers_to_s03_data_fifo_RREADY;
  wire [1:0]s03_couplers_to_s03_data_fifo_RRESP;
  wire s03_couplers_to_s03_data_fifo_RVALID;
  wire [511:0]s03_couplers_to_s03_data_fifo_WDATA;
  wire s03_couplers_to_s03_data_fifo_WLAST;
  wire s03_couplers_to_s03_data_fifo_WREADY;
  wire [63:0]s03_couplers_to_s03_data_fifo_WSTRB;
  wire s03_couplers_to_s03_data_fifo_WVALID;
  wire [31:0]s03_data_fifo_to_s03_couplers_ARADDR;
  wire [1:0]s03_data_fifo_to_s03_couplers_ARBURST;
  wire [3:0]s03_data_fifo_to_s03_couplers_ARCACHE;
  wire [7:0]s03_data_fifo_to_s03_couplers_ARLEN;
  wire [0:0]s03_data_fifo_to_s03_couplers_ARLOCK;
  wire [2:0]s03_data_fifo_to_s03_couplers_ARPROT;
  wire [3:0]s03_data_fifo_to_s03_couplers_ARQOS;
  wire s03_data_fifo_to_s03_couplers_ARREADY;
  wire [2:0]s03_data_fifo_to_s03_couplers_ARSIZE;
  wire s03_data_fifo_to_s03_couplers_ARVALID;
  wire [31:0]s03_data_fifo_to_s03_couplers_AWADDR;
  wire [1:0]s03_data_fifo_to_s03_couplers_AWBURST;
  wire [3:0]s03_data_fifo_to_s03_couplers_AWCACHE;
  wire [7:0]s03_data_fifo_to_s03_couplers_AWLEN;
  wire [0:0]s03_data_fifo_to_s03_couplers_AWLOCK;
  wire [2:0]s03_data_fifo_to_s03_couplers_AWPROT;
  wire [3:0]s03_data_fifo_to_s03_couplers_AWQOS;
  wire s03_data_fifo_to_s03_couplers_AWREADY;
  wire [2:0]s03_data_fifo_to_s03_couplers_AWSIZE;
  wire s03_data_fifo_to_s03_couplers_AWVALID;
  wire s03_data_fifo_to_s03_couplers_BREADY;
  wire [1:0]s03_data_fifo_to_s03_couplers_BRESP;
  wire s03_data_fifo_to_s03_couplers_BVALID;
  wire [511:0]s03_data_fifo_to_s03_couplers_RDATA;
  wire s03_data_fifo_to_s03_couplers_RLAST;
  wire s03_data_fifo_to_s03_couplers_RREADY;
  wire [1:0]s03_data_fifo_to_s03_couplers_RRESP;
  wire s03_data_fifo_to_s03_couplers_RVALID;
  wire [511:0]s03_data_fifo_to_s03_couplers_WDATA;
  wire s03_data_fifo_to_s03_couplers_WLAST;
  wire s03_data_fifo_to_s03_couplers_WREADY;
  wire [63:0]s03_data_fifo_to_s03_couplers_WSTRB;
  wire s03_data_fifo_to_s03_couplers_WVALID;

  assign M_ACLK_1 = M_ACLK;
  assign M_ARESETN_1 = M_ARESETN[0];
  assign M_AXI_araddr[31:0] = s03_data_fifo_to_s03_couplers_ARADDR;
  assign M_AXI_arburst[1:0] = s03_data_fifo_to_s03_couplers_ARBURST;
  assign M_AXI_arcache[3:0] = s03_data_fifo_to_s03_couplers_ARCACHE;
  assign M_AXI_arlen[7:0] = s03_data_fifo_to_s03_couplers_ARLEN;
  assign M_AXI_arlock[0] = s03_data_fifo_to_s03_couplers_ARLOCK;
  assign M_AXI_arprot[2:0] = s03_data_fifo_to_s03_couplers_ARPROT;
  assign M_AXI_arqos[3:0] = s03_data_fifo_to_s03_couplers_ARQOS;
  assign M_AXI_arsize[2:0] = s03_data_fifo_to_s03_couplers_ARSIZE;
  assign M_AXI_arvalid = s03_data_fifo_to_s03_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = s03_data_fifo_to_s03_couplers_AWADDR;
  assign M_AXI_awburst[1:0] = s03_data_fifo_to_s03_couplers_AWBURST;
  assign M_AXI_awcache[3:0] = s03_data_fifo_to_s03_couplers_AWCACHE;
  assign M_AXI_awlen[7:0] = s03_data_fifo_to_s03_couplers_AWLEN;
  assign M_AXI_awlock[0] = s03_data_fifo_to_s03_couplers_AWLOCK;
  assign M_AXI_awprot[2:0] = s03_data_fifo_to_s03_couplers_AWPROT;
  assign M_AXI_awqos[3:0] = s03_data_fifo_to_s03_couplers_AWQOS;
  assign M_AXI_awsize[2:0] = s03_data_fifo_to_s03_couplers_AWSIZE;
  assign M_AXI_awvalid = s03_data_fifo_to_s03_couplers_AWVALID;
  assign M_AXI_bready = s03_data_fifo_to_s03_couplers_BREADY;
  assign M_AXI_rready = s03_data_fifo_to_s03_couplers_RREADY;
  assign M_AXI_wdata[511:0] = s03_data_fifo_to_s03_couplers_WDATA;
  assign M_AXI_wlast = s03_data_fifo_to_s03_couplers_WLAST;
  assign M_AXI_wstrb[63:0] = s03_data_fifo_to_s03_couplers_WSTRB;
  assign M_AXI_wvalid = s03_data_fifo_to_s03_couplers_WVALID;
  assign S_AXI_arready = s03_couplers_to_s03_data_fifo_ARREADY;
  assign S_AXI_awready = s03_couplers_to_s03_data_fifo_AWREADY;
  assign S_AXI_bresp[1:0] = s03_couplers_to_s03_data_fifo_BRESP;
  assign S_AXI_bvalid = s03_couplers_to_s03_data_fifo_BVALID;
  assign S_AXI_rdata[511:0] = s03_couplers_to_s03_data_fifo_RDATA;
  assign S_AXI_rlast = s03_couplers_to_s03_data_fifo_RLAST;
  assign S_AXI_rresp[1:0] = s03_couplers_to_s03_data_fifo_RRESP;
  assign S_AXI_rvalid = s03_couplers_to_s03_data_fifo_RVALID;
  assign S_AXI_wready = s03_couplers_to_s03_data_fifo_WREADY;
  assign s03_couplers_to_s03_data_fifo_ARADDR = S_AXI_araddr[31:0];
  assign s03_couplers_to_s03_data_fifo_ARBURST = S_AXI_arburst[1:0];
  assign s03_couplers_to_s03_data_fifo_ARCACHE = S_AXI_arcache[3:0];
  assign s03_couplers_to_s03_data_fifo_ARLEN = S_AXI_arlen[7:0];
  assign s03_couplers_to_s03_data_fifo_ARLOCK = S_AXI_arlock[0];
  assign s03_couplers_to_s03_data_fifo_ARPROT = S_AXI_arprot[2:0];
  assign s03_couplers_to_s03_data_fifo_ARQOS = S_AXI_arqos[3:0];
  assign s03_couplers_to_s03_data_fifo_ARREGION = S_AXI_arregion[3:0];
  assign s03_couplers_to_s03_data_fifo_ARSIZE = S_AXI_arsize[2:0];
  assign s03_couplers_to_s03_data_fifo_ARVALID = S_AXI_arvalid;
  assign s03_couplers_to_s03_data_fifo_AWADDR = S_AXI_awaddr[31:0];
  assign s03_couplers_to_s03_data_fifo_AWBURST = S_AXI_awburst[1:0];
  assign s03_couplers_to_s03_data_fifo_AWCACHE = S_AXI_awcache[3:0];
  assign s03_couplers_to_s03_data_fifo_AWLEN = S_AXI_awlen[7:0];
  assign s03_couplers_to_s03_data_fifo_AWLOCK = S_AXI_awlock[0];
  assign s03_couplers_to_s03_data_fifo_AWPROT = S_AXI_awprot[2:0];
  assign s03_couplers_to_s03_data_fifo_AWQOS = S_AXI_awqos[3:0];
  assign s03_couplers_to_s03_data_fifo_AWREGION = S_AXI_awregion[3:0];
  assign s03_couplers_to_s03_data_fifo_AWSIZE = S_AXI_awsize[2:0];
  assign s03_couplers_to_s03_data_fifo_AWVALID = S_AXI_awvalid;
  assign s03_couplers_to_s03_data_fifo_BREADY = S_AXI_bready;
  assign s03_couplers_to_s03_data_fifo_RREADY = S_AXI_rready;
  assign s03_couplers_to_s03_data_fifo_WDATA = S_AXI_wdata[511:0];
  assign s03_couplers_to_s03_data_fifo_WLAST = S_AXI_wlast;
  assign s03_couplers_to_s03_data_fifo_WSTRB = S_AXI_wstrb[63:0];
  assign s03_couplers_to_s03_data_fifo_WVALID = S_AXI_wvalid;
  assign s03_data_fifo_to_s03_couplers_ARREADY = M_AXI_arready;
  assign s03_data_fifo_to_s03_couplers_AWREADY = M_AXI_awready;
  assign s03_data_fifo_to_s03_couplers_BRESP = M_AXI_bresp[1:0];
  assign s03_data_fifo_to_s03_couplers_BVALID = M_AXI_bvalid;
  assign s03_data_fifo_to_s03_couplers_RDATA = M_AXI_rdata[511:0];
  assign s03_data_fifo_to_s03_couplers_RLAST = M_AXI_rlast;
  assign s03_data_fifo_to_s03_couplers_RRESP = M_AXI_rresp[1:0];
  assign s03_data_fifo_to_s03_couplers_RVALID = M_AXI_rvalid;
  assign s03_data_fifo_to_s03_couplers_WREADY = M_AXI_wready;
  system_i_bak_s03_data_fifo_1 s03_data_fifo
       (.aclk(M_ACLK_1),
        .aresetn(M_ARESETN_1),
        .m_axi_araddr(s03_data_fifo_to_s03_couplers_ARADDR),
        .m_axi_arburst(s03_data_fifo_to_s03_couplers_ARBURST),
        .m_axi_arcache(s03_data_fifo_to_s03_couplers_ARCACHE),
        .m_axi_arlen(s03_data_fifo_to_s03_couplers_ARLEN),
        .m_axi_arlock(s03_data_fifo_to_s03_couplers_ARLOCK),
        .m_axi_arprot(s03_data_fifo_to_s03_couplers_ARPROT),
        .m_axi_arqos(s03_data_fifo_to_s03_couplers_ARQOS),
        .m_axi_arready(s03_data_fifo_to_s03_couplers_ARREADY),
        .m_axi_arsize(s03_data_fifo_to_s03_couplers_ARSIZE),
        .m_axi_arvalid(s03_data_fifo_to_s03_couplers_ARVALID),
        .m_axi_awaddr(s03_data_fifo_to_s03_couplers_AWADDR),
        .m_axi_awburst(s03_data_fifo_to_s03_couplers_AWBURST),
        .m_axi_awcache(s03_data_fifo_to_s03_couplers_AWCACHE),
        .m_axi_awlen(s03_data_fifo_to_s03_couplers_AWLEN),
        .m_axi_awlock(s03_data_fifo_to_s03_couplers_AWLOCK),
        .m_axi_awprot(s03_data_fifo_to_s03_couplers_AWPROT),
        .m_axi_awqos(s03_data_fifo_to_s03_couplers_AWQOS),
        .m_axi_awready(s03_data_fifo_to_s03_couplers_AWREADY),
        .m_axi_awsize(s03_data_fifo_to_s03_couplers_AWSIZE),
        .m_axi_awvalid(s03_data_fifo_to_s03_couplers_AWVALID),
        .m_axi_bready(s03_data_fifo_to_s03_couplers_BREADY),
        .m_axi_bresp(s03_data_fifo_to_s03_couplers_BRESP),
        .m_axi_bvalid(s03_data_fifo_to_s03_couplers_BVALID),
        .m_axi_rdata(s03_data_fifo_to_s03_couplers_RDATA),
        .m_axi_rlast(s03_data_fifo_to_s03_couplers_RLAST),
        .m_axi_rready(s03_data_fifo_to_s03_couplers_RREADY),
        .m_axi_rresp(s03_data_fifo_to_s03_couplers_RRESP),
        .m_axi_rvalid(s03_data_fifo_to_s03_couplers_RVALID),
        .m_axi_wdata(s03_data_fifo_to_s03_couplers_WDATA),
        .m_axi_wlast(s03_data_fifo_to_s03_couplers_WLAST),
        .m_axi_wready(s03_data_fifo_to_s03_couplers_WREADY),
        .m_axi_wstrb(s03_data_fifo_to_s03_couplers_WSTRB),
        .m_axi_wvalid(s03_data_fifo_to_s03_couplers_WVALID),
        .s_axi_araddr(s03_couplers_to_s03_data_fifo_ARADDR),
        .s_axi_arburst(s03_couplers_to_s03_data_fifo_ARBURST),
        .s_axi_arcache(s03_couplers_to_s03_data_fifo_ARCACHE),
        .s_axi_arlen(s03_couplers_to_s03_data_fifo_ARLEN),
        .s_axi_arlock(s03_couplers_to_s03_data_fifo_ARLOCK),
        .s_axi_arprot(s03_couplers_to_s03_data_fifo_ARPROT),
        .s_axi_arqos(s03_couplers_to_s03_data_fifo_ARQOS),
        .s_axi_arready(s03_couplers_to_s03_data_fifo_ARREADY),
        .s_axi_arregion(s03_couplers_to_s03_data_fifo_ARREGION),
        .s_axi_arsize(s03_couplers_to_s03_data_fifo_ARSIZE),
        .s_axi_arvalid(s03_couplers_to_s03_data_fifo_ARVALID),
        .s_axi_awaddr(s03_couplers_to_s03_data_fifo_AWADDR),
        .s_axi_awburst(s03_couplers_to_s03_data_fifo_AWBURST),
        .s_axi_awcache(s03_couplers_to_s03_data_fifo_AWCACHE),
        .s_axi_awlen(s03_couplers_to_s03_data_fifo_AWLEN),
        .s_axi_awlock(s03_couplers_to_s03_data_fifo_AWLOCK),
        .s_axi_awprot(s03_couplers_to_s03_data_fifo_AWPROT),
        .s_axi_awqos(s03_couplers_to_s03_data_fifo_AWQOS),
        .s_axi_awready(s03_couplers_to_s03_data_fifo_AWREADY),
        .s_axi_awregion(s03_couplers_to_s03_data_fifo_AWREGION),
        .s_axi_awsize(s03_couplers_to_s03_data_fifo_AWSIZE),
        .s_axi_awvalid(s03_couplers_to_s03_data_fifo_AWVALID),
        .s_axi_bready(s03_couplers_to_s03_data_fifo_BREADY),
        .s_axi_bresp(s03_couplers_to_s03_data_fifo_BRESP),
        .s_axi_bvalid(s03_couplers_to_s03_data_fifo_BVALID),
        .s_axi_rdata(s03_couplers_to_s03_data_fifo_RDATA),
        .s_axi_rlast(s03_couplers_to_s03_data_fifo_RLAST),
        .s_axi_rready(s03_couplers_to_s03_data_fifo_RREADY),
        .s_axi_rresp(s03_couplers_to_s03_data_fifo_RRESP),
        .s_axi_rvalid(s03_couplers_to_s03_data_fifo_RVALID),
        .s_axi_wdata(s03_couplers_to_s03_data_fifo_WDATA),
        .s_axi_wlast(s03_couplers_to_s03_data_fifo_WLAST),
        .s_axi_wready(s03_couplers_to_s03_data_fifo_WREADY),
        .s_axi_wstrb(s03_couplers_to_s03_data_fifo_WSTRB),
        .s_axi_wvalid(s03_couplers_to_s03_data_fifo_WVALID));
endmodule

module s03_couplers_imp_MKB4BP
   (M_ACLK,
    M_ARESETN,
    M_AXI_awaddr,
    M_AXI_awburst,
    M_AXI_awcache,
    M_AXI_awlen,
    M_AXI_awlock,
    M_AXI_awprot,
    M_AXI_awqos,
    M_AXI_awready,
    M_AXI_awsize,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_wdata,
    M_AXI_wlast,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_awaddr,
    S_AXI_awburst,
    S_AXI_awcache,
    S_AXI_awlen,
    S_AXI_awprot,
    S_AXI_awready,
    S_AXI_awsize,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_wdata,
    S_AXI_wlast,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input [0:0]M_ARESETN;
  output [31:0]M_AXI_awaddr;
  output [1:0]M_AXI_awburst;
  output [3:0]M_AXI_awcache;
  output [7:0]M_AXI_awlen;
  output [0:0]M_AXI_awlock;
  output [2:0]M_AXI_awprot;
  output [3:0]M_AXI_awqos;
  input M_AXI_awready;
  output [2:0]M_AXI_awsize;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  output [511:0]M_AXI_wdata;
  output M_AXI_wlast;
  input M_AXI_wready;
  output [63:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input [0:0]S_ARESETN;
  input [31:0]S_AXI_awaddr;
  input [1:0]S_AXI_awburst;
  input [3:0]S_AXI_awcache;
  input [7:0]S_AXI_awlen;
  input [2:0]S_AXI_awprot;
  output S_AXI_awready;
  input [2:0]S_AXI_awsize;
  input S_AXI_awvalid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  input [31:0]S_AXI_wdata;
  input S_AXI_wlast;
  output S_AXI_wready;
  input [3:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire M_ACLK_1;
  wire [0:0]M_ARESETN_1;
  wire S_ACLK_1;
  wire [0:0]S_ARESETN_1;
  wire [31:0]auto_us_to_s03_data_fifo_AWADDR;
  wire [1:0]auto_us_to_s03_data_fifo_AWBURST;
  wire [3:0]auto_us_to_s03_data_fifo_AWCACHE;
  wire [7:0]auto_us_to_s03_data_fifo_AWLEN;
  wire [0:0]auto_us_to_s03_data_fifo_AWLOCK;
  wire [2:0]auto_us_to_s03_data_fifo_AWPROT;
  wire [3:0]auto_us_to_s03_data_fifo_AWQOS;
  wire auto_us_to_s03_data_fifo_AWREADY;
  wire [3:0]auto_us_to_s03_data_fifo_AWREGION;
  wire [2:0]auto_us_to_s03_data_fifo_AWSIZE;
  wire auto_us_to_s03_data_fifo_AWVALID;
  wire auto_us_to_s03_data_fifo_BREADY;
  wire [1:0]auto_us_to_s03_data_fifo_BRESP;
  wire auto_us_to_s03_data_fifo_BVALID;
  wire [511:0]auto_us_to_s03_data_fifo_WDATA;
  wire auto_us_to_s03_data_fifo_WLAST;
  wire auto_us_to_s03_data_fifo_WREADY;
  wire [63:0]auto_us_to_s03_data_fifo_WSTRB;
  wire auto_us_to_s03_data_fifo_WVALID;
  wire [31:0]s03_couplers_to_auto_us_AWADDR;
  wire [1:0]s03_couplers_to_auto_us_AWBURST;
  wire [3:0]s03_couplers_to_auto_us_AWCACHE;
  wire [7:0]s03_couplers_to_auto_us_AWLEN;
  wire [2:0]s03_couplers_to_auto_us_AWPROT;
  wire s03_couplers_to_auto_us_AWREADY;
  wire [2:0]s03_couplers_to_auto_us_AWSIZE;
  wire s03_couplers_to_auto_us_AWVALID;
  wire s03_couplers_to_auto_us_BREADY;
  wire [1:0]s03_couplers_to_auto_us_BRESP;
  wire s03_couplers_to_auto_us_BVALID;
  wire [31:0]s03_couplers_to_auto_us_WDATA;
  wire s03_couplers_to_auto_us_WLAST;
  wire s03_couplers_to_auto_us_WREADY;
  wire [3:0]s03_couplers_to_auto_us_WSTRB;
  wire s03_couplers_to_auto_us_WVALID;
  wire [31:0]s03_data_fifo_to_s03_couplers_AWADDR;
  wire [1:0]s03_data_fifo_to_s03_couplers_AWBURST;
  wire [3:0]s03_data_fifo_to_s03_couplers_AWCACHE;
  wire [7:0]s03_data_fifo_to_s03_couplers_AWLEN;
  wire [0:0]s03_data_fifo_to_s03_couplers_AWLOCK;
  wire [2:0]s03_data_fifo_to_s03_couplers_AWPROT;
  wire [3:0]s03_data_fifo_to_s03_couplers_AWQOS;
  wire s03_data_fifo_to_s03_couplers_AWREADY;
  wire [2:0]s03_data_fifo_to_s03_couplers_AWSIZE;
  wire s03_data_fifo_to_s03_couplers_AWVALID;
  wire s03_data_fifo_to_s03_couplers_BREADY;
  wire [1:0]s03_data_fifo_to_s03_couplers_BRESP;
  wire s03_data_fifo_to_s03_couplers_BVALID;
  wire [511:0]s03_data_fifo_to_s03_couplers_WDATA;
  wire s03_data_fifo_to_s03_couplers_WLAST;
  wire s03_data_fifo_to_s03_couplers_WREADY;
  wire [63:0]s03_data_fifo_to_s03_couplers_WSTRB;
  wire s03_data_fifo_to_s03_couplers_WVALID;

  assign M_ACLK_1 = M_ACLK;
  assign M_ARESETN_1 = M_ARESETN[0];
  assign M_AXI_awaddr[31:0] = s03_data_fifo_to_s03_couplers_AWADDR;
  assign M_AXI_awburst[1:0] = s03_data_fifo_to_s03_couplers_AWBURST;
  assign M_AXI_awcache[3:0] = s03_data_fifo_to_s03_couplers_AWCACHE;
  assign M_AXI_awlen[7:0] = s03_data_fifo_to_s03_couplers_AWLEN;
  assign M_AXI_awlock[0] = s03_data_fifo_to_s03_couplers_AWLOCK;
  assign M_AXI_awprot[2:0] = s03_data_fifo_to_s03_couplers_AWPROT;
  assign M_AXI_awqos[3:0] = s03_data_fifo_to_s03_couplers_AWQOS;
  assign M_AXI_awsize[2:0] = s03_data_fifo_to_s03_couplers_AWSIZE;
  assign M_AXI_awvalid = s03_data_fifo_to_s03_couplers_AWVALID;
  assign M_AXI_bready = s03_data_fifo_to_s03_couplers_BREADY;
  assign M_AXI_wdata[511:0] = s03_data_fifo_to_s03_couplers_WDATA;
  assign M_AXI_wlast = s03_data_fifo_to_s03_couplers_WLAST;
  assign M_AXI_wstrb[63:0] = s03_data_fifo_to_s03_couplers_WSTRB;
  assign M_AXI_wvalid = s03_data_fifo_to_s03_couplers_WVALID;
  assign S_ACLK_1 = S_ACLK;
  assign S_ARESETN_1 = S_ARESETN[0];
  assign S_AXI_awready = s03_couplers_to_auto_us_AWREADY;
  assign S_AXI_bresp[1:0] = s03_couplers_to_auto_us_BRESP;
  assign S_AXI_bvalid = s03_couplers_to_auto_us_BVALID;
  assign S_AXI_wready = s03_couplers_to_auto_us_WREADY;
  assign s03_couplers_to_auto_us_AWADDR = S_AXI_awaddr[31:0];
  assign s03_couplers_to_auto_us_AWBURST = S_AXI_awburst[1:0];
  assign s03_couplers_to_auto_us_AWCACHE = S_AXI_awcache[3:0];
  assign s03_couplers_to_auto_us_AWLEN = S_AXI_awlen[7:0];
  assign s03_couplers_to_auto_us_AWPROT = S_AXI_awprot[2:0];
  assign s03_couplers_to_auto_us_AWSIZE = S_AXI_awsize[2:0];
  assign s03_couplers_to_auto_us_AWVALID = S_AXI_awvalid;
  assign s03_couplers_to_auto_us_BREADY = S_AXI_bready;
  assign s03_couplers_to_auto_us_WDATA = S_AXI_wdata[31:0];
  assign s03_couplers_to_auto_us_WLAST = S_AXI_wlast;
  assign s03_couplers_to_auto_us_WSTRB = S_AXI_wstrb[3:0];
  assign s03_couplers_to_auto_us_WVALID = S_AXI_wvalid;
  assign s03_data_fifo_to_s03_couplers_AWREADY = M_AXI_awready;
  assign s03_data_fifo_to_s03_couplers_BRESP = M_AXI_bresp[1:0];
  assign s03_data_fifo_to_s03_couplers_BVALID = M_AXI_bvalid;
  assign s03_data_fifo_to_s03_couplers_WREADY = M_AXI_wready;
  system_i_bak_auto_us_3 auto_us
       (.m_axi_awaddr(auto_us_to_s03_data_fifo_AWADDR),
        .m_axi_awburst(auto_us_to_s03_data_fifo_AWBURST),
        .m_axi_awcache(auto_us_to_s03_data_fifo_AWCACHE),
        .m_axi_awlen(auto_us_to_s03_data_fifo_AWLEN),
        .m_axi_awlock(auto_us_to_s03_data_fifo_AWLOCK),
        .m_axi_awprot(auto_us_to_s03_data_fifo_AWPROT),
        .m_axi_awqos(auto_us_to_s03_data_fifo_AWQOS),
        .m_axi_awready(auto_us_to_s03_data_fifo_AWREADY),
        .m_axi_awregion(auto_us_to_s03_data_fifo_AWREGION),
        .m_axi_awsize(auto_us_to_s03_data_fifo_AWSIZE),
        .m_axi_awvalid(auto_us_to_s03_data_fifo_AWVALID),
        .m_axi_bready(auto_us_to_s03_data_fifo_BREADY),
        .m_axi_bresp(auto_us_to_s03_data_fifo_BRESP),
        .m_axi_bvalid(auto_us_to_s03_data_fifo_BVALID),
        .m_axi_wdata(auto_us_to_s03_data_fifo_WDATA),
        .m_axi_wlast(auto_us_to_s03_data_fifo_WLAST),
        .m_axi_wready(auto_us_to_s03_data_fifo_WREADY),
        .m_axi_wstrb(auto_us_to_s03_data_fifo_WSTRB),
        .m_axi_wvalid(auto_us_to_s03_data_fifo_WVALID),
        .s_axi_aclk(S_ACLK_1),
        .s_axi_aresetn(S_ARESETN_1),
        .s_axi_awaddr(s03_couplers_to_auto_us_AWADDR),
        .s_axi_awburst(s03_couplers_to_auto_us_AWBURST),
        .s_axi_awcache(s03_couplers_to_auto_us_AWCACHE),
        .s_axi_awlen(s03_couplers_to_auto_us_AWLEN),
        .s_axi_awlock(1'b0),
        .s_axi_awprot(s03_couplers_to_auto_us_AWPROT),
        .s_axi_awqos({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(s03_couplers_to_auto_us_AWREADY),
        .s_axi_awregion({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awsize(s03_couplers_to_auto_us_AWSIZE),
        .s_axi_awvalid(s03_couplers_to_auto_us_AWVALID),
        .s_axi_bready(s03_couplers_to_auto_us_BREADY),
        .s_axi_bresp(s03_couplers_to_auto_us_BRESP),
        .s_axi_bvalid(s03_couplers_to_auto_us_BVALID),
        .s_axi_wdata(s03_couplers_to_auto_us_WDATA),
        .s_axi_wlast(s03_couplers_to_auto_us_WLAST),
        .s_axi_wready(s03_couplers_to_auto_us_WREADY),
        .s_axi_wstrb(s03_couplers_to_auto_us_WSTRB),
        .s_axi_wvalid(s03_couplers_to_auto_us_WVALID));
  system_i_bak_s03_data_fifo_0 s03_data_fifo
       (.aclk(M_ACLK_1),
        .aresetn(M_ARESETN_1),
        .m_axi_awaddr(s03_data_fifo_to_s03_couplers_AWADDR),
        .m_axi_awburst(s03_data_fifo_to_s03_couplers_AWBURST),
        .m_axi_awcache(s03_data_fifo_to_s03_couplers_AWCACHE),
        .m_axi_awlen(s03_data_fifo_to_s03_couplers_AWLEN),
        .m_axi_awlock(s03_data_fifo_to_s03_couplers_AWLOCK),
        .m_axi_awprot(s03_data_fifo_to_s03_couplers_AWPROT),
        .m_axi_awqos(s03_data_fifo_to_s03_couplers_AWQOS),
        .m_axi_awready(s03_data_fifo_to_s03_couplers_AWREADY),
        .m_axi_awsize(s03_data_fifo_to_s03_couplers_AWSIZE),
        .m_axi_awvalid(s03_data_fifo_to_s03_couplers_AWVALID),
        .m_axi_bready(s03_data_fifo_to_s03_couplers_BREADY),
        .m_axi_bresp(s03_data_fifo_to_s03_couplers_BRESP),
        .m_axi_bvalid(s03_data_fifo_to_s03_couplers_BVALID),
        .m_axi_wdata(s03_data_fifo_to_s03_couplers_WDATA),
        .m_axi_wlast(s03_data_fifo_to_s03_couplers_WLAST),
        .m_axi_wready(s03_data_fifo_to_s03_couplers_WREADY),
        .m_axi_wstrb(s03_data_fifo_to_s03_couplers_WSTRB),
        .m_axi_wvalid(s03_data_fifo_to_s03_couplers_WVALID),
        .s_axi_awaddr(auto_us_to_s03_data_fifo_AWADDR),
        .s_axi_awburst(auto_us_to_s03_data_fifo_AWBURST),
        .s_axi_awcache(auto_us_to_s03_data_fifo_AWCACHE),
        .s_axi_awlen(auto_us_to_s03_data_fifo_AWLEN),
        .s_axi_awlock(auto_us_to_s03_data_fifo_AWLOCK),
        .s_axi_awprot(auto_us_to_s03_data_fifo_AWPROT),
        .s_axi_awqos(auto_us_to_s03_data_fifo_AWQOS),
        .s_axi_awready(auto_us_to_s03_data_fifo_AWREADY),
        .s_axi_awregion(auto_us_to_s03_data_fifo_AWREGION),
        .s_axi_awsize(auto_us_to_s03_data_fifo_AWSIZE),
        .s_axi_awvalid(auto_us_to_s03_data_fifo_AWVALID),
        .s_axi_bready(auto_us_to_s03_data_fifo_BREADY),
        .s_axi_bresp(auto_us_to_s03_data_fifo_BRESP),
        .s_axi_bvalid(auto_us_to_s03_data_fifo_BVALID),
        .s_axi_wdata(auto_us_to_s03_data_fifo_WDATA),
        .s_axi_wlast(auto_us_to_s03_data_fifo_WLAST),
        .s_axi_wready(auto_us_to_s03_data_fifo_WREADY),
        .s_axi_wstrb(auto_us_to_s03_data_fifo_WSTRB),
        .s_axi_wvalid(auto_us_to_s03_data_fifo_WVALID));
endmodule

module s04_couplers_imp_EKV279
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arburst,
    M_AXI_arcache,
    M_AXI_arlen,
    M_AXI_arlock,
    M_AXI_arprot,
    M_AXI_arqos,
    M_AXI_arready,
    M_AXI_arsize,
    M_AXI_arvalid,
    M_AXI_rdata,
    M_AXI_rlast,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arprot,
    S_AXI_arready,
    S_AXI_arvalid,
    S_AXI_rdata,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid);
  input M_ACLK;
  input [0:0]M_ARESETN;
  output [31:0]M_AXI_araddr;
  output [1:0]M_AXI_arburst;
  output [3:0]M_AXI_arcache;
  output [7:0]M_AXI_arlen;
  output [0:0]M_AXI_arlock;
  output [2:0]M_AXI_arprot;
  output [3:0]M_AXI_arqos;
  input M_AXI_arready;
  output [2:0]M_AXI_arsize;
  output M_AXI_arvalid;
  input [511:0]M_AXI_rdata;
  input M_AXI_rlast;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  input S_ACLK;
  input [0:0]S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [2:0]S_AXI_arprot;
  output S_AXI_arready;
  input S_AXI_arvalid;
  output [31:0]S_AXI_rdata;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;

  wire M_ACLK_1;
  wire [0:0]M_ARESETN_1;
  wire S_ACLK_1;
  wire [0:0]S_ARESETN_1;
  wire [31:0]auto_pc_to_auto_us_df_ARADDR;
  wire [1:0]auto_pc_to_auto_us_df_ARBURST;
  wire [3:0]auto_pc_to_auto_us_df_ARCACHE;
  wire [7:0]auto_pc_to_auto_us_df_ARLEN;
  wire [0:0]auto_pc_to_auto_us_df_ARLOCK;
  wire [2:0]auto_pc_to_auto_us_df_ARPROT;
  wire [3:0]auto_pc_to_auto_us_df_ARQOS;
  wire auto_pc_to_auto_us_df_ARREADY;
  wire [3:0]auto_pc_to_auto_us_df_ARREGION;
  wire [2:0]auto_pc_to_auto_us_df_ARSIZE;
  wire auto_pc_to_auto_us_df_ARVALID;
  wire [31:0]auto_pc_to_auto_us_df_RDATA;
  wire auto_pc_to_auto_us_df_RLAST;
  wire auto_pc_to_auto_us_df_RREADY;
  wire [1:0]auto_pc_to_auto_us_df_RRESP;
  wire auto_pc_to_auto_us_df_RVALID;
  wire [31:0]auto_us_df_to_s04_couplers_ARADDR;
  wire [1:0]auto_us_df_to_s04_couplers_ARBURST;
  wire [3:0]auto_us_df_to_s04_couplers_ARCACHE;
  wire [7:0]auto_us_df_to_s04_couplers_ARLEN;
  wire [0:0]auto_us_df_to_s04_couplers_ARLOCK;
  wire [2:0]auto_us_df_to_s04_couplers_ARPROT;
  wire [3:0]auto_us_df_to_s04_couplers_ARQOS;
  wire auto_us_df_to_s04_couplers_ARREADY;
  wire [2:0]auto_us_df_to_s04_couplers_ARSIZE;
  wire auto_us_df_to_s04_couplers_ARVALID;
  wire [511:0]auto_us_df_to_s04_couplers_RDATA;
  wire auto_us_df_to_s04_couplers_RLAST;
  wire auto_us_df_to_s04_couplers_RREADY;
  wire [1:0]auto_us_df_to_s04_couplers_RRESP;
  wire auto_us_df_to_s04_couplers_RVALID;
  wire [31:0]s04_couplers_to_auto_pc_ARADDR;
  wire [2:0]s04_couplers_to_auto_pc_ARPROT;
  wire s04_couplers_to_auto_pc_ARREADY;
  wire s04_couplers_to_auto_pc_ARVALID;
  wire [31:0]s04_couplers_to_auto_pc_RDATA;
  wire s04_couplers_to_auto_pc_RREADY;
  wire [1:0]s04_couplers_to_auto_pc_RRESP;
  wire s04_couplers_to_auto_pc_RVALID;

  assign M_ACLK_1 = M_ACLK;
  assign M_ARESETN_1 = M_ARESETN[0];
  assign M_AXI_araddr[31:0] = auto_us_df_to_s04_couplers_ARADDR;
  assign M_AXI_arburst[1:0] = auto_us_df_to_s04_couplers_ARBURST;
  assign M_AXI_arcache[3:0] = auto_us_df_to_s04_couplers_ARCACHE;
  assign M_AXI_arlen[7:0] = auto_us_df_to_s04_couplers_ARLEN;
  assign M_AXI_arlock[0] = auto_us_df_to_s04_couplers_ARLOCK;
  assign M_AXI_arprot[2:0] = auto_us_df_to_s04_couplers_ARPROT;
  assign M_AXI_arqos[3:0] = auto_us_df_to_s04_couplers_ARQOS;
  assign M_AXI_arsize[2:0] = auto_us_df_to_s04_couplers_ARSIZE;
  assign M_AXI_arvalid = auto_us_df_to_s04_couplers_ARVALID;
  assign M_AXI_rready = auto_us_df_to_s04_couplers_RREADY;
  assign S_ACLK_1 = S_ACLK;
  assign S_ARESETN_1 = S_ARESETN[0];
  assign S_AXI_arready = s04_couplers_to_auto_pc_ARREADY;
  assign S_AXI_rdata[31:0] = s04_couplers_to_auto_pc_RDATA;
  assign S_AXI_rresp[1:0] = s04_couplers_to_auto_pc_RRESP;
  assign S_AXI_rvalid = s04_couplers_to_auto_pc_RVALID;
  assign auto_us_df_to_s04_couplers_ARREADY = M_AXI_arready;
  assign auto_us_df_to_s04_couplers_RDATA = M_AXI_rdata[511:0];
  assign auto_us_df_to_s04_couplers_RLAST = M_AXI_rlast;
  assign auto_us_df_to_s04_couplers_RRESP = M_AXI_rresp[1:0];
  assign auto_us_df_to_s04_couplers_RVALID = M_AXI_rvalid;
  assign s04_couplers_to_auto_pc_ARADDR = S_AXI_araddr[31:0];
  assign s04_couplers_to_auto_pc_ARPROT = S_AXI_arprot[2:0];
  assign s04_couplers_to_auto_pc_ARVALID = S_AXI_arvalid;
  assign s04_couplers_to_auto_pc_RREADY = S_AXI_rready;
  system_i_bak_auto_pc_13 auto_pc
       (.aclk(S_ACLK_1),
        .aresetn(S_ARESETN_1),
        .m_axi_araddr(auto_pc_to_auto_us_df_ARADDR),
        .m_axi_arburst(auto_pc_to_auto_us_df_ARBURST),
        .m_axi_arcache(auto_pc_to_auto_us_df_ARCACHE),
        .m_axi_arlen(auto_pc_to_auto_us_df_ARLEN),
        .m_axi_arlock(auto_pc_to_auto_us_df_ARLOCK),
        .m_axi_arprot(auto_pc_to_auto_us_df_ARPROT),
        .m_axi_arqos(auto_pc_to_auto_us_df_ARQOS),
        .m_axi_arready(auto_pc_to_auto_us_df_ARREADY),
        .m_axi_arregion(auto_pc_to_auto_us_df_ARREGION),
        .m_axi_arsize(auto_pc_to_auto_us_df_ARSIZE),
        .m_axi_arvalid(auto_pc_to_auto_us_df_ARVALID),
        .m_axi_rdata(auto_pc_to_auto_us_df_RDATA),
        .m_axi_rlast(auto_pc_to_auto_us_df_RLAST),
        .m_axi_rready(auto_pc_to_auto_us_df_RREADY),
        .m_axi_rresp(auto_pc_to_auto_us_df_RRESP),
        .m_axi_rvalid(auto_pc_to_auto_us_df_RVALID),
        .s_axi_araddr(s04_couplers_to_auto_pc_ARADDR),
        .s_axi_arprot(s04_couplers_to_auto_pc_ARPROT),
        .s_axi_arready(s04_couplers_to_auto_pc_ARREADY),
        .s_axi_arvalid(s04_couplers_to_auto_pc_ARVALID),
        .s_axi_rdata(s04_couplers_to_auto_pc_RDATA),
        .s_axi_rready(s04_couplers_to_auto_pc_RREADY),
        .s_axi_rresp(s04_couplers_to_auto_pc_RRESP),
        .s_axi_rvalid(s04_couplers_to_auto_pc_RVALID));
  system_i_bak_auto_us_df_0 auto_us_df
       (.m_axi_araddr(auto_us_df_to_s04_couplers_ARADDR),
        .m_axi_arburst(auto_us_df_to_s04_couplers_ARBURST),
        .m_axi_arcache(auto_us_df_to_s04_couplers_ARCACHE),
        .m_axi_arlen(auto_us_df_to_s04_couplers_ARLEN),
        .m_axi_arlock(auto_us_df_to_s04_couplers_ARLOCK),
        .m_axi_arprot(auto_us_df_to_s04_couplers_ARPROT),
        .m_axi_arqos(auto_us_df_to_s04_couplers_ARQOS),
        .m_axi_arready(auto_us_df_to_s04_couplers_ARREADY),
        .m_axi_arsize(auto_us_df_to_s04_couplers_ARSIZE),
        .m_axi_arvalid(auto_us_df_to_s04_couplers_ARVALID),
        .m_axi_rdata(auto_us_df_to_s04_couplers_RDATA),
        .m_axi_rlast(auto_us_df_to_s04_couplers_RLAST),
        .m_axi_rready(auto_us_df_to_s04_couplers_RREADY),
        .m_axi_rresp(auto_us_df_to_s04_couplers_RRESP),
        .m_axi_rvalid(auto_us_df_to_s04_couplers_RVALID),
        .s_axi_aclk(S_ACLK_1),
        .s_axi_araddr(auto_pc_to_auto_us_df_ARADDR),
        .s_axi_arburst(auto_pc_to_auto_us_df_ARBURST),
        .s_axi_arcache(auto_pc_to_auto_us_df_ARCACHE),
        .s_axi_aresetn(S_ARESETN_1),
        .s_axi_arlen(auto_pc_to_auto_us_df_ARLEN),
        .s_axi_arlock(auto_pc_to_auto_us_df_ARLOCK),
        .s_axi_arprot(auto_pc_to_auto_us_df_ARPROT),
        .s_axi_arqos(auto_pc_to_auto_us_df_ARQOS),
        .s_axi_arready(auto_pc_to_auto_us_df_ARREADY),
        .s_axi_arregion(auto_pc_to_auto_us_df_ARREGION),
        .s_axi_arsize(auto_pc_to_auto_us_df_ARSIZE),
        .s_axi_arvalid(auto_pc_to_auto_us_df_ARVALID),
        .s_axi_rdata(auto_pc_to_auto_us_df_RDATA),
        .s_axi_rlast(auto_pc_to_auto_us_df_RLAST),
        .s_axi_rready(auto_pc_to_auto_us_df_RREADY),
        .s_axi_rresp(auto_pc_to_auto_us_df_RRESP),
        .s_axi_rvalid(auto_pc_to_auto_us_df_RVALID));
endmodule

module s05_couplers_imp_9VZVAD
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arburst,
    M_AXI_arcache,
    M_AXI_arlen,
    M_AXI_arlock,
    M_AXI_arprot,
    M_AXI_arqos,
    M_AXI_arready,
    M_AXI_arsize,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awburst,
    M_AXI_awcache,
    M_AXI_awlen,
    M_AXI_awlock,
    M_AXI_awprot,
    M_AXI_awqos,
    M_AXI_awready,
    M_AXI_awsize,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rlast,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wlast,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arburst,
    S_AXI_arcache,
    S_AXI_arid,
    S_AXI_arlen,
    S_AXI_arlock,
    S_AXI_arprot,
    S_AXI_arqos,
    S_AXI_arready,
    S_AXI_arsize,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awburst,
    S_AXI_awcache,
    S_AXI_awid,
    S_AXI_awlen,
    S_AXI_awlock,
    S_AXI_awprot,
    S_AXI_awqos,
    S_AXI_awready,
    S_AXI_awsize,
    S_AXI_awvalid,
    S_AXI_bid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rid,
    S_AXI_rlast,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wlast,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input [0:0]M_ARESETN;
  output [31:0]M_AXI_araddr;
  output [1:0]M_AXI_arburst;
  output [3:0]M_AXI_arcache;
  output [7:0]M_AXI_arlen;
  output [0:0]M_AXI_arlock;
  output [2:0]M_AXI_arprot;
  output [3:0]M_AXI_arqos;
  input M_AXI_arready;
  output [2:0]M_AXI_arsize;
  output M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  output [1:0]M_AXI_awburst;
  output [3:0]M_AXI_awcache;
  output [7:0]M_AXI_awlen;
  output [0:0]M_AXI_awlock;
  output [2:0]M_AXI_awprot;
  output [3:0]M_AXI_awqos;
  input M_AXI_awready;
  output [2:0]M_AXI_awsize;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [511:0]M_AXI_rdata;
  input M_AXI_rlast;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [511:0]M_AXI_wdata;
  output M_AXI_wlast;
  input M_AXI_wready;
  output [63:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input [0:0]S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [1:0]S_AXI_arburst;
  input [3:0]S_AXI_arcache;
  input [0:0]S_AXI_arid;
  input [7:0]S_AXI_arlen;
  input S_AXI_arlock;
  input [2:0]S_AXI_arprot;
  input [3:0]S_AXI_arqos;
  output S_AXI_arready;
  input [2:0]S_AXI_arsize;
  input S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  input [1:0]S_AXI_awburst;
  input [3:0]S_AXI_awcache;
  input [0:0]S_AXI_awid;
  input [7:0]S_AXI_awlen;
  input S_AXI_awlock;
  input [2:0]S_AXI_awprot;
  input [3:0]S_AXI_awqos;
  output S_AXI_awready;
  input [2:0]S_AXI_awsize;
  input S_AXI_awvalid;
  output [0:0]S_AXI_bid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [31:0]S_AXI_rdata;
  output [0:0]S_AXI_rid;
  output S_AXI_rlast;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [31:0]S_AXI_wdata;
  input S_AXI_wlast;
  output S_AXI_wready;
  input [3:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire M_ACLK_1;
  wire [0:0]M_ARESETN_1;
  wire S_ACLK_1;
  wire [0:0]S_ARESETN_1;
  wire [31:0]auto_us_df_to_s05_couplers_ARADDR;
  wire [1:0]auto_us_df_to_s05_couplers_ARBURST;
  wire [3:0]auto_us_df_to_s05_couplers_ARCACHE;
  wire [7:0]auto_us_df_to_s05_couplers_ARLEN;
  wire [0:0]auto_us_df_to_s05_couplers_ARLOCK;
  wire [2:0]auto_us_df_to_s05_couplers_ARPROT;
  wire [3:0]auto_us_df_to_s05_couplers_ARQOS;
  wire auto_us_df_to_s05_couplers_ARREADY;
  wire [2:0]auto_us_df_to_s05_couplers_ARSIZE;
  wire auto_us_df_to_s05_couplers_ARVALID;
  wire [31:0]auto_us_df_to_s05_couplers_AWADDR;
  wire [1:0]auto_us_df_to_s05_couplers_AWBURST;
  wire [3:0]auto_us_df_to_s05_couplers_AWCACHE;
  wire [7:0]auto_us_df_to_s05_couplers_AWLEN;
  wire [0:0]auto_us_df_to_s05_couplers_AWLOCK;
  wire [2:0]auto_us_df_to_s05_couplers_AWPROT;
  wire [3:0]auto_us_df_to_s05_couplers_AWQOS;
  wire auto_us_df_to_s05_couplers_AWREADY;
  wire [2:0]auto_us_df_to_s05_couplers_AWSIZE;
  wire auto_us_df_to_s05_couplers_AWVALID;
  wire auto_us_df_to_s05_couplers_BREADY;
  wire [1:0]auto_us_df_to_s05_couplers_BRESP;
  wire auto_us_df_to_s05_couplers_BVALID;
  wire [511:0]auto_us_df_to_s05_couplers_RDATA;
  wire auto_us_df_to_s05_couplers_RLAST;
  wire auto_us_df_to_s05_couplers_RREADY;
  wire [1:0]auto_us_df_to_s05_couplers_RRESP;
  wire auto_us_df_to_s05_couplers_RVALID;
  wire [511:0]auto_us_df_to_s05_couplers_WDATA;
  wire auto_us_df_to_s05_couplers_WLAST;
  wire auto_us_df_to_s05_couplers_WREADY;
  wire [63:0]auto_us_df_to_s05_couplers_WSTRB;
  wire auto_us_df_to_s05_couplers_WVALID;
  wire [31:0]s05_couplers_to_auto_us_df_ARADDR;
  wire [1:0]s05_couplers_to_auto_us_df_ARBURST;
  wire [3:0]s05_couplers_to_auto_us_df_ARCACHE;
  wire [0:0]s05_couplers_to_auto_us_df_ARID;
  wire [7:0]s05_couplers_to_auto_us_df_ARLEN;
  wire s05_couplers_to_auto_us_df_ARLOCK;
  wire [2:0]s05_couplers_to_auto_us_df_ARPROT;
  wire [3:0]s05_couplers_to_auto_us_df_ARQOS;
  wire s05_couplers_to_auto_us_df_ARREADY;
  wire [2:0]s05_couplers_to_auto_us_df_ARSIZE;
  wire s05_couplers_to_auto_us_df_ARVALID;
  wire [31:0]s05_couplers_to_auto_us_df_AWADDR;
  wire [1:0]s05_couplers_to_auto_us_df_AWBURST;
  wire [3:0]s05_couplers_to_auto_us_df_AWCACHE;
  wire [0:0]s05_couplers_to_auto_us_df_AWID;
  wire [7:0]s05_couplers_to_auto_us_df_AWLEN;
  wire s05_couplers_to_auto_us_df_AWLOCK;
  wire [2:0]s05_couplers_to_auto_us_df_AWPROT;
  wire [3:0]s05_couplers_to_auto_us_df_AWQOS;
  wire s05_couplers_to_auto_us_df_AWREADY;
  wire [2:0]s05_couplers_to_auto_us_df_AWSIZE;
  wire s05_couplers_to_auto_us_df_AWVALID;
  wire [0:0]s05_couplers_to_auto_us_df_BID;
  wire s05_couplers_to_auto_us_df_BREADY;
  wire [1:0]s05_couplers_to_auto_us_df_BRESP;
  wire s05_couplers_to_auto_us_df_BVALID;
  wire [31:0]s05_couplers_to_auto_us_df_RDATA;
  wire [0:0]s05_couplers_to_auto_us_df_RID;
  wire s05_couplers_to_auto_us_df_RLAST;
  wire s05_couplers_to_auto_us_df_RREADY;
  wire [1:0]s05_couplers_to_auto_us_df_RRESP;
  wire s05_couplers_to_auto_us_df_RVALID;
  wire [31:0]s05_couplers_to_auto_us_df_WDATA;
  wire s05_couplers_to_auto_us_df_WLAST;
  wire s05_couplers_to_auto_us_df_WREADY;
  wire [3:0]s05_couplers_to_auto_us_df_WSTRB;
  wire s05_couplers_to_auto_us_df_WVALID;

  assign M_ACLK_1 = M_ACLK;
  assign M_ARESETN_1 = M_ARESETN[0];
  assign M_AXI_araddr[31:0] = auto_us_df_to_s05_couplers_ARADDR;
  assign M_AXI_arburst[1:0] = auto_us_df_to_s05_couplers_ARBURST;
  assign M_AXI_arcache[3:0] = auto_us_df_to_s05_couplers_ARCACHE;
  assign M_AXI_arlen[7:0] = auto_us_df_to_s05_couplers_ARLEN;
  assign M_AXI_arlock[0] = auto_us_df_to_s05_couplers_ARLOCK;
  assign M_AXI_arprot[2:0] = auto_us_df_to_s05_couplers_ARPROT;
  assign M_AXI_arqos[3:0] = auto_us_df_to_s05_couplers_ARQOS;
  assign M_AXI_arsize[2:0] = auto_us_df_to_s05_couplers_ARSIZE;
  assign M_AXI_arvalid = auto_us_df_to_s05_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = auto_us_df_to_s05_couplers_AWADDR;
  assign M_AXI_awburst[1:0] = auto_us_df_to_s05_couplers_AWBURST;
  assign M_AXI_awcache[3:0] = auto_us_df_to_s05_couplers_AWCACHE;
  assign M_AXI_awlen[7:0] = auto_us_df_to_s05_couplers_AWLEN;
  assign M_AXI_awlock[0] = auto_us_df_to_s05_couplers_AWLOCK;
  assign M_AXI_awprot[2:0] = auto_us_df_to_s05_couplers_AWPROT;
  assign M_AXI_awqos[3:0] = auto_us_df_to_s05_couplers_AWQOS;
  assign M_AXI_awsize[2:0] = auto_us_df_to_s05_couplers_AWSIZE;
  assign M_AXI_awvalid = auto_us_df_to_s05_couplers_AWVALID;
  assign M_AXI_bready = auto_us_df_to_s05_couplers_BREADY;
  assign M_AXI_rready = auto_us_df_to_s05_couplers_RREADY;
  assign M_AXI_wdata[511:0] = auto_us_df_to_s05_couplers_WDATA;
  assign M_AXI_wlast = auto_us_df_to_s05_couplers_WLAST;
  assign M_AXI_wstrb[63:0] = auto_us_df_to_s05_couplers_WSTRB;
  assign M_AXI_wvalid = auto_us_df_to_s05_couplers_WVALID;
  assign S_ACLK_1 = S_ACLK;
  assign S_ARESETN_1 = S_ARESETN[0];
  assign S_AXI_arready = s05_couplers_to_auto_us_df_ARREADY;
  assign S_AXI_awready = s05_couplers_to_auto_us_df_AWREADY;
  assign S_AXI_bid[0] = s05_couplers_to_auto_us_df_BID;
  assign S_AXI_bresp[1:0] = s05_couplers_to_auto_us_df_BRESP;
  assign S_AXI_bvalid = s05_couplers_to_auto_us_df_BVALID;
  assign S_AXI_rdata[31:0] = s05_couplers_to_auto_us_df_RDATA;
  assign S_AXI_rid[0] = s05_couplers_to_auto_us_df_RID;
  assign S_AXI_rlast = s05_couplers_to_auto_us_df_RLAST;
  assign S_AXI_rresp[1:0] = s05_couplers_to_auto_us_df_RRESP;
  assign S_AXI_rvalid = s05_couplers_to_auto_us_df_RVALID;
  assign S_AXI_wready = s05_couplers_to_auto_us_df_WREADY;
  assign auto_us_df_to_s05_couplers_ARREADY = M_AXI_arready;
  assign auto_us_df_to_s05_couplers_AWREADY = M_AXI_awready;
  assign auto_us_df_to_s05_couplers_BRESP = M_AXI_bresp[1:0];
  assign auto_us_df_to_s05_couplers_BVALID = M_AXI_bvalid;
  assign auto_us_df_to_s05_couplers_RDATA = M_AXI_rdata[511:0];
  assign auto_us_df_to_s05_couplers_RLAST = M_AXI_rlast;
  assign auto_us_df_to_s05_couplers_RRESP = M_AXI_rresp[1:0];
  assign auto_us_df_to_s05_couplers_RVALID = M_AXI_rvalid;
  assign auto_us_df_to_s05_couplers_WREADY = M_AXI_wready;
  assign s05_couplers_to_auto_us_df_ARADDR = S_AXI_araddr[31:0];
  assign s05_couplers_to_auto_us_df_ARBURST = S_AXI_arburst[1:0];
  assign s05_couplers_to_auto_us_df_ARCACHE = S_AXI_arcache[3:0];
  assign s05_couplers_to_auto_us_df_ARID = S_AXI_arid[0];
  assign s05_couplers_to_auto_us_df_ARLEN = S_AXI_arlen[7:0];
  assign s05_couplers_to_auto_us_df_ARLOCK = S_AXI_arlock;
  assign s05_couplers_to_auto_us_df_ARPROT = S_AXI_arprot[2:0];
  assign s05_couplers_to_auto_us_df_ARQOS = S_AXI_arqos[3:0];
  assign s05_couplers_to_auto_us_df_ARSIZE = S_AXI_arsize[2:0];
  assign s05_couplers_to_auto_us_df_ARVALID = S_AXI_arvalid;
  assign s05_couplers_to_auto_us_df_AWADDR = S_AXI_awaddr[31:0];
  assign s05_couplers_to_auto_us_df_AWBURST = S_AXI_awburst[1:0];
  assign s05_couplers_to_auto_us_df_AWCACHE = S_AXI_awcache[3:0];
  assign s05_couplers_to_auto_us_df_AWID = S_AXI_awid[0];
  assign s05_couplers_to_auto_us_df_AWLEN = S_AXI_awlen[7:0];
  assign s05_couplers_to_auto_us_df_AWLOCK = S_AXI_awlock;
  assign s05_couplers_to_auto_us_df_AWPROT = S_AXI_awprot[2:0];
  assign s05_couplers_to_auto_us_df_AWQOS = S_AXI_awqos[3:0];
  assign s05_couplers_to_auto_us_df_AWSIZE = S_AXI_awsize[2:0];
  assign s05_couplers_to_auto_us_df_AWVALID = S_AXI_awvalid;
  assign s05_couplers_to_auto_us_df_BREADY = S_AXI_bready;
  assign s05_couplers_to_auto_us_df_RREADY = S_AXI_rready;
  assign s05_couplers_to_auto_us_df_WDATA = S_AXI_wdata[31:0];
  assign s05_couplers_to_auto_us_df_WLAST = S_AXI_wlast;
  assign s05_couplers_to_auto_us_df_WSTRB = S_AXI_wstrb[3:0];
  assign s05_couplers_to_auto_us_df_WVALID = S_AXI_wvalid;
  system_i_bak_auto_us_df_1 auto_us_df
       (.m_axi_araddr(auto_us_df_to_s05_couplers_ARADDR),
        .m_axi_arburst(auto_us_df_to_s05_couplers_ARBURST),
        .m_axi_arcache(auto_us_df_to_s05_couplers_ARCACHE),
        .m_axi_arlen(auto_us_df_to_s05_couplers_ARLEN),
        .m_axi_arlock(auto_us_df_to_s05_couplers_ARLOCK),
        .m_axi_arprot(auto_us_df_to_s05_couplers_ARPROT),
        .m_axi_arqos(auto_us_df_to_s05_couplers_ARQOS),
        .m_axi_arready(auto_us_df_to_s05_couplers_ARREADY),
        .m_axi_arsize(auto_us_df_to_s05_couplers_ARSIZE),
        .m_axi_arvalid(auto_us_df_to_s05_couplers_ARVALID),
        .m_axi_awaddr(auto_us_df_to_s05_couplers_AWADDR),
        .m_axi_awburst(auto_us_df_to_s05_couplers_AWBURST),
        .m_axi_awcache(auto_us_df_to_s05_couplers_AWCACHE),
        .m_axi_awlen(auto_us_df_to_s05_couplers_AWLEN),
        .m_axi_awlock(auto_us_df_to_s05_couplers_AWLOCK),
        .m_axi_awprot(auto_us_df_to_s05_couplers_AWPROT),
        .m_axi_awqos(auto_us_df_to_s05_couplers_AWQOS),
        .m_axi_awready(auto_us_df_to_s05_couplers_AWREADY),
        .m_axi_awsize(auto_us_df_to_s05_couplers_AWSIZE),
        .m_axi_awvalid(auto_us_df_to_s05_couplers_AWVALID),
        .m_axi_bready(auto_us_df_to_s05_couplers_BREADY),
        .m_axi_bresp(auto_us_df_to_s05_couplers_BRESP),
        .m_axi_bvalid(auto_us_df_to_s05_couplers_BVALID),
        .m_axi_rdata(auto_us_df_to_s05_couplers_RDATA),
        .m_axi_rlast(auto_us_df_to_s05_couplers_RLAST),
        .m_axi_rready(auto_us_df_to_s05_couplers_RREADY),
        .m_axi_rresp(auto_us_df_to_s05_couplers_RRESP),
        .m_axi_rvalid(auto_us_df_to_s05_couplers_RVALID),
        .m_axi_wdata(auto_us_df_to_s05_couplers_WDATA),
        .m_axi_wlast(auto_us_df_to_s05_couplers_WLAST),
        .m_axi_wready(auto_us_df_to_s05_couplers_WREADY),
        .m_axi_wstrb(auto_us_df_to_s05_couplers_WSTRB),
        .m_axi_wvalid(auto_us_df_to_s05_couplers_WVALID),
        .s_axi_aclk(S_ACLK_1),
        .s_axi_araddr(s05_couplers_to_auto_us_df_ARADDR),
        .s_axi_arburst(s05_couplers_to_auto_us_df_ARBURST),
        .s_axi_arcache(s05_couplers_to_auto_us_df_ARCACHE),
        .s_axi_aresetn(S_ARESETN_1),
        .s_axi_arid(s05_couplers_to_auto_us_df_ARID),
        .s_axi_arlen(s05_couplers_to_auto_us_df_ARLEN),
        .s_axi_arlock(s05_couplers_to_auto_us_df_ARLOCK),
        .s_axi_arprot(s05_couplers_to_auto_us_df_ARPROT),
        .s_axi_arqos(s05_couplers_to_auto_us_df_ARQOS),
        .s_axi_arready(s05_couplers_to_auto_us_df_ARREADY),
        .s_axi_arregion({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arsize(s05_couplers_to_auto_us_df_ARSIZE),
        .s_axi_arvalid(s05_couplers_to_auto_us_df_ARVALID),
        .s_axi_awaddr(s05_couplers_to_auto_us_df_AWADDR),
        .s_axi_awburst(s05_couplers_to_auto_us_df_AWBURST),
        .s_axi_awcache(s05_couplers_to_auto_us_df_AWCACHE),
        .s_axi_awid(s05_couplers_to_auto_us_df_AWID),
        .s_axi_awlen(s05_couplers_to_auto_us_df_AWLEN),
        .s_axi_awlock(s05_couplers_to_auto_us_df_AWLOCK),
        .s_axi_awprot(s05_couplers_to_auto_us_df_AWPROT),
        .s_axi_awqos(s05_couplers_to_auto_us_df_AWQOS),
        .s_axi_awready(s05_couplers_to_auto_us_df_AWREADY),
        .s_axi_awregion({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awsize(s05_couplers_to_auto_us_df_AWSIZE),
        .s_axi_awvalid(s05_couplers_to_auto_us_df_AWVALID),
        .s_axi_bid(s05_couplers_to_auto_us_df_BID),
        .s_axi_bready(s05_couplers_to_auto_us_df_BREADY),
        .s_axi_bresp(s05_couplers_to_auto_us_df_BRESP),
        .s_axi_bvalid(s05_couplers_to_auto_us_df_BVALID),
        .s_axi_rdata(s05_couplers_to_auto_us_df_RDATA),
        .s_axi_rid(s05_couplers_to_auto_us_df_RID),
        .s_axi_rlast(s05_couplers_to_auto_us_df_RLAST),
        .s_axi_rready(s05_couplers_to_auto_us_df_RREADY),
        .s_axi_rresp(s05_couplers_to_auto_us_df_RRESP),
        .s_axi_rvalid(s05_couplers_to_auto_us_df_RVALID),
        .s_axi_wdata(s05_couplers_to_auto_us_df_WDATA),
        .s_axi_wlast(s05_couplers_to_auto_us_df_WLAST),
        .s_axi_wready(s05_couplers_to_auto_us_df_WREADY),
        .s_axi_wstrb(s05_couplers_to_auto_us_df_WSTRB),
        .s_axi_wvalid(s05_couplers_to_auto_us_df_WVALID));
endmodule

module s06_couplers_imp_7G9LK5
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arburst,
    M_AXI_arcache,
    M_AXI_arlen,
    M_AXI_arlock,
    M_AXI_arprot,
    M_AXI_arqos,
    M_AXI_arready,
    M_AXI_arsize,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awburst,
    M_AXI_awcache,
    M_AXI_awlen,
    M_AXI_awlock,
    M_AXI_awprot,
    M_AXI_awqos,
    M_AXI_awready,
    M_AXI_awsize,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rlast,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wlast,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arburst,
    S_AXI_arcache,
    S_AXI_arid,
    S_AXI_arlen,
    S_AXI_arlock,
    S_AXI_arprot,
    S_AXI_arqos,
    S_AXI_arready,
    S_AXI_arsize,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awburst,
    S_AXI_awcache,
    S_AXI_awid,
    S_AXI_awlen,
    S_AXI_awlock,
    S_AXI_awprot,
    S_AXI_awqos,
    S_AXI_awready,
    S_AXI_awsize,
    S_AXI_awvalid,
    S_AXI_bid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rid,
    S_AXI_rlast,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wlast,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input [0:0]M_ARESETN;
  output [31:0]M_AXI_araddr;
  output [1:0]M_AXI_arburst;
  output [3:0]M_AXI_arcache;
  output [7:0]M_AXI_arlen;
  output [0:0]M_AXI_arlock;
  output [2:0]M_AXI_arprot;
  output [3:0]M_AXI_arqos;
  input M_AXI_arready;
  output [2:0]M_AXI_arsize;
  output M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  output [1:0]M_AXI_awburst;
  output [3:0]M_AXI_awcache;
  output [7:0]M_AXI_awlen;
  output [0:0]M_AXI_awlock;
  output [2:0]M_AXI_awprot;
  output [3:0]M_AXI_awqos;
  input M_AXI_awready;
  output [2:0]M_AXI_awsize;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [511:0]M_AXI_rdata;
  input M_AXI_rlast;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [511:0]M_AXI_wdata;
  output M_AXI_wlast;
  input M_AXI_wready;
  output [63:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input [0:0]S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [1:0]S_AXI_arburst;
  input [3:0]S_AXI_arcache;
  input [0:0]S_AXI_arid;
  input [7:0]S_AXI_arlen;
  input S_AXI_arlock;
  input [2:0]S_AXI_arprot;
  input [3:0]S_AXI_arqos;
  output S_AXI_arready;
  input [2:0]S_AXI_arsize;
  input S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  input [1:0]S_AXI_awburst;
  input [3:0]S_AXI_awcache;
  input [0:0]S_AXI_awid;
  input [7:0]S_AXI_awlen;
  input S_AXI_awlock;
  input [2:0]S_AXI_awprot;
  input [3:0]S_AXI_awqos;
  output S_AXI_awready;
  input [2:0]S_AXI_awsize;
  input S_AXI_awvalid;
  output [0:0]S_AXI_bid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [31:0]S_AXI_rdata;
  output [0:0]S_AXI_rid;
  output S_AXI_rlast;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [31:0]S_AXI_wdata;
  input S_AXI_wlast;
  output S_AXI_wready;
  input [3:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire M_ACLK_1;
  wire [0:0]M_ARESETN_1;
  wire S_ACLK_1;
  wire [0:0]S_ARESETN_1;
  wire [31:0]auto_us_df_to_s06_couplers_ARADDR;
  wire [1:0]auto_us_df_to_s06_couplers_ARBURST;
  wire [3:0]auto_us_df_to_s06_couplers_ARCACHE;
  wire [7:0]auto_us_df_to_s06_couplers_ARLEN;
  wire [0:0]auto_us_df_to_s06_couplers_ARLOCK;
  wire [2:0]auto_us_df_to_s06_couplers_ARPROT;
  wire [3:0]auto_us_df_to_s06_couplers_ARQOS;
  wire auto_us_df_to_s06_couplers_ARREADY;
  wire [2:0]auto_us_df_to_s06_couplers_ARSIZE;
  wire auto_us_df_to_s06_couplers_ARVALID;
  wire [31:0]auto_us_df_to_s06_couplers_AWADDR;
  wire [1:0]auto_us_df_to_s06_couplers_AWBURST;
  wire [3:0]auto_us_df_to_s06_couplers_AWCACHE;
  wire [7:0]auto_us_df_to_s06_couplers_AWLEN;
  wire [0:0]auto_us_df_to_s06_couplers_AWLOCK;
  wire [2:0]auto_us_df_to_s06_couplers_AWPROT;
  wire [3:0]auto_us_df_to_s06_couplers_AWQOS;
  wire auto_us_df_to_s06_couplers_AWREADY;
  wire [2:0]auto_us_df_to_s06_couplers_AWSIZE;
  wire auto_us_df_to_s06_couplers_AWVALID;
  wire auto_us_df_to_s06_couplers_BREADY;
  wire [1:0]auto_us_df_to_s06_couplers_BRESP;
  wire auto_us_df_to_s06_couplers_BVALID;
  wire [511:0]auto_us_df_to_s06_couplers_RDATA;
  wire auto_us_df_to_s06_couplers_RLAST;
  wire auto_us_df_to_s06_couplers_RREADY;
  wire [1:0]auto_us_df_to_s06_couplers_RRESP;
  wire auto_us_df_to_s06_couplers_RVALID;
  wire [511:0]auto_us_df_to_s06_couplers_WDATA;
  wire auto_us_df_to_s06_couplers_WLAST;
  wire auto_us_df_to_s06_couplers_WREADY;
  wire [63:0]auto_us_df_to_s06_couplers_WSTRB;
  wire auto_us_df_to_s06_couplers_WVALID;
  wire [31:0]s06_couplers_to_auto_us_df_ARADDR;
  wire [1:0]s06_couplers_to_auto_us_df_ARBURST;
  wire [3:0]s06_couplers_to_auto_us_df_ARCACHE;
  wire [0:0]s06_couplers_to_auto_us_df_ARID;
  wire [7:0]s06_couplers_to_auto_us_df_ARLEN;
  wire s06_couplers_to_auto_us_df_ARLOCK;
  wire [2:0]s06_couplers_to_auto_us_df_ARPROT;
  wire [3:0]s06_couplers_to_auto_us_df_ARQOS;
  wire s06_couplers_to_auto_us_df_ARREADY;
  wire [2:0]s06_couplers_to_auto_us_df_ARSIZE;
  wire s06_couplers_to_auto_us_df_ARVALID;
  wire [31:0]s06_couplers_to_auto_us_df_AWADDR;
  wire [1:0]s06_couplers_to_auto_us_df_AWBURST;
  wire [3:0]s06_couplers_to_auto_us_df_AWCACHE;
  wire [0:0]s06_couplers_to_auto_us_df_AWID;
  wire [7:0]s06_couplers_to_auto_us_df_AWLEN;
  wire s06_couplers_to_auto_us_df_AWLOCK;
  wire [2:0]s06_couplers_to_auto_us_df_AWPROT;
  wire [3:0]s06_couplers_to_auto_us_df_AWQOS;
  wire s06_couplers_to_auto_us_df_AWREADY;
  wire [2:0]s06_couplers_to_auto_us_df_AWSIZE;
  wire s06_couplers_to_auto_us_df_AWVALID;
  wire [0:0]s06_couplers_to_auto_us_df_BID;
  wire s06_couplers_to_auto_us_df_BREADY;
  wire [1:0]s06_couplers_to_auto_us_df_BRESP;
  wire s06_couplers_to_auto_us_df_BVALID;
  wire [31:0]s06_couplers_to_auto_us_df_RDATA;
  wire [0:0]s06_couplers_to_auto_us_df_RID;
  wire s06_couplers_to_auto_us_df_RLAST;
  wire s06_couplers_to_auto_us_df_RREADY;
  wire [1:0]s06_couplers_to_auto_us_df_RRESP;
  wire s06_couplers_to_auto_us_df_RVALID;
  wire [31:0]s06_couplers_to_auto_us_df_WDATA;
  wire s06_couplers_to_auto_us_df_WLAST;
  wire s06_couplers_to_auto_us_df_WREADY;
  wire [3:0]s06_couplers_to_auto_us_df_WSTRB;
  wire s06_couplers_to_auto_us_df_WVALID;

  assign M_ACLK_1 = M_ACLK;
  assign M_ARESETN_1 = M_ARESETN[0];
  assign M_AXI_araddr[31:0] = auto_us_df_to_s06_couplers_ARADDR;
  assign M_AXI_arburst[1:0] = auto_us_df_to_s06_couplers_ARBURST;
  assign M_AXI_arcache[3:0] = auto_us_df_to_s06_couplers_ARCACHE;
  assign M_AXI_arlen[7:0] = auto_us_df_to_s06_couplers_ARLEN;
  assign M_AXI_arlock[0] = auto_us_df_to_s06_couplers_ARLOCK;
  assign M_AXI_arprot[2:0] = auto_us_df_to_s06_couplers_ARPROT;
  assign M_AXI_arqos[3:0] = auto_us_df_to_s06_couplers_ARQOS;
  assign M_AXI_arsize[2:0] = auto_us_df_to_s06_couplers_ARSIZE;
  assign M_AXI_arvalid = auto_us_df_to_s06_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = auto_us_df_to_s06_couplers_AWADDR;
  assign M_AXI_awburst[1:0] = auto_us_df_to_s06_couplers_AWBURST;
  assign M_AXI_awcache[3:0] = auto_us_df_to_s06_couplers_AWCACHE;
  assign M_AXI_awlen[7:0] = auto_us_df_to_s06_couplers_AWLEN;
  assign M_AXI_awlock[0] = auto_us_df_to_s06_couplers_AWLOCK;
  assign M_AXI_awprot[2:0] = auto_us_df_to_s06_couplers_AWPROT;
  assign M_AXI_awqos[3:0] = auto_us_df_to_s06_couplers_AWQOS;
  assign M_AXI_awsize[2:0] = auto_us_df_to_s06_couplers_AWSIZE;
  assign M_AXI_awvalid = auto_us_df_to_s06_couplers_AWVALID;
  assign M_AXI_bready = auto_us_df_to_s06_couplers_BREADY;
  assign M_AXI_rready = auto_us_df_to_s06_couplers_RREADY;
  assign M_AXI_wdata[511:0] = auto_us_df_to_s06_couplers_WDATA;
  assign M_AXI_wlast = auto_us_df_to_s06_couplers_WLAST;
  assign M_AXI_wstrb[63:0] = auto_us_df_to_s06_couplers_WSTRB;
  assign M_AXI_wvalid = auto_us_df_to_s06_couplers_WVALID;
  assign S_ACLK_1 = S_ACLK;
  assign S_ARESETN_1 = S_ARESETN[0];
  assign S_AXI_arready = s06_couplers_to_auto_us_df_ARREADY;
  assign S_AXI_awready = s06_couplers_to_auto_us_df_AWREADY;
  assign S_AXI_bid[0] = s06_couplers_to_auto_us_df_BID;
  assign S_AXI_bresp[1:0] = s06_couplers_to_auto_us_df_BRESP;
  assign S_AXI_bvalid = s06_couplers_to_auto_us_df_BVALID;
  assign S_AXI_rdata[31:0] = s06_couplers_to_auto_us_df_RDATA;
  assign S_AXI_rid[0] = s06_couplers_to_auto_us_df_RID;
  assign S_AXI_rlast = s06_couplers_to_auto_us_df_RLAST;
  assign S_AXI_rresp[1:0] = s06_couplers_to_auto_us_df_RRESP;
  assign S_AXI_rvalid = s06_couplers_to_auto_us_df_RVALID;
  assign S_AXI_wready = s06_couplers_to_auto_us_df_WREADY;
  assign auto_us_df_to_s06_couplers_ARREADY = M_AXI_arready;
  assign auto_us_df_to_s06_couplers_AWREADY = M_AXI_awready;
  assign auto_us_df_to_s06_couplers_BRESP = M_AXI_bresp[1:0];
  assign auto_us_df_to_s06_couplers_BVALID = M_AXI_bvalid;
  assign auto_us_df_to_s06_couplers_RDATA = M_AXI_rdata[511:0];
  assign auto_us_df_to_s06_couplers_RLAST = M_AXI_rlast;
  assign auto_us_df_to_s06_couplers_RRESP = M_AXI_rresp[1:0];
  assign auto_us_df_to_s06_couplers_RVALID = M_AXI_rvalid;
  assign auto_us_df_to_s06_couplers_WREADY = M_AXI_wready;
  assign s06_couplers_to_auto_us_df_ARADDR = S_AXI_araddr[31:0];
  assign s06_couplers_to_auto_us_df_ARBURST = S_AXI_arburst[1:0];
  assign s06_couplers_to_auto_us_df_ARCACHE = S_AXI_arcache[3:0];
  assign s06_couplers_to_auto_us_df_ARID = S_AXI_arid[0];
  assign s06_couplers_to_auto_us_df_ARLEN = S_AXI_arlen[7:0];
  assign s06_couplers_to_auto_us_df_ARLOCK = S_AXI_arlock;
  assign s06_couplers_to_auto_us_df_ARPROT = S_AXI_arprot[2:0];
  assign s06_couplers_to_auto_us_df_ARQOS = S_AXI_arqos[3:0];
  assign s06_couplers_to_auto_us_df_ARSIZE = S_AXI_arsize[2:0];
  assign s06_couplers_to_auto_us_df_ARVALID = S_AXI_arvalid;
  assign s06_couplers_to_auto_us_df_AWADDR = S_AXI_awaddr[31:0];
  assign s06_couplers_to_auto_us_df_AWBURST = S_AXI_awburst[1:0];
  assign s06_couplers_to_auto_us_df_AWCACHE = S_AXI_awcache[3:0];
  assign s06_couplers_to_auto_us_df_AWID = S_AXI_awid[0];
  assign s06_couplers_to_auto_us_df_AWLEN = S_AXI_awlen[7:0];
  assign s06_couplers_to_auto_us_df_AWLOCK = S_AXI_awlock;
  assign s06_couplers_to_auto_us_df_AWPROT = S_AXI_awprot[2:0];
  assign s06_couplers_to_auto_us_df_AWQOS = S_AXI_awqos[3:0];
  assign s06_couplers_to_auto_us_df_AWSIZE = S_AXI_awsize[2:0];
  assign s06_couplers_to_auto_us_df_AWVALID = S_AXI_awvalid;
  assign s06_couplers_to_auto_us_df_BREADY = S_AXI_bready;
  assign s06_couplers_to_auto_us_df_RREADY = S_AXI_rready;
  assign s06_couplers_to_auto_us_df_WDATA = S_AXI_wdata[31:0];
  assign s06_couplers_to_auto_us_df_WLAST = S_AXI_wlast;
  assign s06_couplers_to_auto_us_df_WSTRB = S_AXI_wstrb[3:0];
  assign s06_couplers_to_auto_us_df_WVALID = S_AXI_wvalid;
  system_i_bak_auto_us_df_2 auto_us_df
       (.m_axi_araddr(auto_us_df_to_s06_couplers_ARADDR),
        .m_axi_arburst(auto_us_df_to_s06_couplers_ARBURST),
        .m_axi_arcache(auto_us_df_to_s06_couplers_ARCACHE),
        .m_axi_arlen(auto_us_df_to_s06_couplers_ARLEN),
        .m_axi_arlock(auto_us_df_to_s06_couplers_ARLOCK),
        .m_axi_arprot(auto_us_df_to_s06_couplers_ARPROT),
        .m_axi_arqos(auto_us_df_to_s06_couplers_ARQOS),
        .m_axi_arready(auto_us_df_to_s06_couplers_ARREADY),
        .m_axi_arsize(auto_us_df_to_s06_couplers_ARSIZE),
        .m_axi_arvalid(auto_us_df_to_s06_couplers_ARVALID),
        .m_axi_awaddr(auto_us_df_to_s06_couplers_AWADDR),
        .m_axi_awburst(auto_us_df_to_s06_couplers_AWBURST),
        .m_axi_awcache(auto_us_df_to_s06_couplers_AWCACHE),
        .m_axi_awlen(auto_us_df_to_s06_couplers_AWLEN),
        .m_axi_awlock(auto_us_df_to_s06_couplers_AWLOCK),
        .m_axi_awprot(auto_us_df_to_s06_couplers_AWPROT),
        .m_axi_awqos(auto_us_df_to_s06_couplers_AWQOS),
        .m_axi_awready(auto_us_df_to_s06_couplers_AWREADY),
        .m_axi_awsize(auto_us_df_to_s06_couplers_AWSIZE),
        .m_axi_awvalid(auto_us_df_to_s06_couplers_AWVALID),
        .m_axi_bready(auto_us_df_to_s06_couplers_BREADY),
        .m_axi_bresp(auto_us_df_to_s06_couplers_BRESP),
        .m_axi_bvalid(auto_us_df_to_s06_couplers_BVALID),
        .m_axi_rdata(auto_us_df_to_s06_couplers_RDATA),
        .m_axi_rlast(auto_us_df_to_s06_couplers_RLAST),
        .m_axi_rready(auto_us_df_to_s06_couplers_RREADY),
        .m_axi_rresp(auto_us_df_to_s06_couplers_RRESP),
        .m_axi_rvalid(auto_us_df_to_s06_couplers_RVALID),
        .m_axi_wdata(auto_us_df_to_s06_couplers_WDATA),
        .m_axi_wlast(auto_us_df_to_s06_couplers_WLAST),
        .m_axi_wready(auto_us_df_to_s06_couplers_WREADY),
        .m_axi_wstrb(auto_us_df_to_s06_couplers_WSTRB),
        .m_axi_wvalid(auto_us_df_to_s06_couplers_WVALID),
        .s_axi_aclk(S_ACLK_1),
        .s_axi_araddr(s06_couplers_to_auto_us_df_ARADDR),
        .s_axi_arburst(s06_couplers_to_auto_us_df_ARBURST),
        .s_axi_arcache(s06_couplers_to_auto_us_df_ARCACHE),
        .s_axi_aresetn(S_ARESETN_1),
        .s_axi_arid(s06_couplers_to_auto_us_df_ARID),
        .s_axi_arlen(s06_couplers_to_auto_us_df_ARLEN),
        .s_axi_arlock(s06_couplers_to_auto_us_df_ARLOCK),
        .s_axi_arprot(s06_couplers_to_auto_us_df_ARPROT),
        .s_axi_arqos(s06_couplers_to_auto_us_df_ARQOS),
        .s_axi_arready(s06_couplers_to_auto_us_df_ARREADY),
        .s_axi_arregion({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arsize(s06_couplers_to_auto_us_df_ARSIZE),
        .s_axi_arvalid(s06_couplers_to_auto_us_df_ARVALID),
        .s_axi_awaddr(s06_couplers_to_auto_us_df_AWADDR),
        .s_axi_awburst(s06_couplers_to_auto_us_df_AWBURST),
        .s_axi_awcache(s06_couplers_to_auto_us_df_AWCACHE),
        .s_axi_awid(s06_couplers_to_auto_us_df_AWID),
        .s_axi_awlen(s06_couplers_to_auto_us_df_AWLEN),
        .s_axi_awlock(s06_couplers_to_auto_us_df_AWLOCK),
        .s_axi_awprot(s06_couplers_to_auto_us_df_AWPROT),
        .s_axi_awqos(s06_couplers_to_auto_us_df_AWQOS),
        .s_axi_awready(s06_couplers_to_auto_us_df_AWREADY),
        .s_axi_awregion({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awsize(s06_couplers_to_auto_us_df_AWSIZE),
        .s_axi_awvalid(s06_couplers_to_auto_us_df_AWVALID),
        .s_axi_bid(s06_couplers_to_auto_us_df_BID),
        .s_axi_bready(s06_couplers_to_auto_us_df_BREADY),
        .s_axi_bresp(s06_couplers_to_auto_us_df_BRESP),
        .s_axi_bvalid(s06_couplers_to_auto_us_df_BVALID),
        .s_axi_rdata(s06_couplers_to_auto_us_df_RDATA),
        .s_axi_rid(s06_couplers_to_auto_us_df_RID),
        .s_axi_rlast(s06_couplers_to_auto_us_df_RLAST),
        .s_axi_rready(s06_couplers_to_auto_us_df_RREADY),
        .s_axi_rresp(s06_couplers_to_auto_us_df_RRESP),
        .s_axi_rvalid(s06_couplers_to_auto_us_df_RVALID),
        .s_axi_wdata(s06_couplers_to_auto_us_df_WDATA),
        .s_axi_wlast(s06_couplers_to_auto_us_df_WLAST),
        .s_axi_wready(s06_couplers_to_auto_us_df_WREADY),
        .s_axi_wstrb(s06_couplers_to_auto_us_df_WSTRB),
        .s_axi_wvalid(s06_couplers_to_auto_us_df_WVALID));
endmodule

(* CORE_GENERATION_INFO = "system_i_bak,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=system_i_bak,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=118,numReposBlks=88,numNonXlnxBlks=4,numHierBlks=30,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=1,numPkgbdBlks=0,bdsource=USER,da_aeth_cnt=3,da_axi4_cnt=22,da_board_cnt=15,synth_mode=Global}" *) (* HW_HANDOFF = "system_i_bak.hwdef" *) 
module system_i_bak
   (GPIO2_tri_i,
    GPIO_tri_o,
    GT_DIFF_REFCLK1_clk_n,
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
    hdmi_16_data,
    hdmi_16_data_e,
    hdmi_16_hsync,
    hdmi_16_vsync,
    hdmi_out_clk,
    iic_main_scl_i,
    iic_main_scl_o,
    iic_main_scl_t,
    iic_main_sda_i,
    iic_main_sda_o,
    iic_main_sda_t,
    mb_intr_05,
    mb_intr_06,
    mb_intr_12,
    mb_intr_13,
    mb_intr_14,
    mb_intr_15,
    mdio_mdc_mdc,
    mdio_mdc_mdio_i,
    mdio_mdc_mdio_o,
    mdio_mdc_mdio_t,
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
  input [3:0]GPIO2_tri_i;
  output [6:0]GPIO_tri_o;
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
  output [15:0]hdmi_16_data;
  output hdmi_16_data_e;
  output hdmi_16_hsync;
  output hdmi_16_vsync;
  output hdmi_out_clk;
  input iic_main_scl_i;
  output iic_main_scl_o;
  output iic_main_scl_t;
  input iic_main_sda_i;
  output iic_main_sda_o;
  output iic_main_sda_t;
  input mb_intr_05;
  input mb_intr_06;
  input mb_intr_12;
  input mb_intr_13;
  input mb_intr_14;
  input mb_intr_15;
  output mdio_mdc_mdc;
  input mdio_mdc_mdio_i;
  output mdio_mdc_mdio_o;
  output mdio_mdc_mdio_t;
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

  wire BeamformerIP_0_fifo_axis_tready;
  wire GT_DIFF_REFCLK1_1_CLK_N;
  wire GT_DIFF_REFCLK1_1_CLK_P;
  wire [0:3]GT_SERIAL_RX_1_RXN;
  wire [0:3]GT_SERIAL_RX_1_RXP;
  wire [31:0]S00_AXI_1_ARADDR;
  wire [2:0]S00_AXI_1_ARPROT;
  wire S00_AXI_1_ARREADY;
  wire S00_AXI_1_ARVALID;
  wire [31:0]S00_AXI_1_AWADDR;
  wire [2:0]S00_AXI_1_AWPROT;
  wire S00_AXI_1_AWREADY;
  wire S00_AXI_1_AWVALID;
  wire S00_AXI_1_BREADY;
  wire [1:0]S00_AXI_1_BRESP;
  wire S00_AXI_1_BVALID;
  wire [31:0]S00_AXI_1_RDATA;
  wire S00_AXI_1_RREADY;
  wire [1:0]S00_AXI_1_RRESP;
  wire S00_AXI_1_RVALID;
  wire [31:0]S00_AXI_1_WDATA;
  wire S00_AXI_1_WREADY;
  wire [3:0]S00_AXI_1_WSTRB;
  wire S00_AXI_1_WVALID;
  wire [31:0]S05_AXI_1_ARADDR;
  wire [1:0]S05_AXI_1_ARBURST;
  wire [3:0]S05_AXI_1_ARCACHE;
  wire [0:0]S05_AXI_1_ARID;
  wire [7:0]S05_AXI_1_ARLEN;
  wire S05_AXI_1_ARLOCK;
  wire [2:0]S05_AXI_1_ARPROT;
  wire [3:0]S05_AXI_1_ARQOS;
  wire S05_AXI_1_ARREADY;
  wire [2:0]S05_AXI_1_ARSIZE;
  wire S05_AXI_1_ARVALID;
  wire [31:0]S05_AXI_1_AWADDR;
  wire [1:0]S05_AXI_1_AWBURST;
  wire [3:0]S05_AXI_1_AWCACHE;
  wire [0:0]S05_AXI_1_AWID;
  wire [7:0]S05_AXI_1_AWLEN;
  wire S05_AXI_1_AWLOCK;
  wire [2:0]S05_AXI_1_AWPROT;
  wire [3:0]S05_AXI_1_AWQOS;
  wire S05_AXI_1_AWREADY;
  wire [2:0]S05_AXI_1_AWSIZE;
  wire S05_AXI_1_AWVALID;
  wire [0:0]S05_AXI_1_BID;
  wire S05_AXI_1_BREADY;
  wire [1:0]S05_AXI_1_BRESP;
  wire S05_AXI_1_BVALID;
  wire [31:0]S05_AXI_1_RDATA;
  wire [0:0]S05_AXI_1_RID;
  wire S05_AXI_1_RLAST;
  wire S05_AXI_1_RREADY;
  wire [1:0]S05_AXI_1_RRESP;
  wire S05_AXI_1_RVALID;
  wire [31:0]S05_AXI_1_WDATA;
  wire S05_AXI_1_WLAST;
  wire S05_AXI_1_WREADY;
  wire [3:0]S05_AXI_1_WSTRB;
  wire S05_AXI_1_WVALID;
  wire [31:0]ScanConverterIP_0_m00_axi_ARADDR;
  wire [1:0]ScanConverterIP_0_m00_axi_ARBURST;
  wire [3:0]ScanConverterIP_0_m00_axi_ARCACHE;
  wire [0:0]ScanConverterIP_0_m00_axi_ARID;
  wire [7:0]ScanConverterIP_0_m00_axi_ARLEN;
  wire ScanConverterIP_0_m00_axi_ARLOCK;
  wire [2:0]ScanConverterIP_0_m00_axi_ARPROT;
  wire [3:0]ScanConverterIP_0_m00_axi_ARQOS;
  wire ScanConverterIP_0_m00_axi_ARREADY;
  wire [2:0]ScanConverterIP_0_m00_axi_ARSIZE;
  wire ScanConverterIP_0_m00_axi_ARVALID;
  wire [31:0]ScanConverterIP_0_m00_axi_AWADDR;
  wire [1:0]ScanConverterIP_0_m00_axi_AWBURST;
  wire [3:0]ScanConverterIP_0_m00_axi_AWCACHE;
  wire [0:0]ScanConverterIP_0_m00_axi_AWID;
  wire [7:0]ScanConverterIP_0_m00_axi_AWLEN;
  wire ScanConverterIP_0_m00_axi_AWLOCK;
  wire [2:0]ScanConverterIP_0_m00_axi_AWPROT;
  wire [3:0]ScanConverterIP_0_m00_axi_AWQOS;
  wire ScanConverterIP_0_m00_axi_AWREADY;
  wire [2:0]ScanConverterIP_0_m00_axi_AWSIZE;
  wire ScanConverterIP_0_m00_axi_AWVALID;
  wire [0:0]ScanConverterIP_0_m00_axi_BID;
  wire ScanConverterIP_0_m00_axi_BREADY;
  wire [1:0]ScanConverterIP_0_m00_axi_BRESP;
  wire ScanConverterIP_0_m00_axi_BVALID;
  wire [31:0]ScanConverterIP_0_m00_axi_RDATA;
  wire [0:0]ScanConverterIP_0_m00_axi_RID;
  wire ScanConverterIP_0_m00_axi_RLAST;
  wire ScanConverterIP_0_m00_axi_RREADY;
  wire [1:0]ScanConverterIP_0_m00_axi_RRESP;
  wire ScanConverterIP_0_m00_axi_RVALID;
  wire [31:0]ScanConverterIP_0_m00_axi_WDATA;
  wire ScanConverterIP_0_m00_axi_WLAST;
  wire ScanConverterIP_0_m00_axi_WREADY;
  wire [3:0]ScanConverterIP_0_m00_axi_WSTRB;
  wire ScanConverterIP_0_m00_axi_WVALID;
  wire [63:0]aurora_8b10b_0_USER_DATA_M_AXI_RX_TDATA;
  wire [7:0]aurora_8b10b_0_USER_DATA_M_AXI_RX_TKEEP;
  wire aurora_8b10b_0_USER_DATA_M_AXI_RX_TLAST;
  wire aurora_8b10b_0_USER_DATA_M_AXI_RX_TVALID;
  wire aurora_8b10b_0_gt_refclk1_out;
  wire aurora_8b10b_0_gt_reset_out;
  wire aurora_8b10b_0_rx_channel_up;
  wire aurora_8b10b_0_sys_reset_out;
  wire aurora_8b10b_0_user_clk_out;
  wire [0:3]aurora_8b10b_1_GT_SERIAL_TX_TXN;
  wire [0:3]aurora_8b10b_1_GT_SERIAL_TX_TXP;
  wire aurora_8b10b_1_s_axi_tx_tready;
  wire aurora_8b10b_1_user_clk_out;
  wire [31:0]axi_cpu_interconnect_M00_AXI_ARADDR;
  wire axi_cpu_interconnect_M00_AXI_ARREADY;
  wire axi_cpu_interconnect_M00_AXI_ARVALID;
  wire [31:0]axi_cpu_interconnect_M00_AXI_AWADDR;
  wire axi_cpu_interconnect_M00_AXI_AWREADY;
  wire axi_cpu_interconnect_M00_AXI_AWVALID;
  wire axi_cpu_interconnect_M00_AXI_BREADY;
  wire [1:0]axi_cpu_interconnect_M00_AXI_BRESP;
  wire axi_cpu_interconnect_M00_AXI_BVALID;
  wire [31:0]axi_cpu_interconnect_M00_AXI_RDATA;
  wire axi_cpu_interconnect_M00_AXI_RREADY;
  wire [1:0]axi_cpu_interconnect_M00_AXI_RRESP;
  wire axi_cpu_interconnect_M00_AXI_RVALID;
  wire [31:0]axi_cpu_interconnect_M00_AXI_WDATA;
  wire axi_cpu_interconnect_M00_AXI_WREADY;
  wire [3:0]axi_cpu_interconnect_M00_AXI_WSTRB;
  wire axi_cpu_interconnect_M00_AXI_WVALID;
  wire [31:0]axi_cpu_interconnect_M01_AXI_ARADDR;
  wire [1:0]axi_cpu_interconnect_M01_AXI_ARBURST;
  wire [3:0]axi_cpu_interconnect_M01_AXI_ARCACHE;
  wire [7:0]axi_cpu_interconnect_M01_AXI_ARLEN;
  wire axi_cpu_interconnect_M01_AXI_ARLOCK;
  wire [2:0]axi_cpu_interconnect_M01_AXI_ARPROT;
  wire [3:0]axi_cpu_interconnect_M01_AXI_ARQOS;
  wire axi_cpu_interconnect_M01_AXI_ARREADY;
  wire [3:0]axi_cpu_interconnect_M01_AXI_ARREGION;
  wire [2:0]axi_cpu_interconnect_M01_AXI_ARSIZE;
  wire axi_cpu_interconnect_M01_AXI_ARVALID;
  wire [31:0]axi_cpu_interconnect_M01_AXI_AWADDR;
  wire [1:0]axi_cpu_interconnect_M01_AXI_AWBURST;
  wire [3:0]axi_cpu_interconnect_M01_AXI_AWCACHE;
  wire [7:0]axi_cpu_interconnect_M01_AXI_AWLEN;
  wire axi_cpu_interconnect_M01_AXI_AWLOCK;
  wire [2:0]axi_cpu_interconnect_M01_AXI_AWPROT;
  wire [3:0]axi_cpu_interconnect_M01_AXI_AWQOS;
  wire axi_cpu_interconnect_M01_AXI_AWREADY;
  wire [3:0]axi_cpu_interconnect_M01_AXI_AWREGION;
  wire [2:0]axi_cpu_interconnect_M01_AXI_AWSIZE;
  wire axi_cpu_interconnect_M01_AXI_AWVALID;
  wire axi_cpu_interconnect_M01_AXI_BREADY;
  wire [1:0]axi_cpu_interconnect_M01_AXI_BRESP;
  wire axi_cpu_interconnect_M01_AXI_BVALID;
  wire [31:0]axi_cpu_interconnect_M01_AXI_RDATA;
  wire axi_cpu_interconnect_M01_AXI_RLAST;
  wire axi_cpu_interconnect_M01_AXI_RREADY;
  wire [1:0]axi_cpu_interconnect_M01_AXI_RRESP;
  wire axi_cpu_interconnect_M01_AXI_RVALID;
  wire [31:0]axi_cpu_interconnect_M01_AXI_WDATA;
  wire axi_cpu_interconnect_M01_AXI_WLAST;
  wire axi_cpu_interconnect_M01_AXI_WREADY;
  wire [3:0]axi_cpu_interconnect_M01_AXI_WSTRB;
  wire axi_cpu_interconnect_M01_AXI_WVALID;
  wire [31:0]axi_cpu_interconnect_M02_AXI_ARADDR;
  wire axi_cpu_interconnect_M02_AXI_ARREADY;
  wire axi_cpu_interconnect_M02_AXI_ARVALID;
  wire [31:0]axi_cpu_interconnect_M02_AXI_AWADDR;
  wire axi_cpu_interconnect_M02_AXI_AWREADY;
  wire axi_cpu_interconnect_M02_AXI_AWVALID;
  wire axi_cpu_interconnect_M02_AXI_BREADY;
  wire [1:0]axi_cpu_interconnect_M02_AXI_BRESP;
  wire axi_cpu_interconnect_M02_AXI_BVALID;
  wire [31:0]axi_cpu_interconnect_M02_AXI_RDATA;
  wire axi_cpu_interconnect_M02_AXI_RREADY;
  wire [1:0]axi_cpu_interconnect_M02_AXI_RRESP;
  wire axi_cpu_interconnect_M02_AXI_RVALID;
  wire [31:0]axi_cpu_interconnect_M02_AXI_WDATA;
  wire axi_cpu_interconnect_M02_AXI_WREADY;
  wire axi_cpu_interconnect_M02_AXI_WVALID;
  wire [31:0]axi_cpu_interconnect_M03_AXI_ARADDR;
  wire axi_cpu_interconnect_M03_AXI_ARREADY;
  wire axi_cpu_interconnect_M03_AXI_ARVALID;
  wire [31:0]axi_cpu_interconnect_M03_AXI_AWADDR;
  wire axi_cpu_interconnect_M03_AXI_AWREADY;
  wire axi_cpu_interconnect_M03_AXI_AWVALID;
  wire axi_cpu_interconnect_M03_AXI_BREADY;
  wire [1:0]axi_cpu_interconnect_M03_AXI_BRESP;
  wire axi_cpu_interconnect_M03_AXI_BVALID;
  wire [31:0]axi_cpu_interconnect_M03_AXI_RDATA;
  wire axi_cpu_interconnect_M03_AXI_RREADY;
  wire [1:0]axi_cpu_interconnect_M03_AXI_RRESP;
  wire axi_cpu_interconnect_M03_AXI_RVALID;
  wire [31:0]axi_cpu_interconnect_M03_AXI_WDATA;
  wire axi_cpu_interconnect_M03_AXI_WREADY;
  wire [3:0]axi_cpu_interconnect_M03_AXI_WSTRB;
  wire axi_cpu_interconnect_M03_AXI_WVALID;
  wire [31:0]axi_cpu_interconnect_M04_AXI_ARADDR;
  wire axi_cpu_interconnect_M04_AXI_ARREADY;
  wire axi_cpu_interconnect_M04_AXI_ARVALID;
  wire [31:0]axi_cpu_interconnect_M04_AXI_AWADDR;
  wire axi_cpu_interconnect_M04_AXI_AWREADY;
  wire axi_cpu_interconnect_M04_AXI_AWVALID;
  wire axi_cpu_interconnect_M04_AXI_BREADY;
  wire [1:0]axi_cpu_interconnect_M04_AXI_BRESP;
  wire axi_cpu_interconnect_M04_AXI_BVALID;
  wire [31:0]axi_cpu_interconnect_M04_AXI_RDATA;
  wire axi_cpu_interconnect_M04_AXI_RREADY;
  wire [1:0]axi_cpu_interconnect_M04_AXI_RRESP;
  wire axi_cpu_interconnect_M04_AXI_RVALID;
  wire [31:0]axi_cpu_interconnect_M04_AXI_WDATA;
  wire axi_cpu_interconnect_M04_AXI_WREADY;
  wire [3:0]axi_cpu_interconnect_M04_AXI_WSTRB;
  wire axi_cpu_interconnect_M04_AXI_WVALID;
  wire [31:0]axi_cpu_interconnect_M05_AXI_ARADDR;
  wire axi_cpu_interconnect_M05_AXI_ARREADY;
  wire axi_cpu_interconnect_M05_AXI_ARVALID;
  wire [31:0]axi_cpu_interconnect_M05_AXI_AWADDR;
  wire axi_cpu_interconnect_M05_AXI_AWREADY;
  wire axi_cpu_interconnect_M05_AXI_AWVALID;
  wire axi_cpu_interconnect_M05_AXI_BREADY;
  wire [1:0]axi_cpu_interconnect_M05_AXI_BRESP;
  wire axi_cpu_interconnect_M05_AXI_BVALID;
  wire [31:0]axi_cpu_interconnect_M05_AXI_RDATA;
  wire axi_cpu_interconnect_M05_AXI_RREADY;
  wire [1:0]axi_cpu_interconnect_M05_AXI_RRESP;
  wire axi_cpu_interconnect_M05_AXI_RVALID;
  wire [31:0]axi_cpu_interconnect_M05_AXI_WDATA;
  wire axi_cpu_interconnect_M05_AXI_WREADY;
  wire [3:0]axi_cpu_interconnect_M05_AXI_WSTRB;
  wire axi_cpu_interconnect_M05_AXI_WVALID;
  wire [31:0]axi_cpu_interconnect_M06_AXI_ARADDR;
  wire axi_cpu_interconnect_M06_AXI_ARREADY;
  wire axi_cpu_interconnect_M06_AXI_ARVALID;
  wire [31:0]axi_cpu_interconnect_M06_AXI_AWADDR;
  wire axi_cpu_interconnect_M06_AXI_AWREADY;
  wire axi_cpu_interconnect_M06_AXI_AWVALID;
  wire axi_cpu_interconnect_M06_AXI_BREADY;
  wire [1:0]axi_cpu_interconnect_M06_AXI_BRESP;
  wire axi_cpu_interconnect_M06_AXI_BVALID;
  wire [31:0]axi_cpu_interconnect_M06_AXI_RDATA;
  wire axi_cpu_interconnect_M06_AXI_RREADY;
  wire [1:0]axi_cpu_interconnect_M06_AXI_RRESP;
  wire axi_cpu_interconnect_M06_AXI_RVALID;
  wire [31:0]axi_cpu_interconnect_M06_AXI_WDATA;
  wire axi_cpu_interconnect_M06_AXI_WREADY;
  wire [3:0]axi_cpu_interconnect_M06_AXI_WSTRB;
  wire axi_cpu_interconnect_M06_AXI_WVALID;
  wire [31:0]axi_cpu_interconnect_M07_AXI_ARADDR;
  wire [1:0]axi_cpu_interconnect_M07_AXI_ARBURST;
  wire [3:0]axi_cpu_interconnect_M07_AXI_ARCACHE;
  wire [7:0]axi_cpu_interconnect_M07_AXI_ARLEN;
  wire [0:0]axi_cpu_interconnect_M07_AXI_ARLOCK;
  wire [2:0]axi_cpu_interconnect_M07_AXI_ARPROT;
  wire [3:0]axi_cpu_interconnect_M07_AXI_ARQOS;
  wire axi_cpu_interconnect_M07_AXI_ARREADY;
  wire [3:0]axi_cpu_interconnect_M07_AXI_ARREGION;
  wire [2:0]axi_cpu_interconnect_M07_AXI_ARSIZE;
  wire axi_cpu_interconnect_M07_AXI_ARVALID;
  wire [31:0]axi_cpu_interconnect_M07_AXI_AWADDR;
  wire [1:0]axi_cpu_interconnect_M07_AXI_AWBURST;
  wire [3:0]axi_cpu_interconnect_M07_AXI_AWCACHE;
  wire [7:0]axi_cpu_interconnect_M07_AXI_AWLEN;
  wire [0:0]axi_cpu_interconnect_M07_AXI_AWLOCK;
  wire [2:0]axi_cpu_interconnect_M07_AXI_AWPROT;
  wire [3:0]axi_cpu_interconnect_M07_AXI_AWQOS;
  wire axi_cpu_interconnect_M07_AXI_AWREADY;
  wire [3:0]axi_cpu_interconnect_M07_AXI_AWREGION;
  wire [2:0]axi_cpu_interconnect_M07_AXI_AWSIZE;
  wire axi_cpu_interconnect_M07_AXI_AWVALID;
  wire axi_cpu_interconnect_M07_AXI_BREADY;
  wire [1:0]axi_cpu_interconnect_M07_AXI_BRESP;
  wire axi_cpu_interconnect_M07_AXI_BVALID;
  wire [511:0]axi_cpu_interconnect_M07_AXI_RDATA;
  wire axi_cpu_interconnect_M07_AXI_RLAST;
  wire axi_cpu_interconnect_M07_AXI_RREADY;
  wire [1:0]axi_cpu_interconnect_M07_AXI_RRESP;
  wire axi_cpu_interconnect_M07_AXI_RVALID;
  wire [511:0]axi_cpu_interconnect_M07_AXI_WDATA;
  wire axi_cpu_interconnect_M07_AXI_WLAST;
  wire axi_cpu_interconnect_M07_AXI_WREADY;
  wire [63:0]axi_cpu_interconnect_M07_AXI_WSTRB;
  wire axi_cpu_interconnect_M07_AXI_WVALID;
  wire [17:0]axi_cpu_interconnect_M08_AXI_ARADDR;
  wire axi_cpu_interconnect_M08_AXI_ARREADY;
  wire axi_cpu_interconnect_M08_AXI_ARVALID;
  wire [17:0]axi_cpu_interconnect_M08_AXI_AWADDR;
  wire axi_cpu_interconnect_M08_AXI_AWREADY;
  wire axi_cpu_interconnect_M08_AXI_AWVALID;
  wire axi_cpu_interconnect_M08_AXI_BREADY;
  wire [1:0]axi_cpu_interconnect_M08_AXI_BRESP;
  wire axi_cpu_interconnect_M08_AXI_BVALID;
  wire [31:0]axi_cpu_interconnect_M08_AXI_RDATA;
  wire axi_cpu_interconnect_M08_AXI_RREADY;
  wire [1:0]axi_cpu_interconnect_M08_AXI_RRESP;
  wire axi_cpu_interconnect_M08_AXI_RVALID;
  wire [31:0]axi_cpu_interconnect_M08_AXI_WDATA;
  wire axi_cpu_interconnect_M08_AXI_WREADY;
  wire [3:0]axi_cpu_interconnect_M08_AXI_WSTRB;
  wire axi_cpu_interconnect_M08_AXI_WVALID;
  wire [31:0]axi_cpu_interconnect_M09_AXI_ARADDR;
  wire axi_cpu_interconnect_M09_AXI_ARREADY;
  wire axi_cpu_interconnect_M09_AXI_ARVALID;
  wire [31:0]axi_cpu_interconnect_M09_AXI_AWADDR;
  wire axi_cpu_interconnect_M09_AXI_AWREADY;
  wire axi_cpu_interconnect_M09_AXI_AWVALID;
  wire axi_cpu_interconnect_M09_AXI_BREADY;
  wire [1:0]axi_cpu_interconnect_M09_AXI_BRESP;
  wire axi_cpu_interconnect_M09_AXI_BVALID;
  wire [31:0]axi_cpu_interconnect_M09_AXI_RDATA;
  wire axi_cpu_interconnect_M09_AXI_RREADY;
  wire [1:0]axi_cpu_interconnect_M09_AXI_RRESP;
  wire axi_cpu_interconnect_M09_AXI_RVALID;
  wire [31:0]axi_cpu_interconnect_M09_AXI_WDATA;
  wire axi_cpu_interconnect_M09_AXI_WREADY;
  wire [3:0]axi_cpu_interconnect_M09_AXI_WSTRB;
  wire axi_cpu_interconnect_M09_AXI_WVALID;
  wire [31:0]axi_cpu_interconnect_M10_AXI_ARADDR;
  wire axi_cpu_interconnect_M10_AXI_ARREADY;
  wire axi_cpu_interconnect_M10_AXI_ARVALID;
  wire [31:0]axi_cpu_interconnect_M10_AXI_AWADDR;
  wire axi_cpu_interconnect_M10_AXI_AWREADY;
  wire axi_cpu_interconnect_M10_AXI_AWVALID;
  wire axi_cpu_interconnect_M10_AXI_BREADY;
  wire [1:0]axi_cpu_interconnect_M10_AXI_BRESP;
  wire axi_cpu_interconnect_M10_AXI_BVALID;
  wire [31:0]axi_cpu_interconnect_M10_AXI_RDATA;
  wire axi_cpu_interconnect_M10_AXI_RREADY;
  wire [1:0]axi_cpu_interconnect_M10_AXI_RRESP;
  wire axi_cpu_interconnect_M10_AXI_RVALID;
  wire [31:0]axi_cpu_interconnect_M10_AXI_WDATA;
  wire axi_cpu_interconnect_M10_AXI_WREADY;
  wire axi_cpu_interconnect_M10_AXI_WVALID;
  wire [31:0]axi_cpu_interconnect_M11_AXI_ARADDR;
  wire [2:0]axi_cpu_interconnect_M11_AXI_ARPROT;
  wire axi_cpu_interconnect_M11_AXI_ARREADY;
  wire axi_cpu_interconnect_M11_AXI_ARVALID;
  wire [31:0]axi_cpu_interconnect_M11_AXI_AWADDR;
  wire [2:0]axi_cpu_interconnect_M11_AXI_AWPROT;
  wire axi_cpu_interconnect_M11_AXI_AWREADY;
  wire axi_cpu_interconnect_M11_AXI_AWVALID;
  wire axi_cpu_interconnect_M11_AXI_BREADY;
  wire [1:0]axi_cpu_interconnect_M11_AXI_BRESP;
  wire axi_cpu_interconnect_M11_AXI_BVALID;
  wire [31:0]axi_cpu_interconnect_M11_AXI_RDATA;
  wire axi_cpu_interconnect_M11_AXI_RREADY;
  wire [1:0]axi_cpu_interconnect_M11_AXI_RRESP;
  wire axi_cpu_interconnect_M11_AXI_RVALID;
  wire [31:0]axi_cpu_interconnect_M11_AXI_WDATA;
  wire axi_cpu_interconnect_M11_AXI_WREADY;
  wire [3:0]axi_cpu_interconnect_M11_AXI_WSTRB;
  wire axi_cpu_interconnect_M11_AXI_WVALID;
  wire [31:0]axi_cpu_interconnect_M12_AXI_ARADDR;
  wire axi_cpu_interconnect_M12_AXI_ARREADY;
  wire axi_cpu_interconnect_M12_AXI_ARVALID;
  wire [31:0]axi_cpu_interconnect_M12_AXI_AWADDR;
  wire axi_cpu_interconnect_M12_AXI_AWREADY;
  wire axi_cpu_interconnect_M12_AXI_AWVALID;
  wire axi_cpu_interconnect_M12_AXI_BREADY;
  wire [1:0]axi_cpu_interconnect_M12_AXI_BRESP;
  wire axi_cpu_interconnect_M12_AXI_BVALID;
  wire [31:0]axi_cpu_interconnect_M12_AXI_RDATA;
  wire axi_cpu_interconnect_M12_AXI_RREADY;
  wire [1:0]axi_cpu_interconnect_M12_AXI_RRESP;
  wire axi_cpu_interconnect_M12_AXI_RVALID;
  wire [31:0]axi_cpu_interconnect_M12_AXI_WDATA;
  wire axi_cpu_interconnect_M12_AXI_WREADY;
  wire [3:0]axi_cpu_interconnect_M12_AXI_WSTRB;
  wire axi_cpu_interconnect_M12_AXI_WVALID;
  wire [31:0]axi_cpu_interconnect_M13_AXI_ARADDR;
  wire [2:0]axi_cpu_interconnect_M13_AXI_ARPROT;
  wire axi_cpu_interconnect_M13_AXI_ARREADY;
  wire axi_cpu_interconnect_M13_AXI_ARVALID;
  wire [31:0]axi_cpu_interconnect_M13_AXI_AWADDR;
  wire [2:0]axi_cpu_interconnect_M13_AXI_AWPROT;
  wire axi_cpu_interconnect_M13_AXI_AWREADY;
  wire axi_cpu_interconnect_M13_AXI_AWVALID;
  wire axi_cpu_interconnect_M13_AXI_BREADY;
  wire [1:0]axi_cpu_interconnect_M13_AXI_BRESP;
  wire axi_cpu_interconnect_M13_AXI_BVALID;
  wire [31:0]axi_cpu_interconnect_M13_AXI_RDATA;
  wire axi_cpu_interconnect_M13_AXI_RREADY;
  wire [1:0]axi_cpu_interconnect_M13_AXI_RRESP;
  wire axi_cpu_interconnect_M13_AXI_RVALID;
  wire [31:0]axi_cpu_interconnect_M13_AXI_WDATA;
  wire axi_cpu_interconnect_M13_AXI_WREADY;
  wire [3:0]axi_cpu_interconnect_M13_AXI_WSTRB;
  wire axi_cpu_interconnect_M13_AXI_WVALID;
  wire [31:0]axi_cpu_interconnect_M14_AXI_ARADDR;
  wire [1:0]axi_cpu_interconnect_M14_AXI_ARBURST;
  wire [3:0]axi_cpu_interconnect_M14_AXI_ARCACHE;
  wire [7:0]axi_cpu_interconnect_M14_AXI_ARLEN;
  wire axi_cpu_interconnect_M14_AXI_ARLOCK;
  wire [2:0]axi_cpu_interconnect_M14_AXI_ARPROT;
  wire [3:0]axi_cpu_interconnect_M14_AXI_ARQOS;
  wire axi_cpu_interconnect_M14_AXI_ARREADY;
  wire [3:0]axi_cpu_interconnect_M14_AXI_ARREGION;
  wire [2:0]axi_cpu_interconnect_M14_AXI_ARSIZE;
  wire axi_cpu_interconnect_M14_AXI_ARVALID;
  wire [31:0]axi_cpu_interconnect_M14_AXI_AWADDR;
  wire [1:0]axi_cpu_interconnect_M14_AXI_AWBURST;
  wire [3:0]axi_cpu_interconnect_M14_AXI_AWCACHE;
  wire [7:0]axi_cpu_interconnect_M14_AXI_AWLEN;
  wire axi_cpu_interconnect_M14_AXI_AWLOCK;
  wire [2:0]axi_cpu_interconnect_M14_AXI_AWPROT;
  wire [3:0]axi_cpu_interconnect_M14_AXI_AWQOS;
  wire axi_cpu_interconnect_M14_AXI_AWREADY;
  wire [3:0]axi_cpu_interconnect_M14_AXI_AWREGION;
  wire [2:0]axi_cpu_interconnect_M14_AXI_AWSIZE;
  wire axi_cpu_interconnect_M14_AXI_AWVALID;
  wire axi_cpu_interconnect_M14_AXI_BREADY;
  wire [1:0]axi_cpu_interconnect_M14_AXI_BRESP;
  wire axi_cpu_interconnect_M14_AXI_BVALID;
  wire [31:0]axi_cpu_interconnect_M14_AXI_RDATA;
  wire axi_cpu_interconnect_M14_AXI_RLAST;
  wire axi_cpu_interconnect_M14_AXI_RREADY;
  wire [1:0]axi_cpu_interconnect_M14_AXI_RRESP;
  wire axi_cpu_interconnect_M14_AXI_RVALID;
  wire [31:0]axi_cpu_interconnect_M14_AXI_WDATA;
  wire axi_cpu_interconnect_M14_AXI_WLAST;
  wire axi_cpu_interconnect_M14_AXI_WREADY;
  wire [3:0]axi_cpu_interconnect_M14_AXI_WSTRB;
  wire axi_cpu_interconnect_M14_AXI_WVALID;
  wire axi_ddr_cntrl_C0_DDR4_ACT_N;
  wire [16:0]axi_ddr_cntrl_C0_DDR4_ADR;
  wire [1:0]axi_ddr_cntrl_C0_DDR4_BA;
  wire [0:0]axi_ddr_cntrl_C0_DDR4_BG;
  wire [0:0]axi_ddr_cntrl_C0_DDR4_CKE;
  wire [0:0]axi_ddr_cntrl_C0_DDR4_CK_C;
  wire [0:0]axi_ddr_cntrl_C0_DDR4_CK_T;
  wire [0:0]axi_ddr_cntrl_C0_DDR4_CS_N;
  wire [7:0]axi_ddr_cntrl_C0_DDR4_DM_N;
  wire [63:0]axi_ddr_cntrl_C0_DDR4_DQ;
  wire [7:0]axi_ddr_cntrl_C0_DDR4_DQS_C;
  wire [7:0]axi_ddr_cntrl_C0_DDR4_DQS_T;
  wire [0:0]axi_ddr_cntrl_C0_DDR4_ODT;
  wire axi_ddr_cntrl_C0_DDR4_RESET_N;
  wire axi_ddr_cntrl_addn_ui_clkout2;
  wire axi_ddr_cntrl_addn_ui_clkout3;
  wire axi_ddr_cntrl_c0_ddr4_ui_clk_sync_rst;
  wire axi_ethernet_0_interrupt;
  wire [31:0]axi_ethernet_0_m_axis_rxd_TDATA;
  wire [3:0]axi_ethernet_0_m_axis_rxd_TKEEP;
  wire axi_ethernet_0_m_axis_rxd_TLAST;
  wire axi_ethernet_0_m_axis_rxd_TREADY;
  wire axi_ethernet_0_m_axis_rxd_TVALID;
  wire [31:0]axi_ethernet_0_m_axis_rxs_TDATA;
  wire [3:0]axi_ethernet_0_m_axis_rxs_TKEEP;
  wire axi_ethernet_0_m_axis_rxs_TLAST;
  wire axi_ethernet_0_m_axis_rxs_TREADY;
  wire axi_ethernet_0_m_axis_rxs_TVALID;
  wire axi_ethernet_0_mdio_MDC;
  wire axi_ethernet_0_mdio_MDIO_I;
  wire axi_ethernet_0_mdio_MDIO_O;
  wire axi_ethernet_0_mdio_MDIO_T;
  wire axi_ethernet_0_sgmii_RXN;
  wire axi_ethernet_0_sgmii_RXP;
  wire axi_ethernet_0_sgmii_TXN;
  wire axi_ethernet_0_sgmii_TXP;
  wire axi_ethernet_clkgen_clk_out1;
  wire axi_ethernet_clkgen_clk_out2;
  wire axi_ethernet_clkgen_clk_out3;
  wire axi_ethernet_clkgen_clk_out4;
  wire axi_ethernet_clkgen_clk_out5;
  wire axi_ethernet_clkgen_locked;
  wire [31:0]axi_ethernet_dma_M_AXIS_CNTRL_TDATA;
  wire [3:0]axi_ethernet_dma_M_AXIS_CNTRL_TKEEP;
  wire axi_ethernet_dma_M_AXIS_CNTRL_TLAST;
  wire axi_ethernet_dma_M_AXIS_CNTRL_TREADY;
  wire axi_ethernet_dma_M_AXIS_CNTRL_TVALID;
  wire [31:0]axi_ethernet_dma_M_AXIS_MM2S_TDATA;
  wire [3:0]axi_ethernet_dma_M_AXIS_MM2S_TKEEP;
  wire axi_ethernet_dma_M_AXIS_MM2S_TLAST;
  wire axi_ethernet_dma_M_AXIS_MM2S_TREADY;
  wire axi_ethernet_dma_M_AXIS_MM2S_TVALID;
  wire [31:0]axi_ethernet_dma_M_AXI_MM2S_ARADDR;
  wire [1:0]axi_ethernet_dma_M_AXI_MM2S_ARBURST;
  wire [3:0]axi_ethernet_dma_M_AXI_MM2S_ARCACHE;
  wire [7:0]axi_ethernet_dma_M_AXI_MM2S_ARLEN;
  wire [2:0]axi_ethernet_dma_M_AXI_MM2S_ARPROT;
  wire axi_ethernet_dma_M_AXI_MM2S_ARREADY;
  wire [2:0]axi_ethernet_dma_M_AXI_MM2S_ARSIZE;
  wire axi_ethernet_dma_M_AXI_MM2S_ARVALID;
  wire [31:0]axi_ethernet_dma_M_AXI_MM2S_RDATA;
  wire axi_ethernet_dma_M_AXI_MM2S_RLAST;
  wire axi_ethernet_dma_M_AXI_MM2S_RREADY;
  wire [1:0]axi_ethernet_dma_M_AXI_MM2S_RRESP;
  wire axi_ethernet_dma_M_AXI_MM2S_RVALID;
  wire [31:0]axi_ethernet_dma_M_AXI_S2MM_AWADDR;
  wire [1:0]axi_ethernet_dma_M_AXI_S2MM_AWBURST;
  wire [3:0]axi_ethernet_dma_M_AXI_S2MM_AWCACHE;
  wire [7:0]axi_ethernet_dma_M_AXI_S2MM_AWLEN;
  wire [2:0]axi_ethernet_dma_M_AXI_S2MM_AWPROT;
  wire axi_ethernet_dma_M_AXI_S2MM_AWREADY;
  wire [2:0]axi_ethernet_dma_M_AXI_S2MM_AWSIZE;
  wire axi_ethernet_dma_M_AXI_S2MM_AWVALID;
  wire axi_ethernet_dma_M_AXI_S2MM_BREADY;
  wire [1:0]axi_ethernet_dma_M_AXI_S2MM_BRESP;
  wire axi_ethernet_dma_M_AXI_S2MM_BVALID;
  wire [31:0]axi_ethernet_dma_M_AXI_S2MM_WDATA;
  wire axi_ethernet_dma_M_AXI_S2MM_WLAST;
  wire axi_ethernet_dma_M_AXI_S2MM_WREADY;
  wire [3:0]axi_ethernet_dma_M_AXI_S2MM_WSTRB;
  wire axi_ethernet_dma_M_AXI_S2MM_WVALID;
  wire [31:0]axi_ethernet_dma_M_AXI_SG_ARADDR;
  wire [1:0]axi_ethernet_dma_M_AXI_SG_ARBURST;
  wire [3:0]axi_ethernet_dma_M_AXI_SG_ARCACHE;
  wire [7:0]axi_ethernet_dma_M_AXI_SG_ARLEN;
  wire [2:0]axi_ethernet_dma_M_AXI_SG_ARPROT;
  wire axi_ethernet_dma_M_AXI_SG_ARREADY;
  wire [2:0]axi_ethernet_dma_M_AXI_SG_ARSIZE;
  wire axi_ethernet_dma_M_AXI_SG_ARVALID;
  wire [31:0]axi_ethernet_dma_M_AXI_SG_AWADDR;
  wire [1:0]axi_ethernet_dma_M_AXI_SG_AWBURST;
  wire [3:0]axi_ethernet_dma_M_AXI_SG_AWCACHE;
  wire [7:0]axi_ethernet_dma_M_AXI_SG_AWLEN;
  wire [2:0]axi_ethernet_dma_M_AXI_SG_AWPROT;
  wire axi_ethernet_dma_M_AXI_SG_AWREADY;
  wire [2:0]axi_ethernet_dma_M_AXI_SG_AWSIZE;
  wire axi_ethernet_dma_M_AXI_SG_AWVALID;
  wire axi_ethernet_dma_M_AXI_SG_BREADY;
  wire [1:0]axi_ethernet_dma_M_AXI_SG_BRESP;
  wire axi_ethernet_dma_M_AXI_SG_BVALID;
  wire [31:0]axi_ethernet_dma_M_AXI_SG_RDATA;
  wire axi_ethernet_dma_M_AXI_SG_RLAST;
  wire axi_ethernet_dma_M_AXI_SG_RREADY;
  wire [1:0]axi_ethernet_dma_M_AXI_SG_RRESP;
  wire axi_ethernet_dma_M_AXI_SG_RVALID;
  wire [31:0]axi_ethernet_dma_M_AXI_SG_WDATA;
  wire axi_ethernet_dma_M_AXI_SG_WLAST;
  wire axi_ethernet_dma_M_AXI_SG_WREADY;
  wire [3:0]axi_ethernet_dma_M_AXI_SG_WSTRB;
  wire axi_ethernet_dma_M_AXI_SG_WVALID;
  wire axi_ethernet_dma_mm2s_cntrl_reset_out_n;
  wire axi_ethernet_dma_mm2s_introut;
  wire axi_ethernet_dma_mm2s_prmry_reset_out_n;
  wire axi_ethernet_dma_s2mm_introut;
  wire axi_ethernet_dma_s2mm_prmry_reset_out_n;
  wire axi_ethernet_dma_s2mm_sts_reset_out_n;
  wire axi_ethernet_idelayctrl_rdy;
  wire [0:0]axi_ethernet_rstgen_peripheral_reset;
  wire [3:0]axi_gpio_0_GPIO2_TRI_I;
  wire [6:0]axi_gpio_0_GPIO_TRI_O;
  wire [15:0]axi_hdmi_tx_0_hdmi_16_data;
  wire axi_hdmi_tx_0_hdmi_16_data_e;
  wire axi_hdmi_tx_0_hdmi_16_hsync;
  wire axi_hdmi_tx_0_hdmi_16_vsync;
  wire axi_hdmi_tx_0_hdmi_out_clk;
  wire axi_hdmi_tx_0_vdma_fs;
  wire axi_hdmi_tx_0_vdma_ready;
  wire axi_iic_0_IIC_SCL_I;
  wire axi_iic_0_IIC_SCL_O;
  wire axi_iic_0_IIC_SCL_T;
  wire axi_iic_0_IIC_SDA_I;
  wire axi_iic_0_IIC_SDA_O;
  wire axi_iic_0_IIC_SDA_T;
  wire axi_iic_0_iic2intc_irpt;
  wire axi_intc_interrupt_INTERRUPT;
  wire [30:0]axi_interconnect_0_M00_AXI_ARADDR;
  wire [1:0]axi_interconnect_0_M00_AXI_ARBURST;
  wire [3:0]axi_interconnect_0_M00_AXI_ARCACHE;
  wire [1:0]axi_interconnect_0_M00_AXI_ARID;
  wire [7:0]axi_interconnect_0_M00_AXI_ARLEN;
  wire [0:0]axi_interconnect_0_M00_AXI_ARLOCK;
  wire [2:0]axi_interconnect_0_M00_AXI_ARPROT;
  wire [3:0]axi_interconnect_0_M00_AXI_ARQOS;
  wire axi_interconnect_0_M00_AXI_ARREADY;
  wire [2:0]axi_interconnect_0_M00_AXI_ARSIZE;
  wire axi_interconnect_0_M00_AXI_ARVALID;
  wire [30:0]axi_interconnect_0_M00_AXI_AWADDR;
  wire [1:0]axi_interconnect_0_M00_AXI_AWBURST;
  wire [3:0]axi_interconnect_0_M00_AXI_AWCACHE;
  wire [1:0]axi_interconnect_0_M00_AXI_AWID;
  wire [7:0]axi_interconnect_0_M00_AXI_AWLEN;
  wire [0:0]axi_interconnect_0_M00_AXI_AWLOCK;
  wire [2:0]axi_interconnect_0_M00_AXI_AWPROT;
  wire [3:0]axi_interconnect_0_M00_AXI_AWQOS;
  wire axi_interconnect_0_M00_AXI_AWREADY;
  wire [2:0]axi_interconnect_0_M00_AXI_AWSIZE;
  wire axi_interconnect_0_M00_AXI_AWVALID;
  wire [1:0]axi_interconnect_0_M00_AXI_BID;
  wire axi_interconnect_0_M00_AXI_BREADY;
  wire [1:0]axi_interconnect_0_M00_AXI_BRESP;
  wire axi_interconnect_0_M00_AXI_BVALID;
  wire [511:0]axi_interconnect_0_M00_AXI_RDATA;
  wire [1:0]axi_interconnect_0_M00_AXI_RID;
  wire axi_interconnect_0_M00_AXI_RLAST;
  wire axi_interconnect_0_M00_AXI_RREADY;
  wire [1:0]axi_interconnect_0_M00_AXI_RRESP;
  wire axi_interconnect_0_M00_AXI_RVALID;
  wire [511:0]axi_interconnect_0_M00_AXI_WDATA;
  wire axi_interconnect_0_M00_AXI_WLAST;
  wire axi_interconnect_0_M00_AXI_WREADY;
  wire [63:0]axi_interconnect_0_M00_AXI_WSTRB;
  wire axi_interconnect_0_M00_AXI_WVALID;
  wire axi_timer_interrupt;
  wire axi_uartlite_0_interrupt;
  wire axi_uartlite_0_tx;
  wire [31:0]axi_vdma_0_M_AXI_MM2S_ARADDR;
  wire [1:0]axi_vdma_0_M_AXI_MM2S_ARBURST;
  wire [3:0]axi_vdma_0_M_AXI_MM2S_ARCACHE;
  wire [7:0]axi_vdma_0_M_AXI_MM2S_ARLEN;
  wire [2:0]axi_vdma_0_M_AXI_MM2S_ARPROT;
  wire axi_vdma_0_M_AXI_MM2S_ARREADY;
  wire [2:0]axi_vdma_0_M_AXI_MM2S_ARSIZE;
  wire axi_vdma_0_M_AXI_MM2S_ARVALID;
  wire [63:0]axi_vdma_0_M_AXI_MM2S_RDATA;
  wire axi_vdma_0_M_AXI_MM2S_RLAST;
  wire axi_vdma_0_M_AXI_MM2S_RREADY;
  wire [1:0]axi_vdma_0_M_AXI_MM2S_RRESP;
  wire axi_vdma_0_M_AXI_MM2S_RVALID;
  wire [63:0]axi_vdma_0_m_axis_mm2s_tdata;
  wire axi_vdma_0_m_axis_mm2s_tvalid;
  wire axi_vdma_0_mm2s_introut;
  wire [31:0]axis_data_fifo_0_axis_data_count;
  wire [31:0]axis_data_fifo_0_axis_rd_data_count;
  wire [63:0]axis_data_fifo_0_m_axis_tdata;
  wire axis_data_fifo_0_m_axis_tvalid;
  wire mb_intr_05_1;
  wire mb_intr_06_1;
  wire mb_intr_12_1;
  wire mb_intr_13_1;
  wire mb_intr_14_1;
  wire mb_intr_15_1;
  wire phy_clk_1_CLK_N;
  wire phy_clk_1_CLK_P;
  wire reset_button_1;
  wire rx_1;
  wire [63:0]sim_data_probe_0_axis_tdata;
  wire sim_data_probe_0_axis_tvalid;
  wire sys_clk_1_CLK_N;
  wire sys_clk_1_CLK_P;
  wire [12:0]sys_concat_intc_dout;
  wire sys_cpu_clk;
  wire [0:0]sys_cpu_reset;
  wire [0:0]sys_cpu_resetn;
  wire [0:31]sys_mb_DLMB_ABUS;
  wire sys_mb_DLMB_ADDRSTROBE;
  wire [0:3]sys_mb_DLMB_BE;
  wire sys_mb_DLMB_CE;
  wire [0:31]sys_mb_DLMB_READDBUS;
  wire sys_mb_DLMB_READSTROBE;
  wire sys_mb_DLMB_READY;
  wire sys_mb_DLMB_UE;
  wire sys_mb_DLMB_WAIT;
  wire [0:31]sys_mb_DLMB_WRITEDBUS;
  wire sys_mb_DLMB_WRITESTROBE;
  wire [0:31]sys_mb_ILMB_ABUS;
  wire sys_mb_ILMB_ADDRSTROBE;
  wire sys_mb_ILMB_CE;
  wire [0:31]sys_mb_ILMB_READDBUS;
  wire sys_mb_ILMB_READSTROBE;
  wire sys_mb_ILMB_READY;
  wire sys_mb_ILMB_UE;
  wire sys_mb_ILMB_WAIT;
  wire [31:0]sys_mb_M_AXI_DC_ARADDR;
  wire [1:0]sys_mb_M_AXI_DC_ARBURST;
  wire [3:0]sys_mb_M_AXI_DC_ARCACHE;
  wire [7:0]sys_mb_M_AXI_DC_ARLEN;
  wire sys_mb_M_AXI_DC_ARLOCK;
  wire [2:0]sys_mb_M_AXI_DC_ARPROT;
  wire [3:0]sys_mb_M_AXI_DC_ARQOS;
  wire sys_mb_M_AXI_DC_ARREADY;
  wire [2:0]sys_mb_M_AXI_DC_ARSIZE;
  wire sys_mb_M_AXI_DC_ARVALID;
  wire [31:0]sys_mb_M_AXI_DC_AWADDR;
  wire [1:0]sys_mb_M_AXI_DC_AWBURST;
  wire [3:0]sys_mb_M_AXI_DC_AWCACHE;
  wire [7:0]sys_mb_M_AXI_DC_AWLEN;
  wire sys_mb_M_AXI_DC_AWLOCK;
  wire [2:0]sys_mb_M_AXI_DC_AWPROT;
  wire [3:0]sys_mb_M_AXI_DC_AWQOS;
  wire sys_mb_M_AXI_DC_AWREADY;
  wire [2:0]sys_mb_M_AXI_DC_AWSIZE;
  wire sys_mb_M_AXI_DC_AWVALID;
  wire sys_mb_M_AXI_DC_BREADY;
  wire [1:0]sys_mb_M_AXI_DC_BRESP;
  wire sys_mb_M_AXI_DC_BVALID;
  wire [31:0]sys_mb_M_AXI_DC_RDATA;
  wire sys_mb_M_AXI_DC_RLAST;
  wire sys_mb_M_AXI_DC_RREADY;
  wire [1:0]sys_mb_M_AXI_DC_RRESP;
  wire sys_mb_M_AXI_DC_RVALID;
  wire [31:0]sys_mb_M_AXI_DC_WDATA;
  wire sys_mb_M_AXI_DC_WLAST;
  wire sys_mb_M_AXI_DC_WREADY;
  wire [3:0]sys_mb_M_AXI_DC_WSTRB;
  wire sys_mb_M_AXI_DC_WVALID;
  wire [31:0]sys_mb_M_AXI_IC_ARADDR;
  wire [1:0]sys_mb_M_AXI_IC_ARBURST;
  wire [3:0]sys_mb_M_AXI_IC_ARCACHE;
  wire [7:0]sys_mb_M_AXI_IC_ARLEN;
  wire sys_mb_M_AXI_IC_ARLOCK;
  wire [2:0]sys_mb_M_AXI_IC_ARPROT;
  wire [3:0]sys_mb_M_AXI_IC_ARQOS;
  wire sys_mb_M_AXI_IC_ARREADY;
  wire [2:0]sys_mb_M_AXI_IC_ARSIZE;
  wire sys_mb_M_AXI_IC_ARVALID;
  wire [31:0]sys_mb_M_AXI_IC_RDATA;
  wire sys_mb_M_AXI_IC_RLAST;
  wire sys_mb_M_AXI_IC_RREADY;
  wire [1:0]sys_mb_M_AXI_IC_RRESP;
  wire sys_mb_M_AXI_IC_RVALID;
  wire [31:0]sys_mb_M_AXI_IP_ARADDR;
  wire [2:0]sys_mb_M_AXI_IP_ARPROT;
  wire sys_mb_M_AXI_IP_ARREADY;
  wire sys_mb_M_AXI_IP_ARVALID;
  wire [31:0]sys_mb_M_AXI_IP_RDATA;
  wire sys_mb_M_AXI_IP_RREADY;
  wire [1:0]sys_mb_M_AXI_IP_RRESP;
  wire sys_mb_M_AXI_IP_RVALID;
  wire sys_mb_debug_Debug_SYS_Rst;
  wire sys_mb_debug_MBDEBUG_0_CAPTURE;
  wire sys_mb_debug_MBDEBUG_0_CLK;
  wire [0:7]sys_mb_debug_MBDEBUG_0_REG_EN;
  wire sys_mb_debug_MBDEBUG_0_RST;
  wire sys_mb_debug_MBDEBUG_0_SHIFT;
  wire sys_mb_debug_MBDEBUG_0_TDI;
  wire sys_mb_debug_MBDEBUG_0_TDO;
  wire sys_mb_debug_MBDEBUG_0_UPDATE;
  wire sys_mem_clk;
  wire [0:0]sys_mem_resetn;
  wire sys_rst_1;
  wire sys_rstgen_mb_reset;
  wire [0:0]util_vector_logic_0_Res;
  wire [2:0]xlconstant_0_dout;
  wire [0:0]xlconstant_1_dout;
  wire [0:0]xlconstant_2_dout;
  wire [0:0]xlconstant_3_dout;
  wire [0:0]xlconstant_4_dout;
  wire [0:0]xlconstant_5_dout;
  wire [7:0]xlconstant_6_dout;
  wire [0:0]xlconstant_7_dout;
  wire [2:0]xlconstant_8_dout;

  assign GPIO_tri_o[6:0] = axi_gpio_0_GPIO_TRI_O;
  assign GT_DIFF_REFCLK1_1_CLK_N = GT_DIFF_REFCLK1_clk_n;
  assign GT_DIFF_REFCLK1_1_CLK_P = GT_DIFF_REFCLK1_clk_p;
  assign GT_SERIAL_RX_1_RXN = GT_SERIAL_RX_rxn[0:3];
  assign GT_SERIAL_RX_1_RXP = GT_SERIAL_RX_rxp[0:3];
  assign GT_SERIAL_TX_txn[0:3] = aurora_8b10b_1_GT_SERIAL_TX_TXN;
  assign GT_SERIAL_TX_txp[0:3] = aurora_8b10b_1_GT_SERIAL_TX_TXP;
  assign axi_ethernet_0_mdio_MDIO_I = mdio_mdc_mdio_i;
  assign axi_ethernet_0_sgmii_RXN = sgmii_rxn;
  assign axi_ethernet_0_sgmii_RXP = sgmii_rxp;
  assign axi_gpio_0_GPIO2_TRI_I = GPIO2_tri_i[3:0];
  assign axi_iic_0_IIC_SCL_I = iic_main_scl_i;
  assign axi_iic_0_IIC_SDA_I = iic_main_sda_i;
  assign c0_ddr4_act_n = axi_ddr_cntrl_C0_DDR4_ACT_N;
  assign c0_ddr4_adr[16:0] = axi_ddr_cntrl_C0_DDR4_ADR;
  assign c0_ddr4_ba[1:0] = axi_ddr_cntrl_C0_DDR4_BA;
  assign c0_ddr4_bg = axi_ddr_cntrl_C0_DDR4_BG;
  assign c0_ddr4_ck_c = axi_ddr_cntrl_C0_DDR4_CK_C;
  assign c0_ddr4_ck_t = axi_ddr_cntrl_C0_DDR4_CK_T;
  assign c0_ddr4_cke = axi_ddr_cntrl_C0_DDR4_CKE;
  assign c0_ddr4_cs_n = axi_ddr_cntrl_C0_DDR4_CS_N;
  assign c0_ddr4_odt = axi_ddr_cntrl_C0_DDR4_ODT;
  assign c0_ddr4_reset_n = axi_ddr_cntrl_C0_DDR4_RESET_N;
  assign hdmi_16_data[15:0] = axi_hdmi_tx_0_hdmi_16_data;
  assign hdmi_16_data_e = axi_hdmi_tx_0_hdmi_16_data_e;
  assign hdmi_16_hsync = axi_hdmi_tx_0_hdmi_16_hsync;
  assign hdmi_16_vsync = axi_hdmi_tx_0_hdmi_16_vsync;
  assign hdmi_out_clk = axi_hdmi_tx_0_hdmi_out_clk;
  assign iic_main_scl_o = axi_iic_0_IIC_SCL_O;
  assign iic_main_scl_t = axi_iic_0_IIC_SCL_T;
  assign iic_main_sda_o = axi_iic_0_IIC_SDA_O;
  assign iic_main_sda_t = axi_iic_0_IIC_SDA_T;
  assign mb_intr_05_1 = mb_intr_05;
  assign mb_intr_06_1 = mb_intr_06;
  assign mb_intr_12_1 = mb_intr_12;
  assign mb_intr_13_1 = mb_intr_13;
  assign mb_intr_14_1 = mb_intr_14;
  assign mb_intr_15_1 = mb_intr_15;
  assign mdio_mdc_mdc = axi_ethernet_0_mdio_MDC;
  assign mdio_mdc_mdio_o = axi_ethernet_0_mdio_MDIO_O;
  assign mdio_mdc_mdio_t = axi_ethernet_0_mdio_MDIO_T;
  assign phy_clk_1_CLK_N = phy_clk_clk_n;
  assign phy_clk_1_CLK_P = phy_clk_clk_p;
  assign phy_rst_n[0] = sys_cpu_resetn;
  assign reset_button_1 = aurora_reset_button;
  assign rx_1 = uart_sin;
  assign rx_channel_up = aurora_8b10b_0_rx_channel_up;
  assign sgmii_txn = axi_ethernet_0_sgmii_TXN;
  assign sgmii_txp = axi_ethernet_0_sgmii_TXP;
  assign sys_clk_1_CLK_N = sys_clk_clk_n;
  assign sys_clk_1_CLK_P = sys_clk_clk_p;
  assign sys_rst_1 = sys_rst;
  assign uart_sout = axi_uartlite_0_tx;
  system_i_bak_BeamformerIP_0_1 BeamformerIP_0
       (.fifo_axis_aclk(sys_cpu_clk),
        .fifo_axis_aresetn(sys_cpu_resetn),
        .fifo_axis_rd_data_count(axis_data_fifo_0_axis_rd_data_count),
        .fifo_axis_tdata(axis_data_fifo_0_m_axis_tdata),
        .fifo_axis_tready(BeamformerIP_0_fifo_axis_tready),
        .fifo_axis_tvalid(axis_data_fifo_0_m_axis_tvalid),
        .m00_axi_aclk(sys_cpu_clk),
        .m00_axi_araddr(S05_AXI_1_ARADDR),
        .m00_axi_arburst(S05_AXI_1_ARBURST),
        .m00_axi_arcache(S05_AXI_1_ARCACHE),
        .m00_axi_aresetn(sys_cpu_resetn),
        .m00_axi_arid(S05_AXI_1_ARID),
        .m00_axi_arlen(S05_AXI_1_ARLEN),
        .m00_axi_arlock(S05_AXI_1_ARLOCK),
        .m00_axi_arprot(S05_AXI_1_ARPROT),
        .m00_axi_arqos(S05_AXI_1_ARQOS),
        .m00_axi_arready(S05_AXI_1_ARREADY),
        .m00_axi_arsize(S05_AXI_1_ARSIZE),
        .m00_axi_arvalid(S05_AXI_1_ARVALID),
        .m00_axi_awaddr(S05_AXI_1_AWADDR),
        .m00_axi_awburst(S05_AXI_1_AWBURST),
        .m00_axi_awcache(S05_AXI_1_AWCACHE),
        .m00_axi_awid(S05_AXI_1_AWID),
        .m00_axi_awlen(S05_AXI_1_AWLEN),
        .m00_axi_awlock(S05_AXI_1_AWLOCK),
        .m00_axi_awprot(S05_AXI_1_AWPROT),
        .m00_axi_awqos(S05_AXI_1_AWQOS),
        .m00_axi_awready(S05_AXI_1_AWREADY),
        .m00_axi_awsize(S05_AXI_1_AWSIZE),
        .m00_axi_awvalid(S05_AXI_1_AWVALID),
        .m00_axi_bid(S05_AXI_1_BID),
        .m00_axi_bready(S05_AXI_1_BREADY),
        .m00_axi_bresp(S05_AXI_1_BRESP),
        .m00_axi_bvalid(S05_AXI_1_BVALID),
        .m00_axi_rdata(S05_AXI_1_RDATA),
        .m00_axi_rid(S05_AXI_1_RID),
        .m00_axi_rlast(S05_AXI_1_RLAST),
        .m00_axi_rready(S05_AXI_1_RREADY),
        .m00_axi_rresp(S05_AXI_1_RRESP),
        .m00_axi_rvalid(S05_AXI_1_RVALID),
        .m00_axi_wdata(S05_AXI_1_WDATA),
        .m00_axi_wlast(S05_AXI_1_WLAST),
        .m00_axi_wready(S05_AXI_1_WREADY),
        .m00_axi_wstrb(S05_AXI_1_WSTRB),
        .m00_axi_wvalid(S05_AXI_1_WVALID),
        .s00_axi_aclk(sys_cpu_clk),
        .s00_axi_araddr(axi_cpu_interconnect_M01_AXI_ARADDR[5:0]),
        .s00_axi_arburst(axi_cpu_interconnect_M01_AXI_ARBURST),
        .s00_axi_arcache(axi_cpu_interconnect_M01_AXI_ARCACHE),
        .s00_axi_aresetn(sys_cpu_resetn),
        .s00_axi_arid(1'b0),
        .s00_axi_arlen(axi_cpu_interconnect_M01_AXI_ARLEN),
        .s00_axi_arlock(axi_cpu_interconnect_M01_AXI_ARLOCK),
        .s00_axi_arprot(axi_cpu_interconnect_M01_AXI_ARPROT),
        .s00_axi_arqos(axi_cpu_interconnect_M01_AXI_ARQOS),
        .s00_axi_arready(axi_cpu_interconnect_M01_AXI_ARREADY),
        .s00_axi_arregion(axi_cpu_interconnect_M01_AXI_ARREGION),
        .s00_axi_arsize(axi_cpu_interconnect_M01_AXI_ARSIZE),
        .s00_axi_arvalid(axi_cpu_interconnect_M01_AXI_ARVALID),
        .s00_axi_awaddr(axi_cpu_interconnect_M01_AXI_AWADDR[5:0]),
        .s00_axi_awburst(axi_cpu_interconnect_M01_AXI_AWBURST),
        .s00_axi_awcache(axi_cpu_interconnect_M01_AXI_AWCACHE),
        .s00_axi_awid(1'b0),
        .s00_axi_awlen(axi_cpu_interconnect_M01_AXI_AWLEN),
        .s00_axi_awlock(axi_cpu_interconnect_M01_AXI_AWLOCK),
        .s00_axi_awprot(axi_cpu_interconnect_M01_AXI_AWPROT),
        .s00_axi_awqos(axi_cpu_interconnect_M01_AXI_AWQOS),
        .s00_axi_awready(axi_cpu_interconnect_M01_AXI_AWREADY),
        .s00_axi_awregion(axi_cpu_interconnect_M01_AXI_AWREGION),
        .s00_axi_awsize(axi_cpu_interconnect_M01_AXI_AWSIZE),
        .s00_axi_awvalid(axi_cpu_interconnect_M01_AXI_AWVALID),
        .s00_axi_bready(axi_cpu_interconnect_M01_AXI_BREADY),
        .s00_axi_bresp(axi_cpu_interconnect_M01_AXI_BRESP),
        .s00_axi_bvalid(axi_cpu_interconnect_M01_AXI_BVALID),
        .s00_axi_rdata(axi_cpu_interconnect_M01_AXI_RDATA),
        .s00_axi_rlast(axi_cpu_interconnect_M01_AXI_RLAST),
        .s00_axi_rready(axi_cpu_interconnect_M01_AXI_RREADY),
        .s00_axi_rresp(axi_cpu_interconnect_M01_AXI_RRESP),
        .s00_axi_rvalid(axi_cpu_interconnect_M01_AXI_RVALID),
        .s00_axi_wdata(axi_cpu_interconnect_M01_AXI_WDATA),
        .s00_axi_wlast(axi_cpu_interconnect_M01_AXI_WLAST),
        .s00_axi_wready(axi_cpu_interconnect_M01_AXI_WREADY),
        .s00_axi_wstrb(axi_cpu_interconnect_M01_AXI_WSTRB),
        .s00_axi_wvalid(axi_cpu_interconnect_M01_AXI_WVALID));
  system_i_bak_ScanConverterIP_0_0 ScanConverterIP_0
       (.m00_axi_aclk(sys_cpu_clk),
        .m00_axi_araddr(ScanConverterIP_0_m00_axi_ARADDR),
        .m00_axi_arburst(ScanConverterIP_0_m00_axi_ARBURST),
        .m00_axi_arcache(ScanConverterIP_0_m00_axi_ARCACHE),
        .m00_axi_aresetn(sys_cpu_resetn),
        .m00_axi_arid(ScanConverterIP_0_m00_axi_ARID),
        .m00_axi_arlen(ScanConverterIP_0_m00_axi_ARLEN),
        .m00_axi_arlock(ScanConverterIP_0_m00_axi_ARLOCK),
        .m00_axi_arprot(ScanConverterIP_0_m00_axi_ARPROT),
        .m00_axi_arqos(ScanConverterIP_0_m00_axi_ARQOS),
        .m00_axi_arready(ScanConverterIP_0_m00_axi_ARREADY),
        .m00_axi_arsize(ScanConverterIP_0_m00_axi_ARSIZE),
        .m00_axi_arvalid(ScanConverterIP_0_m00_axi_ARVALID),
        .m00_axi_awaddr(ScanConverterIP_0_m00_axi_AWADDR),
        .m00_axi_awburst(ScanConverterIP_0_m00_axi_AWBURST),
        .m00_axi_awcache(ScanConverterIP_0_m00_axi_AWCACHE),
        .m00_axi_awid(ScanConverterIP_0_m00_axi_AWID),
        .m00_axi_awlen(ScanConverterIP_0_m00_axi_AWLEN),
        .m00_axi_awlock(ScanConverterIP_0_m00_axi_AWLOCK),
        .m00_axi_awprot(ScanConverterIP_0_m00_axi_AWPROT),
        .m00_axi_awqos(ScanConverterIP_0_m00_axi_AWQOS),
        .m00_axi_awready(ScanConverterIP_0_m00_axi_AWREADY),
        .m00_axi_awsize(ScanConverterIP_0_m00_axi_AWSIZE),
        .m00_axi_awvalid(ScanConverterIP_0_m00_axi_AWVALID),
        .m00_axi_bid(ScanConverterIP_0_m00_axi_BID),
        .m00_axi_bready(ScanConverterIP_0_m00_axi_BREADY),
        .m00_axi_bresp(ScanConverterIP_0_m00_axi_BRESP),
        .m00_axi_bvalid(ScanConverterIP_0_m00_axi_BVALID),
        .m00_axi_rdata(ScanConverterIP_0_m00_axi_RDATA),
        .m00_axi_rid(ScanConverterIP_0_m00_axi_RID),
        .m00_axi_rlast(ScanConverterIP_0_m00_axi_RLAST),
        .m00_axi_rready(ScanConverterIP_0_m00_axi_RREADY),
        .m00_axi_rresp(ScanConverterIP_0_m00_axi_RRESP),
        .m00_axi_rvalid(ScanConverterIP_0_m00_axi_RVALID),
        .m00_axi_wdata(ScanConverterIP_0_m00_axi_WDATA),
        .m00_axi_wlast(ScanConverterIP_0_m00_axi_WLAST),
        .m00_axi_wready(ScanConverterIP_0_m00_axi_WREADY),
        .m00_axi_wstrb(ScanConverterIP_0_m00_axi_WSTRB),
        .m00_axi_wvalid(ScanConverterIP_0_m00_axi_WVALID),
        .s00_axi_aclk(sys_cpu_clk),
        .s00_axi_araddr(axi_cpu_interconnect_M14_AXI_ARADDR[9:0]),
        .s00_axi_arburst(axi_cpu_interconnect_M14_AXI_ARBURST),
        .s00_axi_arcache(axi_cpu_interconnect_M14_AXI_ARCACHE),
        .s00_axi_aresetn(sys_cpu_resetn),
        .s00_axi_arid(1'b0),
        .s00_axi_arlen(axi_cpu_interconnect_M14_AXI_ARLEN),
        .s00_axi_arlock(axi_cpu_interconnect_M14_AXI_ARLOCK),
        .s00_axi_arprot(axi_cpu_interconnect_M14_AXI_ARPROT),
        .s00_axi_arqos(axi_cpu_interconnect_M14_AXI_ARQOS),
        .s00_axi_arready(axi_cpu_interconnect_M14_AXI_ARREADY),
        .s00_axi_arregion(axi_cpu_interconnect_M14_AXI_ARREGION),
        .s00_axi_arsize(axi_cpu_interconnect_M14_AXI_ARSIZE),
        .s00_axi_aruser(1'b0),
        .s00_axi_arvalid(axi_cpu_interconnect_M14_AXI_ARVALID),
        .s00_axi_awaddr(axi_cpu_interconnect_M14_AXI_AWADDR[9:0]),
        .s00_axi_awburst(axi_cpu_interconnect_M14_AXI_AWBURST),
        .s00_axi_awcache(axi_cpu_interconnect_M14_AXI_AWCACHE),
        .s00_axi_awid(1'b0),
        .s00_axi_awlen(axi_cpu_interconnect_M14_AXI_AWLEN),
        .s00_axi_awlock(axi_cpu_interconnect_M14_AXI_AWLOCK),
        .s00_axi_awprot(axi_cpu_interconnect_M14_AXI_AWPROT),
        .s00_axi_awqos(axi_cpu_interconnect_M14_AXI_AWQOS),
        .s00_axi_awready(axi_cpu_interconnect_M14_AXI_AWREADY),
        .s00_axi_awregion(axi_cpu_interconnect_M14_AXI_AWREGION),
        .s00_axi_awsize(axi_cpu_interconnect_M14_AXI_AWSIZE),
        .s00_axi_awuser(1'b0),
        .s00_axi_awvalid(axi_cpu_interconnect_M14_AXI_AWVALID),
        .s00_axi_bready(axi_cpu_interconnect_M14_AXI_BREADY),
        .s00_axi_bresp(axi_cpu_interconnect_M14_AXI_BRESP),
        .s00_axi_bvalid(axi_cpu_interconnect_M14_AXI_BVALID),
        .s00_axi_rdata(axi_cpu_interconnect_M14_AXI_RDATA),
        .s00_axi_rlast(axi_cpu_interconnect_M14_AXI_RLAST),
        .s00_axi_rready(axi_cpu_interconnect_M14_AXI_RREADY),
        .s00_axi_rresp(axi_cpu_interconnect_M14_AXI_RRESP),
        .s00_axi_rvalid(axi_cpu_interconnect_M14_AXI_RVALID),
        .s00_axi_wdata(axi_cpu_interconnect_M14_AXI_WDATA),
        .s00_axi_wlast(axi_cpu_interconnect_M14_AXI_WLAST),
        .s00_axi_wready(axi_cpu_interconnect_M14_AXI_WREADY),
        .s00_axi_wstrb(axi_cpu_interconnect_M14_AXI_WSTRB),
        .s00_axi_wuser(1'b0),
        .s00_axi_wvalid(axi_cpu_interconnect_M14_AXI_WVALID));
  system_i_bak_aurora_8b10b_0_0 aurora_8b10b_0
       (.gt_refclk1_n(GT_DIFF_REFCLK1_1_CLK_N),
        .gt_refclk1_out(aurora_8b10b_0_gt_refclk1_out),
        .gt_refclk1_p(GT_DIFF_REFCLK1_1_CLK_P),
        .gt_reset(reset_button_1),
        .gt_reset_out(aurora_8b10b_0_gt_reset_out),
        .init_clk_in(axi_ddr_cntrl_addn_ui_clkout3),
        .loopback(xlconstant_0_dout),
        .m_axi_rx_tdata(aurora_8b10b_0_USER_DATA_M_AXI_RX_TDATA),
        .m_axi_rx_tkeep(aurora_8b10b_0_USER_DATA_M_AXI_RX_TKEEP),
        .m_axi_rx_tlast(aurora_8b10b_0_USER_DATA_M_AXI_RX_TLAST),
        .m_axi_rx_tvalid(aurora_8b10b_0_USER_DATA_M_AXI_RX_TVALID),
        .power_down(xlconstant_1_dout),
        .rx_channel_up(aurora_8b10b_0_rx_channel_up),
        .rx_system_reset(sys_rst_1),
        .rxn(GT_SERIAL_RX_1_RXN),
        .rxp(GT_SERIAL_RX_1_RXP),
        .sys_reset_out(aurora_8b10b_0_sys_reset_out),
        .user_clk_out(aurora_8b10b_0_user_clk_out));
  system_i_bak_aurora_8b10b_1_0 aurora_8b10b_1
       (.gt_refclk1(aurora_8b10b_0_gt_refclk1_out),
        .gt_reset(aurora_8b10b_0_gt_reset_out),
        .init_clk_in(axi_ddr_cntrl_addn_ui_clkout3),
        .loopback(xlconstant_8_dout),
        .power_down(xlconstant_7_dout),
        .s_axi_tx_tdata(sim_data_probe_0_axis_tdata),
        .s_axi_tx_tkeep(xlconstant_6_dout),
        .s_axi_tx_tlast(xlconstant_5_dout),
        .s_axi_tx_tready(aurora_8b10b_1_s_axi_tx_tready),
        .s_axi_tx_tvalid(sim_data_probe_0_axis_tvalid),
        .tx_system_reset(sys_rst_1),
        .txn(aurora_8b10b_1_GT_SERIAL_TX_TXN),
        .txp(aurora_8b10b_1_GT_SERIAL_TX_TXP),
        .user_clk_out(aurora_8b10b_1_user_clk_out));
  system_i_bak_axi_clkgen_0_0 axi_clkgen_0
       (.clk(axi_ddr_cntrl_addn_ui_clkout3),
        .clk2(1'b0),
        .clk_0(axi_ddr_cntrl_addn_ui_clkout2),
        .s_axi_aclk(sys_cpu_clk),
        .s_axi_araddr(axi_cpu_interconnect_M13_AXI_ARADDR),
        .s_axi_aresetn(sys_cpu_resetn),
        .s_axi_arprot(axi_cpu_interconnect_M13_AXI_ARPROT),
        .s_axi_arready(axi_cpu_interconnect_M13_AXI_ARREADY),
        .s_axi_arvalid(axi_cpu_interconnect_M13_AXI_ARVALID),
        .s_axi_awaddr(axi_cpu_interconnect_M13_AXI_AWADDR),
        .s_axi_awprot(axi_cpu_interconnect_M13_AXI_AWPROT),
        .s_axi_awready(axi_cpu_interconnect_M13_AXI_AWREADY),
        .s_axi_awvalid(axi_cpu_interconnect_M13_AXI_AWVALID),
        .s_axi_bready(axi_cpu_interconnect_M13_AXI_BREADY),
        .s_axi_bresp(axi_cpu_interconnect_M13_AXI_BRESP),
        .s_axi_bvalid(axi_cpu_interconnect_M13_AXI_BVALID),
        .s_axi_rdata(axi_cpu_interconnect_M13_AXI_RDATA),
        .s_axi_rready(axi_cpu_interconnect_M13_AXI_RREADY),
        .s_axi_rresp(axi_cpu_interconnect_M13_AXI_RRESP),
        .s_axi_rvalid(axi_cpu_interconnect_M13_AXI_RVALID),
        .s_axi_wdata(axi_cpu_interconnect_M13_AXI_WDATA),
        .s_axi_wready(axi_cpu_interconnect_M13_AXI_WREADY),
        .s_axi_wstrb(axi_cpu_interconnect_M13_AXI_WSTRB),
        .s_axi_wvalid(axi_cpu_interconnect_M13_AXI_WVALID));
  system_i_bak_axi_cpu_interconnect_0 axi_cpu_interconnect
       (.ACLK(sys_cpu_clk),
        .ARESETN(sys_cpu_resetn),
        .M00_ACLK(sys_cpu_clk),
        .M00_ARESETN(sys_cpu_resetn),
        .M00_AXI_araddr(axi_cpu_interconnect_M00_AXI_ARADDR),
        .M00_AXI_arready(axi_cpu_interconnect_M00_AXI_ARREADY),
        .M00_AXI_arvalid(axi_cpu_interconnect_M00_AXI_ARVALID),
        .M00_AXI_awaddr(axi_cpu_interconnect_M00_AXI_AWADDR),
        .M00_AXI_awready(axi_cpu_interconnect_M00_AXI_AWREADY),
        .M00_AXI_awvalid(axi_cpu_interconnect_M00_AXI_AWVALID),
        .M00_AXI_bready(axi_cpu_interconnect_M00_AXI_BREADY),
        .M00_AXI_bresp(axi_cpu_interconnect_M00_AXI_BRESP),
        .M00_AXI_bvalid(axi_cpu_interconnect_M00_AXI_BVALID),
        .M00_AXI_rdata(axi_cpu_interconnect_M00_AXI_RDATA),
        .M00_AXI_rready(axi_cpu_interconnect_M00_AXI_RREADY),
        .M00_AXI_rresp(axi_cpu_interconnect_M00_AXI_RRESP),
        .M00_AXI_rvalid(axi_cpu_interconnect_M00_AXI_RVALID),
        .M00_AXI_wdata(axi_cpu_interconnect_M00_AXI_WDATA),
        .M00_AXI_wready(axi_cpu_interconnect_M00_AXI_WREADY),
        .M00_AXI_wstrb(axi_cpu_interconnect_M00_AXI_WSTRB),
        .M00_AXI_wvalid(axi_cpu_interconnect_M00_AXI_WVALID),
        .M01_ACLK(sys_cpu_clk),
        .M01_ARESETN(sys_cpu_resetn),
        .M01_AXI_araddr(axi_cpu_interconnect_M01_AXI_ARADDR),
        .M01_AXI_arburst(axi_cpu_interconnect_M01_AXI_ARBURST),
        .M01_AXI_arcache(axi_cpu_interconnect_M01_AXI_ARCACHE),
        .M01_AXI_arlen(axi_cpu_interconnect_M01_AXI_ARLEN),
        .M01_AXI_arlock(axi_cpu_interconnect_M01_AXI_ARLOCK),
        .M01_AXI_arprot(axi_cpu_interconnect_M01_AXI_ARPROT),
        .M01_AXI_arqos(axi_cpu_interconnect_M01_AXI_ARQOS),
        .M01_AXI_arready(axi_cpu_interconnect_M01_AXI_ARREADY),
        .M01_AXI_arregion(axi_cpu_interconnect_M01_AXI_ARREGION),
        .M01_AXI_arsize(axi_cpu_interconnect_M01_AXI_ARSIZE),
        .M01_AXI_arvalid(axi_cpu_interconnect_M01_AXI_ARVALID),
        .M01_AXI_awaddr(axi_cpu_interconnect_M01_AXI_AWADDR),
        .M01_AXI_awburst(axi_cpu_interconnect_M01_AXI_AWBURST),
        .M01_AXI_awcache(axi_cpu_interconnect_M01_AXI_AWCACHE),
        .M01_AXI_awlen(axi_cpu_interconnect_M01_AXI_AWLEN),
        .M01_AXI_awlock(axi_cpu_interconnect_M01_AXI_AWLOCK),
        .M01_AXI_awprot(axi_cpu_interconnect_M01_AXI_AWPROT),
        .M01_AXI_awqos(axi_cpu_interconnect_M01_AXI_AWQOS),
        .M01_AXI_awready(axi_cpu_interconnect_M01_AXI_AWREADY),
        .M01_AXI_awregion(axi_cpu_interconnect_M01_AXI_AWREGION),
        .M01_AXI_awsize(axi_cpu_interconnect_M01_AXI_AWSIZE),
        .M01_AXI_awvalid(axi_cpu_interconnect_M01_AXI_AWVALID),
        .M01_AXI_bready(axi_cpu_interconnect_M01_AXI_BREADY),
        .M01_AXI_bresp(axi_cpu_interconnect_M01_AXI_BRESP),
        .M01_AXI_bvalid(axi_cpu_interconnect_M01_AXI_BVALID),
        .M01_AXI_rdata(axi_cpu_interconnect_M01_AXI_RDATA),
        .M01_AXI_rlast(axi_cpu_interconnect_M01_AXI_RLAST),
        .M01_AXI_rready(axi_cpu_interconnect_M01_AXI_RREADY),
        .M01_AXI_rresp(axi_cpu_interconnect_M01_AXI_RRESP),
        .M01_AXI_rvalid(axi_cpu_interconnect_M01_AXI_RVALID),
        .M01_AXI_wdata(axi_cpu_interconnect_M01_AXI_WDATA),
        .M01_AXI_wlast(axi_cpu_interconnect_M01_AXI_WLAST),
        .M01_AXI_wready(axi_cpu_interconnect_M01_AXI_WREADY),
        .M01_AXI_wstrb(axi_cpu_interconnect_M01_AXI_WSTRB),
        .M01_AXI_wvalid(axi_cpu_interconnect_M01_AXI_WVALID),
        .M02_ACLK(sys_cpu_clk),
        .M02_ARESETN(sys_cpu_resetn),
        .M02_AXI_araddr(axi_cpu_interconnect_M02_AXI_ARADDR),
        .M02_AXI_arready(axi_cpu_interconnect_M02_AXI_ARREADY),
        .M02_AXI_arvalid(axi_cpu_interconnect_M02_AXI_ARVALID),
        .M02_AXI_awaddr(axi_cpu_interconnect_M02_AXI_AWADDR),
        .M02_AXI_awready(axi_cpu_interconnect_M02_AXI_AWREADY),
        .M02_AXI_awvalid(axi_cpu_interconnect_M02_AXI_AWVALID),
        .M02_AXI_bready(axi_cpu_interconnect_M02_AXI_BREADY),
        .M02_AXI_bresp(axi_cpu_interconnect_M02_AXI_BRESP),
        .M02_AXI_bvalid(axi_cpu_interconnect_M02_AXI_BVALID),
        .M02_AXI_rdata(axi_cpu_interconnect_M02_AXI_RDATA),
        .M02_AXI_rready(axi_cpu_interconnect_M02_AXI_RREADY),
        .M02_AXI_rresp(axi_cpu_interconnect_M02_AXI_RRESP),
        .M02_AXI_rvalid(axi_cpu_interconnect_M02_AXI_RVALID),
        .M02_AXI_wdata(axi_cpu_interconnect_M02_AXI_WDATA),
        .M02_AXI_wready(axi_cpu_interconnect_M02_AXI_WREADY),
        .M02_AXI_wvalid(axi_cpu_interconnect_M02_AXI_WVALID),
        .M03_ACLK(sys_cpu_clk),
        .M03_ARESETN(sys_cpu_resetn),
        .M03_AXI_araddr(axi_cpu_interconnect_M03_AXI_ARADDR),
        .M03_AXI_arready(axi_cpu_interconnect_M03_AXI_ARREADY),
        .M03_AXI_arvalid(axi_cpu_interconnect_M03_AXI_ARVALID),
        .M03_AXI_awaddr(axi_cpu_interconnect_M03_AXI_AWADDR),
        .M03_AXI_awready(axi_cpu_interconnect_M03_AXI_AWREADY),
        .M03_AXI_awvalid(axi_cpu_interconnect_M03_AXI_AWVALID),
        .M03_AXI_bready(axi_cpu_interconnect_M03_AXI_BREADY),
        .M03_AXI_bresp(axi_cpu_interconnect_M03_AXI_BRESP),
        .M03_AXI_bvalid(axi_cpu_interconnect_M03_AXI_BVALID),
        .M03_AXI_rdata(axi_cpu_interconnect_M03_AXI_RDATA),
        .M03_AXI_rready(axi_cpu_interconnect_M03_AXI_RREADY),
        .M03_AXI_rresp(axi_cpu_interconnect_M03_AXI_RRESP),
        .M03_AXI_rvalid(axi_cpu_interconnect_M03_AXI_RVALID),
        .M03_AXI_wdata(axi_cpu_interconnect_M03_AXI_WDATA),
        .M03_AXI_wready(axi_cpu_interconnect_M03_AXI_WREADY),
        .M03_AXI_wstrb(axi_cpu_interconnect_M03_AXI_WSTRB),
        .M03_AXI_wvalid(axi_cpu_interconnect_M03_AXI_WVALID),
        .M04_ACLK(sys_cpu_clk),
        .M04_ARESETN(sys_cpu_resetn),
        .M04_AXI_araddr(axi_cpu_interconnect_M04_AXI_ARADDR),
        .M04_AXI_arready(axi_cpu_interconnect_M04_AXI_ARREADY),
        .M04_AXI_arvalid(axi_cpu_interconnect_M04_AXI_ARVALID),
        .M04_AXI_awaddr(axi_cpu_interconnect_M04_AXI_AWADDR),
        .M04_AXI_awready(axi_cpu_interconnect_M04_AXI_AWREADY),
        .M04_AXI_awvalid(axi_cpu_interconnect_M04_AXI_AWVALID),
        .M04_AXI_bready(axi_cpu_interconnect_M04_AXI_BREADY),
        .M04_AXI_bresp(axi_cpu_interconnect_M04_AXI_BRESP),
        .M04_AXI_bvalid(axi_cpu_interconnect_M04_AXI_BVALID),
        .M04_AXI_rdata(axi_cpu_interconnect_M04_AXI_RDATA),
        .M04_AXI_rready(axi_cpu_interconnect_M04_AXI_RREADY),
        .M04_AXI_rresp(axi_cpu_interconnect_M04_AXI_RRESP),
        .M04_AXI_rvalid(axi_cpu_interconnect_M04_AXI_RVALID),
        .M04_AXI_wdata(axi_cpu_interconnect_M04_AXI_WDATA),
        .M04_AXI_wready(axi_cpu_interconnect_M04_AXI_WREADY),
        .M04_AXI_wstrb(axi_cpu_interconnect_M04_AXI_WSTRB),
        .M04_AXI_wvalid(axi_cpu_interconnect_M04_AXI_WVALID),
        .M05_ACLK(sys_cpu_clk),
        .M05_ARESETN(sys_cpu_resetn),
        .M05_AXI_araddr(axi_cpu_interconnect_M05_AXI_ARADDR),
        .M05_AXI_arready(axi_cpu_interconnect_M05_AXI_ARREADY),
        .M05_AXI_arvalid(axi_cpu_interconnect_M05_AXI_ARVALID),
        .M05_AXI_awaddr(axi_cpu_interconnect_M05_AXI_AWADDR),
        .M05_AXI_awready(axi_cpu_interconnect_M05_AXI_AWREADY),
        .M05_AXI_awvalid(axi_cpu_interconnect_M05_AXI_AWVALID),
        .M05_AXI_bready(axi_cpu_interconnect_M05_AXI_BREADY),
        .M05_AXI_bresp(axi_cpu_interconnect_M05_AXI_BRESP),
        .M05_AXI_bvalid(axi_cpu_interconnect_M05_AXI_BVALID),
        .M05_AXI_rdata(axi_cpu_interconnect_M05_AXI_RDATA),
        .M05_AXI_rready(axi_cpu_interconnect_M05_AXI_RREADY),
        .M05_AXI_rresp(axi_cpu_interconnect_M05_AXI_RRESP),
        .M05_AXI_rvalid(axi_cpu_interconnect_M05_AXI_RVALID),
        .M05_AXI_wdata(axi_cpu_interconnect_M05_AXI_WDATA),
        .M05_AXI_wready(axi_cpu_interconnect_M05_AXI_WREADY),
        .M05_AXI_wstrb(axi_cpu_interconnect_M05_AXI_WSTRB),
        .M05_AXI_wvalid(axi_cpu_interconnect_M05_AXI_WVALID),
        .M06_ACLK(sys_cpu_clk),
        .M06_ARESETN(sys_cpu_resetn),
        .M06_AXI_araddr(axi_cpu_interconnect_M06_AXI_ARADDR),
        .M06_AXI_arready(axi_cpu_interconnect_M06_AXI_ARREADY),
        .M06_AXI_arvalid(axi_cpu_interconnect_M06_AXI_ARVALID),
        .M06_AXI_awaddr(axi_cpu_interconnect_M06_AXI_AWADDR),
        .M06_AXI_awready(axi_cpu_interconnect_M06_AXI_AWREADY),
        .M06_AXI_awvalid(axi_cpu_interconnect_M06_AXI_AWVALID),
        .M06_AXI_bready(axi_cpu_interconnect_M06_AXI_BREADY),
        .M06_AXI_bresp(axi_cpu_interconnect_M06_AXI_BRESP),
        .M06_AXI_bvalid(axi_cpu_interconnect_M06_AXI_BVALID),
        .M06_AXI_rdata(axi_cpu_interconnect_M06_AXI_RDATA),
        .M06_AXI_rready(axi_cpu_interconnect_M06_AXI_RREADY),
        .M06_AXI_rresp(axi_cpu_interconnect_M06_AXI_RRESP),
        .M06_AXI_rvalid(axi_cpu_interconnect_M06_AXI_RVALID),
        .M06_AXI_wdata(axi_cpu_interconnect_M06_AXI_WDATA),
        .M06_AXI_wready(axi_cpu_interconnect_M06_AXI_WREADY),
        .M06_AXI_wstrb(axi_cpu_interconnect_M06_AXI_WSTRB),
        .M06_AXI_wvalid(axi_cpu_interconnect_M06_AXI_WVALID),
        .M07_ACLK(sys_cpu_clk),
        .M07_ARESETN(sys_cpu_resetn),
        .M07_AXI_araddr(axi_cpu_interconnect_M07_AXI_ARADDR),
        .M07_AXI_arburst(axi_cpu_interconnect_M07_AXI_ARBURST),
        .M07_AXI_arcache(axi_cpu_interconnect_M07_AXI_ARCACHE),
        .M07_AXI_arlen(axi_cpu_interconnect_M07_AXI_ARLEN),
        .M07_AXI_arlock(axi_cpu_interconnect_M07_AXI_ARLOCK),
        .M07_AXI_arprot(axi_cpu_interconnect_M07_AXI_ARPROT),
        .M07_AXI_arqos(axi_cpu_interconnect_M07_AXI_ARQOS),
        .M07_AXI_arready(axi_cpu_interconnect_M07_AXI_ARREADY),
        .M07_AXI_arregion(axi_cpu_interconnect_M07_AXI_ARREGION),
        .M07_AXI_arsize(axi_cpu_interconnect_M07_AXI_ARSIZE),
        .M07_AXI_arvalid(axi_cpu_interconnect_M07_AXI_ARVALID),
        .M07_AXI_awaddr(axi_cpu_interconnect_M07_AXI_AWADDR),
        .M07_AXI_awburst(axi_cpu_interconnect_M07_AXI_AWBURST),
        .M07_AXI_awcache(axi_cpu_interconnect_M07_AXI_AWCACHE),
        .M07_AXI_awlen(axi_cpu_interconnect_M07_AXI_AWLEN),
        .M07_AXI_awlock(axi_cpu_interconnect_M07_AXI_AWLOCK),
        .M07_AXI_awprot(axi_cpu_interconnect_M07_AXI_AWPROT),
        .M07_AXI_awqos(axi_cpu_interconnect_M07_AXI_AWQOS),
        .M07_AXI_awready(axi_cpu_interconnect_M07_AXI_AWREADY),
        .M07_AXI_awregion(axi_cpu_interconnect_M07_AXI_AWREGION),
        .M07_AXI_awsize(axi_cpu_interconnect_M07_AXI_AWSIZE),
        .M07_AXI_awvalid(axi_cpu_interconnect_M07_AXI_AWVALID),
        .M07_AXI_bready(axi_cpu_interconnect_M07_AXI_BREADY),
        .M07_AXI_bresp(axi_cpu_interconnect_M07_AXI_BRESP),
        .M07_AXI_bvalid(axi_cpu_interconnect_M07_AXI_BVALID),
        .M07_AXI_rdata(axi_cpu_interconnect_M07_AXI_RDATA),
        .M07_AXI_rlast(axi_cpu_interconnect_M07_AXI_RLAST),
        .M07_AXI_rready(axi_cpu_interconnect_M07_AXI_RREADY),
        .M07_AXI_rresp(axi_cpu_interconnect_M07_AXI_RRESP),
        .M07_AXI_rvalid(axi_cpu_interconnect_M07_AXI_RVALID),
        .M07_AXI_wdata(axi_cpu_interconnect_M07_AXI_WDATA),
        .M07_AXI_wlast(axi_cpu_interconnect_M07_AXI_WLAST),
        .M07_AXI_wready(axi_cpu_interconnect_M07_AXI_WREADY),
        .M07_AXI_wstrb(axi_cpu_interconnect_M07_AXI_WSTRB),
        .M07_AXI_wvalid(axi_cpu_interconnect_M07_AXI_WVALID),
        .M08_ACLK(sys_cpu_clk),
        .M08_ARESETN(sys_cpu_resetn),
        .M08_AXI_araddr(axi_cpu_interconnect_M08_AXI_ARADDR),
        .M08_AXI_arready(axi_cpu_interconnect_M08_AXI_ARREADY),
        .M08_AXI_arvalid(axi_cpu_interconnect_M08_AXI_ARVALID),
        .M08_AXI_awaddr(axi_cpu_interconnect_M08_AXI_AWADDR),
        .M08_AXI_awready(axi_cpu_interconnect_M08_AXI_AWREADY),
        .M08_AXI_awvalid(axi_cpu_interconnect_M08_AXI_AWVALID),
        .M08_AXI_bready(axi_cpu_interconnect_M08_AXI_BREADY),
        .M08_AXI_bresp(axi_cpu_interconnect_M08_AXI_BRESP),
        .M08_AXI_bvalid(axi_cpu_interconnect_M08_AXI_BVALID),
        .M08_AXI_rdata(axi_cpu_interconnect_M08_AXI_RDATA),
        .M08_AXI_rready(axi_cpu_interconnect_M08_AXI_RREADY),
        .M08_AXI_rresp(axi_cpu_interconnect_M08_AXI_RRESP),
        .M08_AXI_rvalid(axi_cpu_interconnect_M08_AXI_RVALID),
        .M08_AXI_wdata(axi_cpu_interconnect_M08_AXI_WDATA),
        .M08_AXI_wready(axi_cpu_interconnect_M08_AXI_WREADY),
        .M08_AXI_wstrb(axi_cpu_interconnect_M08_AXI_WSTRB),
        .M08_AXI_wvalid(axi_cpu_interconnect_M08_AXI_WVALID),
        .M09_ACLK(sys_cpu_clk),
        .M09_ARESETN(sys_cpu_resetn),
        .M09_AXI_araddr(axi_cpu_interconnect_M09_AXI_ARADDR),
        .M09_AXI_arready(axi_cpu_interconnect_M09_AXI_ARREADY),
        .M09_AXI_arvalid(axi_cpu_interconnect_M09_AXI_ARVALID),
        .M09_AXI_awaddr(axi_cpu_interconnect_M09_AXI_AWADDR),
        .M09_AXI_awready(axi_cpu_interconnect_M09_AXI_AWREADY),
        .M09_AXI_awvalid(axi_cpu_interconnect_M09_AXI_AWVALID),
        .M09_AXI_bready(axi_cpu_interconnect_M09_AXI_BREADY),
        .M09_AXI_bresp(axi_cpu_interconnect_M09_AXI_BRESP),
        .M09_AXI_bvalid(axi_cpu_interconnect_M09_AXI_BVALID),
        .M09_AXI_rdata(axi_cpu_interconnect_M09_AXI_RDATA),
        .M09_AXI_rready(axi_cpu_interconnect_M09_AXI_RREADY),
        .M09_AXI_rresp(axi_cpu_interconnect_M09_AXI_RRESP),
        .M09_AXI_rvalid(axi_cpu_interconnect_M09_AXI_RVALID),
        .M09_AXI_wdata(axi_cpu_interconnect_M09_AXI_WDATA),
        .M09_AXI_wready(axi_cpu_interconnect_M09_AXI_WREADY),
        .M09_AXI_wstrb(axi_cpu_interconnect_M09_AXI_WSTRB),
        .M09_AXI_wvalid(axi_cpu_interconnect_M09_AXI_WVALID),
        .M10_ACLK(sys_cpu_clk),
        .M10_ARESETN(sys_cpu_resetn),
        .M10_AXI_araddr(axi_cpu_interconnect_M10_AXI_ARADDR),
        .M10_AXI_arready(axi_cpu_interconnect_M10_AXI_ARREADY),
        .M10_AXI_arvalid(axi_cpu_interconnect_M10_AXI_ARVALID),
        .M10_AXI_awaddr(axi_cpu_interconnect_M10_AXI_AWADDR),
        .M10_AXI_awready(axi_cpu_interconnect_M10_AXI_AWREADY),
        .M10_AXI_awvalid(axi_cpu_interconnect_M10_AXI_AWVALID),
        .M10_AXI_bready(axi_cpu_interconnect_M10_AXI_BREADY),
        .M10_AXI_bresp(axi_cpu_interconnect_M10_AXI_BRESP),
        .M10_AXI_bvalid(axi_cpu_interconnect_M10_AXI_BVALID),
        .M10_AXI_rdata(axi_cpu_interconnect_M10_AXI_RDATA),
        .M10_AXI_rready(axi_cpu_interconnect_M10_AXI_RREADY),
        .M10_AXI_rresp(axi_cpu_interconnect_M10_AXI_RRESP),
        .M10_AXI_rvalid(axi_cpu_interconnect_M10_AXI_RVALID),
        .M10_AXI_wdata(axi_cpu_interconnect_M10_AXI_WDATA),
        .M10_AXI_wready(axi_cpu_interconnect_M10_AXI_WREADY),
        .M10_AXI_wvalid(axi_cpu_interconnect_M10_AXI_WVALID),
        .M11_ACLK(sys_cpu_clk),
        .M11_ARESETN(sys_cpu_resetn),
        .M11_AXI_araddr(axi_cpu_interconnect_M11_AXI_ARADDR),
        .M11_AXI_arprot(axi_cpu_interconnect_M11_AXI_ARPROT),
        .M11_AXI_arready(axi_cpu_interconnect_M11_AXI_ARREADY),
        .M11_AXI_arvalid(axi_cpu_interconnect_M11_AXI_ARVALID),
        .M11_AXI_awaddr(axi_cpu_interconnect_M11_AXI_AWADDR),
        .M11_AXI_awprot(axi_cpu_interconnect_M11_AXI_AWPROT),
        .M11_AXI_awready(axi_cpu_interconnect_M11_AXI_AWREADY),
        .M11_AXI_awvalid(axi_cpu_interconnect_M11_AXI_AWVALID),
        .M11_AXI_bready(axi_cpu_interconnect_M11_AXI_BREADY),
        .M11_AXI_bresp(axi_cpu_interconnect_M11_AXI_BRESP),
        .M11_AXI_bvalid(axi_cpu_interconnect_M11_AXI_BVALID),
        .M11_AXI_rdata(axi_cpu_interconnect_M11_AXI_RDATA),
        .M11_AXI_rready(axi_cpu_interconnect_M11_AXI_RREADY),
        .M11_AXI_rresp(axi_cpu_interconnect_M11_AXI_RRESP),
        .M11_AXI_rvalid(axi_cpu_interconnect_M11_AXI_RVALID),
        .M11_AXI_wdata(axi_cpu_interconnect_M11_AXI_WDATA),
        .M11_AXI_wready(axi_cpu_interconnect_M11_AXI_WREADY),
        .M11_AXI_wstrb(axi_cpu_interconnect_M11_AXI_WSTRB),
        .M11_AXI_wvalid(axi_cpu_interconnect_M11_AXI_WVALID),
        .M12_ACLK(sys_cpu_clk),
        .M12_ARESETN(sys_cpu_resetn),
        .M12_AXI_araddr(axi_cpu_interconnect_M12_AXI_ARADDR),
        .M12_AXI_arready(axi_cpu_interconnect_M12_AXI_ARREADY),
        .M12_AXI_arvalid(axi_cpu_interconnect_M12_AXI_ARVALID),
        .M12_AXI_awaddr(axi_cpu_interconnect_M12_AXI_AWADDR),
        .M12_AXI_awready(axi_cpu_interconnect_M12_AXI_AWREADY),
        .M12_AXI_awvalid(axi_cpu_interconnect_M12_AXI_AWVALID),
        .M12_AXI_bready(axi_cpu_interconnect_M12_AXI_BREADY),
        .M12_AXI_bresp(axi_cpu_interconnect_M12_AXI_BRESP),
        .M12_AXI_bvalid(axi_cpu_interconnect_M12_AXI_BVALID),
        .M12_AXI_rdata(axi_cpu_interconnect_M12_AXI_RDATA),
        .M12_AXI_rready(axi_cpu_interconnect_M12_AXI_RREADY),
        .M12_AXI_rresp(axi_cpu_interconnect_M12_AXI_RRESP),
        .M12_AXI_rvalid(axi_cpu_interconnect_M12_AXI_RVALID),
        .M12_AXI_wdata(axi_cpu_interconnect_M12_AXI_WDATA),
        .M12_AXI_wready(axi_cpu_interconnect_M12_AXI_WREADY),
        .M12_AXI_wstrb(axi_cpu_interconnect_M12_AXI_WSTRB),
        .M12_AXI_wvalid(axi_cpu_interconnect_M12_AXI_WVALID),
        .M13_ACLK(sys_cpu_clk),
        .M13_ARESETN(sys_cpu_resetn),
        .M13_AXI_araddr(axi_cpu_interconnect_M13_AXI_ARADDR),
        .M13_AXI_arprot(axi_cpu_interconnect_M13_AXI_ARPROT),
        .M13_AXI_arready(axi_cpu_interconnect_M13_AXI_ARREADY),
        .M13_AXI_arvalid(axi_cpu_interconnect_M13_AXI_ARVALID),
        .M13_AXI_awaddr(axi_cpu_interconnect_M13_AXI_AWADDR),
        .M13_AXI_awprot(axi_cpu_interconnect_M13_AXI_AWPROT),
        .M13_AXI_awready(axi_cpu_interconnect_M13_AXI_AWREADY),
        .M13_AXI_awvalid(axi_cpu_interconnect_M13_AXI_AWVALID),
        .M13_AXI_bready(axi_cpu_interconnect_M13_AXI_BREADY),
        .M13_AXI_bresp(axi_cpu_interconnect_M13_AXI_BRESP),
        .M13_AXI_bvalid(axi_cpu_interconnect_M13_AXI_BVALID),
        .M13_AXI_rdata(axi_cpu_interconnect_M13_AXI_RDATA),
        .M13_AXI_rready(axi_cpu_interconnect_M13_AXI_RREADY),
        .M13_AXI_rresp(axi_cpu_interconnect_M13_AXI_RRESP),
        .M13_AXI_rvalid(axi_cpu_interconnect_M13_AXI_RVALID),
        .M13_AXI_wdata(axi_cpu_interconnect_M13_AXI_WDATA),
        .M13_AXI_wready(axi_cpu_interconnect_M13_AXI_WREADY),
        .M13_AXI_wstrb(axi_cpu_interconnect_M13_AXI_WSTRB),
        .M13_AXI_wvalid(axi_cpu_interconnect_M13_AXI_WVALID),
        .M14_ACLK(sys_cpu_clk),
        .M14_ARESETN(sys_cpu_resetn),
        .M14_AXI_araddr(axi_cpu_interconnect_M14_AXI_ARADDR),
        .M14_AXI_arburst(axi_cpu_interconnect_M14_AXI_ARBURST),
        .M14_AXI_arcache(axi_cpu_interconnect_M14_AXI_ARCACHE),
        .M14_AXI_arlen(axi_cpu_interconnect_M14_AXI_ARLEN),
        .M14_AXI_arlock(axi_cpu_interconnect_M14_AXI_ARLOCK),
        .M14_AXI_arprot(axi_cpu_interconnect_M14_AXI_ARPROT),
        .M14_AXI_arqos(axi_cpu_interconnect_M14_AXI_ARQOS),
        .M14_AXI_arready(axi_cpu_interconnect_M14_AXI_ARREADY),
        .M14_AXI_arregion(axi_cpu_interconnect_M14_AXI_ARREGION),
        .M14_AXI_arsize(axi_cpu_interconnect_M14_AXI_ARSIZE),
        .M14_AXI_arvalid(axi_cpu_interconnect_M14_AXI_ARVALID),
        .M14_AXI_awaddr(axi_cpu_interconnect_M14_AXI_AWADDR),
        .M14_AXI_awburst(axi_cpu_interconnect_M14_AXI_AWBURST),
        .M14_AXI_awcache(axi_cpu_interconnect_M14_AXI_AWCACHE),
        .M14_AXI_awlen(axi_cpu_interconnect_M14_AXI_AWLEN),
        .M14_AXI_awlock(axi_cpu_interconnect_M14_AXI_AWLOCK),
        .M14_AXI_awprot(axi_cpu_interconnect_M14_AXI_AWPROT),
        .M14_AXI_awqos(axi_cpu_interconnect_M14_AXI_AWQOS),
        .M14_AXI_awready(axi_cpu_interconnect_M14_AXI_AWREADY),
        .M14_AXI_awregion(axi_cpu_interconnect_M14_AXI_AWREGION),
        .M14_AXI_awsize(axi_cpu_interconnect_M14_AXI_AWSIZE),
        .M14_AXI_awvalid(axi_cpu_interconnect_M14_AXI_AWVALID),
        .M14_AXI_bready(axi_cpu_interconnect_M14_AXI_BREADY),
        .M14_AXI_bresp(axi_cpu_interconnect_M14_AXI_BRESP),
        .M14_AXI_bvalid(axi_cpu_interconnect_M14_AXI_BVALID),
        .M14_AXI_rdata(axi_cpu_interconnect_M14_AXI_RDATA),
        .M14_AXI_rlast(axi_cpu_interconnect_M14_AXI_RLAST),
        .M14_AXI_rready(axi_cpu_interconnect_M14_AXI_RREADY),
        .M14_AXI_rresp(axi_cpu_interconnect_M14_AXI_RRESP),
        .M14_AXI_rvalid(axi_cpu_interconnect_M14_AXI_RVALID),
        .M14_AXI_wdata(axi_cpu_interconnect_M14_AXI_WDATA),
        .M14_AXI_wlast(axi_cpu_interconnect_M14_AXI_WLAST),
        .M14_AXI_wready(axi_cpu_interconnect_M14_AXI_WREADY),
        .M14_AXI_wstrb(axi_cpu_interconnect_M14_AXI_WSTRB),
        .M14_AXI_wvalid(axi_cpu_interconnect_M14_AXI_WVALID),
        .S00_ACLK(sys_cpu_clk),
        .S00_ARESETN(sys_cpu_resetn),
        .S00_AXI_araddr(S00_AXI_1_ARADDR),
        .S00_AXI_arprot(S00_AXI_1_ARPROT),
        .S00_AXI_arready(S00_AXI_1_ARREADY),
        .S00_AXI_arvalid(S00_AXI_1_ARVALID),
        .S00_AXI_awaddr(S00_AXI_1_AWADDR),
        .S00_AXI_awprot(S00_AXI_1_AWPROT),
        .S00_AXI_awready(S00_AXI_1_AWREADY),
        .S00_AXI_awvalid(S00_AXI_1_AWVALID),
        .S00_AXI_bready(S00_AXI_1_BREADY),
        .S00_AXI_bresp(S00_AXI_1_BRESP),
        .S00_AXI_bvalid(S00_AXI_1_BVALID),
        .S00_AXI_rdata(S00_AXI_1_RDATA),
        .S00_AXI_rready(S00_AXI_1_RREADY),
        .S00_AXI_rresp(S00_AXI_1_RRESP),
        .S00_AXI_rvalid(S00_AXI_1_RVALID),
        .S00_AXI_wdata(S00_AXI_1_WDATA),
        .S00_AXI_wready(S00_AXI_1_WREADY),
        .S00_AXI_wstrb(S00_AXI_1_WSTRB),
        .S00_AXI_wvalid(S00_AXI_1_WVALID),
        .S01_ACLK(sys_cpu_clk),
        .S01_ARESETN(sys_cpu_resetn),
        .S01_AXI_araddr(axi_ethernet_dma_M_AXI_SG_ARADDR),
        .S01_AXI_arburst(axi_ethernet_dma_M_AXI_SG_ARBURST),
        .S01_AXI_arcache(axi_ethernet_dma_M_AXI_SG_ARCACHE),
        .S01_AXI_arlen(axi_ethernet_dma_M_AXI_SG_ARLEN),
        .S01_AXI_arprot(axi_ethernet_dma_M_AXI_SG_ARPROT),
        .S01_AXI_arready(axi_ethernet_dma_M_AXI_SG_ARREADY),
        .S01_AXI_arsize(axi_ethernet_dma_M_AXI_SG_ARSIZE),
        .S01_AXI_arvalid(axi_ethernet_dma_M_AXI_SG_ARVALID),
        .S01_AXI_awaddr(axi_ethernet_dma_M_AXI_SG_AWADDR),
        .S01_AXI_awburst(axi_ethernet_dma_M_AXI_SG_AWBURST),
        .S01_AXI_awcache(axi_ethernet_dma_M_AXI_SG_AWCACHE),
        .S01_AXI_awlen(axi_ethernet_dma_M_AXI_SG_AWLEN),
        .S01_AXI_awprot(axi_ethernet_dma_M_AXI_SG_AWPROT),
        .S01_AXI_awready(axi_ethernet_dma_M_AXI_SG_AWREADY),
        .S01_AXI_awsize(axi_ethernet_dma_M_AXI_SG_AWSIZE),
        .S01_AXI_awvalid(axi_ethernet_dma_M_AXI_SG_AWVALID),
        .S01_AXI_bready(axi_ethernet_dma_M_AXI_SG_BREADY),
        .S01_AXI_bresp(axi_ethernet_dma_M_AXI_SG_BRESP),
        .S01_AXI_bvalid(axi_ethernet_dma_M_AXI_SG_BVALID),
        .S01_AXI_rdata(axi_ethernet_dma_M_AXI_SG_RDATA),
        .S01_AXI_rlast(axi_ethernet_dma_M_AXI_SG_RLAST),
        .S01_AXI_rready(axi_ethernet_dma_M_AXI_SG_RREADY),
        .S01_AXI_rresp(axi_ethernet_dma_M_AXI_SG_RRESP),
        .S01_AXI_rvalid(axi_ethernet_dma_M_AXI_SG_RVALID),
        .S01_AXI_wdata(axi_ethernet_dma_M_AXI_SG_WDATA),
        .S01_AXI_wlast(axi_ethernet_dma_M_AXI_SG_WLAST),
        .S01_AXI_wready(axi_ethernet_dma_M_AXI_SG_WREADY),
        .S01_AXI_wstrb(axi_ethernet_dma_M_AXI_SG_WSTRB),
        .S01_AXI_wvalid(axi_ethernet_dma_M_AXI_SG_WVALID),
        .S02_ACLK(sys_cpu_clk),
        .S02_ARESETN(sys_cpu_resetn),
        .S02_AXI_araddr(axi_ethernet_dma_M_AXI_MM2S_ARADDR),
        .S02_AXI_arburst(axi_ethernet_dma_M_AXI_MM2S_ARBURST),
        .S02_AXI_arcache(axi_ethernet_dma_M_AXI_MM2S_ARCACHE),
        .S02_AXI_arlen(axi_ethernet_dma_M_AXI_MM2S_ARLEN),
        .S02_AXI_arprot(axi_ethernet_dma_M_AXI_MM2S_ARPROT),
        .S02_AXI_arready(axi_ethernet_dma_M_AXI_MM2S_ARREADY),
        .S02_AXI_arsize(axi_ethernet_dma_M_AXI_MM2S_ARSIZE),
        .S02_AXI_arvalid(axi_ethernet_dma_M_AXI_MM2S_ARVALID),
        .S02_AXI_rdata(axi_ethernet_dma_M_AXI_MM2S_RDATA),
        .S02_AXI_rlast(axi_ethernet_dma_M_AXI_MM2S_RLAST),
        .S02_AXI_rready(axi_ethernet_dma_M_AXI_MM2S_RREADY),
        .S02_AXI_rresp(axi_ethernet_dma_M_AXI_MM2S_RRESP),
        .S02_AXI_rvalid(axi_ethernet_dma_M_AXI_MM2S_RVALID),
        .S03_ACLK(sys_cpu_clk),
        .S03_ARESETN(sys_cpu_resetn),
        .S03_AXI_awaddr(axi_ethernet_dma_M_AXI_S2MM_AWADDR),
        .S03_AXI_awburst(axi_ethernet_dma_M_AXI_S2MM_AWBURST),
        .S03_AXI_awcache(axi_ethernet_dma_M_AXI_S2MM_AWCACHE),
        .S03_AXI_awlen(axi_ethernet_dma_M_AXI_S2MM_AWLEN),
        .S03_AXI_awprot(axi_ethernet_dma_M_AXI_S2MM_AWPROT),
        .S03_AXI_awready(axi_ethernet_dma_M_AXI_S2MM_AWREADY),
        .S03_AXI_awsize(axi_ethernet_dma_M_AXI_S2MM_AWSIZE),
        .S03_AXI_awvalid(axi_ethernet_dma_M_AXI_S2MM_AWVALID),
        .S03_AXI_bready(axi_ethernet_dma_M_AXI_S2MM_BREADY),
        .S03_AXI_bresp(axi_ethernet_dma_M_AXI_S2MM_BRESP),
        .S03_AXI_bvalid(axi_ethernet_dma_M_AXI_S2MM_BVALID),
        .S03_AXI_wdata(axi_ethernet_dma_M_AXI_S2MM_WDATA),
        .S03_AXI_wlast(axi_ethernet_dma_M_AXI_S2MM_WLAST),
        .S03_AXI_wready(axi_ethernet_dma_M_AXI_S2MM_WREADY),
        .S03_AXI_wstrb(axi_ethernet_dma_M_AXI_S2MM_WSTRB),
        .S03_AXI_wvalid(axi_ethernet_dma_M_AXI_S2MM_WVALID),
        .S04_ACLK(sys_cpu_clk),
        .S04_ARESETN(sys_cpu_resetn),
        .S04_AXI_araddr(sys_mb_M_AXI_IP_ARADDR),
        .S04_AXI_arprot(sys_mb_M_AXI_IP_ARPROT),
        .S04_AXI_arready(sys_mb_M_AXI_IP_ARREADY),
        .S04_AXI_arvalid(sys_mb_M_AXI_IP_ARVALID),
        .S04_AXI_rdata(sys_mb_M_AXI_IP_RDATA),
        .S04_AXI_rready(sys_mb_M_AXI_IP_RREADY),
        .S04_AXI_rresp(sys_mb_M_AXI_IP_RRESP),
        .S04_AXI_rvalid(sys_mb_M_AXI_IP_RVALID),
        .S05_ACLK(sys_cpu_clk),
        .S05_ARESETN(sys_cpu_resetn),
        .S05_AXI_araddr(S05_AXI_1_ARADDR),
        .S05_AXI_arburst(S05_AXI_1_ARBURST),
        .S05_AXI_arcache(S05_AXI_1_ARCACHE),
        .S05_AXI_arid(S05_AXI_1_ARID),
        .S05_AXI_arlen(S05_AXI_1_ARLEN),
        .S05_AXI_arlock(S05_AXI_1_ARLOCK),
        .S05_AXI_arprot(S05_AXI_1_ARPROT),
        .S05_AXI_arqos(S05_AXI_1_ARQOS),
        .S05_AXI_arready(S05_AXI_1_ARREADY),
        .S05_AXI_arsize(S05_AXI_1_ARSIZE),
        .S05_AXI_arvalid(S05_AXI_1_ARVALID),
        .S05_AXI_awaddr(S05_AXI_1_AWADDR),
        .S05_AXI_awburst(S05_AXI_1_AWBURST),
        .S05_AXI_awcache(S05_AXI_1_AWCACHE),
        .S05_AXI_awid(S05_AXI_1_AWID),
        .S05_AXI_awlen(S05_AXI_1_AWLEN),
        .S05_AXI_awlock(S05_AXI_1_AWLOCK),
        .S05_AXI_awprot(S05_AXI_1_AWPROT),
        .S05_AXI_awqos(S05_AXI_1_AWQOS),
        .S05_AXI_awready(S05_AXI_1_AWREADY),
        .S05_AXI_awsize(S05_AXI_1_AWSIZE),
        .S05_AXI_awvalid(S05_AXI_1_AWVALID),
        .S05_AXI_bid(S05_AXI_1_BID),
        .S05_AXI_bready(S05_AXI_1_BREADY),
        .S05_AXI_bresp(S05_AXI_1_BRESP),
        .S05_AXI_bvalid(S05_AXI_1_BVALID),
        .S05_AXI_rdata(S05_AXI_1_RDATA),
        .S05_AXI_rid(S05_AXI_1_RID),
        .S05_AXI_rlast(S05_AXI_1_RLAST),
        .S05_AXI_rready(S05_AXI_1_RREADY),
        .S05_AXI_rresp(S05_AXI_1_RRESP),
        .S05_AXI_rvalid(S05_AXI_1_RVALID),
        .S05_AXI_wdata(S05_AXI_1_WDATA),
        .S05_AXI_wlast(S05_AXI_1_WLAST),
        .S05_AXI_wready(S05_AXI_1_WREADY),
        .S05_AXI_wstrb(S05_AXI_1_WSTRB),
        .S05_AXI_wvalid(S05_AXI_1_WVALID),
        .S06_ACLK(sys_cpu_clk),
        .S06_ARESETN(sys_cpu_resetn),
        .S06_AXI_araddr(ScanConverterIP_0_m00_axi_ARADDR),
        .S06_AXI_arburst(ScanConverterIP_0_m00_axi_ARBURST),
        .S06_AXI_arcache(ScanConverterIP_0_m00_axi_ARCACHE),
        .S06_AXI_arid(ScanConverterIP_0_m00_axi_ARID),
        .S06_AXI_arlen(ScanConverterIP_0_m00_axi_ARLEN),
        .S06_AXI_arlock(ScanConverterIP_0_m00_axi_ARLOCK),
        .S06_AXI_arprot(ScanConverterIP_0_m00_axi_ARPROT),
        .S06_AXI_arqos(ScanConverterIP_0_m00_axi_ARQOS),
        .S06_AXI_arready(ScanConverterIP_0_m00_axi_ARREADY),
        .S06_AXI_arsize(ScanConverterIP_0_m00_axi_ARSIZE),
        .S06_AXI_arvalid(ScanConverterIP_0_m00_axi_ARVALID),
        .S06_AXI_awaddr(ScanConverterIP_0_m00_axi_AWADDR),
        .S06_AXI_awburst(ScanConverterIP_0_m00_axi_AWBURST),
        .S06_AXI_awcache(ScanConverterIP_0_m00_axi_AWCACHE),
        .S06_AXI_awid(ScanConverterIP_0_m00_axi_AWID),
        .S06_AXI_awlen(ScanConverterIP_0_m00_axi_AWLEN),
        .S06_AXI_awlock(ScanConverterIP_0_m00_axi_AWLOCK),
        .S06_AXI_awprot(ScanConverterIP_0_m00_axi_AWPROT),
        .S06_AXI_awqos(ScanConverterIP_0_m00_axi_AWQOS),
        .S06_AXI_awready(ScanConverterIP_0_m00_axi_AWREADY),
        .S06_AXI_awsize(ScanConverterIP_0_m00_axi_AWSIZE),
        .S06_AXI_awvalid(ScanConverterIP_0_m00_axi_AWVALID),
        .S06_AXI_bid(ScanConverterIP_0_m00_axi_BID),
        .S06_AXI_bready(ScanConverterIP_0_m00_axi_BREADY),
        .S06_AXI_bresp(ScanConverterIP_0_m00_axi_BRESP),
        .S06_AXI_bvalid(ScanConverterIP_0_m00_axi_BVALID),
        .S06_AXI_rdata(ScanConverterIP_0_m00_axi_RDATA),
        .S06_AXI_rid(ScanConverterIP_0_m00_axi_RID),
        .S06_AXI_rlast(ScanConverterIP_0_m00_axi_RLAST),
        .S06_AXI_rready(ScanConverterIP_0_m00_axi_RREADY),
        .S06_AXI_rresp(ScanConverterIP_0_m00_axi_RRESP),
        .S06_AXI_rvalid(ScanConverterIP_0_m00_axi_RVALID),
        .S06_AXI_wdata(ScanConverterIP_0_m00_axi_WDATA),
        .S06_AXI_wlast(ScanConverterIP_0_m00_axi_WLAST),
        .S06_AXI_wready(ScanConverterIP_0_m00_axi_WREADY),
        .S06_AXI_wstrb(ScanConverterIP_0_m00_axi_WSTRB),
        .S06_AXI_wvalid(ScanConverterIP_0_m00_axi_WVALID));
  system_i_bak_axi_ddr_cntrl_0 axi_ddr_cntrl
       (.addn_ui_clkout1(sys_cpu_clk),
        .addn_ui_clkout2(axi_ddr_cntrl_addn_ui_clkout3),
        .c0_ddr4_act_n(axi_ddr_cntrl_C0_DDR4_ACT_N),
        .c0_ddr4_adr(axi_ddr_cntrl_C0_DDR4_ADR),
        .c0_ddr4_aresetn(sys_mem_resetn),
        .c0_ddr4_ba(axi_ddr_cntrl_C0_DDR4_BA),
        .c0_ddr4_bg(axi_ddr_cntrl_C0_DDR4_BG),
        .c0_ddr4_ck_c(axi_ddr_cntrl_C0_DDR4_CK_C),
        .c0_ddr4_ck_t(axi_ddr_cntrl_C0_DDR4_CK_T),
        .c0_ddr4_cke(axi_ddr_cntrl_C0_DDR4_CKE),
        .c0_ddr4_cs_n(axi_ddr_cntrl_C0_DDR4_CS_N),
        .c0_ddr4_dm_dbi_n(c0_ddr4_dm_n[7:0]),
        .c0_ddr4_dq(c0_ddr4_dq[63:0]),
        .c0_ddr4_dqs_c(c0_ddr4_dqs_c[7:0]),
        .c0_ddr4_dqs_t(c0_ddr4_dqs_t[7:0]),
        .c0_ddr4_odt(axi_ddr_cntrl_C0_DDR4_ODT),
        .c0_ddr4_reset_n(axi_ddr_cntrl_C0_DDR4_RESET_N),
        .c0_ddr4_s_axi_araddr(axi_interconnect_0_M00_AXI_ARADDR),
        .c0_ddr4_s_axi_arburst(axi_interconnect_0_M00_AXI_ARBURST),
        .c0_ddr4_s_axi_arcache(axi_interconnect_0_M00_AXI_ARCACHE),
        .c0_ddr4_s_axi_arid(axi_interconnect_0_M00_AXI_ARID),
        .c0_ddr4_s_axi_arlen(axi_interconnect_0_M00_AXI_ARLEN),
        .c0_ddr4_s_axi_arlock(axi_interconnect_0_M00_AXI_ARLOCK),
        .c0_ddr4_s_axi_arprot(axi_interconnect_0_M00_AXI_ARPROT),
        .c0_ddr4_s_axi_arqos(axi_interconnect_0_M00_AXI_ARQOS),
        .c0_ddr4_s_axi_arready(axi_interconnect_0_M00_AXI_ARREADY),
        .c0_ddr4_s_axi_arsize(axi_interconnect_0_M00_AXI_ARSIZE),
        .c0_ddr4_s_axi_arvalid(axi_interconnect_0_M00_AXI_ARVALID),
        .c0_ddr4_s_axi_awaddr(axi_interconnect_0_M00_AXI_AWADDR),
        .c0_ddr4_s_axi_awburst(axi_interconnect_0_M00_AXI_AWBURST),
        .c0_ddr4_s_axi_awcache(axi_interconnect_0_M00_AXI_AWCACHE),
        .c0_ddr4_s_axi_awid(axi_interconnect_0_M00_AXI_AWID),
        .c0_ddr4_s_axi_awlen(axi_interconnect_0_M00_AXI_AWLEN),
        .c0_ddr4_s_axi_awlock(axi_interconnect_0_M00_AXI_AWLOCK),
        .c0_ddr4_s_axi_awprot(axi_interconnect_0_M00_AXI_AWPROT),
        .c0_ddr4_s_axi_awqos(axi_interconnect_0_M00_AXI_AWQOS),
        .c0_ddr4_s_axi_awready(axi_interconnect_0_M00_AXI_AWREADY),
        .c0_ddr4_s_axi_awsize(axi_interconnect_0_M00_AXI_AWSIZE),
        .c0_ddr4_s_axi_awvalid(axi_interconnect_0_M00_AXI_AWVALID),
        .c0_ddr4_s_axi_bid(axi_interconnect_0_M00_AXI_BID),
        .c0_ddr4_s_axi_bready(axi_interconnect_0_M00_AXI_BREADY),
        .c0_ddr4_s_axi_bresp(axi_interconnect_0_M00_AXI_BRESP),
        .c0_ddr4_s_axi_bvalid(axi_interconnect_0_M00_AXI_BVALID),
        .c0_ddr4_s_axi_rdata(axi_interconnect_0_M00_AXI_RDATA),
        .c0_ddr4_s_axi_rid(axi_interconnect_0_M00_AXI_RID),
        .c0_ddr4_s_axi_rlast(axi_interconnect_0_M00_AXI_RLAST),
        .c0_ddr4_s_axi_rready(axi_interconnect_0_M00_AXI_RREADY),
        .c0_ddr4_s_axi_rresp(axi_interconnect_0_M00_AXI_RRESP),
        .c0_ddr4_s_axi_rvalid(axi_interconnect_0_M00_AXI_RVALID),
        .c0_ddr4_s_axi_wdata(axi_interconnect_0_M00_AXI_WDATA),
        .c0_ddr4_s_axi_wlast(axi_interconnect_0_M00_AXI_WLAST),
        .c0_ddr4_s_axi_wready(axi_interconnect_0_M00_AXI_WREADY),
        .c0_ddr4_s_axi_wstrb(axi_interconnect_0_M00_AXI_WSTRB),
        .c0_ddr4_s_axi_wvalid(axi_interconnect_0_M00_AXI_WVALID),
        .c0_ddr4_ui_clk(sys_mem_clk),
        .c0_ddr4_ui_clk_sync_rst(axi_ddr_cntrl_c0_ddr4_ui_clk_sync_rst),
        .c0_sys_clk_n(sys_clk_1_CLK_N),
        .c0_sys_clk_p(sys_clk_1_CLK_P),
        .sys_rst(sys_rst_1));
  system_i_bak_axi_ddr_cntrl_rstgen_0 axi_ddr_cntrl_rstgen
       (.aux_reset_in(1'b1),
        .dcm_locked(1'b1),
        .ext_reset_in(axi_ddr_cntrl_c0_ddr4_ui_clk_sync_rst),
        .mb_debug_sys_rst(1'b0),
        .peripheral_aresetn(sys_mem_resetn),
        .slowest_sync_clk(sys_mem_clk));
  system_i_bak_axi_ethernet_0_0 axi_ethernet_0
       (.axi_rxd_arstn(axi_ethernet_dma_s2mm_prmry_reset_out_n),
        .axi_rxs_arstn(axi_ethernet_dma_s2mm_sts_reset_out_n),
        .axi_txc_arstn(axi_ethernet_dma_mm2s_cntrl_reset_out_n),
        .axi_txd_arstn(axi_ethernet_dma_mm2s_prmry_reset_out_n),
        .axis_clk(sys_cpu_clk),
        .clk125m(axi_ethernet_clkgen_clk_out1),
        .clk312(axi_ethernet_clkgen_clk_out2),
        .clk625(axi_ethernet_clkgen_clk_out3),
        .idelay_rdy_in(axi_ethernet_idelayctrl_rdy),
        .interrupt(axi_ethernet_0_interrupt),
        .m_axis_rxd_tdata(axi_ethernet_0_m_axis_rxd_TDATA),
        .m_axis_rxd_tkeep(axi_ethernet_0_m_axis_rxd_TKEEP),
        .m_axis_rxd_tlast(axi_ethernet_0_m_axis_rxd_TLAST),
        .m_axis_rxd_tready(axi_ethernet_0_m_axis_rxd_TREADY),
        .m_axis_rxd_tvalid(axi_ethernet_0_m_axis_rxd_TVALID),
        .m_axis_rxs_tdata(axi_ethernet_0_m_axis_rxs_TDATA),
        .m_axis_rxs_tkeep(axi_ethernet_0_m_axis_rxs_TKEEP),
        .m_axis_rxs_tlast(axi_ethernet_0_m_axis_rxs_TLAST),
        .m_axis_rxs_tready(axi_ethernet_0_m_axis_rxs_TREADY),
        .m_axis_rxs_tvalid(axi_ethernet_0_m_axis_rxs_TVALID),
        .mdio_mdc(axi_ethernet_0_mdio_MDC),
        .mdio_mdio_i(axi_ethernet_0_mdio_MDIO_I),
        .mdio_mdio_o(axi_ethernet_0_mdio_MDIO_O),
        .mdio_mdio_t(axi_ethernet_0_mdio_MDIO_T),
        .mmcm_locked(axi_ethernet_clkgen_locked),
        .rst_125(axi_ethernet_rstgen_peripheral_reset),
        .s_axi_araddr(axi_cpu_interconnect_M08_AXI_ARADDR),
        .s_axi_arready(axi_cpu_interconnect_M08_AXI_ARREADY),
        .s_axi_arvalid(axi_cpu_interconnect_M08_AXI_ARVALID),
        .s_axi_awaddr(axi_cpu_interconnect_M08_AXI_AWADDR),
        .s_axi_awready(axi_cpu_interconnect_M08_AXI_AWREADY),
        .s_axi_awvalid(axi_cpu_interconnect_M08_AXI_AWVALID),
        .s_axi_bready(axi_cpu_interconnect_M08_AXI_BREADY),
        .s_axi_bresp(axi_cpu_interconnect_M08_AXI_BRESP),
        .s_axi_bvalid(axi_cpu_interconnect_M08_AXI_BVALID),
        .s_axi_lite_clk(sys_cpu_clk),
        .s_axi_lite_resetn(sys_cpu_resetn),
        .s_axi_rdata(axi_cpu_interconnect_M08_AXI_RDATA),
        .s_axi_rready(axi_cpu_interconnect_M08_AXI_RREADY),
        .s_axi_rresp(axi_cpu_interconnect_M08_AXI_RRESP),
        .s_axi_rvalid(axi_cpu_interconnect_M08_AXI_RVALID),
        .s_axi_wdata(axi_cpu_interconnect_M08_AXI_WDATA),
        .s_axi_wready(axi_cpu_interconnect_M08_AXI_WREADY),
        .s_axi_wstrb(axi_cpu_interconnect_M08_AXI_WSTRB),
        .s_axi_wvalid(axi_cpu_interconnect_M08_AXI_WVALID),
        .s_axis_txc_tdata(axi_ethernet_dma_M_AXIS_CNTRL_TDATA),
        .s_axis_txc_tkeep(axi_ethernet_dma_M_AXIS_CNTRL_TKEEP),
        .s_axis_txc_tlast(axi_ethernet_dma_M_AXIS_CNTRL_TLAST),
        .s_axis_txc_tready(axi_ethernet_dma_M_AXIS_CNTRL_TREADY),
        .s_axis_txc_tvalid(axi_ethernet_dma_M_AXIS_CNTRL_TVALID),
        .s_axis_txd_tdata(axi_ethernet_dma_M_AXIS_MM2S_TDATA),
        .s_axis_txd_tkeep(axi_ethernet_dma_M_AXIS_MM2S_TKEEP),
        .s_axis_txd_tlast(axi_ethernet_dma_M_AXIS_MM2S_TLAST),
        .s_axis_txd_tready(axi_ethernet_dma_M_AXIS_MM2S_TREADY),
        .s_axis_txd_tvalid(axi_ethernet_dma_M_AXIS_MM2S_TVALID),
        .sgmii_rxn(axi_ethernet_0_sgmii_RXN),
        .sgmii_rxp(axi_ethernet_0_sgmii_RXP),
        .sgmii_txn(axi_ethernet_0_sgmii_TXN),
        .sgmii_txp(axi_ethernet_0_sgmii_TXP),
        .signal_detect(xlconstant_4_dout));
  system_i_bak_axi_ethernet_clkgen_0 axi_ethernet_clkgen
       (.clk_in1_n(phy_clk_1_CLK_N),
        .clk_in1_p(phy_clk_1_CLK_P),
        .clk_out1(axi_ethernet_clkgen_clk_out1),
        .clk_out2(axi_ethernet_clkgen_clk_out2),
        .clk_out3(axi_ethernet_clkgen_clk_out3),
        .clk_out4(axi_ethernet_clkgen_clk_out4),
        .clk_out5(axi_ethernet_clkgen_clk_out5),
        .locked(axi_ethernet_clkgen_locked));
  system_i_bak_axi_ethernet_dma_0 axi_ethernet_dma
       (.axi_resetn(sys_cpu_resetn),
        .m_axi_mm2s_aclk(sys_cpu_clk),
        .m_axi_mm2s_araddr(axi_ethernet_dma_M_AXI_MM2S_ARADDR),
        .m_axi_mm2s_arburst(axi_ethernet_dma_M_AXI_MM2S_ARBURST),
        .m_axi_mm2s_arcache(axi_ethernet_dma_M_AXI_MM2S_ARCACHE),
        .m_axi_mm2s_arlen(axi_ethernet_dma_M_AXI_MM2S_ARLEN),
        .m_axi_mm2s_arprot(axi_ethernet_dma_M_AXI_MM2S_ARPROT),
        .m_axi_mm2s_arready(axi_ethernet_dma_M_AXI_MM2S_ARREADY),
        .m_axi_mm2s_arsize(axi_ethernet_dma_M_AXI_MM2S_ARSIZE),
        .m_axi_mm2s_arvalid(axi_ethernet_dma_M_AXI_MM2S_ARVALID),
        .m_axi_mm2s_rdata(axi_ethernet_dma_M_AXI_MM2S_RDATA),
        .m_axi_mm2s_rlast(axi_ethernet_dma_M_AXI_MM2S_RLAST),
        .m_axi_mm2s_rready(axi_ethernet_dma_M_AXI_MM2S_RREADY),
        .m_axi_mm2s_rresp(axi_ethernet_dma_M_AXI_MM2S_RRESP),
        .m_axi_mm2s_rvalid(axi_ethernet_dma_M_AXI_MM2S_RVALID),
        .m_axi_s2mm_aclk(sys_cpu_clk),
        .m_axi_s2mm_awaddr(axi_ethernet_dma_M_AXI_S2MM_AWADDR),
        .m_axi_s2mm_awburst(axi_ethernet_dma_M_AXI_S2MM_AWBURST),
        .m_axi_s2mm_awcache(axi_ethernet_dma_M_AXI_S2MM_AWCACHE),
        .m_axi_s2mm_awlen(axi_ethernet_dma_M_AXI_S2MM_AWLEN),
        .m_axi_s2mm_awprot(axi_ethernet_dma_M_AXI_S2MM_AWPROT),
        .m_axi_s2mm_awready(axi_ethernet_dma_M_AXI_S2MM_AWREADY),
        .m_axi_s2mm_awsize(axi_ethernet_dma_M_AXI_S2MM_AWSIZE),
        .m_axi_s2mm_awvalid(axi_ethernet_dma_M_AXI_S2MM_AWVALID),
        .m_axi_s2mm_bready(axi_ethernet_dma_M_AXI_S2MM_BREADY),
        .m_axi_s2mm_bresp(axi_ethernet_dma_M_AXI_S2MM_BRESP),
        .m_axi_s2mm_bvalid(axi_ethernet_dma_M_AXI_S2MM_BVALID),
        .m_axi_s2mm_wdata(axi_ethernet_dma_M_AXI_S2MM_WDATA),
        .m_axi_s2mm_wlast(axi_ethernet_dma_M_AXI_S2MM_WLAST),
        .m_axi_s2mm_wready(axi_ethernet_dma_M_AXI_S2MM_WREADY),
        .m_axi_s2mm_wstrb(axi_ethernet_dma_M_AXI_S2MM_WSTRB),
        .m_axi_s2mm_wvalid(axi_ethernet_dma_M_AXI_S2MM_WVALID),
        .m_axi_sg_aclk(sys_cpu_clk),
        .m_axi_sg_araddr(axi_ethernet_dma_M_AXI_SG_ARADDR),
        .m_axi_sg_arburst(axi_ethernet_dma_M_AXI_SG_ARBURST),
        .m_axi_sg_arcache(axi_ethernet_dma_M_AXI_SG_ARCACHE),
        .m_axi_sg_arlen(axi_ethernet_dma_M_AXI_SG_ARLEN),
        .m_axi_sg_arprot(axi_ethernet_dma_M_AXI_SG_ARPROT),
        .m_axi_sg_arready(axi_ethernet_dma_M_AXI_SG_ARREADY),
        .m_axi_sg_arsize(axi_ethernet_dma_M_AXI_SG_ARSIZE),
        .m_axi_sg_arvalid(axi_ethernet_dma_M_AXI_SG_ARVALID),
        .m_axi_sg_awaddr(axi_ethernet_dma_M_AXI_SG_AWADDR),
        .m_axi_sg_awburst(axi_ethernet_dma_M_AXI_SG_AWBURST),
        .m_axi_sg_awcache(axi_ethernet_dma_M_AXI_SG_AWCACHE),
        .m_axi_sg_awlen(axi_ethernet_dma_M_AXI_SG_AWLEN),
        .m_axi_sg_awprot(axi_ethernet_dma_M_AXI_SG_AWPROT),
        .m_axi_sg_awready(axi_ethernet_dma_M_AXI_SG_AWREADY),
        .m_axi_sg_awsize(axi_ethernet_dma_M_AXI_SG_AWSIZE),
        .m_axi_sg_awvalid(axi_ethernet_dma_M_AXI_SG_AWVALID),
        .m_axi_sg_bready(axi_ethernet_dma_M_AXI_SG_BREADY),
        .m_axi_sg_bresp(axi_ethernet_dma_M_AXI_SG_BRESP),
        .m_axi_sg_bvalid(axi_ethernet_dma_M_AXI_SG_BVALID),
        .m_axi_sg_rdata(axi_ethernet_dma_M_AXI_SG_RDATA),
        .m_axi_sg_rlast(axi_ethernet_dma_M_AXI_SG_RLAST),
        .m_axi_sg_rready(axi_ethernet_dma_M_AXI_SG_RREADY),
        .m_axi_sg_rresp(axi_ethernet_dma_M_AXI_SG_RRESP),
        .m_axi_sg_rvalid(axi_ethernet_dma_M_AXI_SG_RVALID),
        .m_axi_sg_wdata(axi_ethernet_dma_M_AXI_SG_WDATA),
        .m_axi_sg_wlast(axi_ethernet_dma_M_AXI_SG_WLAST),
        .m_axi_sg_wready(axi_ethernet_dma_M_AXI_SG_WREADY),
        .m_axi_sg_wstrb(axi_ethernet_dma_M_AXI_SG_WSTRB),
        .m_axi_sg_wvalid(axi_ethernet_dma_M_AXI_SG_WVALID),
        .m_axis_mm2s_cntrl_tdata(axi_ethernet_dma_M_AXIS_CNTRL_TDATA),
        .m_axis_mm2s_cntrl_tkeep(axi_ethernet_dma_M_AXIS_CNTRL_TKEEP),
        .m_axis_mm2s_cntrl_tlast(axi_ethernet_dma_M_AXIS_CNTRL_TLAST),
        .m_axis_mm2s_cntrl_tready(axi_ethernet_dma_M_AXIS_CNTRL_TREADY),
        .m_axis_mm2s_cntrl_tvalid(axi_ethernet_dma_M_AXIS_CNTRL_TVALID),
        .m_axis_mm2s_tdata(axi_ethernet_dma_M_AXIS_MM2S_TDATA),
        .m_axis_mm2s_tkeep(axi_ethernet_dma_M_AXIS_MM2S_TKEEP),
        .m_axis_mm2s_tlast(axi_ethernet_dma_M_AXIS_MM2S_TLAST),
        .m_axis_mm2s_tready(axi_ethernet_dma_M_AXIS_MM2S_TREADY),
        .m_axis_mm2s_tvalid(axi_ethernet_dma_M_AXIS_MM2S_TVALID),
        .mm2s_cntrl_reset_out_n(axi_ethernet_dma_mm2s_cntrl_reset_out_n),
        .mm2s_introut(axi_ethernet_dma_mm2s_introut),
        .mm2s_prmry_reset_out_n(axi_ethernet_dma_mm2s_prmry_reset_out_n),
        .s2mm_introut(axi_ethernet_dma_s2mm_introut),
        .s2mm_prmry_reset_out_n(axi_ethernet_dma_s2mm_prmry_reset_out_n),
        .s2mm_sts_reset_out_n(axi_ethernet_dma_s2mm_sts_reset_out_n),
        .s_axi_lite_aclk(sys_cpu_clk),
        .s_axi_lite_araddr(axi_cpu_interconnect_M02_AXI_ARADDR[9:0]),
        .s_axi_lite_arready(axi_cpu_interconnect_M02_AXI_ARREADY),
        .s_axi_lite_arvalid(axi_cpu_interconnect_M02_AXI_ARVALID),
        .s_axi_lite_awaddr(axi_cpu_interconnect_M02_AXI_AWADDR[9:0]),
        .s_axi_lite_awready(axi_cpu_interconnect_M02_AXI_AWREADY),
        .s_axi_lite_awvalid(axi_cpu_interconnect_M02_AXI_AWVALID),
        .s_axi_lite_bready(axi_cpu_interconnect_M02_AXI_BREADY),
        .s_axi_lite_bresp(axi_cpu_interconnect_M02_AXI_BRESP),
        .s_axi_lite_bvalid(axi_cpu_interconnect_M02_AXI_BVALID),
        .s_axi_lite_rdata(axi_cpu_interconnect_M02_AXI_RDATA),
        .s_axi_lite_rready(axi_cpu_interconnect_M02_AXI_RREADY),
        .s_axi_lite_rresp(axi_cpu_interconnect_M02_AXI_RRESP),
        .s_axi_lite_rvalid(axi_cpu_interconnect_M02_AXI_RVALID),
        .s_axi_lite_wdata(axi_cpu_interconnect_M02_AXI_WDATA),
        .s_axi_lite_wready(axi_cpu_interconnect_M02_AXI_WREADY),
        .s_axi_lite_wvalid(axi_cpu_interconnect_M02_AXI_WVALID),
        .s_axis_s2mm_sts_tdata(axi_ethernet_0_m_axis_rxs_TDATA),
        .s_axis_s2mm_sts_tkeep(axi_ethernet_0_m_axis_rxs_TKEEP),
        .s_axis_s2mm_sts_tlast(axi_ethernet_0_m_axis_rxs_TLAST),
        .s_axis_s2mm_sts_tready(axi_ethernet_0_m_axis_rxs_TREADY),
        .s_axis_s2mm_sts_tvalid(axi_ethernet_0_m_axis_rxs_TVALID),
        .s_axis_s2mm_tdata(axi_ethernet_0_m_axis_rxd_TDATA),
        .s_axis_s2mm_tkeep(axi_ethernet_0_m_axis_rxd_TKEEP),
        .s_axis_s2mm_tlast(axi_ethernet_0_m_axis_rxd_TLAST),
        .s_axis_s2mm_tready(axi_ethernet_0_m_axis_rxd_TREADY),
        .s_axis_s2mm_tvalid(axi_ethernet_0_m_axis_rxd_TVALID));
  system_i_bak_axi_ethernet_idelayctrl_0 axi_ethernet_idelayctrl
       (.rdy(axi_ethernet_idelayctrl_rdy),
        .ref_clk(axi_ethernet_clkgen_clk_out5),
        .rst(axi_ethernet_rstgen_peripheral_reset));
  system_i_bak_axi_ethernet_rstgen_0 axi_ethernet_rstgen
       (.aux_reset_in(1'b1),
        .dcm_locked(1'b1),
        .ext_reset_in(axi_ddr_cntrl_c0_ddr4_ui_clk_sync_rst),
        .mb_debug_sys_rst(1'b0),
        .peripheral_reset(axi_ethernet_rstgen_peripheral_reset),
        .slowest_sync_clk(axi_ethernet_clkgen_clk_out1));
  system_i_bak_axi_gpio_0_1 axi_gpio_0
       (.gpio2_io_i(axi_gpio_0_GPIO2_TRI_I),
        .gpio_io_o(axi_gpio_0_GPIO_TRI_O),
        .s_axi_aclk(sys_cpu_clk),
        .s_axi_araddr(axi_cpu_interconnect_M12_AXI_ARADDR[8:0]),
        .s_axi_aresetn(sys_cpu_resetn),
        .s_axi_arready(axi_cpu_interconnect_M12_AXI_ARREADY),
        .s_axi_arvalid(axi_cpu_interconnect_M12_AXI_ARVALID),
        .s_axi_awaddr(axi_cpu_interconnect_M12_AXI_AWADDR[8:0]),
        .s_axi_awready(axi_cpu_interconnect_M12_AXI_AWREADY),
        .s_axi_awvalid(axi_cpu_interconnect_M12_AXI_AWVALID),
        .s_axi_bready(axi_cpu_interconnect_M12_AXI_BREADY),
        .s_axi_bresp(axi_cpu_interconnect_M12_AXI_BRESP),
        .s_axi_bvalid(axi_cpu_interconnect_M12_AXI_BVALID),
        .s_axi_rdata(axi_cpu_interconnect_M12_AXI_RDATA),
        .s_axi_rready(axi_cpu_interconnect_M12_AXI_RREADY),
        .s_axi_rresp(axi_cpu_interconnect_M12_AXI_RRESP),
        .s_axi_rvalid(axi_cpu_interconnect_M12_AXI_RVALID),
        .s_axi_wdata(axi_cpu_interconnect_M12_AXI_WDATA),
        .s_axi_wready(axi_cpu_interconnect_M12_AXI_WREADY),
        .s_axi_wstrb(axi_cpu_interconnect_M12_AXI_WSTRB),
        .s_axi_wvalid(axi_cpu_interconnect_M12_AXI_WVALID));
  system_i_bak_axi_hdmi_tx_0_0 axi_hdmi_tx_0
       (.hdmi_16_data(axi_hdmi_tx_0_hdmi_16_data),
        .hdmi_16_data_e(axi_hdmi_tx_0_hdmi_16_data_e),
        .hdmi_16_hsync(axi_hdmi_tx_0_hdmi_16_hsync),
        .hdmi_16_vsync(axi_hdmi_tx_0_hdmi_16_vsync),
        .hdmi_clk(axi_ddr_cntrl_addn_ui_clkout2),
        .hdmi_out_clk(axi_hdmi_tx_0_hdmi_out_clk),
        .s_axi_aclk(sys_cpu_clk),
        .s_axi_araddr(axi_cpu_interconnect_M11_AXI_ARADDR),
        .s_axi_aresetn(sys_cpu_resetn),
        .s_axi_arprot(axi_cpu_interconnect_M11_AXI_ARPROT),
        .s_axi_arready(axi_cpu_interconnect_M11_AXI_ARREADY),
        .s_axi_arvalid(axi_cpu_interconnect_M11_AXI_ARVALID),
        .s_axi_awaddr(axi_cpu_interconnect_M11_AXI_AWADDR),
        .s_axi_awprot(axi_cpu_interconnect_M11_AXI_AWPROT),
        .s_axi_awready(axi_cpu_interconnect_M11_AXI_AWREADY),
        .s_axi_awvalid(axi_cpu_interconnect_M11_AXI_AWVALID),
        .s_axi_bready(axi_cpu_interconnect_M11_AXI_BREADY),
        .s_axi_bresp(axi_cpu_interconnect_M11_AXI_BRESP),
        .s_axi_bvalid(axi_cpu_interconnect_M11_AXI_BVALID),
        .s_axi_rdata(axi_cpu_interconnect_M11_AXI_RDATA),
        .s_axi_rready(axi_cpu_interconnect_M11_AXI_RREADY),
        .s_axi_rresp(axi_cpu_interconnect_M11_AXI_RRESP),
        .s_axi_rvalid(axi_cpu_interconnect_M11_AXI_RVALID),
        .s_axi_wdata(axi_cpu_interconnect_M11_AXI_WDATA),
        .s_axi_wready(axi_cpu_interconnect_M11_AXI_WREADY),
        .s_axi_wstrb(axi_cpu_interconnect_M11_AXI_WSTRB),
        .s_axi_wvalid(axi_cpu_interconnect_M11_AXI_WVALID),
        .vdma_clk(sys_cpu_clk),
        .vdma_data(axi_vdma_0_m_axis_mm2s_tdata),
        .vdma_fs(axi_hdmi_tx_0_vdma_fs),
        .vdma_fs_ret(axi_hdmi_tx_0_vdma_fs),
        .vdma_ready(axi_hdmi_tx_0_vdma_ready),
        .vdma_valid(axi_vdma_0_m_axis_mm2s_tvalid));
  system_i_bak_axi_iic_0_0 axi_iic_0
       (.iic2intc_irpt(axi_iic_0_iic2intc_irpt),
        .s_axi_aclk(sys_cpu_clk),
        .s_axi_araddr(axi_cpu_interconnect_M09_AXI_ARADDR[8:0]),
        .s_axi_aresetn(sys_cpu_resetn),
        .s_axi_arready(axi_cpu_interconnect_M09_AXI_ARREADY),
        .s_axi_arvalid(axi_cpu_interconnect_M09_AXI_ARVALID),
        .s_axi_awaddr(axi_cpu_interconnect_M09_AXI_AWADDR[8:0]),
        .s_axi_awready(axi_cpu_interconnect_M09_AXI_AWREADY),
        .s_axi_awvalid(axi_cpu_interconnect_M09_AXI_AWVALID),
        .s_axi_bready(axi_cpu_interconnect_M09_AXI_BREADY),
        .s_axi_bresp(axi_cpu_interconnect_M09_AXI_BRESP),
        .s_axi_bvalid(axi_cpu_interconnect_M09_AXI_BVALID),
        .s_axi_rdata(axi_cpu_interconnect_M09_AXI_RDATA),
        .s_axi_rready(axi_cpu_interconnect_M09_AXI_RREADY),
        .s_axi_rresp(axi_cpu_interconnect_M09_AXI_RRESP),
        .s_axi_rvalid(axi_cpu_interconnect_M09_AXI_RVALID),
        .s_axi_wdata(axi_cpu_interconnect_M09_AXI_WDATA),
        .s_axi_wready(axi_cpu_interconnect_M09_AXI_WREADY),
        .s_axi_wstrb(axi_cpu_interconnect_M09_AXI_WSTRB),
        .s_axi_wvalid(axi_cpu_interconnect_M09_AXI_WVALID),
        .scl_i(axi_iic_0_IIC_SCL_I),
        .scl_o(axi_iic_0_IIC_SCL_O),
        .scl_t(axi_iic_0_IIC_SCL_T),
        .sda_i(axi_iic_0_IIC_SDA_I),
        .sda_o(axi_iic_0_IIC_SDA_O),
        .sda_t(axi_iic_0_IIC_SDA_T));
  system_i_bak_axi_intc_0 axi_intc
       (.intr(sys_concat_intc_dout),
        .irq(axi_intc_interrupt_INTERRUPT),
        .s_axi_aclk(sys_cpu_clk),
        .s_axi_araddr(axi_cpu_interconnect_M04_AXI_ARADDR[8:0]),
        .s_axi_aresetn(sys_cpu_resetn),
        .s_axi_arready(axi_cpu_interconnect_M04_AXI_ARREADY),
        .s_axi_arvalid(axi_cpu_interconnect_M04_AXI_ARVALID),
        .s_axi_awaddr(axi_cpu_interconnect_M04_AXI_AWADDR[8:0]),
        .s_axi_awready(axi_cpu_interconnect_M04_AXI_AWREADY),
        .s_axi_awvalid(axi_cpu_interconnect_M04_AXI_AWVALID),
        .s_axi_bready(axi_cpu_interconnect_M04_AXI_BREADY),
        .s_axi_bresp(axi_cpu_interconnect_M04_AXI_BRESP),
        .s_axi_bvalid(axi_cpu_interconnect_M04_AXI_BVALID),
        .s_axi_rdata(axi_cpu_interconnect_M04_AXI_RDATA),
        .s_axi_rready(axi_cpu_interconnect_M04_AXI_RREADY),
        .s_axi_rresp(axi_cpu_interconnect_M04_AXI_RRESP),
        .s_axi_rvalid(axi_cpu_interconnect_M04_AXI_RVALID),
        .s_axi_wdata(axi_cpu_interconnect_M04_AXI_WDATA),
        .s_axi_wready(axi_cpu_interconnect_M04_AXI_WREADY),
        .s_axi_wstrb(axi_cpu_interconnect_M04_AXI_WSTRB),
        .s_axi_wvalid(axi_cpu_interconnect_M04_AXI_WVALID));
  system_i_bak_axi_interconnect_0_0 axi_interconnect_0
       (.ACLK(sys_cpu_clk),
        .ARESETN(sys_cpu_resetn),
        .M00_ACLK(sys_mem_clk),
        .M00_ARESETN(sys_mem_resetn),
        .M00_AXI_araddr(axi_interconnect_0_M00_AXI_ARADDR),
        .M00_AXI_arburst(axi_interconnect_0_M00_AXI_ARBURST),
        .M00_AXI_arcache(axi_interconnect_0_M00_AXI_ARCACHE),
        .M00_AXI_arid(axi_interconnect_0_M00_AXI_ARID),
        .M00_AXI_arlen(axi_interconnect_0_M00_AXI_ARLEN),
        .M00_AXI_arlock(axi_interconnect_0_M00_AXI_ARLOCK),
        .M00_AXI_arprot(axi_interconnect_0_M00_AXI_ARPROT),
        .M00_AXI_arqos(axi_interconnect_0_M00_AXI_ARQOS),
        .M00_AXI_arready(axi_interconnect_0_M00_AXI_ARREADY),
        .M00_AXI_arsize(axi_interconnect_0_M00_AXI_ARSIZE),
        .M00_AXI_arvalid(axi_interconnect_0_M00_AXI_ARVALID),
        .M00_AXI_awaddr(axi_interconnect_0_M00_AXI_AWADDR),
        .M00_AXI_awburst(axi_interconnect_0_M00_AXI_AWBURST),
        .M00_AXI_awcache(axi_interconnect_0_M00_AXI_AWCACHE),
        .M00_AXI_awid(axi_interconnect_0_M00_AXI_AWID),
        .M00_AXI_awlen(axi_interconnect_0_M00_AXI_AWLEN),
        .M00_AXI_awlock(axi_interconnect_0_M00_AXI_AWLOCK),
        .M00_AXI_awprot(axi_interconnect_0_M00_AXI_AWPROT),
        .M00_AXI_awqos(axi_interconnect_0_M00_AXI_AWQOS),
        .M00_AXI_awready(axi_interconnect_0_M00_AXI_AWREADY),
        .M00_AXI_awsize(axi_interconnect_0_M00_AXI_AWSIZE),
        .M00_AXI_awvalid(axi_interconnect_0_M00_AXI_AWVALID),
        .M00_AXI_bid(axi_interconnect_0_M00_AXI_BID),
        .M00_AXI_bready(axi_interconnect_0_M00_AXI_BREADY),
        .M00_AXI_bresp(axi_interconnect_0_M00_AXI_BRESP),
        .M00_AXI_bvalid(axi_interconnect_0_M00_AXI_BVALID),
        .M00_AXI_rdata(axi_interconnect_0_M00_AXI_RDATA),
        .M00_AXI_rid(axi_interconnect_0_M00_AXI_RID),
        .M00_AXI_rlast(axi_interconnect_0_M00_AXI_RLAST),
        .M00_AXI_rready(axi_interconnect_0_M00_AXI_RREADY),
        .M00_AXI_rresp(axi_interconnect_0_M00_AXI_RRESP),
        .M00_AXI_rvalid(axi_interconnect_0_M00_AXI_RVALID),
        .M00_AXI_wdata(axi_interconnect_0_M00_AXI_WDATA),
        .M00_AXI_wlast(axi_interconnect_0_M00_AXI_WLAST),
        .M00_AXI_wready(axi_interconnect_0_M00_AXI_WREADY),
        .M00_AXI_wstrb(axi_interconnect_0_M00_AXI_WSTRB),
        .M00_AXI_wvalid(axi_interconnect_0_M00_AXI_WVALID),
        .S00_ACLK(sys_cpu_clk),
        .S00_ARESETN(sys_cpu_resetn),
        .S00_AXI_araddr(sys_mb_M_AXI_DC_ARADDR),
        .S00_AXI_arburst(sys_mb_M_AXI_DC_ARBURST),
        .S00_AXI_arcache(sys_mb_M_AXI_DC_ARCACHE),
        .S00_AXI_arlen(sys_mb_M_AXI_DC_ARLEN),
        .S00_AXI_arlock(sys_mb_M_AXI_DC_ARLOCK),
        .S00_AXI_arprot(sys_mb_M_AXI_DC_ARPROT),
        .S00_AXI_arqos(sys_mb_M_AXI_DC_ARQOS),
        .S00_AXI_arready(sys_mb_M_AXI_DC_ARREADY),
        .S00_AXI_arsize(sys_mb_M_AXI_DC_ARSIZE),
        .S00_AXI_arvalid(sys_mb_M_AXI_DC_ARVALID),
        .S00_AXI_awaddr(sys_mb_M_AXI_DC_AWADDR),
        .S00_AXI_awburst(sys_mb_M_AXI_DC_AWBURST),
        .S00_AXI_awcache(sys_mb_M_AXI_DC_AWCACHE),
        .S00_AXI_awlen(sys_mb_M_AXI_DC_AWLEN),
        .S00_AXI_awlock(sys_mb_M_AXI_DC_AWLOCK),
        .S00_AXI_awprot(sys_mb_M_AXI_DC_AWPROT),
        .S00_AXI_awqos(sys_mb_M_AXI_DC_AWQOS),
        .S00_AXI_awready(sys_mb_M_AXI_DC_AWREADY),
        .S00_AXI_awsize(sys_mb_M_AXI_DC_AWSIZE),
        .S00_AXI_awvalid(sys_mb_M_AXI_DC_AWVALID),
        .S00_AXI_bready(sys_mb_M_AXI_DC_BREADY),
        .S00_AXI_bresp(sys_mb_M_AXI_DC_BRESP),
        .S00_AXI_bvalid(sys_mb_M_AXI_DC_BVALID),
        .S00_AXI_rdata(sys_mb_M_AXI_DC_RDATA),
        .S00_AXI_rlast(sys_mb_M_AXI_DC_RLAST),
        .S00_AXI_rready(sys_mb_M_AXI_DC_RREADY),
        .S00_AXI_rresp(sys_mb_M_AXI_DC_RRESP),
        .S00_AXI_rvalid(sys_mb_M_AXI_DC_RVALID),
        .S00_AXI_wdata(sys_mb_M_AXI_DC_WDATA),
        .S00_AXI_wlast(sys_mb_M_AXI_DC_WLAST),
        .S00_AXI_wready(sys_mb_M_AXI_DC_WREADY),
        .S00_AXI_wstrb(sys_mb_M_AXI_DC_WSTRB),
        .S00_AXI_wvalid(sys_mb_M_AXI_DC_WVALID),
        .S01_ACLK(sys_cpu_clk),
        .S01_ARESETN(sys_cpu_resetn),
        .S01_AXI_araddr(sys_mb_M_AXI_IC_ARADDR),
        .S01_AXI_arburst(sys_mb_M_AXI_IC_ARBURST),
        .S01_AXI_arcache(sys_mb_M_AXI_IC_ARCACHE),
        .S01_AXI_arlen(sys_mb_M_AXI_IC_ARLEN),
        .S01_AXI_arlock(sys_mb_M_AXI_IC_ARLOCK),
        .S01_AXI_arprot(sys_mb_M_AXI_IC_ARPROT),
        .S01_AXI_arqos(sys_mb_M_AXI_IC_ARQOS),
        .S01_AXI_arready(sys_mb_M_AXI_IC_ARREADY),
        .S01_AXI_arsize(sys_mb_M_AXI_IC_ARSIZE),
        .S01_AXI_arvalid(sys_mb_M_AXI_IC_ARVALID),
        .S01_AXI_rdata(sys_mb_M_AXI_IC_RDATA),
        .S01_AXI_rlast(sys_mb_M_AXI_IC_RLAST),
        .S01_AXI_rready(sys_mb_M_AXI_IC_RREADY),
        .S01_AXI_rresp(sys_mb_M_AXI_IC_RRESP),
        .S01_AXI_rvalid(sys_mb_M_AXI_IC_RVALID),
        .S02_ACLK(sys_cpu_clk),
        .S02_ARESETN(sys_cpu_resetn),
        .S02_AXI_araddr(axi_vdma_0_M_AXI_MM2S_ARADDR),
        .S02_AXI_arburst(axi_vdma_0_M_AXI_MM2S_ARBURST),
        .S02_AXI_arcache(axi_vdma_0_M_AXI_MM2S_ARCACHE),
        .S02_AXI_arlen(axi_vdma_0_M_AXI_MM2S_ARLEN),
        .S02_AXI_arprot(axi_vdma_0_M_AXI_MM2S_ARPROT),
        .S02_AXI_arready(axi_vdma_0_M_AXI_MM2S_ARREADY),
        .S02_AXI_arsize(axi_vdma_0_M_AXI_MM2S_ARSIZE),
        .S02_AXI_arvalid(axi_vdma_0_M_AXI_MM2S_ARVALID),
        .S02_AXI_rdata(axi_vdma_0_M_AXI_MM2S_RDATA),
        .S02_AXI_rlast(axi_vdma_0_M_AXI_MM2S_RLAST),
        .S02_AXI_rready(axi_vdma_0_M_AXI_MM2S_RREADY),
        .S02_AXI_rresp(axi_vdma_0_M_AXI_MM2S_RRESP),
        .S02_AXI_rvalid(axi_vdma_0_M_AXI_MM2S_RVALID),
        .S03_ACLK(sys_cpu_clk),
        .S03_ARESETN(sys_cpu_resetn),
        .S03_AXI_araddr(axi_cpu_interconnect_M07_AXI_ARADDR),
        .S03_AXI_arburst(axi_cpu_interconnect_M07_AXI_ARBURST),
        .S03_AXI_arcache(axi_cpu_interconnect_M07_AXI_ARCACHE),
        .S03_AXI_arlen(axi_cpu_interconnect_M07_AXI_ARLEN),
        .S03_AXI_arlock(axi_cpu_interconnect_M07_AXI_ARLOCK),
        .S03_AXI_arprot(axi_cpu_interconnect_M07_AXI_ARPROT),
        .S03_AXI_arqos(axi_cpu_interconnect_M07_AXI_ARQOS),
        .S03_AXI_arready(axi_cpu_interconnect_M07_AXI_ARREADY),
        .S03_AXI_arregion(axi_cpu_interconnect_M07_AXI_ARREGION),
        .S03_AXI_arsize(axi_cpu_interconnect_M07_AXI_ARSIZE),
        .S03_AXI_arvalid(axi_cpu_interconnect_M07_AXI_ARVALID),
        .S03_AXI_awaddr(axi_cpu_interconnect_M07_AXI_AWADDR),
        .S03_AXI_awburst(axi_cpu_interconnect_M07_AXI_AWBURST),
        .S03_AXI_awcache(axi_cpu_interconnect_M07_AXI_AWCACHE),
        .S03_AXI_awlen(axi_cpu_interconnect_M07_AXI_AWLEN),
        .S03_AXI_awlock(axi_cpu_interconnect_M07_AXI_AWLOCK),
        .S03_AXI_awprot(axi_cpu_interconnect_M07_AXI_AWPROT),
        .S03_AXI_awqos(axi_cpu_interconnect_M07_AXI_AWQOS),
        .S03_AXI_awready(axi_cpu_interconnect_M07_AXI_AWREADY),
        .S03_AXI_awregion(axi_cpu_interconnect_M07_AXI_AWREGION),
        .S03_AXI_awsize(axi_cpu_interconnect_M07_AXI_AWSIZE),
        .S03_AXI_awvalid(axi_cpu_interconnect_M07_AXI_AWVALID),
        .S03_AXI_bready(axi_cpu_interconnect_M07_AXI_BREADY),
        .S03_AXI_bresp(axi_cpu_interconnect_M07_AXI_BRESP),
        .S03_AXI_bvalid(axi_cpu_interconnect_M07_AXI_BVALID),
        .S03_AXI_rdata(axi_cpu_interconnect_M07_AXI_RDATA),
        .S03_AXI_rlast(axi_cpu_interconnect_M07_AXI_RLAST),
        .S03_AXI_rready(axi_cpu_interconnect_M07_AXI_RREADY),
        .S03_AXI_rresp(axi_cpu_interconnect_M07_AXI_RRESP),
        .S03_AXI_rvalid(axi_cpu_interconnect_M07_AXI_RVALID),
        .S03_AXI_wdata(axi_cpu_interconnect_M07_AXI_WDATA),
        .S03_AXI_wlast(axi_cpu_interconnect_M07_AXI_WLAST),
        .S03_AXI_wready(axi_cpu_interconnect_M07_AXI_WREADY),
        .S03_AXI_wstrb(axi_cpu_interconnect_M07_AXI_WSTRB),
        .S03_AXI_wvalid(axi_cpu_interconnect_M07_AXI_WVALID));
  system_i_bak_axi_quad_spi_0_0 axi_quad_spi_0
       (.ext_spi_clk(axi_ethernet_clkgen_clk_out4),
        .gsr(xlconstant_2_dout),
        .gts(xlconstant_2_dout),
        .keyclearb(xlconstant_3_dout),
        .s_axi_aclk(sys_cpu_clk),
        .s_axi_araddr(axi_cpu_interconnect_M05_AXI_ARADDR[6:0]),
        .s_axi_aresetn(sys_cpu_resetn),
        .s_axi_arready(axi_cpu_interconnect_M05_AXI_ARREADY),
        .s_axi_arvalid(axi_cpu_interconnect_M05_AXI_ARVALID),
        .s_axi_awaddr(axi_cpu_interconnect_M05_AXI_AWADDR[6:0]),
        .s_axi_awready(axi_cpu_interconnect_M05_AXI_AWREADY),
        .s_axi_awvalid(axi_cpu_interconnect_M05_AXI_AWVALID),
        .s_axi_bready(axi_cpu_interconnect_M05_AXI_BREADY),
        .s_axi_bresp(axi_cpu_interconnect_M05_AXI_BRESP),
        .s_axi_bvalid(axi_cpu_interconnect_M05_AXI_BVALID),
        .s_axi_rdata(axi_cpu_interconnect_M05_AXI_RDATA),
        .s_axi_rready(axi_cpu_interconnect_M05_AXI_RREADY),
        .s_axi_rresp(axi_cpu_interconnect_M05_AXI_RRESP),
        .s_axi_rvalid(axi_cpu_interconnect_M05_AXI_RVALID),
        .s_axi_wdata(axi_cpu_interconnect_M05_AXI_WDATA),
        .s_axi_wready(axi_cpu_interconnect_M05_AXI_WREADY),
        .s_axi_wstrb(axi_cpu_interconnect_M05_AXI_WSTRB),
        .s_axi_wvalid(axi_cpu_interconnect_M05_AXI_WVALID),
        .usrcclkts(xlconstant_2_dout),
        .usrdoneo(xlconstant_3_dout),
        .usrdonets(xlconstant_3_dout));
  system_i_bak_axi_timer_0 axi_timer
       (.capturetrig0(1'b0),
        .capturetrig1(1'b0),
        .freeze(1'b0),
        .interrupt(axi_timer_interrupt),
        .s_axi_aclk(sys_cpu_clk),
        .s_axi_araddr(axi_cpu_interconnect_M03_AXI_ARADDR[4:0]),
        .s_axi_aresetn(sys_cpu_resetn),
        .s_axi_arready(axi_cpu_interconnect_M03_AXI_ARREADY),
        .s_axi_arvalid(axi_cpu_interconnect_M03_AXI_ARVALID),
        .s_axi_awaddr(axi_cpu_interconnect_M03_AXI_AWADDR[4:0]),
        .s_axi_awready(axi_cpu_interconnect_M03_AXI_AWREADY),
        .s_axi_awvalid(axi_cpu_interconnect_M03_AXI_AWVALID),
        .s_axi_bready(axi_cpu_interconnect_M03_AXI_BREADY),
        .s_axi_bresp(axi_cpu_interconnect_M03_AXI_BRESP),
        .s_axi_bvalid(axi_cpu_interconnect_M03_AXI_BVALID),
        .s_axi_rdata(axi_cpu_interconnect_M03_AXI_RDATA),
        .s_axi_rready(axi_cpu_interconnect_M03_AXI_RREADY),
        .s_axi_rresp(axi_cpu_interconnect_M03_AXI_RRESP),
        .s_axi_rvalid(axi_cpu_interconnect_M03_AXI_RVALID),
        .s_axi_wdata(axi_cpu_interconnect_M03_AXI_WDATA),
        .s_axi_wready(axi_cpu_interconnect_M03_AXI_WREADY),
        .s_axi_wstrb(axi_cpu_interconnect_M03_AXI_WSTRB),
        .s_axi_wvalid(axi_cpu_interconnect_M03_AXI_WVALID));
  system_i_bak_axi_uartlite_0_0 axi_uartlite_0
       (.interrupt(axi_uartlite_0_interrupt),
        .rx(rx_1),
        .s_axi_aclk(sys_cpu_clk),
        .s_axi_araddr(axi_cpu_interconnect_M06_AXI_ARADDR[3:0]),
        .s_axi_aresetn(sys_cpu_resetn),
        .s_axi_arready(axi_cpu_interconnect_M06_AXI_ARREADY),
        .s_axi_arvalid(axi_cpu_interconnect_M06_AXI_ARVALID),
        .s_axi_awaddr(axi_cpu_interconnect_M06_AXI_AWADDR[3:0]),
        .s_axi_awready(axi_cpu_interconnect_M06_AXI_AWREADY),
        .s_axi_awvalid(axi_cpu_interconnect_M06_AXI_AWVALID),
        .s_axi_bready(axi_cpu_interconnect_M06_AXI_BREADY),
        .s_axi_bresp(axi_cpu_interconnect_M06_AXI_BRESP),
        .s_axi_bvalid(axi_cpu_interconnect_M06_AXI_BVALID),
        .s_axi_rdata(axi_cpu_interconnect_M06_AXI_RDATA),
        .s_axi_rready(axi_cpu_interconnect_M06_AXI_RREADY),
        .s_axi_rresp(axi_cpu_interconnect_M06_AXI_RRESP),
        .s_axi_rvalid(axi_cpu_interconnect_M06_AXI_RVALID),
        .s_axi_wdata(axi_cpu_interconnect_M06_AXI_WDATA),
        .s_axi_wready(axi_cpu_interconnect_M06_AXI_WREADY),
        .s_axi_wstrb(axi_cpu_interconnect_M06_AXI_WSTRB),
        .s_axi_wvalid(axi_cpu_interconnect_M06_AXI_WVALID),
        .tx(axi_uartlite_0_tx));
  system_i_bak_axi_vdma_0_0 axi_vdma_0
       (.axi_resetn(sys_cpu_resetn),
        .m_axi_mm2s_aclk(sys_cpu_clk),
        .m_axi_mm2s_araddr(axi_vdma_0_M_AXI_MM2S_ARADDR),
        .m_axi_mm2s_arburst(axi_vdma_0_M_AXI_MM2S_ARBURST),
        .m_axi_mm2s_arcache(axi_vdma_0_M_AXI_MM2S_ARCACHE),
        .m_axi_mm2s_arlen(axi_vdma_0_M_AXI_MM2S_ARLEN),
        .m_axi_mm2s_arprot(axi_vdma_0_M_AXI_MM2S_ARPROT),
        .m_axi_mm2s_arready(axi_vdma_0_M_AXI_MM2S_ARREADY),
        .m_axi_mm2s_arsize(axi_vdma_0_M_AXI_MM2S_ARSIZE),
        .m_axi_mm2s_arvalid(axi_vdma_0_M_AXI_MM2S_ARVALID),
        .m_axi_mm2s_rdata(axi_vdma_0_M_AXI_MM2S_RDATA),
        .m_axi_mm2s_rlast(axi_vdma_0_M_AXI_MM2S_RLAST),
        .m_axi_mm2s_rready(axi_vdma_0_M_AXI_MM2S_RREADY),
        .m_axi_mm2s_rresp(axi_vdma_0_M_AXI_MM2S_RRESP),
        .m_axi_mm2s_rvalid(axi_vdma_0_M_AXI_MM2S_RVALID),
        .m_axis_mm2s_aclk(sys_cpu_clk),
        .m_axis_mm2s_tdata(axi_vdma_0_m_axis_mm2s_tdata),
        .m_axis_mm2s_tready(axi_hdmi_tx_0_vdma_ready),
        .m_axis_mm2s_tvalid(axi_vdma_0_m_axis_mm2s_tvalid),
        .mm2s_frame_ptr_in({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .mm2s_fsync(axi_hdmi_tx_0_vdma_fs),
        .mm2s_introut(axi_vdma_0_mm2s_introut),
        .s_axi_lite_aclk(sys_cpu_clk),
        .s_axi_lite_araddr(axi_cpu_interconnect_M10_AXI_ARADDR[8:0]),
        .s_axi_lite_arready(axi_cpu_interconnect_M10_AXI_ARREADY),
        .s_axi_lite_arvalid(axi_cpu_interconnect_M10_AXI_ARVALID),
        .s_axi_lite_awaddr(axi_cpu_interconnect_M10_AXI_AWADDR[8:0]),
        .s_axi_lite_awready(axi_cpu_interconnect_M10_AXI_AWREADY),
        .s_axi_lite_awvalid(axi_cpu_interconnect_M10_AXI_AWVALID),
        .s_axi_lite_bready(axi_cpu_interconnect_M10_AXI_BREADY),
        .s_axi_lite_bresp(axi_cpu_interconnect_M10_AXI_BRESP),
        .s_axi_lite_bvalid(axi_cpu_interconnect_M10_AXI_BVALID),
        .s_axi_lite_rdata(axi_cpu_interconnect_M10_AXI_RDATA),
        .s_axi_lite_rready(axi_cpu_interconnect_M10_AXI_RREADY),
        .s_axi_lite_rresp(axi_cpu_interconnect_M10_AXI_RRESP),
        .s_axi_lite_rvalid(axi_cpu_interconnect_M10_AXI_RVALID),
        .s_axi_lite_wdata(axi_cpu_interconnect_M10_AXI_WDATA),
        .s_axi_lite_wready(axi_cpu_interconnect_M10_AXI_WREADY),
        .s_axi_lite_wvalid(axi_cpu_interconnect_M10_AXI_WVALID));
  system_i_bak_axis_data_fifo_0_0 axis_data_fifo_0
       (.axis_data_count(axis_data_fifo_0_axis_data_count),
        .axis_rd_data_count(axis_data_fifo_0_axis_rd_data_count),
        .m_axis_aclk(sys_cpu_clk),
        .m_axis_aresetn(sys_cpu_resetn),
        .m_axis_tdata(axis_data_fifo_0_m_axis_tdata),
        .m_axis_tready(BeamformerIP_0_fifo_axis_tready),
        .m_axis_tvalid(axis_data_fifo_0_m_axis_tvalid),
        .s_axis_aclk(aurora_8b10b_0_user_clk_out),
        .s_axis_aresetn(util_vector_logic_0_Res),
        .s_axis_tdata(aurora_8b10b_0_USER_DATA_M_AXI_RX_TDATA),
        .s_axis_tkeep(aurora_8b10b_0_USER_DATA_M_AXI_RX_TKEEP),
        .s_axis_tlast(aurora_8b10b_0_USER_DATA_M_AXI_RX_TLAST),
        .s_axis_tvalid(aurora_8b10b_0_USER_DATA_M_AXI_RX_TVALID));
  system_i_bak_ila_0_0 ila_0
       (.clk(sys_cpu_clk),
        .probe0(axis_data_fifo_0_m_axis_tdata),
        .probe1(axis_data_fifo_0_m_axis_tvalid),
        .probe2(BeamformerIP_0_fifo_axis_tready),
        .trig_in(1'b0));
  microblaze_0_local_memory_imp_D4M65J microblaze_0_local_memory
       (.DLMB_abus(sys_mb_DLMB_ABUS),
        .DLMB_addrstrobe(sys_mb_DLMB_ADDRSTROBE),
        .DLMB_be(sys_mb_DLMB_BE),
        .DLMB_ce(sys_mb_DLMB_CE),
        .DLMB_readdbus(sys_mb_DLMB_READDBUS),
        .DLMB_readstrobe(sys_mb_DLMB_READSTROBE),
        .DLMB_ready(sys_mb_DLMB_READY),
        .DLMB_ue(sys_mb_DLMB_UE),
        .DLMB_wait(sys_mb_DLMB_WAIT),
        .DLMB_writedbus(sys_mb_DLMB_WRITEDBUS),
        .DLMB_writestrobe(sys_mb_DLMB_WRITESTROBE),
        .ILMB_abus(sys_mb_ILMB_ABUS),
        .ILMB_addrstrobe(sys_mb_ILMB_ADDRSTROBE),
        .ILMB_ce(sys_mb_ILMB_CE),
        .ILMB_readdbus(sys_mb_ILMB_READDBUS),
        .ILMB_readstrobe(sys_mb_ILMB_READSTROBE),
        .ILMB_ready(sys_mb_ILMB_READY),
        .ILMB_ue(sys_mb_ILMB_UE),
        .ILMB_wait(sys_mb_ILMB_WAIT),
        .LMB_Clk(sys_cpu_clk),
        .SYS_Rst(sys_rstgen_mb_reset));
  system_i_bak_sim_data_probe_0_0 sim_data_probe_0
       (.axis_aclk(aurora_8b10b_1_user_clk_out),
        .axis_tdata(sim_data_probe_0_axis_tdata),
        .axis_tready(aurora_8b10b_1_s_axi_tx_tready),
        .axis_tvalid(sim_data_probe_0_axis_tvalid),
        .reset(util_vector_logic_0_Res));
  system_i_bak_sys_concat_intc_0 sys_concat_intc
       (.In0(axi_timer_interrupt),
        .In1(axi_ethernet_0_interrupt),
        .In10(axi_uartlite_0_interrupt),
        .In11(axi_iic_0_iic2intc_irpt),
        .In12(axi_vdma_0_mm2s_introut),
        .In2(axi_ethernet_dma_mm2s_introut),
        .In3(axi_ethernet_dma_s2mm_introut),
        .In4(mb_intr_05_1),
        .In5(mb_intr_06_1),
        .In6(mb_intr_12_1),
        .In7(mb_intr_13_1),
        .In8(mb_intr_14_1),
        .In9(mb_intr_15_1),
        .dout(sys_concat_intc_dout));
  (* BMM_INFO_PROCESSOR = "microblaze-le > system_i_bak microblaze_0_local_memory/dlmb_bram_if_cntlr" *) 
  (* KEEP_HIERARCHY = "yes" *) 
  system_i_bak_sys_mb_0 sys_mb
       (.Byte_Enable(sys_mb_DLMB_BE),
        .Clk(sys_cpu_clk),
        .DCE(sys_mb_DLMB_CE),
        .DReady(sys_mb_DLMB_READY),
        .DUE(sys_mb_DLMB_UE),
        .DWait(sys_mb_DLMB_WAIT),
        .D_AS(sys_mb_DLMB_ADDRSTROBE),
        .Data_Addr(sys_mb_DLMB_ABUS),
        .Data_Read(sys_mb_DLMB_READDBUS),
        .Data_Write(sys_mb_DLMB_WRITEDBUS),
        .Dbg_Capture(sys_mb_debug_MBDEBUG_0_CAPTURE),
        .Dbg_Clk(sys_mb_debug_MBDEBUG_0_CLK),
        .Dbg_Reg_En(sys_mb_debug_MBDEBUG_0_REG_EN),
        .Dbg_Shift(sys_mb_debug_MBDEBUG_0_SHIFT),
        .Dbg_TDI(sys_mb_debug_MBDEBUG_0_TDI),
        .Dbg_TDO(sys_mb_debug_MBDEBUG_0_TDO),
        .Dbg_Update(sys_mb_debug_MBDEBUG_0_UPDATE),
        .Debug_Rst(sys_mb_debug_MBDEBUG_0_RST),
        .ICE(sys_mb_ILMB_CE),
        .IFetch(sys_mb_ILMB_READSTROBE),
        .IReady(sys_mb_ILMB_READY),
        .IUE(sys_mb_ILMB_UE),
        .IWAIT(sys_mb_ILMB_WAIT),
        .I_AS(sys_mb_ILMB_ADDRSTROBE),
        .Instr(sys_mb_ILMB_READDBUS),
        .Instr_Addr(sys_mb_ILMB_ABUS),
        .Interrupt(axi_intc_interrupt_INTERRUPT),
        .Interrupt_Address({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .M_AXI_DC_ARADDR(sys_mb_M_AXI_DC_ARADDR),
        .M_AXI_DC_ARBURST(sys_mb_M_AXI_DC_ARBURST),
        .M_AXI_DC_ARCACHE(sys_mb_M_AXI_DC_ARCACHE),
        .M_AXI_DC_ARLEN(sys_mb_M_AXI_DC_ARLEN),
        .M_AXI_DC_ARLOCK(sys_mb_M_AXI_DC_ARLOCK),
        .M_AXI_DC_ARPROT(sys_mb_M_AXI_DC_ARPROT),
        .M_AXI_DC_ARQOS(sys_mb_M_AXI_DC_ARQOS),
        .M_AXI_DC_ARREADY(sys_mb_M_AXI_DC_ARREADY),
        .M_AXI_DC_ARSIZE(sys_mb_M_AXI_DC_ARSIZE),
        .M_AXI_DC_ARVALID(sys_mb_M_AXI_DC_ARVALID),
        .M_AXI_DC_AWADDR(sys_mb_M_AXI_DC_AWADDR),
        .M_AXI_DC_AWBURST(sys_mb_M_AXI_DC_AWBURST),
        .M_AXI_DC_AWCACHE(sys_mb_M_AXI_DC_AWCACHE),
        .M_AXI_DC_AWLEN(sys_mb_M_AXI_DC_AWLEN),
        .M_AXI_DC_AWLOCK(sys_mb_M_AXI_DC_AWLOCK),
        .M_AXI_DC_AWPROT(sys_mb_M_AXI_DC_AWPROT),
        .M_AXI_DC_AWQOS(sys_mb_M_AXI_DC_AWQOS),
        .M_AXI_DC_AWREADY(sys_mb_M_AXI_DC_AWREADY),
        .M_AXI_DC_AWSIZE(sys_mb_M_AXI_DC_AWSIZE),
        .M_AXI_DC_AWVALID(sys_mb_M_AXI_DC_AWVALID),
        .M_AXI_DC_BID(1'b0),
        .M_AXI_DC_BREADY(sys_mb_M_AXI_DC_BREADY),
        .M_AXI_DC_BRESP(sys_mb_M_AXI_DC_BRESP),
        .M_AXI_DC_BVALID(sys_mb_M_AXI_DC_BVALID),
        .M_AXI_DC_RDATA(sys_mb_M_AXI_DC_RDATA),
        .M_AXI_DC_RID(1'b0),
        .M_AXI_DC_RLAST(sys_mb_M_AXI_DC_RLAST),
        .M_AXI_DC_RREADY(sys_mb_M_AXI_DC_RREADY),
        .M_AXI_DC_RRESP(sys_mb_M_AXI_DC_RRESP),
        .M_AXI_DC_RVALID(sys_mb_M_AXI_DC_RVALID),
        .M_AXI_DC_WDATA(sys_mb_M_AXI_DC_WDATA),
        .M_AXI_DC_WLAST(sys_mb_M_AXI_DC_WLAST),
        .M_AXI_DC_WREADY(sys_mb_M_AXI_DC_WREADY),
        .M_AXI_DC_WSTRB(sys_mb_M_AXI_DC_WSTRB),
        .M_AXI_DC_WVALID(sys_mb_M_AXI_DC_WVALID),
        .M_AXI_DP_ARADDR(S00_AXI_1_ARADDR),
        .M_AXI_DP_ARPROT(S00_AXI_1_ARPROT),
        .M_AXI_DP_ARREADY(S00_AXI_1_ARREADY),
        .M_AXI_DP_ARVALID(S00_AXI_1_ARVALID),
        .M_AXI_DP_AWADDR(S00_AXI_1_AWADDR),
        .M_AXI_DP_AWPROT(S00_AXI_1_AWPROT),
        .M_AXI_DP_AWREADY(S00_AXI_1_AWREADY),
        .M_AXI_DP_AWVALID(S00_AXI_1_AWVALID),
        .M_AXI_DP_BREADY(S00_AXI_1_BREADY),
        .M_AXI_DP_BRESP(S00_AXI_1_BRESP),
        .M_AXI_DP_BVALID(S00_AXI_1_BVALID),
        .M_AXI_DP_RDATA(S00_AXI_1_RDATA),
        .M_AXI_DP_RREADY(S00_AXI_1_RREADY),
        .M_AXI_DP_RRESP(S00_AXI_1_RRESP),
        .M_AXI_DP_RVALID(S00_AXI_1_RVALID),
        .M_AXI_DP_WDATA(S00_AXI_1_WDATA),
        .M_AXI_DP_WREADY(S00_AXI_1_WREADY),
        .M_AXI_DP_WSTRB(S00_AXI_1_WSTRB),
        .M_AXI_DP_WVALID(S00_AXI_1_WVALID),
        .M_AXI_IC_ARADDR(sys_mb_M_AXI_IC_ARADDR),
        .M_AXI_IC_ARBURST(sys_mb_M_AXI_IC_ARBURST),
        .M_AXI_IC_ARCACHE(sys_mb_M_AXI_IC_ARCACHE),
        .M_AXI_IC_ARLEN(sys_mb_M_AXI_IC_ARLEN),
        .M_AXI_IC_ARLOCK(sys_mb_M_AXI_IC_ARLOCK),
        .M_AXI_IC_ARPROT(sys_mb_M_AXI_IC_ARPROT),
        .M_AXI_IC_ARQOS(sys_mb_M_AXI_IC_ARQOS),
        .M_AXI_IC_ARREADY(sys_mb_M_AXI_IC_ARREADY),
        .M_AXI_IC_ARSIZE(sys_mb_M_AXI_IC_ARSIZE),
        .M_AXI_IC_ARVALID(sys_mb_M_AXI_IC_ARVALID),
        .M_AXI_IC_AWREADY(1'b0),
        .M_AXI_IC_BID(1'b0),
        .M_AXI_IC_BRESP({1'b0,1'b0}),
        .M_AXI_IC_BVALID(1'b0),
        .M_AXI_IC_RDATA(sys_mb_M_AXI_IC_RDATA),
        .M_AXI_IC_RID(1'b0),
        .M_AXI_IC_RLAST(sys_mb_M_AXI_IC_RLAST),
        .M_AXI_IC_RREADY(sys_mb_M_AXI_IC_RREADY),
        .M_AXI_IC_RRESP(sys_mb_M_AXI_IC_RRESP),
        .M_AXI_IC_RVALID(sys_mb_M_AXI_IC_RVALID),
        .M_AXI_IC_WREADY(1'b0),
        .M_AXI_IP_ARADDR(sys_mb_M_AXI_IP_ARADDR),
        .M_AXI_IP_ARPROT(sys_mb_M_AXI_IP_ARPROT),
        .M_AXI_IP_ARREADY(sys_mb_M_AXI_IP_ARREADY),
        .M_AXI_IP_ARVALID(sys_mb_M_AXI_IP_ARVALID),
        .M_AXI_IP_AWREADY(1'b0),
        .M_AXI_IP_BRESP({1'b0,1'b0}),
        .M_AXI_IP_BVALID(1'b0),
        .M_AXI_IP_RDATA(sys_mb_M_AXI_IP_RDATA),
        .M_AXI_IP_RREADY(sys_mb_M_AXI_IP_RREADY),
        .M_AXI_IP_RRESP(sys_mb_M_AXI_IP_RRESP),
        .M_AXI_IP_RVALID(sys_mb_M_AXI_IP_RVALID),
        .M_AXI_IP_WREADY(1'b0),
        .Read_Strobe(sys_mb_DLMB_READSTROBE),
        .Reset(sys_rstgen_mb_reset),
        .Write_Strobe(sys_mb_DLMB_WRITESTROBE));
  system_i_bak_sys_mb_debug_0 sys_mb_debug
       (.Dbg_Capture_0(sys_mb_debug_MBDEBUG_0_CAPTURE),
        .Dbg_Clk_0(sys_mb_debug_MBDEBUG_0_CLK),
        .Dbg_Reg_En_0(sys_mb_debug_MBDEBUG_0_REG_EN),
        .Dbg_Rst_0(sys_mb_debug_MBDEBUG_0_RST),
        .Dbg_Shift_0(sys_mb_debug_MBDEBUG_0_SHIFT),
        .Dbg_TDI_0(sys_mb_debug_MBDEBUG_0_TDI),
        .Dbg_TDO_0(sys_mb_debug_MBDEBUG_0_TDO),
        .Dbg_Update_0(sys_mb_debug_MBDEBUG_0_UPDATE),
        .Debug_SYS_Rst(sys_mb_debug_Debug_SYS_Rst),
        .S_AXI_ACLK(sys_cpu_clk),
        .S_AXI_ARADDR(axi_cpu_interconnect_M00_AXI_ARADDR),
        .S_AXI_ARESETN(sys_cpu_resetn),
        .S_AXI_ARREADY(axi_cpu_interconnect_M00_AXI_ARREADY),
        .S_AXI_ARVALID(axi_cpu_interconnect_M00_AXI_ARVALID),
        .S_AXI_AWADDR(axi_cpu_interconnect_M00_AXI_AWADDR),
        .S_AXI_AWREADY(axi_cpu_interconnect_M00_AXI_AWREADY),
        .S_AXI_AWVALID(axi_cpu_interconnect_M00_AXI_AWVALID),
        .S_AXI_BREADY(axi_cpu_interconnect_M00_AXI_BREADY),
        .S_AXI_BRESP(axi_cpu_interconnect_M00_AXI_BRESP),
        .S_AXI_BVALID(axi_cpu_interconnect_M00_AXI_BVALID),
        .S_AXI_RDATA(axi_cpu_interconnect_M00_AXI_RDATA),
        .S_AXI_RREADY(axi_cpu_interconnect_M00_AXI_RREADY),
        .S_AXI_RRESP(axi_cpu_interconnect_M00_AXI_RRESP),
        .S_AXI_RVALID(axi_cpu_interconnect_M00_AXI_RVALID),
        .S_AXI_WDATA(axi_cpu_interconnect_M00_AXI_WDATA),
        .S_AXI_WREADY(axi_cpu_interconnect_M00_AXI_WREADY),
        .S_AXI_WSTRB(axi_cpu_interconnect_M00_AXI_WSTRB),
        .S_AXI_WVALID(axi_cpu_interconnect_M00_AXI_WVALID));
  system_i_bak_sys_rstgen_0 sys_rstgen
       (.aux_reset_in(1'b1),
        .dcm_locked(1'b1),
        .ext_reset_in(axi_ddr_cntrl_c0_ddr4_ui_clk_sync_rst),
        .mb_debug_sys_rst(sys_mb_debug_Debug_SYS_Rst),
        .mb_reset(sys_rstgen_mb_reset),
        .peripheral_aresetn(sys_cpu_resetn),
        .peripheral_reset(sys_cpu_reset),
        .slowest_sync_clk(sys_cpu_clk));
  system_i_bak_util_vector_logic_0_0 util_vector_logic_0
       (.Op1(aurora_8b10b_0_sys_reset_out),
        .Res(util_vector_logic_0_Res));
  system_i_bak_xlconstant_0_0 xlconstant_0
       (.dout(xlconstant_0_dout));
  system_i_bak_xlconstant_0_1 xlconstant_1
       (.dout(xlconstant_1_dout));
  system_i_bak_xlconstant_2_0 xlconstant_2
       (.dout(xlconstant_2_dout));
  system_i_bak_xlconstant_3_0 xlconstant_3
       (.dout(xlconstant_3_dout));
  system_i_bak_xlconstant_4_0 xlconstant_4
       (.dout(xlconstant_4_dout));
  system_i_bak_xlconstant_5_0 xlconstant_5
       (.dout(xlconstant_5_dout));
  system_i_bak_xlconstant_6_0 xlconstant_6
       (.dout(xlconstant_6_dout));
  system_i_bak_xlconstant_7_0 xlconstant_7
       (.dout(xlconstant_7_dout));
  system_i_bak_xlconstant_8_0 xlconstant_8
       (.dout(xlconstant_8_dout));
endmodule

module system_i_bak_axi_cpu_interconnect_0
   (ACLK,
    ARESETN,
    M00_ACLK,
    M00_ARESETN,
    M00_AXI_araddr,
    M00_AXI_arready,
    M00_AXI_arvalid,
    M00_AXI_awaddr,
    M00_AXI_awready,
    M00_AXI_awvalid,
    M00_AXI_bready,
    M00_AXI_bresp,
    M00_AXI_bvalid,
    M00_AXI_rdata,
    M00_AXI_rready,
    M00_AXI_rresp,
    M00_AXI_rvalid,
    M00_AXI_wdata,
    M00_AXI_wready,
    M00_AXI_wstrb,
    M00_AXI_wvalid,
    M01_ACLK,
    M01_ARESETN,
    M01_AXI_araddr,
    M01_AXI_arburst,
    M01_AXI_arcache,
    M01_AXI_arlen,
    M01_AXI_arlock,
    M01_AXI_arprot,
    M01_AXI_arqos,
    M01_AXI_arready,
    M01_AXI_arregion,
    M01_AXI_arsize,
    M01_AXI_arvalid,
    M01_AXI_awaddr,
    M01_AXI_awburst,
    M01_AXI_awcache,
    M01_AXI_awlen,
    M01_AXI_awlock,
    M01_AXI_awprot,
    M01_AXI_awqos,
    M01_AXI_awready,
    M01_AXI_awregion,
    M01_AXI_awsize,
    M01_AXI_awvalid,
    M01_AXI_bready,
    M01_AXI_bresp,
    M01_AXI_bvalid,
    M01_AXI_rdata,
    M01_AXI_rlast,
    M01_AXI_rready,
    M01_AXI_rresp,
    M01_AXI_rvalid,
    M01_AXI_wdata,
    M01_AXI_wlast,
    M01_AXI_wready,
    M01_AXI_wstrb,
    M01_AXI_wvalid,
    M02_ACLK,
    M02_ARESETN,
    M02_AXI_araddr,
    M02_AXI_arready,
    M02_AXI_arvalid,
    M02_AXI_awaddr,
    M02_AXI_awready,
    M02_AXI_awvalid,
    M02_AXI_bready,
    M02_AXI_bresp,
    M02_AXI_bvalid,
    M02_AXI_rdata,
    M02_AXI_rready,
    M02_AXI_rresp,
    M02_AXI_rvalid,
    M02_AXI_wdata,
    M02_AXI_wready,
    M02_AXI_wvalid,
    M03_ACLK,
    M03_ARESETN,
    M03_AXI_araddr,
    M03_AXI_arready,
    M03_AXI_arvalid,
    M03_AXI_awaddr,
    M03_AXI_awready,
    M03_AXI_awvalid,
    M03_AXI_bready,
    M03_AXI_bresp,
    M03_AXI_bvalid,
    M03_AXI_rdata,
    M03_AXI_rready,
    M03_AXI_rresp,
    M03_AXI_rvalid,
    M03_AXI_wdata,
    M03_AXI_wready,
    M03_AXI_wstrb,
    M03_AXI_wvalid,
    M04_ACLK,
    M04_ARESETN,
    M04_AXI_araddr,
    M04_AXI_arready,
    M04_AXI_arvalid,
    M04_AXI_awaddr,
    M04_AXI_awready,
    M04_AXI_awvalid,
    M04_AXI_bready,
    M04_AXI_bresp,
    M04_AXI_bvalid,
    M04_AXI_rdata,
    M04_AXI_rready,
    M04_AXI_rresp,
    M04_AXI_rvalid,
    M04_AXI_wdata,
    M04_AXI_wready,
    M04_AXI_wstrb,
    M04_AXI_wvalid,
    M05_ACLK,
    M05_ARESETN,
    M05_AXI_araddr,
    M05_AXI_arready,
    M05_AXI_arvalid,
    M05_AXI_awaddr,
    M05_AXI_awready,
    M05_AXI_awvalid,
    M05_AXI_bready,
    M05_AXI_bresp,
    M05_AXI_bvalid,
    M05_AXI_rdata,
    M05_AXI_rready,
    M05_AXI_rresp,
    M05_AXI_rvalid,
    M05_AXI_wdata,
    M05_AXI_wready,
    M05_AXI_wstrb,
    M05_AXI_wvalid,
    M06_ACLK,
    M06_ARESETN,
    M06_AXI_araddr,
    M06_AXI_arready,
    M06_AXI_arvalid,
    M06_AXI_awaddr,
    M06_AXI_awready,
    M06_AXI_awvalid,
    M06_AXI_bready,
    M06_AXI_bresp,
    M06_AXI_bvalid,
    M06_AXI_rdata,
    M06_AXI_rready,
    M06_AXI_rresp,
    M06_AXI_rvalid,
    M06_AXI_wdata,
    M06_AXI_wready,
    M06_AXI_wstrb,
    M06_AXI_wvalid,
    M07_ACLK,
    M07_ARESETN,
    M07_AXI_araddr,
    M07_AXI_arburst,
    M07_AXI_arcache,
    M07_AXI_arlen,
    M07_AXI_arlock,
    M07_AXI_arprot,
    M07_AXI_arqos,
    M07_AXI_arready,
    M07_AXI_arregion,
    M07_AXI_arsize,
    M07_AXI_arvalid,
    M07_AXI_awaddr,
    M07_AXI_awburst,
    M07_AXI_awcache,
    M07_AXI_awlen,
    M07_AXI_awlock,
    M07_AXI_awprot,
    M07_AXI_awqos,
    M07_AXI_awready,
    M07_AXI_awregion,
    M07_AXI_awsize,
    M07_AXI_awvalid,
    M07_AXI_bready,
    M07_AXI_bresp,
    M07_AXI_bvalid,
    M07_AXI_rdata,
    M07_AXI_rlast,
    M07_AXI_rready,
    M07_AXI_rresp,
    M07_AXI_rvalid,
    M07_AXI_wdata,
    M07_AXI_wlast,
    M07_AXI_wready,
    M07_AXI_wstrb,
    M07_AXI_wvalid,
    M08_ACLK,
    M08_ARESETN,
    M08_AXI_araddr,
    M08_AXI_arready,
    M08_AXI_arvalid,
    M08_AXI_awaddr,
    M08_AXI_awready,
    M08_AXI_awvalid,
    M08_AXI_bready,
    M08_AXI_bresp,
    M08_AXI_bvalid,
    M08_AXI_rdata,
    M08_AXI_rready,
    M08_AXI_rresp,
    M08_AXI_rvalid,
    M08_AXI_wdata,
    M08_AXI_wready,
    M08_AXI_wstrb,
    M08_AXI_wvalid,
    M09_ACLK,
    M09_ARESETN,
    M09_AXI_araddr,
    M09_AXI_arready,
    M09_AXI_arvalid,
    M09_AXI_awaddr,
    M09_AXI_awready,
    M09_AXI_awvalid,
    M09_AXI_bready,
    M09_AXI_bresp,
    M09_AXI_bvalid,
    M09_AXI_rdata,
    M09_AXI_rready,
    M09_AXI_rresp,
    M09_AXI_rvalid,
    M09_AXI_wdata,
    M09_AXI_wready,
    M09_AXI_wstrb,
    M09_AXI_wvalid,
    M10_ACLK,
    M10_ARESETN,
    M10_AXI_araddr,
    M10_AXI_arready,
    M10_AXI_arvalid,
    M10_AXI_awaddr,
    M10_AXI_awready,
    M10_AXI_awvalid,
    M10_AXI_bready,
    M10_AXI_bresp,
    M10_AXI_bvalid,
    M10_AXI_rdata,
    M10_AXI_rready,
    M10_AXI_rresp,
    M10_AXI_rvalid,
    M10_AXI_wdata,
    M10_AXI_wready,
    M10_AXI_wvalid,
    M11_ACLK,
    M11_ARESETN,
    M11_AXI_araddr,
    M11_AXI_arprot,
    M11_AXI_arready,
    M11_AXI_arvalid,
    M11_AXI_awaddr,
    M11_AXI_awprot,
    M11_AXI_awready,
    M11_AXI_awvalid,
    M11_AXI_bready,
    M11_AXI_bresp,
    M11_AXI_bvalid,
    M11_AXI_rdata,
    M11_AXI_rready,
    M11_AXI_rresp,
    M11_AXI_rvalid,
    M11_AXI_wdata,
    M11_AXI_wready,
    M11_AXI_wstrb,
    M11_AXI_wvalid,
    M12_ACLK,
    M12_ARESETN,
    M12_AXI_araddr,
    M12_AXI_arready,
    M12_AXI_arvalid,
    M12_AXI_awaddr,
    M12_AXI_awready,
    M12_AXI_awvalid,
    M12_AXI_bready,
    M12_AXI_bresp,
    M12_AXI_bvalid,
    M12_AXI_rdata,
    M12_AXI_rready,
    M12_AXI_rresp,
    M12_AXI_rvalid,
    M12_AXI_wdata,
    M12_AXI_wready,
    M12_AXI_wstrb,
    M12_AXI_wvalid,
    M13_ACLK,
    M13_ARESETN,
    M13_AXI_araddr,
    M13_AXI_arprot,
    M13_AXI_arready,
    M13_AXI_arvalid,
    M13_AXI_awaddr,
    M13_AXI_awprot,
    M13_AXI_awready,
    M13_AXI_awvalid,
    M13_AXI_bready,
    M13_AXI_bresp,
    M13_AXI_bvalid,
    M13_AXI_rdata,
    M13_AXI_rready,
    M13_AXI_rresp,
    M13_AXI_rvalid,
    M13_AXI_wdata,
    M13_AXI_wready,
    M13_AXI_wstrb,
    M13_AXI_wvalid,
    M14_ACLK,
    M14_ARESETN,
    M14_AXI_araddr,
    M14_AXI_arburst,
    M14_AXI_arcache,
    M14_AXI_arlen,
    M14_AXI_arlock,
    M14_AXI_arprot,
    M14_AXI_arqos,
    M14_AXI_arready,
    M14_AXI_arregion,
    M14_AXI_arsize,
    M14_AXI_arvalid,
    M14_AXI_awaddr,
    M14_AXI_awburst,
    M14_AXI_awcache,
    M14_AXI_awlen,
    M14_AXI_awlock,
    M14_AXI_awprot,
    M14_AXI_awqos,
    M14_AXI_awready,
    M14_AXI_awregion,
    M14_AXI_awsize,
    M14_AXI_awvalid,
    M14_AXI_bready,
    M14_AXI_bresp,
    M14_AXI_bvalid,
    M14_AXI_rdata,
    M14_AXI_rlast,
    M14_AXI_rready,
    M14_AXI_rresp,
    M14_AXI_rvalid,
    M14_AXI_wdata,
    M14_AXI_wlast,
    M14_AXI_wready,
    M14_AXI_wstrb,
    M14_AXI_wvalid,
    S00_ACLK,
    S00_ARESETN,
    S00_AXI_araddr,
    S00_AXI_arprot,
    S00_AXI_arready,
    S00_AXI_arvalid,
    S00_AXI_awaddr,
    S00_AXI_awprot,
    S00_AXI_awready,
    S00_AXI_awvalid,
    S00_AXI_bready,
    S00_AXI_bresp,
    S00_AXI_bvalid,
    S00_AXI_rdata,
    S00_AXI_rready,
    S00_AXI_rresp,
    S00_AXI_rvalid,
    S00_AXI_wdata,
    S00_AXI_wready,
    S00_AXI_wstrb,
    S00_AXI_wvalid,
    S01_ACLK,
    S01_ARESETN,
    S01_AXI_araddr,
    S01_AXI_arburst,
    S01_AXI_arcache,
    S01_AXI_arlen,
    S01_AXI_arprot,
    S01_AXI_arready,
    S01_AXI_arsize,
    S01_AXI_arvalid,
    S01_AXI_awaddr,
    S01_AXI_awburst,
    S01_AXI_awcache,
    S01_AXI_awlen,
    S01_AXI_awprot,
    S01_AXI_awready,
    S01_AXI_awsize,
    S01_AXI_awvalid,
    S01_AXI_bready,
    S01_AXI_bresp,
    S01_AXI_bvalid,
    S01_AXI_rdata,
    S01_AXI_rlast,
    S01_AXI_rready,
    S01_AXI_rresp,
    S01_AXI_rvalid,
    S01_AXI_wdata,
    S01_AXI_wlast,
    S01_AXI_wready,
    S01_AXI_wstrb,
    S01_AXI_wvalid,
    S02_ACLK,
    S02_ARESETN,
    S02_AXI_araddr,
    S02_AXI_arburst,
    S02_AXI_arcache,
    S02_AXI_arlen,
    S02_AXI_arprot,
    S02_AXI_arready,
    S02_AXI_arsize,
    S02_AXI_arvalid,
    S02_AXI_rdata,
    S02_AXI_rlast,
    S02_AXI_rready,
    S02_AXI_rresp,
    S02_AXI_rvalid,
    S03_ACLK,
    S03_ARESETN,
    S03_AXI_awaddr,
    S03_AXI_awburst,
    S03_AXI_awcache,
    S03_AXI_awlen,
    S03_AXI_awprot,
    S03_AXI_awready,
    S03_AXI_awsize,
    S03_AXI_awvalid,
    S03_AXI_bready,
    S03_AXI_bresp,
    S03_AXI_bvalid,
    S03_AXI_wdata,
    S03_AXI_wlast,
    S03_AXI_wready,
    S03_AXI_wstrb,
    S03_AXI_wvalid,
    S04_ACLK,
    S04_ARESETN,
    S04_AXI_araddr,
    S04_AXI_arprot,
    S04_AXI_arready,
    S04_AXI_arvalid,
    S04_AXI_rdata,
    S04_AXI_rready,
    S04_AXI_rresp,
    S04_AXI_rvalid,
    S05_ACLK,
    S05_ARESETN,
    S05_AXI_araddr,
    S05_AXI_arburst,
    S05_AXI_arcache,
    S05_AXI_arid,
    S05_AXI_arlen,
    S05_AXI_arlock,
    S05_AXI_arprot,
    S05_AXI_arqos,
    S05_AXI_arready,
    S05_AXI_arsize,
    S05_AXI_arvalid,
    S05_AXI_awaddr,
    S05_AXI_awburst,
    S05_AXI_awcache,
    S05_AXI_awid,
    S05_AXI_awlen,
    S05_AXI_awlock,
    S05_AXI_awprot,
    S05_AXI_awqos,
    S05_AXI_awready,
    S05_AXI_awsize,
    S05_AXI_awvalid,
    S05_AXI_bid,
    S05_AXI_bready,
    S05_AXI_bresp,
    S05_AXI_bvalid,
    S05_AXI_rdata,
    S05_AXI_rid,
    S05_AXI_rlast,
    S05_AXI_rready,
    S05_AXI_rresp,
    S05_AXI_rvalid,
    S05_AXI_wdata,
    S05_AXI_wlast,
    S05_AXI_wready,
    S05_AXI_wstrb,
    S05_AXI_wvalid,
    S06_ACLK,
    S06_ARESETN,
    S06_AXI_araddr,
    S06_AXI_arburst,
    S06_AXI_arcache,
    S06_AXI_arid,
    S06_AXI_arlen,
    S06_AXI_arlock,
    S06_AXI_arprot,
    S06_AXI_arqos,
    S06_AXI_arready,
    S06_AXI_arsize,
    S06_AXI_arvalid,
    S06_AXI_awaddr,
    S06_AXI_awburst,
    S06_AXI_awcache,
    S06_AXI_awid,
    S06_AXI_awlen,
    S06_AXI_awlock,
    S06_AXI_awprot,
    S06_AXI_awqos,
    S06_AXI_awready,
    S06_AXI_awsize,
    S06_AXI_awvalid,
    S06_AXI_bid,
    S06_AXI_bready,
    S06_AXI_bresp,
    S06_AXI_bvalid,
    S06_AXI_rdata,
    S06_AXI_rid,
    S06_AXI_rlast,
    S06_AXI_rready,
    S06_AXI_rresp,
    S06_AXI_rvalid,
    S06_AXI_wdata,
    S06_AXI_wlast,
    S06_AXI_wready,
    S06_AXI_wstrb,
    S06_AXI_wvalid);
  input ACLK;
  input [0:0]ARESETN;
  input M00_ACLK;
  input [0:0]M00_ARESETN;
  output [31:0]M00_AXI_araddr;
  input M00_AXI_arready;
  output M00_AXI_arvalid;
  output [31:0]M00_AXI_awaddr;
  input M00_AXI_awready;
  output M00_AXI_awvalid;
  output M00_AXI_bready;
  input [1:0]M00_AXI_bresp;
  input M00_AXI_bvalid;
  input [31:0]M00_AXI_rdata;
  output M00_AXI_rready;
  input [1:0]M00_AXI_rresp;
  input M00_AXI_rvalid;
  output [31:0]M00_AXI_wdata;
  input M00_AXI_wready;
  output [3:0]M00_AXI_wstrb;
  output M00_AXI_wvalid;
  input M01_ACLK;
  input [0:0]M01_ARESETN;
  output [31:0]M01_AXI_araddr;
  output [1:0]M01_AXI_arburst;
  output [3:0]M01_AXI_arcache;
  output [7:0]M01_AXI_arlen;
  output M01_AXI_arlock;
  output [2:0]M01_AXI_arprot;
  output [3:0]M01_AXI_arqos;
  input M01_AXI_arready;
  output [3:0]M01_AXI_arregion;
  output [2:0]M01_AXI_arsize;
  output M01_AXI_arvalid;
  output [31:0]M01_AXI_awaddr;
  output [1:0]M01_AXI_awburst;
  output [3:0]M01_AXI_awcache;
  output [7:0]M01_AXI_awlen;
  output M01_AXI_awlock;
  output [2:0]M01_AXI_awprot;
  output [3:0]M01_AXI_awqos;
  input M01_AXI_awready;
  output [3:0]M01_AXI_awregion;
  output [2:0]M01_AXI_awsize;
  output M01_AXI_awvalid;
  output M01_AXI_bready;
  input [1:0]M01_AXI_bresp;
  input M01_AXI_bvalid;
  input [31:0]M01_AXI_rdata;
  input M01_AXI_rlast;
  output M01_AXI_rready;
  input [1:0]M01_AXI_rresp;
  input M01_AXI_rvalid;
  output [31:0]M01_AXI_wdata;
  output M01_AXI_wlast;
  input M01_AXI_wready;
  output [3:0]M01_AXI_wstrb;
  output M01_AXI_wvalid;
  input M02_ACLK;
  input [0:0]M02_ARESETN;
  output [31:0]M02_AXI_araddr;
  input M02_AXI_arready;
  output M02_AXI_arvalid;
  output [31:0]M02_AXI_awaddr;
  input M02_AXI_awready;
  output M02_AXI_awvalid;
  output M02_AXI_bready;
  input [1:0]M02_AXI_bresp;
  input M02_AXI_bvalid;
  input [31:0]M02_AXI_rdata;
  output M02_AXI_rready;
  input [1:0]M02_AXI_rresp;
  input M02_AXI_rvalid;
  output [31:0]M02_AXI_wdata;
  input M02_AXI_wready;
  output M02_AXI_wvalid;
  input M03_ACLK;
  input [0:0]M03_ARESETN;
  output [31:0]M03_AXI_araddr;
  input M03_AXI_arready;
  output M03_AXI_arvalid;
  output [31:0]M03_AXI_awaddr;
  input M03_AXI_awready;
  output M03_AXI_awvalid;
  output M03_AXI_bready;
  input [1:0]M03_AXI_bresp;
  input M03_AXI_bvalid;
  input [31:0]M03_AXI_rdata;
  output M03_AXI_rready;
  input [1:0]M03_AXI_rresp;
  input M03_AXI_rvalid;
  output [31:0]M03_AXI_wdata;
  input M03_AXI_wready;
  output [3:0]M03_AXI_wstrb;
  output M03_AXI_wvalid;
  input M04_ACLK;
  input [0:0]M04_ARESETN;
  output [31:0]M04_AXI_araddr;
  input M04_AXI_arready;
  output M04_AXI_arvalid;
  output [31:0]M04_AXI_awaddr;
  input M04_AXI_awready;
  output M04_AXI_awvalid;
  output M04_AXI_bready;
  input [1:0]M04_AXI_bresp;
  input M04_AXI_bvalid;
  input [31:0]M04_AXI_rdata;
  output M04_AXI_rready;
  input [1:0]M04_AXI_rresp;
  input M04_AXI_rvalid;
  output [31:0]M04_AXI_wdata;
  input M04_AXI_wready;
  output [3:0]M04_AXI_wstrb;
  output M04_AXI_wvalid;
  input M05_ACLK;
  input [0:0]M05_ARESETN;
  output [31:0]M05_AXI_araddr;
  input M05_AXI_arready;
  output M05_AXI_arvalid;
  output [31:0]M05_AXI_awaddr;
  input M05_AXI_awready;
  output M05_AXI_awvalid;
  output M05_AXI_bready;
  input [1:0]M05_AXI_bresp;
  input M05_AXI_bvalid;
  input [31:0]M05_AXI_rdata;
  output M05_AXI_rready;
  input [1:0]M05_AXI_rresp;
  input M05_AXI_rvalid;
  output [31:0]M05_AXI_wdata;
  input M05_AXI_wready;
  output [3:0]M05_AXI_wstrb;
  output M05_AXI_wvalid;
  input M06_ACLK;
  input [0:0]M06_ARESETN;
  output [31:0]M06_AXI_araddr;
  input M06_AXI_arready;
  output M06_AXI_arvalid;
  output [31:0]M06_AXI_awaddr;
  input M06_AXI_awready;
  output M06_AXI_awvalid;
  output M06_AXI_bready;
  input [1:0]M06_AXI_bresp;
  input M06_AXI_bvalid;
  input [31:0]M06_AXI_rdata;
  output M06_AXI_rready;
  input [1:0]M06_AXI_rresp;
  input M06_AXI_rvalid;
  output [31:0]M06_AXI_wdata;
  input M06_AXI_wready;
  output [3:0]M06_AXI_wstrb;
  output M06_AXI_wvalid;
  input M07_ACLK;
  input [0:0]M07_ARESETN;
  output [31:0]M07_AXI_araddr;
  output [1:0]M07_AXI_arburst;
  output [3:0]M07_AXI_arcache;
  output [7:0]M07_AXI_arlen;
  output [0:0]M07_AXI_arlock;
  output [2:0]M07_AXI_arprot;
  output [3:0]M07_AXI_arqos;
  input M07_AXI_arready;
  output [3:0]M07_AXI_arregion;
  output [2:0]M07_AXI_arsize;
  output M07_AXI_arvalid;
  output [31:0]M07_AXI_awaddr;
  output [1:0]M07_AXI_awburst;
  output [3:0]M07_AXI_awcache;
  output [7:0]M07_AXI_awlen;
  output [0:0]M07_AXI_awlock;
  output [2:0]M07_AXI_awprot;
  output [3:0]M07_AXI_awqos;
  input M07_AXI_awready;
  output [3:0]M07_AXI_awregion;
  output [2:0]M07_AXI_awsize;
  output M07_AXI_awvalid;
  output M07_AXI_bready;
  input [1:0]M07_AXI_bresp;
  input M07_AXI_bvalid;
  input [511:0]M07_AXI_rdata;
  input M07_AXI_rlast;
  output M07_AXI_rready;
  input [1:0]M07_AXI_rresp;
  input M07_AXI_rvalid;
  output [511:0]M07_AXI_wdata;
  output M07_AXI_wlast;
  input M07_AXI_wready;
  output [63:0]M07_AXI_wstrb;
  output M07_AXI_wvalid;
  input M08_ACLK;
  input [0:0]M08_ARESETN;
  output [17:0]M08_AXI_araddr;
  input M08_AXI_arready;
  output M08_AXI_arvalid;
  output [17:0]M08_AXI_awaddr;
  input M08_AXI_awready;
  output M08_AXI_awvalid;
  output M08_AXI_bready;
  input [1:0]M08_AXI_bresp;
  input M08_AXI_bvalid;
  input [31:0]M08_AXI_rdata;
  output M08_AXI_rready;
  input [1:0]M08_AXI_rresp;
  input M08_AXI_rvalid;
  output [31:0]M08_AXI_wdata;
  input M08_AXI_wready;
  output [3:0]M08_AXI_wstrb;
  output M08_AXI_wvalid;
  input M09_ACLK;
  input [0:0]M09_ARESETN;
  output [31:0]M09_AXI_araddr;
  input M09_AXI_arready;
  output M09_AXI_arvalid;
  output [31:0]M09_AXI_awaddr;
  input M09_AXI_awready;
  output M09_AXI_awvalid;
  output M09_AXI_bready;
  input [1:0]M09_AXI_bresp;
  input M09_AXI_bvalid;
  input [31:0]M09_AXI_rdata;
  output M09_AXI_rready;
  input [1:0]M09_AXI_rresp;
  input M09_AXI_rvalid;
  output [31:0]M09_AXI_wdata;
  input M09_AXI_wready;
  output [3:0]M09_AXI_wstrb;
  output M09_AXI_wvalid;
  input M10_ACLK;
  input [0:0]M10_ARESETN;
  output [31:0]M10_AXI_araddr;
  input M10_AXI_arready;
  output M10_AXI_arvalid;
  output [31:0]M10_AXI_awaddr;
  input M10_AXI_awready;
  output M10_AXI_awvalid;
  output M10_AXI_bready;
  input [1:0]M10_AXI_bresp;
  input M10_AXI_bvalid;
  input [31:0]M10_AXI_rdata;
  output M10_AXI_rready;
  input [1:0]M10_AXI_rresp;
  input M10_AXI_rvalid;
  output [31:0]M10_AXI_wdata;
  input M10_AXI_wready;
  output M10_AXI_wvalid;
  input M11_ACLK;
  input [0:0]M11_ARESETN;
  output [31:0]M11_AXI_araddr;
  output [2:0]M11_AXI_arprot;
  input M11_AXI_arready;
  output M11_AXI_arvalid;
  output [31:0]M11_AXI_awaddr;
  output [2:0]M11_AXI_awprot;
  input M11_AXI_awready;
  output M11_AXI_awvalid;
  output M11_AXI_bready;
  input [1:0]M11_AXI_bresp;
  input M11_AXI_bvalid;
  input [31:0]M11_AXI_rdata;
  output M11_AXI_rready;
  input [1:0]M11_AXI_rresp;
  input M11_AXI_rvalid;
  output [31:0]M11_AXI_wdata;
  input M11_AXI_wready;
  output [3:0]M11_AXI_wstrb;
  output M11_AXI_wvalid;
  input M12_ACLK;
  input [0:0]M12_ARESETN;
  output [31:0]M12_AXI_araddr;
  input M12_AXI_arready;
  output M12_AXI_arvalid;
  output [31:0]M12_AXI_awaddr;
  input M12_AXI_awready;
  output M12_AXI_awvalid;
  output M12_AXI_bready;
  input [1:0]M12_AXI_bresp;
  input M12_AXI_bvalid;
  input [31:0]M12_AXI_rdata;
  output M12_AXI_rready;
  input [1:0]M12_AXI_rresp;
  input M12_AXI_rvalid;
  output [31:0]M12_AXI_wdata;
  input M12_AXI_wready;
  output [3:0]M12_AXI_wstrb;
  output M12_AXI_wvalid;
  input M13_ACLK;
  input [0:0]M13_ARESETN;
  output [31:0]M13_AXI_araddr;
  output [2:0]M13_AXI_arprot;
  input M13_AXI_arready;
  output M13_AXI_arvalid;
  output [31:0]M13_AXI_awaddr;
  output [2:0]M13_AXI_awprot;
  input M13_AXI_awready;
  output M13_AXI_awvalid;
  output M13_AXI_bready;
  input [1:0]M13_AXI_bresp;
  input M13_AXI_bvalid;
  input [31:0]M13_AXI_rdata;
  output M13_AXI_rready;
  input [1:0]M13_AXI_rresp;
  input M13_AXI_rvalid;
  output [31:0]M13_AXI_wdata;
  input M13_AXI_wready;
  output [3:0]M13_AXI_wstrb;
  output M13_AXI_wvalid;
  input M14_ACLK;
  input [0:0]M14_ARESETN;
  output [31:0]M14_AXI_araddr;
  output [1:0]M14_AXI_arburst;
  output [3:0]M14_AXI_arcache;
  output [7:0]M14_AXI_arlen;
  output M14_AXI_arlock;
  output [2:0]M14_AXI_arprot;
  output [3:0]M14_AXI_arqos;
  input M14_AXI_arready;
  output [3:0]M14_AXI_arregion;
  output [2:0]M14_AXI_arsize;
  output M14_AXI_arvalid;
  output [31:0]M14_AXI_awaddr;
  output [1:0]M14_AXI_awburst;
  output [3:0]M14_AXI_awcache;
  output [7:0]M14_AXI_awlen;
  output M14_AXI_awlock;
  output [2:0]M14_AXI_awprot;
  output [3:0]M14_AXI_awqos;
  input M14_AXI_awready;
  output [3:0]M14_AXI_awregion;
  output [2:0]M14_AXI_awsize;
  output M14_AXI_awvalid;
  output M14_AXI_bready;
  input [1:0]M14_AXI_bresp;
  input M14_AXI_bvalid;
  input [31:0]M14_AXI_rdata;
  input M14_AXI_rlast;
  output M14_AXI_rready;
  input [1:0]M14_AXI_rresp;
  input M14_AXI_rvalid;
  output [31:0]M14_AXI_wdata;
  output M14_AXI_wlast;
  input M14_AXI_wready;
  output [3:0]M14_AXI_wstrb;
  output M14_AXI_wvalid;
  input S00_ACLK;
  input [0:0]S00_ARESETN;
  input [31:0]S00_AXI_araddr;
  input [2:0]S00_AXI_arprot;
  output S00_AXI_arready;
  input S00_AXI_arvalid;
  input [31:0]S00_AXI_awaddr;
  input [2:0]S00_AXI_awprot;
  output S00_AXI_awready;
  input S00_AXI_awvalid;
  input S00_AXI_bready;
  output [1:0]S00_AXI_bresp;
  output S00_AXI_bvalid;
  output [31:0]S00_AXI_rdata;
  input S00_AXI_rready;
  output [1:0]S00_AXI_rresp;
  output S00_AXI_rvalid;
  input [31:0]S00_AXI_wdata;
  output S00_AXI_wready;
  input [3:0]S00_AXI_wstrb;
  input S00_AXI_wvalid;
  input S01_ACLK;
  input [0:0]S01_ARESETN;
  input [31:0]S01_AXI_araddr;
  input [1:0]S01_AXI_arburst;
  input [3:0]S01_AXI_arcache;
  input [7:0]S01_AXI_arlen;
  input [2:0]S01_AXI_arprot;
  output S01_AXI_arready;
  input [2:0]S01_AXI_arsize;
  input S01_AXI_arvalid;
  input [31:0]S01_AXI_awaddr;
  input [1:0]S01_AXI_awburst;
  input [3:0]S01_AXI_awcache;
  input [7:0]S01_AXI_awlen;
  input [2:0]S01_AXI_awprot;
  output S01_AXI_awready;
  input [2:0]S01_AXI_awsize;
  input S01_AXI_awvalid;
  input S01_AXI_bready;
  output [1:0]S01_AXI_bresp;
  output S01_AXI_bvalid;
  output [31:0]S01_AXI_rdata;
  output S01_AXI_rlast;
  input S01_AXI_rready;
  output [1:0]S01_AXI_rresp;
  output S01_AXI_rvalid;
  input [31:0]S01_AXI_wdata;
  input S01_AXI_wlast;
  output S01_AXI_wready;
  input [3:0]S01_AXI_wstrb;
  input S01_AXI_wvalid;
  input S02_ACLK;
  input [0:0]S02_ARESETN;
  input [31:0]S02_AXI_araddr;
  input [1:0]S02_AXI_arburst;
  input [3:0]S02_AXI_arcache;
  input [7:0]S02_AXI_arlen;
  input [2:0]S02_AXI_arprot;
  output S02_AXI_arready;
  input [2:0]S02_AXI_arsize;
  input S02_AXI_arvalid;
  output [31:0]S02_AXI_rdata;
  output S02_AXI_rlast;
  input S02_AXI_rready;
  output [1:0]S02_AXI_rresp;
  output S02_AXI_rvalid;
  input S03_ACLK;
  input [0:0]S03_ARESETN;
  input [31:0]S03_AXI_awaddr;
  input [1:0]S03_AXI_awburst;
  input [3:0]S03_AXI_awcache;
  input [7:0]S03_AXI_awlen;
  input [2:0]S03_AXI_awprot;
  output S03_AXI_awready;
  input [2:0]S03_AXI_awsize;
  input S03_AXI_awvalid;
  input S03_AXI_bready;
  output [1:0]S03_AXI_bresp;
  output S03_AXI_bvalid;
  input [31:0]S03_AXI_wdata;
  input S03_AXI_wlast;
  output S03_AXI_wready;
  input [3:0]S03_AXI_wstrb;
  input S03_AXI_wvalid;
  input S04_ACLK;
  input [0:0]S04_ARESETN;
  input [31:0]S04_AXI_araddr;
  input [2:0]S04_AXI_arprot;
  output S04_AXI_arready;
  input S04_AXI_arvalid;
  output [31:0]S04_AXI_rdata;
  input S04_AXI_rready;
  output [1:0]S04_AXI_rresp;
  output S04_AXI_rvalid;
  input S05_ACLK;
  input [0:0]S05_ARESETN;
  input [31:0]S05_AXI_araddr;
  input [1:0]S05_AXI_arburst;
  input [3:0]S05_AXI_arcache;
  input [0:0]S05_AXI_arid;
  input [7:0]S05_AXI_arlen;
  input S05_AXI_arlock;
  input [2:0]S05_AXI_arprot;
  input [3:0]S05_AXI_arqos;
  output S05_AXI_arready;
  input [2:0]S05_AXI_arsize;
  input S05_AXI_arvalid;
  input [31:0]S05_AXI_awaddr;
  input [1:0]S05_AXI_awburst;
  input [3:0]S05_AXI_awcache;
  input [0:0]S05_AXI_awid;
  input [7:0]S05_AXI_awlen;
  input S05_AXI_awlock;
  input [2:0]S05_AXI_awprot;
  input [3:0]S05_AXI_awqos;
  output S05_AXI_awready;
  input [2:0]S05_AXI_awsize;
  input S05_AXI_awvalid;
  output [0:0]S05_AXI_bid;
  input S05_AXI_bready;
  output [1:0]S05_AXI_bresp;
  output S05_AXI_bvalid;
  output [31:0]S05_AXI_rdata;
  output [0:0]S05_AXI_rid;
  output S05_AXI_rlast;
  input S05_AXI_rready;
  output [1:0]S05_AXI_rresp;
  output S05_AXI_rvalid;
  input [31:0]S05_AXI_wdata;
  input S05_AXI_wlast;
  output S05_AXI_wready;
  input [3:0]S05_AXI_wstrb;
  input S05_AXI_wvalid;
  input S06_ACLK;
  input [0:0]S06_ARESETN;
  input [31:0]S06_AXI_araddr;
  input [1:0]S06_AXI_arburst;
  input [3:0]S06_AXI_arcache;
  input [0:0]S06_AXI_arid;
  input [7:0]S06_AXI_arlen;
  input S06_AXI_arlock;
  input [2:0]S06_AXI_arprot;
  input [3:0]S06_AXI_arqos;
  output S06_AXI_arready;
  input [2:0]S06_AXI_arsize;
  input S06_AXI_arvalid;
  input [31:0]S06_AXI_awaddr;
  input [1:0]S06_AXI_awburst;
  input [3:0]S06_AXI_awcache;
  input [0:0]S06_AXI_awid;
  input [7:0]S06_AXI_awlen;
  input S06_AXI_awlock;
  input [2:0]S06_AXI_awprot;
  input [3:0]S06_AXI_awqos;
  output S06_AXI_awready;
  input [2:0]S06_AXI_awsize;
  input S06_AXI_awvalid;
  output [0:0]S06_AXI_bid;
  input S06_AXI_bready;
  output [1:0]S06_AXI_bresp;
  output S06_AXI_bvalid;
  output [31:0]S06_AXI_rdata;
  output [0:0]S06_AXI_rid;
  output S06_AXI_rlast;
  input S06_AXI_rready;
  output [1:0]S06_AXI_rresp;
  output S06_AXI_rvalid;
  input [31:0]S06_AXI_wdata;
  input S06_AXI_wlast;
  output S06_AXI_wready;
  input [3:0]S06_AXI_wstrb;
  input S06_AXI_wvalid;

  wire axi_cpu_interconnect_ACLK_net;
  wire [0:0]axi_cpu_interconnect_ARESETN_net;
  wire [31:0]axi_cpu_interconnect_to_s00_couplers_ARADDR;
  wire [2:0]axi_cpu_interconnect_to_s00_couplers_ARPROT;
  wire axi_cpu_interconnect_to_s00_couplers_ARREADY;
  wire axi_cpu_interconnect_to_s00_couplers_ARVALID;
  wire [31:0]axi_cpu_interconnect_to_s00_couplers_AWADDR;
  wire [2:0]axi_cpu_interconnect_to_s00_couplers_AWPROT;
  wire axi_cpu_interconnect_to_s00_couplers_AWREADY;
  wire axi_cpu_interconnect_to_s00_couplers_AWVALID;
  wire axi_cpu_interconnect_to_s00_couplers_BREADY;
  wire [1:0]axi_cpu_interconnect_to_s00_couplers_BRESP;
  wire axi_cpu_interconnect_to_s00_couplers_BVALID;
  wire [31:0]axi_cpu_interconnect_to_s00_couplers_RDATA;
  wire axi_cpu_interconnect_to_s00_couplers_RREADY;
  wire [1:0]axi_cpu_interconnect_to_s00_couplers_RRESP;
  wire axi_cpu_interconnect_to_s00_couplers_RVALID;
  wire [31:0]axi_cpu_interconnect_to_s00_couplers_WDATA;
  wire axi_cpu_interconnect_to_s00_couplers_WREADY;
  wire [3:0]axi_cpu_interconnect_to_s00_couplers_WSTRB;
  wire axi_cpu_interconnect_to_s00_couplers_WVALID;
  wire [31:0]axi_cpu_interconnect_to_s01_couplers_ARADDR;
  wire [1:0]axi_cpu_interconnect_to_s01_couplers_ARBURST;
  wire [3:0]axi_cpu_interconnect_to_s01_couplers_ARCACHE;
  wire [7:0]axi_cpu_interconnect_to_s01_couplers_ARLEN;
  wire [2:0]axi_cpu_interconnect_to_s01_couplers_ARPROT;
  wire axi_cpu_interconnect_to_s01_couplers_ARREADY;
  wire [2:0]axi_cpu_interconnect_to_s01_couplers_ARSIZE;
  wire axi_cpu_interconnect_to_s01_couplers_ARVALID;
  wire [31:0]axi_cpu_interconnect_to_s01_couplers_AWADDR;
  wire [1:0]axi_cpu_interconnect_to_s01_couplers_AWBURST;
  wire [3:0]axi_cpu_interconnect_to_s01_couplers_AWCACHE;
  wire [7:0]axi_cpu_interconnect_to_s01_couplers_AWLEN;
  wire [2:0]axi_cpu_interconnect_to_s01_couplers_AWPROT;
  wire axi_cpu_interconnect_to_s01_couplers_AWREADY;
  wire [2:0]axi_cpu_interconnect_to_s01_couplers_AWSIZE;
  wire axi_cpu_interconnect_to_s01_couplers_AWVALID;
  wire axi_cpu_interconnect_to_s01_couplers_BREADY;
  wire [1:0]axi_cpu_interconnect_to_s01_couplers_BRESP;
  wire axi_cpu_interconnect_to_s01_couplers_BVALID;
  wire [31:0]axi_cpu_interconnect_to_s01_couplers_RDATA;
  wire axi_cpu_interconnect_to_s01_couplers_RLAST;
  wire axi_cpu_interconnect_to_s01_couplers_RREADY;
  wire [1:0]axi_cpu_interconnect_to_s01_couplers_RRESP;
  wire axi_cpu_interconnect_to_s01_couplers_RVALID;
  wire [31:0]axi_cpu_interconnect_to_s01_couplers_WDATA;
  wire axi_cpu_interconnect_to_s01_couplers_WLAST;
  wire axi_cpu_interconnect_to_s01_couplers_WREADY;
  wire [3:0]axi_cpu_interconnect_to_s01_couplers_WSTRB;
  wire axi_cpu_interconnect_to_s01_couplers_WVALID;
  wire [31:0]axi_cpu_interconnect_to_s02_couplers_ARADDR;
  wire [1:0]axi_cpu_interconnect_to_s02_couplers_ARBURST;
  wire [3:0]axi_cpu_interconnect_to_s02_couplers_ARCACHE;
  wire [7:0]axi_cpu_interconnect_to_s02_couplers_ARLEN;
  wire [2:0]axi_cpu_interconnect_to_s02_couplers_ARPROT;
  wire axi_cpu_interconnect_to_s02_couplers_ARREADY;
  wire [2:0]axi_cpu_interconnect_to_s02_couplers_ARSIZE;
  wire axi_cpu_interconnect_to_s02_couplers_ARVALID;
  wire [31:0]axi_cpu_interconnect_to_s02_couplers_RDATA;
  wire axi_cpu_interconnect_to_s02_couplers_RLAST;
  wire axi_cpu_interconnect_to_s02_couplers_RREADY;
  wire [1:0]axi_cpu_interconnect_to_s02_couplers_RRESP;
  wire axi_cpu_interconnect_to_s02_couplers_RVALID;
  wire [31:0]axi_cpu_interconnect_to_s03_couplers_AWADDR;
  wire [1:0]axi_cpu_interconnect_to_s03_couplers_AWBURST;
  wire [3:0]axi_cpu_interconnect_to_s03_couplers_AWCACHE;
  wire [7:0]axi_cpu_interconnect_to_s03_couplers_AWLEN;
  wire [2:0]axi_cpu_interconnect_to_s03_couplers_AWPROT;
  wire axi_cpu_interconnect_to_s03_couplers_AWREADY;
  wire [2:0]axi_cpu_interconnect_to_s03_couplers_AWSIZE;
  wire axi_cpu_interconnect_to_s03_couplers_AWVALID;
  wire axi_cpu_interconnect_to_s03_couplers_BREADY;
  wire [1:0]axi_cpu_interconnect_to_s03_couplers_BRESP;
  wire axi_cpu_interconnect_to_s03_couplers_BVALID;
  wire [31:0]axi_cpu_interconnect_to_s03_couplers_WDATA;
  wire axi_cpu_interconnect_to_s03_couplers_WLAST;
  wire axi_cpu_interconnect_to_s03_couplers_WREADY;
  wire [3:0]axi_cpu_interconnect_to_s03_couplers_WSTRB;
  wire axi_cpu_interconnect_to_s03_couplers_WVALID;
  wire [31:0]axi_cpu_interconnect_to_s04_couplers_ARADDR;
  wire [2:0]axi_cpu_interconnect_to_s04_couplers_ARPROT;
  wire axi_cpu_interconnect_to_s04_couplers_ARREADY;
  wire axi_cpu_interconnect_to_s04_couplers_ARVALID;
  wire [31:0]axi_cpu_interconnect_to_s04_couplers_RDATA;
  wire axi_cpu_interconnect_to_s04_couplers_RREADY;
  wire [1:0]axi_cpu_interconnect_to_s04_couplers_RRESP;
  wire axi_cpu_interconnect_to_s04_couplers_RVALID;
  wire [31:0]axi_cpu_interconnect_to_s05_couplers_ARADDR;
  wire [1:0]axi_cpu_interconnect_to_s05_couplers_ARBURST;
  wire [3:0]axi_cpu_interconnect_to_s05_couplers_ARCACHE;
  wire [0:0]axi_cpu_interconnect_to_s05_couplers_ARID;
  wire [7:0]axi_cpu_interconnect_to_s05_couplers_ARLEN;
  wire axi_cpu_interconnect_to_s05_couplers_ARLOCK;
  wire [2:0]axi_cpu_interconnect_to_s05_couplers_ARPROT;
  wire [3:0]axi_cpu_interconnect_to_s05_couplers_ARQOS;
  wire axi_cpu_interconnect_to_s05_couplers_ARREADY;
  wire [2:0]axi_cpu_interconnect_to_s05_couplers_ARSIZE;
  wire axi_cpu_interconnect_to_s05_couplers_ARVALID;
  wire [31:0]axi_cpu_interconnect_to_s05_couplers_AWADDR;
  wire [1:0]axi_cpu_interconnect_to_s05_couplers_AWBURST;
  wire [3:0]axi_cpu_interconnect_to_s05_couplers_AWCACHE;
  wire [0:0]axi_cpu_interconnect_to_s05_couplers_AWID;
  wire [7:0]axi_cpu_interconnect_to_s05_couplers_AWLEN;
  wire axi_cpu_interconnect_to_s05_couplers_AWLOCK;
  wire [2:0]axi_cpu_interconnect_to_s05_couplers_AWPROT;
  wire [3:0]axi_cpu_interconnect_to_s05_couplers_AWQOS;
  wire axi_cpu_interconnect_to_s05_couplers_AWREADY;
  wire [2:0]axi_cpu_interconnect_to_s05_couplers_AWSIZE;
  wire axi_cpu_interconnect_to_s05_couplers_AWVALID;
  wire [0:0]axi_cpu_interconnect_to_s05_couplers_BID;
  wire axi_cpu_interconnect_to_s05_couplers_BREADY;
  wire [1:0]axi_cpu_interconnect_to_s05_couplers_BRESP;
  wire axi_cpu_interconnect_to_s05_couplers_BVALID;
  wire [31:0]axi_cpu_interconnect_to_s05_couplers_RDATA;
  wire [0:0]axi_cpu_interconnect_to_s05_couplers_RID;
  wire axi_cpu_interconnect_to_s05_couplers_RLAST;
  wire axi_cpu_interconnect_to_s05_couplers_RREADY;
  wire [1:0]axi_cpu_interconnect_to_s05_couplers_RRESP;
  wire axi_cpu_interconnect_to_s05_couplers_RVALID;
  wire [31:0]axi_cpu_interconnect_to_s05_couplers_WDATA;
  wire axi_cpu_interconnect_to_s05_couplers_WLAST;
  wire axi_cpu_interconnect_to_s05_couplers_WREADY;
  wire [3:0]axi_cpu_interconnect_to_s05_couplers_WSTRB;
  wire axi_cpu_interconnect_to_s05_couplers_WVALID;
  wire [31:0]axi_cpu_interconnect_to_s06_couplers_ARADDR;
  wire [1:0]axi_cpu_interconnect_to_s06_couplers_ARBURST;
  wire [3:0]axi_cpu_interconnect_to_s06_couplers_ARCACHE;
  wire [0:0]axi_cpu_interconnect_to_s06_couplers_ARID;
  wire [7:0]axi_cpu_interconnect_to_s06_couplers_ARLEN;
  wire axi_cpu_interconnect_to_s06_couplers_ARLOCK;
  wire [2:0]axi_cpu_interconnect_to_s06_couplers_ARPROT;
  wire [3:0]axi_cpu_interconnect_to_s06_couplers_ARQOS;
  wire axi_cpu_interconnect_to_s06_couplers_ARREADY;
  wire [2:0]axi_cpu_interconnect_to_s06_couplers_ARSIZE;
  wire axi_cpu_interconnect_to_s06_couplers_ARVALID;
  wire [31:0]axi_cpu_interconnect_to_s06_couplers_AWADDR;
  wire [1:0]axi_cpu_interconnect_to_s06_couplers_AWBURST;
  wire [3:0]axi_cpu_interconnect_to_s06_couplers_AWCACHE;
  wire [0:0]axi_cpu_interconnect_to_s06_couplers_AWID;
  wire [7:0]axi_cpu_interconnect_to_s06_couplers_AWLEN;
  wire axi_cpu_interconnect_to_s06_couplers_AWLOCK;
  wire [2:0]axi_cpu_interconnect_to_s06_couplers_AWPROT;
  wire [3:0]axi_cpu_interconnect_to_s06_couplers_AWQOS;
  wire axi_cpu_interconnect_to_s06_couplers_AWREADY;
  wire [2:0]axi_cpu_interconnect_to_s06_couplers_AWSIZE;
  wire axi_cpu_interconnect_to_s06_couplers_AWVALID;
  wire [0:0]axi_cpu_interconnect_to_s06_couplers_BID;
  wire axi_cpu_interconnect_to_s06_couplers_BREADY;
  wire [1:0]axi_cpu_interconnect_to_s06_couplers_BRESP;
  wire axi_cpu_interconnect_to_s06_couplers_BVALID;
  wire [31:0]axi_cpu_interconnect_to_s06_couplers_RDATA;
  wire [0:0]axi_cpu_interconnect_to_s06_couplers_RID;
  wire axi_cpu_interconnect_to_s06_couplers_RLAST;
  wire axi_cpu_interconnect_to_s06_couplers_RREADY;
  wire [1:0]axi_cpu_interconnect_to_s06_couplers_RRESP;
  wire axi_cpu_interconnect_to_s06_couplers_RVALID;
  wire [31:0]axi_cpu_interconnect_to_s06_couplers_WDATA;
  wire axi_cpu_interconnect_to_s06_couplers_WLAST;
  wire axi_cpu_interconnect_to_s06_couplers_WREADY;
  wire [3:0]axi_cpu_interconnect_to_s06_couplers_WSTRB;
  wire axi_cpu_interconnect_to_s06_couplers_WVALID;
  wire [31:0]m00_couplers_to_axi_cpu_interconnect_ARADDR;
  wire m00_couplers_to_axi_cpu_interconnect_ARREADY;
  wire m00_couplers_to_axi_cpu_interconnect_ARVALID;
  wire [31:0]m00_couplers_to_axi_cpu_interconnect_AWADDR;
  wire m00_couplers_to_axi_cpu_interconnect_AWREADY;
  wire m00_couplers_to_axi_cpu_interconnect_AWVALID;
  wire m00_couplers_to_axi_cpu_interconnect_BREADY;
  wire [1:0]m00_couplers_to_axi_cpu_interconnect_BRESP;
  wire m00_couplers_to_axi_cpu_interconnect_BVALID;
  wire [31:0]m00_couplers_to_axi_cpu_interconnect_RDATA;
  wire m00_couplers_to_axi_cpu_interconnect_RREADY;
  wire [1:0]m00_couplers_to_axi_cpu_interconnect_RRESP;
  wire m00_couplers_to_axi_cpu_interconnect_RVALID;
  wire [31:0]m00_couplers_to_axi_cpu_interconnect_WDATA;
  wire m00_couplers_to_axi_cpu_interconnect_WREADY;
  wire [3:0]m00_couplers_to_axi_cpu_interconnect_WSTRB;
  wire m00_couplers_to_axi_cpu_interconnect_WVALID;
  wire [31:0]m01_couplers_to_axi_cpu_interconnect_ARADDR;
  wire [1:0]m01_couplers_to_axi_cpu_interconnect_ARBURST;
  wire [3:0]m01_couplers_to_axi_cpu_interconnect_ARCACHE;
  wire [7:0]m01_couplers_to_axi_cpu_interconnect_ARLEN;
  wire m01_couplers_to_axi_cpu_interconnect_ARLOCK;
  wire [2:0]m01_couplers_to_axi_cpu_interconnect_ARPROT;
  wire [3:0]m01_couplers_to_axi_cpu_interconnect_ARQOS;
  wire m01_couplers_to_axi_cpu_interconnect_ARREADY;
  wire [3:0]m01_couplers_to_axi_cpu_interconnect_ARREGION;
  wire [2:0]m01_couplers_to_axi_cpu_interconnect_ARSIZE;
  wire m01_couplers_to_axi_cpu_interconnect_ARVALID;
  wire [31:0]m01_couplers_to_axi_cpu_interconnect_AWADDR;
  wire [1:0]m01_couplers_to_axi_cpu_interconnect_AWBURST;
  wire [3:0]m01_couplers_to_axi_cpu_interconnect_AWCACHE;
  wire [7:0]m01_couplers_to_axi_cpu_interconnect_AWLEN;
  wire m01_couplers_to_axi_cpu_interconnect_AWLOCK;
  wire [2:0]m01_couplers_to_axi_cpu_interconnect_AWPROT;
  wire [3:0]m01_couplers_to_axi_cpu_interconnect_AWQOS;
  wire m01_couplers_to_axi_cpu_interconnect_AWREADY;
  wire [3:0]m01_couplers_to_axi_cpu_interconnect_AWREGION;
  wire [2:0]m01_couplers_to_axi_cpu_interconnect_AWSIZE;
  wire m01_couplers_to_axi_cpu_interconnect_AWVALID;
  wire m01_couplers_to_axi_cpu_interconnect_BREADY;
  wire [1:0]m01_couplers_to_axi_cpu_interconnect_BRESP;
  wire m01_couplers_to_axi_cpu_interconnect_BVALID;
  wire [31:0]m01_couplers_to_axi_cpu_interconnect_RDATA;
  wire m01_couplers_to_axi_cpu_interconnect_RLAST;
  wire m01_couplers_to_axi_cpu_interconnect_RREADY;
  wire [1:0]m01_couplers_to_axi_cpu_interconnect_RRESP;
  wire m01_couplers_to_axi_cpu_interconnect_RVALID;
  wire [31:0]m01_couplers_to_axi_cpu_interconnect_WDATA;
  wire m01_couplers_to_axi_cpu_interconnect_WLAST;
  wire m01_couplers_to_axi_cpu_interconnect_WREADY;
  wire [3:0]m01_couplers_to_axi_cpu_interconnect_WSTRB;
  wire m01_couplers_to_axi_cpu_interconnect_WVALID;
  wire [31:0]m02_couplers_to_axi_cpu_interconnect_ARADDR;
  wire m02_couplers_to_axi_cpu_interconnect_ARREADY;
  wire m02_couplers_to_axi_cpu_interconnect_ARVALID;
  wire [31:0]m02_couplers_to_axi_cpu_interconnect_AWADDR;
  wire m02_couplers_to_axi_cpu_interconnect_AWREADY;
  wire m02_couplers_to_axi_cpu_interconnect_AWVALID;
  wire m02_couplers_to_axi_cpu_interconnect_BREADY;
  wire [1:0]m02_couplers_to_axi_cpu_interconnect_BRESP;
  wire m02_couplers_to_axi_cpu_interconnect_BVALID;
  wire [31:0]m02_couplers_to_axi_cpu_interconnect_RDATA;
  wire m02_couplers_to_axi_cpu_interconnect_RREADY;
  wire [1:0]m02_couplers_to_axi_cpu_interconnect_RRESP;
  wire m02_couplers_to_axi_cpu_interconnect_RVALID;
  wire [31:0]m02_couplers_to_axi_cpu_interconnect_WDATA;
  wire m02_couplers_to_axi_cpu_interconnect_WREADY;
  wire m02_couplers_to_axi_cpu_interconnect_WVALID;
  wire [31:0]m03_couplers_to_axi_cpu_interconnect_ARADDR;
  wire m03_couplers_to_axi_cpu_interconnect_ARREADY;
  wire m03_couplers_to_axi_cpu_interconnect_ARVALID;
  wire [31:0]m03_couplers_to_axi_cpu_interconnect_AWADDR;
  wire m03_couplers_to_axi_cpu_interconnect_AWREADY;
  wire m03_couplers_to_axi_cpu_interconnect_AWVALID;
  wire m03_couplers_to_axi_cpu_interconnect_BREADY;
  wire [1:0]m03_couplers_to_axi_cpu_interconnect_BRESP;
  wire m03_couplers_to_axi_cpu_interconnect_BVALID;
  wire [31:0]m03_couplers_to_axi_cpu_interconnect_RDATA;
  wire m03_couplers_to_axi_cpu_interconnect_RREADY;
  wire [1:0]m03_couplers_to_axi_cpu_interconnect_RRESP;
  wire m03_couplers_to_axi_cpu_interconnect_RVALID;
  wire [31:0]m03_couplers_to_axi_cpu_interconnect_WDATA;
  wire m03_couplers_to_axi_cpu_interconnect_WREADY;
  wire [3:0]m03_couplers_to_axi_cpu_interconnect_WSTRB;
  wire m03_couplers_to_axi_cpu_interconnect_WVALID;
  wire [31:0]m04_couplers_to_axi_cpu_interconnect_ARADDR;
  wire m04_couplers_to_axi_cpu_interconnect_ARREADY;
  wire m04_couplers_to_axi_cpu_interconnect_ARVALID;
  wire [31:0]m04_couplers_to_axi_cpu_interconnect_AWADDR;
  wire m04_couplers_to_axi_cpu_interconnect_AWREADY;
  wire m04_couplers_to_axi_cpu_interconnect_AWVALID;
  wire m04_couplers_to_axi_cpu_interconnect_BREADY;
  wire [1:0]m04_couplers_to_axi_cpu_interconnect_BRESP;
  wire m04_couplers_to_axi_cpu_interconnect_BVALID;
  wire [31:0]m04_couplers_to_axi_cpu_interconnect_RDATA;
  wire m04_couplers_to_axi_cpu_interconnect_RREADY;
  wire [1:0]m04_couplers_to_axi_cpu_interconnect_RRESP;
  wire m04_couplers_to_axi_cpu_interconnect_RVALID;
  wire [31:0]m04_couplers_to_axi_cpu_interconnect_WDATA;
  wire m04_couplers_to_axi_cpu_interconnect_WREADY;
  wire [3:0]m04_couplers_to_axi_cpu_interconnect_WSTRB;
  wire m04_couplers_to_axi_cpu_interconnect_WVALID;
  wire [31:0]m05_couplers_to_axi_cpu_interconnect_ARADDR;
  wire m05_couplers_to_axi_cpu_interconnect_ARREADY;
  wire m05_couplers_to_axi_cpu_interconnect_ARVALID;
  wire [31:0]m05_couplers_to_axi_cpu_interconnect_AWADDR;
  wire m05_couplers_to_axi_cpu_interconnect_AWREADY;
  wire m05_couplers_to_axi_cpu_interconnect_AWVALID;
  wire m05_couplers_to_axi_cpu_interconnect_BREADY;
  wire [1:0]m05_couplers_to_axi_cpu_interconnect_BRESP;
  wire m05_couplers_to_axi_cpu_interconnect_BVALID;
  wire [31:0]m05_couplers_to_axi_cpu_interconnect_RDATA;
  wire m05_couplers_to_axi_cpu_interconnect_RREADY;
  wire [1:0]m05_couplers_to_axi_cpu_interconnect_RRESP;
  wire m05_couplers_to_axi_cpu_interconnect_RVALID;
  wire [31:0]m05_couplers_to_axi_cpu_interconnect_WDATA;
  wire m05_couplers_to_axi_cpu_interconnect_WREADY;
  wire [3:0]m05_couplers_to_axi_cpu_interconnect_WSTRB;
  wire m05_couplers_to_axi_cpu_interconnect_WVALID;
  wire [31:0]m06_couplers_to_axi_cpu_interconnect_ARADDR;
  wire m06_couplers_to_axi_cpu_interconnect_ARREADY;
  wire m06_couplers_to_axi_cpu_interconnect_ARVALID;
  wire [31:0]m06_couplers_to_axi_cpu_interconnect_AWADDR;
  wire m06_couplers_to_axi_cpu_interconnect_AWREADY;
  wire m06_couplers_to_axi_cpu_interconnect_AWVALID;
  wire m06_couplers_to_axi_cpu_interconnect_BREADY;
  wire [1:0]m06_couplers_to_axi_cpu_interconnect_BRESP;
  wire m06_couplers_to_axi_cpu_interconnect_BVALID;
  wire [31:0]m06_couplers_to_axi_cpu_interconnect_RDATA;
  wire m06_couplers_to_axi_cpu_interconnect_RREADY;
  wire [1:0]m06_couplers_to_axi_cpu_interconnect_RRESP;
  wire m06_couplers_to_axi_cpu_interconnect_RVALID;
  wire [31:0]m06_couplers_to_axi_cpu_interconnect_WDATA;
  wire m06_couplers_to_axi_cpu_interconnect_WREADY;
  wire [3:0]m06_couplers_to_axi_cpu_interconnect_WSTRB;
  wire m06_couplers_to_axi_cpu_interconnect_WVALID;
  wire [31:0]m07_couplers_to_axi_cpu_interconnect_ARADDR;
  wire [1:0]m07_couplers_to_axi_cpu_interconnect_ARBURST;
  wire [3:0]m07_couplers_to_axi_cpu_interconnect_ARCACHE;
  wire [7:0]m07_couplers_to_axi_cpu_interconnect_ARLEN;
  wire [0:0]m07_couplers_to_axi_cpu_interconnect_ARLOCK;
  wire [2:0]m07_couplers_to_axi_cpu_interconnect_ARPROT;
  wire [3:0]m07_couplers_to_axi_cpu_interconnect_ARQOS;
  wire m07_couplers_to_axi_cpu_interconnect_ARREADY;
  wire [3:0]m07_couplers_to_axi_cpu_interconnect_ARREGION;
  wire [2:0]m07_couplers_to_axi_cpu_interconnect_ARSIZE;
  wire m07_couplers_to_axi_cpu_interconnect_ARVALID;
  wire [31:0]m07_couplers_to_axi_cpu_interconnect_AWADDR;
  wire [1:0]m07_couplers_to_axi_cpu_interconnect_AWBURST;
  wire [3:0]m07_couplers_to_axi_cpu_interconnect_AWCACHE;
  wire [7:0]m07_couplers_to_axi_cpu_interconnect_AWLEN;
  wire [0:0]m07_couplers_to_axi_cpu_interconnect_AWLOCK;
  wire [2:0]m07_couplers_to_axi_cpu_interconnect_AWPROT;
  wire [3:0]m07_couplers_to_axi_cpu_interconnect_AWQOS;
  wire m07_couplers_to_axi_cpu_interconnect_AWREADY;
  wire [3:0]m07_couplers_to_axi_cpu_interconnect_AWREGION;
  wire [2:0]m07_couplers_to_axi_cpu_interconnect_AWSIZE;
  wire m07_couplers_to_axi_cpu_interconnect_AWVALID;
  wire m07_couplers_to_axi_cpu_interconnect_BREADY;
  wire [1:0]m07_couplers_to_axi_cpu_interconnect_BRESP;
  wire m07_couplers_to_axi_cpu_interconnect_BVALID;
  wire [511:0]m07_couplers_to_axi_cpu_interconnect_RDATA;
  wire m07_couplers_to_axi_cpu_interconnect_RLAST;
  wire m07_couplers_to_axi_cpu_interconnect_RREADY;
  wire [1:0]m07_couplers_to_axi_cpu_interconnect_RRESP;
  wire m07_couplers_to_axi_cpu_interconnect_RVALID;
  wire [511:0]m07_couplers_to_axi_cpu_interconnect_WDATA;
  wire m07_couplers_to_axi_cpu_interconnect_WLAST;
  wire m07_couplers_to_axi_cpu_interconnect_WREADY;
  wire [63:0]m07_couplers_to_axi_cpu_interconnect_WSTRB;
  wire m07_couplers_to_axi_cpu_interconnect_WVALID;
  wire [17:0]m08_couplers_to_axi_cpu_interconnect_ARADDR;
  wire m08_couplers_to_axi_cpu_interconnect_ARREADY;
  wire m08_couplers_to_axi_cpu_interconnect_ARVALID;
  wire [17:0]m08_couplers_to_axi_cpu_interconnect_AWADDR;
  wire m08_couplers_to_axi_cpu_interconnect_AWREADY;
  wire m08_couplers_to_axi_cpu_interconnect_AWVALID;
  wire m08_couplers_to_axi_cpu_interconnect_BREADY;
  wire [1:0]m08_couplers_to_axi_cpu_interconnect_BRESP;
  wire m08_couplers_to_axi_cpu_interconnect_BVALID;
  wire [31:0]m08_couplers_to_axi_cpu_interconnect_RDATA;
  wire m08_couplers_to_axi_cpu_interconnect_RREADY;
  wire [1:0]m08_couplers_to_axi_cpu_interconnect_RRESP;
  wire m08_couplers_to_axi_cpu_interconnect_RVALID;
  wire [31:0]m08_couplers_to_axi_cpu_interconnect_WDATA;
  wire m08_couplers_to_axi_cpu_interconnect_WREADY;
  wire [3:0]m08_couplers_to_axi_cpu_interconnect_WSTRB;
  wire m08_couplers_to_axi_cpu_interconnect_WVALID;
  wire [31:0]m09_couplers_to_axi_cpu_interconnect_ARADDR;
  wire m09_couplers_to_axi_cpu_interconnect_ARREADY;
  wire m09_couplers_to_axi_cpu_interconnect_ARVALID;
  wire [31:0]m09_couplers_to_axi_cpu_interconnect_AWADDR;
  wire m09_couplers_to_axi_cpu_interconnect_AWREADY;
  wire m09_couplers_to_axi_cpu_interconnect_AWVALID;
  wire m09_couplers_to_axi_cpu_interconnect_BREADY;
  wire [1:0]m09_couplers_to_axi_cpu_interconnect_BRESP;
  wire m09_couplers_to_axi_cpu_interconnect_BVALID;
  wire [31:0]m09_couplers_to_axi_cpu_interconnect_RDATA;
  wire m09_couplers_to_axi_cpu_interconnect_RREADY;
  wire [1:0]m09_couplers_to_axi_cpu_interconnect_RRESP;
  wire m09_couplers_to_axi_cpu_interconnect_RVALID;
  wire [31:0]m09_couplers_to_axi_cpu_interconnect_WDATA;
  wire m09_couplers_to_axi_cpu_interconnect_WREADY;
  wire [3:0]m09_couplers_to_axi_cpu_interconnect_WSTRB;
  wire m09_couplers_to_axi_cpu_interconnect_WVALID;
  wire [31:0]m10_couplers_to_axi_cpu_interconnect_ARADDR;
  wire m10_couplers_to_axi_cpu_interconnect_ARREADY;
  wire m10_couplers_to_axi_cpu_interconnect_ARVALID;
  wire [31:0]m10_couplers_to_axi_cpu_interconnect_AWADDR;
  wire m10_couplers_to_axi_cpu_interconnect_AWREADY;
  wire m10_couplers_to_axi_cpu_interconnect_AWVALID;
  wire m10_couplers_to_axi_cpu_interconnect_BREADY;
  wire [1:0]m10_couplers_to_axi_cpu_interconnect_BRESP;
  wire m10_couplers_to_axi_cpu_interconnect_BVALID;
  wire [31:0]m10_couplers_to_axi_cpu_interconnect_RDATA;
  wire m10_couplers_to_axi_cpu_interconnect_RREADY;
  wire [1:0]m10_couplers_to_axi_cpu_interconnect_RRESP;
  wire m10_couplers_to_axi_cpu_interconnect_RVALID;
  wire [31:0]m10_couplers_to_axi_cpu_interconnect_WDATA;
  wire m10_couplers_to_axi_cpu_interconnect_WREADY;
  wire m10_couplers_to_axi_cpu_interconnect_WVALID;
  wire [31:0]m11_couplers_to_axi_cpu_interconnect_ARADDR;
  wire [2:0]m11_couplers_to_axi_cpu_interconnect_ARPROT;
  wire m11_couplers_to_axi_cpu_interconnect_ARREADY;
  wire m11_couplers_to_axi_cpu_interconnect_ARVALID;
  wire [31:0]m11_couplers_to_axi_cpu_interconnect_AWADDR;
  wire [2:0]m11_couplers_to_axi_cpu_interconnect_AWPROT;
  wire m11_couplers_to_axi_cpu_interconnect_AWREADY;
  wire m11_couplers_to_axi_cpu_interconnect_AWVALID;
  wire m11_couplers_to_axi_cpu_interconnect_BREADY;
  wire [1:0]m11_couplers_to_axi_cpu_interconnect_BRESP;
  wire m11_couplers_to_axi_cpu_interconnect_BVALID;
  wire [31:0]m11_couplers_to_axi_cpu_interconnect_RDATA;
  wire m11_couplers_to_axi_cpu_interconnect_RREADY;
  wire [1:0]m11_couplers_to_axi_cpu_interconnect_RRESP;
  wire m11_couplers_to_axi_cpu_interconnect_RVALID;
  wire [31:0]m11_couplers_to_axi_cpu_interconnect_WDATA;
  wire m11_couplers_to_axi_cpu_interconnect_WREADY;
  wire [3:0]m11_couplers_to_axi_cpu_interconnect_WSTRB;
  wire m11_couplers_to_axi_cpu_interconnect_WVALID;
  wire [31:0]m12_couplers_to_axi_cpu_interconnect_ARADDR;
  wire m12_couplers_to_axi_cpu_interconnect_ARREADY;
  wire m12_couplers_to_axi_cpu_interconnect_ARVALID;
  wire [31:0]m12_couplers_to_axi_cpu_interconnect_AWADDR;
  wire m12_couplers_to_axi_cpu_interconnect_AWREADY;
  wire m12_couplers_to_axi_cpu_interconnect_AWVALID;
  wire m12_couplers_to_axi_cpu_interconnect_BREADY;
  wire [1:0]m12_couplers_to_axi_cpu_interconnect_BRESP;
  wire m12_couplers_to_axi_cpu_interconnect_BVALID;
  wire [31:0]m12_couplers_to_axi_cpu_interconnect_RDATA;
  wire m12_couplers_to_axi_cpu_interconnect_RREADY;
  wire [1:0]m12_couplers_to_axi_cpu_interconnect_RRESP;
  wire m12_couplers_to_axi_cpu_interconnect_RVALID;
  wire [31:0]m12_couplers_to_axi_cpu_interconnect_WDATA;
  wire m12_couplers_to_axi_cpu_interconnect_WREADY;
  wire [3:0]m12_couplers_to_axi_cpu_interconnect_WSTRB;
  wire m12_couplers_to_axi_cpu_interconnect_WVALID;
  wire [31:0]m13_couplers_to_axi_cpu_interconnect_ARADDR;
  wire [2:0]m13_couplers_to_axi_cpu_interconnect_ARPROT;
  wire m13_couplers_to_axi_cpu_interconnect_ARREADY;
  wire m13_couplers_to_axi_cpu_interconnect_ARVALID;
  wire [31:0]m13_couplers_to_axi_cpu_interconnect_AWADDR;
  wire [2:0]m13_couplers_to_axi_cpu_interconnect_AWPROT;
  wire m13_couplers_to_axi_cpu_interconnect_AWREADY;
  wire m13_couplers_to_axi_cpu_interconnect_AWVALID;
  wire m13_couplers_to_axi_cpu_interconnect_BREADY;
  wire [1:0]m13_couplers_to_axi_cpu_interconnect_BRESP;
  wire m13_couplers_to_axi_cpu_interconnect_BVALID;
  wire [31:0]m13_couplers_to_axi_cpu_interconnect_RDATA;
  wire m13_couplers_to_axi_cpu_interconnect_RREADY;
  wire [1:0]m13_couplers_to_axi_cpu_interconnect_RRESP;
  wire m13_couplers_to_axi_cpu_interconnect_RVALID;
  wire [31:0]m13_couplers_to_axi_cpu_interconnect_WDATA;
  wire m13_couplers_to_axi_cpu_interconnect_WREADY;
  wire [3:0]m13_couplers_to_axi_cpu_interconnect_WSTRB;
  wire m13_couplers_to_axi_cpu_interconnect_WVALID;
  wire [31:0]m14_couplers_to_axi_cpu_interconnect_ARADDR;
  wire [1:0]m14_couplers_to_axi_cpu_interconnect_ARBURST;
  wire [3:0]m14_couplers_to_axi_cpu_interconnect_ARCACHE;
  wire [7:0]m14_couplers_to_axi_cpu_interconnect_ARLEN;
  wire m14_couplers_to_axi_cpu_interconnect_ARLOCK;
  wire [2:0]m14_couplers_to_axi_cpu_interconnect_ARPROT;
  wire [3:0]m14_couplers_to_axi_cpu_interconnect_ARQOS;
  wire m14_couplers_to_axi_cpu_interconnect_ARREADY;
  wire [3:0]m14_couplers_to_axi_cpu_interconnect_ARREGION;
  wire [2:0]m14_couplers_to_axi_cpu_interconnect_ARSIZE;
  wire m14_couplers_to_axi_cpu_interconnect_ARVALID;
  wire [31:0]m14_couplers_to_axi_cpu_interconnect_AWADDR;
  wire [1:0]m14_couplers_to_axi_cpu_interconnect_AWBURST;
  wire [3:0]m14_couplers_to_axi_cpu_interconnect_AWCACHE;
  wire [7:0]m14_couplers_to_axi_cpu_interconnect_AWLEN;
  wire m14_couplers_to_axi_cpu_interconnect_AWLOCK;
  wire [2:0]m14_couplers_to_axi_cpu_interconnect_AWPROT;
  wire [3:0]m14_couplers_to_axi_cpu_interconnect_AWQOS;
  wire m14_couplers_to_axi_cpu_interconnect_AWREADY;
  wire [3:0]m14_couplers_to_axi_cpu_interconnect_AWREGION;
  wire [2:0]m14_couplers_to_axi_cpu_interconnect_AWSIZE;
  wire m14_couplers_to_axi_cpu_interconnect_AWVALID;
  wire m14_couplers_to_axi_cpu_interconnect_BREADY;
  wire [1:0]m14_couplers_to_axi_cpu_interconnect_BRESP;
  wire m14_couplers_to_axi_cpu_interconnect_BVALID;
  wire [31:0]m14_couplers_to_axi_cpu_interconnect_RDATA;
  wire m14_couplers_to_axi_cpu_interconnect_RLAST;
  wire m14_couplers_to_axi_cpu_interconnect_RREADY;
  wire [1:0]m14_couplers_to_axi_cpu_interconnect_RRESP;
  wire m14_couplers_to_axi_cpu_interconnect_RVALID;
  wire [31:0]m14_couplers_to_axi_cpu_interconnect_WDATA;
  wire m14_couplers_to_axi_cpu_interconnect_WLAST;
  wire m14_couplers_to_axi_cpu_interconnect_WREADY;
  wire [3:0]m14_couplers_to_axi_cpu_interconnect_WSTRB;
  wire m14_couplers_to_axi_cpu_interconnect_WVALID;
  wire [31:0]s00_couplers_to_xbar_ARADDR;
  wire [1:0]s00_couplers_to_xbar_ARBURST;
  wire [3:0]s00_couplers_to_xbar_ARCACHE;
  wire [7:0]s00_couplers_to_xbar_ARLEN;
  wire [0:0]s00_couplers_to_xbar_ARLOCK;
  wire [2:0]s00_couplers_to_xbar_ARPROT;
  wire [3:0]s00_couplers_to_xbar_ARQOS;
  wire [0:0]s00_couplers_to_xbar_ARREADY;
  wire [2:0]s00_couplers_to_xbar_ARSIZE;
  wire s00_couplers_to_xbar_ARVALID;
  wire [31:0]s00_couplers_to_xbar_AWADDR;
  wire [1:0]s00_couplers_to_xbar_AWBURST;
  wire [3:0]s00_couplers_to_xbar_AWCACHE;
  wire [7:0]s00_couplers_to_xbar_AWLEN;
  wire [0:0]s00_couplers_to_xbar_AWLOCK;
  wire [2:0]s00_couplers_to_xbar_AWPROT;
  wire [3:0]s00_couplers_to_xbar_AWQOS;
  wire [0:0]s00_couplers_to_xbar_AWREADY;
  wire [2:0]s00_couplers_to_xbar_AWSIZE;
  wire s00_couplers_to_xbar_AWVALID;
  wire s00_couplers_to_xbar_BREADY;
  wire [1:0]s00_couplers_to_xbar_BRESP;
  wire [0:0]s00_couplers_to_xbar_BVALID;
  wire [511:0]s00_couplers_to_xbar_RDATA;
  wire [0:0]s00_couplers_to_xbar_RLAST;
  wire s00_couplers_to_xbar_RREADY;
  wire [1:0]s00_couplers_to_xbar_RRESP;
  wire [0:0]s00_couplers_to_xbar_RVALID;
  wire [511:0]s00_couplers_to_xbar_WDATA;
  wire s00_couplers_to_xbar_WLAST;
  wire [0:0]s00_couplers_to_xbar_WREADY;
  wire [63:0]s00_couplers_to_xbar_WSTRB;
  wire s00_couplers_to_xbar_WVALID;
  wire [31:0]s01_couplers_to_xbar_ARADDR;
  wire [1:0]s01_couplers_to_xbar_ARBURST;
  wire [3:0]s01_couplers_to_xbar_ARCACHE;
  wire [7:0]s01_couplers_to_xbar_ARLEN;
  wire [0:0]s01_couplers_to_xbar_ARLOCK;
  wire [2:0]s01_couplers_to_xbar_ARPROT;
  wire [3:0]s01_couplers_to_xbar_ARQOS;
  wire [1:1]s01_couplers_to_xbar_ARREADY;
  wire [2:0]s01_couplers_to_xbar_ARSIZE;
  wire s01_couplers_to_xbar_ARVALID;
  wire [31:0]s01_couplers_to_xbar_AWADDR;
  wire [1:0]s01_couplers_to_xbar_AWBURST;
  wire [3:0]s01_couplers_to_xbar_AWCACHE;
  wire [7:0]s01_couplers_to_xbar_AWLEN;
  wire [0:0]s01_couplers_to_xbar_AWLOCK;
  wire [2:0]s01_couplers_to_xbar_AWPROT;
  wire [3:0]s01_couplers_to_xbar_AWQOS;
  wire [1:1]s01_couplers_to_xbar_AWREADY;
  wire [2:0]s01_couplers_to_xbar_AWSIZE;
  wire s01_couplers_to_xbar_AWVALID;
  wire s01_couplers_to_xbar_BREADY;
  wire [3:2]s01_couplers_to_xbar_BRESP;
  wire [1:1]s01_couplers_to_xbar_BVALID;
  wire [1023:512]s01_couplers_to_xbar_RDATA;
  wire [1:1]s01_couplers_to_xbar_RLAST;
  wire s01_couplers_to_xbar_RREADY;
  wire [3:2]s01_couplers_to_xbar_RRESP;
  wire [1:1]s01_couplers_to_xbar_RVALID;
  wire [511:0]s01_couplers_to_xbar_WDATA;
  wire s01_couplers_to_xbar_WLAST;
  wire [1:1]s01_couplers_to_xbar_WREADY;
  wire [63:0]s01_couplers_to_xbar_WSTRB;
  wire s01_couplers_to_xbar_WVALID;
  wire [31:0]s02_couplers_to_xbar_ARADDR;
  wire [1:0]s02_couplers_to_xbar_ARBURST;
  wire [3:0]s02_couplers_to_xbar_ARCACHE;
  wire [7:0]s02_couplers_to_xbar_ARLEN;
  wire [0:0]s02_couplers_to_xbar_ARLOCK;
  wire [2:0]s02_couplers_to_xbar_ARPROT;
  wire [3:0]s02_couplers_to_xbar_ARQOS;
  wire [2:2]s02_couplers_to_xbar_ARREADY;
  wire [2:0]s02_couplers_to_xbar_ARSIZE;
  wire s02_couplers_to_xbar_ARVALID;
  wire [1535:1024]s02_couplers_to_xbar_RDATA;
  wire [2:2]s02_couplers_to_xbar_RLAST;
  wire s02_couplers_to_xbar_RREADY;
  wire [5:4]s02_couplers_to_xbar_RRESP;
  wire [2:2]s02_couplers_to_xbar_RVALID;
  wire [31:0]s03_couplers_to_xbar_AWADDR;
  wire [1:0]s03_couplers_to_xbar_AWBURST;
  wire [3:0]s03_couplers_to_xbar_AWCACHE;
  wire [7:0]s03_couplers_to_xbar_AWLEN;
  wire [0:0]s03_couplers_to_xbar_AWLOCK;
  wire [2:0]s03_couplers_to_xbar_AWPROT;
  wire [3:0]s03_couplers_to_xbar_AWQOS;
  wire [3:3]s03_couplers_to_xbar_AWREADY;
  wire [2:0]s03_couplers_to_xbar_AWSIZE;
  wire s03_couplers_to_xbar_AWVALID;
  wire s03_couplers_to_xbar_BREADY;
  wire [7:6]s03_couplers_to_xbar_BRESP;
  wire [3:3]s03_couplers_to_xbar_BVALID;
  wire [511:0]s03_couplers_to_xbar_WDATA;
  wire s03_couplers_to_xbar_WLAST;
  wire [3:3]s03_couplers_to_xbar_WREADY;
  wire [63:0]s03_couplers_to_xbar_WSTRB;
  wire s03_couplers_to_xbar_WVALID;
  wire [31:0]s04_couplers_to_xbar_ARADDR;
  wire [1:0]s04_couplers_to_xbar_ARBURST;
  wire [3:0]s04_couplers_to_xbar_ARCACHE;
  wire [7:0]s04_couplers_to_xbar_ARLEN;
  wire [0:0]s04_couplers_to_xbar_ARLOCK;
  wire [2:0]s04_couplers_to_xbar_ARPROT;
  wire [3:0]s04_couplers_to_xbar_ARQOS;
  wire [4:4]s04_couplers_to_xbar_ARREADY;
  wire [2:0]s04_couplers_to_xbar_ARSIZE;
  wire s04_couplers_to_xbar_ARVALID;
  wire [2559:2048]s04_couplers_to_xbar_RDATA;
  wire [4:4]s04_couplers_to_xbar_RLAST;
  wire s04_couplers_to_xbar_RREADY;
  wire [9:8]s04_couplers_to_xbar_RRESP;
  wire [4:4]s04_couplers_to_xbar_RVALID;
  wire [31:0]s05_couplers_to_xbar_ARADDR;
  wire [1:0]s05_couplers_to_xbar_ARBURST;
  wire [3:0]s05_couplers_to_xbar_ARCACHE;
  wire [7:0]s05_couplers_to_xbar_ARLEN;
  wire [0:0]s05_couplers_to_xbar_ARLOCK;
  wire [2:0]s05_couplers_to_xbar_ARPROT;
  wire [3:0]s05_couplers_to_xbar_ARQOS;
  wire [5:5]s05_couplers_to_xbar_ARREADY;
  wire [2:0]s05_couplers_to_xbar_ARSIZE;
  wire s05_couplers_to_xbar_ARVALID;
  wire [31:0]s05_couplers_to_xbar_AWADDR;
  wire [1:0]s05_couplers_to_xbar_AWBURST;
  wire [3:0]s05_couplers_to_xbar_AWCACHE;
  wire [7:0]s05_couplers_to_xbar_AWLEN;
  wire [0:0]s05_couplers_to_xbar_AWLOCK;
  wire [2:0]s05_couplers_to_xbar_AWPROT;
  wire [3:0]s05_couplers_to_xbar_AWQOS;
  wire [5:5]s05_couplers_to_xbar_AWREADY;
  wire [2:0]s05_couplers_to_xbar_AWSIZE;
  wire s05_couplers_to_xbar_AWVALID;
  wire s05_couplers_to_xbar_BREADY;
  wire [11:10]s05_couplers_to_xbar_BRESP;
  wire [5:5]s05_couplers_to_xbar_BVALID;
  wire [3071:2560]s05_couplers_to_xbar_RDATA;
  wire [5:5]s05_couplers_to_xbar_RLAST;
  wire s05_couplers_to_xbar_RREADY;
  wire [11:10]s05_couplers_to_xbar_RRESP;
  wire [5:5]s05_couplers_to_xbar_RVALID;
  wire [511:0]s05_couplers_to_xbar_WDATA;
  wire s05_couplers_to_xbar_WLAST;
  wire [5:5]s05_couplers_to_xbar_WREADY;
  wire [63:0]s05_couplers_to_xbar_WSTRB;
  wire s05_couplers_to_xbar_WVALID;
  wire [31:0]s06_couplers_to_xbar_ARADDR;
  wire [1:0]s06_couplers_to_xbar_ARBURST;
  wire [3:0]s06_couplers_to_xbar_ARCACHE;
  wire [7:0]s06_couplers_to_xbar_ARLEN;
  wire [0:0]s06_couplers_to_xbar_ARLOCK;
  wire [2:0]s06_couplers_to_xbar_ARPROT;
  wire [3:0]s06_couplers_to_xbar_ARQOS;
  wire [6:6]s06_couplers_to_xbar_ARREADY;
  wire [2:0]s06_couplers_to_xbar_ARSIZE;
  wire s06_couplers_to_xbar_ARVALID;
  wire [31:0]s06_couplers_to_xbar_AWADDR;
  wire [1:0]s06_couplers_to_xbar_AWBURST;
  wire [3:0]s06_couplers_to_xbar_AWCACHE;
  wire [7:0]s06_couplers_to_xbar_AWLEN;
  wire [0:0]s06_couplers_to_xbar_AWLOCK;
  wire [2:0]s06_couplers_to_xbar_AWPROT;
  wire [3:0]s06_couplers_to_xbar_AWQOS;
  wire [6:6]s06_couplers_to_xbar_AWREADY;
  wire [2:0]s06_couplers_to_xbar_AWSIZE;
  wire s06_couplers_to_xbar_AWVALID;
  wire s06_couplers_to_xbar_BREADY;
  wire [13:12]s06_couplers_to_xbar_BRESP;
  wire [6:6]s06_couplers_to_xbar_BVALID;
  wire [3583:3072]s06_couplers_to_xbar_RDATA;
  wire [6:6]s06_couplers_to_xbar_RLAST;
  wire s06_couplers_to_xbar_RREADY;
  wire [13:12]s06_couplers_to_xbar_RRESP;
  wire [6:6]s06_couplers_to_xbar_RVALID;
  wire [511:0]s06_couplers_to_xbar_WDATA;
  wire s06_couplers_to_xbar_WLAST;
  wire [6:6]s06_couplers_to_xbar_WREADY;
  wire [63:0]s06_couplers_to_xbar_WSTRB;
  wire s06_couplers_to_xbar_WVALID;
  wire [31:0]xbar_to_m00_couplers_ARADDR;
  wire [1:0]xbar_to_m00_couplers_ARBURST;
  wire [3:0]xbar_to_m00_couplers_ARCACHE;
  wire [7:0]xbar_to_m00_couplers_ARLEN;
  wire [0:0]xbar_to_m00_couplers_ARLOCK;
  wire [2:0]xbar_to_m00_couplers_ARPROT;
  wire [3:0]xbar_to_m00_couplers_ARQOS;
  wire xbar_to_m00_couplers_ARREADY;
  wire [3:0]xbar_to_m00_couplers_ARREGION;
  wire [2:0]xbar_to_m00_couplers_ARSIZE;
  wire [0:0]xbar_to_m00_couplers_ARVALID;
  wire [31:0]xbar_to_m00_couplers_AWADDR;
  wire [1:0]xbar_to_m00_couplers_AWBURST;
  wire [3:0]xbar_to_m00_couplers_AWCACHE;
  wire [7:0]xbar_to_m00_couplers_AWLEN;
  wire [0:0]xbar_to_m00_couplers_AWLOCK;
  wire [2:0]xbar_to_m00_couplers_AWPROT;
  wire [3:0]xbar_to_m00_couplers_AWQOS;
  wire xbar_to_m00_couplers_AWREADY;
  wire [3:0]xbar_to_m00_couplers_AWREGION;
  wire [2:0]xbar_to_m00_couplers_AWSIZE;
  wire [0:0]xbar_to_m00_couplers_AWVALID;
  wire [0:0]xbar_to_m00_couplers_BREADY;
  wire [1:0]xbar_to_m00_couplers_BRESP;
  wire xbar_to_m00_couplers_BVALID;
  wire [511:0]xbar_to_m00_couplers_RDATA;
  wire xbar_to_m00_couplers_RLAST;
  wire [0:0]xbar_to_m00_couplers_RREADY;
  wire [1:0]xbar_to_m00_couplers_RRESP;
  wire xbar_to_m00_couplers_RVALID;
  wire [511:0]xbar_to_m00_couplers_WDATA;
  wire [0:0]xbar_to_m00_couplers_WLAST;
  wire xbar_to_m00_couplers_WREADY;
  wire [63:0]xbar_to_m00_couplers_WSTRB;
  wire [0:0]xbar_to_m00_couplers_WVALID;
  wire [63:32]xbar_to_m01_couplers_ARADDR;
  wire [3:2]xbar_to_m01_couplers_ARBURST;
  wire [7:4]xbar_to_m01_couplers_ARCACHE;
  wire [15:8]xbar_to_m01_couplers_ARLEN;
  wire [1:1]xbar_to_m01_couplers_ARLOCK;
  wire [5:3]xbar_to_m01_couplers_ARPROT;
  wire [7:4]xbar_to_m01_couplers_ARQOS;
  wire xbar_to_m01_couplers_ARREADY;
  wire [7:4]xbar_to_m01_couplers_ARREGION;
  wire [5:3]xbar_to_m01_couplers_ARSIZE;
  wire [1:1]xbar_to_m01_couplers_ARVALID;
  wire [63:32]xbar_to_m01_couplers_AWADDR;
  wire [3:2]xbar_to_m01_couplers_AWBURST;
  wire [7:4]xbar_to_m01_couplers_AWCACHE;
  wire [15:8]xbar_to_m01_couplers_AWLEN;
  wire [1:1]xbar_to_m01_couplers_AWLOCK;
  wire [5:3]xbar_to_m01_couplers_AWPROT;
  wire [7:4]xbar_to_m01_couplers_AWQOS;
  wire xbar_to_m01_couplers_AWREADY;
  wire [7:4]xbar_to_m01_couplers_AWREGION;
  wire [5:3]xbar_to_m01_couplers_AWSIZE;
  wire [1:1]xbar_to_m01_couplers_AWVALID;
  wire [1:1]xbar_to_m01_couplers_BREADY;
  wire [1:0]xbar_to_m01_couplers_BRESP;
  wire xbar_to_m01_couplers_BVALID;
  wire [511:0]xbar_to_m01_couplers_RDATA;
  wire xbar_to_m01_couplers_RLAST;
  wire [1:1]xbar_to_m01_couplers_RREADY;
  wire [1:0]xbar_to_m01_couplers_RRESP;
  wire xbar_to_m01_couplers_RVALID;
  wire [1023:512]xbar_to_m01_couplers_WDATA;
  wire [1:1]xbar_to_m01_couplers_WLAST;
  wire xbar_to_m01_couplers_WREADY;
  wire [127:64]xbar_to_m01_couplers_WSTRB;
  wire [1:1]xbar_to_m01_couplers_WVALID;
  wire [95:64]xbar_to_m02_couplers_ARADDR;
  wire [5:4]xbar_to_m02_couplers_ARBURST;
  wire [11:8]xbar_to_m02_couplers_ARCACHE;
  wire [23:16]xbar_to_m02_couplers_ARLEN;
  wire [2:2]xbar_to_m02_couplers_ARLOCK;
  wire [8:6]xbar_to_m02_couplers_ARPROT;
  wire [11:8]xbar_to_m02_couplers_ARQOS;
  wire xbar_to_m02_couplers_ARREADY;
  wire [11:8]xbar_to_m02_couplers_ARREGION;
  wire [8:6]xbar_to_m02_couplers_ARSIZE;
  wire [2:2]xbar_to_m02_couplers_ARVALID;
  wire [95:64]xbar_to_m02_couplers_AWADDR;
  wire [5:4]xbar_to_m02_couplers_AWBURST;
  wire [11:8]xbar_to_m02_couplers_AWCACHE;
  wire [23:16]xbar_to_m02_couplers_AWLEN;
  wire [2:2]xbar_to_m02_couplers_AWLOCK;
  wire [8:6]xbar_to_m02_couplers_AWPROT;
  wire [11:8]xbar_to_m02_couplers_AWQOS;
  wire xbar_to_m02_couplers_AWREADY;
  wire [11:8]xbar_to_m02_couplers_AWREGION;
  wire [8:6]xbar_to_m02_couplers_AWSIZE;
  wire [2:2]xbar_to_m02_couplers_AWVALID;
  wire [2:2]xbar_to_m02_couplers_BREADY;
  wire [1:0]xbar_to_m02_couplers_BRESP;
  wire xbar_to_m02_couplers_BVALID;
  wire [511:0]xbar_to_m02_couplers_RDATA;
  wire xbar_to_m02_couplers_RLAST;
  wire [2:2]xbar_to_m02_couplers_RREADY;
  wire [1:0]xbar_to_m02_couplers_RRESP;
  wire xbar_to_m02_couplers_RVALID;
  wire [1535:1024]xbar_to_m02_couplers_WDATA;
  wire [2:2]xbar_to_m02_couplers_WLAST;
  wire xbar_to_m02_couplers_WREADY;
  wire [191:128]xbar_to_m02_couplers_WSTRB;
  wire [2:2]xbar_to_m02_couplers_WVALID;
  wire [127:96]xbar_to_m03_couplers_ARADDR;
  wire [7:6]xbar_to_m03_couplers_ARBURST;
  wire [15:12]xbar_to_m03_couplers_ARCACHE;
  wire [31:24]xbar_to_m03_couplers_ARLEN;
  wire [3:3]xbar_to_m03_couplers_ARLOCK;
  wire [11:9]xbar_to_m03_couplers_ARPROT;
  wire [15:12]xbar_to_m03_couplers_ARQOS;
  wire xbar_to_m03_couplers_ARREADY;
  wire [15:12]xbar_to_m03_couplers_ARREGION;
  wire [11:9]xbar_to_m03_couplers_ARSIZE;
  wire [3:3]xbar_to_m03_couplers_ARVALID;
  wire [127:96]xbar_to_m03_couplers_AWADDR;
  wire [7:6]xbar_to_m03_couplers_AWBURST;
  wire [15:12]xbar_to_m03_couplers_AWCACHE;
  wire [31:24]xbar_to_m03_couplers_AWLEN;
  wire [3:3]xbar_to_m03_couplers_AWLOCK;
  wire [11:9]xbar_to_m03_couplers_AWPROT;
  wire [15:12]xbar_to_m03_couplers_AWQOS;
  wire xbar_to_m03_couplers_AWREADY;
  wire [15:12]xbar_to_m03_couplers_AWREGION;
  wire [11:9]xbar_to_m03_couplers_AWSIZE;
  wire [3:3]xbar_to_m03_couplers_AWVALID;
  wire [3:3]xbar_to_m03_couplers_BREADY;
  wire [1:0]xbar_to_m03_couplers_BRESP;
  wire xbar_to_m03_couplers_BVALID;
  wire [511:0]xbar_to_m03_couplers_RDATA;
  wire xbar_to_m03_couplers_RLAST;
  wire [3:3]xbar_to_m03_couplers_RREADY;
  wire [1:0]xbar_to_m03_couplers_RRESP;
  wire xbar_to_m03_couplers_RVALID;
  wire [2047:1536]xbar_to_m03_couplers_WDATA;
  wire [3:3]xbar_to_m03_couplers_WLAST;
  wire xbar_to_m03_couplers_WREADY;
  wire [255:192]xbar_to_m03_couplers_WSTRB;
  wire [3:3]xbar_to_m03_couplers_WVALID;
  wire [159:128]xbar_to_m04_couplers_ARADDR;
  wire [9:8]xbar_to_m04_couplers_ARBURST;
  wire [19:16]xbar_to_m04_couplers_ARCACHE;
  wire [39:32]xbar_to_m04_couplers_ARLEN;
  wire [4:4]xbar_to_m04_couplers_ARLOCK;
  wire [14:12]xbar_to_m04_couplers_ARPROT;
  wire [19:16]xbar_to_m04_couplers_ARQOS;
  wire xbar_to_m04_couplers_ARREADY;
  wire [19:16]xbar_to_m04_couplers_ARREGION;
  wire [14:12]xbar_to_m04_couplers_ARSIZE;
  wire [4:4]xbar_to_m04_couplers_ARVALID;
  wire [159:128]xbar_to_m04_couplers_AWADDR;
  wire [9:8]xbar_to_m04_couplers_AWBURST;
  wire [19:16]xbar_to_m04_couplers_AWCACHE;
  wire [39:32]xbar_to_m04_couplers_AWLEN;
  wire [4:4]xbar_to_m04_couplers_AWLOCK;
  wire [14:12]xbar_to_m04_couplers_AWPROT;
  wire [19:16]xbar_to_m04_couplers_AWQOS;
  wire xbar_to_m04_couplers_AWREADY;
  wire [19:16]xbar_to_m04_couplers_AWREGION;
  wire [14:12]xbar_to_m04_couplers_AWSIZE;
  wire [4:4]xbar_to_m04_couplers_AWVALID;
  wire [4:4]xbar_to_m04_couplers_BREADY;
  wire [1:0]xbar_to_m04_couplers_BRESP;
  wire xbar_to_m04_couplers_BVALID;
  wire [511:0]xbar_to_m04_couplers_RDATA;
  wire xbar_to_m04_couplers_RLAST;
  wire [4:4]xbar_to_m04_couplers_RREADY;
  wire [1:0]xbar_to_m04_couplers_RRESP;
  wire xbar_to_m04_couplers_RVALID;
  wire [2559:2048]xbar_to_m04_couplers_WDATA;
  wire [4:4]xbar_to_m04_couplers_WLAST;
  wire xbar_to_m04_couplers_WREADY;
  wire [319:256]xbar_to_m04_couplers_WSTRB;
  wire [4:4]xbar_to_m04_couplers_WVALID;
  wire [191:160]xbar_to_m05_couplers_ARADDR;
  wire [11:10]xbar_to_m05_couplers_ARBURST;
  wire [23:20]xbar_to_m05_couplers_ARCACHE;
  wire [47:40]xbar_to_m05_couplers_ARLEN;
  wire [5:5]xbar_to_m05_couplers_ARLOCK;
  wire [17:15]xbar_to_m05_couplers_ARPROT;
  wire [23:20]xbar_to_m05_couplers_ARQOS;
  wire xbar_to_m05_couplers_ARREADY;
  wire [23:20]xbar_to_m05_couplers_ARREGION;
  wire [17:15]xbar_to_m05_couplers_ARSIZE;
  wire [5:5]xbar_to_m05_couplers_ARVALID;
  wire [191:160]xbar_to_m05_couplers_AWADDR;
  wire [11:10]xbar_to_m05_couplers_AWBURST;
  wire [23:20]xbar_to_m05_couplers_AWCACHE;
  wire [47:40]xbar_to_m05_couplers_AWLEN;
  wire [5:5]xbar_to_m05_couplers_AWLOCK;
  wire [17:15]xbar_to_m05_couplers_AWPROT;
  wire [23:20]xbar_to_m05_couplers_AWQOS;
  wire xbar_to_m05_couplers_AWREADY;
  wire [23:20]xbar_to_m05_couplers_AWREGION;
  wire [17:15]xbar_to_m05_couplers_AWSIZE;
  wire [5:5]xbar_to_m05_couplers_AWVALID;
  wire [5:5]xbar_to_m05_couplers_BREADY;
  wire [1:0]xbar_to_m05_couplers_BRESP;
  wire xbar_to_m05_couplers_BVALID;
  wire [511:0]xbar_to_m05_couplers_RDATA;
  wire xbar_to_m05_couplers_RLAST;
  wire [5:5]xbar_to_m05_couplers_RREADY;
  wire [1:0]xbar_to_m05_couplers_RRESP;
  wire xbar_to_m05_couplers_RVALID;
  wire [3071:2560]xbar_to_m05_couplers_WDATA;
  wire [5:5]xbar_to_m05_couplers_WLAST;
  wire xbar_to_m05_couplers_WREADY;
  wire [383:320]xbar_to_m05_couplers_WSTRB;
  wire [5:5]xbar_to_m05_couplers_WVALID;
  wire [223:192]xbar_to_m06_couplers_ARADDR;
  wire [13:12]xbar_to_m06_couplers_ARBURST;
  wire [27:24]xbar_to_m06_couplers_ARCACHE;
  wire [55:48]xbar_to_m06_couplers_ARLEN;
  wire [6:6]xbar_to_m06_couplers_ARLOCK;
  wire [20:18]xbar_to_m06_couplers_ARPROT;
  wire [27:24]xbar_to_m06_couplers_ARQOS;
  wire xbar_to_m06_couplers_ARREADY;
  wire [27:24]xbar_to_m06_couplers_ARREGION;
  wire [20:18]xbar_to_m06_couplers_ARSIZE;
  wire [6:6]xbar_to_m06_couplers_ARVALID;
  wire [223:192]xbar_to_m06_couplers_AWADDR;
  wire [13:12]xbar_to_m06_couplers_AWBURST;
  wire [27:24]xbar_to_m06_couplers_AWCACHE;
  wire [55:48]xbar_to_m06_couplers_AWLEN;
  wire [6:6]xbar_to_m06_couplers_AWLOCK;
  wire [20:18]xbar_to_m06_couplers_AWPROT;
  wire [27:24]xbar_to_m06_couplers_AWQOS;
  wire xbar_to_m06_couplers_AWREADY;
  wire [27:24]xbar_to_m06_couplers_AWREGION;
  wire [20:18]xbar_to_m06_couplers_AWSIZE;
  wire [6:6]xbar_to_m06_couplers_AWVALID;
  wire [6:6]xbar_to_m06_couplers_BREADY;
  wire [1:0]xbar_to_m06_couplers_BRESP;
  wire xbar_to_m06_couplers_BVALID;
  wire [511:0]xbar_to_m06_couplers_RDATA;
  wire xbar_to_m06_couplers_RLAST;
  wire [6:6]xbar_to_m06_couplers_RREADY;
  wire [1:0]xbar_to_m06_couplers_RRESP;
  wire xbar_to_m06_couplers_RVALID;
  wire [3583:3072]xbar_to_m06_couplers_WDATA;
  wire [6:6]xbar_to_m06_couplers_WLAST;
  wire xbar_to_m06_couplers_WREADY;
  wire [447:384]xbar_to_m06_couplers_WSTRB;
  wire [6:6]xbar_to_m06_couplers_WVALID;
  wire [255:224]xbar_to_m07_couplers_ARADDR;
  wire [15:14]xbar_to_m07_couplers_ARBURST;
  wire [31:28]xbar_to_m07_couplers_ARCACHE;
  wire [63:56]xbar_to_m07_couplers_ARLEN;
  wire [7:7]xbar_to_m07_couplers_ARLOCK;
  wire [23:21]xbar_to_m07_couplers_ARPROT;
  wire [31:28]xbar_to_m07_couplers_ARQOS;
  wire xbar_to_m07_couplers_ARREADY;
  wire [31:28]xbar_to_m07_couplers_ARREGION;
  wire [23:21]xbar_to_m07_couplers_ARSIZE;
  wire [7:7]xbar_to_m07_couplers_ARVALID;
  wire [255:224]xbar_to_m07_couplers_AWADDR;
  wire [15:14]xbar_to_m07_couplers_AWBURST;
  wire [31:28]xbar_to_m07_couplers_AWCACHE;
  wire [63:56]xbar_to_m07_couplers_AWLEN;
  wire [7:7]xbar_to_m07_couplers_AWLOCK;
  wire [23:21]xbar_to_m07_couplers_AWPROT;
  wire [31:28]xbar_to_m07_couplers_AWQOS;
  wire xbar_to_m07_couplers_AWREADY;
  wire [31:28]xbar_to_m07_couplers_AWREGION;
  wire [23:21]xbar_to_m07_couplers_AWSIZE;
  wire [7:7]xbar_to_m07_couplers_AWVALID;
  wire [7:7]xbar_to_m07_couplers_BREADY;
  wire [1:0]xbar_to_m07_couplers_BRESP;
  wire xbar_to_m07_couplers_BVALID;
  wire [511:0]xbar_to_m07_couplers_RDATA;
  wire xbar_to_m07_couplers_RLAST;
  wire [7:7]xbar_to_m07_couplers_RREADY;
  wire [1:0]xbar_to_m07_couplers_RRESP;
  wire xbar_to_m07_couplers_RVALID;
  wire [4095:3584]xbar_to_m07_couplers_WDATA;
  wire [7:7]xbar_to_m07_couplers_WLAST;
  wire xbar_to_m07_couplers_WREADY;
  wire [511:448]xbar_to_m07_couplers_WSTRB;
  wire [7:7]xbar_to_m07_couplers_WVALID;
  wire [287:256]xbar_to_m08_couplers_ARADDR;
  wire [17:16]xbar_to_m08_couplers_ARBURST;
  wire [35:32]xbar_to_m08_couplers_ARCACHE;
  wire [71:64]xbar_to_m08_couplers_ARLEN;
  wire [8:8]xbar_to_m08_couplers_ARLOCK;
  wire [26:24]xbar_to_m08_couplers_ARPROT;
  wire [35:32]xbar_to_m08_couplers_ARQOS;
  wire xbar_to_m08_couplers_ARREADY;
  wire [35:32]xbar_to_m08_couplers_ARREGION;
  wire [26:24]xbar_to_m08_couplers_ARSIZE;
  wire [8:8]xbar_to_m08_couplers_ARVALID;
  wire [287:256]xbar_to_m08_couplers_AWADDR;
  wire [17:16]xbar_to_m08_couplers_AWBURST;
  wire [35:32]xbar_to_m08_couplers_AWCACHE;
  wire [71:64]xbar_to_m08_couplers_AWLEN;
  wire [8:8]xbar_to_m08_couplers_AWLOCK;
  wire [26:24]xbar_to_m08_couplers_AWPROT;
  wire [35:32]xbar_to_m08_couplers_AWQOS;
  wire xbar_to_m08_couplers_AWREADY;
  wire [35:32]xbar_to_m08_couplers_AWREGION;
  wire [26:24]xbar_to_m08_couplers_AWSIZE;
  wire [8:8]xbar_to_m08_couplers_AWVALID;
  wire [8:8]xbar_to_m08_couplers_BREADY;
  wire [1:0]xbar_to_m08_couplers_BRESP;
  wire xbar_to_m08_couplers_BVALID;
  wire [511:0]xbar_to_m08_couplers_RDATA;
  wire xbar_to_m08_couplers_RLAST;
  wire [8:8]xbar_to_m08_couplers_RREADY;
  wire [1:0]xbar_to_m08_couplers_RRESP;
  wire xbar_to_m08_couplers_RVALID;
  wire [4607:4096]xbar_to_m08_couplers_WDATA;
  wire [8:8]xbar_to_m08_couplers_WLAST;
  wire xbar_to_m08_couplers_WREADY;
  wire [575:512]xbar_to_m08_couplers_WSTRB;
  wire [8:8]xbar_to_m08_couplers_WVALID;
  wire [319:288]xbar_to_m09_couplers_ARADDR;
  wire [19:18]xbar_to_m09_couplers_ARBURST;
  wire [39:36]xbar_to_m09_couplers_ARCACHE;
  wire [79:72]xbar_to_m09_couplers_ARLEN;
  wire [9:9]xbar_to_m09_couplers_ARLOCK;
  wire [29:27]xbar_to_m09_couplers_ARPROT;
  wire [39:36]xbar_to_m09_couplers_ARQOS;
  wire xbar_to_m09_couplers_ARREADY;
  wire [39:36]xbar_to_m09_couplers_ARREGION;
  wire [29:27]xbar_to_m09_couplers_ARSIZE;
  wire [9:9]xbar_to_m09_couplers_ARVALID;
  wire [319:288]xbar_to_m09_couplers_AWADDR;
  wire [19:18]xbar_to_m09_couplers_AWBURST;
  wire [39:36]xbar_to_m09_couplers_AWCACHE;
  wire [79:72]xbar_to_m09_couplers_AWLEN;
  wire [9:9]xbar_to_m09_couplers_AWLOCK;
  wire [29:27]xbar_to_m09_couplers_AWPROT;
  wire [39:36]xbar_to_m09_couplers_AWQOS;
  wire xbar_to_m09_couplers_AWREADY;
  wire [39:36]xbar_to_m09_couplers_AWREGION;
  wire [29:27]xbar_to_m09_couplers_AWSIZE;
  wire [9:9]xbar_to_m09_couplers_AWVALID;
  wire [9:9]xbar_to_m09_couplers_BREADY;
  wire [1:0]xbar_to_m09_couplers_BRESP;
  wire xbar_to_m09_couplers_BVALID;
  wire [511:0]xbar_to_m09_couplers_RDATA;
  wire xbar_to_m09_couplers_RLAST;
  wire [9:9]xbar_to_m09_couplers_RREADY;
  wire [1:0]xbar_to_m09_couplers_RRESP;
  wire xbar_to_m09_couplers_RVALID;
  wire [5119:4608]xbar_to_m09_couplers_WDATA;
  wire [9:9]xbar_to_m09_couplers_WLAST;
  wire xbar_to_m09_couplers_WREADY;
  wire [639:576]xbar_to_m09_couplers_WSTRB;
  wire [9:9]xbar_to_m09_couplers_WVALID;
  wire [351:320]xbar_to_m10_couplers_ARADDR;
  wire [21:20]xbar_to_m10_couplers_ARBURST;
  wire [43:40]xbar_to_m10_couplers_ARCACHE;
  wire [87:80]xbar_to_m10_couplers_ARLEN;
  wire [10:10]xbar_to_m10_couplers_ARLOCK;
  wire [32:30]xbar_to_m10_couplers_ARPROT;
  wire [43:40]xbar_to_m10_couplers_ARQOS;
  wire xbar_to_m10_couplers_ARREADY;
  wire [43:40]xbar_to_m10_couplers_ARREGION;
  wire [32:30]xbar_to_m10_couplers_ARSIZE;
  wire [10:10]xbar_to_m10_couplers_ARVALID;
  wire [351:320]xbar_to_m10_couplers_AWADDR;
  wire [21:20]xbar_to_m10_couplers_AWBURST;
  wire [43:40]xbar_to_m10_couplers_AWCACHE;
  wire [87:80]xbar_to_m10_couplers_AWLEN;
  wire [10:10]xbar_to_m10_couplers_AWLOCK;
  wire [32:30]xbar_to_m10_couplers_AWPROT;
  wire [43:40]xbar_to_m10_couplers_AWQOS;
  wire xbar_to_m10_couplers_AWREADY;
  wire [43:40]xbar_to_m10_couplers_AWREGION;
  wire [32:30]xbar_to_m10_couplers_AWSIZE;
  wire [10:10]xbar_to_m10_couplers_AWVALID;
  wire [10:10]xbar_to_m10_couplers_BREADY;
  wire [1:0]xbar_to_m10_couplers_BRESP;
  wire xbar_to_m10_couplers_BVALID;
  wire [511:0]xbar_to_m10_couplers_RDATA;
  wire xbar_to_m10_couplers_RLAST;
  wire [10:10]xbar_to_m10_couplers_RREADY;
  wire [1:0]xbar_to_m10_couplers_RRESP;
  wire xbar_to_m10_couplers_RVALID;
  wire [5631:5120]xbar_to_m10_couplers_WDATA;
  wire [10:10]xbar_to_m10_couplers_WLAST;
  wire xbar_to_m10_couplers_WREADY;
  wire [703:640]xbar_to_m10_couplers_WSTRB;
  wire [10:10]xbar_to_m10_couplers_WVALID;
  wire [383:352]xbar_to_m11_couplers_ARADDR;
  wire [23:22]xbar_to_m11_couplers_ARBURST;
  wire [47:44]xbar_to_m11_couplers_ARCACHE;
  wire [95:88]xbar_to_m11_couplers_ARLEN;
  wire [11:11]xbar_to_m11_couplers_ARLOCK;
  wire [35:33]xbar_to_m11_couplers_ARPROT;
  wire [47:44]xbar_to_m11_couplers_ARQOS;
  wire xbar_to_m11_couplers_ARREADY;
  wire [47:44]xbar_to_m11_couplers_ARREGION;
  wire [35:33]xbar_to_m11_couplers_ARSIZE;
  wire [11:11]xbar_to_m11_couplers_ARVALID;
  wire [383:352]xbar_to_m11_couplers_AWADDR;
  wire [23:22]xbar_to_m11_couplers_AWBURST;
  wire [47:44]xbar_to_m11_couplers_AWCACHE;
  wire [95:88]xbar_to_m11_couplers_AWLEN;
  wire [11:11]xbar_to_m11_couplers_AWLOCK;
  wire [35:33]xbar_to_m11_couplers_AWPROT;
  wire [47:44]xbar_to_m11_couplers_AWQOS;
  wire xbar_to_m11_couplers_AWREADY;
  wire [47:44]xbar_to_m11_couplers_AWREGION;
  wire [35:33]xbar_to_m11_couplers_AWSIZE;
  wire [11:11]xbar_to_m11_couplers_AWVALID;
  wire [11:11]xbar_to_m11_couplers_BREADY;
  wire [1:0]xbar_to_m11_couplers_BRESP;
  wire xbar_to_m11_couplers_BVALID;
  wire [511:0]xbar_to_m11_couplers_RDATA;
  wire xbar_to_m11_couplers_RLAST;
  wire [11:11]xbar_to_m11_couplers_RREADY;
  wire [1:0]xbar_to_m11_couplers_RRESP;
  wire xbar_to_m11_couplers_RVALID;
  wire [6143:5632]xbar_to_m11_couplers_WDATA;
  wire [11:11]xbar_to_m11_couplers_WLAST;
  wire xbar_to_m11_couplers_WREADY;
  wire [767:704]xbar_to_m11_couplers_WSTRB;
  wire [11:11]xbar_to_m11_couplers_WVALID;
  wire [415:384]xbar_to_m12_couplers_ARADDR;
  wire [25:24]xbar_to_m12_couplers_ARBURST;
  wire [51:48]xbar_to_m12_couplers_ARCACHE;
  wire [103:96]xbar_to_m12_couplers_ARLEN;
  wire [12:12]xbar_to_m12_couplers_ARLOCK;
  wire [38:36]xbar_to_m12_couplers_ARPROT;
  wire [51:48]xbar_to_m12_couplers_ARQOS;
  wire xbar_to_m12_couplers_ARREADY;
  wire [51:48]xbar_to_m12_couplers_ARREGION;
  wire [38:36]xbar_to_m12_couplers_ARSIZE;
  wire [12:12]xbar_to_m12_couplers_ARVALID;
  wire [415:384]xbar_to_m12_couplers_AWADDR;
  wire [25:24]xbar_to_m12_couplers_AWBURST;
  wire [51:48]xbar_to_m12_couplers_AWCACHE;
  wire [103:96]xbar_to_m12_couplers_AWLEN;
  wire [12:12]xbar_to_m12_couplers_AWLOCK;
  wire [38:36]xbar_to_m12_couplers_AWPROT;
  wire [51:48]xbar_to_m12_couplers_AWQOS;
  wire xbar_to_m12_couplers_AWREADY;
  wire [51:48]xbar_to_m12_couplers_AWREGION;
  wire [38:36]xbar_to_m12_couplers_AWSIZE;
  wire [12:12]xbar_to_m12_couplers_AWVALID;
  wire [12:12]xbar_to_m12_couplers_BREADY;
  wire [1:0]xbar_to_m12_couplers_BRESP;
  wire xbar_to_m12_couplers_BVALID;
  wire [511:0]xbar_to_m12_couplers_RDATA;
  wire xbar_to_m12_couplers_RLAST;
  wire [12:12]xbar_to_m12_couplers_RREADY;
  wire [1:0]xbar_to_m12_couplers_RRESP;
  wire xbar_to_m12_couplers_RVALID;
  wire [6655:6144]xbar_to_m12_couplers_WDATA;
  wire [12:12]xbar_to_m12_couplers_WLAST;
  wire xbar_to_m12_couplers_WREADY;
  wire [831:768]xbar_to_m12_couplers_WSTRB;
  wire [12:12]xbar_to_m12_couplers_WVALID;
  wire [447:416]xbar_to_m13_couplers_ARADDR;
  wire [27:26]xbar_to_m13_couplers_ARBURST;
  wire [55:52]xbar_to_m13_couplers_ARCACHE;
  wire [111:104]xbar_to_m13_couplers_ARLEN;
  wire [13:13]xbar_to_m13_couplers_ARLOCK;
  wire [41:39]xbar_to_m13_couplers_ARPROT;
  wire [55:52]xbar_to_m13_couplers_ARQOS;
  wire xbar_to_m13_couplers_ARREADY;
  wire [55:52]xbar_to_m13_couplers_ARREGION;
  wire [41:39]xbar_to_m13_couplers_ARSIZE;
  wire [13:13]xbar_to_m13_couplers_ARVALID;
  wire [447:416]xbar_to_m13_couplers_AWADDR;
  wire [27:26]xbar_to_m13_couplers_AWBURST;
  wire [55:52]xbar_to_m13_couplers_AWCACHE;
  wire [111:104]xbar_to_m13_couplers_AWLEN;
  wire [13:13]xbar_to_m13_couplers_AWLOCK;
  wire [41:39]xbar_to_m13_couplers_AWPROT;
  wire [55:52]xbar_to_m13_couplers_AWQOS;
  wire xbar_to_m13_couplers_AWREADY;
  wire [55:52]xbar_to_m13_couplers_AWREGION;
  wire [41:39]xbar_to_m13_couplers_AWSIZE;
  wire [13:13]xbar_to_m13_couplers_AWVALID;
  wire [13:13]xbar_to_m13_couplers_BREADY;
  wire [1:0]xbar_to_m13_couplers_BRESP;
  wire xbar_to_m13_couplers_BVALID;
  wire [511:0]xbar_to_m13_couplers_RDATA;
  wire xbar_to_m13_couplers_RLAST;
  wire [13:13]xbar_to_m13_couplers_RREADY;
  wire [1:0]xbar_to_m13_couplers_RRESP;
  wire xbar_to_m13_couplers_RVALID;
  wire [7167:6656]xbar_to_m13_couplers_WDATA;
  wire [13:13]xbar_to_m13_couplers_WLAST;
  wire xbar_to_m13_couplers_WREADY;
  wire [895:832]xbar_to_m13_couplers_WSTRB;
  wire [13:13]xbar_to_m13_couplers_WVALID;
  wire [479:448]xbar_to_m14_couplers_ARADDR;
  wire [29:28]xbar_to_m14_couplers_ARBURST;
  wire [59:56]xbar_to_m14_couplers_ARCACHE;
  wire [119:112]xbar_to_m14_couplers_ARLEN;
  wire [14:14]xbar_to_m14_couplers_ARLOCK;
  wire [44:42]xbar_to_m14_couplers_ARPROT;
  wire [59:56]xbar_to_m14_couplers_ARQOS;
  wire xbar_to_m14_couplers_ARREADY;
  wire [59:56]xbar_to_m14_couplers_ARREGION;
  wire [44:42]xbar_to_m14_couplers_ARSIZE;
  wire [14:14]xbar_to_m14_couplers_ARVALID;
  wire [479:448]xbar_to_m14_couplers_AWADDR;
  wire [29:28]xbar_to_m14_couplers_AWBURST;
  wire [59:56]xbar_to_m14_couplers_AWCACHE;
  wire [119:112]xbar_to_m14_couplers_AWLEN;
  wire [14:14]xbar_to_m14_couplers_AWLOCK;
  wire [44:42]xbar_to_m14_couplers_AWPROT;
  wire [59:56]xbar_to_m14_couplers_AWQOS;
  wire xbar_to_m14_couplers_AWREADY;
  wire [59:56]xbar_to_m14_couplers_AWREGION;
  wire [44:42]xbar_to_m14_couplers_AWSIZE;
  wire [14:14]xbar_to_m14_couplers_AWVALID;
  wire [14:14]xbar_to_m14_couplers_BREADY;
  wire [1:0]xbar_to_m14_couplers_BRESP;
  wire xbar_to_m14_couplers_BVALID;
  wire [511:0]xbar_to_m14_couplers_RDATA;
  wire xbar_to_m14_couplers_RLAST;
  wire [14:14]xbar_to_m14_couplers_RREADY;
  wire [1:0]xbar_to_m14_couplers_RRESP;
  wire xbar_to_m14_couplers_RVALID;
  wire [7679:7168]xbar_to_m14_couplers_WDATA;
  wire [14:14]xbar_to_m14_couplers_WLAST;
  wire xbar_to_m14_couplers_WREADY;
  wire [959:896]xbar_to_m14_couplers_WSTRB;
  wire [14:14]xbar_to_m14_couplers_WVALID;
  wire [6:0]NLW_xbar_s_axi_arready_UNCONNECTED;
  wire [6:0]NLW_xbar_s_axi_awready_UNCONNECTED;
  wire [13:0]NLW_xbar_s_axi_bresp_UNCONNECTED;
  wire [6:0]NLW_xbar_s_axi_bvalid_UNCONNECTED;
  wire [3583:0]NLW_xbar_s_axi_rdata_UNCONNECTED;
  wire [6:0]NLW_xbar_s_axi_rlast_UNCONNECTED;
  wire [13:0]NLW_xbar_s_axi_rresp_UNCONNECTED;
  wire [6:0]NLW_xbar_s_axi_rvalid_UNCONNECTED;
  wire [6:0]NLW_xbar_s_axi_wready_UNCONNECTED;

  assign M00_AXI_araddr[31:0] = m00_couplers_to_axi_cpu_interconnect_ARADDR;
  assign M00_AXI_arvalid = m00_couplers_to_axi_cpu_interconnect_ARVALID;
  assign M00_AXI_awaddr[31:0] = m00_couplers_to_axi_cpu_interconnect_AWADDR;
  assign M00_AXI_awvalid = m00_couplers_to_axi_cpu_interconnect_AWVALID;
  assign M00_AXI_bready = m00_couplers_to_axi_cpu_interconnect_BREADY;
  assign M00_AXI_rready = m00_couplers_to_axi_cpu_interconnect_RREADY;
  assign M00_AXI_wdata[31:0] = m00_couplers_to_axi_cpu_interconnect_WDATA;
  assign M00_AXI_wstrb[3:0] = m00_couplers_to_axi_cpu_interconnect_WSTRB;
  assign M00_AXI_wvalid = m00_couplers_to_axi_cpu_interconnect_WVALID;
  assign M01_AXI_araddr[31:0] = m01_couplers_to_axi_cpu_interconnect_ARADDR;
  assign M01_AXI_arburst[1:0] = m01_couplers_to_axi_cpu_interconnect_ARBURST;
  assign M01_AXI_arcache[3:0] = m01_couplers_to_axi_cpu_interconnect_ARCACHE;
  assign M01_AXI_arlen[7:0] = m01_couplers_to_axi_cpu_interconnect_ARLEN;
  assign M01_AXI_arlock = m01_couplers_to_axi_cpu_interconnect_ARLOCK;
  assign M01_AXI_arprot[2:0] = m01_couplers_to_axi_cpu_interconnect_ARPROT;
  assign M01_AXI_arqos[3:0] = m01_couplers_to_axi_cpu_interconnect_ARQOS;
  assign M01_AXI_arregion[3:0] = m01_couplers_to_axi_cpu_interconnect_ARREGION;
  assign M01_AXI_arsize[2:0] = m01_couplers_to_axi_cpu_interconnect_ARSIZE;
  assign M01_AXI_arvalid = m01_couplers_to_axi_cpu_interconnect_ARVALID;
  assign M01_AXI_awaddr[31:0] = m01_couplers_to_axi_cpu_interconnect_AWADDR;
  assign M01_AXI_awburst[1:0] = m01_couplers_to_axi_cpu_interconnect_AWBURST;
  assign M01_AXI_awcache[3:0] = m01_couplers_to_axi_cpu_interconnect_AWCACHE;
  assign M01_AXI_awlen[7:0] = m01_couplers_to_axi_cpu_interconnect_AWLEN;
  assign M01_AXI_awlock = m01_couplers_to_axi_cpu_interconnect_AWLOCK;
  assign M01_AXI_awprot[2:0] = m01_couplers_to_axi_cpu_interconnect_AWPROT;
  assign M01_AXI_awqos[3:0] = m01_couplers_to_axi_cpu_interconnect_AWQOS;
  assign M01_AXI_awregion[3:0] = m01_couplers_to_axi_cpu_interconnect_AWREGION;
  assign M01_AXI_awsize[2:0] = m01_couplers_to_axi_cpu_interconnect_AWSIZE;
  assign M01_AXI_awvalid = m01_couplers_to_axi_cpu_interconnect_AWVALID;
  assign M01_AXI_bready = m01_couplers_to_axi_cpu_interconnect_BREADY;
  assign M01_AXI_rready = m01_couplers_to_axi_cpu_interconnect_RREADY;
  assign M01_AXI_wdata[31:0] = m01_couplers_to_axi_cpu_interconnect_WDATA;
  assign M01_AXI_wlast = m01_couplers_to_axi_cpu_interconnect_WLAST;
  assign M01_AXI_wstrb[3:0] = m01_couplers_to_axi_cpu_interconnect_WSTRB;
  assign M01_AXI_wvalid = m01_couplers_to_axi_cpu_interconnect_WVALID;
  assign M02_AXI_araddr[31:0] = m02_couplers_to_axi_cpu_interconnect_ARADDR;
  assign M02_AXI_arvalid = m02_couplers_to_axi_cpu_interconnect_ARVALID;
  assign M02_AXI_awaddr[31:0] = m02_couplers_to_axi_cpu_interconnect_AWADDR;
  assign M02_AXI_awvalid = m02_couplers_to_axi_cpu_interconnect_AWVALID;
  assign M02_AXI_bready = m02_couplers_to_axi_cpu_interconnect_BREADY;
  assign M02_AXI_rready = m02_couplers_to_axi_cpu_interconnect_RREADY;
  assign M02_AXI_wdata[31:0] = m02_couplers_to_axi_cpu_interconnect_WDATA;
  assign M02_AXI_wvalid = m02_couplers_to_axi_cpu_interconnect_WVALID;
  assign M03_AXI_araddr[31:0] = m03_couplers_to_axi_cpu_interconnect_ARADDR;
  assign M03_AXI_arvalid = m03_couplers_to_axi_cpu_interconnect_ARVALID;
  assign M03_AXI_awaddr[31:0] = m03_couplers_to_axi_cpu_interconnect_AWADDR;
  assign M03_AXI_awvalid = m03_couplers_to_axi_cpu_interconnect_AWVALID;
  assign M03_AXI_bready = m03_couplers_to_axi_cpu_interconnect_BREADY;
  assign M03_AXI_rready = m03_couplers_to_axi_cpu_interconnect_RREADY;
  assign M03_AXI_wdata[31:0] = m03_couplers_to_axi_cpu_interconnect_WDATA;
  assign M03_AXI_wstrb[3:0] = m03_couplers_to_axi_cpu_interconnect_WSTRB;
  assign M03_AXI_wvalid = m03_couplers_to_axi_cpu_interconnect_WVALID;
  assign M04_AXI_araddr[31:0] = m04_couplers_to_axi_cpu_interconnect_ARADDR;
  assign M04_AXI_arvalid = m04_couplers_to_axi_cpu_interconnect_ARVALID;
  assign M04_AXI_awaddr[31:0] = m04_couplers_to_axi_cpu_interconnect_AWADDR;
  assign M04_AXI_awvalid = m04_couplers_to_axi_cpu_interconnect_AWVALID;
  assign M04_AXI_bready = m04_couplers_to_axi_cpu_interconnect_BREADY;
  assign M04_AXI_rready = m04_couplers_to_axi_cpu_interconnect_RREADY;
  assign M04_AXI_wdata[31:0] = m04_couplers_to_axi_cpu_interconnect_WDATA;
  assign M04_AXI_wstrb[3:0] = m04_couplers_to_axi_cpu_interconnect_WSTRB;
  assign M04_AXI_wvalid = m04_couplers_to_axi_cpu_interconnect_WVALID;
  assign M05_AXI_araddr[31:0] = m05_couplers_to_axi_cpu_interconnect_ARADDR;
  assign M05_AXI_arvalid = m05_couplers_to_axi_cpu_interconnect_ARVALID;
  assign M05_AXI_awaddr[31:0] = m05_couplers_to_axi_cpu_interconnect_AWADDR;
  assign M05_AXI_awvalid = m05_couplers_to_axi_cpu_interconnect_AWVALID;
  assign M05_AXI_bready = m05_couplers_to_axi_cpu_interconnect_BREADY;
  assign M05_AXI_rready = m05_couplers_to_axi_cpu_interconnect_RREADY;
  assign M05_AXI_wdata[31:0] = m05_couplers_to_axi_cpu_interconnect_WDATA;
  assign M05_AXI_wstrb[3:0] = m05_couplers_to_axi_cpu_interconnect_WSTRB;
  assign M05_AXI_wvalid = m05_couplers_to_axi_cpu_interconnect_WVALID;
  assign M06_AXI_araddr[31:0] = m06_couplers_to_axi_cpu_interconnect_ARADDR;
  assign M06_AXI_arvalid = m06_couplers_to_axi_cpu_interconnect_ARVALID;
  assign M06_AXI_awaddr[31:0] = m06_couplers_to_axi_cpu_interconnect_AWADDR;
  assign M06_AXI_awvalid = m06_couplers_to_axi_cpu_interconnect_AWVALID;
  assign M06_AXI_bready = m06_couplers_to_axi_cpu_interconnect_BREADY;
  assign M06_AXI_rready = m06_couplers_to_axi_cpu_interconnect_RREADY;
  assign M06_AXI_wdata[31:0] = m06_couplers_to_axi_cpu_interconnect_WDATA;
  assign M06_AXI_wstrb[3:0] = m06_couplers_to_axi_cpu_interconnect_WSTRB;
  assign M06_AXI_wvalid = m06_couplers_to_axi_cpu_interconnect_WVALID;
  assign M07_AXI_araddr[31:0] = m07_couplers_to_axi_cpu_interconnect_ARADDR;
  assign M07_AXI_arburst[1:0] = m07_couplers_to_axi_cpu_interconnect_ARBURST;
  assign M07_AXI_arcache[3:0] = m07_couplers_to_axi_cpu_interconnect_ARCACHE;
  assign M07_AXI_arlen[7:0] = m07_couplers_to_axi_cpu_interconnect_ARLEN;
  assign M07_AXI_arlock[0] = m07_couplers_to_axi_cpu_interconnect_ARLOCK;
  assign M07_AXI_arprot[2:0] = m07_couplers_to_axi_cpu_interconnect_ARPROT;
  assign M07_AXI_arqos[3:0] = m07_couplers_to_axi_cpu_interconnect_ARQOS;
  assign M07_AXI_arregion[3:0] = m07_couplers_to_axi_cpu_interconnect_ARREGION;
  assign M07_AXI_arsize[2:0] = m07_couplers_to_axi_cpu_interconnect_ARSIZE;
  assign M07_AXI_arvalid = m07_couplers_to_axi_cpu_interconnect_ARVALID;
  assign M07_AXI_awaddr[31:0] = m07_couplers_to_axi_cpu_interconnect_AWADDR;
  assign M07_AXI_awburst[1:0] = m07_couplers_to_axi_cpu_interconnect_AWBURST;
  assign M07_AXI_awcache[3:0] = m07_couplers_to_axi_cpu_interconnect_AWCACHE;
  assign M07_AXI_awlen[7:0] = m07_couplers_to_axi_cpu_interconnect_AWLEN;
  assign M07_AXI_awlock[0] = m07_couplers_to_axi_cpu_interconnect_AWLOCK;
  assign M07_AXI_awprot[2:0] = m07_couplers_to_axi_cpu_interconnect_AWPROT;
  assign M07_AXI_awqos[3:0] = m07_couplers_to_axi_cpu_interconnect_AWQOS;
  assign M07_AXI_awregion[3:0] = m07_couplers_to_axi_cpu_interconnect_AWREGION;
  assign M07_AXI_awsize[2:0] = m07_couplers_to_axi_cpu_interconnect_AWSIZE;
  assign M07_AXI_awvalid = m07_couplers_to_axi_cpu_interconnect_AWVALID;
  assign M07_AXI_bready = m07_couplers_to_axi_cpu_interconnect_BREADY;
  assign M07_AXI_rready = m07_couplers_to_axi_cpu_interconnect_RREADY;
  assign M07_AXI_wdata[511:0] = m07_couplers_to_axi_cpu_interconnect_WDATA;
  assign M07_AXI_wlast = m07_couplers_to_axi_cpu_interconnect_WLAST;
  assign M07_AXI_wstrb[63:0] = m07_couplers_to_axi_cpu_interconnect_WSTRB;
  assign M07_AXI_wvalid = m07_couplers_to_axi_cpu_interconnect_WVALID;
  assign M08_AXI_araddr[17:0] = m08_couplers_to_axi_cpu_interconnect_ARADDR;
  assign M08_AXI_arvalid = m08_couplers_to_axi_cpu_interconnect_ARVALID;
  assign M08_AXI_awaddr[17:0] = m08_couplers_to_axi_cpu_interconnect_AWADDR;
  assign M08_AXI_awvalid = m08_couplers_to_axi_cpu_interconnect_AWVALID;
  assign M08_AXI_bready = m08_couplers_to_axi_cpu_interconnect_BREADY;
  assign M08_AXI_rready = m08_couplers_to_axi_cpu_interconnect_RREADY;
  assign M08_AXI_wdata[31:0] = m08_couplers_to_axi_cpu_interconnect_WDATA;
  assign M08_AXI_wstrb[3:0] = m08_couplers_to_axi_cpu_interconnect_WSTRB;
  assign M08_AXI_wvalid = m08_couplers_to_axi_cpu_interconnect_WVALID;
  assign M09_AXI_araddr[31:0] = m09_couplers_to_axi_cpu_interconnect_ARADDR;
  assign M09_AXI_arvalid = m09_couplers_to_axi_cpu_interconnect_ARVALID;
  assign M09_AXI_awaddr[31:0] = m09_couplers_to_axi_cpu_interconnect_AWADDR;
  assign M09_AXI_awvalid = m09_couplers_to_axi_cpu_interconnect_AWVALID;
  assign M09_AXI_bready = m09_couplers_to_axi_cpu_interconnect_BREADY;
  assign M09_AXI_rready = m09_couplers_to_axi_cpu_interconnect_RREADY;
  assign M09_AXI_wdata[31:0] = m09_couplers_to_axi_cpu_interconnect_WDATA;
  assign M09_AXI_wstrb[3:0] = m09_couplers_to_axi_cpu_interconnect_WSTRB;
  assign M09_AXI_wvalid = m09_couplers_to_axi_cpu_interconnect_WVALID;
  assign M10_AXI_araddr[31:0] = m10_couplers_to_axi_cpu_interconnect_ARADDR;
  assign M10_AXI_arvalid = m10_couplers_to_axi_cpu_interconnect_ARVALID;
  assign M10_AXI_awaddr[31:0] = m10_couplers_to_axi_cpu_interconnect_AWADDR;
  assign M10_AXI_awvalid = m10_couplers_to_axi_cpu_interconnect_AWVALID;
  assign M10_AXI_bready = m10_couplers_to_axi_cpu_interconnect_BREADY;
  assign M10_AXI_rready = m10_couplers_to_axi_cpu_interconnect_RREADY;
  assign M10_AXI_wdata[31:0] = m10_couplers_to_axi_cpu_interconnect_WDATA;
  assign M10_AXI_wvalid = m10_couplers_to_axi_cpu_interconnect_WVALID;
  assign M11_AXI_araddr[31:0] = m11_couplers_to_axi_cpu_interconnect_ARADDR;
  assign M11_AXI_arprot[2:0] = m11_couplers_to_axi_cpu_interconnect_ARPROT;
  assign M11_AXI_arvalid = m11_couplers_to_axi_cpu_interconnect_ARVALID;
  assign M11_AXI_awaddr[31:0] = m11_couplers_to_axi_cpu_interconnect_AWADDR;
  assign M11_AXI_awprot[2:0] = m11_couplers_to_axi_cpu_interconnect_AWPROT;
  assign M11_AXI_awvalid = m11_couplers_to_axi_cpu_interconnect_AWVALID;
  assign M11_AXI_bready = m11_couplers_to_axi_cpu_interconnect_BREADY;
  assign M11_AXI_rready = m11_couplers_to_axi_cpu_interconnect_RREADY;
  assign M11_AXI_wdata[31:0] = m11_couplers_to_axi_cpu_interconnect_WDATA;
  assign M11_AXI_wstrb[3:0] = m11_couplers_to_axi_cpu_interconnect_WSTRB;
  assign M11_AXI_wvalid = m11_couplers_to_axi_cpu_interconnect_WVALID;
  assign M12_AXI_araddr[31:0] = m12_couplers_to_axi_cpu_interconnect_ARADDR;
  assign M12_AXI_arvalid = m12_couplers_to_axi_cpu_interconnect_ARVALID;
  assign M12_AXI_awaddr[31:0] = m12_couplers_to_axi_cpu_interconnect_AWADDR;
  assign M12_AXI_awvalid = m12_couplers_to_axi_cpu_interconnect_AWVALID;
  assign M12_AXI_bready = m12_couplers_to_axi_cpu_interconnect_BREADY;
  assign M12_AXI_rready = m12_couplers_to_axi_cpu_interconnect_RREADY;
  assign M12_AXI_wdata[31:0] = m12_couplers_to_axi_cpu_interconnect_WDATA;
  assign M12_AXI_wstrb[3:0] = m12_couplers_to_axi_cpu_interconnect_WSTRB;
  assign M12_AXI_wvalid = m12_couplers_to_axi_cpu_interconnect_WVALID;
  assign M13_AXI_araddr[31:0] = m13_couplers_to_axi_cpu_interconnect_ARADDR;
  assign M13_AXI_arprot[2:0] = m13_couplers_to_axi_cpu_interconnect_ARPROT;
  assign M13_AXI_arvalid = m13_couplers_to_axi_cpu_interconnect_ARVALID;
  assign M13_AXI_awaddr[31:0] = m13_couplers_to_axi_cpu_interconnect_AWADDR;
  assign M13_AXI_awprot[2:0] = m13_couplers_to_axi_cpu_interconnect_AWPROT;
  assign M13_AXI_awvalid = m13_couplers_to_axi_cpu_interconnect_AWVALID;
  assign M13_AXI_bready = m13_couplers_to_axi_cpu_interconnect_BREADY;
  assign M13_AXI_rready = m13_couplers_to_axi_cpu_interconnect_RREADY;
  assign M13_AXI_wdata[31:0] = m13_couplers_to_axi_cpu_interconnect_WDATA;
  assign M13_AXI_wstrb[3:0] = m13_couplers_to_axi_cpu_interconnect_WSTRB;
  assign M13_AXI_wvalid = m13_couplers_to_axi_cpu_interconnect_WVALID;
  assign M14_AXI_araddr[31:0] = m14_couplers_to_axi_cpu_interconnect_ARADDR;
  assign M14_AXI_arburst[1:0] = m14_couplers_to_axi_cpu_interconnect_ARBURST;
  assign M14_AXI_arcache[3:0] = m14_couplers_to_axi_cpu_interconnect_ARCACHE;
  assign M14_AXI_arlen[7:0] = m14_couplers_to_axi_cpu_interconnect_ARLEN;
  assign M14_AXI_arlock = m14_couplers_to_axi_cpu_interconnect_ARLOCK;
  assign M14_AXI_arprot[2:0] = m14_couplers_to_axi_cpu_interconnect_ARPROT;
  assign M14_AXI_arqos[3:0] = m14_couplers_to_axi_cpu_interconnect_ARQOS;
  assign M14_AXI_arregion[3:0] = m14_couplers_to_axi_cpu_interconnect_ARREGION;
  assign M14_AXI_arsize[2:0] = m14_couplers_to_axi_cpu_interconnect_ARSIZE;
  assign M14_AXI_arvalid = m14_couplers_to_axi_cpu_interconnect_ARVALID;
  assign M14_AXI_awaddr[31:0] = m14_couplers_to_axi_cpu_interconnect_AWADDR;
  assign M14_AXI_awburst[1:0] = m14_couplers_to_axi_cpu_interconnect_AWBURST;
  assign M14_AXI_awcache[3:0] = m14_couplers_to_axi_cpu_interconnect_AWCACHE;
  assign M14_AXI_awlen[7:0] = m14_couplers_to_axi_cpu_interconnect_AWLEN;
  assign M14_AXI_awlock = m14_couplers_to_axi_cpu_interconnect_AWLOCK;
  assign M14_AXI_awprot[2:0] = m14_couplers_to_axi_cpu_interconnect_AWPROT;
  assign M14_AXI_awqos[3:0] = m14_couplers_to_axi_cpu_interconnect_AWQOS;
  assign M14_AXI_awregion[3:0] = m14_couplers_to_axi_cpu_interconnect_AWREGION;
  assign M14_AXI_awsize[2:0] = m14_couplers_to_axi_cpu_interconnect_AWSIZE;
  assign M14_AXI_awvalid = m14_couplers_to_axi_cpu_interconnect_AWVALID;
  assign M14_AXI_bready = m14_couplers_to_axi_cpu_interconnect_BREADY;
  assign M14_AXI_rready = m14_couplers_to_axi_cpu_interconnect_RREADY;
  assign M14_AXI_wdata[31:0] = m14_couplers_to_axi_cpu_interconnect_WDATA;
  assign M14_AXI_wlast = m14_couplers_to_axi_cpu_interconnect_WLAST;
  assign M14_AXI_wstrb[3:0] = m14_couplers_to_axi_cpu_interconnect_WSTRB;
  assign M14_AXI_wvalid = m14_couplers_to_axi_cpu_interconnect_WVALID;
  assign S00_AXI_arready = axi_cpu_interconnect_to_s00_couplers_ARREADY;
  assign S00_AXI_awready = axi_cpu_interconnect_to_s00_couplers_AWREADY;
  assign S00_AXI_bresp[1:0] = axi_cpu_interconnect_to_s00_couplers_BRESP;
  assign S00_AXI_bvalid = axi_cpu_interconnect_to_s00_couplers_BVALID;
  assign S00_AXI_rdata[31:0] = axi_cpu_interconnect_to_s00_couplers_RDATA;
  assign S00_AXI_rresp[1:0] = axi_cpu_interconnect_to_s00_couplers_RRESP;
  assign S00_AXI_rvalid = axi_cpu_interconnect_to_s00_couplers_RVALID;
  assign S00_AXI_wready = axi_cpu_interconnect_to_s00_couplers_WREADY;
  assign S01_AXI_arready = axi_cpu_interconnect_to_s01_couplers_ARREADY;
  assign S01_AXI_awready = axi_cpu_interconnect_to_s01_couplers_AWREADY;
  assign S01_AXI_bresp[1:0] = axi_cpu_interconnect_to_s01_couplers_BRESP;
  assign S01_AXI_bvalid = axi_cpu_interconnect_to_s01_couplers_BVALID;
  assign S01_AXI_rdata[31:0] = axi_cpu_interconnect_to_s01_couplers_RDATA;
  assign S01_AXI_rlast = axi_cpu_interconnect_to_s01_couplers_RLAST;
  assign S01_AXI_rresp[1:0] = axi_cpu_interconnect_to_s01_couplers_RRESP;
  assign S01_AXI_rvalid = axi_cpu_interconnect_to_s01_couplers_RVALID;
  assign S01_AXI_wready = axi_cpu_interconnect_to_s01_couplers_WREADY;
  assign S02_AXI_arready = axi_cpu_interconnect_to_s02_couplers_ARREADY;
  assign S02_AXI_rdata[31:0] = axi_cpu_interconnect_to_s02_couplers_RDATA;
  assign S02_AXI_rlast = axi_cpu_interconnect_to_s02_couplers_RLAST;
  assign S02_AXI_rresp[1:0] = axi_cpu_interconnect_to_s02_couplers_RRESP;
  assign S02_AXI_rvalid = axi_cpu_interconnect_to_s02_couplers_RVALID;
  assign S03_AXI_awready = axi_cpu_interconnect_to_s03_couplers_AWREADY;
  assign S03_AXI_bresp[1:0] = axi_cpu_interconnect_to_s03_couplers_BRESP;
  assign S03_AXI_bvalid = axi_cpu_interconnect_to_s03_couplers_BVALID;
  assign S03_AXI_wready = axi_cpu_interconnect_to_s03_couplers_WREADY;
  assign S04_AXI_arready = axi_cpu_interconnect_to_s04_couplers_ARREADY;
  assign S04_AXI_rdata[31:0] = axi_cpu_interconnect_to_s04_couplers_RDATA;
  assign S04_AXI_rresp[1:0] = axi_cpu_interconnect_to_s04_couplers_RRESP;
  assign S04_AXI_rvalid = axi_cpu_interconnect_to_s04_couplers_RVALID;
  assign S05_AXI_arready = axi_cpu_interconnect_to_s05_couplers_ARREADY;
  assign S05_AXI_awready = axi_cpu_interconnect_to_s05_couplers_AWREADY;
  assign S05_AXI_bid[0] = axi_cpu_interconnect_to_s05_couplers_BID;
  assign S05_AXI_bresp[1:0] = axi_cpu_interconnect_to_s05_couplers_BRESP;
  assign S05_AXI_bvalid = axi_cpu_interconnect_to_s05_couplers_BVALID;
  assign S05_AXI_rdata[31:0] = axi_cpu_interconnect_to_s05_couplers_RDATA;
  assign S05_AXI_rid[0] = axi_cpu_interconnect_to_s05_couplers_RID;
  assign S05_AXI_rlast = axi_cpu_interconnect_to_s05_couplers_RLAST;
  assign S05_AXI_rresp[1:0] = axi_cpu_interconnect_to_s05_couplers_RRESP;
  assign S05_AXI_rvalid = axi_cpu_interconnect_to_s05_couplers_RVALID;
  assign S05_AXI_wready = axi_cpu_interconnect_to_s05_couplers_WREADY;
  assign S06_AXI_arready = axi_cpu_interconnect_to_s06_couplers_ARREADY;
  assign S06_AXI_awready = axi_cpu_interconnect_to_s06_couplers_AWREADY;
  assign S06_AXI_bid[0] = axi_cpu_interconnect_to_s06_couplers_BID;
  assign S06_AXI_bresp[1:0] = axi_cpu_interconnect_to_s06_couplers_BRESP;
  assign S06_AXI_bvalid = axi_cpu_interconnect_to_s06_couplers_BVALID;
  assign S06_AXI_rdata[31:0] = axi_cpu_interconnect_to_s06_couplers_RDATA;
  assign S06_AXI_rid[0] = axi_cpu_interconnect_to_s06_couplers_RID;
  assign S06_AXI_rlast = axi_cpu_interconnect_to_s06_couplers_RLAST;
  assign S06_AXI_rresp[1:0] = axi_cpu_interconnect_to_s06_couplers_RRESP;
  assign S06_AXI_rvalid = axi_cpu_interconnect_to_s06_couplers_RVALID;
  assign S06_AXI_wready = axi_cpu_interconnect_to_s06_couplers_WREADY;
  assign axi_cpu_interconnect_ACLK_net = ACLK;
  assign axi_cpu_interconnect_ARESETN_net = ARESETN[0];
  assign axi_cpu_interconnect_to_s00_couplers_ARADDR = S00_AXI_araddr[31:0];
  assign axi_cpu_interconnect_to_s00_couplers_ARPROT = S00_AXI_arprot[2:0];
  assign axi_cpu_interconnect_to_s00_couplers_ARVALID = S00_AXI_arvalid;
  assign axi_cpu_interconnect_to_s00_couplers_AWADDR = S00_AXI_awaddr[31:0];
  assign axi_cpu_interconnect_to_s00_couplers_AWPROT = S00_AXI_awprot[2:0];
  assign axi_cpu_interconnect_to_s00_couplers_AWVALID = S00_AXI_awvalid;
  assign axi_cpu_interconnect_to_s00_couplers_BREADY = S00_AXI_bready;
  assign axi_cpu_interconnect_to_s00_couplers_RREADY = S00_AXI_rready;
  assign axi_cpu_interconnect_to_s00_couplers_WDATA = S00_AXI_wdata[31:0];
  assign axi_cpu_interconnect_to_s00_couplers_WSTRB = S00_AXI_wstrb[3:0];
  assign axi_cpu_interconnect_to_s00_couplers_WVALID = S00_AXI_wvalid;
  assign axi_cpu_interconnect_to_s01_couplers_ARADDR = S01_AXI_araddr[31:0];
  assign axi_cpu_interconnect_to_s01_couplers_ARBURST = S01_AXI_arburst[1:0];
  assign axi_cpu_interconnect_to_s01_couplers_ARCACHE = S01_AXI_arcache[3:0];
  assign axi_cpu_interconnect_to_s01_couplers_ARLEN = S01_AXI_arlen[7:0];
  assign axi_cpu_interconnect_to_s01_couplers_ARPROT = S01_AXI_arprot[2:0];
  assign axi_cpu_interconnect_to_s01_couplers_ARSIZE = S01_AXI_arsize[2:0];
  assign axi_cpu_interconnect_to_s01_couplers_ARVALID = S01_AXI_arvalid;
  assign axi_cpu_interconnect_to_s01_couplers_AWADDR = S01_AXI_awaddr[31:0];
  assign axi_cpu_interconnect_to_s01_couplers_AWBURST = S01_AXI_awburst[1:0];
  assign axi_cpu_interconnect_to_s01_couplers_AWCACHE = S01_AXI_awcache[3:0];
  assign axi_cpu_interconnect_to_s01_couplers_AWLEN = S01_AXI_awlen[7:0];
  assign axi_cpu_interconnect_to_s01_couplers_AWPROT = S01_AXI_awprot[2:0];
  assign axi_cpu_interconnect_to_s01_couplers_AWSIZE = S01_AXI_awsize[2:0];
  assign axi_cpu_interconnect_to_s01_couplers_AWVALID = S01_AXI_awvalid;
  assign axi_cpu_interconnect_to_s01_couplers_BREADY = S01_AXI_bready;
  assign axi_cpu_interconnect_to_s01_couplers_RREADY = S01_AXI_rready;
  assign axi_cpu_interconnect_to_s01_couplers_WDATA = S01_AXI_wdata[31:0];
  assign axi_cpu_interconnect_to_s01_couplers_WLAST = S01_AXI_wlast;
  assign axi_cpu_interconnect_to_s01_couplers_WSTRB = S01_AXI_wstrb[3:0];
  assign axi_cpu_interconnect_to_s01_couplers_WVALID = S01_AXI_wvalid;
  assign axi_cpu_interconnect_to_s02_couplers_ARADDR = S02_AXI_araddr[31:0];
  assign axi_cpu_interconnect_to_s02_couplers_ARBURST = S02_AXI_arburst[1:0];
  assign axi_cpu_interconnect_to_s02_couplers_ARCACHE = S02_AXI_arcache[3:0];
  assign axi_cpu_interconnect_to_s02_couplers_ARLEN = S02_AXI_arlen[7:0];
  assign axi_cpu_interconnect_to_s02_couplers_ARPROT = S02_AXI_arprot[2:0];
  assign axi_cpu_interconnect_to_s02_couplers_ARSIZE = S02_AXI_arsize[2:0];
  assign axi_cpu_interconnect_to_s02_couplers_ARVALID = S02_AXI_arvalid;
  assign axi_cpu_interconnect_to_s02_couplers_RREADY = S02_AXI_rready;
  assign axi_cpu_interconnect_to_s03_couplers_AWADDR = S03_AXI_awaddr[31:0];
  assign axi_cpu_interconnect_to_s03_couplers_AWBURST = S03_AXI_awburst[1:0];
  assign axi_cpu_interconnect_to_s03_couplers_AWCACHE = S03_AXI_awcache[3:0];
  assign axi_cpu_interconnect_to_s03_couplers_AWLEN = S03_AXI_awlen[7:0];
  assign axi_cpu_interconnect_to_s03_couplers_AWPROT = S03_AXI_awprot[2:0];
  assign axi_cpu_interconnect_to_s03_couplers_AWSIZE = S03_AXI_awsize[2:0];
  assign axi_cpu_interconnect_to_s03_couplers_AWVALID = S03_AXI_awvalid;
  assign axi_cpu_interconnect_to_s03_couplers_BREADY = S03_AXI_bready;
  assign axi_cpu_interconnect_to_s03_couplers_WDATA = S03_AXI_wdata[31:0];
  assign axi_cpu_interconnect_to_s03_couplers_WLAST = S03_AXI_wlast;
  assign axi_cpu_interconnect_to_s03_couplers_WSTRB = S03_AXI_wstrb[3:0];
  assign axi_cpu_interconnect_to_s03_couplers_WVALID = S03_AXI_wvalid;
  assign axi_cpu_interconnect_to_s04_couplers_ARADDR = S04_AXI_araddr[31:0];
  assign axi_cpu_interconnect_to_s04_couplers_ARPROT = S04_AXI_arprot[2:0];
  assign axi_cpu_interconnect_to_s04_couplers_ARVALID = S04_AXI_arvalid;
  assign axi_cpu_interconnect_to_s04_couplers_RREADY = S04_AXI_rready;
  assign axi_cpu_interconnect_to_s05_couplers_ARADDR = S05_AXI_araddr[31:0];
  assign axi_cpu_interconnect_to_s05_couplers_ARBURST = S05_AXI_arburst[1:0];
  assign axi_cpu_interconnect_to_s05_couplers_ARCACHE = S05_AXI_arcache[3:0];
  assign axi_cpu_interconnect_to_s05_couplers_ARID = S05_AXI_arid[0];
  assign axi_cpu_interconnect_to_s05_couplers_ARLEN = S05_AXI_arlen[7:0];
  assign axi_cpu_interconnect_to_s05_couplers_ARLOCK = S05_AXI_arlock;
  assign axi_cpu_interconnect_to_s05_couplers_ARPROT = S05_AXI_arprot[2:0];
  assign axi_cpu_interconnect_to_s05_couplers_ARQOS = S05_AXI_arqos[3:0];
  assign axi_cpu_interconnect_to_s05_couplers_ARSIZE = S05_AXI_arsize[2:0];
  assign axi_cpu_interconnect_to_s05_couplers_ARVALID = S05_AXI_arvalid;
  assign axi_cpu_interconnect_to_s05_couplers_AWADDR = S05_AXI_awaddr[31:0];
  assign axi_cpu_interconnect_to_s05_couplers_AWBURST = S05_AXI_awburst[1:0];
  assign axi_cpu_interconnect_to_s05_couplers_AWCACHE = S05_AXI_awcache[3:0];
  assign axi_cpu_interconnect_to_s05_couplers_AWID = S05_AXI_awid[0];
  assign axi_cpu_interconnect_to_s05_couplers_AWLEN = S05_AXI_awlen[7:0];
  assign axi_cpu_interconnect_to_s05_couplers_AWLOCK = S05_AXI_awlock;
  assign axi_cpu_interconnect_to_s05_couplers_AWPROT = S05_AXI_awprot[2:0];
  assign axi_cpu_interconnect_to_s05_couplers_AWQOS = S05_AXI_awqos[3:0];
  assign axi_cpu_interconnect_to_s05_couplers_AWSIZE = S05_AXI_awsize[2:0];
  assign axi_cpu_interconnect_to_s05_couplers_AWVALID = S05_AXI_awvalid;
  assign axi_cpu_interconnect_to_s05_couplers_BREADY = S05_AXI_bready;
  assign axi_cpu_interconnect_to_s05_couplers_RREADY = S05_AXI_rready;
  assign axi_cpu_interconnect_to_s05_couplers_WDATA = S05_AXI_wdata[31:0];
  assign axi_cpu_interconnect_to_s05_couplers_WLAST = S05_AXI_wlast;
  assign axi_cpu_interconnect_to_s05_couplers_WSTRB = S05_AXI_wstrb[3:0];
  assign axi_cpu_interconnect_to_s05_couplers_WVALID = S05_AXI_wvalid;
  assign axi_cpu_interconnect_to_s06_couplers_ARADDR = S06_AXI_araddr[31:0];
  assign axi_cpu_interconnect_to_s06_couplers_ARBURST = S06_AXI_arburst[1:0];
  assign axi_cpu_interconnect_to_s06_couplers_ARCACHE = S06_AXI_arcache[3:0];
  assign axi_cpu_interconnect_to_s06_couplers_ARID = S06_AXI_arid[0];
  assign axi_cpu_interconnect_to_s06_couplers_ARLEN = S06_AXI_arlen[7:0];
  assign axi_cpu_interconnect_to_s06_couplers_ARLOCK = S06_AXI_arlock;
  assign axi_cpu_interconnect_to_s06_couplers_ARPROT = S06_AXI_arprot[2:0];
  assign axi_cpu_interconnect_to_s06_couplers_ARQOS = S06_AXI_arqos[3:0];
  assign axi_cpu_interconnect_to_s06_couplers_ARSIZE = S06_AXI_arsize[2:0];
  assign axi_cpu_interconnect_to_s06_couplers_ARVALID = S06_AXI_arvalid;
  assign axi_cpu_interconnect_to_s06_couplers_AWADDR = S06_AXI_awaddr[31:0];
  assign axi_cpu_interconnect_to_s06_couplers_AWBURST = S06_AXI_awburst[1:0];
  assign axi_cpu_interconnect_to_s06_couplers_AWCACHE = S06_AXI_awcache[3:0];
  assign axi_cpu_interconnect_to_s06_couplers_AWID = S06_AXI_awid[0];
  assign axi_cpu_interconnect_to_s06_couplers_AWLEN = S06_AXI_awlen[7:0];
  assign axi_cpu_interconnect_to_s06_couplers_AWLOCK = S06_AXI_awlock;
  assign axi_cpu_interconnect_to_s06_couplers_AWPROT = S06_AXI_awprot[2:0];
  assign axi_cpu_interconnect_to_s06_couplers_AWQOS = S06_AXI_awqos[3:0];
  assign axi_cpu_interconnect_to_s06_couplers_AWSIZE = S06_AXI_awsize[2:0];
  assign axi_cpu_interconnect_to_s06_couplers_AWVALID = S06_AXI_awvalid;
  assign axi_cpu_interconnect_to_s06_couplers_BREADY = S06_AXI_bready;
  assign axi_cpu_interconnect_to_s06_couplers_RREADY = S06_AXI_rready;
  assign axi_cpu_interconnect_to_s06_couplers_WDATA = S06_AXI_wdata[31:0];
  assign axi_cpu_interconnect_to_s06_couplers_WLAST = S06_AXI_wlast;
  assign axi_cpu_interconnect_to_s06_couplers_WSTRB = S06_AXI_wstrb[3:0];
  assign axi_cpu_interconnect_to_s06_couplers_WVALID = S06_AXI_wvalid;
  assign m00_couplers_to_axi_cpu_interconnect_ARREADY = M00_AXI_arready;
  assign m00_couplers_to_axi_cpu_interconnect_AWREADY = M00_AXI_awready;
  assign m00_couplers_to_axi_cpu_interconnect_BRESP = M00_AXI_bresp[1:0];
  assign m00_couplers_to_axi_cpu_interconnect_BVALID = M00_AXI_bvalid;
  assign m00_couplers_to_axi_cpu_interconnect_RDATA = M00_AXI_rdata[31:0];
  assign m00_couplers_to_axi_cpu_interconnect_RRESP = M00_AXI_rresp[1:0];
  assign m00_couplers_to_axi_cpu_interconnect_RVALID = M00_AXI_rvalid;
  assign m00_couplers_to_axi_cpu_interconnect_WREADY = M00_AXI_wready;
  assign m01_couplers_to_axi_cpu_interconnect_ARREADY = M01_AXI_arready;
  assign m01_couplers_to_axi_cpu_interconnect_AWREADY = M01_AXI_awready;
  assign m01_couplers_to_axi_cpu_interconnect_BRESP = M01_AXI_bresp[1:0];
  assign m01_couplers_to_axi_cpu_interconnect_BVALID = M01_AXI_bvalid;
  assign m01_couplers_to_axi_cpu_interconnect_RDATA = M01_AXI_rdata[31:0];
  assign m01_couplers_to_axi_cpu_interconnect_RLAST = M01_AXI_rlast;
  assign m01_couplers_to_axi_cpu_interconnect_RRESP = M01_AXI_rresp[1:0];
  assign m01_couplers_to_axi_cpu_interconnect_RVALID = M01_AXI_rvalid;
  assign m01_couplers_to_axi_cpu_interconnect_WREADY = M01_AXI_wready;
  assign m02_couplers_to_axi_cpu_interconnect_ARREADY = M02_AXI_arready;
  assign m02_couplers_to_axi_cpu_interconnect_AWREADY = M02_AXI_awready;
  assign m02_couplers_to_axi_cpu_interconnect_BRESP = M02_AXI_bresp[1:0];
  assign m02_couplers_to_axi_cpu_interconnect_BVALID = M02_AXI_bvalid;
  assign m02_couplers_to_axi_cpu_interconnect_RDATA = M02_AXI_rdata[31:0];
  assign m02_couplers_to_axi_cpu_interconnect_RRESP = M02_AXI_rresp[1:0];
  assign m02_couplers_to_axi_cpu_interconnect_RVALID = M02_AXI_rvalid;
  assign m02_couplers_to_axi_cpu_interconnect_WREADY = M02_AXI_wready;
  assign m03_couplers_to_axi_cpu_interconnect_ARREADY = M03_AXI_arready;
  assign m03_couplers_to_axi_cpu_interconnect_AWREADY = M03_AXI_awready;
  assign m03_couplers_to_axi_cpu_interconnect_BRESP = M03_AXI_bresp[1:0];
  assign m03_couplers_to_axi_cpu_interconnect_BVALID = M03_AXI_bvalid;
  assign m03_couplers_to_axi_cpu_interconnect_RDATA = M03_AXI_rdata[31:0];
  assign m03_couplers_to_axi_cpu_interconnect_RRESP = M03_AXI_rresp[1:0];
  assign m03_couplers_to_axi_cpu_interconnect_RVALID = M03_AXI_rvalid;
  assign m03_couplers_to_axi_cpu_interconnect_WREADY = M03_AXI_wready;
  assign m04_couplers_to_axi_cpu_interconnect_ARREADY = M04_AXI_arready;
  assign m04_couplers_to_axi_cpu_interconnect_AWREADY = M04_AXI_awready;
  assign m04_couplers_to_axi_cpu_interconnect_BRESP = M04_AXI_bresp[1:0];
  assign m04_couplers_to_axi_cpu_interconnect_BVALID = M04_AXI_bvalid;
  assign m04_couplers_to_axi_cpu_interconnect_RDATA = M04_AXI_rdata[31:0];
  assign m04_couplers_to_axi_cpu_interconnect_RRESP = M04_AXI_rresp[1:0];
  assign m04_couplers_to_axi_cpu_interconnect_RVALID = M04_AXI_rvalid;
  assign m04_couplers_to_axi_cpu_interconnect_WREADY = M04_AXI_wready;
  assign m05_couplers_to_axi_cpu_interconnect_ARREADY = M05_AXI_arready;
  assign m05_couplers_to_axi_cpu_interconnect_AWREADY = M05_AXI_awready;
  assign m05_couplers_to_axi_cpu_interconnect_BRESP = M05_AXI_bresp[1:0];
  assign m05_couplers_to_axi_cpu_interconnect_BVALID = M05_AXI_bvalid;
  assign m05_couplers_to_axi_cpu_interconnect_RDATA = M05_AXI_rdata[31:0];
  assign m05_couplers_to_axi_cpu_interconnect_RRESP = M05_AXI_rresp[1:0];
  assign m05_couplers_to_axi_cpu_interconnect_RVALID = M05_AXI_rvalid;
  assign m05_couplers_to_axi_cpu_interconnect_WREADY = M05_AXI_wready;
  assign m06_couplers_to_axi_cpu_interconnect_ARREADY = M06_AXI_arready;
  assign m06_couplers_to_axi_cpu_interconnect_AWREADY = M06_AXI_awready;
  assign m06_couplers_to_axi_cpu_interconnect_BRESP = M06_AXI_bresp[1:0];
  assign m06_couplers_to_axi_cpu_interconnect_BVALID = M06_AXI_bvalid;
  assign m06_couplers_to_axi_cpu_interconnect_RDATA = M06_AXI_rdata[31:0];
  assign m06_couplers_to_axi_cpu_interconnect_RRESP = M06_AXI_rresp[1:0];
  assign m06_couplers_to_axi_cpu_interconnect_RVALID = M06_AXI_rvalid;
  assign m06_couplers_to_axi_cpu_interconnect_WREADY = M06_AXI_wready;
  assign m07_couplers_to_axi_cpu_interconnect_ARREADY = M07_AXI_arready;
  assign m07_couplers_to_axi_cpu_interconnect_AWREADY = M07_AXI_awready;
  assign m07_couplers_to_axi_cpu_interconnect_BRESP = M07_AXI_bresp[1:0];
  assign m07_couplers_to_axi_cpu_interconnect_BVALID = M07_AXI_bvalid;
  assign m07_couplers_to_axi_cpu_interconnect_RDATA = M07_AXI_rdata[511:0];
  assign m07_couplers_to_axi_cpu_interconnect_RLAST = M07_AXI_rlast;
  assign m07_couplers_to_axi_cpu_interconnect_RRESP = M07_AXI_rresp[1:0];
  assign m07_couplers_to_axi_cpu_interconnect_RVALID = M07_AXI_rvalid;
  assign m07_couplers_to_axi_cpu_interconnect_WREADY = M07_AXI_wready;
  assign m08_couplers_to_axi_cpu_interconnect_ARREADY = M08_AXI_arready;
  assign m08_couplers_to_axi_cpu_interconnect_AWREADY = M08_AXI_awready;
  assign m08_couplers_to_axi_cpu_interconnect_BRESP = M08_AXI_bresp[1:0];
  assign m08_couplers_to_axi_cpu_interconnect_BVALID = M08_AXI_bvalid;
  assign m08_couplers_to_axi_cpu_interconnect_RDATA = M08_AXI_rdata[31:0];
  assign m08_couplers_to_axi_cpu_interconnect_RRESP = M08_AXI_rresp[1:0];
  assign m08_couplers_to_axi_cpu_interconnect_RVALID = M08_AXI_rvalid;
  assign m08_couplers_to_axi_cpu_interconnect_WREADY = M08_AXI_wready;
  assign m09_couplers_to_axi_cpu_interconnect_ARREADY = M09_AXI_arready;
  assign m09_couplers_to_axi_cpu_interconnect_AWREADY = M09_AXI_awready;
  assign m09_couplers_to_axi_cpu_interconnect_BRESP = M09_AXI_bresp[1:0];
  assign m09_couplers_to_axi_cpu_interconnect_BVALID = M09_AXI_bvalid;
  assign m09_couplers_to_axi_cpu_interconnect_RDATA = M09_AXI_rdata[31:0];
  assign m09_couplers_to_axi_cpu_interconnect_RRESP = M09_AXI_rresp[1:0];
  assign m09_couplers_to_axi_cpu_interconnect_RVALID = M09_AXI_rvalid;
  assign m09_couplers_to_axi_cpu_interconnect_WREADY = M09_AXI_wready;
  assign m10_couplers_to_axi_cpu_interconnect_ARREADY = M10_AXI_arready;
  assign m10_couplers_to_axi_cpu_interconnect_AWREADY = M10_AXI_awready;
  assign m10_couplers_to_axi_cpu_interconnect_BRESP = M10_AXI_bresp[1:0];
  assign m10_couplers_to_axi_cpu_interconnect_BVALID = M10_AXI_bvalid;
  assign m10_couplers_to_axi_cpu_interconnect_RDATA = M10_AXI_rdata[31:0];
  assign m10_couplers_to_axi_cpu_interconnect_RRESP = M10_AXI_rresp[1:0];
  assign m10_couplers_to_axi_cpu_interconnect_RVALID = M10_AXI_rvalid;
  assign m10_couplers_to_axi_cpu_interconnect_WREADY = M10_AXI_wready;
  assign m11_couplers_to_axi_cpu_interconnect_ARREADY = M11_AXI_arready;
  assign m11_couplers_to_axi_cpu_interconnect_AWREADY = M11_AXI_awready;
  assign m11_couplers_to_axi_cpu_interconnect_BRESP = M11_AXI_bresp[1:0];
  assign m11_couplers_to_axi_cpu_interconnect_BVALID = M11_AXI_bvalid;
  assign m11_couplers_to_axi_cpu_interconnect_RDATA = M11_AXI_rdata[31:0];
  assign m11_couplers_to_axi_cpu_interconnect_RRESP = M11_AXI_rresp[1:0];
  assign m11_couplers_to_axi_cpu_interconnect_RVALID = M11_AXI_rvalid;
  assign m11_couplers_to_axi_cpu_interconnect_WREADY = M11_AXI_wready;
  assign m12_couplers_to_axi_cpu_interconnect_ARREADY = M12_AXI_arready;
  assign m12_couplers_to_axi_cpu_interconnect_AWREADY = M12_AXI_awready;
  assign m12_couplers_to_axi_cpu_interconnect_BRESP = M12_AXI_bresp[1:0];
  assign m12_couplers_to_axi_cpu_interconnect_BVALID = M12_AXI_bvalid;
  assign m12_couplers_to_axi_cpu_interconnect_RDATA = M12_AXI_rdata[31:0];
  assign m12_couplers_to_axi_cpu_interconnect_RRESP = M12_AXI_rresp[1:0];
  assign m12_couplers_to_axi_cpu_interconnect_RVALID = M12_AXI_rvalid;
  assign m12_couplers_to_axi_cpu_interconnect_WREADY = M12_AXI_wready;
  assign m13_couplers_to_axi_cpu_interconnect_ARREADY = M13_AXI_arready;
  assign m13_couplers_to_axi_cpu_interconnect_AWREADY = M13_AXI_awready;
  assign m13_couplers_to_axi_cpu_interconnect_BRESP = M13_AXI_bresp[1:0];
  assign m13_couplers_to_axi_cpu_interconnect_BVALID = M13_AXI_bvalid;
  assign m13_couplers_to_axi_cpu_interconnect_RDATA = M13_AXI_rdata[31:0];
  assign m13_couplers_to_axi_cpu_interconnect_RRESP = M13_AXI_rresp[1:0];
  assign m13_couplers_to_axi_cpu_interconnect_RVALID = M13_AXI_rvalid;
  assign m13_couplers_to_axi_cpu_interconnect_WREADY = M13_AXI_wready;
  assign m14_couplers_to_axi_cpu_interconnect_ARREADY = M14_AXI_arready;
  assign m14_couplers_to_axi_cpu_interconnect_AWREADY = M14_AXI_awready;
  assign m14_couplers_to_axi_cpu_interconnect_BRESP = M14_AXI_bresp[1:0];
  assign m14_couplers_to_axi_cpu_interconnect_BVALID = M14_AXI_bvalid;
  assign m14_couplers_to_axi_cpu_interconnect_RDATA = M14_AXI_rdata[31:0];
  assign m14_couplers_to_axi_cpu_interconnect_RLAST = M14_AXI_rlast;
  assign m14_couplers_to_axi_cpu_interconnect_RRESP = M14_AXI_rresp[1:0];
  assign m14_couplers_to_axi_cpu_interconnect_RVALID = M14_AXI_rvalid;
  assign m14_couplers_to_axi_cpu_interconnect_WREADY = M14_AXI_wready;
  m00_couplers_imp_WL3GAE m00_couplers
       (.M_ACLK(axi_cpu_interconnect_ACLK_net),
        .M_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .M_AXI_araddr(m00_couplers_to_axi_cpu_interconnect_ARADDR),
        .M_AXI_arready(m00_couplers_to_axi_cpu_interconnect_ARREADY),
        .M_AXI_arvalid(m00_couplers_to_axi_cpu_interconnect_ARVALID),
        .M_AXI_awaddr(m00_couplers_to_axi_cpu_interconnect_AWADDR),
        .M_AXI_awready(m00_couplers_to_axi_cpu_interconnect_AWREADY),
        .M_AXI_awvalid(m00_couplers_to_axi_cpu_interconnect_AWVALID),
        .M_AXI_bready(m00_couplers_to_axi_cpu_interconnect_BREADY),
        .M_AXI_bresp(m00_couplers_to_axi_cpu_interconnect_BRESP),
        .M_AXI_bvalid(m00_couplers_to_axi_cpu_interconnect_BVALID),
        .M_AXI_rdata(m00_couplers_to_axi_cpu_interconnect_RDATA),
        .M_AXI_rready(m00_couplers_to_axi_cpu_interconnect_RREADY),
        .M_AXI_rresp(m00_couplers_to_axi_cpu_interconnect_RRESP),
        .M_AXI_rvalid(m00_couplers_to_axi_cpu_interconnect_RVALID),
        .M_AXI_wdata(m00_couplers_to_axi_cpu_interconnect_WDATA),
        .M_AXI_wready(m00_couplers_to_axi_cpu_interconnect_WREADY),
        .M_AXI_wstrb(m00_couplers_to_axi_cpu_interconnect_WSTRB),
        .M_AXI_wvalid(m00_couplers_to_axi_cpu_interconnect_WVALID),
        .S_ACLK(axi_cpu_interconnect_ACLK_net),
        .S_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .S_AXI_araddr(xbar_to_m00_couplers_ARADDR),
        .S_AXI_arburst(xbar_to_m00_couplers_ARBURST),
        .S_AXI_arcache(xbar_to_m00_couplers_ARCACHE),
        .S_AXI_arlen(xbar_to_m00_couplers_ARLEN),
        .S_AXI_arlock(xbar_to_m00_couplers_ARLOCK),
        .S_AXI_arprot(xbar_to_m00_couplers_ARPROT),
        .S_AXI_arqos(xbar_to_m00_couplers_ARQOS),
        .S_AXI_arready(xbar_to_m00_couplers_ARREADY),
        .S_AXI_arregion(xbar_to_m00_couplers_ARREGION),
        .S_AXI_arsize(xbar_to_m00_couplers_ARSIZE),
        .S_AXI_arvalid(xbar_to_m00_couplers_ARVALID),
        .S_AXI_awaddr(xbar_to_m00_couplers_AWADDR),
        .S_AXI_awburst(xbar_to_m00_couplers_AWBURST),
        .S_AXI_awcache(xbar_to_m00_couplers_AWCACHE),
        .S_AXI_awlen(xbar_to_m00_couplers_AWLEN),
        .S_AXI_awlock(xbar_to_m00_couplers_AWLOCK),
        .S_AXI_awprot(xbar_to_m00_couplers_AWPROT),
        .S_AXI_awqos(xbar_to_m00_couplers_AWQOS),
        .S_AXI_awready(xbar_to_m00_couplers_AWREADY),
        .S_AXI_awregion(xbar_to_m00_couplers_AWREGION),
        .S_AXI_awsize(xbar_to_m00_couplers_AWSIZE),
        .S_AXI_awvalid(xbar_to_m00_couplers_AWVALID),
        .S_AXI_bready(xbar_to_m00_couplers_BREADY),
        .S_AXI_bresp(xbar_to_m00_couplers_BRESP),
        .S_AXI_bvalid(xbar_to_m00_couplers_BVALID),
        .S_AXI_rdata(xbar_to_m00_couplers_RDATA),
        .S_AXI_rlast(xbar_to_m00_couplers_RLAST),
        .S_AXI_rready(xbar_to_m00_couplers_RREADY),
        .S_AXI_rresp(xbar_to_m00_couplers_RRESP),
        .S_AXI_rvalid(xbar_to_m00_couplers_RVALID),
        .S_AXI_wdata(xbar_to_m00_couplers_WDATA),
        .S_AXI_wlast(xbar_to_m00_couplers_WLAST),
        .S_AXI_wready(xbar_to_m00_couplers_WREADY),
        .S_AXI_wstrb(xbar_to_m00_couplers_WSTRB),
        .S_AXI_wvalid(xbar_to_m00_couplers_WVALID));
  m01_couplers_imp_RADNNA m01_couplers
       (.M_ACLK(axi_cpu_interconnect_ACLK_net),
        .M_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .M_AXI_araddr(m01_couplers_to_axi_cpu_interconnect_ARADDR),
        .M_AXI_arburst(m01_couplers_to_axi_cpu_interconnect_ARBURST),
        .M_AXI_arcache(m01_couplers_to_axi_cpu_interconnect_ARCACHE),
        .M_AXI_arlen(m01_couplers_to_axi_cpu_interconnect_ARLEN),
        .M_AXI_arlock(m01_couplers_to_axi_cpu_interconnect_ARLOCK),
        .M_AXI_arprot(m01_couplers_to_axi_cpu_interconnect_ARPROT),
        .M_AXI_arqos(m01_couplers_to_axi_cpu_interconnect_ARQOS),
        .M_AXI_arready(m01_couplers_to_axi_cpu_interconnect_ARREADY),
        .M_AXI_arregion(m01_couplers_to_axi_cpu_interconnect_ARREGION),
        .M_AXI_arsize(m01_couplers_to_axi_cpu_interconnect_ARSIZE),
        .M_AXI_arvalid(m01_couplers_to_axi_cpu_interconnect_ARVALID),
        .M_AXI_awaddr(m01_couplers_to_axi_cpu_interconnect_AWADDR),
        .M_AXI_awburst(m01_couplers_to_axi_cpu_interconnect_AWBURST),
        .M_AXI_awcache(m01_couplers_to_axi_cpu_interconnect_AWCACHE),
        .M_AXI_awlen(m01_couplers_to_axi_cpu_interconnect_AWLEN),
        .M_AXI_awlock(m01_couplers_to_axi_cpu_interconnect_AWLOCK),
        .M_AXI_awprot(m01_couplers_to_axi_cpu_interconnect_AWPROT),
        .M_AXI_awqos(m01_couplers_to_axi_cpu_interconnect_AWQOS),
        .M_AXI_awready(m01_couplers_to_axi_cpu_interconnect_AWREADY),
        .M_AXI_awregion(m01_couplers_to_axi_cpu_interconnect_AWREGION),
        .M_AXI_awsize(m01_couplers_to_axi_cpu_interconnect_AWSIZE),
        .M_AXI_awvalid(m01_couplers_to_axi_cpu_interconnect_AWVALID),
        .M_AXI_bready(m01_couplers_to_axi_cpu_interconnect_BREADY),
        .M_AXI_bresp(m01_couplers_to_axi_cpu_interconnect_BRESP),
        .M_AXI_bvalid(m01_couplers_to_axi_cpu_interconnect_BVALID),
        .M_AXI_rdata(m01_couplers_to_axi_cpu_interconnect_RDATA),
        .M_AXI_rlast(m01_couplers_to_axi_cpu_interconnect_RLAST),
        .M_AXI_rready(m01_couplers_to_axi_cpu_interconnect_RREADY),
        .M_AXI_rresp(m01_couplers_to_axi_cpu_interconnect_RRESP),
        .M_AXI_rvalid(m01_couplers_to_axi_cpu_interconnect_RVALID),
        .M_AXI_wdata(m01_couplers_to_axi_cpu_interconnect_WDATA),
        .M_AXI_wlast(m01_couplers_to_axi_cpu_interconnect_WLAST),
        .M_AXI_wready(m01_couplers_to_axi_cpu_interconnect_WREADY),
        .M_AXI_wstrb(m01_couplers_to_axi_cpu_interconnect_WSTRB),
        .M_AXI_wvalid(m01_couplers_to_axi_cpu_interconnect_WVALID),
        .S_ACLK(axi_cpu_interconnect_ACLK_net),
        .S_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .S_AXI_araddr(xbar_to_m01_couplers_ARADDR),
        .S_AXI_arburst(xbar_to_m01_couplers_ARBURST),
        .S_AXI_arcache(xbar_to_m01_couplers_ARCACHE),
        .S_AXI_arlen(xbar_to_m01_couplers_ARLEN),
        .S_AXI_arlock(xbar_to_m01_couplers_ARLOCK),
        .S_AXI_arprot(xbar_to_m01_couplers_ARPROT),
        .S_AXI_arqos(xbar_to_m01_couplers_ARQOS),
        .S_AXI_arready(xbar_to_m01_couplers_ARREADY),
        .S_AXI_arregion(xbar_to_m01_couplers_ARREGION),
        .S_AXI_arsize(xbar_to_m01_couplers_ARSIZE),
        .S_AXI_arvalid(xbar_to_m01_couplers_ARVALID),
        .S_AXI_awaddr(xbar_to_m01_couplers_AWADDR),
        .S_AXI_awburst(xbar_to_m01_couplers_AWBURST),
        .S_AXI_awcache(xbar_to_m01_couplers_AWCACHE),
        .S_AXI_awlen(xbar_to_m01_couplers_AWLEN),
        .S_AXI_awlock(xbar_to_m01_couplers_AWLOCK),
        .S_AXI_awprot(xbar_to_m01_couplers_AWPROT),
        .S_AXI_awqos(xbar_to_m01_couplers_AWQOS),
        .S_AXI_awready(xbar_to_m01_couplers_AWREADY),
        .S_AXI_awregion(xbar_to_m01_couplers_AWREGION),
        .S_AXI_awsize(xbar_to_m01_couplers_AWSIZE),
        .S_AXI_awvalid(xbar_to_m01_couplers_AWVALID),
        .S_AXI_bready(xbar_to_m01_couplers_BREADY),
        .S_AXI_bresp(xbar_to_m01_couplers_BRESP),
        .S_AXI_bvalid(xbar_to_m01_couplers_BVALID),
        .S_AXI_rdata(xbar_to_m01_couplers_RDATA),
        .S_AXI_rlast(xbar_to_m01_couplers_RLAST),
        .S_AXI_rready(xbar_to_m01_couplers_RREADY),
        .S_AXI_rresp(xbar_to_m01_couplers_RRESP),
        .S_AXI_rvalid(xbar_to_m01_couplers_RVALID),
        .S_AXI_wdata(xbar_to_m01_couplers_WDATA),
        .S_AXI_wlast(xbar_to_m01_couplers_WLAST),
        .S_AXI_wready(xbar_to_m01_couplers_WREADY),
        .S_AXI_wstrb(xbar_to_m01_couplers_WSTRB),
        .S_AXI_wvalid(xbar_to_m01_couplers_WVALID));
  m02_couplers_imp_PAANJQ m02_couplers
       (.M_ACLK(axi_cpu_interconnect_ACLK_net),
        .M_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .M_AXI_araddr(m02_couplers_to_axi_cpu_interconnect_ARADDR),
        .M_AXI_arready(m02_couplers_to_axi_cpu_interconnect_ARREADY),
        .M_AXI_arvalid(m02_couplers_to_axi_cpu_interconnect_ARVALID),
        .M_AXI_awaddr(m02_couplers_to_axi_cpu_interconnect_AWADDR),
        .M_AXI_awready(m02_couplers_to_axi_cpu_interconnect_AWREADY),
        .M_AXI_awvalid(m02_couplers_to_axi_cpu_interconnect_AWVALID),
        .M_AXI_bready(m02_couplers_to_axi_cpu_interconnect_BREADY),
        .M_AXI_bresp(m02_couplers_to_axi_cpu_interconnect_BRESP),
        .M_AXI_bvalid(m02_couplers_to_axi_cpu_interconnect_BVALID),
        .M_AXI_rdata(m02_couplers_to_axi_cpu_interconnect_RDATA),
        .M_AXI_rready(m02_couplers_to_axi_cpu_interconnect_RREADY),
        .M_AXI_rresp(m02_couplers_to_axi_cpu_interconnect_RRESP),
        .M_AXI_rvalid(m02_couplers_to_axi_cpu_interconnect_RVALID),
        .M_AXI_wdata(m02_couplers_to_axi_cpu_interconnect_WDATA),
        .M_AXI_wready(m02_couplers_to_axi_cpu_interconnect_WREADY),
        .M_AXI_wvalid(m02_couplers_to_axi_cpu_interconnect_WVALID),
        .S_ACLK(axi_cpu_interconnect_ACLK_net),
        .S_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .S_AXI_araddr(xbar_to_m02_couplers_ARADDR),
        .S_AXI_arburst(xbar_to_m02_couplers_ARBURST),
        .S_AXI_arcache(xbar_to_m02_couplers_ARCACHE),
        .S_AXI_arlen(xbar_to_m02_couplers_ARLEN),
        .S_AXI_arlock(xbar_to_m02_couplers_ARLOCK),
        .S_AXI_arprot(xbar_to_m02_couplers_ARPROT),
        .S_AXI_arqos(xbar_to_m02_couplers_ARQOS),
        .S_AXI_arready(xbar_to_m02_couplers_ARREADY),
        .S_AXI_arregion(xbar_to_m02_couplers_ARREGION),
        .S_AXI_arsize(xbar_to_m02_couplers_ARSIZE),
        .S_AXI_arvalid(xbar_to_m02_couplers_ARVALID),
        .S_AXI_awaddr(xbar_to_m02_couplers_AWADDR),
        .S_AXI_awburst(xbar_to_m02_couplers_AWBURST),
        .S_AXI_awcache(xbar_to_m02_couplers_AWCACHE),
        .S_AXI_awlen(xbar_to_m02_couplers_AWLEN),
        .S_AXI_awlock(xbar_to_m02_couplers_AWLOCK),
        .S_AXI_awprot(xbar_to_m02_couplers_AWPROT),
        .S_AXI_awqos(xbar_to_m02_couplers_AWQOS),
        .S_AXI_awready(xbar_to_m02_couplers_AWREADY),
        .S_AXI_awregion(xbar_to_m02_couplers_AWREGION),
        .S_AXI_awsize(xbar_to_m02_couplers_AWSIZE),
        .S_AXI_awvalid(xbar_to_m02_couplers_AWVALID),
        .S_AXI_bready(xbar_to_m02_couplers_BREADY),
        .S_AXI_bresp(xbar_to_m02_couplers_BRESP),
        .S_AXI_bvalid(xbar_to_m02_couplers_BVALID),
        .S_AXI_rdata(xbar_to_m02_couplers_RDATA),
        .S_AXI_rlast(xbar_to_m02_couplers_RLAST),
        .S_AXI_rready(xbar_to_m02_couplers_RREADY),
        .S_AXI_rresp(xbar_to_m02_couplers_RRESP),
        .S_AXI_rvalid(xbar_to_m02_couplers_RVALID),
        .S_AXI_wdata(xbar_to_m02_couplers_WDATA),
        .S_AXI_wlast(xbar_to_m02_couplers_WLAST),
        .S_AXI_wready(xbar_to_m02_couplers_WREADY),
        .S_AXI_wstrb(xbar_to_m02_couplers_WSTRB),
        .S_AXI_wvalid(xbar_to_m02_couplers_WVALID));
  m03_couplers_imp_L3IIYE m03_couplers
       (.M_ACLK(axi_cpu_interconnect_ACLK_net),
        .M_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .M_AXI_araddr(m03_couplers_to_axi_cpu_interconnect_ARADDR),
        .M_AXI_arready(m03_couplers_to_axi_cpu_interconnect_ARREADY),
        .M_AXI_arvalid(m03_couplers_to_axi_cpu_interconnect_ARVALID),
        .M_AXI_awaddr(m03_couplers_to_axi_cpu_interconnect_AWADDR),
        .M_AXI_awready(m03_couplers_to_axi_cpu_interconnect_AWREADY),
        .M_AXI_awvalid(m03_couplers_to_axi_cpu_interconnect_AWVALID),
        .M_AXI_bready(m03_couplers_to_axi_cpu_interconnect_BREADY),
        .M_AXI_bresp(m03_couplers_to_axi_cpu_interconnect_BRESP),
        .M_AXI_bvalid(m03_couplers_to_axi_cpu_interconnect_BVALID),
        .M_AXI_rdata(m03_couplers_to_axi_cpu_interconnect_RDATA),
        .M_AXI_rready(m03_couplers_to_axi_cpu_interconnect_RREADY),
        .M_AXI_rresp(m03_couplers_to_axi_cpu_interconnect_RRESP),
        .M_AXI_rvalid(m03_couplers_to_axi_cpu_interconnect_RVALID),
        .M_AXI_wdata(m03_couplers_to_axi_cpu_interconnect_WDATA),
        .M_AXI_wready(m03_couplers_to_axi_cpu_interconnect_WREADY),
        .M_AXI_wstrb(m03_couplers_to_axi_cpu_interconnect_WSTRB),
        .M_AXI_wvalid(m03_couplers_to_axi_cpu_interconnect_WVALID),
        .S_ACLK(axi_cpu_interconnect_ACLK_net),
        .S_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .S_AXI_araddr(xbar_to_m03_couplers_ARADDR),
        .S_AXI_arburst(xbar_to_m03_couplers_ARBURST),
        .S_AXI_arcache(xbar_to_m03_couplers_ARCACHE),
        .S_AXI_arlen(xbar_to_m03_couplers_ARLEN),
        .S_AXI_arlock(xbar_to_m03_couplers_ARLOCK),
        .S_AXI_arprot(xbar_to_m03_couplers_ARPROT),
        .S_AXI_arqos(xbar_to_m03_couplers_ARQOS),
        .S_AXI_arready(xbar_to_m03_couplers_ARREADY),
        .S_AXI_arregion(xbar_to_m03_couplers_ARREGION),
        .S_AXI_arsize(xbar_to_m03_couplers_ARSIZE),
        .S_AXI_arvalid(xbar_to_m03_couplers_ARVALID),
        .S_AXI_awaddr(xbar_to_m03_couplers_AWADDR),
        .S_AXI_awburst(xbar_to_m03_couplers_AWBURST),
        .S_AXI_awcache(xbar_to_m03_couplers_AWCACHE),
        .S_AXI_awlen(xbar_to_m03_couplers_AWLEN),
        .S_AXI_awlock(xbar_to_m03_couplers_AWLOCK),
        .S_AXI_awprot(xbar_to_m03_couplers_AWPROT),
        .S_AXI_awqos(xbar_to_m03_couplers_AWQOS),
        .S_AXI_awready(xbar_to_m03_couplers_AWREADY),
        .S_AXI_awregion(xbar_to_m03_couplers_AWREGION),
        .S_AXI_awsize(xbar_to_m03_couplers_AWSIZE),
        .S_AXI_awvalid(xbar_to_m03_couplers_AWVALID),
        .S_AXI_bready(xbar_to_m03_couplers_BREADY),
        .S_AXI_bresp(xbar_to_m03_couplers_BRESP),
        .S_AXI_bvalid(xbar_to_m03_couplers_BVALID),
        .S_AXI_rdata(xbar_to_m03_couplers_RDATA),
        .S_AXI_rlast(xbar_to_m03_couplers_RLAST),
        .S_AXI_rready(xbar_to_m03_couplers_RREADY),
        .S_AXI_rresp(xbar_to_m03_couplers_RRESP),
        .S_AXI_rvalid(xbar_to_m03_couplers_RVALID),
        .S_AXI_wdata(xbar_to_m03_couplers_WDATA),
        .S_AXI_wlast(xbar_to_m03_couplers_WLAST),
        .S_AXI_wready(xbar_to_m03_couplers_WREADY),
        .S_AXI_wstrb(xbar_to_m03_couplers_WSTRB),
        .S_AXI_wvalid(xbar_to_m03_couplers_WVALID));
  m04_couplers_imp_BLOJEE m04_couplers
       (.M_ACLK(axi_cpu_interconnect_ACLK_net),
        .M_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .M_AXI_araddr(m04_couplers_to_axi_cpu_interconnect_ARADDR),
        .M_AXI_arready(m04_couplers_to_axi_cpu_interconnect_ARREADY),
        .M_AXI_arvalid(m04_couplers_to_axi_cpu_interconnect_ARVALID),
        .M_AXI_awaddr(m04_couplers_to_axi_cpu_interconnect_AWADDR),
        .M_AXI_awready(m04_couplers_to_axi_cpu_interconnect_AWREADY),
        .M_AXI_awvalid(m04_couplers_to_axi_cpu_interconnect_AWVALID),
        .M_AXI_bready(m04_couplers_to_axi_cpu_interconnect_BREADY),
        .M_AXI_bresp(m04_couplers_to_axi_cpu_interconnect_BRESP),
        .M_AXI_bvalid(m04_couplers_to_axi_cpu_interconnect_BVALID),
        .M_AXI_rdata(m04_couplers_to_axi_cpu_interconnect_RDATA),
        .M_AXI_rready(m04_couplers_to_axi_cpu_interconnect_RREADY),
        .M_AXI_rresp(m04_couplers_to_axi_cpu_interconnect_RRESP),
        .M_AXI_rvalid(m04_couplers_to_axi_cpu_interconnect_RVALID),
        .M_AXI_wdata(m04_couplers_to_axi_cpu_interconnect_WDATA),
        .M_AXI_wready(m04_couplers_to_axi_cpu_interconnect_WREADY),
        .M_AXI_wstrb(m04_couplers_to_axi_cpu_interconnect_WSTRB),
        .M_AXI_wvalid(m04_couplers_to_axi_cpu_interconnect_WVALID),
        .S_ACLK(axi_cpu_interconnect_ACLK_net),
        .S_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .S_AXI_araddr(xbar_to_m04_couplers_ARADDR),
        .S_AXI_arburst(xbar_to_m04_couplers_ARBURST),
        .S_AXI_arcache(xbar_to_m04_couplers_ARCACHE),
        .S_AXI_arlen(xbar_to_m04_couplers_ARLEN),
        .S_AXI_arlock(xbar_to_m04_couplers_ARLOCK),
        .S_AXI_arprot(xbar_to_m04_couplers_ARPROT),
        .S_AXI_arqos(xbar_to_m04_couplers_ARQOS),
        .S_AXI_arready(xbar_to_m04_couplers_ARREADY),
        .S_AXI_arregion(xbar_to_m04_couplers_ARREGION),
        .S_AXI_arsize(xbar_to_m04_couplers_ARSIZE),
        .S_AXI_arvalid(xbar_to_m04_couplers_ARVALID),
        .S_AXI_awaddr(xbar_to_m04_couplers_AWADDR),
        .S_AXI_awburst(xbar_to_m04_couplers_AWBURST),
        .S_AXI_awcache(xbar_to_m04_couplers_AWCACHE),
        .S_AXI_awlen(xbar_to_m04_couplers_AWLEN),
        .S_AXI_awlock(xbar_to_m04_couplers_AWLOCK),
        .S_AXI_awprot(xbar_to_m04_couplers_AWPROT),
        .S_AXI_awqos(xbar_to_m04_couplers_AWQOS),
        .S_AXI_awready(xbar_to_m04_couplers_AWREADY),
        .S_AXI_awregion(xbar_to_m04_couplers_AWREGION),
        .S_AXI_awsize(xbar_to_m04_couplers_AWSIZE),
        .S_AXI_awvalid(xbar_to_m04_couplers_AWVALID),
        .S_AXI_bready(xbar_to_m04_couplers_BREADY),
        .S_AXI_bresp(xbar_to_m04_couplers_BRESP),
        .S_AXI_bvalid(xbar_to_m04_couplers_BVALID),
        .S_AXI_rdata(xbar_to_m04_couplers_RDATA),
        .S_AXI_rlast(xbar_to_m04_couplers_RLAST),
        .S_AXI_rready(xbar_to_m04_couplers_RREADY),
        .S_AXI_rresp(xbar_to_m04_couplers_RRESP),
        .S_AXI_rvalid(xbar_to_m04_couplers_RVALID),
        .S_AXI_wdata(xbar_to_m04_couplers_WDATA),
        .S_AXI_wlast(xbar_to_m04_couplers_WLAST),
        .S_AXI_wready(xbar_to_m04_couplers_WREADY),
        .S_AXI_wstrb(xbar_to_m04_couplers_WSTRB),
        .S_AXI_wvalid(xbar_to_m04_couplers_WVALID));
  m05_couplers_imp_HH0EEU m05_couplers
       (.M_ACLK(axi_cpu_interconnect_ACLK_net),
        .M_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .M_AXI_araddr(m05_couplers_to_axi_cpu_interconnect_ARADDR),
        .M_AXI_arready(m05_couplers_to_axi_cpu_interconnect_ARREADY),
        .M_AXI_arvalid(m05_couplers_to_axi_cpu_interconnect_ARVALID),
        .M_AXI_awaddr(m05_couplers_to_axi_cpu_interconnect_AWADDR),
        .M_AXI_awready(m05_couplers_to_axi_cpu_interconnect_AWREADY),
        .M_AXI_awvalid(m05_couplers_to_axi_cpu_interconnect_AWVALID),
        .M_AXI_bready(m05_couplers_to_axi_cpu_interconnect_BREADY),
        .M_AXI_bresp(m05_couplers_to_axi_cpu_interconnect_BRESP),
        .M_AXI_bvalid(m05_couplers_to_axi_cpu_interconnect_BVALID),
        .M_AXI_rdata(m05_couplers_to_axi_cpu_interconnect_RDATA),
        .M_AXI_rready(m05_couplers_to_axi_cpu_interconnect_RREADY),
        .M_AXI_rresp(m05_couplers_to_axi_cpu_interconnect_RRESP),
        .M_AXI_rvalid(m05_couplers_to_axi_cpu_interconnect_RVALID),
        .M_AXI_wdata(m05_couplers_to_axi_cpu_interconnect_WDATA),
        .M_AXI_wready(m05_couplers_to_axi_cpu_interconnect_WREADY),
        .M_AXI_wstrb(m05_couplers_to_axi_cpu_interconnect_WSTRB),
        .M_AXI_wvalid(m05_couplers_to_axi_cpu_interconnect_WVALID),
        .S_ACLK(axi_cpu_interconnect_ACLK_net),
        .S_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .S_AXI_araddr(xbar_to_m05_couplers_ARADDR),
        .S_AXI_arburst(xbar_to_m05_couplers_ARBURST),
        .S_AXI_arcache(xbar_to_m05_couplers_ARCACHE),
        .S_AXI_arlen(xbar_to_m05_couplers_ARLEN),
        .S_AXI_arlock(xbar_to_m05_couplers_ARLOCK),
        .S_AXI_arprot(xbar_to_m05_couplers_ARPROT),
        .S_AXI_arqos(xbar_to_m05_couplers_ARQOS),
        .S_AXI_arready(xbar_to_m05_couplers_ARREADY),
        .S_AXI_arregion(xbar_to_m05_couplers_ARREGION),
        .S_AXI_arsize(xbar_to_m05_couplers_ARSIZE),
        .S_AXI_arvalid(xbar_to_m05_couplers_ARVALID),
        .S_AXI_awaddr(xbar_to_m05_couplers_AWADDR),
        .S_AXI_awburst(xbar_to_m05_couplers_AWBURST),
        .S_AXI_awcache(xbar_to_m05_couplers_AWCACHE),
        .S_AXI_awlen(xbar_to_m05_couplers_AWLEN),
        .S_AXI_awlock(xbar_to_m05_couplers_AWLOCK),
        .S_AXI_awprot(xbar_to_m05_couplers_AWPROT),
        .S_AXI_awqos(xbar_to_m05_couplers_AWQOS),
        .S_AXI_awready(xbar_to_m05_couplers_AWREADY),
        .S_AXI_awregion(xbar_to_m05_couplers_AWREGION),
        .S_AXI_awsize(xbar_to_m05_couplers_AWSIZE),
        .S_AXI_awvalid(xbar_to_m05_couplers_AWVALID),
        .S_AXI_bready(xbar_to_m05_couplers_BREADY),
        .S_AXI_bresp(xbar_to_m05_couplers_BRESP),
        .S_AXI_bvalid(xbar_to_m05_couplers_BVALID),
        .S_AXI_rdata(xbar_to_m05_couplers_RDATA),
        .S_AXI_rlast(xbar_to_m05_couplers_RLAST),
        .S_AXI_rready(xbar_to_m05_couplers_RREADY),
        .S_AXI_rresp(xbar_to_m05_couplers_RRESP),
        .S_AXI_rvalid(xbar_to_m05_couplers_RVALID),
        .S_AXI_wdata(xbar_to_m05_couplers_WDATA),
        .S_AXI_wlast(xbar_to_m05_couplers_WLAST),
        .S_AXI_wready(xbar_to_m05_couplers_WREADY),
        .S_AXI_wstrb(xbar_to_m05_couplers_WSTRB),
        .S_AXI_wvalid(xbar_to_m05_couplers_WVALID));
  m06_couplers_imp_22XKMU m06_couplers
       (.M_ACLK(axi_cpu_interconnect_ACLK_net),
        .M_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .M_AXI_araddr(m06_couplers_to_axi_cpu_interconnect_ARADDR),
        .M_AXI_arready(m06_couplers_to_axi_cpu_interconnect_ARREADY),
        .M_AXI_arvalid(m06_couplers_to_axi_cpu_interconnect_ARVALID),
        .M_AXI_awaddr(m06_couplers_to_axi_cpu_interconnect_AWADDR),
        .M_AXI_awready(m06_couplers_to_axi_cpu_interconnect_AWREADY),
        .M_AXI_awvalid(m06_couplers_to_axi_cpu_interconnect_AWVALID),
        .M_AXI_bready(m06_couplers_to_axi_cpu_interconnect_BREADY),
        .M_AXI_bresp(m06_couplers_to_axi_cpu_interconnect_BRESP),
        .M_AXI_bvalid(m06_couplers_to_axi_cpu_interconnect_BVALID),
        .M_AXI_rdata(m06_couplers_to_axi_cpu_interconnect_RDATA),
        .M_AXI_rready(m06_couplers_to_axi_cpu_interconnect_RREADY),
        .M_AXI_rresp(m06_couplers_to_axi_cpu_interconnect_RRESP),
        .M_AXI_rvalid(m06_couplers_to_axi_cpu_interconnect_RVALID),
        .M_AXI_wdata(m06_couplers_to_axi_cpu_interconnect_WDATA),
        .M_AXI_wready(m06_couplers_to_axi_cpu_interconnect_WREADY),
        .M_AXI_wstrb(m06_couplers_to_axi_cpu_interconnect_WSTRB),
        .M_AXI_wvalid(m06_couplers_to_axi_cpu_interconnect_WVALID),
        .S_ACLK(axi_cpu_interconnect_ACLK_net),
        .S_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .S_AXI_araddr(xbar_to_m06_couplers_ARADDR),
        .S_AXI_arburst(xbar_to_m06_couplers_ARBURST),
        .S_AXI_arcache(xbar_to_m06_couplers_ARCACHE),
        .S_AXI_arlen(xbar_to_m06_couplers_ARLEN),
        .S_AXI_arlock(xbar_to_m06_couplers_ARLOCK),
        .S_AXI_arprot(xbar_to_m06_couplers_ARPROT),
        .S_AXI_arqos(xbar_to_m06_couplers_ARQOS),
        .S_AXI_arready(xbar_to_m06_couplers_ARREADY),
        .S_AXI_arregion(xbar_to_m06_couplers_ARREGION),
        .S_AXI_arsize(xbar_to_m06_couplers_ARSIZE),
        .S_AXI_arvalid(xbar_to_m06_couplers_ARVALID),
        .S_AXI_awaddr(xbar_to_m06_couplers_AWADDR),
        .S_AXI_awburst(xbar_to_m06_couplers_AWBURST),
        .S_AXI_awcache(xbar_to_m06_couplers_AWCACHE),
        .S_AXI_awlen(xbar_to_m06_couplers_AWLEN),
        .S_AXI_awlock(xbar_to_m06_couplers_AWLOCK),
        .S_AXI_awprot(xbar_to_m06_couplers_AWPROT),
        .S_AXI_awqos(xbar_to_m06_couplers_AWQOS),
        .S_AXI_awready(xbar_to_m06_couplers_AWREADY),
        .S_AXI_awregion(xbar_to_m06_couplers_AWREGION),
        .S_AXI_awsize(xbar_to_m06_couplers_AWSIZE),
        .S_AXI_awvalid(xbar_to_m06_couplers_AWVALID),
        .S_AXI_bready(xbar_to_m06_couplers_BREADY),
        .S_AXI_bresp(xbar_to_m06_couplers_BRESP),
        .S_AXI_bvalid(xbar_to_m06_couplers_BVALID),
        .S_AXI_rdata(xbar_to_m06_couplers_RDATA),
        .S_AXI_rlast(xbar_to_m06_couplers_RLAST),
        .S_AXI_rready(xbar_to_m06_couplers_RREADY),
        .S_AXI_rresp(xbar_to_m06_couplers_RRESP),
        .S_AXI_rvalid(xbar_to_m06_couplers_RVALID),
        .S_AXI_wdata(xbar_to_m06_couplers_WDATA),
        .S_AXI_wlast(xbar_to_m06_couplers_WLAST),
        .S_AXI_wready(xbar_to_m06_couplers_WREADY),
        .S_AXI_wstrb(xbar_to_m06_couplers_WSTRB),
        .S_AXI_wvalid(xbar_to_m06_couplers_WVALID));
  m07_couplers_imp_4MDLKM m07_couplers
       (.M_ACLK(axi_cpu_interconnect_ACLK_net),
        .M_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .M_AXI_araddr(m07_couplers_to_axi_cpu_interconnect_ARADDR),
        .M_AXI_arburst(m07_couplers_to_axi_cpu_interconnect_ARBURST),
        .M_AXI_arcache(m07_couplers_to_axi_cpu_interconnect_ARCACHE),
        .M_AXI_arlen(m07_couplers_to_axi_cpu_interconnect_ARLEN),
        .M_AXI_arlock(m07_couplers_to_axi_cpu_interconnect_ARLOCK),
        .M_AXI_arprot(m07_couplers_to_axi_cpu_interconnect_ARPROT),
        .M_AXI_arqos(m07_couplers_to_axi_cpu_interconnect_ARQOS),
        .M_AXI_arready(m07_couplers_to_axi_cpu_interconnect_ARREADY),
        .M_AXI_arregion(m07_couplers_to_axi_cpu_interconnect_ARREGION),
        .M_AXI_arsize(m07_couplers_to_axi_cpu_interconnect_ARSIZE),
        .M_AXI_arvalid(m07_couplers_to_axi_cpu_interconnect_ARVALID),
        .M_AXI_awaddr(m07_couplers_to_axi_cpu_interconnect_AWADDR),
        .M_AXI_awburst(m07_couplers_to_axi_cpu_interconnect_AWBURST),
        .M_AXI_awcache(m07_couplers_to_axi_cpu_interconnect_AWCACHE),
        .M_AXI_awlen(m07_couplers_to_axi_cpu_interconnect_AWLEN),
        .M_AXI_awlock(m07_couplers_to_axi_cpu_interconnect_AWLOCK),
        .M_AXI_awprot(m07_couplers_to_axi_cpu_interconnect_AWPROT),
        .M_AXI_awqos(m07_couplers_to_axi_cpu_interconnect_AWQOS),
        .M_AXI_awready(m07_couplers_to_axi_cpu_interconnect_AWREADY),
        .M_AXI_awregion(m07_couplers_to_axi_cpu_interconnect_AWREGION),
        .M_AXI_awsize(m07_couplers_to_axi_cpu_interconnect_AWSIZE),
        .M_AXI_awvalid(m07_couplers_to_axi_cpu_interconnect_AWVALID),
        .M_AXI_bready(m07_couplers_to_axi_cpu_interconnect_BREADY),
        .M_AXI_bresp(m07_couplers_to_axi_cpu_interconnect_BRESP),
        .M_AXI_bvalid(m07_couplers_to_axi_cpu_interconnect_BVALID),
        .M_AXI_rdata(m07_couplers_to_axi_cpu_interconnect_RDATA),
        .M_AXI_rlast(m07_couplers_to_axi_cpu_interconnect_RLAST),
        .M_AXI_rready(m07_couplers_to_axi_cpu_interconnect_RREADY),
        .M_AXI_rresp(m07_couplers_to_axi_cpu_interconnect_RRESP),
        .M_AXI_rvalid(m07_couplers_to_axi_cpu_interconnect_RVALID),
        .M_AXI_wdata(m07_couplers_to_axi_cpu_interconnect_WDATA),
        .M_AXI_wlast(m07_couplers_to_axi_cpu_interconnect_WLAST),
        .M_AXI_wready(m07_couplers_to_axi_cpu_interconnect_WREADY),
        .M_AXI_wstrb(m07_couplers_to_axi_cpu_interconnect_WSTRB),
        .M_AXI_wvalid(m07_couplers_to_axi_cpu_interconnect_WVALID),
        .S_ACLK(axi_cpu_interconnect_ACLK_net),
        .S_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .S_AXI_araddr(xbar_to_m07_couplers_ARADDR),
        .S_AXI_arburst(xbar_to_m07_couplers_ARBURST),
        .S_AXI_arcache(xbar_to_m07_couplers_ARCACHE),
        .S_AXI_arlen(xbar_to_m07_couplers_ARLEN),
        .S_AXI_arlock(xbar_to_m07_couplers_ARLOCK),
        .S_AXI_arprot(xbar_to_m07_couplers_ARPROT),
        .S_AXI_arqos(xbar_to_m07_couplers_ARQOS),
        .S_AXI_arready(xbar_to_m07_couplers_ARREADY),
        .S_AXI_arregion(xbar_to_m07_couplers_ARREGION),
        .S_AXI_arsize(xbar_to_m07_couplers_ARSIZE),
        .S_AXI_arvalid(xbar_to_m07_couplers_ARVALID),
        .S_AXI_awaddr(xbar_to_m07_couplers_AWADDR),
        .S_AXI_awburst(xbar_to_m07_couplers_AWBURST),
        .S_AXI_awcache(xbar_to_m07_couplers_AWCACHE),
        .S_AXI_awlen(xbar_to_m07_couplers_AWLEN),
        .S_AXI_awlock(xbar_to_m07_couplers_AWLOCK),
        .S_AXI_awprot(xbar_to_m07_couplers_AWPROT),
        .S_AXI_awqos(xbar_to_m07_couplers_AWQOS),
        .S_AXI_awready(xbar_to_m07_couplers_AWREADY),
        .S_AXI_awregion(xbar_to_m07_couplers_AWREGION),
        .S_AXI_awsize(xbar_to_m07_couplers_AWSIZE),
        .S_AXI_awvalid(xbar_to_m07_couplers_AWVALID),
        .S_AXI_bready(xbar_to_m07_couplers_BREADY),
        .S_AXI_bresp(xbar_to_m07_couplers_BRESP),
        .S_AXI_bvalid(xbar_to_m07_couplers_BVALID),
        .S_AXI_rdata(xbar_to_m07_couplers_RDATA),
        .S_AXI_rlast(xbar_to_m07_couplers_RLAST),
        .S_AXI_rready(xbar_to_m07_couplers_RREADY),
        .S_AXI_rresp(xbar_to_m07_couplers_RRESP),
        .S_AXI_rvalid(xbar_to_m07_couplers_RVALID),
        .S_AXI_wdata(xbar_to_m07_couplers_WDATA),
        .S_AXI_wlast(xbar_to_m07_couplers_WLAST),
        .S_AXI_wready(xbar_to_m07_couplers_WREADY),
        .S_AXI_wstrb(xbar_to_m07_couplers_WSTRB),
        .S_AXI_wvalid(xbar_to_m07_couplers_WVALID));
  m08_couplers_imp_1KNNGVQ m08_couplers
       (.M_ACLK(axi_cpu_interconnect_ACLK_net),
        .M_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .M_AXI_araddr(m08_couplers_to_axi_cpu_interconnect_ARADDR),
        .M_AXI_arready(m08_couplers_to_axi_cpu_interconnect_ARREADY),
        .M_AXI_arvalid(m08_couplers_to_axi_cpu_interconnect_ARVALID),
        .M_AXI_awaddr(m08_couplers_to_axi_cpu_interconnect_AWADDR),
        .M_AXI_awready(m08_couplers_to_axi_cpu_interconnect_AWREADY),
        .M_AXI_awvalid(m08_couplers_to_axi_cpu_interconnect_AWVALID),
        .M_AXI_bready(m08_couplers_to_axi_cpu_interconnect_BREADY),
        .M_AXI_bresp(m08_couplers_to_axi_cpu_interconnect_BRESP),
        .M_AXI_bvalid(m08_couplers_to_axi_cpu_interconnect_BVALID),
        .M_AXI_rdata(m08_couplers_to_axi_cpu_interconnect_RDATA),
        .M_AXI_rready(m08_couplers_to_axi_cpu_interconnect_RREADY),
        .M_AXI_rresp(m08_couplers_to_axi_cpu_interconnect_RRESP),
        .M_AXI_rvalid(m08_couplers_to_axi_cpu_interconnect_RVALID),
        .M_AXI_wdata(m08_couplers_to_axi_cpu_interconnect_WDATA),
        .M_AXI_wready(m08_couplers_to_axi_cpu_interconnect_WREADY),
        .M_AXI_wstrb(m08_couplers_to_axi_cpu_interconnect_WSTRB),
        .M_AXI_wvalid(m08_couplers_to_axi_cpu_interconnect_WVALID),
        .S_ACLK(axi_cpu_interconnect_ACLK_net),
        .S_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .S_AXI_araddr(xbar_to_m08_couplers_ARADDR),
        .S_AXI_arburst(xbar_to_m08_couplers_ARBURST),
        .S_AXI_arcache(xbar_to_m08_couplers_ARCACHE),
        .S_AXI_arlen(xbar_to_m08_couplers_ARLEN),
        .S_AXI_arlock(xbar_to_m08_couplers_ARLOCK),
        .S_AXI_arprot(xbar_to_m08_couplers_ARPROT),
        .S_AXI_arqos(xbar_to_m08_couplers_ARQOS),
        .S_AXI_arready(xbar_to_m08_couplers_ARREADY),
        .S_AXI_arregion(xbar_to_m08_couplers_ARREGION),
        .S_AXI_arsize(xbar_to_m08_couplers_ARSIZE),
        .S_AXI_arvalid(xbar_to_m08_couplers_ARVALID),
        .S_AXI_awaddr(xbar_to_m08_couplers_AWADDR),
        .S_AXI_awburst(xbar_to_m08_couplers_AWBURST),
        .S_AXI_awcache(xbar_to_m08_couplers_AWCACHE),
        .S_AXI_awlen(xbar_to_m08_couplers_AWLEN),
        .S_AXI_awlock(xbar_to_m08_couplers_AWLOCK),
        .S_AXI_awprot(xbar_to_m08_couplers_AWPROT),
        .S_AXI_awqos(xbar_to_m08_couplers_AWQOS),
        .S_AXI_awready(xbar_to_m08_couplers_AWREADY),
        .S_AXI_awregion(xbar_to_m08_couplers_AWREGION),
        .S_AXI_awsize(xbar_to_m08_couplers_AWSIZE),
        .S_AXI_awvalid(xbar_to_m08_couplers_AWVALID),
        .S_AXI_bready(xbar_to_m08_couplers_BREADY),
        .S_AXI_bresp(xbar_to_m08_couplers_BRESP),
        .S_AXI_bvalid(xbar_to_m08_couplers_BVALID),
        .S_AXI_rdata(xbar_to_m08_couplers_RDATA),
        .S_AXI_rlast(xbar_to_m08_couplers_RLAST),
        .S_AXI_rready(xbar_to_m08_couplers_RREADY),
        .S_AXI_rresp(xbar_to_m08_couplers_RRESP),
        .S_AXI_rvalid(xbar_to_m08_couplers_RVALID),
        .S_AXI_wdata(xbar_to_m08_couplers_WDATA),
        .S_AXI_wlast(xbar_to_m08_couplers_WLAST),
        .S_AXI_wready(xbar_to_m08_couplers_WREADY),
        .S_AXI_wstrb(xbar_to_m08_couplers_WSTRB),
        .S_AXI_wvalid(xbar_to_m08_couplers_WVALID));
  m09_couplers_imp_1OSK6BA m09_couplers
       (.M_ACLK(axi_cpu_interconnect_ACLK_net),
        .M_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .M_AXI_araddr(m09_couplers_to_axi_cpu_interconnect_ARADDR),
        .M_AXI_arready(m09_couplers_to_axi_cpu_interconnect_ARREADY),
        .M_AXI_arvalid(m09_couplers_to_axi_cpu_interconnect_ARVALID),
        .M_AXI_awaddr(m09_couplers_to_axi_cpu_interconnect_AWADDR),
        .M_AXI_awready(m09_couplers_to_axi_cpu_interconnect_AWREADY),
        .M_AXI_awvalid(m09_couplers_to_axi_cpu_interconnect_AWVALID),
        .M_AXI_bready(m09_couplers_to_axi_cpu_interconnect_BREADY),
        .M_AXI_bresp(m09_couplers_to_axi_cpu_interconnect_BRESP),
        .M_AXI_bvalid(m09_couplers_to_axi_cpu_interconnect_BVALID),
        .M_AXI_rdata(m09_couplers_to_axi_cpu_interconnect_RDATA),
        .M_AXI_rready(m09_couplers_to_axi_cpu_interconnect_RREADY),
        .M_AXI_rresp(m09_couplers_to_axi_cpu_interconnect_RRESP),
        .M_AXI_rvalid(m09_couplers_to_axi_cpu_interconnect_RVALID),
        .M_AXI_wdata(m09_couplers_to_axi_cpu_interconnect_WDATA),
        .M_AXI_wready(m09_couplers_to_axi_cpu_interconnect_WREADY),
        .M_AXI_wstrb(m09_couplers_to_axi_cpu_interconnect_WSTRB),
        .M_AXI_wvalid(m09_couplers_to_axi_cpu_interconnect_WVALID),
        .S_ACLK(axi_cpu_interconnect_ACLK_net),
        .S_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .S_AXI_araddr(xbar_to_m09_couplers_ARADDR),
        .S_AXI_arburst(xbar_to_m09_couplers_ARBURST),
        .S_AXI_arcache(xbar_to_m09_couplers_ARCACHE),
        .S_AXI_arlen(xbar_to_m09_couplers_ARLEN),
        .S_AXI_arlock(xbar_to_m09_couplers_ARLOCK),
        .S_AXI_arprot(xbar_to_m09_couplers_ARPROT),
        .S_AXI_arqos(xbar_to_m09_couplers_ARQOS),
        .S_AXI_arready(xbar_to_m09_couplers_ARREADY),
        .S_AXI_arregion(xbar_to_m09_couplers_ARREGION),
        .S_AXI_arsize(xbar_to_m09_couplers_ARSIZE),
        .S_AXI_arvalid(xbar_to_m09_couplers_ARVALID),
        .S_AXI_awaddr(xbar_to_m09_couplers_AWADDR),
        .S_AXI_awburst(xbar_to_m09_couplers_AWBURST),
        .S_AXI_awcache(xbar_to_m09_couplers_AWCACHE),
        .S_AXI_awlen(xbar_to_m09_couplers_AWLEN),
        .S_AXI_awlock(xbar_to_m09_couplers_AWLOCK),
        .S_AXI_awprot(xbar_to_m09_couplers_AWPROT),
        .S_AXI_awqos(xbar_to_m09_couplers_AWQOS),
        .S_AXI_awready(xbar_to_m09_couplers_AWREADY),
        .S_AXI_awregion(xbar_to_m09_couplers_AWREGION),
        .S_AXI_awsize(xbar_to_m09_couplers_AWSIZE),
        .S_AXI_awvalid(xbar_to_m09_couplers_AWVALID),
        .S_AXI_bready(xbar_to_m09_couplers_BREADY),
        .S_AXI_bresp(xbar_to_m09_couplers_BRESP),
        .S_AXI_bvalid(xbar_to_m09_couplers_BVALID),
        .S_AXI_rdata(xbar_to_m09_couplers_RDATA),
        .S_AXI_rlast(xbar_to_m09_couplers_RLAST),
        .S_AXI_rready(xbar_to_m09_couplers_RREADY),
        .S_AXI_rresp(xbar_to_m09_couplers_RRESP),
        .S_AXI_rvalid(xbar_to_m09_couplers_RVALID),
        .S_AXI_wdata(xbar_to_m09_couplers_WDATA),
        .S_AXI_wlast(xbar_to_m09_couplers_WLAST),
        .S_AXI_wready(xbar_to_m09_couplers_WREADY),
        .S_AXI_wstrb(xbar_to_m09_couplers_WSTRB),
        .S_AXI_wvalid(xbar_to_m09_couplers_WVALID));
  m10_couplers_imp_1U1F8BM m10_couplers
       (.M_ACLK(axi_cpu_interconnect_ACLK_net),
        .M_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .M_AXI_araddr(m10_couplers_to_axi_cpu_interconnect_ARADDR),
        .M_AXI_arready(m10_couplers_to_axi_cpu_interconnect_ARREADY),
        .M_AXI_arvalid(m10_couplers_to_axi_cpu_interconnect_ARVALID),
        .M_AXI_awaddr(m10_couplers_to_axi_cpu_interconnect_AWADDR),
        .M_AXI_awready(m10_couplers_to_axi_cpu_interconnect_AWREADY),
        .M_AXI_awvalid(m10_couplers_to_axi_cpu_interconnect_AWVALID),
        .M_AXI_bready(m10_couplers_to_axi_cpu_interconnect_BREADY),
        .M_AXI_bresp(m10_couplers_to_axi_cpu_interconnect_BRESP),
        .M_AXI_bvalid(m10_couplers_to_axi_cpu_interconnect_BVALID),
        .M_AXI_rdata(m10_couplers_to_axi_cpu_interconnect_RDATA),
        .M_AXI_rready(m10_couplers_to_axi_cpu_interconnect_RREADY),
        .M_AXI_rresp(m10_couplers_to_axi_cpu_interconnect_RRESP),
        .M_AXI_rvalid(m10_couplers_to_axi_cpu_interconnect_RVALID),
        .M_AXI_wdata(m10_couplers_to_axi_cpu_interconnect_WDATA),
        .M_AXI_wready(m10_couplers_to_axi_cpu_interconnect_WREADY),
        .M_AXI_wvalid(m10_couplers_to_axi_cpu_interconnect_WVALID),
        .S_ACLK(axi_cpu_interconnect_ACLK_net),
        .S_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .S_AXI_araddr(xbar_to_m10_couplers_ARADDR),
        .S_AXI_arburst(xbar_to_m10_couplers_ARBURST),
        .S_AXI_arcache(xbar_to_m10_couplers_ARCACHE),
        .S_AXI_arlen(xbar_to_m10_couplers_ARLEN),
        .S_AXI_arlock(xbar_to_m10_couplers_ARLOCK),
        .S_AXI_arprot(xbar_to_m10_couplers_ARPROT),
        .S_AXI_arqos(xbar_to_m10_couplers_ARQOS),
        .S_AXI_arready(xbar_to_m10_couplers_ARREADY),
        .S_AXI_arregion(xbar_to_m10_couplers_ARREGION),
        .S_AXI_arsize(xbar_to_m10_couplers_ARSIZE),
        .S_AXI_arvalid(xbar_to_m10_couplers_ARVALID),
        .S_AXI_awaddr(xbar_to_m10_couplers_AWADDR),
        .S_AXI_awburst(xbar_to_m10_couplers_AWBURST),
        .S_AXI_awcache(xbar_to_m10_couplers_AWCACHE),
        .S_AXI_awlen(xbar_to_m10_couplers_AWLEN),
        .S_AXI_awlock(xbar_to_m10_couplers_AWLOCK),
        .S_AXI_awprot(xbar_to_m10_couplers_AWPROT),
        .S_AXI_awqos(xbar_to_m10_couplers_AWQOS),
        .S_AXI_awready(xbar_to_m10_couplers_AWREADY),
        .S_AXI_awregion(xbar_to_m10_couplers_AWREGION),
        .S_AXI_awsize(xbar_to_m10_couplers_AWSIZE),
        .S_AXI_awvalid(xbar_to_m10_couplers_AWVALID),
        .S_AXI_bready(xbar_to_m10_couplers_BREADY),
        .S_AXI_bresp(xbar_to_m10_couplers_BRESP),
        .S_AXI_bvalid(xbar_to_m10_couplers_BVALID),
        .S_AXI_rdata(xbar_to_m10_couplers_RDATA),
        .S_AXI_rlast(xbar_to_m10_couplers_RLAST),
        .S_AXI_rready(xbar_to_m10_couplers_RREADY),
        .S_AXI_rresp(xbar_to_m10_couplers_RRESP),
        .S_AXI_rvalid(xbar_to_m10_couplers_RVALID),
        .S_AXI_wdata(xbar_to_m10_couplers_WDATA),
        .S_AXI_wlast(xbar_to_m10_couplers_WLAST),
        .S_AXI_wready(xbar_to_m10_couplers_WREADY),
        .S_AXI_wstrb(xbar_to_m10_couplers_WSTRB),
        .S_AXI_wvalid(xbar_to_m10_couplers_WVALID));
  m11_couplers_imp_1X4USKI m11_couplers
       (.M_ACLK(axi_cpu_interconnect_ACLK_net),
        .M_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .M_AXI_araddr(m11_couplers_to_axi_cpu_interconnect_ARADDR),
        .M_AXI_arprot(m11_couplers_to_axi_cpu_interconnect_ARPROT),
        .M_AXI_arready(m11_couplers_to_axi_cpu_interconnect_ARREADY),
        .M_AXI_arvalid(m11_couplers_to_axi_cpu_interconnect_ARVALID),
        .M_AXI_awaddr(m11_couplers_to_axi_cpu_interconnect_AWADDR),
        .M_AXI_awprot(m11_couplers_to_axi_cpu_interconnect_AWPROT),
        .M_AXI_awready(m11_couplers_to_axi_cpu_interconnect_AWREADY),
        .M_AXI_awvalid(m11_couplers_to_axi_cpu_interconnect_AWVALID),
        .M_AXI_bready(m11_couplers_to_axi_cpu_interconnect_BREADY),
        .M_AXI_bresp(m11_couplers_to_axi_cpu_interconnect_BRESP),
        .M_AXI_bvalid(m11_couplers_to_axi_cpu_interconnect_BVALID),
        .M_AXI_rdata(m11_couplers_to_axi_cpu_interconnect_RDATA),
        .M_AXI_rready(m11_couplers_to_axi_cpu_interconnect_RREADY),
        .M_AXI_rresp(m11_couplers_to_axi_cpu_interconnect_RRESP),
        .M_AXI_rvalid(m11_couplers_to_axi_cpu_interconnect_RVALID),
        .M_AXI_wdata(m11_couplers_to_axi_cpu_interconnect_WDATA),
        .M_AXI_wready(m11_couplers_to_axi_cpu_interconnect_WREADY),
        .M_AXI_wstrb(m11_couplers_to_axi_cpu_interconnect_WSTRB),
        .M_AXI_wvalid(m11_couplers_to_axi_cpu_interconnect_WVALID),
        .S_ACLK(axi_cpu_interconnect_ACLK_net),
        .S_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .S_AXI_araddr(xbar_to_m11_couplers_ARADDR),
        .S_AXI_arburst(xbar_to_m11_couplers_ARBURST),
        .S_AXI_arcache(xbar_to_m11_couplers_ARCACHE),
        .S_AXI_arlen(xbar_to_m11_couplers_ARLEN),
        .S_AXI_arlock(xbar_to_m11_couplers_ARLOCK),
        .S_AXI_arprot(xbar_to_m11_couplers_ARPROT),
        .S_AXI_arqos(xbar_to_m11_couplers_ARQOS),
        .S_AXI_arready(xbar_to_m11_couplers_ARREADY),
        .S_AXI_arregion(xbar_to_m11_couplers_ARREGION),
        .S_AXI_arsize(xbar_to_m11_couplers_ARSIZE),
        .S_AXI_arvalid(xbar_to_m11_couplers_ARVALID),
        .S_AXI_awaddr(xbar_to_m11_couplers_AWADDR),
        .S_AXI_awburst(xbar_to_m11_couplers_AWBURST),
        .S_AXI_awcache(xbar_to_m11_couplers_AWCACHE),
        .S_AXI_awlen(xbar_to_m11_couplers_AWLEN),
        .S_AXI_awlock(xbar_to_m11_couplers_AWLOCK),
        .S_AXI_awprot(xbar_to_m11_couplers_AWPROT),
        .S_AXI_awqos(xbar_to_m11_couplers_AWQOS),
        .S_AXI_awready(xbar_to_m11_couplers_AWREADY),
        .S_AXI_awregion(xbar_to_m11_couplers_AWREGION),
        .S_AXI_awsize(xbar_to_m11_couplers_AWSIZE),
        .S_AXI_awvalid(xbar_to_m11_couplers_AWVALID),
        .S_AXI_bready(xbar_to_m11_couplers_BREADY),
        .S_AXI_bresp(xbar_to_m11_couplers_BRESP),
        .S_AXI_bvalid(xbar_to_m11_couplers_BVALID),
        .S_AXI_rdata(xbar_to_m11_couplers_RDATA),
        .S_AXI_rlast(xbar_to_m11_couplers_RLAST),
        .S_AXI_rready(xbar_to_m11_couplers_RREADY),
        .S_AXI_rresp(xbar_to_m11_couplers_RRESP),
        .S_AXI_rvalid(xbar_to_m11_couplers_RVALID),
        .S_AXI_wdata(xbar_to_m11_couplers_WDATA),
        .S_AXI_wlast(xbar_to_m11_couplers_WLAST),
        .S_AXI_wready(xbar_to_m11_couplers_WREADY),
        .S_AXI_wstrb(xbar_to_m11_couplers_WSTRB),
        .S_AXI_wvalid(xbar_to_m11_couplers_WVALID));
  m12_couplers_imp_1HD19WI m12_couplers
       (.M_ACLK(axi_cpu_interconnect_ACLK_net),
        .M_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .M_AXI_araddr(m12_couplers_to_axi_cpu_interconnect_ARADDR),
        .M_AXI_arready(m12_couplers_to_axi_cpu_interconnect_ARREADY),
        .M_AXI_arvalid(m12_couplers_to_axi_cpu_interconnect_ARVALID),
        .M_AXI_awaddr(m12_couplers_to_axi_cpu_interconnect_AWADDR),
        .M_AXI_awready(m12_couplers_to_axi_cpu_interconnect_AWREADY),
        .M_AXI_awvalid(m12_couplers_to_axi_cpu_interconnect_AWVALID),
        .M_AXI_bready(m12_couplers_to_axi_cpu_interconnect_BREADY),
        .M_AXI_bresp(m12_couplers_to_axi_cpu_interconnect_BRESP),
        .M_AXI_bvalid(m12_couplers_to_axi_cpu_interconnect_BVALID),
        .M_AXI_rdata(m12_couplers_to_axi_cpu_interconnect_RDATA),
        .M_AXI_rready(m12_couplers_to_axi_cpu_interconnect_RREADY),
        .M_AXI_rresp(m12_couplers_to_axi_cpu_interconnect_RRESP),
        .M_AXI_rvalid(m12_couplers_to_axi_cpu_interconnect_RVALID),
        .M_AXI_wdata(m12_couplers_to_axi_cpu_interconnect_WDATA),
        .M_AXI_wready(m12_couplers_to_axi_cpu_interconnect_WREADY),
        .M_AXI_wstrb(m12_couplers_to_axi_cpu_interconnect_WSTRB),
        .M_AXI_wvalid(m12_couplers_to_axi_cpu_interconnect_WVALID),
        .S_ACLK(axi_cpu_interconnect_ACLK_net),
        .S_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .S_AXI_araddr(xbar_to_m12_couplers_ARADDR),
        .S_AXI_arburst(xbar_to_m12_couplers_ARBURST),
        .S_AXI_arcache(xbar_to_m12_couplers_ARCACHE),
        .S_AXI_arlen(xbar_to_m12_couplers_ARLEN),
        .S_AXI_arlock(xbar_to_m12_couplers_ARLOCK),
        .S_AXI_arprot(xbar_to_m12_couplers_ARPROT),
        .S_AXI_arqos(xbar_to_m12_couplers_ARQOS),
        .S_AXI_arready(xbar_to_m12_couplers_ARREADY),
        .S_AXI_arregion(xbar_to_m12_couplers_ARREGION),
        .S_AXI_arsize(xbar_to_m12_couplers_ARSIZE),
        .S_AXI_arvalid(xbar_to_m12_couplers_ARVALID),
        .S_AXI_awaddr(xbar_to_m12_couplers_AWADDR),
        .S_AXI_awburst(xbar_to_m12_couplers_AWBURST),
        .S_AXI_awcache(xbar_to_m12_couplers_AWCACHE),
        .S_AXI_awlen(xbar_to_m12_couplers_AWLEN),
        .S_AXI_awlock(xbar_to_m12_couplers_AWLOCK),
        .S_AXI_awprot(xbar_to_m12_couplers_AWPROT),
        .S_AXI_awqos(xbar_to_m12_couplers_AWQOS),
        .S_AXI_awready(xbar_to_m12_couplers_AWREADY),
        .S_AXI_awregion(xbar_to_m12_couplers_AWREGION),
        .S_AXI_awsize(xbar_to_m12_couplers_AWSIZE),
        .S_AXI_awvalid(xbar_to_m12_couplers_AWVALID),
        .S_AXI_bready(xbar_to_m12_couplers_BREADY),
        .S_AXI_bresp(xbar_to_m12_couplers_BRESP),
        .S_AXI_bvalid(xbar_to_m12_couplers_BVALID),
        .S_AXI_rdata(xbar_to_m12_couplers_RDATA),
        .S_AXI_rlast(xbar_to_m12_couplers_RLAST),
        .S_AXI_rready(xbar_to_m12_couplers_RREADY),
        .S_AXI_rresp(xbar_to_m12_couplers_RRESP),
        .S_AXI_rvalid(xbar_to_m12_couplers_RVALID),
        .S_AXI_wdata(xbar_to_m12_couplers_WDATA),
        .S_AXI_wlast(xbar_to_m12_couplers_WLAST),
        .S_AXI_wready(xbar_to_m12_couplers_WREADY),
        .S_AXI_wstrb(xbar_to_m12_couplers_WSTRB),
        .S_AXI_wvalid(xbar_to_m12_couplers_WVALID));
  m13_couplers_imp_1NSCO82 m13_couplers
       (.M_ACLK(axi_cpu_interconnect_ACLK_net),
        .M_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .M_AXI_araddr(m13_couplers_to_axi_cpu_interconnect_ARADDR),
        .M_AXI_arprot(m13_couplers_to_axi_cpu_interconnect_ARPROT),
        .M_AXI_arready(m13_couplers_to_axi_cpu_interconnect_ARREADY),
        .M_AXI_arvalid(m13_couplers_to_axi_cpu_interconnect_ARVALID),
        .M_AXI_awaddr(m13_couplers_to_axi_cpu_interconnect_AWADDR),
        .M_AXI_awprot(m13_couplers_to_axi_cpu_interconnect_AWPROT),
        .M_AXI_awready(m13_couplers_to_axi_cpu_interconnect_AWREADY),
        .M_AXI_awvalid(m13_couplers_to_axi_cpu_interconnect_AWVALID),
        .M_AXI_bready(m13_couplers_to_axi_cpu_interconnect_BREADY),
        .M_AXI_bresp(m13_couplers_to_axi_cpu_interconnect_BRESP),
        .M_AXI_bvalid(m13_couplers_to_axi_cpu_interconnect_BVALID),
        .M_AXI_rdata(m13_couplers_to_axi_cpu_interconnect_RDATA),
        .M_AXI_rready(m13_couplers_to_axi_cpu_interconnect_RREADY),
        .M_AXI_rresp(m13_couplers_to_axi_cpu_interconnect_RRESP),
        .M_AXI_rvalid(m13_couplers_to_axi_cpu_interconnect_RVALID),
        .M_AXI_wdata(m13_couplers_to_axi_cpu_interconnect_WDATA),
        .M_AXI_wready(m13_couplers_to_axi_cpu_interconnect_WREADY),
        .M_AXI_wstrb(m13_couplers_to_axi_cpu_interconnect_WSTRB),
        .M_AXI_wvalid(m13_couplers_to_axi_cpu_interconnect_WVALID),
        .S_ACLK(axi_cpu_interconnect_ACLK_net),
        .S_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .S_AXI_araddr(xbar_to_m13_couplers_ARADDR),
        .S_AXI_arburst(xbar_to_m13_couplers_ARBURST),
        .S_AXI_arcache(xbar_to_m13_couplers_ARCACHE),
        .S_AXI_arlen(xbar_to_m13_couplers_ARLEN),
        .S_AXI_arlock(xbar_to_m13_couplers_ARLOCK),
        .S_AXI_arprot(xbar_to_m13_couplers_ARPROT),
        .S_AXI_arqos(xbar_to_m13_couplers_ARQOS),
        .S_AXI_arready(xbar_to_m13_couplers_ARREADY),
        .S_AXI_arregion(xbar_to_m13_couplers_ARREGION),
        .S_AXI_arsize(xbar_to_m13_couplers_ARSIZE),
        .S_AXI_arvalid(xbar_to_m13_couplers_ARVALID),
        .S_AXI_awaddr(xbar_to_m13_couplers_AWADDR),
        .S_AXI_awburst(xbar_to_m13_couplers_AWBURST),
        .S_AXI_awcache(xbar_to_m13_couplers_AWCACHE),
        .S_AXI_awlen(xbar_to_m13_couplers_AWLEN),
        .S_AXI_awlock(xbar_to_m13_couplers_AWLOCK),
        .S_AXI_awprot(xbar_to_m13_couplers_AWPROT),
        .S_AXI_awqos(xbar_to_m13_couplers_AWQOS),
        .S_AXI_awready(xbar_to_m13_couplers_AWREADY),
        .S_AXI_awregion(xbar_to_m13_couplers_AWREGION),
        .S_AXI_awsize(xbar_to_m13_couplers_AWSIZE),
        .S_AXI_awvalid(xbar_to_m13_couplers_AWVALID),
        .S_AXI_bready(xbar_to_m13_couplers_BREADY),
        .S_AXI_bresp(xbar_to_m13_couplers_BRESP),
        .S_AXI_bvalid(xbar_to_m13_couplers_BVALID),
        .S_AXI_rdata(xbar_to_m13_couplers_RDATA),
        .S_AXI_rlast(xbar_to_m13_couplers_RLAST),
        .S_AXI_rready(xbar_to_m13_couplers_RREADY),
        .S_AXI_rresp(xbar_to_m13_couplers_RRESP),
        .S_AXI_rvalid(xbar_to_m13_couplers_RVALID),
        .S_AXI_wdata(xbar_to_m13_couplers_WDATA),
        .S_AXI_wlast(xbar_to_m13_couplers_WLAST),
        .S_AXI_wready(xbar_to_m13_couplers_WREADY),
        .S_AXI_wstrb(xbar_to_m13_couplers_WSTRB),
        .S_AXI_wvalid(xbar_to_m13_couplers_WVALID));
  m14_couplers_imp_1DKD59E m14_couplers
       (.M_ACLK(axi_cpu_interconnect_ACLK_net),
        .M_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .M_AXI_araddr(m14_couplers_to_axi_cpu_interconnect_ARADDR),
        .M_AXI_arburst(m14_couplers_to_axi_cpu_interconnect_ARBURST),
        .M_AXI_arcache(m14_couplers_to_axi_cpu_interconnect_ARCACHE),
        .M_AXI_arlen(m14_couplers_to_axi_cpu_interconnect_ARLEN),
        .M_AXI_arlock(m14_couplers_to_axi_cpu_interconnect_ARLOCK),
        .M_AXI_arprot(m14_couplers_to_axi_cpu_interconnect_ARPROT),
        .M_AXI_arqos(m14_couplers_to_axi_cpu_interconnect_ARQOS),
        .M_AXI_arready(m14_couplers_to_axi_cpu_interconnect_ARREADY),
        .M_AXI_arregion(m14_couplers_to_axi_cpu_interconnect_ARREGION),
        .M_AXI_arsize(m14_couplers_to_axi_cpu_interconnect_ARSIZE),
        .M_AXI_arvalid(m14_couplers_to_axi_cpu_interconnect_ARVALID),
        .M_AXI_awaddr(m14_couplers_to_axi_cpu_interconnect_AWADDR),
        .M_AXI_awburst(m14_couplers_to_axi_cpu_interconnect_AWBURST),
        .M_AXI_awcache(m14_couplers_to_axi_cpu_interconnect_AWCACHE),
        .M_AXI_awlen(m14_couplers_to_axi_cpu_interconnect_AWLEN),
        .M_AXI_awlock(m14_couplers_to_axi_cpu_interconnect_AWLOCK),
        .M_AXI_awprot(m14_couplers_to_axi_cpu_interconnect_AWPROT),
        .M_AXI_awqos(m14_couplers_to_axi_cpu_interconnect_AWQOS),
        .M_AXI_awready(m14_couplers_to_axi_cpu_interconnect_AWREADY),
        .M_AXI_awregion(m14_couplers_to_axi_cpu_interconnect_AWREGION),
        .M_AXI_awsize(m14_couplers_to_axi_cpu_interconnect_AWSIZE),
        .M_AXI_awvalid(m14_couplers_to_axi_cpu_interconnect_AWVALID),
        .M_AXI_bready(m14_couplers_to_axi_cpu_interconnect_BREADY),
        .M_AXI_bresp(m14_couplers_to_axi_cpu_interconnect_BRESP),
        .M_AXI_bvalid(m14_couplers_to_axi_cpu_interconnect_BVALID),
        .M_AXI_rdata(m14_couplers_to_axi_cpu_interconnect_RDATA),
        .M_AXI_rlast(m14_couplers_to_axi_cpu_interconnect_RLAST),
        .M_AXI_rready(m14_couplers_to_axi_cpu_interconnect_RREADY),
        .M_AXI_rresp(m14_couplers_to_axi_cpu_interconnect_RRESP),
        .M_AXI_rvalid(m14_couplers_to_axi_cpu_interconnect_RVALID),
        .M_AXI_wdata(m14_couplers_to_axi_cpu_interconnect_WDATA),
        .M_AXI_wlast(m14_couplers_to_axi_cpu_interconnect_WLAST),
        .M_AXI_wready(m14_couplers_to_axi_cpu_interconnect_WREADY),
        .M_AXI_wstrb(m14_couplers_to_axi_cpu_interconnect_WSTRB),
        .M_AXI_wvalid(m14_couplers_to_axi_cpu_interconnect_WVALID),
        .S_ACLK(axi_cpu_interconnect_ACLK_net),
        .S_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .S_AXI_araddr(xbar_to_m14_couplers_ARADDR),
        .S_AXI_arburst(xbar_to_m14_couplers_ARBURST),
        .S_AXI_arcache(xbar_to_m14_couplers_ARCACHE),
        .S_AXI_arlen(xbar_to_m14_couplers_ARLEN),
        .S_AXI_arlock(xbar_to_m14_couplers_ARLOCK),
        .S_AXI_arprot(xbar_to_m14_couplers_ARPROT),
        .S_AXI_arqos(xbar_to_m14_couplers_ARQOS),
        .S_AXI_arready(xbar_to_m14_couplers_ARREADY),
        .S_AXI_arregion(xbar_to_m14_couplers_ARREGION),
        .S_AXI_arsize(xbar_to_m14_couplers_ARSIZE),
        .S_AXI_arvalid(xbar_to_m14_couplers_ARVALID),
        .S_AXI_awaddr(xbar_to_m14_couplers_AWADDR),
        .S_AXI_awburst(xbar_to_m14_couplers_AWBURST),
        .S_AXI_awcache(xbar_to_m14_couplers_AWCACHE),
        .S_AXI_awlen(xbar_to_m14_couplers_AWLEN),
        .S_AXI_awlock(xbar_to_m14_couplers_AWLOCK),
        .S_AXI_awprot(xbar_to_m14_couplers_AWPROT),
        .S_AXI_awqos(xbar_to_m14_couplers_AWQOS),
        .S_AXI_awready(xbar_to_m14_couplers_AWREADY),
        .S_AXI_awregion(xbar_to_m14_couplers_AWREGION),
        .S_AXI_awsize(xbar_to_m14_couplers_AWSIZE),
        .S_AXI_awvalid(xbar_to_m14_couplers_AWVALID),
        .S_AXI_bready(xbar_to_m14_couplers_BREADY),
        .S_AXI_bresp(xbar_to_m14_couplers_BRESP),
        .S_AXI_bvalid(xbar_to_m14_couplers_BVALID),
        .S_AXI_rdata(xbar_to_m14_couplers_RDATA),
        .S_AXI_rlast(xbar_to_m14_couplers_RLAST),
        .S_AXI_rready(xbar_to_m14_couplers_RREADY),
        .S_AXI_rresp(xbar_to_m14_couplers_RRESP),
        .S_AXI_rvalid(xbar_to_m14_couplers_RVALID),
        .S_AXI_wdata(xbar_to_m14_couplers_WDATA),
        .S_AXI_wlast(xbar_to_m14_couplers_WLAST),
        .S_AXI_wready(xbar_to_m14_couplers_WREADY),
        .S_AXI_wstrb(xbar_to_m14_couplers_WSTRB),
        .S_AXI_wvalid(xbar_to_m14_couplers_WVALID));
  s00_couplers_imp_SWH3HH s00_couplers
       (.M_ACLK(axi_cpu_interconnect_ACLK_net),
        .M_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .M_AXI_araddr(s00_couplers_to_xbar_ARADDR),
        .M_AXI_arburst(s00_couplers_to_xbar_ARBURST),
        .M_AXI_arcache(s00_couplers_to_xbar_ARCACHE),
        .M_AXI_arlen(s00_couplers_to_xbar_ARLEN),
        .M_AXI_arlock(s00_couplers_to_xbar_ARLOCK),
        .M_AXI_arprot(s00_couplers_to_xbar_ARPROT),
        .M_AXI_arqos(s00_couplers_to_xbar_ARQOS),
        .M_AXI_arready(s00_couplers_to_xbar_ARREADY),
        .M_AXI_arsize(s00_couplers_to_xbar_ARSIZE),
        .M_AXI_arvalid(s00_couplers_to_xbar_ARVALID),
        .M_AXI_awaddr(s00_couplers_to_xbar_AWADDR),
        .M_AXI_awburst(s00_couplers_to_xbar_AWBURST),
        .M_AXI_awcache(s00_couplers_to_xbar_AWCACHE),
        .M_AXI_awlen(s00_couplers_to_xbar_AWLEN),
        .M_AXI_awlock(s00_couplers_to_xbar_AWLOCK),
        .M_AXI_awprot(s00_couplers_to_xbar_AWPROT),
        .M_AXI_awqos(s00_couplers_to_xbar_AWQOS),
        .M_AXI_awready(s00_couplers_to_xbar_AWREADY),
        .M_AXI_awsize(s00_couplers_to_xbar_AWSIZE),
        .M_AXI_awvalid(s00_couplers_to_xbar_AWVALID),
        .M_AXI_bready(s00_couplers_to_xbar_BREADY),
        .M_AXI_bresp(s00_couplers_to_xbar_BRESP),
        .M_AXI_bvalid(s00_couplers_to_xbar_BVALID),
        .M_AXI_rdata(s00_couplers_to_xbar_RDATA),
        .M_AXI_rlast(s00_couplers_to_xbar_RLAST),
        .M_AXI_rready(s00_couplers_to_xbar_RREADY),
        .M_AXI_rresp(s00_couplers_to_xbar_RRESP),
        .M_AXI_rvalid(s00_couplers_to_xbar_RVALID),
        .M_AXI_wdata(s00_couplers_to_xbar_WDATA),
        .M_AXI_wlast(s00_couplers_to_xbar_WLAST),
        .M_AXI_wready(s00_couplers_to_xbar_WREADY),
        .M_AXI_wstrb(s00_couplers_to_xbar_WSTRB),
        .M_AXI_wvalid(s00_couplers_to_xbar_WVALID),
        .S_ACLK(axi_cpu_interconnect_ACLK_net),
        .S_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .S_AXI_araddr(axi_cpu_interconnect_to_s00_couplers_ARADDR),
        .S_AXI_arprot(axi_cpu_interconnect_to_s00_couplers_ARPROT),
        .S_AXI_arready(axi_cpu_interconnect_to_s00_couplers_ARREADY),
        .S_AXI_arvalid(axi_cpu_interconnect_to_s00_couplers_ARVALID),
        .S_AXI_awaddr(axi_cpu_interconnect_to_s00_couplers_AWADDR),
        .S_AXI_awprot(axi_cpu_interconnect_to_s00_couplers_AWPROT),
        .S_AXI_awready(axi_cpu_interconnect_to_s00_couplers_AWREADY),
        .S_AXI_awvalid(axi_cpu_interconnect_to_s00_couplers_AWVALID),
        .S_AXI_bready(axi_cpu_interconnect_to_s00_couplers_BREADY),
        .S_AXI_bresp(axi_cpu_interconnect_to_s00_couplers_BRESP),
        .S_AXI_bvalid(axi_cpu_interconnect_to_s00_couplers_BVALID),
        .S_AXI_rdata(axi_cpu_interconnect_to_s00_couplers_RDATA),
        .S_AXI_rready(axi_cpu_interconnect_to_s00_couplers_RREADY),
        .S_AXI_rresp(axi_cpu_interconnect_to_s00_couplers_RRESP),
        .S_AXI_rvalid(axi_cpu_interconnect_to_s00_couplers_RVALID),
        .S_AXI_wdata(axi_cpu_interconnect_to_s00_couplers_WDATA),
        .S_AXI_wready(axi_cpu_interconnect_to_s00_couplers_WREADY),
        .S_AXI_wstrb(axi_cpu_interconnect_to_s00_couplers_WSTRB),
        .S_AXI_wvalid(axi_cpu_interconnect_to_s00_couplers_WVALID));
  s01_couplers_imp_Z8NRJ9 s01_couplers
       (.M_ACLK(axi_cpu_interconnect_ACLK_net),
        .M_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .M_AXI_araddr(s01_couplers_to_xbar_ARADDR),
        .M_AXI_arburst(s01_couplers_to_xbar_ARBURST),
        .M_AXI_arcache(s01_couplers_to_xbar_ARCACHE),
        .M_AXI_arlen(s01_couplers_to_xbar_ARLEN),
        .M_AXI_arlock(s01_couplers_to_xbar_ARLOCK),
        .M_AXI_arprot(s01_couplers_to_xbar_ARPROT),
        .M_AXI_arqos(s01_couplers_to_xbar_ARQOS),
        .M_AXI_arready(s01_couplers_to_xbar_ARREADY),
        .M_AXI_arsize(s01_couplers_to_xbar_ARSIZE),
        .M_AXI_arvalid(s01_couplers_to_xbar_ARVALID),
        .M_AXI_awaddr(s01_couplers_to_xbar_AWADDR),
        .M_AXI_awburst(s01_couplers_to_xbar_AWBURST),
        .M_AXI_awcache(s01_couplers_to_xbar_AWCACHE),
        .M_AXI_awlen(s01_couplers_to_xbar_AWLEN),
        .M_AXI_awlock(s01_couplers_to_xbar_AWLOCK),
        .M_AXI_awprot(s01_couplers_to_xbar_AWPROT),
        .M_AXI_awqos(s01_couplers_to_xbar_AWQOS),
        .M_AXI_awready(s01_couplers_to_xbar_AWREADY),
        .M_AXI_awsize(s01_couplers_to_xbar_AWSIZE),
        .M_AXI_awvalid(s01_couplers_to_xbar_AWVALID),
        .M_AXI_bready(s01_couplers_to_xbar_BREADY),
        .M_AXI_bresp(s01_couplers_to_xbar_BRESP),
        .M_AXI_bvalid(s01_couplers_to_xbar_BVALID),
        .M_AXI_rdata(s01_couplers_to_xbar_RDATA),
        .M_AXI_rlast(s01_couplers_to_xbar_RLAST),
        .M_AXI_rready(s01_couplers_to_xbar_RREADY),
        .M_AXI_rresp(s01_couplers_to_xbar_RRESP),
        .M_AXI_rvalid(s01_couplers_to_xbar_RVALID),
        .M_AXI_wdata(s01_couplers_to_xbar_WDATA),
        .M_AXI_wlast(s01_couplers_to_xbar_WLAST),
        .M_AXI_wready(s01_couplers_to_xbar_WREADY),
        .M_AXI_wstrb(s01_couplers_to_xbar_WSTRB),
        .M_AXI_wvalid(s01_couplers_to_xbar_WVALID),
        .S_ACLK(axi_cpu_interconnect_ACLK_net),
        .S_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .S_AXI_araddr(axi_cpu_interconnect_to_s01_couplers_ARADDR),
        .S_AXI_arburst(axi_cpu_interconnect_to_s01_couplers_ARBURST),
        .S_AXI_arcache(axi_cpu_interconnect_to_s01_couplers_ARCACHE),
        .S_AXI_arlen(axi_cpu_interconnect_to_s01_couplers_ARLEN),
        .S_AXI_arprot(axi_cpu_interconnect_to_s01_couplers_ARPROT),
        .S_AXI_arready(axi_cpu_interconnect_to_s01_couplers_ARREADY),
        .S_AXI_arsize(axi_cpu_interconnect_to_s01_couplers_ARSIZE),
        .S_AXI_arvalid(axi_cpu_interconnect_to_s01_couplers_ARVALID),
        .S_AXI_awaddr(axi_cpu_interconnect_to_s01_couplers_AWADDR),
        .S_AXI_awburst(axi_cpu_interconnect_to_s01_couplers_AWBURST),
        .S_AXI_awcache(axi_cpu_interconnect_to_s01_couplers_AWCACHE),
        .S_AXI_awlen(axi_cpu_interconnect_to_s01_couplers_AWLEN),
        .S_AXI_awprot(axi_cpu_interconnect_to_s01_couplers_AWPROT),
        .S_AXI_awready(axi_cpu_interconnect_to_s01_couplers_AWREADY),
        .S_AXI_awsize(axi_cpu_interconnect_to_s01_couplers_AWSIZE),
        .S_AXI_awvalid(axi_cpu_interconnect_to_s01_couplers_AWVALID),
        .S_AXI_bready(axi_cpu_interconnect_to_s01_couplers_BREADY),
        .S_AXI_bresp(axi_cpu_interconnect_to_s01_couplers_BRESP),
        .S_AXI_bvalid(axi_cpu_interconnect_to_s01_couplers_BVALID),
        .S_AXI_rdata(axi_cpu_interconnect_to_s01_couplers_RDATA),
        .S_AXI_rlast(axi_cpu_interconnect_to_s01_couplers_RLAST),
        .S_AXI_rready(axi_cpu_interconnect_to_s01_couplers_RREADY),
        .S_AXI_rresp(axi_cpu_interconnect_to_s01_couplers_RRESP),
        .S_AXI_rvalid(axi_cpu_interconnect_to_s01_couplers_RVALID),
        .S_AXI_wdata(axi_cpu_interconnect_to_s01_couplers_WDATA),
        .S_AXI_wlast(axi_cpu_interconnect_to_s01_couplers_WLAST),
        .S_AXI_wready(axi_cpu_interconnect_to_s01_couplers_WREADY),
        .S_AXI_wstrb(axi_cpu_interconnect_to_s01_couplers_WSTRB),
        .S_AXI_wvalid(axi_cpu_interconnect_to_s01_couplers_WVALID));
  s02_couplers_imp_JK09YD s02_couplers
       (.M_ACLK(axi_cpu_interconnect_ACLK_net),
        .M_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .M_AXI_araddr(s02_couplers_to_xbar_ARADDR),
        .M_AXI_arburst(s02_couplers_to_xbar_ARBURST),
        .M_AXI_arcache(s02_couplers_to_xbar_ARCACHE),
        .M_AXI_arlen(s02_couplers_to_xbar_ARLEN),
        .M_AXI_arlock(s02_couplers_to_xbar_ARLOCK),
        .M_AXI_arprot(s02_couplers_to_xbar_ARPROT),
        .M_AXI_arqos(s02_couplers_to_xbar_ARQOS),
        .M_AXI_arready(s02_couplers_to_xbar_ARREADY),
        .M_AXI_arsize(s02_couplers_to_xbar_ARSIZE),
        .M_AXI_arvalid(s02_couplers_to_xbar_ARVALID),
        .M_AXI_rdata(s02_couplers_to_xbar_RDATA),
        .M_AXI_rlast(s02_couplers_to_xbar_RLAST),
        .M_AXI_rready(s02_couplers_to_xbar_RREADY),
        .M_AXI_rresp(s02_couplers_to_xbar_RRESP),
        .M_AXI_rvalid(s02_couplers_to_xbar_RVALID),
        .S_ACLK(axi_cpu_interconnect_ACLK_net),
        .S_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .S_AXI_araddr(axi_cpu_interconnect_to_s02_couplers_ARADDR),
        .S_AXI_arburst(axi_cpu_interconnect_to_s02_couplers_ARBURST),
        .S_AXI_arcache(axi_cpu_interconnect_to_s02_couplers_ARCACHE),
        .S_AXI_arlen(axi_cpu_interconnect_to_s02_couplers_ARLEN),
        .S_AXI_arprot(axi_cpu_interconnect_to_s02_couplers_ARPROT),
        .S_AXI_arready(axi_cpu_interconnect_to_s02_couplers_ARREADY),
        .S_AXI_arsize(axi_cpu_interconnect_to_s02_couplers_ARSIZE),
        .S_AXI_arvalid(axi_cpu_interconnect_to_s02_couplers_ARVALID),
        .S_AXI_rdata(axi_cpu_interconnect_to_s02_couplers_RDATA),
        .S_AXI_rlast(axi_cpu_interconnect_to_s02_couplers_RLAST),
        .S_AXI_rready(axi_cpu_interconnect_to_s02_couplers_RREADY),
        .S_AXI_rresp(axi_cpu_interconnect_to_s02_couplers_RRESP),
        .S_AXI_rvalid(axi_cpu_interconnect_to_s02_couplers_RVALID));
  s03_couplers_imp_MKB4BP s03_couplers
       (.M_ACLK(axi_cpu_interconnect_ACLK_net),
        .M_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .M_AXI_awaddr(s03_couplers_to_xbar_AWADDR),
        .M_AXI_awburst(s03_couplers_to_xbar_AWBURST),
        .M_AXI_awcache(s03_couplers_to_xbar_AWCACHE),
        .M_AXI_awlen(s03_couplers_to_xbar_AWLEN),
        .M_AXI_awlock(s03_couplers_to_xbar_AWLOCK),
        .M_AXI_awprot(s03_couplers_to_xbar_AWPROT),
        .M_AXI_awqos(s03_couplers_to_xbar_AWQOS),
        .M_AXI_awready(s03_couplers_to_xbar_AWREADY),
        .M_AXI_awsize(s03_couplers_to_xbar_AWSIZE),
        .M_AXI_awvalid(s03_couplers_to_xbar_AWVALID),
        .M_AXI_bready(s03_couplers_to_xbar_BREADY),
        .M_AXI_bresp(s03_couplers_to_xbar_BRESP),
        .M_AXI_bvalid(s03_couplers_to_xbar_BVALID),
        .M_AXI_wdata(s03_couplers_to_xbar_WDATA),
        .M_AXI_wlast(s03_couplers_to_xbar_WLAST),
        .M_AXI_wready(s03_couplers_to_xbar_WREADY),
        .M_AXI_wstrb(s03_couplers_to_xbar_WSTRB),
        .M_AXI_wvalid(s03_couplers_to_xbar_WVALID),
        .S_ACLK(axi_cpu_interconnect_ACLK_net),
        .S_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .S_AXI_awaddr(axi_cpu_interconnect_to_s03_couplers_AWADDR),
        .S_AXI_awburst(axi_cpu_interconnect_to_s03_couplers_AWBURST),
        .S_AXI_awcache(axi_cpu_interconnect_to_s03_couplers_AWCACHE),
        .S_AXI_awlen(axi_cpu_interconnect_to_s03_couplers_AWLEN),
        .S_AXI_awprot(axi_cpu_interconnect_to_s03_couplers_AWPROT),
        .S_AXI_awready(axi_cpu_interconnect_to_s03_couplers_AWREADY),
        .S_AXI_awsize(axi_cpu_interconnect_to_s03_couplers_AWSIZE),
        .S_AXI_awvalid(axi_cpu_interconnect_to_s03_couplers_AWVALID),
        .S_AXI_bready(axi_cpu_interconnect_to_s03_couplers_BREADY),
        .S_AXI_bresp(axi_cpu_interconnect_to_s03_couplers_BRESP),
        .S_AXI_bvalid(axi_cpu_interconnect_to_s03_couplers_BVALID),
        .S_AXI_wdata(axi_cpu_interconnect_to_s03_couplers_WDATA),
        .S_AXI_wlast(axi_cpu_interconnect_to_s03_couplers_WLAST),
        .S_AXI_wready(axi_cpu_interconnect_to_s03_couplers_WREADY),
        .S_AXI_wstrb(axi_cpu_interconnect_to_s03_couplers_WSTRB),
        .S_AXI_wvalid(axi_cpu_interconnect_to_s03_couplers_WVALID));
  s04_couplers_imp_EKV279 s04_couplers
       (.M_ACLK(axi_cpu_interconnect_ACLK_net),
        .M_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .M_AXI_araddr(s04_couplers_to_xbar_ARADDR),
        .M_AXI_arburst(s04_couplers_to_xbar_ARBURST),
        .M_AXI_arcache(s04_couplers_to_xbar_ARCACHE),
        .M_AXI_arlen(s04_couplers_to_xbar_ARLEN),
        .M_AXI_arlock(s04_couplers_to_xbar_ARLOCK),
        .M_AXI_arprot(s04_couplers_to_xbar_ARPROT),
        .M_AXI_arqos(s04_couplers_to_xbar_ARQOS),
        .M_AXI_arready(s04_couplers_to_xbar_ARREADY),
        .M_AXI_arsize(s04_couplers_to_xbar_ARSIZE),
        .M_AXI_arvalid(s04_couplers_to_xbar_ARVALID),
        .M_AXI_rdata(s04_couplers_to_xbar_RDATA),
        .M_AXI_rlast(s04_couplers_to_xbar_RLAST),
        .M_AXI_rready(s04_couplers_to_xbar_RREADY),
        .M_AXI_rresp(s04_couplers_to_xbar_RRESP),
        .M_AXI_rvalid(s04_couplers_to_xbar_RVALID),
        .S_ACLK(axi_cpu_interconnect_ACLK_net),
        .S_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .S_AXI_araddr(axi_cpu_interconnect_to_s04_couplers_ARADDR),
        .S_AXI_arprot(axi_cpu_interconnect_to_s04_couplers_ARPROT),
        .S_AXI_arready(axi_cpu_interconnect_to_s04_couplers_ARREADY),
        .S_AXI_arvalid(axi_cpu_interconnect_to_s04_couplers_ARVALID),
        .S_AXI_rdata(axi_cpu_interconnect_to_s04_couplers_RDATA),
        .S_AXI_rready(axi_cpu_interconnect_to_s04_couplers_RREADY),
        .S_AXI_rresp(axi_cpu_interconnect_to_s04_couplers_RRESP),
        .S_AXI_rvalid(axi_cpu_interconnect_to_s04_couplers_RVALID));
  s05_couplers_imp_9VZVAD s05_couplers
       (.M_ACLK(axi_cpu_interconnect_ACLK_net),
        .M_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .M_AXI_araddr(s05_couplers_to_xbar_ARADDR),
        .M_AXI_arburst(s05_couplers_to_xbar_ARBURST),
        .M_AXI_arcache(s05_couplers_to_xbar_ARCACHE),
        .M_AXI_arlen(s05_couplers_to_xbar_ARLEN),
        .M_AXI_arlock(s05_couplers_to_xbar_ARLOCK),
        .M_AXI_arprot(s05_couplers_to_xbar_ARPROT),
        .M_AXI_arqos(s05_couplers_to_xbar_ARQOS),
        .M_AXI_arready(s05_couplers_to_xbar_ARREADY),
        .M_AXI_arsize(s05_couplers_to_xbar_ARSIZE),
        .M_AXI_arvalid(s05_couplers_to_xbar_ARVALID),
        .M_AXI_awaddr(s05_couplers_to_xbar_AWADDR),
        .M_AXI_awburst(s05_couplers_to_xbar_AWBURST),
        .M_AXI_awcache(s05_couplers_to_xbar_AWCACHE),
        .M_AXI_awlen(s05_couplers_to_xbar_AWLEN),
        .M_AXI_awlock(s05_couplers_to_xbar_AWLOCK),
        .M_AXI_awprot(s05_couplers_to_xbar_AWPROT),
        .M_AXI_awqos(s05_couplers_to_xbar_AWQOS),
        .M_AXI_awready(s05_couplers_to_xbar_AWREADY),
        .M_AXI_awsize(s05_couplers_to_xbar_AWSIZE),
        .M_AXI_awvalid(s05_couplers_to_xbar_AWVALID),
        .M_AXI_bready(s05_couplers_to_xbar_BREADY),
        .M_AXI_bresp(s05_couplers_to_xbar_BRESP),
        .M_AXI_bvalid(s05_couplers_to_xbar_BVALID),
        .M_AXI_rdata(s05_couplers_to_xbar_RDATA),
        .M_AXI_rlast(s05_couplers_to_xbar_RLAST),
        .M_AXI_rready(s05_couplers_to_xbar_RREADY),
        .M_AXI_rresp(s05_couplers_to_xbar_RRESP),
        .M_AXI_rvalid(s05_couplers_to_xbar_RVALID),
        .M_AXI_wdata(s05_couplers_to_xbar_WDATA),
        .M_AXI_wlast(s05_couplers_to_xbar_WLAST),
        .M_AXI_wready(s05_couplers_to_xbar_WREADY),
        .M_AXI_wstrb(s05_couplers_to_xbar_WSTRB),
        .M_AXI_wvalid(s05_couplers_to_xbar_WVALID),
        .S_ACLK(axi_cpu_interconnect_ACLK_net),
        .S_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .S_AXI_araddr(axi_cpu_interconnect_to_s05_couplers_ARADDR),
        .S_AXI_arburst(axi_cpu_interconnect_to_s05_couplers_ARBURST),
        .S_AXI_arcache(axi_cpu_interconnect_to_s05_couplers_ARCACHE),
        .S_AXI_arid(axi_cpu_interconnect_to_s05_couplers_ARID),
        .S_AXI_arlen(axi_cpu_interconnect_to_s05_couplers_ARLEN),
        .S_AXI_arlock(axi_cpu_interconnect_to_s05_couplers_ARLOCK),
        .S_AXI_arprot(axi_cpu_interconnect_to_s05_couplers_ARPROT),
        .S_AXI_arqos(axi_cpu_interconnect_to_s05_couplers_ARQOS),
        .S_AXI_arready(axi_cpu_interconnect_to_s05_couplers_ARREADY),
        .S_AXI_arsize(axi_cpu_interconnect_to_s05_couplers_ARSIZE),
        .S_AXI_arvalid(axi_cpu_interconnect_to_s05_couplers_ARVALID),
        .S_AXI_awaddr(axi_cpu_interconnect_to_s05_couplers_AWADDR),
        .S_AXI_awburst(axi_cpu_interconnect_to_s05_couplers_AWBURST),
        .S_AXI_awcache(axi_cpu_interconnect_to_s05_couplers_AWCACHE),
        .S_AXI_awid(axi_cpu_interconnect_to_s05_couplers_AWID),
        .S_AXI_awlen(axi_cpu_interconnect_to_s05_couplers_AWLEN),
        .S_AXI_awlock(axi_cpu_interconnect_to_s05_couplers_AWLOCK),
        .S_AXI_awprot(axi_cpu_interconnect_to_s05_couplers_AWPROT),
        .S_AXI_awqos(axi_cpu_interconnect_to_s05_couplers_AWQOS),
        .S_AXI_awready(axi_cpu_interconnect_to_s05_couplers_AWREADY),
        .S_AXI_awsize(axi_cpu_interconnect_to_s05_couplers_AWSIZE),
        .S_AXI_awvalid(axi_cpu_interconnect_to_s05_couplers_AWVALID),
        .S_AXI_bid(axi_cpu_interconnect_to_s05_couplers_BID),
        .S_AXI_bready(axi_cpu_interconnect_to_s05_couplers_BREADY),
        .S_AXI_bresp(axi_cpu_interconnect_to_s05_couplers_BRESP),
        .S_AXI_bvalid(axi_cpu_interconnect_to_s05_couplers_BVALID),
        .S_AXI_rdata(axi_cpu_interconnect_to_s05_couplers_RDATA),
        .S_AXI_rid(axi_cpu_interconnect_to_s05_couplers_RID),
        .S_AXI_rlast(axi_cpu_interconnect_to_s05_couplers_RLAST),
        .S_AXI_rready(axi_cpu_interconnect_to_s05_couplers_RREADY),
        .S_AXI_rresp(axi_cpu_interconnect_to_s05_couplers_RRESP),
        .S_AXI_rvalid(axi_cpu_interconnect_to_s05_couplers_RVALID),
        .S_AXI_wdata(axi_cpu_interconnect_to_s05_couplers_WDATA),
        .S_AXI_wlast(axi_cpu_interconnect_to_s05_couplers_WLAST),
        .S_AXI_wready(axi_cpu_interconnect_to_s05_couplers_WREADY),
        .S_AXI_wstrb(axi_cpu_interconnect_to_s05_couplers_WSTRB),
        .S_AXI_wvalid(axi_cpu_interconnect_to_s05_couplers_WVALID));
  s06_couplers_imp_7G9LK5 s06_couplers
       (.M_ACLK(axi_cpu_interconnect_ACLK_net),
        .M_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .M_AXI_araddr(s06_couplers_to_xbar_ARADDR),
        .M_AXI_arburst(s06_couplers_to_xbar_ARBURST),
        .M_AXI_arcache(s06_couplers_to_xbar_ARCACHE),
        .M_AXI_arlen(s06_couplers_to_xbar_ARLEN),
        .M_AXI_arlock(s06_couplers_to_xbar_ARLOCK),
        .M_AXI_arprot(s06_couplers_to_xbar_ARPROT),
        .M_AXI_arqos(s06_couplers_to_xbar_ARQOS),
        .M_AXI_arready(s06_couplers_to_xbar_ARREADY),
        .M_AXI_arsize(s06_couplers_to_xbar_ARSIZE),
        .M_AXI_arvalid(s06_couplers_to_xbar_ARVALID),
        .M_AXI_awaddr(s06_couplers_to_xbar_AWADDR),
        .M_AXI_awburst(s06_couplers_to_xbar_AWBURST),
        .M_AXI_awcache(s06_couplers_to_xbar_AWCACHE),
        .M_AXI_awlen(s06_couplers_to_xbar_AWLEN),
        .M_AXI_awlock(s06_couplers_to_xbar_AWLOCK),
        .M_AXI_awprot(s06_couplers_to_xbar_AWPROT),
        .M_AXI_awqos(s06_couplers_to_xbar_AWQOS),
        .M_AXI_awready(s06_couplers_to_xbar_AWREADY),
        .M_AXI_awsize(s06_couplers_to_xbar_AWSIZE),
        .M_AXI_awvalid(s06_couplers_to_xbar_AWVALID),
        .M_AXI_bready(s06_couplers_to_xbar_BREADY),
        .M_AXI_bresp(s06_couplers_to_xbar_BRESP),
        .M_AXI_bvalid(s06_couplers_to_xbar_BVALID),
        .M_AXI_rdata(s06_couplers_to_xbar_RDATA),
        .M_AXI_rlast(s06_couplers_to_xbar_RLAST),
        .M_AXI_rready(s06_couplers_to_xbar_RREADY),
        .M_AXI_rresp(s06_couplers_to_xbar_RRESP),
        .M_AXI_rvalid(s06_couplers_to_xbar_RVALID),
        .M_AXI_wdata(s06_couplers_to_xbar_WDATA),
        .M_AXI_wlast(s06_couplers_to_xbar_WLAST),
        .M_AXI_wready(s06_couplers_to_xbar_WREADY),
        .M_AXI_wstrb(s06_couplers_to_xbar_WSTRB),
        .M_AXI_wvalid(s06_couplers_to_xbar_WVALID),
        .S_ACLK(axi_cpu_interconnect_ACLK_net),
        .S_ARESETN(axi_cpu_interconnect_ARESETN_net),
        .S_AXI_araddr(axi_cpu_interconnect_to_s06_couplers_ARADDR),
        .S_AXI_arburst(axi_cpu_interconnect_to_s06_couplers_ARBURST),
        .S_AXI_arcache(axi_cpu_interconnect_to_s06_couplers_ARCACHE),
        .S_AXI_arid(axi_cpu_interconnect_to_s06_couplers_ARID),
        .S_AXI_arlen(axi_cpu_interconnect_to_s06_couplers_ARLEN),
        .S_AXI_arlock(axi_cpu_interconnect_to_s06_couplers_ARLOCK),
        .S_AXI_arprot(axi_cpu_interconnect_to_s06_couplers_ARPROT),
        .S_AXI_arqos(axi_cpu_interconnect_to_s06_couplers_ARQOS),
        .S_AXI_arready(axi_cpu_interconnect_to_s06_couplers_ARREADY),
        .S_AXI_arsize(axi_cpu_interconnect_to_s06_couplers_ARSIZE),
        .S_AXI_arvalid(axi_cpu_interconnect_to_s06_couplers_ARVALID),
        .S_AXI_awaddr(axi_cpu_interconnect_to_s06_couplers_AWADDR),
        .S_AXI_awburst(axi_cpu_interconnect_to_s06_couplers_AWBURST),
        .S_AXI_awcache(axi_cpu_interconnect_to_s06_couplers_AWCACHE),
        .S_AXI_awid(axi_cpu_interconnect_to_s06_couplers_AWID),
        .S_AXI_awlen(axi_cpu_interconnect_to_s06_couplers_AWLEN),
        .S_AXI_awlock(axi_cpu_interconnect_to_s06_couplers_AWLOCK),
        .S_AXI_awprot(axi_cpu_interconnect_to_s06_couplers_AWPROT),
        .S_AXI_awqos(axi_cpu_interconnect_to_s06_couplers_AWQOS),
        .S_AXI_awready(axi_cpu_interconnect_to_s06_couplers_AWREADY),
        .S_AXI_awsize(axi_cpu_interconnect_to_s06_couplers_AWSIZE),
        .S_AXI_awvalid(axi_cpu_interconnect_to_s06_couplers_AWVALID),
        .S_AXI_bid(axi_cpu_interconnect_to_s06_couplers_BID),
        .S_AXI_bready(axi_cpu_interconnect_to_s06_couplers_BREADY),
        .S_AXI_bresp(axi_cpu_interconnect_to_s06_couplers_BRESP),
        .S_AXI_bvalid(axi_cpu_interconnect_to_s06_couplers_BVALID),
        .S_AXI_rdata(axi_cpu_interconnect_to_s06_couplers_RDATA),
        .S_AXI_rid(axi_cpu_interconnect_to_s06_couplers_RID),
        .S_AXI_rlast(axi_cpu_interconnect_to_s06_couplers_RLAST),
        .S_AXI_rready(axi_cpu_interconnect_to_s06_couplers_RREADY),
        .S_AXI_rresp(axi_cpu_interconnect_to_s06_couplers_RRESP),
        .S_AXI_rvalid(axi_cpu_interconnect_to_s06_couplers_RVALID),
        .S_AXI_wdata(axi_cpu_interconnect_to_s06_couplers_WDATA),
        .S_AXI_wlast(axi_cpu_interconnect_to_s06_couplers_WLAST),
        .S_AXI_wready(axi_cpu_interconnect_to_s06_couplers_WREADY),
        .S_AXI_wstrb(axi_cpu_interconnect_to_s06_couplers_WSTRB),
        .S_AXI_wvalid(axi_cpu_interconnect_to_s06_couplers_WVALID));
  system_i_bak_xbar_0 xbar
       (.aclk(axi_cpu_interconnect_ACLK_net),
        .aresetn(axi_cpu_interconnect_ARESETN_net),
        .m_axi_araddr({xbar_to_m14_couplers_ARADDR,xbar_to_m13_couplers_ARADDR,xbar_to_m12_couplers_ARADDR,xbar_to_m11_couplers_ARADDR,xbar_to_m10_couplers_ARADDR,xbar_to_m09_couplers_ARADDR,xbar_to_m08_couplers_ARADDR,xbar_to_m07_couplers_ARADDR,xbar_to_m06_couplers_ARADDR,xbar_to_m05_couplers_ARADDR,xbar_to_m04_couplers_ARADDR,xbar_to_m03_couplers_ARADDR,xbar_to_m02_couplers_ARADDR,xbar_to_m01_couplers_ARADDR,xbar_to_m00_couplers_ARADDR}),
        .m_axi_arburst({xbar_to_m14_couplers_ARBURST,xbar_to_m13_couplers_ARBURST,xbar_to_m12_couplers_ARBURST,xbar_to_m11_couplers_ARBURST,xbar_to_m10_couplers_ARBURST,xbar_to_m09_couplers_ARBURST,xbar_to_m08_couplers_ARBURST,xbar_to_m07_couplers_ARBURST,xbar_to_m06_couplers_ARBURST,xbar_to_m05_couplers_ARBURST,xbar_to_m04_couplers_ARBURST,xbar_to_m03_couplers_ARBURST,xbar_to_m02_couplers_ARBURST,xbar_to_m01_couplers_ARBURST,xbar_to_m00_couplers_ARBURST}),
        .m_axi_arcache({xbar_to_m14_couplers_ARCACHE,xbar_to_m13_couplers_ARCACHE,xbar_to_m12_couplers_ARCACHE,xbar_to_m11_couplers_ARCACHE,xbar_to_m10_couplers_ARCACHE,xbar_to_m09_couplers_ARCACHE,xbar_to_m08_couplers_ARCACHE,xbar_to_m07_couplers_ARCACHE,xbar_to_m06_couplers_ARCACHE,xbar_to_m05_couplers_ARCACHE,xbar_to_m04_couplers_ARCACHE,xbar_to_m03_couplers_ARCACHE,xbar_to_m02_couplers_ARCACHE,xbar_to_m01_couplers_ARCACHE,xbar_to_m00_couplers_ARCACHE}),
        .m_axi_arlen({xbar_to_m14_couplers_ARLEN,xbar_to_m13_couplers_ARLEN,xbar_to_m12_couplers_ARLEN,xbar_to_m11_couplers_ARLEN,xbar_to_m10_couplers_ARLEN,xbar_to_m09_couplers_ARLEN,xbar_to_m08_couplers_ARLEN,xbar_to_m07_couplers_ARLEN,xbar_to_m06_couplers_ARLEN,xbar_to_m05_couplers_ARLEN,xbar_to_m04_couplers_ARLEN,xbar_to_m03_couplers_ARLEN,xbar_to_m02_couplers_ARLEN,xbar_to_m01_couplers_ARLEN,xbar_to_m00_couplers_ARLEN}),
        .m_axi_arlock({xbar_to_m14_couplers_ARLOCK,xbar_to_m13_couplers_ARLOCK,xbar_to_m12_couplers_ARLOCK,xbar_to_m11_couplers_ARLOCK,xbar_to_m10_couplers_ARLOCK,xbar_to_m09_couplers_ARLOCK,xbar_to_m08_couplers_ARLOCK,xbar_to_m07_couplers_ARLOCK,xbar_to_m06_couplers_ARLOCK,xbar_to_m05_couplers_ARLOCK,xbar_to_m04_couplers_ARLOCK,xbar_to_m03_couplers_ARLOCK,xbar_to_m02_couplers_ARLOCK,xbar_to_m01_couplers_ARLOCK,xbar_to_m00_couplers_ARLOCK}),
        .m_axi_arprot({xbar_to_m14_couplers_ARPROT,xbar_to_m13_couplers_ARPROT,xbar_to_m12_couplers_ARPROT,xbar_to_m11_couplers_ARPROT,xbar_to_m10_couplers_ARPROT,xbar_to_m09_couplers_ARPROT,xbar_to_m08_couplers_ARPROT,xbar_to_m07_couplers_ARPROT,xbar_to_m06_couplers_ARPROT,xbar_to_m05_couplers_ARPROT,xbar_to_m04_couplers_ARPROT,xbar_to_m03_couplers_ARPROT,xbar_to_m02_couplers_ARPROT,xbar_to_m01_couplers_ARPROT,xbar_to_m00_couplers_ARPROT}),
        .m_axi_arqos({xbar_to_m14_couplers_ARQOS,xbar_to_m13_couplers_ARQOS,xbar_to_m12_couplers_ARQOS,xbar_to_m11_couplers_ARQOS,xbar_to_m10_couplers_ARQOS,xbar_to_m09_couplers_ARQOS,xbar_to_m08_couplers_ARQOS,xbar_to_m07_couplers_ARQOS,xbar_to_m06_couplers_ARQOS,xbar_to_m05_couplers_ARQOS,xbar_to_m04_couplers_ARQOS,xbar_to_m03_couplers_ARQOS,xbar_to_m02_couplers_ARQOS,xbar_to_m01_couplers_ARQOS,xbar_to_m00_couplers_ARQOS}),
        .m_axi_arready({xbar_to_m14_couplers_ARREADY,xbar_to_m13_couplers_ARREADY,xbar_to_m12_couplers_ARREADY,xbar_to_m11_couplers_ARREADY,xbar_to_m10_couplers_ARREADY,xbar_to_m09_couplers_ARREADY,xbar_to_m08_couplers_ARREADY,xbar_to_m07_couplers_ARREADY,xbar_to_m06_couplers_ARREADY,xbar_to_m05_couplers_ARREADY,xbar_to_m04_couplers_ARREADY,xbar_to_m03_couplers_ARREADY,xbar_to_m02_couplers_ARREADY,xbar_to_m01_couplers_ARREADY,xbar_to_m00_couplers_ARREADY}),
        .m_axi_arregion({xbar_to_m14_couplers_ARREGION,xbar_to_m13_couplers_ARREGION,xbar_to_m12_couplers_ARREGION,xbar_to_m11_couplers_ARREGION,xbar_to_m10_couplers_ARREGION,xbar_to_m09_couplers_ARREGION,xbar_to_m08_couplers_ARREGION,xbar_to_m07_couplers_ARREGION,xbar_to_m06_couplers_ARREGION,xbar_to_m05_couplers_ARREGION,xbar_to_m04_couplers_ARREGION,xbar_to_m03_couplers_ARREGION,xbar_to_m02_couplers_ARREGION,xbar_to_m01_couplers_ARREGION,xbar_to_m00_couplers_ARREGION}),
        .m_axi_arsize({xbar_to_m14_couplers_ARSIZE,xbar_to_m13_couplers_ARSIZE,xbar_to_m12_couplers_ARSIZE,xbar_to_m11_couplers_ARSIZE,xbar_to_m10_couplers_ARSIZE,xbar_to_m09_couplers_ARSIZE,xbar_to_m08_couplers_ARSIZE,xbar_to_m07_couplers_ARSIZE,xbar_to_m06_couplers_ARSIZE,xbar_to_m05_couplers_ARSIZE,xbar_to_m04_couplers_ARSIZE,xbar_to_m03_couplers_ARSIZE,xbar_to_m02_couplers_ARSIZE,xbar_to_m01_couplers_ARSIZE,xbar_to_m00_couplers_ARSIZE}),
        .m_axi_arvalid({xbar_to_m14_couplers_ARVALID,xbar_to_m13_couplers_ARVALID,xbar_to_m12_couplers_ARVALID,xbar_to_m11_couplers_ARVALID,xbar_to_m10_couplers_ARVALID,xbar_to_m09_couplers_ARVALID,xbar_to_m08_couplers_ARVALID,xbar_to_m07_couplers_ARVALID,xbar_to_m06_couplers_ARVALID,xbar_to_m05_couplers_ARVALID,xbar_to_m04_couplers_ARVALID,xbar_to_m03_couplers_ARVALID,xbar_to_m02_couplers_ARVALID,xbar_to_m01_couplers_ARVALID,xbar_to_m00_couplers_ARVALID}),
        .m_axi_awaddr({xbar_to_m14_couplers_AWADDR,xbar_to_m13_couplers_AWADDR,xbar_to_m12_couplers_AWADDR,xbar_to_m11_couplers_AWADDR,xbar_to_m10_couplers_AWADDR,xbar_to_m09_couplers_AWADDR,xbar_to_m08_couplers_AWADDR,xbar_to_m07_couplers_AWADDR,xbar_to_m06_couplers_AWADDR,xbar_to_m05_couplers_AWADDR,xbar_to_m04_couplers_AWADDR,xbar_to_m03_couplers_AWADDR,xbar_to_m02_couplers_AWADDR,xbar_to_m01_couplers_AWADDR,xbar_to_m00_couplers_AWADDR}),
        .m_axi_awburst({xbar_to_m14_couplers_AWBURST,xbar_to_m13_couplers_AWBURST,xbar_to_m12_couplers_AWBURST,xbar_to_m11_couplers_AWBURST,xbar_to_m10_couplers_AWBURST,xbar_to_m09_couplers_AWBURST,xbar_to_m08_couplers_AWBURST,xbar_to_m07_couplers_AWBURST,xbar_to_m06_couplers_AWBURST,xbar_to_m05_couplers_AWBURST,xbar_to_m04_couplers_AWBURST,xbar_to_m03_couplers_AWBURST,xbar_to_m02_couplers_AWBURST,xbar_to_m01_couplers_AWBURST,xbar_to_m00_couplers_AWBURST}),
        .m_axi_awcache({xbar_to_m14_couplers_AWCACHE,xbar_to_m13_couplers_AWCACHE,xbar_to_m12_couplers_AWCACHE,xbar_to_m11_couplers_AWCACHE,xbar_to_m10_couplers_AWCACHE,xbar_to_m09_couplers_AWCACHE,xbar_to_m08_couplers_AWCACHE,xbar_to_m07_couplers_AWCACHE,xbar_to_m06_couplers_AWCACHE,xbar_to_m05_couplers_AWCACHE,xbar_to_m04_couplers_AWCACHE,xbar_to_m03_couplers_AWCACHE,xbar_to_m02_couplers_AWCACHE,xbar_to_m01_couplers_AWCACHE,xbar_to_m00_couplers_AWCACHE}),
        .m_axi_awlen({xbar_to_m14_couplers_AWLEN,xbar_to_m13_couplers_AWLEN,xbar_to_m12_couplers_AWLEN,xbar_to_m11_couplers_AWLEN,xbar_to_m10_couplers_AWLEN,xbar_to_m09_couplers_AWLEN,xbar_to_m08_couplers_AWLEN,xbar_to_m07_couplers_AWLEN,xbar_to_m06_couplers_AWLEN,xbar_to_m05_couplers_AWLEN,xbar_to_m04_couplers_AWLEN,xbar_to_m03_couplers_AWLEN,xbar_to_m02_couplers_AWLEN,xbar_to_m01_couplers_AWLEN,xbar_to_m00_couplers_AWLEN}),
        .m_axi_awlock({xbar_to_m14_couplers_AWLOCK,xbar_to_m13_couplers_AWLOCK,xbar_to_m12_couplers_AWLOCK,xbar_to_m11_couplers_AWLOCK,xbar_to_m10_couplers_AWLOCK,xbar_to_m09_couplers_AWLOCK,xbar_to_m08_couplers_AWLOCK,xbar_to_m07_couplers_AWLOCK,xbar_to_m06_couplers_AWLOCK,xbar_to_m05_couplers_AWLOCK,xbar_to_m04_couplers_AWLOCK,xbar_to_m03_couplers_AWLOCK,xbar_to_m02_couplers_AWLOCK,xbar_to_m01_couplers_AWLOCK,xbar_to_m00_couplers_AWLOCK}),
        .m_axi_awprot({xbar_to_m14_couplers_AWPROT,xbar_to_m13_couplers_AWPROT,xbar_to_m12_couplers_AWPROT,xbar_to_m11_couplers_AWPROT,xbar_to_m10_couplers_AWPROT,xbar_to_m09_couplers_AWPROT,xbar_to_m08_couplers_AWPROT,xbar_to_m07_couplers_AWPROT,xbar_to_m06_couplers_AWPROT,xbar_to_m05_couplers_AWPROT,xbar_to_m04_couplers_AWPROT,xbar_to_m03_couplers_AWPROT,xbar_to_m02_couplers_AWPROT,xbar_to_m01_couplers_AWPROT,xbar_to_m00_couplers_AWPROT}),
        .m_axi_awqos({xbar_to_m14_couplers_AWQOS,xbar_to_m13_couplers_AWQOS,xbar_to_m12_couplers_AWQOS,xbar_to_m11_couplers_AWQOS,xbar_to_m10_couplers_AWQOS,xbar_to_m09_couplers_AWQOS,xbar_to_m08_couplers_AWQOS,xbar_to_m07_couplers_AWQOS,xbar_to_m06_couplers_AWQOS,xbar_to_m05_couplers_AWQOS,xbar_to_m04_couplers_AWQOS,xbar_to_m03_couplers_AWQOS,xbar_to_m02_couplers_AWQOS,xbar_to_m01_couplers_AWQOS,xbar_to_m00_couplers_AWQOS}),
        .m_axi_awready({xbar_to_m14_couplers_AWREADY,xbar_to_m13_couplers_AWREADY,xbar_to_m12_couplers_AWREADY,xbar_to_m11_couplers_AWREADY,xbar_to_m10_couplers_AWREADY,xbar_to_m09_couplers_AWREADY,xbar_to_m08_couplers_AWREADY,xbar_to_m07_couplers_AWREADY,xbar_to_m06_couplers_AWREADY,xbar_to_m05_couplers_AWREADY,xbar_to_m04_couplers_AWREADY,xbar_to_m03_couplers_AWREADY,xbar_to_m02_couplers_AWREADY,xbar_to_m01_couplers_AWREADY,xbar_to_m00_couplers_AWREADY}),
        .m_axi_awregion({xbar_to_m14_couplers_AWREGION,xbar_to_m13_couplers_AWREGION,xbar_to_m12_couplers_AWREGION,xbar_to_m11_couplers_AWREGION,xbar_to_m10_couplers_AWREGION,xbar_to_m09_couplers_AWREGION,xbar_to_m08_couplers_AWREGION,xbar_to_m07_couplers_AWREGION,xbar_to_m06_couplers_AWREGION,xbar_to_m05_couplers_AWREGION,xbar_to_m04_couplers_AWREGION,xbar_to_m03_couplers_AWREGION,xbar_to_m02_couplers_AWREGION,xbar_to_m01_couplers_AWREGION,xbar_to_m00_couplers_AWREGION}),
        .m_axi_awsize({xbar_to_m14_couplers_AWSIZE,xbar_to_m13_couplers_AWSIZE,xbar_to_m12_couplers_AWSIZE,xbar_to_m11_couplers_AWSIZE,xbar_to_m10_couplers_AWSIZE,xbar_to_m09_couplers_AWSIZE,xbar_to_m08_couplers_AWSIZE,xbar_to_m07_couplers_AWSIZE,xbar_to_m06_couplers_AWSIZE,xbar_to_m05_couplers_AWSIZE,xbar_to_m04_couplers_AWSIZE,xbar_to_m03_couplers_AWSIZE,xbar_to_m02_couplers_AWSIZE,xbar_to_m01_couplers_AWSIZE,xbar_to_m00_couplers_AWSIZE}),
        .m_axi_awvalid({xbar_to_m14_couplers_AWVALID,xbar_to_m13_couplers_AWVALID,xbar_to_m12_couplers_AWVALID,xbar_to_m11_couplers_AWVALID,xbar_to_m10_couplers_AWVALID,xbar_to_m09_couplers_AWVALID,xbar_to_m08_couplers_AWVALID,xbar_to_m07_couplers_AWVALID,xbar_to_m06_couplers_AWVALID,xbar_to_m05_couplers_AWVALID,xbar_to_m04_couplers_AWVALID,xbar_to_m03_couplers_AWVALID,xbar_to_m02_couplers_AWVALID,xbar_to_m01_couplers_AWVALID,xbar_to_m00_couplers_AWVALID}),
        .m_axi_bready({xbar_to_m14_couplers_BREADY,xbar_to_m13_couplers_BREADY,xbar_to_m12_couplers_BREADY,xbar_to_m11_couplers_BREADY,xbar_to_m10_couplers_BREADY,xbar_to_m09_couplers_BREADY,xbar_to_m08_couplers_BREADY,xbar_to_m07_couplers_BREADY,xbar_to_m06_couplers_BREADY,xbar_to_m05_couplers_BREADY,xbar_to_m04_couplers_BREADY,xbar_to_m03_couplers_BREADY,xbar_to_m02_couplers_BREADY,xbar_to_m01_couplers_BREADY,xbar_to_m00_couplers_BREADY}),
        .m_axi_bresp({xbar_to_m14_couplers_BRESP,xbar_to_m13_couplers_BRESP,xbar_to_m12_couplers_BRESP,xbar_to_m11_couplers_BRESP,xbar_to_m10_couplers_BRESP,xbar_to_m09_couplers_BRESP,xbar_to_m08_couplers_BRESP,xbar_to_m07_couplers_BRESP,xbar_to_m06_couplers_BRESP,xbar_to_m05_couplers_BRESP,xbar_to_m04_couplers_BRESP,xbar_to_m03_couplers_BRESP,xbar_to_m02_couplers_BRESP,xbar_to_m01_couplers_BRESP,xbar_to_m00_couplers_BRESP}),
        .m_axi_bvalid({xbar_to_m14_couplers_BVALID,xbar_to_m13_couplers_BVALID,xbar_to_m12_couplers_BVALID,xbar_to_m11_couplers_BVALID,xbar_to_m10_couplers_BVALID,xbar_to_m09_couplers_BVALID,xbar_to_m08_couplers_BVALID,xbar_to_m07_couplers_BVALID,xbar_to_m06_couplers_BVALID,xbar_to_m05_couplers_BVALID,xbar_to_m04_couplers_BVALID,xbar_to_m03_couplers_BVALID,xbar_to_m02_couplers_BVALID,xbar_to_m01_couplers_BVALID,xbar_to_m00_couplers_BVALID}),
        .m_axi_rdata({xbar_to_m14_couplers_RDATA,xbar_to_m13_couplers_RDATA,xbar_to_m12_couplers_RDATA,xbar_to_m11_couplers_RDATA,xbar_to_m10_couplers_RDATA,xbar_to_m09_couplers_RDATA,xbar_to_m08_couplers_RDATA,xbar_to_m07_couplers_RDATA,xbar_to_m06_couplers_RDATA,xbar_to_m05_couplers_RDATA,xbar_to_m04_couplers_RDATA,xbar_to_m03_couplers_RDATA,xbar_to_m02_couplers_RDATA,xbar_to_m01_couplers_RDATA,xbar_to_m00_couplers_RDATA}),
        .m_axi_rlast({xbar_to_m14_couplers_RLAST,xbar_to_m13_couplers_RLAST,xbar_to_m12_couplers_RLAST,xbar_to_m11_couplers_RLAST,xbar_to_m10_couplers_RLAST,xbar_to_m09_couplers_RLAST,xbar_to_m08_couplers_RLAST,xbar_to_m07_couplers_RLAST,xbar_to_m06_couplers_RLAST,xbar_to_m05_couplers_RLAST,xbar_to_m04_couplers_RLAST,xbar_to_m03_couplers_RLAST,xbar_to_m02_couplers_RLAST,xbar_to_m01_couplers_RLAST,xbar_to_m00_couplers_RLAST}),
        .m_axi_rready({xbar_to_m14_couplers_RREADY,xbar_to_m13_couplers_RREADY,xbar_to_m12_couplers_RREADY,xbar_to_m11_couplers_RREADY,xbar_to_m10_couplers_RREADY,xbar_to_m09_couplers_RREADY,xbar_to_m08_couplers_RREADY,xbar_to_m07_couplers_RREADY,xbar_to_m06_couplers_RREADY,xbar_to_m05_couplers_RREADY,xbar_to_m04_couplers_RREADY,xbar_to_m03_couplers_RREADY,xbar_to_m02_couplers_RREADY,xbar_to_m01_couplers_RREADY,xbar_to_m00_couplers_RREADY}),
        .m_axi_rresp({xbar_to_m14_couplers_RRESP,xbar_to_m13_couplers_RRESP,xbar_to_m12_couplers_RRESP,xbar_to_m11_couplers_RRESP,xbar_to_m10_couplers_RRESP,xbar_to_m09_couplers_RRESP,xbar_to_m08_couplers_RRESP,xbar_to_m07_couplers_RRESP,xbar_to_m06_couplers_RRESP,xbar_to_m05_couplers_RRESP,xbar_to_m04_couplers_RRESP,xbar_to_m03_couplers_RRESP,xbar_to_m02_couplers_RRESP,xbar_to_m01_couplers_RRESP,xbar_to_m00_couplers_RRESP}),
        .m_axi_rvalid({xbar_to_m14_couplers_RVALID,xbar_to_m13_couplers_RVALID,xbar_to_m12_couplers_RVALID,xbar_to_m11_couplers_RVALID,xbar_to_m10_couplers_RVALID,xbar_to_m09_couplers_RVALID,xbar_to_m08_couplers_RVALID,xbar_to_m07_couplers_RVALID,xbar_to_m06_couplers_RVALID,xbar_to_m05_couplers_RVALID,xbar_to_m04_couplers_RVALID,xbar_to_m03_couplers_RVALID,xbar_to_m02_couplers_RVALID,xbar_to_m01_couplers_RVALID,xbar_to_m00_couplers_RVALID}),
        .m_axi_wdata({xbar_to_m14_couplers_WDATA,xbar_to_m13_couplers_WDATA,xbar_to_m12_couplers_WDATA,xbar_to_m11_couplers_WDATA,xbar_to_m10_couplers_WDATA,xbar_to_m09_couplers_WDATA,xbar_to_m08_couplers_WDATA,xbar_to_m07_couplers_WDATA,xbar_to_m06_couplers_WDATA,xbar_to_m05_couplers_WDATA,xbar_to_m04_couplers_WDATA,xbar_to_m03_couplers_WDATA,xbar_to_m02_couplers_WDATA,xbar_to_m01_couplers_WDATA,xbar_to_m00_couplers_WDATA}),
        .m_axi_wlast({xbar_to_m14_couplers_WLAST,xbar_to_m13_couplers_WLAST,xbar_to_m12_couplers_WLAST,xbar_to_m11_couplers_WLAST,xbar_to_m10_couplers_WLAST,xbar_to_m09_couplers_WLAST,xbar_to_m08_couplers_WLAST,xbar_to_m07_couplers_WLAST,xbar_to_m06_couplers_WLAST,xbar_to_m05_couplers_WLAST,xbar_to_m04_couplers_WLAST,xbar_to_m03_couplers_WLAST,xbar_to_m02_couplers_WLAST,xbar_to_m01_couplers_WLAST,xbar_to_m00_couplers_WLAST}),
        .m_axi_wready({xbar_to_m14_couplers_WREADY,xbar_to_m13_couplers_WREADY,xbar_to_m12_couplers_WREADY,xbar_to_m11_couplers_WREADY,xbar_to_m10_couplers_WREADY,xbar_to_m09_couplers_WREADY,xbar_to_m08_couplers_WREADY,xbar_to_m07_couplers_WREADY,xbar_to_m06_couplers_WREADY,xbar_to_m05_couplers_WREADY,xbar_to_m04_couplers_WREADY,xbar_to_m03_couplers_WREADY,xbar_to_m02_couplers_WREADY,xbar_to_m01_couplers_WREADY,xbar_to_m00_couplers_WREADY}),
        .m_axi_wstrb({xbar_to_m14_couplers_WSTRB,xbar_to_m13_couplers_WSTRB,xbar_to_m12_couplers_WSTRB,xbar_to_m11_couplers_WSTRB,xbar_to_m10_couplers_WSTRB,xbar_to_m09_couplers_WSTRB,xbar_to_m08_couplers_WSTRB,xbar_to_m07_couplers_WSTRB,xbar_to_m06_couplers_WSTRB,xbar_to_m05_couplers_WSTRB,xbar_to_m04_couplers_WSTRB,xbar_to_m03_couplers_WSTRB,xbar_to_m02_couplers_WSTRB,xbar_to_m01_couplers_WSTRB,xbar_to_m00_couplers_WSTRB}),
        .m_axi_wvalid({xbar_to_m14_couplers_WVALID,xbar_to_m13_couplers_WVALID,xbar_to_m12_couplers_WVALID,xbar_to_m11_couplers_WVALID,xbar_to_m10_couplers_WVALID,xbar_to_m09_couplers_WVALID,xbar_to_m08_couplers_WVALID,xbar_to_m07_couplers_WVALID,xbar_to_m06_couplers_WVALID,xbar_to_m05_couplers_WVALID,xbar_to_m04_couplers_WVALID,xbar_to_m03_couplers_WVALID,xbar_to_m02_couplers_WVALID,xbar_to_m01_couplers_WVALID,xbar_to_m00_couplers_WVALID}),
        .s_axi_araddr({s06_couplers_to_xbar_ARADDR,s05_couplers_to_xbar_ARADDR,s04_couplers_to_xbar_ARADDR,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,s02_couplers_to_xbar_ARADDR,s01_couplers_to_xbar_ARADDR,s00_couplers_to_xbar_ARADDR}),
        .s_axi_arburst({s06_couplers_to_xbar_ARBURST,s05_couplers_to_xbar_ARBURST,s04_couplers_to_xbar_ARBURST,1'b0,1'b0,s02_couplers_to_xbar_ARBURST,s01_couplers_to_xbar_ARBURST,s00_couplers_to_xbar_ARBURST}),
        .s_axi_arcache({s06_couplers_to_xbar_ARCACHE,s05_couplers_to_xbar_ARCACHE,s04_couplers_to_xbar_ARCACHE,1'b0,1'b0,1'b0,1'b0,s02_couplers_to_xbar_ARCACHE,s01_couplers_to_xbar_ARCACHE,s00_couplers_to_xbar_ARCACHE}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({s06_couplers_to_xbar_ARLEN,s05_couplers_to_xbar_ARLEN,s04_couplers_to_xbar_ARLEN,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,s02_couplers_to_xbar_ARLEN,s01_couplers_to_xbar_ARLEN,s00_couplers_to_xbar_ARLEN}),
        .s_axi_arlock({s06_couplers_to_xbar_ARLOCK,s05_couplers_to_xbar_ARLOCK,s04_couplers_to_xbar_ARLOCK,1'b0,s02_couplers_to_xbar_ARLOCK,s01_couplers_to_xbar_ARLOCK,s00_couplers_to_xbar_ARLOCK}),
        .s_axi_arprot({s06_couplers_to_xbar_ARPROT,s05_couplers_to_xbar_ARPROT,s04_couplers_to_xbar_ARPROT,1'b0,1'b0,1'b0,s02_couplers_to_xbar_ARPROT,s01_couplers_to_xbar_ARPROT,s00_couplers_to_xbar_ARPROT}),
        .s_axi_arqos({s06_couplers_to_xbar_ARQOS,s05_couplers_to_xbar_ARQOS,s04_couplers_to_xbar_ARQOS,1'b0,1'b0,1'b0,1'b0,s02_couplers_to_xbar_ARQOS,s01_couplers_to_xbar_ARQOS,s00_couplers_to_xbar_ARQOS}),
        .s_axi_arready({s06_couplers_to_xbar_ARREADY,s05_couplers_to_xbar_ARREADY,s04_couplers_to_xbar_ARREADY,NLW_xbar_s_axi_arready_UNCONNECTED[3],s02_couplers_to_xbar_ARREADY,s01_couplers_to_xbar_ARREADY,s00_couplers_to_xbar_ARREADY}),
        .s_axi_arsize({s06_couplers_to_xbar_ARSIZE,s05_couplers_to_xbar_ARSIZE,s04_couplers_to_xbar_ARSIZE,1'b0,1'b0,1'b0,s02_couplers_to_xbar_ARSIZE,s01_couplers_to_xbar_ARSIZE,s00_couplers_to_xbar_ARSIZE}),
        .s_axi_arvalid({s06_couplers_to_xbar_ARVALID,s05_couplers_to_xbar_ARVALID,s04_couplers_to_xbar_ARVALID,1'b0,s02_couplers_to_xbar_ARVALID,s01_couplers_to_xbar_ARVALID,s00_couplers_to_xbar_ARVALID}),
        .s_axi_awaddr({s06_couplers_to_xbar_AWADDR,s05_couplers_to_xbar_AWADDR,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,s03_couplers_to_xbar_AWADDR,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,s01_couplers_to_xbar_AWADDR,s00_couplers_to_xbar_AWADDR}),
        .s_axi_awburst({s06_couplers_to_xbar_AWBURST,s05_couplers_to_xbar_AWBURST,1'b0,1'b0,s03_couplers_to_xbar_AWBURST,1'b0,1'b0,s01_couplers_to_xbar_AWBURST,s00_couplers_to_xbar_AWBURST}),
        .s_axi_awcache({s06_couplers_to_xbar_AWCACHE,s05_couplers_to_xbar_AWCACHE,1'b0,1'b0,1'b0,1'b0,s03_couplers_to_xbar_AWCACHE,1'b0,1'b0,1'b0,1'b0,s01_couplers_to_xbar_AWCACHE,s00_couplers_to_xbar_AWCACHE}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({s06_couplers_to_xbar_AWLEN,s05_couplers_to_xbar_AWLEN,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,s03_couplers_to_xbar_AWLEN,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,s01_couplers_to_xbar_AWLEN,s00_couplers_to_xbar_AWLEN}),
        .s_axi_awlock({s06_couplers_to_xbar_AWLOCK,s05_couplers_to_xbar_AWLOCK,1'b0,s03_couplers_to_xbar_AWLOCK,1'b0,s01_couplers_to_xbar_AWLOCK,s00_couplers_to_xbar_AWLOCK}),
        .s_axi_awprot({s06_couplers_to_xbar_AWPROT,s05_couplers_to_xbar_AWPROT,1'b0,1'b0,1'b0,s03_couplers_to_xbar_AWPROT,1'b0,1'b0,1'b0,s01_couplers_to_xbar_AWPROT,s00_couplers_to_xbar_AWPROT}),
        .s_axi_awqos({s06_couplers_to_xbar_AWQOS,s05_couplers_to_xbar_AWQOS,1'b0,1'b0,1'b0,1'b0,s03_couplers_to_xbar_AWQOS,1'b0,1'b0,1'b0,1'b0,s01_couplers_to_xbar_AWQOS,s00_couplers_to_xbar_AWQOS}),
        .s_axi_awready({s06_couplers_to_xbar_AWREADY,s05_couplers_to_xbar_AWREADY,NLW_xbar_s_axi_awready_UNCONNECTED[4],s03_couplers_to_xbar_AWREADY,NLW_xbar_s_axi_awready_UNCONNECTED[2],s01_couplers_to_xbar_AWREADY,s00_couplers_to_xbar_AWREADY}),
        .s_axi_awsize({s06_couplers_to_xbar_AWSIZE,s05_couplers_to_xbar_AWSIZE,1'b0,1'b0,1'b0,s03_couplers_to_xbar_AWSIZE,1'b0,1'b0,1'b0,s01_couplers_to_xbar_AWSIZE,s00_couplers_to_xbar_AWSIZE}),
        .s_axi_awvalid({s06_couplers_to_xbar_AWVALID,s05_couplers_to_xbar_AWVALID,1'b0,s03_couplers_to_xbar_AWVALID,1'b0,s01_couplers_to_xbar_AWVALID,s00_couplers_to_xbar_AWVALID}),
        .s_axi_bready({s06_couplers_to_xbar_BREADY,s05_couplers_to_xbar_BREADY,1'b0,s03_couplers_to_xbar_BREADY,1'b0,s01_couplers_to_xbar_BREADY,s00_couplers_to_xbar_BREADY}),
        .s_axi_bresp({s06_couplers_to_xbar_BRESP,s05_couplers_to_xbar_BRESP,NLW_xbar_s_axi_bresp_UNCONNECTED[9:8],s03_couplers_to_xbar_BRESP,NLW_xbar_s_axi_bresp_UNCONNECTED[5:4],s01_couplers_to_xbar_BRESP,s00_couplers_to_xbar_BRESP}),
        .s_axi_bvalid({s06_couplers_to_xbar_BVALID,s05_couplers_to_xbar_BVALID,NLW_xbar_s_axi_bvalid_UNCONNECTED[4],s03_couplers_to_xbar_BVALID,NLW_xbar_s_axi_bvalid_UNCONNECTED[2],s01_couplers_to_xbar_BVALID,s00_couplers_to_xbar_BVALID}),
        .s_axi_rdata({s06_couplers_to_xbar_RDATA,s05_couplers_to_xbar_RDATA,s04_couplers_to_xbar_RDATA,NLW_xbar_s_axi_rdata_UNCONNECTED[2047:1536],s02_couplers_to_xbar_RDATA,s01_couplers_to_xbar_RDATA,s00_couplers_to_xbar_RDATA}),
        .s_axi_rlast({s06_couplers_to_xbar_RLAST,s05_couplers_to_xbar_RLAST,s04_couplers_to_xbar_RLAST,NLW_xbar_s_axi_rlast_UNCONNECTED[3],s02_couplers_to_xbar_RLAST,s01_couplers_to_xbar_RLAST,s00_couplers_to_xbar_RLAST}),
        .s_axi_rready({s06_couplers_to_xbar_RREADY,s05_couplers_to_xbar_RREADY,s04_couplers_to_xbar_RREADY,1'b0,s02_couplers_to_xbar_RREADY,s01_couplers_to_xbar_RREADY,s00_couplers_to_xbar_RREADY}),
        .s_axi_rresp({s06_couplers_to_xbar_RRESP,s05_couplers_to_xbar_RRESP,s04_couplers_to_xbar_RRESP,NLW_xbar_s_axi_rresp_UNCONNECTED[7:6],s02_couplers_to_xbar_RRESP,s01_couplers_to_xbar_RRESP,s00_couplers_to_xbar_RRESP}),
        .s_axi_rvalid({s06_couplers_to_xbar_RVALID,s05_couplers_to_xbar_RVALID,s04_couplers_to_xbar_RVALID,NLW_xbar_s_axi_rvalid_UNCONNECTED[3],s02_couplers_to_xbar_RVALID,s01_couplers_to_xbar_RVALID,s00_couplers_to_xbar_RVALID}),
        .s_axi_wdata({s06_couplers_to_xbar_WDATA,s05_couplers_to_xbar_WDATA,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,s03_couplers_to_xbar_WDATA,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,s01_couplers_to_xbar_WDATA,s00_couplers_to_xbar_WDATA}),
        .s_axi_wlast({s06_couplers_to_xbar_WLAST,s05_couplers_to_xbar_WLAST,1'b1,s03_couplers_to_xbar_WLAST,1'b1,s01_couplers_to_xbar_WLAST,s00_couplers_to_xbar_WLAST}),
        .s_axi_wready({s06_couplers_to_xbar_WREADY,s05_couplers_to_xbar_WREADY,NLW_xbar_s_axi_wready_UNCONNECTED[4],s03_couplers_to_xbar_WREADY,NLW_xbar_s_axi_wready_UNCONNECTED[2],s01_couplers_to_xbar_WREADY,s00_couplers_to_xbar_WREADY}),
        .s_axi_wstrb({s06_couplers_to_xbar_WSTRB,s05_couplers_to_xbar_WSTRB,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,s03_couplers_to_xbar_WSTRB,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,s01_couplers_to_xbar_WSTRB,s00_couplers_to_xbar_WSTRB}),
        .s_axi_wvalid({s06_couplers_to_xbar_WVALID,s05_couplers_to_xbar_WVALID,1'b0,s03_couplers_to_xbar_WVALID,1'b0,s01_couplers_to_xbar_WVALID,s00_couplers_to_xbar_WVALID}));
endmodule

module system_i_bak_axi_interconnect_0_0
   (ACLK,
    ARESETN,
    M00_ACLK,
    M00_ARESETN,
    M00_AXI_araddr,
    M00_AXI_arburst,
    M00_AXI_arcache,
    M00_AXI_arid,
    M00_AXI_arlen,
    M00_AXI_arlock,
    M00_AXI_arprot,
    M00_AXI_arqos,
    M00_AXI_arready,
    M00_AXI_arsize,
    M00_AXI_arvalid,
    M00_AXI_awaddr,
    M00_AXI_awburst,
    M00_AXI_awcache,
    M00_AXI_awid,
    M00_AXI_awlen,
    M00_AXI_awlock,
    M00_AXI_awprot,
    M00_AXI_awqos,
    M00_AXI_awready,
    M00_AXI_awsize,
    M00_AXI_awvalid,
    M00_AXI_bid,
    M00_AXI_bready,
    M00_AXI_bresp,
    M00_AXI_bvalid,
    M00_AXI_rdata,
    M00_AXI_rid,
    M00_AXI_rlast,
    M00_AXI_rready,
    M00_AXI_rresp,
    M00_AXI_rvalid,
    M00_AXI_wdata,
    M00_AXI_wlast,
    M00_AXI_wready,
    M00_AXI_wstrb,
    M00_AXI_wvalid,
    S00_ACLK,
    S00_ARESETN,
    S00_AXI_araddr,
    S00_AXI_arburst,
    S00_AXI_arcache,
    S00_AXI_arlen,
    S00_AXI_arlock,
    S00_AXI_arprot,
    S00_AXI_arqos,
    S00_AXI_arready,
    S00_AXI_arsize,
    S00_AXI_arvalid,
    S00_AXI_awaddr,
    S00_AXI_awburst,
    S00_AXI_awcache,
    S00_AXI_awlen,
    S00_AXI_awlock,
    S00_AXI_awprot,
    S00_AXI_awqos,
    S00_AXI_awready,
    S00_AXI_awsize,
    S00_AXI_awvalid,
    S00_AXI_bready,
    S00_AXI_bresp,
    S00_AXI_bvalid,
    S00_AXI_rdata,
    S00_AXI_rlast,
    S00_AXI_rready,
    S00_AXI_rresp,
    S00_AXI_rvalid,
    S00_AXI_wdata,
    S00_AXI_wlast,
    S00_AXI_wready,
    S00_AXI_wstrb,
    S00_AXI_wvalid,
    S01_ACLK,
    S01_ARESETN,
    S01_AXI_araddr,
    S01_AXI_arburst,
    S01_AXI_arcache,
    S01_AXI_arlen,
    S01_AXI_arlock,
    S01_AXI_arprot,
    S01_AXI_arqos,
    S01_AXI_arready,
    S01_AXI_arsize,
    S01_AXI_arvalid,
    S01_AXI_rdata,
    S01_AXI_rlast,
    S01_AXI_rready,
    S01_AXI_rresp,
    S01_AXI_rvalid,
    S02_ACLK,
    S02_ARESETN,
    S02_AXI_araddr,
    S02_AXI_arburst,
    S02_AXI_arcache,
    S02_AXI_arlen,
    S02_AXI_arprot,
    S02_AXI_arready,
    S02_AXI_arsize,
    S02_AXI_arvalid,
    S02_AXI_rdata,
    S02_AXI_rlast,
    S02_AXI_rready,
    S02_AXI_rresp,
    S02_AXI_rvalid,
    S03_ACLK,
    S03_ARESETN,
    S03_AXI_araddr,
    S03_AXI_arburst,
    S03_AXI_arcache,
    S03_AXI_arlen,
    S03_AXI_arlock,
    S03_AXI_arprot,
    S03_AXI_arqos,
    S03_AXI_arready,
    S03_AXI_arregion,
    S03_AXI_arsize,
    S03_AXI_arvalid,
    S03_AXI_awaddr,
    S03_AXI_awburst,
    S03_AXI_awcache,
    S03_AXI_awlen,
    S03_AXI_awlock,
    S03_AXI_awprot,
    S03_AXI_awqos,
    S03_AXI_awready,
    S03_AXI_awregion,
    S03_AXI_awsize,
    S03_AXI_awvalid,
    S03_AXI_bready,
    S03_AXI_bresp,
    S03_AXI_bvalid,
    S03_AXI_rdata,
    S03_AXI_rlast,
    S03_AXI_rready,
    S03_AXI_rresp,
    S03_AXI_rvalid,
    S03_AXI_wdata,
    S03_AXI_wlast,
    S03_AXI_wready,
    S03_AXI_wstrb,
    S03_AXI_wvalid);
  input ACLK;
  input [0:0]ARESETN;
  input M00_ACLK;
  input [0:0]M00_ARESETN;
  output [30:0]M00_AXI_araddr;
  output [1:0]M00_AXI_arburst;
  output [3:0]M00_AXI_arcache;
  output [1:0]M00_AXI_arid;
  output [7:0]M00_AXI_arlen;
  output [0:0]M00_AXI_arlock;
  output [2:0]M00_AXI_arprot;
  output [3:0]M00_AXI_arqos;
  input M00_AXI_arready;
  output [2:0]M00_AXI_arsize;
  output M00_AXI_arvalid;
  output [30:0]M00_AXI_awaddr;
  output [1:0]M00_AXI_awburst;
  output [3:0]M00_AXI_awcache;
  output [1:0]M00_AXI_awid;
  output [7:0]M00_AXI_awlen;
  output [0:0]M00_AXI_awlock;
  output [2:0]M00_AXI_awprot;
  output [3:0]M00_AXI_awqos;
  input M00_AXI_awready;
  output [2:0]M00_AXI_awsize;
  output M00_AXI_awvalid;
  input [1:0]M00_AXI_bid;
  output M00_AXI_bready;
  input [1:0]M00_AXI_bresp;
  input M00_AXI_bvalid;
  input [511:0]M00_AXI_rdata;
  input [1:0]M00_AXI_rid;
  input M00_AXI_rlast;
  output M00_AXI_rready;
  input [1:0]M00_AXI_rresp;
  input M00_AXI_rvalid;
  output [511:0]M00_AXI_wdata;
  output M00_AXI_wlast;
  input M00_AXI_wready;
  output [63:0]M00_AXI_wstrb;
  output M00_AXI_wvalid;
  input S00_ACLK;
  input [0:0]S00_ARESETN;
  input [31:0]S00_AXI_araddr;
  input [1:0]S00_AXI_arburst;
  input [3:0]S00_AXI_arcache;
  input [7:0]S00_AXI_arlen;
  input [0:0]S00_AXI_arlock;
  input [2:0]S00_AXI_arprot;
  input [3:0]S00_AXI_arqos;
  output S00_AXI_arready;
  input [2:0]S00_AXI_arsize;
  input S00_AXI_arvalid;
  input [31:0]S00_AXI_awaddr;
  input [1:0]S00_AXI_awburst;
  input [3:0]S00_AXI_awcache;
  input [7:0]S00_AXI_awlen;
  input [0:0]S00_AXI_awlock;
  input [2:0]S00_AXI_awprot;
  input [3:0]S00_AXI_awqos;
  output S00_AXI_awready;
  input [2:0]S00_AXI_awsize;
  input S00_AXI_awvalid;
  input S00_AXI_bready;
  output [1:0]S00_AXI_bresp;
  output S00_AXI_bvalid;
  output [31:0]S00_AXI_rdata;
  output S00_AXI_rlast;
  input S00_AXI_rready;
  output [1:0]S00_AXI_rresp;
  output S00_AXI_rvalid;
  input [31:0]S00_AXI_wdata;
  input S00_AXI_wlast;
  output S00_AXI_wready;
  input [3:0]S00_AXI_wstrb;
  input S00_AXI_wvalid;
  input S01_ACLK;
  input [0:0]S01_ARESETN;
  input [31:0]S01_AXI_araddr;
  input [1:0]S01_AXI_arburst;
  input [3:0]S01_AXI_arcache;
  input [7:0]S01_AXI_arlen;
  input [0:0]S01_AXI_arlock;
  input [2:0]S01_AXI_arprot;
  input [3:0]S01_AXI_arqos;
  output S01_AXI_arready;
  input [2:0]S01_AXI_arsize;
  input S01_AXI_arvalid;
  output [31:0]S01_AXI_rdata;
  output S01_AXI_rlast;
  input S01_AXI_rready;
  output [1:0]S01_AXI_rresp;
  output S01_AXI_rvalid;
  input S02_ACLK;
  input [0:0]S02_ARESETN;
  input [31:0]S02_AXI_araddr;
  input [1:0]S02_AXI_arburst;
  input [3:0]S02_AXI_arcache;
  input [7:0]S02_AXI_arlen;
  input [2:0]S02_AXI_arprot;
  output S02_AXI_arready;
  input [2:0]S02_AXI_arsize;
  input S02_AXI_arvalid;
  output [63:0]S02_AXI_rdata;
  output S02_AXI_rlast;
  input S02_AXI_rready;
  output [1:0]S02_AXI_rresp;
  output S02_AXI_rvalid;
  input S03_ACLK;
  input [0:0]S03_ARESETN;
  input [31:0]S03_AXI_araddr;
  input [1:0]S03_AXI_arburst;
  input [3:0]S03_AXI_arcache;
  input [7:0]S03_AXI_arlen;
  input [0:0]S03_AXI_arlock;
  input [2:0]S03_AXI_arprot;
  input [3:0]S03_AXI_arqos;
  output S03_AXI_arready;
  input [3:0]S03_AXI_arregion;
  input [2:0]S03_AXI_arsize;
  input S03_AXI_arvalid;
  input [31:0]S03_AXI_awaddr;
  input [1:0]S03_AXI_awburst;
  input [3:0]S03_AXI_awcache;
  input [7:0]S03_AXI_awlen;
  input [0:0]S03_AXI_awlock;
  input [2:0]S03_AXI_awprot;
  input [3:0]S03_AXI_awqos;
  output S03_AXI_awready;
  input [3:0]S03_AXI_awregion;
  input [2:0]S03_AXI_awsize;
  input S03_AXI_awvalid;
  input S03_AXI_bready;
  output [1:0]S03_AXI_bresp;
  output S03_AXI_bvalid;
  output [511:0]S03_AXI_rdata;
  output S03_AXI_rlast;
  input S03_AXI_rready;
  output [1:0]S03_AXI_rresp;
  output S03_AXI_rvalid;
  input [511:0]S03_AXI_wdata;
  input S03_AXI_wlast;
  output S03_AXI_wready;
  input [63:0]S03_AXI_wstrb;
  input S03_AXI_wvalid;

  wire M00_ACLK_1;
  wire [0:0]M00_ARESETN_1;
  wire S00_ACLK_1;
  wire [0:0]S00_ARESETN_1;
  wire S01_ACLK_1;
  wire [0:0]S01_ARESETN_1;
  wire S02_ACLK_1;
  wire [0:0]S02_ARESETN_1;
  wire S03_ACLK_1;
  wire [0:0]S03_ARESETN_1;
  wire axi_interconnect_0_ACLK_net;
  wire [0:0]axi_interconnect_0_ARESETN_net;
  wire [31:0]axi_interconnect_0_to_s00_couplers_ARADDR;
  wire [1:0]axi_interconnect_0_to_s00_couplers_ARBURST;
  wire [3:0]axi_interconnect_0_to_s00_couplers_ARCACHE;
  wire [7:0]axi_interconnect_0_to_s00_couplers_ARLEN;
  wire [0:0]axi_interconnect_0_to_s00_couplers_ARLOCK;
  wire [2:0]axi_interconnect_0_to_s00_couplers_ARPROT;
  wire [3:0]axi_interconnect_0_to_s00_couplers_ARQOS;
  wire axi_interconnect_0_to_s00_couplers_ARREADY;
  wire [2:0]axi_interconnect_0_to_s00_couplers_ARSIZE;
  wire axi_interconnect_0_to_s00_couplers_ARVALID;
  wire [31:0]axi_interconnect_0_to_s00_couplers_AWADDR;
  wire [1:0]axi_interconnect_0_to_s00_couplers_AWBURST;
  wire [3:0]axi_interconnect_0_to_s00_couplers_AWCACHE;
  wire [7:0]axi_interconnect_0_to_s00_couplers_AWLEN;
  wire [0:0]axi_interconnect_0_to_s00_couplers_AWLOCK;
  wire [2:0]axi_interconnect_0_to_s00_couplers_AWPROT;
  wire [3:0]axi_interconnect_0_to_s00_couplers_AWQOS;
  wire axi_interconnect_0_to_s00_couplers_AWREADY;
  wire [2:0]axi_interconnect_0_to_s00_couplers_AWSIZE;
  wire axi_interconnect_0_to_s00_couplers_AWVALID;
  wire axi_interconnect_0_to_s00_couplers_BREADY;
  wire [1:0]axi_interconnect_0_to_s00_couplers_BRESP;
  wire axi_interconnect_0_to_s00_couplers_BVALID;
  wire [31:0]axi_interconnect_0_to_s00_couplers_RDATA;
  wire axi_interconnect_0_to_s00_couplers_RLAST;
  wire axi_interconnect_0_to_s00_couplers_RREADY;
  wire [1:0]axi_interconnect_0_to_s00_couplers_RRESP;
  wire axi_interconnect_0_to_s00_couplers_RVALID;
  wire [31:0]axi_interconnect_0_to_s00_couplers_WDATA;
  wire axi_interconnect_0_to_s00_couplers_WLAST;
  wire axi_interconnect_0_to_s00_couplers_WREADY;
  wire [3:0]axi_interconnect_0_to_s00_couplers_WSTRB;
  wire axi_interconnect_0_to_s00_couplers_WVALID;
  wire [31:0]axi_interconnect_0_to_s01_couplers_ARADDR;
  wire [1:0]axi_interconnect_0_to_s01_couplers_ARBURST;
  wire [3:0]axi_interconnect_0_to_s01_couplers_ARCACHE;
  wire [7:0]axi_interconnect_0_to_s01_couplers_ARLEN;
  wire [0:0]axi_interconnect_0_to_s01_couplers_ARLOCK;
  wire [2:0]axi_interconnect_0_to_s01_couplers_ARPROT;
  wire [3:0]axi_interconnect_0_to_s01_couplers_ARQOS;
  wire axi_interconnect_0_to_s01_couplers_ARREADY;
  wire [2:0]axi_interconnect_0_to_s01_couplers_ARSIZE;
  wire axi_interconnect_0_to_s01_couplers_ARVALID;
  wire [31:0]axi_interconnect_0_to_s01_couplers_RDATA;
  wire axi_interconnect_0_to_s01_couplers_RLAST;
  wire axi_interconnect_0_to_s01_couplers_RREADY;
  wire [1:0]axi_interconnect_0_to_s01_couplers_RRESP;
  wire axi_interconnect_0_to_s01_couplers_RVALID;
  wire [31:0]axi_interconnect_0_to_s02_couplers_ARADDR;
  wire [1:0]axi_interconnect_0_to_s02_couplers_ARBURST;
  wire [3:0]axi_interconnect_0_to_s02_couplers_ARCACHE;
  wire [7:0]axi_interconnect_0_to_s02_couplers_ARLEN;
  wire [2:0]axi_interconnect_0_to_s02_couplers_ARPROT;
  wire axi_interconnect_0_to_s02_couplers_ARREADY;
  wire [2:0]axi_interconnect_0_to_s02_couplers_ARSIZE;
  wire axi_interconnect_0_to_s02_couplers_ARVALID;
  wire [63:0]axi_interconnect_0_to_s02_couplers_RDATA;
  wire axi_interconnect_0_to_s02_couplers_RLAST;
  wire axi_interconnect_0_to_s02_couplers_RREADY;
  wire [1:0]axi_interconnect_0_to_s02_couplers_RRESP;
  wire axi_interconnect_0_to_s02_couplers_RVALID;
  wire [31:0]axi_interconnect_0_to_s03_couplers_ARADDR;
  wire [1:0]axi_interconnect_0_to_s03_couplers_ARBURST;
  wire [3:0]axi_interconnect_0_to_s03_couplers_ARCACHE;
  wire [7:0]axi_interconnect_0_to_s03_couplers_ARLEN;
  wire [0:0]axi_interconnect_0_to_s03_couplers_ARLOCK;
  wire [2:0]axi_interconnect_0_to_s03_couplers_ARPROT;
  wire [3:0]axi_interconnect_0_to_s03_couplers_ARQOS;
  wire axi_interconnect_0_to_s03_couplers_ARREADY;
  wire [3:0]axi_interconnect_0_to_s03_couplers_ARREGION;
  wire [2:0]axi_interconnect_0_to_s03_couplers_ARSIZE;
  wire axi_interconnect_0_to_s03_couplers_ARVALID;
  wire [31:0]axi_interconnect_0_to_s03_couplers_AWADDR;
  wire [1:0]axi_interconnect_0_to_s03_couplers_AWBURST;
  wire [3:0]axi_interconnect_0_to_s03_couplers_AWCACHE;
  wire [7:0]axi_interconnect_0_to_s03_couplers_AWLEN;
  wire [0:0]axi_interconnect_0_to_s03_couplers_AWLOCK;
  wire [2:0]axi_interconnect_0_to_s03_couplers_AWPROT;
  wire [3:0]axi_interconnect_0_to_s03_couplers_AWQOS;
  wire axi_interconnect_0_to_s03_couplers_AWREADY;
  wire [3:0]axi_interconnect_0_to_s03_couplers_AWREGION;
  wire [2:0]axi_interconnect_0_to_s03_couplers_AWSIZE;
  wire axi_interconnect_0_to_s03_couplers_AWVALID;
  wire axi_interconnect_0_to_s03_couplers_BREADY;
  wire [1:0]axi_interconnect_0_to_s03_couplers_BRESP;
  wire axi_interconnect_0_to_s03_couplers_BVALID;
  wire [511:0]axi_interconnect_0_to_s03_couplers_RDATA;
  wire axi_interconnect_0_to_s03_couplers_RLAST;
  wire axi_interconnect_0_to_s03_couplers_RREADY;
  wire [1:0]axi_interconnect_0_to_s03_couplers_RRESP;
  wire axi_interconnect_0_to_s03_couplers_RVALID;
  wire [511:0]axi_interconnect_0_to_s03_couplers_WDATA;
  wire axi_interconnect_0_to_s03_couplers_WLAST;
  wire axi_interconnect_0_to_s03_couplers_WREADY;
  wire [63:0]axi_interconnect_0_to_s03_couplers_WSTRB;
  wire axi_interconnect_0_to_s03_couplers_WVALID;
  wire [30:0]m00_couplers_to_axi_interconnect_0_ARADDR;
  wire [1:0]m00_couplers_to_axi_interconnect_0_ARBURST;
  wire [3:0]m00_couplers_to_axi_interconnect_0_ARCACHE;
  wire [1:0]m00_couplers_to_axi_interconnect_0_ARID;
  wire [7:0]m00_couplers_to_axi_interconnect_0_ARLEN;
  wire [0:0]m00_couplers_to_axi_interconnect_0_ARLOCK;
  wire [2:0]m00_couplers_to_axi_interconnect_0_ARPROT;
  wire [3:0]m00_couplers_to_axi_interconnect_0_ARQOS;
  wire m00_couplers_to_axi_interconnect_0_ARREADY;
  wire [2:0]m00_couplers_to_axi_interconnect_0_ARSIZE;
  wire m00_couplers_to_axi_interconnect_0_ARVALID;
  wire [30:0]m00_couplers_to_axi_interconnect_0_AWADDR;
  wire [1:0]m00_couplers_to_axi_interconnect_0_AWBURST;
  wire [3:0]m00_couplers_to_axi_interconnect_0_AWCACHE;
  wire [1:0]m00_couplers_to_axi_interconnect_0_AWID;
  wire [7:0]m00_couplers_to_axi_interconnect_0_AWLEN;
  wire [0:0]m00_couplers_to_axi_interconnect_0_AWLOCK;
  wire [2:0]m00_couplers_to_axi_interconnect_0_AWPROT;
  wire [3:0]m00_couplers_to_axi_interconnect_0_AWQOS;
  wire m00_couplers_to_axi_interconnect_0_AWREADY;
  wire [2:0]m00_couplers_to_axi_interconnect_0_AWSIZE;
  wire m00_couplers_to_axi_interconnect_0_AWVALID;
  wire [1:0]m00_couplers_to_axi_interconnect_0_BID;
  wire m00_couplers_to_axi_interconnect_0_BREADY;
  wire [1:0]m00_couplers_to_axi_interconnect_0_BRESP;
  wire m00_couplers_to_axi_interconnect_0_BVALID;
  wire [511:0]m00_couplers_to_axi_interconnect_0_RDATA;
  wire [1:0]m00_couplers_to_axi_interconnect_0_RID;
  wire m00_couplers_to_axi_interconnect_0_RLAST;
  wire m00_couplers_to_axi_interconnect_0_RREADY;
  wire [1:0]m00_couplers_to_axi_interconnect_0_RRESP;
  wire m00_couplers_to_axi_interconnect_0_RVALID;
  wire [511:0]m00_couplers_to_axi_interconnect_0_WDATA;
  wire m00_couplers_to_axi_interconnect_0_WLAST;
  wire m00_couplers_to_axi_interconnect_0_WREADY;
  wire [63:0]m00_couplers_to_axi_interconnect_0_WSTRB;
  wire m00_couplers_to_axi_interconnect_0_WVALID;
  wire [31:0]s00_couplers_to_xbar_ARADDR;
  wire [1:0]s00_couplers_to_xbar_ARBURST;
  wire [3:0]s00_couplers_to_xbar_ARCACHE;
  wire [7:0]s00_couplers_to_xbar_ARLEN;
  wire [0:0]s00_couplers_to_xbar_ARLOCK;
  wire [2:0]s00_couplers_to_xbar_ARPROT;
  wire [3:0]s00_couplers_to_xbar_ARQOS;
  wire [0:0]s00_couplers_to_xbar_ARREADY;
  wire [2:0]s00_couplers_to_xbar_ARSIZE;
  wire s00_couplers_to_xbar_ARVALID;
  wire [31:0]s00_couplers_to_xbar_AWADDR;
  wire [1:0]s00_couplers_to_xbar_AWBURST;
  wire [3:0]s00_couplers_to_xbar_AWCACHE;
  wire [7:0]s00_couplers_to_xbar_AWLEN;
  wire [0:0]s00_couplers_to_xbar_AWLOCK;
  wire [2:0]s00_couplers_to_xbar_AWPROT;
  wire [3:0]s00_couplers_to_xbar_AWQOS;
  wire [0:0]s00_couplers_to_xbar_AWREADY;
  wire [2:0]s00_couplers_to_xbar_AWSIZE;
  wire s00_couplers_to_xbar_AWVALID;
  wire s00_couplers_to_xbar_BREADY;
  wire [1:0]s00_couplers_to_xbar_BRESP;
  wire [0:0]s00_couplers_to_xbar_BVALID;
  wire [511:0]s00_couplers_to_xbar_RDATA;
  wire [0:0]s00_couplers_to_xbar_RLAST;
  wire s00_couplers_to_xbar_RREADY;
  wire [1:0]s00_couplers_to_xbar_RRESP;
  wire [0:0]s00_couplers_to_xbar_RVALID;
  wire [511:0]s00_couplers_to_xbar_WDATA;
  wire s00_couplers_to_xbar_WLAST;
  wire [0:0]s00_couplers_to_xbar_WREADY;
  wire [63:0]s00_couplers_to_xbar_WSTRB;
  wire s00_couplers_to_xbar_WVALID;
  wire [31:0]s01_couplers_to_xbar_ARADDR;
  wire [1:0]s01_couplers_to_xbar_ARBURST;
  wire [3:0]s01_couplers_to_xbar_ARCACHE;
  wire [7:0]s01_couplers_to_xbar_ARLEN;
  wire [0:0]s01_couplers_to_xbar_ARLOCK;
  wire [2:0]s01_couplers_to_xbar_ARPROT;
  wire [3:0]s01_couplers_to_xbar_ARQOS;
  wire [1:1]s01_couplers_to_xbar_ARREADY;
  wire [2:0]s01_couplers_to_xbar_ARSIZE;
  wire s01_couplers_to_xbar_ARVALID;
  wire [1023:512]s01_couplers_to_xbar_RDATA;
  wire [1:1]s01_couplers_to_xbar_RLAST;
  wire s01_couplers_to_xbar_RREADY;
  wire [3:2]s01_couplers_to_xbar_RRESP;
  wire [1:1]s01_couplers_to_xbar_RVALID;
  wire [31:0]s02_couplers_to_xbar_ARADDR;
  wire [1:0]s02_couplers_to_xbar_ARBURST;
  wire [3:0]s02_couplers_to_xbar_ARCACHE;
  wire [7:0]s02_couplers_to_xbar_ARLEN;
  wire [0:0]s02_couplers_to_xbar_ARLOCK;
  wire [2:0]s02_couplers_to_xbar_ARPROT;
  wire [3:0]s02_couplers_to_xbar_ARQOS;
  wire [2:2]s02_couplers_to_xbar_ARREADY;
  wire [2:0]s02_couplers_to_xbar_ARSIZE;
  wire s02_couplers_to_xbar_ARVALID;
  wire [1535:1024]s02_couplers_to_xbar_RDATA;
  wire [2:2]s02_couplers_to_xbar_RLAST;
  wire s02_couplers_to_xbar_RREADY;
  wire [5:4]s02_couplers_to_xbar_RRESP;
  wire [2:2]s02_couplers_to_xbar_RVALID;
  wire [31:0]s03_couplers_to_xbar_ARADDR;
  wire [1:0]s03_couplers_to_xbar_ARBURST;
  wire [3:0]s03_couplers_to_xbar_ARCACHE;
  wire [7:0]s03_couplers_to_xbar_ARLEN;
  wire [0:0]s03_couplers_to_xbar_ARLOCK;
  wire [2:0]s03_couplers_to_xbar_ARPROT;
  wire [3:0]s03_couplers_to_xbar_ARQOS;
  wire [3:3]s03_couplers_to_xbar_ARREADY;
  wire [2:0]s03_couplers_to_xbar_ARSIZE;
  wire s03_couplers_to_xbar_ARVALID;
  wire [31:0]s03_couplers_to_xbar_AWADDR;
  wire [1:0]s03_couplers_to_xbar_AWBURST;
  wire [3:0]s03_couplers_to_xbar_AWCACHE;
  wire [7:0]s03_couplers_to_xbar_AWLEN;
  wire [0:0]s03_couplers_to_xbar_AWLOCK;
  wire [2:0]s03_couplers_to_xbar_AWPROT;
  wire [3:0]s03_couplers_to_xbar_AWQOS;
  wire [3:3]s03_couplers_to_xbar_AWREADY;
  wire [2:0]s03_couplers_to_xbar_AWSIZE;
  wire s03_couplers_to_xbar_AWVALID;
  wire s03_couplers_to_xbar_BREADY;
  wire [7:6]s03_couplers_to_xbar_BRESP;
  wire [3:3]s03_couplers_to_xbar_BVALID;
  wire [2047:1536]s03_couplers_to_xbar_RDATA;
  wire [3:3]s03_couplers_to_xbar_RLAST;
  wire s03_couplers_to_xbar_RREADY;
  wire [7:6]s03_couplers_to_xbar_RRESP;
  wire [3:3]s03_couplers_to_xbar_RVALID;
  wire [511:0]s03_couplers_to_xbar_WDATA;
  wire s03_couplers_to_xbar_WLAST;
  wire [3:3]s03_couplers_to_xbar_WREADY;
  wire [63:0]s03_couplers_to_xbar_WSTRB;
  wire s03_couplers_to_xbar_WVALID;
  wire [31:0]xbar_to_m00_couplers_ARADDR;
  wire [1:0]xbar_to_m00_couplers_ARBURST;
  wire [3:0]xbar_to_m00_couplers_ARCACHE;
  wire [1:0]xbar_to_m00_couplers_ARID;
  wire [7:0]xbar_to_m00_couplers_ARLEN;
  wire [0:0]xbar_to_m00_couplers_ARLOCK;
  wire [2:0]xbar_to_m00_couplers_ARPROT;
  wire [3:0]xbar_to_m00_couplers_ARQOS;
  wire xbar_to_m00_couplers_ARREADY;
  wire [3:0]xbar_to_m00_couplers_ARREGION;
  wire [2:0]xbar_to_m00_couplers_ARSIZE;
  wire [0:0]xbar_to_m00_couplers_ARVALID;
  wire [31:0]xbar_to_m00_couplers_AWADDR;
  wire [1:0]xbar_to_m00_couplers_AWBURST;
  wire [3:0]xbar_to_m00_couplers_AWCACHE;
  wire [1:0]xbar_to_m00_couplers_AWID;
  wire [7:0]xbar_to_m00_couplers_AWLEN;
  wire [0:0]xbar_to_m00_couplers_AWLOCK;
  wire [2:0]xbar_to_m00_couplers_AWPROT;
  wire [3:0]xbar_to_m00_couplers_AWQOS;
  wire xbar_to_m00_couplers_AWREADY;
  wire [3:0]xbar_to_m00_couplers_AWREGION;
  wire [2:0]xbar_to_m00_couplers_AWSIZE;
  wire [0:0]xbar_to_m00_couplers_AWVALID;
  wire [1:0]xbar_to_m00_couplers_BID;
  wire [0:0]xbar_to_m00_couplers_BREADY;
  wire [1:0]xbar_to_m00_couplers_BRESP;
  wire xbar_to_m00_couplers_BVALID;
  wire [511:0]xbar_to_m00_couplers_RDATA;
  wire [1:0]xbar_to_m00_couplers_RID;
  wire xbar_to_m00_couplers_RLAST;
  wire [0:0]xbar_to_m00_couplers_RREADY;
  wire [1:0]xbar_to_m00_couplers_RRESP;
  wire xbar_to_m00_couplers_RVALID;
  wire [511:0]xbar_to_m00_couplers_WDATA;
  wire [0:0]xbar_to_m00_couplers_WLAST;
  wire xbar_to_m00_couplers_WREADY;
  wire [63:0]xbar_to_m00_couplers_WSTRB;
  wire [0:0]xbar_to_m00_couplers_WVALID;
  wire [3:0]NLW_xbar_s_axi_awready_UNCONNECTED;
  wire [7:0]NLW_xbar_s_axi_bresp_UNCONNECTED;
  wire [3:0]NLW_xbar_s_axi_bvalid_UNCONNECTED;
  wire [3:0]NLW_xbar_s_axi_wready_UNCONNECTED;

  assign M00_ACLK_1 = M00_ACLK;
  assign M00_ARESETN_1 = M00_ARESETN[0];
  assign M00_AXI_araddr[30:0] = m00_couplers_to_axi_interconnect_0_ARADDR;
  assign M00_AXI_arburst[1:0] = m00_couplers_to_axi_interconnect_0_ARBURST;
  assign M00_AXI_arcache[3:0] = m00_couplers_to_axi_interconnect_0_ARCACHE;
  assign M00_AXI_arid[1:0] = m00_couplers_to_axi_interconnect_0_ARID;
  assign M00_AXI_arlen[7:0] = m00_couplers_to_axi_interconnect_0_ARLEN;
  assign M00_AXI_arlock[0] = m00_couplers_to_axi_interconnect_0_ARLOCK;
  assign M00_AXI_arprot[2:0] = m00_couplers_to_axi_interconnect_0_ARPROT;
  assign M00_AXI_arqos[3:0] = m00_couplers_to_axi_interconnect_0_ARQOS;
  assign M00_AXI_arsize[2:0] = m00_couplers_to_axi_interconnect_0_ARSIZE;
  assign M00_AXI_arvalid = m00_couplers_to_axi_interconnect_0_ARVALID;
  assign M00_AXI_awaddr[30:0] = m00_couplers_to_axi_interconnect_0_AWADDR;
  assign M00_AXI_awburst[1:0] = m00_couplers_to_axi_interconnect_0_AWBURST;
  assign M00_AXI_awcache[3:0] = m00_couplers_to_axi_interconnect_0_AWCACHE;
  assign M00_AXI_awid[1:0] = m00_couplers_to_axi_interconnect_0_AWID;
  assign M00_AXI_awlen[7:0] = m00_couplers_to_axi_interconnect_0_AWLEN;
  assign M00_AXI_awlock[0] = m00_couplers_to_axi_interconnect_0_AWLOCK;
  assign M00_AXI_awprot[2:0] = m00_couplers_to_axi_interconnect_0_AWPROT;
  assign M00_AXI_awqos[3:0] = m00_couplers_to_axi_interconnect_0_AWQOS;
  assign M00_AXI_awsize[2:0] = m00_couplers_to_axi_interconnect_0_AWSIZE;
  assign M00_AXI_awvalid = m00_couplers_to_axi_interconnect_0_AWVALID;
  assign M00_AXI_bready = m00_couplers_to_axi_interconnect_0_BREADY;
  assign M00_AXI_rready = m00_couplers_to_axi_interconnect_0_RREADY;
  assign M00_AXI_wdata[511:0] = m00_couplers_to_axi_interconnect_0_WDATA;
  assign M00_AXI_wlast = m00_couplers_to_axi_interconnect_0_WLAST;
  assign M00_AXI_wstrb[63:0] = m00_couplers_to_axi_interconnect_0_WSTRB;
  assign M00_AXI_wvalid = m00_couplers_to_axi_interconnect_0_WVALID;
  assign S00_ACLK_1 = S00_ACLK;
  assign S00_ARESETN_1 = S00_ARESETN[0];
  assign S00_AXI_arready = axi_interconnect_0_to_s00_couplers_ARREADY;
  assign S00_AXI_awready = axi_interconnect_0_to_s00_couplers_AWREADY;
  assign S00_AXI_bresp[1:0] = axi_interconnect_0_to_s00_couplers_BRESP;
  assign S00_AXI_bvalid = axi_interconnect_0_to_s00_couplers_BVALID;
  assign S00_AXI_rdata[31:0] = axi_interconnect_0_to_s00_couplers_RDATA;
  assign S00_AXI_rlast = axi_interconnect_0_to_s00_couplers_RLAST;
  assign S00_AXI_rresp[1:0] = axi_interconnect_0_to_s00_couplers_RRESP;
  assign S00_AXI_rvalid = axi_interconnect_0_to_s00_couplers_RVALID;
  assign S00_AXI_wready = axi_interconnect_0_to_s00_couplers_WREADY;
  assign S01_ACLK_1 = S01_ACLK;
  assign S01_ARESETN_1 = S01_ARESETN[0];
  assign S01_AXI_arready = axi_interconnect_0_to_s01_couplers_ARREADY;
  assign S01_AXI_rdata[31:0] = axi_interconnect_0_to_s01_couplers_RDATA;
  assign S01_AXI_rlast = axi_interconnect_0_to_s01_couplers_RLAST;
  assign S01_AXI_rresp[1:0] = axi_interconnect_0_to_s01_couplers_RRESP;
  assign S01_AXI_rvalid = axi_interconnect_0_to_s01_couplers_RVALID;
  assign S02_ACLK_1 = S02_ACLK;
  assign S02_ARESETN_1 = S02_ARESETN[0];
  assign S02_AXI_arready = axi_interconnect_0_to_s02_couplers_ARREADY;
  assign S02_AXI_rdata[63:0] = axi_interconnect_0_to_s02_couplers_RDATA;
  assign S02_AXI_rlast = axi_interconnect_0_to_s02_couplers_RLAST;
  assign S02_AXI_rresp[1:0] = axi_interconnect_0_to_s02_couplers_RRESP;
  assign S02_AXI_rvalid = axi_interconnect_0_to_s02_couplers_RVALID;
  assign S03_ACLK_1 = S03_ACLK;
  assign S03_ARESETN_1 = S03_ARESETN[0];
  assign S03_AXI_arready = axi_interconnect_0_to_s03_couplers_ARREADY;
  assign S03_AXI_awready = axi_interconnect_0_to_s03_couplers_AWREADY;
  assign S03_AXI_bresp[1:0] = axi_interconnect_0_to_s03_couplers_BRESP;
  assign S03_AXI_bvalid = axi_interconnect_0_to_s03_couplers_BVALID;
  assign S03_AXI_rdata[511:0] = axi_interconnect_0_to_s03_couplers_RDATA;
  assign S03_AXI_rlast = axi_interconnect_0_to_s03_couplers_RLAST;
  assign S03_AXI_rresp[1:0] = axi_interconnect_0_to_s03_couplers_RRESP;
  assign S03_AXI_rvalid = axi_interconnect_0_to_s03_couplers_RVALID;
  assign S03_AXI_wready = axi_interconnect_0_to_s03_couplers_WREADY;
  assign axi_interconnect_0_ACLK_net = ACLK;
  assign axi_interconnect_0_ARESETN_net = ARESETN[0];
  assign axi_interconnect_0_to_s00_couplers_ARADDR = S00_AXI_araddr[31:0];
  assign axi_interconnect_0_to_s00_couplers_ARBURST = S00_AXI_arburst[1:0];
  assign axi_interconnect_0_to_s00_couplers_ARCACHE = S00_AXI_arcache[3:0];
  assign axi_interconnect_0_to_s00_couplers_ARLEN = S00_AXI_arlen[7:0];
  assign axi_interconnect_0_to_s00_couplers_ARLOCK = S00_AXI_arlock[0];
  assign axi_interconnect_0_to_s00_couplers_ARPROT = S00_AXI_arprot[2:0];
  assign axi_interconnect_0_to_s00_couplers_ARQOS = S00_AXI_arqos[3:0];
  assign axi_interconnect_0_to_s00_couplers_ARSIZE = S00_AXI_arsize[2:0];
  assign axi_interconnect_0_to_s00_couplers_ARVALID = S00_AXI_arvalid;
  assign axi_interconnect_0_to_s00_couplers_AWADDR = S00_AXI_awaddr[31:0];
  assign axi_interconnect_0_to_s00_couplers_AWBURST = S00_AXI_awburst[1:0];
  assign axi_interconnect_0_to_s00_couplers_AWCACHE = S00_AXI_awcache[3:0];
  assign axi_interconnect_0_to_s00_couplers_AWLEN = S00_AXI_awlen[7:0];
  assign axi_interconnect_0_to_s00_couplers_AWLOCK = S00_AXI_awlock[0];
  assign axi_interconnect_0_to_s00_couplers_AWPROT = S00_AXI_awprot[2:0];
  assign axi_interconnect_0_to_s00_couplers_AWQOS = S00_AXI_awqos[3:0];
  assign axi_interconnect_0_to_s00_couplers_AWSIZE = S00_AXI_awsize[2:0];
  assign axi_interconnect_0_to_s00_couplers_AWVALID = S00_AXI_awvalid;
  assign axi_interconnect_0_to_s00_couplers_BREADY = S00_AXI_bready;
  assign axi_interconnect_0_to_s00_couplers_RREADY = S00_AXI_rready;
  assign axi_interconnect_0_to_s00_couplers_WDATA = S00_AXI_wdata[31:0];
  assign axi_interconnect_0_to_s00_couplers_WLAST = S00_AXI_wlast;
  assign axi_interconnect_0_to_s00_couplers_WSTRB = S00_AXI_wstrb[3:0];
  assign axi_interconnect_0_to_s00_couplers_WVALID = S00_AXI_wvalid;
  assign axi_interconnect_0_to_s01_couplers_ARADDR = S01_AXI_araddr[31:0];
  assign axi_interconnect_0_to_s01_couplers_ARBURST = S01_AXI_arburst[1:0];
  assign axi_interconnect_0_to_s01_couplers_ARCACHE = S01_AXI_arcache[3:0];
  assign axi_interconnect_0_to_s01_couplers_ARLEN = S01_AXI_arlen[7:0];
  assign axi_interconnect_0_to_s01_couplers_ARLOCK = S01_AXI_arlock[0];
  assign axi_interconnect_0_to_s01_couplers_ARPROT = S01_AXI_arprot[2:0];
  assign axi_interconnect_0_to_s01_couplers_ARQOS = S01_AXI_arqos[3:0];
  assign axi_interconnect_0_to_s01_couplers_ARSIZE = S01_AXI_arsize[2:0];
  assign axi_interconnect_0_to_s01_couplers_ARVALID = S01_AXI_arvalid;
  assign axi_interconnect_0_to_s01_couplers_RREADY = S01_AXI_rready;
  assign axi_interconnect_0_to_s02_couplers_ARADDR = S02_AXI_araddr[31:0];
  assign axi_interconnect_0_to_s02_couplers_ARBURST = S02_AXI_arburst[1:0];
  assign axi_interconnect_0_to_s02_couplers_ARCACHE = S02_AXI_arcache[3:0];
  assign axi_interconnect_0_to_s02_couplers_ARLEN = S02_AXI_arlen[7:0];
  assign axi_interconnect_0_to_s02_couplers_ARPROT = S02_AXI_arprot[2:0];
  assign axi_interconnect_0_to_s02_couplers_ARSIZE = S02_AXI_arsize[2:0];
  assign axi_interconnect_0_to_s02_couplers_ARVALID = S02_AXI_arvalid;
  assign axi_interconnect_0_to_s02_couplers_RREADY = S02_AXI_rready;
  assign axi_interconnect_0_to_s03_couplers_ARADDR = S03_AXI_araddr[31:0];
  assign axi_interconnect_0_to_s03_couplers_ARBURST = S03_AXI_arburst[1:0];
  assign axi_interconnect_0_to_s03_couplers_ARCACHE = S03_AXI_arcache[3:0];
  assign axi_interconnect_0_to_s03_couplers_ARLEN = S03_AXI_arlen[7:0];
  assign axi_interconnect_0_to_s03_couplers_ARLOCK = S03_AXI_arlock[0];
  assign axi_interconnect_0_to_s03_couplers_ARPROT = S03_AXI_arprot[2:0];
  assign axi_interconnect_0_to_s03_couplers_ARQOS = S03_AXI_arqos[3:0];
  assign axi_interconnect_0_to_s03_couplers_ARREGION = S03_AXI_arregion[3:0];
  assign axi_interconnect_0_to_s03_couplers_ARSIZE = S03_AXI_arsize[2:0];
  assign axi_interconnect_0_to_s03_couplers_ARVALID = S03_AXI_arvalid;
  assign axi_interconnect_0_to_s03_couplers_AWADDR = S03_AXI_awaddr[31:0];
  assign axi_interconnect_0_to_s03_couplers_AWBURST = S03_AXI_awburst[1:0];
  assign axi_interconnect_0_to_s03_couplers_AWCACHE = S03_AXI_awcache[3:0];
  assign axi_interconnect_0_to_s03_couplers_AWLEN = S03_AXI_awlen[7:0];
  assign axi_interconnect_0_to_s03_couplers_AWLOCK = S03_AXI_awlock[0];
  assign axi_interconnect_0_to_s03_couplers_AWPROT = S03_AXI_awprot[2:0];
  assign axi_interconnect_0_to_s03_couplers_AWQOS = S03_AXI_awqos[3:0];
  assign axi_interconnect_0_to_s03_couplers_AWREGION = S03_AXI_awregion[3:0];
  assign axi_interconnect_0_to_s03_couplers_AWSIZE = S03_AXI_awsize[2:0];
  assign axi_interconnect_0_to_s03_couplers_AWVALID = S03_AXI_awvalid;
  assign axi_interconnect_0_to_s03_couplers_BREADY = S03_AXI_bready;
  assign axi_interconnect_0_to_s03_couplers_RREADY = S03_AXI_rready;
  assign axi_interconnect_0_to_s03_couplers_WDATA = S03_AXI_wdata[511:0];
  assign axi_interconnect_0_to_s03_couplers_WLAST = S03_AXI_wlast;
  assign axi_interconnect_0_to_s03_couplers_WSTRB = S03_AXI_wstrb[63:0];
  assign axi_interconnect_0_to_s03_couplers_WVALID = S03_AXI_wvalid;
  assign m00_couplers_to_axi_interconnect_0_ARREADY = M00_AXI_arready;
  assign m00_couplers_to_axi_interconnect_0_AWREADY = M00_AXI_awready;
  assign m00_couplers_to_axi_interconnect_0_BID = M00_AXI_bid[1:0];
  assign m00_couplers_to_axi_interconnect_0_BRESP = M00_AXI_bresp[1:0];
  assign m00_couplers_to_axi_interconnect_0_BVALID = M00_AXI_bvalid;
  assign m00_couplers_to_axi_interconnect_0_RDATA = M00_AXI_rdata[511:0];
  assign m00_couplers_to_axi_interconnect_0_RID = M00_AXI_rid[1:0];
  assign m00_couplers_to_axi_interconnect_0_RLAST = M00_AXI_rlast;
  assign m00_couplers_to_axi_interconnect_0_RRESP = M00_AXI_rresp[1:0];
  assign m00_couplers_to_axi_interconnect_0_RVALID = M00_AXI_rvalid;
  assign m00_couplers_to_axi_interconnect_0_WREADY = M00_AXI_wready;
  m00_couplers_imp_18LXGZ m00_couplers
       (.M_ACLK(M00_ACLK_1),
        .M_ARESETN(M00_ARESETN_1),
        .M_AXI_araddr(m00_couplers_to_axi_interconnect_0_ARADDR),
        .M_AXI_arburst(m00_couplers_to_axi_interconnect_0_ARBURST),
        .M_AXI_arcache(m00_couplers_to_axi_interconnect_0_ARCACHE),
        .M_AXI_arid(m00_couplers_to_axi_interconnect_0_ARID),
        .M_AXI_arlen(m00_couplers_to_axi_interconnect_0_ARLEN),
        .M_AXI_arlock(m00_couplers_to_axi_interconnect_0_ARLOCK),
        .M_AXI_arprot(m00_couplers_to_axi_interconnect_0_ARPROT),
        .M_AXI_arqos(m00_couplers_to_axi_interconnect_0_ARQOS),
        .M_AXI_arready(m00_couplers_to_axi_interconnect_0_ARREADY),
        .M_AXI_arsize(m00_couplers_to_axi_interconnect_0_ARSIZE),
        .M_AXI_arvalid(m00_couplers_to_axi_interconnect_0_ARVALID),
        .M_AXI_awaddr(m00_couplers_to_axi_interconnect_0_AWADDR),
        .M_AXI_awburst(m00_couplers_to_axi_interconnect_0_AWBURST),
        .M_AXI_awcache(m00_couplers_to_axi_interconnect_0_AWCACHE),
        .M_AXI_awid(m00_couplers_to_axi_interconnect_0_AWID),
        .M_AXI_awlen(m00_couplers_to_axi_interconnect_0_AWLEN),
        .M_AXI_awlock(m00_couplers_to_axi_interconnect_0_AWLOCK),
        .M_AXI_awprot(m00_couplers_to_axi_interconnect_0_AWPROT),
        .M_AXI_awqos(m00_couplers_to_axi_interconnect_0_AWQOS),
        .M_AXI_awready(m00_couplers_to_axi_interconnect_0_AWREADY),
        .M_AXI_awsize(m00_couplers_to_axi_interconnect_0_AWSIZE),
        .M_AXI_awvalid(m00_couplers_to_axi_interconnect_0_AWVALID),
        .M_AXI_bid(m00_couplers_to_axi_interconnect_0_BID),
        .M_AXI_bready(m00_couplers_to_axi_interconnect_0_BREADY),
        .M_AXI_bresp(m00_couplers_to_axi_interconnect_0_BRESP),
        .M_AXI_bvalid(m00_couplers_to_axi_interconnect_0_BVALID),
        .M_AXI_rdata(m00_couplers_to_axi_interconnect_0_RDATA),
        .M_AXI_rid(m00_couplers_to_axi_interconnect_0_RID),
        .M_AXI_rlast(m00_couplers_to_axi_interconnect_0_RLAST),
        .M_AXI_rready(m00_couplers_to_axi_interconnect_0_RREADY),
        .M_AXI_rresp(m00_couplers_to_axi_interconnect_0_RRESP),
        .M_AXI_rvalid(m00_couplers_to_axi_interconnect_0_RVALID),
        .M_AXI_wdata(m00_couplers_to_axi_interconnect_0_WDATA),
        .M_AXI_wlast(m00_couplers_to_axi_interconnect_0_WLAST),
        .M_AXI_wready(m00_couplers_to_axi_interconnect_0_WREADY),
        .M_AXI_wstrb(m00_couplers_to_axi_interconnect_0_WSTRB),
        .M_AXI_wvalid(m00_couplers_to_axi_interconnect_0_WVALID),
        .S_ACLK(axi_interconnect_0_ACLK_net),
        .S_ARESETN(axi_interconnect_0_ARESETN_net),
        .S_AXI_araddr(xbar_to_m00_couplers_ARADDR),
        .S_AXI_arburst(xbar_to_m00_couplers_ARBURST),
        .S_AXI_arcache(xbar_to_m00_couplers_ARCACHE),
        .S_AXI_arid(xbar_to_m00_couplers_ARID),
        .S_AXI_arlen(xbar_to_m00_couplers_ARLEN),
        .S_AXI_arlock(xbar_to_m00_couplers_ARLOCK),
        .S_AXI_arprot(xbar_to_m00_couplers_ARPROT),
        .S_AXI_arqos(xbar_to_m00_couplers_ARQOS),
        .S_AXI_arready(xbar_to_m00_couplers_ARREADY),
        .S_AXI_arregion(xbar_to_m00_couplers_ARREGION),
        .S_AXI_arsize(xbar_to_m00_couplers_ARSIZE),
        .S_AXI_arvalid(xbar_to_m00_couplers_ARVALID),
        .S_AXI_awaddr(xbar_to_m00_couplers_AWADDR),
        .S_AXI_awburst(xbar_to_m00_couplers_AWBURST),
        .S_AXI_awcache(xbar_to_m00_couplers_AWCACHE),
        .S_AXI_awid(xbar_to_m00_couplers_AWID),
        .S_AXI_awlen(xbar_to_m00_couplers_AWLEN),
        .S_AXI_awlock(xbar_to_m00_couplers_AWLOCK),
        .S_AXI_awprot(xbar_to_m00_couplers_AWPROT),
        .S_AXI_awqos(xbar_to_m00_couplers_AWQOS),
        .S_AXI_awready(xbar_to_m00_couplers_AWREADY),
        .S_AXI_awregion(xbar_to_m00_couplers_AWREGION),
        .S_AXI_awsize(xbar_to_m00_couplers_AWSIZE),
        .S_AXI_awvalid(xbar_to_m00_couplers_AWVALID),
        .S_AXI_bid(xbar_to_m00_couplers_BID),
        .S_AXI_bready(xbar_to_m00_couplers_BREADY),
        .S_AXI_bresp(xbar_to_m00_couplers_BRESP),
        .S_AXI_bvalid(xbar_to_m00_couplers_BVALID),
        .S_AXI_rdata(xbar_to_m00_couplers_RDATA),
        .S_AXI_rid(xbar_to_m00_couplers_RID),
        .S_AXI_rlast(xbar_to_m00_couplers_RLAST),
        .S_AXI_rready(xbar_to_m00_couplers_RREADY),
        .S_AXI_rresp(xbar_to_m00_couplers_RRESP),
        .S_AXI_rvalid(xbar_to_m00_couplers_RVALID),
        .S_AXI_wdata(xbar_to_m00_couplers_WDATA),
        .S_AXI_wlast(xbar_to_m00_couplers_WLAST),
        .S_AXI_wready(xbar_to_m00_couplers_WREADY),
        .S_AXI_wstrb(xbar_to_m00_couplers_WSTRB),
        .S_AXI_wvalid(xbar_to_m00_couplers_WVALID));
  s00_couplers_imp_6ZG57K s00_couplers
       (.M_ACLK(axi_interconnect_0_ACLK_net),
        .M_ARESETN(axi_interconnect_0_ARESETN_net),
        .M_AXI_araddr(s00_couplers_to_xbar_ARADDR),
        .M_AXI_arburst(s00_couplers_to_xbar_ARBURST),
        .M_AXI_arcache(s00_couplers_to_xbar_ARCACHE),
        .M_AXI_arlen(s00_couplers_to_xbar_ARLEN),
        .M_AXI_arlock(s00_couplers_to_xbar_ARLOCK),
        .M_AXI_arprot(s00_couplers_to_xbar_ARPROT),
        .M_AXI_arqos(s00_couplers_to_xbar_ARQOS),
        .M_AXI_arready(s00_couplers_to_xbar_ARREADY),
        .M_AXI_arsize(s00_couplers_to_xbar_ARSIZE),
        .M_AXI_arvalid(s00_couplers_to_xbar_ARVALID),
        .M_AXI_awaddr(s00_couplers_to_xbar_AWADDR),
        .M_AXI_awburst(s00_couplers_to_xbar_AWBURST),
        .M_AXI_awcache(s00_couplers_to_xbar_AWCACHE),
        .M_AXI_awlen(s00_couplers_to_xbar_AWLEN),
        .M_AXI_awlock(s00_couplers_to_xbar_AWLOCK),
        .M_AXI_awprot(s00_couplers_to_xbar_AWPROT),
        .M_AXI_awqos(s00_couplers_to_xbar_AWQOS),
        .M_AXI_awready(s00_couplers_to_xbar_AWREADY),
        .M_AXI_awsize(s00_couplers_to_xbar_AWSIZE),
        .M_AXI_awvalid(s00_couplers_to_xbar_AWVALID),
        .M_AXI_bready(s00_couplers_to_xbar_BREADY),
        .M_AXI_bresp(s00_couplers_to_xbar_BRESP),
        .M_AXI_bvalid(s00_couplers_to_xbar_BVALID),
        .M_AXI_rdata(s00_couplers_to_xbar_RDATA),
        .M_AXI_rlast(s00_couplers_to_xbar_RLAST),
        .M_AXI_rready(s00_couplers_to_xbar_RREADY),
        .M_AXI_rresp(s00_couplers_to_xbar_RRESP),
        .M_AXI_rvalid(s00_couplers_to_xbar_RVALID),
        .M_AXI_wdata(s00_couplers_to_xbar_WDATA),
        .M_AXI_wlast(s00_couplers_to_xbar_WLAST),
        .M_AXI_wready(s00_couplers_to_xbar_WREADY),
        .M_AXI_wstrb(s00_couplers_to_xbar_WSTRB),
        .M_AXI_wvalid(s00_couplers_to_xbar_WVALID),
        .S_ACLK(S00_ACLK_1),
        .S_ARESETN(S00_ARESETN_1),
        .S_AXI_araddr(axi_interconnect_0_to_s00_couplers_ARADDR),
        .S_AXI_arburst(axi_interconnect_0_to_s00_couplers_ARBURST),
        .S_AXI_arcache(axi_interconnect_0_to_s00_couplers_ARCACHE),
        .S_AXI_arlen(axi_interconnect_0_to_s00_couplers_ARLEN),
        .S_AXI_arlock(axi_interconnect_0_to_s00_couplers_ARLOCK),
        .S_AXI_arprot(axi_interconnect_0_to_s00_couplers_ARPROT),
        .S_AXI_arqos(axi_interconnect_0_to_s00_couplers_ARQOS),
        .S_AXI_arready(axi_interconnect_0_to_s00_couplers_ARREADY),
        .S_AXI_arsize(axi_interconnect_0_to_s00_couplers_ARSIZE),
        .S_AXI_arvalid(axi_interconnect_0_to_s00_couplers_ARVALID),
        .S_AXI_awaddr(axi_interconnect_0_to_s00_couplers_AWADDR),
        .S_AXI_awburst(axi_interconnect_0_to_s00_couplers_AWBURST),
        .S_AXI_awcache(axi_interconnect_0_to_s00_couplers_AWCACHE),
        .S_AXI_awlen(axi_interconnect_0_to_s00_couplers_AWLEN),
        .S_AXI_awlock(axi_interconnect_0_to_s00_couplers_AWLOCK),
        .S_AXI_awprot(axi_interconnect_0_to_s00_couplers_AWPROT),
        .S_AXI_awqos(axi_interconnect_0_to_s00_couplers_AWQOS),
        .S_AXI_awready(axi_interconnect_0_to_s00_couplers_AWREADY),
        .S_AXI_awsize(axi_interconnect_0_to_s00_couplers_AWSIZE),
        .S_AXI_awvalid(axi_interconnect_0_to_s00_couplers_AWVALID),
        .S_AXI_bready(axi_interconnect_0_to_s00_couplers_BREADY),
        .S_AXI_bresp(axi_interconnect_0_to_s00_couplers_BRESP),
        .S_AXI_bvalid(axi_interconnect_0_to_s00_couplers_BVALID),
        .S_AXI_rdata(axi_interconnect_0_to_s00_couplers_RDATA),
        .S_AXI_rlast(axi_interconnect_0_to_s00_couplers_RLAST),
        .S_AXI_rready(axi_interconnect_0_to_s00_couplers_RREADY),
        .S_AXI_rresp(axi_interconnect_0_to_s00_couplers_RRESP),
        .S_AXI_rvalid(axi_interconnect_0_to_s00_couplers_RVALID),
        .S_AXI_wdata(axi_interconnect_0_to_s00_couplers_WDATA),
        .S_AXI_wlast(axi_interconnect_0_to_s00_couplers_WLAST),
        .S_AXI_wready(axi_interconnect_0_to_s00_couplers_WREADY),
        .S_AXI_wstrb(axi_interconnect_0_to_s00_couplers_WSTRB),
        .S_AXI_wvalid(axi_interconnect_0_to_s00_couplers_WVALID));
  s01_couplers_imp_3W09SW s01_couplers
       (.M_ACLK(axi_interconnect_0_ACLK_net),
        .M_ARESETN(axi_interconnect_0_ARESETN_net),
        .M_AXI_araddr(s01_couplers_to_xbar_ARADDR),
        .M_AXI_arburst(s01_couplers_to_xbar_ARBURST),
        .M_AXI_arcache(s01_couplers_to_xbar_ARCACHE),
        .M_AXI_arlen(s01_couplers_to_xbar_ARLEN),
        .M_AXI_arlock(s01_couplers_to_xbar_ARLOCK),
        .M_AXI_arprot(s01_couplers_to_xbar_ARPROT),
        .M_AXI_arqos(s01_couplers_to_xbar_ARQOS),
        .M_AXI_arready(s01_couplers_to_xbar_ARREADY),
        .M_AXI_arsize(s01_couplers_to_xbar_ARSIZE),
        .M_AXI_arvalid(s01_couplers_to_xbar_ARVALID),
        .M_AXI_rdata(s01_couplers_to_xbar_RDATA),
        .M_AXI_rlast(s01_couplers_to_xbar_RLAST),
        .M_AXI_rready(s01_couplers_to_xbar_RREADY),
        .M_AXI_rresp(s01_couplers_to_xbar_RRESP),
        .M_AXI_rvalid(s01_couplers_to_xbar_RVALID),
        .S_ACLK(S01_ACLK_1),
        .S_ARESETN(S01_ARESETN_1),
        .S_AXI_araddr(axi_interconnect_0_to_s01_couplers_ARADDR),
        .S_AXI_arburst(axi_interconnect_0_to_s01_couplers_ARBURST),
        .S_AXI_arcache(axi_interconnect_0_to_s01_couplers_ARCACHE),
        .S_AXI_arlen(axi_interconnect_0_to_s01_couplers_ARLEN),
        .S_AXI_arlock(axi_interconnect_0_to_s01_couplers_ARLOCK),
        .S_AXI_arprot(axi_interconnect_0_to_s01_couplers_ARPROT),
        .S_AXI_arqos(axi_interconnect_0_to_s01_couplers_ARQOS),
        .S_AXI_arready(axi_interconnect_0_to_s01_couplers_ARREADY),
        .S_AXI_arsize(axi_interconnect_0_to_s01_couplers_ARSIZE),
        .S_AXI_arvalid(axi_interconnect_0_to_s01_couplers_ARVALID),
        .S_AXI_rdata(axi_interconnect_0_to_s01_couplers_RDATA),
        .S_AXI_rlast(axi_interconnect_0_to_s01_couplers_RLAST),
        .S_AXI_rready(axi_interconnect_0_to_s01_couplers_RREADY),
        .S_AXI_rresp(axi_interconnect_0_to_s01_couplers_RRESP),
        .S_AXI_rvalid(axi_interconnect_0_to_s01_couplers_RVALID));
  s02_couplers_imp_FE8N34 s02_couplers
       (.M_ACLK(axi_interconnect_0_ACLK_net),
        .M_ARESETN(axi_interconnect_0_ARESETN_net),
        .M_AXI_araddr(s02_couplers_to_xbar_ARADDR),
        .M_AXI_arburst(s02_couplers_to_xbar_ARBURST),
        .M_AXI_arcache(s02_couplers_to_xbar_ARCACHE),
        .M_AXI_arlen(s02_couplers_to_xbar_ARLEN),
        .M_AXI_arlock(s02_couplers_to_xbar_ARLOCK),
        .M_AXI_arprot(s02_couplers_to_xbar_ARPROT),
        .M_AXI_arqos(s02_couplers_to_xbar_ARQOS),
        .M_AXI_arready(s02_couplers_to_xbar_ARREADY),
        .M_AXI_arsize(s02_couplers_to_xbar_ARSIZE),
        .M_AXI_arvalid(s02_couplers_to_xbar_ARVALID),
        .M_AXI_rdata(s02_couplers_to_xbar_RDATA),
        .M_AXI_rlast(s02_couplers_to_xbar_RLAST),
        .M_AXI_rready(s02_couplers_to_xbar_RREADY),
        .M_AXI_rresp(s02_couplers_to_xbar_RRESP),
        .M_AXI_rvalid(s02_couplers_to_xbar_RVALID),
        .S_ACLK(S02_ACLK_1),
        .S_ARESETN(S02_ARESETN_1),
        .S_AXI_araddr(axi_interconnect_0_to_s02_couplers_ARADDR),
        .S_AXI_arburst(axi_interconnect_0_to_s02_couplers_ARBURST),
        .S_AXI_arcache(axi_interconnect_0_to_s02_couplers_ARCACHE),
        .S_AXI_arlen(axi_interconnect_0_to_s02_couplers_ARLEN),
        .S_AXI_arprot(axi_interconnect_0_to_s02_couplers_ARPROT),
        .S_AXI_arready(axi_interconnect_0_to_s02_couplers_ARREADY),
        .S_AXI_arsize(axi_interconnect_0_to_s02_couplers_ARSIZE),
        .S_AXI_arvalid(axi_interconnect_0_to_s02_couplers_ARVALID),
        .S_AXI_rdata(axi_interconnect_0_to_s02_couplers_RDATA),
        .S_AXI_rlast(axi_interconnect_0_to_s02_couplers_RLAST),
        .S_AXI_rready(axi_interconnect_0_to_s02_couplers_RREADY),
        .S_AXI_rresp(axi_interconnect_0_to_s02_couplers_RRESP),
        .S_AXI_rvalid(axi_interconnect_0_to_s02_couplers_RVALID));
  s03_couplers_imp_8YYC68 s03_couplers
       (.M_ACLK(axi_interconnect_0_ACLK_net),
        .M_ARESETN(axi_interconnect_0_ARESETN_net),
        .M_AXI_araddr(s03_couplers_to_xbar_ARADDR),
        .M_AXI_arburst(s03_couplers_to_xbar_ARBURST),
        .M_AXI_arcache(s03_couplers_to_xbar_ARCACHE),
        .M_AXI_arlen(s03_couplers_to_xbar_ARLEN),
        .M_AXI_arlock(s03_couplers_to_xbar_ARLOCK),
        .M_AXI_arprot(s03_couplers_to_xbar_ARPROT),
        .M_AXI_arqos(s03_couplers_to_xbar_ARQOS),
        .M_AXI_arready(s03_couplers_to_xbar_ARREADY),
        .M_AXI_arsize(s03_couplers_to_xbar_ARSIZE),
        .M_AXI_arvalid(s03_couplers_to_xbar_ARVALID),
        .M_AXI_awaddr(s03_couplers_to_xbar_AWADDR),
        .M_AXI_awburst(s03_couplers_to_xbar_AWBURST),
        .M_AXI_awcache(s03_couplers_to_xbar_AWCACHE),
        .M_AXI_awlen(s03_couplers_to_xbar_AWLEN),
        .M_AXI_awlock(s03_couplers_to_xbar_AWLOCK),
        .M_AXI_awprot(s03_couplers_to_xbar_AWPROT),
        .M_AXI_awqos(s03_couplers_to_xbar_AWQOS),
        .M_AXI_awready(s03_couplers_to_xbar_AWREADY),
        .M_AXI_awsize(s03_couplers_to_xbar_AWSIZE),
        .M_AXI_awvalid(s03_couplers_to_xbar_AWVALID),
        .M_AXI_bready(s03_couplers_to_xbar_BREADY),
        .M_AXI_bresp(s03_couplers_to_xbar_BRESP),
        .M_AXI_bvalid(s03_couplers_to_xbar_BVALID),
        .M_AXI_rdata(s03_couplers_to_xbar_RDATA),
        .M_AXI_rlast(s03_couplers_to_xbar_RLAST),
        .M_AXI_rready(s03_couplers_to_xbar_RREADY),
        .M_AXI_rresp(s03_couplers_to_xbar_RRESP),
        .M_AXI_rvalid(s03_couplers_to_xbar_RVALID),
        .M_AXI_wdata(s03_couplers_to_xbar_WDATA),
        .M_AXI_wlast(s03_couplers_to_xbar_WLAST),
        .M_AXI_wready(s03_couplers_to_xbar_WREADY),
        .M_AXI_wstrb(s03_couplers_to_xbar_WSTRB),
        .M_AXI_wvalid(s03_couplers_to_xbar_WVALID),
        .S_ACLK(S03_ACLK_1),
        .S_ARESETN(S03_ARESETN_1),
        .S_AXI_araddr(axi_interconnect_0_to_s03_couplers_ARADDR),
        .S_AXI_arburst(axi_interconnect_0_to_s03_couplers_ARBURST),
        .S_AXI_arcache(axi_interconnect_0_to_s03_couplers_ARCACHE),
        .S_AXI_arlen(axi_interconnect_0_to_s03_couplers_ARLEN),
        .S_AXI_arlock(axi_interconnect_0_to_s03_couplers_ARLOCK),
        .S_AXI_arprot(axi_interconnect_0_to_s03_couplers_ARPROT),
        .S_AXI_arqos(axi_interconnect_0_to_s03_couplers_ARQOS),
        .S_AXI_arready(axi_interconnect_0_to_s03_couplers_ARREADY),
        .S_AXI_arregion(axi_interconnect_0_to_s03_couplers_ARREGION),
        .S_AXI_arsize(axi_interconnect_0_to_s03_couplers_ARSIZE),
        .S_AXI_arvalid(axi_interconnect_0_to_s03_couplers_ARVALID),
        .S_AXI_awaddr(axi_interconnect_0_to_s03_couplers_AWADDR),
        .S_AXI_awburst(axi_interconnect_0_to_s03_couplers_AWBURST),
        .S_AXI_awcache(axi_interconnect_0_to_s03_couplers_AWCACHE),
        .S_AXI_awlen(axi_interconnect_0_to_s03_couplers_AWLEN),
        .S_AXI_awlock(axi_interconnect_0_to_s03_couplers_AWLOCK),
        .S_AXI_awprot(axi_interconnect_0_to_s03_couplers_AWPROT),
        .S_AXI_awqos(axi_interconnect_0_to_s03_couplers_AWQOS),
        .S_AXI_awready(axi_interconnect_0_to_s03_couplers_AWREADY),
        .S_AXI_awregion(axi_interconnect_0_to_s03_couplers_AWREGION),
        .S_AXI_awsize(axi_interconnect_0_to_s03_couplers_AWSIZE),
        .S_AXI_awvalid(axi_interconnect_0_to_s03_couplers_AWVALID),
        .S_AXI_bready(axi_interconnect_0_to_s03_couplers_BREADY),
        .S_AXI_bresp(axi_interconnect_0_to_s03_couplers_BRESP),
        .S_AXI_bvalid(axi_interconnect_0_to_s03_couplers_BVALID),
        .S_AXI_rdata(axi_interconnect_0_to_s03_couplers_RDATA),
        .S_AXI_rlast(axi_interconnect_0_to_s03_couplers_RLAST),
        .S_AXI_rready(axi_interconnect_0_to_s03_couplers_RREADY),
        .S_AXI_rresp(axi_interconnect_0_to_s03_couplers_RRESP),
        .S_AXI_rvalid(axi_interconnect_0_to_s03_couplers_RVALID),
        .S_AXI_wdata(axi_interconnect_0_to_s03_couplers_WDATA),
        .S_AXI_wlast(axi_interconnect_0_to_s03_couplers_WLAST),
        .S_AXI_wready(axi_interconnect_0_to_s03_couplers_WREADY),
        .S_AXI_wstrb(axi_interconnect_0_to_s03_couplers_WSTRB),
        .S_AXI_wvalid(axi_interconnect_0_to_s03_couplers_WVALID));
  system_i_bak_xbar_1 xbar
       (.aclk(axi_interconnect_0_ACLK_net),
        .aresetn(axi_interconnect_0_ARESETN_net),
        .m_axi_araddr(xbar_to_m00_couplers_ARADDR),
        .m_axi_arburst(xbar_to_m00_couplers_ARBURST),
        .m_axi_arcache(xbar_to_m00_couplers_ARCACHE),
        .m_axi_arid(xbar_to_m00_couplers_ARID),
        .m_axi_arlen(xbar_to_m00_couplers_ARLEN),
        .m_axi_arlock(xbar_to_m00_couplers_ARLOCK),
        .m_axi_arprot(xbar_to_m00_couplers_ARPROT),
        .m_axi_arqos(xbar_to_m00_couplers_ARQOS),
        .m_axi_arready(xbar_to_m00_couplers_ARREADY),
        .m_axi_arregion(xbar_to_m00_couplers_ARREGION),
        .m_axi_arsize(xbar_to_m00_couplers_ARSIZE),
        .m_axi_arvalid(xbar_to_m00_couplers_ARVALID),
        .m_axi_awaddr(xbar_to_m00_couplers_AWADDR),
        .m_axi_awburst(xbar_to_m00_couplers_AWBURST),
        .m_axi_awcache(xbar_to_m00_couplers_AWCACHE),
        .m_axi_awid(xbar_to_m00_couplers_AWID),
        .m_axi_awlen(xbar_to_m00_couplers_AWLEN),
        .m_axi_awlock(xbar_to_m00_couplers_AWLOCK),
        .m_axi_awprot(xbar_to_m00_couplers_AWPROT),
        .m_axi_awqos(xbar_to_m00_couplers_AWQOS),
        .m_axi_awready(xbar_to_m00_couplers_AWREADY),
        .m_axi_awregion(xbar_to_m00_couplers_AWREGION),
        .m_axi_awsize(xbar_to_m00_couplers_AWSIZE),
        .m_axi_awvalid(xbar_to_m00_couplers_AWVALID),
        .m_axi_bid(xbar_to_m00_couplers_BID),
        .m_axi_bready(xbar_to_m00_couplers_BREADY),
        .m_axi_bresp(xbar_to_m00_couplers_BRESP),
        .m_axi_bvalid(xbar_to_m00_couplers_BVALID),
        .m_axi_rdata(xbar_to_m00_couplers_RDATA),
        .m_axi_rid(xbar_to_m00_couplers_RID),
        .m_axi_rlast(xbar_to_m00_couplers_RLAST),
        .m_axi_rready(xbar_to_m00_couplers_RREADY),
        .m_axi_rresp(xbar_to_m00_couplers_RRESP),
        .m_axi_rvalid(xbar_to_m00_couplers_RVALID),
        .m_axi_wdata(xbar_to_m00_couplers_WDATA),
        .m_axi_wlast(xbar_to_m00_couplers_WLAST),
        .m_axi_wready(xbar_to_m00_couplers_WREADY),
        .m_axi_wstrb(xbar_to_m00_couplers_WSTRB),
        .m_axi_wvalid(xbar_to_m00_couplers_WVALID),
        .s_axi_araddr({s03_couplers_to_xbar_ARADDR,s02_couplers_to_xbar_ARADDR,s01_couplers_to_xbar_ARADDR,s00_couplers_to_xbar_ARADDR}),
        .s_axi_arburst({s03_couplers_to_xbar_ARBURST,s02_couplers_to_xbar_ARBURST,s01_couplers_to_xbar_ARBURST,s00_couplers_to_xbar_ARBURST}),
        .s_axi_arcache({s03_couplers_to_xbar_ARCACHE,s02_couplers_to_xbar_ARCACHE,s01_couplers_to_xbar_ARCACHE,s00_couplers_to_xbar_ARCACHE}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({s03_couplers_to_xbar_ARLEN,s02_couplers_to_xbar_ARLEN,s01_couplers_to_xbar_ARLEN,s00_couplers_to_xbar_ARLEN}),
        .s_axi_arlock({s03_couplers_to_xbar_ARLOCK,s02_couplers_to_xbar_ARLOCK,s01_couplers_to_xbar_ARLOCK,s00_couplers_to_xbar_ARLOCK}),
        .s_axi_arprot({s03_couplers_to_xbar_ARPROT,s02_couplers_to_xbar_ARPROT,s01_couplers_to_xbar_ARPROT,s00_couplers_to_xbar_ARPROT}),
        .s_axi_arqos({s03_couplers_to_xbar_ARQOS,s02_couplers_to_xbar_ARQOS,s01_couplers_to_xbar_ARQOS,s00_couplers_to_xbar_ARQOS}),
        .s_axi_arready({s03_couplers_to_xbar_ARREADY,s02_couplers_to_xbar_ARREADY,s01_couplers_to_xbar_ARREADY,s00_couplers_to_xbar_ARREADY}),
        .s_axi_arsize({s03_couplers_to_xbar_ARSIZE,s02_couplers_to_xbar_ARSIZE,s01_couplers_to_xbar_ARSIZE,s00_couplers_to_xbar_ARSIZE}),
        .s_axi_arvalid({s03_couplers_to_xbar_ARVALID,s02_couplers_to_xbar_ARVALID,s01_couplers_to_xbar_ARVALID,s00_couplers_to_xbar_ARVALID}),
        .s_axi_awaddr({s03_couplers_to_xbar_AWADDR,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,s00_couplers_to_xbar_AWADDR}),
        .s_axi_awburst({s03_couplers_to_xbar_AWBURST,1'b0,1'b0,1'b0,1'b0,s00_couplers_to_xbar_AWBURST}),
        .s_axi_awcache({s03_couplers_to_xbar_AWCACHE,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,s00_couplers_to_xbar_AWCACHE}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({s03_couplers_to_xbar_AWLEN,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,s00_couplers_to_xbar_AWLEN}),
        .s_axi_awlock({s03_couplers_to_xbar_AWLOCK,1'b0,1'b0,s00_couplers_to_xbar_AWLOCK}),
        .s_axi_awprot({s03_couplers_to_xbar_AWPROT,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,s00_couplers_to_xbar_AWPROT}),
        .s_axi_awqos({s03_couplers_to_xbar_AWQOS,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,s00_couplers_to_xbar_AWQOS}),
        .s_axi_awready({s03_couplers_to_xbar_AWREADY,NLW_xbar_s_axi_awready_UNCONNECTED[2:1],s00_couplers_to_xbar_AWREADY}),
        .s_axi_awsize({s03_couplers_to_xbar_AWSIZE,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,s00_couplers_to_xbar_AWSIZE}),
        .s_axi_awvalid({s03_couplers_to_xbar_AWVALID,1'b0,1'b0,s00_couplers_to_xbar_AWVALID}),
        .s_axi_bready({s03_couplers_to_xbar_BREADY,1'b0,1'b0,s00_couplers_to_xbar_BREADY}),
        .s_axi_bresp({s03_couplers_to_xbar_BRESP,NLW_xbar_s_axi_bresp_UNCONNECTED[5:2],s00_couplers_to_xbar_BRESP}),
        .s_axi_bvalid({s03_couplers_to_xbar_BVALID,NLW_xbar_s_axi_bvalid_UNCONNECTED[2:1],s00_couplers_to_xbar_BVALID}),
        .s_axi_rdata({s03_couplers_to_xbar_RDATA,s02_couplers_to_xbar_RDATA,s01_couplers_to_xbar_RDATA,s00_couplers_to_xbar_RDATA}),
        .s_axi_rlast({s03_couplers_to_xbar_RLAST,s02_couplers_to_xbar_RLAST,s01_couplers_to_xbar_RLAST,s00_couplers_to_xbar_RLAST}),
        .s_axi_rready({s03_couplers_to_xbar_RREADY,s02_couplers_to_xbar_RREADY,s01_couplers_to_xbar_RREADY,s00_couplers_to_xbar_RREADY}),
        .s_axi_rresp({s03_couplers_to_xbar_RRESP,s02_couplers_to_xbar_RRESP,s01_couplers_to_xbar_RRESP,s00_couplers_to_xbar_RRESP}),
        .s_axi_rvalid({s03_couplers_to_xbar_RVALID,s02_couplers_to_xbar_RVALID,s01_couplers_to_xbar_RVALID,s00_couplers_to_xbar_RVALID}),
        .s_axi_wdata({s03_couplers_to_xbar_WDATA,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,s00_couplers_to_xbar_WDATA}),
        .s_axi_wlast({s03_couplers_to_xbar_WLAST,1'b1,1'b1,s00_couplers_to_xbar_WLAST}),
        .s_axi_wready({s03_couplers_to_xbar_WREADY,NLW_xbar_s_axi_wready_UNCONNECTED[2:1],s00_couplers_to_xbar_WREADY}),
        .s_axi_wstrb({s03_couplers_to_xbar_WSTRB,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,s00_couplers_to_xbar_WSTRB}),
        .s_axi_wvalid({s03_couplers_to_xbar_WVALID,1'b0,1'b0,s00_couplers_to_xbar_WVALID}));
endmodule
