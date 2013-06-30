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
 *        fifomem
 *
 *  Author:
 *        Sam D'Amico
 *
 *  Description:
 *        Arbitrated FIFO to/from memory interface
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

//TODO: might want to use almost_full instead of full for memory, as it might
//clip when full and not notify FIFOs.

module FifoMem
#(
///////////////////////////////////////////////////////////////////////////////
// Parameter Definitions
///////////////////////////////////////////////////////////////////////////////
  // Width of AXI data bus in bytes
  parameter integer TDATA_WIDTH        = 32,
  parameter integer TUSER_WIDTH        = 128,
  parameter integer NUM_QUEUES         = 4,
  parameter integer QUEUE_ID_WIDTH     = 2,
  parameter integer NUM_MEM_INPUTS     = 6,
  parameter integer NUM_MEM_CHIPS      = 3,
  parameter integer MEM_WIDTH          = 36,
  parameter integer MEM_ADDR_WIDTH     = 19,
  parameter integer MEM_NUM_WORDS      = 524288,
  parameter integer QUEUE_SIZE         = MEM_NUM_WORDS/4
)
(
    input                          clk,
    input                          reset,
    input  [(QUEUE_ID_WIDTH-1):0]   read_queue_id,
    output [(QUEUE_ID_WIDTH-1):0]  read_data_queue_id,
    input                          read_data_ready,
    output [((8*TDATA_WIDTH+9)-1):0]  read_data,
    output                         read_data_valid,
    output [(NUM_QUEUES-1):0]  read_empty,
    output reg                     read_burst_state,


    input [(QUEUE_ID_WIDTH-1):0]   write_queue_id,
    input [((8*TDATA_WIDTH+9)-1):0]  write_data,
    input                          write_data_valid,
    output [(NUM_QUEUES-1):0]  write_full,
    output reg                     next_write_burst_state,

    //TODO: In theory these two signals should be used.
    //It's OK now because the the mem controller is
    //faster than the data path and there is no back
    //pressure from following stages.
    input                          sram_read_full,
    input                          sram_write_full,
    output reg [(MEM_WIDTH*NUM_MEM_INPUTS-1):0]       dout,
    output reg [(MEM_ADDR_WIDTH-1):0]  dout_addr,
    output reg                         dout_burst_ready,
    input  [(MEM_WIDTH*NUM_MEM_INPUTS-1):0]       din,
    input  [(NUM_MEM_CHIPS-1):0]                  din_valid,
    output reg [(MEM_ADDR_WIDTH-1):0]  din_addr,
    output reg                         din_ready,

    //signals from sram_regs
    input [18:0] base_addr_input_0,
    input [18:0] base_addr_input_1,
    input [18:0] base_addr_input_2,
    input [18:0] base_addr_input_3,
    input [18:0] bound_addr_input_0,
    input [18:0] bound_addr_input_1,
    input [18:0] bound_addr_input_2,
    input [18:0] bound_addr_input_3,
    output [18:0] tail_addr_0,
    output [18:0] tail_addr_1,
    output [18:0] tail_addr_2,
    output [18:0] tail_addr_3,
    input [31:0] replay_times_input,
    input replay_begin
);

reg [(MEM_ADDR_WIDTH-1):0] next_read_addr[(NUM_QUEUES-1):0];
reg [(MEM_ADDR_WIDTH-1):0] read_addr[(NUM_QUEUES-1):0];
reg [(MEM_ADDR_WIDTH-1):0] next_write_addr[(NUM_QUEUES-1):0];
reg [(MEM_ADDR_WIDTH-1):0] write_addr[(NUM_QUEUES-1):0];

reg next_read_burst_state;
reg write_burst_state;
wire read_mem_word_valid;
reg [(MEM_ADDR_WIDTH-1):0] next_din_addr;
reg next_din_ready;

wire [(MEM_WIDTH*NUM_MEM_INPUTS-1):0] next_dout;
reg [(MEM_ADDR_WIDTH-1):0] next_dout_addr;
reg next_dout_burst_ready;

