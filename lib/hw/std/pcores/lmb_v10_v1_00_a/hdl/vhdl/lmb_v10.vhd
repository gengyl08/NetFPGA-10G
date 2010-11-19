-------------------------------------------------------------------------------
-- $Id: lmb_v10.vhd,v 1.2 2002/04/10 23:24:14 paulo Exp $
-------------------------------------------------------------------------------
-- lmb_v10.vhd
-------------------------------------------------------------------------------
--
--                  ****************************
--                  ** Copyright Xilinx, Inc. **
--                  ** All rights reserved.   **
--                  ****************************
--
-------------------------------------------------------------------------------
-- Filename:        lmb_v10.vhd
--
-- Description:     
--                  
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:   
--              lmb_v10.vhd
--
-------------------------------------------------------------------------------
-- Author:          goran
-- Revision:        $Revision: 1.2 $
-- Date:            $Date: 2002/04/10 23:24:14 $
--
-- History:
--   goran  2002-01-30    First Version
--   paulo  2002-04-10    Renamed C_NUM_SLAVES to C_LMB_NUM_SLAVES
--
-------------------------------------------------------------------------------
-- Naming Conventions:
--      active low signals:                     "*_n"
--      clock signals:                          "clk", "clk_div#", "clk_#x" 
--      reset signals:                          "rst", "rst_n" 
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

entity lmb_v10 is

  generic (
    C_LMB_NUM_SLAVES     : integer := 4;
    C_LMB_DWIDTH     : integer := 32;
    C_LMB_AWIDTH     : integer := 32;
    C_EXT_RESET_HIGH : integer := 1
    );

  port (
    -- Global Ports
    LMB_Clk : in  std_logic;
    SYS_Rst : in  std_logic;
    LMB_Rst : out std_logic;

    -- LMB master signals
    M_ABus        : in std_logic_vector(0 to C_LMB_AWIDTH-1);
    M_ReadStrobe  : in std_logic;
    M_WriteStrobe : in std_logic;
    M_AddrStrobe  : in std_logic;
    M_DBus        : in std_logic_vector(0 to C_LMB_DWIDTH-1);
    M_BE          : in std_logic_vector(0 to (C_LMB_DWIDTH+7)/8-1);

    -- LMB slave signals
    Sl_DBus  : in std_logic_vector(0 to (C_LMB_DWIDTH*C_LMB_NUM_SLAVES)-1);
    Sl_Ready : in std_logic_vector(0 to C_LMB_NUM_SLAVES-1);

    -- LMB output signals
    LMB_ABus        : out std_logic_vector(0 to C_LMB_AWIDTH-1);
    LMB_ReadStrobe  : out std_logic;
    LMB_WriteStrobe : out std_logic;
    LMB_AddrStrobe  : out std_logic;
    LMB_ReadDBus    : out std_logic_vector(0 to C_LMB_DWIDTH-1);
    LMB_WriteDBus   : out std_logic_vector(0 to C_LMB_DWIDTH-1);
    LMB_Ready       : out std_logic;
    LMB_BE          : out std_logic_vector(0 to (C_LMB_DWIDTH+7)/8-1)
    );

end entity lmb_v10;

library unisim;
use unisim.all;

architecture IMP of lmb_v10 is

  component SRL16 is
    -- synthesis translate_off
    generic (
      INIT : bit_vector );
    -- synthesis translate_on
    port (
      D   : in  std_logic;
      CLK : in  std_logic;
      A0  : in  std_logic;
      A1  : in  std_logic;
      A2  : in  std_logic;
      A3  : in  std_logic;
      Q   : out std_logic); 
  end component SRL16;

  component FDS is
    port(
      Q : out std_logic;
      D : in  std_logic;
      C : in  std_logic;
      S : in  std_logic);
  end component FDS;

  signal srl_time_out : std_logic;
  signal sys_rst_i    : std_logic;

  attribute INIT              : string;
  attribute INIT of POR_SRL_I : label is "FFFF";

begin  -- architecture IMP

  -----------------------------------------------------------------------------
  -- Driving the reset signal
  -----------------------------------------------------------------------------

  SYS_RST_PROC : process (SYS_Rst) is
    variable sys_rst_input : std_logic;
  begin
    if C_EXT_RESET_HIGH = 0 then
      sys_rst_input := not SYS_Rst;
    else
      sys_rst_input := SYS_Rst;
    end if;
    sys_rst_i <= sys_rst_input;
  end process SYS_RST_PROC;

  POR_SRL_I : SRL16
    -- synthesis translate_off
    generic map (
      INIT => X"FFFF") 
    -- synthesis translate_on
    port map (
      D   => '0',
      CLK => LMB_Clk,
      A0  => '1',
      A1  => '1',
      A2  => '1',
      A3  => '1',
      Q   => srl_time_out);

  POR_FF_I : FDS
    port map (
      Q => LMB_Rst,
      D => srl_time_out,
      C => LMB_Clk,
      S => sys_rst_i);

  -----------------------------------------------------------------------------
  -- Drive all Master to Slave signals
  -----------------------------------------------------------------------------
  LMB_ABus        <= M_ABus;
  LMB_ReadStrobe  <= M_ReadStrobe;
  LMB_WriteStrobe <= M_WriteStrobe;
  LMB_AddrStrobe  <= M_AddrStrobe;
  LMB_BE          <= M_BE;
  LMB_WriteDBus   <= M_DBus;

  -----------------------------------------------------------------------------
  -- Drive all the Slave to Master signals
  -----------------------------------------------------------------------------
  Ready_ORing : process (Sl_Ready) is
    variable i : std_logic;
  begin  -- process Ready_ORing
    i := '0';
    for S in Sl_Ready'range loop
      i := i or Sl_Ready(S);
    end loop;  -- S
    LMB_Ready <= i;
  end process Ready_ORing;

  DBus_Oring : process (Sl_Ready, Sl_DBus) is
    variable Res    : std_logic_vector(0 to C_LMB_DWIDTH-1);
    variable Tmp    : std_logic_vector(Sl_DBus'range);
    variable tmp_or : std_logic;
  begin  -- process DBus_Oring
    if (C_LMB_NUM_SLAVES = 1) then
      LMB_ReadDBus <= Sl_DBus;
    else
      -- First gating all data signals with their resp. ready signal
      for I in 0 to C_LMB_NUM_SLAVES-1 loop
        for J in 0 to C_LMB_DWIDTH-1 loop
          tmp(I*C_LMB_DWIDTH + J) := Sl_Ready(I) and Sl_DBus(I*C_LMB_DWIDTH + J);
        end loop;  -- J
      end loop;  -- I
      -- then oring the tmp signals together
      for J in 0 to C_LMB_DWIDTH-1 loop
        tmp_or := '0';
        for I in 0 to C_LMB_NUM_SLAVES-1 loop
          tmp_or := tmp_or or tmp(I*C_LMB_DWIDTH + j);
        end loop;  -- J
        res(J) := tmp_or;
      end loop;  -- I
      LMB_ReadDBus <= Res;
    end if;
  end process DBus_Oring;

end architecture IMP;



