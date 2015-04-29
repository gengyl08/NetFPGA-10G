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
 *        James Hongyi Zeng
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

module my_converter
#(
    // Master AXI Stream Data Width
    parameter C_M_AXIS_DATA_WIDTH=256,
    parameter C_S_AXIS_DATA_WIDTH=64,

    parameter C_M_AXIS_TUSER_WIDTH=128,
    parameter C_S_AXIS_TUSER_WIDTH=128,

    parameter C_DEFAULT_SRC_PORT=0,
    parameter C_DEFAULT_DST_PORT=0
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
wire [63:0] tdata_fifo;
wire [7:0] tstrb_fifo;
wire tlast_fifo;
wire in_fifo_full;
wire in_fifo_empty;


fallthrough_small_fifo
#(.WIDTH(73),
  .MAX_DEPTH_BITS(8)
 )
in_fifo
(.din({s_axis_tdata, s_axis_tstrb, s_axis_tlast}),     // Data in
 .wr_en(s_axis_tvalid && s_axis_tready),   // Write enable
 .rd_en(in_fifo_rd_en),   // Read the next word
 .dout({tdata_fifo, tstrb_fifo, tlast_fifo}),    // Data out
 .full(),
 .nearly_full(in_fifo_full),
 .prog_full(),
 .empty(in_fifo_empty),
 .reset(~axi_resetn),
 .clk(axi_aclk)
);

reg [127:0] tuser_fifo_din;
reg tuser_fifo_wr_en;
reg tuser_fifo_rd_en;
wire [127:0] tuser_fifo_dout;
wire tuser_fifo_full;
wire tuser_fifo_empty;

fallthrough_small_fifo
#(.WIDTH(128),
  .MAX_DEPTH_BITS(8)
 )
tuser_fifo
(.din(tuser_fifo_din),     // Data in
 .wr_en(tuser_fifo_wr_en),   // Write enable
 .rd_en(tuser_fifo_rd_en),   // Read the next word
 .dout(tuser_fifo_dout),    // Data out
 .full(),
 .nearly_full(tuser_fifo_full),
 .prog_full(),
 .empty(tuser_fifo_empty),
 .reset(~axi_resetn),
 .clk(axi_aclk)
);

assign s_axis_tready = !in_fifo_full && !tuser_fifo_full;

localparam META_STATE_IDLE = 0;
localparam META_STATE_DATA = 1;

reg meta_state, meta_state_nxt;
reg [15:0] pkt_len, pkt_len_nxt;

