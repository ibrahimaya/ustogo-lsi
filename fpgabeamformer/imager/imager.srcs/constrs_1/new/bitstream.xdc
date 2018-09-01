## ***************************************************************************
## ***************************************************************************
##  Copyright (C) 2014-2018  EPFL
##  "imager" toplevel block design.
##
##   Permission is hereby granted, free of charge, to any person
##   obtaining a copy of this software and associated documentation
##   files (the "Software"), to deal in the Software without
##   restriction, including without limitation the rights to use,
##   copy, modify, merge, publish, distribute, sublicense, and/or sell
##   copies of the Software, and to permit persons to whom the
##   Software is furnished to do so, subject to the following
##   conditions:
##
##   The above copyright notice and this permission notice shall be
##   included in all copies or substantial portions of the Software.
##
##   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
##   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
##   OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
##   NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
##   HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
##   WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
##   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
##   OTHER DEALINGS IN THE SOFTWARE.
## ***************************************************************************
## ***************************************************************************
## ***************************************************************************
## ***************************************************************************

# Clocks and reset
# This pin assignment is automatic.
#set_property -dict {PACKAGE_PIN AN8 IOSTANDARD LVCMOS18} [get_ports sys_rst]
set_property -dict {PACKAGE_PIN AK17} [get_ports sys_clk_p]
set_property -dict {PACKAGE_PIN AK16} [get_ports sys_clk_n]

# Ethernet
set_property -dict {PACKAGE_PIN J23 IOSTANDARD LVCMOS18} [get_ports phy_rst_n]
set_property -dict {PACKAGE_PIN P26 IOSTANDARD LVDS_25} [get_ports phy_clk_p]
set_property -dict {PACKAGE_PIN N26 IOSTANDARD LVDS_25} [get_ports phy_clk_n]
# The pin assignments below are done by selecting the board interfaces in the first tab of the IP properties in the block design.
#set_property -dict {PACKAGE_PIN L25 IOSTANDARD LVCMOS18} [get_ports mdio_mdc]
#set_property -dict {PACKAGE_PIN H26 IOSTANDARD LVCMOS18} [get_ports mdio_mdio]
#set_property -dict {PACKAGE_PIN N24 IOSTANDARD DIFF_HSTL_I_18} [get_ports phy_tx_p]
#set_property -dict {PACKAGE_PIN M24 IOSTANDARD DIFF_HSTL_I_18} [get_ports phy_tx_n]
#set_property -dict {PACKAGE_PIN P24 IOSTANDARD DIFF_HSTL_I_18} [get_ports phy_rx_p]
#set_property -dict {PACKAGE_PIN P25 IOSTANDARD DIFF_HSTL_I_18} [get_ports phy_rx_n]
# Constraints from file : 'system_i_bak_axi_ddr_cntrl_0.xdc'
set_property INTERNAL_VREF 0.84 [get_iobanks 44]
set_property INTERNAL_VREF 0.84 [get_iobanks 45]
set_property INTERNAL_VREF 0.84 [get_iobanks 46]
set_false_path -to [get_pins -hier -filter {name =~ *axi_ethernet_idelayctrl*/RST}]
current_instance i_system_wrapper/system_i_bak_i/axi_ddr_cntrl/inst
set_property LOC MMCME3_ADV_X0Y1 [get_cells -hier -filter {NAME =~ */u_ddr4_infrastructure/gen_mmcme*.u_mmcme_adv_inst}]
current_instance -quiet

# UART
# The pin assignments below are done by selecting the board interfaces in the first tab of the IP properties in the block design.
#set_property -dict {PACKAGE_PIN K26 IOSTANDARD LVCMOS18} [get_ports uart_sout]
#set_property -dict {PACKAGE_PIN G25 IOSTANDARD LVCMOS18} [get_ports uart_sin]

# Fan
set_property -dict {PACKAGE_PIN AJ9 IOSTANDARD LVCMOS18} [get_ports fan_pwm]

