-------------------------------------------------------------------------------
-- deferral - entity/architecture pair
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
-- Filename:        deferral.vhd
-- 
-- Description:     
--                  This file contains the transmit deferral control.
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
-- Author:         M. Scott Hurt
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
use xps_ethernetlite_v3_01_a.mac_pkg.all;

-- synopsys translate_off
Library XilinxCoreLib;
-- synopsys translate_on

-------------------------------------------------------------------------------
-- Port Declaration
-------------------------------------------------------------------------------
-- Definition of Ports:
--
--  Clk          -- System Clock
--  Rst          -- System Reset
--  TxEn         -- Transmit enable
--  Txrst        -- Transmit reset
--  Tx_clk_en    -- Transmit clock enable
--  BackingOff   -- Backing off 
--  Crs          -- Carrier sense
--  Full_half_n  -- Full/Half duplex indicator
--  Ifgp1        -- Interframe gap delay
--  Ifgp2        -- Interframe gap delay
--  Deferring    -- Deffering for the tx data
-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity deferral is
  port 
       (
        Clk         : in std_logic;
        Rst         : in std_logic;
        TxEn        : in std_logic; 
        Txrst       : in std_logic;
        Tx_clk_en   : in std_logic;
        BackingOff  : in std_logic;
        Crs         : in std_logic;
        Full_half_n : in std_logic;
        Ifgp1       : in std_logic_vector(0 to 4);
        Ifgp2       : in std_logic_vector(0 to 4);        
        Deferring   : out std_logic
        );
end deferral;

-------------------------------------------------------------------------------
-- Definition of Generics:
--          No Generics were used for this Entity.
--
-- Definition of Ports:
--         
-------------------------------------------------------------------------------

architecture implementation of deferral is

-------------------------------------------------------------------------------
-- Signal and Type Declarations
-------------------------------------------------------------------------------
  signal cntrLd_i     : std_logic;
  signal cntrEn       : std_logic;
  signal comboCntrEn  : std_logic;
  signal comboCntrEn2 : std_logic;
  signal ifgp1_zero   : std_logic;
  signal ifgp2_zero   : std_logic;
  signal comboRst     : std_logic;
   
begin

comboRst     <= Rst or Txrst;
comboCntrEn  <= Tx_clk_en and cntrEn;
comboCntrEn2 <= Tx_clk_en and cntrEn and ifgp1_zero;
-------------------------------------------------------------------------------
-- Ifgp1 counter
-------------------------------------------------------------------------------
  inst_ifgp1_count: entity xps_ethernetlite_v3_01_a.cntr5bit
    port map
           (
            Clk     =>  Clk, 
            Rst     =>  comboRst,
            En      =>  comboCntrEn,
            Ld      =>  cntrLd_i,
            Load_in =>  Ifgp1,
            Zero    =>  ifgp1_zero
            );  

-------------------------------------------------------------------------------
-- Ifgp2 counter
-------------------------------------------------------------------------------
  inst_ifgp2_count: entity xps_ethernetlite_v3_01_a.cntr5bit
    port map
           (
            Clk     =>  Clk, 
            Rst     =>  comboRst,
            En      =>  comboCntrEn2,
            Ld      =>  cntrLd_i,
            Load_in =>  Ifgp2,
            Zero    =>  ifgp2_zero
            );

-------------------------------------------------------------------------------
-- deferral state machine
-------------------------------------------------------------------------------
  inst_deferral_state: entity xps_ethernetlite_v3_01_a.defer_state
    port map
            (
             Clk         =>  Clk, 
             Rst         =>  Rst,
             TxEn        =>  TxEn,
             Txrst       =>  Txrst, 
             Ifgp2Done   =>  ifgp2_zero,
             Ifgp1Done   =>  ifgp1_zero,
             BackingOff  =>  BackingOff,
             Crs         =>  Crs,
             Full_half_n =>  Full_half_n,
             Deferring   =>  Deferring,
             CntrEnbl    =>  cntrEn,
             CntrLd      =>  cntrLd_i
             );   


end implementation;
