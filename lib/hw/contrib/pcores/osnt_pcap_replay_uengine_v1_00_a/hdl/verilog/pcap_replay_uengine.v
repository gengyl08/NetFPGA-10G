/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        pcap_replay_uengine.v
 *
 *  Library:
 *        hw/osnt/pcores/nf10_pcap_replay_uengine_v1_00_a
 *
 *  Module:
 *        pcap_replay_uengine
 *
 *  Author:
 *        Muhammad Shahbaz
 *
 *  Description:
 *
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
 *        MERCHANTABILITY or FITNESS FOR A PARTICULAqR PURPOSE.  See the GNU
 *        Lesser General Public License for more details.
 *
 *        You should have received a copy of the GNU Lesser General Public
 *        License along with the NetFPGA source package.  If not, see
 *        http://www.gnu.org/licenses/.
 *
 */


// TODO: 
// (1) Add support for the third SRAM

module pcap_replay_uengine
#(
    //Master AXI Stream Data Width
    parameter C_M_AXIS_DATA_WIDTH  = 256,
    parameter C_S_AXIS_DATA_WIDTH  = 256,
    parameter C_M_AXIS_TUSER_WIDTH = 128,
    parameter C_S_AXIS_TUSER_WIDTH = 128,
    parameter C_S_AXI_DATA_WIDTH   = 32,
	  parameter C_NUM_QUEUES 				 = 4,
		parameter DST_PORT_POS         = 24,
    parameter QDR_NUM_CHIPS        = 3,
    parameter QDR_DATA_WIDTH       = 36,
    parameter QDR_ADDR_WIDTH       = 19,
    parameter QDR_BW_WIDTH         = 4,
    parameter QDR_CQ_WIDTH         = 1,
    parameter QDR_CLK_WIDTH        = 1,
		parameter QDR_BURST_LENGTH     = 4,
		parameter QDR_CLK_PERIOD       = 4000,
		parameter REPLAY_COUNT_WIDTH   = 32,
		parameter SIM_ONLY             = 0
)
(
    output reg     [31:0]                              drop_count_0,
    output reg     [31:0]                              drop_count_1,
    output reg     [31:0]                              drop_count_2,
    output reg     [31:0]                              drop_count_3,

    input     [31:0]                                split_ratio_0,
    input     [31:0]                                split_ratio_1,
    input     [31:0]                                split_ratio_2,

    // Global Ports
    input                                           axi_aclk,
    input                                           axi_aresetn,
		
		input 																					dcm_locked,
                                                    
    input                                           qdr_clk,
    input                                           qdr_clk_200,
    input                                           qdr_clk_270,

    // Master Stream Ports (interface to data path)
    output     [C_M_AXIS_DATA_WIDTH-1:0]            m_axis_tdata_0,
    output     [((C_M_AXIS_DATA_WIDTH/8))-1:0]      m_axis_tstrb_0,
    output     [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_tuser_0,
    output                                          m_axis_tvalid_0,
    input                                           m_axis_tready_0,
    output                                          m_axis_tlast_0,
		
    output     [C_M_AXIS_DATA_WIDTH-1:0]            m_axis_tdata_1,
    output     [((C_M_AXIS_DATA_WIDTH/8))-1:0]      m_axis_tstrb_1,
    output     [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_tuser_1,
    output                                          m_axis_tvalid_1,
    input                                           m_axis_tready_1,
    output                                          m_axis_tlast_1,
		
    output     [C_M_AXIS_DATA_WIDTH-1:0]            m_axis_tdata_2,
    output     [((C_M_AXIS_DATA_WIDTH/8))-1:0]      m_axis_tstrb_2,
    output     [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_tuser_2,
    output                                          m_axis_tvalid_2,
    input                                           m_axis_tready_2,
    output                                          m_axis_tlast_2,
		
    output     [C_M_AXIS_DATA_WIDTH-1:0]            m_axis_tdata_3,
    output     [((C_M_AXIS_DATA_WIDTH/8))-1:0]      m_axis_tstrb_3,
    output     [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_tuser_3,
    output                                          m_axis_tvalid_3,
    input                                           m_axis_tready_3,
    output                                          m_axis_tlast_3,

    // Slave Stream Ports (interface to RX queues)
    input [C_S_AXIS_DATA_WIDTH-1:0]            			s_axis_tdata,
    input [((C_S_AXIS_DATA_WIDTH/8))-1:0]      			s_axis_tstrb,
    input [C_S_AXIS_TUSER_WIDTH-1:0]           			s_axis_tuser,
    input                                      			s_axis_tvalid,
    output                                     			s_axis_tready,
    input                                      			s_axis_tlast,
                                               			
    // QDR Memory Interface                    			
    input [(QDR_DATA_WIDTH)-1:0]               			qdr_q_0,
    input [QDR_CQ_WIDTH-1:0]                   			qdr_cq_0,
    input [QDR_CQ_WIDTH-1:0]                   			qdr_cq_n_0,
    output [QDR_CLK_WIDTH-1:0]                 			qdr_c_0,
    output [QDR_CLK_WIDTH-1:0]                 			qdr_c_n_0,
    output                                     			qdr_dll_off_n_0,
    output [QDR_CLK_WIDTH-1:0]                 			qdr_k_0,
    output [QDR_CLK_WIDTH-1:0]                 			qdr_k_n_0,
    output [QDR_ADDR_WIDTH-1:0]                			qdr_sa_0,
    output [(QDR_BW_WIDTH)-1:0]                			qdr_bw_n_0,
    output                                     			qdr_w_n_0,
    output [(QDR_DATA_WIDTH)-1:0]              			qdr_d_0,
    output                                     			qdr_r_n_0,
    input 					                 								qdr_masterbank_sel_0,
                                               			
    input [(QDR_DATA_WIDTH)-1:0]               			qdr_q_1,
    input [QDR_CQ_WIDTH-1:0]                   			qdr_cq_1,
    input [QDR_CQ_WIDTH-1:0]                   			qdr_cq_n_1,
    output [QDR_CLK_WIDTH-1:0]                 			qdr_c_1,
    output [QDR_CLK_WIDTH-1:0]                 			qdr_c_n_1,
    output                                     			qdr_dll_off_n_1,
    output [QDR_CLK_WIDTH-1:0]                 			qdr_k_1,
    output [QDR_CLK_WIDTH-1:0]                 			qdr_k_n_1,
    output [QDR_ADDR_WIDTH-1:0]                			qdr_sa_1,
    output [(QDR_BW_WIDTH)-1:0]                			qdr_bw_n_1,
    output                                     			qdr_w_n_1,
    output [(QDR_DATA_WIDTH)-1:0]              			qdr_d_1,
    output                                     			qdr_r_n_1,
    input 					                 								qdr_masterbank_sel_1,
                                               			
    input [(QDR_DATA_WIDTH)-1:0]               			qdr_q_2,
    input [QDR_CQ_WIDTH-1:0]                   			qdr_cq_2,
    input [QDR_CQ_WIDTH-1:0]                   			qdr_cq_n_2,
    output [QDR_CLK_WIDTH-1:0]                 			qdr_c_2,
    output [QDR_CLK_WIDTH-1:0]                 			qdr_c_n_2,
    output                                     			qdr_dll_off_n_2,
    output [QDR_CLK_WIDTH-1:0]                 			qdr_k_2,
    output [QDR_CLK_WIDTH-1:0]                 			qdr_k_n_2,
    output [QDR_ADDR_WIDTH-1:0]                			qdr_sa_2,
    output [(QDR_BW_WIDTH)-1:0]                			qdr_bw_n_2,
    output                                     			qdr_w_n_2,
    output [(QDR_DATA_WIDTH)-1:0]              			qdr_d_2,
    output                                     			qdr_r_n_2,
    input 					                 								qdr_masterbank_sel_2
);

  // -- Local Functions
  function integer log2;
    input integer number;
    begin
       log2=0;
       while(2**log2<number) begin
          log2=log2+1;
       end
    end
  endfunction

  // -- Internal Parameters
  localparam IODELAY_GRP = "IODELAY_MIG";
	
  // -- Signals
  
  genvar i;

  wire [QDR_ADDR_WIDTH-3:0]                      q0_addr_head;
  wire [QDR_ADDR_WIDTH-3:0]                      q0_addr_tail;
  wire [QDR_ADDR_WIDTH-3:0]                      q1_addr_head;
  wire [QDR_ADDR_WIDTH-3:0]                      q1_addr_tail;
  wire [QDR_ADDR_WIDTH-3:0]                      q2_addr_head;
  wire [QDR_ADDR_WIDTH-3:0]                      q2_addr_tail;
  wire [QDR_ADDR_WIDTH-3:0]                      q3_addr_head;
  wire [QDR_ADDR_WIDTH-3:0]                      q3_addr_tail;

  wire [31:0]                                    drop_count_0_sram;
  wire [31:0]                                    drop_count_1_sram;
  wire [31:0]                                    drop_count_2_sram;
  wire [31:0]                                    drop_count_3_sram;
	
	wire qdr_clk_180;
	wire user_rst, user_rst_180, user_rst_200, user_rst_270;
  wire idelay_ctrl_rdy;
				
  wire                                       								 			fifo_wr_rd_en;
  wire [QDR_NUM_CHIPS*QDR_DATA_WIDTH*2-1:0]  								 			fifo_wr_data;
	wire [log2(C_NUM_QUEUES)-1:0]  						 								 			fifo_wr_qid;
  wire                                       								 			fifo_wr_empty;
	                                           								 
  wire                    								 									 			q0_fifo_rd_wr_en;
  wire [QDR_NUM_CHIPS*(QDR_DATA_WIDTH*(QDR_BURST_LENGTH/2))-1:0] 	q0_fifo_rd_data;
  wire                                 										 	 			q0_fifo_rd_full;
	wire                                 										 	 			q0_fifo_rd_prog_full;
  wire                    								 									 			q1_fifo_rd_wr_en;
  wire [QDR_NUM_CHIPS*(QDR_DATA_WIDTH*(QDR_BURST_LENGTH/2))-1:0] 	q1_fifo_rd_data;
  wire                                 										 	 			q1_fifo_rd_full;
	wire                                 										 	 			q1_fifo_rd_prog_full;
  wire                    								 									 			q2_fifo_rd_wr_en;
  wire [QDR_NUM_CHIPS*(QDR_DATA_WIDTH*(QDR_BURST_LENGTH/2))-1:0] 	q2_fifo_rd_data;
  wire                                 										 	 			q2_fifo_rd_full;
	wire                                 										 	 			q2_fifo_rd_prog_full;
  wire                    								 									 			q3_fifo_rd_wr_en;
  wire [QDR_NUM_CHIPS*(QDR_DATA_WIDTH*(QDR_BURST_LENGTH/2))-1:0] 	q3_fifo_rd_data;
  wire                                 										 	 			q3_fifo_rd_full;
	wire                                 										 	 			q3_fifo_rd_prog_full;
	                                                           
	wire                    									 								 			user_ad_w_n;
  wire		                 									 								 			user_d_w_n;
	wire [QDR_NUM_CHIPS-1:0]									 								 			user_wr_full;
  wire [QDR_ADDR_WIDTH-1:0]  								 								 			user_ad_wr;
  wire [QDR_BW_WIDTH-1:0]    								 								 			user_bwh_n;
  wire [QDR_BW_WIDTH-1:0]    								 								 			user_bwl_n;
  wire [QDR_NUM_CHIPS*QDR_DATA_WIDTH-1:0]  	 								 			user_dwl;
  wire [QDR_NUM_CHIPS*QDR_DATA_WIDTH-1:0]  	 								 			user_dwh;
	                                                           			
	wire																			 								 			user_r_n;
	wire [QDR_NUM_CHIPS-1:0]									 								 			user_rd_full;
	wire [QDR_ADDR_WIDTH-1:0]  								 								 			user_ad_rd;
	wire [QDR_NUM_CHIPS-1:0]									 								 			user_qr_valid;
  wire [QDR_NUM_CHIPS*QDR_DATA_WIDTH-1:0]  	 								 			user_qrl;
  wire [QDR_NUM_CHIPS*QDR_DATA_WIDTH-1:0]  	 								 			user_qrh;
	                                                           			
  wire [QDR_NUM_CHIPS*QDR_DATA_WIDTH-1:0]    								 			qdr_q;
  wire [QDR_NUM_CHIPS*QDR_CQ_WIDTH-1:0]      								 			qdr_cq;
  wire [QDR_NUM_CHIPS*QDR_CQ_WIDTH-1:0]      								 			qdr_cq_n;
  wire [QDR_NUM_CHIPS*QDR_CLK_WIDTH-1:0]     								 			qdr_c;
  wire [QDR_NUM_CHIPS*QDR_CLK_WIDTH-1:0]     								 			qdr_c_n;
  wire [QDR_NUM_CHIPS-1:0]                   								 			qdr_dll_off_n;
  wire [QDR_NUM_CHIPS*QDR_CLK_WIDTH-1:0]     								 			qdr_k;
  wire [QDR_NUM_CHIPS*QDR_CLK_WIDTH-1:0]     								 			qdr_k_n;
  wire [QDR_NUM_CHIPS*QDR_ADDR_WIDTH-1:0]    								 			qdr_sa;
  wire [QDR_NUM_CHIPS*QDR_BW_WIDTH-1:0]      								 			qdr_bw_n;
  wire [QDR_NUM_CHIPS-1:0]                   								 			qdr_w_n;
  wire [QDR_NUM_CHIPS*QDR_DATA_WIDTH-1:0]    								 			qdr_d;
  wire [QDR_NUM_CHIPS-1:0]            			 								 			qdr_r_n;
	                                                           			
	wire [QDR_NUM_CHIPS-1:0] 									 								 			cal_done;

  wire                                                            drop_count_fifo_full;
  wire                                                            drop_count_fifo_empty;
  wire [127:0]                                                    drop_count_fifo_dout;
	
	// -- Assignments

	assign qdr_q                                               			= {qdr_q_2,    qdr_q_1,    qdr_q_0};
	assign qdr_cq                                              			= {qdr_cq_2,   qdr_cq_1,   qdr_cq_0};
	assign qdr_cq_n                                            			= {qdr_cq_n_2, qdr_cq_n_1, qdr_cq_n_0};
  assign {qdr_c_2,         qdr_c_1,         qdr_c_0}         			= qdr_c;
	assign {qdr_c_n_2,       qdr_c_n_1,       qdr_c_n_0}       			= qdr_c_n;
	assign {qdr_dll_off_n_2, qdr_dll_off_n_1, qdr_dll_off_n_0} 			= qdr_dll_off_n;
  assign {qdr_k_2,         qdr_k_1,         qdr_k_0}         			= qdr_k;
	assign {qdr_k_n_2,       qdr_k_n_1,       qdr_k_n_0}       			= qdr_k_n;
  assign {qdr_sa_2,        qdr_sa_1,        qdr_sa_0}        			= qdr_sa;
  assign {qdr_bw_n_2,      qdr_bw_n_1,      qdr_bw_n_0}      			= qdr_bw_n;
  assign {qdr_w_n_2,       qdr_w_n_1,       qdr_w_n_0}       			= qdr_w_n;
  assign {qdr_d_2,         qdr_d_1,         qdr_d_0}         			= qdr_d;
  assign {qdr_r_n_2,       qdr_r_n_1,       qdr_r_n_0}       			= qdr_r_n;

  // -- Modules and Logic

  always @ (posedge axi_aclk) begin
    if (!drop_count_fifo_empty) begin
      {drop_count_3, drop_count_2, drop_count_1, drop_count_0} <= drop_count_fifo_dout;
    end
  end

  fifo_generator_v8_4_128_to_128_fwft
    drop_count_fifo
  (
    .rst                      (!axi_aresetn),
    .wr_clk                   (qdr_clk),
    .rd_clk                   (axi_aclk),
    .din                      ({drop_count_3_sram, drop_count_2_sram, drop_count_1_sram, drop_count_0_sram}),
    .wr_en                    (!drop_count_fifo_full),
    .rd_en                    (!drop_count_fifo_empty),
    .dout                     (drop_count_fifo_dout),
    .full                     (drop_count_fifo_full),
    .empty                    (drop_count_fifo_empty)
  );

  axis_to_fifo #(
    .C_S_AXIS_DATA_WIDTH  		(C_S_AXIS_DATA_WIDTH),
    .C_S_AXIS_TUSER_WIDTH 		(C_S_AXIS_TUSER_WIDTH),
    .FIFO_DATA_WIDTH      		(QDR_NUM_CHIPS*(QDR_DATA_WIDTH*(QDR_BURST_LENGTH/2))),
		.NUM_QUEUES								(C_NUM_QUEUES),
		.DST_PORT_POS							(DST_PORT_POS)
  )                       		
     axis_to_fifo_inst    		
  (                       		
    .axi_aclk             		(axi_aclk),
    .axi_aresetn          		(axi_aresetn),
    .fifo_clk             		(qdr_clk),
                          		
    .s_axis_tdata         		(s_axis_tdata),
    .s_axis_tstrb         		(s_axis_tstrb),
    .s_axis_tuser         		(s_axis_tuser),
    .s_axis_tvalid        		(s_axis_tvalid),
    .s_axis_tready        		(s_axis_tready),
    .s_axis_tlast         		(s_axis_tlast),
                          		
    .fifo_rd_en           		(fifo_wr_rd_en),
    .fifo_dout            		(fifo_wr_data),
		.fifo_dout_qid						(fifo_wr_qid),
    .fifo_empty           		(fifo_wr_empty),

    .split_ratio_0            (split_ratio_0),
    .split_ratio_1            (split_ratio_1),
    .split_ratio_2            (split_ratio_2)
  );

	fifo_to_mem #(
    .FIFO_DATA_WIDTH      		(QDR_NUM_CHIPS*(QDR_DATA_WIDTH*(QDR_BURST_LENGTH/2))),
		.NUM_QUEUES								(C_NUM_QUEUES),
		.MEM_ADDR_WIDTH       		(QDR_ADDR_WIDTH),
		.MEM_DATA_WIDTH       		(QDR_NUM_CHIPS*QDR_DATA_WIDTH),
		.MEM_BW_WIDTH         		(QDR_BW_WIDTH),
		.MEM_BURST_LENGTH					(QDR_BURST_LENGTH)    
	)
	  fifo_to_mem_inst
	(
      .drop_count_0           (drop_count_0_sram),
      .drop_count_1           (drop_count_1_sram),
      .drop_count_2           (drop_count_2_sram),
      .drop_count_3           (drop_count_3_sram),
	    .clk										(qdr_clk),
			.rst										(user_rst),
                          		
	    .fifo_rd_en							(fifo_wr_rd_en),
	    .fifo_data							(fifo_wr_data),
			.fifo_qid								(fifo_wr_qid),
	    .fifo_empty							(fifo_wr_empty),
		                      		
	    .mem_ad_w_n							(user_ad_w_n),
	    .mem_d_w_n							(user_d_w_n),
			.mem_wr_full						(|user_wr_full),
	    .mem_ad_wr							(user_ad_wr),
	    .mem_bwh_n							(user_bwh_n),
	    .mem_bwl_n							(user_bwl_n),
	    .mem_dwl								(user_dwl),
	    .mem_dwh								(user_dwh),
			                    		
			.q0_addr_head						(q0_addr_head),
			.q0_addr_tail						(q0_addr_tail),
			.q1_addr_head					  (q1_addr_head),
			.q1_addr_tail						(q1_addr_tail),
			.q2_addr_head						(q2_addr_head),
			.q2_addr_tail						(q2_addr_tail),
			.q3_addr_head						(q3_addr_head),
			.q3_addr_tail						(q3_addr_tail),
			
			.cal_done								(&cal_done)
	);
	
  generate
    for(i=0; i<QDR_NUM_CHIPS; i=i+1)
    begin : _qdrii_controller
    	qdrii_top #(
      	.ADDR_WIDTH             (QDR_ADDR_WIDTH),
        .BURST_LENGTH           (QDR_BURST_LENGTH),
        .BW_WIDTH               (QDR_BW_WIDTH),
        .CLK_PERIOD             (QDR_CLK_PERIOD),
        //.CLK_FREQ             (160),
        .CLK_WIDTH              (QDR_CLK_WIDTH),
        .CQ_WIDTH               (QDR_CQ_WIDTH),
        .DATA_WIDTH             (QDR_DATA_WIDTH),
        .DEBUG_EN               (0),
        .HIGH_PERFORMANCE_MODE  ("TRUE"),
        .IODELAY_GRP            (IODELAY_GRP),
        .MEMORY_WIDTH           (QDR_DATA_WIDTH),
        .SIM_ONLY								(SIM_ONLY)	
			)
      	_inst
      (
        .clk0                   (qdr_clk),
        .clk180                 (qdr_clk_180),
        .clk270                 (qdr_clk_270),
        .user_rst_0							(user_rst),
        .user_rst_180						(user_rst_180),
        .user_rst_270						(user_rst_270),
				
        .user_ad_w_n            (user_ad_w_n),
        .user_ad_wr             (user_ad_wr),
        .user_wr_full           (user_wr_full[i]),
        .user_d_w_n             (user_d_w_n),
        .user_bwh_n             (user_bwh_n),
        .user_bwl_n             (user_bwl_n),
        .user_dwl               (user_dwl[QDR_DATA_WIDTH*(i+1)-1:QDR_DATA_WIDTH*i]),
        .user_dwh               (user_dwh[QDR_DATA_WIDTH*(i+1)-1:QDR_DATA_WIDTH*i]),
        
				.user_r_n               (user_r_n),
        .user_ad_rd             (user_ad_rd),         
        .user_rd_full           (user_rd_full[i]),
        .user_qr_valid          (user_qr_valid[i]),
        .user_qrl               (user_qrl[QDR_DATA_WIDTH*(i+1)-1:QDR_DATA_WIDTH*i]),
        .user_qrh               (user_qrh[QDR_DATA_WIDTH*(i+1)-1:QDR_DATA_WIDTH*i]),
        
        .idelay_ctrl_rdy        (idelay_ctrl_rdy),
        
				.qdr_q                  (qdr_q[QDR_DATA_WIDTH*(i+1)-1:QDR_DATA_WIDTH*i]), 
        .qdr_cq                 (qdr_cq[QDR_CQ_WIDTH*(i+1)-1:QDR_CQ_WIDTH*i]), 
        .qdr_cq_n               (qdr_cq_n[QDR_CQ_WIDTH*(i+1)-1:QDR_CQ_WIDTH*i]), 
        .qdr_c                  (qdr_c[QDR_CLK_WIDTH*(i+1)-1:QDR_CLK_WIDTH*i]),
        .qdr_c_n                (qdr_c_n[QDR_CLK_WIDTH*(i+1)-1:QDR_CLK_WIDTH*i]),
        .qdr_dll_off_n          (qdr_dll_off_n[i]),
        .qdr_k                  (qdr_k[QDR_CLK_WIDTH*(i+1)-1:QDR_CLK_WIDTH*i]),
        .qdr_k_n                (qdr_k_n[QDR_CLK_WIDTH*(i+1)-1:QDR_CLK_WIDTH*i]),
        .qdr_sa                 (qdr_sa[QDR_ADDR_WIDTH*(i+1)-1:QDR_ADDR_WIDTH*i]),
        .qdr_bw_n               (qdr_bw_n[QDR_BW_WIDTH*(i+1)-1:QDR_BW_WIDTH*i]),
        .qdr_w_n                (qdr_w_n[i]),
        .qdr_d                  (qdr_d[QDR_DATA_WIDTH*(i+1)-1:QDR_DATA_WIDTH*i]),
        .qdr_r_n                (qdr_r_n[i]),
        .cal_done               (cal_done[i]),
				
        .dbg_idel_up_all        (1'b0),
        .dbg_idel_down_all      (1'b0),
        .dbg_idel_up_q_cq       (1'b0),
        .dbg_idel_down_q_cq     (1'b0),
        .dbg_idel_up_q_cq_n     (1'b0),
        .dbg_idel_down_q_cq_n   (1'b0),
        .dbg_idel_up_cq         (1'b0),
        .dbg_idel_down_cq       (1'b0),
        .dbg_idel_up_cq_n       (1'b0),
        .dbg_idel_down_cq_n     (1'b0),
        .dbg_sel_idel_q_cq      ({QDR_CQ_WIDTH{1'b0}}),
        .dbg_sel_all_idel_q_cq  (1'b0),
        .dbg_sel_idel_q_cq_n    ({QDR_CQ_WIDTH{1'b0}}),
        .dbg_sel_all_idel_q_cq_n(1'b0),
        .dbg_sel_idel_cq        ({QDR_CQ_WIDTH{1'b0}}),
        .dbg_sel_all_idel_cq    (1'b0),
        .dbg_sel_idel_cq_n      ({QDR_CQ_WIDTH{1'b0}}),
        .dbg_sel_all_idel_cq_n  (1'b0)
		  );
    end
  endgenerate 
	
  qdrii_infrastructure #(
  	.RST_ACT_LOW (1)
  )
  	u_qdrii_infrastructure
  (
   	.sys_rst_n              (axi_aresetn),
   	.locked                 (dcm_locked),
   	.user_rst_0             (user_rst),
   	.user_rst_180           (user_rst_180),
   	.user_rst_270           (user_rst_270),
   	.user_rst_200           (user_rst_200),
   	.idelay_ctrl_rdy        (idelay_ctrl_rdy),
   	.clk0                   (qdr_clk),
   	.clk180                 (qdr_clk_180),
   	.clk270                 (qdr_clk_270),
   	.clk200                 (qdr_clk_200)
  );

  qdrii_idelay_ctrl #(
		.IODELAY_GRP (IODELAY_GRP)
  )
	  u_qdrii_idelay_ctrl
  (
    .user_rst_200    (user_rst_200),
    .idelay_ctrl_rdy (idelay_ctrl_rdy),
    .clk200          (qdr_clk_200)
  );
	
  // TODO: add calibration state machine (not sure if needed)

  (* KEEP = "TRUE" *) wire [QDR_NUM_CHIPS-1:0] qdr_masterbank_sel /*synthesis syn_keep = 1 */;
	(* KEEP = "TRUE" *) wire [QDR_NUM_CHIPS-1:0] qdr_masterbank_sel_o /*synthesis syn_keep = 1 */;
	
	assign qdr_masterbank_sel = {qdr_masterbank_sel_2, qdr_masterbank_sel_1, qdr_masterbank_sel_0};
	
	generate
	  for(i=0; i<QDR_NUM_CHIPS; i=i+1) begin: _dummy_masterbank
	    MUXCY _inst
	    (
	      .O  (qdr_masterbank_sel_o[i]),
	      .CI (qdr_masterbank_sel[i]),
	      .DI (1'b0),
	      .S  (1'b1)
	    )/* synthesis syn_noprune = 1 */;
	  end
	endgenerate
	
	mem_to_fifo #(
		.NUM_QUEUES     			(C_NUM_QUEUES),
    .FIFO_DATA_WIDTH      (QDR_NUM_CHIPS*(QDR_DATA_WIDTH*(QDR_BURST_LENGTH/2))),
		.MEM_ADDR_WIDTH       (QDR_ADDR_WIDTH),
		.MEM_DATA_WIDTH       (QDR_NUM_CHIPS*QDR_DATA_WIDTH),
		.MEM_BW_WIDTH         (QDR_BW_WIDTH),
		.MEM_BURST_LENGTH			(QDR_BURST_LENGTH),    
		.REPLAY_COUNT_WIDTH   (REPLAY_COUNT_WIDTH),
		.SIM_ONLY							(SIM_ONLY)
	)
		mem_to_fifo_inst
	(
    .clk									(qdr_clk),
		.rst									(user_rst),
	                      	
	  .mem_r_n							(user_r_n),
		.mem_rd_full					(|user_rd_full),
	  .mem_ad_rd						(user_ad_rd),
		.mem_qr_valid					(user_qr_valid),
	  .mem_qrl							(user_qrl),
	  .mem_qrh							(user_qrh),
	                      	
	  .q0_fifo_wr_en				(q0_fifo_rd_wr_en),
	  .q0_fifo_data					(q0_fifo_rd_data),
	  .q0_fifo_full					(q0_fifo_rd_full),
		.q0_fifo_prog_full		(q0_fifo_rd_prog_full),
	  
		.q1_fifo_wr_en				(q1_fifo_rd_wr_en),
	  .q1_fifo_data					(q1_fifo_rd_data),
	  .q1_fifo_full					(q1_fifo_rd_full),
		.q1_fifo_prog_full		(q1_fifo_rd_prog_full),
	  
		.q2_fifo_wr_en				(q2_fifo_rd_wr_en),
	  .q2_fifo_data					(q2_fifo_rd_data),
	  .q2_fifo_full					(q2_fifo_rd_full),
		.q2_fifo_prog_full		(q2_fifo_rd_prog_full),
	  
		.q3_fifo_wr_en				(q3_fifo_rd_wr_en),
	  .q3_fifo_data					(q3_fifo_rd_data),
	  .q3_fifo_full					(q3_fifo_rd_full),
		.q3_fifo_prog_full		(q3_fifo_rd_prog_full),
	                      	
		.q0_addr_head           (q0_addr_head),
    .q0_addr_tail           (q0_addr_tail),
    .q1_addr_head           (q1_addr_head),
    .q1_addr_tail           (q1_addr_tail),
    .q2_addr_head           (q2_addr_head),
    .q2_addr_tail           (q2_addr_tail),
    .q3_addr_head           (q3_addr_head),
    .q3_addr_tail           (q3_addr_tail),
		                    	
		.cal_done							(&cal_done)
	);
	
  generate
    if (C_NUM_QUEUES > 0) begin : _q0	
  		fifo_to_axis #(
  		  .C_M_AXIS_DATA_WIDTH  (C_M_AXIS_DATA_WIDTH),
  		  .C_M_AXIS_TUSER_WIDTH (C_M_AXIS_TUSER_WIDTH),
  		  .FIFO_DATA_WIDTH      (QDR_NUM_CHIPS*(QDR_DATA_WIDTH*(QDR_BURST_LENGTH/2)))
  		)
  		  _inst
  		(
  		  .axi_aclk             (axi_aclk),
  		  .axi_aresetn          (axi_aresetn),
  		  .fifo_clk             (qdr_clk),
				
  		  .fifo_wr_en           (q0_fifo_rd_wr_en),
  		  .fifo_din             (q0_fifo_rd_data),
  		  .fifo_full            (q0_fifo_rd_full),
				.fifo_prog_full       (q0_fifo_rd_prog_full),
  		
  		  .m_axis_tdata         (m_axis_tdata_0),
  		  .m_axis_tstrb         (m_axis_tstrb_0),
  		  .m_axis_tuser         (m_axis_tuser_0),
  		  .m_axis_tvalid        (m_axis_tvalid_0),
  		  .m_axis_tready        (m_axis_tready_0),
  		  .m_axis_tlast         (m_axis_tlast_0)
  		);
		end
		
    if (C_NUM_QUEUES > 1) begin : _q1	
  		fifo_to_axis #(
  		  .C_M_AXIS_DATA_WIDTH  (C_M_AXIS_DATA_WIDTH),
  		  .C_M_AXIS_TUSER_WIDTH (C_M_AXIS_TUSER_WIDTH),
  		  .FIFO_DATA_WIDTH      (QDR_NUM_CHIPS*(QDR_DATA_WIDTH*(QDR_BURST_LENGTH/2)))
  		)
  		  _inst
  		(
  		  .axi_aclk             (axi_aclk),
  		  .axi_aresetn          (axi_aresetn),
  		  .fifo_clk             (qdr_clk),
				
  		  .fifo_wr_en           (q1_fifo_rd_wr_en),
  		  .fifo_din             (q1_fifo_rd_data),
  		  .fifo_full            (q1_fifo_rd_full),
				.fifo_prog_full       (q1_fifo_rd_prog_full),
  		
  		  .m_axis_tdata         (m_axis_tdata_1),
  		  .m_axis_tstrb         (m_axis_tstrb_1),
  		  .m_axis_tuser         (m_axis_tuser_1),
  		  .m_axis_tvalid        (m_axis_tvalid_1),
  		  .m_axis_tready        (m_axis_tready_1),
  		  .m_axis_tlast         (m_axis_tlast_1)
  		);
		end
		
    if (C_NUM_QUEUES > 2) begin : _q2	
  		fifo_to_axis #(
  		  .C_M_AXIS_DATA_WIDTH  (C_M_AXIS_DATA_WIDTH),
  		  .C_M_AXIS_TUSER_WIDTH (C_M_AXIS_TUSER_WIDTH),
  		  .FIFO_DATA_WIDTH      (QDR_NUM_CHIPS*(QDR_DATA_WIDTH*(QDR_BURST_LENGTH/2)))
  		)
  		  _inst
  		(
  		  .axi_aclk             (axi_aclk),
  		  .axi_aresetn          (axi_aresetn),
  		  .fifo_clk             (qdr_clk),
				
  		  .fifo_wr_en           (q2_fifo_rd_wr_en),
  		  .fifo_din             (q2_fifo_rd_data),
  		  .fifo_full            (q2_fifo_rd_full),
				.fifo_prog_full       (q2_fifo_rd_prog_full),
  		
  		  .m_axis_tdata         (m_axis_tdata_2),
  		  .m_axis_tstrb         (m_axis_tstrb_2),
  		  .m_axis_tuser         (m_axis_tuser_2),
  		  .m_axis_tvalid        (m_axis_tvalid_2),
  		  .m_axis_tready        (m_axis_tready_2),
  		  .m_axis_tlast         (m_axis_tlast_2)
  		);
		end
		
    if (C_NUM_QUEUES > 3) begin : _q3	
  		fifo_to_axis #(
  		  .C_M_AXIS_DATA_WIDTH  (C_M_AXIS_DATA_WIDTH),
  		  .C_M_AXIS_TUSER_WIDTH (C_M_AXIS_TUSER_WIDTH),
  		  .FIFO_DATA_WIDTH      (QDR_NUM_CHIPS*(QDR_DATA_WIDTH*(QDR_BURST_LENGTH/2)))
  		)
  		  _inst
  		(
  		  .axi_aclk             (axi_aclk),
  		  .axi_aresetn          (axi_aresetn),
  		  .fifo_clk             (qdr_clk),
				
  		  .fifo_wr_en           (q3_fifo_rd_wr_en),
  		  .fifo_din             (q3_fifo_rd_data),
  		  .fifo_full            (q3_fifo_rd_full),
				.fifo_prog_full       (q3_fifo_rd_prog_full),
  		
  		  .m_axis_tdata         (m_axis_tdata_3),
  		  .m_axis_tstrb         (m_axis_tstrb_3),
  		  .m_axis_tuser         (m_axis_tuser_3),
  		  .m_axis_tvalid        (m_axis_tvalid_3),
  		  .m_axis_tready        (m_axis_tready_3),
  		  .m_axis_tlast         (m_axis_tlast_3)
  		);
		end
	endgenerate

endmodule

