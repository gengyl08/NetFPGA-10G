/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        nf10_inter_pkt_delay.v
 *
 *  Library:
 *        hw/contrib/pcores/nf10_inter_pkt_delay_v1_00_a
 *
 *  Module:
 *        nf10_inter_pkt_delay
 *
 *  Author:
 *        Yilong Geng
 *
 *  Description:
 *        Produce delay on packets.
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

module nf10_delay
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
    output [C_M_AXIS_DATA_WIDTH - 1:0] m_axis_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0] m_axis_tstrb,
    output [C_M_AXIS_TUSER_WIDTH-1:0] m_axis_tuser,
    output reg m_axis_tvalid,
    input  m_axis_tready,
    output m_axis_tlast,

    // Slave Stream Ports (interface to RX queues)
    input [C_S_AXIS_DATA_WIDTH - 1:0] s_axis_tdata,
    input [((C_S_AXIS_DATA_WIDTH / 8)) - 1:0] s_axis_tstrb,
    input [C_S_AXIS_TUSER_WIDTH-1:0] s_axis_tuser,
    input  s_axis_tvalid,
    output s_axis_tready,
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
   localparam MODULE_HEADER      = 0;
   localparam IN_PACKET      = 1;

   //------------- Wires -----------------
   reg state;
   reg state_next;

   wire fifo_nearly_full;
   wire fifo_empty;

   assign s_axis_tready = ~fifo_nearly_full;

   wire [31:0] delay_length;

   reg [63:0] timestamp;

   // ------------ Modules ----------------

   fallthrough_small_fifo
        #( .WIDTH(C_M_AXIS_DATA_WIDTH+C_M_AXIS_TUSER_WIDTH+C_M_AXIS_DATA_WIDTH/8+1),
           .MAX_DEPTH_BITS(2))
      input_fifo
        (// Outputs
         .dout                           ({m_axis_tlast, m_axis_tuser, m_axis_tstrb, m_axis_tdata}),
         .full                           (),
         .nearly_full                    (fifo_nearly_full),
         .prog_full                      (),
         .empty                          (fifo_empty),
         // Inputs
         .din                            ({s_axis_tlast, s_axis_tuser, s_axis_tstrb, s_axis_tdata}),
         .wr_en                          (s_axis_tvalid & s_axis_tready),
         .rd_en                          (m_axis_tvalid & m_axis_tready),
         .reset                          (~axi_resetn),
         .clk                            (axi_aclk));

   delay_regs
      delay_regs_0
         (
          .delay_length(delay_length),
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

   // ------------- Logic ---------------

   always @(*) begin
      state_next = state;
      m_axis_tvalid = 0;

      case(state)
         MODULE_HEADER: begin
           if(~fifo_empty) begin
              if(timestamp > m_axis_tuser[127:64] + delay_length) begin
                 state_next = IN_PACKET;
              end
           end
         end

         IN_PACKET: begin
            if(~fifo_empty) begin
               m_axis_tvalid = 1;
               if(m_axis_tready & m_axis_tlast) begin
                  state_next = MODULE_HEADER;
               end
            end
         end
      endcase

      
   end // always @ (*)

   always @(posedge axi_aclk) begin
      if(~axi_resetn) begin
         state <= MODULE_HEADER;
         timestamp <= 0;
      end
      else begin
         state <= state_next;
         timestamp <= timestamp + 1;
      end
   end

endmodule
