/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        nf10_1g_interface.v
 *
 *  Library:
 *        hw/std/pcores/nf10_1g_interface_v1_10_a
 *
 *  Module:
 *        nf10_1g_interface
 *
 *  Author:
 *        Adam Covington
 *
 *  Description:
 *        This is the combination of AXI interface, GMAC and XAUI
 *
 *                        / rx_queue (AXI Master)
 *        XAUI - GMAC
 *                        \ tx_queue (AXI Slave)
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

module nf10_1g_interface
#(
    // Master AXI Stream Data Width
    parameter C_M_AXIS_DATA_WIDTH=64,
    parameter C_S_AXIS_DATA_WIDTH=64,
    parameter C_M_AXIS_TUSER_WIDTH=128,
    parameter C_S_AXIS_TUSER_WIDTH=128,
    parameter C_DEFAULT_VALUE_ENABLE_0 = 0,
    parameter C_DEFAULT_SRC_PORT_0 = 0,
    parameter C_DEFAULT_DST_PORT_0 = 0,
    parameter C_DEFAULT_VALUE_ENABLE_1 = 0,
    parameter C_DEFAULT_SRC_PORT_1 = 0,
    parameter C_DEFAULT_DST_PORT_1 = 0
)
(
    // Part 1: System side signals
    // Global Ports
    input axi_aclk,
    input axi_resetn,

    input gtxclk_0, //GTX Clock 125MHz (from the PCB)
    input gtxclk_1, //GTX Clock 125MHz (from the PCB)

    // Master Stream Ports 0
    output [C_M_AXIS_DATA_WIDTH - 1:0] 		m_axis_tdata_0,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0] 	m_axis_tstrb_0,
    output [C_M_AXIS_TUSER_WIDTH-1:0] 			m_axis_tuser_0,
    output 					m_axis_tvalid_0,
    input  					m_axis_tready_0,
    output 					m_axis_tlast_0,

    // Slave Stream Ports 0
    input [C_S_AXIS_DATA_WIDTH - 1:0] 		s_axis_tdata_0,
    input [((C_S_AXIS_DATA_WIDTH / 8)) - 1:0] 	s_axis_tstrb_0,
    input [C_S_AXIS_TUSER_WIDTH-1:0] 			s_axis_tuser_0,
    input  					s_axis_tvalid_0,
    output 					s_axis_tready_0,
    input  					s_axis_tlast_0,

    // Master Stream Ports 1
    output [C_M_AXIS_DATA_WIDTH - 1:0] 		m_axis_tdata_1,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0] 	m_axis_tstrb_1,
    output [C_M_AXIS_TUSER_WIDTH-1:0] 			m_axis_tuser_1,
    output 					m_axis_tvalid_1,
    input  					m_axis_tready_1,
    output 					m_axis_tlast_1,
    output 					m_axis_err_tvalid_1,

    // Slave Stream Ports 1
    input [C_S_AXIS_DATA_WIDTH - 1:0] 		s_axis_tdata_1,
    input [((C_S_AXIS_DATA_WIDTH / 8)) - 1:0] 	s_axis_tstrb_1,
    input [C_S_AXIS_TUSER_WIDTH-1:0] 			s_axis_tuser_1,
    input  					s_axis_tvalid_1,
    output 					s_axis_tready_1,
    input  					s_axis_tlast_1,

    // Part 2: PHY side signals
    output          TXP_0,
    output          TXN_0,
    input           RXP_0,
    input           RXN_0,

    output          TXP_1,
    output          TXN_1,
    input           RXP_1,
    input           RXN_1,

    output          TXP_0_dummy,
    output          TXN_0_dummy,
    input           RXP_0_dummy,
    input           RXN_0_dummy,

    output          TXP_1_dummy,
    output          TXN_1_dummy,
    input           RXP_1_dummy,
    input           RXN_1_dummy
);

  localparam C_M_AXIS_DATA_WIDTH_INTERNAL = 8;
  localparam C_S_AXIS_DATA_WIDTH_INTERNAL = 8;

  wire          clk125; // 125MHz clock *from* GTX

  wire [7 : 0]  tx_data_0;
  wire    	tx_data_valid_0;
  wire    	tx_ack_0;

  wire [7 : 0]  rx_data_0;
  wire    	rx_data_valid_0;
  wire    	rx_good_frame_0;
  wire    	rx_bad_frame_0;

   //Local Link Interface
  wire [7 : 0]  tx_data_1;
  wire    	tx_data_valid_1;
  wire    	tx_ack_1;

  wire [7 : 0]  rx_data_1;
  wire    	rx_data_valid_1;
  wire    	rx_good_frame_1;
  wire    	rx_bad_frame_1;

  // Master Stream Ports 0
  wire [C_M_AXIS_DATA_WIDTH_INTERNAL - 1:0] 		m_axis_tdata_internal_0;
  wire [((C_M_AXIS_DATA_WIDTH_INTERNAL / 8)) - 1:0] 	m_axis_tstrb_internal_0;
  wire [C_M_AXIS_TUSER_WIDTH-1:0] 				m_axis_tuser_internal_0;
  wire 							m_axis_tvalid_internal_0;
  wire  						m_axis_tready_internal_0;
  wire 							m_axis_tlast_internal_0;

  // Slave Stream Ports 0
  wire [C_S_AXIS_DATA_WIDTH_INTERNAL - 1:0] 		s_axis_tdata_internal_0;
  wire [((C_S_AXIS_DATA_WIDTH_INTERNAL / 8)) - 1:0] 	s_axis_tstrb_internal_0;
  wire [C_S_AXIS_TUSER_WIDTH-1:0] 				s_axis_tuser_internal_0;
  wire  						s_axis_tvalid_internal_0;
  wire  						s_axis_tready_internal_0;
  wire  						s_axis_tlast_internal_0;

  // Master Stream Ports 1
  wire [C_M_AXIS_DATA_WIDTH_INTERNAL - 1:0] 		m_axis_tdata_internal_1;
  wire [((C_M_AXIS_DATA_WIDTH_INTERNAL / 8)) - 1:0] 	m_axis_tstrb_internal_1;
  wire [C_M_AXIS_TUSER_WIDTH-1:0] 				m_axis_tuser_internal_1;
  wire 							m_axis_tvalid_internal_1;
  wire  						m_axis_tready_internal_1;
  wire 							m_axis_tlast_internal_1;

  // Slave Stream Ports 1
  wire [C_S_AXIS_DATA_WIDTH_INTERNAL - 1:0] 		s_axis_tdata_internal_1;
  wire [((C_S_AXIS_DATA_WIDTH_INTERNAL / 8)) - 1:0] 	s_axis_tstrb_internal_1;
  wire [C_S_AXIS_TUSER_WIDTH-1:0] 				s_axis_tuser_internal_1;
  wire  						s_axis_tvalid_internal_1;
  wire  						s_axis_tready_internal_1;
  wire  						s_axis_tlast_internal_1;

  // =============================================================================
  // Module Instantiation
  // =============================================================================
  gmac gmac (
    // SGMII MGT Clock buffer inputs
    .gtxclk_0	    	(gtxclk_0),
    .gtxclk_1	    	(gtxclk_1),
    .GTRESET		(~axi_resetn),

    // EMAC0 Clocking
    // 125MHz clock output from transceiver
    .clk125		(clk125),
    .RESET		(~axi_resetn),

    // SGMII Interface - EMAC0
    .TXP_0		(TXP_0),
    .TXN_0		(TXN_0),
    .RXP_0		(RXP_0),
    .RXN_0		(RXN_0),
    .PHYAD_0		(5'b0),
    .RESETDONE_0	(),

   //EMAC0 Local Link Interface
    .tx_data_0		(tx_data_0),
    .tx_data_valid_0	(tx_data_valid_0),
    .tx_ack_0		(tx_ack_0),

    .rx_data_0		(rx_data_0),
    .rx_data_valid_0	(rx_data_valid_0),
    .rx_good_frame_0	(rx_good_frame_0),
    .rx_bad_frame_0	(rx_bad_frame_0),

    // SGMII Interface - EMAC1
    .TXP_1		(TXP_1),
    .TXN_1		(TXN_1),
    .RXP_1		(RXP_1),
    .RXN_1		(RXN_1),
    .PHYAD_1		(5'b0),
    .RESETDONE_1	(),

   //EMAC0 Local Link Interface
    .tx_data_1		(tx_data_1),
    .tx_data_valid_1	(tx_data_valid_1),
    .tx_ack_1		(tx_ack_1),

    .rx_data_1		(rx_data_1),
    .rx_data_valid_1	(rx_data_valid_1),
    .rx_good_frame_1	(rx_good_frame_1),
    .rx_bad_frame_1	(rx_bad_frame_1)
  );

    //-----------------------
    // Instantiate the AXI Converter
    //-----------------------
    // Port 0
    rx_queue #(
       .AXI_DATA_WIDTH(C_M_AXIS_DATA_WIDTH_INTERNAL)
    )rx_queue_0 (
       // AXI side
       .tdata		(m_axis_tdata_internal_0),
       .tstrb		(m_axis_tstrb_internal_0),
       .tvalid		(m_axis_tvalid_internal_0),
       .tlast		(m_axis_tlast_internal_0),
       .tready		(m_axis_tready_internal_0),

       .err_tvalid	(),

       .clk		(axi_aclk),
       .reset		(~axi_resetn),

       // MAC side
       .rx_data		(rx_data_0),
       .rx_data_valid	(rx_data_valid_0),
       .rx_good_frame	(rx_good_frame_0),
       .rx_bad_frame	(rx_bad_frame_0),
       .clk125		(clk125)
    );

    tx_queue #(
       .AXI_DATA_WIDTH(C_S_AXIS_DATA_WIDTH_INTERNAL)
    )
    tx_queue_0 (
       // AXI side
       .tdata		(s_axis_tdata_internal_0),
       .tstrb		(s_axis_tstrb_internal_0),
       .tvalid		(s_axis_tvalid_internal_0),
       .tlast		(s_axis_tlast_internal_0),
       .tready		(s_axis_tready_internal_0),

       .clk		(axi_aclk),
       .reset		(~axi_resetn),

       // MAC side
       .tx_data		(tx_data_0),
       .tx_data_valid	(tx_data_valid_0),
       .tx_ack		(tx_ack_0),
       .clk125		(clk125)
    );

    // Port 1
    rx_queue #(
       .AXI_DATA_WIDTH	(C_M_AXIS_DATA_WIDTH_INTERNAL)
    )rx_queue_1 (
       // AXI side
       .tdata		(m_axis_tdata_internal_1),
       .tstrb		(m_axis_tstrb_internal_1),
       .tvalid		(m_axis_tvalid_internal_1),
       .tlast		(m_axis_tlast_internal_1),
       .tready		(m_axis_tready_internal_1),

       .err_tvalid	(),

       .clk		(axi_aclk),
       .reset		(~axi_resetn),

       // MAC side
       .rx_data		(rx_data_1),
       .rx_data_valid	(rx_data_valid_1),
       .rx_good_frame	(rx_good_frame_1),
       .rx_bad_frame	(rx_bad_frame_1),
       .clk125		(clk125)
    );

    tx_queue #(
       .AXI_DATA_WIDTH	(C_S_AXIS_DATA_WIDTH_INTERNAL)
    )
    tx_queue_1 (
       // AXI side
       .tdata		(s_axis_tdata_internal_1),
       .tstrb		(s_axis_tstrb_internal_1),
       .tvalid		(s_axis_tvalid_internal_1),
       .tlast		(s_axis_tlast_internal_1),
       .tready		(s_axis_tready_internal_1),

       .clk		(axi_aclk),
       .reset		(~axi_resetn),

       // MAC side
       .tx_data		(tx_data_1),
       .tx_data_valid	(tx_data_valid_1),
       .tx_ack		(tx_ack_1),
       .clk125		(clk125)
    );

    nf10_axis_converter
    #(.C_M_AXIS_DATA_WIDTH	(C_M_AXIS_DATA_WIDTH),
      .C_S_AXIS_DATA_WIDTH	(C_M_AXIS_DATA_WIDTH_INTERNAL),
      .C_DEFAULT_VALUE_ENABLE	(C_DEFAULT_VALUE_ENABLE_0),
      .C_DEFAULT_SRC_PORT	(C_DEFAULT_SRC_PORT_0),
      .C_DEFAULT_DST_PORT	(C_DEFAULT_DST_PORT_0)
     ) converter_master_0 (
    // Global Ports
    .axi_aclk			(axi_aclk),
    .axi_resetn			(axi_resetn),

    // Master Stream Ports
    .m_axis_tdata		(m_axis_tdata_0),
    .m_axis_tstrb		(m_axis_tstrb_0),
    .m_axis_tvalid		(m_axis_tvalid_0),
    .m_axis_tready		(m_axis_tready_0),
    .m_axis_tlast		(m_axis_tlast_0),
    .m_axis_tuser		(m_axis_tuser_0),

    // Slave Stream Ports
    .s_axis_tdata		(m_axis_tdata_internal_0),
    .s_axis_tstrb		(m_axis_tstrb_internal_0),
    .s_axis_tvalid		(m_axis_tvalid_internal_0),
    .s_axis_tready		(m_axis_tready_internal_0),
    .s_axis_tlast		(m_axis_tlast_internal_0),
    .s_axis_tuser		(m_axis_tuser_internal_0)
   );

    nf10_axis_converter
    #(.C_M_AXIS_DATA_WIDTH	(C_S_AXIS_DATA_WIDTH_INTERNAL),
      .C_S_AXIS_DATA_WIDTH	(C_S_AXIS_DATA_WIDTH)
     ) converter_slave_0 (
    // Global Ports
    .axi_aclk			(axi_aclk),
    .axi_resetn			(axi_resetn),

    // Master Stream Ports
    .m_axis_tdata		(s_axis_tdata_internal_0),
    .m_axis_tstrb		(s_axis_tstrb_internal_0),
    .m_axis_tvalid		(s_axis_tvalid_internal_0),
    .m_axis_tready		(s_axis_tready_internal_0),
    .m_axis_tlast		(s_axis_tlast_internal_0),
    .m_axis_tuser		(s_axis_tuser_internal_0),

    // Slave Stream Ports
    .s_axis_tdata		(s_axis_tdata_0),
    .s_axis_tstrb		(s_axis_tstrb_0),
    .s_axis_tvalid		(s_axis_tvalid_0),
    .s_axis_tready		(s_axis_tready_0),
    .s_axis_tlast		(s_axis_tlast_0),
    .s_axis_tuser		(s_axis_tuser_0)
   );

    nf10_axis_converter
    #(.C_M_AXIS_DATA_WIDTH	(C_M_AXIS_DATA_WIDTH),
      .C_S_AXIS_DATA_WIDTH	(C_M_AXIS_DATA_WIDTH_INTERNAL),
      .C_DEFAULT_VALUE_ENABLE	(C_DEFAULT_VALUE_ENABLE_1),
      .C_DEFAULT_SRC_PORT	(C_DEFAULT_SRC_PORT_1),
      .C_DEFAULT_DST_PORT	(C_DEFAULT_DST_PORT_1)
     ) converter_master_1
    (
    // Global Ports
    .axi_aclk			(axi_aclk),
    .axi_resetn			(axi_resetn),

    // Master Stream Ports
    .m_axis_tdata		(m_axis_tdata_1),
    .m_axis_tstrb		(m_axis_tstrb_1),
    .m_axis_tvalid		(m_axis_tvalid_1),
    .m_axis_tready		(m_axis_tready_1),
    .m_axis_tlast		(m_axis_tlast_1),
    .m_axis_tuser		(m_axis_tuser_1),

    // Slave Stream Ports
    .s_axis_tdata		(m_axis_tdata_internal_1),
    .s_axis_tstrb		(m_axis_tstrb_internal_1),
    .s_axis_tvalid		(m_axis_tvalid_internal_1),
    .s_axis_tready		(m_axis_tready_internal_1),
    .s_axis_tlast		(m_axis_tlast_internal_1),
    .s_axis_tuser		(m_axis_tuser_internal_1)
   );

    nf10_axis_converter
    #(.C_M_AXIS_DATA_WIDTH	(C_S_AXIS_DATA_WIDTH_INTERNAL),
      .C_S_AXIS_DATA_WIDTH	(C_S_AXIS_DATA_WIDTH)
     ) converter_slave_1
    (
    // Global Ports
    .axi_aclk			(axi_aclk),
    .axi_resetn			(axi_resetn),

    // Master Stream Ports
    .m_axis_tdata		(s_axis_tdata_internal_1),
    .m_axis_tstrb		(s_axis_tstrb_internal_1),
    .m_axis_tvalid		(s_axis_tvalid_internal_1),
    .m_axis_tready		(s_axis_tready_internal_1),
    .m_axis_tlast		(s_axis_tlast_internal_1),
    .m_axis_tuser		(s_axis_tuser_internal_1),

    // Slave Stream Ports
    .s_axis_tdata		(s_axis_tdata_1),
    .s_axis_tstrb		(s_axis_tstrb_1),
    .s_axis_tvalid		(s_axis_tvalid_1),
    .s_axis_tready		(s_axis_tready_1),
    .s_axis_tlast		(s_axis_tlast_1),
    .s_axis_tuser		(s_axis_tuser_1)
   );

    // The following is dummy GTX per AR 33473
    // http://www.xilinx.com/support/answers/33473.htm
    dummy_gtx dummy_gtx_0 (
        .CLK_IN     (gtxclk_0),
        .TXP		(TXP_0_dummy),
        .TXN		(TXN_0_dummy),
        .RXP		(RXP_0_dummy),
        .RXN		(RXN_0_dummy)
    );
    dummy_gtx dummy_gtx_1 (
        .CLK_IN     (gtxclk_1),
        .TXP		(TXP_1_dummy),
        .TXN		(TXN_1_dummy),
        .RXP		(RXP_1_dummy),
        .RXN		(RXN_1_dummy)
    );

endmodule
