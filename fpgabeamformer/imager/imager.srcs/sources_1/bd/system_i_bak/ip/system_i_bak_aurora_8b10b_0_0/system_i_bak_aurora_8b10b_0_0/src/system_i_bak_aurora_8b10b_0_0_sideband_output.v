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
//  SIDEBAND_OUTPUT
//
//
//  Description: SIDEBAND_OUTPUT generates the SRC_RDY_N, EOF_N, SOF_N and
//               RX_REM signals for the RX localLink interface
//
//              This module supports 4 2-byte lane designs
//
//

`timescale 1 ns / 1 ps

module system_i_bak_aurora_8b10b_0_0_SIDEBAND_OUTPUT
(
    LEFT_ALIGNED_COUNT,
    STORAGE_COUNT,
    END_BEFORE_START,
    END_AFTER_START,
    START_DETECTED,
    START_WITH_DATA,
    PAD,
    FRAME_ERR,
    USER_CLK,
    RESET,

    END_STORAGE,
    SRC_RDY_N,
    SOF_N,
    EOF_N,
    RX_REM,
    FRAME_ERR_RESULT


);

`define DLY #1


//***********************************Port Declarations*******************************

    input   [0:2]   LEFT_ALIGNED_COUNT;
    input   [0:2]   STORAGE_COUNT;
    input           END_BEFORE_START;
    input           END_AFTER_START;
    input           START_DETECTED;
    input           START_WITH_DATA;
    input           PAD;
    input           FRAME_ERR;
    input           USER_CLK;
    input           RESET;

    output          END_STORAGE;
    output          SRC_RDY_N;
    output          SOF_N;
    output          EOF_N;
    output  [0:2]  RX_REM;
    output          FRAME_ERR_RESULT;


//***********************External Register Declarations *****************************
    reg             SRC_RDY_N;
    reg             SOF_N;
    reg             EOF_N;
    reg     [0:2]  RX_REM;
    reg             FRAME_ERR_RESULT;


//********************** Internal Register Declarations *****************************
    reg             start_next_r;
    reg             start_storage_r;
    reg             end_storage_r;
    reg             pad_storage_r;
    reg     [0:3]   rx_rem_c;


//*********************************** Wire Declarations *****************************
    wire            word_valid_c;
    wire    [0:3]  total_lanes_c;
    wire            excess_c;
    wire            storage_not_empty_c;