reg [18:0] base_addr [3:0];
reg [18:0] bound_addr [3:0];
reg [31:0] replay_times [3:0];
reg [31:0] next_replay_times [3:0];

wire [18:0] base_addr_input [3:0];
wire [18:0] bound_addr_input [3:0];
wire [18:0] tail_addr [3:0];

assign base_addr_input[0] = base_addr_input_0;
assign base_addr_input[1] = base_addr_input_1;
assign base_addr_input[2] = base_addr_input_2;
assign base_addr_input[3] = base_addr_input_3;
assign bound_addr_input[0] = bound_addr_input_0;
assign bound_addr_input[1] = bound_addr_input_1;
assign bound_addr_input[2] = bound_addr_input_2;
assign bound_addr_input[3] = bound_addr_input_3;
assign tail_addr_0 = tail_addr[0];
assign tail_addr_1 = tail_addr[1];
assign tail_addr_2 = tail_addr[2];
assign tail_addr_3 = tail_addr[3];

localparam BURST_STATE_OFF = 1'b0;
localparam BURST_STATE_HALFWAY = 1'b1;

genvar i;

always @(posedge clk)
begin
    if(reset)
    begin
        read_burst_state <= BURST_STATE_OFF;
        write_burst_state <= BURST_STATE_OFF;
        dout <= {(MEM_WIDTH*NUM_MEM_INPUTS){1'b0}};
        dout_addr <= {(MEM_ADDR_WIDTH){1'b0}};
        dout_burst_ready <= 1'b0;
        din_addr <= {(MEM_ADDR_WIDTH){1'b0}};
        din_ready <= 1'b0;
        replay_times[0] <= replay_times_input;
        replay_times[1] <= replay_times_input;
        replay_times[2] <= replay_times_input;
        replay_times[3] <= replay_times_input;
    end
    else
    begin
        read_burst_state <= next_read_burst_state;
        write_burst_state <= next_write_burst_state;
        dout <= next_dout;
        dout_addr <= next_dout_addr;
        dout_burst_ready <= next_dout_burst_ready;
        din_addr <= next_din_addr;
        din_ready <= next_din_ready;
        if (!replay_begin)
        begin
            replay_times[0] <= replay_times_input;
            replay_times[1] <= replay_times_input;
            replay_times[2] <= replay_times_input;
            replay_times[3] <= replay_times_input;
        end
        else
        begin
            replay_times[0] <= next_replay_times[0];
            replay_times[1] <= next_replay_times[1];
            replay_times[2] <= next_replay_times[2];
            replay_times[3] <= next_replay_times[3];
        end
    end
end

wire  [(MEM_WIDTH*NUM_MEM_INPUTS-1):0]       din_merged;
wire [(NUM_MEM_CHIPS-1):0] din_merged_empty;
wire din_merged_valid;
generate
    for(i=0;i<NUM_MEM_CHIPS;i=i+1)
    begin : memreadfifos
        fallthrough_small_fifo
            #(.WIDTH(72), .MAX_DEPTH_BITS(2))
            fifo(.din(din[((i+1)*MEM_WIDTH*2-1):(i*MEM_WIDTH*2)]),
                 .wr_en(din_valid[i]),
                 .rd_en(din_merged_valid),
                 .dout(din_merged[((i+1)*MEM_WIDTH*2-1):(i*MEM_WIDTH*2)]),
                 .empty(din_merged_empty[i]),
                 .reset(reset),
                 .clk(clk)
                );
    end
endgenerate

generate
    for(i=0; i<4; i=i+1)
    begin: addr_assignment
        always @(posedge clk) begin
            if(reset) begin
                read_addr[i] <= base_addr_input[i];
                write_addr[i] <= base_addr_input[i];
                base_addr[i] <= base_addr_input[i];
                bound_addr[i] <= bound_addr_input[i];
            end
            else begin
                read_addr[i] <= next_read_addr[i];
                write_addr[i] <= next_write_addr[i];
            end
        end
    end
endgenerate

assign din_merged_valid = ((|din_merged_empty) == 0);
assign read_mem_word_valid = din_merged[8*TDATA_WIDTH+9+QUEUE_ID_WIDTH];
assign read_data_valid = din_merged_valid && read_mem_word_valid;
assign read_data = din_merged[((8*TDATA_WIDTH+9)-1):0];
assign read_data_queue_id = din_merged[((8*TDATA_WIDTH+9+QUEUE_ID_WIDTH)-1):(8*TDATA_WIDTH+9)];
assign next_dout[((8*TDATA_WIDTH+9)-1):0] = write_data;
assign next_dout[((8*TDATA_WIDTH+9+QUEUE_ID_WIDTH)-1):(8*TDATA_WIDTH+9)] = write_queue_id;
assign next_dout[8*TDATA_WIDTH+9+QUEUE_ID_WIDTH] = write_data_valid;
assign read_empty[0] = (read_addr[0] == write_addr[0]) || (replay_times[0] == 0);
assign read_empty[1] = (read_addr[1] == write_addr[1]) || (replay_times[1] == 0);
assign read_empty[2] = (read_addr[2] == write_addr[2]) || (replay_times[2] == 0);
assign read_empty[3] = (read_addr[3] == write_addr[3]) || (replay_times[3] == 0);
assign write_full[0] = (write_addr[0] == bound_addr[0]);
assign write_full[1] = (write_addr[1] == bound_addr[1]);
assign write_full[2] = (write_addr[2] == bound_addr[2]);
assign write_full[3] = (write_addr[3] == bound_addr[3]);
assign tail_addr[0] = write_addr[0];
assign tail_addr[1] = write_addr[1];
assign tail_addr[2] = write_addr[2];
assign tail_addr[3] = write_addr[3];

always @(read_addr[0],read_addr[1],read_addr[2],read_addr[3],write_addr[0],write_addr[1],write_addr[2],write_addr[3],
         replay_times[0],replay_times[1],replay_times[2],replay_times[3],read_data_ready,read_burst_state,replay_begin,base_addr[0],base_addr[1],base_addr[2],
         base_addr[3],write_data_valid,write_burst_state,write_full) begin

    next_read_burst_state = BURST_STATE_OFF;
    next_write_burst_state = BURST_STATE_OFF;
    next_din_ready = 1'b0;
    next_dout_burst_ready = 1'b0;
    next_dout_addr = {(MEM_ADDR_WIDTH){1'b0}};
    next_din_addr = {(MEM_ADDR_WIDTH){1'b0}};
    next_read_addr[0] = read_addr[0];
    next_read_addr[1] = read_addr[1];
    next_read_addr[2] = read_addr[2];
    next_read_addr[3] = read_addr[3];
    next_write_addr[0] = write_addr[0];
    next_write_addr[1] = write_addr[1];
    next_write_addr[2] = write_addr[2];
    next_write_addr[3] = write_addr[3];    
    next_replay_times[0] = replay_times[0];
    next_replay_times[1] = replay_times[1];
    next_replay_times[2] = replay_times[2];
    next_replay_times[3] = replay_times[3];
    
    if(read_data_ready && (read_burst_state == 0) && replay_begin && replay_times[read_queue_id] != 0)
    begin
        next_din_addr = read_addr[read_queue_id];
        next_din_ready = 1'b1;             
        next_read_addr[read_queue_id] = read_addr[read_queue_id] + 1;
        if (next_read_addr[read_queue_id] == write_addr[read_queue_id])
        begin
            next_read_addr[read_queue_id] = base_addr[read_queue_id];
            next_replay_times[read_queue_id] = replay_times[read_queue_id] - 1;
        end
        next_read_burst_state = BURST_STATE_HALFWAY; 
    end

    if(write_data_valid && (~write_burst_state))
    begin
        next_dout_addr = write_addr[write_queue_id];

        if(!write_full[write_queue_id])
       	begin
            next_dout_burst_ready = 1'b1;
            next_write_addr[write_queue_id] = write_addr[write_queue_id] + 1;
            next_write_burst_state = BURST_STATE_HALFWAY;
        end
    end

end

endmodule
