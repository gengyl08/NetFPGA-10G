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
                    // Width of TUSER in bits
  parameter integer TUSER_WIDTH        = 128,

  parameter integer TDEST_WIDTH        = 4,
  parameter integer NUM_QUEUES         = 4,
  parameter integer QUEUE_ID_WIDTH     = 2
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
    output [((8*TDATA_WIDTH+TUSER_WIDTH+1)-1):0]  dout,
    input                           cal_done,
    output reg [31:0] input_fifo_cnt
);

wire wfull, w_almost_full;
reg winc;
reg [(TDEST_WIDTH+TID_WIDTH-1):0] last_tid_tdest;
reg [(TDEST_WIDTH+TID_WIDTH-1):0] next_last_tid_tdest;
reg [(QUEUE_ID_WIDTH-1):0]        latched_queue_id;
reg [(QUEUE_ID_WIDTH-1):0]        next_latched_queue_id;
reg next_dout_valid;
reg rinc_prev;
reg [31:0] next_input_fifo_cnt;

always @(posedge clk)
begin
    if(reset)
    begin
        last_tid_tdest <= 0; //{((TDEST_WIDTH+TID_WIDTH){1'b0}};
        latched_queue_id <= 0; //{((QUEUE_ID_WIDTH){1'b0}};
        
    end
    else
    begin 
        last_tid_tdest <= next_last_tid_tdest;
        latched_queue_id <= next_latched_queue_id;
        
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
    next_last_tid_tdest = last_tid_tdest;
    next_latched_queue_id = latched_queue_id;
    next_input_fifo_cnt = input_fifo_cnt;
    if(~wfull && cal_done)
    begin
        tready = 1'b1;
        if(tvalid)
        begin
            next_input_fifo_cnt = input_fifo_cnt+1;
            
            winc = 1'b1;
        end
        // TODO: dubiously necessary stuff below
        // We're on a new packet boundary - check tuser bits for destination queue
        if(last_tid_tdest != {tid, tdest})
        begin
            next_last_tid_tdest = {tid, tdest};
            next_latched_queue_id = tuser[1:0];
        end
    end
end

/*always @(*)
begin
  dout_valid = 1'b0;
  if(rinc)
    dout_valid = 1'b1;    
end*/

//small_async_fifo #(.DSIZE(8*TDATA_WIDTH + TUSER_WIDTH + 1),.ASIZE(5),.ALMOST_FULL_SIZE(30),.ALMOST_EMPTY_SIZE(1)) fifo(wfull,w_almost_full,{tdata, tuser, tlast},winc,clk,~reset,dout,rempty,r_almost_empty,rinc,memclk,~memreset);

async_fifo fifo(reset, clk, memclk, {tdata, tuser, tlast}, winc, rinc, dout, wfull, w_almost_full,rempty,r_almost_empty,dout_valid);


endmodule
