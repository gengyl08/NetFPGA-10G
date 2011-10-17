/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        tx_queue.v
 *
 *  Library:
 *        hw/std/pcores/nf10_10g_interface_v1_10_a
 *
 *  Module:
 *        tx_queue
 *
 *  Author:
 *        James Hongyi Zeng
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
   parameter AXI_DATA_WIDTH = 64 //Only 64 is supported right now.
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
   output [63:0] tx_data,
   output reg [ 7:0] tx_data_valid,
   output reg tx_start,
   input  tx_ack,
   input  clk156
);

   localparam IDLE = 0;
   localparam WAIT_FOR_ACK = 1;
   localparam SEND_PKT = 2;
   localparam IFG  = 3;

   wire [3:0] tx_data_valid_encoded;
   reg  [7:0] tx_data_valid_decoded;
   reg  [3:0] tstrb_encoded;
   wire       eop_axi;
   wire       eop_mac;

   wire fifo_almost_full;
   wire fifo_empty, info_fifo_empty;
   reg  fifo_rd_en, info_fifo_rd_en;
   reg  info_fifo_wr_en;

   reg  [2:0] state, state_next;
   reg  eop_axi_delay, tlast_delay;

   assign tready = ~fifo_almost_full;
   assign eop_axi = tlast;

   // Instantiate clock domain crossing FIFO
   FIFO36_72 #(
   	.SIM_MODE("FAST"),
   	.ALMOST_FULL_OFFSET(9'hA),
   	.ALMOST_EMPTY_OFFSET(9'hA),
   	.DO_REG(1),
   	.EN_ECC_READ("FALSE"),
   	.EN_ECC_WRITE("FALSE"),
   	.EN_SYN("FALSE"),
   	.FIRST_WORD_FALL_THROUGH("TRUE")
   	) tx_fifo (
		.ALMOSTEMPTY(),
		.ALMOSTFULL(fifo_almost_full),
		.DBITERR(),
		.DO(tx_data),
		.DOP({eop_mac, tx_data_valid_encoded}),
		.ECCPARITY(),
		.EMPTY(fifo_empty),
		.FULL(),
		.RDCOUNT(),
		.RDERR(),
		.SBITERR(),
		.WRCOUNT(),
		.WRERR(),
		.DI(tdata),
		.DIP({eop_axi , tstrb_encoded}),
		.RDCLK(clk156),
		.RDEN(fifo_rd_en),
		.RST(reset),
		.WRCLK(clk),
		.WREN(tvalid & tready)
   	);

   	small_async_fifo
   	#(
   	  .DSIZE (1),
      .ASIZE (9),
      .ALMOST_FULL_SIZE(500)
	) tx_info_fifo
        (
         .wdata(1'b0),
         .winc(info_fifo_wr_en), //Only 1 cycle per packet!
         .wclk(clk),

         .rdata(),
         .rinc(info_fifo_rd_en),
         .rclk(clk156),

         .rempty(info_fifo_empty),
         .r_almost_empty(),
         .wfull(),
         .w_almost_full(),
	     .rrst_n(~reset),
         .wrst_n(~reset)
         );

     // Encoder to map 8bit strobe to 4 bit
     always @* begin
         case (tx_data_valid_encoded)
             4'h0: tx_data_valid_decoded = 8'h1;
             4'h1: tx_data_valid_decoded = 8'h3;
             4'h2: tx_data_valid_decoded = 8'h7;
             4'h3: tx_data_valid_decoded = 8'hF;
             4'h4: tx_data_valid_decoded = 8'h1F;
             4'h5: tx_data_valid_decoded = 8'h3F;
             4'h6: tx_data_valid_decoded = 8'h7F;
             4'h7: tx_data_valid_decoded = 8'hFF;
             default: tx_data_valid_decoded = 8'h0;
         endcase

         case (tstrb)
             8'h1: tstrb_encoded = 4'h0;
             8'h3: tstrb_encoded = 4'h1;
             8'h7: tstrb_encoded = 4'h2;
             8'hF: tstrb_encoded = 4'h3;
             8'h1F: tstrb_encoded = 4'h4;
             8'h3F: tstrb_encoded = 4'h5;
             8'h7F: tstrb_encoded = 4'h6;
             8'hFF: tstrb_encoded = 4'h7;
             default: tstrb_encoded = 4'h8;
         endcase
     end

     always @* begin
         state_next = state;
         fifo_rd_en = 1'b0;
         info_fifo_rd_en = 1'b0;
         tx_start   = 1'b0;
         tx_data_valid = tx_data_valid_decoded;

         case(state)
             IDLE: begin
                 tx_data_valid = 8'b0;
                 if(~info_fifo_empty) begin
                     info_fifo_rd_en = 1'b1;
                     tx_start = 1'b1;
                     state_next = WAIT_FOR_ACK;
                 end
             end

             WAIT_FOR_ACK: begin
                 if(tx_ack) begin
                     fifo_rd_en = 1'b1;
                     state_next = SEND_PKT;
                 end
             end

             SEND_PKT: begin
                 fifo_rd_en = 1'b1;
                 if(eop_mac) begin
                     state_next = IDLE;
                 end
             end

             IFG: begin
                 state_next = IDLE;
                 tx_data_valid = 8'b0;
             end
         endcase
     end

     always @(posedge clk156) begin
         if(reset) begin
             state <= IDLE;
         end
         else begin
             state <= state_next;
         end
     end

     always @(posedge clk) begin
         info_fifo_wr_en <= tlast & tvalid & tready;
     end
endmodule
