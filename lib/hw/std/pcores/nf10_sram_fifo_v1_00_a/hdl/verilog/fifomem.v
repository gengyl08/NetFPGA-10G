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
    output reg [(QUEUE_ID_WIDTH-1):0]  read_data_queue_id,
    input                          read_data_ready,
    output reg [((8*TDATA_WIDTH+9)-1):0]  read_data,
    output                         read_data_valid,
    output reg [(NUM_QUEUES-1):0]  read_empty,
    output reg                     read_burst_state,


    input [(QUEUE_ID_WIDTH-1):0]   write_queue_id,
    input [((8*TDATA_WIDTH+9)-1):0]  write_data,
    input                          write_data_valid,
    output reg [(NUM_QUEUES-1):0]  write_full,
    output reg                     next_write_burst_state,

    input                          sram_read_full,
    input                          sram_write_full,
    output reg [(MEM_WIDTH*NUM_MEM_INPUTS-1):0]       dout,
    output reg [(MEM_ADDR_WIDTH-1):0]  dout_addr,
    output reg                         dout_burst_ready,
    input  [(MEM_WIDTH*NUM_MEM_INPUTS-1):0]       din,
    input  [(NUM_MEM_CHIPS-1):0]                  din_valid,
    output reg [(MEM_ADDR_WIDTH-1):0]  din_addr,
    output reg                         din_ready
);

reg [(MEM_ADDR_WIDTH-3):0] next_num_used[(NUM_QUEUES-1):0];
reg [(MEM_ADDR_WIDTH-3):0] num_used[(NUM_QUEUES-1):0];
reg [(MEM_ADDR_WIDTH-1):0] next_read_addr[(NUM_QUEUES-1):0];
reg [(MEM_ADDR_WIDTH-1):0] read_addr[(NUM_QUEUES-1):0];
reg [(MEM_ADDR_WIDTH-1):0] next_write_addr[(NUM_QUEUES-1):0];
reg [(MEM_ADDR_WIDTH-1):0] write_addr[(NUM_QUEUES-1):0];
reg next_read_data_valid;
reg read_data_valid_internal;
reg next_read_burst_state;
reg write_burst_state;
reg dout_ready;
reg read_mem_word_valid;
reg [(MEM_ADDR_WIDTH-1):0] next_din_addr;
reg next_din_ready;

reg [(MEM_WIDTH*NUM_MEM_INPUTS-1):0] next_dout;
reg [(MEM_ADDR_WIDTH-1):0] next_dout_addr;
reg                        next_dout_burst_ready;
reg [(QUEUE_ID_WIDTH-1):0] prev_write_queue_id;
reg [(NUM_QUEUES-1):0] next_read_empty;
reg [(NUM_QUEUES-1):0] next_write_full;


reg [31:0] next_before_mem_cnt;
reg [31:0] next_after_mem_cnt;

reg before_mem_cnt_inc, after_mem_cnt_inc;
reg next_before_mem_cnt_inc, next_after_mem_cnt_inc;



localparam BURST_STATE_OFF = 1'b0;
localparam BURST_STATE_HALFWAY = 1'b1;

genvar i;

