////////////////////////////////////////////////////////////////////////
//
//  NetFPGA-10G http://www.netfpga.org
//
//  Module:
//          testbench
//
//  Description:
//          Testbench of nf10_axis_converter
//          Instantiate 3 converters of Master width larger, equal or
//          smaller than Slave width
//                 
//  Revision history:
//          2011/2/6 hyzeng: Initial check-in
//
////////////////////////////////////////////////////////////////////////
`timescale 1 ns / 1ps
module testbench();
    
    reg clk, reset;
    reg [63:0] tdata;
    reg [7:0]  tstrb;
    reg        tvalid;
    reg        tlast;
    wire       tready;
	 wire [127:0] tuser = 128'b0;
    
    wire [255:0] tdata_0;
    wire [31:0]  tstrb_0;
    wire        tvalid_0;
    wire        tlast_0;
    wire        tready_0;
	 wire	[127:0] tuser_0;
    
    wire [255:0] tdata_1;
    wire [31:0]  tstrb_1;
    wire        tvalid_1;
    wire        tlast_1;
    wire        tready_1;
	 wire	[127:0] tuser_1;
    
    integer i;
    
    wire [63:0] header_word_0 = 64'hEFBEFECAFECAFECA; // Destination MAC
    wire [63:0] header_word_1 = 64'h00000008EFBEEFBE; // Source MAC + EtherType
    
    localparam HEADER_0 = 0;
    localparam HEADER_1 = 1;
    localparam PAYLOAD  = 2;
    localparam DEAD     = 3;
    
    reg [2:0] state, state_next;
    reg [7:0] counter, counter_next;
    
    always @(*) begin
        state_next = state;
        tdata = 64'b0;
        tstrb = 8'hFF;
        tlast = 1'b0;
        tvalid = 1'b0;
        counter_next = counter;
        case(state)
            HEADER_0: begin
					 tvalid = 1'b1;
                tdata = header_word_0;
                tstrb = 8'hFF;
                if(tready) begin
                    state_next = HEADER_1;
                end
            end
            HEADER_1: begin
					 tvalid = 1'b1;
                tdata = header_word_1;
                tstrb = 8'hFF;
                if(tready) begin
                    state_next = PAYLOAD;
                end
            end
            PAYLOAD: begin
					 tvalid = 1'b1;
                tdata = {8{counter}};
                tstrb = 8'hFF;
                if(tready) begin
                    counter_next = counter + 1'b1;
                    if(counter == 8'h1F) begin
                        tstrb = 8'hFF;
                        state_next = DEAD;
                        counter_next = 8'b0;
                        tlast = 1'b1;
                    end
                end
            end
            
            DEAD: begin
                counter_next = counter + 1'b1;
                tlast = 1'b0;
                if(counter[7]==1'b1) begin
                    counter_next = 8'b0;
                    state_next = HEADER_0;
                end
            end
        endcase
    end
    
    always @(posedge clk) begin
        if(reset) begin
            state <= HEADER_0;
            counter <= 8'b0;
        end
        else begin
            state <= state_next;
            counter <= counter_next;
        end
    end
    
  initial begin
      clk   = 1'b0;
  
      $display("[%t] : System Reset Asserted...", $realtime);
      reset = 1'b1;
      for (i = 0; i < 50; i = i + 1) begin
                 @(posedge clk);
      end
      $display("[%t] : System Reset De-asserted...", $realtime);
      reset = 1'b0;
  end
  
  always #2.5  clk = ~clk;      // 200MHz

    nf10_axis_converter 
    #(.C_M_AXIS_DATA_WIDTH(256),
      .C_S_AXIS_DATA_WIDTH(64)
     ) dut_0
    (
    // Global Ports
    .axi_aclk(clk),
    .axi_resetn(~reset),
    
    // Master Stream Ports
    .m_axis_tdata(tdata_0),
    .m_axis_tstrb(tstrb_0),
    .m_axis_tvalid(tvalid_0),
    .m_axis_tready(tready_0),
    .m_axis_tlast(tlast_0),
	 .m_axis_tuser(tuser_0),
    
    // Slave Stream Ports
    .s_axis_tdata(tdata),
    .s_axis_tstrb(tstrb),
    .s_axis_tvalid(tvalid),
    .s_axis_tready(tready),
    .s_axis_tlast(tlast),
	 .s_axis_tuser(tuser)
   );

    nf10_axis_converter 
    #(.C_M_AXIS_DATA_WIDTH(256),
      .C_S_AXIS_DATA_WIDTH(256)
     ) dut_1
    (
    // Global Ports
    .axi_aclk(clk),
    .axi_resetn(~reset),
    
    // Master Stream Ports
    .m_axis_tdata(tdata_1),
    .m_axis_tstrb(tstrb_1),
    .m_axis_tvalid(tvalid_1),
    .m_axis_tready(tready_1),
    .m_axis_tlast(tlast_1),
	 .m_axis_tuser(tuser_1),
    
    // Slave Stream Ports
    .s_axis_tdata(tdata_0),
    .s_axis_tstrb(tstrb_0),
    .s_axis_tvalid(tvalid_0),
    .s_axis_tready(tready_0),
    .s_axis_tlast(tlast_0),
	 .s_axis_tuser(tuser_0)
   );

    nf10_axis_converter
    #(.C_M_AXIS_DATA_WIDTH(64),
      .C_S_AXIS_DATA_WIDTH(256)
     ) dut_2
    (
    // Global Ports
    .axi_aclk(clk),
    .axi_resetn(~reset),
    
    // Master Stream Ports
    .m_axis_tdata(),
    .m_axis_tstrb(),
    .m_axis_tvalid(),
    .m_axis_tready(1'b1),
    .m_axis_tlast(),
	 .m_axis_tuser(),
    
    // Slave Stream Ports
    .s_axis_tdata(tdata_1),
    .s_axis_tstrb(tstrb_1),
    .s_axis_tvalid(tvalid_1),
    .s_axis_tready(tready_1),
    .s_axis_tlast(tlast_1),
	 .s_axis_tuser(tuser_1)
   );

endmodule
