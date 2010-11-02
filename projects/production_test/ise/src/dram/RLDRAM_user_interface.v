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
// Copyright (c) 2006 Xilinx, Inc. All rights reserved.
//
// This copyright and support notice must be retained as part 
// of this text at all times. 
//*****************************************************************************
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: 1.1
//  \   \         Filename: rld_user_interface.v
//  /   /         Timestamp: 24 August 2007
// /___/   /\     
// \   \  /  \
//  \___\/\___\
//
//
//	Device:	 Virtex-5
//	Purpose: This module instantiates the read fifo, write fifo and 
//		merged fifos. It has all the user interface signals, like
//		write data, write address, read data and FIFO status signals.
// Revision History:
//   Rev 1.0 - initial release
//   Rev 1.1 - Added support for FIFO generation for 72-bit width
//*****************************************************************************

`timescale 1ns/100ps

module  rld_user_interface  (
   clk,
   clk90,
   rstHard,
   rstHard_90,
   rstHard_180,
   rstHard_270,

   apWriteDM,
   apWriteData,
   apWriteDValid,

   ctlWdfRdEn,

   apAddr,
   apValid,

   ctlafRdEn,
   apRdfRdEn,

   dpRdData,

   wren_RdFifo,

   afA,
   wdfDM,
   wdfD,
   rlWdfEmpty,
   rlWdfFull,
   rldReadData,
   rldReadDataValid,
   rlafEmpty,
   rlafFull,
   rlafAlmostEmpty,
   rlafAlmostFull,
   rlRdfEmpty,
   rlRdfFull,
   rlWdfAlmostEmpty,
   rlWdfAlmostFull,
   rlWdfWrCount,
   rlWdfWordCount,
   rlafWrCount,
   rlafWordCount,
   
   // chipscope debug ports
   cs_io
);

// public parameters -- adjustable
parameter RL_DQ_WIDTH     = 36;
parameter DEV_DQ_WIDTH    = 18;  // data width of the memory device
parameter NUM_OF_DEVS     = RL_DQ_WIDTH/DEV_DQ_WIDTH;  // number of memory devices
parameter NUM_OF_DKS      = (DEV_DQ_WIDTH == 36) ? 2*NUM_OF_DEVS : NUM_OF_DEVS;
parameter QK_DATA_WIDTH   = (DEV_DQ_WIDTH == 9)  ?  DEV_DQ_WIDTH : DEV_DQ_WIDTH/2;
parameter DEV_AD_WIDTH    = 20;  // address width of the memory device
parameter DEV_BA_WIDTH    = 3;   // bank address width of the memory device
parameter APP_AD_WIDTH    = 1+1+1+DEV_AD_WIDTH+DEV_BA_WIDTH;
parameter DUPLICATE_CONTROLS = 1'b0;  // Duplicate the ports for A, BA, WE# and REF#
//
parameter RL_IO_TYPE     = 2'b00;    // CIO=2'b00  SIO_CIO_HYBRID=2'b01  SIO=2'b10
parameter DEVICE_ARCH    = 2'b00;    // Virtex4=2'b00  Virtex5=2'b01
parameter CAPTURE_METHOD = 2'b00;    // Direct Clocking=2'b00  SerDes=2'b01
// end of public parameters

parameter NUM_OF_FIFOS    = (RL_DQ_WIDTH == 36) ? 2 : 1;

   input                         clk;
   input                         clk90;
   input                         rstHard;
   input                         rstHard_90;
   input                         rstHard_180;
   input                         rstHard_270;
   
   input  [(2*NUM_OF_DEVS)-1:0]  apWriteDM;
   input  [(2*RL_DQ_WIDTH)-1:0]  apWriteData;
   input                         apWriteDValid;
   
   input                         ctlWdfRdEn;
   
   input  [APP_AD_WIDTH-1:0]     apAddr;
   input                         apValid;
   
   input                         ctlafRdEn;
   input                         apRdfRdEn; 
   
   input  [(2*RL_DQ_WIDTH)-1:0]  dpRdData;
   
   input  [(2*NUM_OF_DEVS)-1:0]  wren_RdFifo;
   
   output [APP_AD_WIDTH-1:0]     afA;
   output [(2*NUM_OF_DEVS)-1:0]  wdfDM;
   output [(2*RL_DQ_WIDTH)-1:0]  wdfD;
   output                        rlWdfEmpty;
   output                        rlWdfFull;
   output [(2*RL_DQ_WIDTH)-1:0]  rldReadData;
   output                        rldReadDataValid;
   output                        rlafEmpty;
   output                        rlafFull;
   output                        rlafAlmostEmpty;
   output                        rlafAlmostFull;
   output                        rlRdfEmpty;
   output                        rlRdfFull;
   output                        rlWdfAlmostEmpty;
   output                        rlWdfAlmostFull;
   output [12:0]                 rlWdfWrCount;   // write data FIFO (wdfifo) write count
   wire   [12:0]                 rlWdfRdCount;   // write data FIFO (wdfifo) read count
   output [12:0]                 rlWdfWordCount; // write data FIFO (wdfifo) word count
   output [12:0]                 rlafWrCount;    // command/address FIFO (rafifo) write count
   wire   [12:0]                 rlafRdCount;    // command/address FIFO (rafifo) read count
   output [12:0]                 rlafWordCount;  // command/address FIFO (rafifo) word count
   
   inout [1023:0] cs_io;

   reg [5:0] wren_RdFifo_r;
   reg                        rldReadDataValid;
   //reg                        rlRdfEmpty;
   //reg                        rlafEmpty; //added 8/14
   //wire                       rlafEmpty_r0; //added 8/14
   
   wire  [(RL_DQ_WIDTH/18)-1:0]  rlRdfSubFull;
   wire  [(RL_DQ_WIDTH/18)-1:0]  rlRdfSubEmpty;
   wire  [RL_DQ_WIDTH-1:0]  dpRdData_lower;
   wire  [RL_DQ_WIDTH-1:0]  dpRdData_higher;
   wire  [RL_DQ_WIDTH-1:0]  rldReadData_lower;
   wire  [RL_DQ_WIDTH-1:0]  rldReadData_higher;

   wire  [(RL_DQ_WIDTH/18)-1:0]   rlWdfFull_f;    // Full  flag signal for each FIFO36 instances
   wire                           rlWdfFull_DM;
   wire  [(RL_DQ_WIDTH/18)-1:0]   rlWdfEmpty_f;   // Empty flag signal for each FIFO36 instances
   wire                           rlWdfEmpty_DM;
   wire  [(RL_DQ_WIDTH/18)-1:0]   rlWdfAlmostFull_f;    // AlmostFull  flag signal for each FIFO36 instances
   wire                           rlWdfAlmostFull_DM;
   wire  [(RL_DQ_WIDTH/18)-1:0]   rlWdfAlmostEmpty_f;   // AlmostEmpty flag signal for each FIFO36 instances
   wire                           rlWdfAlmostEmpty_DM;
   wire  [((RL_DQ_WIDTH/18)*13)-1:0]   rlWdfWrCount_f;   // "write data FIFO write count", 13-bit count
   wire  [((RL_DQ_WIDTH/18)*13)-1:0]   rlWdfRdCount_f;   // "write data FIFO read count",  13-bit count

   wire clk180;
   wire clk270;

   assign clk180 = ~clk;
   assign clk270 = ~clk90;

   // read data from PHY, to be stored in FIFO
   assign dpRdData_lower  = dpRdData[RL_DQ_WIDTH-1:0];                // falling data read from phy interface
   assign dpRdData_higher = dpRdData[(2*RL_DQ_WIDTH)-1:RL_DQ_WIDTH];  // rising data read from phy interface

   // read data going back to the user (output from FIFO)
   assign rldReadData[RL_DQ_WIDTH-1:0]               = rldReadData_lower;   // falling data read from FIFO
   assign rldReadData[(2*RL_DQ_WIDTH)-1:RL_DQ_WIDTH] = rldReadData_higher;  // rising data read from FIFO

/*assign cs_io[8:0]  = {rldReadData_higher[8:0]};	//1st byte
assign cs_io[17:9] = {rldReadData_lower[8:0]};

assign cs_io[26:18] = {rldReadData_higher[17:9]}; //2nd byte
assign cs_io[35:27] = {rldReadData_lower[17:9]};

assign cs_io[44:36] = {rldReadData_higher[26:18]}; //3rd byte
assign cs_io[53:45] = {rldReadData_lower[26:18]};

assign cs_io[62:54] = {rldReadData_higher[35:27]}; //4th byte
assign cs_io[71:63] = {rldReadData_lower[35:27]};*/

//assign cs_io[89:88] = { wren_RdFifo[2], wren_RdFifo[0] };

   // -----------------------------------------------------------------------------
   // Read Data FIFO "rdfifo"
   //   - Capture read data from physical interface
   //   - Buffer back to the user interface, storing data
   // -----------------------------------------------------------------------------
   // The read data format is a concatenation of the rising data (in MSB) and 
   // the falling data (in LSB).  The data is read from FIFO36 where 18-bit rise
   // and 18-bit fall concatenation is using {MSB | LSB} 36-bit format.
   //
   // For instance,
   // 18-bit RL2 data width => 18-bit rise | 18-bit fall (FIFO36, instance 0)
   //                          [17:0] rise   [17:0] fall
   //
   // 36-bit RL2 data width => 18-bit rise | 18-bit fall (FIFO36, instance 0)
   //                          [17:0] rise   [17:0] fall
   //                          18-bit rise | 18-bit fall (FIFO36, instance 1)
   //                          [35:18] rise  [35:18] fall
   //
   // 54-bit RL2 data width => 18-bit rise | 18-bit fall (FIFO36, instance 0)
   //                          [17:0] rise   [17:0] fall
   //                          18-bit rise | 18-bit fall (FIFO36, instance 1)
   //                          [35:18] rise  [35:18] fall
   //                          18-bit rise | 18-bit fall (FIFO36, instance 2)
   //                          [53:36] rise  [53:36] fall
   //
   // 72-bit RL2 data width => 18-bit rise | 18-bit fall (FIFO36, instance 0)
   //                          [17:0] rise   [17:0] fall
   //                          18-bit rise | 18-bit fall (FIFO36, instance 1)
   //                          [35:18] rise  [35:18] fall
   //                          18-bit rise | 18-bit fall (FIFO36, instance 2)
   //                          [53:36] rise  [53:36] fall
   //                          18-bit rise | 18-bit fall (FIFO36, instance 3)
   //                          [71:54] rise  [71:54] fall
   //
   // The FIFO36 18-bit data is splitted among Parity (2-bit) and Data bits (16-bit).
   // Two MSB bits goes to Parity, the rest (16-bit) goes to data bits.
   //
   // A special case is required to handle shorter than 18-bit data width.  This
   // has not been implemented yet.
   // -----------------------------------------------------------------------------
   genvar i_rdfifo;

   generate
      for ( i_rdfifo = 0; i_rdfifo < RL_DQ_WIDTH/18; i_rdfifo = i_rdfifo + 1 )
      begin : rdfifo_gen_inst
         FIFO36  #(
      //      .ALMOST_FULL_OFFSET  ( 12'h080 ),
      //      .ALMOST_EMPTY_OFFSET ( 12'h007 ),
            .DATA_WIDTH              ( 36 ),
            .DO_REG                  ( 1 ),
            .EN_SYN                  ( "FALSE" ),
            .FIRST_WORD_FALL_THROUGH ( "FALSE" )
         )
         rdfifo  (
            .ALMOSTEMPTY ( ),
            .ALMOSTFULL  ( ),
//            .DO          ( {rldReadData_higher[15:0], rldReadData_lower[15:0]} ),
//            .DOP         ( {rldReadData_higher[17:16], rldReadData_lower[17:16]} ),
            .DO          ( {rldReadData_higher[(i_rdfifo+1)*18-2-1 -: (18-2)], rldReadData_lower[(i_rdfifo+1)*18-2-1 -: (18-2)]} ),
            .DOP         ( {rldReadData_higher[(i_rdfifo+1)*18-1 -: 2],        rldReadData_lower[(i_rdfifo+1)*18-1 -: 2]} ),
            .EMPTY       ( rlRdfSubEmpty[i_rdfifo] ),
            .FULL        ( rlRdfSubFull[i_rdfifo] ),
            .RDCOUNT     ( ),
            .RDERR       ( ),
            .WRCOUNT     ( ),
            .WRERR       ( ),
//            .DI          ( {dpRdData_higher[15:0], dpRdData_lower[15:0]} ),
//            .DIP         ( {dpRdData_higher[17:16], dpRdData_lower[17:16]} ),
            .DI          ( {dpRdData_higher[(i_rdfifo+1)*18-2-1 -: (18-2)], dpRdData_lower[(i_rdfifo+1)*18-2-1 -: (18-2)]} ),
            .DIP         ( {dpRdData_higher[(i_rdfifo+1)*18-1 -: 2],        dpRdData_lower[(i_rdfifo+1)*18-1 -: 2]} ),
            .RDCLK       ( clk ),
            //.RDEN        ( apRdfRdEn ),
            .RDEN        ( wren_RdFifo_r[5]),
            .RST         ( rstHard ),
            .WRCLK       ( clk270 ),
            .WREN        ( wren_RdFifo[i_rdfifo*NUM_OF_FIFOS] )  // use even byte (skip odd byte)
         );
      end
   endgenerate



   // concatenate flags from individual "read data" FIFOs
   // do not use FLAGS, issues seen.
   assign rlRdfFull  = | ( rlRdfSubFull [(RL_DQ_WIDTH/18)-1:0] );
   assign rlRdfEmpty = | ( rlRdfSubEmpty[(RL_DQ_WIDTH/18)-1:0] );
   
   // -----------------------------------------------------------------------------
   // Read Data valid flag (will be used by the user or test bench)
   // -----------------------------------------------------------------------------
   // User to change the Read-enable for the read Data FIFOs from automatic to manual
   /*always @( posedge clk )
   begin
      if ( rstHard )
         rldReadDataValid <= 1'b0;
      else
         rldReadDataValid <= apRdfRdEn & ~rlRdfEmpty;
   end*/
   
  /*always @ (posedge clk)
  begin
    if (rstHard)
      rlRdfEmpty <= 1'b1;
    else
      rlRdfEmpty <= | ( rlRdfSubEmpty[NUM_OF_DEVS-1:0] );
  end */
   
  always @ (posedge clk270)
  begin
    if (rstHard_270)
      wren_RdFifo_r[0] <= 1'b0;
    else
      wren_RdFifo_r[0] <= apRdfRdEn;
  end
  
  always @ (posedge clk90)
  begin
    if (rstHard_90)
      wren_RdFifo_r[1] <= 1'b0;
    else
      wren_RdFifo_r[1] <= wren_RdFifo_r[0];
  end
   
  always @ (posedge clk)
  begin
    if (rstHard) begin
      wren_RdFifo_r[5:2] <= 3'b0;
      rldReadDataValid   <= 1'b0;
    end else begin
      wren_RdFifo_r[2] <= wren_RdFifo_r[1];
      wren_RdFifo_r[3] <= wren_RdFifo_r[2];
      wren_RdFifo_r[4] <= wren_RdFifo_r[3];
      wren_RdFifo_r[5] <= wren_RdFifo_r[4];
      
      rldReadDataValid <= wren_RdFifo_r[5]; //data is valid one clock cycle after read_enable
    end    
  end 
  
  

   // -----------------------------------------------------------------------------
   // Write Data FIFO "wdfifo"
   //   - include bits for DM signals (i.e. larger FIFO to store data + mask)
   //   - store data (from the user) to be written to RL2
   // -----------------------------------------------------------------------------
   // The write data format is a concatenation of the rising data (in MSB) and 
   // the falling data (in LSB).  The data is stored in FIFO36 where 18-bit rise
   // and 18-bit fall are stored using {MSB | LSB} 36-bit format.
   //
   // For instance,
   // 18-bit RL2 data width => 18-bit rise | 18-bit fall (FIFO36, instance 0)
   //                          [17:0] rise   [17:0] fall
   //
   // 36-bit RL2 data width => 18-bit rise | 18-bit fall (FIFO36, instance 0)
   //                          [17:0] rise   [17:0] fall
   //                          18-bit rise | 18-bit fall (FIFO36, instance 1)
   //                          [35:18] rise  [35:18] fall
   //
   // 54-bit RL2 data width => 18-bit rise | 18-bit fall (FIFO36, instance 0)
   //                          [17:0] rise   [17:0] fall
   //                          18-bit rise | 18-bit fall (FIFO36, instance 1)
   //                          [35:18] rise  [35:18] fall
   //                          18-bit rise | 18-bit fall (FIFO36, instance 2)
   //                          [53:36] rise  [53:36] fall
   //
   // 72-bit RL2 data width => 18-bit rise | 18-bit fall (FIFO36, instance 0)
   //                          [17:0] rise   [17:0] fall
   //                          18-bit rise | 18-bit fall (FIFO36, instance 1)
   //                          [35:18] rise  [35:18] fall
   //                          18-bit rise | 18-bit fall (FIFO36, instance 2)
   //                          [53:36] rise  [53:36] fall
   //                          18-bit rise | 18-bit fall (FIFO36, instance 3)
   //                          [71:54] rise  [71:54] fall
   //
   // The FIFO36 18-bit data is splitted among Parity (2-bit) and Data bits (16-bit).
   // Two MSB bits goes to Parity, the rest (16-bit) goes to data bits.
   //
   // A special case is required to handle shorter than 18-bit data width.  This
   // has not been implemented yet.
   // -----------------------------------------------------------------------------
   genvar i_wdfifo;

   generate
      for ( i_wdfifo = 0; i_wdfifo < RL_DQ_WIDTH/18; i_wdfifo = i_wdfifo + 1 )
      begin : wdfifo_gen_inst
         FIFO36  #(
      //      .ALMOST_FULL_OFFSET  ( 12'h080 ),
      //      .ALMOST_EMPTY_OFFSET ( 12'h007 ),
            .DATA_WIDTH              ( 36 ),
            .DO_REG                  ( 1 ),
            .EN_SYN                  ( "FALSE" ),
            .FIRST_WORD_FALL_THROUGH ( "FALSE" )
         )
         wdfifo  (
            .ALMOSTEMPTY ( rlWdfAlmostEmpty_f[i_wdfifo] ),
            .ALMOSTFULL  ( rlWdfAlmostFull_f[i_wdfifo] ),
//            .DO          ( {wdfD[51:36], wdfD[15:0]} ),
//            .DOP         ( {wdfD[53:52], wdfD[17:16]} ),
            .DO          ( {wdfD[RL_DQ_WIDTH+(i_wdfifo+1)*18-2-1 -: (18-2)], wdfD[(i_wdfifo+1)*18-2-1 -: (18-2)]} ),
            .DOP         ( {wdfD[RL_DQ_WIDTH+(i_wdfifo+1)*18-1 -: 2],        wdfD[(i_wdfifo+1)*18-1 -: 2]} ),
            .EMPTY       ( rlWdfEmpty_f[i_wdfifo] ),
            .FULL        ( rlWdfFull_f[i_wdfifo] ),
            .RDCOUNT     ( rlWdfRdCount_f[(i_wdfifo+1)*13-1 -: 13] ),
            .RDERR       ( ),
            .WRCOUNT     ( rlWdfWrCount_f[(i_wdfifo+1)*13-1 -: 13] ),
            .WRERR       ( ),
//            .DI          ( {apWriteData[51:36], apWriteData[15:0]} ),
//            .DIP         ( {apWriteData[53:52], apWriteData[17:16]} ),
            .DI          ( {apWriteData[RL_DQ_WIDTH+(i_wdfifo+1)*18-2-1 -: (18-2)], apWriteData[(i_wdfifo+1)*18-2-1 -: (18-2)]} ),
            .DIP         ( {apWriteData[RL_DQ_WIDTH+(i_wdfifo+1)*18-1 -: 2],        apWriteData[(i_wdfifo+1)*18-1 -: 2]} ),
            .RDCLK       ( clk ),
            .RDEN        ( ctlWdfRdEn ),
            .RST         ( rstHard ),
            .WRCLK       ( clk ),
            .WREN        ( apWriteDValid )
         );
      end
   endgenerate


   FIFO18  #(
//      .ALMOST_FULL_OFFSET  ( 12'h080 ),
//      .ALMOST_EMPTY_OFFSET ( 12'h007 ),
      // valid DATA_WIDTH values are 4, 9 or 18
      .DATA_WIDTH              ( (2*NUM_OF_DEVS < 5) ? 4 : ( (2*NUM_OF_DEVS < 10) ? 9 : 18 ) ),  // 9 devices max per Controller
      .DO_REG                  ( 1 ),
      .EN_SYN                  ( "FALSE" ),
      .FIRST_WORD_FALL_THROUGH ( "FALSE" )
   )
   wdfifo_DM  (
      .ALMOSTEMPTY ( rlWdfAlmostEmpty_DM ),
      .ALMOSTFULL  ( rlWdfAlmostFull_DM ),
      .DO          ( wdfDM ),
      .DOP         ( ),
      .EMPTY       ( rlWdfEmpty_DM ),
      .FULL        ( rlWdfFull_DM ),
      .RDCOUNT     ( ),
      .RDERR       ( ),
      .WRCOUNT     ( ),
      .WRERR       ( ),
      .DI          ( apWriteDM ),
      .DIP         ( ),
      .RDCLK       ( clk ),
      .RDEN        ( ctlWdfRdEn ),
      .RST         ( rstHard ),
      .WRCLK       ( clk ),
      .WREN        ( apWriteDValid )
   );


   // concatenate flags from individual "write data" FIFOs
//   assign rlWdfEmpty = rlWdfEmpty_0 | rlWdfEmpty_1 | rlWdfEmpty_2;
//   assign rlWdfFull  = rlWdfFull_0  | rlWdfFull_1  | rlWdfFull_2;
   assign rlWdfEmpty = | ( rlWdfEmpty_f[(RL_DQ_WIDTH/18)-1:0] ) | rlWdfEmpty_DM;
   assign rlWdfFull  = | ( rlWdfFull_f[(RL_DQ_WIDTH/18)-1:0] )  | rlWdfFull_DM;

   assign rlWdfAlmostEmpty = | ( rlWdfAlmostEmpty_f[(RL_DQ_WIDTH/18)-1:0] ) | rlWdfAlmostEmpty_DM;
   assign rlWdfAlmostFull  = | ( rlWdfAlmostFull_f[(RL_DQ_WIDTH/18)-1:0] )  | rlWdfAlmostFull_DM;

   assign rlWdfWrCount   = rlWdfWrCount_f[12:0];  // use first FIFO's count of "write data FIFO write count"
   assign rlWdfRdCount   = rlWdfRdCount_f[12:0];  // use first FIFO's count of "write data FIFO read count"
   assign rlWdfWordCount = rlWdfWrCount_f[12:0] - rlWdfRdCount_f[12:0];  // number of words in "write data FIFO"


   // -----------------------------------------------------------------------------
   // Command & Address merged FIFO "rafifo"
   //   - Store command and address (from the user)
   // -----------------------------------------------------------------------------
   FIFO36  #(
//      .ALMOST_FULL_OFFSET  ( 12'h080 ),
      .ALMOST_EMPTY_OFFSET ( 12'h009 ), //arbitrary setting, may need to change based on HW tests
      .DATA_WIDTH              ( 36 ),
      .DO_REG                  ( 1 ),
      .EN_SYN                  ( "FALSE" ),
      .FIRST_WORD_FALL_THROUGH ( "FALSE" )
   )
   rafifo0  (
      .ALMOSTEMPTY ( rlafAlmostEmpty ),
      .ALMOSTFULL  ( rlafAlmostFull ),
      .DO          ( afA ),
      .DOP         ( ),
      .EMPTY       ( rlafEmpty ),
      .FULL        ( rlafFull ),
      .RDCOUNT     ( rlafRdCount ),
      .RDERR       ( ),
      .WRCOUNT     ( rlafWrCount ),
      .WRERR       ( ),
      .DI          ( apAddr ),
      .DIP         ( ),
      .RDCLK       ( clk ),
      .RDEN        ( ctlafRdEn ),
      .RST         ( rstHard ),
      .WRCLK       ( clk ),
      .WREN        ( apValid )
   );

   assign rlafWordCount = rlafWrCount - rlafRdCount;  // number of words in "command/address FIFO"


endmodule
