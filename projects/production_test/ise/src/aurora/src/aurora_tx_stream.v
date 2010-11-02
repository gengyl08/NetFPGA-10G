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
//  TX_STREAM
//
//
//  Description: The TX_STREAM module converts user data from a streaming interface
//               to Aurora Data, then sends it to the Aurora Channel for transmission.
//               To perform streaming with Aurora, it starts an infinite frame after
//               channel up and performs opporunistic clock correction automatically
//
//               This module supports 20 4-byte lane designs
//

`timescale 1 ns / 1 ps

module aurora_TX_STREAM
(
    // Data interface
    TX_D,
    TX_SRC_RDY_N,
    TX_DST_RDY_N,


    // Global Logic Interface
    CHANNEL_UP,
    
    
    //Clock Correction Interface
    DO_CC,
    WARN_CC,


    // Aurora Lane Interface
    GEN_SCP,
    GEN_ECP,
    TX_PE_DATA_V,
    GEN_PAD,
    TX_PE_DATA,
    GEN_CC,


    // System Interface
    USER_CLK


);

`define DLY #1


//***********************************Port Declarations*******************************


    // LocalLink PDU Interface
    input   [0:319]    TX_D;
    input              TX_SRC_RDY_N;

    output             TX_DST_RDY_N;


    // Global Logic Interface
    input              CHANNEL_UP;
    
    
    //Clock Correction Interface
    input              DO_CC;
    input              WARN_CC;


    // Aurora Lane Interface
    output             GEN_SCP;
    output             GEN_ECP;
    output  [0:19]     TX_PE_DATA_V;
    output  [0:19]     GEN_PAD;
    output  [0:319]    TX_PE_DATA;
    output             GEN_CC;


    // System Interface
    input              USER_CLK;


//************************External Register Declarations***********

    reg                GEN_CC;


//************************Register Declarations********************

    //State registers
    reg                rst_r;
    reg                start_r;
    reg                run_r;
    
    reg                tx_dst_rdy_n_r;        
    
    
//*********************************Wire Declarations**********************************

    //FSM nextstate signals
    wire               next_start_c;
    wire               next_run_c;


//*********************************Main Body of Code**********************************



    //____________________________  Data Interface Signals__________________________
    

    // Data interface is ready when the channel is up and running and not forcing a cc
    always @(posedge USER_CLK)
        tx_dst_rdy_n_r  <= `DLY !CHANNEL_UP || !run_r || DO_CC;
        
         
     assign  TX_DST_RDY_N           =   tx_dst_rdy_n_r;   
    
    
    
    //____________________________  Aurora Lane Interface Signals __________________

    
    // Generate CCs whenever DO_CC is asserted. Register the signal to line it up
    // with the cycle when TX_DST_RDY_N is deasserted
    always @(posedge USER_CLK)
        GEN_CC  <=  DO_CC;                                
    
    
    // Send an SCP to start the infinite frame
    assign  GEN_SCP         =   start_r;
    
    
    // Never send ECPs or PADs
    assign  GEN_ECP         =   1'b0;
    assign  GEN_PAD         =   20'd0;

    
    
    
    // Send the user's data directly to the Aurora Lane 
    assign  TX_PE_DATA      =   TX_D;
    
    
    // The data is valid if it is written when the channel is ready and TX_SRC_RDY_N is asserted
    assign  TX_PE_DATA_V[0]    =   !tx_dst_rdy_n_r && !TX_SRC_RDY_N;
    assign  TX_PE_DATA_V[1]    =   !tx_dst_rdy_n_r && !TX_SRC_RDY_N;
    assign  TX_PE_DATA_V[2]    =   !tx_dst_rdy_n_r && !TX_SRC_RDY_N;
    assign  TX_PE_DATA_V[3]    =   !tx_dst_rdy_n_r && !TX_SRC_RDY_N;
    assign  TX_PE_DATA_V[4]    =   !tx_dst_rdy_n_r && !TX_SRC_RDY_N;
    assign  TX_PE_DATA_V[5]    =   !tx_dst_rdy_n_r && !TX_SRC_RDY_N;
    assign  TX_PE_DATA_V[6]    =   !tx_dst_rdy_n_r && !TX_SRC_RDY_N;
    assign  TX_PE_DATA_V[7]    =   !tx_dst_rdy_n_r && !TX_SRC_RDY_N;
    assign  TX_PE_DATA_V[8]    =   !tx_dst_rdy_n_r && !TX_SRC_RDY_N;
    assign  TX_PE_DATA_V[9]    =   !tx_dst_rdy_n_r && !TX_SRC_RDY_N;
    assign  TX_PE_DATA_V[10]    =   !tx_dst_rdy_n_r && !TX_SRC_RDY_N;
    assign  TX_PE_DATA_V[11]    =   !tx_dst_rdy_n_r && !TX_SRC_RDY_N;
    assign  TX_PE_DATA_V[12]    =   !tx_dst_rdy_n_r && !TX_SRC_RDY_N;
    assign  TX_PE_DATA_V[13]    =   !tx_dst_rdy_n_r && !TX_SRC_RDY_N;
    assign  TX_PE_DATA_V[14]    =   !tx_dst_rdy_n_r && !TX_SRC_RDY_N;
    assign  TX_PE_DATA_V[15]    =   !tx_dst_rdy_n_r && !TX_SRC_RDY_N;
    assign  TX_PE_DATA_V[16]    =   !tx_dst_rdy_n_r && !TX_SRC_RDY_N;
    assign  TX_PE_DATA_V[17]    =   !tx_dst_rdy_n_r && !TX_SRC_RDY_N;
    assign  TX_PE_DATA_V[18]    =   !tx_dst_rdy_n_r && !TX_SRC_RDY_N;
    assign  TX_PE_DATA_V[19]    =   !tx_dst_rdy_n_r && !TX_SRC_RDY_N;




    
    
    //_______________  State machine to start infinite frame ______________
    

    // After channel up, the tx stream module  sends an SCP character
    // to start the inifinite frame that will carry the data stream, then 
    // goes to the run state.


    //Control state machine state registers
    always @(posedge USER_CLK)
        if(!CHANNEL_UP) 
        begin
            rst_r       <=  `DLY    1'b1;
            start_r     <=  `DLY    1'b0;
            run_r       <=  `DLY    1'b0;
        end
        else if(!DO_CC)
        begin
            rst_r       <=  `DLY    1'b0;
            start_r     <=  `DLY    next_start_c;
            run_r       <=  `DLY    next_run_c;
        end


    //Nextstate logic
    
    // After reset, send the SCP character to open the infinite 
    // frame 
    assign  next_start_c    =   rst_r;

    
    // After the start state, go to normal operation 
    assign  next_run_c      =   start_r ||
                                run_r;
      
            

endmodule
