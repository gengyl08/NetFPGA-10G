/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        cpld.v
 *
 *  Project:
 *        configuration
 *
 *  Author:
 *        Muhammad Shahbaz
 *
 *  Description:
 *               	CPLD logic for flash interface and on-chip FPGA
 *        configuration.
 *
 *  Copyright notice:
 *        Copyright (C) 2010, 2011 University of Cambridge
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

//`define EN_DBG

module cpld
(
	// System signals
	input			CPLD_CLK_100MHz,
//	input			PERST_B,
	output [3:0]		LED,

	// FPGA side signals
	output			FPGA_CCLK,
	input			FPGA_DONE,
	input			FPGA_INIT_B,
	inout			FPGA_PROG_B,
	input			FPGA_PROG_REQ_B,
	input			FPGA_WE_B,
	input			FPGA_OE_B,
	input			FPGA_CS_B,
	input [23:0]		FPGA_A,
	inout [7:0]		FPGA_DQ,

	// Flash side common signals
	output [23:0]		FLASH_A,

	// Flash A signals
	output			FLASH_A_K,
	output			FLASH_A_RP_B,
	input			FLASH_A_RW,
	output			FLASH_A_L_B,
	output			FLASH_A_WP_B,
	output reg		FLASH_A_W_B,
	output reg		FLASH_A_G_B,
	output reg		FLASH_A_E_B,
	inout [7:0]		FLASH_A_DQ,

	// Flash B signals
	output			FLASH_B_K,
	output			FLASH_B_RP_B,
	input			FLASH_B_RW,
	output			FLASH_B_L_B,
	output			FLASH_B_WP_B,
	output reg		FLASH_B_W_B,
	output reg		FLASH_B_G_B,
	output reg		FLASH_B_E_B,
	inout [7:0]		FLASH_B_DQ
);

	// Internal Parameters
	parameter	XIL_ELEC_ID = 8'h49;

	// Addresses
	parameter	ASYNC_MODE_ADDR = 24'h8000;

	// Commands
	parameter	CMD_SET_CFG_REG = 8'h60;
	parameter	CMD_CNFRM_CFG_REG = 8'h03;
	parameter	CMD_READ_ELEC_SIG = 8'h90;
	parameter	CMD_READ_ARRAY = 8'hFF;

