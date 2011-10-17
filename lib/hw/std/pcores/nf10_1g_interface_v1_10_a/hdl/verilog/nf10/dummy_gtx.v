/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        dummy_gtx.v
 *
 *  Library:
 *        hw/std/pcores/nf10_1g_interface_v1_10_a
 *
 *  Module:
 *        dummy_gtx
 *
 *  Author:
 *        Adam Covington
 *
 *  Description:
 *        The following is dummy GTX per AR 33473
 *        http://www.xilinx.com/support/answers/33473.htm
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

module dummy_gtx(
    input CLK_IN,
    input RXN,
    input RXP,
    output TXN,
    output TXP
);

wire tied_to_ground_i = 1'b0;
wire [63:0] tied_to_ground_vec_i = 64'h0000000000000000;
wire tied_to_vcc_i = 1'b1;
wire [63:0] tied_to_vcc_vec_i = 64'hffffffffffffffff;

GTX_DUAL gtx_dual_i
(
//---------------------- Loopback and Powerdown Ports ----------------------
.LOOPBACK0 (tied_to_vcc_vec_i[2:0]),
.LOOPBACK1 (tied_to_vcc_vec_i[2:0]),
.RXPOWERDOWN0 (tied_to_vcc_vec_i[1:0]),
.RXPOWERDOWN1 (tied_to_vcc_vec_i[1:0]),
.TXPOWERDOWN0 (tied_to_vcc_vec_i[1:0]),
.TXPOWERDOWN1 (tied_to_vcc_vec_i[1:0]),
//--------------------- Receive Ports - 8b10b Decoder ----------------------
.RXCHARISCOMMA0 (),
.RXCHARISCOMMA1 (),
.RXCHARISK0 (),
.RXCHARISK1 (),
.RXDEC8B10BUSE0 (tied_to_ground_i),
.RXDEC8B10BUSE1 (tied_to_ground_i),
.RXDISPERR0 (),
.RXDISPERR1 (),
.RXNOTINTABLE0 (),
.RXNOTINTABLE1 (),
.RXRUNDISP0 (),
.RXRUNDISP1 (),
//----------------- Receive Ports - Channel Bonding Ports ------------------
.RXCHANBONDSEQ0 (),
.RXCHANBONDSEQ1 (),
.RXCHBONDI0 (tied_to_ground_vec_i[2:0]),
.RXCHBONDI1 (tied_to_ground_vec_i[2:0]),
.RXCHBONDO0 (),
.RXCHBONDO1 (),
.RXENCHANSYNC0 (tied_to_ground_i),
.RXENCHANSYNC1 (tied_to_ground_i),
//----------------- Receive Ports - Clock Correction Ports -----------------
.RXCLKCORCNT0 (),
.RXCLKCORCNT1 (),
//------------- Receive Ports - Comma Detection and Alignment --------------
.RXBYTEISALIGNED0 (),
.RXBYTEISALIGNED1 (),
.RXBYTEREALIGN0 (),
.RXBYTEREALIGN1 (),
.RXCOMMADET0 (),
.RXCOMMADET1 (),
.RXCOMMADETUSE0 (tied_to_ground_i),
.RXCOMMADETUSE1 (tied_to_ground_i),
.RXENMCOMMAALIGN0 (tied_to_ground_i),
.RXENMCOMMAALIGN1 (tied_to_ground_i),
.RXENPCOMMAALIGN0 (tied_to_ground_i),
.RXENPCOMMAALIGN1 (tied_to_ground_i),
.RXSLIDE0 (tied_to_ground_i),
.RXSLIDE1 (tied_to_ground_i),
//--------------------- Receive Ports - PRBS Detection ---------------------
.PRBSCNTRESET0 (tied_to_ground_i),
.PRBSCNTRESET1 (tied_to_ground_i),
.RXENPRBSTST0 (tied_to_ground_vec_i[1:0]),
.RXENPRBSTST1 (tied_to_ground_vec_i[1:0]),
.RXPRBSERR0 (),
.RXPRBSERR1 (),
//----------------- Receive Ports - RX Data Path interface -----------------
.RXDATA0 (),
.RXDATA1 (),
.RXDATAWIDTH0 (tied_to_vcc_i),
.RXDATAWIDTH1 (tied_to_vcc_i),
.RXRECCLK0 (),
.RXRECCLK1 (),
.RXRESET0 (tied_to_ground_i),
.RXRESET1 (tied_to_ground_i),
.RXUSRCLK0 (tied_to_ground_i),
.RXUSRCLK1 (tied_to_ground_i),
.RXUSRCLK20 (tied_to_ground_i),
.RXUSRCLK21 (tied_to_ground_i),
//----- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
.RXCDRRESET0 (tied_to_ground_i),
.RXCDRRESET1 (tied_to_ground_i),
.RXELECIDLE0 (),
.RXELECIDLE1 (),
.RXENEQB0 (tied_to_vcc_i),
.RXENEQB1 (tied_to_vcc_i),
.RXEQMIX0 (tied_to_ground_vec_i[1:0]),
.RXEQMIX1 (tied_to_ground_vec_i[1:0]),
.RXEQPOLE0 (tied_to_ground_vec_i[3:0]),
.RXEQPOLE1 (tied_to_ground_vec_i[3:0]),
.RXN0 (RXN),
.RXN1 (),
.RXP0 (RXP),
.RXP1 (),
//------ Receive Ports - RX Elastic Buffer and Phase Alignment Ports -------
.RXBUFRESET0 (tied_to_ground_i),
.RXBUFRESET1 (tied_to_ground_i),
.RXBUFSTATUS0 (),
.RXBUFSTATUS1 (),
.RXCHANISALIGNED0 (),
.RXCHANISALIGNED1 (),
.RXCHANREALIGN0 (),
.RXCHANREALIGN1 (),
.RXPMASETPHASE0 (tied_to_ground_i),
.RXPMASETPHASE1 (tied_to_ground_i),
.RXSTATUS0 (),
.RXSTATUS1 (),
//------------- Receive Ports - RX Loss-of-sync State Machine --------------
.RXLOSSOFSYNC0 (),
.RXLOSSOFSYNC1 (),
//-------------------- Receive Ports - RX Oversampling ---------------------
.RXENSAMPLEALIGN0 (tied_to_ground_i),
.RXENSAMPLEALIGN1 (tied_to_ground_i),
.RXOVERSAMPLEERR0 (),
.RXOVERSAMPLEERR1 (),
//------------ Receive Ports - RX Pipe Control for PCI Express -------------
.PHYSTATUS0 (),
.PHYSTATUS1 (),
.RXVALID0 (),
.RXVALID1 (),
//--------------- Receive Ports - RX Polarity Control Ports ----------------
.RXPOLARITY0 (tied_to_ground_i),
.RXPOLARITY1 (tied_to_ground_i),
//----------- Shared Ports - Dynamic Reconfiguration Port (DRP) ------------
.DADDR (tied_to_ground_vec_i[6:0]),
.DCLK (tied_to_ground_i),
.DEN (tied_to_ground_i),
.DI (tied_to_ground_vec_i[15:0]),
.DO (),
.DRDY (),
.DWE (tied_to_ground_i),
//------------------- Shared Ports - Tile and PLL Ports --------------------
.CLKIN (CLK_IN),
.GTXRESET (tied_to_ground_i),
.GTXTEST (tied_to_ground_vec_i[3:0]),
.INTDATAWIDTH (tied_to_vcc_i),
.PLLLKDET (),
.PLLLKDETEN (tied_to_vcc_i),
.PLLPOWERDOWN (tied_to_ground_i),
.REFCLKOUT (),
.REFCLKPWRDNB (tied_to_vcc_i),
.RESETDONE0 (),
.RESETDONE1 (),
//-------------- Transmit Ports - 8b10b Encoder Control Ports --------------
.TXBYPASS8B10B0 (tied_to_ground_vec_i[1:0]),
.TXBYPASS8B10B1 (tied_to_ground_vec_i[1:0]),
.TXCHARDISPMODE0 (tied_to_ground_vec_i[1:0]),
.TXCHARDISPMODE1 (tied_to_ground_vec_i[1:0]),
.TXCHARDISPVAL0 (tied_to_ground_vec_i[1:0]),
.TXCHARDISPVAL1 (tied_to_ground_vec_i[1:0]),
.TXCHARISK0 (tied_to_ground_vec_i[1:0]),
.TXCHARISK1 (tied_to_ground_vec_i[1:0]),
.TXENC8B10BUSE0 (tied_to_ground_i),
.TXENC8B10BUSE1 (tied_to_ground_i),
.TXKERR0 (),
.TXKERR1 (),
.TXRUNDISP0 (),
.TXRUNDISP1 (),
//----------- Transmit Ports - TX Buffering and Phase Alignment ------------
.TXBUFSTATUS0 (),
.TXBUFSTATUS1 (),
//---------------- Transmit Ports - TX Data Path interface -----------------
.TXDATA0 (tied_to_ground_vec_i[15:0]),
.TXDATA1 (tied_to_ground_vec_i[15:0]),
.TXDATAWIDTH0 (tied_to_vcc_i),
.TXDATAWIDTH1 (tied_to_vcc_i),
.TXOUTCLK0 (),
.TXOUTCLK1 (),
.TXRESET0 (tied_to_ground_i),
.TXRESET1 (tied_to_ground_i),
.TXUSRCLK0 (tied_to_ground_i),
.TXUSRCLK1 (tied_to_ground_i),
.TXUSRCLK20 (tied_to_ground_i),
.TXUSRCLK21 (tied_to_ground_i),
//------------- Transmit Ports - TX Driver and OOB signalling --------------
.TXBUFDIFFCTRL0 (tied_to_vcc_vec_i[2:0]),
.TXBUFDIFFCTRL1 (tied_to_vcc_vec_i[2:0]),
.TXDIFFCTRL0 (tied_to_vcc_vec_i[2:0]),
.TXDIFFCTRL1 (tied_to_vcc_vec_i[2:0]),
.TXINHIBIT0 (tied_to_ground_i),
.TXINHIBIT1 (tied_to_ground_i),
.TXN0 (TXN),
.TXN1 (),
.TXP0 (TXP),
.TXP1 (),
.TXPREEMPHASIS0 (tied_to_vcc_vec_i[2:0]),
.TXPREEMPHASIS1 (tied_to_vcc_vec_i[2:0]),
//------------------- Transmit Ports - TX PRBS Generator -------------------
.TXENPRBSTST0 (tied_to_ground_vec_i[1:0]),
.TXENPRBSTST1 (tied_to_ground_vec_i[1:0]),
//------------------ Transmit Ports - TX Polarity Control ------------------
.TXPOLARITY0 (tied_to_ground_i),
.TXPOLARITY1 (tied_to_ground_i),
//--------------- Transmit Ports - TX Ports for PCI Express ----------------
.TXDETECTRX0 (tied_to_ground_i),
.TXDETECTRX1 (tied_to_ground_i),
.TXELECIDLE0 (tied_to_ground_i),
.TXELECIDLE1 (tied_to_ground_i),
//------------------- Transmit Ports - TX Ports for SATA -------------------
.TXCOMSTART0 (tied_to_ground_i),
.TXCOMSTART1 (tied_to_ground_i),
.TXCOMTYPE0 (tied_to_ground_i),
.TXCOMTYPE1 (tied_to_ground_i)

);

endmodule
