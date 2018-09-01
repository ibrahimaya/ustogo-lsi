
################################################################
# This is a generated script based on design: system_i_bak
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2016.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source system_i_bak_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# sim_data_probe

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xcku040-ffva1156-2-e
   set_property BOARD_PART xilinx.com:kcu105:part0:1.0 [current_project]
}


# CHANGE DESIGN NAME HERE
set design_name system_i_bak

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: microblaze_0_local_memory
proc create_hier_cell_microblaze_0_local_memory { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" create_hier_cell_microblaze_0_local_memory() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 DLMB
  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 ILMB

  # Create pins
  create_bd_pin -dir I -type clk LMB_Clk
  create_bd_pin -dir I -from 0 -to 0 -type rst SYS_Rst

  # Create instance: dlmb_bram_if_cntlr, and set properties
  set dlmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 dlmb_bram_if_cntlr ]
  set_property -dict [ list \
CONFIG.C_ECC {0} \
 ] $dlmb_bram_if_cntlr

  # Create instance: dlmb_v10, and set properties
  set dlmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 dlmb_v10 ]

  # Create instance: ilmb_bram_if_cntlr, and set properties
  set ilmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 ilmb_bram_if_cntlr ]
  set_property -dict [ list \
CONFIG.C_ECC {0} \
 ] $ilmb_bram_if_cntlr

  # Create instance: ilmb_v10, and set properties
  set ilmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 ilmb_v10 ]

  # Create instance: lmb_bram, and set properties
  set lmb_bram [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.3 lmb_bram ]
  set_property -dict [ list \
CONFIG.Memory_Type {True_Dual_Port_RAM} \
CONFIG.use_bram_block {BRAM_Controller} \
 ] $lmb_bram

  # Create interface connections
  connect_bd_intf_net -intf_net microblaze_0_dlmb [get_bd_intf_pins DLMB] [get_bd_intf_pins dlmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_bus [get_bd_intf_pins dlmb_bram_if_cntlr/SLMB] [get_bd_intf_pins dlmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_cntlr [get_bd_intf_pins dlmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTA]
  connect_bd_intf_net -intf_net microblaze_0_ilmb [get_bd_intf_pins ILMB] [get_bd_intf_pins ilmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_bus [get_bd_intf_pins ilmb_bram_if_cntlr/SLMB] [get_bd_intf_pins ilmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_cntlr [get_bd_intf_pins ilmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTB]

  # Create port connections
  connect_bd_net -net SYS_Rst_1 [get_bd_pins SYS_Rst] [get_bd_pins dlmb_bram_if_cntlr/LMB_Rst] [get_bd_pins dlmb_v10/SYS_Rst] [get_bd_pins ilmb_bram_if_cntlr/LMB_Rst] [get_bd_pins ilmb_v10/SYS_Rst]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins LMB_Clk] [get_bd_pins dlmb_bram_if_cntlr/LMB_Clk] [get_bd_pins dlmb_v10/LMB_Clk] [get_bd_pins ilmb_bram_if_cntlr/LMB_Clk] [get_bd_pins ilmb_v10/LMB_Clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set GPIO [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 GPIO ]
  set GPIO2 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 GPIO2 ]
  set GT_DIFF_REFCLK1 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 GT_DIFF_REFCLK1 ]
  set_property -dict [ list \
CONFIG.FREQ_HZ {125000000} \
 ] $GT_DIFF_REFCLK1
  set GT_SERIAL_RX [ create_bd_intf_port -mode Slave -vlnv xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_RX_rtl:1.0 GT_SERIAL_RX ]
  set GT_SERIAL_TX [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_aurora:GT_Serial_Transceiver_Pins_TX_rtl:1.0 GT_SERIAL_TX ]
  set c0_ddr4 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddr4_rtl:1.0 c0_ddr4 ]
  set default_sysclk_300 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 default_sysclk_300 ]
  set_property -dict [ list \
CONFIG.FREQ_HZ {300000000} \
 ] $default_sysclk_300
  set iic_main [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 iic_main ]
  set mdio_mdc [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 mdio_mdc ]
  set phy_clk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 phy_clk ]
  set_property -dict [ list \
CONFIG.FREQ_HZ {625000000} \
 ] $phy_clk
  set sgmii [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:sgmii_rtl:1.0 sgmii ]
  set sys_clk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 sys_clk ]
  set_property -dict [ list \
CONFIG.FREQ_HZ {300000000} \
 ] $sys_clk

  # Create ports
  set aurora_reset_button [ create_bd_port -dir I -type rst aurora_reset_button ]
  set_property -dict [ list \
CONFIG.POLARITY {ACTIVE_HIGH} \
 ] $aurora_reset_button
  set hdmi_16_data [ create_bd_port -dir O -from 15 -to 0 hdmi_16_data ]
  set hdmi_16_data_e [ create_bd_port -dir O hdmi_16_data_e ]
  set hdmi_16_hsync [ create_bd_port -dir O hdmi_16_hsync ]
  set hdmi_16_vsync [ create_bd_port -dir O hdmi_16_vsync ]
  set hdmi_out_clk [ create_bd_port -dir O hdmi_out_clk ]
  set mb_intr_05 [ create_bd_port -dir I -type intr mb_intr_05 ]
  set mb_intr_06 [ create_bd_port -dir I -type intr mb_intr_06 ]
  set mb_intr_12 [ create_bd_port -dir I -type intr mb_intr_12 ]
  set mb_intr_13 [ create_bd_port -dir I -type intr mb_intr_13 ]
  set mb_intr_14 [ create_bd_port -dir I -type intr mb_intr_14 ]
  set mb_intr_15 [ create_bd_port -dir I -type intr mb_intr_15 ]
  set phy_rst_n [ create_bd_port -dir O -from 0 -to 0 -type rst phy_rst_n ]
  set rx_channel_up [ create_bd_port -dir O rx_channel_up ]
  set sys_rst [ create_bd_port -dir I -type rst sys_rst ]
  set_property -dict [ list \
CONFIG.POLARITY {ACTIVE_HIGH} \
 ] $sys_rst
  set uart_sin [ create_bd_port -dir I uart_sin ]
  set uart_sout [ create_bd_port -dir O uart_sout ]

  # Create instance: BeamformerIP_0, and set properties
  set BeamformerIP_0 [ create_bd_cell -type ip -vlnv lsi.epfl.ch:user:BeamformerIP:4.46 BeamformerIP_0 ]
  set_property -dict [ list \
CONFIG.NAPPE_BUFFER_DEPTH {3} \
 ] $BeamformerIP_0

  # Create instance: ScanConverterIP_0, and set properties
  set ScanConverterIP_0 [ create_bd_cell -type ip -vlnv lsi.epfl.ch:user:ScanConverterIP:1.211 ScanConverterIP_0 ]
  set_property -dict [ list \
CONFIG.C_S00_AXI_ARUSER_WIDTH {0} \
CONFIG.C_S00_AXI_AWUSER_WIDTH {0} \
CONFIG.C_S00_AXI_BUSER_WIDTH {0} \
CONFIG.C_S00_AXI_RUSER_WIDTH {0} \
CONFIG.C_S00_AXI_WUSER_WIDTH {0} \
 ] $ScanConverterIP_0

  # Create instance: aurora_8b10b_0, and set properties
  set aurora_8b10b_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:aurora_8b10b:11.0 aurora_8b10b_0 ]
  set_property -dict [ list \
CONFIG.Backchannel_mode {Timer} \
CONFIG.CHANNEL_ENABLE {X0Y16 X0Y17 X0Y18 X0Y19} \
CONFIG.C_AURORA_LANES {4} \
CONFIG.C_DRP_IF {false} \
CONFIG.C_GT_LOC_2 {2} \
CONFIG.C_GT_LOC_3 {3} \
CONFIG.C_GT_LOC_4 {4} \
CONFIG.C_LINE_RATE {6.25} \
CONFIG.C_REFCLK_SOURCE {MGTREFCLK0 of Quad X0Y4} \
CONFIG.C_START_LANE {X0Y16} \
CONFIG.C_START_QUAD {Quad_X0Y4} \
CONFIG.C_USE_BYTESWAP {true} \
CONFIG.Dataflow_Config {RX-only_Simplex} \
CONFIG.SupportLevel {1} \
 ] $aurora_8b10b_0

  # Create instance: aurora_8b10b_1, and set properties
  set aurora_8b10b_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:aurora_8b10b:11.0 aurora_8b10b_1 ]
  set_property -dict [ list \
CONFIG.Backchannel_mode {Timer} \
CONFIG.CHANNEL_ENABLE {X0Y12 X0Y13 X0Y14 X0Y15} \
CONFIG.C_AURORA_LANES {4} \
CONFIG.C_DRP_IF {false} \
CONFIG.C_GT_LOC_2 {2} \
CONFIG.C_GT_LOC_3 {3} \
CONFIG.C_GT_LOC_4 {4} \
CONFIG.C_LINE_RATE {6.25} \
CONFIG.C_REFCLK_SOURCE {MGTREFCLK0 of Quad X0Y3} \
CONFIG.C_START_LANE {X0Y12} \
CONFIG.C_START_QUAD {Quad_X0Y3} \
CONFIG.C_USE_BYTESWAP {true} \
CONFIG.Dataflow_Config {TX-only_Simplex} \
CONFIG.SINGLEEND_GTREFCLK {true} \
CONFIG.SupportLevel {1} \
 ] $aurora_8b10b_1

  # Create instance: axi_clkgen_0, and set properties
  set axi_clkgen_0 [ create_bd_cell -type ip -vlnv analog.com:user:axi_clkgen:1.0 axi_clkgen_0 ]

  # Create instance: axi_cpu_interconnect, and set properties
  set axi_cpu_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_cpu_interconnect ]
  set_property -dict [ list \
CONFIG.NUM_MI {15} \
CONFIG.NUM_SI {7} \
CONFIG.S00_HAS_DATA_FIFO {1} \
CONFIG.S01_HAS_DATA_FIFO {1} \
CONFIG.S02_HAS_DATA_FIFO {1} \
CONFIG.S03_HAS_DATA_FIFO {1} \
CONFIG.S04_HAS_DATA_FIFO {2} \
CONFIG.S05_HAS_DATA_FIFO {2} \
CONFIG.S06_HAS_DATA_FIFO {2} \
CONFIG.S07_HAS_DATA_FIFO {1} \
CONFIG.S08_HAS_DATA_FIFO {2} \
CONFIG.S09_HAS_DATA_FIFO {2} \
CONFIG.STRATEGY {1} \
 ] $axi_cpu_interconnect

  # Create instance: axi_ddr_cntrl, and set properties
  set axi_ddr_cntrl [ create_bd_cell -type ip -vlnv xilinx.com:ip:ddr4:2.0 axi_ddr_cntrl ]
  set_property -dict [ list \
CONFIG.ADDN_UI_CLKOUT1_FREQ_HZ {133} \
CONFIG.ADDN_UI_CLKOUT2_FREQ_HZ {200} \
CONFIG.C0.DDR4_AxiDataWidth {512} \
CONFIG.C0.DDR4_CasWriteLatency {12} \
CONFIG.C0.DDR4_DataWidth {64} \
CONFIG.C0.DDR4_InputClockPeriod {3332} \
CONFIG.C0.DDR4_Mem_Add_Map {ROW_COLUMN_BANK} \
CONFIG.C0.DDR4_MemoryPart {EDY4016AABG-DR-F} \
CONFIG.C0.DDR4_TimePeriod {833} \
CONFIG.C0_CLOCK_BOARD_INTERFACE {Custom} \
CONFIG.C0_DDR4_BOARD_INTERFACE {ddr4_sdram} \
CONFIG.Debug_Signal {Disable} \
CONFIG.RESET_BOARD_INTERFACE {reset} \
 ] $axi_ddr_cntrl

  # Create instance: axi_ddr_cntrl_rstgen, and set properties
  set axi_ddr_cntrl_rstgen [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 axi_ddr_cntrl_rstgen ]

  # Create instance: axi_ethernet_0, and set properties
  set axi_ethernet_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernet:7.0 axi_ethernet_0 ]
  set_property -dict [ list \
CONFIG.ENABLE_LVDS {true} \
CONFIG.ETHERNET_BOARD_INTERFACE {sgmii} \
CONFIG.MDIO_BOARD_INTERFACE {mdio_mdc} \
CONFIG.PHY_TYPE {SGMII} \
CONFIG.Statistics_Counters {false} \
CONFIG.SupportLevel {0} \
CONFIG.axiliteclkrate {133} \
CONFIG.axisclkrate {133} \
 ] $axi_ethernet_0

  # Create instance: axi_ethernet_clkgen, and set properties
  set axi_ethernet_clkgen [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.3 axi_ethernet_clkgen ]
  set_property -dict [ list \
CONFIG.CLKIN1_JITTER_PS {16.0} \
CONFIG.CLKOUT1_JITTER {95.868} \
CONFIG.CLKOUT1_PHASE_ERROR {76.196} \
CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {125} \
CONFIG.CLKOUT2_JITTER {80.069} \
CONFIG.CLKOUT2_PHASE_ERROR {76.196} \
CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {312} \
CONFIG.CLKOUT2_USED {true} \
CONFIG.CLKOUT3_DRIVES {BUFG} \
CONFIG.CLKOUT3_JITTER {69.880} \
CONFIG.CLKOUT3_PHASE_ERROR {76.196} \
CONFIG.CLKOUT3_REQUESTED_OUT_FREQ {625} \
CONFIG.CLKOUT3_USED {true} \
CONFIG.CLKOUT4_JITTER {99.367} \
CONFIG.CLKOUT4_PHASE_ERROR {76.196} \
CONFIG.CLKOUT4_REQUESTED_OUT_FREQ {108} \
CONFIG.CLKOUT4_USED {true} \
CONFIG.CLKOUT5_JITTER {86.709} \
CONFIG.CLKOUT5_PHASE_ERROR {76.196} \
CONFIG.CLKOUT5_REQUESTED_OUT_FREQ {208} \
CONFIG.CLKOUT5_USED {true} \
CONFIG.CLKOUT6_DRIVES {BUFG} \
CONFIG.CLKOUT6_JITTER {86.709} \
CONFIG.CLKOUT6_PHASE_ERROR {76.196} \
CONFIG.CLKOUT6_REQUESTED_OUT_FREQ {208} \
CONFIG.CLKOUT6_USED {false} \
CONFIG.CLK_IN1_BOARD_INTERFACE {sgmii_phyclk} \
CONFIG.MMCM_CLKIN1_PERIOD {1.6} \
CONFIG.MMCM_CLKIN2_PERIOD {10.0} \
CONFIG.MMCM_CLKOUT0_DIVIDE_F {10.000} \
CONFIG.MMCM_CLKOUT1_DIVIDE {4} \
CONFIG.MMCM_CLKOUT2_DIVIDE {2} \
CONFIG.MMCM_CLKOUT3_DIVIDE {12} \
CONFIG.MMCM_CLKOUT4_DIVIDE {6} \
CONFIG.MMCM_CLKOUT5_DIVIDE {1} \
CONFIG.MMCM_DIVCLK_DIVIDE {2} \
CONFIG.NUM_OUT_CLKS {5} \
CONFIG.PRIM_IN_FREQ {625.000} \
CONFIG.PRIM_SOURCE {Differential_clock_capable_pin} \
CONFIG.RESET_BOARD_INTERFACE {Custom} \
CONFIG.USE_LOCKED {true} \
CONFIG.USE_RESET {false} \
 ] $axi_ethernet_clkgen

  # Need to retain value_src of defaults
  set_property -dict [ list \
CONFIG.CLKIN1_JITTER_PS.VALUE_SRC {DEFAULT} \
CONFIG.CLKOUT1_JITTER.VALUE_SRC {DEFAULT} \
CONFIG.CLKOUT1_PHASE_ERROR.VALUE_SRC {DEFAULT} \
CONFIG.CLKOUT2_JITTER.VALUE_SRC {DEFAULT} \
CONFIG.CLKOUT2_PHASE_ERROR.VALUE_SRC {DEFAULT} \
CONFIG.CLKOUT3_JITTER.VALUE_SRC {DEFAULT} \
CONFIG.CLKOUT3_PHASE_ERROR.VALUE_SRC {DEFAULT} \
CONFIG.MMCM_CLKIN2_PERIOD.VALUE_SRC {DEFAULT} \
CONFIG.MMCM_CLKOUT0_DIVIDE_F.VALUE_SRC {DEFAULT} \
CONFIG.MMCM_CLKOUT1_DIVIDE.VALUE_SRC {DEFAULT} \
CONFIG.MMCM_CLKOUT2_DIVIDE.VALUE_SRC {DEFAULT} \
 ] $axi_ethernet_clkgen

  # Create instance: axi_ethernet_dma, and set properties
  set axi_ethernet_dma [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_ethernet_dma ]
  set_property -dict [ list \
CONFIG.c_include_mm2s_dre {1} \
CONFIG.c_include_s2mm_dre {1} \
CONFIG.c_sg_length_width {16} \
CONFIG.c_sg_use_stsapp_length {1} \
 ] $axi_ethernet_dma

  # Create instance: axi_ethernet_idelayctrl, and set properties
  set axi_ethernet_idelayctrl [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_idelay_ctrl:1.0 axi_ethernet_idelayctrl ]

  # Create instance: axi_ethernet_rstgen, and set properties
  set axi_ethernet_rstgen [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 axi_ethernet_rstgen ]
  set_property -dict [ list \
CONFIG.RESET_BOARD_INTERFACE {Custom} \
 ] $axi_ethernet_rstgen

  # Create instance: axi_gpio_0, and set properties
  set axi_gpio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_0 ]
  set_property -dict [ list \
CONFIG.C_ALL_INPUTS {0} \
CONFIG.C_ALL_INPUTS_2 {1} \
CONFIG.C_ALL_OUTPUTS {1} \
CONFIG.C_GPIO2_WIDTH {4} \
CONFIG.C_GPIO_WIDTH {7} \
CONFIG.C_IS_DUAL {1} \
CONFIG.GPIO2_BOARD_INTERFACE {Custom} \
CONFIG.GPIO_BOARD_INTERFACE {Custom} \
CONFIG.USE_BOARD_FLOW {true} \
 ] $axi_gpio_0

  # Create instance: axi_hdmi_tx_0, and set properties
  set axi_hdmi_tx_0 [ create_bd_cell -type ip -vlnv analog.com:user:axi_hdmi_tx:1.0 axi_hdmi_tx_0 ]
  set_property -dict [ list \
CONFIG.DEVICE_TYPE {1} \
 ] $axi_hdmi_tx_0

  # Create instance: axi_iic_0, and set properties
  set axi_iic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.0 axi_iic_0 ]
  set_property -dict [ list \
CONFIG.IIC_BOARD_INTERFACE {iic_main} \
CONFIG.USE_BOARD_FLOW {true} \
 ] $axi_iic_0

  # Create instance: axi_intc, and set properties
  set axi_intc [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 axi_intc ]
  set_property -dict [ list \
CONFIG.C_HAS_FAST {0} \
 ] $axi_intc

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0 ]
  set_property -dict [ list \
CONFIG.NUM_MI {1} \
CONFIG.NUM_SI {4} \
CONFIG.S00_HAS_DATA_FIFO {2} \
CONFIG.S01_HAS_DATA_FIFO {2} \
CONFIG.S02_HAS_DATA_FIFO {2} \
CONFIG.S03_HAS_DATA_FIFO {2} \
CONFIG.STRATEGY {2} \
 ] $axi_interconnect_0

  # Create instance: axi_quad_spi_0, and set properties
  set axi_quad_spi_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0 ]
  set_property -dict [ list \
CONFIG.C_SCK_RATIO {2} \
CONFIG.C_SPI_MEMORY {2} \
CONFIG.C_SPI_MODE {2} \
CONFIG.C_USE_STARTUP {1} \
CONFIG.C_USE_STARTUP_INT {1} \
 ] $axi_quad_spi_0

  # Create instance: axi_timer, and set properties
  set axi_timer [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer ]

  # Create instance: axi_uartlite_0, and set properties
  set axi_uartlite_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 axi_uartlite_0 ]
  set_property -dict [ list \
CONFIG.C_S_AXI_ACLK_FREQ_HZ {133000000} \
CONFIG.UARTLITE_BOARD_INTERFACE {rs232_uart} \
 ] $axi_uartlite_0

  # Need to retain value_src of defaults
  set_property -dict [ list \
CONFIG.C_S_AXI_ACLK_FREQ_HZ.VALUE_SRC {DEFAULT} \
 ] $axi_uartlite_0

  # Create instance: axi_vdma_0, and set properties
  set axi_vdma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma:6.2 axi_vdma_0 ]
  set_property -dict [ list \
CONFIG.c_include_s2mm {0} \
CONFIG.c_m_axis_mm2s_tdata_width {64} \
CONFIG.c_s2mm_genlock_mode {0} \
CONFIG.c_use_mm2s_fsync {1} \
 ] $axi_vdma_0

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:1.1 axis_data_fifo_0 ]
  set_property -dict [ list \
CONFIG.FIFO_DEPTH {32768} \
CONFIG.IS_ACLK_ASYNC {1} \
CONFIG.TDATA_NUM_BYTES {8} \
 ] $axis_data_fifo_0

  # Create instance: ila_0, and set properties
  set ila_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ila:6.1 ila_0 ]
  set_property -dict [ list \
CONFIG.C_ADV_TRIGGER {true} \
CONFIG.C_ENABLE_ILA_AXI_MON {false} \
CONFIG.C_MONITOR_TYPE {Native} \
CONFIG.C_NUM_OF_PROBES {3} \
CONFIG.C_PROBE0_WIDTH {64} \
CONFIG.C_TRIGIN_EN {true} \
 ] $ila_0

  # Create instance: microblaze_0_local_memory
  create_hier_cell_microblaze_0_local_memory [current_bd_instance .] microblaze_0_local_memory

  # Create instance: sim_data_probe_0, and set properties
  set block_name sim_data_probe
  set block_cell_name sim_data_probe_0
  if { [catch {set sim_data_probe_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $sim_data_probe_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: sys_concat_intc, and set properties
  set sys_concat_intc [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 sys_concat_intc ]
  set_property -dict [ list \
CONFIG.NUM_PORTS {13} \
 ] $sys_concat_intc

  # Create instance: sys_mb, and set properties
  set sys_mb [ create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:9.6 sys_mb ]
  set_property -dict [ list \
CONFIG.C_AREA_OPTIMIZED {0} \
CONFIG.C_CACHE_BYTE_SIZE {4096} \
CONFIG.C_DCACHE_BYTE_SIZE {4096} \
CONFIG.C_DCACHE_LINE_LEN {4} \
CONFIG.C_DCACHE_USE_WRITEBACK {0} \
CONFIG.C_DCACHE_VICTIMS {0} \
CONFIG.C_DEBUG_ENABLED {1} \
CONFIG.C_DIV_ZERO_EXCEPTION {0} \
CONFIG.C_D_LMB {1} \
CONFIG.C_FSL_LINKS {0} \
CONFIG.C_ICACHE_LINE_LEN {8} \
CONFIG.C_ICACHE_STREAMS {0} \
CONFIG.C_ICACHE_VICTIMS {0} \
CONFIG.C_ILL_OPCODE_EXCEPTION {0} \
CONFIG.C_I_AXI {1} \
CONFIG.C_I_LMB {1} \
CONFIG.C_MMU_DTLB_SIZE {4} \
CONFIG.C_MMU_ITLB_SIZE {2} \
CONFIG.C_M_AXI_D_BUS_EXCEPTION {1} \
CONFIG.C_M_AXI_I_BUS_EXCEPTION {0} \
CONFIG.C_NUMBER_OF_PC_BRK {2} \
CONFIG.C_OPCODE_0x0_ILLEGAL {0} \
CONFIG.C_PVR {0} \
CONFIG.C_UNALIGNED_EXCEPTIONS {0} \
CONFIG.C_USE_BARREL {1} \
CONFIG.C_USE_BRANCH_TARGET_CACHE {0} \
CONFIG.C_USE_DCACHE {1} \
CONFIG.C_USE_DIV {0} \
CONFIG.C_USE_FPU {0} \
CONFIG.C_USE_HW_MUL {1} \
CONFIG.C_USE_ICACHE {1} \
CONFIG.C_USE_MMU {3} \
CONFIG.C_USE_MSR_INSTR {1} \
CONFIG.C_USE_PCMP_INSTR {1} \
CONFIG.C_USE_REORDER_INSTR {1} \
CONFIG.G_TEMPLATE_LIST {6} \
CONFIG.G_USE_EXCEPTIONS {1} \
 ] $sys_mb

  # Create instance: sys_mb_debug, and set properties
  set sys_mb_debug [ create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 sys_mb_debug ]
  set_property -dict [ list \
CONFIG.C_USE_UART {1} \
 ] $sys_mb_debug

  # Create instance: sys_rstgen, and set properties
  set sys_rstgen [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 sys_rstgen ]

  # Create instance: util_vector_logic_0, and set properties
  set util_vector_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0 ]
  set_property -dict [ list \
CONFIG.C_OPERATION {not} \
CONFIG.C_SIZE {1} \
CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $util_vector_logic_0

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
CONFIG.CONST_VAL {0} \
CONFIG.CONST_WIDTH {3} \
 ] $xlconstant_0

  # Create instance: xlconstant_1, and set properties
  set xlconstant_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_1 ]
  set_property -dict [ list \
CONFIG.CONST_VAL {0} \
CONFIG.CONST_WIDTH {1} \
 ] $xlconstant_1

  # Create instance: xlconstant_2, and set properties
  set xlconstant_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_2 ]
  set_property -dict [ list \
CONFIG.CONST_VAL {0} \
 ] $xlconstant_2

  # Create instance: xlconstant_3, and set properties
  set xlconstant_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_3 ]

  # Create instance: xlconstant_4, and set properties
  set xlconstant_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_4 ]

  # Create instance: xlconstant_5, and set properties
  set xlconstant_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_5 ]

  # Create instance: xlconstant_6, and set properties
  set xlconstant_6 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_6 ]
  set_property -dict [ list \
CONFIG.CONST_VAL {255} \
CONFIG.CONST_WIDTH {8} \
 ] $xlconstant_6

  # Create instance: xlconstant_7, and set properties
  set xlconstant_7 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_7 ]
  set_property -dict [ list \
CONFIG.CONST_VAL {0} \
 ] $xlconstant_7

  # Create instance: xlconstant_8, and set properties
  set xlconstant_8 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_8 ]
  set_property -dict [ list \
CONFIG.CONST_VAL {0} \
CONFIG.CONST_WIDTH {3} \
 ] $xlconstant_8

  # Create interface connections
  connect_bd_intf_net -intf_net GT_DIFF_REFCLK1_1 [get_bd_intf_ports GT_DIFF_REFCLK1] [get_bd_intf_pins aurora_8b10b_0/GT_DIFF_REFCLK1]
  connect_bd_intf_net -intf_net GT_SERIAL_RX_1 [get_bd_intf_ports GT_SERIAL_RX] [get_bd_intf_pins aurora_8b10b_0/GT_SERIAL_RX]
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins axi_cpu_interconnect/S00_AXI] [get_bd_intf_pins sys_mb/M_AXI_DP]
  connect_bd_intf_net -intf_net S05_AXI_1 [get_bd_intf_pins BeamformerIP_0/m00_axi] [get_bd_intf_pins axi_cpu_interconnect/S05_AXI]
  connect_bd_intf_net -intf_net ScanConverterIP_0_m00_axi [get_bd_intf_pins ScanConverterIP_0/m00_axi] [get_bd_intf_pins axi_cpu_interconnect/S06_AXI]
  connect_bd_intf_net -intf_net aurora_8b10b_0_USER_DATA_M_AXI_RX [get_bd_intf_pins aurora_8b10b_0/USER_DATA_M_AXI_RX] [get_bd_intf_pins axis_data_fifo_0/S_AXIS]
  connect_bd_intf_net -intf_net aurora_8b10b_1_GT_SERIAL_TX [get_bd_intf_ports GT_SERIAL_TX] [get_bd_intf_pins aurora_8b10b_1/GT_SERIAL_TX]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M00_AXI [get_bd_intf_pins axi_cpu_interconnect/M00_AXI] [get_bd_intf_pins sys_mb_debug/S_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M01_AXI [get_bd_intf_pins BeamformerIP_0/s00_axi] [get_bd_intf_pins axi_cpu_interconnect/M01_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M02_AXI [get_bd_intf_pins axi_cpu_interconnect/M02_AXI] [get_bd_intf_pins axi_ethernet_dma/S_AXI_LITE]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M03_AXI [get_bd_intf_pins axi_cpu_interconnect/M03_AXI] [get_bd_intf_pins axi_timer/S_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M04_AXI [get_bd_intf_pins axi_cpu_interconnect/M04_AXI] [get_bd_intf_pins axi_intc/s_axi]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M05_AXI [get_bd_intf_pins axi_cpu_interconnect/M05_AXI] [get_bd_intf_pins axi_quad_spi_0/AXI_LITE]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M06_AXI [get_bd_intf_pins axi_cpu_interconnect/M06_AXI] [get_bd_intf_pins axi_uartlite_0/S_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M07_AXI [get_bd_intf_pins axi_cpu_interconnect/M07_AXI] [get_bd_intf_pins axi_interconnect_0/S03_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M08_AXI [get_bd_intf_pins axi_cpu_interconnect/M08_AXI] [get_bd_intf_pins axi_ethernet_0/s_axi]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M09_AXI [get_bd_intf_pins axi_cpu_interconnect/M09_AXI] [get_bd_intf_pins axi_iic_0/S_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M10_AXI [get_bd_intf_pins axi_cpu_interconnect/M10_AXI] [get_bd_intf_pins axi_vdma_0/S_AXI_LITE]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M11_AXI [get_bd_intf_pins axi_cpu_interconnect/M11_AXI] [get_bd_intf_pins axi_hdmi_tx_0/s_axi]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M12_AXI [get_bd_intf_pins axi_cpu_interconnect/M12_AXI] [get_bd_intf_pins axi_gpio_0/S_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M13_AXI [get_bd_intf_pins axi_clkgen_0/s_axi] [get_bd_intf_pins axi_cpu_interconnect/M13_AXI]
  connect_bd_intf_net -intf_net axi_cpu_interconnect_M14_AXI [get_bd_intf_pins ScanConverterIP_0/s00_axi] [get_bd_intf_pins axi_cpu_interconnect/M14_AXI]
  connect_bd_intf_net -intf_net axi_ddr_cntrl_C0_DDR4 [get_bd_intf_ports c0_ddr4] [get_bd_intf_pins axi_ddr_cntrl/C0_DDR4]
  connect_bd_intf_net -intf_net axi_ethernet_0_m_axis_rxd [get_bd_intf_pins axi_ethernet_0/m_axis_rxd] [get_bd_intf_pins axi_ethernet_dma/S_AXIS_S2MM]
  connect_bd_intf_net -intf_net axi_ethernet_0_m_axis_rxs [get_bd_intf_pins axi_ethernet_0/m_axis_rxs] [get_bd_intf_pins axi_ethernet_dma/S_AXIS_STS]
  connect_bd_intf_net -intf_net axi_ethernet_0_mdio [get_bd_intf_ports mdio_mdc] [get_bd_intf_pins axi_ethernet_0/mdio]
  connect_bd_intf_net -intf_net axi_ethernet_0_sgmii [get_bd_intf_ports sgmii] [get_bd_intf_pins axi_ethernet_0/sgmii]
  connect_bd_intf_net -intf_net axi_ethernet_dma_M_AXIS_CNTRL [get_bd_intf_pins axi_ethernet_0/s_axis_txc] [get_bd_intf_pins axi_ethernet_dma/M_AXIS_CNTRL]
  connect_bd_intf_net -intf_net axi_ethernet_dma_M_AXIS_MM2S [get_bd_intf_pins axi_ethernet_0/s_axis_txd] [get_bd_intf_pins axi_ethernet_dma/M_AXIS_MM2S]
  connect_bd_intf_net -intf_net axi_ethernet_dma_M_AXI_MM2S [get_bd_intf_pins axi_cpu_interconnect/S02_AXI] [get_bd_intf_pins axi_ethernet_dma/M_AXI_MM2S]
  connect_bd_intf_net -intf_net axi_ethernet_dma_M_AXI_S2MM [get_bd_intf_pins axi_cpu_interconnect/S03_AXI] [get_bd_intf_pins axi_ethernet_dma/M_AXI_S2MM]
  connect_bd_intf_net -intf_net axi_ethernet_dma_M_AXI_SG [get_bd_intf_pins axi_cpu_interconnect/S01_AXI] [get_bd_intf_pins axi_ethernet_dma/M_AXI_SG]
  connect_bd_intf_net -intf_net axi_gpio_0_GPIO [get_bd_intf_ports GPIO] [get_bd_intf_pins axi_gpio_0/GPIO]
  connect_bd_intf_net -intf_net axi_gpio_0_GPIO2 [get_bd_intf_ports GPIO2] [get_bd_intf_pins axi_gpio_0/GPIO2]
  connect_bd_intf_net -intf_net axi_iic_0_IIC [get_bd_intf_ports iic_main] [get_bd_intf_pins axi_iic_0/IIC]
  connect_bd_intf_net -intf_net axi_intc_interrupt [get_bd_intf_pins axi_intc/interrupt] [get_bd_intf_pins sys_mb/INTERRUPT]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins axi_ddr_cntrl/C0_DDR4_S_AXI] [get_bd_intf_pins axi_interconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net axi_vdma_0_M_AXI_MM2S [get_bd_intf_pins axi_interconnect_0/S02_AXI] [get_bd_intf_pins axi_vdma_0/M_AXI_MM2S]
  connect_bd_intf_net -intf_net phy_clk_1 [get_bd_intf_ports phy_clk] [get_bd_intf_pins axi_ethernet_clkgen/CLK_IN1_D]
  connect_bd_intf_net -intf_net sys_clk_1 [get_bd_intf_ports sys_clk] [get_bd_intf_pins axi_ddr_cntrl/C0_SYS_CLK]
  connect_bd_intf_net -intf_net sys_mb_DLMB [get_bd_intf_pins microblaze_0_local_memory/DLMB] [get_bd_intf_pins sys_mb/DLMB]
  connect_bd_intf_net -intf_net sys_mb_ILMB [get_bd_intf_pins microblaze_0_local_memory/ILMB] [get_bd_intf_pins sys_mb/ILMB]
  connect_bd_intf_net -intf_net sys_mb_M_AXI_DC [get_bd_intf_pins axi_interconnect_0/S00_AXI] [get_bd_intf_pins sys_mb/M_AXI_DC]
  connect_bd_intf_net -intf_net sys_mb_M_AXI_IC [get_bd_intf_pins axi_interconnect_0/S01_AXI] [get_bd_intf_pins sys_mb/M_AXI_IC]
  connect_bd_intf_net -intf_net sys_mb_M_AXI_IP [get_bd_intf_pins axi_cpu_interconnect/S04_AXI] [get_bd_intf_pins sys_mb/M_AXI_IP]
  connect_bd_intf_net -intf_net sys_mb_debug_MBDEBUG_0 [get_bd_intf_pins sys_mb/DEBUG] [get_bd_intf_pins sys_mb_debug/MBDEBUG_0]

  # Create port connections
  connect_bd_net -net BeamformerIP_0_fifo_axis_tready [get_bd_pins BeamformerIP_0/fifo_axis_tready] [get_bd_pins axis_data_fifo_0/m_axis_tready] [get_bd_pins ila_0/probe2]
  connect_bd_net -net aurora_8b10b_0_gt_refclk1_out [get_bd_pins aurora_8b10b_0/gt_refclk1_out] [get_bd_pins aurora_8b10b_1/gt_refclk1]
  connect_bd_net -net aurora_8b10b_0_gt_reset_out [get_bd_pins aurora_8b10b_0/gt_reset_out] [get_bd_pins aurora_8b10b_1/gt_reset]
  connect_bd_net -net aurora_8b10b_0_rx_channel_up [get_bd_ports rx_channel_up] [get_bd_pins aurora_8b10b_0/rx_channel_up]
  connect_bd_net -net aurora_8b10b_0_sys_reset_out [get_bd_pins aurora_8b10b_0/sys_reset_out] [get_bd_pins util_vector_logic_0/Op1]
  connect_bd_net -net aurora_8b10b_0_user_clk_out [get_bd_pins aurora_8b10b_0/user_clk_out] [get_bd_pins axis_data_fifo_0/s_axis_aclk]
  connect_bd_net -net aurora_8b10b_1_s_axi_tx_tready [get_bd_pins aurora_8b10b_1/s_axi_tx_tready] [get_bd_pins sim_data_probe_0/axis_tready]
  connect_bd_net -net aurora_8b10b_1_user_clk_out [get_bd_pins aurora_8b10b_1/user_clk_out] [get_bd_pins sim_data_probe_0/axis_aclk]
  connect_bd_net -net axi_ddr_cntrl_addn_ui_clkout2 [get_bd_pins axi_clkgen_0/clk_0] [get_bd_pins axi_hdmi_tx_0/hdmi_clk]
  connect_bd_net -net axi_ddr_cntrl_addn_ui_clkout3 [get_bd_pins aurora_8b10b_0/init_clk_in] [get_bd_pins aurora_8b10b_1/init_clk_in] [get_bd_pins axi_clkgen_0/clk] [get_bd_pins axi_ddr_cntrl/addn_ui_clkout2]
  connect_bd_net -net axi_ddr_cntrl_c0_ddr4_ui_clk_sync_rst [get_bd_pins axi_ddr_cntrl/c0_ddr4_ui_clk_sync_rst] [get_bd_pins axi_ddr_cntrl_rstgen/ext_reset_in] [get_bd_pins axi_ethernet_rstgen/ext_reset_in] [get_bd_pins sys_rstgen/ext_reset_in]
  connect_bd_net -net axi_ethernet_0_interrupt [get_bd_pins axi_ethernet_0/interrupt] [get_bd_pins sys_concat_intc/In1]
  connect_bd_net -net axi_ethernet_clkgen_clk_out1 [get_bd_pins axi_ethernet_0/clk125m] [get_bd_pins axi_ethernet_clkgen/clk_out1] [get_bd_pins axi_ethernet_rstgen/slowest_sync_clk]
  connect_bd_net -net axi_ethernet_clkgen_clk_out2 [get_bd_pins axi_ethernet_0/clk312] [get_bd_pins axi_ethernet_clkgen/clk_out2]
  connect_bd_net -net axi_ethernet_clkgen_clk_out3 [get_bd_pins axi_ethernet_0/clk625] [get_bd_pins axi_ethernet_clkgen/clk_out3]
  connect_bd_net -net axi_ethernet_clkgen_clk_out4 [get_bd_pins axi_ethernet_clkgen/clk_out4] [get_bd_pins axi_quad_spi_0/ext_spi_clk]
  connect_bd_net -net axi_ethernet_clkgen_clk_out5 [get_bd_pins axi_ethernet_clkgen/clk_out5] [get_bd_pins axi_ethernet_idelayctrl/ref_clk]
  connect_bd_net -net axi_ethernet_clkgen_locked [get_bd_pins axi_ethernet_0/mmcm_locked] [get_bd_pins axi_ethernet_clkgen/locked]
  connect_bd_net -net axi_ethernet_dma_mm2s_cntrl_reset_out_n [get_bd_pins axi_ethernet_0/axi_txc_arstn] [get_bd_pins axi_ethernet_dma/mm2s_cntrl_reset_out_n]
  connect_bd_net -net axi_ethernet_dma_mm2s_introut [get_bd_pins axi_ethernet_dma/mm2s_introut] [get_bd_pins sys_concat_intc/In2]
  connect_bd_net -net axi_ethernet_dma_mm2s_prmry_reset_out_n [get_bd_pins axi_ethernet_0/axi_txd_arstn] [get_bd_pins axi_ethernet_dma/mm2s_prmry_reset_out_n]
  connect_bd_net -net axi_ethernet_dma_s2mm_introut [get_bd_pins axi_ethernet_dma/s2mm_introut] [get_bd_pins sys_concat_intc/In3]
  connect_bd_net -net axi_ethernet_dma_s2mm_prmry_reset_out_n [get_bd_pins axi_ethernet_0/axi_rxd_arstn] [get_bd_pins axi_ethernet_dma/s2mm_prmry_reset_out_n]
  connect_bd_net -net axi_ethernet_dma_s2mm_sts_reset_out_n [get_bd_pins axi_ethernet_0/axi_rxs_arstn] [get_bd_pins axi_ethernet_dma/s2mm_sts_reset_out_n]
  connect_bd_net -net axi_ethernet_idelayctrl_rdy [get_bd_pins axi_ethernet_0/idelay_rdy_in] [get_bd_pins axi_ethernet_idelayctrl/rdy]
  connect_bd_net -net axi_ethernet_rstgen_peripheral_reset [get_bd_pins axi_ethernet_0/rst_125] [get_bd_pins axi_ethernet_idelayctrl/rst] [get_bd_pins axi_ethernet_rstgen/peripheral_reset]
  connect_bd_net -net axi_hdmi_tx_0_hdmi_16_data [get_bd_ports hdmi_16_data] [get_bd_pins axi_hdmi_tx_0/hdmi_16_data]
  connect_bd_net -net axi_hdmi_tx_0_hdmi_16_data_e [get_bd_ports hdmi_16_data_e] [get_bd_pins axi_hdmi_tx_0/hdmi_16_data_e]
  connect_bd_net -net axi_hdmi_tx_0_hdmi_16_hsync [get_bd_ports hdmi_16_hsync] [get_bd_pins axi_hdmi_tx_0/hdmi_16_hsync]
  connect_bd_net -net axi_hdmi_tx_0_hdmi_16_vsync [get_bd_ports hdmi_16_vsync] [get_bd_pins axi_hdmi_tx_0/hdmi_16_vsync]
  connect_bd_net -net axi_hdmi_tx_0_hdmi_out_clk [get_bd_ports hdmi_out_clk] [get_bd_pins axi_hdmi_tx_0/hdmi_out_clk]
  connect_bd_net -net axi_hdmi_tx_0_vdma_fs [get_bd_pins axi_hdmi_tx_0/vdma_fs] [get_bd_pins axi_hdmi_tx_0/vdma_fs_ret] [get_bd_pins axi_vdma_0/mm2s_fsync]
  connect_bd_net -net axi_hdmi_tx_0_vdma_ready [get_bd_pins axi_hdmi_tx_0/vdma_ready] [get_bd_pins axi_vdma_0/m_axis_mm2s_tready]
  connect_bd_net -net axi_iic_0_iic2intc_irpt [get_bd_pins axi_iic_0/iic2intc_irpt] [get_bd_pins sys_concat_intc/In11]
  connect_bd_net -net axi_timer_interrupt [get_bd_pins axi_timer/interrupt] [get_bd_pins sys_concat_intc/In0]
  connect_bd_net -net axi_uartlite_0_interrupt [get_bd_pins axi_uartlite_0/interrupt] [get_bd_pins sys_concat_intc/In10]
  connect_bd_net -net axi_uartlite_0_tx [get_bd_ports uart_sout] [get_bd_pins axi_uartlite_0/tx]
  connect_bd_net -net axi_vdma_0_m_axis_mm2s_tdata [get_bd_pins axi_hdmi_tx_0/vdma_data] [get_bd_pins axi_vdma_0/m_axis_mm2s_tdata]
  connect_bd_net -net axi_vdma_0_m_axis_mm2s_tvalid [get_bd_pins axi_hdmi_tx_0/vdma_valid] [get_bd_pins axi_vdma_0/m_axis_mm2s_tvalid]
  connect_bd_net -net axi_vdma_0_mm2s_introut [get_bd_pins axi_vdma_0/mm2s_introut] [get_bd_pins sys_concat_intc/In12]
  connect_bd_net -net axis_data_fifo_0_axis_data_count [get_bd_pins axis_data_fifo_0/axis_data_count]
  connect_bd_net -net axis_data_fifo_0_axis_rd_data_count [get_bd_pins BeamformerIP_0/fifo_axis_rd_data_count] [get_bd_pins axis_data_fifo_0/axis_rd_data_count]
  connect_bd_net -net axis_data_fifo_0_m_axis_tdata [get_bd_pins BeamformerIP_0/fifo_axis_tdata] [get_bd_pins axis_data_fifo_0/m_axis_tdata] [get_bd_pins ila_0/probe0]
  connect_bd_net -net axis_data_fifo_0_m_axis_tvalid [get_bd_pins BeamformerIP_0/fifo_axis_tvalid] [get_bd_pins axis_data_fifo_0/m_axis_tvalid] [get_bd_pins ila_0/probe1]
  connect_bd_net -net mb_intr_05_1 [get_bd_ports mb_intr_05] [get_bd_pins sys_concat_intc/In4]
  connect_bd_net -net mb_intr_06_1 [get_bd_ports mb_intr_06] [get_bd_pins sys_concat_intc/In5]
  connect_bd_net -net mb_intr_12_1 [get_bd_ports mb_intr_12] [get_bd_pins sys_concat_intc/In6]
  connect_bd_net -net mb_intr_13_1 [get_bd_ports mb_intr_13] [get_bd_pins sys_concat_intc/In7]
  connect_bd_net -net mb_intr_14_1 [get_bd_ports mb_intr_14] [get_bd_pins sys_concat_intc/In8]
  connect_bd_net -net mb_intr_15_1 [get_bd_ports mb_intr_15] [get_bd_pins sys_concat_intc/In9]
  connect_bd_net -net reset_button_1 [get_bd_ports aurora_reset_button] [get_bd_pins aurora_8b10b_0/gt_reset]
  connect_bd_net -net rx_1 [get_bd_ports uart_sin] [get_bd_pins axi_uartlite_0/rx]
  connect_bd_net -net sim_data_probe_0_axis_tdata [get_bd_pins aurora_8b10b_1/s_axi_tx_tdata] [get_bd_pins sim_data_probe_0/axis_tdata]
  connect_bd_net -net sim_data_probe_0_axis_tvalid [get_bd_pins aurora_8b10b_1/s_axi_tx_tvalid] [get_bd_pins sim_data_probe_0/axis_tvalid]
  connect_bd_net -net sys_concat_intc_dout [get_bd_pins axi_intc/intr] [get_bd_pins sys_concat_intc/dout]
  connect_bd_net -net sys_cpu_clk [get_bd_pins BeamformerIP_0/fifo_axis_aclk] [get_bd_pins BeamformerIP_0/m00_axi_aclk] [get_bd_pins BeamformerIP_0/s00_axi_aclk] [get_bd_pins ScanConverterIP_0/m00_axi_aclk] [get_bd_pins ScanConverterIP_0/s00_axi_aclk] [get_bd_pins axi_clkgen_0/s_axi_aclk] [get_bd_pins axi_cpu_interconnect/ACLK] [get_bd_pins axi_cpu_interconnect/M00_ACLK] [get_bd_pins axi_cpu_interconnect/M01_ACLK] [get_bd_pins axi_cpu_interconnect/M02_ACLK] [get_bd_pins axi_cpu_interconnect/M03_ACLK] [get_bd_pins axi_cpu_interconnect/M04_ACLK] [get_bd_pins axi_cpu_interconnect/M05_ACLK] [get_bd_pins axi_cpu_interconnect/M06_ACLK] [get_bd_pins axi_cpu_interconnect/M07_ACLK] [get_bd_pins axi_cpu_interconnect/M08_ACLK] [get_bd_pins axi_cpu_interconnect/M09_ACLK] [get_bd_pins axi_cpu_interconnect/M10_ACLK] [get_bd_pins axi_cpu_interconnect/M11_ACLK] [get_bd_pins axi_cpu_interconnect/M12_ACLK] [get_bd_pins axi_cpu_interconnect/M13_ACLK] [get_bd_pins axi_cpu_interconnect/M14_ACLK] [get_bd_pins axi_cpu_interconnect/S00_ACLK] [get_bd_pins axi_cpu_interconnect/S01_ACLK] [get_bd_pins axi_cpu_interconnect/S02_ACLK] [get_bd_pins axi_cpu_interconnect/S03_ACLK] [get_bd_pins axi_cpu_interconnect/S04_ACLK] [get_bd_pins axi_cpu_interconnect/S05_ACLK] [get_bd_pins axi_cpu_interconnect/S06_ACLK] [get_bd_pins axi_ddr_cntrl/addn_ui_clkout1] [get_bd_pins axi_ethernet_0/axis_clk] [get_bd_pins axi_ethernet_0/s_axi_lite_clk] [get_bd_pins axi_ethernet_dma/m_axi_mm2s_aclk] [get_bd_pins axi_ethernet_dma/m_axi_s2mm_aclk] [get_bd_pins axi_ethernet_dma/m_axi_sg_aclk] [get_bd_pins axi_ethernet_dma/s_axi_lite_aclk] [get_bd_pins axi_gpio_0/s_axi_aclk] [get_bd_pins axi_hdmi_tx_0/s_axi_aclk] [get_bd_pins axi_hdmi_tx_0/vdma_clk] [get_bd_pins axi_iic_0/s_axi_aclk] [get_bd_pins axi_intc/s_axi_aclk] [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins axi_interconnect_0/S01_ACLK] [get_bd_pins axi_interconnect_0/S02_ACLK] [get_bd_pins axi_interconnect_0/S03_ACLK] [get_bd_pins axi_quad_spi_0/s_axi_aclk] [get_bd_pins axi_timer/s_axi_aclk] [get_bd_pins axi_uartlite_0/s_axi_aclk] [get_bd_pins axi_vdma_0/m_axi_mm2s_aclk] [get_bd_pins axi_vdma_0/m_axis_mm2s_aclk] [get_bd_pins axi_vdma_0/s_axi_lite_aclk] [get_bd_pins axis_data_fifo_0/m_axis_aclk] [get_bd_pins ila_0/clk] [get_bd_pins microblaze_0_local_memory/LMB_Clk] [get_bd_pins sys_mb/Clk] [get_bd_pins sys_mb_debug/S_AXI_ACLK] [get_bd_pins sys_rstgen/slowest_sync_clk]
  connect_bd_net -net sys_cpu_reset [get_bd_pins sys_rstgen/peripheral_reset]
  connect_bd_net -net sys_cpu_resetn [get_bd_ports phy_rst_n] [get_bd_pins BeamformerIP_0/fifo_axis_aresetn] [get_bd_pins BeamformerIP_0/m00_axi_aresetn] [get_bd_pins BeamformerIP_0/s00_axi_aresetn] [get_bd_pins ScanConverterIP_0/m00_axi_aresetn] [get_bd_pins ScanConverterIP_0/s00_axi_aresetn] [get_bd_pins axi_clkgen_0/s_axi_aresetn] [get_bd_pins axi_cpu_interconnect/ARESETN] [get_bd_pins axi_cpu_interconnect/M00_ARESETN] [get_bd_pins axi_cpu_interconnect/M01_ARESETN] [get_bd_pins axi_cpu_interconnect/M02_ARESETN] [get_bd_pins axi_cpu_interconnect/M03_ARESETN] [get_bd_pins axi_cpu_interconnect/M04_ARESETN] [get_bd_pins axi_cpu_interconnect/M05_ARESETN] [get_bd_pins axi_cpu_interconnect/M06_ARESETN] [get_bd_pins axi_cpu_interconnect/M07_ARESETN] [get_bd_pins axi_cpu_interconnect/M08_ARESETN] [get_bd_pins axi_cpu_interconnect/M09_ARESETN] [get_bd_pins axi_cpu_interconnect/M10_ARESETN] [get_bd_pins axi_cpu_interconnect/M11_ARESETN] [get_bd_pins axi_cpu_interconnect/M12_ARESETN] [get_bd_pins axi_cpu_interconnect/M13_ARESETN] [get_bd_pins axi_cpu_interconnect/M14_ARESETN] [get_bd_pins axi_cpu_interconnect/S00_ARESETN] [get_bd_pins axi_cpu_interconnect/S01_ARESETN] [get_bd_pins axi_cpu_interconnect/S02_ARESETN] [get_bd_pins axi_cpu_interconnect/S03_ARESETN] [get_bd_pins axi_cpu_interconnect/S04_ARESETN] [get_bd_pins axi_cpu_interconnect/S05_ARESETN] [get_bd_pins axi_cpu_interconnect/S06_ARESETN] [get_bd_pins axi_ethernet_0/s_axi_lite_resetn] [get_bd_pins axi_ethernet_dma/axi_resetn] [get_bd_pins axi_gpio_0/s_axi_aresetn] [get_bd_pins axi_hdmi_tx_0/s_axi_aresetn] [get_bd_pins axi_iic_0/s_axi_aresetn] [get_bd_pins axi_intc/s_axi_aresetn] [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins axi_interconnect_0/S01_ARESETN] [get_bd_pins axi_interconnect_0/S02_ARESETN] [get_bd_pins axi_interconnect_0/S03_ARESETN] [get_bd_pins axi_quad_spi_0/s_axi_aresetn] [get_bd_pins axi_timer/s_axi_aresetn] [get_bd_pins axi_uartlite_0/s_axi_aresetn] [get_bd_pins axi_vdma_0/axi_resetn] [get_bd_pins axis_data_fifo_0/m_axis_aresetn] [get_bd_pins sys_mb_debug/S_AXI_ARESETN] [get_bd_pins sys_rstgen/peripheral_aresetn]
  connect_bd_net -net sys_mb_debug_Debug_SYS_Rst [get_bd_pins sys_mb_debug/Debug_SYS_Rst] [get_bd_pins sys_rstgen/mb_debug_sys_rst]
  connect_bd_net -net sys_mem_clk [get_bd_pins axi_ddr_cntrl/c0_ddr4_ui_clk] [get_bd_pins axi_ddr_cntrl_rstgen/slowest_sync_clk] [get_bd_pins axi_interconnect_0/M00_ACLK]
  connect_bd_net -net sys_mem_resetn [get_bd_pins axi_ddr_cntrl/c0_ddr4_aresetn] [get_bd_pins axi_ddr_cntrl_rstgen/peripheral_aresetn] [get_bd_pins axi_interconnect_0/M00_ARESETN]
  connect_bd_net -net sys_rst_1 [get_bd_ports sys_rst] [get_bd_pins aurora_8b10b_0/rx_system_reset] [get_bd_pins aurora_8b10b_1/tx_system_reset] [get_bd_pins axi_ddr_cntrl/sys_rst]
  connect_bd_net -net sys_rstgen_mb_reset [get_bd_pins microblaze_0_local_memory/SYS_Rst] [get_bd_pins sys_mb/Reset] [get_bd_pins sys_rstgen/mb_reset]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins sim_data_probe_0/reset] [get_bd_pins util_vector_logic_0/Res]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins aurora_8b10b_0/loopback] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins aurora_8b10b_0/power_down] [get_bd_pins xlconstant_1/dout]
  connect_bd_net -net xlconstant_2_dout [get_bd_pins axi_quad_spi_0/gsr] [get_bd_pins axi_quad_spi_0/gts] [get_bd_pins axi_quad_spi_0/usrcclkts] [get_bd_pins xlconstant_2/dout]
  connect_bd_net -net xlconstant_3_dout [get_bd_pins axi_quad_spi_0/keyclearb] [get_bd_pins axi_quad_spi_0/usrdoneo] [get_bd_pins axi_quad_spi_0/usrdonets] [get_bd_pins xlconstant_3/dout]
  connect_bd_net -net xlconstant_4_dout [get_bd_pins axi_ethernet_0/signal_detect] [get_bd_pins xlconstant_4/dout]
  connect_bd_net -net xlconstant_5_dout [get_bd_pins aurora_8b10b_1/s_axi_tx_tlast] [get_bd_pins xlconstant_5/dout]
  connect_bd_net -net xlconstant_6_dout [get_bd_pins aurora_8b10b_1/s_axi_tx_tkeep] [get_bd_pins xlconstant_6/dout]
  connect_bd_net -net xlconstant_7_dout [get_bd_pins aurora_8b10b_1/power_down] [get_bd_pins xlconstant_7/dout]
  connect_bd_net -net xlconstant_8_dout [get_bd_pins aurora_8b10b_1/loopback] [get_bd_pins xlconstant_8/dout]

  # Create address segments
  create_bd_addr_seg -range 0x00010000 -offset 0x44A00000 [get_bd_addr_spaces BeamformerIP_0/m00_axi] [get_bd_addr_segs BeamformerIP_0/s00_axi/reg0] SEG_BeamformerIP_0_reg0
  create_bd_addr_seg -range 0x00010000 -offset 0x44A50000 [get_bd_addr_spaces BeamformerIP_0/m00_axi] [get_bd_addr_segs ScanConverterIP_0/s00_axi/reg0] SEG_ScanConverterIP_0_reg0
  create_bd_addr_seg -range 0x00010000 -offset 0x44A40000 [get_bd_addr_spaces BeamformerIP_0/m00_axi] [get_bd_addr_segs axi_clkgen_0/s_axi/axi_lite] SEG_axi_clkgen_0_axi_lite
  create_bd_addr_seg -range 0x80000000 -offset 0x80000000 [get_bd_addr_spaces BeamformerIP_0/m00_axi] [get_bd_addr_segs axi_ddr_cntrl/C0_DDR4_MEMORY_MAP/C0_DDR4_ADDRESS_BLOCK] SEG_axi_ddr_cntrl_C0_DDR4_ADDRESS_BLOCK
  create_bd_addr_seg -range 0x00040000 -offset 0x40C00000 [get_bd_addr_spaces BeamformerIP_0/m00_axi] [get_bd_addr_segs axi_ethernet_0/s_axi/Reg0] SEG_axi_ethernet_0_Reg0
  create_bd_addr_seg -range 0x00010000 -offset 0x41E00000 [get_bd_addr_spaces BeamformerIP_0/m00_axi] [get_bd_addr_segs axi_ethernet_dma/S_AXI_LITE/Reg] SEG_axi_ethernet_dma_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x40000000 [get_bd_addr_spaces BeamformerIP_0/m00_axi] [get_bd_addr_segs axi_gpio_0/S_AXI/Reg] SEG_axi_gpio_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44A30000 [get_bd_addr_spaces BeamformerIP_0/m00_axi] [get_bd_addr_segs axi_hdmi_tx_0/s_axi/axi_lite] SEG_axi_hdmi_tx_0_axi_lite
  create_bd_addr_seg -range 0x00010000 -offset 0x40800000 [get_bd_addr_spaces BeamformerIP_0/m00_axi] [get_bd_addr_segs axi_iic_0/S_AXI/Reg] SEG_axi_iic_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x41200000 [get_bd_addr_spaces BeamformerIP_0/m00_axi] [get_bd_addr_segs axi_intc/s_axi/Reg] SEG_axi_intc_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44A10000 [get_bd_addr_spaces BeamformerIP_0/m00_axi] [get_bd_addr_segs axi_quad_spi_0/AXI_LITE/Reg] SEG_axi_quad_spi_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x41C00000 [get_bd_addr_spaces BeamformerIP_0/m00_axi] [get_bd_addr_segs axi_timer/S_AXI/Reg] SEG_axi_timer_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x40600000 [get_bd_addr_spaces BeamformerIP_0/m00_axi] [get_bd_addr_segs axi_uartlite_0/S_AXI/Reg] SEG_axi_uartlite_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44A20000 [get_bd_addr_spaces BeamformerIP_0/m00_axi] [get_bd_addr_segs axi_vdma_0/S_AXI_LITE/Reg] SEG_axi_vdma_0_Reg
  create_bd_addr_seg -range 0x00001000 -offset 0x41400000 [get_bd_addr_spaces BeamformerIP_0/m00_axi] [get_bd_addr_segs sys_mb_debug/S_AXI/Reg] SEG_sys_mb_debug_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44A00000 [get_bd_addr_spaces ScanConverterIP_0/m00_axi] [get_bd_addr_segs BeamformerIP_0/s00_axi/reg0] SEG_BeamformerIP_0_reg0
  create_bd_addr_seg -range 0x00010000 -offset 0x44A50000 [get_bd_addr_spaces ScanConverterIP_0/m00_axi] [get_bd_addr_segs ScanConverterIP_0/s00_axi/reg0] SEG_ScanConverterIP_0_reg0
  create_bd_addr_seg -range 0x00010000 -offset 0x44A40000 [get_bd_addr_spaces ScanConverterIP_0/m00_axi] [get_bd_addr_segs axi_clkgen_0/s_axi/axi_lite] SEG_axi_clkgen_0_axi_lite
  create_bd_addr_seg -range 0x80000000 -offset 0x80000000 [get_bd_addr_spaces ScanConverterIP_0/m00_axi] [get_bd_addr_segs axi_ddr_cntrl/C0_DDR4_MEMORY_MAP/C0_DDR4_ADDRESS_BLOCK] SEG_axi_ddr_cntrl_C0_DDR4_ADDRESS_BLOCK
  create_bd_addr_seg -range 0x00040000 -offset 0x40C00000 [get_bd_addr_spaces ScanConverterIP_0/m00_axi] [get_bd_addr_segs axi_ethernet_0/s_axi/Reg0] SEG_axi_ethernet_0_Reg0
  create_bd_addr_seg -range 0x00010000 -offset 0x41E00000 [get_bd_addr_spaces ScanConverterIP_0/m00_axi] [get_bd_addr_segs axi_ethernet_dma/S_AXI_LITE/Reg] SEG_axi_ethernet_dma_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x40000000 [get_bd_addr_spaces ScanConverterIP_0/m00_axi] [get_bd_addr_segs axi_gpio_0/S_AXI/Reg] SEG_axi_gpio_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44A30000 [get_bd_addr_spaces ScanConverterIP_0/m00_axi] [get_bd_addr_segs axi_hdmi_tx_0/s_axi/axi_lite] SEG_axi_hdmi_tx_0_axi_lite
  create_bd_addr_seg -range 0x00010000 -offset 0x40800000 [get_bd_addr_spaces ScanConverterIP_0/m00_axi] [get_bd_addr_segs axi_iic_0/S_AXI/Reg] SEG_axi_iic_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x41200000 [get_bd_addr_spaces ScanConverterIP_0/m00_axi] [get_bd_addr_segs axi_intc/s_axi/Reg] SEG_axi_intc_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44A10000 [get_bd_addr_spaces ScanConverterIP_0/m00_axi] [get_bd_addr_segs axi_quad_spi_0/AXI_LITE/Reg] SEG_axi_quad_spi_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x41C00000 [get_bd_addr_spaces ScanConverterIP_0/m00_axi] [get_bd_addr_segs axi_timer/S_AXI/Reg] SEG_axi_timer_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x40600000 [get_bd_addr_spaces ScanConverterIP_0/m00_axi] [get_bd_addr_segs axi_uartlite_0/S_AXI/Reg] SEG_axi_uartlite_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44A20000 [get_bd_addr_spaces ScanConverterIP_0/m00_axi] [get_bd_addr_segs axi_vdma_0/S_AXI_LITE/Reg] SEG_axi_vdma_0_Reg
  create_bd_addr_seg -range 0x00001000 -offset 0x41400000 [get_bd_addr_spaces ScanConverterIP_0/m00_axi] [get_bd_addr_segs sys_mb_debug/S_AXI/Reg] SEG_sys_mb_debug_Reg
  create_bd_addr_seg -range 0x80000000 -offset 0x80000000 [get_bd_addr_spaces axi_ethernet_dma/Data_SG] [get_bd_addr_segs axi_ddr_cntrl/C0_DDR4_MEMORY_MAP/C0_DDR4_ADDRESS_BLOCK] SEG_axi_ddr_cntrl_C0_DDR4_ADDRESS_BLOCK
  create_bd_addr_seg -range 0x80000000 -offset 0x80000000 [get_bd_addr_spaces axi_ethernet_dma/Data_MM2S] [get_bd_addr_segs axi_ddr_cntrl/C0_DDR4_MEMORY_MAP/C0_DDR4_ADDRESS_BLOCK] SEG_axi_ddr_cntrl_C0_DDR4_ADDRESS_BLOCK
  create_bd_addr_seg -range 0x80000000 -offset 0x80000000 [get_bd_addr_spaces axi_ethernet_dma/Data_S2MM] [get_bd_addr_segs axi_ddr_cntrl/C0_DDR4_MEMORY_MAP/C0_DDR4_ADDRESS_BLOCK] SEG_axi_ddr_cntrl_C0_DDR4_ADDRESS_BLOCK
  create_bd_addr_seg -range 0x00040000 -offset 0x40C00000 [get_bd_addr_spaces axi_ethernet_dma/Data_SG] [get_bd_addr_segs axi_ethernet_0/s_axi/Reg0] SEG_axi_ethernet_0_Reg0
  create_bd_addr_seg -range 0x00040000 -offset 0x40C00000 [get_bd_addr_spaces axi_ethernet_dma/Data_MM2S] [get_bd_addr_segs axi_ethernet_0/s_axi/Reg0] SEG_axi_ethernet_0_Reg0
  create_bd_addr_seg -range 0x00040000 -offset 0x40C00000 [get_bd_addr_spaces axi_ethernet_dma/Data_S2MM] [get_bd_addr_segs axi_ethernet_0/s_axi/Reg0] SEG_axi_ethernet_0_Reg0
  create_bd_addr_seg -range 0x00010000 -offset 0x41E00000 [get_bd_addr_spaces axi_ethernet_dma/Data_SG] [get_bd_addr_segs axi_ethernet_dma/S_AXI_LITE/Reg] SEG_axi_ethernet_dma_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x41E00000 [get_bd_addr_spaces axi_ethernet_dma/Data_MM2S] [get_bd_addr_segs axi_ethernet_dma/S_AXI_LITE/Reg] SEG_axi_ethernet_dma_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x41E00000 [get_bd_addr_spaces axi_ethernet_dma/Data_S2MM] [get_bd_addr_segs axi_ethernet_dma/S_AXI_LITE/Reg] SEG_axi_ethernet_dma_Reg
  create_bd_addr_seg -range 0x80000000 -offset 0x80000000 [get_bd_addr_spaces axi_vdma_0/Data_MM2S] [get_bd_addr_segs axi_ddr_cntrl/C0_DDR4_MEMORY_MAP/C0_DDR4_ADDRESS_BLOCK] SEG_axi_ddr_cntrl_C0_DDR4_ADDRESS_BLOCK
  create_bd_addr_seg -range 0x00010000 -offset 0x44A00000 [get_bd_addr_spaces sys_mb/Data] [get_bd_addr_segs BeamformerIP_0/s00_axi/reg0] SEG_BeamformerIP_0_reg0
  create_bd_addr_seg -range 0x00010000 -offset 0x44A00000 [get_bd_addr_spaces sys_mb/Instruction] [get_bd_addr_segs BeamformerIP_0/s00_axi/reg0] SEG_BeamformerIP_0_reg0
  create_bd_addr_seg -range 0x00010000 -offset 0x44A50000 [get_bd_addr_spaces sys_mb/Data] [get_bd_addr_segs ScanConverterIP_0/s00_axi/reg0] SEG_ScanConverterIP_0_reg0
  create_bd_addr_seg -range 0x00010000 -offset 0x44A50000 [get_bd_addr_spaces sys_mb/Instruction] [get_bd_addr_segs ScanConverterIP_0/s00_axi/reg0] SEG_ScanConverterIP_0_reg0
  create_bd_addr_seg -range 0x00010000 -offset 0x44A40000 [get_bd_addr_spaces sys_mb/Data] [get_bd_addr_segs axi_clkgen_0/s_axi/axi_lite] SEG_axi_clkgen_0_axi_lite
  create_bd_addr_seg -range 0x00010000 -offset 0x44A40000 [get_bd_addr_spaces sys_mb/Instruction] [get_bd_addr_segs axi_clkgen_0/s_axi/axi_lite] SEG_axi_clkgen_0_axi_lite
  create_bd_addr_seg -range 0x80000000 -offset 0x80000000 [get_bd_addr_spaces sys_mb/Data] [get_bd_addr_segs axi_ddr_cntrl/C0_DDR4_MEMORY_MAP/C0_DDR4_ADDRESS_BLOCK] SEG_axi_ddr_cntrl_C0_DDR4_ADDRESS_BLOCK
  create_bd_addr_seg -range 0x80000000 -offset 0x80000000 [get_bd_addr_spaces sys_mb/Instruction] [get_bd_addr_segs axi_ddr_cntrl/C0_DDR4_MEMORY_MAP/C0_DDR4_ADDRESS_BLOCK] SEG_axi_ddr_cntrl_C0_DDR4_ADDRESS_BLOCK
  create_bd_addr_seg -range 0x00040000 -offset 0x40C00000 [get_bd_addr_spaces sys_mb/Data] [get_bd_addr_segs axi_ethernet_0/s_axi/Reg0] SEG_axi_ethernet_0_Reg0
  create_bd_addr_seg -range 0x00040000 -offset 0x40C00000 [get_bd_addr_spaces sys_mb/Instruction] [get_bd_addr_segs axi_ethernet_0/s_axi/Reg0] SEG_axi_ethernet_0_Reg0
  create_bd_addr_seg -range 0x00010000 -offset 0x41E00000 [get_bd_addr_spaces sys_mb/Data] [get_bd_addr_segs axi_ethernet_dma/S_AXI_LITE/Reg] SEG_axi_ethernet_dma_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x41E00000 [get_bd_addr_spaces sys_mb/Instruction] [get_bd_addr_segs axi_ethernet_dma/S_AXI_LITE/Reg] SEG_axi_ethernet_dma_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x40000000 [get_bd_addr_spaces sys_mb/Data] [get_bd_addr_segs axi_gpio_0/S_AXI/Reg] SEG_axi_gpio_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x40000000 [get_bd_addr_spaces sys_mb/Instruction] [get_bd_addr_segs axi_gpio_0/S_AXI/Reg] SEG_axi_gpio_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44A30000 [get_bd_addr_spaces sys_mb/Data] [get_bd_addr_segs axi_hdmi_tx_0/s_axi/axi_lite] SEG_axi_hdmi_tx_0_axi_lite
  create_bd_addr_seg -range 0x00010000 -offset 0x44A30000 [get_bd_addr_spaces sys_mb/Instruction] [get_bd_addr_segs axi_hdmi_tx_0/s_axi/axi_lite] SEG_axi_hdmi_tx_0_axi_lite
  create_bd_addr_seg -range 0x00010000 -offset 0x40800000 [get_bd_addr_spaces sys_mb/Data] [get_bd_addr_segs axi_iic_0/S_AXI/Reg] SEG_axi_iic_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x40800000 [get_bd_addr_spaces sys_mb/Instruction] [get_bd_addr_segs axi_iic_0/S_AXI/Reg] SEG_axi_iic_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x41200000 [get_bd_addr_spaces sys_mb/Data] [get_bd_addr_segs axi_intc/s_axi/Reg] SEG_axi_intc_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x41200000 [get_bd_addr_spaces sys_mb/Instruction] [get_bd_addr_segs axi_intc/s_axi/Reg] SEG_axi_intc_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44A10000 [get_bd_addr_spaces sys_mb/Data] [get_bd_addr_segs axi_quad_spi_0/AXI_LITE/Reg] SEG_axi_quad_spi_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44A10000 [get_bd_addr_spaces sys_mb/Instruction] [get_bd_addr_segs axi_quad_spi_0/AXI_LITE/Reg] SEG_axi_quad_spi_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x41C00000 [get_bd_addr_spaces sys_mb/Data] [get_bd_addr_segs axi_timer/S_AXI/Reg] SEG_axi_timer_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x41C00000 [get_bd_addr_spaces sys_mb/Instruction] [get_bd_addr_segs axi_timer/S_AXI/Reg] SEG_axi_timer_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x40600000 [get_bd_addr_spaces sys_mb/Data] [get_bd_addr_segs axi_uartlite_0/S_AXI/Reg] SEG_axi_uartlite_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x40600000 [get_bd_addr_spaces sys_mb/Instruction] [get_bd_addr_segs axi_uartlite_0/S_AXI/Reg] SEG_axi_uartlite_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44A20000 [get_bd_addr_spaces sys_mb/Data] [get_bd_addr_segs axi_vdma_0/S_AXI_LITE/Reg] SEG_axi_vdma_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44A20000 [get_bd_addr_spaces sys_mb/Instruction] [get_bd_addr_segs axi_vdma_0/S_AXI_LITE/Reg] SEG_axi_vdma_0_Reg
  create_bd_addr_seg -range 0x00008000 -offset 0x00000000 [get_bd_addr_spaces sys_mb/Data] [get_bd_addr_segs microblaze_0_local_memory/dlmb_bram_if_cntlr/SLMB/Mem] SEG_dlmb_bram_if_cntlr_Mem
  create_bd_addr_seg -range 0x00008000 -offset 0x00000000 [get_bd_addr_spaces sys_mb/Instruction] [get_bd_addr_segs microblaze_0_local_memory/ilmb_bram_if_cntlr/SLMB/Mem] SEG_ilmb_bram_if_cntlr_Mem
  create_bd_addr_seg -range 0x00001000 -offset 0x41400000 [get_bd_addr_spaces sys_mb/Data] [get_bd_addr_segs sys_mb_debug/S_AXI/Reg] SEG_sys_mb_debug_Reg
  create_bd_addr_seg -range 0x00001000 -offset 0x41400000 [get_bd_addr_spaces sys_mb/Instruction] [get_bd_addr_segs sys_mb_debug/S_AXI/Reg] SEG_sys_mb_debug_Reg

  # Exclude Address Segments
  create_bd_addr_seg -range 0x00010000 -offset 0x44A00000 [get_bd_addr_spaces axi_ethernet_dma/Data_MM2S] [get_bd_addr_segs BeamformerIP_0/s00_axi/reg0] SEG_BeamformerIP_0_reg0
  exclude_bd_addr_seg [get_bd_addr_segs axi_ethernet_dma/Data_MM2S/SEG_BeamformerIP_0_reg0]

  create_bd_addr_seg -range 0x00010000 -offset 0x44A50000 [get_bd_addr_spaces axi_ethernet_dma/Data_MM2S] [get_bd_addr_segs ScanConverterIP_0/s00_axi/reg0] SEG_ScanConverterIP_0_reg0
  exclude_bd_addr_seg [get_bd_addr_segs axi_ethernet_dma/Data_MM2S/SEG_ScanConverterIP_0_reg0]

  create_bd_addr_seg -range 0x00010000 -offset 0x44A40000 [get_bd_addr_spaces axi_ethernet_dma/Data_MM2S] [get_bd_addr_segs axi_clkgen_0/s_axi/axi_lite] SEG_axi_clkgen_0_axi_lite
  exclude_bd_addr_seg [get_bd_addr_segs axi_ethernet_dma/Data_MM2S/SEG_axi_clkgen_0_axi_lite]

  create_bd_addr_seg -range 0x00010000 -offset 0x40000000 [get_bd_addr_spaces axi_ethernet_dma/Data_MM2S] [get_bd_addr_segs axi_gpio_0/S_AXI/Reg] SEG_axi_gpio_0_Reg
  exclude_bd_addr_seg [get_bd_addr_segs axi_ethernet_dma/Data_MM2S/SEG_axi_gpio_0_Reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x44A30000 [get_bd_addr_spaces axi_ethernet_dma/Data_MM2S] [get_bd_addr_segs axi_hdmi_tx_0/s_axi/axi_lite] SEG_axi_hdmi_tx_0_axi_lite
  exclude_bd_addr_seg [get_bd_addr_segs axi_ethernet_dma/Data_MM2S/SEG_axi_hdmi_tx_0_axi_lite]

  create_bd_addr_seg -range 0x00010000 -offset 0x40800000 [get_bd_addr_spaces axi_ethernet_dma/Data_MM2S] [get_bd_addr_segs axi_iic_0/S_AXI/Reg] SEG_axi_iic_0_Reg
  exclude_bd_addr_seg [get_bd_addr_segs axi_ethernet_dma/Data_MM2S/SEG_axi_iic_0_Reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x41200000 [get_bd_addr_spaces axi_ethernet_dma/Data_MM2S] [get_bd_addr_segs axi_intc/s_axi/Reg] SEG_axi_intc_Reg
  exclude_bd_addr_seg [get_bd_addr_segs axi_ethernet_dma/Data_MM2S/SEG_axi_intc_Reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x44A10000 [get_bd_addr_spaces axi_ethernet_dma/Data_MM2S] [get_bd_addr_segs axi_quad_spi_0/AXI_LITE/Reg] SEG_axi_quad_spi_0_Reg
  exclude_bd_addr_seg [get_bd_addr_segs axi_ethernet_dma/Data_MM2S/SEG_axi_quad_spi_0_Reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x41C00000 [get_bd_addr_spaces axi_ethernet_dma/Data_MM2S] [get_bd_addr_segs axi_timer/S_AXI/Reg] SEG_axi_timer_Reg
  exclude_bd_addr_seg [get_bd_addr_segs axi_ethernet_dma/Data_MM2S/SEG_axi_timer_Reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x40600000 [get_bd_addr_spaces axi_ethernet_dma/Data_MM2S] [get_bd_addr_segs axi_uartlite_0/S_AXI/Reg] SEG_axi_uartlite_0_Reg
  exclude_bd_addr_seg [get_bd_addr_segs axi_ethernet_dma/Data_MM2S/SEG_axi_uartlite_0_Reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x44A20000 [get_bd_addr_spaces axi_ethernet_dma/Data_MM2S] [get_bd_addr_segs axi_vdma_0/S_AXI_LITE/Reg] SEG_axi_vdma_0_Reg
  exclude_bd_addr_seg [get_bd_addr_segs axi_ethernet_dma/Data_MM2S/SEG_axi_vdma_0_Reg]

  create_bd_addr_seg -range 0x00001000 -offset 0x41400000 [get_bd_addr_spaces axi_ethernet_dma/Data_MM2S] [get_bd_addr_segs sys_mb_debug/S_AXI/Reg] SEG_sys_mb_debug_Reg
  exclude_bd_addr_seg [get_bd_addr_segs axi_ethernet_dma/Data_MM2S/SEG_sys_mb_debug_Reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x44A00000 [get_bd_addr_spaces axi_ethernet_dma/Data_S2MM] [get_bd_addr_segs BeamformerIP_0/s00_axi/reg0] SEG_BeamformerIP_0_reg0
  exclude_bd_addr_seg [get_bd_addr_segs axi_ethernet_dma/Data_S2MM/SEG_BeamformerIP_0_reg0]

  create_bd_addr_seg -range 0x00010000 -offset 0x44A50000 [get_bd_addr_spaces axi_ethernet_dma/Data_S2MM] [get_bd_addr_segs ScanConverterIP_0/s00_axi/reg0] SEG_ScanConverterIP_0_reg0
  exclude_bd_addr_seg [get_bd_addr_segs axi_ethernet_dma/Data_S2MM/SEG_ScanConverterIP_0_reg0]

  create_bd_addr_seg -range 0x00010000 -offset 0x44A40000 [get_bd_addr_spaces axi_ethernet_dma/Data_S2MM] [get_bd_addr_segs axi_clkgen_0/s_axi/axi_lite] SEG_axi_clkgen_0_axi_lite
  exclude_bd_addr_seg [get_bd_addr_segs axi_ethernet_dma/Data_S2MM/SEG_axi_clkgen_0_axi_lite]

  create_bd_addr_seg -range 0x00010000 -offset 0x40000000 [get_bd_addr_spaces axi_ethernet_dma/Data_S2MM] [get_bd_addr_segs axi_gpio_0/S_AXI/Reg] SEG_axi_gpio_0_Reg
  exclude_bd_addr_seg [get_bd_addr_segs axi_ethernet_dma/Data_S2MM/SEG_axi_gpio_0_Reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x44A30000 [get_bd_addr_spaces axi_ethernet_dma/Data_S2MM] [get_bd_addr_segs axi_hdmi_tx_0/s_axi/axi_lite] SEG_axi_hdmi_tx_0_axi_lite
  exclude_bd_addr_seg [get_bd_addr_segs axi_ethernet_dma/Data_S2MM/SEG_axi_hdmi_tx_0_axi_lite]

  create_bd_addr_seg -range 0x00010000 -offset 0x40800000 [get_bd_addr_spaces axi_ethernet_dma/Data_S2MM] [get_bd_addr_segs axi_iic_0/S_AXI/Reg] SEG_axi_iic_0_Reg
  exclude_bd_addr_seg [get_bd_addr_segs axi_ethernet_dma/Data_S2MM/SEG_axi_iic_0_Reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x41200000 [get_bd_addr_spaces axi_ethernet_dma/Data_S2MM] [get_bd_addr_segs axi_intc/s_axi/Reg] SEG_axi_intc_Reg
  exclude_bd_addr_seg [get_bd_addr_segs axi_ethernet_dma/Data_S2MM/SEG_axi_intc_Reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x44A10000 [get_bd_addr_spaces axi_ethernet_dma/Data_S2MM] [get_bd_addr_segs axi_quad_spi_0/AXI_LITE/Reg] SEG_axi_quad_spi_0_Reg
  exclude_bd_addr_seg [get_bd_addr_segs axi_ethernet_dma/Data_S2MM/SEG_axi_quad_spi_0_Reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x41C00000 [get_bd_addr_spaces axi_ethernet_dma/Data_S2MM] [get_bd_addr_segs axi_timer/S_AXI/Reg] SEG_axi_timer_Reg
  exclude_bd_addr_seg [get_bd_addr_segs axi_ethernet_dma/Data_S2MM/SEG_axi_timer_Reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x40600000 [get_bd_addr_spaces axi_ethernet_dma/Data_S2MM] [get_bd_addr_segs axi_uartlite_0/S_AXI/Reg] SEG_axi_uartlite_0_Reg
  exclude_bd_addr_seg [get_bd_addr_segs axi_ethernet_dma/Data_S2MM/SEG_axi_uartlite_0_Reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x44A20000 [get_bd_addr_spaces axi_ethernet_dma/Data_S2MM] [get_bd_addr_segs axi_vdma_0/S_AXI_LITE/Reg] SEG_axi_vdma_0_Reg
  exclude_bd_addr_seg [get_bd_addr_segs axi_ethernet_dma/Data_S2MM/SEG_axi_vdma_0_Reg]

  create_bd_addr_seg -range 0x00001000 -offset 0x41400000 [get_bd_addr_spaces axi_ethernet_dma/Data_S2MM] [get_bd_addr_segs sys_mb_debug/S_AXI/Reg] SEG_sys_mb_debug_Reg
  exclude_bd_addr_seg [get_bd_addr_segs axi_ethernet_dma/Data_S2MM/SEG_sys_mb_debug_Reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x44A00000 [get_bd_addr_spaces axi_ethernet_dma/Data_SG] [get_bd_addr_segs BeamformerIP_0/s00_axi/reg0] SEG_BeamformerIP_0_reg0
  exclude_bd_addr_seg [get_bd_addr_segs axi_ethernet_dma/Data_SG/SEG_BeamformerIP_0_reg0]

  create_bd_addr_seg -range 0x00010000 -offset 0x44A50000 [get_bd_addr_spaces axi_ethernet_dma/Data_SG] [get_bd_addr_segs ScanConverterIP_0/s00_axi/reg0] SEG_ScanConverterIP_0_reg0
  exclude_bd_addr_seg [get_bd_addr_segs axi_ethernet_dma/Data_SG/SEG_ScanConverterIP_0_reg0]

  create_bd_addr_seg -range 0x00010000 -offset 0x44A40000 [get_bd_addr_spaces axi_ethernet_dma/Data_SG] [get_bd_addr_segs axi_clkgen_0/s_axi/axi_lite] SEG_axi_clkgen_0_axi_lite
  exclude_bd_addr_seg [get_bd_addr_segs axi_ethernet_dma/Data_SG/SEG_axi_clkgen_0_axi_lite]

  create_bd_addr_seg -range 0x00010000 -offset 0x40000000 [get_bd_addr_spaces axi_ethernet_dma/Data_SG] [get_bd_addr_segs axi_gpio_0/S_AXI/Reg] SEG_axi_gpio_0_Reg
  exclude_bd_addr_seg [get_bd_addr_segs axi_ethernet_dma/Data_SG/SEG_axi_gpio_0_Reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x44A30000 [get_bd_addr_spaces axi_ethernet_dma/Data_SG] [get_bd_addr_segs axi_hdmi_tx_0/s_axi/axi_lite] SEG_axi_hdmi_tx_0_axi_lite
  exclude_bd_addr_seg [get_bd_addr_segs axi_ethernet_dma/Data_SG/SEG_axi_hdmi_tx_0_axi_lite]

  create_bd_addr_seg -range 0x00010000 -offset 0x40800000 [get_bd_addr_spaces axi_ethernet_dma/Data_SG] [get_bd_addr_segs axi_iic_0/S_AXI/Reg] SEG_axi_iic_0_Reg
  exclude_bd_addr_seg [get_bd_addr_segs axi_ethernet_dma/Data_SG/SEG_axi_iic_0_Reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x41200000 [get_bd_addr_spaces axi_ethernet_dma/Data_SG] [get_bd_addr_segs axi_intc/s_axi/Reg] SEG_axi_intc_Reg
  exclude_bd_addr_seg [get_bd_addr_segs axi_ethernet_dma/Data_SG/SEG_axi_intc_Reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x44A10000 [get_bd_addr_spaces axi_ethernet_dma/Data_SG] [get_bd_addr_segs axi_quad_spi_0/AXI_LITE/Reg] SEG_axi_quad_spi_0_Reg
  exclude_bd_addr_seg [get_bd_addr_segs axi_ethernet_dma/Data_SG/SEG_axi_quad_spi_0_Reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x41C00000 [get_bd_addr_spaces axi_ethernet_dma/Data_SG] [get_bd_addr_segs axi_timer/S_AXI/Reg] SEG_axi_timer_Reg
  exclude_bd_addr_seg [get_bd_addr_segs axi_ethernet_dma/Data_SG/SEG_axi_timer_Reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x40600000 [get_bd_addr_spaces axi_ethernet_dma/Data_SG] [get_bd_addr_segs axi_uartlite_0/S_AXI/Reg] SEG_axi_uartlite_0_Reg
  exclude_bd_addr_seg [get_bd_addr_segs axi_ethernet_dma/Data_SG/SEG_axi_uartlite_0_Reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x44A20000 [get_bd_addr_spaces axi_ethernet_dma/Data_SG] [get_bd_addr_segs axi_vdma_0/S_AXI_LITE/Reg] SEG_axi_vdma_0_Reg
  exclude_bd_addr_seg [get_bd_addr_segs axi_ethernet_dma/Data_SG/SEG_axi_vdma_0_Reg]

  create_bd_addr_seg -range 0x00001000 -offset 0x41400000 [get_bd_addr_spaces axi_ethernet_dma/Data_SG] [get_bd_addr_segs sys_mb_debug/S_AXI/Reg] SEG_sys_mb_debug_Reg
  exclude_bd_addr_seg [get_bd_addr_segs axi_ethernet_dma/Data_SG/SEG_sys_mb_debug_Reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x44A00000 [get_bd_addr_spaces axi_vdma_0/Data_MM2S] [get_bd_addr_segs BeamformerIP_0/s00_axi/reg0] SEG_BeamformerIP_0_reg0
  exclude_bd_addr_seg [get_bd_addr_segs axi_vdma_0/Data_MM2S/SEG_BeamformerIP_0_reg0]

  create_bd_addr_seg -range 0x00010000 -offset 0x44A50000 [get_bd_addr_spaces axi_vdma_0/Data_MM2S] [get_bd_addr_segs ScanConverterIP_0/s00_axi/reg0] SEG_ScanConverterIP_0_reg0
  exclude_bd_addr_seg [get_bd_addr_segs axi_vdma_0/Data_MM2S/SEG_ScanConverterIP_0_reg0]

  create_bd_addr_seg -range 0x00010000 -offset 0x44A40000 [get_bd_addr_spaces axi_vdma_0/Data_MM2S] [get_bd_addr_segs axi_clkgen_0/s_axi/axi_lite] SEG_axi_clkgen_0_axi_lite
  exclude_bd_addr_seg [get_bd_addr_segs axi_vdma_0/Data_MM2S/SEG_axi_clkgen_0_axi_lite]

  create_bd_addr_seg -range 0x00040000 -offset 0x40C00000 [get_bd_addr_spaces axi_vdma_0/Data_MM2S] [get_bd_addr_segs axi_ethernet_0/s_axi/Reg0] SEG_axi_ethernet_0_Reg0
  exclude_bd_addr_seg [get_bd_addr_segs axi_vdma_0/Data_MM2S/SEG_axi_ethernet_0_Reg0]

  create_bd_addr_seg -range 0x00010000 -offset 0x41E00000 [get_bd_addr_spaces axi_vdma_0/Data_MM2S] [get_bd_addr_segs axi_ethernet_dma/S_AXI_LITE/Reg] SEG_axi_ethernet_dma_Reg
  exclude_bd_addr_seg [get_bd_addr_segs axi_vdma_0/Data_MM2S/SEG_axi_ethernet_dma_Reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x40000000 [get_bd_addr_spaces axi_vdma_0/Data_MM2S] [get_bd_addr_segs axi_gpio_0/S_AXI/Reg] SEG_axi_gpio_0_Reg
  exclude_bd_addr_seg [get_bd_addr_segs axi_vdma_0/Data_MM2S/SEG_axi_gpio_0_Reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x44A30000 [get_bd_addr_spaces axi_vdma_0/Data_MM2S] [get_bd_addr_segs axi_hdmi_tx_0/s_axi/axi_lite] SEG_axi_hdmi_tx_0_axi_lite
  exclude_bd_addr_seg [get_bd_addr_segs axi_vdma_0/Data_MM2S/SEG_axi_hdmi_tx_0_axi_lite]

  create_bd_addr_seg -range 0x00010000 -offset 0x40800000 [get_bd_addr_spaces axi_vdma_0/Data_MM2S] [get_bd_addr_segs axi_iic_0/S_AXI/Reg] SEG_axi_iic_0_Reg
  exclude_bd_addr_seg [get_bd_addr_segs axi_vdma_0/Data_MM2S/SEG_axi_iic_0_Reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x41200000 [get_bd_addr_spaces axi_vdma_0/Data_MM2S] [get_bd_addr_segs axi_intc/s_axi/Reg] SEG_axi_intc_Reg
  exclude_bd_addr_seg [get_bd_addr_segs axi_vdma_0/Data_MM2S/SEG_axi_intc_Reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x44A10000 [get_bd_addr_spaces axi_vdma_0/Data_MM2S] [get_bd_addr_segs axi_quad_spi_0/AXI_LITE/Reg] SEG_axi_quad_spi_0_Reg
  exclude_bd_addr_seg [get_bd_addr_segs axi_vdma_0/Data_MM2S/SEG_axi_quad_spi_0_Reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x41C00000 [get_bd_addr_spaces axi_vdma_0/Data_MM2S] [get_bd_addr_segs axi_timer/S_AXI/Reg] SEG_axi_timer_Reg
  exclude_bd_addr_seg [get_bd_addr_segs axi_vdma_0/Data_MM2S/SEG_axi_timer_Reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x40600000 [get_bd_addr_spaces axi_vdma_0/Data_MM2S] [get_bd_addr_segs axi_uartlite_0/S_AXI/Reg] SEG_axi_uartlite_0_Reg
  exclude_bd_addr_seg [get_bd_addr_segs axi_vdma_0/Data_MM2S/SEG_axi_uartlite_0_Reg]

  create_bd_addr_seg -range 0x00010000 -offset 0x44A20000 [get_bd_addr_spaces axi_vdma_0/Data_MM2S] [get_bd_addr_segs axi_vdma_0/S_AXI_LITE/Reg] SEG_axi_vdma_0_Reg
  exclude_bd_addr_seg [get_bd_addr_segs axi_vdma_0/Data_MM2S/SEG_axi_vdma_0_Reg]

  create_bd_addr_seg -range 0x00001000 -offset 0x41400000 [get_bd_addr_spaces axi_vdma_0/Data_MM2S] [get_bd_addr_segs sys_mb_debug/S_AXI/Reg] SEG_sys_mb_debug_Reg
  exclude_bd_addr_seg [get_bd_addr_segs axi_vdma_0/Data_MM2S/SEG_sys_mb_debug_Reg]


  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.5.12  2016-01-29 bk=1.3547 VDI=39 GEI=35 GUI=JA:1.6
#  -string -flagsOSRD
preplace port hdmi_16_vsync -pg 1 -y 2160 -defaultsOSRD
preplace port uart_sin -pg 1 -y 1250 -defaultsOSRD
preplace port hdmi_16_hsync -pg 1 -y 2140 -defaultsOSRD
preplace port mb_intr_05 -pg 1 -y 1420 -defaultsOSRD
preplace port default_sysclk_300 -pg 1 -y 1300 -defaultsOSRD
preplace port GPIO2 -pg 1 -y -340 -defaultsOSRD
preplace port mb_intr_06 -pg 1 -y 1440 -defaultsOSRD
preplace port GT_SERIAL_RX -pg 1 -y 2480 -defaultsOSRD
preplace port sys_rst -pg 1 -y 570 -defaultsOSRD
preplace port uart_sout -pg 1 -y 870 -defaultsOSRD
preplace port sys_clk -pg 1 -y 1280 -defaultsOSRD
preplace port iic_main -pg 1 -y 1590 -defaultsOSRD
preplace port sgmii -pg 1 -y 580 -defaultsOSRD
preplace port mdio_mdc -pg 1 -y 560 -defaultsOSRD
preplace port mb_intr_12 -pg 1 -y 1460 -defaultsOSRD
preplace port phy_clk -pg 1 -y 770 -defaultsOSRD
preplace port c0_ddr4 -pg 1 -y 890 -defaultsOSRD
preplace port hdmi_16_data_e -pg 1 -y 2180 -defaultsOSRD
preplace port hdmi_out_clk -pg 1 -y 2120 -defaultsOSRD
preplace port mb_intr_13 -pg 1 -y 1480 -defaultsOSRD
preplace port GT_DIFF_REFCLK1 -pg 1 -y 2300 -defaultsOSRD
preplace port mb_intr_14 -pg 1 -y 1500 -defaultsOSRD
preplace port GT_SERIAL_TX -pg 1 -y 2880 -defaultsOSRD
preplace port GPIO -pg 1 -y -370 -defaultsOSRD
preplace port aurora_reset_button -pg 1 -y 2540 -defaultsOSRD
preplace port rx_channel_up -pg 1 -y 2390 -defaultsOSRD
preplace port mb_intr_15 -pg 1 -y 1520 -defaultsOSRD
preplace portBus hdmi_16_data -pg 1 -y 2200 -defaultsOSRD
preplace portBus phy_rst_n -pg 1 -y -90 -defaultsOSRD
preplace inst sim_data_probe_0 -pg 1 -lvl 1 -y 2940 -defaultsOSRD
preplace inst axi_hdmi_tx_0 -pg 1 -lvl 10 -y 2490 -defaultsOSRD
preplace inst axi_vdma_0 -pg 1 -lvl 9 -y 2720 -defaultsOSRD
preplace inst axi_iic_0 -pg 1 -lvl 10 -y 1710 -defaultsOSRD
preplace inst sys_mb_debug -pg 1 -lvl 7 -y 1000 -defaultsOSRD
preplace inst axi_ddr_cntrl -pg 1 -lvl 10 -y 1040 -defaultsOSRD
preplace inst xlconstant_0 -pg 1 -lvl 3 -y 2360 -defaultsOSRD
preplace inst axi_ddr_cntrl_rstgen -pg 1 -lvl 4 -y 90 -defaultsOSRD
preplace inst ScanConverterIP_0 -pg 1 -lvl 10 -y 2770 -defaultsOSRD
preplace inst xlconstant_1 -pg 1 -lvl 2 -y 2380 -defaultsOSRD
preplace inst axi_ethernet_idelayctrl -pg 1 -lvl 4 -y 590 -defaultsOSRD
preplace inst xlconstant_2 -pg 1 -lvl 9 -y 1810 -defaultsOSRD
preplace inst sys_concat_intc -pg 1 -lvl 4 -y 1420 -defaultsOSRD
preplace inst xlconstant_3 -pg 1 -lvl 9 -y 1920 -defaultsOSRD
preplace inst util_vector_logic_0 -pg 1 -lvl 5 -y 2420 -defaultsOSRD
preplace inst axi_gpio_0 -pg 1 -lvl 10 -y -350 -defaultsOSRD
preplace inst axi_timer -pg 1 -lvl 10 -y 180 -defaultsOSRD
preplace inst axi_ethernet_dma -pg 1 -lvl 7 -y 180 -defaultsOSRD
preplace inst axi_ethernet_clkgen -pg 1 -lvl 4 -y 770 -defaultsOSRD
preplace inst xlconstant_4 -pg 1 -lvl 9 -y 580 -defaultsOSRD
preplace inst xlconstant_5 -pg 1 -lvl 3 -y 2670 -defaultsOSRD
preplace inst aurora_8b10b_0 -pg 1 -lvl 4 -y 2470 -defaultsOSRD
preplace inst axi_clkgen_0 -pg 1 -lvl 8 -y 2740 -defaultsOSRD
preplace inst sys_rstgen -pg 1 -lvl 4 -y 250 -defaultsOSRD
preplace inst sys_mb -pg 1 -lvl 7 -y 1180 -defaultsOSRD
preplace inst BeamformerIP_0 -pg 1 -lvl 10 -y 1470 -defaultsOSRD
preplace inst ila_0 -pg 1 -lvl 7 -y 2520 -defaultsOSRD
preplace inst xlconstant_6 -pg 1 -lvl 3 -y 2770 -defaultsOSRD
preplace inst aurora_8b10b_1 -pg 1 -lvl 4 -y 2920 -defaultsOSRD
preplace inst axi_interconnect_0 -pg 1 -lvl 8 -y 2090 -defaultsOSRD
preplace inst xlconstant_7 -pg 1 -lvl 3 -y 2870 -defaultsOSRD
preplace inst axi_uartlite_0 -pg 1 -lvl 10 -y 1250 -defaultsOSRD
preplace inst axi_intc -pg 1 -lvl 4 -y 1810 -defaultsOSRD
preplace inst xlconstant_8 -pg 1 -lvl 3 -y 2970 -defaultsOSRD
preplace inst axi_ethernet_rstgen -pg 1 -lvl 4 -y 430 -defaultsOSRD
preplace inst axi_cpu_interconnect -pg 1 -lvl 8 -y 300 -defaultsOSRD
preplace inst axi_ethernet_0 -pg 1 -lvl 10 -y 640 -defaultsOSRD
preplace inst microblaze_0_local_memory -pg 1 -lvl 7 -y 1430 -defaultsOSRD
preplace inst axis_data_fifo_0 -pg 1 -lvl 6 -y 2480 -defaultsOSRD
preplace inst axi_quad_spi_0 -pg 1 -lvl 10 -y 2000 -defaultsOSRD
preplace netloc axi_ethernet_0_mdio 1 10 1 4030
preplace netloc axi_vdma_0_M_AXI_MM2S 1 7 3 2510 1310 NJ 1310 3360
preplace netloc BeamformerIP_0_fifo_axis_tready 1 6 4 1820 1510 NJ 1440 NJ 1440 NJ
preplace netloc xlconstant_4_dout 1 9 1 3430
preplace netloc sys_clk_1 1 0 10 NJ 1070 NJ 1070 NJ 1070 NJ 1070 NJ 1070 NJ 1070 NJ 1070 NJ 1010 NJ 1010 NJ
preplace netloc axi_ddr_cntrl_addn_ui_clkout2 1 8 2 NJ 2440 NJ
preplace netloc sim_data_probe_0_axis_tvalid 1 1 3 300 2920 NJ 2920 NJ
preplace netloc axi_ddr_cntrl_addn_ui_clkout3 1 3 8 NJ 2720 NJ 2720 NJ 2720 NJ 2720 2280 2880 NJ 2880 NJ 2880 3970
preplace netloc util_vector_logic_0_Res 1 0 6 -30 2620 NJ 2620 NJ 2620 NJ 2620 NJ 2470 1370
preplace netloc sys_mb_debug_Debug_SYS_Rst 1 3 5 NJ 530 NJ 530 NJ 530 NJ 530 2290
preplace netloc mb_intr_14_1 1 0 4 NJ 1460 NJ 1460 NJ 1460 N
preplace netloc mb_intr_06_1 1 0 4 NJ 1400 NJ 1400 NJ 1400 N
preplace netloc axi_ethernet_dma_mm2s_cntrl_reset_out_n 1 7 3 NJ -400 NJ -400 NJ
preplace netloc axi_ethernet_dma_M_AXI_MM2S 1 7 1 2310
preplace netloc axis_data_fifo_0_m_axis_tdata 1 6 4 1790 1320 NJ 1320 NJ 1320 NJ
preplace netloc aurora_8b10b_0_rx_channel_up 1 4 7 NJ 2300 NJ 2300 NJ 2300 NJ 2300 NJ 2290 NJ 2290 NJ
preplace netloc xlconstant_3_dout 1 9 2 NJ 1880 3910
preplace netloc axi_iic_0_IIC 1 10 1 4040
preplace netloc phy_clk_1 1 0 4 NJ 770 NJ 770 NJ 770 N
preplace netloc aurora_8b10b_1_s_axi_tx_tready 1 1 3 N 2970 NJ 3020 NJ
preplace netloc axi_hdmi_tx_0_hdmi_16_data_e 1 10 1 4030
preplace netloc axi_hdmi_tx_0_hdmi_16_vsync 1 10 1 4020
preplace netloc axi_uartlite_0_tx 1 10 1 4030
preplace netloc mb_intr_12_1 1 0 4 NJ 1420 NJ 1420 NJ 1420 N
preplace netloc sys_mb_DLMB 1 6 2 1810 1300 2270
preplace netloc sys_mem_clk 1 3 8 NJ 930 NJ 930 NJ 930 NJ 930 2330 950 NJ 920 NJ 920 3910
preplace netloc axi_ethernet_dma_M_AXIS_CNTRL 1 7 3 NJ -340 NJ -340 NJ
preplace netloc aurora_8b10b_0_sys_reset_out 1 4 1 1080
preplace netloc GT_SERIAL_RX_1 1 0 4 NJ 2480 NJ 2480 NJ 2480 N
preplace netloc axi_gpio_0_GPIO 1 10 1 4030
preplace netloc axi_ethernet_0_sgmii 1 10 1 4040
preplace netloc axi_cpu_interconnect_M11_AXI 1 8 2 NJ 380 NJ
preplace netloc sim_data_probe_0_axis_tdata 1 1 3 290 2820 NJ 2820 NJ
preplace netloc axi_ethernet_dma_s2mm_sts_reset_out_n 1 7 3 NJ -370 NJ -360 NJ
preplace netloc sys_mb_M_AXI_IP 1 7 1 2410
preplace netloc ScanConverterIP_0_m00_axi 1 7 4 2460 -460 NJ -460 NJ -460 3980
preplace netloc axi_cpu_interconnect_M13_AXI 1 7 2 2500 -280 2820
preplace netloc axi_cpu_interconnect_M04_AXI 1 3 6 NJ -410 NJ -410 NJ -410 NJ -410 NJ -410 2850
preplace netloc mb_intr_15_1 1 0 4 NJ 1480 NJ 1480 NJ 1480 N
preplace netloc axi_gpio_0_GPIO2 1 10 1 N
preplace netloc axi_cpu_interconnect_M01_AXI 1 8 2 NJ 180 3460
preplace netloc xlconstant_5_dout 1 3 1 600
preplace netloc mb_intr_13_1 1 0 4 NJ 1440 NJ 1440 NJ 1440 N
preplace netloc axi_ethernet_dma_s2mm_prmry_reset_out_n 1 7 3 NJ -320 NJ -320 NJ
preplace netloc axis_data_fifo_0_axis_data_count 1 6 1 N
preplace netloc xlconstant_1_dout 1 2 2 NJ 2410 620
preplace netloc axi_vdma_0_m_axis_mm2s_tdata 1 9 1 3560
preplace netloc axi_intc_interrupt 1 4 3 1090 1150 NJ 1150 NJ
preplace netloc axi_iic_0_iic2intc_irpt 1 3 8 NJ 1890 NJ 1870 NJ 1870 NJ 1870 NJ 1870 NJ 1870 NJ 1870 3930
preplace netloc xlconstant_8_dout 1 3 1 680
preplace netloc aurora_8b10b_1_user_clk_out 1 0 5 0 3090 NJ 3090 NJ 3090 NJ 3090 1070
preplace netloc axi_ddr_cntrl_c0_ddr4_ui_clk_sync_rst 1 3 8 NJ -350 NJ -350 NJ -350 NJ -350 NJ -350 NJ -350 NJ -270 3940
preplace netloc axi_ethernet_rstgen_peripheral_reset 1 3 7 710 520 1070 520 NJ 520 NJ 520 NJ 890 NJ 760 NJ
preplace netloc axi_ethernet_dma_M_AXIS_MM2S 1 7 3 NJ -330 NJ -330 NJ
preplace netloc axi_ethernet_dma_M_AXI_SG 1 7 1 2300
preplace netloc axi_cpu_interconnect_M14_AXI 1 8 2 NJ 440 NJ
preplace netloc axi_cpu_interconnect_M08_AXI 1 8 2 NJ 320 3490
preplace netloc axi_cpu_interconnect_M03_AXI 1 8 2 2870 130 NJ
preplace netloc axi_ethernet_idelayctrl_rdy 1 4 6 NJ 590 NJ 590 NJ 590 NJ 920 NJ 800 NJ
preplace netloc aurora_8b10b_0_gt_refclk1_out 1 3 2 700 2630 1070
preplace netloc axi_ethernet_0_m_axis_rxd 1 6 5 NJ -300 NJ -300 NJ -300 NJ -280 NJ
preplace netloc axi_vdma_0_mm2s_introut 1 3 7 NJ 2650 NJ 2850 NJ 2850 NJ 2850 NJ 2850 NJ 2850 3360
preplace netloc axi_hdmi_tx_0_vdma_ready 1 9 2 NJ 2860 3910
preplace netloc xlconstant_2_dout 1 9 2 NJ 1810 3920
preplace netloc axi_cpu_interconnect_M00_AXI 1 6 3 NJ -430 NJ -430 2840
preplace netloc sys_rstgen_mb_reset 1 4 3 NJ 210 NJ 210 1760
preplace netloc axi_ethernet_clkgen_clk_out1 1 3 7 690 670 1100 900 NJ 900 NJ 900 NJ 900 NJ 700 NJ
preplace netloc axi_cpu_interconnect_M12_AXI 1 8 2 NJ -370 NJ
preplace netloc axi_cpu_interconnect_M05_AXI 1 8 2 NJ 260 3440
preplace netloc axi_ethernet_clkgen_clk_out2 1 4 6 NJ 740 NJ 740 NJ 740 NJ 910 NJ 740 NJ
preplace netloc axi_ethernet_clkgen_clk_out3 1 4 6 NJ 760 NJ 760 NJ 760 NJ 880 NJ 720 NJ
preplace netloc axi_hdmi_tx_0_hdmi_16_hsync 1 10 1 4010
preplace netloc rx_1 1 0 11 NJ 1250 NJ 1250 NJ 1250 NJ 1250 NJ 1250 NJ 1250 NJ 1290 NJ 1170 NJ 1170 NJ 1170 3910
preplace netloc axis_data_fifo_0_m_axis_tvalid 1 6 4 1800 1340 NJ 1340 NJ 1340 NJ
preplace netloc axi_ethernet_clkgen_clk_out4 1 4 6 NJ 920 NJ 920 NJ 920 NJ 940 NJ 940 NJ
preplace netloc axi_ethernet_dma_M_AXI_S2MM 1 7 1 2340
preplace netloc axi_ethernet_clkgen_clk_out5 1 3 2 710 650 1070
preplace netloc GT_DIFF_REFCLK1_1 1 0 4 NJ 2300 NJ 2300 NJ 2300 640
preplace netloc aurora_8b10b_0_USER_DATA_M_AXI_RX 1 4 2 NJ 2370 1390
preplace netloc reset_button_1 1 0 4 NJ 2520 NJ 2520 NJ 2520 N
preplace netloc sys_concat_intc_dout 1 3 2 710 1620 1070
preplace netloc axi_cpu_interconnect_M10_AXI 1 8 1 2870
preplace netloc axi_vdma_0_m_axis_mm2s_tvalid 1 9 1 3540
preplace netloc axi_ethernet_0_interrupt 1 3 8 NJ 1630 NJ 1630 NJ 1630 NJ 1630 NJ 1630 NJ 1630 NJ 1630 NJ
preplace netloc aurora_8b10b_1_GT_SERIAL_TX 1 4 7 NJ 2870 NJ 2870 NJ 2870 NJ 2870 NJ 2870 NJ 2870 NJ
preplace netloc aurora_8b10b_0_user_clk_out 1 4 2 NJ 2500 N
preplace netloc sys_mb_M_AXI_DC 1 7 1 2340
preplace netloc sys_mb_ILMB 1 6 2 1820 1310 2260
preplace netloc sys_mem_resetn 1 4 6 NJ 10 NJ 10 NJ 10 2360 1050 NJ 1050 NJ
preplace netloc axi_ethernet_clkgen_locked 1 4 6 NJ 820 NJ 820 NJ 820 NJ 930 NJ 780 NJ
preplace netloc axi_ddr_cntrl_C0_DDR4 1 10 1 4040
preplace netloc xlconstant_6_dout 1 3 1 590
preplace netloc axi_cpu_interconnect_M02_AXI 1 6 3 NJ -380 NJ -380 2810
preplace netloc axis_data_fifo_0_axis_rd_data_count 1 6 4 1780 1520 NJ 1500 NJ 1500 NJ
preplace netloc axi_hdmi_tx_0_hdmi_out_clk 1 10 1 4000
preplace netloc axi_cpu_interconnect_M06_AXI 1 8 2 NJ 280 3450
preplace netloc axi_uartlite_0_interrupt 1 3 8 NJ 1640 NJ 1640 NJ 1640 NJ 1640 NJ 1640 NJ 1640 NJ 1640 3910
preplace netloc axi_hdmi_tx_0_hdmi_16_data 1 10 1 4040
preplace netloc sys_cpu_reset 1 4 1 N
preplace netloc axi_ethernet_dma_s2mm_introut 1 3 5 NJ 1600 NJ 1600 NJ 1600 NJ 1600 2300
preplace netloc axi_timer_interrupt 1 3 8 NJ -450 NJ -450 NJ -450 NJ -450 NJ -450 NJ -450 NJ -450 3930
preplace netloc axi_ethernet_dma_mm2s_introut 1 3 5 NJ 1590 NJ 1590 NJ 1590 NJ 1590 2310
preplace netloc axi_cpu_interconnect_M07_AXI 1 7 2 2490 -290 2830
preplace netloc axi_cpu_interconnect_M09_AXI 1 8 2 NJ 340 3420
preplace netloc axi_ethernet_0_m_axis_rxs 1 6 5 NJ -310 NJ -310 NJ -310 NJ -260 NJ
preplace netloc axi_hdmi_tx_0_vdma_fs 1 8 3 2900 2480 NJ 2270 3910
preplace netloc xlconstant_0_dout 1 3 1 630
preplace netloc aurora_8b10b_0_gt_reset_out 1 3 2 710 2600 1080
preplace netloc sys_cpu_clk 1 3 8 NJ 1970 NJ 1970 1380 1970 1770 30 2440 2830 2810 2840 3470 1160 3910
preplace netloc sys_cpu_resetn 1 3 8 650 1020 1090 1020 1400 1020 1750 330 2460 2650 2840 2830 NJ -90 NJ
preplace netloc sys_mb_debug_MBDEBUG_0 1 6 2 1820 1280 2280
preplace netloc axi_ethernet_dma_mm2s_prmry_reset_out_n 1 7 3 NJ -390 NJ -390 NJ
preplace netloc mb_intr_05_1 1 0 4 NJ 1380 NJ 1380 NJ 1380 N
preplace netloc sys_rst_1 1 0 10 NJ 570 NJ 570 NJ 570 NJ 1080 NJ 1080 NJ 1080 NJ 1080 NJ 1070 NJ 1070 NJ
preplace netloc S05_AXI_1 1 7 4 2510 -440 NJ -440 NJ -440 3960
preplace netloc sys_mb_M_AXI_IC 1 7 1 2320
preplace netloc axi_interconnect_0_M00_AXI 1 8 2 2900 1030 NJ
preplace netloc S00_AXI_1 1 7 1 2370
preplace netloc xlconstant_7_dout 1 3 1 590
levelinfo -pg 1 -60 160 390 530 900 1260 1600 2040 2660 3170 3750 4060 -top -470 -bot 3100
",
}

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