# I2C
set_property -dict  {PACKAGE_PIN  J24   IOSTANDARD  LVCMOS18} [get_ports iic_scl] 
set_property -dict  {PACKAGE_PIN  J25   IOSTANDARD  LVCMOS18} [get_ports iic_sda] 

# DDR Controller
# The pin assignments below are done by selecting the board interfaces in the first tab of the IP properties in the block design.
#set_property -dict {PACKAGE_PIN AH14} [get_ports ddr4_act_n]
#set_property -dict {PACKAGE_PIN AE17} [get_ports {ddr4_addr[0]}]
#set_property -dict {PACKAGE_PIN AH17} [get_ports {ddr4_addr[1]}]
#set_property -dict {PACKAGE_PIN AE18} [get_ports {ddr4_addr[2]}]
#set_property -dict {PACKAGE_PIN AJ15} [get_ports {ddr4_addr[3]}]
#set_property -dict {PACKAGE_PIN AG16} [get_ports {ddr4_addr[4]}]
#set_property -dict {PACKAGE_PIN AL17} [get_ports {ddr4_addr[5]}]
#set_property -dict {PACKAGE_PIN AK18} [get_ports {ddr4_addr[6]}]
#set_property -dict {PACKAGE_PIN AG17} [get_ports {ddr4_addr[7]}]
#set_property -dict {PACKAGE_PIN AF18} [get_ports {ddr4_addr[8]}]
#set_property -dict {PACKAGE_PIN AH19} [get_ports {ddr4_addr[9]}]
#set_property -dict {PACKAGE_PIN AF15} [get_ports {ddr4_addr[10]}]
#set_property -dict {PACKAGE_PIN AD19} [get_ports {ddr4_addr[11]}]
#set_property -dict {PACKAGE_PIN AJ14} [get_ports {ddr4_addr[12]}]
#set_property -dict {PACKAGE_PIN AG19} [get_ports {ddr4_addr[13]}]
#set_property -dict {PACKAGE_PIN AD16} [get_ports {ddr4_addr[14]}]
#set_property -dict {PACKAGE_PIN AG14} [get_ports {ddr4_addr[15]}]
#set_property -dict {PACKAGE_PIN AF14} [get_ports {ddr4_addr[16]}]
#set_property -dict {PACKAGE_PIN AF17} [get_ports {ddr4_ba[0]}]
#set_property -dict {PACKAGE_PIN AL15} [get_ports {ddr4_ba[1]}]
#set_property -dict {PACKAGE_PIN AG15} [get_ports {ddr4_bg[0]}]
#set_property -dict {PACKAGE_PIN AE16} [get_ports ddr4_ck_p]
#set_property -dict {PACKAGE_PIN AE15} [get_ports ddr4_ck_n]
#set_property -dict {PACKAGE_PIN AD15} [get_ports {ddr4_cke[0]}]
#set_property -dict {PACKAGE_PIN AL19} [get_ports {ddr4_cs_n[0]}]
#set_property -dict {PACKAGE_PIN AD21} [get_ports {ddr4_dm_n[0]}]
#set_property -dict {PACKAGE_PIN AE25} [get_ports {ddr4_dm_n[1]}]
#set_property -dict {PACKAGE_PIN AJ21} [get_ports {ddr4_dm_n[2]}]
#set_property -dict {PACKAGE_PIN AM21} [get_ports {ddr4_dm_n[3]}]
#set_property -dict {PACKAGE_PIN AH26} [get_ports {ddr4_dm_n[4]}]
#set_property -dict {PACKAGE_PIN AN26} [get_ports {ddr4_dm_n[5]}]
#set_property -dict {PACKAGE_PIN AJ29} [get_ports {ddr4_dm_n[6]}]
#set_property -dict {PACKAGE_PIN AL32} [get_ports {ddr4_dm_n[7]}]
#set_property -dict {PACKAGE_PIN AE23} [get_ports {ddr4_dq[0]}]
#set_property -dict {PACKAGE_PIN AG20} [get_ports {ddr4_dq[1]}]
#set_property -dict {PACKAGE_PIN AF22} [get_ports {ddr4_dq[2]}]
#set_property -dict {PACKAGE_PIN AF20} [get_ports {ddr4_dq[3]}]
#set_property -dict {PACKAGE_PIN AE22} [get_ports {ddr4_dq[4]}]
#set_property -dict {PACKAGE_PIN AD20} [get_ports {ddr4_dq[5]}]
#set_property -dict {PACKAGE_PIN AG22} [get_ports {ddr4_dq[6]}]
#set_property -dict {PACKAGE_PIN AE20} [get_ports {ddr4_dq[7]}]
#set_property -dict {PACKAGE_PIN AJ24} [get_ports {ddr4_dq[8]}]
#set_property -dict {PACKAGE_PIN AG24} [get_ports {ddr4_dq[9]}]
#set_property -dict {PACKAGE_PIN AJ23} [get_ports {ddr4_dq[10]}]
#set_property -dict {PACKAGE_PIN AF23} [get_ports {ddr4_dq[11]}]
#set_property -dict {PACKAGE_PIN AH23} [get_ports {ddr4_dq[12]}]
#set_property -dict {PACKAGE_PIN AF24} [get_ports {ddr4_dq[13]}]
#set_property -dict {PACKAGE_PIN AH22} [get_ports {ddr4_dq[14]}]
#set_property -dict {PACKAGE_PIN AG25} [get_ports {ddr4_dq[15]}]
#set_property -dict {PACKAGE_PIN AL22} [get_ports {ddr4_dq[16]}]
#set_property -dict {PACKAGE_PIN AL25} [get_ports {ddr4_dq[17]}]
#set_property -dict {PACKAGE_PIN AM20} [get_ports {ddr4_dq[18]}]
#set_property -dict {PACKAGE_PIN AK23} [get_ports {ddr4_dq[19]}]
#set_property -dict {PACKAGE_PIN AK22} [get_ports {ddr4_dq[20]}]
#set_property -dict {PACKAGE_PIN AL24} [get_ports {ddr4_dq[21]}]
#set_property -dict {PACKAGE_PIN AL20} [get_ports {ddr4_dq[22]}]
#set_property -dict {PACKAGE_PIN AL23} [get_ports {ddr4_dq[23]}]
#set_property -dict {PACKAGE_PIN AM24} [get_ports {ddr4_dq[24]}]
#set_property -dict {PACKAGE_PIN AN23} [get_ports {ddr4_dq[25]}]
#set_property -dict {PACKAGE_PIN AN24} [get_ports {ddr4_dq[26]}]
#set_property -dict {PACKAGE_PIN AP23} [get_ports {ddr4_dq[27]}]
#set_property -dict {PACKAGE_PIN AP25} [get_ports {ddr4_dq[28]}]
#set_property -dict {PACKAGE_PIN AN22} [get_ports {ddr4_dq[29]}]
#set_property -dict {PACKAGE_PIN AP24} [get_ports {ddr4_dq[30]}]
#set_property -dict {PACKAGE_PIN AM22} [get_ports {ddr4_dq[31]}]
#set_property -dict {PACKAGE_PIN AH28} [get_ports {ddr4_dq[32]}]
#set_property -dict {PACKAGE_PIN AK26} [get_ports {ddr4_dq[33]}]
#set_property -dict {PACKAGE_PIN AK28} [get_ports {ddr4_dq[34]}]
#set_property -dict {PACKAGE_PIN AM27} [get_ports {ddr4_dq[35]}]
#set_property -dict {PACKAGE_PIN AJ28} [get_ports {ddr4_dq[36]}]
#set_property -dict {PACKAGE_PIN AH27} [get_ports {ddr4_dq[37]}]
#set_property -dict {PACKAGE_PIN AK27} [get_ports {ddr4_dq[38]}]
#set_property -dict {PACKAGE_PIN AM26} [get_ports {ddr4_dq[39]}]
#set_property -dict {PACKAGE_PIN AL30} [get_ports {ddr4_dq[40]}]
#set_property -dict {PACKAGE_PIN AP29} [get_ports {ddr4_dq[41]}]
#set_property -dict {PACKAGE_PIN AM30} [get_ports {ddr4_dq[42]}]
#set_property -dict {PACKAGE_PIN AN28} [get_ports {ddr4_dq[43]}]
#set_property -dict {PACKAGE_PIN AL29} [get_ports {ddr4_dq[44]}]
#set_property -dict {PACKAGE_PIN AP28} [get_ports {ddr4_dq[45]}]
#set_property -dict {PACKAGE_PIN AM29} [get_ports {ddr4_dq[46]}]
#set_property -dict {PACKAGE_PIN AN27} [get_ports {ddr4_dq[47]}]
#set_property -dict {PACKAGE_PIN AH31} [get_ports {ddr4_dq[48]}]
#set_property -dict {PACKAGE_PIN AH32} [get_ports {ddr4_dq[49]}]
#set_property -dict {PACKAGE_PIN AJ34} [get_ports {ddr4_dq[50]}]
#set_property -dict {PACKAGE_PIN AK31} [get_ports {ddr4_dq[51]}]
#set_property -dict {PACKAGE_PIN AJ31} [get_ports {ddr4_dq[52]}]
#set_property -dict {PACKAGE_PIN AJ30} [get_ports {ddr4_dq[53]}]
#set_property -dict {PACKAGE_PIN AH34} [get_ports {ddr4_dq[54]}]
#set_property -dict {PACKAGE_PIN AK32} [get_ports {ddr4_dq[55]}]
#set_property -dict {PACKAGE_PIN AN33} [get_ports {ddr4_dq[56]}]
#set_property -dict {PACKAGE_PIN AP33} [get_ports {ddr4_dq[57]}]
#set_property -dict {PACKAGE_PIN AM34} [get_ports {ddr4_dq[58]}]
#set_property -dict {PACKAGE_PIN AP31} [get_ports {ddr4_dq[59]}]
#set_property -dict {PACKAGE_PIN AM32} [get_ports {ddr4_dq[60]}]
#set_property -dict {PACKAGE_PIN AN31} [get_ports {ddr4_dq[61]}]
#set_property -dict {PACKAGE_PIN AL34} [get_ports {ddr4_dq[62]}]
#set_property -dict {PACKAGE_PIN AN32} [get_ports {ddr4_dq[63]}]
#set_property -dict {PACKAGE_PIN AG21} [get_ports {ddr4_dqs_p[0]}]
#set_property -dict {PACKAGE_PIN AH24} [get_ports {ddr4_dqs_p[1]}]
#set_property -dict {PACKAGE_PIN AJ20} [get_ports {ddr4_dqs_p[2]}]
#set_property -dict {PACKAGE_PIN AP20} [get_ports {ddr4_dqs_p[3]}]
#set_property -dict {PACKAGE_PIN AL27} [get_ports {ddr4_dqs_p[4]}]
#set_property -dict {PACKAGE_PIN AN29} [get_ports {ddr4_dqs_p[5]}]
#set_property -dict {PACKAGE_PIN AH33} [get_ports {ddr4_dqs_p[6]}]
#set_property -dict {PACKAGE_PIN AN34} [get_ports {ddr4_dqs_p[7]}]
#set_property -dict {PACKAGE_PIN AH21} [get_ports {ddr4_dqs_n[0]}]
#set_property -dict {PACKAGE_PIN AJ25} [get_ports {ddr4_dqs_n[1]}]
#set_property -dict {PACKAGE_PIN AK20} [get_ports {ddr4_dqs_n[2]}]
#set_property -dict {PACKAGE_PIN AP21} [get_ports {ddr4_dqs_n[3]}]
#set_property -dict {PACKAGE_PIN AL28} [get_ports {ddr4_dqs_n[4]}]
#set_property -dict {PACKAGE_PIN AP30} [get_ports {ddr4_dqs_n[5]}]
#set_property -dict {PACKAGE_PIN AJ33} [get_ports {ddr4_dqs_n[6]}]
#set_property -dict {PACKAGE_PIN AP34} [get_ports {ddr4_dqs_n[7]}]
#set_property -dict {PACKAGE_PIN AJ18} [get_ports {ddr4_odt[0]}]
set_property -dict {PACKAGE_PIN AL18} [get_ports ddr4_reset_n]

