-------------------------------------------------------------------------------
-- $Id: dcm_module.vhd,v 1.1.2.6 2010/04/22 16:41:04 xic Exp $
-------------------------------------------------------------------------------
-- dcm_module.vhd - Entity and architecture
--
--  ***************************************************************************
--  **  Copyright(C) 2003 by Xilinx, Inc. All rights reserved.               **
--  **                                                                       **
--  **  This text contains proprietary, confidential                         **
--  **  information of Xilinx, Inc. , is distributed by                      **
--  **  under license from Xilinx, Inc., and may be used,                    **
--  **  copied and/or disclosed only pursuant to the terms                   **
--  **  of a valid license agreement with Xilinx, Inc.                       **
--  **                                                                       **
--  **  Unmodified source code is guaranteed to place and route,             **
--  **  function and run at speed according to the datasheet                 **
--  **  specification. Source code is provided "as-is", with no              **
--  **  obligation on the part of Xilinx to provide support.                 **
--  **                                                                       **
--  **  Xilinx Hotline support of source code IP shall only include          **
--  **  standard level Xilinx Hotline support, and will only address         **
--  **  issues and questions related to the standard released Netlist        **
--  **  version of the core (and thus indirectly, the original core source). **
--  **                                                                       **
--  **  The Xilinx Support Hotline does not have access to source            **
--  **  code and therefore cannot answer specific questions related          **
--  **  to source HDL. The Xilinx Support Hotline will only be able          **
--  **  to confirm the problem in the Netlist version of the core.           **
--  **                                                                       **
--  **  This copyright and support notice must be retained as part           **
--  **  of this text at all times.                                           **
--  ***************************************************************************
--
-------------------------------------------------------------------------------
-- Filename:        dcm_module.vhd
--
-- Description:     
--                  
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:   
--              dcm_module.vhd
--
-------------------------------------------------------------------------------
-- Author:          goran
-- Revision:        $Revision: 1.1.2.6 $
-- Date:            $Date: 2010/04/22 16:41:04 $
--
-- History:
--   goran  2003-06-05    First Version
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
use IEEE.numeric_std.all;

library Unisim;
use Unisim.vcomponents.all;

-------------------------------------------------------------------------------
-- dcm module v1.00.c
-------------------------------------------------------------------------------

entity dcm_module is
  generic (
    C_DFS_FREQUENCY_MODE    : string  := "LOW";
    C_DLL_FREQUENCY_MODE    : string  := "LOW";
    C_DUTY_CYCLE_CORRECTION : boolean := true;
    C_CLKIN_DIVIDE_BY_2     : boolean := false;
    C_CLK_FEEDBACK          : string  := "1X";
    C_CLKOUT_PHASE_SHIFT    : string  := "NONE";
    C_DSS_MODE              : string  := "NONE";
    C_STARTUP_WAIT          : boolean := false;
    C_PHASE_SHIFT           : integer := 0;
    C_CLKFX_MULTIPLY        : integer := 4;
    C_CLKFX_DIVIDE          : integer := 1;
    C_CLKDV_DIVIDE          : real    := 2.0;
    C_CLKIN_PERIOD          : real    := 41.6666666;
    C_DESKEW_ADJUST         : string  := "SYSTEM_SYNCHRONOUS";
    C_CLKIN_BUF             : boolean := false;
    C_CLKFB_BUF             : boolean := false;
    C_CLK0_BUF              : boolean := false;
    C_CLK90_BUF             : boolean := false;
    C_CLK180_BUF            : boolean := false;
    C_CLK270_BUF            : boolean := false;
    C_CLKDV_BUF             : boolean := false;
    C_CLK2X_BUF             : boolean := false;
    C_CLK2X180_BUF          : boolean := false;
    C_CLKFX_BUF             : boolean := false;
    C_CLKFX180_BUF          : boolean := false;
    C_EXT_RESET_HIGH        : integer := 1;
    C_FAMILY                : string  := "virtex2"
    );
  port (
    RST      : in  std_logic;
    CLKIN    : in  std_logic;
    CLKFB    : in  std_logic;
    PSEN     : in  std_logic;
    PSINCDEC : in  std_logic;
    PSCLK    : in  std_logic;
    DSSEN    : in  std_logic;
    CLK0     : out std_logic;
    CLK90    : out std_logic;
    CLK180   : out std_logic;
    CLK270   : out std_logic;
    CLKDV    : out std_logic;
    CLK2X    : out std_logic;
    CLK2X180 : out std_logic;
    CLKFX    : out std_logic;
    CLKFX180 : out std_logic;
    STATUS   : out std_logic_vector(7 downto 0);
    LOCKED   : out std_logic;
    PSDONE   : out std_logic
    );
