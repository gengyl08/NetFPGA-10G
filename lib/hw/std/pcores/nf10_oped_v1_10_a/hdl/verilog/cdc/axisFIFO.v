/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        axisFIFO.v
 *
 *  Library:
 *        hw/std/pcores/nf10_oped_v1_10_a
 *
 *  Module:
 *        axisFIFO
 *
 *  Author:
 *        James Hongyi Zeng
 *
 *  Description:
 *        AXIS FIFO
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

`timescale 1ps/1ps

module axisFIFO(
  m_aclk,
  s_aclk,
  s_aresetn,
  s_axis_tvalid,
  s_axis_tready,
  s_axis_tdata,
  s_axis_tuser,
  s_axis_tstrb,
  s_axis_tlast,
  m_axis_tvalid,
  m_axis_tready,
  m_axis_tdata,
  m_axis_tuser,
  m_axis_tstrb,
  m_axis_tlast
);

parameter C_AXIS_DATA_WIDTH = 32;
parameter C_AXIS_USER_WIDTH = 128;

input m_aclk;
input s_aclk;
input s_aresetn;
input s_axis_tvalid;
output s_axis_tready;
input [C_AXIS_DATA_WIDTH-1 : 0] s_axis_tdata;
input [C_AXIS_DATA_WIDTH/8-1 : 0] s_axis_tstrb;
input [C_AXIS_USER_WIDTH-1 : 0] s_axis_tuser;
input s_axis_tlast;
output m_axis_tvalid;
input m_axis_tready;
output [C_AXIS_DATA_WIDTH-1 : 0] m_axis_tdata;
output [C_AXIS_DATA_WIDTH/8-1 : 0] m_axis_tstrb;
output [C_AXIS_USER_WIDTH-1 : 0] m_axis_tuser;
output m_axis_tlast;

wire nearly_full;
wire empty;
assign s_axis_tready = ~nearly_full;
assign m_axis_tvalid = ~empty;

    fallthrough_small_async_fifo
    #(.WIDTH(C_AXIS_DATA_WIDTH+C_AXIS_DATA_WIDTH/8+1+C_AXIS_USER_WIDTH),
      .MAX_DEPTH_BITS(3))
      fifo
    (

     .din({s_axis_tdata, s_axis_tstrb, s_axis_tlast, s_axis_tuser}),     // Data in
     .wr_en(s_axis_tvalid & s_axis_tready),   // Write enable

     .rd_en(m_axis_tvalid & m_axis_tready),   // Read the next word

     .dout({m_axis_tdata, m_axis_tstrb, m_axis_tlast, m_axis_tuser}),    // Data out
     .full(),
     .nearly_full(nearly_full),
     .empty(empty),

     .reset(~s_aresetn),
     .rd_clk(m_aclk),
     .wr_clk(s_aclk)
     );

endmodule
