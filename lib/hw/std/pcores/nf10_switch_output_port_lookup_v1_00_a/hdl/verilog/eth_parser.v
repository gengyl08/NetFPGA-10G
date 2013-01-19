/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        eth_parser.v
 *
 *  Library:
 *        /hw/contrib/pcores/nf10_switch_output_port_lookup_v1_10_a
 *
 *  Module:
 *        eth_parser
 *
 *  Author:
 *        Gianni Antichi, Muhammad Shahbaz
 *
 *  Description:
 *        parsing of the L2 header
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

  module eth_parser
    #(parameter C_S_AXIS_DATA_WIDTH  = 256,
      parameter C_S_AXIS_TUSER_WIDTH = 128,
      parameter SRC_PORT_POS         = 16,
      parameter NUM_QUEUES           = 8
    )
    (
      // --- Interface to the previous stage
      input  [C_S_AXIS_DATA_WIDTH-1:0]   tdata,
      input  [C_S_AXIS_TUSER_WIDTH-1:0]  tuser,
      input                              valid,
      input 				             tlast,

      // --- Interface to output_port_lookup
      output reg [47:0]                  dst_mac,
      output reg [47:0]                  src_mac,
      output reg                         eth_done,
      output reg [NUM_QUEUES-1:0]        src_port,
  
      // --- Misc
      input                              reset,
      input                              clk
    );
    
 // ------------ Internal Params --------

   localparam NUM_STATES         = 2;
   localparam READ_MAC_ADDRESSES = 1;
   localparam WAIT_EOP           = 2;

   // ------------- Regs/ wires -----------

   reg [47:0]                  dst_mac_w;
   reg [47:0]                  src_mac_w;
   reg                         eth_done_w;
   reg [NUM_QUEUES-1:0]        src_port_w;
   
   reg [NUM_STATES-1:0]        state, state_next;

   // ------------ Logic ----------------

   always @(*) begin
      src_mac_w      = 0;
      dst_mac_w      = 0;
      eth_done_w     = 0;
      src_port_w     = 0;
      state_next     = state;
      
	  case(state)
        /* read the input source header and get the first word */
        READ_MAC_ADDRESSES: begin
           if(valid) begin
              src_port_w   = tuser[SRC_PORT_POS+7:SRC_PORT_POS];
              dst_mac_w    = tdata[47:0];
              src_mac_w    = tdata[95:48];
	          eth_done_w   = 1;
              state_next = WAIT_EOP;
           end
        end // case: READ_WORD_1

        WAIT_EOP: begin
           if(valid && tlast)
              state_next = READ_MAC_ADDRESSES;
           end
      endcase // case(state)
   end // always @ (*)

   always @(posedge clk) begin
      if(reset) begin
	     src_port <= {NUM_QUEUES{1'b0}};
		 dst_mac  <= 48'b0;
		 src_mac  <= 48'b0;
		 eth_done <= 0;
		 
         state  <= READ_MAC_ADDRESSES;
      end
      else begin
	     src_port <= src_port_w;
		 dst_mac  <= dst_mac_w;
		 src_mac  <= src_mac_w;
		 eth_done <= eth_done_w;
		 
         state  <= state_next;
      end // else: !if(reset)
   end // always @ (posedge clk)

endmodule // ethernet_parser

