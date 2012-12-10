
/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        nf1g_router_port.v
 *
 *  Library:
 *        hw/contrib/pcores/nf1g_router_port_v1_00_a
 *
 *  Module:
 *        nf1g_router_port
 *
 *  Author:
 *        Muhammad Shahbaz
 *
 *  Description:
 *        NetFPGA-1G ROUTER port
 *
 *  Copyright notice:
 *        Copyright (C) 2010, 2011 The Board of Trustees of The Leland Stanford
 *                                 Junior University
 *
 *  Licence:
 *        This file is part of the NetFPGA 10G development base package.
 *
 *        This file is free code: you can redistribute it and/or modify it under
 *        the terms of the GNU Lesser General Public License version 2.1 as
 *        published by the Free Software Foundation.
 *
 *        This package is distributed in the hope that it will be useful, but
 *        WITHOUT ANY WARRANTY; without even the implied warranty of
 *        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *        Lesser General Public License for more details.
 *
 *        You should have received a copy of the GNU Lesser General Public
 *        License along with the NetFPGA source package.  If not, see
 *        http://www.gnu.org/licenses/.
 *
 */

`timescale 1ns/1ps
module nf1g_router_port
#(
    parameter C_S_PBS_DATA_WIDTH = 64,
    parameter C_M_PBS_DATA_WIDTH = 64,
    parameter C_RBS_ADDR_WIDTH = 32,
    parameter C_RBS_DATA_WIDTH = 32,
    parameter C_RBS_SRC_WIDTH = 2
)
(
   // Clock and Reset signals
   input                                    CLK,
   input                                    RESET,   
   
   // 1G Packet side signals
   output     [C_M_PBS_DATA_WIDTH-1:0]      M_PBS_DATA,
   output     [C_M_PBS_DATA_WIDTH/8-1:0]    M_PBS_CTRL,
   output				    M_PBS_WR,	
   input				    M_PBS_RDY,
   
   input      [C_S_PBS_DATA_WIDTH-1:0]      S_PBS_DATA,
   input      [C_S_PBS_DATA_WIDTH/8-1:0]    S_PBS_CTRL,
   input                                    S_PBS_WR,
   output                                   S_PBS_RDY,

   // 1G Register side signals
   input                                    S_RBS_REQ,
   input                                    S_RBS_ACK,
   input                                    S_RBS_RD_WR_L,
   input [(C_RBS_ADDR_WIDTH-2)-1:0]         S_RBS_ADDR,
   input [C_RBS_DATA_WIDTH-1:0]             S_RBS_DATA,
   input [C_RBS_SRC_WIDTH-1:0]              S_RBS_SRC,

   output                                   M_RBS_REQ,
   output                                   M_RBS_ACK,
   output                                   M_RBS_RD_WR_L,
   output [(C_RBS_ADDR_WIDTH-2)-1:0]        M_RBS_ADDR,
   output [C_RBS_DATA_WIDTH-1:0]            M_RBS_DATA,
   output [C_RBS_SRC_WIDTH-1:0]             M_RBS_SRC
);

  // ROUTER logic
  output_port_lookup
  #(
      .DATA_WIDTH (C_S_PBS_DATA_WIDTH),
      .UDP_REG_SRC_WIDTH (C_RBS_SRC_WIDTH)
   ) olut
   (
       // --- data path interface
       .out_data (M_PBS_DATA),
       .out_ctrl (M_PBS_CTRL),
       .out_wr (M_PBS_WR),
       .out_rdy (M_PBS_RDY),

       .in_data (S_PBS_DATA),
       .in_ctrl (S_PBS_CTRL),
       .in_wr (S_PBS_WR),
       .in_rdy (S_PBS_RDY),

       // --- Register interface
       .reg_req_in (S_RBS_REQ),
       .reg_ack_in (S_RBS_ACK),
       .reg_rd_wr_L_in (S_RBS_RD_WR_L),
       .reg_addr_in (S_RBS_ADDR),
       .reg_data_in (S_RBS_DATA),
       .reg_src_in (S_RBS_SRC),

       .reg_req_out (M_RBS_REQ),
       .reg_ack_out (M_RBS_ACK),
       .reg_rd_wr_L_out (M_RBS_RD_WR_L),
       .reg_addr_out (M_RBS_ADDR),
       .reg_data_out (M_RBS_DATA),
       .reg_src_out (M_RBS_SRC),

       // --- Misc
       .clk (CLK),
       .reset (RESET)
    );

endmodule
