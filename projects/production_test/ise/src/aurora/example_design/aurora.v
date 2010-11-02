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
//  aurora
//
//
//  Description: This is the top level module for a 10 4-byte lane Aurora
//               reference design module with streaming interface. This module supports 
//               the following features:
//
//               * Supports Virtex 5 GTX
//               * Supports Virtex 6 GTX
//               * Supports Spartan 6 GTP
//


`timescale 1 ns / 1 ps
(* core_generation_info = "aurora,aurora_8b10b_v5_2,{backchannel_mode=Sidebands, c_aurora_lanes=10, c_column_used=left, c_gt_clock_1=GTXD1, c_gt_clock_2=None, c_gt_loc_1=1, c_gt_loc_10=10, c_gt_loc_11=X, c_gt_loc_12=X, c_gt_loc_13=X, c_gt_loc_14=X, c_gt_loc_15=X, c_gt_loc_16=X, c_gt_loc_17=X, c_gt_loc_18=X, c_gt_loc_19=X, c_gt_loc_2=2, c_gt_loc_20=X, c_gt_loc_21=X, c_gt_loc_22=X, c_gt_loc_23=X, c_gt_loc_24=X, c_gt_loc_25=X, c_gt_loc_26=X, c_gt_loc_27=X, c_gt_loc_28=X, c_gt_loc_29=X, c_gt_loc_3=3, c_gt_loc_30=X, c_gt_loc_31=X, c_gt_loc_32=X, c_gt_loc_33=X, c_gt_loc_34=X, c_gt_loc_35=X, c_gt_loc_36=X, c_gt_loc_37=X, c_gt_loc_38=X, c_gt_loc_39=X, c_gt_loc_4=4, c_gt_loc_40=X, c_gt_loc_41=X, c_gt_loc_42=X, c_gt_loc_43=X, c_gt_loc_44=X, c_gt_loc_45=X, c_gt_loc_46=X, c_gt_loc_47=X, c_gt_loc_48=X, c_gt_loc_5=5, c_gt_loc_6=6, c_gt_loc_7=7, c_gt_loc_8=8, c_gt_loc_9=9, c_lane_width=4, c_line_rate=6.5, c_nfc=false, c_nfc_mode=IMM, c_refclk_frequency=130.0, c_simplex=false, c_simplex_mode=TX, c_stream=true, c_ufc=false, flow_mode=None, interface_mode=Streaming, dataflow_config=Duplex}" *)
module aurora #
(
    parameter SIM_GTXRESET_SPEEDUP = 0
)
(
    // TX Stream Interface
    TX_D,
    TX_SRC_RDY_N,
    TX_DST_RDY_N,

    // RX Stream Interface
    RX_D,
    RX_SRC_RDY_N,

    //Clock Correction Interface
    DO_CC,
    WARN_CC,

    //GTX Serial I/O
    RXP,
    RXN,
    TXP,
    TXN,

    //GTX Reference Clock Interface
    GTXD1,

    //Error Detection Interface
    HARD_ERR,
    SOFT_ERR,

    //Status
    CHANNEL_UP,
    LANE_UP,
 
    //System Interface
    USER_CLK,
    SYNC_CLK,
    RESET,
    POWER_DOWN,
    LOOPBACK,
    GT_RESET,
    TX_OUT_CLK,
    TX_LOCK
);


`define DLY #1
    
//***********************************Port Declarations*******************************

    // TX Stream Interface
    input   [0:319]    TX_D;
    input              TX_SRC_RDY_N;
    output             TX_DST_RDY_N;

    // RX Stream Interface
    output  [0:319]    RX_D;
    output             RX_SRC_RDY_N;

    // Clock Correction Interface
    input              DO_CC;
    input              WARN_CC;
    
    //GTX Serial I/O
    input   [0:9]      RXP;
    input   [0:9]      RXN;
    output  [0:9]      TXP;
    output  [0:9]      TXN;

    //GTX Reference Clock Interface
    input              GTXD1;

    //Error Detection Interface
    output             HARD_ERR;
    output             SOFT_ERR;

    //Status
    output             CHANNEL_UP;
    output  [0:9]      LANE_UP;

    //System Interface
    input              USER_CLK;
    input              SYNC_CLK;
    input              RESET;
    input              POWER_DOWN;
    input   [2:0]      LOOPBACK;
    input              GT_RESET;
    output             TX_OUT_CLK;
    output             TX_LOCK;

//*********************************Wire Declarations**********************************

    wire    [0:9]      TX1N_OUT_unused;
    wire    [0:9]      TX1P_OUT_unused;
    wire    [0:9]      RX1N_IN_unused;
    wire    [0:9]      RX1P_IN_unused;
    wire    [9:0]      rx_buf_err_i_unused;
    wire    [39:0]     rx_char_is_comma_i_unused;
    wire    [39:0]     rx_char_is_k_i_unused;
    wire    [319:0]    rx_data_i_unused;
    wire    [39:0]     rx_disp_err_i_unused;
    wire    [39:0]     rx_not_in_table_i_unused;
    wire    [9:0]      rx_realign_i_unused;
    wire    [9:0]      tx_buf_err_i_unused;
    wire    [9:0]      ch_bond_done_i_unused;

    wire    [9:0]      ch_bond_done_i;
    reg     [9:0]      ch_bond_done_r1;
    reg     [9:0]      ch_bond_done_r2;
    wire    [49:0]     rx_status_float_i;    
    wire               channel_up_i;
    wire               en_chan_sync_i;
    wire    [9:0]      ena_comma_align_i;
    wire    [0:9]      gen_a_i;
    wire               gen_cc_i;
    wire               gen_ecp_i;
    wire    [0:1]      gen_ecp_striped_i;
    wire    [0:39]     gen_k_i;
    wire    [0:19]     gen_pad_i;
    wire    [0:19]     gen_pad_striped_i;
    wire    [0:39]     gen_r_i;
    wire               gen_scp_i;
    wire    [0:1]      gen_scp_striped_i;
    wire    [0:39]     gen_v_i;
    wire    [0:39]     got_a_i;
    wire    [0:9]      got_v_i;
    wire    [0:9]      hard_err_i;
    wire    [0:9]      lane_up_i;
    wire    [9:0]      pma_rx_lock_i;
    wire    [0:9]      raw_tx_out_clk_i;
    wire    [0:9]      reset_lanes_i;
    wire    [9:0]      rx_buf_err_i;
    wire    [39:0]     rx_char_is_comma_i;
    wire    [39:0]     rx_char_is_k_i;
    wire    [29:0]     rx_clk_cor_cnt_i;
    wire    [319:0]    rx_data_i;
    wire    [39:0]     rx_disp_err_i;
    wire    [0:19]     rx_ecp_i;
    wire    [0:19]     rx_ecp_striped_i;
    wire    [39:0]     rx_not_in_table_i;
    wire    [0:19]     rx_pad_i;
    wire    [0:19]     rx_pad_striped_i;
    wire    [0:319]    rx_pe_data_i;
    wire    [0:319]    rx_pe_data_striped_i;
    wire    [0:19]     rx_pe_data_v_i;
    wire    [0:19]     rx_pe_data_v_striped_i;
    wire    [9:0]      rx_polarity_i;
    wire    [9:0]      rx_realign_i;
    wire    [9:0]      rx_reset_i;
    wire    [0:19]     rx_scp_i;
    wire    [0:19]     rx_scp_striped_i;
    wire    [0:19]     soft_err_i;
    wire    [0:9]      all_soft_err_i;
    wire               start_rx_i;
    wire               tied_to_ground_i;
    wire    [31:0]     tied_to_ground_vec_i;
    wire               tied_to_vcc_i;
    wire    [9:0]      tx_buf_err_i;
    wire    [39:0]     tx_char_is_k_i;
    wire    [319:0]    tx_data_i;
    wire    [0:4]      tx_lock_i;
    wire    [0:9]      tx_out_clk_i;
    wire    [0:319]    tx_pe_data_i;
    wire    [0:319]    tx_pe_data_striped_i;
    wire    [0:19]     tx_pe_data_v_i;
    wire    [0:19]     tx_pe_data_v_striped_i;
    wire    [9:0]      tx_reset_i;
    reg     [0:9]      ch_bond_load_pulse_i;
    reg     [0:9]      ch_bond_done_dly_i;

