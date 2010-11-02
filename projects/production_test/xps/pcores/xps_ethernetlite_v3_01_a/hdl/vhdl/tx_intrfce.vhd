-------------------------------------------------------------------------------
-- tx_intrfce - entity/architecture pair
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
-- Filename:        tx_intrfce.vhd
--
-- Description:     This is the ethernet transmit interface. 
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
use ieee.std_logic_1164.all;

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
use proc_common_v3_00_a.family.all;

-- synopsys translate_off
Library XilinxCoreLib;
library simprim;
-- synopsys translate_on

-------------------------------------------------------------------------------
-- Vcomponents from unisim library is used for FIFO instatiation
-- function declarations
-------------------------------------------------------------------------------
library unisim;
use unisim.Vcomponents.all;

-------------------------------------------------------------------------------
-- Definition of Ports:
--
--  Clk                 -- System Clock
--  Rst                 -- System Reset
--  Phy_tx_clk          -- PHY TX Clock
--  Emac_tx_wr_data     -- Ethernet transmit data
--  Tx_er               -- Transmit error
--  Phy_tx_en           -- Ethernet transmit enable
--  Tx_en               -- Transmit enable
--  Emac_tx_wr          -- TX FIFO write enable
--  Fifo_empty          -- TX FIFO empty
--  Fifo_almost_emp     -- TX FIFP almost empty
--  Fifo_full           -- TX FIFO full
--  Phy_tx_data         -- Ethernet transmit data
-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity tx_intrfce is

  port 
    (
    Clk               : in  std_logic;
    Rst               : in  std_logic;
    Phy_tx_clk        : in  std_logic;
    Emac_tx_wr_data   : in  std_logic_vector (0 to 3);
    Tx_er             : in  std_logic;
    PhyTxEn           : in  std_logic;
    Tx_en             : in  std_logic;
    Emac_tx_wr        : in  std_logic;
    Fifo_rd_ack       : out std_logic;  
    Fifo_empty        : out std_logic;
    Fifo_almost_empty : out std_logic; 
    Fifo_full         : out std_logic;
    Phy_tx_data       : out std_logic_vector (0 to 5)
    );
end tx_intrfce;

architecture implementation of tx_intrfce is

-------------------------------------------------------------------------------
--  Constant Declarations
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
--  Signal and Type Declarations
-------------------------------------------------------------------------------

signal bus_combo    : std_logic_vector (0 to 5);
signal fifo_empty_i : std_logic;
-------------------------------------------------------------------------------
-- Component Declarations
-------------------------------------------------------------------------------
-- The following components are the building blocks of the EMAC
-------------------------------------------------------------------------------
component FDR
  port 
   (
    Q : out std_logic;
    C : in std_logic;
    D : in std_logic;
    R : in std_logic
   );
end component;
 
-------------------------------------------------------------------------------
-- COREGEN asynchronous FIFO that is 5 wide and 15 deep
-------------------------------------------------------------------------------
 
-- Start Configuration Specification
  
-- End Configuration Specification
-- This was copied from the COREGEN ethernetlite_v1_00_a_dmem_v2.vho file
  component ethernetlite_v1_01_b_dmem_v2
    port 
      (
      din   : in std_logic_vector(5 downto 0);
      wr_en : in std_logic;
      wr_clk: in std_logic;
      rd_en : in std_logic;
      rd_clk: in std_logic;
      ainit : in std_logic;
      dout  : out std_logic_vector(5 downto 0);
      full  : out std_logic;
      empty : out std_logic;
      rd_ack: out std_logic
      );
  end component;

-- synopsys translate_off
  for all : ethernetlite_v1_01_b_dmem_v2 
            use entity XilinxCoreLib.async_fifo_v5_1(behavioral)
    generic map
     (
      c_wr_count_width   => 2,
      c_has_rd_err       => 0,
      c_data_width       => 6,
      c_has_almost_full  => 0,
      c_rd_err_low       => 0,
      c_has_wr_ack       => 0,
      c_wr_ack_low       => 0,
      c_fifo_depth       => 15,
      c_rd_count_width   => 2,
      c_has_wr_err       => 0,
      c_has_almost_empty => 0,
      c_rd_ack_low       => 0,
      c_has_wr_count     => 0,
      c_use_blockmem     => 0,
      c_has_rd_ack       => 1,
      c_has_rd_count     => 0,
      c_wr_err_low       => 0,
      c_enable_rlocs     => 0
      );

-- synopsys translate_on
                            
-- Synplicity black box declaration
 attribute box_type : string;
 attribute box_type of ethernetlite_v1_01_b_dmem_v2: component is "black_box";

begin
    
   pipeIt: FDR
     port map
      (
       Q => Fifo_empty,   --[out]
       C => Clk,          --[in]
       D => fifo_empty_i, --[in]
       R => Rst           --[in]
      );
     

   -- Connect the Coregen fifo to the VHDL wrapper
      I_TX_FIFO : ethernetlite_v1_01_b_dmem_v2
        port map 
          (
          din    => bus_combo,
          wr_en  => Emac_tx_wr,
          wr_clk => Clk,
          rd_en  => Tx_en,
          rd_clk => Phy_tx_clk,
          ainit  => Rst,
          dout   => Phy_tx_data,
          full   => Fifo_full,
          empty  => fifo_empty_i,    
          rd_ack => open
          );    

      bus_combo <= (Emac_tx_wr_data & Tx_er & PhyTxEn); 
           
end implementation;

