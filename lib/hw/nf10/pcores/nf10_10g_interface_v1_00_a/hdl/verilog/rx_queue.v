// *************************************************************************
// Module: rx_queue
// Author: James Hongyi Zeng (hyzeng_at_stanford.edu)
// Description: AXI-MAC converter: RX side
// *************************************************************************
module rx_queue
#(
   parameter AXI_DATA_WIDTH = 64 //Only 64 is supported right now.
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
   input [63:0] rx_data,
   input [ 7:0] rx_data_valid,
   input clk156
);

   localparam IDLE = 0;
   localparam WAIT_FOR_EOP = 1;
   localparam DROP = 2;

   wire fifo_almost_full;
   wire fifo_empty;
   reg  fifo_wr_en;
   
   reg  [2:0] state, state_next;
   
   
   // Instantiate clock domain crossing FIFO
   FIFO36_72 #(
   	.SIM_MODE("FAST"),
   	.ALMOST_FULL_OFFSET(9'h080),
   	.ALMOST_EMPTY_OFFSET(9'h080),
   	.DO_REG(1),
   	.EN_ECC_READ("FALSE"),
   	.EN_ECC_WRITE("FALSE"),
   	.EN_SYN("FALSE"),
   	.FIRST_WORD_FALL_THROUGH("TRUE")
   	) rx_fifo (
		.ALMOSTEMPTY(),
		.ALMOSTFULL(fifo_almost_full),
		.DBITERR(),
		.DO(tdata),
		.DOP(tstrb),
		.ECCPARITY(),
		.EMPTY(fifo_empty),
		.FULL(),
		.RDCOUNT(),
		.RDERR(),
		.SBITERR(),
		.WRCOUNT(),
		.WRERR(),
		.DI(rx_data),
		.DIP(rx_data_valid),
		.RDCLK(clk),
		.RDEN((~fifo_empty & tready)),
		.RST(reset),
		.WRCLK(clk156),
		.WREN(fifo_wr_en) 
   	);
   	    
     assign tlast = ~fifo_empty & (tstrb != 8'hFF);
     assign tvalid = ~fifo_empty & (tstrb != 8'h0); //Avoid writing a null word into the next module.
         
     always @* begin
         state_next = state;
         fifo_wr_en = 1'b0;
         
         case(state)
             IDLE: begin
                 if(rx_data_valid == 8'hFF) begin                    
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
                 if(rx_data_valid != 8'hFF) begin                     
                     state_next = IDLE;
                 end
             end
             
             DROP: begin
                 if(rx_data_valid != 8'hFF) begin
                     state_next = IDLE;
                 end
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
endmodule
