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
//  /   /         Filename           : qdrii_phy_cq_io.v
// /___/   /\     Timestamp          : 15 May 2006
// \   \  /  \    Date Last Modified : $Date: 2010/11/26 18:26:06 $
//  \___\/\___\
//
//Device: Virtex-5
//Design: QDRII
//
//Purpose:
//    This module
//      1. Is the I/O module for the incoming memory read clock (CQ).
//      2. Instantiates the IDELAY to delay the clock and routes it through
//         BUFIO.
//
//Revision History:
//   Rev 1.1 - Parameter IODELAY_GRP added and constraint IODELAY_GROUP added
//             on IODELAY primitives. PK. 11/27/08
//*****************************************************************************


`timescale 1ns/1ps

module qdrii_phy_cq_io #
  (
   parameter HIGH_PERFORMANCE_MODE = "TRUE",
   parameter IODELAY_GRP           = "IODELAY_MIG"
   )
  (
   input  qdr_cq,
   input  cal_clk,
   input  cq_dly_ce,
   input  cq_dly_inc,
   input  cq_dly_rst,
   output qdr_cq_bufio
   );

   wire qdr_cq_int;
   wire qdr_cq_delay;
   wire qdr_cq_bufio_w;

   //***************************************************************************
   // CQ path inside the IOB
   //***************************************************************************

   IBUF QDR_CQ_IBUF
     (
      .I ( qdr_cq ),
      .O ( qdr_cq_int )
      );

   (* IODELAY_GROUP = IODELAY_GRP *) IODELAY #
    (
     .DELAY_SRC            ( "I" ),
     .IDELAY_TYPE          ( "VARIABLE" ),
     .HIGH_PERFORMANCE_MODE( HIGH_PERFORMANCE_MODE ),
     .IDELAY_VALUE         ( 0 ),
     .ODELAY_VALUE         ( 0 )
     )
    IODELAY_CQ
      (
       .DATAOUT ( qdr_cq_delay ),
       .C       ( cal_clk ),
       .CE      ( cq_dly_ce ),
       .DATAIN  ( 1'b0 ),
       .IDATAIN ( qdr_cq_int ),
       .INC     ( cq_dly_inc ),
       .ODATAIN ( 1'b0 ),
       .RST     ( cq_dly_rst ),
       .T       ( 1'b1 )
       );

//   IDELAY #
//     (
//      .IOBDELAY_TYPE  ( "VARIABLE" ),
//      .IOBDELAY_VALUE ( 0 )
//      )
//    QDR_CQ_IDELAY
//     (
//      .O   ( qdr_cq_delay ),
//      .C   ( cal_clk ),
//      .CE  ( cq_dly_ce ),
//      .I   ( qdr_cq_int ),
//      .INC ( cq_dly_inc ),
//      .RST ( cq_dly_rst )
//      );

   BUFIO QDR_CQ_BUFIO_INST
     (
      .I ( qdr_cq_delay ),
      .O ( qdr_cq_bufio_w )
      );

   assign #1.0 qdr_cq_bufio =  qdr_cq_bufio_w;

endmodule