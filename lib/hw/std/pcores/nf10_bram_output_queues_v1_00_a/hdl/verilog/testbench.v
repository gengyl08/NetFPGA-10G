////////////////////////////////////////////////////////////////////////
//
//  NetFPGA-10G http://www.netfpga.org
//
//  Module:
//          testbench
//
//  Description:
//          Testbench of nf10_output_queues
//          Send in packets to two ports
//                 
//  Revision history:
//          2011/5/10 hyzeng: Initial check-in
//
////////////////////////////////////////////////////////////////////////
`timescale 1 ns / 1ps
module testbench();
    
    reg clk, reset;
    reg [255:0] tdata;
    reg [31:0]  tstrb;
    reg        tvalid;
    reg        tlast;
    wire       tready;
    
    wire [255:0] tdata_0;
    wire [31:0]  tstrb_0;
    wire        tvalid_0;
    wire        tlast_0;
            
    wire [255:0] tdata_1;
    wire [31:0]  tstrb_1;
    wire        tvalid_1;
    wire        tlast_1;
    
    wire [255:0] tdata_2;
    wire [31:0]  tstrb_2;
    wire        tvalid_2;
    wire        tlast_2;
    
    wire [255:0] tdata_3;
    wire [31:0]  tstrb_3;
    wire        tvalid_3;
    wire        tlast_3;
    
    wire [255:0] tdata_4;
    wire [31:0]  tstrb_4;
    wire        tvalid_4;
    wire        tlast_4;

    
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
        tvalid = 1'b1;
        counter_next = counter;
        case(state)
            HEADER_0: begin
                tdata = header_word_0;
                tstrb = 8'hFF;
                if(tready) begin
                    state_next = HEADER_1;
                end
            end
            HEADER_1: begin
                tdata = header_word_1;
                tstrb = 8'hFF;
                if(tready) begin
                    state_next = PAYLOAD;
                end
            end
            PAYLOAD: begin
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
                tvalid = 1'b0;
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

    nf10_bram_output_queues 
    #(.C_AXIS_DATA_WIDTH(256),
      .C_AXIS_USER_WIDTH(128)
     ) dut
    (
    // Global Ports
    .axi_aclk(clk),
    .axi_resetn(~reset),
    
    // Master Stream Ports
    .m_axis_tdata_0(tdata_0),
    .m_axis_tstrb_0(tstrb_0),
    .m_axis_tvalid_0(tvalid_0),
    .m_axis_tready_0(1'b1),
    .m_axis_tlast_0(tlast_0),

    .m_axis_tdata_1(tdata_1),
    .m_axis_tstrb_1(tstrb_1),
    .m_axis_tvalid_1(tvalid_1),
    .m_axis_tready_1(1'b1),
    .m_axis_tlast_1(tlast_1),

    .m_axis_tdata_2(tdata_2),
    .m_axis_tstrb_2(tstrb_2),
    .m_axis_tvalid_2(tvalid_2),
    .m_axis_tready_2(1'b1),
    .m_axis_tlast_2(tlast_2),
    
    .m_axis_tdata_3(tdata_3),
    .m_axis_tstrb_3(tstrb_3),
    .m_axis_tvalid_3(tvalid_3),
    .m_axis_tready_3(1'b1),
    .m_axis_tlast_3(tlast_3),
    
    .m_axis_tdata_4(tdata_4),
    .m_axis_tstrb_4(tstrb_4),
    .m_axis_tvalid_4(tvalid_4),
    .m_axis_tready_4(1'b1),
    .m_axis_tlast_4(tlast_4),
    
    // Slave Stream Ports
    .s_axis_tdata(tdata),
    .s_axis_tstrb(tstrb),
    .s_axis_tvalid(tvalid),
    .s_axis_tready(tready),
    .s_axis_tlast(tlast),
    .s_axis_tuser({96'b0, 8'b0000_1010, 8'b0, 16'b0})
   );

endmodule