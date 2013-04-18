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
//  /   /         Filename           : qdrii_phy_q_io.v
// /___/   /\     Timestamp          : 15 May 2006
// \   \  /  \    Date Last Modified : $Date: 2010/11/26 18:26:07 $
//  \___\/\___\
//
//Device: Virtex-5
//Design: QDRII
//
//Purpose:
//    This module
//       1. Is used to capture data inside the FPGA and transfer the captured
//          data in the FPGA clock domain.
//       2. instantiates phy_v5_q_io module
//
//Revision History:
//   Rev 1.1 - Parameter IODELAY_GRP added. PK. 11/27/08
//*****************************************************************************

`timescale 1ns/1ps

module qdrii_phy_q_io #
  (
   // Following parameters are for 72-bit design (for ML561 Reference board
   // design). Actual values may be different. Actual parameters values are
   // passed from design top module controller module. Please refer to the
   // controller module for actual values.
   parameter CQ_WIDTH              = 2,
   parameter DATA_WIDTH            = 72,
   parameter HIGH_PERFORMANCE_MODE = "TRUE",
   parameter IODELAY_GRP           = "IODELAY_MIG",
   parameter Q_PER_CQ              = 18
   )
  (
   input [Q_PER_CQ-1:0]  qdr_q,
   input                 bufio_clk,
   input                 q_dly_ce,
   input                 q_dly_inc,
   input                 q_dly_rst,
   input                 cal_clk,
   output [Q_PER_CQ-1:0] qdr_q_rise,
   output [Q_PER_CQ-1:0] qdr_q_fall
   );

   genvar mw_i;
   generate
      for(mw_i=0; mw_i < Q_PER_CQ; mw_i=mw_i+1)
        begin:MEM_INST
           qdrii_phy_v5_q_io #
             (
              .HIGH_PERFORMANCE_MODE ( HIGH_PERFORMANCE_MODE ),
              .IODELAY_GRP           ( IODELAY_GRP )
              )
             u_qdrii_phy_v5_q_io
               (
                .qdr_q      ( qdr_q[mw_i] ),
                .bufio_clk  ( bufio_clk ),
                .q_dly_ce   ( q_dly_ce ),
                .q_dly_inc  ( q_dly_inc ),
                .q_dly_rst  ( q_dly_rst ),
                .cal_clk    ( cal_clk ),
                .qdr_q_rise ( qdr_q_rise[mw_i] ),
                .qdr_q_fall ( qdr_q_fall[mw_i] )
                );
        end
   endgenerate

endmodule