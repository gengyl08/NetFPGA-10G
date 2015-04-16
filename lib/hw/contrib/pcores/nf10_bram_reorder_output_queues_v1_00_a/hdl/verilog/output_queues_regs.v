module output_queues_regs
  #(
    // Master AXI Lite Data Width
    parameter DATA_WIDTH=32,
    parameter ADDR_WIDTH=32
    )
   (
    output reg reset_drop_counts,
    input [31:0] drop_count_0,
    input [31:0] drop_count_1,
    input [31:0] drop_count_2,
    input [31:0] drop_count_3,
    input [31:0] drop_count_4,

    output reg [31:0] split_ratio_0,
    output reg [31:0] split_ratio_1,
    output reg [31:0] split_ratio_2,
    output reg [31:0] split_ratio_3,

    input                        ACLK,
    input                        ARESETN,
    
    input [ADDR_WIDTH-1: 0]      AWADDR,
    input                        AWVALID,
    output reg                   AWREADY,
    
    input [DATA_WIDTH-1: 0]      WDATA,
    input [DATA_WIDTH/8-1: 0]    WSTRB,
    input                        WVALID,
    output reg                   WREADY,
    
    output reg [1:0]             BRESP,
    output reg                   BVALID,
    input                        BREADY,
    
    input [ADDR_WIDTH-1: 0]      ARADDR,
    input                        ARVALID,
    output reg                   ARREADY,
    
    output reg [DATA_WIDTH-1: 0] RDATA, 
    output reg [1:0]             RRESP,
    output reg                   RVALID,
    input                        RREADY
    );

   localparam AXI_RESP_OK = 2'b00;
   localparam AXI_RESP_SLVERR = 2'b10;
   
   localparam WRITE_IDLE = 0;
   localparam WRITE_RESPONSE = 1;
   localparam WRITE_DATA = 2;

   localparam READ_IDLE = 0;
   localparam READ_RESPONSE = 1;

   localparam RESET_DROP_COUNTS = 8'h01;
   localparam DROP_COUNT_0 = 8'h10;
   localparam DROP_COUNT_1 = 8'h11;
   localparam DROP_COUNT_2 = 8'h12;
   localparam DROP_COUNT_3 = 8'h13;
   localparam DROP_COUNT_4 = 8'h14;
   localparam SPLIT_RATIO_0 = 8'h20;
   localparam SPLIT_RATIO_1 = 8'h21;
   localparam SPLIT_RATIO_2 = 8'h22;
   localparam SPLIT_RATIO_3 = 8'h23;

   reg [1:0]                     write_state, write_state_next;
   reg [1:0]                     read_state, read_state_next;
   reg [ADDR_WIDTH-1:0]          read_addr, read_addr_next;
   reg [ADDR_WIDTH-1:0]          write_addr, write_addr_next;
   reg [1:0]                     BRESP_next;

   reg                           reset_drop_counts_next;
   reg [31:0]                    split_ratio_0_next;
   reg [31:0]                    split_ratio_1_next;
   reg [31:0]                    split_ratio_2_next;
   reg [31:0]                    split_ratio_3_next;

   always @(*) begin
      read_state_next = read_state;   
      ARREADY = 1'b1;
      read_addr_next = read_addr;
      RDATA = 0; 
      RRESP = AXI_RESP_OK;
      RVALID = 1'b0;
      
      case(read_state)
        READ_IDLE: begin
           if(ARVALID) begin
              read_addr_next = ARADDR;
              read_state_next = READ_RESPONSE;
           end
        end        
        
        READ_RESPONSE: begin
           RVALID = 1'b1;
           ARREADY = 1'b0;

           if(read_addr[7:0] == RESET_DROP_COUNTS) begin
              RDATA[0] = reset_drop_counts;
              RDATA[31:1] = 0;
           end
           else if(read_addr[7:0] == DROP_COUNT_0) begin
              RDATA = drop_count_0;
           end
           else if(read_addr[7:0] == DROP_COUNT_1) begin
              RDATA = drop_count_1;
           end
           else if(read_addr[7:0] == DROP_COUNT_2) begin
              RDATA = drop_count_2;
           end
           else if(read_addr[7:0] == DROP_COUNT_3) begin
              RDATA = drop_count_3;
           end
           else if(read_addr[7:0] == DROP_COUNT_4) begin
              RDATA = drop_count_4;
           end

           else if(read_addr[7:0] == SPLIT_RATIO_0) begin
              RDATA = split_ratio_0;
           end
           else if(read_addr[7:0] == SPLIT_RATIO_1) begin
              RDATA = split_ratio_1;
           end
           else if(read_addr[7:0] == SPLIT_RATIO_2) begin
              RDATA = split_ratio_2;
           end
           else if(read_addr[7:0] == SPLIT_RATIO_3) begin
              RDATA = split_ratio_3;
           end

           else begin
              RRESP = AXI_RESP_SLVERR;
           end

           if(RREADY) begin
              read_state_next = READ_IDLE;
           end
        end
      endcase
   end
   
   always @(*) begin
      write_state_next = write_state;
      write_addr_next = write_addr;

      AWREADY = 1'b1;
      WREADY = 1'b0;
      BVALID = 1'b0;  
      BRESP_next = BRESP;

      reset_drop_counts_next = reset_drop_counts;
      split_ratio_0_next = split_ratio_0;
      split_ratio_1_next = split_ratio_1;
      split_ratio_2_next = split_ratio_2;
      split_ratio_3_next = split_ratio_3;

      case(write_state)
        WRITE_IDLE: begin
           write_addr_next = AWADDR;
           if(AWVALID) begin
              write_state_next = WRITE_DATA;
           end
        end
        WRITE_DATA: begin
           AWREADY = 1'b0;
           WREADY = 1'b1;
           if(WVALID) begin

              if(write_addr[7:0] == RESET_DROP_COUNTS) begin
                 reset_drop_counts_next = WDATA[0];
                 BRESP_next = AXI_RESP_OK;
              end

              else if(write_addr[7:0] == SPLIT_RATIO_0) begin
                 split_ratio_0_next = WDATA;
                 BRESP_next = AXI_RESP_OK;
              end
              else if(write_addr[7:0] == SPLIT_RATIO_1) begin
                 split_ratio_1_next = WDATA;
                 BRESP_next = AXI_RESP_OK;
              end
              else if(write_addr[7:0] == SPLIT_RATIO_2) begin
                 split_ratio_2_next = WDATA;
                 BRESP_next = AXI_RESP_OK;
              end
              else if(write_addr[7:0] == SPLIT_RATIO_3) begin
                 split_ratio_3_next = WDATA;
                 BRESP_next = AXI_RESP_OK;
              end

              else begin
                 BRESP_next = AXI_RESP_SLVERR;
              end
              write_state_next = WRITE_RESPONSE;
           end
        end
        WRITE_RESPONSE: begin
           AWREADY = 1'b0;
           BVALID = 1'b1;
           if(BREADY) begin                    
              write_state_next = WRITE_IDLE;
           end
        end
      endcase
   end

   always @(posedge ACLK) begin
      if(~ARESETN) begin
         write_state <= WRITE_IDLE;
         read_state <= READ_IDLE;
         read_addr <= 0;
         write_addr <= 0;
         BRESP <= AXI_RESP_OK;

         reset_drop_counts <= 0;

         split_ratio_0 <= 32'd858993460;
         split_ratio_1 <= 32'd1717986919;
         split_ratio_2 <= 32'd2576980378;
         split_ratio_3 <= 32'd3435973837;
      end
      else begin
         write_state <= write_state_next;
         read_state <= read_state_next;
         read_addr <= read_addr_next;
         write_addr <= write_addr_next;
         BRESP <= BRESP_next;

         reset_drop_counts <= reset_drop_counts_next;

         split_ratio_0 <= split_ratio_0_next;
         split_ratio_1 <= split_ratio_1_next;
         split_ratio_2 <= split_ratio_2_next;
         split_ratio_3 <= split_ratio_3_next;

      end
   end

endmodule
