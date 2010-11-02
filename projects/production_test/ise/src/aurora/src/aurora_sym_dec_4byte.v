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
//  SYM_DEC_4BYTE
//
//
//  Description: The SYM_DEC_4BYTE module is a symbol decoder for the
//               4-byte Aurora Lane.  Its inputs are the raw data from
//               the GTX.  It word-aligns the regular data and decodes
//               all of the Aurora control symbols.  Its outputs are the
//               word-aligned data and signals indicating the arrival of
//               specific control characters.
//

`timescale 1 ns / 1 ps

module aurora_SYM_DEC_4BYTE
(
    // RX_LL Interface
    RX_PAD,
    RX_PE_DATA,
    RX_PE_DATA_V,
    RX_SCP,
    RX_ECP,


    // Lane Init SM Interface
    DO_WORD_ALIGN,
    LANE_UP,

    RX_SP,
    RX_SPA,
    RX_NEG,


    // Global Logic Interface
    GOT_A,
    GOT_V,


    // GTX Interface
    RX_DATA,
    RX_CHAR_IS_K,
    RX_CHAR_IS_COMMA,


    // System Interface
    USER_CLK,
    RESET
);

`define DLY #1

//***********************************Parameter Declarations**************************

    parameter       K_CHAR_0        =   4'hb;
    parameter       K_CHAR_1        =   4'hc;
    parameter       SP_DATA_0       =   4'h4;
    parameter       SP_DATA_1       =   4'ha;
    parameter       SPA_DATA_0      =   4'h2;
    parameter       SPA_DATA_1      =   4'hc;
    parameter       SP_NEG_DATA_0   =   4'hb;
    parameter       SP_NEG_DATA_1   =   4'h5;
    parameter       SPA_NEG_DATA_0  =   4'hd;
    parameter       SPA_NEG_DATA_1  =   4'h3;
    parameter       PAD_0           =   4'h9;
    parameter       PAD_1           =   4'hc;
    parameter       SCP_0           =   4'h5;
    parameter       SCP_1           =   4'hc;
    parameter       SCP_2           =   4'hf;
    parameter       SCP_3           =   4'hb;
    parameter       ECP_0           =   4'hf;
    parameter       ECP_1           =   4'hd;
    parameter       ECP_2           =   4'hf;
    parameter       ECP_3           =   4'he;
    parameter       A_CHAR_0        =   4'h7;
    parameter       A_CHAR_1        =   4'hc;
    parameter       VER_DATA_0      =   4'he;
    parameter       VER_DATA_1      =   4'h8;


//***********************************Port Declarations*******************************

    // RX_LL Interface
    output  [0:1]   RX_PAD;           // LSByte is PAD.
    output  [0:31]  RX_PE_DATA;       // Word aligned data from channel partner.
    output  [0:1]   RX_PE_DATA_V;     // Data is valid data and not a control character.
    output  [0:1]   RX_SCP;           // SCP symbol received.
    output  [0:1]   RX_ECP;           // ECP symbol received.


    // Lane Init SM Interface
    input           DO_WORD_ALIGN;    // Word alignment is allowed.
    input           LANE_UP;          // lane is up

    output          RX_SP;            // SP sequence received with positive or negative data.
    output          RX_SPA;           // SPA sequence received.
    output          RX_NEG;           // Inverted data for SP or SPA received.


    // Global Logic Interface
    output  [0:3]   GOT_A;            // A character received on indicated byte(s).
    output          GOT_V;            // V sequence received.


    // GTX Interface
    input   [31:0]  RX_DATA;          // Raw RX data from GTX.
    input   [3:0]   RX_CHAR_IS_K;     // Bits indicating which bytes are control characters.
    input   [3:0]   RX_CHAR_IS_COMMA; // Rx'ed a comma.


    // System Interface
    input           USER_CLK;         // System clock for all non-GTX Aurora Logic.
    input           RESET;