always @(posedge clk)
begin
    if(reset)
    begin
        read_burst_state <= BURST_STATE_OFF;
        write_burst_state <= BURST_STATE_OFF;
        prev_write_queue_id <= {(QUEUE_ID_WIDTH){1'b0}};
        dout <= {(MEM_WIDTH*NUM_MEM_INPUTS){1'b0}};
        dout_addr <= {(MEM_ADDR_WIDTH){1'b0}};
        dout_burst_ready <= 1'b0;
        write_full <= {(NUM_QUEUES){1'b0}};
        din_addr <= {(MEM_ADDR_WIDTH){1'b0}};
        din_ready <= 1'b0;
    end
    else
    begin
        read_burst_state <= next_read_burst_state;
        write_burst_state <= next_write_burst_state;
        prev_write_queue_id <= write_queue_id;
        dout <= next_dout;
        dout_addr <= next_dout_addr;
        dout_burst_ready <= next_dout_burst_ready;
        din_addr <= next_din_addr;
        din_ready <= next_din_ready;
        write_full <= next_write_full;
    end
end

generate
    for(i=0;i<NUM_QUEUES;i=i+1)
    begin : memqueues
        always @(posedge clk)
        begin
            if(reset)
            begin
                read_addr[i] <= ({(MEM_ADDR_WIDTH){1'b0}}+(MEM_NUM_WORDS>>2)*i);
                write_addr[i] <= ({(MEM_ADDR_WIDTH){1'b0}}+(MEM_NUM_WORDS>>2)*i);
                num_used[i] <= {(MEM_ADDR_WIDTH-2){1'b0}};
            end
            else
            begin
                read_addr[i] <= next_read_addr[i];
                write_addr[i] <= next_write_addr[i];
                num_used[i] <= next_num_used[i];
            end
        end
    end
endgenerate

always @(posedge clk)
begin
    
    if(reset)
    begin
        read_data_valid_internal <= 1'b0;
    end
    else
    begin        
        read_data_valid_internal <= next_read_data_valid;
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

assign din_merged_valid = ((|din_merged_empty) == 0);

assign read_data_valid = din_merged_valid && read_mem_word_valid;

reg rw_same_queue;

always @(din or din_merged or read_queue_id or write_queue_id or read_addr[0] or read_addr[1] or read_addr[2] or read_addr[3] or write_addr[0] or write_addr[1] or write_addr[2] or write_addr[3] or num_used[0] or  num_used[1] or num_used[2] or num_used[3] or read_burst_state or write_burst_state or read_data_valid or write_data_valid or write_data or dout_ready or dout_burst_ready or sram_read_full or sram_write_full or read_data_ready)
begin
    next_read_burst_state = BURST_STATE_OFF;
    next_write_burst_state = BURST_STATE_OFF;
    next_din_ready = 1'b0;
    dout_ready = 1'b0;
    next_dout_addr = {(MEM_ADDR_WIDTH){1'b0}};
    next_din_addr = {(MEM_ADDR_WIDTH){1'b0}};
    read_data = din_merged[((8*TDATA_WIDTH+9)-1):0];
    read_data_queue_id = din_merged[((8*TDATA_WIDTH+9+QUEUE_ID_WIDTH)-1):(8*TDATA_WIDTH+9)];
    next_dout[((8*TDATA_WIDTH+9)-1):0] = write_data;
    next_dout[((8*TDATA_WIDTH+9+QUEUE_ID_WIDTH)-1):(8*TDATA_WIDTH+9)] = write_queue_id;
    next_dout[8*TDATA_WIDTH+9+QUEUE_ID_WIDTH] = write_data_valid;
    read_mem_word_valid = din_merged[8*TDATA_WIDTH+9+QUEUE_ID_WIDTH];

    next_read_data_valid = 1'b0;
    
    next_num_used[0] = num_used[0];
    next_num_used[1] = num_used[1];
    next_num_used[2] = num_used[2];
    next_num_used[3] = num_used[3];
    
    // TODO: SRAM read and write full signals
    // only seems to matter before calibration completes
    if(read_data_ready && (read_burst_state == 0) /*&& ~read_empty*/)
    begin
        if(read_queue_id == 2'd0)
        begin
            next_din_addr = read_addr[0];
            next_read_addr[1] = read_addr[1];
            next_read_addr[2] = read_addr[2];
            next_read_addr[3] = read_addr[3];
            if(!read_empty[0])
            begin
                next_din_ready = 1'b1;            
                next_read_data_valid = 1'b1; 


                next_read_addr[0][MEM_ADDR_WIDTH-1:MEM_ADDR_WIDTH-QUEUE_ID_WIDTH] = 2'd0;
                next_read_addr[0][MEM_ADDR_WIDTH-QUEUE_ID_WIDTH-1:0] = read_addr[0][(MEM_ADDR_WIDTH-QUEUE_ID_WIDTH-1):0]+17'b1;
                if(read_burst_state == BURST_STATE_OFF)
                    next_read_burst_state = BURST_STATE_HALFWAY;
            end
            else
            begin
                next_read_addr[0] = read_addr[0];
            end
        end
            else if(read_queue_id == 2'd1)
            begin
                next_din_addr = read_addr[1];
                next_read_addr[0] = read_addr[0];
                next_read_addr[2] = read_addr[2];
                next_read_addr[3] = read_addr[3];
                if(!read_empty[1])
                begin
                    next_din_ready = 1'b1;            
                    next_read_data_valid = 1'b1;


                    next_read_addr[1][MEM_ADDR_WIDTH-1:MEM_ADDR_WIDTH-QUEUE_ID_WIDTH] = 2'd1;
                    next_read_addr[1][MEM_ADDR_WIDTH-QUEUE_ID_WIDTH-1:0] = read_addr[1][(MEM_ADDR_WIDTH-QUEUE_ID_WIDTH-1):0]+17'b1;
                    if(read_burst_state == BURST_STATE_OFF)
                        next_read_burst_state = BURST_STATE_HALFWAY;
                end
                else
                begin
                    next_read_addr[1] = read_addr[1];
                end
            end
            else if(read_queue_id == 2'd2)
            begin
                next_din_addr = read_addr[2];
                next_read_addr[0] = read_addr[0];
                next_read_addr[1] = read_addr[1];
                next_read_addr[3] = read_addr[3];

                if(!read_empty[2])
                begin
                    next_din_ready = 1'b1;            
                    next_read_data_valid = 1'b1;


                    next_read_addr[2][MEM_ADDR_WIDTH-1:MEM_ADDR_WIDTH-QUEUE_ID_WIDTH] = 2'd2;
                    next_read_addr[2][MEM_ADDR_WIDTH-QUEUE_ID_WIDTH-1:0] = read_addr[2][(MEM_ADDR_WIDTH-QUEUE_ID_WIDTH-1):0]+17'b1;
                    if(read_burst_state == BURST_STATE_OFF)
                        next_read_burst_state = BURST_STATE_HALFWAY;
                end   
                else
                begin
                    next_read_addr[2] = read_addr[2];
                end
            end
            else if(read_queue_id == 2'd3)
            begin
                next_din_addr = read_addr[3];
                next_read_addr[0] = read_addr[0];
                next_read_addr[1] = read_addr[1];
                next_read_addr[2] = read_addr[2];
                if(!read_empty[3])
                begin
                    next_din_ready = 1'b1;            
                    next_read_data_valid = 1'b1;


                    next_read_addr[3][MEM_ADDR_WIDTH-1:MEM_ADDR_WIDTH-QUEUE_ID_WIDTH] = 2'd3;
                    next_read_addr[3][MEM_ADDR_WIDTH-QUEUE_ID_WIDTH-1:0] = read_addr[3][(MEM_ADDR_WIDTH-QUEUE_ID_WIDTH-1):0]+17'b1;
                    if(read_burst_state == BURST_STATE_OFF)
                        next_read_burst_state = BURST_STATE_HALFWAY;
                    end
                    else
                    begin
                        next_read_addr[3] = read_addr[3];
                    end
                end
            end
            else
            begin
                next_read_addr[0] = read_addr[0];
                next_read_addr[1] = read_addr[1];
                next_read_addr[2] = read_addr[2];
                next_read_addr[3] = read_addr[3];
            end

    if(write_data_valid && (~write_burst_state) /* && ~write_full*/)
    begin
        if(write_queue_id == 2'd0)
        begin
       		next_dout_addr = write_addr[0];
        	next_write_addr[1] = write_addr[1];
    		next_write_addr[2] = write_addr[2];
   	 		next_write_addr[3] = write_addr[3];

        	if(!write_full[0])
        	begin
            	next_write_addr[0][MEM_ADDR_WIDTH-1:MEM_ADDR_WIDTH-QUEUE_ID_WIDTH] = 2'd0;
            
            	next_write_addr[0][MEM_ADDR_WIDTH-QUEUE_ID_WIDTH-1:0] = write_addr[0][(MEM_ADDR_WIDTH-QUEUE_ID_WIDTH-1):0]+17'b1;
            	dout_ready = 1'b1;
            	
                    if(write_burst_state == BURST_STATE_OFF)
                	next_write_burst_state = BURST_STATE_HALFWAY;
        	end
        	else
        	begin
            	next_write_addr[0] = write_addr[0];
                dout_ready = 1'b0;
        	end
        end
        else if(write_queue_id == 2'd1)
        begin
        	next_dout_addr = write_addr[1];
        	next_write_addr[0] = write_addr[0];
    		next_write_addr[2] = write_addr[2];
    		next_write_addr[3] = write_addr[3];
        	if(!write_full[1])
        	begin
            	next_write_addr[1][MEM_ADDR_WIDTH-1:MEM_ADDR_WIDTH-QUEUE_ID_WIDTH] = 2'd1;
            
            	next_write_addr[1][MEM_ADDR_WIDTH-QUEUE_ID_WIDTH-1:0] = write_addr[1][(MEM_ADDR_WIDTH-QUEUE_ID_WIDTH-1):0]+17'b1;
            	dout_ready = 1'b1;
            	if(write_burst_state == BURST_STATE_OFF)
                	next_write_burst_state = BURST_STATE_HALFWAY;
        	end
        	else
        	begin
        	    next_write_addr[1] = write_addr[1];
        	end
        end

		else if(write_queue_id == 2'd2)
        begin
        	next_dout_addr = write_addr[2];
        	next_write_addr[0] = write_addr[0];
    		next_write_addr[1] = write_addr[1];
    		next_write_addr[3] = write_addr[3];

        	if(!write_full[2])
        	begin
            	next_write_addr[2][MEM_ADDR_WIDTH-1:MEM_ADDR_WIDTH-QUEUE_ID_WIDTH] = 2'd2;
            
            	next_write_addr[2][MEM_ADDR_WIDTH-QUEUE_ID_WIDTH-1:0] = write_addr[2][(MEM_ADDR_WIDTH-QUEUE_ID_WIDTH-1):0]+17'b1;
            	dout_ready = 1'b1;
            	if(write_burst_state == BURST_STATE_OFF)
                	next_write_burst_state = BURST_STATE_HALFWAY;
        	end
        	else
        	begin
            	next_write_addr[2] = write_addr[2];
        	end

        end
		else if(write_queue_id == 2'd3)
        begin
        	next_dout_addr = write_addr[3];
        	next_write_addr[0] = write_addr[0];
    		next_write_addr[1] = write_addr[1];
    		next_write_addr[2] = write_addr[2];
        	if(!write_full[3])
        	begin
            	next_write_addr[3][MEM_ADDR_WIDTH-1:MEM_ADDR_WIDTH-QUEUE_ID_WIDTH] = 2'd3;
            	next_write_addr[3][MEM_ADDR_WIDTH-QUEUE_ID_WIDTH-1:0] = write_addr[3][(MEM_ADDR_WIDTH-QUEUE_ID_WIDTH-1):0]+17'b1;
            	dout_ready = 1'b1;
            	if(write_burst_state == BURST_STATE_OFF)
                	next_write_burst_state = BURST_STATE_HALFWAY;
        	end
        	else
        	begin
        	    next_write_addr[3] = write_addr[3];
        	end

        end
    end
    else
    begin
    	next_write_addr[0] = write_addr[0];
    	next_write_addr[1] = write_addr[1];
    	next_write_addr[2] = write_addr[2];
        next_write_addr[3] = write_addr[3];
    end
    
    rw_same_queue = read_queue_id == write_queue_id;
    if(next_din_ready && (~dout_ready || ~rw_same_queue)) //(din_ready & ~dout_ready)
    begin
        next_num_used[read_queue_id] = num_used[read_queue_id] - 1;
    end
    if(dout_ready && (~next_din_ready || ~rw_same_queue))//(dout_ready & ~din_ready)
    begin
        next_num_used[write_queue_id] = num_used[write_queue_id] + 1;
    end

    next_dout_burst_ready = /*~write_burst_state &&*/ dout_ready;

end


generate
    for(i=0;i<NUM_QUEUES;i=i+1)
    begin : emptyfull
        always @(num_used[i])
        begin
            read_empty[i] = num_used[i]==0;
            next_write_full[i] = (num_used[i])>=((QUEUE_SIZE)-5);
        end
    end
endgenerate

endmodule
