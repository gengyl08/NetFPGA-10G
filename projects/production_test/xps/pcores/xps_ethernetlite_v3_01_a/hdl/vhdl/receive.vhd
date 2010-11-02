-------------------------------------------------------------------------------
-- receive - entity/architecture pair
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
--  **  Copyright 2007, 2008, 2009 Xilinx, Inc.                              **
--  **  All rights reserved.                                                 **
--  **                                                                       **
--  **  This disclaimer and copyright notice must be retained as part        **
--  **  of this file at all times.                                           **
--  ***************************************************************************
--
-------------------------------------------------------------------------------
-- Filename:        receive.vhd
--
-- Description:     This is the receive path portion of the design
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:   
--
--  xps_ethernetlite.vhd
--      \
--      \-- xemac.vhd
--           \
--           \-- xps_ipif_ssp1.vhd
--           \-- mdio_if.vhd
--           \-- emac_dpram.vhd                     
--           \    \                     
--           \    \-- RAMB16_S4_S36
--           \                          
--           \    
--           \-- emac.vhd                     
--                \                     
--                \                     
--                \-- receive.vhd
--                \      rx_statemachine.vhd
--                \      rx_intrfce.vhd
--                \         ethernetlite_v1_01_b_dmem_v2.edn
--                \      crcgenrx.vhd
--                \                     
--                \-- transmit.vhd
--                       crcgentx.vhd
--                          crcnibshiftreg
--                       tx_intrfce.vhd
--                          ethernetlite_v1_01_b_dmem_v2.edn
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
-- Author:         MSH
-- History:
--  RSK            11/06/06
-- ^^^^^^
--                 First Version, Based on opb_ethernetlite v1.01.b
--  ~~~~~
--  PVK       3/13/2009    Version v3.00.a
-- ^^^^^^^
--  Updated to new version v3.00.a.
-- ~~~~~~~
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
use ieee.STD_LOGIC_1164.all;

-------------------------------------------------------------------------------
-- xps_ethernetlite_v3_01_a library is used for xps_ethernetlite_v3_01_a 
-- component declarations
-------------------------------------------------------------------------------
library xps_ethernetlite_v3_01_a;
use xps_ethernetlite_v3_01_a.all;

-------------------------------------------------------------------------------
-- proc common package of the proc common library is used for different 
-- function declarations
-------------------------------------------------------------------------------
library proc_common_v3_00_a;
use proc_common_v3_00_a.all;

-- synopsys translate_off
Library XilinxCoreLib;
library unisim;
library simprim;
-- synopsys translate_on

-------------------------------------------------------------------------------
-- Definition of Generics:
-------------------------------------------------------------------------------
-- C_DUPLEX               -- 1 = full duplex, 0 = half duplex
-- C_FAMILY               -- Target device family 
-------------------------------------------------------------------------------
-- Definition of Ports:
--
--  Clk                  -- System Clock
--  Rst                  -- System Reset
--  Phy_rx_clk           -- Ethernet receive clock
--  Phy_dv               -- Ethernet receive enable
--  Phy_rx_data          -- Ethernet receive data
--  Phy_rx_col           -- Ethernet collision indicator
--  Phy_rx_er            -- Ethernet receive error
--  Rx_addr_en           -- RX buufer address enable
--  Rx_start             -- Receive start
--  Rx_done              -- Receive complete
--  Rx_pong_ping_l       -- RX Ping/Pong buffer enable
--  Rx_DPM_ce            -- RX buffer chip enable
--  Rx_DPM_wr_data       -- RX buffer write data
--  Rx_DPM_rd_data       -- RX buffer read data
--  Rx_DPM_wr_rd_n       -- RX buffer write read enable
--  Rx_idle              -- RX idle
--  Mac_addr_ram_addr_rd -- MAC Addr RAM read address
--  Mac_addr_ram_data    -- MAC Addr RAM read data
--  Rx_buffer_ready      -- RX buffer ready to accept new packet
-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity receive is
  generic 
    (
    C_DUPLEX : integer := 1; 
      -- 1 = full duplex, 0 = half duplex    
    C_FAMILY             : string  := "virtex5"  
    );
  port 
    (
    Clk                  : in  std_logic;
    Rst                  : in  std_logic;
    Phy_rx_clk           : in  std_logic;
    Phy_dv               : in  std_logic;
    Phy_rx_data          : in  std_logic_vector (0 to 3);
    Phy_rx_col           : in  std_logic;
    Phy_rx_er            : in  std_logic;
    Rx_addr_en           : out std_logic;
    Rx_start             : out std_logic;
    Rx_done              : out std_logic;
    Rx_pong_ping_l       : in  std_logic;
    Rx_DPM_ce            : out std_logic;
    Rx_DPM_wr_data       : out std_logic_vector (0 to 3);
    Rx_DPM_rd_data       : in  std_logic_vector (0 to 3);    
    Rx_DPM_wr_rd_n       : out std_logic;
    Rx_idle              : out std_logic;
    Mac_addr_ram_addr_rd : out std_logic_vector(0 to 3);
    Mac_addr_ram_data    : in  std_logic_vector (0 to 3);
    Rx_buffer_ready      : in  std_logic
    );
end receive;

-------------------------------------------------------------------------------
-- Architecture
-------------------------------------------------------------------------------  
architecture imp of receive is

