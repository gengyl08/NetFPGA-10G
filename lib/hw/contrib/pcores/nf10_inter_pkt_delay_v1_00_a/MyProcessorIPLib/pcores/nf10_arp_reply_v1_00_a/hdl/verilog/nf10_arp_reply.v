/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        nf10_arp_reply.v
 *
 *  Library:
 *        hw/std/pcores/nf10_arp_reply_v1_00_a
 *
 *  Module:
 *        nf10_arp_reply
 *
 *  Author:
 *        Yilong Geng
 *
 *  Description:
 *        Reply to arp request if know the answer.
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

module nf10_arp_reply
#(
    //Master AXI Stream Data Width
    parameter C_M_AXIS_DATA_WIDTH=256,
    parameter C_S_AXIS_DATA_WIDTH=256,
    parameter C_M_AXIS_TUSER_WIDTH=128,
    parameter C_S_AXIS_TUSER_WIDTH=128,
    parameter SRC_PORT_POS=16,
    parameter DST_PORT_POS=24
)
(
    // Global Ports
    input axi_aclk,
    input axi_resetn,

    // Master Stream Ports (interface to data path)
    output reg [C_M_AXIS_DATA_WIDTH - 1:0] m_axis_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0] m_axis_tstrb,
    output reg [C_M_AXIS_TUSER_WIDTH-1:0] m_axis_tuser,
    output m_axis_tvalid,
    input  m_axis_tready,
    output m_axis_tlast,

    // Slave Stream Ports (interface to RX queues)
    input [C_S_AXIS_DATA_WIDTH - 1:0] s_axis_tdata,
    input [((C_S_AXIS_DATA_WIDTH / 8)) - 1:0] s_axis_tstrb,
    input [C_S_AXIS_TUSER_WIDTH-1:0] s_axis_tuser,
    input  s_axis_tvalid,
    output s_axis_tready,
    input  s_axis_tlast
);

   function integer log2;
      input integer number;
      begin
         log2=0;
         while(2**log2<number) begin
            log2=log2+1;
         end
      end
   endfunction // log2

   // ------------ Internal Params --------
   localparam MODULE_HEADER      = 0;
   localparam IN_PACKET      = 1;
   
   localparam MAC_DEST_ADD_POS = 0;
   localparam MAC_SOUR_ADD_POS = 48;
   localparam ARP_PROTO_CODE_POS = 96;
   localparam OPERATION_POS = 168;
   localparam ARP_REQUEST = 1;
   localparam ARP_REPLY = 2;
   localparam SENDER_HARD_ADD_POS = 176;
   localparam SENDER_PROTO_ADD_POS = 224;
   localparam TARGET_HARD_ADD_POS = 0;
   localparam TARGET_PROTO_ADD_POS = 48;


   //------------- Wires -----------------
   reg [C_M_AXIS_DATA_WIDTH+C_M_AXIS_TUSER_WIDTH+C_M_AXIS_DATA_WIDTH/8:0] data_reg_stage1;
   reg empty_stage1;
   reg [C_M_AXIS_DATA_WIDTH+C_M_AXIS_TUSER_WIDTH+C_M_AXIS_DATA_WIDTH/8:0] data_reg_stage2;
   reg empty_stage2;
   wire [C_M_AXIS_DATA_WIDTH+C_M_AXIS_TUSER_WIDTH+C_M_AXIS_DATA_WIDTH/8:0] fifo_data_out;
   wire in_fifo_empty;
   reg data_reg_stage1_empty;
   reg data_reg_stage2_empty;
   reg data_reg_stage2_stop;
   reg [C_M_AXIS_DATA_WIDTH+C_M_AXIS_TUSER_WIDTH+C_M_AXIS_DATA_WIDTH/8:0] data_reg_stage2_input;
   wire [47:0] target_mac;
   wire  [C_M_AXIS_TUSER_WIDTH-1:0] tuser_reg;
   wire  [C_M_AXIS_DATA_WIDTH-1:0] tdata_reg;
   wire  [C_M_AXIS_TUSER_WIDTH-1:0] tuser_reg_next;
   wire  [C_M_AXIS_DATA_WIDTH-1:0] tdata_reg_next;
   reg 			  state, state_next;

   // ------------ Modules ----------------

   fallthrough_small_fifo
        #( .WIDTH(C_M_AXIS_DATA_WIDTH+C_M_AXIS_TUSER_WIDTH+C_M_AXIS_DATA_WIDTH/8+1),
           .MAX_DEPTH_BITS(2))
      input_fifo
        (// Outputs
         .dout                           (fifo_data_out),
         .full                           (),
         .nearly_full                    (in_fifo_nearly_full),
         .prog_full                      (),
         .empty                          (in_fifo_empty),
         // Inputs
         .din                            ({s_axis_tlast, s_axis_tuser, s_axis_tstrb, s_axis_tdata}),
         .wr_en                          (s_axis_tvalid & ~in_fifo_nearly_full),
         .rd_en                          (in_fifo_rd_en),
         .reset                          (~axi_resetn),
         .clk                            (axi_aclk));

   mac_addr_lookup
      mac_lookup
         (
          .ip_addr(tdata_reg_next[TARGET_PROTO_ADD_POS+31:TARGET_PROTO_ADD_POS]),
          .mac_addr(target_mac),
          .lookup_success(lookup_success)
         );

   // ------------- Logic ----------------

   assign s_axis_tready = !in_fifo_nearly_full;
   assign in_fifo_rd_en = (((m_axis_tready || data_reg_stage2_empty) && !data_reg_stage2_stop) || data_reg_stage1_empty) && !in_fifo_empty;

   assign {m_axis_tlast, tuser_reg, m_axis_tstrb, tdata_reg} = data_reg_stage2;
   assign tdata_reg_next = data_reg_stage1[C_S_AXIS_DATA_WIDTH-1:0];
   assign tuser_reg_next = data_reg_stage1[C_M_AXIS_DATA_WIDTH+C_M_AXIS_TUSER_WIDTH+C_M_AXIS_DATA_WIDTH/8-1:C_M_AXIS_DATA_WIDTH+C_M_AXIS_DATA_WIDTH/8];

   //take care of the data registers
   always @(posedge axi_aclk) begin
      if ((m_axis_tready || data_reg_stage2_empty) && !data_reg_stage2_stop) begin
         data_reg_stage2 <= data_reg_stage2_input;
         data_reg_stage2_empty <= data_reg_stage1_empty;
      end 
      if (((m_axis_tready || data_reg_stage2_empty) && !data_reg_stage2_stop) || data_reg_stage1_empty) begin
         data_reg_stage1 <= fifo_data_out;
         data_reg_stage1_empty <= in_fifo_empty;
      end
   end /*end always*/

   // modify the dst port in tuser
   always @(*) begin
      m_axis_tuser = tuser_reg;
      m_axis_tdata = tdata_reg;
      state_next      = state;
      data_reg_stage2_stop = 0;
      data_reg_stage2_input = data_reg_stage1;

      case(state)
	MODULE_HEADER: begin
	   if (!data_reg_stage2_empty) begin
              if(tdata_reg[ARP_PROTO_CODE_POS+15:ARP_PROTO_CODE_POS]==16'h0608 && tdata_reg[OPERATION_POS+7:OPERATION_POS]==ARP_REQUEST) begin
                    if(data_reg_stage1_empty) begin
                       data_reg_stage2_stop = 1;
                    end
                    else if(lookup_success) begin

                       m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = tuser_reg[SRC_PORT_POS+7:SRC_PORT_POS];
                       m_axis_tdata[MAC_DEST_ADD_POS+47:MAC_DEST_ADD_POS] = tdata_reg[SENDER_HARD_ADD_POS+47:SENDER_HARD_ADD_POS];
                       //m_axis_tdata[MAC_SOUR_ADD_POS+47:MAC_DEST_ADD_POS] = 
                       m_axis_tdata[OPERATION_POS+7:OPERATION_POS] = ARP_REPLY;
                       m_axis_tdata[SENDER_HARD_ADD_POS+47:SENDER_HARD_ADD_POS] = target_mac;
                       m_axis_tdata[SENDER_PROTO_ADD_POS+31:SENDER_PROTO_ADD_POS] = tdata_reg_next[TARGET_PROTO_ADD_POS+31:TARGET_PROTO_ADD_POS];
                       data_reg_stage2_input[TARGET_HARD_ADD_POS+47:TARGET_HARD_ADD_POS] = tdata_reg[SENDER_HARD_ADD_POS+47:SENDER_HARD_ADD_POS];
                       data_reg_stage2_input[TARGET_PROTO_ADD_POS+31:TARGET_PROTO_ADD_POS] = tdata_reg[SENDER_PROTO_ADD_POS+31:SENDER_PROTO_ADD_POS];
                    end
              end
              if(m_axis_tready && m_axis_tvalid) begin
                 state_next = IN_PACKET;
              end
	   end
	end // case: MODULE_HEADER

	IN_PACKET: begin
	   if(m_axis_tlast & m_axis_tvalid & m_axis_tready) begin
	      state_next = MODULE_HEADER;
	   end
	end
      endcase // case (state)
   end // always @ (*)

   always @(posedge axi_aclk) begin
      if(~axi_resetn) begin
	 state <= MODULE_HEADER;
      end
      else begin
	 state <= state_next;
      end
   end

   // Handle output
   assign m_axis_tvalid = !data_reg_stage2_empty && !data_reg_stage2_stop;

endmodule // output_port_lookup