# HDMI
set_property -dict  {PACKAGE_PIN  AF13  IOSTANDARD  LVCMOS18} [get_ports hdmi_out_clk]
set_property -dict  {PACKAGE_PIN  AE13  IOSTANDARD  LVCMOS18} [get_ports hdmi_hsync]
set_property -dict  {PACKAGE_PIN  AH13  IOSTANDARD  LVCMOS18} [get_ports hdmi_vsync]
set_property -dict  {PACKAGE_PIN  AE11  IOSTANDARD  LVCMOS18} [get_ports hdmi_data_e]
set_property -dict  {PACKAGE_PIN  AK11  IOSTANDARD  LVCMOS18} [get_ports hdmi_data[0]]
set_property -dict  {PACKAGE_PIN  AP11  IOSTANDARD  LVCMOS18} [get_ports hdmi_data[1]]
set_property -dict  {PACKAGE_PIN  AP13  IOSTANDARD  LVCMOS18} [get_ports hdmi_data[2]]
set_property -dict  {PACKAGE_PIN  AN13  IOSTANDARD  LVCMOS18} [get_ports hdmi_data[3]]
set_property -dict  {PACKAGE_PIN  AN11  IOSTANDARD  LVCMOS18} [get_ports hdmi_data[4]]
set_property -dict  {PACKAGE_PIN  AM11  IOSTANDARD  LVCMOS18} [get_ports hdmi_data[5]]
set_property -dict  {PACKAGE_PIN  AN12  IOSTANDARD  LVCMOS18} [get_ports hdmi_data[6]]
set_property -dict  {PACKAGE_PIN  AM12  IOSTANDARD  LVCMOS18} [get_ports hdmi_data[7]]
set_property -dict  {PACKAGE_PIN  AL12  IOSTANDARD  LVCMOS18} [get_ports hdmi_data[8]]
set_property -dict  {PACKAGE_PIN  AK12  IOSTANDARD  LVCMOS18} [get_ports hdmi_data[9]]
set_property -dict  {PACKAGE_PIN  AL13  IOSTANDARD  LVCMOS18} [get_ports hdmi_data[10]]
set_property -dict  {PACKAGE_PIN  AK13  IOSTANDARD  LVCMOS18} [get_ports hdmi_data[11]]
set_property -dict  {PACKAGE_PIN  AD11  IOSTANDARD  LVCMOS18} [get_ports hdmi_data[12]]
set_property -dict  {PACKAGE_PIN  AH12  IOSTANDARD  LVCMOS18} [get_ports hdmi_data[13]]
set_property -dict  {PACKAGE_PIN  AG12  IOSTANDARD  LVCMOS18} [get_ports hdmi_data[14]]
set_property -dict  {PACKAGE_PIN  AJ11  IOSTANDARD  LVCMOS18} [get_ports hdmi_data[15]]

