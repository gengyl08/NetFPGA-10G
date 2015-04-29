/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        nf10_axis_converter.v
 *
 *  Library:
 *        hw/std/pcores/nf10_axis_converter_v1_00_a
 *
 *  Module:
 *        nf10_axis_converter
 *
 *  Author:
 *        Yilong Geng
 *
 *  Description:
 *        Convert AXI4-Streams to different data width
 *        Add LEN subchannel
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

module converter_256_64
#(
    // Master AXI Stream Data Width
    parameter C_M_AXIS_DATA_WIDTH=64,
    parameter C_S_AXIS_DATA_WIDTH=256,

    parameter C_M_AXIS_TUSER_WIDTH=128,
    parameter C_S_AXIS_TUSER_WIDTH=128
)
(
    // Global Ports
    input axi_aclk,
    input axi_resetn,

    // Master Stream Ports
    output reg [C_M_AXIS_DATA_WIDTH - 1:0] m_axis_tdata,
    output reg [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0] m_axis_tstrb,
    output reg [C_M_AXIS_TUSER_WIDTH-1:0] m_axis_tuser,
    output reg m_axis_tvalid,
    input  m_axis_tready,
    output reg m_axis_tlast,

    // Slave Stream Ports
    input [C_S_AXIS_DATA_WIDTH - 1:0] s_axis_tdata,
    input [((C_S_AXIS_DATA_WIDTH / 8)) - 1:0] s_axis_tstrb,
    input [C_S_AXIS_TUSER_WIDTH-1:0] s_axis_tuser,
    input  s_axis_tvalid,
    output s_axis_tready,
    input  s_axis_tlast
);

reg in_fifo_rd_en;
wire [255:0] tdata_fifo;
wire [127:0] tuser_fifo;
wire [31:0] tstrb_fifo;
wire tlast_fifo;
wire in_fifo_full;
wire in_fifo_empty;


fallthrough_small_fifo
#(.WIDTH(417),
  .MAX_DEPTH_BITS(2)
 )
in_fifo
(.din({s_axis_tdata, s_axis_tuser, s_axis_tstrb, s_axis_tlast}),     // Data in
 .wr_en(s_axis_tvalid && s_axis_tready),   // Write enable
 .rd_en(in_fifo_rd_en),   // Read the next word
 .dout({tdata_fifo, tuser_fifo, tstrb_fifo, tlast_fifo}),    // Data out
 .full(),
 .nearly_full(in_fifo_full),
 .prog_full(),
 .empty(in_fifo_empty),
 .reset(~axi_resetn),
 .clk(axi_aclk)
);

assign s_axis_tready = !in_fifo_full;

localparam STATE_IDLE = 0;
localparam STATE_L1 = 1;
localparam STATE_L2 = 2;
localparam STATE_L3 = 3;
localparam STATE_L4 = 4;

reg [2:0] state, state_nxt;

always @(*) begin
   state_nxt = state;

   m_axis_tdata = 0;
   m_axis_tuser = tuser_fifo;
   m_axis_tstrb = 0;
   m_axis_tlast = 0;
   m_axis_tvalid = 0;

   in_fifo_rd_en = 0;

   case(state)
      STATE_IDLE: begin
         if(!in_fifo_empty) begin
            m_axis_tdata = tdata_fifo[63:0];
            m_axis_tstrb = tstrb_fifo[7:0];
            m_axis_tlast = tlast_fifo & !tstrb_fifo[8];
            m_axis_tvalid = 1;
            if(m_axis_tready) begin
               if(tlast_fifo & !tstrb_fifo[8]) begin
                  in_fifo_rd_en = 1;
               end
               else begin
                  state_nxt = STATE_L2;
               end
            end
         end
      end

      STATE_L1: begin
         if(!in_fifo_empty) begin
            m_axis_tdata = tdata_fifo[63:0];
            m_axis_tstrb = tstrb_fifo[7:0];
            m_axis_tlast = tlast_fifo & !tstrb_fifo[8];
            m_axis_tvalid = 1;
            if(m_axis_tready) begin
               if(tlast_fifo & !tstrb_fifo[8]) begin
                  in_fifo_rd_en = 1;
                  state_nxt = STATE_IDLE;
               end
               else begin
                  state_nxt = STATE_L2;
               end
            end
         end
      end

      STATE_L2: begin
         m_axis_tdata = tdata_fifo[127:64];
         m_axis_tstrb = tstrb_fifo[15:8];
         m_axis_tlast = tlast_fifo & !tstrb_fifo[16];
         m_axis_tvalid = 1;
         if(m_axis_tready) begin
            if(tlast_fifo & !tstrb_fifo[16]) begin
               in_fifo_rd_en = 1;
               state_nxt = STATE_IDLE;
            end
            else begin
               state_nxt = STATE_L3;
            end
         end
      end

      STATE_L3: begin
         m_axis_tdata = tdata_fifo[191:128];
         m_axis_tstrb = tstrb_fifo[23:16];
         m_axis_tlast = tlast_fifo & !tstrb_fifo[24];
         m_axis_tvalid = 1;
         if(m_axis_tready) begin
            if(tlast_fifo & !tstrb_fifo[24]) begin
               in_fifo_rd_en = 1;
               state_nxt = STATE_IDLE;
            end
            else begin
               state_nxt = STATE_L4;
            end
         end
      end

      STATE_L4: begin
         m_axis_tdata = tdata_fifo[255:192];
         m_axis_tstrb = tstrb_fifo[31:24];
         m_axis_tlast = tlast_fifo;
         m_axis_tvalid = 1;
         if(m_axis_tready) begin
            in_fifo_rd_en = 1;
            if(tlast_fifo) begin
               state_nxt = STATE_IDLE;
            end
            else begin
               state_nxt = STATE_L1;
            end
         end
      end

   endcase
end

always @(posedge axi_aclk) begin
   if(~axi_resetn) begin
      state <= STATE_IDLE;
   end
   else begin
      state <= state_nxt;
   end
end

endmodule
