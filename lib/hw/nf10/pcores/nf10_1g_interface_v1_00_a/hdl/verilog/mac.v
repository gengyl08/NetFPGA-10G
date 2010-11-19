//-----------------------------------------------------------------------------
// Title      : Virtex-5 Ethernet MAC Wrapper
//-----------------------------------------------------------------------------
// File       : mac.v
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

//------------------------------------------------------------------------------
// Description:  This wrapper file instantiates the full Virtex-5 Ethernet 
//               MAC (EMAC) primitive.  For one or both of the two Ethernet MACs
//               (EMAC0/EMAC1):
//
//               * all unused input ports on the primitive will be tied to the
//                 appropriate logic level;
//
//               * all unused output ports on the primitive will be left 
//                 unconnected;
//
//               * the Tie-off Vector will be connected based on the options 
//                 selected from CORE Generator;
//
//               * only used ports will be connected to the ports of this 
//                 wrapper file.
//
//               This simplified wrapper should therefore be used as the 
//               instantiation template for the EMAC in customer designs.
//------------------------------------------------------------------------------

`timescale 1 ps / 1 ps


//------------------------------------------------------------------------------
// The module declaration for the top level wrapper.
//------------------------------------------------------------------------------
(* X_CORE_INFO = "v5_emac_v1_6, Coregen 11.1" *)
module mac
(
    // Client Receiver Interface - EMAC0
    EMAC0CLIENTRXCLIENTCLKOUT,
    CLIENTEMAC0RXCLIENTCLKIN,
    EMAC0CLIENTRXD,
    EMAC0CLIENTRXDVLD,
    EMAC0CLIENTRXDVLDMSW,
    EMAC0CLIENTRXGOODFRAME,
    EMAC0CLIENTRXBADFRAME,
    EMAC0CLIENTRXFRAMEDROP,
    EMAC0CLIENTRXSTATS,
    EMAC0CLIENTRXSTATSVLD,
    EMAC0CLIENTRXSTATSBYTEVLD,

    // Client Transmitter Interface - EMAC0
    EMAC0CLIENTTXCLIENTCLKOUT,
    CLIENTEMAC0TXCLIENTCLKIN,
    CLIENTEMAC0TXD,
    CLIENTEMAC0TXDVLD,
    CLIENTEMAC0TXDVLDMSW,
    EMAC0CLIENTTXACK,
    CLIENTEMAC0TXFIRSTBYTE,
    CLIENTEMAC0TXUNDERRUN,
    EMAC0CLIENTTXCOLLISION,
    EMAC0CLIENTTXRETRANSMIT,
    CLIENTEMAC0TXIFGDELAY,
    EMAC0CLIENTTXSTATS,
    EMAC0CLIENTTXSTATSVLD,
    EMAC0CLIENTTXSTATSBYTEVLD,

    // MAC Control Interface - EMAC0
    CLIENTEMAC0PAUSEREQ,
    CLIENTEMAC0PAUSEVAL,

    // Clock Signal - EMAC0
    GTX_CLK_0,
    PHYEMAC0TXGMIIMIICLKIN,
    EMAC0PHYTXGMIIMIICLKOUT,

    // 1000BASE-X PCS/PMA Interface - EMAC0
    RXDATA_0,
    TXDATA_0,
    DCM_LOCKED_0,
    AN_INTERRUPT_0,
    SIGNAL_DETECT_0,
    PHYAD_0,
    ENCOMMAALIGN_0,
    LOOPBACKMSB_0,
    MGTRXRESET_0,
    MGTTXRESET_0,
    POWERDOWN_0,
    SYNCACQSTATUS_0,
    RXCLKCORCNT_0,
    RXBUFSTATUS_0,
    RXCHARISCOMMA_0,
    RXCHARISK_0,
    RXDISPERR_0,
    RXNOTINTABLE_0,
    RXREALIGN_0,
    RXRUNDISP_0,
    TXBUFERR_0,
    TXCHARDISPMODE_0,
    TXCHARDISPVAL_0,
    TXCHARISK_0,
    TXRUNDISP_0,


    // Client Receiver Interface - EMAC1
    EMAC1CLIENTRXCLIENTCLKOUT,
    CLIENTEMAC1RXCLIENTCLKIN,
    EMAC1CLIENTRXD,
    EMAC1CLIENTRXDVLD,
    EMAC1CLIENTRXDVLDMSW,
    EMAC1CLIENTRXGOODFRAME,
    EMAC1CLIENTRXBADFRAME,
    EMAC1CLIENTRXFRAMEDROP,
    EMAC1CLIENTRXSTATS,
    EMAC1CLIENTRXSTATSVLD,
    EMAC1CLIENTRXSTATSBYTEVLD,

    // Client Transmitter Interface - EMAC1
    EMAC1CLIENTTXCLIENTCLKOUT,
    CLIENTEMAC1TXCLIENTCLKIN,
    CLIENTEMAC1TXD,
    CLIENTEMAC1TXDVLD,
    CLIENTEMAC1TXDVLDMSW,
    EMAC1CLIENTTXACK,
    CLIENTEMAC1TXFIRSTBYTE,
    CLIENTEMAC1TXUNDERRUN,
    EMAC1CLIENTTXCOLLISION,
    EMAC1CLIENTTXRETRANSMIT,
    CLIENTEMAC1TXIFGDELAY,
    EMAC1CLIENTTXSTATS,
    EMAC1CLIENTTXSTATSVLD,
    EMAC1CLIENTTXSTATSBYTEVLD,

    // MAC Control Interface - EMAC1
    CLIENTEMAC1PAUSEREQ,
    CLIENTEMAC1PAUSEVAL,

    // Clock Signal - EMAC1
    GTX_CLK_1,
    EMAC1PHYTXGMIIMIICLKOUT,
    PHYEMAC1TXGMIIMIICLKIN,

    //  1000BASE-X PCS/PMA Interface - EMAC1
    RXDATA_1,
    TXDATA_1,
    DCM_LOCKED_1,
    AN_INTERRUPT_1,
    SIGNAL_DETECT_1,
    PHYAD_1,
    ENCOMMAALIGN_1,
    LOOPBACKMSB_1,
    MGTRXRESET_1,
    MGTTXRESET_1,
    POWERDOWN_1,
    SYNCACQSTATUS_1,
    RXCLKCORCNT_1,
    RXBUFSTATUS_1,
    RXCHARISCOMMA_1,
    RXCHARISK_1,
    RXDISPERR_1,
    RXNOTINTABLE_1,
    RXREALIGN_1,
    RXRUNDISP_1,
    TXBUFERR_1,
    TXCHARDISPMODE_1,
    TXCHARDISPVAL_1,
    TXCHARISK_1,
    TXRUNDISP_1,




    // Asynchronous Reset
    RESET
);

    //--------------------------------------------------------------------------
    // Port Declarations
    //--------------------------------------------------------------------------


    // Client Receiver Interface - EMAC0
    output          EMAC0CLIENTRXCLIENTCLKOUT;
    input           CLIENTEMAC0RXCLIENTCLKIN;
    output   [7:0]  EMAC0CLIENTRXD;
    output          EMAC0CLIENTRXDVLD;
    output          EMAC0CLIENTRXDVLDMSW;
    output          EMAC0CLIENTRXGOODFRAME;
    output          EMAC0CLIENTRXBADFRAME;
    output          EMAC0CLIENTRXFRAMEDROP;
    output   [6:0]  EMAC0CLIENTRXSTATS;
    output          EMAC0CLIENTRXSTATSVLD;
    output          EMAC0CLIENTRXSTATSBYTEVLD;

    // Client Transmitter Interface - EMAC0
    output          EMAC0CLIENTTXCLIENTCLKOUT;
    input           CLIENTEMAC0TXCLIENTCLKIN;
    input    [7:0]  CLIENTEMAC0TXD;
    input           CLIENTEMAC0TXDVLD;
    input           CLIENTEMAC0TXDVLDMSW;
    output          EMAC0CLIENTTXACK;
    input           CLIENTEMAC0TXFIRSTBYTE;
    input           CLIENTEMAC0TXUNDERRUN;
    output          EMAC0CLIENTTXCOLLISION;
    output          EMAC0CLIENTTXRETRANSMIT;
    input    [7:0]  CLIENTEMAC0TXIFGDELAY;
    output          EMAC0CLIENTTXSTATS;
    output          EMAC0CLIENTTXSTATSVLD;
    output          EMAC0CLIENTTXSTATSBYTEVLD;

    // MAC Control Interface - EMAC0
    input           CLIENTEMAC0PAUSEREQ;
    input   [15:0]  CLIENTEMAC0PAUSEVAL;

    // Clock Signal - EMAC0
    input           GTX_CLK_0;
    output          EMAC0PHYTXGMIIMIICLKOUT;
    input           PHYEMAC0TXGMIIMIICLKIN;

    // 1000BASE-X PCS/PMA Interface - EMAC0
    input    [7:0]  RXDATA_0;
    output   [7:0]  TXDATA_0;
    input           DCM_LOCKED_0;
    output          AN_INTERRUPT_0;
    input           SIGNAL_DETECT_0;
    input    [4:0]  PHYAD_0;
    output          ENCOMMAALIGN_0;
    output          LOOPBACKMSB_0;
    output          MGTRXRESET_0;
    output          MGTTXRESET_0;
    output          POWERDOWN_0;
    output          SYNCACQSTATUS_0;
    input    [2:0]  RXCLKCORCNT_0;
    input    [1:0]  RXBUFSTATUS_0;
    input           RXCHARISCOMMA_0;
    input           RXCHARISK_0;
    input           RXDISPERR_0;
    input           RXNOTINTABLE_0;
    input           RXREALIGN_0;
    input           RXRUNDISP_0;
    input           TXBUFERR_0;
    output          TXCHARDISPMODE_0;
    output          TXCHARDISPVAL_0;
    output          TXCHARISK_0;
    input           TXRUNDISP_0;


    // Client Receiver Interface - EMAC1
    output          EMAC1CLIENTRXCLIENTCLKOUT;
    input           CLIENTEMAC1RXCLIENTCLKIN;
    output   [7:0]  EMAC1CLIENTRXD;
    output          EMAC1CLIENTRXDVLD;
    output          EMAC1CLIENTRXDVLDMSW;
    output          EMAC1CLIENTRXGOODFRAME;
    output          EMAC1CLIENTRXBADFRAME;
    output          EMAC1CLIENTRXFRAMEDROP;
    output   [6:0]  EMAC1CLIENTRXSTATS;
    output          EMAC1CLIENTRXSTATSVLD;
    output          EMAC1CLIENTRXSTATSBYTEVLD;

    // Client Transmitter Interface - EMAC1
    output          EMAC1CLIENTTXCLIENTCLKOUT;
    input           CLIENTEMAC1TXCLIENTCLKIN;
    input    [7:0]  CLIENTEMAC1TXD;
    input           CLIENTEMAC1TXDVLD;
    input           CLIENTEMAC1TXDVLDMSW;
    output          EMAC1CLIENTTXACK;
    input           CLIENTEMAC1TXFIRSTBYTE;
    input           CLIENTEMAC1TXUNDERRUN;
    output          EMAC1CLIENTTXCOLLISION;
    output          EMAC1CLIENTTXRETRANSMIT;
    input    [7:0]  CLIENTEMAC1TXIFGDELAY;
    output          EMAC1CLIENTTXSTATS;
    output          EMAC1CLIENTTXSTATSVLD;
    output          EMAC1CLIENTTXSTATSBYTEVLD;

    // MAC Control Interface - EMAC1
    input           CLIENTEMAC1PAUSEREQ;
    input   [15:0]  CLIENTEMAC1PAUSEVAL;

    // Clock Signal - EMAC1
    input           GTX_CLK_1;
    output          EMAC1PHYTXGMIIMIICLKOUT;
    input           PHYEMAC1TXGMIIMIICLKIN;

    // 1000BASE-X PCS/PMA Interface - EMAC1
    input    [7:0]  RXDATA_1;
    output   [7:0]  TXDATA_1;
    input           DCM_LOCKED_1;
    output          AN_INTERRUPT_1;
    input           SIGNAL_DETECT_1;
    input    [4:0]  PHYAD_1;
    output          ENCOMMAALIGN_1;
    output          LOOPBACKMSB_1;
    output          MGTRXRESET_1;
    output          MGTTXRESET_1;
    output          POWERDOWN_1;
    output          SYNCACQSTATUS_1;
    input    [2:0]  RXCLKCORCNT_1;
    input    [1:0]  RXBUFSTATUS_1;
    input           RXCHARISCOMMA_1;
    input           RXCHARISK_1;
    input           RXDISPERR_1;
    input           RXNOTINTABLE_1;
    input           RXREALIGN_1;
    input           RXRUNDISP_1;
    input           TXBUFERR_1;
    output          TXCHARDISPMODE_1;
    output          TXCHARDISPVAL_1;
    output          TXCHARISK_1;
    input           TXRUNDISP_1;




    // Asynchronous Reset
    input           RESET;


    //--------------------------------------------------------------------------
    // Wire Declarations 
    //--------------------------------------------------------------------------


    wire    [15:0]  client_rx_data_0_i;
    wire    [15:0]  client_tx_data_0_i;


    wire    [15:0]  client_rx_data_1_i;
    wire    [15:0]  client_tx_data_1_i;



    //--------------------------------------------------------------------------
    // Main Body of Code 
    //--------------------------------------------------------------------------


    // 8-bit client data on EMAC0
    assign EMAC0CLIENTRXD = client_rx_data_0_i[7:0];
    assign #4000 client_tx_data_0_i = {8'b00000000, CLIENTEMAC0TXD};

    // 8-bit client data on EMAC1
    assign EMAC1CLIENTRXD = client_rx_data_1_i[7:0];
    assign #4000 client_tx_data_1_i = {8'b00000000, CLIENTEMAC1TXD};



    //--------------------------------------------------------------------------
    // Instantiate the Virtex-5 Embedded Ethernet EMAC
    //--------------------------------------------------------------------------
    TEMAC v5_emac
    (
        .RESET                          (RESET),

        // EMAC0
        .EMAC0CLIENTRXCLIENTCLKOUT      (EMAC0CLIENTRXCLIENTCLKOUT),
        .CLIENTEMAC0RXCLIENTCLKIN       (CLIENTEMAC0RXCLIENTCLKIN),
        .EMAC0CLIENTRXD                 (client_rx_data_0_i),
        .EMAC0CLIENTRXDVLD              (EMAC0CLIENTRXDVLD),
        .EMAC0CLIENTRXDVLDMSW           (EMAC0CLIENTRXDVLDMSW),
        .EMAC0CLIENTRXGOODFRAME         (EMAC0CLIENTRXGOODFRAME),
        .EMAC0CLIENTRXBADFRAME          (EMAC0CLIENTRXBADFRAME),
        .EMAC0CLIENTRXFRAMEDROP         (EMAC0CLIENTRXFRAMEDROP),
        .EMAC0CLIENTRXSTATS             (EMAC0CLIENTRXSTATS),
        .EMAC0CLIENTRXSTATSVLD          (EMAC0CLIENTRXSTATSVLD),
        .EMAC0CLIENTRXSTATSBYTEVLD      (EMAC0CLIENTRXSTATSBYTEVLD),

        .EMAC0CLIENTTXCLIENTCLKOUT      (EMAC0CLIENTTXCLIENTCLKOUT),
        .CLIENTEMAC0TXCLIENTCLKIN       (CLIENTEMAC0TXCLIENTCLKIN),
        .CLIENTEMAC0TXD                 (client_tx_data_0_i),
        .CLIENTEMAC0TXDVLD              (CLIENTEMAC0TXDVLD),
        .CLIENTEMAC0TXDVLDMSW           (CLIENTEMAC0TXDVLDMSW),
        .EMAC0CLIENTTXACK               (EMAC0CLIENTTXACK),
        .CLIENTEMAC0TXFIRSTBYTE         (CLIENTEMAC0TXFIRSTBYTE),
        .CLIENTEMAC0TXUNDERRUN          (CLIENTEMAC0TXUNDERRUN),
        .EMAC0CLIENTTXCOLLISION         (EMAC0CLIENTTXCOLLISION),
        .EMAC0CLIENTTXRETRANSMIT        (EMAC0CLIENTTXRETRANSMIT),
        .CLIENTEMAC0TXIFGDELAY          (CLIENTEMAC0TXIFGDELAY),
        .EMAC0CLIENTTXSTATS             (EMAC0CLIENTTXSTATS),
        .EMAC0CLIENTTXSTATSVLD          (EMAC0CLIENTTXSTATSVLD),
        .EMAC0CLIENTTXSTATSBYTEVLD      (EMAC0CLIENTTXSTATSBYTEVLD),

        .CLIENTEMAC0PAUSEREQ            (CLIENTEMAC0PAUSEREQ),
        .CLIENTEMAC0PAUSEVAL            (CLIENTEMAC0PAUSEVAL),

        .PHYEMAC0GTXCLK                 (GTX_CLK_0),
        .EMAC0PHYTXGMIIMIICLKOUT        (EMAC0PHYTXGMIIMIICLKOUT),
        .PHYEMAC0TXGMIIMIICLKIN         (PHYEMAC0TXGMIIMIICLKIN),

        .PHYEMAC0RXCLK                  (1'b0),
        .PHYEMAC0MIITXCLK               (),
        .PHYEMAC0RXD                    (RXDATA_0),
        .PHYEMAC0RXDV                   (RXREALIGN_0),
        .PHYEMAC0RXER                   (1'b0),
        .EMAC0PHYTXCLK                  (),
        .EMAC0PHYTXD                    (TXDATA_0),
        .EMAC0PHYTXEN                   (),
        .EMAC0PHYTXER                   (),
        .PHYEMAC0COL                    (TXRUNDISP_0),
        .PHYEMAC0CRS                    (1'b0),
        .CLIENTEMAC0DCMLOCKED           (DCM_LOCKED_0),
        .EMAC0CLIENTANINTERRUPT         (AN_INTERRUPT_0),
        .PHYEMAC0SIGNALDET              (SIGNAL_DETECT_0),
        .PHYEMAC0PHYAD                  (PHYAD_0),
        .EMAC0PHYENCOMMAALIGN           (ENCOMMAALIGN_0),
        .EMAC0PHYLOOPBACKMSB            (LOOPBACKMSB_0),
        .EMAC0PHYMGTRXRESET             (MGTRXRESET_0),
        .EMAC0PHYMGTTXRESET             (MGTTXRESET_0),
        .EMAC0PHYPOWERDOWN              (POWERDOWN_0),
        .EMAC0PHYSYNCACQSTATUS          (SYNCACQSTATUS_0),
        .PHYEMAC0RXCLKCORCNT            (RXCLKCORCNT_0),
        .PHYEMAC0RXBUFSTATUS            (RXBUFSTATUS_0),
        .PHYEMAC0RXBUFERR               (1'b0),
        .PHYEMAC0RXCHARISCOMMA          (RXCHARISCOMMA_0),
        .PHYEMAC0RXCHARISK              (RXCHARISK_0),
        .PHYEMAC0RXCHECKINGCRC          (1'b0),
        .PHYEMAC0RXCOMMADET             (1'b0),
        .PHYEMAC0RXDISPERR              (RXDISPERR_0),
        .PHYEMAC0RXLOSSOFSYNC           (2'b00),
        .PHYEMAC0RXNOTINTABLE           (RXNOTINTABLE_0),
        .PHYEMAC0RXRUNDISP              (RXRUNDISP_0),
        .PHYEMAC0TXBUFERR               (TXBUFERR_0),
        .EMAC0PHYTXCHARDISPMODE         (TXCHARDISPMODE_0),
        .EMAC0PHYTXCHARDISPVAL          (TXCHARDISPVAL_0),
        .EMAC0PHYTXCHARISK              (TXCHARISK_0),

        .EMAC0PHYMCLKOUT                (),
        .PHYEMAC0MCLKIN                 (1'b0),
        .PHYEMAC0MDIN                   (1'b1),
        .EMAC0PHYMDOUT                  (),
        .EMAC0PHYMDTRI                  (),
        .EMAC0SPEEDIS10100              (),

        // EMAC1
        .EMAC1CLIENTRXCLIENTCLKOUT      (EMAC1CLIENTRXCLIENTCLKOUT),
        .CLIENTEMAC1RXCLIENTCLKIN       (CLIENTEMAC1RXCLIENTCLKIN),
        .EMAC1CLIENTRXD                 (client_rx_data_1_i),
        .EMAC1CLIENTRXDVLD              (EMAC1CLIENTRXDVLD),
        .EMAC1CLIENTRXDVLDMSW           (EMAC1CLIENTRXDVLDMSW),
        .EMAC1CLIENTRXGOODFRAME         (EMAC1CLIENTRXGOODFRAME),
        .EMAC1CLIENTRXBADFRAME          (EMAC1CLIENTRXBADFRAME),
        .EMAC1CLIENTRXFRAMEDROP         (EMAC1CLIENTRXFRAMEDROP),
        .EMAC1CLIENTRXSTATS             (EMAC1CLIENTRXSTATS),
        .EMAC1CLIENTRXSTATSVLD          (EMAC1CLIENTRXSTATSVLD),
        .EMAC1CLIENTRXSTATSBYTEVLD      (EMAC1CLIENTRXSTATSBYTEVLD),

        .EMAC1CLIENTTXCLIENTCLKOUT      (EMAC1CLIENTTXCLIENTCLKOUT),
        .CLIENTEMAC1TXCLIENTCLKIN       (CLIENTEMAC1TXCLIENTCLKIN),
        .CLIENTEMAC1TXD                 (client_tx_data_1_i),
        .CLIENTEMAC1TXDVLD              (CLIENTEMAC1TXDVLD),
        .CLIENTEMAC1TXDVLDMSW           (CLIENTEMAC1TXDVLDMSW),
        .EMAC1CLIENTTXACK               (EMAC1CLIENTTXACK),
        .CLIENTEMAC1TXFIRSTBYTE         (CLIENTEMAC1TXFIRSTBYTE),
        .CLIENTEMAC1TXUNDERRUN          (CLIENTEMAC1TXUNDERRUN),
        .EMAC1CLIENTTXCOLLISION         (EMAC1CLIENTTXCOLLISION),
        .EMAC1CLIENTTXRETRANSMIT        (EMAC1CLIENTTXRETRANSMIT),
        .CLIENTEMAC1TXIFGDELAY          (CLIENTEMAC1TXIFGDELAY),
        .EMAC1CLIENTTXSTATS             (EMAC1CLIENTTXSTATS),
        .EMAC1CLIENTTXSTATSVLD          (EMAC1CLIENTTXSTATSVLD),
        .EMAC1CLIENTTXSTATSBYTEVLD      (EMAC1CLIENTTXSTATSBYTEVLD),

        .CLIENTEMAC1PAUSEREQ            (CLIENTEMAC1PAUSEREQ),
        .CLIENTEMAC1PAUSEVAL            (CLIENTEMAC1PAUSEVAL),

        .PHYEMAC1GTXCLK                 (GTX_CLK_1),
        .EMAC1PHYTXGMIIMIICLKOUT        (EMAC1PHYTXGMIIMIICLKOUT),
        .PHYEMAC1TXGMIIMIICLKIN         (PHYEMAC1TXGMIIMIICLKIN),

        .PHYEMAC1RXCLK                  (1'b0),
        .PHYEMAC1MIITXCLK               (),
        .PHYEMAC1RXD                    (RXDATA_1),
        .PHYEMAC1RXDV                   (RXREALIGN_1),
        .PHYEMAC1RXER                   (1'b0),
        .EMAC1PHYTXCLK                  (),
        .EMAC1PHYTXD                    (TXDATA_1),
        .EMAC1PHYTXEN                   (),
        .EMAC1PHYTXER                   (),
        .PHYEMAC1COL                    (TXRUNDISP_1),
        .PHYEMAC1CRS                    (1'b0),
        .CLIENTEMAC1DCMLOCKED           (DCM_LOCKED_1),
        .EMAC1CLIENTANINTERRUPT         (AN_INTERRUPT_1),
        .PHYEMAC1SIGNALDET              (SIGNAL_DETECT_1),
        .PHYEMAC1PHYAD                  (PHYAD_1),
        .EMAC1PHYENCOMMAALIGN           (ENCOMMAALIGN_1),
        .EMAC1PHYLOOPBACKMSB            (LOOPBACKMSB_1),
        .EMAC1PHYMGTRXRESET             (MGTRXRESET_1),
        .EMAC1PHYMGTTXRESET             (MGTTXRESET_1),
        .EMAC1PHYPOWERDOWN              (POWERDOWN_1),
        .EMAC1PHYSYNCACQSTATUS          (SYNCACQSTATUS_1),
        .PHYEMAC1RXCLKCORCNT            (RXCLKCORCNT_1),
        .PHYEMAC1RXBUFSTATUS            (RXBUFSTATUS_1),
        .PHYEMAC1RXBUFERR               (1'b0),
        .PHYEMAC1RXCHARISCOMMA          (RXCHARISCOMMA_1),
        .PHYEMAC1RXCHARISK              (RXCHARISK_1),
        .PHYEMAC1RXCHECKINGCRC          (1'b0),
        .PHYEMAC1RXCOMMADET             (1'b0),
        .PHYEMAC1RXDISPERR              (RXDISPERR_1),
        .PHYEMAC1RXLOSSOFSYNC           (2'b00),
        .PHYEMAC1RXNOTINTABLE           (RXNOTINTABLE_1),
        .PHYEMAC1RXRUNDISP              (RXRUNDISP_1),
        .PHYEMAC1TXBUFERR               (TXBUFERR_1),
        .EMAC1PHYTXCHARDISPMODE         (TXCHARDISPMODE_1),
        .EMAC1PHYTXCHARDISPVAL          (TXCHARDISPVAL_1),
        .EMAC1PHYTXCHARISK              (TXCHARISK_1),

        .EMAC1PHYMCLKOUT                (),
        .PHYEMAC1MCLKIN                 (1'b0),
        .PHYEMAC1MDIN                   (1'b1),
        .EMAC1PHYMDOUT                  (),
        .EMAC1PHYMDTRI                  (),
        .EMAC1SPEEDIS10100              (),

        // Host Interface 
        .HOSTCLK                        (1'b0),
        .HOSTOPCODE                     (2'b00),
        .HOSTREQ                        (1'b0),
        .HOSTMIIMSEL                    (1'b0),
        .HOSTADDR                       (10'b0000000000),
        .HOSTWRDATA                     (32'h00000000),
        .HOSTMIIMRDY                    (),
        .HOSTRDDATA                     (),
        .HOSTEMAC1SEL                   (1'b0),

        // DCR Interface
        .DCREMACCLK                     (1'b0),
        .DCREMACABUS                    (10'h000),
        .DCREMACREAD                    (1'b0),
        .DCREMACWRITE                   (1'b0),
        .DCREMACDBUS                    (32'h00000000),
        .EMACDCRACK                     (),
        .EMACDCRDBUS                    (),
        .DCREMACENABLE                  (1'b0),
        .DCRHOSTDONEIR                  ()
    );
    //------
    // EMAC0
    //------
    // Configure the PCS/PMA logic
    // PCS/PMA Reset not asserted (normal operating mode)
    //synthesis attribute EMAC0_PHYRESET of v5_emac is "FALSE"
    defparam v5_emac.EMAC0_PHYRESET = "FALSE";  
    // PCS/PMA Auto-Negotiation Enable (enabled)
    //synthesis attribute EMAC0_PHYINITAUTONEG_ENABLE of v5_emac is "FALSE"
    defparam v5_emac.EMAC0_PHYINITAUTONEG_ENABLE = "FALSE";  
    // PCS/PMA Isolate (not enabled)
    //synthesis attribute EMAC0_PHYISOLATE of v5_emac is "FALSE"
    defparam v5_emac.EMAC0_PHYISOLATE = "FALSE";  
    // PCS/PMA Powerdown (not in power down: normal operating mode)
    //synthesis attribute EMAC0_PHYPOWERDOWN of v5_emac is "FALSE"
    defparam v5_emac.EMAC0_PHYPOWERDOWN = "FALSE";  
    // PCS/PMA Loopback (not enabled)
    //synthesis attribute EMAC0_PHYLOOPBACKMSB of v5_emac is "FALSE"
    defparam v5_emac.EMAC0_PHYLOOPBACKMSB = "FALSE";  
    // Do not allow over/underflow in the GTP during auto-negotiation
    //synthesis attribute EMAC0_CONFIGVEC_79 of v5_emac is "TRUE"
    defparam v5_emac.EMAC0_CONFIGVEC_79 = "TRUE"; 
    // GT loopback (not enabled)
    //synthesis attribute EMAC0_GTLOOPBACK of v5_emac is "FALSE"
    defparam v5_emac.EMAC0_GTLOOPBACK = "FALSE"; 
    // Do not allow TX without having established a valid link
    //synthesis attribute EMAC0_UNIDIRECTION_ENABLE of v5_emac is "FALSE"
    defparam v5_emac.EMAC0_UNIDIRECTION_ENABLE = "FALSE"; 
    //synthesis attribute EMAC0_LINKTIMERVAL of v5_emac is 9'h13D
    defparam v5_emac.EMAC0_LINKTIMERVAL = 9'h13D;

    // Configure the MAC operating mode
    // MDIO is enabled
    //synthesis attribute EMAC0_MDIO_ENABLE of v5_emac is "TRUE"
    defparam v5_emac.EMAC0_MDIO_ENABLE = "TRUE";  
    // Speed is defaulted to 1000Mb/s
    //synthesis attribute EMAC0_SPEED_LSB of v5_emac is "FALSE"
    defparam v5_emac.EMAC0_SPEED_LSB = "FALSE";
    //synthesis attribute EMAC0_SPEED_MSB of v5_emac is "TRUE"
    defparam v5_emac.EMAC0_SPEED_MSB = "TRUE"; 
    //synthesis attribute EMAC0_USECLKEN of v5_emac is "FALSE"
    defparam v5_emac.EMAC0_USECLKEN = "FALSE";
    //synthesis attribute EMAC0_BYTEPHY of v5_emac is "FALSE"
    defparam v5_emac.EMAC0_BYTEPHY = "FALSE";
   
    //synthesis attribute EMAC0_RGMII_ENABLE of v5_emac is "FALSE"
    defparam v5_emac.EMAC0_RGMII_ENABLE = "FALSE";
    //synthesis attribute EMAC0_SGMII_ENABLE of v5_emac is "FALSE"
    defparam v5_emac.EMAC0_SGMII_ENABLE = "FALSE";
    // 1000BASE-X PCS/PMA is used as the PHY
    //synthesis attribute EMAC0_1000BASEX_ENABLE of v5_emac is "TRUE"
    defparam v5_emac.EMAC0_1000BASEX_ENABLE = "TRUE";  
    // The Host I/F is not  in use
    //synthesis attribute EMAC0_HOST_ENABLE of v5_emac is "FALSE"
    defparam v5_emac.EMAC0_HOST_ENABLE = "FALSE";  
    // 8-bit interface for Tx client
    //synthesis attribute EMAC0_TX16BITCLIENT_ENABLE of v5_emac is "FALSE"
    defparam v5_emac.EMAC0_TX16BITCLIENT_ENABLE = "FALSE";
    // 8-bit interface for Rx client
    //synthesis attribute EMAC0_RX16BITCLIENT_ENABLE of v5_emac is "FALSE"
    defparam v5_emac.EMAC0_RX16BITCLIENT_ENABLE = "FALSE";    
    // The Address Filter (not enabled)
    //synthesis attribute EMAC0_ADDRFILTER_ENABLE of v5_emac is "FALSE"
    defparam v5_emac.EMAC0_ADDRFILTER_ENABLE = "FALSE";  

    // MAC configuration defaults
    // Rx Length/Type checking enabled (standard IEEE operation)
    //synthesis attribute EMAC0_LTCHECK_DISABLE of v5_emac is "FALSE"
    defparam v5_emac.EMAC0_LTCHECK_DISABLE = "FALSE";  
    // Rx Flow Control (not enabled)
    //synthesis attribute EMAC0_RXFLOWCTRL_ENABLE of v5_emac is "FALSE"
    defparam v5_emac.EMAC0_RXFLOWCTRL_ENABLE = "FALSE";  
    // Tx Flow Control (not enabled)
    //synthesis attribute EMAC0_TXFLOWCTRL_ENABLE of v5_emac is "FALSE"
    defparam v5_emac.EMAC0_TXFLOWCTRL_ENABLE = "FALSE";  
    // Transmitter is not held in reset not asserted (normal operating mode)
    //synthesis attribute EMAC0_TXRESET of v5_emac is "FALSE"
    defparam v5_emac.EMAC0_TXRESET = "FALSE";  
    // Transmitter Jumbo Frames (not enabled)
    //synthesis attribute EMAC0_TXJUMBOFRAME_ENABLE of v5_emac is "FALSE"
    defparam v5_emac.EMAC0_TXJUMBOFRAME_ENABLE = "FALSE";  
    // Transmitter In-band FCS (not enabled)
    //synthesis attribute EMAC0_TXINBANDFCS_ENABLE of v5_emac is "FALSE"
    defparam v5_emac.EMAC0_TXINBANDFCS_ENABLE = "FALSE";  
    // Transmitter Enabled
    //synthesis attribute EMAC0_TX_ENABLE of v5_emac is "TRUE"
    defparam v5_emac.EMAC0_TX_ENABLE = "TRUE";  
    // Transmitter VLAN mode (not enabled)
    //synthesis attribute EMAC0_TXVLAN_ENABLE of v5_emac is "FALSE"
    defparam v5_emac.EMAC0_TXVLAN_ENABLE = "FALSE";  
    // Transmitter Half Duplex mode (not enabled)
    //synthesis attribute EMAC0_TXHALFDUPLEX of v5_emac is "FALSE"
    defparam v5_emac.EMAC0_TXHALFDUPLEX = "FALSE";  
    // Transmitter IFG Adjust (not enabled)
    //synthesis attribute EMAC0_TXIFGADJUST_ENABLE of v5_emac is "FALSE"
    defparam v5_emac.EMAC0_TXIFGADJUST_ENABLE = "FALSE";  
    // Receiver is not held in reset not asserted (normal operating mode)
    //synthesis attribute EMAC0_RXRESET of v5_emac is "FALSE"
    defparam v5_emac.EMAC0_RXRESET = "FALSE";  
    // Receiver Jumbo Frames (not enabled)
    //synthesis attribute EMAC0_RXJUMBOFRAME_ENABLE of v5_emac is "FALSE"
    defparam v5_emac.EMAC0_RXJUMBOFRAME_ENABLE = "FALSE";  
    // Receiver In-band FCS (not enabled)
    //synthesis attribute EMAC0_RXINBANDFCS_ENABLE of v5_emac is "FALSE"
    defparam v5_emac.EMAC0_RXINBANDFCS_ENABLE = "FALSE";  
    // Receiver Enabled
    //synthesis attribute EMAC0_RX_ENABLE of v5_emac is "TRUE"
    defparam v5_emac.EMAC0_RX_ENABLE = "TRUE";  
    // Receiver VLAN mode (not enabled)
    //synthesis attribute EMAC0_RXVLAN_ENABLE of v5_emac is "FALSE"
    defparam v5_emac.EMAC0_RXVLAN_ENABLE = "FALSE";  
    // Receiver Half Duplex mode (not enabled)
    //synthesis attribute EMAC0_RXHALFDUPLEX of v5_emac is "FALSE"
    defparam v5_emac.EMAC0_RXHALFDUPLEX = "FALSE";  

    // Set the Pause Address Default
    //synthesis attribute EMAC0_PAUSEADDR of v5_emac is 48'hFFEEDDCCBBAA
    defparam v5_emac.EMAC0_PAUSEADDR = 48'hFFEEDDCCBBAA;

    //synthesis attribute EMAC0_UNICASTADDR of v5_emac is 48'h000000000000
    defparam v5_emac.EMAC0_UNICASTADDR = 48'h000000000000;
 
    //synthesis attribute EMAC0_DCRBASEADDR of v5_emac is 8'h00
    defparam v5_emac.EMAC0_DCRBASEADDR = 8'h00;
    //------
    // EMAC1
    //------
    // Configure the PCS/PMA logic
    // PCS/PMA Reset not asserted (normal operating mode)
    //synthesis attribute EMAC1_PHYRESET of v5_emac is "FALSE"
    defparam v5_emac.EMAC1_PHYRESET = "FALSE";  
    // PCS/PMA Auto-Negotiation Enable (enabled)
    //synthesis attribute EMAC1_PHYINITAUTONEG_ENABLE of v5_emac is "FALSE"
    defparam v5_emac.EMAC1_PHYINITAUTONEG_ENABLE = "FALSE";  
    // PCS/PMA Isolate (not enabled)
    //synthesis attribute EMAC1_PHYISOLATE of v5_emac is "FALSE"
    defparam v5_emac.EMAC1_PHYISOLATE = "FALSE";  
    // PCS/PMA Powerdown (not in power down: normal operating mode)
    //synthesis attribute EMAC1_PHYPOWERDOWN of v5_emac is "FALSE"
    defparam v5_emac.EMAC1_PHYPOWERDOWN = "FALSE";  
    // PCS/PMA Loopback (not enabled)
    //synthesis attribute EMAC1_PHYLOOPBACKMSB of v5_emac is "FALSE"
    defparam v5_emac.EMAC1_PHYLOOPBACKMSB = "FALSE";  
    // Do not allow over/underflow in the GTP during auto-negotiation
    //synthesis attribute EMAC1_CONFIGVEC_79 of v5_emac is "TRUE"
    defparam v5_emac.EMAC1_CONFIGVEC_79 = "TRUE"; 
    // GT loopback (not enabled)
    //synthesis attribute EMAC1_GTLOOPBACK of v5_emac is "FALSE"
    defparam v5_emac.EMAC1_GTLOOPBACK = "FALSE"; 
    // Do not allow TX without having established a valid link
    //synthesis attribute EMAC1_UNIDIRECTION_ENABLE of v5_emac is "FALSE"
    defparam v5_emac.EMAC1_UNIDIRECTION_ENABLE = "FALSE"; 
    //synthesis attribute EMAC1_LINKTIMERVAL of v5_emac is 9'h13D
    defparam v5_emac.EMAC1_LINKTIMERVAL = 9'h13D;

    // Configure the MAC operating mode
    // MDIO is enabled
    //synthesis attribute EMAC1_MDIO_ENABLE of v5_emac is "TRUE"
    defparam v5_emac.EMAC1_MDIO_ENABLE = "TRUE";  
    // Speed is defaulted to 1000Mb/s
    //synthesis attribute EMAC1_SPEED_LSB of v5_emac is "FALSE"
    defparam v5_emac.EMAC1_SPEED_LSB = "FALSE";
    //synthesis attribute EMAC1_SPEED_MSB of v5_emac is "TRUE"
    defparam v5_emac.EMAC1_SPEED_MSB = "TRUE"; 
    //synthesis attribute EMAC1_USECLKEN of v5_emac is "FALSE"
    defparam v5_emac.EMAC1_USECLKEN = "FALSE";
    //synthesis attribute EMAC1_BYTEPHY of v5_emac is "FALSE"
    defparam v5_emac.EMAC1_BYTEPHY = "FALSE";
   
    //synthesis attribute EMAC1_RGMII_ENABLE of v5_emac is "FALSE"
    defparam v5_emac.EMAC1_RGMII_ENABLE = "FALSE";
    //synthesis attribute EMAC1_SGMII_ENABLE of v5_emac is "FALSE"
    defparam v5_emac.EMAC1_SGMII_ENABLE = "FALSE";
    // 1000BASE-X PCS/PMA is used as the PHY
    //synthesis attribute EMAC1_1000BASEX_ENABLE of v5_emac is "TRUE"
    defparam v5_emac.EMAC1_1000BASEX_ENABLE = "TRUE";  
    // The Host I/F is not  in use
    //synthesis attribute EMAC1_HOST_ENABLE of v5_emac is "FALSE"
    defparam v5_emac.EMAC1_HOST_ENABLE = "FALSE";  
    // 8-bit interface for Tx client
    //synthesis attribute EMAC1_TX16BITCLIENT_ENABLE of v5_emac is "FALSE"
    defparam v5_emac.EMAC1_TX16BITCLIENT_ENABLE = "FALSE";
    // 8-bit interface for Rx client
    //synthesis attribute EMAC1_RX16BITCLIENT_ENABLE of v5_emac is "FALSE"
    defparam v5_emac.EMAC1_RX16BITCLIENT_ENABLE = "FALSE";    
    // The Address Filter (not enabled)
    //synthesis attribute EMAC1_ADDRFILTER_ENABLE of v5_emac is "FALSE"
    defparam v5_emac.EMAC1_ADDRFILTER_ENABLE = "FALSE";  

    // MAC configuration defaults
    // Rx Length/Type checking enabled (standard IEEE operation)
    //synthesis attribute EMAC1_LTCHECK_DISABLE of v5_emac is "FALSE"
    defparam v5_emac.EMAC1_LTCHECK_DISABLE = "FALSE";  
    // Rx Flow Control (not enabled)
    //synthesis attribute EMAC1_RXFLOWCTRL_ENABLE of v5_emac is "FALSE"
    defparam v5_emac.EMAC1_RXFLOWCTRL_ENABLE = "FALSE";  
    // Tx Flow Control (not enabled)
    //synthesis attribute EMAC1_TXFLOWCTRL_ENABLE of v5_emac is "FALSE"
    defparam v5_emac.EMAC1_TXFLOWCTRL_ENABLE = "FALSE";  
    // Transmitter is not held in reset not asserted (normal operating mode)
    //synthesis attribute EMAC1_TXRESET of v5_emac is "FALSE"
    defparam v5_emac.EMAC1_TXRESET = "FALSE";  
    // Transmitter Jumbo Frames (not enabled)
    //synthesis attribute EMAC1_TXJUMBOFRAME_ENABLE of v5_emac is "FALSE"
    defparam v5_emac.EMAC1_TXJUMBOFRAME_ENABLE = "FALSE";  
    // Transmitter In-band FCS (not enabled)
    //synthesis attribute EMAC1_TXINBANDFCS_ENABLE of v5_emac is "FALSE"
    defparam v5_emac.EMAC1_TXINBANDFCS_ENABLE = "FALSE";  
    // Transmitter Enabled
    //synthesis attribute EMAC1_TX_ENABLE of v5_emac is "TRUE"
    defparam v5_emac.EMAC1_TX_ENABLE = "TRUE";  
    // Transmitter VLAN mode (not enabled)
    //synthesis attribute EMAC1_TXVLAN_ENABLE of v5_emac is "FALSE"
    defparam v5_emac.EMAC1_TXVLAN_ENABLE = "FALSE";  
    // Transmitter Half Duplex mode (not enabled)
    //synthesis attribute EMAC1_TXHALFDUPLEX of v5_emac is "FALSE"
    defparam v5_emac.EMAC1_TXHALFDUPLEX = "FALSE";  
    // Transmitter IFG Adjust (not enabled)
    //synthesis attribute EMAC1_TXIFGADJUST_ENABLE of v5_emac is "FALSE"
    defparam v5_emac.EMAC1_TXIFGADJUST_ENABLE = "FALSE";  
    // Receiver is not held in reset not asserted (normal operating mode)
    //synthesis attribute EMAC1_RXRESET of v5_emac is "FALSE"
    defparam v5_emac.EMAC1_RXRESET = "FALSE";  
    // Receiver Jumbo Frames (not enabled)
    //synthesis attribute EMAC1_RXJUMBOFRAME_ENABLE of v5_emac is "FALSE"
    defparam v5_emac.EMAC1_RXJUMBOFRAME_ENABLE = "FALSE";  
    // Receiver In-band FCS (not enabled)
    //synthesis attribute EMAC1_RXINBANDFCS_ENABLE of v5_emac is "FALSE"
    defparam v5_emac.EMAC1_RXINBANDFCS_ENABLE = "FALSE";  
    // Receiver Enabled
    //synthesis attribute EMAC1_RX_ENABLE of v5_emac is "TRUE"
    defparam v5_emac.EMAC1_RX_ENABLE = "TRUE";  
    // Receiver VLAN mode (not enabled)
    //synthesis attribute EMAC1_RXVLAN_ENABLE of v5_emac is "FALSE"
    defparam v5_emac.EMAC1_RXVLAN_ENABLE = "FALSE";  
    // Receiver Half Duplex mode (not enabled)
    //synthesis attribute EMAC1_RXHALFDUPLEX of v5_emac is "FALSE"
    defparam v5_emac.EMAC1_RXHALFDUPLEX = "FALSE";  

    // Set the Pause Address Default
    //synthesis attribute EMAC1_PAUSEADDR of v5_emac is 48'hFFEEDDCCBBAA
    defparam v5_emac.EMAC1_PAUSEADDR = 48'hFFEEDDCCBBAA;

    //synthesis attribute EMAC1_UNICASTADDR of v5_emac is 48'h000000000000
    defparam v5_emac.EMAC1_UNICASTADDR = 48'h000000000000;
 
    //synthesis attribute EMAC1_DCRBASEADDR of v5_emac is 8'h00
    defparam v5_emac.EMAC1_DCRBASEADDR = 8'h00;

endmodule