//**************************External Register Declarations****************************

    reg     [0:31]  RX_PE_DATA;
    reg     [0:1]   RX_PAD;
    reg     [0:1]   RX_PE_DATA_V;
    reg     [0:1]   RX_SCP;
    reg     [0:1]   RX_ECP;
    reg             RX_SP;
    reg             RX_SPA;
    reg             RX_NEG;
    reg     [0:3]   GOT_A;
    reg             GOT_V;


//**************************Internal Register Declarations****************************

    reg     [0:1]   left_align_select_r;
    reg     [23:0]  previous_cycle_data_r;
    reg     [2:0]   previous_cycle_control_r;
    reg     [0:31]  word_aligned_data_r;
    reg     [0:3]   word_aligned_control_bits_r;
    reg     [0:31]  rx_pe_data_r;
    reg     [0:3]   rx_pe_control_r;
    reg     [0:3]   rx_pad_d_r;
    reg     [0:7]   rx_scp_d_r;
    reg     [0:7]   rx_ecp_d_r;
    reg     [0:7]   rx_sp_r;
    reg     [0:7]   rx_spa_r;
    reg     [0:1]   rx_sp_neg_d_r;
    reg     [0:1]   rx_spa_neg_d_r;
    reg     [0:7]   rx_v_d_r;
    reg     [0:7]   got_a_d_r;
    reg             first_v_received_r;


//*********************************Wire Declarations**********************************

    wire            got_v_c;


