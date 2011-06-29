////////////////////////////////////////////////////////////////////////
//
//  NetFPGA-10G http://www.netfpga.org
//
//  Module:
//          tx_queue
//
//  Description:
//          AXI-MAC converter: TX side
//                 
//  Revision history:
//          2010/11/28 hyzeng: Initial check-in
//
////////////////////////////////////////////////////////////////////////

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
   wire tx_data_valid_fifo;
   reg  info_fifo_wr_en;
   
   reg  [2:0] state, state_next;
   reg  tlast_delay, eop_axi_delay;
   
   assign tready = ~fifo_almost_full;
   assign eop_axi = tvalid & tlast;
   
   
   // Instantiate clock domain crossing FIFO
   FIFO18 #(
   	.SIM_MODE("FAST"),
   	.ALMOST_FULL_OFFSET(9'h080),
   	.ALMOST_EMPTY_OFFSET(9'h080),
   	.DO_REG(1),
   	.EN_SYN("FALSE"),
   	.FIRST_WORD_FALL_THROUGH("TRUE"),
   	.DATA_WIDTH(18)
   	) tx_fifo (
		.ALMOSTEMPTY(),
		.ALMOSTFULL(fifo_almost_full),
		.DO({eop_mac, tx_data_valid_fifo, tx_data}),
		.DOP(),
		.EMPTY(fifo_empty),
		.FULL(),
		.RDCOUNT(),
		.RDERR(),
		.WRCOUNT(),
		.WRERR(),
		.DI({eop_axi, tvalid, tdata}),
		.DIP(2'b0),
		.RDCLK(clk125),
		.RDEN(fifo_rd_en),
		.RST(reset),
		.WRCLK(clk),
		.WREN((tvalid) & tready)
   	);

   	small_async_fifo 
   	#(
   	  .DSIZE (1),
      .ASIZE (9)
	) tx_info_fifo
        (
         .wdata(1'b0),
         .winc(eop_axi),
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
         tx_data_valid = tx_data_valid_fifo;
         
         case(state)
             IDLE: begin
                 tx_data_valid = 1'b0;
                 if(~info_fifo_empty) begin
                     info_fifo_rd_en = 1'b1;
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
                     state_next = IFG;
                 end
             end
             
             IFG: begin
                 tx_data_valid = 1'b0;
                 state_next = IDLE;
             end
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
         tlast_delay <= tlast;
         eop_axi_delay <= eop_axi;
         info_fifo_wr_en <= eop_axi & ~eop_axi_delay; // Only 1 cycle
     end
endmodule
