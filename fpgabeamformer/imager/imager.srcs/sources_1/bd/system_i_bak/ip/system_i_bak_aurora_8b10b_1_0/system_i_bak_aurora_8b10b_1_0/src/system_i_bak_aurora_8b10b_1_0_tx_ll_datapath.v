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
//  TX_LL_DATAPATH
//
//
//  Description: This module pipelines the data path while handling the PAD
//               character placement and valid data flags.
//
//               This module supports 4 2-byte lane designs
//

`timescale 1 ns / 1 ps

module system_i_bak_aurora_8b10b_1_0_TX_LL_DATAPATH
(
    // LocalLink PDU Interface
    TX_D,
    TX_REM,
    TX_SRC_RDY_N,
    TX_SOF_N,
    TX_EOF_N,


    // Aurora Lane Interface
    TX_PE_DATA_V,
    GEN_PAD,
    TX_PE_DATA,


    // TX_LL Control Module Interface
    HALT_C,
    TX_DST_RDY_N,

    // System Interface
    CHANNEL_UP,
    USER_CLK

);

`define DLY #1


//***********************************Port Declarations*******************************


    // LocalLink PDU Interface
input   [0:63]     TX_D;
input   [0:2]      TX_REM;
input              TX_SRC_RDY_N;
input              TX_SOF_N;
input              TX_EOF_N;


    // Aurora Lane Interface
output  [0:3]      TX_PE_DATA_V;
output  [0:3]      GEN_PAD;
output  [0:63]     TX_PE_DATA;


    // TX_LL Control Module Interface
input              HALT_C;
input              TX_DST_RDY_N;

    // System Interface
input              CHANNEL_UP;
input              USER_CLK;


//**************************External Register Declarations****************************

reg     [0:63]     TX_PE_DATA;
reg     [0:3]      TX_PE_DATA_V;
reg     [0:3]      GEN_PAD;


//**************************Internal Register Declarations****************************

reg                in_frame_r;
reg     [0:15]     storage_r;
reg                storage_v_r;
reg                storage_pad_r;
reg     [0:63]     tx_pe_data_r;
reg     [0:3]      valid_c;
reg     [0:3]      tx_pe_data_v_r;
reg     [0:3]      gen_pad_c;
reg     [0:3]      gen_pad_r;

reg     [0:63]     tx_d_pipeline_r;
reg     [0:2]      tx_rem_pipeline_r;
reg                tx_src_rdy_n_pipeline_r;
reg                tx_sof_n_pipeline_r;
reg                tx_eof_n_pipeline_r;
reg                halt_c_pipeline_r;
reg                tx_dst_rdy_n_pipeline_r;



//******************************Internal Wire Declarations****************************

wire               in_frame_c;
wire               ll_valid_c;