//*********************************Main Body of Code**********************************


    //__________________________Word Alignment__________________________________

    // Determine whether the lane is aligned to the left byte (MSByte) or the
    // right byte (LSByte).  This information is used for word alignment. To
    // prevent the word align from changing during normal operation, we do word
    // alignment only when it is allowed by the lane_init_sm.
    always @(posedge USER_CLK)
        if(DO_WORD_ALIGN & !first_v_received_r)
            case(RX_CHAR_IS_K)
                4'b1000   :   left_align_select_r  <=  `DLY    2'b00;
                4'b0100   :   left_align_select_r  <=  `DLY    2'b01;
                4'b0010   :   left_align_select_r  <=  `DLY    2'b10;
                4'b1100   :   left_align_select_r  <=  `DLY    2'b01;
                4'b1110   :   left_align_select_r  <=  `DLY    2'b10;
                4'b0001   :   left_align_select_r  <=  `DLY    2'b11;
                default :     left_align_select_r  <=  `DLY    left_align_select_r;
            endcase



    // Store bytes 1, 2 and 3 from the previous cycle.  If the lane is aligned
    // on one of those bytes, we use the data in the current cycle.
    always @(posedge USER_CLK)
        previous_cycle_data_r       <=  `DLY  RX_DATA[23:0];



    // Store the control bits from bytes 1, 2 and 3 from the previous cycle.  If
    // we align on one of those bytes, we will also need to use their previous
    // value control bits.
    always @(posedge USER_CLK)
        previous_cycle_control_r    <=  `DLY  RX_CHAR_IS_K[2:0];



    // Select the word-aligned data byte 0.
    always @(posedge USER_CLK)
        case(left_align_select_r)
            2'b00   :   word_aligned_data_r[0:7]  <=  `DLY    RX_DATA[31:24];
            2'b01   :   word_aligned_data_r[0:7]  <=  `DLY    previous_cycle_data_r[23:16];
            2'b10   :   word_aligned_data_r[0:7]  <=  `DLY    previous_cycle_data_r[15:8];
            2'b11   :   word_aligned_data_r[0:7]  <=  `DLY    previous_cycle_data_r[7:0];
            default :   word_aligned_data_r[0:7]  <=  `DLY    8'b00000000;
        endcase



    // Select the word-aligned data byte 1.
    always @(posedge USER_CLK)
        case(left_align_select_r)
            2'b00   :   word_aligned_data_r[8:15]  <=  `DLY    RX_DATA[23:16];
            2'b01   :   word_aligned_data_r[8:15]  <=  `DLY    previous_cycle_data_r[15:8];
            2'b10   :   word_aligned_data_r[8:15]  <=  `DLY    previous_cycle_data_r[7:0];
            2'b11   :   word_aligned_data_r[8:15]  <=  `DLY    RX_DATA[31:24];
            default :   word_aligned_data_r[8:15]  <=  `DLY    8'b00000000;
        endcase



    // Select the word-aligned data byte 2.
    always @(posedge USER_CLK)
        case(left_align_select_r)
            2'b00   :   word_aligned_data_r[16:23]  <=  `DLY    RX_DATA[15:8];
            2'b01   :   word_aligned_data_r[16:23]  <=  `DLY    previous_cycle_data_r[7:0];
            2'b10   :   word_aligned_data_r[16:23]  <=  `DLY    RX_DATA[31:24];
            2'b11   :   word_aligned_data_r[16:23]  <=  `DLY    RX_DATA[23:16];
            default :   word_aligned_data_r[16:23]  <=  `DLY    8'b00000000;
        endcase



    // Select the word-aligned data byte 3.
    always @(posedge USER_CLK)
        case(left_align_select_r)
            2'b00   :   word_aligned_data_r[24:31]  <=  `DLY    RX_DATA[7:0];
            2'b01   :   word_aligned_data_r[24:31]  <=  `DLY    RX_DATA[31:24];
            2'b10   :   word_aligned_data_r[24:31]  <=  `DLY    RX_DATA[23:16];
            2'b11   :   word_aligned_data_r[24:31]  <=  `DLY    RX_DATA[15:8];
            default :   word_aligned_data_r[24:31]  <=  `DLY    8'b00000000;
        endcase



    // Select the word-aligned control bit 0.
    always @(posedge USER_CLK)
        case(left_align_select_r)
            2'b00   :   word_aligned_control_bits_r[0]  <=  `DLY    RX_CHAR_IS_K[3];
            2'b01   :   word_aligned_control_bits_r[0]  <=  `DLY    previous_cycle_control_r[2];
            2'b10   :   word_aligned_control_bits_r[0]  <=  `DLY    previous_cycle_control_r[1];
            2'b11   :   word_aligned_control_bits_r[0]  <=  `DLY    previous_cycle_control_r[0];
            default :   word_aligned_control_bits_r[0]  <=  `DLY    1'b0;
        endcase



    // Select the word-aligned control bit 1.
    always @(posedge USER_CLK)
        case(left_align_select_r)
            2'b00   :   word_aligned_control_bits_r[1]  <=  `DLY    RX_CHAR_IS_K[2];
            2'b01   :   word_aligned_control_bits_r[1]  <=  `DLY    previous_cycle_control_r[1];
            2'b10   :   word_aligned_control_bits_r[1]  <=  `DLY    previous_cycle_control_r[0];
            2'b11   :   word_aligned_control_bits_r[1]  <=  `DLY    RX_CHAR_IS_K[3];
            default :   word_aligned_control_bits_r[1]  <=  `DLY    1'b0;
        endcase



    // Select the word-aligned control bit 2.
    always @(posedge USER_CLK)
        case(left_align_select_r)
            2'b00   :   word_aligned_control_bits_r[2]  <=  `DLY    RX_CHAR_IS_K[1];
            2'b01   :   word_aligned_control_bits_r[2]  <=  `DLY    previous_cycle_control_r[0];
            2'b10   :   word_aligned_control_bits_r[2]  <=  `DLY    RX_CHAR_IS_K[3];
            2'b11   :   word_aligned_control_bits_r[2]  <=  `DLY    RX_CHAR_IS_K[2];
            default :   word_aligned_control_bits_r[2]  <=  `DLY    1'b0;
        endcase



    // Select the word-aligned control bit 3.
    always @(posedge USER_CLK)
        case(left_align_select_r)
            2'b00   :   word_aligned_control_bits_r[3]  <=  `DLY    RX_CHAR_IS_K[0];
            2'b01   :   word_aligned_control_bits_r[3]  <=  `DLY    RX_CHAR_IS_K[3];
            2'b10   :   word_aligned_control_bits_r[3]  <=  `DLY    RX_CHAR_IS_K[2];
            2'b11   :   word_aligned_control_bits_r[3]  <=  `DLY    RX_CHAR_IS_K[1];
            default :   word_aligned_control_bits_r[3]  <=  `DLY    1'b0;
        endcase



    // Pipeline the word-aligned data for 1 cycle to match the Decodes.
    always @(posedge USER_CLK)
        rx_pe_data_r   <=  `DLY    word_aligned_data_r;


    // Register the pipelined word-aligned data for the RX_LL interface.
    always @(posedge USER_CLK)
        RX_PE_DATA  <=  `DLY  rx_pe_data_r;





    //_____________________________Decode Control Symbols___________________________


    // All decodes are pipelined to keep the number of logic levels to a minimum.


    // Delay the control bits: they are most often used in the second stage of the
    // decoding process.
    always @(posedge USER_CLK)
        rx_pe_control_r     <=  `DLY    word_aligned_control_bits_r;


    // Decode PAD.
    always @(posedge USER_CLK)
    begin
        rx_pad_d_r[0]   <=  `DLY    (word_aligned_data_r[8:11]     ==  PAD_0);
        rx_pad_d_r[1]   <=  `DLY    (word_aligned_data_r[12:15]    ==  PAD_1);
        rx_pad_d_r[2]   <=  `DLY    (word_aligned_data_r[24:27]    ==  PAD_0);
        rx_pad_d_r[3]   <=  `DLY    (word_aligned_data_r[28:31]    ==  PAD_1);
    end

    always @(posedge USER_CLK)
    begin
        RX_PAD[0]      <=  `DLY  (rx_pad_d_r[0:1]== 2'b11) & (rx_pe_control_r[0:1] == 2'b01);
        RX_PAD[1]      <=  `DLY  (rx_pad_d_r[2:3]== 2'b11) & (rx_pe_control_r[2:3] == 2'b01);
    end



    // Decode RX_PE_DATA_V.
    always @(posedge USER_CLK)
    begin
        RX_PE_DATA_V[0]     <=  `DLY    !rx_pe_control_r[0];
        RX_PE_DATA_V[1]     <=  `DLY    !rx_pe_control_r[2];
    end


    // Decode RX_SCP.
    always @(posedge USER_CLK)
    begin
        rx_scp_d_r[0]   <=  `DLY    (word_aligned_data_r[0:3]   ==  SCP_0);
        rx_scp_d_r[1]   <=  `DLY    (word_aligned_data_r[4:7]   ==  SCP_1);
        rx_scp_d_r[2]   <=  `DLY    (word_aligned_data_r[8:11]  ==  SCP_2);
        rx_scp_d_r[3]   <=  `DLY    (word_aligned_data_r[12:15] ==  SCP_3);
        rx_scp_d_r[4]   <=  `DLY    (word_aligned_data_r[16:19] ==  SCP_0);
        rx_scp_d_r[5]   <=  `DLY    (word_aligned_data_r[20:23] ==  SCP_1);
        rx_scp_d_r[6]   <=  `DLY    (word_aligned_data_r[24:27] ==  SCP_2);
        rx_scp_d_r[7]   <=  `DLY    (word_aligned_data_r[28:31] ==  SCP_3);
    end

    always @(posedge USER_CLK)
    begin
        RX_SCP[0]   <=  `DLY    &{rx_pe_control_r[0:1], rx_scp_d_r[0:3]};
        RX_SCP[1]   <=  `DLY    &{rx_pe_control_r[2:3], rx_scp_d_r[4:7]};
    end



    // Decode RX_ECP.
    always @(posedge USER_CLK)
    begin
        rx_ecp_d_r[0]   <=  `DLY    (word_aligned_data_r[0:3]   ==  ECP_0);
        rx_ecp_d_r[1]   <=  `DLY    (word_aligned_data_r[4:7]   ==  ECP_1);
        rx_ecp_d_r[2]   <=  `DLY    (word_aligned_data_r[8:11]  ==  ECP_2);
        rx_ecp_d_r[3]   <=  `DLY    (word_aligned_data_r[12:15] ==  ECP_3);
        rx_ecp_d_r[4]   <=  `DLY    (word_aligned_data_r[16:19] ==  ECP_0);
        rx_ecp_d_r[5]   <=  `DLY    (word_aligned_data_r[20:23] ==  ECP_1);
        rx_ecp_d_r[6]   <=  `DLY    (word_aligned_data_r[24:27] ==  ECP_2);
        rx_ecp_d_r[7]   <=  `DLY    (word_aligned_data_r[28:31] ==  ECP_3);
    end

    always @(posedge USER_CLK)
    begin
        RX_ECP[0]   <=  `DLY    &{rx_pe_control_r[0:1], rx_ecp_d_r[0:3]};
        RX_ECP[1]   <=  `DLY    &{rx_pe_control_r[2:3], rx_ecp_d_r[4:7]};
    end






    // Indicate the SP sequence was received.
    always @(posedge USER_CLK)
    begin
        rx_sp_r[0]   <=  `DLY    (word_aligned_data_r[0:3]   ==  K_CHAR_0);
        rx_sp_r[1]   <=  `DLY    (word_aligned_data_r[4:7]   ==  K_CHAR_1);
        rx_sp_r[2]   <=  `DLY    (word_aligned_data_r[8:11]  ==  SP_DATA_0)|
                                   (word_aligned_data_r[8:11]  ==  SP_NEG_DATA_0);
        rx_sp_r[3]   <=  `DLY    (word_aligned_data_r[12:15] ==  SP_DATA_1)|
                                   (word_aligned_data_r[12:15] ==  SP_NEG_DATA_1);
        rx_sp_r[4]   <=  `DLY    (word_aligned_data_r[16:19]   ==  SP_DATA_0)|
                                   (word_aligned_data_r[16:19]   ==  SP_NEG_DATA_0);
        rx_sp_r[5]   <=  `DLY    (word_aligned_data_r[20:23]   ==  SP_DATA_1)|
                                   (word_aligned_data_r[20:23]   ==  SP_NEG_DATA_1);
        rx_sp_r[6]   <=  `DLY    (word_aligned_data_r[24:27]  ==  SP_DATA_0)|
                                   (word_aligned_data_r[24:27]  ==  SP_NEG_DATA_0);
        rx_sp_r[7]   <=  `DLY    (word_aligned_data_r[28:31] ==  SP_DATA_1)|
                                   (word_aligned_data_r[28:31] ==  SP_NEG_DATA_1);

    end

    always @(posedge USER_CLK)
        RX_SP   <=  `DLY  (rx_pe_control_r == 4'b1000) & (rx_sp_r == 8'hFF);




    // Indicate the SPA sequence was received.
    always @(posedge USER_CLK)
    begin
        rx_spa_r[0]   <=  `DLY    (word_aligned_data_r[0:3]   ==  K_CHAR_0);
        rx_spa_r[1]   <=  `DLY    (word_aligned_data_r[4:7]   ==  K_CHAR_1);
        rx_spa_r[2]   <=  `DLY    (word_aligned_data_r[8:11]  ==  SPA_DATA_0);
        rx_spa_r[3]   <=  `DLY    (word_aligned_data_r[12:15] ==  SPA_DATA_1);
        rx_spa_r[4]   <=  `DLY    (word_aligned_data_r[16:19] ==  SPA_DATA_0);
        rx_spa_r[5]   <=  `DLY    (word_aligned_data_r[20:23] ==  SPA_DATA_1);
        rx_spa_r[6]   <=  `DLY    (word_aligned_data_r[24:27] ==  SPA_DATA_0);
        rx_spa_r[7]   <=  `DLY    (word_aligned_data_r[28:31] ==  SPA_DATA_1);
    end

    always @(posedge USER_CLK)
        RX_SPA   <=  `DLY  (rx_pe_control_r == 4'b1000) & (rx_spa_r == 8'hFF);




    // Indicate reversed data received.  We look only at the word aligned LSByte
    // which, during an SP or SPA sequence, will always contain a data byte.
    always @(posedge USER_CLK)
    begin
        rx_sp_neg_d_r[0]   <=  `DLY    (word_aligned_data_r[8:11]   ==  SP_NEG_DATA_0);
        rx_sp_neg_d_r[1]   <=  `DLY    (word_aligned_data_r[12:15]  ==  SP_NEG_DATA_1);

        rx_spa_neg_d_r[0]   <=  `DLY    (word_aligned_data_r[8:11]  ==  SPA_NEG_DATA_0);
        rx_spa_neg_d_r[1]   <=  `DLY    (word_aligned_data_r[12:15] ==  SPA_NEG_DATA_1);
    end

    always @(posedge USER_CLK)
        RX_NEG   <=  `DLY  !rx_pe_control_r[1] &
                           ((rx_sp_neg_d_r == 2'b11)|
                            (rx_spa_neg_d_r == 2'b11));



    // Decode GOT_A.
    always @(posedge USER_CLK)
    begin
        got_a_d_r[0]   <=  `DLY    (RX_DATA[31:28]  ==  A_CHAR_0);
        got_a_d_r[1]   <=  `DLY    (RX_DATA[27:24]  ==  A_CHAR_1);
        got_a_d_r[2]   <=  `DLY    (RX_DATA[23:20]  ==  A_CHAR_0);
        got_a_d_r[3]   <=  `DLY    (RX_DATA[19:16]  ==  A_CHAR_1);
        got_a_d_r[4]   <=  `DLY    (RX_DATA[15:12]  ==  A_CHAR_0);
        got_a_d_r[5]   <=  `DLY    (RX_DATA[11:8]   ==  A_CHAR_1);
        got_a_d_r[6]   <=  `DLY    (RX_DATA[7:4]    ==  A_CHAR_0);
        got_a_d_r[7]   <=  `DLY    (RX_DATA[3:0]    ==  A_CHAR_1);
    end

    always @(posedge USER_CLK)
    begin
        GOT_A[0]    <=  `DLY RX_CHAR_IS_K[3] & (got_a_d_r[0:1] == 2'b11);
        GOT_A[1]    <=  `DLY RX_CHAR_IS_K[2] & (got_a_d_r[2:3] == 2'b11);
        GOT_A[2]    <=  `DLY RX_CHAR_IS_K[1] & (got_a_d_r[4:5] == 2'b11);
        GOT_A[3]    <=  `DLY RX_CHAR_IS_K[0] & (got_a_d_r[6:7] == 2'b11);
    end



    //_______________________Verification symbol decode__________________________



    // Indicate the SP sequence was received.
    always @(posedge USER_CLK)
    begin
        rx_v_d_r[0]     <=  `DLY    (word_aligned_data_r[0:3]   ==  K_CHAR_0);
        rx_v_d_r[1]     <=  `DLY    (word_aligned_data_r[4:7]   ==  K_CHAR_1);
        rx_v_d_r[2]     <=  `DLY    (word_aligned_data_r[8:11]  ==  VER_DATA_0);
        rx_v_d_r[3]     <=  `DLY    (word_aligned_data_r[12:15] ==  VER_DATA_1);
        rx_v_d_r[4]     <=  `DLY    (word_aligned_data_r[16:19] ==  VER_DATA_0);
        rx_v_d_r[5]     <=  `DLY    (word_aligned_data_r[20:23] ==  VER_DATA_1);
        rx_v_d_r[6]     <=  `DLY    (word_aligned_data_r[24:27] ==  VER_DATA_0);
        rx_v_d_r[7]     <=  `DLY    (word_aligned_data_r[28:31] ==  VER_DATA_1);
    end

    assign got_v_c  =   (rx_pe_control_r == 4'b1000) & (rx_v_d_r == 8'hFF);

    always @(posedge USER_CLK)
    begin
        GOT_V   <=  `DLY    got_v_c;
    end

    // Remember that the first V sequence has been detected.
    initial                 first_v_received_r  =   1'b0;

    always @(posedge USER_CLK)
        if(!LANE_UP)        first_v_received_r  <=  `DLY    1'b0;
        else if(got_v_c)    first_v_received_r  <=  `DLY    1'b1;

endmodule
