create_clock -period 10 [get_ports s00_axi_aclk]

# Input delays: how late the inputs arrive, with respect to the clock edge
# Same constraint on -min and -max (for hold, setup analysis)
set_input_delay -clock s00_axi_aclk 0.5 [get_ports s00_axi_araddr]
set_input_delay -clock s00_axi_aclk 1.0 [get_ports s00_axi_arburst]
set_input_delay -clock s00_axi_aclk 2.0 [get_ports s00_axi_aresetn]
set_input_delay -clock s00_axi_aclk 1.0 [get_ports s00_axi_arlen]
set_input_delay -clock s00_axi_aclk 1.0 [get_ports s00_axi_arvalid]
set_input_delay -clock s00_axi_aclk 1.0 [get_ports s00_axi_awaddr]
set_input_delay -clock s00_axi_aclk 1.0 [get_ports s00_axi_awburst]
set_input_delay -clock s00_axi_aclk 1.0 [get_ports s00_axi_awlen]
set_input_delay -clock s00_axi_aclk 1.0 [get_ports s00_axi_awvalid]
set_input_delay -clock s00_axi_aclk 1.0 [get_ports s00_axi_bready]
set_input_delay -clock s00_axi_aclk 1.0 [get_ports s00_axi_rready]
set_input_delay -clock s00_axi_aclk 1.0 [get_ports s00_axi_wvalid]
set_input_delay -clock s00_axi_aclk 1.0 [get_ports s00_axi_wdata]
set_input_delay -clock s00_axi_aclk 1.0 [get_ports s00_axi_wlast]


# Output delays: how early the outputs must be generated, with respect to the clock edge
# Same constraint on -min and -max (for hold, setup analysis)
set_output_delay -clock s00_axi_aclk 2.0 [get_ports s00_axi_arready]
set_output_delay -clock s00_axi_aclk 2.0 [get_ports s00_axi_awready]
set_output_delay -clock s00_axi_aclk 2.0 [get_ports s00_axi_wready]
set_output_delay -clock s00_axi_aclk 2.0 [get_ports s00_axi_rdata]
set_output_delay -clock s00_axi_aclk 2.0 [get_ports s00_axi_rlast]
set_output_delay -clock s00_axi_aclk 2.0 [get_ports s00_axi_rvalid]
set_output_delay -clock s00_axi_aclk 2.0 [get_ports s00_axi_rresp]
set_output_delay -clock s00_axi_aclk 2.0 [get_ports s00_axi_bvalid]
set_output_delay -clock s00_axi_aclk 2.0 [get_ports s00_axi_bresp]
