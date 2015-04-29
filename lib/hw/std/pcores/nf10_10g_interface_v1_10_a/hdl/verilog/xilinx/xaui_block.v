// ----------------------------------------------------------------
// Title      : Verilog block level for XAUI
// Project    : 10 Gigabit Ethernet XAUI Core
// File       : xaui_example_design.v
// Author     : Xilinx Inc.
// Description: This module holds the block for the
//              10Gb/E XAUI core.
//-----------------------------------------------------------------
// 
// (c) Copyright 2002 - 2010 Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//-----------------------------------------------------------------
////////////////////////////////////////////////////////////////////////
//
//  NetFPGA-10G http://www.netfpga.org
//
//  Module:
//          xaui_block.v
//
//  Description:
//          XAUI block patched with Lane reverse
//                 
//  Revision history:
//          2010/12/8 hyzeng: Initial check-in
//
////////////////////////////////////////////////////////////////////////

module xaui_block #
  (
    parameter   WRAPPER_SIM_MODE             = "FAST",
    parameter   WRAPPER_SIM_GTXRESET_SPEEDUP = 0,
    parameter   REVERSE_LANES = 0
  )
  (
   dclk,
   clk156,
   refclk,
   reset,
   reset156,
   txoutclk,
   xgmii_txd,
   xgmii_txc,
   xgmii_rxd,
   xgmii_rxc,
   xaui_tx_l0_p,
   xaui_tx_l0_n,
   xaui_tx_l1_p,
   xaui_tx_l1_n,
   xaui_tx_l2_p,
   xaui_tx_l2_n,
   xaui_tx_l3_p,
   xaui_tx_l3_n,
   xaui_rx_l0_p,
   xaui_rx_l0_n,
   xaui_rx_l1_p,
   xaui_rx_l1_n,
   xaui_rx_l2_p,
   xaui_rx_l2_n,
   xaui_rx_l3_p,
   xaui_rx_l3_n,
   txlock,
   signal_detect,
   align_status,
   sync_status,
   mgt_tx_ready,
   drp_addr,
   drp_en,
   drp_i,
   drp_o,
   drp_rdy,
   drp_we,
   configuration_vector,
   status_vector);

   // Port declarations
   input           dclk;
   input           clk156;
   input           refclk;
   input           reset;
   input           reset156;
   output          txoutclk;
   input[63:0]     xgmii_txd;
   input[7:0]      xgmii_txc;
   output[63:0]    xgmii_rxd;
   output[7:0]     xgmii_rxc;
   output          xaui_tx_l0_p;
   output          xaui_tx_l0_n;
   output          xaui_tx_l1_p;
   output          xaui_tx_l1_n;
   output          xaui_tx_l2_p;
   output          xaui_tx_l2_n;
   output          xaui_tx_l3_p;
   output          xaui_tx_l3_n;
   input           xaui_rx_l0_p;
   input           xaui_rx_l0_n;
   input           xaui_rx_l1_p;
   input           xaui_rx_l1_n;
   input           xaui_rx_l2_p;
   input           xaui_rx_l2_n;
   input           xaui_rx_l3_p;
   input           xaui_rx_l3_n;
   output          txlock;
   input[3:0]      signal_detect;
   output          align_status;
   output[3:0]     sync_status;
   output          mgt_tx_ready;
   input   [6:0]   drp_addr;
   input   [1:0]   drp_en;
   input   [15:0]  drp_i;
   output  [31:0]  drp_o;
   output  [1:0]   drp_rdy;
   input   [1:0]   drp_we;
   input  [6 : 0]  configuration_vector;
   output [7 : 0]  status_vector;

   // Signal declarations
   wire          lock;
   wire [2 : 0]  loopback_int;
   wire [7 : 0]  mgt_rxchariscomma;
   wire [7 : 0]  mgt_codevalid;
   wire [3 : 0]  mgt_enable_align;
   wire          mgt_enchansync;
   wire          mgt_loopback;
   wire          mgt_powerdown;
   wire          mgt_reset_terms;
   wire [3 : 0]  mgt_resetdone;
   wire          mgt_rx_reset;
   wire [11:0]   mgt_rxbufstatus;
   wire [7 : 0]  mgt_rxcharisk;
   wire [63: 0]  mgt_rxdata;
   wire [7 : 0]  mgt_rxdisperr;
   wire [3 : 0]  mgt_rxelecidle;
   wire [3 : 0]  mgt_rxlock;
   wire [7 : 0]  mgt_rxlossofsync;
   wire [7 : 0]  mgt_rxnotintable;
   wire [3 : 0]  mgt_syncok;
   wire [3 : 0]  mgt_tx_fault;
   wire [7 : 0]  mgt_txcharisk;
   wire [63: 0]  mgt_txdata;
   wire [1 : 0]  mgt_plllocked;
   reg  [3 : 0]  mgt_rxbuferr;
   wire          GT_TXOUTCLK1;
   wire [3:0]    mgt_rxbyteisaligned;
   wire [3:0]    mgt_rxbyterealign;
   wire          reset_txsync;

  // Register Declarations
   reg           clk_156_reset_txsync_r1;
   reg           clk_156_reset_txsync_r2;
   reg           clk_156_reset_txsync_r3;
   reg  [3:0]    mgt_rxcdr_reset = 4'b0000;
   reg  [7:0]    mgt_codecomma_reg;
   reg  [7:0]    mgt_rxcharisk_reg;
   reg  [63:0]   mgt_rxdata_reg;
   reg  [7:0]    mgt_rxdisperr_reg;
   reg  [3 : 0]  mgt_rxlock_reg;
   reg  [3 : 0]  mgt_rxlock_r1;
   reg  [7:0]    mgt_rxnotintable_reg;
   reg           mgt_powerdown_r;
   reg           mgt_powerdown_falling;


   // --------------------------CHANBOND_MONITOR signals -----------------------
  wire  [3:0]    mgt_rxchanisaligned;
  wire           comma_align_done;
  wire           chanbond_done;
  wire  [3:0]    sync_status_i;
  wire           align_status_i;


  wire [31:0]    gt_do;
  wire [31:0]    gt_di;
  wire [13:0]    gt_daddr;
  wire [1:0]     gt_den;
  wire [1:0]     gt_dwe;
  wire [1:0]     gt_drdy;
  wire [1:0]     mgt_txenpmaphasealign;
  wire [1:0]     mgt_txpmasetphase;
  wire [1:0]     mgt_txreset;
  wire [1:0]     resetdone;
  wire [1:0]     sync_txreset;
  wire [1:0]     tx_sync_done;
  // synthesis attribute ASYNC_REG of clk_156_reset_txsync_r1 is "TRUE";
  // synthesis attribute ASYNC_REG of mgt_rxlock_r1 is "TRUE";


  // Function Declarations
  function IsBufError;
    input [2:0] bufStatus;
    begin
    if ((bufStatus == 3'b101) || (bufStatus == 3'b110))
      IsBufError = 1'b1;
    else
      IsBufError = 1'b0;
    end
  endfunction

    // Instantiate the XAUI netlist

   xaui xaui_core
     (
       .reset(reset156),
       .xgmii_txd(xgmii_txd),
       .xgmii_txc(xgmii_txc),
       .xgmii_rxd(xgmii_rxd),
       .xgmii_rxc(xgmii_rxc),
       .usrclk(clk156),
       .mgt_txdata(mgt_txdata),
       .mgt_txcharisk(mgt_txcharisk),
       .mgt_rxdata(mgt_rxdata_reg),
       .mgt_rxcharisk(mgt_rxcharisk_reg),
       .mgt_codevalid(mgt_codevalid),
       .mgt_codecomma(mgt_codecomma_reg),
       .mgt_enable_align(mgt_enable_align),
       .mgt_enchansync(mgt_enchansync),
       .mgt_syncok(mgt_syncok),
       .mgt_rxlock(mgt_rxlock_reg),
       .mgt_loopback(mgt_loopback),
       .mgt_powerdown(mgt_powerdown),
       .mgt_tx_reset(mgt_tx_fault),
       .mgt_rx_reset(mgt_rxcdr_reset),
       .signal_detect(signal_detect),
       .align_status(align_status_i),
       .sync_status(sync_status_i),
       .configuration_vector(configuration_vector),
       .status_vector(status_vector));

