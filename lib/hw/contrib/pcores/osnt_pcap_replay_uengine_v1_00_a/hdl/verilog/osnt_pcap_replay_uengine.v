/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        osnt_pcap_replay_uengine.v
 *
 *  Library:
 *        osnt/pcores/osnt_pcap_replay_uengine_v1_00_a
 *
 *  Module:
 *        nf10_pcap_replay_uengine
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
 *        WITHOUT ANY WARRANTY; without even the implqied warranty of
 *        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *        Lesser General Public License for more details.
 *
 *        You should have received a copy of the GNU Lesser General Public
 *        License along with the NetFPGA source package.  If not, see
 *        http://www.gnu.org/licenses/.
 *
 */

// TODO:
// (1) Optimize the code using generate
// (2) Add per queue (correct) enable/disbale support

`uselib lib=unisims_ver
`uselib lib=proc_common_v3_00_a

module osnt_pcap_replay_uengine
#(
  parameter C_S_AXI_DATA_WIDTH   = 32,
  parameter C_S_AXI_ADDR_WIDTH   = 32,
  parameter C_BASEADDR           = 32'hFFFFFFFF,
  parameter C_HIGHADDR           = 32'h00000000,
  parameter C_USE_WSTRB          = 0,
  parameter C_DPHASE_TIMEOUT     = 0,
  parameter C_S_AXI_ACLK_FREQ_HZ = 100,
  parameter C_M_AXIS_DATA_WIDTH  = 256,
  parameter C_S_AXIS_DATA_WIDTH  = 256,
  parameter C_M_AXIS_TUSER_WIDTH = 128,
  parameter C_S_AXIS_TUSER_WIDTH = 128,
	parameter C_NUM_QUEUES         = 4,
	parameter DST_PORT_POS         = 24,
  parameter QDR_NUM_CHIPS        = 2,
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
  // Clock and Reset
  input 										  										dcm_locked,

  input                                           qdr_clk,
  input                                           qdr_clk_200,
  input                                           qdr_clk_270,

  // Slave AXI Ports
  input                                           s_axi_aclk,
  input                                           s_axi_aresetn,
  input      [C_S_AXI_ADDR_WIDTH-1:0]             s_axi_awaddr,
  input                                           s_axi_awvalid,
  input      [C_S_AXI_DATA_WIDTH-1:0]             s_axi_wdata,
  input      [C_S_AXI_DATA_WIDTH/8-1:0]           s_axi_wstrb,
  input                                           s_axi_wvalid,
  input                                           s_axi_bready,
  input      [C_S_AXI_ADDR_WIDTH-1:0]             s_axi_araddr,
  input                                           s_axi_arvalid,
  input                                           s_axi_rready,
  output                                          s_axi_arready,
  output     [C_S_AXI_DATA_WIDTH-1:0]             s_axi_rdata,
  output     [1:0]                                s_axi_rresp,
  output                                          s_axi_rvalid,
  output                                          s_axi_wready,
  output     [1:0]                                s_axi_bresp,
  output                                          s_axi_bvalid,
  output                                          s_axi_awready,

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

  output     [C_M_AXIS_DATA_WIDTH-1:0]            m_axis_tdata_4,
  output     [((C_M_AXIS_DATA_WIDTH/8))-1:0]      m_axis_tstrb_4,
  output     [C_M_AXIS_TUSER_WIDTH-1:0]           m_axis_tuser_4,
  output                                          m_axis_tvalid_4,
  input                                           m_axis_tready_4,
  output                                          m_axis_tlast_4,

  // Slave Stream Ports (interface to RX queues)
  input      [C_S_AXIS_DATA_WIDTH-1:0]            s_axis_tdata,
  input      [((C_S_AXIS_DATA_WIDTH/8))-1:0]      s_axis_tstrb,
  input      [C_S_AXIS_TUSER_WIDTH-1:0]           s_axis_tuser,
  input                                           s_axis_tvalid,
  output                                          s_axis_tready,
  input                                           s_axis_tlast,

  // QDR Memory Interface (Each Chip is of 9MB)
  input      [(QDR_DATA_WIDTH)-1:0]               qdr_q_0,
  input      [QDR_CQ_WIDTH-1:0]                   qdr_cq_0,
  input      [QDR_CQ_WIDTH-1:0]                   qdr_cq_n_0,
  output     [QDR_CLK_WIDTH-1:0]                  qdr_c_0,
  output     [QDR_CLK_WIDTH-1:0]                  qdr_c_n_0,
  output                                          qdr_dll_off_n_0,
  output     [QDR_CLK_WIDTH-1:0]                  qdr_k_0,
  output     [QDR_CLK_WIDTH-1:0]                  qdr_k_n_0,
  output     [QDR_ADDR_WIDTH-1:0]                 qdr_sa_0,
  output     [(QDR_BW_WIDTH)-1:0]                 qdr_bw_n_0,
  output                                          qdr_w_n_0,
  output     [(QDR_DATA_WIDTH)-1:0]               qdr_d_0,
  output                                          qdr_r_n_0,
  (* S = "TRUE" *) input                          qdr_masterbank_sel_0,

  input      [(QDR_DATA_WIDTH)-1:0]               qdr_q_1,
  input      [QDR_CQ_WIDTH-1:0]                   qdr_cq_1,
  input      [QDR_CQ_WIDTH-1:0]                   qdr_cq_n_1,
  output     [QDR_CLK_WIDTH-1:0]                  qdr_c_1,
  output     [QDR_CLK_WIDTH-1:0]                  qdr_c_n_1,
  output                                          qdr_dll_off_n_1,
  output     [QDR_CLK_WIDTH-1:0]                  qdr_k_1,
  output     [QDR_CLK_WIDTH-1:0]                  qdr_k_n_1,
  output     [QDR_ADDR_WIDTH-1:0]                 qdr_sa_1,
  output     [(QDR_BW_WIDTH)-1:0]                 qdr_bw_n_1,
  output                                          qdr_w_n_1,
  output     [(QDR_DATA_WIDTH)-1:0]               qdr_d_1,
  output                                          qdr_r_n_1,
  (* S = "TRUE" *) input                          qdr_masterbank_sel_1,

  input      [(QDR_DATA_WIDTH)-1:0]               qdr_q_2,
  input      [QDR_CQ_WIDTH-1:0]                   qdr_cq_2,
  input      [QDR_CQ_WIDTH-1:0]                   qdr_cq_n_2,
  output     [QDR_CLK_WIDTH-1:0]                  qdr_c_2,
  output     [QDR_CLK_WIDTH-1:0]                  qdr_c_n_2,
  output                                          qdr_dll_off_n_2,
  output     [QDR_CLK_WIDTH-1:0]                  qdr_k_2,
  output     [QDR_CLK_WIDTH-1:0]                  qdr_k_n_2,
  output     [QDR_ADDR_WIDTH-1:0]                 qdr_sa_2,
  output     [(QDR_BW_WIDTH)-1:0]                 qdr_bw_n_2,
  output                                          qdr_w_n_2,
  output     [(QDR_DATA_WIDTH)-1:0]               qdr_d_2,
  output                                          qdr_r_n_2,
  (* S = "TRUE" *) input                          qdr_masterbank_sel_2
);

  // -- Internal Parameters
  localparam NUM_RW_REGS = 21;
  localparam NUM_WO_REGS = 0;
  localparam NUM_RO_REGS = 1;

  // -- Signals
	wire																						axi_aclk;
	wire																						axi_aresetn;
	
  wire [NUM_RW_REGS*C_S_AXI_DATA_WIDTH-1:0]   		rw_regs;

  wire                                            sw_rst;
	
	wire [QDR_ADDR_WIDTH-1:0]  											q0_addr_low;
	wire [QDR_ADDR_WIDTH-1:0]  											q0_addr_high;
	wire [QDR_ADDR_WIDTH-1:0]  											q1_addr_low;
	wire [QDR_ADDR_WIDTH-1:0]  											q1_addr_high;
	wire [QDR_ADDR_WIDTH-1:0]  											q2_addr_low;
	wire [QDR_ADDR_WIDTH-1:0]  											q2_addr_high;
	wire [QDR_ADDR_WIDTH-1:0]  											q3_addr_low;
	wire [QDR_ADDR_WIDTH-1:0]  											q3_addr_high;
	                                              	
	wire 																						q0_enable;
	wire 																						q1_enable;
	wire 																						q2_enable;
	wire 																						q3_enable;
	                                              	
	wire [REPLAY_COUNT_WIDTH-1:0]										q0_replay_count;
	wire [REPLAY_COUNT_WIDTH-1:0]										q1_replay_count;
	wire [REPLAY_COUNT_WIDTH-1:0]										q2_replay_count;
	wire [REPLAY_COUNT_WIDTH-1:0]										q3_replay_count;
	                                              	
	wire 																						q0_start_replay;
	wire 																						q1_start_replay;
	wire 																						q2_start_replay;
	wire 																						q3_start_replay;

  wire err0, err1;
	
	// -- Assignments
	assign		axi_aclk  =  s_axi_aclk;
	assign    axi_aresetn = s_axi_aresetn;

  assign    m_axis_tdata_4 = 0;
  assign    m_axis_tstrb_4 = 0;
  assign    m_axis_tuser_4 = 0;
  assign    m_axis_tvalid_4 = 0;
  assign    m_axis_tlast_4 = 0;

  // -- AXILITE Registers
  axi_lite_regs
  #(
    .C_S_AXI_DATA_WIDTH   (C_S_AXI_DATA_WIDTH),
    .C_S_AXI_ADDR_WIDTH   (C_S_AXI_ADDR_WIDTH),
    .C_USE_WSTRB          (C_USE_WSTRB),
    .C_DPHASE_TIMEOUT     (C_DPHASE_TIMEOUT),
    .C_BAR0_BASEADDR      (C_BASEADDR),
    .C_BAR0_HIGHADDR      (C_HIGHADDR),
    .C_S_AXI_ACLK_FREQ_HZ (C_S_AXI_ACLK_FREQ_HZ),
    .NUM_RW_REGS          (NUM_RW_REGS),
    .NUM_WO_REGS          (NUM_WO_REGS),
    .NUM_RO_REGS          (NUM_RO_REGS)
  )
    axi_lite_regs_1bar_inst
  (
    .s_axi_aclk      			(s_axi_aclk),
    .s_axi_aresetn   			(s_axi_aresetn),
    .s_axi_awaddr    			(s_axi_awaddr),
    .s_axi_awvalid   			(s_axi_awvalid),
    .s_axi_wdata     			(s_axi_wdata),
    .s_axi_wstrb     			(s_axi_wstrb),
    .s_axi_wvalid    			(s_axi_wvalid),
    .s_axi_bready    			(s_axi_bready),
    .s_axi_araddr    			(s_axi_araddr),
    .s_axi_arvalid   			(s_axi_arvalid),
    .s_axi_rready    			(s_axi_rready),
    .s_axi_arready   			(s_axi_arready),
    .s_axi_rdata     			(s_axi_rdata),
    .s_axi_rresp     			(s_axi_rresp),
    .s_axi_rvalid    			(s_axi_rvalid),
    .s_axi_wready    			(s_axi_wready),
    .s_axi_bresp     			(s_axi_bresp),
    .s_axi_bvalid    			(s_axi_bvalid),
    .s_axi_awready   			(s_axi_awready),
                     			
    .rw_regs         			(rw_regs),
		.rw_defaults     			((SIM_ONLY == 0) ? {NUM_RW_REGS*C_S_AXI_DATA_WIDTH{1'b0}} :
													 {
														 {31'b0, 1'b0}, // q3_enable
														 {31'b0, 1'b0},
														 {31'b0, 1'b0},
														 {31'b0, 1'b1},
														  
														 {32'd64},
													   {32'd48},
														 {32'd48},
														 {32'd32},
														 {32'd32},
														 {32'd16},
														 {32'd16},
														 {32'd0},
														  
														 {32'd10},
														 {32'd10},
														 {32'd10},
														 {32'd10},
														  
														 {31'b0, 1'b0},
														 {31'b0, 1'b0},
														 {31'b0, 1'b0},
														 {31'b0, 1'b0},
													   
														 {31'b0, 1'b0} // sw_rst
													 }
													), 
		.wo_regs         			(),
		.wo_defaults     			({NUM_WO_REGS*C_S_AXI_DATA_WIDTH{1'b0}}),
		.ro_regs         			({30'b0, err1, err0})
  );
  

  // -- Register assignments

  assign sw_rst          = rw_regs[(C_S_AXI_DATA_WIDTH*0)+1-1:(C_S_AXI_DATA_WIDTH*0)];
	                         
	assign q0_start_replay = rw_regs[(C_S_AXI_DATA_WIDTH*1)+1-1:(C_S_AXI_DATA_WIDTH*1)];
	assign q1_start_replay = rw_regs[(C_S_AXI_DATA_WIDTH*2)+1-1:(C_S_AXI_DATA_WIDTH*2)];
	assign q2_start_replay = rw_regs[(C_S_AXI_DATA_WIDTH*3)+1-1:(C_S_AXI_DATA_WIDTH*3)];
	assign q3_start_replay = rw_regs[(C_S_AXI_DATA_WIDTH*4)+1-1:(C_S_AXI_DATA_WIDTH*4)];
	                         
  assign q0_replay_count = rw_regs[(C_S_AXI_DATA_WIDTH*5)+REPLAY_COUNT_WIDTH-1:(C_S_AXI_DATA_WIDTH*5)];
	assign q1_replay_count = rw_regs[(C_S_AXI_DATA_WIDTH*6)+REPLAY_COUNT_WIDTH-1:(C_S_AXI_DATA_WIDTH*6)];
	assign q2_replay_count = rw_regs[(C_S_AXI_DATA_WIDTH*7)+REPLAY_COUNT_WIDTH-1:(C_S_AXI_DATA_WIDTH*7)];
	assign q3_replay_count = rw_regs[(C_S_AXI_DATA_WIDTH*8)+REPLAY_COUNT_WIDTH-1:(C_S_AXI_DATA_WIDTH*8)]; 
	                         
	assign q0_addr_low   	 = rw_regs[(C_S_AXI_DATA_WIDTH*9)+QDR_ADDR_WIDTH-1:(C_S_AXI_DATA_WIDTH*9)]; 
	assign q0_addr_high  	 = rw_regs[(C_S_AXI_DATA_WIDTH*10)+QDR_ADDR_WIDTH-1:(C_S_AXI_DATA_WIDTH*10)]; 
	assign q1_addr_low   	 = rw_regs[(C_S_AXI_DATA_WIDTH*11)+QDR_ADDR_WIDTH-1:(C_S_AXI_DATA_WIDTH*11)]; 
	assign q1_addr_high  	 = rw_regs[(C_S_AXI_DATA_WIDTH*12)+QDR_ADDR_WIDTH-1:(C_S_AXI_DATA_WIDTH*12)]; 
	assign q2_addr_low   	 = rw_regs[(C_S_AXI_DATA_WIDTH*13)+QDR_ADDR_WIDTH-1:(C_S_AXI_DATA_WIDTH*13)]; 
	assign q2_addr_high  	 = rw_regs[(C_S_AXI_DATA_WIDTH*14)+QDR_ADDR_WIDTH-1:(C_S_AXI_DATA_WIDTH*14)]; 
	assign q3_addr_low   	 = rw_regs[(C_S_AXI_DATA_WIDTH*15)+QDR_ADDR_WIDTH-1:(C_S_AXI_DATA_WIDTH*15)]; 
	assign q3_addr_high  	 = rw_regs[(C_S_AXI_DATA_WIDTH*16)+QDR_ADDR_WIDTH-1:(C_S_AXI_DATA_WIDTH*16)]; 
	                         
	assign q0_enable			 = rw_regs[(C_S_AXI_DATA_WIDTH*17)+1-1:(C_S_AXI_DATA_WIDTH*17)];
	assign q1_enable			 = rw_regs[(C_S_AXI_DATA_WIDTH*18)+1-1:(C_S_AXI_DATA_WIDTH*18)];
	assign q2_enable			 = rw_regs[(C_S_AXI_DATA_WIDTH*19)+1-1:(C_S_AXI_DATA_WIDTH*19)];
	assign q3_enable			 = rw_regs[(C_S_AXI_DATA_WIDTH*20)+1-1:(C_S_AXI_DATA_WIDTH*20)];

  // -- Pcap Replay uEngine
  pcap_replay_uengine #
  (
    .C_M_AXIS_DATA_WIDTH  ( C_M_AXIS_DATA_WIDTH ),
    .C_S_AXIS_DATA_WIDTH  ( C_S_AXIS_DATA_WIDTH ),
    .C_M_AXIS_TUSER_WIDTH ( C_M_AXIS_TUSER_WIDTH ),
    .C_S_AXIS_TUSER_WIDTH ( C_S_AXIS_TUSER_WIDTH ),
    .C_S_AXI_DATA_WIDTH   ( C_S_AXI_DATA_WIDTH ),
    .QDR_NUM_CHIPS        ( QDR_NUM_CHIPS ),
    .QDR_DATA_WIDTH       ( QDR_DATA_WIDTH ),
    .QDR_ADDR_WIDTH       ( QDR_ADDR_WIDTH ),
    .QDR_BW_WIDTH         ( QDR_BW_WIDTH ),
    .QDR_CLK_WIDTH        ( QDR_CLK_WIDTH ),
    .QDR_CQ_WIDTH         ( QDR_CQ_WIDTH ),
		.QDR_CLK_PERIOD				( QDR_CLK_PERIOD ),
		.QDR_BURST_LENGTH			( QDR_BURST_LENGTH ),
		.SIM_ONLY							( SIM_ONLY )
		
   )
     pcap_replay_uengine_inst
   (
    .err0(err0),
    .err1(err1),
    // Global Ports
    .axi_aclk             ( axi_aclk ),
    .axi_aresetn          ( axi_aresetn ),
	
	  .dcm_locked           ( dcm_locked ),
		
		.qdr_clk							( qdr_clk ),
		.qdr_clk_200					( qdr_clk_200 ),
		.qdr_clk_270				  ( qdr_clk_270 ),

    // Master Stream Ports (interface to data path)
	  .m_axis_tdata_0       ( m_axis_tdata_0 ),
    .m_axis_tstrb_0       ( m_axis_tstrb_0 ),
    .m_axis_tuser_0       ( m_axis_tuser_0 ),
    .m_axis_tvalid_0      ( m_axis_tvalid_0 ),
    .m_axis_tready_0      ( m_axis_tready_0 ),
    .m_axis_tlast_0       ( m_axis_tlast_0 ),
		
	  .m_axis_tdata_1       ( m_axis_tdata_1 ),
    .m_axis_tstrb_1       ( m_axis_tstrb_1 ),
    .m_axis_tuser_1       ( m_axis_tuser_1 ),
    .m_axis_tvalid_1      ( m_axis_tvalid_1 ),
    .m_axis_tready_1      ( m_axis_tready_1 ),
    .m_axis_tlast_1       ( m_axis_tlast_1 ),
		
	  .m_axis_tdata_2       ( m_axis_tdata_2 ),
    .m_axis_tstrb_2       ( m_axis_tstrb_2 ),
    .m_axis_tuser_2       ( m_axis_tuser_2 ),
    .m_axis_tvalid_2      ( m_axis_tvalid_2 ),
    .m_axis_tready_2      ( m_axis_tready_2 ),
    .m_axis_tlast_2       ( m_axis_tlast_2 ),
	
	  .m_axis_tdata_3       ( m_axis_tdata_3 ),
    .m_axis_tstrb_3       ( m_axis_tstrb_3 ),
    .m_axis_tuser_3       ( m_axis_tuser_3 ),
    .m_axis_tvalid_3      ( m_axis_tvalid_3 ),
    .m_axis_tready_3      ( m_axis_tready_3 ),
    .m_axis_tlast_3       ( m_axis_tlast_3 ),

    // Slave Stream Ports (interface to RX queues)
    .s_axis_tdata         ( s_axis_tdata ),
    .s_axis_tstrb         ( s_axis_tstrb ),
    .s_axis_tuser         ( s_axis_tuser ),
    .s_axis_tvalid        ( s_axis_tvalid ),
    .s_axis_tready        ( s_axis_tready ),
    .s_axis_tlast         ( s_axis_tlast ),

    // QDR Memeory Interface
    .qdr_q_0              ( qdr_q_0 ),
    .qdr_cq_0             ( qdr_cq_0 ),
    .qdr_cq_n_0           ( qdr_cq_n_0 ),
    .qdr_c_0              ( qdr_c_0 ),
    .qdr_c_n_0            ( qdr_c_n_0 ),
    .qdr_dll_off_n_0      ( qdr_dll_off_n_0 ),
    .qdr_k_0              ( qdr_k_0 ),
    .qdr_k_n_0            ( qdr_k_n_0 ),
    .qdr_sa_0             ( qdr_sa_0 ),
    .qdr_bw_n_0           ( qdr_bw_n_0),
    .qdr_w_n_0            ( qdr_w_n_0 ),
    .qdr_d_0              ( qdr_d_0 ),
    .qdr_r_n_0            ( qdr_r_n_0 ),
	  .qdr_masterbank_sel_0 ( qdr_masterbank_sel_0 ),

    .qdr_q_1              ( qdr_q_1 ),
    .qdr_cq_1             ( qdr_cq_1 ),
    .qdr_cq_n_1           ( qdr_cq_n_1 ),
    .qdr_c_1              ( qdr_c_1 ),
    .qdr_c_n_1            ( qdr_c_n_1 ),
    .qdr_dll_off_n_1      ( qdr_dll_off_n_1 ),
    .qdr_k_1              ( qdr_k_1 ),
    .qdr_k_n_1            ( qdr_k_n_1 ),
    .qdr_sa_1             ( qdr_sa_1 ),
    .qdr_bw_n_1           ( qdr_bw_n_1),
    .qdr_w_n_1            ( qdr_w_n_1 ),
    .qdr_d_1              ( qdr_d_1 ),
    .qdr_r_n_1            ( qdr_r_n_1 ),
	  .qdr_masterbank_sel_1 ( qdr_masterbank_sel_1 ),

    .qdr_q_2              ( qdr_q_2 ),
    .qdr_cq_2             ( qdr_cq_2 ),
    .qdr_cq_n_2           ( qdr_cq_n_2 ),
    .qdr_c_2              ( qdr_c_2 ),
    .qdr_c_n_2            ( qdr_c_n_2 ),
    .qdr_dll_off_n_2      ( qdr_dll_off_n_2 ),
    .qdr_k_2              ( qdr_k_2 ),
    .qdr_k_n_2            ( qdr_k_n_2 ),
    .qdr_sa_2             ( qdr_sa_2 ),
    .qdr_bw_n_2           ( qdr_bw_n_2),
    .qdr_w_n_2            ( qdr_w_n_2 ),
    .qdr_d_2              ( qdr_d_2 ),
    .qdr_r_n_2            ( qdr_r_n_2 ),
	  .qdr_masterbank_sel_2 ( qdr_masterbank_sel_2 )
  );

endmodule