# AURORA
# RX0 to FMC_HPC_DP0_M2C
set_property LOC E4 [get_ports GT_SERIAL_RX_rxp[0]]
set_property LOC E3 [get_ports GT_SERIAL_RX_rxn[0]]
# RX1 to FMC_HPC_DP1_M2C
set_property LOC D2 [get_ports GT_SERIAL_RX_rxp[1]]
set_property LOC D1 [get_ports GT_SERIAL_RX_rxn[1]]
# RX2 to FMC_HPC_DP2_M2C
set_property LOC B2 [get_ports GT_SERIAL_RX_rxp[2]]
set_property LOC B1 [get_ports GT_SERIAL_RX_rxn[2]]
# RX3 to FMC_HPC_DP3_M2C
set_property LOC A4 [get_ports GT_SERIAL_RX_rxp[3]]
set_property LOC A3 [get_ports GT_SERIAL_RX_rxn[3]]
# TX0 to FMC_HPC_DP4_C2M
set_property LOC N4 [get_ports GT_SERIAL_TX_txp[0]]
set_property LOC N3 [get_ports GT_SERIAL_TX_txn[0]]
# TX2 to FMC_HPC_DP5_C2M
set_property LOC J4 [get_ports GT_SERIAL_TX_txp[2]]
set_property LOC J3 [get_ports GT_SERIAL_TX_txn[2]]
# TX1 to FMC_HPC_DP6_C2M
set_property LOC L4 [get_ports GT_SERIAL_TX_txp[1]]
set_property LOC L3 [get_ports GT_SERIAL_TX_txn[1]]
# TX3 to FMC_HPC_DP7_C2M
set_property LOC G4 [get_ports GT_SERIAL_TX_txp[3]]
set_property LOC G3 [get_ports GT_SERIAL_TX_txn[3]]
# MGT_SI570_CLOCK (125 MHz) BANK 227
create_clock -period 8.000 -name GT_DIFF_REFCLK1 [get_ports GT_DIFF_REFCLK1_clk_p]
set_property LOC P5 [get_ports GT_DIFF_REFCLK1_clk_n]
set_property LOC P6 [get_ports GT_DIFF_REFCLK1_clk_p]
# link up on led 7
# gt_reset on pushbutton 4 (center)
#LED 5
#set_property LOC M22 [get_ports CORE_STATUS1_rx_hard_err] 
#LED 6
#set_property LOC R23 [get_ports CORE_STATUS1_rx_lane_up[2]]
#LED 4
#set_property LOC N22 [get_ports CORE_STATUS1_rx_lane_up[3]]

