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
//  RX_STREAM
//
//
//  Description: The RX_LL module receives data from the Aurora Channel,
//               converts it to a simple streaming format. This module expects
//               all data to be carried in a single, infinite frame, and it 
//               expects the data data in lanes to be all valid or all invalid
//
//               This module supports 20 4-byte lane designs.
//
//

`timescale 1 ns / 1 ps

module aurora_RX_STREAM
(
    // LocalLink PDU Interface
    RX_D,
    RX_SRC_RDY_N,


    // Global Logic Interface
    START_RX,


    // Aurora Lane Interface
    RX_PAD,
    RX_PE_DATA,
    RX_PE_DATA_V,
    RX_SCP,
    RX_ECP,


    // System Interface
    USER_CLK


);

`define DLY #1


//***********************************Port Declarations*******************************


    // LocalLink PDU Interface
    output  [0:319]    RX_D;
    output             RX_SRC_RDY_N;


    // Global Logic Interface
    input              START_RX;


    // Aurora Lane Interface
    input   [0:19]     RX_PAD;
    input   [0:319]    RX_PE_DATA;
    input   [0:19]     RX_PE_DATA_V;
    input   [0:19]     RX_SCP;
    input   [0:19]     RX_ECP;


    // System Interface
    input              USER_CLK;




//************************Register Declarations********************
    
    reg                infinite_frame_started_r;



//***********************Main Body of Code*************************
    
    
    //Don't start presenting data until the infinite frame starts
    always @(posedge USER_CLK)
        if(!START_RX)
            infinite_frame_started_r    <=  `DLY 1'b0;
        else if(RX_SCP > 20'd0)
            infinite_frame_started_r    <=  `DLY 1'b1;
        
        
    assign  RX_D     =   RX_PE_DATA;
    
    assign  RX_SRC_RDY_N   =   !(RX_PE_DATA_V[0] && infinite_frame_started_r);
    
    
    
endmodule
