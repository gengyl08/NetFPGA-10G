/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        tx_queue.v
 *
 *  Library:
 *        hw/std/pcores/nf10_1g_interface_v1_10_a
 *
 *  Module:
 *        tx_queue
 *
 *  Author:
 *        Adam Covington
 *
 *  Description:
 *        AXI-MAC converter: TX side
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

module tx_queue
#(
   parameter AXI_DATA_WIDTH = 8 //Only 8 is supported right now in 1G mode.
)
(
   // AXI side
   input [AXI_DATA_WIDTH-1:0]  tdata,
   input [AXI_DATA_WIDTH/8-1:0]  tstrb,
   input tvalid,
   input tlast,
   output tready,

   input clk,
   input reset,

   // MAC side
   output [7:0] tx_data,
   output reg tx_data_valid,
   input  tx_ack,
   input  clk125
);

   localparam IDLE = 0;
   localparam WAIT_FOR_ACK = 1;
   localparam SEND_PKT = 2;
   localparam IFG = 3;

   wire       eop_axi;
   wire       eop_mac;

   wire fifo_almost_full;
   wire fifo_empty, info_fifo_empty;
   reg  fifo_rd_en, info_fifo_rd_en;
   reg  info_fifo_wr_en;

   reg  [2:0] state, state_next;

   assign tready = ~fifo_almost_full;
   assign eop_axi = tlast;


   // Instantiate clock domain crossing FIFO
   FIFO36 #(
   	.SIM_MODE("FAST"),
   	.ALMOST_FULL_OFFSET(12'hA),
   	.ALMOST_EMPTY_OFFSET(12'hA),
   	.DO_REG(1),
   	.EN_SYN("FALSE"),
   	.FIRST_WORD_FALL_THROUGH("TRUE"),
   	.DATA_WIDTH(18)
   	) tx_fifo (
		.ALMOSTEMPTY(),
		.ALMOSTFULL(fifo_almost_full),
		.DO({eop_mac, tx_data}),
		.DOP(),
		.EMPTY(fifo_empty),
		.FULL(),
		.RDCOUNT(),
		.RDERR(),
		.WRCOUNT(),
		.WRERR(),
		.DI({eop_axi, tdata}),
		.DIP(2'b0),
		.RDCLK(clk125),
		.RDEN(fifo_rd_en),
		.RST(reset),
		.WRCLK(clk),
		.WREN(tvalid & tready)
   	);

   	small_async_fifo
   	#(
   	  .DSIZE (1),
      .ASIZE (9)
	) tx_info_fifo
        (
         .wdata(1'b0),
         .winc(info_fifo_wr_en),
         .wclk(clk),

         .rdata(),
         .rinc(info_fifo_rd_en),
         .rclk(clk125),

         .rempty(info_fifo_empty),
         .r_almost_empty(),
         .wfull(),
         .w_almost_full(),
	     .rrst_n(~reset),
         .wrst_n(~reset)
         );


     always @* begin
         state_next = state;
         fifo_rd_en = 1'b0;
         info_fifo_rd_en = 1'b0;
         tx_data_valid = 1'b0;

         case(state)
             IDLE: begin
                 tx_data_valid = 1'b0;
                 if(~info_fifo_empty) begin
                     info_fifo_rd_en = 1'b1;
                     state_next = WAIT_FOR_ACK;
                 end
             end

             WAIT_FOR_ACK: begin
                 tx_data_valid = 1'b1;
                 if(tx_ack) begin
                     fifo_rd_en = 1'b1;
                     state_next = SEND_PKT;
                 end
             end

             SEND_PKT: begin
                 fifo_rd_en = 1'b1;
                 tx_data_valid = 1'b1;
                 if(eop_mac) begin
                     state_next = IDLE;
                 end
             end

             /*IFG: begin
                 tx_data_valid = 1'b0;
                 state_next = IDLE;
             end*/
         endcase
     end

     always @(posedge clk125 or posedge reset) begin
         if(reset) begin
             state <= IDLE;
         end
         else begin
             state <= state_next;
         end
     end

     always @(posedge clk) begin
         info_fifo_wr_en <= tlast & tready & tvalid; // Only 1 cycle
     end
endmodule
