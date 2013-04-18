//*****************************************************************************
// DISCLAIMER OF LIABILITY
//
// This file contains proprietary and confidential information of
// Xilinx, Inc. ("Xilinx"), that is distributed under a license
// from Xilinx, and may be used, copied and/or disclosed only
// pursuant to the terms of a valid license agreement with Xilinx.
//
// XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION
// ("MATERIALS") "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
// EXPRESSED, IMPLIED, OR STATUTORY, INCLUDING WITHOUT
// LIMITATION, ANY WARRANTY WITH RESPECT TO NONINFRINGEMENT,
// MERCHANTABILITY OR FITNESS FOR ANY PARTICULAR PURPOSE. Xilinx
// does not warrant that functions included in the Materials will
// meet the requirements of Licensee, or that the operation of the
// Materials will be uninterrupted or error-free, or that defects
// in the Materials will be corrected. Furthermore, Xilinx does
// not warrant or make any representations regarding use, or the
// results of the use, of the Materials in terms of correctness,
// accuracy, reliability or otherwise.
//
// Xilinx products are not designed or intended to be fail-safe,
// or for use in any application requiring fail-safe performance,
// such as life-support or safety devices or systems, Class III
// medical devices, nuclear facilities, applications related to
// the deployment of airbags, or any other applications that could
// lead to death, personal injury or severe property or
// environmental damage (individually and collectively, "critical
// applications"). Customer assumes the sole risk and liability
// of any use of Xilinx products in critical applications,
// subject only to applicable laws and regulations governing
// limitations on product liability.
//
// Copyright 2006, 2007, 2008 Xilinx, Inc.
// All rights reserved.
//
// This disclaimer and copyright notice must be retained as part
// of this file at all times.
//*****************************************************************************
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor             : Xilinx
// \   \   \/     Version            : 3.6.1
//  \   \         Application        : MIG
//  /   /         Filename           : qdrii_phy_v5_q_io.v
// /___/   /\     Timestamp          : 15 May 2006
// \   \  /  \    Date Last Modified : $Date: 2010/11/26 18:26:07 $
//  \___\/\___\
//
//Device: Virtex-5
//Design: QDRII
//
//Purpose:
//    This module
//       1. is used to capture data inside the FPGA and transfer the captured
//          data in the FPGA clock domain
//       2. instantiates the Input buffer and ISERDES, clocked by the negative
//          edge of the memory clock.
//
//Revision History:
//   Rev 1.1 - Parameter IODELAY_GRP added and constraint IODELAY_GROUP added
//             on IODELAY primitive. PK. 11/27/08
//*****************************************************************************
`timescale 1ns/1ps

module qdrii_phy_v5_q_io #
  (
   parameter HIGH_PERFORMANCE_MODE = "TRUE",
   parameter IODELAY_GRP           = "IODELAY_MIG"
   )
  (
   input  qdr_q,
   input  bufio_clk,
   input  q_dly_ce,
   input  q_dly_inc,
   input  q_dly_rst,
   input  cal_clk,
   output qdr_q_rise,
   output qdr_q_fall
   );

   wire qdr_q_int;
   wire data_rise;
   wire data_fall;
   wire qdr_q_delay;
   wire iserdes_clk;
   wire iserdes_clkb;

   IBUF QDR_Q_IBUF
     (
      .I ( qdr_q ),
      .O ( qdr_q_int )
      );

   (* IODELAY_GROUP = IODELAY_GRP *) IODELAY #
    (
     .DELAY_SRC            ( "I" ),
     .IDELAY_TYPE          ( "VARIABLE" ),
     .HIGH_PERFORMANCE_MODE( HIGH_PERFORMANCE_MODE ),
     .IDELAY_VALUE         ( 0 ),
     .ODELAY_VALUE         ( 0 )
     )
    IODELAY_Q
      (
       .DATAOUT ( qdr_q_delay ),
       .C       ( cal_clk ),
       .CE      ( q_dly_ce ),
       .DATAIN  ( 1'b0 ),
       .IDATAIN ( qdr_q_int ),
       .INC     ( q_dly_inc ),
       .ODATAIN ( 1'b0 ),
       .RST     ( q_dly_rst ),
       .T       ( 1'b1 )
       );

  assign iserdes_clk  = bufio_clk;
  assign iserdes_clkb = ~bufio_clk;

  ISERDES_NODELAY #
     (
      .BITSLIP_ENABLE ( "FALSE" ),
      .DATA_RATE      ( "DDR" ),
      .DATA_WIDTH     ( 4 ),
      .INTERFACE_TYPE ( "MEMORY" ),
      .NUM_CE         ( 2 ),
      .SERDES_MODE    ( "MASTER" )
      )
     ISERDES_Q
       (
        .Q1        ( data_fall ),
        .Q2        ( data_rise ),
        .Q3        ( ),
        .Q4        ( ),
        .Q5        ( ),
        .Q6        ( ),
        .SHIFTOUT1 ( ),
        .SHIFTOUT2 ( ),
        .BITSLIP   ( 1'b0 ),
        .CE1       ( 1'd1 ),
        .CE2       ( 1'd1 ),
        .CLK       ( iserdes_clk ),
        .CLKB      ( iserdes_clkb ),
        .CLKDIV    ( cal_clk ),
        .D         ( qdr_q_delay ),
        .OCLK      ( cal_clk ),
        .RST       ( 1'b0 ),
        .SHIFTIN1  ( 1'b0 ),
        .SHIFTIN2  ( 1'b0 )
        );

   assign qdr_q_rise = data_rise;
   assign qdr_q_fall = data_fall;

endmodule