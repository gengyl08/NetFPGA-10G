//-----------------------------------------------------------------------------
// Title      : 1000BASE-X RocketIO wrapper
// Project    : Virtex-5 Ethernet MAC Wrappers
//-----------------------------------------------------------------------------
// File       : gtx_dual_1000X.v
// Author     : Xilinx
//-----------------------------------------------------------------------------
// Copyright (c) 2004-2008 by Xilinx, Inc. All rights reserved.
// This text/file contains proprietary, confidential
// information of Xilinx, Inc., is distributed under license
// from Xilinx, Inc., and may be used, copied and/or
// disclosed only pursuant to the terms of a valid license
// agreement with Xilinx, Inc. Xilinx hereby grants you
// a license to use this text/file solely for design, simulation,
// implementation and creation of design files limited
// to Xilinx devices or technologies. Use with non-Xilinx
// devices or technologies is expressly prohibited and
// immediately terminates your license unless covered by
// a separate agreement.
//
// Xilinx is providing this design, code, or information
// "as is" solely for use in developing programs and
// solutions for Xilinx devices. By providing this design,
// code, or information as one possible implementation of
// this feature, application or standard, Xilinx is making no
// representation that this implementation is free from any
// claims of infringement. You are responsible for
// obtaining any rights you may require for your implementation.
// Xilinx expressly disclaims any warranty whatsoever with
// respect to the adequacy of the implementation, including
// but not limited to any warranties or representations that this
// implementation is free from claims of infringement, implied
// warranties of merchantability or fitness for a particular
// purpose.
//
// Xilinx products are not intended for use in life support
// appliances, devices, or systems. Use in such applications are
// expressly prohibited.
//
// This copyright and support notice must be retained as part
// of this text at all times. (c) Copyright 2004-2008 Xilinx, Inc.
// All rights reserved.
//
//----------------------------------------------------------------------
// Description:  This is the Verilog instantiation of a Virtex-5 GTX    
//               RocketIO tile for the Embedded Ethernet MAC.
//
//               Two GTX's must be instantiated regardless of how many  
//               GTXs are used in the MGT tile. 
//----------------------------------------------------------------------

