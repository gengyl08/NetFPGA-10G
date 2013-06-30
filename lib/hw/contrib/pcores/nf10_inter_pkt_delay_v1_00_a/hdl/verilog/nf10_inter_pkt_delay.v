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
 *        Produce delay between packets.
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

module nf10_inter_pkt_delay
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
   localparam MODULE_HEADER      = 0;
   localparam IN_PACKET      = 1;

   //------------- Wires -----------------
   reg state;
   reg state_next;

   reg fifo_wr_en;
   reg fifo_rd_en;

   wire [255:0] tdata_fifo_dout;
   wire [31:0] tstrb_fifo_dout;
   wire [127:0] tuser_fifo_dout;
   wire tlast_fifo_dout;

   reg [255:0] tdata_buffer, tdata_buffer_next;
   reg [127:0] tuser_buffer, tuser_buffer_next;
   reg [31:0] tstrb_buffer, tstrb_buffer_next;
   reg tlast_buffer, tlast_buffer_next;
   reg tvalid_buffer, tvalid_buffer_next;

   reg [63:0] timecount;
   reg [31:0] delay_length;
   reg [63:0] timestamp, timestamp_next;
   wire [31:0] delay_length_reg;
   reg [63:0] pkt_leave_time, pkt_leave_time_next;
   reg pkt_leave_time_ready, pkt_leave_time_ready_next;
   wire [63:0] timecount_add_delay_length;
   assign timecount_add_delay_length = timecount + delay_length;
   wire [63:0] timestamp_add_delay_length;
   assign timestamp_add_delay_length = timestamp + delay_length;

   // ------------ Modules ----------------

   fallthrough_small_fifo
        #( .WIDTH(C_M_AXIS_DATA_WIDTH+C_M_AXIS_TUSER_WIDTH+C_M_AXIS_DATA_WIDTH/8+1),
           .MAX_DEPTH_BITS(2))
      input_fifo
        (// Outputs
         .dout                           ({tlast_fifo_dout, tuser_fifo_dout, tstrb_fifo_dout, tdata_fifo_dout}),
         .full                           (),
         .nearly_full                    (fifo_nearly_full),
         .prog_full                      (),
         .empty                          (fifo_empty),
         // Inputs
         .din                            ({s_axis_tlast, s_axis_tuser, s_axis_tstrb, s_axis_tdata}),
         .wr_en                          (fifo_wr_en),
         .rd_en                          (fifo_rd_en),
         .reset                          (~axi_resetn || host_reset),
         .clk                            (axi_aclk));

   delay_regs
      delay_regs_0
         (
          .delay_enable(delay_enable),
          .delay_mux(delay_use_reg),
          .delay_length(delay_length_reg),
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

   // ------------- Logic ---------------

   always @(*) begin

      timestamp_next = timestamp;
      delay_length = 0;
      pkt_leave_time_next = pkt_leave_time;
      pkt_leave_time_ready_next = pkt_leave_time_ready;

      fifo_wr_en = 0;
      fifo_rd_en = 0;

      state_next = state;
      tdata_buffer_next = tdata_buffer;
      tstrb_buffer_next = tstrb_buffer;
      tuser_buffer_next = tuser_buffer;
      tlast_buffer_next = tlast_buffer;
      tvalid_buffer_next = tvalid_buffer;

      s_axis_tready = 0;
      m_axis_tdata = 0;
      m_axis_tstrb = 0;
      m_axis_tuser = 0;
      m_axis_tlast = 0;
      m_axis_tvalid = 0;

      if(!delay_enable) begin
         s_axis_tready = m_axis_tready;
         m_axis_tdata = s_axis_tdata;
         m_axis_tstrb = s_axis_tstrb;
         m_axis_tuser = s_axis_tuser;
         m_axis_tlast = s_axis_tlast;
         m_axis_tvalid = s_axis_tvalid;
      end
      else begin
         s_axis_tready = !fifo_nearly_full;
         fifo_wr_en = s_axis_tvalid && s_axis_tready;

         if(delay_use_reg) begin
            delay_length = delay_length_reg;

            m_axis_tlast = tlast_fifo_dout;
            m_axis_tuser = tuser_fifo_dout;
            m_axis_tstrb = tstrb_fifo_dout;
            m_axis_tdata = tdata_fifo_dout;

            // State machine for delay_length in the register.
            case(state)
               MODULE_HEADER: begin
                  if(!fifo_empty && (timecount >= pkt_leave_time)) begin
                     m_axis_tvalid = 1;
                     if(m_axis_tready) begin
                        fifo_rd_en = 1;
                        pkt_leave_time_next = timecount_add_delay_length;
                        if(!m_axis_tlast) begin
                           state_next = IN_PACKET;
                        end
                     end
                  end
               end
               IN_PACKET: begin
                  if(!fifo_empty) begin
                     m_axis_tvalid = 1;
                     if(m_axis_tready) begin
                        fifo_rd_en = 1;
                        if(m_axis_tlast) begin
                           state_next = MODULE_HEADER;
                        end
                     end
                  end
               end
            endcase

         end
         else begin
            delay_length = tdata_fifo_dout[31:0];

            // Take care of output
            if(tvalid_buffer) begin
               if(tlast_buffer) begin
                  m_axis_tdata[223:0] = tdata_buffer[255:32];
                  m_axis_tdata[255:224] = 0;
                  m_axis_tstrb[27:0] = tstrb_buffer[31:4];
                  m_axis_tstrb[31:28] = 0;
                  m_axis_tuser = tuser_buffer;
                  m_axis_tlast = 1;
               end
               else if(!fifo_empty) begin
                  m_axis_tdata[223:0] = tdata_buffer[255:32];
                  m_axis_tdata[255:224] = tdata_fifo_dout[31:0];
                  m_axis_tstrb[27:0] = tstrb_buffer[31:4];
                  m_axis_tstrb[31:28] = tstrb_fifo_dout[3:0];
                  m_axis_tuser = tuser_buffer;
                  m_axis_tlast = tlast_fifo_dout && !tstrb_fifo_dout[4];
               end
            end

            // State machine for delay_length in the header
            case(state)
               MODULE_HEADER: begin
                  if(!pkt_leave_time_ready && !fifo_empty) begin
                     pkt_leave_time_next = timestamp_add_delay_length;
                     pkt_leave_time_ready_next = 1;
                  end

                  if(tvalid_buffer && pkt_leave_time_ready && (timecount >= pkt_leave_time)) begin
                     if(tlast_buffer || !fifo_empty) begin

                        m_axis_tvalid = 1;
                        if(m_axis_tready) begin
                           timestamp_next = timecount;
                           if(m_axis_tlast) begin
                              if(tlast_buffer && !fifo_empty) begin
                                 pkt_leave_time_next = timecount_add_delay_length;
                                 pkt_leave_time_ready_next = 1;
                              end
                              else begin
                                 pkt_leave_time_ready_next = 0;
                              end
                           end
                           else begin
                              state_next = IN_PACKET;
                              pkt_leave_time_ready_next = 0;
                           end
                        end

                     end
                  end
               end

               IN_PACKET: begin
                  if(tvalid_buffer && (tlast_buffer || !fifo_empty)) begin
                     m_axis_tvalid = 1;
                     if(m_axis_tready && m_axis_tlast) begin
                        state_next = MODULE_HEADER;
                        if(tlast_buffer && !fifo_empty) begin
                           pkt_leave_time_next = timestamp_add_delay_length;
                           pkt_leave_time_ready_next = 1;
                        end
                     end
                  end
               end

            endcase

            // Take care of the buffer
            if(!tvalid_buffer) begin
               if(!fifo_empty) begin
                  tlast_buffer_next = tlast_fifo_dout;
                  tuser_buffer_next = tuser_fifo_dout;
                  tstrb_buffer_next = tstrb_fifo_dout;
                  tdata_buffer_next = tdata_fifo_dout;
                  tvalid_buffer_next = 1;
                  fifo_rd_en = 1;
               end
            end
            else begin
               if(m_axis_tvalid && m_axis_tready) begin
                  if(!fifo_empty) begin
                     tlast_buffer_next = tlast_fifo_dout;
                     tuser_buffer_next = tuser_fifo_dout;
                     tstrb_buffer_next = tstrb_fifo_dout;
                     tdata_buffer_next = tdata_fifo_dout;
                     tvalid_buffer_next = !tlast_fifo_dout || tstrb_fifo_dout[4];
                     fifo_rd_en = 1;
                  end
                  else begin
                     tdata_buffer_next = 0;
                     tstrb_buffer_next = 0;
                     tuser_buffer_next = 0;
                     tlast_buffer_next = 0;
                     tvalid_buffer_next = 0;
                  end
               end
            end

         end

      end
      
   end // always @ (*)

   always @(posedge axi_aclk) begin
      if(~axi_resetn || host_reset) begin
         state <= MODULE_HEADER;
         tdata_buffer <= 0;
         tstrb_buffer <= 0;
         tuser_buffer <= 0;
         tlast_buffer <= 0;
         tvalid_buffer <= 0;
         timecount <= 0;
         timestamp <= 0;
         pkt_leave_time <= 0;
         pkt_leave_time_ready <= 0;
      end
      else begin
         state <= state_next;
         tdata_buffer <= tdata_buffer_next;
         tstrb_buffer <= tstrb_buffer_next;
         tuser_buffer <= tuser_buffer_next;
         tlast_buffer <= tlast_buffer_next;
         tvalid_buffer <= tvalid_buffer_next;
         timecount <= timecount + 1;
         timestamp <= timestamp_next;
         pkt_leave_time <= pkt_leave_time_next;
         pkt_leave_time_ready <= pkt_leave_time_ready_next;
      end
   end

endmodule
