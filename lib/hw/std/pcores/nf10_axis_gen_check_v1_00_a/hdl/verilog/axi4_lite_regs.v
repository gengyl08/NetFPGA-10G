////////////////////////////////////////////////////////////////////////
//
//  NetFPGA-10G http://www.netfpga.org
//
//  Module:
//          axi4_lite_regs.v
//
//  Description:
//          AXI4-Lite for registers
//                 
//  Revision history:
//          2010/12/15 hyzeng   Initial check-in
//
////////////////////////////////////////////////////////////////////////

module axi4_lite_regs
#(
    // Master AXI Stream Data Width
    parameter DATA_WIDTH=32,
    parameter ADDR_WIDTH=32
)
(
   input  ACLK,
   input  ARESETN,
   
   input  [ADDR_WIDTH-1: 0] AWADDR,
   input  AWVALID,
   output AWREADY,
   
   input  [DATA_WIDTH-1: 0]   WDATA,
   input  [DATA_WIDTH/8-1: 0] WSTRB,
   input  WVALID,
   output reg WREADY,
   
   output [1:0] BRESP,
   output reg BVALID,
   input  BREADY,
   
   input  [ADDR_WIDTH-1: 0] ARADDR,
   input  ARVALID,
   output reg ARREADY,
   
   output reg [DATA_WIDTH-1: 0] RDATA,   
   output reg [1:0] RRESP,
   output reg RVALID,
   input  RREADY,
   
   input  [31:0] tx_count,
   input  [31:0] rx_count,
   input  [31:0] err_count
);

    localparam AXI_RESP_OK = 2'b00;
    localparam AXI_RESP_SLVERR = 2'b10;
    
    localparam WRITE_IDLE = 0;
    localparam WRITE_RESPONSE = 1;

    localparam READ_IDLE = 0;
    localparam READ_RESPONSE = 1;
    
    assign BRESP = AXI_RESP_SLVERR; // Ignore WRITE command
    assign AWREADY = 1'b1;

    reg [31:0] tx_count_r_2, tx_count_r;
    reg [31:0] rx_count_r_2, rx_count_r;
    reg [31:0] err_count_r_2, err_count_r;
    // synthesis attribute ASYNC_REG of tx_count_r is "TRUE";
    // synthesis attribute ASYNC_REG of rx_count_r is "TRUE";
    // synthesis attribute ASYNC_REG of err_count_r is "TRUE";
    
    reg [1:0] write_state, write_state_next;
    reg [1:0] read_state, read_state_next;
    reg [ADDR_WIDTH-1:0] addr, addr_next;

    always @(*) begin
        read_state_next = read_state;   
        ARREADY = 1'b1;
        addr_next = addr;
        RDATA = 0; 
        RRESP = AXI_RESP_OK;
        RVALID = 1'b0;
        
        case(read_state)
            READ_IDLE: begin
                if(ARVALID) begin
                    addr_next = ARADDR;
                    read_state_next = READ_RESPONSE;
                end
            end
            
            READ_RESPONSE: begin
                RVALID = 1'b1;
                ARREADY = 1'b0;
                
                if(addr[1:0] == 2'b00) begin
                    RDATA = tx_count_r_2;
                end
                else if(addr[1:0] == 2'b01) begin
                    RDATA = rx_count_r_2;
                end
                else if(addr[1:0] == 2'b10) begin
                    RDATA = err_count_r_2;
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
        WREADY = 1'b1;
        BVALID = 1'b0;  
              
        case(write_state)
            WRITE_IDLE: begin
                if(WVALID) begin
                    write_state_next = WRITE_RESPONSE;
                end
            end
            WRITE_RESPONSE: begin
                BVALID = 1'b1;
                WREADY = 1'b0;
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
            addr <= 0;
        end
        else begin
            write_state <= write_state_next;
            read_state <= read_state_next;
            addr <= addr_next;
        end
        
        rx_count_r_2 <= rx_count_r;
        tx_count_r_2 <= tx_count_r;
        err_count_r_2 <= err_count_r;
        
        rx_count_r <= rx_count;
        tx_count_r <= tx_count;
        err_count_r <= err_count;
    end

endmodule
