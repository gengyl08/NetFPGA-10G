//-----------------------------------------------------------------------------
// Title      : Virtex-5 Ethernet MAC Wrapper Top Level
// Project    : Virtex-5 Ethernet MAC Wrappers
//-----------------------------------------------------------------------------
// File       : mac_block.v
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
//-----------------------------------------------------------------------------
// Description:  This is the EMAC block level Verilog design for the Virtex-5 
//               Embedded Ethernet MAC Example Design.  It is intended that
//               this example design can be quickly adapted and downloaded onto
//               an FPGA to provide a real hardware test environment.
//
//               The block level:
//
//               * instantiates all clock management logic required (BUFGs, 
//                 DCMs) to operate the EMAC and its example design;
//
//               * instantiates appropriate PHY interface modules (GMII, MII,
//                 RGMII, SGMII or 1000BASE-X) as required based on the user
//                 configuration.
//
//
//               Please refer to the Datasheet, Getting Started Guide, and
//               the Virtex-5 Embedded Tri-Mode Ethernet MAC User Gude for
//               further information.
//-----------------------------------------------------------------------------


`timescale 1 ps / 1 ps


//-----------------------------------------------------------------------------
// The module declaration for the top level design.
//-----------------------------------------------------------------------------
module mac_block
# (parameter PIPELINE_PORT_0 = 1,
             PIPELINE_PORT_1 = 1)
  (
    // EMAC0 Clocking
    // 125MHz clock output from transceiver
    CLK125_OUT,
    // 125MHz clock input from BUFG
    CLK125,
    // 62.5MHz clock input from BUFG
    CLK62_5,

    // Client Receiver Interface - EMAC0
    EMAC0CLIENTRXD,
    EMAC0CLIENTRXDVLD,
    EMAC0CLIENTRXGOODFRAME,
    EMAC0CLIENTRXBADFRAME,
    EMAC0CLIENTRXFRAMEDROP,
    EMAC0CLIENTRXSTATS,
    EMAC0CLIENTRXSTATSVLD,
    EMAC0CLIENTRXSTATSBYTEVLD,

    // Client Transmitter Interface - EMAC0
    CLIENTEMAC0TXD,
    CLIENTEMAC0TXDVLD,
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

    //EMAC-MGT link status
    EMAC0CLIENTSYNCACQSTATUS,
    //EMAC0 Interrupt
    EMAC0ANINTERRUPT,


    // 1000BASE-X PCS/PMA Interface - EMAC0
    TXP_0,
    TXN_0,
    RXP_0,
    RXN_0,
    PHYAD_0,
    RESETDONE_0,

    // EMAC1 Clocking

    // Client Receiver Interface - EMAC1
    EMAC1CLIENTRXD,
    EMAC1CLIENTRXDVLD,
    EMAC1CLIENTRXGOODFRAME,
    EMAC1CLIENTRXBADFRAME,
    EMAC1CLIENTRXFRAMEDROP,
    EMAC1CLIENTRXSTATS,
    EMAC1CLIENTRXSTATSVLD,
    EMAC1CLIENTRXSTATSBYTEVLD,

    // Client Transmitter Interface - EMAC1
    CLIENTEMAC1TXD,
    CLIENTEMAC1TXDVLD,
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

    //EMAC-MGT link status
    EMAC1CLIENTSYNCACQSTATUS,
    //EMAC1 Interrupt 
    EMAC1ANINTERRUPT,


    // 1000BASE-X PCS/PMA Interface - EMAC1
    TXP_1,
    TXN_1,
    RXP_1,
    RXN_1,
    PHYAD_1,
    RESETDONE_1,

    // 1000BASE-X PCS/PMA Clock buffer inputs 
    CLK_DS_0, 
    CLK_DS_1, 
    GTRESET,

    // Asynchronous Reset Input
    RESET
);


//-----------------------------------------------------------------------------
// Port Declarations 
//-----------------------------------------------------------------------------
    // EMAC0 Clocking
    // 125MHz clock output from transceiver
    output          CLK125_OUT;
    // 125MHz clock input from BUFG
    input           CLK125;
    // 62.5MHz clock input from BUFG
    input           CLK62_5;

    // Client Receiver Interface - EMAC0
    output   [7:0]  EMAC0CLIENTRXD;
    output          EMAC0CLIENTRXDVLD;
    output          EMAC0CLIENTRXGOODFRAME;
    output          EMAC0CLIENTRXBADFRAME;
    output          EMAC0CLIENTRXFRAMEDROP;
    output   [6:0]  EMAC0CLIENTRXSTATS;
    output          EMAC0CLIENTRXSTATSVLD;
    output          EMAC0CLIENTRXSTATSBYTEVLD;

    // Client Transmitter Interface - EMAC0
    input    [7:0]  CLIENTEMAC0TXD;
    input           CLIENTEMAC0TXDVLD;
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

    //EMAC-MGT link status
    output          EMAC0CLIENTSYNCACQSTATUS;
    //EMAC0 Interrupt
    output          EMAC0ANINTERRUPT;


    // 1000BASE-X PCS/PMA Interface - EMAC0
    output          TXP_0;
    output          TXN_0;
    input           RXP_0;
    input           RXN_0;
    input           [4:0] PHYAD_0;
    output          RESETDONE_0;

    // EMAC1 Clocking

    // Client Receiver Interface - EMAC1
    output   [7:0]  EMAC1CLIENTRXD;
    output          EMAC1CLIENTRXDVLD;
    output          EMAC1CLIENTRXGOODFRAME;
    output          EMAC1CLIENTRXBADFRAME;
    output          EMAC1CLIENTRXFRAMEDROP;
    output   [6:0]  EMAC1CLIENTRXSTATS;
    output          EMAC1CLIENTRXSTATSVLD;
    output          EMAC1CLIENTRXSTATSBYTEVLD;

    // Client Transmitter Interface - EMAC1
    input    [7:0]  CLIENTEMAC1TXD;
    input           CLIENTEMAC1TXDVLD;
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

    //EMAC-MGT link status
    output          EMAC1CLIENTSYNCACQSTATUS;
    //EMAC1 Interrupt
    output          EMAC1ANINTERRUPT;


    // 1000BASE-X PCS/PMA Interface - EMAC1
    output          TXP_1;
    output          TXN_1;
    input           RXP_1;
    input           RXN_1;
    input           [4:0] PHYAD_1;
    output          RESETDONE_1;

    // 1000BASE-X PCS/PMA Clock buffer inputs 
    input           CLK_DS_0; 
    input           CLK_DS_1;
    input           GTRESET; 

    // Asynchronous Reset
    input           RESET;

//-----------------------------------------------------------------------------
// Wire and Reg Declarations 
//-----------------------------------------------------------------------------

    // Asynchronous reset signals
    wire            reset_ibuf_i;
    wire            reset_i;
    reg      [3:0]  reset_r;

    // EMAC0 client clocking signals
    wire            rx_client_clk_out_0_i;
    wire            rx_client_clk_in_0_i;
    wire            tx_client_clk_out_0_i;
    wire            tx_client_clk_in_0_i;

    // EMAC0 Physical interface signals
    wire           emac_locked_0_i;
    reg            emac_locked_0_ii;
    wire    [7:0]  mgt_rx_data_0_i;
    reg     [7:0]  mgt_rx_data_0_ii;
    reg     [7:0]  mgt_tx_data_0_i;
    wire    [7:0]  mgt_tx_data_0_ii;
    wire           signal_detect_0_i;
    reg            signal_detect_0_ii;
    wire           rxelecidle_0_i;
    reg            encommaalign_0_i;
    wire           encommaalign_0_ii;
    reg            loopback_0_i;
    wire           loopback_0_ii;
    reg            mgt_rx_reset_0_i;
    wire           mgt_rx_reset_0_ii;
    reg            mgt_tx_reset_0_i;
    wire           mgt_tx_reset_0_ii;
    reg            powerdown_0_i;
    wire           powerdown_0_ii;
    wire    [2:0]  rxclkcorcnt_0_i;
    reg     [2:0]  rxclkcorcnt_0_ii;
    wire           rxbuferr_0_i;
    reg            rxbuferr_0_ii;
    wire           rxchariscomma_0_i;
    reg            rxchariscomma_0_ii;
    wire           rxcharisk_0_i;
    reg            rxcharisk_0_ii;
    wire           rxdisperr_0_i;
    reg            rxdisperr_0_ii;
    wire    [1:0]  rxlossofsync_0_i; 
    reg     [1:0]  rxlossofsync_0_ii;
    wire           rxnotintable_0_i;
    reg            rxnotintable_0_ii;
    wire           rxrundisp_0_i;
    reg            rxrundisp_0_ii;
    wire           txbuferr_0_i;
    reg            txbuferr_0_ii;
    reg            txchardispmode_0_i;
    wire           txchardispmode_0_ii;
    reg            txchardispval_0_i;
    wire           txchardispval_0_ii;
    reg            txcharisk_0_i;
    wire           txcharisk_0_ii;
    wire    [1:0]  rxbufstatus_0_i;
    reg     [3:0]  tx_reset_sm_0_r;
    reg            tx_pcs_reset_0_r;
    reg     [3:0]  rx_reset_sm_0_r;
    reg            rx_pcs_reset_0_r;

    // EMAC1 client clocking signals
    wire            rx_client_clk_out_1_i;
    wire            rx_client_clk_in_1_i;
    wire            tx_client_clk_out_1_i;
    wire            tx_client_clk_in_1_i;

    // EMAC1 Physical interface signals
    wire           emac_locked_1_i;
    reg            emac_locked_1_ii;
    wire    [7:0]  mgt_rx_data_1_i;
    reg     [7:0]  mgt_rx_data_1_ii;
    reg     [7:0]  mgt_tx_data_1_i;
    wire    [7:0]  mgt_tx_data_1_ii;
    wire           signal_detect_1_i;
    reg            signal_detect_1_ii;
    wire           rxelecidle_1_i;
    reg            encommaalign_1_i;
    wire           encommaalign_1_ii;
    reg            loopback_1_i;
    wire           loopback_1_ii;
    reg            mgt_rx_reset_1_i;
    wire           mgt_rx_reset_1_ii;
    reg            mgt_tx_reset_1_i;
    wire           mgt_tx_reset_1_ii;
    reg            powerdown_1_i;
    wire           powerdown_1_ii;
    wire    [2:0]  rxclkcorcnt_1_i;
    reg     [2:0]  rxclkcorcnt_1_ii;
    wire           rxbuferr_1_i;
    reg            rxbuferr_1_ii;
    wire           rxchariscomma_1_i;
    reg            rxchariscomma_1_ii;
    wire           rxcharisk_1_i;
    reg            rxcharisk_1_ii;
    wire           rxdisperr_1_i;
    reg            rxdisperr_1_ii;
    wire    [1:0]  rxlossofsync_1_i; 
    reg     [1:0]  rxlossofsync_1_ii;
    wire           rxnotintable_1_i;
    reg            rxnotintable_1_ii;
    wire           rxrundisp_1_i;
    reg            rxrundisp_1_ii;
    wire           txbuferr_1_i;
    reg            txbuferr_1_ii;
    reg            txchardispmode_1_i;
    wire           txchardispmode_1_ii;
    reg            txchardispval_1_i;
    wire           txchardispval_1_ii;
    reg            txcharisk_1_i;
    wire           txcharisk_1_ii;
    wire    [1:0]  rxbufstatus_1_i;
    reg     [3:0]  tx_reset_sm_1_r;
    reg            tx_pcs_reset_1_r;
    reg     [3:0]  rx_reset_sm_1_r;
    reg            rx_pcs_reset_1_r;

    // Transceiver clocking signals
    wire            usrclk2;
    wire            usrclk;
   
    wire            refclkout;
    wire            dcm_locked_gtp;  
    wire            plllock_0_i;
    wire            plllock_1_i;


//-----------------------------------------------------------------------------
// Main Body of Code 
//-----------------------------------------------------------------------------


    //-------------------------------------------------------------------------
    // Main Reset Circuitry
    //-------------------------------------------------------------------------

    assign reset_ibuf_i = RESET;

    // Asserting the reset of the EMAC for a few clock cycles
    always @(posedge usrclk2 or posedge reset_ibuf_i)
    begin
        if (reset_ibuf_i == 1)
        begin
            reset_r <= 4'b1111;
        end
        else
        begin
          if (plllock_0_i == 1 && plllock_1_i == 1)
            reset_r <= {reset_r[2:0], reset_ibuf_i};
        end
    end
    // synthesis attribute async_reg of reset_r is "TRUE";

    // The reset pulse is now several clock cycles in duration
    assign reset_i = reset_r[3];

 
   
    //-------------------------------------------------------------------------
    // Instantiate RocketIO tile for SGMII or 1000BASE-X PCS/PMA Physical I/F
    //-------------------------------------------------------------------------

   //EMAC0-only instance (uses GTX Port 0)
    GTX_dual_1000X GTX_DUAL_1000X_inst_0
 
         (
         .RESETDONE_0           (RESETDONE_0),
         .ENMCOMMAALIGN_0       (encommaalign_0_i),
         .ENPCOMMAALIGN_0       (encommaalign_0_i),
         .LOOPBACK_0            (loopback_0_i),
         .POWERDOWN_0           (powerdown_0_i),
         .RXUSRCLK_0            (usrclk),
         .RXUSRCLK2_0           (usrclk2),
         .RXRESET_0             (mgt_rx_reset_0_i),
         .TXCHARDISPMODE_0      (txchardispmode_0_i),
         .TXCHARDISPVAL_0       (txchardispval_0_i),
         .TXCHARISK_0           (txcharisk_0_i),
         .TXDATA_0              (mgt_tx_data_0_i),
         .TXUSRCLK_0            (usrclk),
         .TXUSRCLK2_0           (usrclk2),
         .TXRESET_0             (mgt_tx_reset_0_i),
         .RXCHARISCOMMA_0       (rxchariscomma_0_i),
         .RXCHARISK_0           (rxcharisk_0_i),
         .RXCLKCORCNT_0         (rxclkcorcnt_0_i),
         .RXDATA_0              (mgt_rx_data_0_i),
         .RXDISPERR_0           (rxdisperr_0_i),
         .RXNOTINTABLE_0        (rxnotintable_0_i),
         .RXRUNDISP_0           (rxrundisp_0_i),
         .RXBUFERR_0            (rxbuferr_0_i),
         .TXBUFERR_0            (txbuferr_0_i),
         .PLLLKDET_0            (plllock_0_i),
         .TXOUTCLK_0            (),
         .RXELECIDLE_0          (rxelecidle_0_i),
         .RX1P_0                (RXP_0),
         .RX1N_0                (RXN_0),
         .TX1N_0                (TXN_0),
         .TX1P_0                (TXP_0),
         .TX1N_1_UNUSED         (),
         .TX1P_1_UNUSED         (),
         .RX1N_1_UNUSED         (),
         .RX1P_1_UNUSED         (),
         .CLK_DS                (CLK_DS_0),         
         .GTRESET               (GTRESET),
         .REFCLKOUT             (refclkout),
         .PMARESET              (reset_ibuf_i),
         .DCM_LOCKED            (dcm_locked_gtp));

   //EMAC1-only instance (uses GTX Port 0)
    GTX_dual_1000X GTX_DUAL_1000X_inst_1
 
         (
         .RESETDONE_0           (RESETDONE_1),
         .ENMCOMMAALIGN_0       (encommaalign_1_i),
         .ENPCOMMAALIGN_0       (encommaalign_1_i),
         .LOOPBACK_0            (loopback_1_i),
         .POWERDOWN_0           (powerdown_1_i),
         .RXUSRCLK_0            (usrclk),
         .RXUSRCLK2_0           (usrclk2),
         .RXRESET_0             (mgt_rx_reset_1_i),
         .TXCHARDISPMODE_0      (txchardispmode_1_i),
         .TXCHARDISPVAL_0       (txchardispval_1_i),
         .TXCHARISK_0           (txcharisk_1_i),
         .TXDATA_0              (mgt_tx_data_1_i),
         .TXUSRCLK_0            (usrclk),
         .TXUSRCLK2_0           (usrclk2),
         .TXRESET_0             (mgt_tx_reset_1_i),
         .RXCHARISCOMMA_0       (rxchariscomma_1_i),
         .RXCHARISK_0           (rxcharisk_1_i),
         .RXCLKCORCNT_0         (rxclkcorcnt_1_i),
         .RXDATA_0              (mgt_rx_data_1_i),
         .RXDISPERR_0           (rxdisperr_1_i),
         .RXNOTINTABLE_0        (rxnotintable_1_i),
         .RXRUNDISP_0           (rxrundisp_1_i),
         .RXBUFERR_0            (rxbuferr_1_i),
         .TXBUFERR_0            (txbuferr_1_i),
         .PLLLKDET_0            (plllock_1_i),
         .TXOUTCLK_0            (),
         .RXELECIDLE_0          (rxelecidle_1_i),
         .RX1P_0                (RXP_1),
         .RX1N_0                (RXN_1),
         .TX1N_0                (TXN_1),
         .TX1P_0                (TXP_1),
         .TX1N_1_UNUSED         (),
         .TX1P_1_UNUSED         (),
         .RX1N_1_UNUSED         (),
         .RX1P_1_UNUSED         (),
         .CLK_DS                (CLK_DS_1),         
         .GTRESET               (GTRESET),
         .REFCLKOUT             (/* refclkout */),
         .PMARESET              (reset_ibuf_i),
         .DCM_LOCKED            (dcm_locked_gtp));



    //-------------------------------------------------------------------------
    // Generate the buffer status input to the EMAC0 from the buffer error 
    // output of the transceiver
    //-------------------------------------------------------------------------
    assign rxbufstatus_0_i[1] = rxbuferr_0_ii;

    //-------------------------------------------------------------------------
    // Detect when there has been a disconnect
    //-------------------------------------------------------------------------
    assign signal_detect_0_i = ~(rxelecidle_0_i);

 

    //-------------------------------------------------------------------------
    // Generate the buffer status input to the EMAC1 from the buffer error 
    // output of the transceiver
    //-------------------------------------------------------------------------
    assign rxbufstatus_1_i[1] = rxbuferr_1_ii;

    //-------------------------------------------------------------------------
    // Detect when there has been a disconnect
    //-------------------------------------------------------------------------
    assign signal_detect_1_i = ~(rxelecidle_1_i);






    //--------------------------------------------------------------------
    // Virtex5 Rocket I/O Clock Management
    //--------------------------------------------------------------------

    // The RocketIO transceivers are available in pairs with shared
    // clock resources
    // 125MHz clock is used for GTP user clocks and used
    // to clock all Ethernet core logic.
    assign usrclk2                   = CLK125;
    assign usrclk                    = CLK62_5;

    assign dcm_locked_gtp            = 1'b1;

    // EMAC0: PLL locks
    assign emac_locked_0_i           = plllock_0_i;


    //------------------------------------------------------------------------
    // GTX_CLK Clock Management for EMAC0 - 125 MHz clock frequency
    // (Connected to PHYEMAC0GTXCLK of the EMAC primitive)
    //------------------------------------------------------------------------
    assign gtx_clk_ibufg_0_i         = usrclk2;


    //------------------------------------------------------------------------
    // PCS/PMA client side receive clock for EMAC0
    //------------------------------------------------------------------------
    assign rx_client_clk_in_0_i      = usrclk2;


    //------------------------------------------------------------------------
    // PCS/PMA client side transmit clock for EMAC0
    //------------------------------------------------------------------------
    assign tx_client_clk_in_0_i      = usrclk2;


    // EMAC1: PLL locks
    assign emac_locked_1_i           = plllock_1_i;


    //------------------------------------------------------------------------
    // GTX_CLK Clock Management for EMAC1 - 125 MHz clock frequency
    // (Connected to PHYEMAC1GTXCLK of the EMAC primitive)
    //------------------------------------------------------------------------
    assign gtx_clk_ibufg_1_i         = usrclk2;


    //------------------------------------------------------------------------
    // PCS/PMA client side receive clock for EMAC1
    //------------------------------------------------------------------------
    assign rx_client_clk_in_1_i      = usrclk2;


    //------------------------------------------------------------------------
    // PCS/PMA client side transmit clock for EMAC0
    //------------------------------------------------------------------------
    assign tx_client_clk_in_1_i      = usrclk2;


    //------------------------------------------------------------------------
    // Connect previously derived client clocks to example design output ports
    //------------------------------------------------------------------------
    // EMAC0 Clocking
    // 125MHz clock output from transceiver
    assign CLK125_OUT                = refclkout;

    // EMAC1 Clocking



    //------------------------------------------------------------------------
    // Instantiate the EMAC Wrapper (mac.v) 
    //------------------------------------------------------------------------
    mac v5_emac_wrapper_inst
    (
        // Client Receiver Interface - EMAC0
        .EMAC0CLIENTRXCLIENTCLKOUT      (rx_client_clk_out_0_i),
        .CLIENTEMAC0RXCLIENTCLKIN       (rx_client_clk_in_0_i),
        .EMAC0CLIENTRXD                 (EMAC0CLIENTRXD),
        .EMAC0CLIENTRXDVLD              (EMAC0CLIENTRXDVLD),
        .EMAC0CLIENTRXDVLDMSW           (),
        .EMAC0CLIENTRXGOODFRAME         (EMAC0CLIENTRXGOODFRAME),
        .EMAC0CLIENTRXBADFRAME          (EMAC0CLIENTRXBADFRAME),
        .EMAC0CLIENTRXFRAMEDROP         (EMAC0CLIENTRXFRAMEDROP),
        .EMAC0CLIENTRXSTATS             (EMAC0CLIENTRXSTATS),
        .EMAC0CLIENTRXSTATSVLD          (EMAC0CLIENTRXSTATSVLD),
        .EMAC0CLIENTRXSTATSBYTEVLD      (EMAC0CLIENTRXSTATSBYTEVLD),

        // Client Transmitter Interface - EMAC0
        .EMAC0CLIENTTXCLIENTCLKOUT      (tx_client_clk_out_0_i),
        .CLIENTEMAC0TXCLIENTCLKIN       (tx_client_clk_in_0_i),
        .CLIENTEMAC0TXD                 (CLIENTEMAC0TXD),
        .CLIENTEMAC0TXDVLD              (CLIENTEMAC0TXDVLD),
        .CLIENTEMAC0TXDVLDMSW           (1'b0),
        .EMAC0CLIENTTXACK               (EMAC0CLIENTTXACK),
        .CLIENTEMAC0TXFIRSTBYTE         (CLIENTEMAC0TXFIRSTBYTE),
        .CLIENTEMAC0TXUNDERRUN          (CLIENTEMAC0TXUNDERRUN),
        .EMAC0CLIENTTXCOLLISION         (EMAC0CLIENTTXCOLLISION),
        .EMAC0CLIENTTXRETRANSMIT        (EMAC0CLIENTTXRETRANSMIT),
        .CLIENTEMAC0TXIFGDELAY          (CLIENTEMAC0TXIFGDELAY),
        .EMAC0CLIENTTXSTATS             (EMAC0CLIENTTXSTATS),
        .EMAC0CLIENTTXSTATSVLD          (EMAC0CLIENTTXSTATSVLD),
        .EMAC0CLIENTTXSTATSBYTEVLD      (EMAC0CLIENTTXSTATSBYTEVLD),

        // MAC Control Interface - EMAC0
        .CLIENTEMAC0PAUSEREQ            (CLIENTEMAC0PAUSEREQ),
        .CLIENTEMAC0PAUSEVAL            (CLIENTEMAC0PAUSEVAL),

        // Clock Signals - EMAC0
        .GTX_CLK_0                      (usrclk2),
        .EMAC0PHYTXGMIIMIICLKOUT        (),
        .PHYEMAC0TXGMIIMIICLKIN         (1'b0),

        // 1000BASE-X PCS/PMA Interface - EMAC0
        .RXDATA_0                       (mgt_rx_data_0_ii),
        .TXDATA_0                       (mgt_tx_data_0_ii),
        .DCM_LOCKED_0                   (emac_locked_0_ii  ),
        .AN_INTERRUPT_0                 (EMAC0ANINTERRUPT),
        .SIGNAL_DETECT_0                (signal_detect_0_ii), 
        .PHYAD_0                        (PHYAD_0), 
        .ENCOMMAALIGN_0                 (encommaalign_0_ii),
        .LOOPBACKMSB_0                  (loopback_0_ii),
        .MGTRXRESET_0                   (mgt_rx_reset_0_ii),
        .MGTTXRESET_0                   (mgt_tx_reset_0_ii),
        .POWERDOWN_0                    (powerdown_0_ii),
        .SYNCACQSTATUS_0                (EMAC0CLIENTSYNCACQSTATUS),
        .RXCLKCORCNT_0                  (rxclkcorcnt_0_ii),
        .RXBUFSTATUS_0                  (rxbufstatus_0_i),
        .RXCHARISCOMMA_0                (rxchariscomma_0_ii),
        .RXCHARISK_0                    (rxcharisk_0_ii),
        .RXDISPERR_0                    (rxdisperr_0_ii),
        .RXNOTINTABLE_0                 (rxnotintable_0_ii),
        .RXREALIGN_0                    (1'b0),
        .RXRUNDISP_0                    (rxrundisp_0_ii),
        .TXBUFERR_0                     (txbuferr_0_ii),
        .TXRUNDISP_0                    (1'b0),
        .TXCHARDISPMODE_0               (txchardispmode_0_ii),
        .TXCHARDISPVAL_0                (txchardispval_0_ii),
        .TXCHARISK_0                    (txcharisk_0_ii),

        // Client Receiver Interface - EMAC1
        .EMAC1CLIENTRXCLIENTCLKOUT      (rx_client_clk_out_1_i),
        .CLIENTEMAC1RXCLIENTCLKIN       (rx_client_clk_in_1_i),
        .EMAC1CLIENTRXD                 (EMAC1CLIENTRXD),
        .EMAC1CLIENTRXDVLD              (EMAC1CLIENTRXDVLD),
        .EMAC1CLIENTRXDVLDMSW           (),
        .EMAC1CLIENTRXGOODFRAME         (EMAC1CLIENTRXGOODFRAME),
        .EMAC1CLIENTRXBADFRAME          (EMAC1CLIENTRXBADFRAME),
        .EMAC1CLIENTRXFRAMEDROP         (EMAC1CLIENTRXFRAMEDROP),
        .EMAC1CLIENTRXSTATS             (EMAC1CLIENTRXSTATS),
        .EMAC1CLIENTRXSTATSVLD          (EMAC1CLIENTRXSTATSVLD),
        .EMAC1CLIENTRXSTATSBYTEVLD      (EMAC1CLIENTRXSTATSBYTEVLD),

        // Client Transmitter Interface - EMAC1
        .EMAC1CLIENTTXCLIENTCLKOUT      (tx_client_clk_out_1_i),
        .CLIENTEMAC1TXCLIENTCLKIN       (tx_client_clk_in_1_i),
        .CLIENTEMAC1TXD                 (CLIENTEMAC1TXD),
        .CLIENTEMAC1TXDVLD              (CLIENTEMAC1TXDVLD),
        .CLIENTEMAC1TXDVLDMSW           (1'b0),
        .EMAC1CLIENTTXACK               (EMAC1CLIENTTXACK),
        .CLIENTEMAC1TXFIRSTBYTE         (CLIENTEMAC1TXFIRSTBYTE),
        .CLIENTEMAC1TXUNDERRUN          (CLIENTEMAC1TXUNDERRUN),
        .EMAC1CLIENTTXCOLLISION         (EMAC1CLIENTTXCOLLISION),
        .EMAC1CLIENTTXRETRANSMIT        (EMAC1CLIENTTXRETRANSMIT),
        .CLIENTEMAC1TXIFGDELAY          (CLIENTEMAC1TXIFGDELAY),
        .EMAC1CLIENTTXSTATS             (EMAC1CLIENTTXSTATS),
        .EMAC1CLIENTTXSTATSVLD          (EMAC1CLIENTTXSTATSVLD),
        .EMAC1CLIENTTXSTATSBYTEVLD      (EMAC1CLIENTTXSTATSBYTEVLD),

        // MAC Control Interface - EMAC1
        .CLIENTEMAC1PAUSEREQ            (CLIENTEMAC1PAUSEREQ),
        .CLIENTEMAC1PAUSEVAL            (CLIENTEMAC1PAUSEVAL),

        // Clock Signals - EMAC1
        .GTX_CLK_1                      (usrclk2),
        .EMAC1PHYTXGMIIMIICLKOUT        (),
        .PHYEMAC1TXGMIIMIICLKIN         (1'b0),

        // 1000BASE-X PCS/PMA Interface - EMAC1
        .RXDATA_1                       (mgt_rx_data_1_ii),
        .TXDATA_1                       (mgt_tx_data_1_ii),
        .DCM_LOCKED_1                   (emac_locked_1_ii  ),
        .AN_INTERRUPT_1                 (EMAC1ANINTERRUPT),
        .SIGNAL_DETECT_1                (signal_detect_1_ii),
        .PHYAD_1                        (PHYAD_1), 
        .ENCOMMAALIGN_1                 (encommaalign_1_ii),
        .LOOPBACKMSB_1                  (loopback_1_ii),
        .MGTRXRESET_1                   (mgt_rx_reset_1_ii),
        .MGTTXRESET_1                   (mgt_tx_reset_1_ii),
        .POWERDOWN_1                    (powerdown_1_ii),
        .SYNCACQSTATUS_1                (EMAC1CLIENTSYNCACQSTATUS),
        .RXCLKCORCNT_1                  (rxclkcorcnt_1_ii),
        .RXBUFSTATUS_1                  (rxbufstatus_1_i),
        .RXCHARISCOMMA_1                (rxchariscomma_1_ii),
        .RXCHARISK_1                    (rxcharisk_1_ii),
        .RXDISPERR_1                    (rxdisperr_1_ii),
        .RXNOTINTABLE_1                 (rxnotintable_1_ii),
        .RXREALIGN_1                    (1'b0),
        .RXRUNDISP_1                    (rxrundisp_1_ii),
        .TXBUFERR_1                     (txbuferr_1_ii),
        .TXRUNDISP_1                    (1'b0),
        .TXCHARDISPMODE_1               (txchardispmode_1_ii),
        .TXCHARDISPVAL_1                (txchardispval_1_ii),
        .TXCHARISK_1                    (txcharisk_1_ii),

        // Asynchronous Reset
        .RESET                          (reset_i)
        );


   // Add pipleine register for timing closure for GTX port 0
   // No reset since only one stage and reset is held longer
   // GTX nets are suffix i and TEMAC nets are suffix ii
   generate if (PIPELINE_PORT_0 == 1) begin
     always @(posedge usrclk2) begin
       emac_locked_0_ii <= emac_locked_0_i;
       mgt_rx_data_0_ii <= mgt_rx_data_0_i;
       mgt_tx_data_0_i <= mgt_tx_data_0_ii;
       signal_detect_0_ii <= signal_detect_0_i;
       // rxelecidle_0_i <= rxelecidle_0_ii; // Actually signal_detect 
       encommaalign_0_i <= encommaalign_0_ii;
       loopback_0_i <= loopback_0_ii;
       mgt_rx_reset_0_i <= mgt_rx_reset_0_ii;
       mgt_tx_reset_0_i <= mgt_tx_reset_0_ii;
       powerdown_0_i <= powerdown_0_ii;
       rxclkcorcnt_0_ii <= rxclkcorcnt_0_i;
       rxbuferr_0_ii <= rxbuferr_0_i; 
       rxchariscomma_0_ii <= rxchariscomma_0_i;
       rxcharisk_0_ii <= rxcharisk_0_i;
       rxdisperr_0_ii <= rxdisperr_0_i;
       rxlossofsync_0_ii <= rxlossofsync_0_i;
       rxnotintable_0_ii <= rxnotintable_0_i;
       rxrundisp_0_ii <= rxrundisp_0_i;
       txbuferr_0_ii <= txbuferr_0_i;
       txchardispmode_0_i <= txchardispmode_0_ii;
       txchardispval_0_i <= txchardispval_0_ii;
       txcharisk_0_i <= txcharisk_0_ii;
       // rxbufstatus_0_i <= rxbufstatus_0_ii; // Actually rxbuferr
     end
   end else begin
     always @(*) begin
       emac_locked_0_ii <= emac_locked_0_i;
       mgt_rx_data_0_ii <= mgt_rx_data_0_i;
       mgt_tx_data_0_i <= mgt_tx_data_0_ii;
       signal_detect_0_ii <= signal_detect_0_i;
       // rxelecidle_0_i <= rxelecidle_0_ii; // Actually signal_detect 
       encommaalign_0_i <= encommaalign_0_ii;
       loopback_0_i <= loopback_0_ii;
       mgt_rx_reset_0_i <= mgt_rx_reset_0_ii;
       mgt_tx_reset_0_i <= mgt_tx_reset_0_ii;
       powerdown_0_i <= powerdown_0_ii;
       rxclkcorcnt_0_ii <= rxclkcorcnt_0_i;
       rxbuferr_0_ii <= rxbuferr_0_i; 
       rxchariscomma_0_ii <= rxchariscomma_0_i;
       rxcharisk_0_ii <= rxcharisk_0_i;
       rxdisperr_0_ii <= rxdisperr_0_i;
       rxlossofsync_0_ii <= rxlossofsync_0_i;
       rxnotintable_0_ii <= rxnotintable_0_i;
       rxrundisp_0_ii <= rxrundisp_0_i;
       txbuferr_0_ii <= txbuferr_0_i;
       txchardispmode_0_i <= txchardispmode_0_ii;
       txchardispval_0_i <= txchardispval_0_ii;
       txcharisk_0_i <= txcharisk_0_ii;
       // rxbufstatus_0_i <= rxbufstatus_0_ii; // Actually rxbuferr
     end
  end
  endgenerate

   // Add pipleine register for timing closure for GTX port 1
   // No reset since only one stage and reset is held longer
   // GTX nets are suffix i and TEMAC nets are suffix ii
   generate if (PIPELINE_PORT_1 == 1) begin
     always @(posedge usrclk2) begin
       emac_locked_1_ii <= emac_locked_1_i;
       mgt_rx_data_1_ii <= mgt_rx_data_1_i;
       mgt_tx_data_1_i <= mgt_tx_data_1_ii;
       signal_detect_1_ii <= signal_detect_1_i;
       // rxelecidle_1_i <= rxelecidle_1_ii; // Actually signal_detect 
       encommaalign_1_i <= encommaalign_1_ii;
       loopback_1_i <= loopback_1_ii;
       mgt_rx_reset_1_i <= mgt_rx_reset_1_ii;
       mgt_tx_reset_1_i <= mgt_tx_reset_1_ii;
       powerdown_1_i <= powerdown_1_ii;
       rxclkcorcnt_1_ii <= rxclkcorcnt_1_i;
       rxbuferr_1_ii <= rxbuferr_1_i; 
       rxchariscomma_1_ii <= rxchariscomma_1_i;
       rxcharisk_1_ii <= rxcharisk_1_i;
       rxdisperr_1_ii <= rxdisperr_1_i;
       rxlossofsync_1_ii <= rxlossofsync_1_i;
       rxnotintable_1_ii <= rxnotintable_1_i;
       rxrundisp_1_ii <= rxrundisp_1_i;
       txbuferr_1_ii <= txbuferr_1_i;
       txchardispmode_1_i <= txchardispmode_1_ii;
       txchardispval_1_i <= txchardispval_1_ii;
       txcharisk_1_i <= txcharisk_1_ii;
       // rxbufstatus_1_i <= rxbufstatus_1_ii; // Actually rxbuferr
     end
   end else begin
     always @(*) begin
       emac_locked_1_ii <= emac_locked_1_i;
       mgt_rx_data_1_ii <= mgt_rx_data_1_i;
       mgt_tx_data_1_i <= mgt_tx_data_1_ii;
       signal_detect_1_ii <= signal_detect_1_i;
       // rxelecidle_1_i <= rxelecidle_1_ii; // Actually signal_detect 
       encommaalign_1_i <= encommaalign_1_ii;
       loopback_1_i <= loopback_1_ii;
       mgt_rx_reset_1_i <= mgt_rx_reset_1_ii;
       mgt_tx_reset_1_i <= mgt_tx_reset_1_ii;
       powerdown_1_i <= powerdown_1_ii;
       rxclkcorcnt_1_ii <= rxclkcorcnt_1_i;
       rxbuferr_1_ii <= rxbuferr_1_i; 
       rxchariscomma_1_ii <= rxchariscomma_1_i;
       rxcharisk_1_ii <= rxcharisk_1_i;
       rxdisperr_1_ii <= rxdisperr_1_i;
       rxlossofsync_1_ii <= rxlossofsync_1_i;
       rxnotintable_1_ii <= rxnotintable_1_i;
       rxrundisp_1_ii <= rxrundisp_1_i;
       txbuferr_1_ii <= txbuferr_1_i;
       txchardispmode_1_i <= txchardispmode_1_ii;
       txchardispval_1_i <= txchardispval_1_ii;
       txcharisk_1_i <= txcharisk_1_ii;
       // rxbufstatus_1_i <= rxbufstatus_1_ii; // Actually rxbuferr
     end
  end
  endgenerate
  
 
  
 



endmodule
