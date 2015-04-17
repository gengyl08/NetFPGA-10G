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
 *        axififoarbiter
 *
 *  Author:
 *        Sam D'Amico
 *
 *  Description:
 *        Arbiter for input AXI4-Stream Interfaces
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



module AxiFifoArbiter
#(
///////////////////////////////////////////////////////////////////////////////
// Parameter Definitions
///////////////////////////////////////////////////////////////////////////////
  // Width of AXI data bus in bytes
  parameter integer TDATA_WIDTH        = 32,
  // Width of TUSER in bits
  parameter integer TUSER_WIDTH        = 128,
  parameter integer NUM_QUEUES         = 4,
  parameter integer QUEUE_ID_WIDTH     = 2
)
(
    input                           clk,
    input                           reset,
    
    input                           memclk,
    output reg [NUM_QUEUES-1:0]     inc,
    input  [NUM_QUEUES-1:0]         empty,
    input                           write_burst,
    input  [NUM_QUEUES-1:0]         din_valid,
    input  [(NUM_QUEUES*(8*TDATA_WIDTH+9)-1):0]  din,
    input [NUM_QUEUES-1:0]         mem_queue_full,
    output reg [QUEUE_ID_WIDTH-1:0] queue_id,
    output reg [((8*TDATA_WIDTH+9)-1):0]  dout,
    output reg                      dout_valid
);

    reg [QUEUE_ID_WIDTH-1:0] next_queue_id_1;
    reg [QUEUE_ID_WIDTH-1:0] next_queue_id_2;
    reg [((8*TDATA_WIDTH+9)-1):0] next_dout;
    reg next_dout_valid;
    //reg [NUM_QUEUES-1:0] prev_empty;
    reg [NUM_QUEUES-1:0] prev_inc;
    always @(posedge memclk)
    begin
        if(reset)
        begin
            {queue_id, next_queue_id_1} <= {2'b00, 2'b00};
            //prev_queue_id <= {(QUEUE_ID_WIDTH){1'b0}};
            //prev_empty <= {(NUM_QUEUES){1'b1}};
            prev_inc <= {(NUM_QUEUES){1'b0}};
            dout <= {(8*TDATA_WIDTH+9){1'b0}};
            dout_valid <= 1'b0;
        end
        else
        begin
            {queue_id, next_queue_id_1} <= {next_queue_id_1, next_queue_id_2};
            //prev_queue_id <= queue_id;
            //prev_empty <= empty;
            prev_inc <= inc;
            dout <= next_dout;
            dout_valid <= next_dout_valid;
        end
    end

    always @(*)
    begin
        inc = 4'b0;
        next_queue_id_2 = next_queue_id_1;

        if(write_burst || (~prev_inc[next_queue_id_1] && empty[next_queue_id_1]))
	begin
            if(next_queue_id_1 == 2'd0)
            begin
	    if(~empty[1] && ~mem_queue_full[1])
	    begin
               next_queue_id_2 = 2'd1;
	    end
	    else if(~empty[2] && ~mem_queue_full[2])
	    begin
	        next_queue_id_2 = 2'd2;
	    end
	    else if(~empty[3] && ~mem_queue_full[3])
	    begin
                next_queue_id_2 = 2'd3;
	    end
            end

if(next_queue_id_1 == 2'd1)
            begin
	   
            if(~empty[2] && ~mem_queue_full[2])
	    begin
               next_queue_id_2 = 2'd2;
	    end
	    else if(~empty[3] && ~mem_queue_full[3])
	    begin
	        next_queue_id_2 = 2'd3;
	    end
	    else if(~empty[0] && ~mem_queue_full[0])
	    begin
                next_queue_id_2 = 2'd0;
	    end
            end

if(next_queue_id_1 == 2'd2)
            begin
	    if(~empty[3] && ~mem_queue_full[3])
	    begin
               next_queue_id_2 = 2'd3;
	    end
            else if(~empty[0] && ~mem_queue_full[0])
	    begin
               next_queue_id_2 = 2'd0;
	    end
	    else if(~empty[1] && ~mem_queue_full[1])
	    begin
	        next_queue_id_2 = 2'd1;
	    end
	    
            end

if(next_queue_id_1 == 2'd3)
            begin
	    if(~empty[0] && ~mem_queue_full[0])
	    begin
               next_queue_id_2 = 2'd0;
	    end
            else if(~empty[1] && ~mem_queue_full[1])
	    begin
               next_queue_id_2 = 2'd1;
	    end
	    else if(~empty[2] && ~mem_queue_full[2])
	    begin
	        next_queue_id_2 = 2'd2;
	    end
	    
            end
        end

        // TODO: is this appropriate, or do we want to inc on the current queue ID
        // ALSO check fifoaxiarb..
	inc[next_queue_id_1] = din_valid[next_queue_id_1] && ((~empty[next_queue_id_1]/* || write_burst*/) && ~mem_queue_full[next_queue_id_1]);
        /*inc[next_queue_id] = (~empty[next_queue_id] && ~mem_queue_full[next_queue_id]);*/

        // NOTE: changed to prev_inc to attempt to remove problem where random
        // bytes get dropped
        next_dout_valid = /*prev_inc[prev_queue_id] || */(din_valid[next_queue_id_1] && ~empty[next_queue_id_1]);
        
        case(next_queue_id_1)
            0:
                next_dout = din[((8*TDATA_WIDTH+9)*(1)-1):((8*TDATA_WIDTH+9)*0)];
            1:
                next_dout = din[((8*TDATA_WIDTH+9)*(2)-1):((8*TDATA_WIDTH+9)*1)];
            2:
                next_dout = din[((8*TDATA_WIDTH+9)*(3)-1):((8*TDATA_WIDTH+9)*2)];
            3:
                next_dout = din[((8*TDATA_WIDTH+9)*(4)-1):((8*TDATA_WIDTH+9)*3)];
        endcase
        
    end

endmodule
