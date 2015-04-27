/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        fifo_to_axis.v
 *
 *  Library:
 *        hw/osnt/pcores/nf10_pcap_replay_uengine_v1_00_a
 *
 *  Module:
 *        fifo_to_axis
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

module fifo_to_axis
#(
    //Master AXI Stream Data Width
    parameter C_M_AXIS_DATA_WIDTH  = 256,
    parameter C_M_AXIS_TUSER_WIDTH = 128,
    parameter FIFO_DATA_WIDTH      = 144
)
(
    // Global Ports
    input                                           axi_aclk,
    input                                           axi_aresetn,
    input                                           fifo_clk,

    // FIFO Ports
    input                                           fifo_wr_en,
    input [FIFO_DATA_WIDTH-1:0]                     fifo_din,
    output                                          fifo_full,
    output                                          fifo_prog_full,		

    // AXI Stream Ports
    output reg [C_M_AXIS_DATA_WIDTH-1:0]            m_axis_tdata,
    output reg [((C_M_AXIS_DATA_WIDTH/8))-1:0]      m_axis_tstrb,
    output reg [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_tuser,
    output reg                                      m_axis_tvalid,
    input                                           m_axis_tready,
    output reg                                      m_axis_tlast
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
  localparam RD_TUSER_BITS = 0;
  localparam RD_PKT_BITS   = 1;
	
	localparam C_M_AXIS_PACKED_DATA_WIDTH = C_M_AXIS_DATA_WIDTH+C_M_AXIS_DATA_WIDTH/8; 

  // -- Signals
	genvar																		i;
	
	reg																				sw_rst_r;
	
  reg                                       state;
  reg                                       next_state;

  reg                                       fifo_rd_en;
  wire   [C_M_AXIS_DATA_WIDTH-1:0]          fifo_dout;
  wire   [C_M_AXIS_DATA_WIDTH/8-1:0]        fifo_dout_strb;
  wire                                      fifo_empty;
	wire   [C_M_AXIS_PACKED_DATA_WIDTH-1:0]   fifo_dout_packed;

  reg    [C_M_AXIS_TUSER_WIDTH-1:0]         axis_tuser_c;
  reg    [C_M_AXIS_TUSER_WIDTH-1:0]         axis_tuser_r;
  
  wire [(C_M_AXIS_DATA_WIDTH/8):0]  axis_tstrb_c;
	
	// -- Assignments
	assign {fifo_dout_strb, fifo_dout} = fifo_dout_packed;

	assign axis_tstrb_c = (fifo_dout_strb<<1)-1;

  // -- Modules and Logic
  xil_async_fifo #(.DOUT_WIDTH(C_M_AXIS_PACKED_DATA_WIDTH), .DIN_WIDTH(FIFO_DATA_WIDTH))
    async_fifo_inst
      ( .din          (fifo_din),
        .wr_en        (fifo_wr_en),
        .rd_en        (fifo_rd_en),
        .dout         (fifo_dout_packed),
        .full         (fifo_full),
				.prog_full		(fifo_prog_full),
        .empty        (fifo_empty),
        .rst          (!axi_aresetn),
        .wr_clk       (fifo_clk),
        .rd_clk       (axi_aclk)
      );

  // ---- AXI (Side) State Machine [Combinational]
  always @ * begin
    next_state = state;
    axis_tuser_c = axis_tuser_r;

    m_axis_tdata = fifo_dout;
    m_axis_tstrb = ~fifo_dout_strb;
    m_axis_tuser = axis_tuser_r;
    m_axis_tvalid = 0;
    m_axis_tlast = 0;

    fifo_rd_en = 0;

    case (state)
      RD_TUSER_BITS: begin
        if (!fifo_empty) begin 
					// Note: Assuming that TDATA_WIDTH > TUSER_WIDTH
          axis_tuser_c = fifo_dout[C_M_AXIS_TUSER_WIDTH-1:0]; 
          fifo_rd_en = 1;

          next_state = RD_PKT_BITS;
        end
      end
			
      RD_PKT_BITS: begin
        if (!fifo_empty) begin
          m_axis_tvalid = 1;

          if (m_axis_tready) begin
            fifo_rd_en = 1;

            if (fifo_dout_strb != {(C_M_AXIS_DATA_WIDTH/8){1'b0}}) begin
              m_axis_tlast = 1;
              m_axis_tstrb = axis_tstrb_c[(C_M_AXIS_DATA_WIDTH/8)-1:0];
              next_state = RD_TUSER_BITS;
            end
          end
        end
      end
    endcase
  end

  // ---- Primary State Machine [Sequential]
  always @ (posedge axi_aclk) begin
    if(!axi_aresetn) begin
      state <= RD_TUSER_BITS;
      axis_tuser_r <= {C_M_AXIS_TUSER_WIDTH{1'b0}};
    end
    else begin
      state <= next_state;
      axis_tuser_r <= axis_tuser_c;
    end
  end
	
endmodule

