////////////////////////////////////////////////////////////////////////
//
//  NetFPGA-10G http://www.netfpga.org
//
//  Module:
//          rx_queue
//
//  Description:
//          AXI-MAC converter: RX side
//                 
//  Revision history:
//          2010/11/28 hyzeng: Initial check-in
//
////////////////////////////////////////////////////////////////////////

module rx_queue
#(
   parameter AXI_DATA_WIDTH = 8 //Only 8 is supported right now in 1G mode.
)
(
   // AXI side
   output reg [AXI_DATA_WIDTH-1:0]  tdata,
   output reg [AXI_DATA_WIDTH/8-1:0]  tstrb,
   output reg tvalid,
   output reg tlast,
   input  tready,
        
   output reg err_tvalid,
       
   input clk,
   input reset,
       
   // MAC side
   input [7:0] rx_data,
   input rx_data_valid,
   input rx_good_frame,
   input rx_bad_frame,
   input clk125
);

   localparam IDLE = 0;
   localparam WAIT_FOR_EOP = 1;
   localparam DROP = 2;
   
   localparam ERR_IDLE = 0;
   localparam ERR_WAIT = 1;
   localparam ERR_BUBBLE = 2;
   
   wire fifo_almost_full;
   wire fifo_empty;
   reg  fifo_wr_en;
     
   wire info_fifo_empty;
   reg  info_fifo_rd_en;
   wire rx_bad_frame_fifo;
   
   reg  [2:0] state, state_next;
   reg  [2:0] err_state, err_state_next;
   
   wire [AXI_DATA_WIDTH-1:0]  tdata_delay;
   wire [AXI_DATA_WIDTH/8-1:0]  tstrb_delay;
   reg  rx_fifo_rd_en;
   
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
		.DO(tdata_delay),
		.DOP(tstrb_delay),
		.EMPTY(fifo_empty),
		.FULL(),
		.RDCOUNT(),
		.RDERR(),
		.WRCOUNT(),
		.WRERR(),
		.DI(rx_data),
		.DIP(rx_data_valid),
		.RDCLK(clk),
		.RDEN(rx_fifo_rd_en),
		.RST(reset),
		.WRCLK(clk125),
		.WREN(fifo_wr_en) 
   	);

   	
   	small_async_fifo 
   	#(
   	  .DSIZE (1),
      .ASIZE (9)
	) rx_info_fifo
        (
         .wdata(rx_bad_frame),
         .winc(rx_good_frame|rx_bad_frame),
         .wclk(clk125),
         
         .rdata(rx_bad_frame_fifo),
         .rinc(info_fifo_rd_en),
         .rclk(clk),
         
         .rempty(info_fifo_empty),
         .r_almost_empty(),
         .wfull(),
         .w_almost_full(),
	     .rrst_n(~reset),
         .wrst_n(~reset)
         );
     
     always @(posedge clk) begin
         if(rx_fifo_rd_en) begin
             tdata <= tdata_delay;
             tstrb <= tstrb_delay;
         end
     end
              
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


   
     always @* begin
         info_fifo_rd_en = 0;
         err_state_next = err_state;
         err_tvalid = 0;
                           
         rx_fifo_rd_en = 0;
         tlast = 0;
         tvalid = 0;
         
         case(err_state)
             ERR_IDLE: begin
                 tvalid = (~fifo_empty);
                 rx_fifo_rd_en = (~fifo_empty & tready);
                 if(tstrb_delay == 1'b0 & ~fifo_empty) begin // End of the packet
                     err_state_next = ERR_WAIT;
                     rx_fifo_rd_en = 0;
                     tvalid = 0;
                 end
             end
             ERR_WAIT: begin
                 if(~info_fifo_empty) begin
                 	tlast = 1;
                 	tvalid = 1;
                 	if(tready) begin
                     	info_fifo_rd_en = 1;
                     	rx_fifo_rd_en = 1;
                     	err_tvalid = rx_bad_frame_fifo;
                     	err_state_next = ERR_BUBBLE;
                    end
                 end
             end
             ERR_BUBBLE: begin
                 if(~fifo_empty) begin // Head of the packet
                     rx_fifo_rd_en = 1;
                     err_state_next = ERR_IDLE;
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
     always @(posedge clk or posedge reset) begin
         if(reset) begin
             err_state <= ERR_BUBBLE;
         end
         else begin
             err_state <= err_state_next;
         end
     end
endmodule
