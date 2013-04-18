/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        nf10_rate_limiter.v
 *
 *  Library:
 *        hw/contrib/pcores/nf10_rate_limiter_v1_00_a
 *
 *  Module:
 *        nf10_rate_limiter
 *
 *  Author:
 *        Yilong Geng
 *
 *  Description:
 *        Limits the rate at which packets pass through.
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

module nf10_rate_limiter
#(
    //Master AXI Stream Data Width
    parameter C_M_AXIS_DATA_WIDTH=256,
    parameter C_S_AXIS_DATA_WIDTH=256,
    parameter C_M_AXIS_TUSER_WIDTH=128,
    parameter C_S_AXIS_TUSER_WIDTH=128,
    parameter C_BASEADDR=32'hffffffff,
    parameter C_HIGHADDR=32'h0
)
(
    // Global Ports
    input axi_aclk,
    input axi_resetn,

    // Master Stream Ports (interface to data path)
    output reg [C_M_AXIS_DATA_WIDTH - 1:0] m_axis_tdata,
    output reg [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0] m_axis_tstrb,
    output reg [C_M_AXIS_TUSER_WIDTH-1:0] m_axis_tuser,
    output reg m_axis_tvalid,
    input  m_axis_tready,
    output reg m_axis_tlast,

    // Slave Stream Ports (interface to RX queues)
    input [C_S_AXIS_DATA_WIDTH - 1:0] s_axis_tdata,
    input [((C_S_AXIS_DATA_WIDTH / 8)) - 1:0] s_axis_tstrb,
    input [C_S_AXIS_TUSER_WIDTH-1:0] s_axis_tuser,
    input  s_axis_tvalid,
    output reg s_axis_tready,
    input  s_axis_tlast,

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

   // ------------ Internal Params --------
   localparam WAIT_FOR_PKT       = 0;
   localparam READ_PKT           = 1;
   localparam WAIT_INTER_PKT_GAP = 2;


   //------------- Wires -----------------
   reg [1:0] state;
   reg [1:0] state_next;

   reg [C_M_AXIS_DATA_WIDTH+C_M_AXIS_TUSER_WIDTH+C_M_AXIS_DATA_WIDTH/8:0] fifo_din;
   wire [C_M_AXIS_DATA_WIDTH+C_M_AXIS_TUSER_WIDTH+C_M_AXIS_DATA_WIDTH/8:0] fifo_dout;
   reg fifo_rd_en;
   reg fifo_wr_en;

   wire [31:0] throughput_shift;
   wire rate_limiter_enable;

   reg [31:0] count, count_next;

   // ------------ Modules ----------------

   fallthrough_small_fifo
        #( .WIDTH(C_M_AXIS_DATA_WIDTH+C_M_AXIS_TUSER_WIDTH+C_M_AXIS_DATA_WIDTH/8+1),
           .MAX_DEPTH_BITS(2))
      input_fifo
        (// Outputs
         .dout                           (fifo_dout),
         .full                           (),
         .nearly_full                    (fifo_nearly_full),
         .prog_full                      (),
         .empty                          (fifo_empty),
         // Inputs
         .din                            (fifo_din),
         .wr_en                          (s_axis_tvalid & ~fifo_nearly_full),
         .rd_en                          (fifo_rd_en),
         .reset                          (~axi_resetn || host_reset),
         .clk                            (axi_aclk));

   rate_limiter_regs
      rate_limiter_regs
         (
          .throughput_shift(throughput_shift),
          .rate_limiter_enable(rate_limiter_enable),
          .host_reset(host_reset),
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

   // ------------- Logic ----------------

   always @(*) begin
      m_axis_tdata = 0;
      m_axis_tuser = 0;
      m_axis_tstrb = 0;
      m_axis_tlast = 0;
      m_axis_tvalid = 0;

      state_next = state;
      count_next = count;

      fifo_rd_en = 0;
      fifo_wr_en = 0;

      if(!rate_limiter_enable) begin
         m_axis_tdata = s_axis_tdata;
         m_axis_tuser = s_axis_tuser;
         m_axis_tstrb = s_axis_tstrb;
         m_axis_tlast = s_axis_tlast;
         m_axis_tvalid = s_axis_tvalid;
         s_axis_tready = m_axis_tready;
         fifo_wr_en = 0;
         fifo_din = 0;
      end
      else begin
         fifo_din = {s_axis_tlast, s_axis_tuser, s_axis_tstrb, s_axis_tdata};
         {m_axis_tlast, m_axis_tuser, m_axis_tstrb, m_axis_tdata} = fifo_dout;
         s_axis_tready = !fifo_nearly_full;
         fifo_wr_en = s_axis_tvalid && s_axis_tready;

         case(state)
            WAIT_FOR_PKT: begin
               if(!fifo_empty) begin
                  m_axis_tvalid = 1;

                  if(m_axis_tready) begin
                     fifo_rd_en = 1;
                     if(m_axis_tlast) begin
                        count_next = (count + 1) << throughput_shift;
                        state_next = WAIT_INTER_PKT_GAP;
                     end
                     else begin
                        count_next = count + 1;
                     end
                  end

               end
            end

            WAIT_INTER_PKT_GAP: begin
               if(count > 1) begin
                  count_next = count - 1;
               end
               else begin
                  count_next = 0;
                  state_next = WAIT_FOR_PKT;
               end
            end
         endcase
      end

   end // always @ (*)

   always @(posedge axi_aclk) begin
      if(~axi_resetn || host_reset) begin
	 state <= WAIT_FOR_PKT;
         count <= 0;
      end
      else begin
	 state <= state_next;
         count <= count_next;
      end
   end

endmodule // output_port_lookup
