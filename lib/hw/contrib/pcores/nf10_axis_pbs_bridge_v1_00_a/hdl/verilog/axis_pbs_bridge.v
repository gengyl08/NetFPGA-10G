/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        axis_pbs_bridge.v
 *
 *  Library:
 *        /hw/contrib/pcores/axis_pbs_bridge_v1_00_a
 *
 *  Module:
 *        axis_pbs_bridge
 *
 *  Author:
 *        Gianni Antichi, Muhammad Shahbaz
 *
 *  Description:
 *        AXIS to PBS bridge
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

module axis_pbs_bridge
#(
    parameter C_AXIS_DATA_WIDTH = 64,
    parameter C_AXIS_USER_WIDTH = 128,
    parameter C_AXIS_SRC_PORT_POS = 16,
    parameter C_AXIS_DST_PORT_POS = 24,
    parameter NUM_QUEUES = 8,
    parameter NUM_QUEUES_WIDTH = log2(NUM_QUEUES),
    parameter C_PBS_IOQ_STAGE_NUM = 'hFF
)
(
    // Global Ports
    input clk,
    input reset,

    // AXIS Ports
    input [C_AXIS_DATA_WIDTH-1:0] axis_tdata,
    input [(C_AXIS_DATA_WIDTH/8)-1:0] axis_tstrb,
    input [C_AXIS_USER_WIDTH-1:0] axis_tuser,
    input  axis_tvalid,
    output axis_tready,
    input  axis_tlast,
    
    // PBS Ports
    output reg [C_AXIS_DATA_WIDTH-1:0] pbs_data,
    output reg [C_AXIS_DATA_WIDTH/8-1:0] pbs_ctrl,
    output reg pbs_wr,
    input pbs_rdy
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

    genvar 		             i;

    wire[C_AXIS_DATA_WIDTH-1:0]      fifo_data;
    wire[C_AXIS_DATA_WIDTH/8-1:0]    fifo_strb;
    wire	                     fifo_last;
    wire [C_AXIS_USER_WIDTH-1:0]     fifo_user;
    wire			     fifo_nearly_full;
    wire			     fifo_empty;
    reg				     fifo_rd_en;

    wire [NUM_QUEUES-1:0]	     encoded_src_prt;
    reg [NUM_QUEUES_WIDTH-1:0]       decoded_src_prt;
    wire [15:0]                      wrd_len;

    reg [(C_AXIS_DATA_WIDTH/8)-1:0]  ctrl_intrnl;
    reg [C_AXIS_DATA_WIDTH-1:0]      data_intrnl;

    reg  [1:0] 	                     cur_state, nxt_state;

    reg		                     wr_next;
    reg [C_AXIS_DATA_WIDTH-1:0]      data_next;
    reg [C_AXIS_DATA_WIDTH/8-1:0]    ctrl_next;

    /* Decode the source port */
    assign encoded_src_prt = fifo_user[C_AXIS_SRC_PORT_POS+NUM_QUEUES-1:C_AXIS_SRC_PORT_POS];

  
    // Todo - Make this generic
    always @(*) begin
       decoded_src_prt = 0;
       case (encoded_src_prt)
	    8'b0000_0001: decoded_src_prt = 0;
	    8'b0000_0010: decoded_src_prt = 1;
 	    8'b0000_0100: decoded_src_prt = 2;
 	    8'b0000_1000: decoded_src_prt = 3;
 	    8'b0001_0000: decoded_src_prt = 4;
 	    8'b0010_0000: decoded_src_prt = 5;
 	    8'b0100_0000: decoded_src_prt = 6;
 	    8'b1000_0000: decoded_src_prt = 7;
	    default	: decoded_src_prt = 0;
	endcase
     end

    fallthrough_small_fifo
      #( .WIDTH(C_AXIS_DATA_WIDTH+C_AXIS_USER_WIDTH+C_AXIS_DATA_WIDTH/8+1),
         .MAX_DEPTH_BITS(2)
       ) input_data
       (
       // Outputs
         .dout                    ({fifo_data, fifo_user, fifo_strb, fifo_last}),
         .full                    (),
         .nearly_full             (fifo_nearly_full),
         .prog_full               (),
         .empty                   (fifo_empty),
         // Inputs
         .din                     ({axis_tdata, axis_tuser, axis_tstrb, axis_tlast}),
         .wr_en                   (axis_tvalid && axis_tready),
         .rd_en                   (fifo_rd_en),
         .reset                   (reset),
         .clk                     (clk)
       );
    
    assign axis_tready = !fifo_nearly_full;

    /* Generate data and ctrl */
  generate
  for (i=0; i<(C_AXIS_DATA_WIDTH/8); i=i+1) begin: data_ctrl
    always @(*) begin
       data_intrnl[(i+1)*8-1:i*8] = fifo_data[((C_AXIS_DATA_WIDTH/8)-i)*8-1:((C_AXIS_DATA_WIDTH/8)-(i+1))*8];
    end
    
    if (C_AXIS_DATA_WIDTH==32) begin: _32
       always @(*) begin
          case (fifo_strb)
             4'b0001: ctrl_intrnl = 4'b1000;
             4'b0011: ctrl_intrnl = 4'b0100;
             4'b0111: ctrl_intrnl = 4'b0010;
             4'b1111: ctrl_intrnl = 4'b0001;
             default: ctrl_intrnl = 4'b0000;
          endcase
       end

       assign wrd_len = {2'b0, fifo_user[15:2]};
    end
    else if (C_AXIS_DATA_WIDTH==64) begin: _64
       always @(*) begin
          case (fifo_strb)
             8'b0000_0001: ctrl_intrnl = 8'b1000_0000;
             8'b0000_0011: ctrl_intrnl = 8'b0100_0000;
             8'b0000_0111: ctrl_intrnl = 8'b0010_0000;
             8'b0000_1111: ctrl_intrnl = 8'b0001_0000;
             8'b0001_1111: ctrl_intrnl = 8'b0000_1000;
             8'b0011_1111: ctrl_intrnl = 8'b0000_0100;
             8'b0111_1111: ctrl_intrnl = 8'b0000_0010;
             8'b1111_1111: ctrl_intrnl = 8'b0000_0001;
             default     : ctrl_intrnl = 8'b0000_0000;
          endcase
       end
      
       assign wrd_len = {3'b0, fifo_user[15:3]};
    end 
  end
  endgenerate

    /* State machine logic */ 
    always @(*) begin
      nxt_state = cur_state;
      ctrl_next = pbs_ctrl;
      data_next = pbs_data;
      wr_next = 0;      
      fifo_rd_en = 0;

      case (cur_state)
	MODULE_HEADER: begin
	   if (!fifo_empty && pbs_rdy) begin
              wr_next = 1;
              ctrl_next = C_PBS_IOQ_STAGE_NUM;
	      data_next={{8'b0, fifo_user[C_AXIS_DST_PORT_POS+7:C_AXIS_DST_PORT_POS]}, wrd_len, {{(16-NUM_QUEUES_WIDTH){1'b0}}, decoded_src_prt}, fifo_user[15:0]};
	      nxt_state = SEND_PACKET;
	   end
	end

	SEND_PACKET: begin
	   if (!fifo_empty && pbs_rdy) begin
              data_next = data_intrnl;
              ctrl_next = (fifo_last) ? ctrl_intrnl : {(C_AXIS_DATA_WIDTH/8){1'b0}};
              wr_next = 1;
              fifo_rd_en = 1;            

              if (fifo_last) begin
	         nxt_state = MODULE_HEADER;
              end
	    end
 	 end
       endcase
    end

    always @(posedge clk) begin
      if(reset) begin
	 cur_state <= MODULE_HEADER;
	 pbs_wr    <= 0;
	 pbs_data  <= {C_AXIS_DATA_WIDTH{1'b0}};
         pbs_ctrl  <= {(C_AXIS_DATA_WIDTH/8){1'b0}};
      end
      else begin
	 cur_state <= nxt_state;
	 pbs_wr <= wr_next;
	 pbs_data  <= data_next;
         pbs_ctrl  <= ctrl_next;
      end
    end

endmodule