//*********************************Main Body of Code**********************************






    // Pipeline all inputs.  This creates 'travelling registers',
    // which makes it easier for par to place blocks to reduce congestion while
    // meeting all timing constriants.


    // First we pipeline the control signals.  Some of these signals are used
    // many times in the datapath.  The sythesis tool will replicate these
    // registers to keep fanout low and preserve timing.
    always @(posedge USER_CLK)
        if(!CHANNEL_UP)
        begin
            tx_src_rdy_n_pipeline_r     <=  `DLY    1'b1;
            tx_sof_n_pipeline_r         <=  `DLY    1'b1;
            tx_eof_n_pipeline_r         <=  `DLY    1'b1;
            halt_c_pipeline_r           <=  `DLY    1'b0;
            tx_dst_rdy_n_pipeline_r     <=  `DLY    1'b1;
        end
        else
        begin
            tx_src_rdy_n_pipeline_r     <=  `DLY    TX_SRC_RDY_N;
            tx_sof_n_pipeline_r         <=  `DLY    TX_SOF_N;
            tx_eof_n_pipeline_r         <=  `DLY    TX_EOF_N;
            halt_c_pipeline_r           <=  `DLY    HALT_C;
            tx_dst_rdy_n_pipeline_r     <=  `DLY    TX_DST_RDY_N;
        end


    // We pipeline the data and REM seperately from the control signals: we
    // use no reset because the routing is expensive, and the signals are
    // all qualified by the control signals.
    always @(posedge USER_CLK)
    begin
        tx_d_pipeline_r             <=  `DLY    TX_D;
        tx_rem_pipeline_r           <=  `DLY    TX_REM;
    end


   
    // LocalLink input is only valid when TX_SRC_RDY_N and TX_DST_RDY_N are both asserted
    assign ll_valid_c    =   !tx_src_rdy_n_pipeline_r && !tx_dst_rdy_n_pipeline_r;


    // Data must only be read if it is within a frame. If a frame will last multiple cycles
    // we assert in_frame_r as long as the frame is open.
    always @(posedge USER_CLK)
        if(!CHANNEL_UP)                   in_frame_r    <=  `DLY    1'b0;
        else if(ll_valid_c)
        begin
            if(!tx_sof_n_pipeline_r && tx_eof_n_pipeline_r )    in_frame_r    <=  `DLY    1'b1;
            else if(!tx_eof_n_pipeline_r)                       in_frame_r    <=  `DLY    1'b0;
        end
   
       
    assign in_frame_c   =   ll_valid_c && (in_frame_r  || !tx_sof_n_pipeline_r);






    // The last 2 bytes of data from the LocalLink interface must be stored
    // for the next cycle to make room for the SCP character that must be
    // placed at the beginning of the lane.
    always @(posedge USER_CLK)
        if(!halt_c_pipeline_r)
            storage_r   <=  `DLY    tx_d_pipeline_r[48:63];



    // All of the remaining bytes (except the last two) must be shifted
    // and registered to be sent to the Channel.  The stored bytes go
    // into the first position.
    always @(posedge USER_CLK)
        if(!halt_c_pipeline_r)
            tx_pe_data_r  <=  `DLY    {storage_r,tx_d_pipeline_r[0:47]};



    // We generate the valid_c signal based on the REM signal and the EOF signal.
    always @(tx_eof_n_pipeline_r or tx_rem_pipeline_r)
if(tx_eof_n_pipeline_r)    valid_c =   4'b1111;
        else
            case(tx_rem_pipeline_r[0:2])
3'h0    : valid_c    =   4'b1000;
3'h1    : valid_c    =   4'b1000;
3'h2    : valid_c    =   4'b1100;
3'h3    : valid_c    =   4'b1100;
3'h4    : valid_c    =   4'b1110;
3'h5    : valid_c    =   4'b1110;
3'h6    : valid_c    =   4'b1111;
3'h7    : valid_c    =   4'b1111;
default:  valid_c    =   4'b1111;
            endcase




    // If the last 2 bytes in the word are valid, they are placed in the storage register and
    // storage_v_r is asserted to indicate the data is valid.  Note that data is only moved to
    // storage if the PDU datapath is not halted, the data is valid and both TX_SRC_RDY_N
    // and TX_DST_RDY_N (as indicated by DATA_VALID) are asserted.
    always @(posedge USER_CLK)
        if(!halt_c_pipeline_r)     storage_v_r     <=  `DLY     valid_c[3] && in_frame_c;
                    




    // The tx_pe_data_v_r registers track valid data in the TX_PE_DATA register.  The data is valid
    // if it was valid in the previous stage.  Since the first 2 bytes come from storage, validity is
    // determined from the storage_v_r signal.  The remaining bytes are valid if their valid signal
    // is asserted, and both TX_SRC_RDY_N and TX_DST_RDY_N (as indicated by DATA_VALID) are asserted.
    // Note that pdu data movement can be frozen by the halt signal.
    always @(posedge USER_CLK)
        if(!halt_c_pipeline_r)
        begin
            tx_pe_data_v_r[0]   <=  `DLY    storage_v_r;
            tx_pe_data_v_r[1]   <=  `DLY    valid_c[0] && in_frame_c;
            tx_pe_data_v_r[2]   <=  `DLY    valid_c[1] && in_frame_c;
            tx_pe_data_v_r[3]   <=  `DLY    valid_c[2] && in_frame_c;
        end






    // We generate the gen_pad_c signal based on the REM signal and the EOF signal.
    always @(tx_eof_n_pipeline_r or tx_rem_pipeline_r)
        if(tx_eof_n_pipeline_r)
gen_pad_c   =   4'b0000;
        else
            case(tx_rem_pipeline_r[0:2])
3'h0    : gen_pad_c    =   4'b1000;
3'h1    : gen_pad_c    =   4'b0000;
3'h2    : gen_pad_c    =   4'b0100;
3'h3    : gen_pad_c    =   4'b0000;
3'h4    : gen_pad_c    =   4'b0010;
3'h5    : gen_pad_c    =   4'b0000;
3'h6    : gen_pad_c    =   4'b0001;
3'h7    : gen_pad_c    =   4'b0000;
default:  gen_pad_c    =   4'b0000;
            endcase



    // Store a padded byte pair if it's padded, TX_SRC_RDY_N is asserted, and data is valid.
    always @(posedge USER_CLK)
        if(!halt_c_pipeline_r)     storage_pad_r   <=  `DLY    gen_pad_c[3] && in_frame_c;


    // Register the gen_pad_r signals.
    always @(posedge USER_CLK)
        if(!halt_c_pipeline_r)
        begin
            gen_pad_r[0]    <=  `DLY    storage_pad_r;
            gen_pad_r[1]    <=  `DLY    gen_pad_c[0] && in_frame_c;
            gen_pad_r[2]    <=  `DLY    gen_pad_c[1] && in_frame_c;
            gen_pad_r[3]    <=  `DLY    gen_pad_c[2] && in_frame_c;
        end





    // Implement the data out register.
    always @(posedge USER_CLK)
    begin
        TX_PE_DATA      <=  `DLY    tx_pe_data_r;
        TX_PE_DATA_V[0] <=  `DLY    tx_pe_data_v_r[0] & !halt_c_pipeline_r;
        TX_PE_DATA_V[1] <=  `DLY    tx_pe_data_v_r[1] & !halt_c_pipeline_r;
        TX_PE_DATA_V[2] <=  `DLY    tx_pe_data_v_r[2] & !halt_c_pipeline_r;
        TX_PE_DATA_V[3] <=  `DLY    tx_pe_data_v_r[3] & !halt_c_pipeline_r;
        GEN_PAD[0]      <=  `DLY    gen_pad_r[0] & !halt_c_pipeline_r;
        GEN_PAD[1]      <=  `DLY    gen_pad_r[1] & !halt_c_pipeline_r;
        GEN_PAD[2]      <=  `DLY    gen_pad_r[2] & !halt_c_pipeline_r;
        GEN_PAD[3]      <=  `DLY    gen_pad_r[3] & !halt_c_pipeline_r;
    end





endmodule
