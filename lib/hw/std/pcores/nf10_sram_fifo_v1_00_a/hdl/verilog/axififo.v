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
  parameter integer TDATA_WIDTH        = 8,
                    // Width of TUSER in bits
  parameter integer TUSER_WIDTH        = 128,

  parameter integer TDEST_WIDTH        = 4,
  parameter integer NUM_QUEUES         = 5,
  parameter integer QUEUE_ID_WIDTH     = 3,
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
    output [((8*TDATA_WIDTH+1+4)-1):0]  dout,
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
        packet_start <= 1'b1;
        allow_packet <= 1'b0;
    end
    else
    begin 
        mem_usage <= next_mem_usage;
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
        //dout_valid <= 1'b0;
    end
    else
    begin
        rinc_prev <= rinc;
        //dout_valid <= next_dout_valid;
    end
end

always @(*)
begin
    tready = 1'b0;
    winc = 1'b0;
    
    next_packet_start = packet_start;
    next_input_fifo_cnt = input_fifo_cnt;
    next_allow_packet = allow_packet;

    if(~wfull && cal_done)
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
                if(mem_usage > (tuser[15:MEM_WORD_BYTES_LOG2]))
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

/*always @(*)
begin
  dout_valid = 1'b0;
  if(rinc)
    dout_valid = 1'b1;    
end*/

//small_async_fifo #(.DSIZE(8*TDATA_WIDTH + TUSER_WIDTH + 1),.ASIZE(5),.ALMOST_FULL_SIZE(30),.ALMOST_EMPTY_SIZE(1)) fifo(wfull,w_almost_full,{tdata, tuser, tlast},winc,clk,~reset,dout,rempty,r_almost_empty,rinc,memclk,~memreset);
async_fifo fifo(reset, clk, memclk, {3'b0, tuser[27:24], tdata, tlast}, winc, rinc, dout, wfull, w_almost_full,rempty,r_almost_empty,dout_valid);


endmodule
