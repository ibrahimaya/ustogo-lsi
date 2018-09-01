///////////////////////////////////////////////////////////////////////////////
// (c) Copyright 2008 Xilinx, Inc. All rights reserved.
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
//
///////////////////////////////////////////////////////////////////////////////
//
//  RX_LL_PDU_DATAPATH
//
//
//  Description: the RX_LL_PDU_DATAPATH module takes regular PDU data in Aurora format
//               and transforms it to LocalLink formatted data
//
//               This module supports 4 2-byte lane designs
//             
//

`timescale 1 ns / 1 ps

module system_i_bak_aurora_8b10b_0_0_RX_LL_PDU_DATAPATH
(

    //Traffic Separator Interface
    PDU_DATA,
    PDU_DATA_V,
    PDU_PAD,
    PDU_SCP,
    PDU_ECP,


    //LocalLink PDU Interface
    RX_D,
    RX_REM,
    RX_SRC_RDY_N,
    RX_SOF_N,
    RX_EOF_N,
   
   
    //Error Interface
    FRAME_ERR,


    //System Interface
    USER_CLK,
    RESET
);

`define DLY #1


//***********************************Port Declarations*******************************
   
  
    //Traffic Separator Interface
    input   [0:63]  PDU_DATA;
    input   [0:3]  PDU_DATA_V;
    input   [0:3]  PDU_PAD;
    input   [0:3]  PDU_SCP;
    input   [0:3]  PDU_ECP;
      
   
    //LocalLink Interface
    output  [0:63]  RX_D;             
    output  [0:2]  RX_REM;           
    output          RX_SRC_RDY_N;
    output          RX_SOF_N;
    output          RX_EOF_N;
   
   
    //Error Interface
    output          FRAME_ERR;
   
   
    //System Interface
    input                           USER_CLK;
    input                           RESET;


   
//****************************External Register Declarations**************************

   
    reg     [0:2]  RX_REM;           
    reg             RX_SRC_RDY_N;
    reg             RX_SOF_N;
    reg             RX_EOF_N;    
    reg             FRAME_ERR;


//****************************Internal Register Declarations**************************
    //Stage 1
    reg     [0:63]  stage_1_data_r;
    reg             stage_1_pad_r; 
    reg     [0:3]   stage_1_ecp_r;
    reg     [0:3]   stage_1_scp_r;
    reg             stage_1_start_detected_r;


    //Stage 2
   
    reg     [0:63]  stage_2_data_r;
    reg             stage_2_pad_r; 
    reg             stage_2_start_with_data_r;
    reg             stage_2_end_before_start_r;
    reg             stage_2_end_after_start_r;   
    reg             stage_2_start_detected_r;
    reg             stage_2_frame_err_r;
       

   




//*********************************Wire Declarations**********************************
    //Stage 1
    wire    [0:3]  stage_1_data_v_r;
    wire    [0:3]  stage_1_after_scp_r;
    wire    [0:3]  stage_1_in_frame_r;
   
    //Stage 2
    wire    [0:11]  stage_2_left_align_select_r;
    wire    [0:3]  stage_2_data_v_r;
   
    wire    [0:2]  stage_2_data_v_count_r;
    wire            stage_2_frame_err_c;
            
    //Stage 3
    wire    [0:63]  stage_3_data_r;
  
    wire    [0:2]  stage_3_storage_count_r;
    wire    [0:3]  stage_3_storage_ce_r;
    wire            stage_3_end_storage_r;
    wire    [0:19]   stage_3_storage_select_r;
    wire    [0:19]   stage_3_output_select_r;
    wire            stage_3_src_rdy_n_r;
    wire            stage_3_sof_n_r;
    wire            stage_3_eof_n_r;
    wire    [0:2]  stage_3_rem_r;
    wire            stage_3_frame_err_r;
   
 
 
    //Stage 4
    wire    [0:63]   storage_data_r;
 
   
   
  
