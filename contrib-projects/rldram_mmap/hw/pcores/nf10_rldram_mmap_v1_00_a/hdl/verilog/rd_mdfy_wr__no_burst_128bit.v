/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        rd_mdfy_wr__no_burst_128bit.v
 *
 *  Library:
 *        hw/std/pcores/nf10_rldram_mmap_v1_00_a
 *
 *  Module:
 *        rd_mdfy_wr
 *
 *  Author:
 *        Muhammad Shahbaz
 *
 *  Description:
 *        Read modify and write logic
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
 *        This module was developed by SRI International and the University of
 *        Cambridge Computer Laboratory under DARPA/AFRL contract (FA8750-11-C-0249)
 *        ("MRC2"), as part of the DARPA MRC research programme.
 *
 */

module rd_mdfy_wr
#(
    parameter ADDR_WIDTH = 23,
    parameter DATA_WIDTH = 128,
    parameter RL_DQ_WIDTH = 72
)
(
    // Global Ports
    input aclk,
    input aresetn,

    // Master interface
	input app_en,
	input [2:0] app_cmd,
	input [ADDR_WIDTH-1:0] app_addr,
	output app_rdy,
	input app_wdf_wren,
	input [DATA_WIDTH-1:0] app_wdf_data,
	input [DATA_WIDTH/8-1:0] app_wdf_mask,
	output app_wdf_rdy,
	output reg app_rd_valid,
	output reg [DATA_WIDTH-1:0] app_rd_data, 	
  
    // Slave interface
	output reg [2:0] apCmd,
	output reg [ADDR_WIDTH-1:0] apAddr,
	output reg apValid,
	input rlafFull,
	output reg [2*RL_DQ_WIDTH-1:0] apWriteData,
	output reg apWriteDValid,
	input rlWdfFull,
    input [2*RL_DQ_WIDTH-1:0] rldReadData,
	input rldReadDataValid
);

   // ------------ Internal Params --------
   localparam IDLE     = 0;
   localparam WR_ON_RD = 1;
   localparam WT_ON_RD = 2;

   //------------- Wires ------------------
   wire addr_fifo_empty;
   wire addr_fifo_nearly_full;
   reg addr_fifo_rd_en;
   wire [ADDR_WIDTH-1:0] addr_fifo_addr;
   wire [2:0] addr_fifo_cmd;
   
   wire wr_data_fifo_empty;
   wire wr_data_fifo_nearly_full;
   reg wr_data_fifo_rd_en;
   wire [DATA_WIDTH-1:0] wr_data_fifo_data;
   wire [DATA_WIDTH/8-1:0] wr_data_fifo_mask;
   
   wire rd_data_fifo_empty;
   reg rd_data_fifo_rd_en;
   wire [2*RL_DQ_WIDTH-1:0] rd_data_fifo_data;
   
   reg [ADDR_WIDTH-1:0] apAddr_w;
   reg [2:0] apCmd_w;
   reg apValid_w;
   reg [2*RL_DQ_WIDTH-1:0] apWriteData_w;
   reg apWriteDValid_w;
   reg app_rd_valid_w;
   reg [DATA_WIDTH-1:0] app_rd_data_w;
   
   reg [1:0] state, state_next;
   
   // ------------ Modules ----------------
   
   fallthrough_small_fifo
        #( .WIDTH(ADDR_WIDTH+3),
           .MAX_DEPTH_BITS(2))
      addr_fifo
        (// Outputs
         .dout                           ({addr_fifo_addr, addr_fifo_cmd}),
         .full                           (),
         .nearly_full                    (addr_fifo_nearly_full),
         .prog_full                      (),
         .empty                          (addr_fifo_empty),
         // Inputs
         .din                            ({app_addr, app_cmd}),
         .wr_en                          (app_en),
         .rd_en                          (addr_fifo_rd_en),
         .reset                          (~aresetn),
         .clk                            (aclk));
   
   fallthrough_small_fifo
        #( .WIDTH(DATA_WIDTH+DATA_WIDTH/8),
           .MAX_DEPTH_BITS(2))
      wr_data_fifo
        (// Outputs
         .dout                           ({wr_data_fifo_data, wr_data_fifo_mask}),
         .full                           (),
         .nearly_full                    (wr_data_fifo_nearly_full),
         .prog_full                      (),
         .empty                          (wr_data_fifo_empty),
         // Inputs
         .din                            ({app_wdf_data, app_wdf_mask}),
         .wr_en                          (app_wdf_wren),
         .rd_en                          (wr_data_fifo_rd_en),
         .reset                          (~aresetn),
         .clk                            (aclk));

   fallthrough_small_fifo
        #( .WIDTH(2*RL_DQ_WIDTH),
           .MAX_DEPTH_BITS(2))
      rd_data_fifo
        (// Outputs
         .dout                           (rd_data_fifo_data),
         .full                           (),
         .nearly_full                    (),
         .prog_full                      (),
         .empty                          (rd_data_fifo_empty),
         // Inputs
         .din                            (rldReadData),
         .wr_en                          (rldReadDataValid),
         .rd_en                          (rd_data_fifo_rd_en),
         .reset                          (~aresetn),
         .clk                            (aclk));
		 
   // ------------- Logic ----------------

   assign app_rdy = ~addr_fifo_nearly_full;
   assign app_wdf_rdy = ~wr_data_fifo_nearly_full;

   always @(*) begin
      apCmd_w = addr_fifo_cmd;
 	  apAddr_w = addr_fifo_addr;
	  apValid_w = 1'b0;
	  addr_fifo_rd_en = 1'b0;
	  apWriteData_w = {1'b0, wr_data_fifo_data[127:120],
	                   1'b0, wr_data_fifo_data[119:112],
	                   1'b0, wr_data_fifo_data[111:104],
	                   1'b0, wr_data_fifo_data[103:96],
	                   1'b0, wr_data_fifo_data[95:88],
	                   1'b0, wr_data_fifo_data[87:80],
	                   1'b0, wr_data_fifo_data[79:72],
	                   1'b0, wr_data_fifo_data[71:64],
					   1'b0, wr_data_fifo_data[63:56],
	                   1'b0, wr_data_fifo_data[55:48],
	                   1'b0, wr_data_fifo_data[47:40],
	                   1'b0, wr_data_fifo_data[39:32],
	                   1'b0, wr_data_fifo_data[31:24],
	                   1'b0, wr_data_fifo_data[23:16],
	                   1'b0, wr_data_fifo_data[15:8],
	                   1'b0, wr_data_fifo_data[7 :0]};
	  apWriteDValid_w = 1'b0;
	  wr_data_fifo_rd_en = 1'b0;
	  app_rd_data_w = {rd_data_fifo_data[142:135],
	                   rd_data_fifo_data[133:126],
	                   rd_data_fifo_data[124:117],
	                   rd_data_fifo_data[115:108],
	                   rd_data_fifo_data[106:99],
	                   rd_data_fifo_data[97:90],
	                   rd_data_fifo_data[88:81],
	                   rd_data_fifo_data[79:72],
					   rd_data_fifo_data[70:63],
	                   rd_data_fifo_data[61:54],
	                   rd_data_fifo_data[52:45],
	                   rd_data_fifo_data[43:36],
	                   rd_data_fifo_data[34:27],
	                   rd_data_fifo_data[25:18],
	                   rd_data_fifo_data[16:9],
	                   rd_data_fifo_data[7 :0]};
	  app_rd_valid_w = 1'b0;
	  rd_data_fifo_rd_en = 1'b0;
      state_next = state;

      case(state)
	IDLE: begin
	   if (~addr_fifo_empty & ~rlafFull) begin
	      apValid_w = 1'b1;
		  
		  if (~addr_fifo_cmd[0]) begin 
		     apCmd_w[0] = 1'b1;
			 state_next = WR_ON_RD;
          end
		  else begin
		     state_next = WT_ON_RD;
		  end
	   end
	end

	WR_ON_RD: begin
	   if(~rd_data_fifo_empty & ~rlafFull & ~rlWdfFull) begin
		  rd_data_fifo_rd_en = 1'b1;
	      addr_fifo_rd_en = 1'b1;
		  apCmd_w[0] = 1'b0;
		  apValid_w = 1'b1;
		  wr_data_fifo_rd_en = 1'b1;
		  apWriteDValid_w = 1'b1;		  
		  apWriteData_w[143:135] = (wr_data_fifo_mask[15]) ? {1'b0, rd_data_fifo_data[142:135]} 
		                                                   : {1'b0, wr_data_fifo_data[127:120]}; 
	      apWriteData_w[134:126] = (wr_data_fifo_mask[14]) ? {1'b0, rd_data_fifo_data[133:126]} 
                                                           : {1'b0, wr_data_fifo_data[119:112]};
	      apWriteData_w[125:117] = (wr_data_fifo_mask[13]) ? {1'b0, rd_data_fifo_data[124:117]} 
                                                           : {1'b0, wr_data_fifo_data[111:104]};
	      apWriteData_w[116:108] = (wr_data_fifo_mask[12]) ? {1'b0, rd_data_fifo_data[115:108]} 
                                                           : {1'b0, wr_data_fifo_data[103:96]};
	      apWriteData_w[107:99]  = (wr_data_fifo_mask[11]) ? {1'b0, rd_data_fifo_data[106:99]} 
                                                           : {1'b0, wr_data_fifo_data[95:88]};
	      apWriteData_w[98:90]   = (wr_data_fifo_mask[10]) ? {1'b0, rd_data_fifo_data[97:90]} 
                                                           : {1'b0, wr_data_fifo_data[87:80]};
	      apWriteData_w[89:81]   = (wr_data_fifo_mask[ 9]) ? {1'b0, rd_data_fifo_data[88:81]} 
                                                           : {1'b0, wr_data_fifo_data[79:72]};
	      apWriteData_w[80:72]   = (wr_data_fifo_mask[ 8]) ? {1'b0, rd_data_fifo_data[79:72]} 
                                                           : {1'b0, wr_data_fifo_data[71:64]};
	      apWriteData_w[71:63]   = (wr_data_fifo_mask[ 7]) ? {1'b0, rd_data_fifo_data[70:63]} 
                                                           : {1'b0, wr_data_fifo_data[63:56]};
	      apWriteData_w[62:54]   = (wr_data_fifo_mask[ 6]) ? {1'b0, rd_data_fifo_data[61:54]} 
                                                           : {1'b0, wr_data_fifo_data[55:48]};
	      apWriteData_w[53:45]   = (wr_data_fifo_mask[ 5]) ? {1'b0, rd_data_fifo_data[52:45]} 
                                                           : {1'b0, wr_data_fifo_data[47:40]};
	      apWriteData_w[44:36]   = (wr_data_fifo_mask[ 4]) ? {1'b0, rd_data_fifo_data[43:36]} 
                                                           : {1'b0, wr_data_fifo_data[39:32]};
	      apWriteData_w[35:27]   = (wr_data_fifo_mask[ 3]) ? {1'b0, rd_data_fifo_data[34:27]} 
                                                           : {1'b0, wr_data_fifo_data[31:24]};
	      apWriteData_w[26:18]   = (wr_data_fifo_mask[ 2]) ? {1'b0, rd_data_fifo_data[25:18]} 
                                                           : {1'b0, wr_data_fifo_data[23:16]};
	      apWriteData_w[17:9]    = (wr_data_fifo_mask[ 1]) ? {1'b0, rd_data_fifo_data[16:9]} 
                                                           : {1'b0, wr_data_fifo_data[15:8]};
	      apWriteData_w[8 :0]    = (wr_data_fifo_mask[ 0]) ? {1'b0, rd_data_fifo_data[7 :0]} 
                                                           : {1'b0, wr_data_fifo_data[7 :0]};
	      state_next = IDLE;
	   end
	end
	
	WT_ON_RD: begin
	   if(~rd_data_fifo_empty) begin
		  addr_fifo_rd_en = 1'b1;
		  app_rd_valid_w = 1'b1;
	      rd_data_fifo_rd_en = 1'b1;
		  state_next = IDLE;
	   end
	end
      endcase // case (state)
   end // always @ (*)

   always @(posedge aclk) begin
      if(~aresetn) begin
	 apAddr <= {ADDR_WIDTH{1'b0}};
	 apCmd <= 3'b0;
	 apValid <= 1'b0;
	 apWriteData <= {2*RL_DQ_WIDTH{1'b0}};
	 apWriteDValid <= 1'b0;
	 app_rd_data <= {DATA_WIDTH{1'b0}};
	 app_rd_valid <= 1'b0;
	 state <= IDLE;
      end
      else begin
	 apAddr <= apAddr_w;
	 apCmd <= apCmd_w;
	 apValid <= apValid_w;
	 apWriteData <= apWriteData_w;
	 apWriteDValid <= apWriteDValid_w;
	 app_rd_data <= app_rd_data_w;
	 app_rd_valid <= app_rd_valid_w;
	 state <= state_next;
      end
   end

endmodule
