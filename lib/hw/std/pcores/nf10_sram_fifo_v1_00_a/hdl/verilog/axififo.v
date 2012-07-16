/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        nf10_nic_output_port_lookup.v
 *
 *  Library:
 *        hw/std/pcores/nf10_sram_fifo
 *
 *  Module:
 *        axififo
 *
 *  Author:
 *        Sam D'Amico
 *
 *  Description:
 *        input AXI4-Stream to FIFO interface
 *
 *  Copyright notice:
 *        Copyright (C) 2010,2011 The Board of Trustees of The Leland Stanford
 *                                Junior University
 *
 *  Licence:
 *        This file is part of the NetFPGA 10G development base package.
 *
 *        This package is free software: you can redistribute it and/or modify
 *        it under the terms of the GNU Lesser General Public License as
 *        published by the Free Software Foundation, either version 3 of the
 *        License, or (at your option) any later version.
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


module AxiToFifo
#(
///////////////////////////////////////////////////////////////////////////////
// Parameter Definitions
///////////////////////////////////////////////////////////////////////////////
                    // Width of TID signals.
                    // Range: >= 1.
  parameter integer TID_WIDTH          = 4, 
                    // Width of AXI data bus in bytes
  parameter integer TDATA_WIDTH        = 32,
  parameter integer CROPPED_TDATA_WIDTH = 24,

                    // Width of TUSER in bits
  parameter integer TUSER_WIDTH        = 128,

  parameter integer TDEST_WIDTH        = 4,
  parameter integer NUM_QUEUES         = 4,
  parameter integer QUEUE_ID_WIDTH     = 2,
  parameter integer MEM_ADDR_WIDTH     = 19,
  parameter integer MEM_NUM_WORDS      = 524288,
  parameter integer QUEUE_SIZE         = MEM_NUM_WORDS/4,
  parameter integer MEM_WORD_BYTES_LOG2= 3
)
(
    input                           clk,
    input                           reset,
    input                           tvalid,
    output reg                      tready,
    input [((8*TDATA_WIDTH) - 1):0] tdata,
    input [(TDATA_WIDTH-1):0]       tstrb,
    input [(TDATA_WIDTH-1):0]       tkeep,
    input                           tlast,
    input [(TID_WIDTH-1):0]         tid,
    input [(TDEST_WIDTH-1):0]       tdest,
    input [(TUSER_WIDTH-1):0]       tuser,
    input                           memclk,
    input                           memreset,
    input                           rinc,
    output                          rempty,
    output                          r_almost_empty,
    output                          dout_valid,
    output [((8*CROPPED_TDATA_WIDTH+9)-1):0]  dout,
    input                           cal_done,
    input                           output_inc,
    output reg [31:0] input_fifo_cnt
);

wire wfull, w_almost_full;
reg winc;
reg [(QUEUE_ID_WIDTH-1):0]        latched_queue_id;
reg [(QUEUE_ID_WIDTH-1):0]        next_latched_queue_id;
reg [(MEM_ADDR_WIDTH-1):0]        mem_usage;
reg [(MEM_ADDR_WIDTH-1):0]        next_mem_usage;
reg [(MEM_ADDR_WIDTH-1):0]        prev_mem_usage;

reg mem_full;
reg next_packet_start;
reg packet_start;
reg next_allow_packet;
reg allow_packet;
reg next_dout_valid;
reg rinc_prev;
reg [31:0] next_input_fifo_cnt;

always @(posedge clk)
begin
    if(reset)
    begin
        mem_usage <= QUEUE_SIZE-1;
        prev_mem_usage <= QUEUE_SIZE-1;
        packet_start <= 1'b1;
        allow_packet <= 1'b0;
    end
    else
    begin 
        mem_usage <= next_mem_usage;
        prev_mem_usage <= mem_usage;
        packet_start <= next_packet_start;  
        allow_packet <= next_allow_packet; 
    end
end

always @(posedge clk)
begin
    if(reset)
        input_fifo_cnt <= 32'b0;
    else
        input_fifo_cnt <= next_input_fifo_cnt;
end


always @(posedge memclk)
begin
    if(memreset)
    begin
        rinc_prev <= 1'b0;
    end
    else
    begin
        rinc_prev <= rinc;
    end
end
reg [1:0] packing_state;

