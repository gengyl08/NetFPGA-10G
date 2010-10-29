-------------------------------------------------------------------------------
-- transmit - entity/architecture pair
-------------------------------------------------------------------------------
--  ***************************************************************************
--  ** DISCLAIMER OF LIABILITY                                               **
--  **                                                                       **
--  **  This file contains proprietary and confidential information of       **
--  **  Xilinx, Inc. ("Xilinx"), that is distributed under a license         **
--  **  from Xilinx, and may be used, copied and/or disclosed only           **
--  **  pursuant to the terms of a valid license agreement with Xilinx.      **
--  **                                                                       **
--  **  XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION                **
--  **  ("MATERIALS") "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER           **
--  **  EXPRESSED, IMPLIED, OR STATUTORY, INCLUDING WITHOUT                  **
--  **  LIMITATION, ANY WARRANTY WITH RESPECT TO NONINFRINGEMENT,            **
--  **  MERCHANTABILITY OR FITNESS FOR ANY PARTICULAR PURPOSE. Xilinx        **
--  **  does not warrant that functions included in the Materials will       **
--  **  meet the requirements of Licensee, or that the operation of the      **
--  **  Materials will be uninterrupted or error-free, or that defects       **
--  **  in the Materials will be corrected. Furthermore, Xilinx does         **
--  **  not warrant or make any representations regarding use, or the        **
--  **  results of the use, of the Materials in terms of correctness,        **
--  **  accuracy, reliability or otherwise.                                  **
--  **                                                                       **
--  **  Xilinx products are not designed or intended to be fail-safe,        **
--  **  or for use in any application requiring fail-safe performance,       **
--  **  such as life-support or safety devices or systems, Class III         **
--  **  medical devices, nuclear facilities, applications related to         **
--  **  the deployment of airbags, or any other applications that could      **
--  **  lead to death, personal injury or severe property or                 **
--  **  environmental damage (individually and collectively, "critical       **
--  **  applications"). Customer assumes the sole risk and liability         **
--  **  of any use of Xilinx products in critical applications,              **
--  **  subject only to applicable laws and regulations governing            **
--  **  limitations on product liability.                                    **
--  **                                                                       **
--  **  Copyright 2010 Xilinx, Inc.                                          **
--  **  All rights reserved.                                                 **
--  **                                                                       **
--  **  This disclaimer and copyright notice must be retained as part        **
--  **  of this file at all times.                                           **
--  ***************************************************************************
--
-------------------------------------------------------------------------------
-- Filename     : transmit.vhd
-- Version      : v1.00.a
-- Description  : This is the transmit path portion of the design
-- VHDL-Standard: VHDL'93
-------------------------------------------------------------------------------
-- Structure:   
--
--  axi_ethernetlite.vhd
--      \
--      \-- axi_interface.vhd
--      \-- xemac.vhd
--           \
--           \-- mdio_if.vhd
--           \-- emac_dpram.vhd                     
--           \    \                     
--           \    \-- RAMB16_S4_S36
--           \                          
--           \    
--           \-- emac.vhd                     
--                \                     
--                \-- MacAddrRAM                   
--                \-- receive.vhd
--                \      rx_statemachine.vhd
--                \      rx_intrfce.vhd
--                \         async_fifo_fg.vhd
--                \      crcgenrx.vhd
--                \                     
--                \-- transmit.vhd
--                       crcgentx.vhd
--                          crcnibshiftreg
--                       tx_intrfce.vhd
--                          async_fifo_fg.vhd
--                       tx_statemachine.vhd
--                       deferral.vhd
--                          cntr5bit.vhd
--                          defer_state.vhd
--                       bocntr.vhd
--                          lfsr16.vhd
--                       msh_cnt.vhd
--                       ld_arith_reg.vhd
--
-------------------------------------------------------------------------------
-- Author:    PVK
-- History:    
-- PVK        06/07/2010     First Version
-- ^^^^^^
-- First version.  
-- ~~~~~~
-------------------------------------------------------------------------------
-- Naming Conventions:
--      active low signals:                     "*_n"
--      clock signals:                          "Clk", "clk_div#", "clk_#x" 
--      reset signals:                          "Rst", "rst_n" 
--      generics:                               "C_*" 
--      user defined types:                     "*_TYPE" 
--      state machine next state:               "*_ns" 
--      state machine current state:            "*_cs" 
--      combinatorial signals:                  "*_com" 
--      pipelined or register delay signals:    "*_d#" 
--      counter signals:                        "*cnt*"
--      clock enable signals:                   "*_ce" 
--      internal version of output port         "*_i"
--      device pins:                            "*_pin" 
--      ports:                                  - Names begin with Uppercase 
--      processes:                              "*_PROCESS" 
--      component instantiations:               "<ENTITY_>I_<#|FUNC>
-------------------------------------------------------------------------------
-- 
library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_misc.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
--use ieee.numeric_std."-";

-------------------------------------------------------------------------------
-- axi_ethernetlite_v1_00_a library is used for axi_ethernetlite_v1_00_a 
-- component declarations
-------------------------------------------------------------------------------
library axi_ethernetlite_v1_00_a;
use axi_ethernetlite_v1_00_a.mac_pkg.all;

-------------------------------------------------------------------------------
-- proc common package of the proc common library is used for different 
-- function declarations
-------------------------------------------------------------------------------
library axi_ethernetlite_v1_00_a_proc_common_v3_00_a;
use axi_ethernetlite_v1_00_a_proc_common_v3_00_a.all;
--use axi_ethernetlite_v1_00_a_proc_common_v3_00_a.proc_common_pkg.all;


-- synopsys translate_off
Library xilinxcorelib;
library simprim;
-- synopsys translate_on

library unisim;
use unisim.Vcomponents.all;

-------------------------------------------------------------------------------
-- Definition of Generics:
-------------------------------------------------------------------------------
--  C_DUPLEX               -- 1 = full duplex, 0 = half duplex
--  C_FAMILY               -- Target device family 
-------------------------------------------------------------------------------
-- Definition of Ports:
--
--  Clk                   -- System Clock
--  Rst                   -- System Reset
--  NibbleLength          -- Transmit frame nibble length
--  NibbleLength_orig     -- Transmit nibble length before pkt adjustment
--  En_pad                -- Enable padding
--  TxClkEn               -- Transmit clock enable
--  Phy_tx_clk            -- PHY TX Clock
--  Phy_crs               -- Ethernet carrier sense
--  Phy_col               -- Ethernet collision indicator
--  Phy_tx_en             -- Ethernet transmit enable
--  Phy_tx_data           -- Ethernet transmit data
--  Tx_addr_en            -- TX buffer address enable
--  Tx_start              -- TX start
--  Tx_done               -- TX complete
--  Tx_pong_ping_l        -- TX Ping/Pong buffer enable
--  Tx_idle               -- TX idle
--  Tx_DPM_ce             -- TX buffer chip enable
--  Tx_DPM_wr_data        -- TX buffer write data
--  Tx_DPM_rd_data        -- TX buffer read data
--  Tx_DPM_wr_rd_n        -- TX buffer write/read enable
--  Transmit_start        -- Transmit start
--  Mac_program_start     -- MAC Program start
--  Mac_addr_ram_we       -- MAC Address RAM write enable
--  Mac_addr_ram_addr_wr  -- MAC Address RAM write address
-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity transmit is
  generic 
   (
    C_DUPLEX : integer := 1; -- 1 = full duplex, 0 = half duplex   
    C_FAMILY : string  := "virtex6"  
   );
  port 
   ( 
    Clk                  : in  std_logic;
    Rst                  : in  std_logic;
    NibbleLength         : in  std_logic_vector(0 to 11);
    NibbleLength_orig    : in  std_logic_vector(0 to 11);
    En_pad               : in  std_logic; 
    TxClkEn              : in  std_logic;
    Phy_tx_clk           : in  std_logic;
    Phy_crs              : in  std_logic;
    Phy_col              : in  std_logic;
    Phy_tx_en            : out std_logic;
    Phy_tx_data          : out std_logic_vector (0 to 3);
    Tx_addr_en           : out std_logic;
    Tx_start             : out std_logic;
    Tx_done              : out std_logic;
    Tx_pong_ping_l       : in  std_logic;
    Tx_idle              : out std_logic;
    Tx_DPM_ce            : out std_logic;
    Tx_DPM_wr_data       : out std_logic_vector (0 to 3);
    Tx_DPM_rd_data       : in  std_logic_vector (0 to 3);
    Tx_DPM_wr_rd_n       : out std_logic;
    Transmit_start       : in  std_logic;
    Mac_program_start    : in  std_logic;
    Mac_addr_ram_we      : out std_logic;
    Mac_addr_ram_addr_wr : out std_logic_vector(0 to 3)    
        
    );
end transmit;

-------------------------------------------------------------------------------
-- Definition of Generics:
--          No Generics were used for this Entity.
--
-- Definition of Ports:
--         
-------------------------------------------------------------------------------

architecture imp of transmit is

-------------------------------------------------------------------------------
--  Constant Declarations
-------------------------------------------------------------------------------
constant logic_one               :std_logic := '1';

-------------------------------------------------------------------------------
--  Signal and Type Declarations
-------------------------------------------------------------------------------
signal full_half_n               : std_logic;
signal bus_combo                 : std_logic_vector (0 to 5);
signal txChannelReset            : std_logic;
signal emac_tx_wr_i              : std_logic;
signal txfifo_full               : std_logic;
signal txfifo_empty              : std_logic;
signal tx_en_i                   : std_logic;
signal fifo_tx_en                : std_logic;
signal txNibbleCntLd             : std_logic;
signal txNibbleCntEn             : std_logic;
signal txNibbleCntRst            : std_logic;
signal txComboNibbleCntRst       : std_logic;
signal phy_tx_en_i               : std_logic;
signal deferring                 : std_logic;
signal txBusFifoWrCntRst         : std_logic;
signal txBusFifoWrCntEn          : std_logic;
signal txComboBusFifoWrCntRst    : std_logic;
signal txComboBusFifoWrCntEn     : std_logic;
signal txComboColRetryCntRst_n   : std_logic;
signal txComboBusFifoRst         : std_logic;
signal txColRetryCntRst_n        : std_logic;
signal enblPreamble              : std_logic;
signal enblSFD                   : std_logic;
signal enblData                  : std_logic;
signal enblJam                   : std_logic;
signal enblCRC                   : std_logic;
signal txCntEnbl                 : std_logic;
signal txColRetryCntEnbl         : std_logic;
signal jamTxComboNibCntEnbl      : std_logic;
signal txRetryRst                : std_logic;
signal txLateColnRst             : std_logic;
signal initBackoff               : std_logic;
signal backingOff_i              : std_logic;
signal txCrcShftOutEn            : std_logic;
signal txCrcEn                   : std_logic;
signal crcComboRst               : std_logic;
signal emac_tx_wr_data_i         : std_logic_vector (0 to 3);
signal crcCnt                    : std_logic_vector(0 to 3);
signal collisionRetryCnt         : std_logic_vector(0 to 4);
signal jamTxNibbleCnt            : std_logic_vector(0 to 3);
signal colWindowNibbleCnt        : std_logic_vector(0 to 7);
signal prb                       : std_logic_vector(0 to 3);
signal sfd                       : std_logic_vector(0 to 3);
signal jam                       : std_logic_vector(0 to 3);
signal crc                       : std_logic_vector(0 to 3);
signal currentTxBusFifoWrCnt     : std_logic_vector(0 to 11);
signal currentTxNibbleCnt        : std_logic_vector (0 to 11);
signal phy_tx_en_n               : std_logic;
signal txComboColRetryCntRst     : std_logic;
signal phy_tx_en_i_n             : std_logic;
signal jam_rst                   : std_logic;
signal txExcessDefrlRst          : std_logic;
signal enblclear                 : std_logic;
signal tx_en_mod                 : std_logic;
signal emac_tx_wr_mod            : std_logic;
signal pre_sfd_done              : std_logic;
signal mux_in_data               : std_logic_vector (0 to 6*4-1);
signal mux_in_sel                : std_logic_vector (0 to 5);
signal transmit_data             : std_logic_vector (0 to 3);
signal txNibbleCnt_pad           : unsigned (0 to 11);
signal tx_idle_i                 : std_logic;
signal emac_tx_wr_data_d1        : std_logic_vector (0 to 3);
signal emac_tx_wr_d1             : std_logic;
signal txcrcen_d1                : std_logic;


-------------------------------------------------------------------------------
-- Component Declarations
-------------------------------------------------------------------------------
component FDRE
  port 
   (
    Q  : out std_logic;
    C  : in std_logic;
    CE : in std_logic;
    D  : in std_logic;
    R  : in std_logic
   );
end component;

component FDCE
  port 
   (
    Q   : out std_logic;
    C   : in std_logic;
    CE  : in std_logic;
    CLR : in std_logic;
    D   : in std_logic
    );
end component;  


begin

   ----------------------------------------------------------------------------
   -- tx crc generator
   ----------------------------------------------------------------------------
   INST_CRCGENTX: entity axi_ethernetlite_v1_00_a.crcgentx
      port map 
         (
         Clk     => Clk,
         Rst     => crcComboRst,
         Clken   => emac_tx_wr_d1,
         Data    => emac_tx_wr_data_d1,
         DataEn  => txcrcen_d1,
         OutEn   => txCrcShftOutEn,
         CrcNibs => crc
      );      
               
   crcComboRst <= Rst or not (fifo_tx_en);
   
   ----------------------------------------------------------------------------
   -- tx interface contains the ethernet tx fifo
   ----------------------------------------------------------------------------
   INST_TX_INTRFCE: entity axi_ethernetlite_v1_00_a.tx_intrfce
      generic map
         (
         C_FAMILY => C_FAMILY
         )
      port map 
         (     
         Clk               => Clk,
         Rst               => txComboBusFifoRst,
         Phy_tx_clk        => Phy_tx_clk,
         Emac_tx_wr_data   => emac_tx_wr_data_i,
         Tx_er             => '0',      
         PhyTxEn           => tx_en_mod,
         Tx_en             => fifo_tx_en,
         Fifo_rd_ack       => open,
         Fifo_empty        => txfifo_empty,
         Fifo_almost_empty => open,
         Fifo_full         => txfifo_full,
         Emac_tx_wr        => emac_tx_wr_mod,
         Phy_tx_data       => bus_combo
       );    
               
   txComboBusFifoRst <= Rst or txRetryRst or
                       (jam_rst and not(full_half_n) and 
                        Phy_col and pre_sfd_done);
   
   jam               <= "0110"; -- arbitrary
   prb               <= "0101"; -- transmitted as 1010
   sfd               <= "1101"; -- transmitted as 1011
   
   

   ----------------------------------------------------------------------------
   -- PHY output selection 
   ----------------------------------------------------------------------------
   mux_in_sel  <= enblPreamble & enblSFD & enblData & enblJam & enblCRC & 
                                                                logic_one;
                                                                
   mux_in_data <= prb & sfd & transmit_data & jam & crc & "0000";
   
   transmit_data <= "0000" when (txNibbleCnt_pad = 0) else
                    Tx_DPM_rd_data;                 
   
   Tx_idle <= tx_idle_i;
   ----------------------------------------------------------------------------
   -- Multiplexing PHY transmit data
   ----------------------------------------------------------------------------
   ONR_HOT_MUX:entity axi_ethernetlite_v1_00_a_proc_common_v3_00_a.mux_onehot_f
   
      generic map 
         ( 
         C_DW => 4, 
         C_NB => 6,
         C_FAMILY => C_FAMILY
        )
   
     port map 
         (
         D => mux_in_data, 
         S => mux_in_sel, 
         Y => emac_tx_wr_data_i
        );
   
   
   ----------------------------------------------------------------------------
   -- PHY transmit data
   ----------------------------------------------------------------------------
   Phy_tx_data <= "0110" when (Phy_col = '1' or 
                               not(jamTxNibbleCnt(0) = '1' and
                                   jamTxNibbleCnt(1) = '0' and 
                                   jamTxNibbleCnt(2) = '0' and
                                   jamTxNibbleCnt(3) = '1')) and 
                               full_half_n = '0' and 
                               not (jamTxNibbleCnt = "0000") and 
                               pre_sfd_done = '1'                    else
                  
                  "0000" when jamTxNibbleCnt = "0000" and 
                              full_half_n = '0'                      else
                  "0000" when phy_tx_en_i = '0'                        else            
                  bus_combo(0 to 3);
   
   ----------------------------------------------------------------------------
   -- PHY transmit enable
   ----------------------------------------------------------------------------
   Phy_tx_en   <= '1' when (Phy_col = '1' or 
                            not(jamTxNibbleCnt(0) = '1' and
                                jamTxNibbleCnt(1) = '0' and 
                                jamTxNibbleCnt(2) = '0' and
                                jamTxNibbleCnt(3) = '1')) and 
                            full_half_n = '0' and
                            not (jamTxNibbleCnt = "0000") and 
                            pre_sfd_done = '1'                       else 
                  
                  '0' when jamTxNibbleCnt = "0000" and 
                           full_half_n = '0'                         else
                  '0' when phy_tx_en_i = '0'                           else
                  bus_combo(5);
   
   ----------------------------------------------------------------------------
   -- transmit packet fifo read nibble counter
   ----------------------------------------------------------------------------
   INST_TXNIBBLECOUNT: entity axi_ethernetlite_v1_00_a_proc_common_v3_00_a.ld_arith_reg
      generic  map
        (
         C_ADD_SUB_NOT => false,
         C_REG_WIDTH   => 12,
         C_RESET_VALUE => "000000000000",
         C_LD_WIDTH    => 12,
         C_LD_OFFSET   => 0,
         C_AD_WIDTH    => 12,
         C_AD_OFFSET   => 0
        )
      port map
        (
         CK       => Clk,
         Rst      => txComboNibbleCntRst,
         Q        => currentTxNibbleCnt,
         LD       => NibbleLength,
         AD       => "000000000001",
         LOAD     => txNibbleCntLd,
         OP       => txNibbleCntEn
        );
       
   txComboNibbleCntRst <= Rst or txNibbleCntRst or txRetryRst;
                                  
   
   ----------------------------------------------------------------------------
   -- PROCESS : PKT_TX_PAD_COUNTER 
   ----------------------------------------------------------------------------
   -- This counter is used to check if the receive packet length is greater 
   -- minimum packet length (64 byte - 128 nibble)
   ----------------------------------------------------------------------------
   PKT_TX_PAD_COUNTER : process(Clk)
   begin
      if (Clk'event and Clk='1') then
         if (Rst=RESET_ACTIVE) then
            txNibbleCnt_pad <= (others=>'0');
         elsif (enblSFD='1') then  -- load the counter for minimum 
            txNibbleCnt_pad <= unsigned(NibbleLength_orig); -- packet length
         elsif (enblData='1' and En_pad='1') then        -- Enable Down Counter
            if (txNibbleCnt_pad=0 ) then  
               txNibbleCnt_pad <= (others=>'0');
            else
               txNibbleCnt_pad <= txNibbleCnt_pad-1;
            end if;
         end if;
      end if;
   end process PKT_TX_PAD_COUNTER;
   
   ----------------------------------------------------------------------------
   -- transmit state machine
   ----------------------------------------------------------------------------
   INST_TX_STATE_MACHINE: entity axi_ethernetlite_v1_00_a.tx_statemachine
      generic map 
        (
         C_DUPLEX             => C_DUPLEX
        )    
      port map
        (
         Clk                  =>  Clk,
         Rst                  =>  txChannelReset,
         TxClkEn              =>  TxClkEn,
         Jam_rst              =>  jam_rst,
         TxRst                =>  txChannelReset, 
         Deferring            =>  deferring,
         ColRetryCnt          =>  collisionRetryCnt,
         ColWindowNibCnt      =>  colWindowNibbleCnt,
         JamTxNibCnt          =>  jamTxNibbleCnt,
         TxNibbleCnt          =>  currentTxNibbleCnt,
         BusFifoWrNibbleCnt   =>  currentTxBusFifoWrCnt,
         CrcCnt               =>  crcCnt,
         BusFifoFull          =>  txfifo_full, 
         BusFifoEmpty         =>  txfifo_empty,
         PhyCollision         =>  Phy_col,
         InitBackoff          =>  initBackoff,
         TxRetryRst           =>  txRetryRst,
         TxExcessDefrlRst     =>  txExcessDefrlRst,
         TxLateColnRst        =>  txLateColnRst,
         TxColRetryCntRst_n   =>  txColRetryCntRst_n,
         TxColRetryCntEnbl    =>  txColRetryCntEnbl,
         TxNibbleCntRst       =>  txNibbleCntRst,
         TxEnNibbleCnt        =>  txNibbleCntEn, 
         TxNibbleCntLd        =>  txNibbleCntLd, 
         BusFifoWrCntRst      =>  txBusFifoWrCntRst,
         BusFifoWrCntEn       =>  txBusFifoWrCntEn,
         EnblPre              =>  enblPreamble,
         EnblSFD              =>  enblSFD,
         EnblData             =>  enblData,
         EnblJam              =>  enblJam,
         EnblCRC              =>  enblCRC,
         BusFifoWr            =>  emac_tx_wr_i,
         Phytx_en             =>  tx_en_i, 
         TxCrcEn              =>  txCrcEn,
         TxCrcShftOutEn       =>  txCrcShftOutEn,
         Tx_addr_en           =>  Tx_addr_en,          
         Tx_start             =>  Tx_start, 
         Tx_done              =>  Tx_done,
         Tx_pong_ping_l       =>  Tx_pong_ping_l,
         Tx_idle              =>  tx_idle_i,
         Tx_DPM_ce            =>  Tx_DPM_ce,           
         Tx_DPM_wr_data       =>  Tx_DPM_wr_data,      
         Tx_DPM_wr_rd_n       =>  Tx_DPM_wr_rd_n,      
         Enblclear            =>  enblclear,
         Transmit_start       =>  Transmit_start,
         Mac_program_start    =>  Mac_program_start,
         Mac_addr_ram_we      =>  Mac_addr_ram_we,     
         Mac_addr_ram_addr_wr =>  Mac_addr_ram_addr_wr,
         Pre_sfd_done         =>  pre_sfd_done
        );
        
   ----------------------------------------------------------------------------
   -- deferral control
   ----------------------------------------------------------------------------
   full_half_n <= '1'when C_DUPLEX = 1 else
                  '0';  
                  
   INST_DEFERRAL_CONTROL: entity axi_ethernetlite_v1_00_a.deferral
      port map
        (
         Clk         => Clk,
         Rst         => Rst,
         TxEn        => tx_en_i, 
         TxRst       => txChannelReset,
         Tx_clk_en   => TxClkEn,
         BackingOff  => backingOff_i,
         Crs         => Phy_crs,
         Full_half_n => full_half_n,
         Ifgp1       => "10000",
         Ifgp2       => "01000",
         Deferring   => deferring
       );            
              
   ----------------------------------------------------------------------------
   -- transmit bus fifo write nibble counter
   ----------------------------------------------------------------------------
   INST_TXBUSFIFOWRITENIBBLECOUNT: entity axi_ethernetlite_v1_00_a_proc_common_v3_00_a.ld_arith_reg
      generic  map
        (
         C_ADD_SUB_NOT => true,
         C_REG_WIDTH   => 12,
         C_RESET_VALUE => "000000000000",
         C_LD_WIDTH    => 12,
         C_LD_OFFSET   => 0,
         C_AD_WIDTH    => 12,
         C_AD_OFFSET   => 0
        )
      port map
        (
         CK       => Clk,
         Rst      => txComboBusFifoWrCntRst,
         Q        =>  currentTxBusFifoWrCnt,
         LD       => "000000000000",
         AD       => "000000000001",
         LOAD     => '0',
         OP       => txComboBusFifoWrCntEn
        );
       
   txComboBusFifoWrCntRst <= Rst or txBusFifoWrCntRst
                               or txRetryRst;
   txComboBusFifoWrCntEn  <= txBusFifoWrCntEn and emac_tx_wr_i;
   
   ----------------------------------------------------------------------------
   -- crc down counter
   ----------------------------------------------------------------------------
   phy_tx_en_n <= not(phy_tx_en_i);
   
   INST_CRCCOUNTER: entity axi_ethernetlite_v1_00_a_proc_common_v3_00_a.ld_arith_reg
      generic  map
        (
         C_ADD_SUB_NOT => false,
         C_REG_WIDTH   => 4,
         C_RESET_VALUE => "1000",
         C_LD_WIDTH    => 4,
         C_LD_OFFSET   => 0,
         C_AD_WIDTH    => 4,
         C_AD_OFFSET   => 0
        )
     
      port map
        (
         CK       => Clk,
         Rst      => Rst,
         Q        =>  crcCnt,
         LD       => "1000",
         AD       => "0001",
         LOAD     => phy_tx_en_n,
         OP       => enblCRC
       );
   
   ----------------------------------------------------------------------------
   -- Full Duplex mode operation
   ----------------------------------------------------------------------------
   TX3_NOT_GENERATE: if(C_DUPLEX = 1) generate --Set outputs to zero
     
   begin
     
      collisionRetryCnt  <= (others=> '0');
      colWindowNibbleCnt <= (others=> '0');
      jamTxNibbleCnt     <= (others=> '0');
      backingOff_i       <= '0';
      
   end generate TX3_NOT_GENERATE;
   
   ----------------------------------------------------------------------------
   -- Half Duplex mode operation
   ----------------------------------------------------------------------------
   tx3_generate: if(C_DUPLEX = 0) generate --Include collision cnts when 1  
   
   ----------------------------------------------------------------------------
   -- transmit collision retry down counter
   ----------------------------------------------------------------------------
   INST_COLRETRYCNT: entity axi_ethernetlite_v1_00_a.msh_cnt
      generic map
        (
         C_ADD_SUB_NOT => true,
         C_REG_WIDTH   => 5,
         C_RESET_VALUE => "00000"
       )
     
      port map
        (
         Clk      => Clk,
         Rst      => txComboColRetryCntRst,
         Q        => collisionRetryCnt,
         Z        => open,
         LD       => "00000",
         AD       => "00001",
         LOAD     => '0',
         OP       => txColRetryCntEnbl
       );
               
   txComboColRetryCntRst_n <= not(Rst) and txColRetryCntRst_n;
   txComboColRetryCntRst   <= not txComboColRetryCntRst_n;                          
   
   ----------------------------------------------------------------------------
   -- transmit collision window nibble down counter
   ----------------------------------------------------------------------------
   INST_COLWINDOWNIBCNT: entity axi_ethernetlite_v1_00_a.msh_cnt
      generic  map
        (
         C_ADD_SUB_NOT => false,
         C_REG_WIDTH   => 8,
         C_RESET_VALUE => "10001111"
       )
     
      port map
        (
         Clk      => Clk,
         Rst      => phy_tx_en_i_n,
         Q        => colWindowNibbleCnt,
         Z        => open,
         LD       => "10001111",
         AD       => "00000001",
         LOAD     => '0',
         OP       => txCntEnbl
       );   
       
   phy_tx_en_i_n <= not(phy_tx_en_i);    
   
   ----------------------------------------------------------------------------
   -- jam transmit nibble down counter
   ----------------------------------------------------------------------------
   INST_JAMTXNIBCNT: entity axi_ethernetlite_v1_00_a.msh_cnt
      generic  map
        (
         C_ADD_SUB_NOT => false,
         C_REG_WIDTH   => 4,
         C_RESET_VALUE => "1001"
       )
     
      port map
        (
         Clk      => Clk,
         Rst      => phy_tx_en_i_n,
         Q        => jamTxNibbleCnt,
         Z        => open,
         LD       => "1001",
         AD       => "0001",
         LOAD     => '0',
         OP       => jamTxComboNibCntEnbl
       );   
       
   ----------------------------------------------------------------------------
   -- tx collision back off counter
   ----------------------------------------------------------------------------
   INST_BOCNT: entity axi_ethernetlite_v1_00_a.bocntr
      port map
        (
         Clk         => Clk,
         Clken       => TxClkEn,
         Rst         => Rst,
         InitBackoff => initBackoff,
         RetryCnt    => collisionRetryCnt,
         BackingOff  => backingOff_i
         ); 
         
   end generate tx3_generate;   
        
   ----------------------------------------------------------------------------
   -- INT_tx_en_PROCESS
   ----------------------------------------------------------------------------
   -- This process assigns the outputs the phy enable
   ----------------------------------------------------------------------------
   INT_TX_EN_PROCESS: process (Phy_tx_clk)
   begin  -- 
      if (Phy_tx_clk'event and Phy_tx_clk = '1') then
         if (Rst = RESET_ACTIVE) then
            phy_tx_en_i <= '0';
            fifo_tx_en  <= '0';
         else
            fifo_tx_en  <= tx_en_i;
            phy_tx_en_i <= fifo_tx_en and tx_en_i;
         end if;
      end if;
   end process INT_TX_EN_PROCESS;            
   
   emac_tx_wr_mod <= emac_tx_wr_i or enblclear;
   
   tx_en_mod      <= '0' when enblclear = '1' else
                     tx_en_i;
   txChannelReset <= Rst;
   
   
   txCntEnbl      <= TxClkEn and phy_tx_en_i and 
                             not(not(full_half_n) and Phy_col);
   
   ----------------------------------------------------------------------------
   -- jam transmit nibble down counter enable
   ----------------------------------------------------------------------------
   jamTxComboNibCntEnbl <= (Phy_col or not(jamTxNibbleCnt(0) and
                            not(jamTxNibbleCnt(1)) and 
                            not(jamTxNibbleCnt(2)) and
                            jamTxNibbleCnt(3))) and 
                            pre_sfd_done and TxClkEn and not(full_half_n);


   ----------------------------------------------------------------------------
   -- INT_CRC_DATA_REG_PROCESS
   ----------------------------------------------------------------------------
   -- This process registers the emac data going to CRCgen Module to break long
   -- timing path. 
   ----------------------------------------------------------------------------
   INT_CRC_DATA_REG_PROCESS: process (Clk)
   begin  -- 
      if (Clk'event and Clk = '1') then
         if (Rst = RESET_ACTIVE) then
            emac_tx_wr_data_d1 <= (others=>'0');
            emac_tx_wr_d1 <= '0';
            txcrcen_d1    <= '0';
         else
            emac_tx_wr_data_d1  <= emac_tx_wr_data_i;
            emac_tx_wr_d1 <= emac_tx_wr_i;
            txcrcen_d1    <= txCrcEn;
         end if;
      end if;
   end process INT_CRC_DATA_REG_PROCESS;            
  
end imp;
