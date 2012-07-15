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
 *        fifoaxiarbiter
 *
 *  Author:
 *        Sam D'Amico
 *
 *  Description:
 *        Arbiter for output AXI4-Stream Interfaces
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


module FifoAxiArbiter
#(
///////////////////////////////////////////////////////////////////////////////
// Parameter Definitions
///////////////////////////////////////////////////////////////////////////////
  // Width of AXI data bus in bytes
  parameter integer TDATA_WIDTH        = 32,
  // Width of TUSER in bits
  parameter integer TUSER_WIDTH        = 64,
  parameter integer NUM_QUEUES         = 4,
  parameter integer QUEUE_ID_WIDTH     = 2
)
(
    input                           clk,
    input                           reset,
    
    input                           memclk,
    output reg [NUM_QUEUES-1:0]     burst_inc,
    input [NUM_QUEUES-1:0]          full,
    input                           read_burst,
    input                           din_valid,
    input  [((8*TDATA_WIDTH+9)-1):0]  din,
    input [QUEUE_ID_WIDTH-1:0]          din_queue_id,
    input  [NUM_QUEUES-1:0]         mem_queue_empty,
    output reg [QUEUE_ID_WIDTH-1:0] queue_id,
    output reg [((NUM_QUEUES*(8*TDATA_WIDTH+9))-1):0]  dout,
    output reg [NUM_QUEUES-1:0]     dout_valid
);

    reg [QUEUE_ID_WIDTH-1:0] next_queue_id;
    reg [NUM_QUEUES-1:0] prev_mem_queue_empty;
    reg [NUM_QUEUES-1:0] prev_inc;
    reg [NUM_QUEUES-1:0] inc;
    wire [NUM_QUEUES-1:0] queues_ready;
    wire [NUM_QUEUES-1:0] queue_in_use;
    reg [(((8*TDATA_WIDTH+9))-1):0] prev_din;
    reg [NUM_QUEUES-1:0] next_dout_valid;
    reg [QUEUE_ID_WIDTH-1:0] prev_din_queue_id;

    always @(posedge memclk)
    begin
        if(reset)
        begin
            queue_id <= {2'b00, 2'b00};
            prev_mem_queue_empty <= {(NUM_QUEUES){1'b1}};
            prev_inc <= {(NUM_QUEUES){1'b0}};
            prev_din <= {((8*TDATA_WIDTH+9)){1'b0}};
            dout_valid <= {(NUM_QUEUES){1'b0}};
            prev_din_queue_id <= {(QUEUE_ID_WIDTH){1'b0}};
        end
        else
        begin
            queue_id <= next_queue_id;
            prev_mem_queue_empty <= mem_queue_empty;
            prev_inc <= inc;
            prev_din <= din;
            dout_valid <= next_dout_valid;
            prev_din_queue_id <= din_queue_id;
        end
    end
    
    assign queues_ready = (~mem_queue_empty) & (~full); 
    assign queue_in_use = 1 << queue_id;
    always @(*)
    begin
        inc = 4'b0;
        burst_inc = 4'b0;
        next_dout_valid = 4'b0;
        dout = {(NUM_QUEUES*(8*TDATA_WIDTH+9)){1'b0}};
        //next_inc = 4'b0;
        next_queue_id = queue_id;
	
        if(read_burst || (~prev_inc[queue_id] && (mem_queue_empty[queue_id] || full[queue_id])))
        begin
            if(queue_id == 2'd0)
            begin
            if(~mem_queue_empty[1] && ~full[1])
            begin
                next_queue_id = 2'd1;
            end
            else if(~mem_queue_empty[2] && ~full[2])
            begin
                next_queue_id = 2'd2;
            end
            else if(~mem_queue_empty[3] && ~full[3])
            begin
                next_queue_id = 2'd3;
            end
            end
            else if(queue_id == 2'd1)
            begin
      
            if(~mem_queue_empty[2] && ~full[2])
            begin
                next_queue_id = 2'd2;
            end
            else if(~mem_queue_empty[3] && ~full[3])
            begin
                next_queue_id = 2'd3;
            end
            else if(~mem_queue_empty[0] && ~full[0])
            begin
                next_queue_id = 2'd0;
            end
            end
            else if(queue_id == 2'd2)
            begin
      
            if(~mem_queue_empty[3] && ~full[3])
            begin
                next_queue_id = 2'd3;
            end
            else if(~mem_queue_empty[0] && ~full[0])
            begin
                next_queue_id = 2'd0;
            end
            else if(~mem_queue_empty[1] && ~full[1])
            begin
                next_queue_id = 2'd1;
            end
            end
            else if(queue_id == 2'd3)
            begin
      
            if(~mem_queue_empty[0] && ~full[0])
            begin
                next_queue_id = 2'd0;
            end
            else if(~mem_queue_empty[1] && ~full[1])
            begin
                next_queue_id = 2'd1;
            end
            else if(~mem_queue_empty[2] && ~full[2])
            begin
                next_queue_id = 2'd2;
            end
            end
        end

        inc[queue_id] = (~mem_queue_empty[queue_id] && ~full[queue_id]);
        burst_inc[queue_id] = (inc[queue_id]/* && ~read_burst*/);

        next_dout_valid[din_queue_id] = (/*~prev_mem_queue_empty[queue_id] &&*/ din_valid);
        //dout[((8*TDATA_WIDTH+TUSER_WIDTH+1)*(1)-1):((8*TDATA_WIDTH+TUSER_WIDTH+1)*0)] = prev_din;
        
        case(prev_din_queue_id)
            0:
                dout[((8*TDATA_WIDTH+9)*(1)-1):((8*TDATA_WIDTH+9)*0)] = prev_din;
            1:
                dout[((8*TDATA_WIDTH+9)*(2)-1):((8*TDATA_WIDTH+9)*1)] = prev_din;
            2:
                dout[((8*TDATA_WIDTH+9)*(3)-1):((8*TDATA_WIDTH+9)*2)] = prev_din;
            3:
                dout[((8*TDATA_WIDTH+9)*(4)-1):((8*TDATA_WIDTH+9)*3)] = prev_din;
        endcase
        
    end

endmodule
