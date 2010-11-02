//*****************************************************************************
// DISCLAIMER OF LIABILITY
// 
// This text/file contains proprietary, confidential
// information of Xilinx, Inc., is distributed under license
// from Xilinx, Inc., and may be used, copied and/or
// disclosed only pursuant to the terms of a valid license
// agreement with Xilinx, Inc. Xilinx hereby grants you a 
// license to use this text/file solely for design, simulation, 
// implementation and creation of design files limited 
// to Xilinx devices or technologies. Use with non-Xilinx 
// devices or technologies is expressly prohibited and 
// immediately terminates your license unless covered by
// a separate agreement.
//
// Xilinx is providing this design, code, or information 
// "as-is" solely for use in developing programs and 
// solutions for Xilinx devices, with no obligation on the 
// part of Xilinx to provide support. By providing this design, 
// code, or information as one possible implementation of 
// this feature, application or standard, Xilinx is making no 
// representation that this implementation is free from any 
// claims of infringement. You are responsible for 
// obtaining any rights you may require for your implementation. 
// Xilinx expressly disclaims any warranty whatsoever with 
// respect to the adequacy of the implementation, including 
// but not limited to any warranties or representations that this
// implementation is free from claims of infringement, implied 
// warranties of merchantability or fitness for a particular 
// purpose.
//
// Xilinx products are not intended for use in life support
// appliances, devices, or systems. Use in such applications is
// expressly prohibited.
//
// Any modifications that are made to the Source Code are 
// done at the user's sole risk and will be unsupported.
//
// Copyright (c) 2006-2008 Xilinx, Inc. All rights reserved.
//
// This copyright and support notice must be retained as part 
// of this text at all times. 
//*****************************************************************************
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: 1.1
//  \   \         Filename: cmp_rd_data.v
//  /   /         Timestamp: 14 March 2008
// /___/   /\     
// \   \  /  \
//  \___\/\___\
//
//
//	Device:  Virtex-4 and Virtex-5
//	Purpose: This module compares the read data with expected data value.
// Revision History:
//   Rev 1.0 - initial release
//   Rev 1.1 - Added fix to catch error at the end of a burst
//
//*****************************************************************************