ROCKETIO_WRAPPER #
(
    // Simulation attributes
    .WRAPPER_SIM_MODE                (WRAPPER_SIM_MODE),
    .WRAPPER_SIM_GTXRESET_SPEEDUP    (WRAPPER_SIM_GTXRESET_SPEEDUP),
    .WRAPPER_SIM_PLL_PERDIV2         (9'h140),
    .REVERSE_LANES                   (REVERSE_LANES)
)
rocketio_wrapper_i
(

    //_________________________________________________________________________
    //_________________________________________________________________________
    //TILE0  (Location)

    //---------------------- Loopback and Powerdown Ports ----------------------
    .TILE0_LOOPBACK0_IN(loopback_int),
    .TILE0_LOOPBACK1_IN(loopback_int),
    .TILE0_RXPOWERDOWN0_IN({ 2{mgt_powerdown} }),
    .TILE0_RXPOWERDOWN1_IN({ 2{mgt_powerdown} }),
    .TILE0_TXPOWERDOWN0_IN({ 2{mgt_powerdown} }),
    .TILE0_TXPOWERDOWN1_IN({ 2{mgt_powerdown} }),
    //--------------------- Receive Ports - 8b10b Decoder ----------------------
    .TILE0_RXDISPERR0_OUT(mgt_rxdisperr[1:0]),
    .TILE0_RXDISPERR1_OUT(mgt_rxdisperr[3:2]),
    .TILE0_RXNOTINTABLE0_OUT(mgt_rxnotintable[1:0]),
    .TILE0_RXNOTINTABLE1_OUT(mgt_rxnotintable[3:2]),
    .TILE0_RXCHARISCOMMA0_OUT(mgt_rxchariscomma[1:0]),
    .TILE0_RXCHARISCOMMA1_OUT(mgt_rxchariscomma[3:2]),
    .TILE0_RXCHARISK0_OUT(mgt_rxcharisk[1:0]),
    .TILE0_RXCHARISK1_OUT(mgt_rxcharisk[3:2]),
    //----------------- Receive Ports - Channel Bonding Ports ------------------
    .TILE0_RXCHANBONDSEQ0_OUT(),
    .TILE0_RXCHANBONDSEQ1_OUT(),
    .TILE0_RXENCHANSYNC0_IN(mgt_enchansync),
    .TILE0_RXENCHANSYNC1_IN(mgt_enchansync),
    //----------------- Receive Ports - Clock Correction Ports -----------------
    .TILE0_RXCLKCORCNT0_OUT(),
    .TILE0_RXCLKCORCNT1_OUT(),
    //------------- Receive Ports - Comma Detection and Alignment --------------
    .TILE0_RXBYTEISALIGNED0_OUT(mgt_rxbyteisaligned[0]),
    .TILE0_RXBYTEISALIGNED1_OUT(mgt_rxbyteisaligned[1]),
    .TILE0_RXBYTEREALIGN0_OUT(mgt_rxbyterealign[0]),
    .TILE0_RXBYTEREALIGN1_OUT(mgt_rxbyterealign[1]),
    .TILE0_RXCOMMADET0_OUT(),
    .TILE0_RXCOMMADET1_OUT(),
    .TILE0_RXENMCOMMAALIGN0_IN(mgt_enable_align[0]),
    .TILE0_RXENMCOMMAALIGN1_IN(mgt_enable_align[1]),
    .TILE0_RXENPCOMMAALIGN0_IN(mgt_enable_align[0]),
    .TILE0_RXENPCOMMAALIGN1_IN(mgt_enable_align[1]),
    //----------------- Receive Ports - RX Data Path interface -----------------
    .TILE0_RXDATA0_OUT(mgt_rxdata[15:0]),
    .TILE0_RXDATA1_OUT(mgt_rxdata[31:16]),
    .TILE0_RXRESET0_IN(mgt_rx_reset),
    .TILE0_RXRESET1_IN(mgt_rx_reset),
    .TILE0_RXUSRCLK0_IN(clk156),
    .TILE0_RXUSRCLK1_IN(clk156),
    .TILE0_RXUSRCLK20_IN(clk156),
    .TILE0_RXUSRCLK21_IN(clk156),
    //----- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
    .TILE0_RXCDRRESET0_IN(mgt_rxcdr_reset[0]),
    .TILE0_RXCDRRESET1_IN(mgt_rxcdr_reset[1]),
    .TILE0_RXELECIDLE0_OUT(mgt_rxelecidle[0]),
    .TILE0_RXELECIDLE1_OUT(mgt_rxelecidle[1]),
    .TILE0_RXN0_IN(xaui_rx_l0_n),
    .TILE0_RXN1_IN(xaui_rx_l1_n),
    .TILE0_RXP0_IN(xaui_rx_l0_p),
    .TILE0_RXP1_IN(xaui_rx_l1_p),
    //------ Receive Ports - RX Elastic Buffer and Phase Alignment Ports -------
    .TILE0_RXBUFRESET0_IN(1'b0),
    .TILE0_RXBUFRESET1_IN(1'b0),
    .TILE0_RXBUFSTATUS0_OUT(mgt_rxbufstatus[2:0]),
    .TILE0_RXBUFSTATUS1_OUT(mgt_rxbufstatus[5:3]),
    .TILE0_RXCHANISALIGNED0_OUT(mgt_rxchanisaligned[0]),
    .TILE0_RXCHANISALIGNED1_OUT(mgt_rxchanisaligned[1]),
    .TILE0_RXCHANREALIGN0_OUT(),
    .TILE0_RXCHANREALIGN1_OUT(),
    //------------- Receive Ports - RX Loss-of-sync State Machine --------------
    .TILE0_RXLOSSOFSYNC0_OUT(mgt_rxlossofsync[1:0]),
    .TILE0_RXLOSSOFSYNC1_OUT(mgt_rxlossofsync[3:2]),
    //----------- Shared Ports - Dynamic Reconfiguration Port (DRP) ------------
    .TILE0_DADDR_IN(gt_daddr[6:0]),
    .TILE0_DCLK_IN(dclk),
    .TILE0_DEN_IN(gt_den[0]),
    .TILE0_DI_IN(gt_di[15:0]),
    .TILE0_DO_OUT(gt_do[15:0]),
    .TILE0_DRDY_OUT(gt_drdy[0]),
    .TILE0_DWE_IN(gt_dwe[0]),
    //------------------- Shared Ports - Tile and PLL Ports --------------------
    .TILE0_CLKIN_IN(refclk),
    .TILE0_GTXRESET_IN(mgt_reset_terms),
    .TILE0_PLLLKDET_OUT(mgt_plllocked[0]),
    .TILE0_REFCLKOUT_OUT(GT_TXOUTCLK1),
    .TILE0_RESETDONE0_OUT(mgt_resetdone[0]),
    .TILE0_RESETDONE1_OUT(mgt_resetdone[1]),
    //-------------- Transmit Ports - 8b10b Encoder Control Ports --------------
    .TILE0_TXCHARISK0_IN(mgt_txcharisk[1:0]),
    .TILE0_TXCHARISK1_IN(mgt_txcharisk[3:2]),
    //---------------- Transmit Ports - TX Data Path interface -----------------
    .TILE0_TXDATA0_IN(mgt_txdata[15:0]),
    .TILE0_TXDATA1_IN(mgt_txdata[31:16]),
    .TILE0_TXRESET0_IN(mgt_txreset[0]),
    .TILE0_TXRESET1_IN(mgt_txreset[0]),
    .TILE0_TXUSRCLK0_IN(clk156),
    .TILE0_TXUSRCLK1_IN(clk156),
    .TILE0_TXUSRCLK20_IN(clk156),
    .TILE0_TXUSRCLK21_IN(clk156),
    //------------- Transmit Ports - TX Driver and OOB signalling --------------
    .TILE0_TXN0_OUT(xaui_tx_l0_n),
    .TILE0_TXN1_OUT(xaui_tx_l1_n),
    .TILE0_TXP0_OUT(xaui_tx_l0_p),
    .TILE0_TXP1_OUT(xaui_tx_l1_p),
    //------ Transmit Ports - TX Elastic Buffer and Phase Alignment ports ------
    .TILE0_TXENPMAPHASEALIGN0_IN(mgt_txenpmaphasealign[0]),
    .TILE0_TXENPMAPHASEALIGN1_IN(mgt_txenpmaphasealign[0]),
    .TILE0_TXPMASETPHASE0_IN(mgt_txpmasetphase[0]),
    .TILE0_TXPMASETPHASE1_IN(mgt_txpmasetphase[0]),
    //--------------- Transmit Ports - TX Ports for PCI Express ----------------
    .TILE0_TXELECIDLE0_IN(mgt_powerdown),
    .TILE0_TXELECIDLE1_IN(mgt_powerdown),


    //_________________________________________________________________________
    //_________________________________________________________________________
    //TILE1  (Location)

    //---------------------- Loopback and Powerdown Ports ----------------------
    .TILE1_LOOPBACK0_IN(loopback_int),
    .TILE1_LOOPBACK1_IN(loopback_int),
    .TILE1_RXPOWERDOWN0_IN({ 2{mgt_powerdown} }),
    .TILE1_RXPOWERDOWN1_IN({ 2{mgt_powerdown} }),
    .TILE1_TXPOWERDOWN0_IN({ 2{mgt_powerdown} }),
    .TILE1_TXPOWERDOWN1_IN({ 2{mgt_powerdown} }),
    //--------------------- Receive Ports - 8b10b Decoder ----------------------
    .TILE1_RXDISPERR0_OUT(mgt_rxdisperr[5:4]),
    .TILE1_RXDISPERR1_OUT(mgt_rxdisperr[7:6]),
    .TILE1_RXNOTINTABLE0_OUT(mgt_rxnotintable[5:4]),
    .TILE1_RXNOTINTABLE1_OUT(mgt_rxnotintable[7:6]),
    .TILE1_RXCHARISCOMMA0_OUT(mgt_rxchariscomma[5:4]),
    .TILE1_RXCHARISCOMMA1_OUT(mgt_rxchariscomma[7:6]),
    .TILE1_RXCHARISK0_OUT(mgt_rxcharisk[5:4]),
    .TILE1_RXCHARISK1_OUT(mgt_rxcharisk[7:6]),
    //----------------- Receive Ports - Channel Bonding Ports ------------------
    .TILE1_RXCHANBONDSEQ0_OUT(),
    .TILE1_RXCHANBONDSEQ1_OUT(),
    .TILE1_RXENCHANSYNC0_IN(mgt_enchansync),
    .TILE1_RXENCHANSYNC1_IN(mgt_enchansync),
    //----------------- Receive Ports - Clock Correction Ports -----------------
    .TILE1_RXCLKCORCNT0_OUT(),
    .TILE1_RXCLKCORCNT1_OUT(),
    //------------- Receive Ports - Comma Detection and Alignment --------------
    .TILE1_RXBYTEISALIGNED0_OUT(mgt_rxbyteisaligned[2]),
    .TILE1_RXBYTEISALIGNED1_OUT(mgt_rxbyteisaligned[3]),
    .TILE1_RXBYTEREALIGN0_OUT(mgt_rxbyterealign[2]),
    .TILE1_RXBYTEREALIGN1_OUT(mgt_rxbyterealign[3]),
    .TILE1_RXCOMMADET0_OUT(),
    .TILE1_RXCOMMADET1_OUT(),
    .TILE1_RXENMCOMMAALIGN0_IN(mgt_enable_align[2]),
    .TILE1_RXENMCOMMAALIGN1_IN(mgt_enable_align[3]),
    .TILE1_RXENPCOMMAALIGN0_IN(mgt_enable_align[2]),
    .TILE1_RXENPCOMMAALIGN1_IN(mgt_enable_align[3]),
    //----------------- Receive Ports - RX Data Path interface -----------------
    .TILE1_RXDATA0_OUT(mgt_rxdata[47:32]),
    .TILE1_RXDATA1_OUT(mgt_rxdata[63:48]),
    .TILE1_RXRESET0_IN(mgt_rx_reset),
    .TILE1_RXRESET1_IN(mgt_rx_reset),
    .TILE1_RXUSRCLK0_IN(clk156),
    .TILE1_RXUSRCLK1_IN(clk156),
    .TILE1_RXUSRCLK20_IN(clk156),
    .TILE1_RXUSRCLK21_IN(clk156),
    //----- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
    .TILE1_RXCDRRESET0_IN(mgt_rxcdr_reset[2]),
    .TILE1_RXCDRRESET1_IN(mgt_rxcdr_reset[3]),
    .TILE1_RXELECIDLE0_OUT(mgt_rxelecidle[2]),
    .TILE1_RXELECIDLE1_OUT(mgt_rxelecidle[3]),
    .TILE1_RXN0_IN(xaui_rx_l2_n),
    .TILE1_RXN1_IN(xaui_rx_l3_n),
    .TILE1_RXP0_IN(xaui_rx_l2_p),
    .TILE1_RXP1_IN(xaui_rx_l3_p),
    //------ Receive Ports - RX Elastic Buffer and Phase Alignment Ports -------
    .TILE1_RXBUFRESET0_IN(1'b0),
    .TILE1_RXBUFRESET1_IN(1'b0),
    .TILE1_RXBUFSTATUS0_OUT(mgt_rxbufstatus[8:6]),
    .TILE1_RXBUFSTATUS1_OUT(mgt_rxbufstatus[11:9]),
    .TILE1_RXCHANISALIGNED0_OUT(mgt_rxchanisaligned[2]),
    .TILE1_RXCHANISALIGNED1_OUT(mgt_rxchanisaligned[3]),
    .TILE1_RXCHANREALIGN0_OUT(),
    .TILE1_RXCHANREALIGN1_OUT(),
    //------------- Receive Ports - RX Loss-of-sync State Machine --------------
    .TILE1_RXLOSSOFSYNC0_OUT(mgt_rxlossofsync[5:4]),
    .TILE1_RXLOSSOFSYNC1_OUT(mgt_rxlossofsync[7:6]),
    //----------- Shared Ports - Dynamic Reconfiguration Port (DRP) ------------
    .TILE1_DADDR_IN(gt_daddr[13:7]),
    .TILE1_DCLK_IN(dclk),
    .TILE1_DEN_IN(gt_den[1]),
    .TILE1_DI_IN(gt_di[31:16]),
    .TILE1_DO_OUT(gt_do[31:16]),
    .TILE1_DRDY_OUT(gt_drdy[1]),
    .TILE1_DWE_IN(gt_dwe[1]),
    //------------------- Shared Ports - Tile and PLL Ports --------------------
    .TILE1_CLKIN_IN(refclk),
    .TILE1_GTXRESET_IN(mgt_reset_terms),
    .TILE1_PLLLKDET_OUT(mgt_plllocked[1]),
    .TILE1_REFCLKOUT_OUT(),
    .TILE1_RESETDONE0_OUT(mgt_resetdone[2]),
    .TILE1_RESETDONE1_OUT(mgt_resetdone[3]),
    //-------------- Transmit Ports - 8b10b Encoder Control Ports --------------
    .TILE1_TXCHARISK0_IN(mgt_txcharisk[5:4]),
    .TILE1_TXCHARISK1_IN(mgt_txcharisk[7:6]),
    //---------------- Transmit Ports - TX Data Path interface -----------------
    .TILE1_TXDATA0_IN(mgt_txdata[47:32]),
    .TILE1_TXDATA1_IN(mgt_txdata[63:48]),
    .TILE1_TXRESET0_IN(mgt_txreset[1]),
    .TILE1_TXRESET1_IN(mgt_txreset[1]),
    .TILE1_TXUSRCLK0_IN(clk156),
    .TILE1_TXUSRCLK1_IN(clk156),
    .TILE1_TXUSRCLK20_IN(clk156),
    .TILE1_TXUSRCLK21_IN(clk156),
    //------------- Transmit Ports - TX Driver and OOB signalling --------------
    .TILE1_TXN0_OUT(xaui_tx_l2_n),
    .TILE1_TXN1_OUT(xaui_tx_l3_n),
    .TILE1_TXP0_OUT(xaui_tx_l2_p),
    .TILE1_TXP1_OUT(xaui_tx_l3_p),
    //------ Transmit Ports - TX Elastic Buffer and Phase Alignment Ports ------
    .TILE1_TXENPMAPHASEALIGN0_IN(mgt_txenpmaphasealign[1]),
    .TILE1_TXENPMAPHASEALIGN1_IN(mgt_txenpmaphasealign[1]),
    .TILE1_TXPMASETPHASE0_IN(mgt_txpmasetphase[1]),
    .TILE1_TXPMASETPHASE1_IN(mgt_txpmasetphase[1]),
    //--------------- Transmit Ports - TX Ports for PCI Express ----------------
    .TILE1_TXELECIDLE0_IN(mgt_powerdown),
    .TILE1_TXELECIDLE1_IN(mgt_powerdown)

);
  assign sync_status   = sync_status_i;
  assign align_status  = align_status_i;
  assign mgt_codevalid = ~(mgt_rxnotintable_reg | mgt_rxdisperr_reg);
  assign loopback_int  = mgt_loopback ? 3'b010 : 3'b000;
  assign mgt_syncok    = ~{mgt_rxlossofsync[7],mgt_rxlossofsync[5],mgt_rxlossofsync[3],mgt_rxlossofsync[1]};

  // Detect falling edge of mgt_powerdown
  always @(posedge clk156)
  begin
    mgt_powerdown_r <= mgt_powerdown;
  end

  always @(posedge clk156)
  begin
    if ( mgt_powerdown_r && ~mgt_powerdown )
    begin
      mgt_powerdown_falling <= 1'b1;
    end
    else begin
      mgt_powerdown_falling <= 1'b0;
    end
  end

  always @(posedge clk156)
    begin
      // We're locked when there is lock from the GT,
      // and not in electrical idle - unless in loopback
      mgt_rxlock_reg       <= mgt_rxlock_r1;
      mgt_rxlock_r1        <= mgt_rxlock & (~mgt_rxelecidle | {4{mgt_loopback}});
      mgt_rxdata_reg       <= mgt_rxdata;
      mgt_rxcharisk_reg    <= mgt_rxcharisk;
      mgt_rxnotintable_reg <= mgt_rxnotintable;
      mgt_rxdisperr_reg    <= mgt_rxdisperr;
      mgt_codecomma_reg    <= mgt_rxchariscomma;
    end

  always @(mgt_rxbufstatus)
  begin
    mgt_rxbuferr[0] = IsBufError(mgt_rxbufstatus[2:0]);
    mgt_rxbuferr[1] = IsBufError(mgt_rxbufstatus[5:3]);
    mgt_rxbuferr[2] = IsBufError(mgt_rxbufstatus[8:6]);
    mgt_rxbuferr[3] = IsBufError(mgt_rxbufstatus[11:9]);
  end

  assign txoutclk = GT_TXOUTCLK1;

  assign reset_txsync = mgt_reset_terms || ~lock;

  always @(posedge clk156)// or posedge reset_txsync)
  begin
    if ( reset_txsync )
      begin
        clk_156_reset_txsync_r1 <= 1'b1;
        clk_156_reset_txsync_r2 <= 1'b1;
        clk_156_reset_txsync_r3 <= 1'b1;
      end
    else
      begin
        if ( &mgt_resetdone ) begin
          clk_156_reset_txsync_r1 <= 1'b0;
          clk_156_reset_txsync_r2 <= clk_156_reset_txsync_r1;
          clk_156_reset_txsync_r3 <= clk_156_reset_txsync_r2;
        end
      end
  end

   // reset logic
  assign lock = &mgt_plllocked;
  assign txlock = lock;
  assign mgt_rxlock = {mgt_plllocked[1], mgt_plllocked[1], mgt_plllocked[0], mgt_plllocked[0]};

   assign mgt_txreset  = sync_txreset | ~mgt_plllocked;
   assign resetdone[0] = &mgt_resetdone[1:0];
   assign resetdone[1] = &mgt_resetdone[3:2];

  TX_SYNC #
    ( .PLL_DIVSEL_OUT(1) )
     tile0_tx_sync_i (
      // User DRP Interface
      .USER_DO(drp_o[15:0]),
      .USER_DI(drp_i),
      .USER_DADDR(drp_addr),
      .USER_DEN(drp_en[0]),
      .USER_DWE(drp_we[0]),
      .USER_DRDY(drp_rdy[0]),
      // GT DRP Interface
      .GT_DO(gt_di[15:0]),
      .GT_DI(gt_do[15:0]),
      .GT_DADDR(gt_daddr[6:0]),
      .GT_DEN(gt_den[0]),
      .GT_DWE(gt_dwe[0]),
      .GT_DRDY(gt_drdy[0]),
      // Clocks and Reset
      .USER_CLK(clk156),
      .DCLK(dclk),
      .RESET(clk_156_reset_txsync_r3),
      .RESETDONE(resetdone[0]),
      // Phase Alignment ports to GT
      .TXENPMAPHASEALIGN(mgt_txenpmaphasealign[0]),
      .TXPMASETPHASE(mgt_txpmasetphase[0]),
      .TXRESET(sync_txreset[0]),
      // SYNC operations
      .SYNC_DONE(tx_sync_done[0]),
      .RESTART_SYNC(1'b0)
      );

TX_SYNC #
    ( .PLL_DIVSEL_OUT(1) )
     tile1_tx_sync_i (
      // User DRP Interface
      .USER_DO(drp_o[31:16]),
      .USER_DI(drp_i),
      .USER_DADDR(drp_addr),
      .USER_DEN(drp_en[1]),
      .USER_DWE(drp_we[1]),
      .USER_DRDY(drp_rdy[1]),
      // GT DRP Interface
      .GT_DO(gt_di[31:16]),
      .GT_DI(gt_do[31:16]),
      .GT_DADDR(gt_daddr[13:7]),
      .GT_DEN(gt_den[1]),
      .GT_DWE(gt_dwe[1]),
      .GT_DRDY(gt_drdy[1]),
      // Clocks and Reset
      .USER_CLK(clk156),
      .DCLK(dclk),
      .RESET(clk_156_reset_txsync_r3),
      .RESETDONE(resetdone[1]),
      // Phase Alignment ports to GT
      .TXENPMAPHASEALIGN(mgt_txenpmaphasealign[1]),
      .TXPMASETPHASE(mgt_txpmasetphase[1]),
      .TXRESET(sync_txreset[1]),
      // SYNC operations
      .SYNC_DONE(tx_sync_done[1]),
      .RESTART_SYNC(1'b0)
      );

    assign mgt_tx_ready = &tx_sync_done;
    assign mgt_tx_fault[3:2] = {2{~tx_sync_done[1]}};
    assign mgt_tx_fault[1:0] = {2{~tx_sync_done[0]}};
 
///////////////////////////////////////////////////////////////////
// Local Reset Logic
///////////////////////////////////////////////////////////////////
  assign mgt_reset_terms = reset;

   // reset the rx side when the buffer overflows / underflows
   always @(posedge clk156)
   begin
    if ( |mgt_rxbuferr || mgt_powerdown_falling )
      mgt_rxcdr_reset <= 4'b1111;
    else
      mgt_rxcdr_reset <= 4'b0000;
   end

///////////////////////////////////////////////////////////////////
// Channel bonding monitor
///////////////////////////////////////////////////////////////////
  assign comma_align_done = &sync_status_i;
  assign chanbond_done    = &mgt_rxchanisaligned;

    chanbond_monitor chanbond_monitor_i (
    .CLK(clk156),
    .RST(reset156),
    .COMMA_ALIGN_DONE(comma_align_done),
    .CORE_ENCHANSYNC(mgt_enchansync),
    .CHANBOND_DONE(chanbond_done),
    .RXRESET(mgt_rx_reset)
    );

endmodule
