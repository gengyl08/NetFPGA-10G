/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        output_port_lookup.v
 *
 *  Library:
 *        hw/std/pcores/nf10_switch_output_port_lookup_v1_10_a
 *
 *  Module:
 *        output_port_lookup
 *
 *  Author:
 *        Gianni Antichi
 *
 *  Description:
 *        Hardwire the hardware interfaces to CPU and vice versa
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

module output_port_lookup
#(
    //Master AXI Stream Data Width
    parameter C_M_AXIS_DATA_WIDTH=256,
    parameter C_S_AXIS_DATA_WIDTH=256,
    parameter C_M_AXIS_TUSER_WIDTH=128,
    parameter C_S_AXIS_TUSER_WIDTH=128,
    parameter SRC_PORT_POS=16,
    parameter DST_PORT_POS=24,
    parameter NUM_OUTPUT_QUEUES=8
)
(
    // Global Ports
    input axi_aclk,
    input axi_resetn,

    // Master Stream Ports (interface to data path)
    output [C_M_AXIS_DATA_WIDTH - 1:0] m_axis_tdata,
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
    input  s_axis_tlast,

    output  lut_hit,
    output  lut_miss

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

   //--------------------- Internal Parameter-------------------------
   localparam LUT_DEPTH_BITS = 4;
   localparam DEFAULT_MISS_OUTPUT_PORTS = 8'h55; // exclude the CPU queues

   localparam NUM_STATES            = 2;
   localparam WAIT_TILL_DONE_DECODE = 1;
   localparam IN_PACKET		    = 2;

   //---------------------- Wires and regs----------------------------

   wire [47:0]			dst_mac;
   wire [47:0]                  src_mac;
   wire [NUM_OUTPUT_QUEUES-1:0] src_port;
   wire                         eth_done;

   wire [NUM_OUTPUT_QUEUES-1:0] dst_ports;
   wire [NUM_OUTPUT_QUEUES-1:0] dst_ports_latched;

   wire                         lookup_done;
   reg				send_packet;
   wire                         in_fifo_rd_en;

   wire [C_S_AXIS_TUSER_WIDTH-1:0] tuser_fifo;

   wire                         in_fifo_nearly_full;
   wire                         in_fifo_empty;

   reg                          dst_port_rd;
   wire                         dst_port_fifo_nearly_full;
   wire                         dst_port_fifo_empty;

   reg [NUM_STATES-1:0]         state, state_next;


   //------------------------- Modules-------------------------------
   ethernet_parser
     #(.C_S_AXIS_DATA_WIDTH (C_S_AXIS_DATA_WIDTH),
       .C_S_AXIS_TUSER_WIDTH (C_S_AXIS_TUSER_WIDTH))
     eth_parser
         (.tdata(s_axis_tdata),
          .tuser(s_axis_tuser),
          .valid(s_axis_tvalid & ~in_fifo_nearly_full),
	  .tlast(s_axis_tlast),
          .dst_mac (dst_mac),
          .src_mac(src_mac),
          .eth_done (eth_done),
          .src_port(src_port),
          .reset(~axi_resetn),
          .clk(axi_aclk));

   mac_cam_lut
     #(.NUM_OUTPUT_QUEUES(NUM_OUTPUT_QUEUES),
       .LUT_DEPTH_BITS(LUT_DEPTH_BITS),
       .DEFAULT_MISS_OUTPUT_PORTS(DEFAULT_MISS_OUTPUT_PORTS))
   mac_cam_lut
     // --- lookup and learn port
     (.dst_mac (dst_mac),
      .src_mac (src_mac),
      .src_port (src_port),
      .lookup_req (eth_done),
      .dst_ports (dst_ports),
      
      .lookup_done (lookup_done),         // pulses high on lookup done
      .lut_hit(lut_hit),
      .lut_miss(lut_miss),

      // --- Misc
      .clk (axi_aclk),
      .reset (~axi_resetn));

   /* The size of this fifo has to be large enough to fit the previous modules' headers
    * and the ethernet header */
   fallthrough_small_fifo #(.WIDTH(C_M_AXIS_DATA_WIDTH+C_M_AXIS_TUSER_WIDTH+C_M_AXIS_DATA_WIDTH/8+1), .MAX_DEPTH_BITS(4))
      input_fifo
        (.din ({s_axis_tlast, s_axis_tuser, s_axis_tstrb, s_axis_tdata}),     // Data in
         .wr_en (s_axis_tvalid & ~in_fifo_nearly_full),               // Write enable
         .rd_en (in_fifo_rd_en),       // Read the next word
         .dout ({m_axis_tlast, tuser_fifo, m_axis_tstrb, m_axis_tdata}),
         .full (),
         .prog_full (),
         .nearly_full (in_fifo_nearly_full),
         .empty (in_fifo_empty),
         .reset (~axi_resetn),
         .clk (axi_aclk)
         );

   fallthrough_small_fifo #(.WIDTH(NUM_OUTPUT_QUEUES), .MAX_DEPTH_BITS(2))
      dst_port_fifo
        (.din (dst_ports),     // Data in
         .wr_en (lookup_done),             // Write enable
         .rd_en (dst_port_rd),       // Read the next word
         .dout (dst_ports_latched),
         .full (),
         .prog_full (),
         .nearly_full (dst_port_fifo_nearly_full),
         .empty (dst_port_fifo_empty),
         .reset (~axi_resetn),
         .clk (axi_aclk)
         );

   //----------------------- Logic -----------------------------

   assign s_axis_tready = !in_fifo_nearly_full;

   /*********************************************************************
    * Wait until the ethernet header has been decoded and the output
    * port is found, then write the module header and move the packet
    * to the output
    **********************************************************************/
   always @(*) begin
      m_axis_tuser = tuser_fifo;
      state_next = state;
      dst_port_rd = 0;
      send_packet = 1;

      case(state)
        WAIT_TILL_DONE_DECODE: begin
	   send_packet = 0;
           if(!dst_port_fifo_empty) begin
	    	state_next = IN_PACKET;
		send_packet = 1;
           	dst_port_rd = 1;
           	m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = dst_ports_latched;
	   end	
	end

	IN_PACKET: begin
	   if(m_axis_tlast & m_axis_tvalid & m_axis_tready)
		state_next = WAIT_TILL_DONE_DECODE;
	end
      endcase // case(state)
   end // always @ (*)

   always @(posedge axi_aclk) begin
      if(~axi_resetn) begin
         state <= WAIT_TILL_DONE_DECODE;
      end
      else begin
         state <= state_next;
      end
   end



// handle output
assign in_fifo_rd_en = m_axis_tready && !in_fifo_empty && send_packet;
assign m_axis_tvalid = !in_fifo_empty && send_packet;


endmodule // output_port_lookup