end dcm_module;

architecture STRUCT of dcm_module is

  signal rsti : std_logic;
  
  signal CLKIN_BUF    : std_logic;
  signal CLKFB_BUF    : std_logic;
  signal CLK0_BUF     : std_logic;
  signal CLK90_BUF    : std_logic;
  signal CLK180_BUF   : std_logic;
  signal CLK270_BUF   : std_logic;
  signal CLKDV_BUF    : std_logic;
  signal CLK2X_BUF    : std_logic;
  signal CLK2X180_BUF : std_logic;
  signal CLKFX_BUF    : std_logic;
  signal CLKFX180_BUF : std_logic;

  function UpperCase_Char(char : character) return character is
  begin
    -- If char is not an upper case letter then return char
    if char < 'a' or char > 'z' then
      return char;
    end if;
    -- Otherwise map char to its corresponding lower case character and
    -- return that
    case char is
      when 'a'    => return 'A'; when 'b' => return 'B'; when 'c' => return 'C'; when 'd' => return 'D';
      when 'e'    => return 'E'; when 'f' => return 'F'; when 'g' => return 'G'; when 'h' => return 'H';
      when 'i'    => return 'I'; when 'j' => return 'J'; when 'k' => return 'K'; when 'l' => return 'L';
      when 'm'    => return 'M'; when 'n' => return 'N'; when 'o' => return 'O'; when 'p' => return 'P';
      when 'q'    => return 'Q'; when 'r' => return 'R'; when 's' => return 'S'; when 't' => return 'T';
      when 'u'    => return 'U'; when 'v' => return 'V'; when 'w' => return 'W'; when 'x' => return 'X';
      when 'y'    => return 'Y'; when 'z' => return 'Z';
      when others => return char;
    end case;
  end UpperCase_Char;

  function UpperCase_String (s : string) return string is
    variable res : string(s'range);
  begin  -- function LoweerCase_String
    for I in s'range loop
      res(I) := UpperCase_Char(s(I));
    end loop;  -- I
    return res;
  end function UpperCase_String;

  -- Returns true if case insensitive string comparison determines that
  -- str1 and str2 are equal
  FUNCTION equalString( str1, str2 : STRING ) RETURN BOOLEAN IS
    CONSTANT len1 : INTEGER := str1'length;
    CONSTANT len2 : INTEGER := str2'length;
    VARIABLE equal : BOOLEAN := TRUE;
  BEGIN
    IF NOT (len1=len2) THEN
      equal := FALSE;
    ELSE
      FOR i IN str1'range LOOP
        IF NOT (UpperCase_Char(str1(i)) = UpperCase_Char(str2(i))) THEN
          equal := FALSE;
        END IF;
      END LOOP;
    END IF;

    RETURN equal;
  END equalString;

  -- Must use equalString otherwise:
  -- "Size of operands are different : result is <false>"
  constant Virtex6_Based : boolean := equalString(C_FAMILY, "VIRTEX6") or equalString(C_FAMILY, "VIRTEX6L") or equalString(C_FAMILY, "QVIRTEX6");
  constant Virtex5_Based : boolean := equalString(C_FAMILY, "VIRTEX5") or equalString(C_FAMILY, "QVIRTEX5") or equalString(C_FAMILY, "QRVIRTEX5");
  constant Virtex4_Based : boolean := equalString(C_FAMILY, "VIRTEX4") or equalString(C_FAMILY, "QVIRTEX4") or equalString(C_FAMILY, "QRVIRTEX4") or equalString(C_FAMILY, "AVIRTEX4");
  constant Virtex_Based : boolean := (not Virtex4_Based) and (not Virtex5_Based) and (not Virtex6_Based);

  constant FACTORY_JF_SETTING : bit_vector := X"F0F0";

  signal reset : std_logic;
  
begin

  -----------------------------------------------------------------------------
  -- handle the reset
  -----------------------------------------------------------------------------
  Rst_is_Active_High: if (C_EXT_RESET_HIGH = 1) generate
    reset <= RST;
  end generate Rst_is_Active_High;

  Rst_is_Active_Low: if (C_EXT_RESET_HIGH /= 1) generate
    reset <= not RST;
  end generate Rst_is_Active_Low;

  -----------------------------------------------------------------------------
  -- Make sure that reset is hold 3 more clock signals after RST is deasserted
  -- this is needed when a LOCKED output from another DCM is drving the RST signal
  -----------------------------------------------------------------------------
  -- 20071207 CR 455700 : Use CLKIN_BUF instead CLKIN in the Reset_Handler
  Reset_Handler : process (CLKIN_BUF) is
    variable rst_delay : std_logic_vector(0 to 2);
  begin  -- process Reset_Handler
    if Reset = '1' then  -- asynchronous reset (active high)        
      rsti      <= '1';
      rst_delay := (others => '1');
    elsif CLKIN_BUF'event and CLKIN_BUF = '1' then  -- rising clock edge
      rsti      <= rst_delay(rst_delay'right);
      rst_delay := reset & rst_delay(0 to rst_delay'right-1);
    end if;
  end process Reset_Handler;
  
  
  Using_Virtex : if (Virtex_Based) generate
      DCM_INST : DCM
        generic map (
          CLK_FEEDBACK          => UpperCase_String(C_CLK_FEEDBACK),
          CLKDV_DIVIDE          => C_CLKDV_DIVIDE,
          CLKFX_DIVIDE          => C_CLKFX_DIVIDE,
          CLKFX_MULTIPLY        => C_CLKFX_MULTIPLY,
          CLKIN_DIVIDE_BY_2     => C_CLKIN_DIVIDE_BY_2,
          CLKIN_PERIOD          => C_CLKIN_PERIOD,
          CLKOUT_PHASE_SHIFT    => UpperCase_String(C_CLKOUT_PHASE_SHIFT),
          DESKEW_ADJUST         => UpperCase_String(C_DESKEW_ADJUST),
          DFS_FREQUENCY_MODE    => UpperCase_String(C_DFS_FREQUENCY_MODE),
          DLL_FREQUENCY_MODE    => UpperCase_String(C_DLL_FREQUENCY_MODE),
          DUTY_CYCLE_CORRECTION => C_DUTY_CYCLE_CORRECTION,
          PHASE_SHIFT           => C_PHASE_SHIFT,
          STARTUP_WAIT          => C_STARTUP_WAIT,
          DSS_MODE              => UpperCase_String(C_DSS_MODE)
          )
        port map (
          CLKIN    => CLKIN_BUF,
          CLKFB    => CLKFB_BUF,
          RST      => rsti,
          PSEN     => PSEN,
          PSINCDEC => PSINCDEC,
          PSCLK    => PSCLK,
          DSSEN    => DSSEN,
          CLK0     => CLK0_BUF,
          CLK90    => CLK90_BUF,
          CLK180   => CLK180_BUF,
          CLK270   => CLK270_BUF,
          CLKDV    => CLKDV_BUF,
          CLK2X    => CLK2X_BUF,
          CLK2X180 => CLK2X180_BUF,
          CLKFX    => CLKFX_BUF,
          CLKFX180 => CLKFX180_BUF,
          STATUS   => STATUS,
          LOCKED   => LOCKED,
          PSDONE   => PSDONE
          );
  end generate Using_Virtex;

  -- This is needed to work around an XST bug with DCM in V4
  -- with structural simulation
  Using_DCM_ADV : if (Virtex4_Based or Virtex5_Based) generate
      DCM_ADV_INST : DCM_ADV
        generic map (
          CLK_FEEDBACK          => UpperCase_String(C_CLK_FEEDBACK),
          CLKDV_DIVIDE          => C_CLKDV_DIVIDE,
          CLKFX_DIVIDE          => C_CLKFX_DIVIDE,
          CLKFX_MULTIPLY        => C_CLKFX_MULTIPLY,
          CLKIN_DIVIDE_BY_2     => C_CLKIN_DIVIDE_BY_2,
          CLKIN_PERIOD          => C_CLKIN_PERIOD,
          CLKOUT_PHASE_SHIFT    => UpperCase_String(C_CLKOUT_PHASE_SHIFT),
          DESKEW_ADJUST         => UpperCase_String(C_DESKEW_ADJUST),
          DFS_FREQUENCY_MODE    => UpperCase_String(C_DFS_FREQUENCY_MODE),
          DLL_FREQUENCY_MODE    => UpperCase_String(C_DLL_FREQUENCY_MODE),
          DUTY_CYCLE_CORRECTION => C_DUTY_CYCLE_CORRECTION,
          FACTORY_JF            => FACTORY_JF_SETTING,
          PHASE_SHIFT           => C_PHASE_SHIFT,
          STARTUP_WAIT          => C_STARTUP_WAIT
          )
        port map (
          CLKIN    => CLKIN_BUF,          -- in std_ulogic
          CLKFB    => CLKFB_BUF,          -- in std_ulogic
          RST      => rsti,               -- in std_ulogic
          PSEN     => PSEN,               -- in std_ulogic
          PSINCDEC => PSINCDEC,           -- in std_ulogic
          PSCLK    => PSCLK,              -- in std_ulogic
          CLK0     => CLK0_BUF,           -- out std_ulogic
          CLK90    => CLK90_BUF,          -- out std_ulogic
          CLK180   => CLK180_BUF,         -- out std_ulogic
          CLK270   => CLK270_BUF,         -- out std_ulogic
          CLKDV    => CLKDV_BUF,          -- out std_ulogic
          CLK2X    => CLK2X_BUF,          -- out std_ulogic
          CLK2X180 => CLK2X180_BUF,       -- out std_ulogic
          CLKFX    => CLKFX_BUF,          -- out std_ulogic
          CLKFX180 => CLKFX180_BUF,       -- out std_ulogic
          LOCKED   => LOCKED,             -- out std_ulogic
          PSDONE   => PSDONE,             -- out std_ulogic

          -- Unused
          DADDR    => "0000000",          -- in std_logic_vector(6 downto 0)
          DCLK     => '0',                -- in std_ulogic
          DEN      => '0',                -- in std_ulogic
          DI       => "0000000000000000", -- in std_logic_vector(16 downto 0)
          DWE      => '0',                -- in std_ulogic
          DO       => open,             -- out std_logic_vector(15 downto 0)
          DRDY     => open              -- out std_ulogic
          );

    -- DCM_ADV does not have STATUS
    STATUS <= "00000000";

  end generate Using_DCM_ADV;

  -----------------------------------------------------------------------------
  -- Clkin
  -----------------------------------------------------------------------------
  Using_BUGF_for_CLKIN : if (C_CLKIN_BUF) generate

    CLKIN_BUFG_INST : BUFG
      port map (
        I => CLKIN,
        O => CLKIN_BUF);
  end generate Using_BUGF_for_CLKIN;

  No_BUFG_for_CLKIN : if (not C_CLKIN_BUF) generate
    CLKIN_BUF <= CLKIN;
  end generate No_BUFG_for_CLKIN;

  -----------------------------------------------------------------------------
  -- Clkfb
  -----------------------------------------------------------------------------
  Using_BUGF_for_CLKFB : if (C_CLKFB_BUF) generate

    CLKFB_BUFG_INST : BUFG
      port map (
        I => CLKFB,
        O => CLKFB_BUF);
  end generate Using_BUGF_for_CLKFB;

  No_BUFG_for_CLKFB : if (not C_CLKFB_BUF) generate
    CLKFB_BUF <= CLKFB;
  end generate No_BUFG_for_CLKFB;

  -----------------------------------------------------------------------------
  -- Clk0
  -----------------------------------------------------------------------------
  Using_BUGF_for_CLK0 : if (C_CLK0_BUF) generate

    CLK0_BUFG_INST : BUFG
      port map (
        I => CLK0_BUF,
        O => CLK0);
  end generate Using_BUGF_for_CLK0;

  No_BUFG_for_CLK0 : if (not C_CLK0_BUF) generate
    CLK0 <= CLK0_BUF;
  end generate No_BUFG_for_CLK0;

  -----------------------------------------------------------------------------
  -- Clk90
  -----------------------------------------------------------------------------
  Using_BUGF_for_CLK90 : if (C_CLK90_BUF) generate

    CLK90_BUFG_INST : BUFG
      port map (
        I => CLK90_BUF,
        O => CLK90);
  end generate Using_BUGF_for_CLK90;

  No_BUFG_for_CLK90 : if (not C_CLK90_BUF) generate
    CLK90 <= CLK90_BUF;
  end generate No_BUFG_for_CLK90;

  -----------------------------------------------------------------------------
  -- Clk180
  -----------------------------------------------------------------------------
  Using_BUGF_for_CLK180 : if (C_CLK180_BUF) generate

    CLK180_BUFG_INST : BUFG
      port map (
        I => CLK180_BUF,
        O => CLK180);
  end generate Using_BUGF_for_CLK180;

  No_BUFG_for_CLK180 : if (not C_CLK180_BUF) generate
    CLK180 <= CLK180_BUF;
  end generate No_BUFG_for_CLK180;

  -----------------------------------------------------------------------------
  -- Clk270
  -----------------------------------------------------------------------------
  Using_BUGF_for_CLK270 : if (C_CLK270_BUF) generate

    CLK270_BUFG_INST : BUFG
      port map (
        I => CLK270_BUF,
        O => CLK270);
  end generate Using_BUGF_for_CLK270;

  No_BUFG_for_CLK270 : if (not C_CLK270_BUF) generate
    CLK270 <= CLK270_BUF;
  end generate No_BUFG_for_CLK270;


  -----------------------------------------------------------------------------
  -- Clkdv
  -----------------------------------------------------------------------------
  Using_BUGF_for_CLKDV : if (C_CLKDV_BUF) generate

    CLKDV_BUFG_INST : BUFG
      port map (
        I => CLKDV_BUF,
        O => CLKDV);
  end generate Using_BUGF_for_CLKDV;

  No_BUFG_for_CLKDV : if (not C_CLKDV_BUF) generate
    CLKDV <= CLKDV_BUF;
  end generate No_BUFG_for_CLKDV;


  -----------------------------------------------------------------------------
  -- Clk2x
  -----------------------------------------------------------------------------
  Using_BUGF_for_CLK2X : if (C_CLK2X_BUF) generate

    CLK2X_BUFG_INST : BUFG
      port map (
        I => CLK2X_BUF,
        O => CLK2X);
  end generate Using_BUGF_for_CLK2X;

  No_BUFG_for_CLK2X : if (not C_CLK2X_BUF) generate
    CLK2X <= CLK2X_BUF;
  end generate No_BUFG_for_CLK2X;


  -----------------------------------------------------------------------------
  -- Clk2x180
  -----------------------------------------------------------------------------
  Using_BUGF_for_CLK2X180 : if (C_CLK2X180_BUF) generate

    CLK2X180_BUFG_INST : BUFG
      port map (
        I => CLK2X180_BUF,
        O => CLK2X180);
  end generate Using_BUGF_for_CLK2X180;

  No_BUFG_for_CLK2X180 : if (not C_CLK2X180_BUF) generate
    CLK2X180 <= CLK2X180_BUF;
  end generate No_BUFG_for_CLK2X180;


  -----------------------------------------------------------------------------
  -- Clkfx
  -----------------------------------------------------------------------------
  Using_BUGF_for_CLKFX : if (C_CLKFX_BUF) generate

    CLKFX_BUFG_INST : BUFG
      port map (
        I => CLKFX_BUF,
        O => CLKFX);
  end generate Using_BUGF_for_CLKFX;

  No_BUFG_for_CLKFX : if (not C_CLKFX_BUF) generate
    CLKFX <= CLKFX_BUF;
  end generate No_BUFG_for_CLKFX;


  -----------------------------------------------------------------------------
  -- Clkfx180
  -----------------------------------------------------------------------------
  Using_BUGF_for_CLKFX180 : if (C_CLKFX180_BUF) generate

    CLKFX180_BUFG_INST : BUFG
      port map (
        I => CLKFX180_BUF,
        O => CLKFX180);
  end generate Using_BUGF_for_CLKFX180;

  No_BUFG_for_CLKFX180 : if (not C_CLKFX180_BUF) generate
    CLKFX180 <= CLKFX180_BUF;
  end generate No_BUFG_for_CLKFX180;

end STRUCT;

-------------------------------------------------------------------------------
-- dcm module wrapper for clock generator
-------------------------------------------------------------------------------