always @(*) begin

   meta_state_nxt = meta_state;
   pkt_len_nxt = pkt_len;

   tuser_fifo_din[127:32] = 0;
   tuser_fifo_din[23:16] = C_DEFAULT_SRC_PORT;
   tuser_fifo_din[31:24] = C_DEFAULT_DST_PORT;
   tuser_fifo_din[15:0] = 0;
   tuser_fifo_wr_en = 0;

   case(meta_state)

      META_STATE_IDLE: begin
         if(s_axis_tvalid && s_axis_tready) begin
            if(!s_axis_tlast) begin
               pkt_len_nxt = 8;
               meta_state_nxt = META_STATE_DATA;
            end
            else begin
               case(s_axis_tstrb)
                 8'h01: begin
                    tuser_fifo_din[15:0] = 16'd1;
                 end
                 8'h03: begin
                    tuser_fifo_din[15:0] = 16'd2;
                 end
                 8'h07: begin
                    tuser_fifo_din[15:0] = 16'd3;
                 end
                 8'h0f: begin
                    tuser_fifo_din[15:0] = 16'd4;
                 end
                 8'h1f: begin
                    tuser_fifo_din[15:0] = 16'd5;
                 end
                 8'h3f: begin
                    tuser_fifo_din[15:0] = 16'd6;
                 end
                 8'h7f: begin
                    tuser_fifo_din[15:0] = 16'd7;
                 end
                 8'hff: begin
                    tuser_fifo_din[15:0] = 16'd8;
                 end
                 default: begin
                    tuser_fifo_din[15:0] = 16'd8;
                 end
               endcase
               tuser_fifo_wr_en = 1;
            end
         end
      end

      META_STATE_DATA: begin
         if(s_axis_tvalid && s_axis_tready) begin
            if(!s_axis_tlast) begin
               pkt_len_nxt = pkt_len + 8;
            end
            else begin
               case(s_axis_tstrb)
                 8'h01: begin
                    tuser_fifo_din[15:0] = pkt_len + 16'd1;
                 end
                 8'h03: begin
                    tuser_fifo_din[15:0] = pkt_len + 16'd2;
                 end
                 8'h07: begin
                    tuser_fifo_din[15:0] = pkt_len + 16'd3;
                 end
                 8'h0f: begin
                    tuser_fifo_din[15:0] = pkt_len + 16'd4;
                 end
                 8'h1f: begin
                    tuser_fifo_din[15:0] = pkt_len + 16'd5;
                 end
                 8'h3f: begin
                    tuser_fifo_din[15:0] = pkt_len + 16'd6;
                 end
                 8'h7f: begin
                    tuser_fifo_din[15:0] = pkt_len + 16'd7;
                 end
                 8'hff: begin
                    tuser_fifo_din[15:0] = pkt_len + 16'd8;
                 end
                 default: begin
                    tuser_fifo_din[15:0] = pkt_len + 16'd8;
                 end
               endcase
               tuser_fifo_wr_en = 1;
               meta_state_nxt = META_STATE_IDLE;
            end
         end
      end

   endcase

end

always @(posedge axi_aclk) begin
   if(~axi_resetn) begin
      meta_state <= META_STATE_IDLE;
      pkt_len <= 0;
   end
   else begin
      meta_state <= meta_state_nxt;
      pkt_len <= pkt_len_nxt;
   end
end



localparam STATE_IDLE = 0;
localparam STATE_L1 = 1;
localparam STATE_L2 = 2;
localparam STATE_L3 = 3;
localparam STATE_L4 = 4;

reg [2:0] state, state_nxt;
reg [63:0] tdata_reg_1, tdata_reg_1_nxt;
reg [63:0] tdata_reg_2, tdata_reg_2_nxt;
reg [63:0] tdata_reg_3, tdata_reg_3_nxt;

reg [127:0] tuser_reg, tuser_reg_nxt;

reg [7:0] tstrb_reg_1, tstrb_reg_1_nxt;
reg [7:0] tstrb_reg_2, tstrb_reg_2_nxt;
reg [7:0] tstrb_reg_3, tstrb_reg_3_nxt;