//*********************************Main Body of Code**********************************
   
   
   
   


    //_____Stage 1: Decode Frame Encapsulation and remove unframed data ________
   
   
    system_i_bak_aurora_8b10b_0_0_RX_LL_DEFRAMER stage_1_rx_ll_deframer_i
    (       
        .PDU_DATA_V(PDU_DATA_V),
        .PDU_SCP(PDU_SCP),
        .PDU_ECP(PDU_ECP),
        .USER_CLK(USER_CLK),
        .RESET(RESET),

        .DEFRAMED_DATA_V(stage_1_data_v_r),
        .IN_FRAME(stage_1_in_frame_r),
        .AFTER_SCP(stage_1_after_scp_r)
  
    );
   
  
    //Determine whether there were any SCPs detected, regardless of data
    always @(posedge USER_CLK)
        if(RESET)    stage_1_start_detected_r    <=  `DLY    1'b0; 
        else         stage_1_start_detected_r    <=  `DLY    |PDU_SCP;
  
  
    //Pipeline the data signal, and register a signal to indicate whether the data in
    // the current cycle contained a Pad character.
    always @(posedge USER_CLK)
    begin
        stage_1_data_r             <=  `DLY    PDU_DATA;
        stage_1_pad_r              <=  `DLY    |PDU_PAD;
        stage_1_ecp_r              <=  `DLY    PDU_ECP;
        stage_1_scp_r              <=  `DLY    PDU_SCP;
    end   
   
   
   
    //_______________________Stage 2: First Control Stage ___________________________
   
   
    //We instantiate a LEFT_ALIGN_CONTROL module to drive the select signals for the
    //left align mux in the next stage, and to compute the next stage valid signals
   
    system_i_bak_aurora_8b10b_0_0_LEFT_ALIGN_CONTROL stage_2_left_align_control_i
    (
        .PREVIOUS_STAGE_VALID(stage_1_data_v_r),

        .MUX_SELECT(stage_2_left_align_select_r),
        .VALID(stage_2_data_v_r),
       
        .USER_CLK(USER_CLK),
        .RESET(RESET)

    );
       

   
    //Count the number of valid data lanes: this count is used to select which data
    // is stored and which data is sent to output in later stages   
    system_i_bak_aurora_8b10b_0_0_VALID_DATA_COUNTER stage_2_valid_data_counter_i
    (
        .PREVIOUS_STAGE_VALID(stage_1_data_v_r),
        .USER_CLK(USER_CLK),
        .RESET(RESET),
       
        .COUNT(stage_2_data_v_count_r)
    );
    
    
         
    //Pipeline the data and pad bits
    always @(posedge USER_CLK)
    begin
        stage_2_data_r          <=  `DLY    stage_1_data_r;       
        stage_2_pad_r           <=  `DLY    stage_1_pad_r;
    end   
       
       
   
   
    //Determine whether there was any valid data after any SCP characters
    always @(posedge USER_CLK)
        if(RESET)   stage_2_start_with_data_r    <=  `DLY   1'b0;
        else        stage_2_start_with_data_r    <=  `DLY   |(stage_1_data_v_r & stage_1_after_scp_r);
       
       
       
    //Determine whether there were any ECPs detected before any SPC characters
    // arrived
    always @(posedge USER_CLK)
        if(RESET)   stage_2_end_before_start_r      <=  `DLY    1'b0;  
        else        stage_2_end_before_start_r      <=  `DLY    |(stage_1_ecp_r & ~stage_1_after_scp_r);
   
   
    //Determine whether there were any ECPs detected at all
    always @(posedge USER_CLK)
        if(RESET)   stage_2_end_after_start_r       <=  `DLY    1'b0;  
        else        stage_2_end_after_start_r       <=  `DLY    |(stage_1_ecp_r & stage_1_after_scp_r);
       
   
    //Pipeline the SCP detected signal
    always @(posedge USER_CLK)
        if(RESET)   stage_2_start_detected_r    <=  `DLY    1'b0; 
        else        stage_2_start_detected_r    <=  `DLY    stage_1_start_detected_r;   
       
   
   
    //Detect frame errors. Note that the frame error signal is held until the start of
    // a frame following the data beat that caused the frame error
    assign  stage_2_frame_err_c   =   |(stage_1_ecp_r & ~stage_1_in_frame_r)||
                                        |(stage_1_scp_r & stage_1_in_frame_r);
   
   
    always @(posedge USER_CLK)
        if(RESET)                       stage_2_frame_err_r               <=  `DLY    1'b0;
        else if(stage_2_frame_err_c)  stage_2_frame_err_r               <=  `DLY    1'b1;
        else if(stage_1_start_detected_r || stage_2_frame_err_r)
                                        stage_2_frame_err_r               <=  `DLY    1'b0;
      
   
       




    //_______________________________ Stage 3 Left Alignment _________________________
   
   
    //We instantiate a left align mux to shift all lanes with valid data in the channel leftward
    //The data is seperated into groups of 8 lanes, and all valid data within each group is left
    //aligned.
    system_i_bak_aurora_8b10b_0_0_LEFT_ALIGN_MUX stage_3_left_align_datapath_mux_i
    (
        .RAW_DATA(stage_2_data_r),
        .MUX_SELECT(stage_2_left_align_select_r),
        .USER_CLK(USER_CLK),

        .MUXED_DATA(stage_3_data_r)
    );
       






    //Determine the number of valid data lanes that will be in storage on the next cycle
    system_i_bak_aurora_8b10b_0_0_STORAGE_COUNT_CONTROL stage_3_storage_count_control_i
    (
        .LEFT_ALIGNED_COUNT(stage_2_data_v_count_r),
        .END_STORAGE(stage_3_end_storage_r),
        .START_WITH_DATA(stage_2_start_with_data_r),
        .FRAME_ERR(stage_2_frame_err_r),
       
        .STORAGE_COUNT(stage_3_storage_count_r),
       
        .USER_CLK(USER_CLK),
        .RESET(RESET)
         
    );
       
    
    
    //Determine the CE settings for the storage module for the next cycle
    system_i_bak_aurora_8b10b_0_0_STORAGE_CE_CONTROL stage_3_storage_ce_control_i
    (
        .LEFT_ALIGNED_COUNT(stage_2_data_v_count_r),
        .STORAGE_COUNT(stage_3_storage_count_r),
        .END_STORAGE(stage_3_end_storage_r),
        .START_WITH_DATA(stage_2_start_with_data_r),

        .STORAGE_CE(stage_3_storage_ce_r),
       
        .USER_CLK(USER_CLK),
        .RESET(RESET)
   
    );
   
            
       
    //Determine the appropriate switch settings for the storage module for the next cycle
    system_i_bak_aurora_8b10b_0_0_STORAGE_SWITCH_CONTROL stage_3_storage_switch_control_i
    (
        .LEFT_ALIGNED_COUNT(stage_2_data_v_count_r),
        .STORAGE_COUNT(stage_3_storage_count_r),
        .END_STORAGE(stage_3_end_storage_r),
        .START_WITH_DATA(stage_2_start_with_data_r),

        .STORAGE_SELECT(stage_3_storage_select_r),
       
        .USER_CLK(USER_CLK)
       
    );
   
       
       
    //Determine the appropriate switch settings for the output module for the next cycle
    system_i_bak_aurora_8b10b_0_0_OUTPUT_SWITCH_CONTROL stage_3_output_switch_control_i
    (
        .LEFT_ALIGNED_COUNT(stage_2_data_v_count_r),
        .STORAGE_COUNT(stage_3_storage_count_r),
        .END_STORAGE(stage_3_end_storage_r),
        .START_WITH_DATA(stage_2_start_with_data_r),

        .OUTPUT_SELECT(stage_3_output_select_r),
       
        .USER_CLK(USER_CLK)
   
    );
       
   
    //Instantiate a sideband output controller
    system_i_bak_aurora_8b10b_0_0_SIDEBAND_OUTPUT sideband_output_i
    (
        .LEFT_ALIGNED_COUNT(stage_2_data_v_count_r),
        .STORAGE_COUNT(stage_3_storage_count_r),
        .END_BEFORE_START(stage_2_end_before_start_r),
        .END_AFTER_START(stage_2_end_after_start_r),
        .START_DETECTED(stage_2_start_detected_r),
        .START_WITH_DATA(stage_2_start_with_data_r),
        .PAD(stage_2_pad_r),
        .FRAME_ERR(stage_2_frame_err_r),
        .USER_CLK(USER_CLK),
        .RESET(RESET),
   
        .END_STORAGE(stage_3_end_storage_r),
        .SRC_RDY_N(stage_3_src_rdy_n_r),
        .SOF_N(stage_3_sof_n_r),
        .EOF_N(stage_3_eof_n_r),
        .RX_REM(stage_3_rem_r),
        .FRAME_ERR_RESULT(stage_3_frame_err_r)
    );
   
     
   
   
   
    //________________________________ Stage 4: Storage and Output_______________________

   
    //Storage: Data is moved to storage when it cannot be sent directly to the output.
   
    system_i_bak_aurora_8b10b_0_0_STORAGE_MUX stage_4_storage_mux_i
    (
        .RAW_DATA(stage_3_data_r),
        .MUX_SELECT(stage_3_storage_select_r),
        .STORAGE_CE(stage_3_storage_ce_r),
        .USER_CLK(USER_CLK),

        .STORAGE_DATA(storage_data_r)
       

    );
   
   
   
    //Output: Data is moved to the locallink output when a full word of valid data is ready,
    // or the end of a frame is reached
   
    system_i_bak_aurora_8b10b_0_0_OUTPUT_MUX output_mux_i
    (
        .STORAGE_DATA(storage_data_r),   
        .LEFT_ALIGNED_DATA(stage_3_data_r),
        .MUX_SELECT(stage_3_output_select_r),
        .USER_CLK(USER_CLK),
       
        .OUTPUT_DATA(RX_D)
       
    );
   
   
    //Pipeline LocalLink sideband signals
    always @(posedge USER_CLK)
    begin
        RX_SOF_N        <=  `DLY    stage_3_sof_n_r;
        RX_EOF_N        <=  `DLY    stage_3_eof_n_r;
        RX_REM          <=  `DLY    stage_3_rem_r;
    end   
        

    //Pipeline the LocalLink source Ready signal
    always @(posedge USER_CLK)
        if(RESET)   RX_SRC_RDY_N    <=  `DLY    1'b1;
        else        RX_SRC_RDY_N    <=  `DLY    stage_3_src_rdy_n_r;
       
       
   
    //Pipeline the Frame error signal
    always @(posedge USER_CLK)
        if(RESET)   FRAME_ERR     <=  `DLY    1'b0;
        else        FRAME_ERR     <=  `DLY    stage_3_frame_err_r;
   


endmodule


