/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        pbs_axis_bridge.v
 *
 *  Library:
 *        hw/contrib/pcores/nf10_axis_pbs_bridge_v1_00_a
 *
 *  Module:
 *        pbs_axis_bridge
 *
 *  Author:
 *        Gianni Antichi, Muhammad Shahbaz
 *
 *  Description:
 *        PBS to AXIS bridge
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

`uselib lib=nf10_proc_common_v1_00_a

module pbs_axis_bridge
#(
    parameter C_AXIS_DATA_WIDTH = 64,
    parameter C_AXIS_USER_WIDTH = 128,
    parameter NUM_QUEUES = 8,
	parameter NUM_QUEUES_WIDTH = log2(NUM_QUEUES),
    parameter C_PBS_SRC_PORT_POS = 16,
    parameter C_PBS_DST_PORT_POS = 48,
    parameter C_PBS_IOQ_STAGE_NUM = 'hFF
)
(
    // Global Ports
    input clk,
    input reset,

    // AXIS Ports
    output reg [C_AXIS_DATA_WIDTH-1:0] axis_tdata,
    output reg [(C_AXIS_DATA_WIDTH/8)-1:0] axis_tstrb,
    output reg [C_AXIS_USER_WIDTH-1:0] axis_tuser,
    output reg  axis_tvalid,
    input axis_tready,
    output reg axis_tlast,
    
    // PBS Ports
    input [C_AXIS_DATA_WIDTH-1:0] pbs_data,
    input [C_AXIS_DATA_WIDTH/8-1:0] pbs_ctrl,
    input pbs_wr,
    output pbs_rdy
);

   function integer log2;
      input integer number;
      begin
         log2=0;
         while(2**log2<number) begin
            log2=log2+1;
         end
      end
    endfunction // log2

   localparam MODULE_HEADER    = 1; 
   localparam SEND_PACKET      = 2;

   genvar 			   i;

   wire[C_AXIS_DATA_WIDTH-1:0]     fifo_data;
   wire[C_AXIS_DATA_WIDTH/8-1:0]   fifo_ctrl;
   wire				   fifo_nearly_full;
   wire				   fifo_empty;
   reg				   fifo_rd_en;

   reg [NUM_QUEUES-1:0]		   encoded_src_prt;
   reg [(C_AXIS_DATA_WIDTH/8)-1:0] tstrb_intrnl;
   reg [C_AXIS_DATA_WIDTH-1:0]     tdata_intrnl;

   reg [1:0] 	                   cur_state, nxt_state;

   reg [C_AXIS_DATA_WIDTH-1:0]     tdata_next;
   reg [C_AXIS_DATA_WIDTH-1:0]     tuser_next;
   reg 				   tvalid_next;
   reg  			   tlast_next;
   reg [(C_AXIS_DATA_WIDTH/8)-1:0] tstrb_next;


   fallthrough_small_fifo
     #( .WIDTH(C_AXIS_DATA_WIDTH+C_AXIS_DATA_WIDTH/8),
        .MAX_DEPTH_BITS(2)
      ) input_data
      ( 
      // Outputs
         .dout                     ({fifo_ctrl, fifo_data}),
         .full                     (),
         .nearly_full              (fifo_nearly_full),
         .prog_full                (),
         .empty                    (fifo_empty),
      // Inputs
         .din                      ({pbs_ctrl, pbs_data}),
         .wr_en                    (pbs_wr),
         .rd_en                    (fifo_rd_en),
         .reset                    (reset),
         .clk                      (clk)
      );  

    assign pbs_rdy = !fifo_nearly_full;

    /* Encode the source port */
    always @(*) begin
       encoded_src_prt = {NUM_QUEUES{1'b0}};
       encoded_src_prt[fifo_data[C_PBS_SRC_PORT_POS+NUM_QUEUES_WIDTH-1:C_PBS_SRC_PORT_POS]] = 1'b1;
    end

    /* Generate tdata and tstrb */
  generate
  for (i=0; i<(C_AXIS_DATA_WIDTH/8); i=i+1) begin: tdata_tstrb
    always @(*) begin
       tdata_intrnl[(i+1)*8-1:i*8] = fifo_data[((C_AXIS_DATA_WIDTH/8)-i)*8-1:((C_AXIS_DATA_WIDTH/8)-(i+1))*8];
    end

    if (C_AXIS_DATA_WIDTH==32) begin: _32
       always @(*) begin
          case (fifo_ctrl)
             4'b1000: tstrb_intrnl = 4'b0001;
             4'b0100: tstrb_intrnl = 4'b0011;
             4'b0010: tstrb_intrnl = 4'b0111;
             4'b0001: tstrb_intrnl = 4'b1111;
             default: tstrb_intrnl = 4'b0000;
          endcase
       end
    end
    else if (C_AXIS_DATA_WIDTH==64) begin: _64
       always @(*) begin
          case (fifo_ctrl)
             8'b1000_0000: tstrb_intrnl = 8'b0000_0001;
             8'b0100_0000: tstrb_intrnl = 8'b0000_0011;
             8'b0010_0000: tstrb_intrnl = 8'b0000_0111;
             8'b0001_0000: tstrb_intrnl = 8'b0000_1111;
             8'b0000_1000: tstrb_intrnl = 8'b0001_1111;
             8'b0000_0100: tstrb_intrnl = 8'b0011_1111;
             8'b0000_0010: tstrb_intrnl = 8'b0111_1111;
             8'b0000_0001: tstrb_intrnl = 8'b1111_1111;
             default     : tstrb_intrnl = 8'b0000_0000;
          endcase
       end
    end     
  end
  endgenerate
    
    /* State machine logic */
    always @(*) begin
      nxt_state = cur_state;
      tdata_next = axis_tdata;
      tstrb_next = axis_tstrb;
      tuser_next = axis_tuser;
      tlast_next = 0;
      tvalid_next = 0;
      fifo_rd_en = 0;
      
      case (cur_state)
        MODULE_HEADER: begin         
	   if (!fifo_empty) begin            
              if (fifo_ctrl==C_PBS_IOQ_STAGE_NUM) begin
                 tuser_next = {96'b0, fifo_data[C_PBS_DST_PORT_POS+NUM_QUEUES-1:C_PBS_DST_PORT_POS], encoded_src_prt, fifo_data[15:0]};
                 fifo_rd_en = 1;
              end
              else // Check to remove multiple Packet Bus headers (currently support/process only one header)
              if (fifo_ctrl==0) begin                  
                 tdata_next = tdata_intrnl;
	      	 tstrb_next = {(C_AXIS_DATA_WIDTH/8){1'b1}};
                 tvalid_next = 1;

                 if (axis_tready) begin
                    fifo_rd_en = 1;
                    nxt_state = SEND_PACKET;
                 end
	      end
           end
	end

	SEND_PACKET: begin
	   if (!fifo_empty) begin
              tdata_next = tdata_intrnl;
	      tstrb_next = {(C_AXIS_DATA_WIDTH/8){1'b1}};
              tvalid_next = 1;
             
              if (axis_tready) begin
                 fifo_rd_en = 1;

                 if (fifo_ctrl!=0) begin
                    tstrb_next = tstrb_intrnl;
                    tlast_next = 1;
	            nxt_state = MODULE_HEADER;
                 end
              end
	   end
	end
     endcase
   end

   always @ (posedge clk) begin
      if(reset) begin
	 cur_state <= MODULE_HEADER;
	 axis_tdata  <= {C_AXIS_DATA_WIDTH{1'b0}};
	 axis_tvalid <= 0;
         axis_tlast  <= 0;
	 axis_tuser  <= {C_AXIS_USER_WIDTH{1'b0}};
	 axis_tstrb  <= {(C_AXIS_DATA_WIDTH/8){1'b0}};
      end
      else begin
	 cur_state <= nxt_state;
	 axis_tdata <= tdata_next;
	 axis_tvalid<= tvalid_next;
         axis_tlast <= tlast_next;
         axis_tuser <= tuser_next;
	 axis_tstrb <= tstrb_next;
      end
   end

endmodule