always @(*)
begin
    tready = 1'b0;
    winc = 1'b0;
    
    next_packet_start = packet_start;
    next_input_fifo_cnt = input_fifo_cnt;
    next_allow_packet = allow_packet;

    if(~w_almost_full && cal_done && (packing_state != 2'd3))
    begin
        tready = 1'b1;
        if(tvalid)
        begin
            next_input_fifo_cnt = input_fifo_cnt+1;

            if(allow_packet)
                winc = 1'b1;

            if(tlast)
                next_packet_start = 1'b1;
            else
                next_packet_start = 1'b0;
            if(packet_start)
            begin
                // Round up by 1 for safety (thus the > rather than >=)
                if(prev_mem_usage > (tuser[15:MEM_WORD_BYTES_LOG2]))
                begin
                    winc = 1'b1;
                    next_allow_packet = 1'b1;
                end
                else
                    next_allow_packet = 1'b0;
            end
        end        
    end

    if(winc && ~output_inc)
        next_mem_usage = mem_usage-1;
    else if(~winc && output_inc)
        next_mem_usage = mem_usage+1;
    else
        next_mem_usage = mem_usage;
end

// tdata0[191:0]
// tdata1[128:0], tdata0[255:192]
// tdata2[63:0], tdata1[255:129]
// tdata2[255:64]
// if tlast send last chunk of tdata with nothing else UNLESS there's
// something on the next cycle
// include 2-bit packet type ID for reassembly

reg [200:0] next_fifo_data;
reg [200:0] fifo_data;
reg [(8*TDATA_WIDTH-1):0] prev_tdata;
reg [1:0] next_packing_state;
reg prev_tlast;
reg winc_fifo, next_winc_fifo;
wire [4:0] tstrb_count;
reg [4:0] prev_tstrb_count;

assign tstrb_count[4] = tstrb[16];
assign tstrb_count[3] = (tstrb[8] && ~tstrb[16]) || tstrb[24];
assign tstrb_count[2] = (tstrb[4] && ~tstrb[8]) || (tstrb[12] && ~tstrb[16]) || (tstrb[20] && ~tstrb[24]) || (tstrb[28]);
assign tstrb_count[1] = (^{tstrb[2],tstrb[4],tstrb[6],tstrb[8],tstrb[10],tstrb[12],tstrb[14],tstrb[16],tstrb[18],tstrb[20],tstrb[22],tstrb[24],tstrb[26],tstrb[28],tstrb[30]});
assign tstrb_count[0] = ~(^tstrb);

always @(posedge clk)
begin
    if(reset)
    begin
        prev_tdata <= {(8*TDATA_WIDTH){1'b0}};
        packing_state <= 2'b0;
        prev_tlast <= 1'b0;
	fifo_data <= 0;
	winc_fifo <= 0;
        prev_tstrb_count <= 0;
    end
    else
    begin
        if(winc)
        begin
            prev_tdata <= tdata;
            prev_tlast <= tlast;
            prev_tstrb_count <= tstrb_count;
        end
        else
        begin
            prev_tdata <= prev_tdata;
            prev_tlast <= prev_tlast;
            prev_tstrb_count <= prev_tstrb_count;
        end
        packing_state <= next_packing_state;
	fifo_data <= next_fifo_data;
	winc_fifo <= next_winc_fifo;
    end
end


always @(*)
begin
    case(packing_state)
        0: next_fifo_data = {tdata[191:0], prev_tstrb_count, packing_state, tlast, winc /*formerly 1'b1*/};
	1: next_fifo_data = {tdata[127:0], prev_tdata[255:192], prev_tstrb_count, packing_state, tlast, winc};
	2: next_fifo_data = {tdata[63:0], prev_tdata[255:128], prev_tstrb_count, packing_state, tlast, winc};
	3: next_fifo_data = {prev_tdata[255:64], prev_tstrb_count, packing_state, 1'b0, winc};
    endcase
    
    next_winc_fifo = 1'b0;	

    if(winc || (packing_state == 2'd3))
    begin
        next_packing_state = packing_state + 2'b1;
        next_winc_fifo = 1'b1;
    end
    else if(prev_tlast && ((packing_state == 2'd1) || (packing_state == 2'd2)))
    begin
	next_packing_state = 2'd0;
        next_winc_fifo = 1'b1;
    end
    else
        next_packing_state = packing_state;
end

async_fifo fifo(reset, clk, memclk, fifo_data, winc_fifo, rinc, dout, wfull, w_almost_full,rempty,r_almost_empty,dout_valid);


endmodule
