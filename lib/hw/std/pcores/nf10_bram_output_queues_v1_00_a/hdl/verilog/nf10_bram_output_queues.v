////////////////////////////////////////////////////////////////////////
//
//  NetFPGA-10G http://www.netfpga.org
//
//  Module:
//          nf10_bram_output_queues
//
//  Description:
//          BRAM Output queues
//          Outputs have a parameterizable width
//                 
//  Revision history:
//          2011/5/10 hyzeng: Initial check-in
//
////////////////////////////////////////////////////////////////////////
module nf10_bram_output_queues
#(
    // Master AXI Stream Data Width
    parameter C_AXIS_DATA_WIDTH=256,    
    parameter C_USER_WIDTH=128,
    parameter NUM_QUEUES=5
)
(
    // Part 1: System side signals
    // Global Ports
    input axi_aclk,
    input axi_resetn,
    
    // Slave Stream Ports (interface to data path)
    input [C_AXIS_DATA_WIDTH - 1:0] s_axis_tdata,
    input [((C_AXIS_DATA_WIDTH / 8)) - 1:0] s_axis_tstrb,
    input [C_USER_WIDTH-1:0] s_axis_tuser,
    input s_axis_tvalid,
    output reg s_axis_tready,
    input s_axis_tlast,
    
    // Master Stream Ports (interface to TX queues)
    output [C_AXIS_DATA_WIDTH - 1:0] m_axis_tdata_0,
    output [((C_AXIS_DATA_WIDTH / 8)) - 1:0] m_axis_tstrb_0,
    output [C_USER_WIDTH-1:0] m_axis_tuser_0,
    output  m_axis_tvalid_0,
    input m_axis_tready_0,
    output  m_axis_tlast_0,

    output [C_AXIS_DATA_WIDTH - 1:0] m_axis_tdata_1,
    output [((C_AXIS_DATA_WIDTH / 8)) - 1:0] m_axis_tstrb_1,
    output [C_USER_WIDTH-1:0] m_axis_tuser_1,
    output  m_axis_tvalid_1,
    input m_axis_tready_1,
    output  m_axis_tlast_1,
    
    output [C_AXIS_DATA_WIDTH - 1:0] m_axis_tdata_2,
    output [((C_AXIS_DATA_WIDTH / 8)) - 1:0] m_axis_tstrb_2,
    output [C_USER_WIDTH-1:0] m_axis_tuser_2,
    output  m_axis_tvalid_2,
    input m_axis_tready_2,
    output  m_axis_tlast_2,
    
    output [C_AXIS_DATA_WIDTH - 1:0] m_axis_tdata_3,
    output [((C_AXIS_DATA_WIDTH / 8)) - 1:0] m_axis_tstrb_3,
    output [C_USER_WIDTH-1:0] m_axis_tuser_3,
    output  m_axis_tvalid_3,
    input m_axis_tready_3,
    output  m_axis_tlast_3,
    
    output [C_AXIS_DATA_WIDTH - 1:0] m_axis_tdata_4,
    output [((C_AXIS_DATA_WIDTH / 8)) - 1:0] m_axis_tstrb_4,
    output [C_USER_WIDTH-1:0] m_axis_tuser_4,
    output  m_axis_tvalid_4,
    input m_axis_tready_4,
    output  m_axis_tlast_4
);

   function integer log2;
      input integer number;
      begin
         log2=0;
         while(2**log2<number) begin
            log2=log2+1;
         end
      end
   endfunction // log2

   // ------------ Internal Params --------
   
   localparam NUM_QUEUES_WIDTH = log2(NUM_QUEUES);

   localparam NUM_STATES = 3;
   localparam IDLE = 0;
   localparam WR_PKT = 1;
   localparam DROP = 2;

   // ------------- Regs/ wires -----------
   
   wire [NUM_QUEUES-1:0]               nearly_full;
   wire [NUM_QUEUES-1:0]               empty;
   wire [C_USER_WIDTH-1:0]             fifo_out_tuser[NUM_QUEUES-1:0];
   wire [C_AXIS_DATA_WIDTH-1:0]        fifo_out_tdata[NUM_QUEUES-1:0];
   wire [((C_AXIS_DATA_WIDTH/8))-1:0]  fifo_out_tstrb[NUM_QUEUES-1:0];
   wire [NUM_QUEUES-1:0] 	           fifo_out_tlast;	       
   wire [NUM_QUEUES-1:0]                rd_en;
   reg [NUM_QUEUES-1:0]                wr_en;

   reg [NUM_QUEUES-1:0]          cur_queue;
   reg [NUM_QUEUES-1:0]          cur_queue_next;
   wire [NUM_QUEUES-1:0]         oq = s_axis_tuser[31:24]; // Per NetFPGA-10G AXI Spec

   reg [NUM_STATES-1:0]                state;
   reg [NUM_STATES-1:0]                state_next;

   // ------------ Modules -------------

   generate
   genvar i;
   for(i=0; i<NUM_QUEUES; i=i+1) begin: output_queues
      fallthrough_small_fifo
        #( .WIDTH(C_AXIS_DATA_WIDTH+C_USER_WIDTH+C_AXIS_DATA_WIDTH/8+1),
           .MAX_DEPTH_BITS(2))
      output_fifo
        (// Outputs
         .dout                           ({fifo_out_tlast[i], fifo_out_tuser[i], fifo_out_tstrb[i], fifo_out_tdata[i]}),
         .full                           (),
         .nearly_full                    (nearly_full[i]),
	 	 .prog_full                      (),
         .empty                          (empty[i]),
         // Inputs
         .din                            ({s_axis_tlast, s_axis_tuser, s_axis_tstrb, s_axis_tdata}),
         .wr_en                          (wr_en[i]),
         .rd_en                          (rd_en[i]),
         .reset                          (~axi_resetn),
         .clk                            (axi_aclk));
   end 
   endgenerate

   // ------------- Logic ------------
   
   
   always @(*) begin
      state_next     = state;
      cur_queue_next = cur_queue;      
      wr_en          = 0;
      s_axis_tready  = 0;

      case(state)

        /* cycle between input queues until one is not empty */
        IDLE: begin
           if(s_axis_tvalid) begin
              if(~|(nearly_full & oq)) begin // All interesting oqs are NOT full.
                  state_next = WR_PKT;
                  cur_queue_next = oq;
              end
              else begin
              	  state_next = DROP;
              end
           end
        end

        /* wait until eop */
        WR_PKT: begin
           if(s_axis_tvalid & ~|(nearly_full & cur_queue)) begin
				wr_en = cur_queue;
				s_axis_tready = 1;
				if(s_axis_tlast) begin
					state_next = IDLE;
					cur_queue_next = 0;
				end           	
           end
        end // case: WR_PKT
        
        DROP: begin
           s_axis_tready = 1;
           if(s_axis_tvalid & s_axis_tlast) begin
           	  state_next = IDLE;
           end
        end

      endcase // case(state)
   end // always @ (*)

   always @(posedge axi_aclk) begin
      if(~axi_resetn) begin
         state <= IDLE;
         cur_queue <= 0; 
      end
      else begin
         state <= state_next;
         cur_queue <= cur_queue_next; 
      end
   end
   
   
   assign m_axis_tdata_0	 = fifo_out_tdata[0];
   assign m_axis_tstrb_0	 = fifo_out_tstrb[0];
   assign m_axis_tuser_0	 = fifo_out_tuser[0];
   assign m_axis_tlast_0	 = fifo_out_tlast[0];
   assign m_axis_tvalid_0	 = ~empty[0];
   assign rd_en[0]			 = m_axis_tready_0 & ~empty[0];
   
   assign m_axis_tdata_1	 = fifo_out_tdata[1];
   assign m_axis_tstrb_1	 = fifo_out_tstrb[1];
   assign m_axis_tuser_1	 = fifo_out_tuser[1];
   assign m_axis_tlast_1	 = fifo_out_tlast[1];
   assign m_axis_tvalid_1	 = ~empty[1];
   assign rd_en[1]			 = m_axis_tready_1 & ~empty[1];
   
   assign m_axis_tdata_2	 = fifo_out_tdata[2];
   assign m_axis_tstrb_2	 = fifo_out_tstrb[2];
   assign m_axis_tuser_2	 = fifo_out_tuser[2];
   assign m_axis_tlast_2	 = fifo_out_tlast[2];
   assign m_axis_tvalid_2	 = ~empty[2];
   assign rd_en[2]			 = m_axis_tready_2 & ~empty[2];
   
   assign m_axis_tdata_3	 = fifo_out_tdata[3];
   assign m_axis_tstrb_3	 = fifo_out_tstrb[3];
   assign m_axis_tuser_3	 = fifo_out_tuser[3];
   assign m_axis_tlast_3	 = fifo_out_tlast[3];
   assign m_axis_tvalid_3	 = ~empty[3];
   assign rd_en[3]			 = m_axis_tready_3 & ~empty[3];
   
   assign m_axis_tdata_4	 = fifo_out_tdata[4];
   assign m_axis_tstrb_4	 = fifo_out_tstrb[4];
   assign m_axis_tuser_4	 = fifo_out_tuser[4];
   assign m_axis_tlast_4	 = fifo_out_tlast[4];
   assign m_axis_tvalid_4	 = ~empty[4];
   assign rd_en[4]			 = m_axis_tready_4 & ~empty[4];

endmodule