-------------------------------------------------------------------------------
--  Constant Declarations
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
--  Signal and Type Declarations
-------------------------------------------------------------------------------
signal fifo_empty_i                  : std_logic;
signal fifo_full_i                   : std_logic;
signal emac_rx_rd_i                  : std_logic;
signal emac_rx_rd_data_i             : std_logic_vector(0 to 5);
signal emac_rx_rd_data_d1            : std_logic_vector(0 to 5); -- 03-26-04
signal rxAbortRst                    : std_logic;
signal rxChannelReset                : std_logic;
signal rxBusFifoRdAck                : std_logic;
signal rxComboCrcRst                 : std_logic;
signal rxComboCrcEn                  : std_logic;
signal crcOk_i                       : std_logic;
signal rxCrcRst                      : std_logic;
signal rxCrcEn                       : std_logic;
signal rxCrcEn_d1                    : std_logic; -- 03-26-04
signal receive_enable                : std_logic; -- 03-26-04
signal fifo_reset                    : std_logic; -- 03-26-04

begin

   ----------------------------------------------------------------------------
   -- rx control state machine
   ----------------------------------------------------------------------------
   INST_RX_STATE: entity xps_ethernetlite_v3_01_a.rx_statemachine
     generic map (
       C_DUPLEX             => C_DUPLEX
       )  
     port map (
       Clk                    => Clk,
       Rst                    => rxChannelReset,
       Emac_rx_rd_data_d1     => emac_rx_rd_data_d1, -- 03-26-04
       Receive_enable         => receive_enable, -- 03-26-04
       RxBusFifoRdAck         => rxBusFifoRdAck,
       BusFifoEmpty           => fifo_empty_i,
       Collision              => Phy_rx_col,
       DataValid              => emac_rx_rd_data_i(4),
       RxError                => emac_rx_rd_data_i(5),
       BusFifoData            => emac_rx_rd_data_i(0 to 3),
       CrcOk                  => crcOk_i,
       BusFifoRd              => emac_rx_rd_i,
       RxAbortRst             => rxAbortRst,
       RxCrcRst               => rxCrcRst,
       RxCrcEn                => rxCrcEn,
       Rx_addr_en             => Rx_addr_en,
       Rx_start               => Rx_start,
       Rx_done                => Rx_done,
       Rx_pong_ping_l         => Rx_pong_ping_l,
       Rx_DPM_ce              => Rx_DPM_ce,
       Rx_DPM_wr_data         => Rx_DPM_wr_data,
       Rx_DPM_rd_data         => Rx_DPM_rd_data,
       Rx_DPM_wr_rd_n         => Rx_DPM_wr_rd_n,
       Rx_idle                => Rx_idle,
       Mac_addr_ram_addr_rd   => Mac_addr_ram_addr_rd,
       Mac_addr_ram_data      => Mac_addr_ram_data,
       Rx_buffer_ready        => Rx_buffer_ready
      );      
   
   rxChannelReset <= Rst;
  
   ----------------------------------------------------------------------------
   -- rx interface contains the ethernet rx fifo
   ----------------------------------------------------------------------------
   INST_RX_INTRFCE: entity xps_ethernetlite_v3_01_a.rx_intrfce
     port map (    
       Clk             => Clk,
       Rst             => fifo_reset, -- 03-26-04
       Phy_rx_clk      => Phy_rx_clk,
       InternalWrapEn  => '0',
       Phy_rx_er       => Phy_rx_er,
       Phy_dv          => Phy_dv,
       Phy_rx_data     => Phy_rx_data,
       Rcv_en          => receive_enable, -- 03-26-04
       Fifo_empty      => fifo_empty_i,
       Fifo_full       => fifo_full_i,
       Emac_rx_rd      => emac_rx_rd_i,
       Emac_rx_rd_data => emac_rx_rd_data_i,
       RdAck           => rxBusFifoRdAck
       );    
      
   fifo_reset <= Rst or not(receive_enable); -- 03-26-04
   ----------------------------------------------------------------------------
   -- crc checker
   ----------------------------------------------------------------------------
   INST_CRCGENRX: entity xps_ethernetlite_v3_01_a.crcgenrx
     port map(
       Clk     => Clk,
       Rst     => rxComboCrcRst,
       Data    => emac_rx_rd_data_i(0 to 3),
       DataEn  => rxComboCrcEn,
       CrcOk   => crcOk_i);
   
   rxComboCrcRst <= Rst or rxCrcRst or rxAbortRst;
   rxComboCrcEn  <=  rxCrcEn_d1;                 
   
   ----------------------------------------------------------------------------
   -- REG_PROCESS
   ----------------------------------------------------------------------------
   -- This process registers the received read data and receive CRC enable.
   ----------------------------------------------------------------------------
   REG_PROCESS : process (Clk)
   begin  --
      if (Clk'event and Clk = '1') then     -- rising clock edge
         if (Rst = '1') then
            emac_rx_rd_data_d1 <= "000000";
            rxCrcEn_d1 <= '0';
         else
            emac_rx_rd_data_d1 <= emac_rx_rd_data_i;   
            rxCrcEn_d1 <= rxCrcEn;
         end if;
      end if;
   end process REG_PROCESS;

end imp;