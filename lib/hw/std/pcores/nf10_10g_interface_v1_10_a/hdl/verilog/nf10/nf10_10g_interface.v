/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        nf10_10g_interface.v
 *
 *  Library:
 *        hw/std/pcores/nf10_10g_interface_v1_10_a
 *
 *  Module:
 *        nf10_10g_interface
 *
 *  Author:
 *        James Hongyi Zeng
 *
 *  Description:
 *        This is the combination of AXI interface, 10G MAC and XAUI
 *        C_XAUI_REVERSE=1 means the XAUI GTX lanes are reversed. This
 *        is used on NetFPGA-10G board Port 0, 1, 2. Please consult
 *        board schematic first before modifying the default value.
 *
 *                        / rx_queue (AXI Master)
 *        XAUI - 10G MAC
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

module nf10_10g_interface
#(
    // Master AXI Stream Data Width
    parameter C_M_AXIS_DATA_WIDTH=64,
    parameter C_S_AXIS_DATA_WIDTH=64,
    parameter C_XAUI_REVERSE=0,
    parameter C_XGMAC_CONFIGURATION = {5'b01000, 64'h0583000000000000},
    parameter C_XAUI_CONFIGURATION = 7'b0,
    parameter C_M_AXIS_TUSER_WIDTH=128,
    parameter C_S_AXIS_TUSER_WIDTH=128,
    parameter C_DEFAULT_VALUE_ENABLE = 0,
    parameter C_DEFAULT_SRC_PORT = 0,
    parameter C_DEFAULT_DST_PORT = 0
)
(
    // Part 1: System side signals
    // Global Ports
    input axi_aclk,
    input axi_resetn,

    input dclk,   //DRP Clock 50MHz
    input refclk, //GTX Clock 156.25MHz

    // Master Stream Ports
    output [C_M_AXIS_DATA_WIDTH - 1:0] m_axis_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0] m_axis_tstrb,
    output [C_M_AXIS_TUSER_WIDTH-1:0] m_axis_tuser, // Dummy AXI TUSER
    output m_axis_tvalid,
    input  m_axis_tready,
    output m_axis_tlast,

    // Slave Stream Ports
    input [C_S_AXIS_DATA_WIDTH - 1:0] s_axis_tdata,
    input [((C_S_AXIS_DATA_WIDTH / 8)) - 1:0] s_axis_tstrb,
    input [C_S_AXIS_TUSER_WIDTH-1:0] s_axis_tuser,
    input  s_axis_tvalid,
    output s_axis_tready,
    input  s_axis_tlast,

    // Part 2: PHY side signals
    // XAUI PHY Interface
    output        xaui_tx_l0_p,
    output        xaui_tx_l0_n,
    output        xaui_tx_l1_p,
    output        xaui_tx_l1_n,
    output        xaui_tx_l2_p,
    output        xaui_tx_l2_n,
    output        xaui_tx_l3_p,
    output        xaui_tx_l3_n,

    input         xaui_rx_l0_p,
    input         xaui_rx_l0_n,
    input         xaui_rx_l1_p,
    input         xaui_rx_l1_n,
    input         xaui_rx_l2_p,
    input         xaui_rx_l2_n,
    input         xaui_rx_l3_p,
    input         xaui_rx_l3_n
);

  localparam C_M_AXIS_DATA_WIDTH_INTERNAL=64;
  localparam C_S_AXIS_DATA_WIDTH_INTERNAL=64;

  wire clk156, txoutclk;

  wire [63:0] xgmii_rxd, xgmii_txd;
  wire [ 7:0] xgmii_rxc, xgmii_txc;

  wire [63 : 0] tx_data;
  wire [7 : 0]  tx_data_valid;
  wire          tx_start;
  wire          tx_ack;

  wire [63 : 0] rx_data;
  wire [7 : 0]  rx_data_valid;

  wire          rx_good_frame;
  wire          rx_bad_frame;

    // Master Stream Ports
    wire [C_M_AXIS_DATA_WIDTH_INTERNAL - 1:0] m_axis_tdata_internal;
    wire [((C_M_AXIS_DATA_WIDTH_INTERNAL / 8)) - 1:0] m_axis_tstrb_internal;
    wire [C_M_AXIS_TUSER_WIDTH-1:0] m_axis_tuser_internal; // Dummy AXI TUSER
    wire m_axis_tvalid_internal;
    wire  m_axis_tready_internal;
    wire m_axis_tlast_internal;

    // Slave Stream Ports
    wire [C_S_AXIS_DATA_WIDTH_INTERNAL - 1:0] s_axis_tdata_internal;
    wire [((C_S_AXIS_DATA_WIDTH_INTERNAL / 8)) - 1:0] s_axis_tstrb_internal;
    wire [C_S_AXIS_TUSER_WIDTH-1:0] s_axis_tuser_internal;
    wire  s_axis_tvalid_internal;
    wire  s_axis_tready_internal;
    wire  s_axis_tlast_internal;


  wire reset = ~axi_resetn;

  assign m_axis_tuser_internal = {(C_M_AXIS_TUSER_WIDTH){1'b0}};

  // =============================================================================
  // Module Instantiation
  // =============================================================================

  // Put system clocks on global routing
  BUFG clk156_bufg (
    .I(txoutclk),
    .O(clk156));

  xaui_block
  #(.WRAPPER_SIM_GTXRESET_SPEEDUP(1),
    .REVERSE_LANES(C_XAUI_REVERSE)
   ) xaui_block
  (
    .reset         (reset),
    .reset156      (reset),
    .clk156        (clk156),
    .dclk          (dclk),
    .refclk        (refclk),
    .txoutclk      (txoutclk),

    .xgmii_txd     (xgmii_txd),
    .xgmii_txc     (xgmii_txc),
    .xgmii_rxd     (xgmii_rxd),
    .xgmii_rxc     (xgmii_rxc),

    .xaui_tx_l0_p  (xaui_tx_l0_p),
    .xaui_tx_l0_n  (xaui_tx_l0_n),
    .xaui_tx_l1_p  (xaui_tx_l1_p),
    .xaui_tx_l1_n  (xaui_tx_l1_n),
    .xaui_tx_l2_p  (xaui_tx_l2_p),
    .xaui_tx_l2_n  (xaui_tx_l2_n),
    .xaui_tx_l3_p  (xaui_tx_l3_p),
    .xaui_tx_l3_n  (xaui_tx_l3_n),
    .xaui_rx_l0_p  (xaui_rx_l0_p),
    .xaui_rx_l0_n  (xaui_rx_l0_n),
    .xaui_rx_l1_p  (xaui_rx_l1_p),
    .xaui_rx_l1_n  (xaui_rx_l1_n),
    .xaui_rx_l2_p  (xaui_rx_l2_p),
    .xaui_rx_l2_n  (xaui_rx_l2_n),
    .xaui_rx_l3_p  (xaui_rx_l3_p),
    .xaui_rx_l3_n  (xaui_rx_l3_n),

    .txlock        (clk156_locked),
    .signal_detect (4'b1111),
    .drp_i         (16'h0),
    .drp_addr      (7'b0),
    .drp_en        (2'b0),
    .drp_we        (2'b0),
    .drp_o         (),
    .drp_rdy       (),
    .configuration_vector (C_XAUI_CONFIGURATION),
    .status_vector ()
  );


   ////////////////////////
   // Instantiate the MAC
   ////////////////////////
   xgmac xgmac
     (
      .reset                (reset),

      .tx_underrun          (1'b0),
      .tx_data              (tx_data),
      .tx_data_valid        (tx_data_valid),
      .tx_start             (tx_start),
      .tx_ack               (tx_ack),
      .tx_ifg_delay         (8'b0),
      .tx_statistics_vector (),
      .tx_statistics_valid  (),
      .pause_val            (16'h0),
      .pause_req            (1'b0),

      .rx_data              (rx_data),
      .rx_data_valid        (rx_data_valid),
      .rx_good_frame        (rx_good_frame),
      .rx_bad_frame         (rx_bad_frame),
      .rx_statistics_vector (),
      .rx_statistics_valid  (),

      .configuration_vector (C_XGMAC_CONFIGURATION),

      .tx_clk0(clk156),
      .tx_dcm_lock(clk156_locked),
      .xgmii_txd(xgmii_txd),
      .xgmii_txc(xgmii_txc),

      .rx_clk0(clk156),
      .rx_dcm_lock(clk156_locked),
      .xgmii_rxd(xgmii_rxd),
      .xgmii_rxc(xgmii_rxc)
      );

    ////////////////////////////////
    // Instantiate the AXI Converter
    ////////////////////////////////
    rx_queue #(
       .AXI_DATA_WIDTH(C_M_AXIS_DATA_WIDTH_INTERNAL)
    )rx_queue (
       // AXI side
       .tdata(m_axis_tdata_internal),
       .tstrb(m_axis_tstrb_internal),
       .tvalid(m_axis_tvalid_internal),
       .tlast(m_axis_tlast_internal),
       .tready(m_axis_tready_internal),

       .clk(axi_aclk),
       .reset(~axi_resetn),

       // MAC side
       .rx_data(rx_data),
       .rx_data_valid(rx_data_valid),
       .rx_good_frame(rx_good_frame),
       .rx_bad_frame(rx_bad_frame),
       .clk156(clk156)
    );

    tx_queue #(
       .AXI_DATA_WIDTH(C_S_AXIS_DATA_WIDTH_INTERNAL)
    )
    tx_queue (
       // AXI side
       .tdata(s_axis_tdata_internal),
       .tstrb(s_axis_tstrb_internal),
       .tvalid(s_axis_tvalid_internal),
       .tlast(s_axis_tlast_internal),
       .tready(s_axis_tready_internal),

       .clk(axi_aclk),
       .reset(~axi_resetn),

       // MAC side
       .tx_data(tx_data),
       .tx_data_valid(tx_data_valid),
       .tx_start(tx_start),
       .tx_ack(tx_ack),
       .clk156(clk156)
    );

    nf10_axis_converter
    #(.C_M_AXIS_DATA_WIDTH(C_M_AXIS_DATA_WIDTH),
      .C_S_AXIS_DATA_WIDTH(C_M_AXIS_DATA_WIDTH_INTERNAL),
      .C_DEFAULT_VALUE_ENABLE(C_DEFAULT_VALUE_ENABLE),
      .C_DEFAULT_SRC_PORT(C_DEFAULT_SRC_PORT),
      .C_DEFAULT_DST_PORT(C_DEFAULT_DST_PORT)
     ) converter_master
    (
    // Global Ports
    .axi_aclk(axi_aclk),
    .axi_resetn(axi_resetn),

    // Master Stream Ports
    .m_axis_tdata(m_axis_tdata),
    .m_axis_tstrb(m_axis_tstrb),
    .m_axis_tvalid(m_axis_tvalid),
    .m_axis_tready(m_axis_tready),
    .m_axis_tlast(m_axis_tlast),
	.m_axis_tuser(m_axis_tuser),

    // Slave Stream Ports
    .s_axis_tdata(m_axis_tdata_internal),
    .s_axis_tstrb(m_axis_tstrb_internal),
    .s_axis_tvalid(m_axis_tvalid_internal),
    .s_axis_tready(m_axis_tready_internal),
    .s_axis_tlast(m_axis_tlast_internal),
	.s_axis_tuser(m_axis_tuser_internal)
   );

    nf10_axis_converter
    #(.C_M_AXIS_DATA_WIDTH(C_S_AXIS_DATA_WIDTH_INTERNAL),
      .C_S_AXIS_DATA_WIDTH(C_S_AXIS_DATA_WIDTH)
     ) converter_slave
    (
    // Global Ports
    .axi_aclk(axi_aclk),
    .axi_resetn(axi_resetn),

    // Master Stream Ports
    .m_axis_tdata(s_axis_tdata_internal),
    .m_axis_tstrb(s_axis_tstrb_internal),
    .m_axis_tvalid(s_axis_tvalid_internal),
    .m_axis_tready(s_axis_tready_internal),
    .m_axis_tlast(s_axis_tlast_internal),
	 .m_axis_tuser(s_axis_tuser_internal),

    // Slave Stream Ports
    .s_axis_tdata(s_axis_tdata),
    .s_axis_tstrb(s_axis_tstrb),
    .s_axis_tvalid(s_axis_tvalid),
    .s_axis_tready(s_axis_tready),
    .s_axis_tlast(s_axis_tlast),
	.s_axis_tuser(s_axis_tuser)
   );

endmodule
