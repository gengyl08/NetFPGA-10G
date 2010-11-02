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
// \   \   \/     Version            : 3.0
//  \   \         Application        : MIG
//  /   /         Filename           : qdrii_idelay_ctrl.v
// /___/   /\     Timestamp          : 15 May 2006
// \   \  /  \    Date Last Modified : $Date: 2008/12/23 14:26:03 $
//  \___\/\___\
//
//Device: Virtex-5
//Design: QDRII
//
//Purpose:
//    This module
//       1. instantiates IDELAYCTRL primitives to generate the IDELAY ready
//          signal. This uses the 200 MHz reference clock input.
//Revision History:
//
//*****************************************************************************

`timescale 1ns/1ps

module qdrii_idelay_ctrl #
  (
   // Following parameters are for 72-bit design (for ML561 Reference board
   // design). Actual values may be different. Actual parameters values are
   // passed from design top module netfpga_c012 module. Please refer to the
   // netfpga_c012 module for actual values.
   parameter IODELAY_GRP     = "IODELAY_MIG"
  )
  (
   input  clk200,
   input  user_rst_200,
   output idelay_ctrl_rdy
   );

  wire idelay_ctrl_rdy_0;
  wire idelay_ctrl_rdy_1;
  wire idelay_ctrl_rdy_2;

  /*synthesis syn_keep = 1 */(* LOC = "IDELAYCTRL_X0Y10" *)
  IDELAYCTRL U_IDELAYCTRL_0
    (
     .RDY    ( idelay_ctrl_rdy_0 ),
     .REFCLK ( clk200 ),
     .RST    ( user_rst_200 )
     );

  /*synthesis syn_keep = 1 */(* LOC = "IDELAYCTRL_X1Y10" *)
  IDELAYCTRL U_IDELAYCTRL_1
    (
     .RDY    ( idelay_ctrl_rdy_1 ),
     .REFCLK ( clk200 ),
     .RST    ( user_rst_200 )
     );

  /*synthesis syn_keep = 1 */(* LOC = "IDELAYCTRL_X2Y10" *)
  IDELAYCTRL U_IDELAYCTRL_2
    (
     .RDY    ( idelay_ctrl_rdy_2 ),
     .REFCLK ( clk200 ),
     .RST    ( user_rst_200 )
     );

  assign idelay_ctrl_rdy = idelay_ctrl_rdy_0 && idelay_ctrl_rdy_1 && idelay_ctrl_rdy_2;

endmodule