# S/PDIF
#set_property -dict  {PACKAGE_PIN  AE12  IOSTANDARD  LVCMOS18} [get_ports spdif]

# GPIO
set_property -dict  {PACKAGE_PIN  AD10  IOSTANDARD  LVCMOS18} [get_ports push_buttons[0]];  ## GPIO_SW_N
set_property -dict  {PACKAGE_PIN  AE8   IOSTANDARD  LVCMOS18} [get_ports push_buttons[1]];  ## GPIO_SW_E
set_property -dict  {PACKAGE_PIN  AF8   IOSTANDARD  LVCMOS18} [get_ports push_buttons[2]];  ## GPIO_SW_S
set_property -dict  {PACKAGE_PIN  AF9   IOSTANDARD  LVCMOS18} [get_ports push_buttons[3]];  ## GPIO_SW_W
set_property -dict  {PACKAGE_PIN  AE10  IOSTANDARD  LVCMOS18} [get_ports push_buttons[4]];  ## GPIO_SW_C
set_property -dict  {PACKAGE_PIN  AP8   IOSTANDARD  LVCMOS18} [get_ports leds[0]]
set_property -dict  {PACKAGE_PIN  H23   IOSTANDARD  LVCMOS18} [get_ports leds[1]]
set_property -dict  {PACKAGE_PIN  P20   IOSTANDARD  LVCMOS18} [get_ports leds[2]]
set_property -dict  {PACKAGE_PIN  P21   IOSTANDARD  LVCMOS18} [get_ports leds[3]]
set_property -dict  {PACKAGE_PIN  N22   IOSTANDARD  LVCMOS18} [get_ports leds[4]]
set_property -dict  {PACKAGE_PIN  M22   IOSTANDARD  LVCMOS18} [get_ports leds[5]]
set_property -dict  {PACKAGE_PIN  R23   IOSTANDARD  LVCMOS18} [get_ports leds[6]]
set_property -dict  {PACKAGE_PIN  P23   IOSTANDARD  LVCMOS18} [get_ports leds[7]]
#set_property -dict  {PACKAGE_PIN  AN16  IOSTANDARD  LVCMOS12  DRIVE 8} [get_ports gpio_bd[8]];   ## GPIO_DIP_SW0
#set_property -dict  {PACKAGE_PIN  AN19  IOSTANDARD  LVCMOS12  DRIVE 8} [get_ports gpio_bd[9]];   ## GPIO_DIP_SW1
#set_property -dict  {PACKAGE_PIN  AP18  IOSTANDARD  LVCMOS12  DRIVE 8} [get_ports gpio_bd[10]];  ## GPIO_DIP_SW2
#set_property -dict  {PACKAGE_PIN  AN14  IOSTANDARD  LVCMOS12  DRIVE 8} [get_ports gpio_bd[11]];  ## GPIO_DIP_SW3

