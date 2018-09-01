///////////////////////////////////////////////////////////////////////////////
// (c) Copyright 1995-2014 Xilinx, Inc. All rights reserved.
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
///////////////////////////////////////////////////////////////////////////////

 `timescale 1 ns / 10 ps

(* core_generation_info = "system_i_bak_aurora_8b10b_1_0,aurora_8b10b_v11_0_4,{user_interface=AXI_4_Streaming,backchannel_mode=Timer,c_aurora_lanes=4,c_column_used=left,c_gt_clock_1=GTHQ0,c_gt_clock_2=None,c_gt_loc_1=1,c_gt_loc_10=X,c_gt_loc_11=X,c_gt_loc_12=X,c_gt_loc_13=X,c_gt_loc_14=X,c_gt_loc_15=X,c_gt_loc_16=X,c_gt_loc_17=X,c_gt_loc_18=X,c_gt_loc_19=X,c_gt_loc_2=2,c_gt_loc_20=X,c_gt_loc_21=X,c_gt_loc_22=X,c_gt_loc_23=X,c_gt_loc_24=X,c_gt_loc_25=X,c_gt_loc_26=X,c_gt_loc_27=X,c_gt_loc_28=X,c_gt_loc_29=X,c_gt_loc_3=3,c_gt_loc_30=X,c_gt_loc_31=X,c_gt_loc_32=X,c_gt_loc_33=X,c_gt_loc_34=X,c_gt_loc_35=X,c_gt_loc_36=X,c_gt_loc_37=X,c_gt_loc_38=X,c_gt_loc_39=X,c_gt_loc_4=4,c_gt_loc_40=X,c_gt_loc_41=X,c_gt_loc_42=X,c_gt_loc_43=X,c_gt_loc_44=X,c_gt_loc_45=X,c_gt_loc_46=X,c_gt_loc_47=X,c_gt_loc_48=X,c_gt_loc_5=X,c_gt_loc_6=X,c_gt_loc_7=X,c_gt_loc_8=X,c_gt_loc_9=X,c_lane_width=2,c_line_rate=62500,c_nfc=false,c_nfc_mode=IMM,c_refclk_frequency=125000,c_simplex=true,c_simplex_mode=TX,c_stream=false,c_ufc=false,flow_mode=None,interface_mode=Framing,dataflow_config=TX-only_Simplex}" *)
module system_i_bak_aurora_8b10b_1_0_support
 (
    // AXI TX Interface
input   [63:0]     s_axi_tx_tdata,
input   [7:0]      s_axi_tx_tkeep,
 
input              s_axi_tx_tvalid,
input              s_axi_tx_tlast,

output             s_axi_tx_tready,





output  [0:3]      txp,
output  [0:3]      txn,

    // GT Reference Clock Interface
input              gt_refclk1_i,
 

    // Error Detection Interface
output             tx_hard_err,
    // Status
output  [0:3]      tx_lane_up,
output             tx_channel_up,




    // System Interface
output              user_clk_out,
output              sync_clk_out,
input               gt_reset,
input               tx_system_reset,

input              power_down,
input   [2:0]      loopback,
output             tx_lock,

input              init_clk_in,
output             tx_resetdone_out,
output             sys_reset_out,
output             gt_reset_out,

    //DRP Ports
    input   [8:0]     gt0_drpaddr,
    input   [15:0]     gt0_drpdi,
    output  [15:0]     gt0_drpdo,
    input              gt0_drpen,
    output             gt0_drprdy,
    input              gt0_drpwe,
    input   [8:0]     gt1_drpaddr,
    input   [15:0]     gt1_drpdi,
    output  [15:0]     gt1_drpdo,
    input              gt1_drpen,
    output             gt1_drprdy,
    input              gt1_drpwe,
    input   [8:0]     gt2_drpaddr,
    input   [15:0]     gt2_drpdi,
    output  [15:0]     gt2_drpdo,
    input              gt2_drpen,
    output             gt2_drprdy,
    input              gt2_drpwe,
    input   [8:0]     gt3_drpaddr,
    input   [15:0]     gt3_drpdi,
    output  [15:0]     gt3_drpdo,
    input              gt3_drpen,
    output             gt3_drprdy,
    input              gt3_drpwe,


output             pll_not_locked_out

 );

 `define DLY #1

 //*********************************Main Body of Code**********************************

//----------  Wire declarations
//------------------{
//------------------}

wire               tx_out_clk_i;
wire               user_clk_i;
wire               sync_clk_i;
wire               pll_not_locked_i;
wire               tx_lock_i;