/*  UNUSED
	parameter 	CMD_BLOCK_LOCK_SETUP = 8'h60;
	parameter	CMD_CONFIRM = 8'hD0;
	parameter	CMD_PROGRAM_SETUP = 8'h40;
	parameter	CMD_PROGRAM_INIT_VAL = 8'h00;
*/

	// Configurations
	parameter 	CLK_25MHz_CFG = 10;
	parameter 	MSTR_SM_WIDTH = 4;
	parameter 	CMD_SM_WIDTH = 4;
	parameter	TRNS_CNTR_WIDTH = 22;
	parameter	MAX_DLY_VAL = (2**TRNS_CNTR_WIDTH)-2;

	// Master SM States
	localparam [MSTR_SM_WIDTH-1:0]	MSTR_IDLE			= 0,
					MSTR_SEND_CMD_SET_CFG_REG	= 1,
					MSTR_SEND_CMD_CNFRM_CFG_REG	= 2,
					MSTR_SEND_CMD_READ_ELEC_SIG 	= 3,
					MSTR_READ_ELEC_SIG   		= 4,
					MSTR_SEND_CMD_READ_ARRAY 	= 5,
					MSTR_CONFIG_4RM_FLASH_A		= 6,
					MSTR_CONFIG_4RM_FLASH_B		= 7,
					MSTR_WAIT_4_PRG_REQ		= 8;

 	// Command SM States
	localparam [CMD_SM_WIDTH-1:0]	CMD_IDLE		= 0,
					CMD_PHASE_CS_LOW	= 1,
					CMD_PHASE_WOE_LOW	= 2,
					CMD_PHASE_WOE_HIGH	= 3,
					CMD_PHASE_CS_HIGH 	= 4,
					CMD_PHASE_WAIT_ASYNC	= 5,
					CMD_PHASE_IO		= 6,
					CMD_CFG_FPGA		= 7,
					CMD_CFG_FPGA_DLY	= 8,
					CMD_DONE		= 9;

	// Internal Signals
	reg [MSTR_SM_WIDTH-1:0]	mstr_cur_state = MSTR_IDLE;
	reg [MSTR_SM_WIDTH-1:0]	mstr_nxt_state = MSTR_IDLE;

	reg [CMD_SM_WIDTH-1:0]	cmd_cur_state = CMD_IDLE;
	reg [CMD_SM_WIDTH-1:0]	cmd_nxt_state = CMD_IDLE;

	reg			tied_to_vcc = 1'b1;
	reg			tied_to_gnd = 1'b0;

	wire			cpld_clk_100MHz_bufg;

	wire [3:0]		clk_25MHz_cntr_preset;
	wire			clk_25MHz_en;
	reg [3:0]		clk_25MHz_cntr = 4'd0;
	reg			clk_25MHz = 1'b0;

	reg			elec_sig_chk_en = 1'b0;

	reg [TRNS_CNTR_WIDTH-1:0] state_trans_cntr = {TRNS_CNTR_WIDTH{1'b0}};
	reg			  state_trans_cntr_en = 1'b0;

	reg			fpga_cfg_from_flash_a = 1'b1;
	reg			fpga_cpld_rst = 1'b0;
	wire			fpga_prog_req;
	reg			fpga_prog_req_d0;

	reg [2:0]		flash_cmd_ctrl = 3'd0;
	reg [1:0]		flash_sel_ctrl = 2'd0;

	reg [1:0]		flash_addr_ctrl = 2'b0;
	reg [23:0] 		flash_addr = 24'd0;
	reg [23:0] 		flash_addr_cntr = 24'b0;
	reg			flash_addr_cntr_en = 1'b0;

	reg [1:0]		flash_a_e_b_ctrl = 2'b0;
	reg [1:0]		flash_a_g_b_ctrl = 2'b0;
	reg [1:0]		flash_a_w_b_ctrl = 2'b0;
	reg [2:0]		flash_a_dq_ctrl	= 3'b0;
	reg [7:0] 		flash_a_dq_c;
	reg			flash_a_elec_sig_failure_chk;

	reg [1:0]		flash_b_e_b_ctrl = 2'b0;
	reg [1:0]		flash_b_g_b_ctrl = 2'b0;
	reg [1:0]		flash_b_w_b_ctrl = 2'b0;
	reg [2:0]		flash_b_dq_ctrl	= 3'b0;
	reg [7:0] 		flash_b_dq_c;
	reg			flash_b_elec_sig_failure_chk;


	// Internal Logic
	BUFG cpld_clk_bufg
	(
		.O (cpld_clk_100MHz_bufg),
		.I (CPLD_CLK_100MHz)
	);

	OBUF cclk_obuf
	(
		.O (FPGA_CCLK),
		.I (clk_25MHz)
	);


	// Debug Singlas.
`ifdef EN_DBG
	assign LED[0] = ~PERST_B;
	assign LED[1] = flash_a_elec_sig_failure_chk;
	assign LED[2] = flash_b_elec_sig_failure_chk;
	assign LED[3] = 1'b0;
`endif


	// Logic for bringing FPGA to init state.
	assign FPGA_PROG_B = (fpga_cpld_rst) ? 1'b0 : 1'bz;

	// Flash A connecitons
	assign FLASH_A_K = tied_to_vcc;
	assign FLASH_A_RP_B = (fpga_cpld_rst) ? 1'b0 : 1'b1;
	assign FLASH_A_L_B = tied_to_gnd; // for continuous address flow, refer DS617.
	assign FLASH_A_WP_B = tied_to_vcc;
	assign FLASH_A_DQ = (!FLASH_A_W_B) ? flash_a_dq_c : 16'bz;

	// Flash B connections
	assign FLASH_B_K = tied_to_vcc;
	assign FLASH_B_RP_B = (fpga_cpld_rst) ? 1'b0 : 1'b1;
	assign FLASH_B_L_B = tied_to_gnd; // for continuous address flow, refer DS617.
	assign FLASH_B_WP_B = tied_to_vcc;
	assign FLASH_B_DQ = (!FLASH_B_W_B) ? flash_b_dq_c : 16'bz;

	assign FLASH_A = flash_addr;
	assign FPGA_DQ = (!FLASH_A_G_B) ? FLASH_A_DQ :
			 (!FLASH_B_G_B) ? FLASH_B_DQ : 16'bz;


	// Electronic check failure indication
`ifdef EN_DBG
	always @ (posedge cpld_clk_100MHz_bufg) begin
		if (elec_sig_chk_en)
		begin
			if (FLASH_A_DQ[7:0] == XIL_ELEC_ID) begin
				flash_a_elec_sig_failure_chk = 1'b1;
			end
			else begin
				flash_a_elec_sig_failure_chk = 1'b0;
			end
		end
	end

	always @ (posedge cpld_clk_100MHz_bufg) begin
		if (elec_sig_chk_en)
		begin
			if (FLASH_B_DQ[7:0] == XIL_ELEC_ID) begin
				flash_b_elec_sig_failure_chk = 1'b1;
			end
			else begin
				flash_b_elec_sig_failure_chk = 1'b0;
			end
		end
	end
`endif

	// FPGA prog req (pulse)
	always @ (posedge cpld_clk_100MHz_bufg) begin
	    if (clk_25MHz_en)
	    	fpga_prog_req_d0 <= FPGA_PROG_REQ_B;
	end

	assign fpga_prog_req = fpga_prog_req_d0 & ~FPGA_PROG_REQ_B;

	// Gold image (flash A) - disable default selection
	always @ (posedge cpld_clk_100MHz_bufg) begin
		if (mstr_cur_state == MSTR_CONFIG_4RM_FLASH_A)
			fpga_cfg_from_flash_a <= 1'b0;
	end


	// State transition counter
	always @ (posedge cpld_clk_100MHz_bufg)	begin
		if(!state_trans_cntr_en)
			state_trans_cntr <= 25'd0;
		else if (state_trans_cntr_en && (clk_25MHz_en) )
			state_trans_cntr <= state_trans_cntr + 25'd1;
	end


	// FPGA configuration clock generation @ 25MHz
	// Preset for FPGA clock generation
	assign clk_25MHz_cntr_preset = ((CLK_25MHz_CFG >> 1) - 'd1);

	// Clock enable for FPGA clock generation
	assign clk_25MHz_en = ((clk_25MHz_cntr == clk_25MHz_cntr_preset) && (!clk_25MHz));

	// Counter for FPGA clock generation
	always @ (posedge cpld_clk_100MHz_bufg)	begin
		if(clk_25MHz_cntr == clk_25MHz_cntr_preset)
			clk_25MHz_cntr <= 4'd0;
		else
			clk_25MHz_cntr <= clk_25MHz_cntr + 4'd1;
	end

	// Clock for FPGA
	always @ (posedge cpld_clk_100MHz_bufg)	begin
		if(clk_25MHz_cntr == clk_25MHz_cntr_preset)
			clk_25MHz <= ~clk_25MHz;
	end


	// Flash A output lines multiplexer
	always @ * begin
		case (flash_a_e_b_ctrl)
			2'd0 : FLASH_A_E_B = FPGA_CS_B;
			2'd1 : FLASH_A_E_B = 1'b0;
	  		2'd2 : FLASH_A_E_B = FPGA_DONE;
    			default : FLASH_A_E_B = 1'b1;
  		endcase
	end

	always @ * begin
		case (flash_a_g_b_ctrl)
			2'd0 : FLASH_A_G_B = FPGA_OE_B;
			2'd1 : FLASH_A_G_B = 1'b0;
		 	2'd2 : FLASH_A_G_B = FPGA_DONE;
	    		default : FLASH_A_G_B = 1'b1;
	  	endcase
	end

	always @ * begin
		case (flash_a_w_b_ctrl)
			2'd0 : FLASH_A_W_B = FPGA_WE_B;
			2'd1 : FLASH_A_W_B = 1'b0;
		  	2'd2 : FLASH_A_W_B = FPGA_DONE;
	    		default : FLASH_A_W_B = 1'b1;
	  	endcase
	end

	always @ * begin
		case (flash_a_dq_ctrl)
			3'd0 : flash_a_dq_c = FPGA_DQ;
			3'd1 : flash_a_dq_c = CMD_SET_CFG_REG;
		  	3'd2 : flash_a_dq_c = CMD_CNFRM_CFG_REG;
			3'd3 : flash_a_dq_c = CMD_READ_ELEC_SIG;
			3'd4 : flash_a_dq_c = CMD_READ_ARRAY;

/* 			UNUSED
			'd5 : flash_a_dq_c = CMD_BLOCK_LOCK_SETUP;
			'd6 : flash_a_dq_c = CMD_CONFIRM;
			'd7 : flash_a_dq_c = CMD_PROGRAM_SETUP;
			'd8 : flash_a_dq_c = CMD_PROGRAM_INIT_VAL;
*/

	    		default : flash_a_dq_c = 8'h00;
	  	endcase
	end


	// Flash B output lines multiplexer
	always @ * begin
		case (flash_b_e_b_ctrl)
			2'd0 : FLASH_B_E_B = FPGA_CS_B;
			2'd1 : FLASH_B_E_B = 1'b0;
	  		2'd2 : FLASH_B_E_B = FPGA_DONE;
    			default : FLASH_B_E_B = 1'b1;
  		endcase
	end

	always @ * begin
		case (flash_b_g_b_ctrl)
			2'd0 : FLASH_B_G_B = FPGA_OE_B;
			2'd1 : FLASH_B_G_B = 1'b0;
		 	2'd2 : FLASH_B_G_B = FPGA_DONE;
	    		default : FLASH_B_G_B = 1'b1;
	  	endcase
	end

	always @ * begin
		case (flash_b_w_b_ctrl)
			2'd0 : FLASH_B_W_B = FPGA_WE_B;
			2'd1 : FLASH_B_W_B = 1'b0;
		  	2'd2 : FLASH_B_W_B = FPGA_DONE;
	    		default : FLASH_B_W_B = 1'b1;
	  	endcase
	end

	always @ * begin
		case (flash_b_dq_ctrl)
			3'd0 : flash_b_dq_c = FPGA_DQ;
			3'd1 : flash_b_dq_c = CMD_SET_CFG_REG;
		  	3'd2 : flash_b_dq_c = CMD_CNFRM_CFG_REG;
			3'd3 : flash_b_dq_c = CMD_READ_ELEC_SIG;
			3'd4 : flash_b_dq_c = CMD_READ_ARRAY;

/*			UNUSED
			'd5 : flash_b_dq_c = CMD_BLOCK_LOCK_SETUP;
			'd6 : flash_b_dq_c = CMD_CONFIRM;
			'd7 : flash_b_dq_c = CMD_PROGRAM_SETUP;
			'd8 : flash_b_dq_c = CMD_PROGRAM_INIT_VAL;
*/

	    		default : flash_b_dq_c = 8'h00;
	  	endcase
	end


	// Flash address line multiplexer
	always @ * begin
		case (flash_addr_ctrl)
			2'd0 : flash_addr = {1'b0, FPGA_A[22:0]};
			2'd1 : flash_addr = ASYNC_MODE_ADDR;
		  	2'd2 : flash_addr = flash_addr_cntr;
			default : flash_addr = 24'd0;
	  	endcase
	end


	// Counter for flash address generation on power-up FPGA configuration
	// Flash A/B
	// CPLD side - base address is always equal to zero (0)
	// FPGA side - base address is always equal to zero (0)
	always @ (posedge cpld_clk_100MHz_bufg)	begin
		if (!FPGA_PROG_B || !flash_addr_cntr_en)
			flash_addr_cntr <= 24'd0;
		else if (FPGA_INIT_B && clk_25MHz_en && flash_addr_cntr_en)
			flash_addr_cntr <= flash_addr_cntr + 24'd1;
	end


	// Master state machine for control logic
	always @ (posedge cpld_clk_100MHz_bufg) begin
	    if (clk_25MHz_en)
	    	mstr_cur_state <= mstr_nxt_state;
	end

	always @ * begin
		mstr_nxt_state = mstr_cur_state;

		flash_addr_ctrl = 2'd3;
		flash_sel_ctrl = 2'd0;
		flash_cmd_ctrl = 3'd0;
		flash_a_dq_ctrl = 3'h7;
		flash_b_dq_ctrl = 3'h7;

    		elec_sig_chk_en = 1'b0;

	   	case (mstr_cur_state)
		MSTR_IDLE : begin
				if (FLASH_A_RW && FLASH_B_RW)
					mstr_nxt_state = MSTR_SEND_CMD_SET_CFG_REG;
	    	end

	    	MSTR_SEND_CMD_SET_CFG_REG : begin
			flash_addr_ctrl = 2'd1; 	// ASYNC_MODE_ADDR
			flash_sel_ctrl = 2'd3; 		// FLASH A & B
			flash_cmd_ctrl = 3'd1; 		// Write Command
			flash_a_dq_ctrl = 3'd1; 	// CMD_SET_CFG_REG
	    	   	flash_b_dq_ctrl = 3'd1; 	// CMD_SET_CFG_REG

			if (cmd_cur_state == CMD_DONE)
				mstr_nxt_state = MSTR_SEND_CMD_CNFRM_CFG_REG;
	    	end

	    	MSTR_SEND_CMD_CNFRM_CFG_REG : begin
			flash_addr_ctrl = 2'd1; 	// ASYNC_MODE_ADDR
			flash_sel_ctrl = 2'd3; 		// FLASH A & B
			flash_cmd_ctrl = 3'd1; 		// Write Command
	    	   	flash_a_dq_ctrl = 3'd2; 	// CMD_CNFRM_CFG_REG
	    	   	flash_b_dq_ctrl = 3'd2;		// CMD_CNFRM_CFG_REG

	    	   	if (cmd_cur_state == CMD_DONE)
				mstr_nxt_state = MSTR_SEND_CMD_READ_ELEC_SIG;
	    	end

	    	MSTR_SEND_CMD_READ_ELEC_SIG : begin
			flash_sel_ctrl = 2'd3;		// FLASH A & B
			flash_cmd_ctrl = 3'd1; 		// Write Command
	    	   	flash_a_dq_ctrl = 3'd3;		// CMD_READ_ELEC_SIG
	    	   	flash_b_dq_ctrl = 3'd3; 	// CMD_READ_ELEC_SIG

	    	   	if (cmd_cur_state == CMD_DONE)
				mstr_nxt_state = MSTR_READ_ELEC_SIG;
	    	end

	    	MSTR_READ_ELEC_SIG : begin
			flash_sel_ctrl = 2'd3;		// FLASH A & B
			flash_cmd_ctrl = 3'd2; 		// Read Command
			elec_sig_chk_en = 1'b1;

	    	   	if (cmd_cur_state == CMD_DONE) begin
				if ((FLASH_A_DQ[7:0] != XIL_ELEC_ID) && (FLASH_B_DQ[7:0] != XIL_ELEC_ID))
					mstr_nxt_state =  MSTR_IDLE;
				else
					mstr_nxt_state = MSTR_SEND_CMD_READ_ARRAY;
			end
	    	end

	    	MSTR_SEND_CMD_READ_ARRAY : begin
			flash_sel_ctrl = 2'd3;		// FLASH A & B
	    	   	flash_cmd_ctrl = 3'd1; 		// Write Command
	    	   	flash_a_dq_ctrl = 3'd4;		// CMD_READ_ARRAY
	    	   	flash_b_dq_ctrl = 3'd4;		// CMD_READ_ARRAY

	    	   	if (cmd_cur_state == CMD_DONE) begin
				if (FPGA_DONE)
					mstr_nxt_state = MSTR_WAIT_4_PRG_REQ;
	    			else if (fpga_cfg_from_flash_a)
	    				mstr_nxt_state = MSTR_CONFIG_4RM_FLASH_A;
				else
	    				mstr_nxt_state = MSTR_CONFIG_4RM_FLASH_B;
			end
	    	end

	    	MSTR_CONFIG_4RM_FLASH_A : begin
			flash_addr_ctrl = 2'd2;		// flash_addr_cntr (Address generation)
	    	   	flash_sel_ctrl = 2'd1; 		// FLASH A
	    	   	flash_cmd_ctrl = 3'd4; 		// CFG Command

	    	   	if (cmd_cur_state == CMD_DONE)
				mstr_nxt_state = MSTR_SEND_CMD_READ_ARRAY;
	    	end

	    	MSTR_CONFIG_4RM_FLASH_B : begin
			flash_addr_ctrl = 2'd2;		// flash_addr_cntr (Address generation)
	    	   	flash_sel_ctrl = 2'd2; 		// FLASH B
	    	   	flash_cmd_ctrl = 3'd4; 		// CFG Command

	    	   	if (cmd_cur_state == CMD_DONE)
				mstr_nxt_state = MSTR_SEND_CMD_READ_ARRAY;
	    	end

	    	MSTR_WAIT_4_PRG_REQ : begin
    			flash_addr_ctrl = 2'd0;		// FPGA_A[22:0]
    			flash_sel_ctrl = {FPGA_A[23], ~FPGA_A[23]};
	    	   	flash_cmd_ctrl = 3'd3; 		// IO Command
    			flash_a_dq_ctrl = 3'd0;		// FPGA_DQ
    			flash_b_dq_ctrl = 3'd0;		// FPGA_DQ

	    		if (cmd_cur_state == CMD_DONE)
				mstr_nxt_state = MSTR_IDLE;
    		end
		endcase
	end


	// State machine for generating flash commands
	always @ (posedge cpld_clk_100MHz_bufg) begin
	    if (clk_25MHz_en)
	    	cmd_cur_state <= cmd_nxt_state;
	end

	always @ * begin
		cmd_nxt_state = cmd_cur_state;
		state_trans_cntr_en = 1'b0;

		fpga_cpld_rst = 1'b0;
      		flash_addr_cntr_en = 1'b0;

		flash_a_e_b_ctrl = 2'd3;
      		flash_a_w_b_ctrl = 2'd3;
      		flash_a_g_b_ctrl = 2'd3;
      		flash_b_e_b_ctrl = 2'd3;
      		flash_b_w_b_ctrl = 2'd3;
      		flash_b_g_b_ctrl = 2'd3;

	   	case (cmd_cur_state)
		CMD_IDLE : begin
			if (flash_cmd_ctrl == 3'd2 || flash_cmd_ctrl == 3'd1) begin // Read and Write
				state_trans_cntr_en = 1'b1;
	    	      		cmd_nxt_state = CMD_PHASE_CS_LOW;
	    	   	end
	    	   	else if (flash_cmd_ctrl == 3'd3) begin // IO
				cmd_nxt_state = CMD_PHASE_IO;
	    	   	end
	    	   	else if (flash_cmd_ctrl == 3'd4) begin // CFG
				cmd_nxt_state = CMD_CFG_FPGA;
			end
	    	end

	    	CMD_PHASE_CS_LOW : begin
	    		state_trans_cntr_en = 1'b1;

	    		if (flash_sel_ctrl[0])
	    			flash_a_e_b_ctrl = 2'd1;

    			if (flash_sel_ctrl[1])
    				flash_b_e_b_ctrl = 2'd1;

	    		if (state_trans_cntr > 10) begin
	    		    cmd_nxt_state = CMD_PHASE_WOE_LOW;
	    		end
	    	end

	    	CMD_PHASE_WOE_LOW : begin
	    		state_trans_cntr_en = 1'b1;

	    		if (flash_sel_ctrl[0]) begin
				flash_a_e_b_ctrl = 2'd1;

	    		 	if (flash_cmd_ctrl == 3'd1)
					flash_a_w_b_ctrl = 2'd1;

    				if (flash_cmd_ctrl == 3'd2)
    					flash_a_g_b_ctrl = 2'd1;
	    		end

	    		if (flash_sel_ctrl[1]) begin
    				flash_b_e_b_ctrl = 2'd1;

				if (flash_cmd_ctrl == 3'd1)
    					flash_b_w_b_ctrl = 2'd1;

    				if (flash_cmd_ctrl == 3'd2)
    					flash_b_g_b_ctrl = 2'd1;
    			end

	    		if (state_trans_cntr > 14) begin
				cmd_nxt_state = CMD_PHASE_WOE_HIGH;
	    		end
	    	end

	    	CMD_PHASE_WOE_HIGH : begin
	    		state_trans_cntr_en = 1'b1;

	    		if (flash_sel_ctrl[0])
	    			flash_a_e_b_ctrl = 2'd1;

    			if (flash_sel_ctrl[1])
    				flash_b_e_b_ctrl = 2'd1;

	    		// (state_trans_cntr > 15)
	    		cmd_nxt_state = CMD_PHASE_CS_HIGH;
	    	end

	    	CMD_PHASE_CS_HIGH : begin
	    		state_trans_cntr_en = 1'b1;

	    		// (state_trans_cntr > 16)
	    		cmd_nxt_state = CMD_PHASE_WAIT_ASYNC;
	    	end

	    	CMD_PHASE_WAIT_ASYNC : begin
	    		state_trans_cntr_en = 1'b1;

	    		if (state_trans_cntr > 20) begin
	    			cmd_nxt_state = CMD_DONE;
	    		end
	    	end

	    	CMD_PHASE_IO : begin
			if (flash_sel_ctrl[0]) begin
				flash_a_e_b_ctrl = 2'd0;
	    		   	flash_a_w_b_ctrl = 2'd0;
	    	    		flash_a_g_b_ctrl = 2'd0;
	    		end

	    		if (flash_sel_ctrl[1]) begin
	    		   	flash_b_e_b_ctrl = 2'd0;
	    		   	flash_b_w_b_ctrl = 2'd0;
	    	    		flash_b_g_b_ctrl = 2'd0;
	    		end

	    		if (fpga_prog_req) begin
	    			cmd_nxt_state = CMD_CFG_FPGA_DLY;
	    		end
	    		else if (!FPGA_PROG_B)
				cmd_nxt_state = CMD_DONE;
	    	end

		CMD_CFG_FPGA_DLY : begin
			state_trans_cntr_en = 1'b1;
			fpga_cpld_rst = 1'b1;

			if (state_trans_cntr > MAX_DLY_VAL) begin
	    			cmd_nxt_state = CMD_DONE;
	    		end
		end

	    	CMD_CFG_FPGA : begin
			if (flash_sel_ctrl[0]) begin
				flash_addr_cntr_en = 1'b1;
	    	   		flash_a_e_b_ctrl = 2'd2;
	    			flash_a_g_b_ctrl = 2'd2;
	    		end

	    		if (flash_sel_ctrl[1]) begin
	    	   		flash_addr_cntr_en = 1'b1;
	    	   		flash_b_e_b_ctrl = 2'd2;
	       			flash_b_g_b_ctrl = 2'd2;
	    		end

	    		if (FPGA_DONE)
	   			cmd_nxt_state = CMD_DONE;
	  	end

	  	CMD_DONE : begin
	  		cmd_nxt_state = CMD_IDLE;
		end
		endcase
	end

endmodule