`timescale 1 ps / 1 ps

module GTX_dual_1000X
(
          RESETDONE_0,
          ENMCOMMAALIGN_0, 
          ENPCOMMAALIGN_0,
          LOOPBACK_0,
          POWERDOWN_0, 
          RXUSRCLK_0,
          RXUSRCLK2_0,
          RXRESET_0,          
          TXCHARDISPMODE_0, 
          TXCHARDISPVAL_0, 
          TXCHARISK_0, 
          TXDATA_0, 
          TXUSRCLK_0, 
          TXUSRCLK2_0, 
          TXRESET_0, 
          RXCHARISCOMMA_0, 
          RXCHARISK_0,
          RXCLKCORCNT_0,           
          RXDATA_0, 
          RXDISPERR_0, 
          RXNOTINTABLE_0,
          RXRUNDISP_0, 
          RXBUFERR_0, 
          TXBUFERR_0, 
          PLLLKDET_0, 
          TXOUTCLK_0, 
          RXELECIDLE_0,
          TX1N_0, 
          TX1P_0,
          RX1N_0, 
          RX1P_0,

          TX1N_1_UNUSED,
          TX1P_1_UNUSED,
          RX1N_1_UNUSED,
          RX1P_1_UNUSED,


          CLK_DS,
          REFCLKOUT,
          GTRESET,
          PMARESET,
          DCM_LOCKED);

  output          RESETDONE_0;
  input           ENMCOMMAALIGN_0; 
  input           ENPCOMMAALIGN_0; 
  input           LOOPBACK_0; 
  input           POWERDOWN_0; 
  input           RXUSRCLK_0;
  input           RXUSRCLK2_0;
  input           RXRESET_0;          
  input           TXCHARDISPMODE_0; 
  input           TXCHARDISPVAL_0; 
  input           TXCHARISK_0; 
  input [7:0]     TXDATA_0; 
  input           TXUSRCLK_0; 
  input           TXUSRCLK2_0; 
  input           TXRESET_0; 
  output          RXCHARISCOMMA_0; 
  output          RXCHARISK_0;
  output [2:0]    RXCLKCORCNT_0;           
  output [7:0]    RXDATA_0; 
  output          RXDISPERR_0; 
  output          RXNOTINTABLE_0;
  output          RXRUNDISP_0; 
  output          RXBUFERR_0; 
  output          TXBUFERR_0; 
  output          PLLLKDET_0; 
  output          TXOUTCLK_0; 
  output          RXELECIDLE_0;
  output          TX1N_0; 
  output          TX1P_0;
  input           RX1N_0; 
  input           RX1P_0;

  output          TX1N_1_UNUSED;
  output          TX1P_1_UNUSED;
  input           RX1N_1_UNUSED;
  input           RX1P_1_UNUSED;


  input           CLK_DS;
  output          REFCLKOUT;
  input           GTRESET;
  input           PMARESET;
  input           DCM_LOCKED;

  //--------------------------------------------------------------------
  // Signal declarations for GTX
  //--------------------------------------------------------------------

   wire PLLLOCK;

            
   wire RXNOTINTABLE_0_INT;   
   wire [7:0] RXDATA_0_INT;
   wire RXCHARISK_0_INT;   
   wire RXDISPERR_0_INT;
   wire RXRUNDISP_0_INT;
         
   wire [1:0] RXBUFSTATUS_float0;
   wire TXBUFSTATUS_float0;

   wire gt_txoutclk1_0;

   reg  [7:0] RXDATA_0;
   reg  RXCHARISK_0;
   reg  RXRUNDISP_0;
   wire resetdone0_i_del;

   wire rxelecidle0_i;
   wire resetdone0_i;

   
   //--------------------------------------------------------------------
   // Wait for both PLL's to lock   
   //--------------------------------------------------------------------

   
   assign PLLLKDET_0        =   PLLLOCK;


   //--------------------------------------------------------------------
   // Wire internal signals to outputs   
   //--------------------------------------------------------------------

   assign TXOUTCLK_0      =   gt_txoutclk1_0;
   assign RXNOTINTABLE_0  =   RXNOTINTABLE_0_INT;
   assign RXDISPERR_0     =   RXDISPERR_0_INT;

   assign RESETDONE_0  = resetdone0_i;
   assign RXELECIDLE_0 = rxelecidle0_i;

  
 

   //--------------------------------------------------------------------
   // Instantiate the Virtex-5 GTX
   // EMAC0 connects to GTX 0 and EMAC1 connects to GTX 1
   //--------------------------------------------------------------------

   // Direct from the RocketIO Wizard output
   ROCKETIO_WRAPPER_GTX #
    (
        .WRAPPER_SIM_GTXRESET_SPEEDUP           (1),
        .WRAPPER_SIM_PLL_PERDIV2                (9'h0c8)
    )
    GTX_1000X
    (
        //------------------- Shared Ports - Tile and PLL Ports --------------------
        .TILE0_CLKIN_IN                 (CLK_DS),
        .TILE0_GTXRESET_IN              (GTRESET),
        .TILE0_PLLLKDET_OUT             (PLLLOCK),
        .TILE0_REFCLKOUT_OUT            (REFCLKOUT),
        //---------------------- Loopback and Powerdown Ports ----------------------
        .TILE0_LOOPBACK0_IN             ({2'b00, LOOPBACK_0}),
        .TILE0_RXPOWERDOWN0_IN          ({POWERDOWN_0, POWERDOWN_0}),
        .TILE0_TXPOWERDOWN0_IN          ({POWERDOWN_0, POWERDOWN_0}),
        //--------------------- Receive Ports - 8b10b Decoder ----------------------
        .TILE0_RXCHARISCOMMA0_OUT       (RXCHARISCOMMA_0),
        .TILE0_RXCHARISK0_OUT           (RXCHARISK_0_INT),
        .TILE0_RXDISPERR0_OUT           (RXDISPERR_0_INT),
        .TILE0_RXNOTINTABLE0_OUT        (RXNOTINTABLE_0_INT),
        .TILE0_RXRUNDISP0_OUT           (RXRUNDISP_0_INT),
        //----------------- Receive Ports - Clock Correction Ports -----------------
        .TILE0_RXCLKCORCNT0_OUT         (RXCLKCORCNT_0),
        //------------- Receive Ports - Comma Detection and Alignment --------------
        .TILE0_RXENMCOMMAALIGN0_IN      (ENMCOMMAALIGN_0),
        .TILE0_RXENPCOMMAALIGN0_IN      (ENPCOMMAALIGN_0),
        //----------------- Receive Ports - RX Data Path interface -----------------
        .TILE0_RXDATA0_OUT              (RXDATA_0_INT),
        .TILE0_RXRECCLK0_OUT            (),
        .TILE0_RXRESET0_IN              (RXRESET_0),
        .TILE0_RXUSRCLK0_IN             (RXUSRCLK_0),
        .TILE0_RXUSRCLK20_IN            (RXUSRCLK2_0),
        //------ Receive Ports - RX Elastic Buffer and Phase Alignment Ports -------
        .TILE0_RXBUFSTATUS0_OUT         ({RXBUFERR_0, RXBUFSTATUS_float0}),
	.TILE0_RXBUFRESET0_IN           (RXRESET_0),
        //----- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
        .TILE0_RXELECIDLE0_OUT          (rxelecidle0_i),
        .TILE0_RXN0_IN                  (RX1N_0),
        .TILE0_RXP0_IN                  (RX1P_0),       
        //------------- ResetDone Ports --------------------------------------------
        .TILE0_RESETDONE0_OUT           (resetdone0_i),
        //-------------- Transmit Ports - 8b10b Encoder Control Ports --------------
        .TILE0_TXCHARDISPMODE0_IN       (TXCHARDISPMODE_0),
        .TILE0_TXCHARDISPVAL0_IN        (TXCHARDISPVAL_0),
        .TILE0_TXCHARISK0_IN            (TXCHARISK_0),
        //----------- Transmit Ports - TX Buffering and Phase Alignment ------------
        .TILE0_TXBUFSTATUS0_OUT         ({TXBUFERR_0, TXBUFSTATUS_float0}),
        //---------------- Transmit Ports - TX Data Path interface -----------------
        .TILE0_TXDATA0_IN               (TXDATA_0),
        .TILE0_TXOUTCLK0_OUT            (gt_txoutclk1_0),
        .TILE0_TXRESET0_IN              (TXRESET_0),
        .TILE0_TXUSRCLK0_IN             (TXUSRCLK_0),
        .TILE0_TXUSRCLK20_IN            (TXUSRCLK2_0),
        //------------- Transmit Ports - TX Driver and OOB signalling --------------
        .TILE0_TXN0_OUT                 (TX1N_0),
        .TILE0_TXP0_OUT                 (TX1P_0),
        .TILE0_LOOPBACK1_IN             (3'b000),
        .TILE0_RXPOWERDOWN1_IN          (2'b00),
        .TILE0_TXPOWERDOWN1_IN          (2'b00),
        .TILE0_RXCHARISCOMMA1_OUT       (),
        .TILE0_RXCHARISK1_OUT           (),
        .TILE0_RXDISPERR1_OUT           (),
        .TILE0_RXNOTINTABLE1_OUT        (),
        .TILE0_RXRUNDISP1_OUT           (),
        .TILE0_RXCLKCORCNT1_OUT         (),
        .TILE0_RXENMCOMMAALIGN1_IN      (1'b0),
        .TILE0_RXENPCOMMAALIGN1_IN      (1'b0),
        .TILE0_RXDATA1_OUT              (),
        .TILE0_RXRECCLK1_OUT            (),
        .TILE0_RXRESET1_IN              (1'b0),
        .TILE0_RXUSRCLK1_IN             (1'b0),
        .TILE0_RXUSRCLK21_IN            (1'b0),
        .TILE0_RXBUFRESET1_IN           (1'b0),
        .TILE0_RXBUFSTATUS1_OUT         (),
        .TILE0_RXELECIDLE1_OUT          (),
        .TILE0_RXN1_IN                  (RX1N_1_UNUSED),
        .TILE0_RXP1_IN                  (RX1P_1_UNUSED),       
        .TILE0_RESETDONE1_OUT           (),
        .TILE0_TXCHARDISPMODE1_IN       (1'b0),
        .TILE0_TXCHARDISPVAL1_IN        (1'b0),
        .TILE0_TXCHARISK1_IN            (1'b0),
        .TILE0_TXBUFSTATUS1_OUT         (),
        .TILE0_TXDATA1_IN               (8'h00),
        .TILE0_TXOUTCLK1_OUT            (),
        .TILE0_TXRESET1_IN              (1'b0),
        .TILE0_TXUSRCLK1_IN             (1'b0),
        .TILE0_TXUSRCLK21_IN            (1'b0),
        .TILE0_TXN1_OUT                 (TX1N_1_UNUSED),
        .TILE0_TXP1_OUT                 (TX1P_1_UNUSED)	
   );


 
                       
   //---------------------------------------------------------------------------
   // EMAC0 to GTX logic shim
   //---------------------------------------------------------------------------

   // When the RXNOTINTABLE condition is detected, the Virtex5 RocketIO
   // GTX outputs the raw 10B code in a bit swapped order to that of the
   // Virtex-II Pro RocketIO.
   always @ (RXNOTINTABLE_0_INT, RXDISPERR_0_INT, RXCHARISK_0_INT, RXDATA_0_INT,
                         RXRUNDISP_0_INT)
   begin
      if (RXNOTINTABLE_0_INT == 1'b1)
      begin
         RXDATA_0[0] <= RXDISPERR_0_INT;
         RXDATA_0[1] <= RXCHARISK_0_INT;
         RXDATA_0[2] <= RXDATA_0_INT[7];
         RXDATA_0[3] <= RXDATA_0_INT[6];
         RXDATA_0[4] <= RXDATA_0_INT[5];
         RXDATA_0[5] <= RXDATA_0_INT[4];
         RXDATA_0[6] <= RXDATA_0_INT[3];
         RXDATA_0[7] <= RXDATA_0_INT[2];
         RXRUNDISP_0 <= RXDATA_0_INT[1];
         RXCHARISK_0 <= RXDATA_0_INT[0];
      end
      else
      begin
         RXDATA_0    <= RXDATA_0_INT;
         RXRUNDISP_0 <= RXRUNDISP_0_INT;
         RXCHARISK_0 <= RXCHARISK_0_INT;
      end
   end




endmodule

