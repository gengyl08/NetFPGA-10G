// *************************************************************************
// Module: rx_queue
// Author: James Hongyi Zeng (hyzeng_at_stanford.edu)
// Description: AXI-MAC converter: RX side
// *************************************************************************
module rx_queue
#(
   parameter AXI_DATA_WIDTH = 8 //Only 8 is supported right now in 1G mode.
)
(
   // AXI side
   output [AXI_DATA_WIDTH-1:0]  tdata,
   output [AXI_DATA_WIDTH/8-1:0]  tstrb,
   output tvalid,
   output tlast,
   input  tready,
       
   input clk,
   input reset,
       
   // MAC side
   input [7:0] rx_data,
   input rx_data_valid,
   input clk125
);

   localparam IDLE = 0;
   localparam WAIT_FOR_EOP = 1;
   localparam DROP = 2;

   wire fifo_almost_full;
   wire fifo_empty;
   reg  fifo_wr_en;
   
   reg  [2:0] state, state_next;
   
   // Instantiate clock domain crossing FIFO
   FIFO18 #(
   	.SIM_MODE("FAST"),
   	.ALMOST_FULL_OFFSET(9'h080),
   	.ALMOST_EMPTY_OFFSET(9'h080),
   	.DO_REG(1),
   	.EN_SYN("FALSE"),
   	.FIRST_WORD_FALL_THROUGH("TRUE"),
   	.DATA_WIDTH(9)
   	) rx_fifo (
		.ALMOSTEMPTY(),
		.ALMOSTFULL(fifo_almost_full),
		.DO(tdata),
		.DOP(tstrb),
		.EMPTY(fifo_empty),
		.FULL(),
		.RDCOUNT(),
		.RDERR(),
		.WRCOUNT(),
		.WRERR(),
		.DI(rx_data),
		.DIP(rx_data_valid),
		.RDCLK(clk),
		.RDEN((~fifo_empty & tready)),
		.RST(reset),
		.WRCLK(clk125),
		.WREN(fifo_wr_en) 
   	);
   	    
     assign tlast = ~fifo_empty & ~tstrb;
     assign tvalid = ~fifo_empty & tstrb;
         
     always @* begin
         state_next = state;
         fifo_wr_en = 1'b0;
         
         case(state)
             IDLE: begin
                 if(rx_data_valid) begin                    
                     if(~fifo_almost_full) begin
                         fifo_wr_en = 1'b1;
                         state_next = WAIT_FOR_EOP;
                     end
                     else begin
                         state_next = DROP;
                     end
                 end
             end
             
             WAIT_FOR_EOP: begin
                 fifo_wr_en = 1'b1;
                 if(~rx_data_valid) begin                     
                     state_next = IDLE;
                 end
             end
             
             DROP: begin
                 if(~rx_data_valid) begin
                     state_next = IDLE;
                 end
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
endmodule