wire               init_clk_i;
wire               tx_resetdone_i;
wire               system_reset_i;
wire               gt_reset_i;
wire               drpclk_i;
wire               reset_sync_user_clk;
wire               gt_reset_sync_init_clk;
wire               bufg_gt_clr_int;



    // Instantiate a clock module for clock division.
    system_i_bak_aurora_8b10b_1_0_CLOCK_MODULE clock_module_i
    (
        .GT_CLK(tx_out_clk_i),
        .GT_CLK_LOCKED(tx_lock_i),
	.BUFG_GT_CLR_IN(bufg_gt_clr_int),
        .USER_CLK(user_clk_i),
        .SYNC_CLK(sync_clk_i),
        .PLL_NOT_LOCKED(pll_not_locked_i)
    );
   assign init_clk_i = init_clk_in;

  //  outputs
  assign gt_reset_out          =  gt_reset_i;
 
  assign sync_clk_out          =  sync_clk_i;
 
  assign user_clk_out          =  user_clk_i;
  assign pll_not_locked_out    =  pll_not_locked_i;
  assign tx_lock               =  tx_lock_i;
  assign tx_resetdone_out      =  tx_resetdone_i;


  system_i_bak_aurora_8b10b_1_0_cdc_sync
     #(
        .c_cdc_type      (1             ),   
        .c_flop_input    (0             ),  
        .c_reset_state   (0             ),  
        .c_single_bit    (1             ),  
        .c_vector_width  (2             ),  
        .c_mtbf_stages   (3              )
      )reset_sync_user_clk_cdc_sync
      (
        .prmry_aclk      (1'b0               ),
        .prmry_rst_n     (1'b1               ),
        .prmry_in        (tx_system_reset    ),
        .prmry_vect_in   (2'd0               ),
        .scndry_aclk     (user_clk_i         ),
        .scndry_rst_n    (1'b1               ),
        .prmry_ack       (                   ),
        .scndry_out      (reset_sync_user_clk),
        .scndry_vect_out (                   ) 
      );

  system_i_bak_aurora_8b10b_1_0_cdc_sync
     #(
        .c_cdc_type      (1             ),   
        .c_flop_input    (0             ),  
        .c_reset_state   (0             ),  
        .c_single_bit    (1             ),  
        .c_vector_width  (2             ),  
        .c_mtbf_stages   (3              )
      )gt_reset_cdc_sync
      (
        .prmry_aclk      (1'b0                  ),
        .prmry_rst_n     (1'b1                  ),
        .prmry_in        (gt_reset              ),
        .prmry_vect_in   (2'd0                  ),
        .scndry_aclk     (init_clk_i            ),
        .scndry_rst_n    (1'b1                  ),
        .prmry_ack       (                      ),
        .scndry_out      (gt_reset_sync_init_clk),
        .scndry_vect_out (                      ) 
      );

    system_i_bak_aurora_8b10b_1_0_SUPPORT_RESET_LOGIC support_reset_logic_i
    (
        .RESET(reset_sync_user_clk),
        .USER_CLK(user_clk_i),
        .INIT_CLK_IN(init_clk_i),
        .GT_RESET_IN(gt_reset_sync_init_clk),
        .SYSTEM_RESET(system_reset_i),
        .GT_RESET_OUT(gt_reset_i)
    );


//----- Instance of _core ----[
system_i_bak_aurora_8b10b_1_0_core system_i_bak_aurora_8b10b_1_0_core_i

     (
        // AXI TX Interface
       .s_axi_tx_tdata               (s_axi_tx_tdata),
       .s_axi_tx_tkeep               (s_axi_tx_tkeep),
       .s_axi_tx_tvalid              (s_axi_tx_tvalid),
       .s_axi_tx_tlast               (s_axi_tx_tlast),
       .s_axi_tx_tready              (s_axi_tx_tready),



        // GT Serial I/O
       .txp                          (txp),
       .txn                          (txn),

        // GT Reference Clock Interface
       .gt_refclk1                   (gt_refclk1_i),
        // Error Detection Interface

        // Error Detection Interface
       .tx_hard_err                  (tx_hard_err),

        // Status
       .tx_channel_up                (tx_channel_up),
       .tx_lane_up                   (tx_lane_up),




        // System Interface
       .user_clk                     (user_clk_i),
       .sync_clk                     (sync_clk_i),
       .tx_system_reset              (system_reset_i),
       .power_down                   (power_down),
       .loopback                     (loopback),
       .gt_reset                     (gt_reset_i),
       .tx_lock                      (tx_lock_i),
       .bufg_gt_clr_out              (bufg_gt_clr_int),
       .init_clk_in                  (init_clk_i),
       .pll_not_locked               (pll_not_locked_i),
       .tx_resetdone_out             (tx_resetdone_i),
       .gt0_drpaddr_in                   (gt0_drpaddr),
       .gt0_drpen_in                     (gt0_drpen),
       .gt0_drpdi_in                     (gt0_drpdi),
       .gt0_drprdy_out                   (gt0_drprdy),
       .gt0_drpdo_out                    (gt0_drpdo),
       .gt0_drpwe_in                     (gt0_drpwe),
       .gt1_drpaddr_in                   (gt1_drpaddr),
       .gt1_drpen_in                     (gt1_drpen),
       .gt1_drpdi_in                     (gt1_drpdi),
       .gt1_drprdy_out                   (gt1_drprdy),
       .gt1_drpdo_out                    (gt1_drpdo),
       .gt1_drpwe_in                     (gt1_drpwe),
       .gt2_drpaddr_in                   (gt2_drpaddr),
       .gt2_drpen_in                     (gt2_drpen),
       .gt2_drpdi_in                     (gt2_drpdi),
       .gt2_drprdy_out                   (gt2_drprdy),
       .gt2_drpdo_out                    (gt2_drpdo),
       .gt2_drpwe_in                     (gt2_drpwe),
       .gt3_drpaddr_in                   (gt3_drpaddr),
       .gt3_drpen_in                     (gt3_drpen),
       .gt3_drpdi_in                     (gt3_drpdi),
       .gt3_drprdy_out                   (gt3_drprdy),
       .gt3_drpdo_out                    (gt3_drpdo),
       .gt3_drpwe_in                     (gt3_drpwe),
//------------------{
//------------------}

       .sys_reset_out                (sys_reset_out),
       .tx_out_clk                   (tx_out_clk_i)

     );
//----- Instance of _core ----]



 endmodule 