`timescale 1ns/100ps

module  cmp_rd_data  (
   clk,
   reset,
   rldReadDataValid,  
   rldReadData,

   APP_COMPARE_DATA, 
   DISPLAY,
   enable_error_counter,
   
   PASS_FAIL,
   
   cs_io
);

   // parameter definitions
   parameter RL_DQ_WIDTH     = 36;
   parameter DEV_BYTE_WIDTH  = 9;  // the width of a "byte" on the memory device (x8 or x9)
   parameter NUM_OF_BYTES    = RL_DQ_WIDTH/DEV_BYTE_WIDTH;
   // end of parameter definitions

// private parameters -- do not change
parameter reset_CODE   = 3'b001;
parameter PASS_CODE    = 3'b010;
parameter ERROR_CODE   = 3'b100;
parameter INVALID_CODE = 3'b111;


   input         clk;               
   input         reset;
   input         rldReadDataValid;
   input [2*RL_DQ_WIDTH-1:0]   APP_COMPARE_DATA;
   input [2*RL_DQ_WIDTH-1:0]   rldReadData;

   output[6:0]   DISPLAY;
   output        enable_error_counter;
   
   output [2:0] 	 PASS_FAIL;
   
   inout [1023:0] cs_io;
   
   reg [2:0] 	 PASS_FAIL_msb1;
   reg [2:0] 	 PASS_FAIL_lsb1;
   reg [2:0] 	 PASS_FAIL;

   reg           valid_d2, valid_d1, valid_cmp;
   reg           valid_cmp_r;
   reg [2*RL_DQ_WIDTH-1:0] read_data, read_data_d1;

   reg [6:0]     display_buf;
   reg [NUM_OF_BYTES-1:0]  msb_cmp, lsb_cmp;
   reg        msb_compare, lsb_compare;

   reg msb_error, lsb_error, enable_error_counter;

   wire [RL_DQ_WIDTH-1:0]   read_data_MSB, APP_COMPARE_DATA_MSB;
   
//for chipscope
//chipscope read data from output of user interface FIFOs
wire [RL_DQ_WIDTH-1:0]		fifo_data_rise;
wire [RL_DQ_WIDTH-1:0]		fifo_data_fall;

//assign	fifo_data_rise[RL_DQ_WIDTH-1:0]=rldReadData[RL_DQ_WIDTH-1:0];
//assign	fifo_data_fall[RL_DQ_WIDTH-1:0]=rldReadData[(2*RL_DQ_WIDTH)-1:RL_DQ_WIDTH];
assign	fifo_data_rise[RL_DQ_WIDTH-1:0]=read_data[(2*RL_DQ_WIDTH)-1:RL_DQ_WIDTH];
assign	fifo_data_fall[RL_DQ_WIDTH-1:0]=read_data[RL_DQ_WIDTH-1:0];

//assign cs_io[92:91] = { msb_error, lsb_error };
//assign cs_io[90] = valid_d1;
//assign cs_io[80:72] = {APP_COMPARE_DATA[44:36]};
//assign cs_io[89:81] = {APP_COMPARE_DATA[8:0]};

//assign cs_io[8:0] = {fifo_data_rise[8:0]};	//1st byte
//assign cs_io[17:9] = {fifo_data_fall[8:0]};

//assign cs_io[26:18] = {fifo_data_rise[17:9]}; //2nd byte
//assign cs_io[35:27] = {fifo_data_fall[17:9]};

//assign cs_io[44:36] = {fifo_data_rise[26:18]}; //3rd byte
//assign cs_io[53:45] = {fifo_data_fall[26:18]};

//assign cs_io[62:54] = {fifo_data_rise[35:27]}; //4th byte
//assign cs_io[71:63] = {fifo_data_fall[35:27]};
assign cs_io[216] =  rldReadDataValid;
assign cs_io[215:144] = rldReadData[71:0];
assign cs_io[143:72] = APP_COMPARE_DATA[71:0];
assign cs_io[71:0] = read_data[71:0];
assign cs_io[217] = msb_compare;
assign cs_io[218] = lsb_compare;
assign cs_io[219] = valid_cmp;
assign cs_io[220] = msb_error;
assign cs_io[221] = lsb_error;

//end of whats for chipscope   

// -----------------------------------------------------------------------------
// create flag for when data should be compared   
// -----------------------------------------------------------------------------
always @ (posedge clk)
begin
   //if ( reset == 1'b1 )
   //begin
   //   valid_d1  <= 1'b0;
   //   valid_d2  <= 1'b0;
   //   valid_cmp <= 1'b0;
   //end
   //else
   //begin
      valid_d1 <= rldReadDataValid;
      valid_d2  <= valid_d1;
      valid_cmp  <= valid_d2;
      valid_cmp_r <= valid_cmp;
   //end
end

// James: shift read_data for alignment
always @ (posedge clk) begin
	read_data <= rldReadData;
	//read_data <= read_data_d1;
end
// -----------------------------------------------------------------------------
// Compare read data with data generated for comparison.
// Set PASS_FAIL flag accordingly.
// reset PASS_FAIL flag when restart occurs    
// -----------------------------------------------------------------------------

// MSB comparison
integer i_msb;
assign read_data_MSB = read_data[2*RL_DQ_WIDTH-1:RL_DQ_WIDTH];
assign APP_COMPARE_DATA_MSB = APP_COMPARE_DATA[2*RL_DQ_WIDTH-1:RL_DQ_WIDTH];
always @ (posedge clk) begin
    for (i_msb = 0; i_msb < NUM_OF_BYTES; i_msb = i_msb + 1) begin
        msb_cmp[i_msb] <= &(~(read_data_MSB[(i_msb+1)*DEV_BYTE_WIDTH-1-1 -:DEV_BYTE_WIDTH-1] ^ 
                              APP_COMPARE_DATA_MSB[(i_msb+1)*DEV_BYTE_WIDTH-1-1 -:DEV_BYTE_WIDTH-1]));
    end
end

always @ (posedge clk)
begin
   msb_compare <= &msb_cmp;
end

always @ (posedge clk)
begin
   if ( reset == 1'b1 )
      msb_error <= 1'b0;
   else
      if ( valid_cmp == 1'b1)
          msb_error <= ~( msb_compare );
      else
          msb_error <= 1'b0;
end

always @ (posedge clk)
begin
   if ( reset == 1'b1 )
      PASS_FAIL_msb1 <= reset_CODE;  // set "reset" flag
   else
      //if ( valid_cmp == 1'b1 )   // XBP: (08-June-2006) add "valid" control for msb
      if ( valid_cmp_r == 1'b1 )   // changed to catch last burst error
         if ( (msb_error == 1'b0) && (PASS_FAIL_msb1 != ERROR_CODE) )
            PASS_FAIL_msb1 <= PASS_CODE;  // set "pass" flag
         else
            PASS_FAIL_msb1 <= ERROR_CODE;  // flag an error
end


// LSB comparison
integer i_lsb;
always @ (posedge clk) begin
    for (i_lsb = 0; i_lsb < NUM_OF_BYTES; i_lsb = i_lsb + 1) begin
        lsb_cmp[i_lsb] <= &(~(read_data[(i_lsb+1)*DEV_BYTE_WIDTH-1-1 -:DEV_BYTE_WIDTH-1] ^ 
                              APP_COMPARE_DATA[(i_lsb+1)*DEV_BYTE_WIDTH-1-1 -:DEV_BYTE_WIDTH-1]));
    end
end

always @ (posedge clk)
begin
   lsb_compare <= &lsb_cmp;
end

always @ (posedge clk)
begin
   if ( reset == 1'b1 )
      lsb_error <= 1'b0;
   else
      if ( valid_cmp == 1'b1 )
          lsb_error <= ~( lsb_compare );
      else
         lsb_error <= 1'b0;
end

always @ (posedge clk)
begin
   if ( reset == 1'b1 )
      PASS_FAIL_lsb1 <= reset_CODE;  // set "reset" flag
   else
      //if ( valid_cmp == 1'b1 )
      if ( valid_cmp_r == 1'b1 )   // changed to catch last burst error
         if ( (lsb_error == 1'b0) && (PASS_FAIL_lsb1 != ERROR_CODE))
            PASS_FAIL_lsb1 <= PASS_CODE;  // set "pass" flag
         else
            PASS_FAIL_lsb1 <= ERROR_CODE;  // flag an error
end


// enable signal for error counter
always @ (posedge clk)
   enable_error_counter <= msb_error | lsb_error;


// Join MSB and LSB comparisons
always @ (posedge clk)
begin
   if ( reset == 1'b1 )
   begin
      PASS_FAIL <= reset_CODE;
   end
   else
   begin
      if ( PASS_FAIL_msb1 == ERROR_CODE || PASS_FAIL_lsb1 == ERROR_CODE )  // check if one flag shows "error"
         PASS_FAIL <= ERROR_CODE;
      else if ( PASS_FAIL_msb1 == PASS_CODE && PASS_FAIL_lsb1 == PASS_CODE )  // make sure all flags "pass"
         PASS_FAIL <= PASS_CODE;
      else if ( PASS_FAIL_msb1 == reset_CODE && PASS_FAIL_lsb1 == reset_CODE )  // make sure all flags "reset"
         PASS_FAIL <= reset_CODE; 
   end
end

always @ (posedge clk)
begin
   if ( PASS_FAIL == ERROR_CODE )
      display_buf <= 7'b1111001;  // E  0x79 or 0x06(inverted)
   else if ( PASS_FAIL == PASS_CODE )
      display_buf <= 7'b1110011;  // P  0x73 or 0x0C(inverted)
   else if ( PASS_FAIL == reset_CODE )
      display_buf <= 7'b0111111;  // 0  0x3F or 0x40(inverted)	 
end   
   
assign DISPLAY = ~display_buf;

always @ (posedge clk)
  if ( enable_error_counter ) begin
      $display("ERROR %m: ************* Data Comparison Error *************", $time);
      //$finish;
  end

endmodule
