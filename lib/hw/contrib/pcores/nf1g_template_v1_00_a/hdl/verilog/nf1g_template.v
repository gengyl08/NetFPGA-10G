
/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        nf1g_template.v
 *
 *  Library:
 *        hw/contrib/pcores/nf1g_template_v1_00_a
 *
 *  Module:
 *        nf1g_template
 *
 *  Author:
 *        e.g. Muhammad Shahbaz
 *
 *  Description:
 *        NetFPGA-1G template for 1G to 10G port
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
module nf1g_template
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

// User logic

endmodule