//*********************************Main Body of Code**********************************



    //Tie off top level constants
    assign          tied_to_ground_vec_i    = 32'd0;
    assign          tied_to_ground_i        = 1'b0;
    assign          tied_to_vcc_i           = 1'b1;

    assign          all_soft_err_i[0] =  soft_err_i[0] | soft_err_i[1]  ;
    assign          all_soft_err_i[1] =  soft_err_i[2] | soft_err_i[3]  ;
    assign          all_soft_err_i[2] =  soft_err_i[4] | soft_err_i[5]  ;
    assign          all_soft_err_i[3] =  soft_err_i[6] | soft_err_i[7]  ;
    assign          all_soft_err_i[4] =  soft_err_i[8] | soft_err_i[9]  ;
    assign          all_soft_err_i[5] =  soft_err_i[10] | soft_err_i[11]  ;
    assign          all_soft_err_i[6] =  soft_err_i[12] | soft_err_i[13]  ;
    assign          all_soft_err_i[7] =  soft_err_i[14] | soft_err_i[15]  ;
    assign          all_soft_err_i[8] =  soft_err_i[16] | soft_err_i[17]  ;
    assign          all_soft_err_i[9] =  soft_err_i[18] | soft_err_i[19]  ;
    
    //Connect top level logic
    assign          CHANNEL_UP  =   channel_up_i;

    //Connect the TXOUTCLK of lane 0 to TX_OUT_CLK
    assign  TX_OUT_CLK  =   raw_tx_out_clk_i[0];
    
    assign  TX_LOCK          = &tx_lock_i;

    //_________________________Instantiate Lane 0______________________________




    assign          LANE_UP[0] =   lane_up_i[0];

    //Aurora lane striping rules require each 4-byte lane to carry 2 bytes from the first 
    //half of the overall word, and 2 bytes from the second half. This ensures that the 
    //data will be ordered correctly if it is send to a 2-byte lane. Here we perform the 
    //required concatenation
    
    assign  gen_scp_striped_i       =   {gen_scp_i,1'b0};
    assign  gen_pad_striped_i[0:1]  =  {gen_pad_i[0],gen_pad_i[10]};
    assign  tx_pe_data_striped_i[0:31]   =   {tx_pe_data_i[0:15],tx_pe_data_i[160:175]};
    assign  tx_pe_data_v_striped_i[0:1]  =   {tx_pe_data_v_i[0],tx_pe_data_v_i[10]};
    assign  {rx_pad_i[0],rx_pad_i[10]}    =   rx_pad_striped_i[0:1];
    assign  {rx_pe_data_i[0:15],rx_pe_data_i[160:175]}   =   rx_pe_data_striped_i[0:31];
    assign  {rx_pe_data_v_i[0],rx_pe_data_v_i[10]}  = rx_pe_data_v_striped_i[0:1];
    assign  {rx_scp_i[0],rx_scp_i[10]}  =   rx_scp_striped_i[0:1];
    assign  {rx_ecp_i[0],rx_ecp_i[10]}  =   rx_ecp_striped_i[0:1];
    
    
    



    aurora_AURORA_LANE_4BYTE aurora_aurora_lane_4byte_0_i
    (
        //GTX Interface
        .RX_DATA(rx_data_i[31:0]),
        .RX_NOT_IN_TABLE(rx_not_in_table_i[3:0]),
        .RX_DISP_ERR(rx_disp_err_i[3:0]),
        .RX_CHAR_IS_K(rx_char_is_k_i[3:0]),
        .RX_CHAR_IS_COMMA(rx_char_is_comma_i[3:0]),
        .RX_STATUS(tied_to_ground_vec_i[5:0]),
        .TX_BUF_ERR(tx_buf_err_i[0]),
        .RX_BUF_ERR(rx_buf_err_i[0]),
        .RX_REALIGN(rx_realign_i[0]),
        .RX_POLARITY(rx_polarity_i[0]),
        .RX_RESET(rx_reset_i[0]),
        .TX_CHAR_IS_K(tx_char_is_k_i[3:0]),
        .TX_DATA(tx_data_i[31:0]),
        .TX_RESET(tx_reset_i[0]),
        
        
        //Comma Detect Phase Align Interface
        .ENA_COMMA_ALIGN(ena_comma_align_i[0]),


        //TX_LL Interface
        .GEN_SCP(gen_scp_striped_i),
        .GEN_ECP(tied_to_ground_vec_i[1:0]),
        .GEN_PAD(gen_pad_striped_i[0:1]),
        .TX_PE_DATA(tx_pe_data_striped_i[0:31]),
        .TX_PE_DATA_V(tx_pe_data_v_striped_i[0:1]),
        .GEN_CC(gen_cc_i),


        //RX_LL Interface
        .RX_PAD(rx_pad_striped_i[0:1]),
        .RX_PE_DATA(rx_pe_data_striped_i[0:31]),
        .RX_PE_DATA_V(rx_pe_data_v_striped_i[0:1]),
        .RX_SCP(rx_scp_striped_i[0:1]),
        .RX_ECP(rx_ecp_striped_i[0:1]),


        //Global Logic Interface
        .GEN_A(gen_a_i[0]),
        .GEN_K(gen_k_i[0:3]),
        .GEN_R(gen_r_i[0:3]),
        .GEN_V(gen_v_i[0:3]),
        .LANE_UP(lane_up_i[0]),
        .SOFT_ERR(soft_err_i[0:1]),
        .HARD_ERR(hard_err_i[0]),
        .CHANNEL_BOND_LOAD(),
        .GOT_A(got_a_i[0:3]),
        .GOT_V(got_v_i[0]),


        //System Interface
        .USER_CLK(USER_CLK),
        .RESET_SYMGEN(RESET),
        .RESET(reset_lanes_i[0])
    );

    //_________________________Instantiate Lane 1______________________________




    assign          LANE_UP[1] =   lane_up_i[1];

    //Aurora lane striping rules require each 4-byte lane to carry 2 bytes from the first 
    //half of the overall word, and 2 bytes from the second half. This ensures that the 
    //data will be ordered correctly if it is send to a 2-byte lane. Here we perform the 
    //required concatenation
    assign  gen_pad_striped_i[2:3]  =  {gen_pad_i[1],gen_pad_i[11]};
    assign  tx_pe_data_striped_i[32:63]   =   {tx_pe_data_i[16:31],tx_pe_data_i[176:191]};
    assign  tx_pe_data_v_striped_i[2:3]  =   {tx_pe_data_v_i[1],tx_pe_data_v_i[11]};
    assign  {rx_pad_i[1],rx_pad_i[11]}    =   rx_pad_striped_i[2:3];
    assign  {rx_pe_data_i[16:31],rx_pe_data_i[176:191]}   =   rx_pe_data_striped_i[32:63];
    assign  {rx_pe_data_v_i[1],rx_pe_data_v_i[11]}  = rx_pe_data_v_striped_i[2:3];
    assign  {rx_scp_i[1],rx_scp_i[11]}  =   rx_scp_striped_i[2:3];
    assign  {rx_ecp_i[1],rx_ecp_i[11]}  =   rx_ecp_striped_i[2:3];
    
    
    



    aurora_AURORA_LANE_4BYTE aurora_aurora_lane_4byte_1_i
    (
        //GTX Interface
        .RX_DATA(rx_data_i[63:32]),
        .RX_NOT_IN_TABLE(rx_not_in_table_i[7:4]),
        .RX_DISP_ERR(rx_disp_err_i[7:4]),
        .RX_CHAR_IS_K(rx_char_is_k_i[7:4]),
        .RX_CHAR_IS_COMMA(rx_char_is_comma_i[7:4]),
        .RX_STATUS(tied_to_ground_vec_i[5:0]),
        .TX_BUF_ERR(tx_buf_err_i[1]),
        .RX_BUF_ERR(rx_buf_err_i[1]),
        .RX_REALIGN(rx_realign_i[1]),
        .RX_POLARITY(rx_polarity_i[1]),
        .RX_RESET(rx_reset_i[1]),
        .TX_CHAR_IS_K(tx_char_is_k_i[7:4]),
        .TX_DATA(tx_data_i[63:32]),
        .TX_RESET(tx_reset_i[1]),
        
        
        //Comma Detect Phase Align Interface
        .ENA_COMMA_ALIGN(ena_comma_align_i[1]),


        //TX_LL Interface
        .GEN_SCP(tied_to_ground_vec_i[1:0]),
        .GEN_ECP(tied_to_ground_vec_i[1:0]),
        .GEN_PAD(gen_pad_striped_i[2:3]),
        .TX_PE_DATA(tx_pe_data_striped_i[32:63]),
        .TX_PE_DATA_V(tx_pe_data_v_striped_i[2:3]),
        .GEN_CC(gen_cc_i),


        //RX_LL Interface
        .RX_PAD(rx_pad_striped_i[2:3]),
        .RX_PE_DATA(rx_pe_data_striped_i[32:63]),
        .RX_PE_DATA_V(rx_pe_data_v_striped_i[2:3]),
        .RX_SCP(rx_scp_striped_i[2:3]),
        .RX_ECP(rx_ecp_striped_i[2:3]),


        //Global Logic Interface
        .GEN_A(gen_a_i[1]),
        .GEN_K(gen_k_i[4:7]),
        .GEN_R(gen_r_i[4:7]),
        .GEN_V(gen_v_i[4:7]),
        .LANE_UP(lane_up_i[1]),
        .SOFT_ERR(soft_err_i[2:3]),
        .HARD_ERR(hard_err_i[1]),
        .CHANNEL_BOND_LOAD(),
        .GOT_A(got_a_i[4:7]),
        .GOT_V(got_v_i[1]),


        //System Interface
        .USER_CLK(USER_CLK),
        .RESET_SYMGEN(RESET),
        .RESET(reset_lanes_i[1])
    );

    //_________________________Instantiate Lane 2______________________________




    assign          LANE_UP[2] =   lane_up_i[2];

    //Aurora lane striping rules require each 4-byte lane to carry 2 bytes from the first 
    //half of the overall word, and 2 bytes from the second half. This ensures that the 
    //data will be ordered correctly if it is send to a 2-byte lane. Here we perform the 
    //required concatenation
    assign  gen_pad_striped_i[4:5]  =  {gen_pad_i[2],gen_pad_i[12]};
    assign  tx_pe_data_striped_i[64:95]   =   {tx_pe_data_i[32:47],tx_pe_data_i[192:207]};
    assign  tx_pe_data_v_striped_i[4:5]  =   {tx_pe_data_v_i[2],tx_pe_data_v_i[12]};
    assign  {rx_pad_i[2],rx_pad_i[12]}    =   rx_pad_striped_i[4:5];
    assign  {rx_pe_data_i[32:47],rx_pe_data_i[192:207]}   =   rx_pe_data_striped_i[64:95];
    assign  {rx_pe_data_v_i[2],rx_pe_data_v_i[12]}  = rx_pe_data_v_striped_i[4:5];
    assign  {rx_scp_i[2],rx_scp_i[12]}  =   rx_scp_striped_i[4:5];
    assign  {rx_ecp_i[2],rx_ecp_i[12]}  =   rx_ecp_striped_i[4:5];
    
    
    



    aurora_AURORA_LANE_4BYTE aurora_aurora_lane_4byte_2_i
    (
        //GTX Interface
        .RX_DATA(rx_data_i[95:64]),
        .RX_NOT_IN_TABLE(rx_not_in_table_i[11:8]),
        .RX_DISP_ERR(rx_disp_err_i[11:8]),
        .RX_CHAR_IS_K(rx_char_is_k_i[11:8]),
        .RX_CHAR_IS_COMMA(rx_char_is_comma_i[11:8]),
        .RX_STATUS(tied_to_ground_vec_i[5:0]),
        .TX_BUF_ERR(tx_buf_err_i[2]),
        .RX_BUF_ERR(rx_buf_err_i[2]),
        .RX_REALIGN(rx_realign_i[2]),
        .RX_POLARITY(rx_polarity_i[2]),
        .RX_RESET(rx_reset_i[2]),
        .TX_CHAR_IS_K(tx_char_is_k_i[11:8]),
        .TX_DATA(tx_data_i[95:64]),
        .TX_RESET(tx_reset_i[2]),
        
        
        //Comma Detect Phase Align Interface
        .ENA_COMMA_ALIGN(ena_comma_align_i[2]),


        //TX_LL Interface
        .GEN_SCP(tied_to_ground_vec_i[1:0]),
        .GEN_ECP(tied_to_ground_vec_i[1:0]),
        .GEN_PAD(gen_pad_striped_i[4:5]),
        .TX_PE_DATA(tx_pe_data_striped_i[64:95]),
        .TX_PE_DATA_V(tx_pe_data_v_striped_i[4:5]),
        .GEN_CC(gen_cc_i),


        //RX_LL Interface
        .RX_PAD(rx_pad_striped_i[4:5]),
        .RX_PE_DATA(rx_pe_data_striped_i[64:95]),
        .RX_PE_DATA_V(rx_pe_data_v_striped_i[4:5]),
        .RX_SCP(rx_scp_striped_i[4:5]),
        .RX_ECP(rx_ecp_striped_i[4:5]),


        //Global Logic Interface
        .GEN_A(gen_a_i[2]),
        .GEN_K(gen_k_i[8:11]),
        .GEN_R(gen_r_i[8:11]),
        .GEN_V(gen_v_i[8:11]),
        .LANE_UP(lane_up_i[2]),
        .SOFT_ERR(soft_err_i[4:5]),
        .HARD_ERR(hard_err_i[2]),
        .CHANNEL_BOND_LOAD(),
        .GOT_A(got_a_i[8:11]),
        .GOT_V(got_v_i[2]),


        //System Interface
        .USER_CLK(USER_CLK),
        .RESET_SYMGEN(RESET),
        .RESET(reset_lanes_i[2])
    );

    //_________________________Instantiate Lane 3______________________________




    assign          LANE_UP[3] =   lane_up_i[3];

    //Aurora lane striping rules require each 4-byte lane to carry 2 bytes from the first 
    //half of the overall word, and 2 bytes from the second half. This ensures that the 
    //data will be ordered correctly if it is send to a 2-byte lane. Here we perform the 
    //required concatenation
    assign  gen_pad_striped_i[6:7]  =  {gen_pad_i[3],gen_pad_i[13]};
    assign  tx_pe_data_striped_i[96:127]   =   {tx_pe_data_i[48:63],tx_pe_data_i[208:223]};
    assign  tx_pe_data_v_striped_i[6:7]  =   {tx_pe_data_v_i[3],tx_pe_data_v_i[13]};
    assign  {rx_pad_i[3],rx_pad_i[13]}    =   rx_pad_striped_i[6:7];
    assign  {rx_pe_data_i[48:63],rx_pe_data_i[208:223]}   =   rx_pe_data_striped_i[96:127];
    assign  {rx_pe_data_v_i[3],rx_pe_data_v_i[13]}  = rx_pe_data_v_striped_i[6:7];
    assign  {rx_scp_i[3],rx_scp_i[13]}  =   rx_scp_striped_i[6:7];
    assign  {rx_ecp_i[3],rx_ecp_i[13]}  =   rx_ecp_striped_i[6:7];
    
    
    



    aurora_AURORA_LANE_4BYTE aurora_aurora_lane_4byte_3_i
    (
        //GTX Interface
        .RX_DATA(rx_data_i[127:96]),
        .RX_NOT_IN_TABLE(rx_not_in_table_i[15:12]),
        .RX_DISP_ERR(rx_disp_err_i[15:12]),
        .RX_CHAR_IS_K(rx_char_is_k_i[15:12]),
        .RX_CHAR_IS_COMMA(rx_char_is_comma_i[15:12]),
        .RX_STATUS(tied_to_ground_vec_i[5:0]),
        .TX_BUF_ERR(tx_buf_err_i[3]),
        .RX_BUF_ERR(rx_buf_err_i[3]),
        .RX_REALIGN(rx_realign_i[3]),
        .RX_POLARITY(rx_polarity_i[3]),
        .RX_RESET(rx_reset_i[3]),
        .TX_CHAR_IS_K(tx_char_is_k_i[15:12]),
        .TX_DATA(tx_data_i[127:96]),
        .TX_RESET(tx_reset_i[3]),
        
        
        //Comma Detect Phase Align Interface
        .ENA_COMMA_ALIGN(ena_comma_align_i[3]),


        //TX_LL Interface
        .GEN_SCP(tied_to_ground_vec_i[1:0]),
        .GEN_ECP(tied_to_ground_vec_i[1:0]),
        .GEN_PAD(gen_pad_striped_i[6:7]),
        .TX_PE_DATA(tx_pe_data_striped_i[96:127]),
        .TX_PE_DATA_V(tx_pe_data_v_striped_i[6:7]),
        .GEN_CC(gen_cc_i),


        //RX_LL Interface
        .RX_PAD(rx_pad_striped_i[6:7]),
        .RX_PE_DATA(rx_pe_data_striped_i[96:127]),
        .RX_PE_DATA_V(rx_pe_data_v_striped_i[6:7]),
        .RX_SCP(rx_scp_striped_i[6:7]),
        .RX_ECP(rx_ecp_striped_i[6:7]),


        //Global Logic Interface
        .GEN_A(gen_a_i[3]),
        .GEN_K(gen_k_i[12:15]),
        .GEN_R(gen_r_i[12:15]),
        .GEN_V(gen_v_i[12:15]),
        .LANE_UP(lane_up_i[3]),
        .SOFT_ERR(soft_err_i[6:7]),
        .HARD_ERR(hard_err_i[3]),
        .CHANNEL_BOND_LOAD(),
        .GOT_A(got_a_i[12:15]),
        .GOT_V(got_v_i[3]),


        //System Interface
        .USER_CLK(USER_CLK),
        .RESET_SYMGEN(RESET),
        .RESET(reset_lanes_i[3])
    );

    //_________________________Instantiate Lane 4______________________________




    assign          LANE_UP[4] =   lane_up_i[4];

    //Aurora lane striping rules require each 4-byte lane to carry 2 bytes from the first 
    //half of the overall word, and 2 bytes from the second half. This ensures that the 
    //data will be ordered correctly if it is send to a 2-byte lane. Here we perform the 
    //required concatenation
    assign  gen_pad_striped_i[8:9]  =  {gen_pad_i[4],gen_pad_i[14]};
    assign  tx_pe_data_striped_i[128:159]   =   {tx_pe_data_i[64:79],tx_pe_data_i[224:239]};
    assign  tx_pe_data_v_striped_i[8:9]  =   {tx_pe_data_v_i[4],tx_pe_data_v_i[14]};
    assign  {rx_pad_i[4],rx_pad_i[14]}    =   rx_pad_striped_i[8:9];
    assign  {rx_pe_data_i[64:79],rx_pe_data_i[224:239]}   =   rx_pe_data_striped_i[128:159];
    assign  {rx_pe_data_v_i[4],rx_pe_data_v_i[14]}  = rx_pe_data_v_striped_i[8:9];
    assign  {rx_scp_i[4],rx_scp_i[14]}  =   rx_scp_striped_i[8:9];
    assign  {rx_ecp_i[4],rx_ecp_i[14]}  =   rx_ecp_striped_i[8:9];
    
    
    



    aurora_AURORA_LANE_4BYTE aurora_aurora_lane_4byte_4_i
    (
        //GTX Interface
        .RX_DATA(rx_data_i[159:128]),
        .RX_NOT_IN_TABLE(rx_not_in_table_i[19:16]),
        .RX_DISP_ERR(rx_disp_err_i[19:16]),
        .RX_CHAR_IS_K(rx_char_is_k_i[19:16]),
        .RX_CHAR_IS_COMMA(rx_char_is_comma_i[19:16]),
        .RX_STATUS(tied_to_ground_vec_i[5:0]),
        .TX_BUF_ERR(tx_buf_err_i[4]),
        .RX_BUF_ERR(rx_buf_err_i[4]),
        .RX_REALIGN(rx_realign_i[4]),
        .RX_POLARITY(rx_polarity_i[4]),
        .RX_RESET(rx_reset_i[4]),
        .TX_CHAR_IS_K(tx_char_is_k_i[19:16]),
        .TX_DATA(tx_data_i[159:128]),
        .TX_RESET(tx_reset_i[4]),
        
        
        //Comma Detect Phase Align Interface
        .ENA_COMMA_ALIGN(ena_comma_align_i[4]),


        //TX_LL Interface
        .GEN_SCP(tied_to_ground_vec_i[1:0]),
        .GEN_ECP(tied_to_ground_vec_i[1:0]),
        .GEN_PAD(gen_pad_striped_i[8:9]),
        .TX_PE_DATA(tx_pe_data_striped_i[128:159]),
        .TX_PE_DATA_V(tx_pe_data_v_striped_i[8:9]),
        .GEN_CC(gen_cc_i),


        //RX_LL Interface
        .RX_PAD(rx_pad_striped_i[8:9]),
        .RX_PE_DATA(rx_pe_data_striped_i[128:159]),
        .RX_PE_DATA_V(rx_pe_data_v_striped_i[8:9]),
        .RX_SCP(rx_scp_striped_i[8:9]),
        .RX_ECP(rx_ecp_striped_i[8:9]),


        //Global Logic Interface
        .GEN_A(gen_a_i[4]),
        .GEN_K(gen_k_i[16:19]),
        .GEN_R(gen_r_i[16:19]),
        .GEN_V(gen_v_i[16:19]),
        .LANE_UP(lane_up_i[4]),
        .SOFT_ERR(soft_err_i[8:9]),
        .HARD_ERR(hard_err_i[4]),
        .CHANNEL_BOND_LOAD(),
        .GOT_A(got_a_i[16:19]),
        .GOT_V(got_v_i[4]),


        //System Interface
        .USER_CLK(USER_CLK),
        .RESET_SYMGEN(RESET),
        .RESET(reset_lanes_i[4])
    );

    //_________________________Instantiate Lane 5______________________________




    assign          LANE_UP[5] =   lane_up_i[5];

    //Aurora lane striping rules require each 4-byte lane to carry 2 bytes from the first 
    //half of the overall word, and 2 bytes from the second half. This ensures that the 
    //data will be ordered correctly if it is send to a 2-byte lane. Here we perform the 
    //required concatenation
    assign  gen_pad_striped_i[10:11]  =  {gen_pad_i[5],gen_pad_i[15]};
    assign  tx_pe_data_striped_i[160:191]   =   {tx_pe_data_i[80:95],tx_pe_data_i[240:255]};
    assign  tx_pe_data_v_striped_i[10:11]  =   {tx_pe_data_v_i[5],tx_pe_data_v_i[15]};
    assign  {rx_pad_i[5],rx_pad_i[15]}    =   rx_pad_striped_i[10:11];
    assign  {rx_pe_data_i[80:95],rx_pe_data_i[240:255]}   =   rx_pe_data_striped_i[160:191];
    assign  {rx_pe_data_v_i[5],rx_pe_data_v_i[15]}  = rx_pe_data_v_striped_i[10:11];
    assign  {rx_scp_i[5],rx_scp_i[15]}  =   rx_scp_striped_i[10:11];
    assign  {rx_ecp_i[5],rx_ecp_i[15]}  =   rx_ecp_striped_i[10:11];
    
    
    



    aurora_AURORA_LANE_4BYTE aurora_aurora_lane_4byte_5_i
    (
        //GTX Interface
        .RX_DATA(rx_data_i[191:160]),
        .RX_NOT_IN_TABLE(rx_not_in_table_i[23:20]),
        .RX_DISP_ERR(rx_disp_err_i[23:20]),
        .RX_CHAR_IS_K(rx_char_is_k_i[23:20]),
        .RX_CHAR_IS_COMMA(rx_char_is_comma_i[23:20]),
        .RX_STATUS(tied_to_ground_vec_i[5:0]),
        .TX_BUF_ERR(tx_buf_err_i[5]),
        .RX_BUF_ERR(rx_buf_err_i[5]),
        .RX_REALIGN(rx_realign_i[5]),
        .RX_POLARITY(rx_polarity_i[5]),
        .RX_RESET(rx_reset_i[5]),
        .TX_CHAR_IS_K(tx_char_is_k_i[23:20]),
        .TX_DATA(tx_data_i[191:160]),
        .TX_RESET(tx_reset_i[5]),
        
        
        //Comma Detect Phase Align Interface
        .ENA_COMMA_ALIGN(ena_comma_align_i[5]),


        //TX_LL Interface
        .GEN_SCP(tied_to_ground_vec_i[1:0]),
        .GEN_ECP(tied_to_ground_vec_i[1:0]),
        .GEN_PAD(gen_pad_striped_i[10:11]),
        .TX_PE_DATA(tx_pe_data_striped_i[160:191]),
        .TX_PE_DATA_V(tx_pe_data_v_striped_i[10:11]),
        .GEN_CC(gen_cc_i),


        //RX_LL Interface
        .RX_PAD(rx_pad_striped_i[10:11]),
        .RX_PE_DATA(rx_pe_data_striped_i[160:191]),
        .RX_PE_DATA_V(rx_pe_data_v_striped_i[10:11]),
        .RX_SCP(rx_scp_striped_i[10:11]),
        .RX_ECP(rx_ecp_striped_i[10:11]),


        //Global Logic Interface
        .GEN_A(gen_a_i[5]),
        .GEN_K(gen_k_i[20:23]),
        .GEN_R(gen_r_i[20:23]),
        .GEN_V(gen_v_i[20:23]),
        .LANE_UP(lane_up_i[5]),
        .SOFT_ERR(soft_err_i[10:11]),
        .HARD_ERR(hard_err_i[5]),
        .CHANNEL_BOND_LOAD(),
        .GOT_A(got_a_i[20:23]),
        .GOT_V(got_v_i[5]),


        //System Interface
        .USER_CLK(USER_CLK),
        .RESET_SYMGEN(RESET),
        .RESET(reset_lanes_i[5])
    );

    //_________________________Instantiate Lane 6______________________________




    assign          LANE_UP[6] =   lane_up_i[6];

    //Aurora lane striping rules require each 4-byte lane to carry 2 bytes from the first 
    //half of the overall word, and 2 bytes from the second half. This ensures that the 
    //data will be ordered correctly if it is send to a 2-byte lane. Here we perform the 
    //required concatenation
    assign  gen_pad_striped_i[12:13]  =  {gen_pad_i[6],gen_pad_i[16]};
    assign  tx_pe_data_striped_i[192:223]   =   {tx_pe_data_i[96:111],tx_pe_data_i[256:271]};
    assign  tx_pe_data_v_striped_i[12:13]  =   {tx_pe_data_v_i[6],tx_pe_data_v_i[16]};
    assign  {rx_pad_i[6],rx_pad_i[16]}    =   rx_pad_striped_i[12:13];
    assign  {rx_pe_data_i[96:111],rx_pe_data_i[256:271]}   =   rx_pe_data_striped_i[192:223];
    assign  {rx_pe_data_v_i[6],rx_pe_data_v_i[16]}  = rx_pe_data_v_striped_i[12:13];
    assign  {rx_scp_i[6],rx_scp_i[16]}  =   rx_scp_striped_i[12:13];
    assign  {rx_ecp_i[6],rx_ecp_i[16]}  =   rx_ecp_striped_i[12:13];
    
    
    



    aurora_AURORA_LANE_4BYTE aurora_aurora_lane_4byte_6_i
    (
        //GTX Interface
        .RX_DATA(rx_data_i[223:192]),
        .RX_NOT_IN_TABLE(rx_not_in_table_i[27:24]),
        .RX_DISP_ERR(rx_disp_err_i[27:24]),
        .RX_CHAR_IS_K(rx_char_is_k_i[27:24]),
        .RX_CHAR_IS_COMMA(rx_char_is_comma_i[27:24]),
        .RX_STATUS(tied_to_ground_vec_i[5:0]),
        .TX_BUF_ERR(tx_buf_err_i[6]),
        .RX_BUF_ERR(rx_buf_err_i[6]),
        .RX_REALIGN(rx_realign_i[6]),
        .RX_POLARITY(rx_polarity_i[6]),
        .RX_RESET(rx_reset_i[6]),
        .TX_CHAR_IS_K(tx_char_is_k_i[27:24]),
        .TX_DATA(tx_data_i[223:192]),
        .TX_RESET(tx_reset_i[6]),
        
        
        //Comma Detect Phase Align Interface
        .ENA_COMMA_ALIGN(ena_comma_align_i[6]),


        //TX_LL Interface
        .GEN_SCP(tied_to_ground_vec_i[1:0]),
        .GEN_ECP(tied_to_ground_vec_i[1:0]),
        .GEN_PAD(gen_pad_striped_i[12:13]),
        .TX_PE_DATA(tx_pe_data_striped_i[192:223]),
        .TX_PE_DATA_V(tx_pe_data_v_striped_i[12:13]),
        .GEN_CC(gen_cc_i),


        //RX_LL Interface
        .RX_PAD(rx_pad_striped_i[12:13]),
        .RX_PE_DATA(rx_pe_data_striped_i[192:223]),
        .RX_PE_DATA_V(rx_pe_data_v_striped_i[12:13]),
        .RX_SCP(rx_scp_striped_i[12:13]),
        .RX_ECP(rx_ecp_striped_i[12:13]),


        //Global Logic Interface
        .GEN_A(gen_a_i[6]),
        .GEN_K(gen_k_i[24:27]),
        .GEN_R(gen_r_i[24:27]),
        .GEN_V(gen_v_i[24:27]),
        .LANE_UP(lane_up_i[6]),
        .SOFT_ERR(soft_err_i[12:13]),
        .HARD_ERR(hard_err_i[6]),
        .CHANNEL_BOND_LOAD(),
        .GOT_A(got_a_i[24:27]),
        .GOT_V(got_v_i[6]),


        //System Interface
        .USER_CLK(USER_CLK),
        .RESET_SYMGEN(RESET),
        .RESET(reset_lanes_i[6])
    );

    //_________________________Instantiate Lane 7______________________________




    assign          LANE_UP[7] =   lane_up_i[7];

    //Aurora lane striping rules require each 4-byte lane to carry 2 bytes from the first 
    //half of the overall word, and 2 bytes from the second half. This ensures that the 
    //data will be ordered correctly if it is send to a 2-byte lane. Here we perform the 
    //required concatenation
    assign  gen_pad_striped_i[14:15]  =  {gen_pad_i[7],gen_pad_i[17]};
    assign  tx_pe_data_striped_i[224:255]   =   {tx_pe_data_i[112:127],tx_pe_data_i[272:287]};
    assign  tx_pe_data_v_striped_i[14:15]  =   {tx_pe_data_v_i[7],tx_pe_data_v_i[17]};
    assign  {rx_pad_i[7],rx_pad_i[17]}    =   rx_pad_striped_i[14:15];
    assign  {rx_pe_data_i[112:127],rx_pe_data_i[272:287]}   =   rx_pe_data_striped_i[224:255];
    assign  {rx_pe_data_v_i[7],rx_pe_data_v_i[17]}  = rx_pe_data_v_striped_i[14:15];
    assign  {rx_scp_i[7],rx_scp_i[17]}  =   rx_scp_striped_i[14:15];
    assign  {rx_ecp_i[7],rx_ecp_i[17]}  =   rx_ecp_striped_i[14:15];
    
    
    



    aurora_AURORA_LANE_4BYTE aurora_aurora_lane_4byte_7_i
    (
        //GTX Interface
        .RX_DATA(rx_data_i[255:224]),
        .RX_NOT_IN_TABLE(rx_not_in_table_i[31:28]),
        .RX_DISP_ERR(rx_disp_err_i[31:28]),
        .RX_CHAR_IS_K(rx_char_is_k_i[31:28]),
        .RX_CHAR_IS_COMMA(rx_char_is_comma_i[31:28]),
        .RX_STATUS(tied_to_ground_vec_i[5:0]),
        .TX_BUF_ERR(tx_buf_err_i[7]),
        .RX_BUF_ERR(rx_buf_err_i[7]),
        .RX_REALIGN(rx_realign_i[7]),
        .RX_POLARITY(rx_polarity_i[7]),
        .RX_RESET(rx_reset_i[7]),
        .TX_CHAR_IS_K(tx_char_is_k_i[31:28]),
        .TX_DATA(tx_data_i[255:224]),
        .TX_RESET(tx_reset_i[7]),
        
        
        //Comma Detect Phase Align Interface
        .ENA_COMMA_ALIGN(ena_comma_align_i[7]),


        //TX_LL Interface
        .GEN_SCP(tied_to_ground_vec_i[1:0]),
        .GEN_ECP(tied_to_ground_vec_i[1:0]),
        .GEN_PAD(gen_pad_striped_i[14:15]),
        .TX_PE_DATA(tx_pe_data_striped_i[224:255]),
        .TX_PE_DATA_V(tx_pe_data_v_striped_i[14:15]),
        .GEN_CC(gen_cc_i),


        //RX_LL Interface
        .RX_PAD(rx_pad_striped_i[14:15]),
        .RX_PE_DATA(rx_pe_data_striped_i[224:255]),
        .RX_PE_DATA_V(rx_pe_data_v_striped_i[14:15]),
        .RX_SCP(rx_scp_striped_i[14:15]),
        .RX_ECP(rx_ecp_striped_i[14:15]),


        //Global Logic Interface
        .GEN_A(gen_a_i[7]),
        .GEN_K(gen_k_i[28:31]),
        .GEN_R(gen_r_i[28:31]),
        .GEN_V(gen_v_i[28:31]),
        .LANE_UP(lane_up_i[7]),
        .SOFT_ERR(soft_err_i[14:15]),
        .HARD_ERR(hard_err_i[7]),
        .CHANNEL_BOND_LOAD(),
        .GOT_A(got_a_i[28:31]),
        .GOT_V(got_v_i[7]),


        //System Interface
        .USER_CLK(USER_CLK),
        .RESET_SYMGEN(RESET),
        .RESET(reset_lanes_i[7])
    );

    //_________________________Instantiate Lane 8______________________________




    assign          LANE_UP[8] =   lane_up_i[8];

    //Aurora lane striping rules require each 4-byte lane to carry 2 bytes from the first 
    //half of the overall word, and 2 bytes from the second half. This ensures that the 
    //data will be ordered correctly if it is send to a 2-byte lane. Here we perform the 
    //required concatenation
    assign  gen_pad_striped_i[16:17]  =  {gen_pad_i[8],gen_pad_i[18]};
    assign  tx_pe_data_striped_i[256:287]   =   {tx_pe_data_i[128:143],tx_pe_data_i[288:303]};
    assign  tx_pe_data_v_striped_i[16:17]  =   {tx_pe_data_v_i[8],tx_pe_data_v_i[18]};
    assign  {rx_pad_i[8],rx_pad_i[18]}    =   rx_pad_striped_i[16:17];
    assign  {rx_pe_data_i[128:143],rx_pe_data_i[288:303]}   =   rx_pe_data_striped_i[256:287];
    assign  {rx_pe_data_v_i[8],rx_pe_data_v_i[18]}  = rx_pe_data_v_striped_i[16:17];
    assign  {rx_scp_i[8],rx_scp_i[18]}  =   rx_scp_striped_i[16:17];
    assign  {rx_ecp_i[8],rx_ecp_i[18]}  =   rx_ecp_striped_i[16:17];
    
    
    



    aurora_AURORA_LANE_4BYTE aurora_aurora_lane_4byte_8_i
    (
        //GTX Interface
        .RX_DATA(rx_data_i[287:256]),
        .RX_NOT_IN_TABLE(rx_not_in_table_i[35:32]),
        .RX_DISP_ERR(rx_disp_err_i[35:32]),
        .RX_CHAR_IS_K(rx_char_is_k_i[35:32]),
        .RX_CHAR_IS_COMMA(rx_char_is_comma_i[35:32]),
        .RX_STATUS(tied_to_ground_vec_i[5:0]),
        .TX_BUF_ERR(tx_buf_err_i[8]),
        .RX_BUF_ERR(rx_buf_err_i[8]),
        .RX_REALIGN(rx_realign_i[8]),
        .RX_POLARITY(rx_polarity_i[8]),
        .RX_RESET(rx_reset_i[8]),
        .TX_CHAR_IS_K(tx_char_is_k_i[35:32]),
        .TX_DATA(tx_data_i[287:256]),
        .TX_RESET(tx_reset_i[8]),
        
        
        //Comma Detect Phase Align Interface
        .ENA_COMMA_ALIGN(ena_comma_align_i[8]),


        //TX_LL Interface
        .GEN_SCP(tied_to_ground_vec_i[1:0]),
        .GEN_ECP(tied_to_ground_vec_i[1:0]),
        .GEN_PAD(gen_pad_striped_i[16:17]),
        .TX_PE_DATA(tx_pe_data_striped_i[256:287]),
        .TX_PE_DATA_V(tx_pe_data_v_striped_i[16:17]),
        .GEN_CC(gen_cc_i),


        //RX_LL Interface
        .RX_PAD(rx_pad_striped_i[16:17]),
        .RX_PE_DATA(rx_pe_data_striped_i[256:287]),
        .RX_PE_DATA_V(rx_pe_data_v_striped_i[16:17]),
        .RX_SCP(rx_scp_striped_i[16:17]),
        .RX_ECP(rx_ecp_striped_i[16:17]),


        //Global Logic Interface
        .GEN_A(gen_a_i[8]),
        .GEN_K(gen_k_i[32:35]),
        .GEN_R(gen_r_i[32:35]),
        .GEN_V(gen_v_i[32:35]),
        .LANE_UP(lane_up_i[8]),
        .SOFT_ERR(soft_err_i[16:17]),
        .HARD_ERR(hard_err_i[8]),
        .CHANNEL_BOND_LOAD(),
        .GOT_A(got_a_i[32:35]),
        .GOT_V(got_v_i[8]),


        //System Interface
        .USER_CLK(USER_CLK),
        .RESET_SYMGEN(RESET),
        .RESET(reset_lanes_i[8])
    );

    //_________________________Instantiate Lane 9______________________________




    assign          LANE_UP[9] =   lane_up_i[9];

    //Aurora lane striping rules require each 4-byte lane to carry 2 bytes from the first 
    //half of the overall word, and 2 bytes from the second half. This ensures that the 
    //data will be ordered correctly if it is send to a 2-byte lane. Here we perform the 
    //required concatenation
    assign  gen_ecp_striped_i       =   {1'b0,gen_ecp_i};
    assign  gen_pad_striped_i[18:19]  =  {gen_pad_i[9],gen_pad_i[19]};
    assign  tx_pe_data_striped_i[288:319]   =   {tx_pe_data_i[144:159],tx_pe_data_i[304:319]};
    assign  tx_pe_data_v_striped_i[18:19]  =   {tx_pe_data_v_i[9],tx_pe_data_v_i[19]};
    assign  {rx_pad_i[9],rx_pad_i[19]}    =   rx_pad_striped_i[18:19];
    assign  {rx_pe_data_i[144:159],rx_pe_data_i[304:319]}   =   rx_pe_data_striped_i[288:319];
    assign  {rx_pe_data_v_i[9],rx_pe_data_v_i[19]}  = rx_pe_data_v_striped_i[18:19];
    assign  {rx_scp_i[9],rx_scp_i[19]}  =   rx_scp_striped_i[18:19];
    assign  {rx_ecp_i[9],rx_ecp_i[19]}  =   rx_ecp_striped_i[18:19];
    
    
    



    aurora_AURORA_LANE_4BYTE aurora_aurora_lane_4byte_9_i
    (
        //GTX Interface
        .RX_DATA(rx_data_i[319:288]),
        .RX_NOT_IN_TABLE(rx_not_in_table_i[39:36]),
        .RX_DISP_ERR(rx_disp_err_i[39:36]),
        .RX_CHAR_IS_K(rx_char_is_k_i[39:36]),
        .RX_CHAR_IS_COMMA(rx_char_is_comma_i[39:36]),
        .RX_STATUS(tied_to_ground_vec_i[5:0]),
        .TX_BUF_ERR(tx_buf_err_i[9]),
        .RX_BUF_ERR(rx_buf_err_i[9]),
        .RX_REALIGN(rx_realign_i[9]),
        .RX_POLARITY(rx_polarity_i[9]),
        .RX_RESET(rx_reset_i[9]),
        .TX_CHAR_IS_K(tx_char_is_k_i[39:36]),
        .TX_DATA(tx_data_i[319:288]),
        .TX_RESET(tx_reset_i[9]),
        
        
        //Comma Detect Phase Align Interface
        .ENA_COMMA_ALIGN(ena_comma_align_i[9]),


        //TX_LL Interface
        .GEN_SCP(tied_to_ground_vec_i[1:0]),
        .GEN_ECP(gen_ecp_striped_i),
        .GEN_PAD(gen_pad_striped_i[18:19]),
        .TX_PE_DATA(tx_pe_data_striped_i[288:319]),
        .TX_PE_DATA_V(tx_pe_data_v_striped_i[18:19]),
        .GEN_CC(gen_cc_i),


        //RX_LL Interface
        .RX_PAD(rx_pad_striped_i[18:19]),
        .RX_PE_DATA(rx_pe_data_striped_i[288:319]),
        .RX_PE_DATA_V(rx_pe_data_v_striped_i[18:19]),
        .RX_SCP(rx_scp_striped_i[18:19]),
        .RX_ECP(rx_ecp_striped_i[18:19]),


        //Global Logic Interface
        .GEN_A(gen_a_i[9]),
        .GEN_K(gen_k_i[36:39]),
        .GEN_R(gen_r_i[36:39]),
        .GEN_V(gen_v_i[36:39]),
        .LANE_UP(lane_up_i[9]),
        .SOFT_ERR(soft_err_i[18:19]),
        .HARD_ERR(hard_err_i[9]),
        .CHANNEL_BOND_LOAD(),
        .GOT_A(got_a_i[36:39]),
        .GOT_V(got_v_i[9]),


        //System Interface
        .USER_CLK(USER_CLK),
        .RESET_SYMGEN(RESET),
        .RESET(reset_lanes_i[9])
    );


    
    
    

    //_________________________Instantiate GTX Wrapper ______________________________

 
    aurora_GTX_WRAPPER #
    (
             .SIM_GTXRESET_SPEEDUP(SIM_GTXRESET_SPEEDUP)
    )

    gtx_wrapper_i

    (
   
        //Aurora Lane Interface
        .RXPOLARITY_IN(rx_polarity_i[0]),
        .RXPOLARITY_IN_LANE1(rx_polarity_i[1]),
        .RXPOLARITY_IN_LANE2(rx_polarity_i[2]),
        .RXPOLARITY_IN_LANE3(rx_polarity_i[3]),
        .RXPOLARITY_IN_LANE4(rx_polarity_i[4]),
        .RXPOLARITY_IN_LANE5(rx_polarity_i[5]),
        .RXPOLARITY_IN_LANE6(rx_polarity_i[6]),
        .RXPOLARITY_IN_LANE7(rx_polarity_i[7]),
        .RXPOLARITY_IN_LANE8(rx_polarity_i[8]),
        .RXPOLARITY_IN_LANE9(rx_polarity_i[9]),
        .RXRESET_IN(rx_reset_i[0]),
        .RXRESET_IN_LANE1(rx_reset_i[1]),
        .RXRESET_IN_LANE2(rx_reset_i[2]),
        .RXRESET_IN_LANE3(rx_reset_i[3]),
        .RXRESET_IN_LANE4(rx_reset_i[4]),
        .RXRESET_IN_LANE5(rx_reset_i[5]),
        .RXRESET_IN_LANE6(rx_reset_i[6]),
        .RXRESET_IN_LANE7(rx_reset_i[7]),
        .RXRESET_IN_LANE8(rx_reset_i[8]),
        .RXRESET_IN_LANE9(rx_reset_i[9]),
        .TXCHARISK_IN(tx_char_is_k_i[3:0]),
        .TXCHARISK_IN_LANE1(tx_char_is_k_i[7:4]),
        .TXCHARISK_IN_LANE2(tx_char_is_k_i[11:8]),
        .TXCHARISK_IN_LANE3(tx_char_is_k_i[15:12]),
        .TXCHARISK_IN_LANE4(tx_char_is_k_i[19:16]),
        .TXCHARISK_IN_LANE5(tx_char_is_k_i[23:20]),
        .TXCHARISK_IN_LANE6(tx_char_is_k_i[27:24]),
        .TXCHARISK_IN_LANE7(tx_char_is_k_i[31:28]),
        .TXCHARISK_IN_LANE8(tx_char_is_k_i[35:32]),
        .TXCHARISK_IN_LANE9(tx_char_is_k_i[39:36]),
        .TXDATA_IN(tx_data_i[31:0]),
        .TXDATA_IN_LANE1(tx_data_i[63:32]),
        .TXDATA_IN_LANE2(tx_data_i[95:64]),
        .TXDATA_IN_LANE3(tx_data_i[127:96]),
        .TXDATA_IN_LANE4(tx_data_i[159:128]),
        .TXDATA_IN_LANE5(tx_data_i[191:160]),
        .TXDATA_IN_LANE6(tx_data_i[223:192]),
        .TXDATA_IN_LANE7(tx_data_i[255:224]),
        .TXDATA_IN_LANE8(tx_data_i[287:256]),
        .TXDATA_IN_LANE9(tx_data_i[319:288]),
        .TXRESET_IN(tx_reset_i[0]),
        .TXRESET_IN_LANE1(tx_reset_i[1]),
        .TXRESET_IN_LANE2(tx_reset_i[2]),
        .TXRESET_IN_LANE3(tx_reset_i[3]),
        .TXRESET_IN_LANE4(tx_reset_i[4]),
        .TXRESET_IN_LANE5(tx_reset_i[5]),
        .TXRESET_IN_LANE6(tx_reset_i[6]),
        .TXRESET_IN_LANE7(tx_reset_i[7]),
        .TXRESET_IN_LANE8(tx_reset_i[8]),
        .TXRESET_IN_LANE9(tx_reset_i[9]),
        .RXDATA_OUT(rx_data_i[31:0]),
        .RXDATA_OUT_LANE1(rx_data_i[63:32]),
        .RXDATA_OUT_LANE2(rx_data_i[95:64]),
        .RXDATA_OUT_LANE3(rx_data_i[127:96]),
        .RXDATA_OUT_LANE4(rx_data_i[159:128]),
        .RXDATA_OUT_LANE5(rx_data_i[191:160]),
        .RXDATA_OUT_LANE6(rx_data_i[223:192]),
        .RXDATA_OUT_LANE7(rx_data_i[255:224]),
        .RXDATA_OUT_LANE8(rx_data_i[287:256]),
        .RXDATA_OUT_LANE9(rx_data_i[319:288]),
        .RXNOTINTABLE_OUT(rx_not_in_table_i[3:0]),
        .RXNOTINTABLE_OUT_LANE1(rx_not_in_table_i[7:4]),
        .RXNOTINTABLE_OUT_LANE2(rx_not_in_table_i[11:8]),
        .RXNOTINTABLE_OUT_LANE3(rx_not_in_table_i[15:12]),
        .RXNOTINTABLE_OUT_LANE4(rx_not_in_table_i[19:16]),
        .RXNOTINTABLE_OUT_LANE5(rx_not_in_table_i[23:20]),
        .RXNOTINTABLE_OUT_LANE6(rx_not_in_table_i[27:24]),
        .RXNOTINTABLE_OUT_LANE7(rx_not_in_table_i[31:28]),
        .RXNOTINTABLE_OUT_LANE8(rx_not_in_table_i[35:32]),
        .RXNOTINTABLE_OUT_LANE9(rx_not_in_table_i[39:36]),
        .RXDISPERR_OUT(rx_disp_err_i[3:0]),
        .RXDISPERR_OUT_LANE1(rx_disp_err_i[7:4]),
        .RXDISPERR_OUT_LANE2(rx_disp_err_i[11:8]),
        .RXDISPERR_OUT_LANE3(rx_disp_err_i[15:12]),
        .RXDISPERR_OUT_LANE4(rx_disp_err_i[19:16]),
        .RXDISPERR_OUT_LANE5(rx_disp_err_i[23:20]),
        .RXDISPERR_OUT_LANE6(rx_disp_err_i[27:24]),
        .RXDISPERR_OUT_LANE7(rx_disp_err_i[31:28]),
        .RXDISPERR_OUT_LANE8(rx_disp_err_i[35:32]),
        .RXDISPERR_OUT_LANE9(rx_disp_err_i[39:36]),
        .RXCHARISK_OUT(rx_char_is_k_i[3:0]),
        .RXCHARISK_OUT_LANE1(rx_char_is_k_i[7:4]),
        .RXCHARISK_OUT_LANE2(rx_char_is_k_i[11:8]),
        .RXCHARISK_OUT_LANE3(rx_char_is_k_i[15:12]),
        .RXCHARISK_OUT_LANE4(rx_char_is_k_i[19:16]),
        .RXCHARISK_OUT_LANE5(rx_char_is_k_i[23:20]),
        .RXCHARISK_OUT_LANE6(rx_char_is_k_i[27:24]),
        .RXCHARISK_OUT_LANE7(rx_char_is_k_i[31:28]),
        .RXCHARISK_OUT_LANE8(rx_char_is_k_i[35:32]),
        .RXCHARISK_OUT_LANE9(rx_char_is_k_i[39:36]),
        .RXCHARISCOMMA_OUT(rx_char_is_comma_i[3:0]),
        .RXCHARISCOMMA_OUT_LANE1(rx_char_is_comma_i[7:4]),
        .RXCHARISCOMMA_OUT_LANE2(rx_char_is_comma_i[11:8]),
        .RXCHARISCOMMA_OUT_LANE3(rx_char_is_comma_i[15:12]),
        .RXCHARISCOMMA_OUT_LANE4(rx_char_is_comma_i[19:16]),
        .RXCHARISCOMMA_OUT_LANE5(rx_char_is_comma_i[23:20]),
        .RXCHARISCOMMA_OUT_LANE6(rx_char_is_comma_i[27:24]),
        .RXCHARISCOMMA_OUT_LANE7(rx_char_is_comma_i[31:28]),
        .RXCHARISCOMMA_OUT_LANE8(rx_char_is_comma_i[35:32]),
        .RXCHARISCOMMA_OUT_LANE9(rx_char_is_comma_i[39:36]),
        .RXREALIGN_OUT(rx_realign_i[0]),
        .RXREALIGN_OUT_LANE1(rx_realign_i[1]),
        .RXREALIGN_OUT_LANE2(rx_realign_i[2]),
        .RXREALIGN_OUT_LANE3(rx_realign_i[3]),
        .RXREALIGN_OUT_LANE4(rx_realign_i[4]),
        .RXREALIGN_OUT_LANE5(rx_realign_i[5]),
        .RXREALIGN_OUT_LANE6(rx_realign_i[6]),
        .RXREALIGN_OUT_LANE7(rx_realign_i[7]),
        .RXREALIGN_OUT_LANE8(rx_realign_i[8]),
        .RXREALIGN_OUT_LANE9(rx_realign_i[9]),
        .RXBUFERR_OUT(rx_buf_err_i[0]),
        .RXBUFERR_OUT_LANE1(rx_buf_err_i[1]),
        .RXBUFERR_OUT_LANE2(rx_buf_err_i[2]),
        .RXBUFERR_OUT_LANE3(rx_buf_err_i[3]),
        .RXBUFERR_OUT_LANE4(rx_buf_err_i[4]),
        .RXBUFERR_OUT_LANE5(rx_buf_err_i[5]),
        .RXBUFERR_OUT_LANE6(rx_buf_err_i[6]),
        .RXBUFERR_OUT_LANE7(rx_buf_err_i[7]),
        .RXBUFERR_OUT_LANE8(rx_buf_err_i[8]),
        .RXBUFERR_OUT_LANE9(rx_buf_err_i[9]),
        .TXBUFERR_OUT(tx_buf_err_i[0]),
        .TXBUFERR_OUT_LANE1(tx_buf_err_i[1]),
        .TXBUFERR_OUT_LANE2(tx_buf_err_i[2]),
        .TXBUFERR_OUT_LANE3(tx_buf_err_i[3]),
        .TXBUFERR_OUT_LANE4(tx_buf_err_i[4]),
        .TXBUFERR_OUT_LANE5(tx_buf_err_i[5]),
        .TXBUFERR_OUT_LANE6(tx_buf_err_i[6]),
        .TXBUFERR_OUT_LANE7(tx_buf_err_i[7]),
        .TXBUFERR_OUT_LANE8(tx_buf_err_i[8]),
        .TXBUFERR_OUT_LANE9(tx_buf_err_i[9]),


      // Phase Align Interface
        .ENMCOMMAALIGN_IN(ena_comma_align_i[0]),
        .ENMCOMMAALIGN_IN_LANE1(ena_comma_align_i[1]),
        .ENMCOMMAALIGN_IN_LANE2(ena_comma_align_i[2]),
        .ENMCOMMAALIGN_IN_LANE3(ena_comma_align_i[3]),
        .ENMCOMMAALIGN_IN_LANE4(ena_comma_align_i[4]),
        .ENMCOMMAALIGN_IN_LANE5(ena_comma_align_i[5]),
        .ENMCOMMAALIGN_IN_LANE6(ena_comma_align_i[6]),
        .ENMCOMMAALIGN_IN_LANE7(ena_comma_align_i[7]),
        .ENMCOMMAALIGN_IN_LANE8(ena_comma_align_i[8]),
        .ENMCOMMAALIGN_IN_LANE9(ena_comma_align_i[9]),
        .ENPCOMMAALIGN_IN(ena_comma_align_i[0]),
        .ENPCOMMAALIGN_IN_LANE1(ena_comma_align_i[1]),
        .ENPCOMMAALIGN_IN_LANE2(ena_comma_align_i[2]),
        .ENPCOMMAALIGN_IN_LANE3(ena_comma_align_i[3]),
        .ENPCOMMAALIGN_IN_LANE4(ena_comma_align_i[4]),
        .ENPCOMMAALIGN_IN_LANE5(ena_comma_align_i[5]),
        .ENPCOMMAALIGN_IN_LANE6(ena_comma_align_i[6]),
        .ENPCOMMAALIGN_IN_LANE7(ena_comma_align_i[7]),
        .ENPCOMMAALIGN_IN_LANE8(ena_comma_align_i[8]),
        .ENPCOMMAALIGN_IN_LANE9(ena_comma_align_i[9]),
        .RXRECCLK1_OUT(),
        .RXRECCLK1_OUT_LANE1(),
        .RXRECCLK1_OUT_LANE2(),
        .RXRECCLK1_OUT_LANE3(),
        .RXRECCLK1_OUT_LANE4(),
        .RXRECCLK1_OUT_LANE5(),
        .RXRECCLK1_OUT_LANE6(),
        .RXRECCLK1_OUT_LANE7(),
        .RXRECCLK1_OUT_LANE8(),
        .RXRECCLK1_OUT_LANE9(),
        .RXRECCLK2_OUT(),
        .RXRECCLK2_OUT_LANE1(),
        .RXRECCLK2_OUT_LANE2(),
        .RXRECCLK2_OUT_LANE3(),
        .RXRECCLK2_OUT_LANE4(),
        .RXRECCLK2_OUT_LANE5(),
        .RXRECCLK2_OUT_LANE6(),
        .RXRECCLK2_OUT_LANE7(),
        .RXRECCLK2_OUT_LANE8(),
        .RXRECCLK2_OUT_LANE9(),
           


        //Global Logic Interface
        .ENCHANSYNC_IN(tied_to_vcc_i),
        .ENCHANSYNC_IN_LANE1(tied_to_vcc_i),
        .ENCHANSYNC_IN_LANE2(tied_to_vcc_i),
        .ENCHANSYNC_IN_LANE3(tied_to_vcc_i),
        .ENCHANSYNC_IN_LANE4(en_chan_sync_i),
        .ENCHANSYNC_IN_LANE5(tied_to_vcc_i),
        .ENCHANSYNC_IN_LANE6(tied_to_vcc_i),
        .ENCHANSYNC_IN_LANE7(tied_to_vcc_i),
        .ENCHANSYNC_IN_LANE8(tied_to_vcc_i),
        .ENCHANSYNC_IN_LANE9(tied_to_vcc_i),
        .CHBONDDONE_OUT(ch_bond_done_i[0]),
        .CHBONDDONE_OUT_LANE1(ch_bond_done_i[1]),
        .CHBONDDONE_OUT_LANE2(ch_bond_done_i[2]),
        .CHBONDDONE_OUT_LANE3(ch_bond_done_i[3]),
        .CHBONDDONE_OUT_LANE4(ch_bond_done_i[4]),
        .CHBONDDONE_OUT_LANE5(ch_bond_done_i[5]),
        .CHBONDDONE_OUT_LANE6(ch_bond_done_i[6]),
        .CHBONDDONE_OUT_LANE7(ch_bond_done_i[7]),
        .CHBONDDONE_OUT_LANE8(ch_bond_done_i[8]),
        .CHBONDDONE_OUT_LANE9(ch_bond_done_i[9]),

        //Serial IO
        .RX1N_IN(RXN[0]),
        .RX1N_IN_LANE1(RXN[1]),
        .RX1N_IN_LANE2(RXN[2]),
        .RX1N_IN_LANE3(RXN[3]),
        .RX1N_IN_LANE4(RXN[4]),
        .RX1N_IN_LANE5(RXN[5]),
        .RX1N_IN_LANE6(RXN[6]),
        .RX1N_IN_LANE7(RXN[7]),
        .RX1N_IN_LANE8(RXN[8]),
        .RX1N_IN_LANE9(RXN[9]),
        .RX1P_IN(RXP[0]),
        .RX1P_IN_LANE1(RXP[1]),
        .RX1P_IN_LANE2(RXP[2]),
        .RX1P_IN_LANE3(RXP[3]),
        .RX1P_IN_LANE4(RXP[4]),
        .RX1P_IN_LANE5(RXP[5]),
        .RX1P_IN_LANE6(RXP[6]),
        .RX1P_IN_LANE7(RXP[7]),
        .RX1P_IN_LANE8(RXP[8]),
        .RX1P_IN_LANE9(RXP[9]),
        .TX1N_OUT(TXN[0]),
        .TX1N_OUT_LANE1(TXN[1]),
        .TX1N_OUT_LANE2(TXN[2]),
        .TX1N_OUT_LANE3(TXN[3]),
        .TX1N_OUT_LANE4(TXN[4]),
        .TX1N_OUT_LANE5(TXN[5]),
        .TX1N_OUT_LANE6(TXN[6]),
        .TX1N_OUT_LANE7(TXN[7]),
        .TX1N_OUT_LANE8(TXN[8]),
        .TX1N_OUT_LANE9(TXN[9]),
        .TX1P_OUT(TXP[0]),
        .TX1P_OUT_LANE1(TXP[1]),
        .TX1P_OUT_LANE2(TXP[2]),
        .TX1P_OUT_LANE3(TXP[3]),
        .TX1P_OUT_LANE4(TXP[4]),
        .TX1P_OUT_LANE5(TXP[5]),
        .TX1P_OUT_LANE6(TXP[6]),
        .TX1P_OUT_LANE7(TXP[7]),
        .TX1P_OUT_LANE8(TXP[8]),
        .TX1P_OUT_LANE9(TXP[9]),

        // Clocks and Clock Status
        .RXUSRCLK_IN(SYNC_CLK),
        .RXUSRCLK2_IN(USER_CLK),
        .TXUSRCLK_IN(SYNC_CLK),
        .TXUSRCLK2_IN(USER_CLK), 
        .REFCLK(GTXD1),

        .TXOUTCLK1_OUT(raw_tx_out_clk_i[0]),
        .TXOUTCLK2_OUT(),
        .TXOUTCLK1_OUT_LANE1(raw_tx_out_clk_i[1]),
        .TXOUTCLK2_OUT_LANE1(),
        .TXOUTCLK1_OUT_LANE2(raw_tx_out_clk_i[2]),
        .TXOUTCLK2_OUT_LANE2(),
        .TXOUTCLK1_OUT_LANE3(raw_tx_out_clk_i[3]),
        .TXOUTCLK2_OUT_LANE3(),
        .TXOUTCLK1_OUT_LANE4(raw_tx_out_clk_i[4]),
        .TXOUTCLK2_OUT_LANE4(),
        .TXOUTCLK1_OUT_LANE5(raw_tx_out_clk_i[5]),
        .TXOUTCLK2_OUT_LANE5(),
        .TXOUTCLK1_OUT_LANE6(raw_tx_out_clk_i[6]),
        .TXOUTCLK2_OUT_LANE6(),
        .TXOUTCLK1_OUT_LANE7(raw_tx_out_clk_i[7]),
        .TXOUTCLK2_OUT_LANE7(),
        .TXOUTCLK1_OUT_LANE8(raw_tx_out_clk_i[8]),
        .TXOUTCLK2_OUT_LANE8(),
        .TXOUTCLK1_OUT_LANE9(raw_tx_out_clk_i[9]),
        .TXOUTCLK2_OUT_LANE9(),
        .PLLLKDET_OUT(tx_lock_i[0]),
        .PLLLKDET_OUT_LANE1(tx_lock_i[1]),
        .PLLLKDET_OUT_LANE2(tx_lock_i[2]),
        .PLLLKDET_OUT_LANE3(tx_lock_i[3]),
        .PLLLKDET_OUT_LANE4(tx_lock_i[4]),
        .REFCLKOUT_OUT(),
        .REFCLKOUT_OUT_LANE1(),
        .REFCLKOUT_OUT_LANE2(),
        .REFCLKOUT_OUT_LANE3(),
        .REFCLKOUT_OUT_LANE4(),

        //System Interface
        .GTXRESET_IN(GT_RESET),
        .LOOPBACK_IN(LOOPBACK),




















        .POWERDOWN_IN(POWER_DOWN)
    );

    //__________Instantiate Global Logic to combine Lanes into a Channel______

  // FF stages added for timing closure
  always @(posedge USER_CLK)
        ch_bond_done_r1  <=  `DLY    ch_bond_done_i;

  always @(posedge USER_CLK)
        ch_bond_done_r2  <=  `DLY    ch_bond_done_r1;

  always @(posedge USER_CLK)
       if (RESET)
         ch_bond_done_dly_i <= 10'b0;
       else if (en_chan_sync_i)
         ch_bond_done_dly_i <= ch_bond_done_r2;
       else
         ch_bond_done_dly_i <= 10'b0;

  always @(posedge USER_CLK)
      if (RESET)
        ch_bond_load_pulse_i <= 10'b0;
      else if(en_chan_sync_i)
        ch_bond_load_pulse_i <= ch_bond_done_r2 & ~ch_bond_done_dly_i;
      else
        ch_bond_load_pulse_i <= 10'b0;

    aurora_GLOBAL_LOGIC    aurora_global_logic_i
    (
        //GTX Interface
        .CH_BOND_DONE(ch_bond_done_i),
        .EN_CHAN_SYNC(en_chan_sync_i),


        //Aurora Lane Interface
        .LANE_UP(lane_up_i),
        .SOFT_ERR(soft_err_i),
        .HARD_ERR(hard_err_i),
        .CHANNEL_BOND_LOAD(ch_bond_load_pulse_i),
        .GOT_A(got_a_i),
        .GOT_V(got_v_i),
        .GEN_A(gen_a_i),
        .GEN_K(gen_k_i),
        .GEN_R(gen_r_i),
        .GEN_V(gen_v_i),
        .RESET_LANES(reset_lanes_i),


        //System Interface
        .USER_CLK(USER_CLK),
        .RESET(RESET),
        .POWER_DOWN(POWER_DOWN),
        .CHANNEL_UP(channel_up_i),
        .START_RX(start_rx_i),
        .CHANNEL_SOFT_ERR(SOFT_ERR),
        .CHANNEL_HARD_ERR(HARD_ERR)
    );



    //_____________________________Instantiate TX_STREAM___________________________

    
    aurora_TX_STREAM aurora_tx_stream_i
    (
        // Data interface
        .TX_D(TX_D),
        .TX_SRC_RDY_N(TX_SRC_RDY_N),
        .TX_DST_RDY_N(TX_DST_RDY_N),


        // Global Logic Interface
        .CHANNEL_UP(channel_up_i),


        //Clock Correction Interface
        .DO_CC(DO_CC),
        .WARN_CC(WARN_CC),
        
        
        // Aurora Lane Interface
        .GEN_SCP(gen_scp_i),
        .GEN_ECP(gen_ecp_i),
        .TX_PE_DATA_V(tx_pe_data_v_i),
        .GEN_PAD(gen_pad_i),
        .TX_PE_DATA(tx_pe_data_i),
        .GEN_CC(gen_cc_i),


        // System Interface
        .USER_CLK(USER_CLK)
    );



    //_____________________________ Instantiate RX_STREAM____________________________
    
    
    aurora_RX_STREAM aurora_rx_stream_i
    (
        // LocalLink PDU Interface
        .RX_D(RX_D),
        .RX_SRC_RDY_N(RX_SRC_RDY_N),
    
    
        // Global Logic Interface
        .START_RX(start_rx_i),
    
    
        // Aurora Lane Interface
        .RX_PAD(rx_pad_i),
        .RX_PE_DATA(rx_pe_data_i),
        .RX_PE_DATA_V(rx_pe_data_v_i),
        .RX_SCP(rx_scp_i),
        .RX_ECP(rx_ecp_i),
    
   
        // System Interface
        .USER_CLK(USER_CLK)
    );



endmodule
