//---------------------------------------------------------------------------
// Title      : Verilog Channel Bonding Monitor
// Project    : XAUI
// File       : chanbond_monitor.v
// Author     : Xilinx Inc.
// Description: This module holds the Channel Bonding monitor circuitry
//---------------------------------------------------------------------------
//
// (c) Copyright 2002 - 2010 Xilinx, Inc. All rights reserved.
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
module chanbond_monitor
(
   input  CLK,
   input  RST,
   input  COMMA_ALIGN_DONE,
   input  CORE_ENCHANSYNC,
   input  CHANBOND_DONE,
   output RXRESET
);   

reg [3:0] state;
reg [3:0] next_state;
reg [7:0] cnt;
reg       enable_cnt;
reg       reset_r;

//*************************************FSM States*************************************
parameter  [3:0]  IDLE             =   4'b0001;
parameter  [3:0]  WAIT_FOR_ALIGN  =   4'b0010;
parameter  [3:0]  CB_SEARCH       =   4'b0100;
parameter  [3:0]  RESET           =    4'b1000;


assign RXRESET = reset_r;

always@ (posedge CLK) begin
  if (RST) begin
    state <= IDLE;
  end else begin
    state <= next_state;
  end
end

// Next State Assignment
always@( state or COMMA_ALIGN_DONE or CORE_ENCHANSYNC or CHANBOND_DONE or cnt) begin
  //Default Assignment
  next_state <= state;
  
  case (state)
  IDLE:
  if (CORE_ENCHANSYNC && ~CHANBOND_DONE) begin
    next_state  <= WAIT_FOR_ALIGN;
  end  
  
  WAIT_FOR_ALIGN :
  if (COMMA_ALIGN_DONE) begin
    next_state  <= CB_SEARCH;
  end
      
  CB_SEARCH :
  if (~COMMA_ALIGN_DONE) begin
    next_state <= WAIT_FOR_ALIGN;
  end else if (CHANBOND_DONE) begin
    next_state <= IDLE;
  end else if (cnt[7]) begin
    next_state <= RESET;
  end else begin
    next_state <= CB_SEARCH;
  end
  
  RESET :
    next_state  <= WAIT_FOR_ALIGN;
      
  default :
    next_state  <= IDLE;
  
  endcase
end

// Registered Output Assignment
always@ (posedge CLK) begin
  if (RST) begin
    enable_cnt  <= 1'b0;
    reset_r     <= 1'b0;
  end else begin
    // Default Assignments
    enable_cnt  <= 1'b0;
    reset_r     <= 1'b0;
    
    case (state)  
    CB_SEARCH :
      enable_cnt <= 1'b1;
        
    RESET :
      reset_r <= 1'b1;
                  
    default : begin
      enable_cnt  <= 1'b0;  
      reset_r     <= 1'b0;
    end
    endcase
  end
end

// CB_SEARCH Timeout Counter
always@ (posedge CLK) begin
  if (~enable_cnt) begin
    cnt <= 8'h00;
  end else begin  
    cnt <= cnt + 1;
  end
end
endmodule
