module delay_regs
  #(
    // Master AXI Lite Data Width
    parameter DATA_WIDTH=32,
    parameter ADDR_WIDTH=32
    )
   (
    output reg delay_enable,
    output reg delay_mux,
    output reg [31:0] delay_length,
    output reg host_reset,

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

   localparam DELAY_ENABLE = 8'h00;
   localparam DELAY_MUX = 8'h01;
   localparam DELAY_LENGTH = 8'h02;
   localparam HOST_RESET = 8'h03;

   reg [1:0]                     write_state, write_state_next;
   reg [1:0]                     read_state, read_state_next;
   reg [ADDR_WIDTH-1:0]          read_addr, read_addr_next;
   reg [ADDR_WIDTH-1:0]          write_addr, write_addr_next;
   reg [1:0]                     BRESP_next;

   reg                           delay_enable_next;
   reg                           delay_mux_next;
   reg [31:0]                    delay_length_next;
   reg                           host_reset_next;
   
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

           if(read_addr[7:0] == DELAY_ENABLE) begin
              RDATA[0] = delay_enable;
              RDATA[31:1] = 0;
           end
           else if(read_addr[7:0] == DELAY_MUX) begin
              RDATA[0] = delay_mux;
              RDATA[31:1] = 0;
           end
           else if(read_addr[7:0] == DELAY_LENGTH) begin
              RDATA = delay_length;
           end
           else if(read_addr[7:0] == HOST_RESET) begin
              RDATA[0] = host_reset;
              RDATA[31:1] = 0;
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

      delay_enable_next = delay_enable;
      delay_mux_next = delay_mux;
      delay_length_next = delay_length;
      host_reset_next = host_reset;

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
              if(write_addr[7:0] == DELAY_ENABLE) begin
                 delay_enable_next = WDATA[0];
                 BRESP_next = AXI_RESP_OK;
              end
              else if(write_addr[7:0] == DELAY_MUX) begin
                 delay_mux_next = WDATA[0];
                 BRESP_next = AXI_RESP_OK;
              end
              else if(write_addr[7:0] == DELAY_LENGTH) begin
                 delay_length_next = WDATA;
                 BRESP_next = AXI_RESP_OK;
              end
              else if(write_addr[7:0] == HOST_RESET) begin
                 host_reset_next = WDATA[0];
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

         delay_length <= 0;
         delay_enable <= 0;
         delay_mux <= 0;
         host_reset <= 0;
//         delay_length <= 5;
//         delay_enable <= 1;
//         delay_mux <= 0;
//         host_reset <= 0;


      end
      else begin
         write_state <= write_state_next;
         read_state <= read_state_next;
         read_addr <= read_addr_next;
         write_addr <= write_addr_next;
         BRESP <= BRESP_next;

         delay_length <= delay_length_next;
         delay_enable <= delay_enable_next;
         delay_mux <= delay_mux_next;
         host_reset <= host_reset_next;
//         delay_length <= 5;
//         delay_enable <= 1;
//         delay_mux <= 0;
//         host_reset <= 0;


      end
   end

endmodule
