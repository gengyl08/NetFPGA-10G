/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        pkt_preprocessor.v
 *
 *  Module:
 *        openflow_datapath
 *
 *  Author:
 *        Tatsuya Yabe
 *
 *  Description:
 *        It parses packet headers, creates matching entries
 *        and sends it to a flow_table module as queries
 *        This module is a wrapper of all the OpenFlow specific
 *        modules
 *
 *  Copyright notice:
 *        Copyright (C) 2010, 2011, 2012 The Board of Trustees of The Leland
 *                                 Stanford Junior University
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
`include "registers.v"

module pkt_preprocessor
#(
   // AXI Stream Data Width
   parameter C_AXIS_DATA_WIDTH=64,
   parameter C_AXIS_TUSER_WIDTH=128,
   parameter C_AXIS_LEN_DATA_WIDTH=16,
   parameter C_AXIS_SPT_DATA_WIDTH=8,
   parameter C_AXIS_DPT_DATA_WIDTH=8,
   // Parameters for Flow Table interface
   parameter OPENFLOW_MATCH_SIZE=256,
   parameter MPLS_ENABLE=0, //1:ENABLED 0:DISABLED(OF1.0)
   // Register size
   parameter DATA_WIDTH=32
)
(
   // Global Ports
   input asclk,
   input aresetn,

   // Slave AXI Stream Ports
   input [C_AXIS_DATA_WIDTH-1:0] s_axis_tdata,
   input [(C_AXIS_DATA_WIDTH/8)-1:0] s_axis_tstrb,
   input [C_AXIS_TUSER_WIDTH-1:0] s_axis_tuser,
   input  s_axis_tvalid,
   input  s_axis_tlast,
   output s_axis_tready,

   // Flow table inquiry
   output lu_req,
   output [OPENFLOW_MATCH_SIZE-1:0] lu_entry,
   output [C_AXIS_LEN_DATA_WIDTH-1:0] lu_len,
   input lu_ack,

   // Master AXI Stream Ports
   output [C_AXIS_DATA_WIDTH-1:0] m_axis_tdata,
   output [(C_AXIS_DATA_WIDTH/8)-1:0] m_axis_tstrb,
   output [C_AXIS_TUSER_WIDTH-1:0] m_axis_tuser,
   output m_axis_tvalid,
   output m_axis_tlast,
   input  m_axis_tready,

   // Interface with host_inf
   output [DATA_WIDTH-1:0] dl_parse_cnt,
   output [DATA_WIDTH-1:0] mpls_parse_cnt,
   output [DATA_WIDTH-1:0] arp_parse_cnt,
   output [DATA_WIDTH-1:0] ip_tp_parse_cnt,

   //TODO To process below in this module
   output pkt_buf_drop
);

   //-------------------- Internal Parameters ------------------------

   localparam FIFO_CTRL_WIDTH = 2;
   localparam FIFO_DATA_WIDTH = C_AXIS_DATA_WIDTH +
                                C_AXIS_DATA_WIDTH/8 +
                                FIFO_CTRL_WIDTH;

   localparam TUSER_LEN_POS = 0;
   localparam TUSER_SPT_POS = TUSER_LEN_POS
                            + C_AXIS_LEN_DATA_WIDTH;

   localparam NUM_TU_STATES = 2;
   localparam TU_WAIT_TVALID = 1,
              TU_WAIT_TLAST = 2;

   //------------------------ Wires/Regs -----------------------------

   // Pkt buffer
   wire m_axis_tvalid_dummy;
   wire pkt_buf_empty;

   // Input fifo and header parser/pkt_buf
   wire fifo_nearly_full;

   wire tx_valid;
   wire tx_last;
   wire [C_AXIS_DATA_WIDTH-1:0] tx_data;
   wire [(C_AXIS_DATA_WIDTH/8)-1:0] tx_strb;
   wire fifo_empty;
   wire fifo_rd_en;

   // header parser and lu_entry_composer/pkt_buf
   wire dl_start;

   wire dl_done;
   wire [15:0] pkt_len;
   wire [7:0] src_port;
   wire [47:0] dl_dst;
   wire [47:0] dl_src;
   wire [15:0] dl_ethtype;
   wire [15:0] dl_vlantag;

   wire mpls_done;
   wire [19:0] mplslabel;
   wire [2:0] mplstc;

   wire arp_done;
   wire [7:0] arp_op;
   wire [31:0] arp_ip_src;
   wire [31:0] arp_ip_dst;

   wire ip_tp_done;
   wire [5:0] ip_tos;
   wire [7:0] ip_proto;
   wire [31:0] ip_src;
   wire [31:0] ip_dst;
   wire [15:0] tp_src;
   wire [15:0] tp_dst;

   wire compose_done;

   // Metadata handling
   reg [NUM_TU_STATES-1:0] s_tuser_state, s_tuser_state_nxt;
   reg s_tuser_valid, s_tuser_valid_nxt;
   wire s_tuser_wr_en;
   wire [C_AXIS_TUSER_WIDTH-1:0] tx_user;
   wire tx_user_rd_en;
   wire [C_AXIS_LEN_DATA_WIDTH-1:0] tx_len;
   wire [C_AXIS_SPT_DATA_WIDTH-1:0] tx_spt;

   wire m_axis_tlast_int;
   wire m_tuser_rd_en;

   //--------------------------- Logic -------------------------------

   //--- Input Pkt/Tuser fifo

   always @(*) begin
      s_tuser_valid_nxt = s_tuser_valid;
      s_tuser_state_nxt = s_tuser_state;
      case (s_tuser_state)
         TU_WAIT_TVALID: begin
            if (s_axis_tvalid) begin
               s_tuser_valid_nxt = 0;
               s_tuser_state_nxt = TU_WAIT_TLAST;
            end
         end
         TU_WAIT_TLAST: begin
            if (s_axis_tlast) begin
               s_tuser_valid_nxt = 1;
               s_tuser_state_nxt = TU_WAIT_TVALID;
            end
         end
      endcase
   end

   always @(posedge asclk) begin
      if (~aresetn) begin
         s_tuser_valid <= 1;
         s_tuser_state <= TU_WAIT_TVALID;
      end
      else begin
         s_tuser_valid <= s_tuser_valid_nxt;
         s_tuser_state <= s_tuser_state_nxt;
      end
   end

   assign s_tuser_wr_en = s_axis_tvalid && s_tuser_valid;

   fallthrough_small_fifo
     #(.WIDTH(C_AXIS_TUSER_WIDTH), .MAX_DEPTH_BITS(3))
     input_metadata_buf
       (.din           (s_axis_tuser),
        .wr_en         (s_tuser_wr_en),
        .rd_en         (tx_user_rd_en),
        .dout          (tx_user),
        .full          (),
        .prog_full     (),
        .nearly_full   (tx_user_nearly_full),
        .empty         (tx_user_empty),
        .reset         (~aresetn),
        .clk           (asclk)
        );

   assign tx_len = tx_user[TUSER_LEN_POS +: C_AXIS_LEN_DATA_WIDTH];
   assign tx_spt = tx_user[TUSER_SPT_POS +: C_AXIS_SPT_DATA_WIDTH];

   fallthrough_small_fifo
     #(.WIDTH(FIFO_DATA_WIDTH), .MAX_DEPTH_BITS(3))
     input_fifo
       (.din           ({s_axis_tvalid, // Should always be 1
                         s_axis_tlast,
                         s_axis_tstrb,
                         s_axis_tdata}),  // Data in
        .wr_en         (s_axis_tvalid && s_axis_tready),   // Write enable
        .rd_en         (fifo_rd_en),      // Read the next word
        .dout          ({tx_valid, // Should always be 1
                         tx_last,
                         tx_strb,
                         tx_data}),
        .full          (),
        .prog_full     (),
        .nearly_full   (fifo_nearly_full),
        .empty         (fifo_empty),
        .reset         (~aresetn),
        .clk           (asclk)
        );

   assign s_axis_tready = ~fifo_nearly_full;

   //--- Output Pkt/Tuser buffers

   // Store upto 128bytes
   fallthrough_small_fifo
     #(.WIDTH(FIFO_DATA_WIDTH), .MAX_DEPTH_BITS(4))
     output_pkt_buf
       (.din           ({tx_valid, // Should always be 1
                         tx_last,
                         tx_strb,
                         tx_data}),  // Data in
        .wr_en         (fifo_rd_en),   // Write enable
        .rd_en         ((m_axis_tready && m_axis_tvalid)),
        .dout          ({m_axis_tvalid_dummy, // Should always be 1
                         m_axis_tlast_int,
                         m_axis_tstrb,
                         m_axis_tdata}),
        .full          (pkt_buf_drop),
        .prog_full     (),
        .nearly_full   (),
        .empty         (pkt_buf_empty),
        .reset         (~aresetn),
        .clk           (asclk)
        );

   assign m_axis_tvalid = ~pkt_buf_empty;
   assign m_axis_tlast = m_axis_tlast_int && ~pkt_buf_empty;

   assign m_tuser_rd_en = m_axis_tready && m_axis_tlast_int && ~pkt_buf_empty;

   fallthrough_small_fifo
     #(.WIDTH(C_AXIS_TUSER_WIDTH), .MAX_DEPTH_BITS(4))
     output_metadata_fifo
       (.din           (tx_user),
        .wr_en         (tx_user_rd_en),
        .rd_en         (m_tuser_rd_en),
        .dout          (m_axis_tuser),
        .full          (),
        .prog_full     (),
        .nearly_full   (),
        .empty         (),
        .reset         (~aresetn),
        .clk           (asclk)
        );

   //--- header parser
   header_parser
     #(.C_AXIS_DATA_WIDTH(C_AXIS_DATA_WIDTH),
       .C_AXIS_LEN_DATA_WIDTH(C_AXIS_LEN_DATA_WIDTH),
       .C_AXIS_SPT_DATA_WIDTH(C_AXIS_SPT_DATA_WIDTH))
     header_parser
       (.tx_data (tx_data),
        .tx_strb (tx_strb),
        .tx_valid (tx_valid),
        .tx_last (tx_last),
        .tx_len_data (tx_len),
        .tx_spt_data (tx_spt),
        .fifo_empty (fifo_empty),
        .fifo_rd_en (fifo_rd_en),
        .tx_user_rd_en (tx_user_rd_en),

        .dl_start (dl_start),
        .dl_done (dl_done),
        .pkt_len (pkt_len),
        .src_port (src_port),
        .dl_dst (dl_dst),
        .dl_src (dl_src),
        .dl_ethtype (dl_ethtype),
        .dl_vlantag (dl_vlantag),
        .mpls_done (mpls_done),
        .mplslabel (mplslabel),
        .mplstc (mplstc),
        .arp_done (arp_done),
        .arp_op (arp_op),
        .arp_ip_src (arp_ip_src),
        .arp_ip_dst (arp_ip_dst),
        .ip_tp_done (ip_tp_done),
        .ip_tos (ip_tos),
        .ip_proto (ip_proto),
        .ip_src (ip_src),
        .ip_dst (ip_dst),
        .tp_src (tp_src),
        .tp_dst (tp_dst),
        .compose_done (compose_done),

        .dl_parse_cnt (dl_parse_cnt),
        .mpls_parse_cnt (mpls_parse_cnt),
        .arp_parse_cnt (arp_parse_cnt),
        .ip_tp_parse_cnt (ip_tp_parse_cnt),

        .aresetn (aresetn),
        .asclk (asclk)
        );

   //--- lu_entry_composer
   lu_entry_composer
     #(.OPENFLOW_MATCH_SIZE(OPENFLOW_MATCH_SIZE),
       .C_AXIS_LEN_DATA_WIDTH(C_AXIS_LEN_DATA_WIDTH),
       .C_AXIS_SPT_DATA_WIDTH(C_AXIS_SPT_DATA_WIDTH),
       .MPLS_ENABLE(MPLS_ENABLE))
     lu_entry_composer
       (.dl_start (dl_start),
        .dl_done (dl_done),
        .pkt_len (pkt_len),
        .src_port (src_port),
        .dl_dst (dl_dst),
        .dl_src (dl_src),
        .dl_ethtype (dl_ethtype),
        .dl_vlantag (dl_vlantag),
        .mpls_done (mpls_done),
        .mplslabel (mplslabel),
        .mplstc (mplstc),
        .arp_done (arp_done),
        .arp_op (arp_op),
        .arp_ip_src (arp_ip_src),
        .arp_ip_dst (arp_ip_dst),
        .ip_tp_done (ip_tp_done),
        .ip_tos (ip_tos),
        .ip_proto (ip_proto),
        .ip_src (ip_src),
        .ip_dst (ip_dst),
        .tp_src (tp_src),
        .tp_dst (tp_dst),
        .compose_done (compose_done),
        .lu_req (lu_req),
        .lu_entry (lu_entry),
        .lu_len (lu_len),
        .lu_ack (lu_ack),
        .aresetn (aresetn),
        .asclk (asclk)
        );
endmodule
