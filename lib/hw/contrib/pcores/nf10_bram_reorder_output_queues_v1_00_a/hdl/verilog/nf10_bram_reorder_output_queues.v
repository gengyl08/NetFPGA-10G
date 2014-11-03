/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        nf10_bram_output_queues.v
 *
 *  Library:
 *        hw/std/pcores/nf10_bram_output_queues_v1_00_a
 *
 *  Module:
 *        nf10_bram_output_queues
 *
 *  Author:
 *        Yilong Geng, James Hongyi Zeng
 *
 *  Description:
 *        BRAM Output queues
 *        Outputs have a parameterizable width
 *
 *  Copyright notice:
 *        Copyright (C) 2010, 2011 The Board of Trustees of The Leland Stanford
 *                                 Junior University
 *
 *  Licence:
 *        This file is part of the NetFPGA 10G development base package.
 *
 *        This file is free code: you can redistribute it and/or modify it under
 *        the terms of the GNU Lesser General Public License version 2.1 as
 *        published by the Free Software Foundation.
 *
 *        This package is distributed in the hope that it will be useful, but
 *        WITHOUT ANY WARRANTY; without even the implied warranty of
 *        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *        Lesser General Public License for more details.
 *
 *        You should have received a copy of the GNU Lesser General Public
 *        License along with the NetFPGA source package.  If not, see
 *        http://www.gnu.org/licenses/.
 *
 */

