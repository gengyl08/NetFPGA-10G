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
 *        fifoaxi
 *
 *  Author:
 *        Sam D'Amico
 *
 *  Description:
 *        Output Fifo to output AXI4-Stream interface
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


module FifoToAxi
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
  parameter integer TUSER_WIDTH        = 64,

  parameter integer TDEST_WIDTH        = 4,
  parameter integer NUM_QUEUES         = 4,
  parameter integer QUEUE_ID_WIDTH     = 2
)
(
    input                            clk,
    input                            reset,
    output reg                       tvalid,
    input                            tready,
    output reg [((8*TDATA_WIDTH) - 1):0] tdata,
    output wire [(TDATA_WIDTH-1):0]       tstrb,
    output reg [(TDATA_WIDTH-1):0]       tkeep,
    output reg                       tlast,
    output reg [(TID_WIDTH-1):0]     tid,
    output reg [(TDEST_WIDTH-1):0]   tdest,
    output [(TUSER_WIDTH-1):0]       tuser,
    input                            memclk,
    input                            memreset,
    input                            din_valid,
    input [((8*TDATA_WIDTH+9)-1):0]    din,
    output                           w_almost_full,
    output                           wfull,
    input                            cal_done,
    output reg                       rinc,
    output reg [31:0] output_fifo_cnt
);

wire rempty, r_almost_empty;
reg winc;
wire rvalid;
reg [31:0] next_output_fifo_cnt;
reg reassembly_dout_valid;

always @(posedge clk)
begin
    if(reset)
        output_fifo_cnt <= 32'b0;
    else
        output_fifo_cnt <= next_output_fifo_cnt;
end

always @(*)
begin
    tvalid = 1'b0;
    tid = {(TID_WIDTH){1'b0}};
    tdest = {(TDEST_WIDTH){1'b0}};
    rinc = 1'b0;
    tkeep = {(TDATA_WIDTH){1'b1}};
    next_output_fifo_cnt = output_fifo_cnt;

    if(reassembly_dout_valid)
    begin
        tvalid = 1'b1;
        if(tready)
        begin
            rinc = 1'b1;
            next_output_fifo_cnt = output_fifo_cnt + 1;
        end
    end
end

assign tuser = 0;

wire [(8*CROPPED_TDATA_WIDTH+9-1):0] fifo_data;
reg [(8*CROPPED_TDATA_WIDTH+9-1):0] prev_fifo_data;
wire [1:0] packing_state = fifo_data[3:2];
wire [4:0] tstrb_count = fifo_data[8:4];
wire [TDATA_WIDTH-1:0] tstrb_onehot;

always @(posedge clk)
begin
    if(reset)
    begin
        prev_fifo_data <= {(8*CROPPED_TDATA_WIDTH+9){1'b0}};
    end
    else
    begin
        if(rinc  || (~rempty && (fifo_data[3:2] == 2'b0)))
            prev_fifo_data <= fifo_data;
        else
            prev_fifo_data <= prev_fifo_data;
    end
end

assign tstrb_onehot = (1<<tstrb_count);
assign tstrb = tstrb_onehot | (tstrb>>1);

always @(*)
begin
    reassembly_dout_valid = prev_fifo_data[0] && ~rempty && (packing_state != 2'b0);
    
    case(packing_state)
        default:
        begin
            tdata = 0;
            tlast = 0;
        end
        1: 
        begin
            tdata = {fifo_data[72:9], prev_fifo_data[200:9]};
            tlast = prev_fifo_data[1]; 
        end 
	2:
        begin
            tdata = {fifo_data[136:9], prev_fifo_data[200:73]};
            tlast = prev_fifo_data[1]; 
        end
	3: 
        begin
            tdata = {fifo_data[200:9], prev_fifo_data[200:137]};
            tlast = prev_fifo_data[1];
        end
    endcase	
end


async_fifo fifo(reset, memclk, clk, din, din_valid, rinc || (~rempty && (fifo_data[3:2] == 2'b0)), fifo_data, wfull, ,rempty,r_almost_empty,rvalid, w_almost_full);


endmodule
