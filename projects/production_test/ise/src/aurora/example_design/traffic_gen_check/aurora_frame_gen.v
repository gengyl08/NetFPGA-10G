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

//
//  FRAME GEN
//
//
//
//  Description: This module is a pattern generator to test the Aurora
//               designs in hardware. It generates data and passes it 
//               through the Aurora channel. If connected to a framing 
//               interface, it generates frames of varying size and 
//               separation. LFSR is used to generate the pseudo-random 
//               data and lower bits of LFSR are connected to REM bus 

`timescale 1 ns / 1 ps
`define DLY #1

module aurora_FRAME_GEN
(
    // User Interface
    TX_D,  
    TX_SRC_RDY_N,
    TX_DST_RDY_N,

    // System Interface
    USER_CLK,       
    RESET,
    CHANNEL_UP
); 
//*****************************Parameter Declarations****************************

//***********************************Port Declarations*******************************

   // User Interface
    output  [0:319]    TX_D;
    output             TX_SRC_RDY_N;
    input              TX_DST_RDY_N;

      // System Interface
    input              USER_CLK;
    input              RESET; 
    input              CHANNEL_UP;

//***************************External Register Declarations***************************

    reg                TX_SRC_RDY_N;

//***************************Internal Register Declarations*************************** 

    reg     [0:15]     data_lfsr_r;    
    
    wire               reset_c;


//*********************************Main Body of Code**********************************

  //Generate RESET signal when Aurora channel is not ready
  assign reset_c = RESET || !CHANNEL_UP;

    //______________________________ Transmit Data  __________________________________    
    //Transmit data when TX_DST_RDY_N is asserted. 
    //Random data is generated using XNOR feedback LFSR
    //TX_SRC_RDY_N is asserted on every cycle with data
    always @(posedge USER_CLK)
        if(reset_c)
        begin
            data_lfsr_r          <=  `DLY    16'hABCD;  //random seed value
            TX_SRC_RDY_N    <=  `DLY    1'b1;    
        end
        else if(!TX_DST_RDY_N)
        begin
            data_lfsr_r          <=  `DLY    {!{data_lfsr_r[3]^data_lfsr_r[12]^data_lfsr_r[14]^data_lfsr_r[15]}, 
                                data_lfsr_r[0:14]};
            TX_SRC_RDY_N    <=  `DLY    1'b0;
        end
    
    //Connect TX_D to the DATA LFSR register
    assign  TX_D    =   {20{data_lfsr_r}};
    

endmodule
