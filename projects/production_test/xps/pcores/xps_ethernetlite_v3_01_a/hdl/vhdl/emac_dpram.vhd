-------------------------------------------------------------------------------
-- emac_dpram.vhd  - entity/architecture pair
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
-- Filename:        emac_dpram.vhd
--
-- Description:     Realization of dprams   
--                  
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
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

-------------------------------------------------------------------------------
-- xps_ethernetlite_v3_01_a library is used for xps_ethernetlite_v3_01_a 
-- component declarations
-------------------------------------------------------------------------------
library xps_ethernetlite_v3_01_a;
use xps_ethernetlite_v3_01_a.mac_pkg.all;

-------------------------------------------------------------------------------
-- proc common package of the proc common library is used for different 
-- function declarations
-------------------------------------------------------------------------------
library proc_common_v3_00_a;
use proc_common_v3_00_a.all;
use proc_common_v3_00_a.family_support.all;

-------------------------------------------------------------------------------
-- Vcomponents from unisim library is used for FIFO instatiation
-- function declarations
-------------------------------------------------------------------------------
library unisim;
use unisim.Vcomponents.all;  -- uses BRAM primitives 

-------------------------------------------------------------------------------
-- Definition of Generics:
-------------------------------------------------------------------------------
-- C_FAMILY             -- Target device family 
-------------------------------------------------------------------------------
-- Definition of Ports:
--
--  Clk                 -- System Clock
--  Rst                 -- System Reset
--  Ce_a                -- Port A enable
--  Wr_rd_n_a           -- Port A write/read enable
--  Adr_a               -- Port A address
--  Data_in_a           -- Port A data in
--  Data_out_a          -- Port A data out
--  Ce_b                -- Port B enable
--  Wr_rd_n_b           -- Port B write/read enable
--  Adr_b               -- Port B address
--  Data_in_b           -- Port B data in
--  Data_out_b          -- Port B data out
-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity emac_dpram is
  generic 
   (
    C_FAMILY : string := "virtex5" 
    );
  port 
    (   
    Clk        : in  std_logic;
    Rst        : in  std_logic;
    -- a Port signals
    Ce_a       : in  std_logic;
    Wr_rd_n_a  : in  std_logic;
    Adr_a      : in  std_logic_vector(0 to 11);
    Data_in_a  : in  std_logic_vector(0 to 3);
    Data_out_a : out std_logic_vector(0 to 3);
    
    -- b Port Signals
    Ce_b       : in  std_logic;
    Wr_rd_n_b  : in  std_logic;
    Adr_b      : in  std_logic_vector(0 to 8);
    Data_in_b  : in  std_logic_vector(0 to 31);
    Data_out_b : out std_logic_vector(0 to 31)
    );
end entity emac_dpram;

                
architecture imp of emac_dpram is

    component RAMB16_S4_S36
-- pragma translate_off
      generic
      (
        WRITE_MODE_A : string := "READ_FIRST"; 
      --WRITE_FIRST(default)/ READ_FIRST/ NO_CHANGE
        WRITE_MODE_B : string := "READ_FIRST" 
      --WRITE_FIRST(default)/ READ_FIRST/ NO_CHANGE
      );
-- pragma translate_on
      port (
        DOA   : out std_logic_vector (3 downto 0);
        DOB   : out std_logic_vector (31 downto 0);
        DOPB  : out std_logic_vector (3 downto 0);
        ADDRA : in std_logic_vector (11 downto 0);
        CLKA  : in std_logic;
        DIA   : in std_logic_vector (3 downto 0);
        ENA   : in std_logic;
        SSRA  : in std_logic;
        WEA   : in std_logic;
        ADDRB : in std_logic_vector (8 downto 0);
        CLKB  : in std_logic;
        DIB   : in std_logic_vector (31 downto 0);
        DIPB  : in std_logic_vector (3 downto 0);
        ENB   : in std_logic;
        SSRB  : in std_logic;
        WEB   : in std_logic
      );
    end component;
    
constant create_v2_mem  : boolean   := supported(C_FAMILY, u_RAMB16_S4_S36);  

-------------------------------------------------------------------------------
--  Signal and Type Declarations
-------------------------------------------------------------------------------

signal ce_a_i          : std_logic; -- added 03-03-05 MSH
signal ce_b_i          : std_logic; -- added 03-03-05 MSH
signal wr_rd_n_a_i     : std_logic; -- added 03-03-05 MSH
signal wr_rd_n_b_i     : std_logic; -- added 03-03-05 MSH

signal port_b_data_in  : STD_LOGIC_VECTOR (31 downto 0);
signal port_b_data_out : STD_LOGIC_VECTOR (31 downto 0);        

attribute WRITE_MODE_A : string;
attribute WRITE_MODE_A of I_DPB16_4_9: label is "READ_FIRST";
attribute WRITE_MODE_B : string;
attribute WRITE_MODE_B of I_DPB16_4_9: label is "READ_FIRST"; 
    
    
  
