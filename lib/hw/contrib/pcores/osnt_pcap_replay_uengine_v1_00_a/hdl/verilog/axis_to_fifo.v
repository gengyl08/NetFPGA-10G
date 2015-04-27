/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        axis_to_fifo.v
 *
 *  Library:
 *        hw/osnt/pcores/nf10_pcap_replay_uengine_v1_00_a
 *
 *  Module:
 *        axis_to_fifo
 *
 *  Author:
 *        Muhammad Shahbaz
 *
 *  Description:
 *
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

module axis_to_fifo
#(
    //Master AXI Stream Data Width
    parameter C_S_AXIS_DATA_WIDTH  				= 256,
    parameter C_S_AXIS_TUSER_WIDTH 				= 128, 
    parameter FIFO_DATA_WIDTH      				= 144, // FIFO width is (1/(2*n) of AXIS width)
		parameter NUM_QUEUES       		 				= 4,
		parameter NUM_QUEUES_BITS 						= log2(NUM_QUEUES),
		parameter DST_PORT_POS         				= 24
)
(
    // Global Ports
    input                                 axi_aclk,
    input                                 axi_aresetn,
    input                                 fifo_clk,

    // AXI Stream Ports
    input [C_S_AXIS_DATA_WIDTH-1:0]       s_axis_tdata,
    input [(C_S_AXIS_DATA_WIDTH/8)-1:0]   s_axis_tstrb,
    input [C_S_AXIS_TUSER_WIDTH-1:0]      s_axis_tuser,
    input                                 s_axis_tvalid,
    output                                s_axis_tready,
    input                                 s_axis_tlast,

    // FIFO Ports
    input                                 fifo_rd_en,
    output [FIFO_DATA_WIDTH-1:0]          fifo_dout,
		output [NUM_QUEUES_BITS-1:0]          fifo_dout_qid,
    output                                fifo_empty,

    // control signals
    input [31:0] split_ratio_0,
    input [31:0] split_ratio_1,
    input [31:0] split_ratio_2
);

  // -- Local Functions
  function integer log2;
    input integer number;
    begin
       log2=0;
       while(2**log2<number) begin
          log2=log2+1;
       end
    end
  endfunction

  // -- Internal Parameters
  localparam WR_TUSER_BITS = 0;
  localparam WR_PKT_BITS   = 1;
	
	localparam C_S_AXIS_PACKED_DATA_WIDTH = C_S_AXIS_DATA_WIDTH+C_S_AXIS_DATA_WIDTH/8; 

  // -- Signals
	
  reg                                       state;
  reg                                       next_state;

  reg                                       ififo_rd_en;
  wire                                      ififo_nearly_full;
  wire                                      ififo_empty;
  wire  [C_S_AXIS_DATA_WIDTH-1:0]           ififo_tdata;
  wire  [C_S_AXIS_TUSER_WIDTH-1:0]          ififo_tuser;
  wire  [C_S_AXIS_DATA_WIDTH/8-1:0]         ififo_tstrb;
  wire                                      ififo_tlast;

  reg                                       fifo_wr_en;
  reg   [C_S_AXIS_DATA_WIDTH-1:0]           fifo_din;
  reg   [C_S_AXIS_DATA_WIDTH/8-1:0]         fifo_din_strb;
  wire   [C_S_AXIS_DATA_WIDTH/8:0]         	fifo_din_strb_c;
	wire  [C_S_AXIS_PACKED_DATA_WIDTH-1:0]    fifo_din_packed;
  reg   [NUM_QUEUES_BITS-1:0]           		fifo_din_qid_0;
  reg   [NUM_QUEUES_BITS-1:0]               fifo_din_qid_1;
	reg   [NUM_QUEUES_BITS-1:0]           		fifo_din_qid_r;
  wire                                      fifo_full;

  reg [63:0]                                timestamp;
  reg [31:0]                                lfsr;
	
	// -- Assignments
  assign fifo_din_packed = {fifo_din_strb, fifo_din};
  
  assign fifo_din_strb_c = ((ififo_tstrb+1)>>1);
	
  assign s_axis_tready = !ififo_nearly_full;

  // -- Modules and Logic
  fallthrough_small_fifo #(.WIDTH(C_S_AXIS_DATA_WIDTH+C_S_AXIS_TUSER_WIDTH+C_S_AXIS_DATA_WIDTH/8+1), .MAX_DEPTH_BITS(2))
    input_fifo_inst
      ( .din         ({s_axis_tlast, s_axis_tuser, s_axis_tstrb, s_axis_tdata}),
        .wr_en       (s_axis_tready && s_axis_tvalid),
        .rd_en       (ififo_rd_en),
        .dout        ({ififo_tlast, ififo_tuser, ififo_tstrb, ififo_tdata}),
        .full        (),
        .prog_full   (),
        .nearly_full (ififo_nearly_full),
        .empty       (ififo_empty),
        .reset       (!axi_aresetn),
        .clk         (axi_aclk)
      );

  // ---- AXI (Side) State Machine [Combinational]
  always @ * begin
    next_state = state;

    ififo_rd_en = 0;

    fifo_din = ififo_tdata;
    fifo_din_strb = ~ififo_tstrb;
    fifo_din_qid_0 = fifo_din_qid_r;
    fifo_din_qid_1 = fifo_din_qid_r;
    fifo_wr_en = 0;

    case (state)
      WR_TUSER_BITS: begin // Assuming TDATA_WIDTH > TUSER_WIDTH
        if (!ififo_empty && !fifo_full) begin
          fifo_din = {{(C_S_AXIS_DATA_WIDTH-128){1'b0}}, timestamp, ififo_tuser[63:0]};
          fifo_din_strb = {(C_S_AXIS_DATA_WIDTH/8){1'b0}};	
					fifo_wr_en = 1;

          if(lfsr <= split_ratio_0) begin
            fifo_din_qid_0 = 0;
            fifo_din_qid_1 = 0;
          end
          else if(lfsr <= split_ratio_1) begin
            fifo_din_qid_0 = 1;
            fifo_din_qid_1 = 1;
          end
          else if(lfsr <= split_ratio_2) begin
            fifo_din_qid_0 = 2;
            fifo_din_qid_1 = 2;
          end
          else begin
            fifo_din_qid_0 = 3;
            fifo_din_qid_1 = 3;
          end

          next_state = WR_PKT_BITS;
        end
      end

      WR_PKT_BITS: begin
        if (!ififo_empty && !fifo_full) begin
          fifo_wr_en = 1;
          ififo_rd_en = 1;

          if (ififo_tlast) begin
          	fifo_din_strb = fifo_din_strb_c[(C_S_AXIS_DATA_WIDTH/8)-1:0];

            // Set the qid of each memory line different from the true qid =
            // to mark the end of packet. This mark can be used because there
            // are always even numbers of memory lines for a packet. This is done
            // for the sram to drop packets.
            fifo_din_qid_1 = fifo_din_qid_r + 1;
            next_state = WR_TUSER_BITS;
          end
        end
      end
    endcase
  end

  // ---- Primary State Machine [Sequential]
  always @ (posedge axi_aclk) begin
    if(!axi_aresetn) begin
      state <= WR_TUSER_BITS;
			fifo_din_qid_r <= {NUM_QUEUES_BITS{1'b0}};

      timestamp <= 0;
      lfsr <= 32'hffffffff;
    end
    else begin
      state <= next_state;
			fifo_din_qid_r <= fifo_din_qid_0;

      timestamp <= timestamp + 1;
      lfsr[30:0] <= lfsr[31:1];
      lfsr[31] <= lfsr[31] ^ lfsr[6] ^ lfsr[4] ^ lfsr[2] ^ lfsr[1] ^lfsr[0];
    end
  end

  // --- Async FIFO
  xil_async_fifo #(.DIN_WIDTH(C_S_AXIS_PACKED_DATA_WIDTH), .DOUT_WIDTH(FIFO_DATA_WIDTH))
    async_fifo_inst
      ( .din          (fifo_din_packed),
        .wr_en        (fifo_wr_en),
        .rd_en        (fifo_rd_en),
        .dout         (fifo_dout),
        .full         (fifo_full),
        .empty        (fifo_empty),
        .rst          (!axi_aresetn),
        .wr_clk       (axi_aclk),
        .rd_clk       (fifo_clk)
      );
			
  // --- Async QID FIFO
  xil_async_fifo #(.DIN_WIDTH(2*NUM_QUEUES_BITS), .DOUT_WIDTH(NUM_QUEUES_BITS))
    async_qid_fifo_inst
      ( .din          ({fifo_din_qid_1, fifo_din_qid_0}),
        .wr_en        (fifo_wr_en),
        .rd_en        (fifo_rd_en),
        .dout         (fifo_dout_qid),
        .full         (),
        .empty        (),
        .rst          (!axi_aresetn),
        .wr_clk       (axi_aclk),
        .rd_clk       (fifo_clk)
      );

endmodule

