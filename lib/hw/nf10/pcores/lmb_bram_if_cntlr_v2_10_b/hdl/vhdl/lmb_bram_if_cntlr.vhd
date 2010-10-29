-------------------------------------------------------------------------------
-- $Id: lmb_bram_if_cntlr.vhd,v 1.4 2008/10/02 07:47:46 rolandp Exp $
-------------------------------------------------------------------------------
-- DISCLAIMER OF LIABILITY
--
-- This file contains proprietary and confidential information of
-- Xilinx, Inc. ("Xilinx"), that is distributed under a license
-- from Xilinx, and may be used, copied and/or disclosed only
-- pursuant to the terms of a valid license agreement with Xilinx.
--
-- XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION
-- ("MATERIALS") "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
-- EXPRESSED, IMPLIED, OR STATUTORY, INCLUDING WITHOUT
-- LIMITATION, ANY WARRANTY WITH RESPECT TO NONINFRINGEMENT,
-- MERCHANTABILITY OR FITNESS FOR ANY PARTICULAR PURPOSE. Xilinx
-- does not warrant that functions included in the Materials will
-- meet the requirements of Licensee, or that the operation of the
-- Materials will be uninterrupted or error-free, or that defects
-- in the Materials will be corrected. Furthermore, Xilinx does
-- not warrant or make any representations regarding use, or the
-- results of the use, of the Materials in terms of correctness,
-- accuracy, reliability or otherwise.
--
-- Xilinx products are not designed or intended to be fail-safe,
-- or for use in any application requiring fail-safe performance,
-- such as life-support or safety devices or systems, Class III
-- medical devices, nuclear facilities, applications related to
-- the deployment of airbags, or any other applications that could
-- lead to death, personal injury or severe property or
-- environmental damage (individually and collectively, "critical
-- applications"). Customer assumes the sole risk and liability
-- of any use of Xilinx products in critical applications,
-- subject only to applicable laws and regulations governing
-- limitations on product liability.
--
-- Copyright 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009 Xilinx, Inc.
-- All rights reserved.
--
-- This disclaimer and copyright notice must be retained as part
-- of this file at all times.
--
-------------------------------------------------------------------------------
-- Filename:        lmb_bram_if_cntlr.vhd
--
-- Description:
--
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:
--              lmb_bram_if_cntlr.vhd
--
-------------------------------------------------------------------------------
-- Author:          goran
-- Revision:        $Revision: 1.4 $
-- Date:            $Date: 2008/10/02 07:47:46 $
--
-- History:
--   paulo  2002-07-08    First Version
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

library ieee;
use ieee.std_logic_1164.all;

library lmb_bram_if_cntlr_v2_10_b;
use lmb_bram_if_cntlr_v2_10_b.pselect_mask;

entity lmb_bram_if_cntlr is
  generic (
    C_HIGHADDR   : std_logic_vector(0 to 31) := X"00000000";
    C_BASEADDR   : std_logic_vector(0 to 31) := X"FFFFFFFF";
    C_MASK       : std_logic_vector(0 to 31) := X"00800000";
    C_LMB_AWIDTH : integer                   := 32;
    C_LMB_DWIDTH : integer                   := 32
    );
  port (
    LMB_Clk : in std_logic := '0';
    LMB_Rst : in std_logic := '0';

    -- Instruction Bus
    LMB_ABus        : in  std_logic_vector(0 to C_LMB_AWIDTH-1);
    LMB_WriteDBus   : in  std_logic_vector(0 to C_LMB_DWIDTH-1);
    LMB_AddrStrobe  : in  std_logic;
    LMB_ReadStrobe  : in  std_logic;
    LMB_WriteStrobe : in  std_logic;
    LMB_BE          : in  std_logic_vector(0 to (C_LMB_DWIDTH/8 - 1));
    Sl_DBus         : out std_logic_vector(0 to C_LMB_DWIDTH-1);
    Sl_Ready        : out std_logic;

    -- ports to memory block
    BRAM_Rst_A  : out std_logic;
    BRAM_Clk_A  : out std_logic;
    BRAM_Addr_A : out std_logic_vector(0 to C_LMB_AWIDTH-1);
    BRAM_EN_A   : out std_logic;
    BRAM_WEN_A  : out std_logic_vector(0 to C_LMB_DWIDTH/8-1);
    BRAM_Dout_A : out std_logic_vector(0 to C_LMB_DWIDTH-1);
    BRAM_Din_A  : in  std_logic_vector(0 to C_LMB_DWIDTH-1)
    );
end lmb_bram_if_cntlr;

architecture imp of lmb_bram_if_cntlr is

------------------------------------------------------------------------------
-- component declarations
------------------------------------------------------------------------------

  component pselect_mask is
    generic (
      C_AW   : integer                   := 32;
      C_BAR  : std_logic_vector(0 to 31) := X"00000000";
      C_MASK : std_logic_vector(0 to 31) := X"00800000");
    port (
      A     : in  std_logic_vector(0 to 31);
      CS    : out std_logic;
      Valid : in  std_logic);
  end component;

------------------------------------------------------------------------------
-- internal signals
------------------------------------------------------------------------------

  signal lmb_select : std_logic;

  signal lmb_select_1 : std_logic;

  signal lmb_we : std_logic_vector(0 to 3);

  signal Sl_Ready_i       : std_logic;
  signal lmb_addrstrobe_i : std_logic;

  signal One : std_logic;
begin  -- architecture IMP

  
  -----------------------------------------------------------------------------
  -- Top-level port assignments

  -- Port A
  BRAM_Rst_A  <= '0';
  BRAM_Clk_A  <= LMB_Clk;
  BRAM_EN_A   <= LMB_AddrStrobe;
  BRAM_WEN_A  <= lmb_we;
  BRAM_Dout_A <= LMB_WriteDBus;
  Sl_DBus     <= BRAM_Din_A;
  BRAM_Addr_A <= LMB_ABus;

  -----------------------------------------------------------------------------
  -- Handling the LMB bus interface
  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  -- Writes are pipelined in MB with 5 stage pipeline
  -----------------------------------------------------------------------------
  Ready_Handling : process (LMB_Clk, LMB_Rst) is
  begin  -- PROCESS Ready_Handling
    if (LMB_Clk'event and LMB_Clk = '1') then  -- rising clock edge
      if (LMB_Rst = '1') then
        Sl_Ready_i       <= '0';
        lmb_addrstrobe_i <= '0';
      else
        Sl_Ready_i       <= lmb_select;
        lmb_addrstrobe_i <= LMB_AddrStrobe;
      end if;
    end if;
  end process Ready_Handling;

  Sl_Ready <= Sl_Ready_i and lmb_addrstrobe_i;
  
  lmb_we(0) <= LMB_BE(0) and LMB_WriteStrobe and lmb_select;
  lmb_we(1) <= LMB_BE(1) and LMB_WriteStrobe and lmb_select;
  lmb_we(2) <= LMB_BE(2) and LMB_WriteStrobe and lmb_select;
  lmb_we(3) <= LMB_BE(3) and LMB_WriteStrobe and lmb_select;
    
  -----------------------------------------------------------------------------
  -- Do the LMB address decoding
  -----------------------------------------------------------------------------
  One <= '1';
  pselect_mask_lmb : pselect_mask
    generic map (
      C_AW   => LMB_ABus'length,
      C_BAR  => C_BASEADDR,
      C_MASK => C_MASK)
    port map (
      A     => LMB_ABus,
      CS    => lmb_select,
      Valid => One);

end architecture imp;