begin  -- architecture

  ce_a_i <= Ce_a or Rst; -- added 03-03-05 MSH
  ce_b_i <= Ce_b or Rst; -- added 03-03-05 MSH
  wr_rd_n_a_i <= Wr_rd_n_a and not(Rst); -- added 03-03-05 MSH
  wr_rd_n_b_i <= Wr_rd_n_b and not(Rst); -- added 03-03-05 MSH

-------------------------------------------------------------------------------
-- Using VII 4096 x 4 : 2048 x 8 Dual Port Primitive
-------------------------------------------------------------------------------
      port_b_data_in(31) <= Data_in_b(0);
      port_b_data_in(30) <= Data_in_b(1);
      port_b_data_in(29) <= Data_in_b(2);
      port_b_data_in(28) <= Data_in_b(3);
      port_b_data_in(27) <= Data_in_b(4);
      port_b_data_in(26) <= Data_in_b(5);
      port_b_data_in(25) <= Data_in_b(6);
      port_b_data_in(24) <= Data_in_b(7);
      port_b_data_in(23) <= Data_in_b(8);
      port_b_data_in(22) <= Data_in_b(9);
      port_b_data_in(21) <= Data_in_b(10);
      port_b_data_in(20) <= Data_in_b(11);
      port_b_data_in(19) <= Data_in_b(12);
      port_b_data_in(18) <= Data_in_b(13);
      port_b_data_in(17) <= Data_in_b(14);
      port_b_data_in(16) <= Data_in_b(15);
      port_b_data_in(15) <= Data_in_b(16);
      port_b_data_in(14) <= Data_in_b(17);
      port_b_data_in(13) <= Data_in_b(18);
      port_b_data_in(12) <= Data_in_b(19);
      port_b_data_in(11) <= Data_in_b(20);
      port_b_data_in(10) <= Data_in_b(21);
      port_b_data_in(9)  <= Data_in_b(22);
      port_b_data_in(8)  <= Data_in_b(23);
      port_b_data_in(7)  <= Data_in_b(24);
      port_b_data_in(6)  <= Data_in_b(25);
      port_b_data_in(5)  <= Data_in_b(26);
      port_b_data_in(4)  <= Data_in_b(27);
      port_b_data_in(3)  <= Data_in_b(28);
      port_b_data_in(2)  <= Data_in_b(29);
      port_b_data_in(1)  <= Data_in_b(30);
      port_b_data_in(0)  <= Data_in_b(31);

      Data_out_b(31) <= port_b_data_out(0);
      Data_out_b(30) <= port_b_data_out(1);
      Data_out_b(29) <= port_b_data_out(2);
      Data_out_b(28) <= port_b_data_out(3);
      Data_out_b(27) <= port_b_data_out(4);
      Data_out_b(26) <= port_b_data_out(5);
      Data_out_b(25) <= port_b_data_out(6);
      Data_out_b(24) <= port_b_data_out(7);  
      Data_out_b(23) <= port_b_data_out(8);
      Data_out_b(22) <= port_b_data_out(9);
      Data_out_b(21) <= port_b_data_out(10);
      Data_out_b(20) <= port_b_data_out(11);
      Data_out_b(19) <= port_b_data_out(12);
      Data_out_b(18) <= port_b_data_out(13);
      Data_out_b(17) <= port_b_data_out(14);
      Data_out_b(16) <= port_b_data_out(15);  
      Data_out_b(15) <= port_b_data_out(16);
      Data_out_b(14) <= port_b_data_out(17);
      Data_out_b(13) <= port_b_data_out(18);
      Data_out_b(12) <= port_b_data_out(19);
      Data_out_b(11) <= port_b_data_out(20);
      Data_out_b(10) <= port_b_data_out(21);
      Data_out_b(9)  <= port_b_data_out(22);
      Data_out_b(8)  <= port_b_data_out(23);  
      Data_out_b(7)  <= port_b_data_out(24);
      Data_out_b(6)  <= port_b_data_out(25);
      Data_out_b(5)  <= port_b_data_out(26);
      Data_out_b(4)  <= port_b_data_out(27);
      Data_out_b(3)  <= port_b_data_out(28);
      Data_out_b(2)  <= port_b_data_out(29);
      Data_out_b(1)  <= port_b_data_out(30);
      Data_out_b(0)  <= port_b_data_out(31);  
      
      I_DPB16_4_9: RAMB16_S4_S36
        port map (
          DOA   => Data_out_a,      --[out]
          DOB   => port_b_data_out, --[out]
          DOPB  => open,            --[out]
          ADDRA => Adr_a,           --[in]
          CLKA  => Clk,             --[in]
          DIA   => Data_in_a,       --[in]
          ENA   => ce_a_i,          --[in]
          SSRA  => Rst,             --[in]
          WEA   => wr_rd_n_a_i,     --[in]
          ADDRB => Adr_b,           --[in]
          CLKB  => Clk,             --[in]
          DIB   => port_b_data_in,  --[in]
          DIPB  => (others => '0'), --[in]
          ENB   => ce_b_i,          --[in]
          SSRB  => Rst,             --[in]
          WEB   => wr_rd_n_b_i      --[in]
        );

assert (create_v2_mem)
report "The primitive RAMB16_S4_S36 is not Supported by the Target device"
severity FAILURE; 
   
end architecture imp;