# Debug core
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk]

# QSPI
#set_property -dict {PACKAGE_PIN M20  IOSTANDARD  LVCMOS18} [get_ports io0_io]
#set_property -dict {PACKAGE_PIN L20  IOSTANDARD  LVCMOS18} [get_ports io1_io]
#set_property -dict {PACKAGE_PIN R21  IOSTANDARD  LVCMOS18} [get_ports io2_io]
#set_property -dict {PACKAGE_PIN R22  IOSTANDARD  LVCMOS18} [get_ports io3_io]
#set_property -dict {PACKAGE_PIN G26  IOSTANDARD  LVCMOS18} [get_ports ss_io]
#set_property -dict {PACKAGE_PIN AA9} [get_ports sck_io]
##### STARTUPE3 parameters
# Tusrcclko maximum value
set cclk_delay 6.7
##### SPI device parameters
set tco_max 8
set tco_min 1 
# SPI setup time requirement
set tsu 2
# SPI hold time requirement
set th 3
#### BOARD parameters-assumes data trace lengths are matched
set tdata_trace_delay_max 0.25
set tdata_trace_delay_min 0.25
set tclk_trace_delay_max 0.2
set tclk_trace_delay_min 0.2
#### Constraints
# Define an SCK Clock for the Quad SPI IP. Following command creates a divided-by-2 clock. 
# It also takes into account the delay added by STARTUP block to route the CCLK
create_generated_clock -name clk_sck -source [get_pins -hierarchical *axi_quad_spi_0/ext_spi_clk] -edges {3 5 7} -edge_shift {6.700 6.700 6.700} [get_pins -hierarchical *USRCCLKO]
set_multicycle_path -setup -from [get_clocks clk_sck] -to [get_clocks -of_objects [get_pins -hierarchical */ext_spi_clk]] 2
set_multicycle_path -hold -end -from [get_clocks clk_sck] -to [get_clocks -of_objects [get_pins -hierarchical */ext_spi_clk]] 1
set_multicycle_path -setup -start -from [get_clocks -of_objects [get_pins -hierarchical */ext_spi_clk]] -to [get_clocks clk_sck] 2
set_multicycle_path -hold -from [get_clocks -of_objects [get_pins -hierarchical */ext_spi_clk]] -to [get_clocks clk_sck] 1
set_max_delay -datapath_only -from [get_pins -hier {*STARTUP*_inst/DI[*]}] 1.000
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins -hierarchical */ext_spi_clk]] -to [get_pins -hier *STARTUP*_inst/USRCCLKO] 1.000
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins -hierarchical */ext_spi_clk]] -to [get_pins -hier {*STARTUP*_inst/DO[*]}] 1.000
set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins -hierarchical */ext_spi_clk]] -to [get_pins -hier {*STARTUP*_inst/DTS[*]}] 1.000

# These settings are to enable bitstream generation to upload on the board's SPI flash memories
set_property CONFIG_MODE SPIx4 [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property CONFIG_VOLTAGE 1.8 [current_design]
set_property CFGBVS GND [current_design]
set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR YES [current_design]
set_property BITSTREAM.CONFIG.SPI_FALL_EDGE YES [current_design]