always @(*) begin
   state_nxt = state;

   m_axis_tdata = 0;
   m_axis_tuser = 0;
   m_axis_tstrb = 0;
   m_axis_tlast = 0;
   m_axis_tvalid = 0;

   in_fifo_rd_en = 0;
   tuser_fifo_rd_en = 0;

   tdata_reg_1_nxt = tdata_reg_1;
   tdata_reg_2_nxt = tdata_reg_2;
   tdata_reg_3_nxt = tdata_reg_3;
   tuser_reg_nxt = tuser_reg;
   tstrb_reg_1_nxt = tstrb_reg_1;
   tstrb_reg_2_nxt = tstrb_reg_2;
   tstrb_reg_3_nxt = tstrb_reg_3;

   case(state)
      STATE_IDLE: begin
         if(!in_fifo_empty && !tuser_fifo_empty) begin
            if(!tlast_fifo) begin
               tuser_reg_nxt = tuser_fifo_dout;
               tdata_reg_1_nxt = tdata_fifo;
               tstrb_reg_1_nxt = tstrb_fifo;
               in_fifo_rd_en = 1;
               tuser_fifo_rd_en = 1;
               state_nxt = STATE_L2;
            end
            else begin
               m_axis_tdata = {64'b0, 64'b0, 64'b0, tdata_fifo};
               m_axis_tstrb = {8'b0, 8'b0, 8'b0, tstrb_fifo};
               m_axis_tuser = tuser_fifo_dout;
               m_axis_tlast = 1;
               m_axis_tvalid = 1;
               if(m_axis_tready) begin
                  in_fifo_rd_en = 1;
                  tuser_fifo_rd_en = 1;
               end
            end
         end
      end

      STATE_L1: begin
         if(!in_fifo_empty) begin
            if(!tlast_fifo) begin
               tdata_reg_1_nxt = tdata_fifo;
               tstrb_reg_1_nxt = tstrb_fifo;
               in_fifo_rd_en = 1;
               state_nxt = STATE_L2;
            end
            else begin
               m_axis_tdata = {64'b0, 64'b0, 64'b0, tdata_fifo};
               m_axis_tstrb = {8'b0, 8'b0, 8'b0, tstrb_fifo};
               m_axis_tuser = tuser_reg;
               m_axis_tlast = 1;
               m_axis_tvalid = 1;
               if(m_axis_tready) begin
                  in_fifo_rd_en = 1;
                  state_nxt = STATE_IDLE;
               end
            end
         end
      end

      STATE_L2: begin
         if(!in_fifo_empty) begin
            if(!tlast_fifo) begin
               tdata_reg_2_nxt = tdata_fifo;
               tstrb_reg_2_nxt = tstrb_fifo;
               in_fifo_rd_en = 1;
               state_nxt = STATE_L3;
            end
            else begin
               m_axis_tdata = {64'b0, 64'b0, tdata_fifo, tdata_reg_1};
               m_axis_tstrb = {8'b0, 8'b0, tstrb_fifo, tstrb_reg_1};
               m_axis_tuser = tuser_reg;
               m_axis_tlast = 1;
               m_axis_tvalid = 1;
               if(m_axis_tready) begin
                  in_fifo_rd_en = 1;
                  state_nxt = STATE_IDLE;
               end
            end
         end
      end

      STATE_L3: begin
         if(!in_fifo_empty) begin
            if(!tlast_fifo) begin
               tdata_reg_3_nxt = tdata_fifo;
               tstrb_reg_3_nxt = tstrb_fifo;
               in_fifo_rd_en = 1;
               state_nxt = STATE_L4;
            end
            else begin
               m_axis_tdata = {64'b0, tdata_fifo, tdata_reg_2, tdata_reg_1};
               m_axis_tstrb = {8'b0, tstrb_fifo, tstrb_reg_2, tstrb_reg_1};
               m_axis_tuser = tuser_reg;
               m_axis_tlast = 1;
               m_axis_tvalid = 1;
               if(m_axis_tready) begin
                  in_fifo_rd_en = 1;
                  state_nxt = STATE_IDLE;
               end
            end
         end
      end

      STATE_L4: begin
         if(!in_fifo_empty) begin
            m_axis_tdata = {tdata_fifo, tdata_reg_3, tdata_reg_2, tdata_reg_1};
            m_axis_tstrb = {tstrb_fifo, tstrb_reg_3, tstrb_reg_2, tstrb_reg_1};
            m_axis_tuser = tuser_reg;
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
      end

   endcase
end

always @(posedge axi_aclk) begin
   if(~axi_resetn) begin
      state <= STATE_IDLE;
      tdata_reg_1 <= 0;
      tdata_reg_2 <= 0;
      tdata_reg_3 <= 0;
      tuser_reg <= 0;
      tstrb_reg_1 <= 0;
      tstrb_reg_2 <= 0;
      tstrb_reg_3 <= 0;
   end
   else begin
      state <= state_nxt;
      tdata_reg_1 <= tdata_reg_1_nxt;
      tdata_reg_2 <= tdata_reg_2_nxt;
      tdata_reg_3 <= tdata_reg_3_nxt;
      tuser_reg <= tuser_reg_nxt;
      tstrb_reg_1 <= tstrb_reg_1_nxt;
      tstrb_reg_2 <= tstrb_reg_2_nxt;
      tstrb_reg_3 <= tstrb_reg_3_nxt;
   end
end


endmodule
