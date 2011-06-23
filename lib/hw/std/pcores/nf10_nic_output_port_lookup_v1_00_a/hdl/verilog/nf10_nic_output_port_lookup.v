////////////////////////////////////////////////////////////////////////
//
//  NetFPGA-10G http://www.netfpga.org
//
//  Module:
//          nf10_nic_output_port_lookup
//
//  Description:
//          Hardwire the hardware interfaces to CPU and vice versa
//                 
//  Revision history:
//          2011/5/13 gac1: Initial check-in
//          2011/6/2 hyzeng: Move state machine to output
//
////////////////////////////////////////////////////////////////////////
module nf10_nic_output_port_lookup
#(
    //Master AXI Stream Data Width
    parameter C_AXIS_DATA_WIDTH=256,
    parameter C_USER_WIDTH=128,
    parameter SRC_PORT_POS=16,
    parameter DST_PORT_POS=24
)
(
    // Global Ports
    input axi_aclk,
    input axi_resetn,

    // Master Stream Ports (interface to data path)
    output [C_AXIS_DATA_WIDTH - 1:0] m_axis_tdata,
    output [((C_AXIS_DATA_WIDTH / 8)) - 1:0] m_axis_tstrb,
    output reg [C_USER_WIDTH-1:0] m_axis_tuser,
    output m_axis_tvalid,
    input  m_axis_tready,
    output m_axis_tlast,

    // Slave Stream Ports (interface to RX queues)
    input [C_AXIS_DATA_WIDTH - 1:0] s_axis_tdata,
    input [((C_AXIS_DATA_WIDTH / 8)) - 1:0] s_axis_tstrb,
    input [C_USER_WIDTH-1:0] s_axis_tuser,
    input  s_axis_tvalid,
    output s_axis_tready,
    input  s_axis_tlast
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
   localparam MODULE_HEADER = 0;
   localparam IN_PACKET     = 1;

   //------------- Wires ------------------
   wire  [C_USER_WIDTH-1:0] tuser_fifo;
   reg 			  state, state_next;     
   
   // ------------ Modules ----------------
   
   fallthrough_small_fifo
        #( .WIDTH(C_AXIS_DATA_WIDTH+C_USER_WIDTH+C_AXIS_DATA_WIDTH/8+1),
           .MAX_DEPTH_BITS(2))
      input_fifo
        (// Outputs
         .dout                           ({m_axis_tlast, tuser_fifo, m_axis_tstrb, m_axis_tdata}),
         .full                           (),
         .nearly_full                    (in_fifo_nearly_full),
         .prog_full                      (),
         .empty                          (in_fifo_empty),
         // Inputs
         .din                            ({s_axis_tlast, s_axis_tuser, s_axis_tstrb, s_axis_tdata}),
         .wr_en                          (s_axis_tvalid & ~in_fifo_nearly_full),
         .rd_en                          (in_fifo_rd_en),
         .reset                          (~axi_resetn),
         .clk                            (axi_aclk));
   
   // ------------- Logic ----------------

   assign s_axis_tready = !in_fifo_nearly_full;

   // packet is from the cpu if it is on an odd numbered port
   assign pkt_is_from_cpu = m_axis_tuser[SRC_PORT_POS+1] || 
			    m_axis_tuser[SRC_PORT_POS+3] || 
			    m_axis_tuser[SRC_PORT_POS+5] || 
			    m_axis_tuser[SRC_PORT_POS+7];

   // modify the dst port in tuser
   always @(*) begin
      m_axis_tuser = tuser_fifo;
      state_next      = state;

      case(state)
	MODULE_HEADER: begin
	   if (m_axis_tvalid) begin
	      if(~|m_axis_tuser[SRC_PORT_POS+:7]) begin
	      	m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = 8'b1;
	      end // Default: Send to MAC 0
	      else if(pkt_is_from_cpu) begin
		 m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = {1'b0, 
			tuser_fifo[SRC_PORT_POS+7:SRC_PORT_POS+1]};
	      end
	      else begin
		 m_axis_tuser[DST_PORT_POS+7:DST_PORT_POS] = {
			tuser_fifo[SRC_PORT_POS+6:SRC_PORT_POS], 1'b0};
	      end
	      if(m_axis_tready) begin
			    state_next = IN_PACKET;
			end
	   end	   
	end // case: MODULE_HEADER

	IN_PACKET: begin
	   if(m_axis_tlast & m_axis_tvalid & m_axis_tready) begin
	      state_next = MODULE_HEADER;
	   end
	end
      endcase // case (state)      
   end // always @ (*)

   always @(posedge axi_aclk) begin
      if(~axi_resetn) begin
	 state <= MODULE_HEADER;
      end
      else begin
	 state <= state_next;
      end
   end
  
   // Handle output
   assign in_fifo_rd_en = m_axis_tready && !in_fifo_empty;
   assign m_axis_tvalid = !in_fifo_empty;

endmodule // output_port_lookup   