module nf10_bram_reorder_output_queues
#(
    // Master AXI Stream Data Width
    parameter C_M_AXIS_DATA_WIDTH=256,
    parameter C_S_AXIS_DATA_WIDTH=256,
    parameter C_M_AXIS_TUSER_WIDTH=128,
    parameter C_S_AXIS_TUSER_WIDTH=128,
    parameter NUM_QUEUES=5,
    parameter C_BASEADDR=32'hffffffff,
    parameter C_HIGHADDR=32'h0
)
(
    // Part 1: System side signals
    // Global Ports
    input axi_aclk,
    input axi_resetn,

    // Slave Stream Ports (interface to data path)
    input [C_S_AXIS_DATA_WIDTH - 1:0] s_axis_tdata,
    input [((C_S_AXIS_DATA_WIDTH / 8)) - 1:0] s_axis_tstrb,
    input [C_S_AXIS_TUSER_WIDTH-1:0] s_axis_tuser,
    input s_axis_tvalid,
    output s_axis_tready,
    input s_axis_tlast,

    // Master Stream Ports (interface to TX queues)
    output [C_M_AXIS_DATA_WIDTH - 1:0] m_axis_tdata_0,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0] m_axis_tstrb_0,
    output [C_M_AXIS_TUSER_WIDTH-1:0] m_axis_tuser_0,
    output  m_axis_tvalid_0,
    input m_axis_tready_0,
    output  m_axis_tlast_0,

    output [C_M_AXIS_DATA_WIDTH - 1:0] m_axis_tdata_1,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0] m_axis_tstrb_1,
    output [C_M_AXIS_TUSER_WIDTH-1:0] m_axis_tuser_1,
    output  m_axis_tvalid_1,
    input m_axis_tready_1,
    output  m_axis_tlast_1,

    output [C_M_AXIS_DATA_WIDTH - 1:0] m_axis_tdata_2,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0] m_axis_tstrb_2,
    output [C_M_AXIS_TUSER_WIDTH-1:0] m_axis_tuser_2,
    output  m_axis_tvalid_2,
    input m_axis_tready_2,
    output  m_axis_tlast_2,

    output [C_M_AXIS_DATA_WIDTH - 1:0] m_axis_tdata_3,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0] m_axis_tstrb_3,
    output [C_M_AXIS_TUSER_WIDTH-1:0] m_axis_tuser_3,
    output  m_axis_tvalid_3,
    input m_axis_tready_3,
    output  m_axis_tlast_3,

    output [C_M_AXIS_DATA_WIDTH - 1:0] m_axis_tdata_4,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0] m_axis_tstrb_4,
    output [C_M_AXIS_TUSER_WIDTH-1:0] m_axis_tuser_4,
    output  m_axis_tvalid_4,
    input m_axis_tready_4,
    output  m_axis_tlast_4,

    // axi lite control/status interface
    input          S_AXI_ACLK,
    input          S_AXI_ARESETN,
    input [31:0]   S_AXI_AWADDR,
    input          S_AXI_AWVALID,
    output         S_AXI_AWREADY,
    input [31:0]   S_AXI_WDATA,
    input [3:0]    S_AXI_WSTRB,
    input          S_AXI_WVALID,
    output         S_AXI_WREADY,
    output [1:0]   S_AXI_BRESP,
    output         S_AXI_BVALID,
    input          S_AXI_BREADY,
    input [31:0]   S_AXI_ARADDR,
    input          S_AXI_ARVALID,
    output         S_AXI_ARREADY,
    output [31:0]  S_AXI_RDATA,
    output [1:0]   S_AXI_RRESP,
    output         S_AXI_RVALID,
    input          S_AXI_RREADY
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

   localparam BUFFER_SIZE         = 32768; // Buffer size 32768B, around 20 packets
   localparam BUFFER_SIZE_WIDTH   = log2(BUFFER_SIZE/(C_M_AXIS_DATA_WIDTH/8));

   localparam MAX_PACKET_SIZE = 1600;
   localparam BUFFER_THRESHOLD = (BUFFER_SIZE-MAX_PACKET_SIZE)/(C_M_AXIS_DATA_WIDTH/8);

   localparam NUM_STATES = 3;
   localparam IDLE = 0;
   localparam WR_PKT = 1;
   localparam DROP = 2;

   localparam NUM_METADATA_STATES = 2;
   localparam WAIT_HEADER = 0;
   localparam WAIT_EOP = 1;

   // ------------- Regs/ wires -----------

   wire                             fifo_in_nearly_full;
   wire                             fifo_in_empty;
   reg                              fifo_in_rd_en;
   wire [C_M_AXIS_TUSER_WIDTH-1:0]  fifo_in_tuser;
   wire [C_M_AXIS_DATA_WIDTH-1:0]   fifo_in_tdata;
   wire [C_M_AXIS_DATA_WIDTH/8-1:0] fifo_in_tstrb;
   wire  	                    fifo_in_tlast;
   wire                             fifo_in_tvalid;

   reg [NUM_QUEUES-1:0]                nearly_full;
   wire [NUM_QUEUES-1:0]               nearly_full_fifo;
   wire [NUM_QUEUES-1:0]               empty;

   reg [NUM_QUEUES-1:0]                metadata_nearly_full;
   wire [NUM_QUEUES-1:0]               metadata_nearly_full_fifo;
   wire [NUM_QUEUES-1:0]               metadata_empty;

   wire [C_M_AXIS_TUSER_WIDTH-1:0]             fifo_out_tuser[NUM_QUEUES-1:0];
   wire [C_M_AXIS_DATA_WIDTH-1:0]        fifo_out_tdata[NUM_QUEUES-1:0];
   wire [((C_M_AXIS_DATA_WIDTH/8))-1:0]  fifo_out_tstrb[NUM_QUEUES-1:0];
   wire [NUM_QUEUES-1:0] 	           fifo_out_tlast;

   wire [NUM_QUEUES-1:0]               rd_en;
   reg [NUM_QUEUES-1:0]                wr_en;

   reg [NUM_QUEUES-1:0]                metadata_rd_en;
   reg [NUM_QUEUES-1:0]                metadata_wr_en;

   reg [NUM_QUEUES-1:0]          cur_queue;
   reg [NUM_QUEUES-1:0]          cur_queue_next;
   wire [NUM_QUEUES-1:0]         oq;

   reg [NUM_STATES-1:0]                state;
   reg [NUM_STATES-1:0]                state_next;

   reg [NUM_METADATA_STATES-1:0]       metadata_state[NUM_QUEUES-1:0];
   reg [NUM_METADATA_STATES-1:0]       metadata_state_next[NUM_QUEUES-1:0];

   reg								   first_word, first_word_next;

   reg [63:0] timestamp;

   // output_queues_regs

   wire [31:0] queues_num;
   wire        reset_drop_counts;
   reg [31:0] drop_count_0, drop_count_0_next;
   reg [31:0] drop_count_1, drop_count_1_next;
   reg [31:0] drop_count_2, drop_count_2_next;
   reg [31:0] drop_count_3, drop_count_3_next;
   reg [31:0] drop_count_4, drop_count_4_next;

   // ------------ Modules -------------

   fallthrough_small_fifo
   #( .WIDTH(C_M_AXIS_DATA_WIDTH+C_M_AXIS_TUSER_WIDTH+C_M_AXIS_DATA_WIDTH/8+1),
      .MAX_DEPTH_BITS(2)
    )
    input_fifo
    ( // Outputs
      .dout                         ({fifo_in_tlast, fifo_in_tuser, fifo_in_tstrb, fifo_in_tdata}),
      .full                         (),
      .nearly_full                  (fifo_in_nearly_full),
      .prog_full                    (),
      .empty                        (fifo_in_empty),
      // Inputs
      .din                          ({s_axis_tlast, s_axis_tuser, s_axis_tstrb, s_axis_tdata}),
      .wr_en                        (s_axis_tvalid & s_axis_tready),
      .rd_en                        (fifo_in_rd_en),
      .reset                        (~axi_resetn),
      .clk                          (axi_aclk));

   assign s_axis_tready = !fifo_in_nearly_full;

   generate
   genvar i;
   for(i=0; i<NUM_QUEUES; i=i+1) begin: output_queues
      fallthrough_small_fifo
        #( .WIDTH(C_M_AXIS_DATA_WIDTH+C_M_AXIS_DATA_WIDTH/8+1),
           .MAX_DEPTH_BITS(BUFFER_SIZE_WIDTH),
           .PROG_FULL_THRESHOLD(BUFFER_THRESHOLD))
      output_fifo
        (// Outputs
         .dout                           ({fifo_out_tlast[i], fifo_out_tstrb[i], fifo_out_tdata[i]}),
         .full                           (),
         .nearly_full                    (),
	 	 .prog_full                      (nearly_full_fifo[i]),
         .empty                          (empty[i]),
         // Inputs
         .din                            ({fifo_in_tlast, fifo_in_tstrb, fifo_in_tdata}),
         .wr_en                          (wr_en[i]),
         .rd_en                          (rd_en[i]),
         .reset                          (~axi_resetn),
         .clk                            (axi_aclk));

      fallthrough_small_fifo
        #( .WIDTH(C_M_AXIS_TUSER_WIDTH),
           .MAX_DEPTH_BITS(5))
      metadata_fifo
        (// Outputs
         .dout                           (fifo_out_tuser[i]),
         .full                           (),
         .nearly_full                    (metadata_nearly_full_fifo[i]),
	 	 .prog_full                      (),
         .empty                          (metadata_empty[i]),
         // Inputs
         .din                            ({timestamp, fifo_in_tuser[63:0]}),
         .wr_en                          (metadata_wr_en[i]),
         .rd_en                          (metadata_rd_en[i]),
         .reset                          (~axi_resetn),
         .clk                            (axi_aclk));

   always @(metadata_state[i], rd_en[i], fifo_out_tlast[i]) begin
        metadata_rd_en[i] = 1'b0;
        metadata_state_next[i] = metadata_state[i];
      	case(metadata_state[i])
      		WAIT_HEADER: begin
      			if(rd_en[i]) begin
      				metadata_state_next[i] = WAIT_EOP;
      				metadata_rd_en[i] = 1'b1;
      			end
      		end
      		WAIT_EOP: begin
      			if(rd_en[i] & fifo_out_tlast[i]) begin
      				metadata_state_next[i] = WAIT_HEADER;
      			end
      		end
        endcase
      end

      always @(posedge axi_aclk) begin
      	if(~axi_resetn) begin
         	metadata_state[i] <= WAIT_HEADER;
      	end
      	else begin
         	metadata_state[i] <= metadata_state_next[i];
      	end
      end
   end
   endgenerate

   output_queues_regs
      output_queues_regs_0
         (
          .queues_num(queues_num),
          .reset_drop_counts(reset_drop_counts),
          .drop_count_0(drop_count_0),
          .drop_count_1(drop_count_1),
          .drop_count_2(drop_count_2),
          .drop_count_3(drop_count_3),
          .drop_count_4(drop_count_4),
          .ACLK(S_AXI_ACLK),
          .ARESETN(S_AXI_ARESETN),
          .AWADDR(S_AXI_AWADDR),
          .AWVALID(S_AXI_AWVALID),
          .AWREADY(S_AXI_AWREADY),
          .WDATA(S_AXI_WDATA),
          .WSTRB(S_AXI_WSTRB),
          .WVALID(S_AXI_WVALID),
          .WREADY(S_AXI_WREADY),
          .BRESP(S_AXI_BRESP),
          .BVALID(S_AXI_BVALID),
          .BREADY(S_AXI_BREADY),
          .ARADDR(S_AXI_ARADDR),
          .ARVALID(S_AXI_ARVALID),
          .ARREADY(S_AXI_ARREADY),
          .RDATA(S_AXI_RDATA),
          .RRESP(S_AXI_RRESP),
          .RVALID(S_AXI_RVALID),
          .RREADY(S_AXI_RREADY)
         );

   always @(*) begin
      state_next     = state;
      cur_queue_next = cur_queue;
      wr_en          = 0;
      metadata_wr_en = 0;
      fifo_in_rd_en  = 0;
      first_word_next = first_word;

      drop_count_0_next = drop_count_0;
      drop_count_1_next = drop_count_1;
      drop_count_2_next = drop_count_2;
      drop_count_3_next = drop_count_3;
      drop_count_4_next = drop_count_4;

      case(state)

        /* cycle between input queues until one is not empty */
        IDLE: begin
           if(!fifo_in_empty) begin
              if(~|((nearly_full | metadata_nearly_full) & cur_queue)) begin // All interesting oqs are NOT _nearly_ full (able to fit in the maximum pacekt).
                  state_next = WR_PKT;
                  first_word_next = 1'b1;
              end
              else begin
              	  state_next = DROP;
                  case(cur_queue)
                     5'b00001: begin
                        drop_count_0_next = drop_count_0 + 1;
                     end
                     5'b00010: begin
                        drop_count_1_next = drop_count_1 + 1;
                     end
                     5'b00100: begin
                        drop_count_2_next = drop_count_2 + 1;
                     end
                     5'b01000: begin
                        drop_count_3_next = drop_count_3 + 1;
                     end
                     5'b10000: begin
                        drop_count_4_next = drop_count_4 + 1;
                     end
                  endcase
              end
           end
        end

        /* wait until eop */
        WR_PKT: begin
            if(!fifo_in_empty) begin
           	    fifo_in_rd_en = 1;
           		  first_word_next = 1'b0;
				        wr_en = cur_queue;
				        if(first_word) begin
					          metadata_wr_en = cur_queue;
				        end
				        if(fifo_in_tlast) begin
                    if(|(cur_queue & 5'b10000)) begin
                        cur_queue_next = 5'b00001;
                    end
                    else if(|((cur_queue >> queues_num) & 5'b00001)) begin
                        cur_queue_next = 5'b00001;
                    end
                    else begin
                        cur_queue_next = (cur_queue << 1);
                    end
					          state_next = IDLE;
				        end
            end
        end // case: WR_PKT

        DROP: begin
            if(!fifo_in_empty) begin
                fifo_in_rd_en = 1;
		            if (fifo_in_tlast) begin
                    if(|(cur_queue & 5'b10000)) begin
                        cur_queue_next = 5'b00001;
                    end
                    else if(|((cur_queue >> queues_num) & 5'b00001)) begin
                        cur_queue_next = 5'b00001;
                    end
                    else begin
                        cur_queue_next = (cur_queue << 1);
                    end
           	        state_next = IDLE;
		            end
            end
        end

      endcase // case(state)
   end // always @ (*)



   always @(posedge axi_aclk) begin
      if(~axi_resetn) begin
         state <= IDLE;
         cur_queue <= 1;
         first_word <= 0;

         timestamp <= 0;

         drop_count_0 <= 0;
         drop_count_1 <= 0;
         drop_count_2 <= 0;
         drop_count_3 <= 0;
         drop_count_4 <= 0;
      end
      else begin
         state <= state_next;
         cur_queue <= cur_queue_next;
         first_word <= first_word_next;

         timestamp <= timestamp + 1;

         if(reset_drop_counts) begin
            drop_count_0 <= 0;
            drop_count_1 <= 0;
            drop_count_2 <= 0;
            drop_count_3 <= 0;
            drop_count_4 <= 0;
         end
         else begin
            drop_count_0 <= drop_count_0_next;
            drop_count_1 <= drop_count_1_next;
            drop_count_2 <= drop_count_2_next;
            drop_count_3 <= drop_count_3_next;
            drop_count_4 <= drop_count_4_next;
         end
      end

      nearly_full <= nearly_full_fifo;
      metadata_nearly_full <= metadata_nearly_full_fifo;
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

  assign m_axis_tdata_4  = fifo_out_tdata[4];
   assign m_axis_tstrb_4   = fifo_out_tstrb[4];
   assign m_axis_tuser_4   = fifo_out_tuser[4];
   assign m_axis_tlast_4   = fifo_out_tlast[4];
   assign m_axis_tvalid_4  = ~empty[4];
   assign rd_en[4]       = m_axis_tready_4 & ~empty[4];

endmodule