//*********************************Main Body of Code*********************************


    //_____________________________Storage not Empty____________________________
    // Determine whether there is any data in storage.

    assign  storage_not_empty_c =   STORAGE_COUNT != 3'd0;



    //______________________________Start Next Register_________________________

    // start_next_r indicates that the Start Storage Register should be set on the next
    // cycle.  This condition occurs when an old frame ends, filling storage with ending
    // data, and the SCP for the next cycle arrives on the same cycle.

    always @(posedge USER_CLK)
        if(RESET|FRAME_ERR)   start_next_r    <=  `DLY    1'b0;
        else                    start_next_r    <=  `DLY    START_DETECTED &&
                                                            !START_WITH_DATA &&
                                                            !END_AFTER_START;



    //______________________________Start Storage Register_________________________

    // Setting the start storage register indicates the data in storage is from
    // the start of a frame.  The register is cleared when the data in storage is sent
    // to the output.

    always @(posedge USER_CLK)
        if(RESET|FRAME_ERR)                   start_storage_r <=  `DLY    1'b0;
        else if(start_next_r | START_WITH_DATA) start_storage_r <=  `DLY    1'b1;
        else if(word_valid_c)                   start_storage_r <=  `DLY    1'b0;


    //______________________________End Storage Register___________________________

    // Setting the end storage register indicates the data in storage is from the end
    // of a frame.  The register is cleared when the data in storage is sent to the output.


    always @(posedge USER_CLK)
        if(RESET|FRAME_ERR)                       end_storage_r   <=  `DLY    1'b0;
        else if( (END_BEFORE_START & !START_WITH_DATA & (total_lanes_c != 0))||
                 (END_AFTER_START && START_WITH_DATA))
                                                    end_storage_r   <=  `DLY    1'b1;
        else                                        end_storage_r   <=  `DLY    1'b0;


    assign  END_STORAGE =   end_storage_r;

    //______________________________Pad Storage Register____________________________

    // Setting the pad storage register indicates that the data in storage had a pad
    // character associated with it.  The register is cleared when the data in storage
    // is sent to the output.

    always @(posedge USER_CLK)
        if(RESET|FRAME_ERR)                               pad_storage_r   <=  `DLY    1'b0;
        else if(PAD)                                        pad_storage_r   <=  `DLY    1'b1;
        else if (word_valid_c)                              pad_storage_r   <=  `DLY    1'b0;



    //_____________________________Word Valid signal and SRC_RDY register__________

    // The word valid signal indicates that the output word has valid data. 
    // This occurs when:
    //     a) A frame is ended on the same cycle as data arrives for the next frame
    //     b) The arriving data belongs to the current frame and is too much to store
    //     c) The storage data is marked as ended with the end_storage flag

    assign word_valid_c = (END_BEFORE_START && START_WITH_DATA)||
                          (excess_c && !START_WITH_DATA)||
                          (end_storage_r);




    // Generate RX_SRC_RDY from word_valid. Note that words can never be valid if
    // a frame error was detected in the deframer due to consecutive SCPs or ECPs

    always @(posedge USER_CLK)
        if(RESET|FRAME_ERR)   SRC_RDY_N   <=  `DLY    1'b1;
        else                    SRC_RDY_N   <=  `DLY    !word_valid_c;




    //_____________________________Frame error result signal_________________________

    // Indicate a frame error whenever the deframer detects a frame error, or whenever
    // an empty frame is detected.
    // We detect empty frames by looking for cases where a frame is ended while the
    // storage register is empty. We must be careful not to confuse the data from
    // seperate frames

    always @(posedge USER_CLK)
        FRAME_ERR_RESULT  <=  `DLY    FRAME_ERR || (END_AFTER_START && !START_WITH_DATA) ||
                                      (END_BEFORE_START && START_WITH_DATA && !storage_not_empty_c) ||
                                      (END_BEFORE_START && !START_WITH_DATA && total_lanes_c == 0);




    //_____________________________The total_lanes and excess signals________________

    // When there is too much data to put into storage, the excess signal is asserted.

    assign total_lanes_c = (LEFT_ALIGNED_COUNT + STORAGE_COUNT);

    assign excess_c =  total_lanes_c > 4'd4;




    //_____________________________The Start of Frame signal_______________________

    // To save logic, start of frame is asserted from the time the start of a frame
    // is placed in storage to the time it is placed on the locallink output register.

    always @(posedge USER_CLK)
        SOF_N   <=  `DLY    ~start_storage_r;


    //_____________________________The end of frame signal__________________________

    // End of frame is asserted when storage contains ended data, or when an ECP arrives
    // at the same time as new data that must replace old data in storage.

    always @(posedge USER_CLK)
        EOF_N   <=  `DLY    ~(end_storage_r | (END_BEFORE_START & START_WITH_DATA & storage_not_empty_c));




    //____________________________The RX_REM signal ___________________________________

    // RX_REM is equal to the number of bytes written to the output, minus 1 if there is
    // a pad.

     always @(PAD or pad_storage_r or START_WITH_DATA or end_storage_r or STORAGE_COUNT or total_lanes_c)
            if(end_storage_r|START_WITH_DATA)   rx_rem_c   =   {STORAGE_COUNT,1'b0} - (pad_storage_r?4'd2:4'd1);
            else                                rx_rem_c   =   {total_lanes_c[1:3],1'b0} - ((PAD|pad_storage_r)?4'd2:4'd1);

    always @(posedge USER_CLK)
        RX_REM <=  `DLY    rx_rem_c[1:3];


endmodule
