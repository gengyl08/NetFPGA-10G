-------------------------------------------------------------------------------
-- $Id: pll_module.vhd,v 1.1.2.8 2010/06/08 18:54:49 xic Exp $
-------------------------------------------------------------------------------
-- pll_module.vhd - Entity and architecture
--
--  ***************************************************************************
--  **  Copyright(C) 2007 by Xilinx, Inc. All rights reserved.               **
--  **                                                                       **
--  ***************************************************************************
--
-------------------------------------------------------------------------------
-- Filename:        pll_module.vhd
--
-- Description:     
--                  
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:   
--              pll_module.vhd
--
-------------------------------------------------------------------------------
-- Revision:        $Revision: 1.1.2.8 $
-- Date:            $Date: 2010/06/08 18:54:49 $
--
-- History:

--
-------------------------------------------------------------------------------
-- Naming Conventions:
-- active low signals: "*_n"
-- clock signals: "clk", "clk_div#", "clk_#x"
-- reset signals: "rst", "rst_n"
-- generics: "C_*"
-- user defined types: "*_TYPE"
-- state machine next state: "*_ns"
-- state machine current state: "*_cs"
-- combinatorial signals: "*_com"
-- pipelined or register delay signals: "*_d#"
-- counter signals: "*cnt*"
-- clock enable signals: "*_ce"
-- internal version of output port "*_i"
-- device pins: "*_pin"
-- ports: - Names begin with Uppercase
-- processes: "*_PROCESS"
-- component instantiations: "<ENTITY_>I_<#|FUNC>
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library Unisim;
use Unisim.vcomponents.all;

-------------------------------------------------------------------------------
-- pll module v1.00.a
-------------------------------------------------------------------------------

entity pll_module is
  generic (
    -- base pll_adv parameters
    C_BANDWIDTH             : string  := "OPTIMIZED";  -- "HIGH", "LOW" or "OPTIMIZED"
    C_CLKFBOUT_MULT         : integer := 1;  -- Multiplication factor for all output clocks
    C_CLKFBOUT_PHASE        : real    := 0.0;  -- Phase shift (degrees) of all output clocks
    C_CLKIN1_PERIOD         : real    := 0.000;  -- Clock period (ns) of input clock on CLKIN1
    -- C_CLKIN2_PERIOD         : real    := 0.000;  -- Clock period (ns) of input clock on CLKIN2
    C_CLKOUT0_DIVIDE        : integer := 1;  -- Division factor for CLKOUT0 (1 to 128)
    C_CLKOUT0_DUTY_CYCLE    : real    := 0.5;  -- Duty cycle for CLKOUT0 (0.01 to 0.99)
    C_CLKOUT0_PHASE         : real    := 0.0;  -- Phase shift (degrees) for CLKOUT0 (0.0 to 360.0)
    C_CLKOUT1_DIVIDE        : integer := 1;  -- Division factor for CLKOUT1 (1 to 128)
    C_CLKOUT1_DUTY_CYCLE    : real    := 0.5;  -- Duty cycle for CLKOUT1 (0.01 to 0.99)
    C_CLKOUT1_PHASE         : real    := 0.0;  -- Phase shift (degrees) for CLKOUT1 (0.0 to 360.0)
    C_CLKOUT2_DIVIDE        : integer := 1;  -- Division factor for CLKOUT2 (1 to 128)
    C_CLKOUT2_DUTY_CYCLE    : real    := 0.5;  -- Duty cycle for CLKOUT2 (0.01 to 0.99)
    C_CLKOUT2_PHASE         : real    := 0.0;  -- Phase shift (degrees) for CLKOUT2 (0.0 to 360.0)
    C_CLKOUT3_DIVIDE        : integer := 1;  -- Division factor for CLKOUT3 (1 to 128)
    C_CLKOUT3_DUTY_CYCLE    : real    := 0.5;  -- Duty cycle for CLKOUT3 (0.01 to 0.99)
    C_CLKOUT3_PHASE         : real    := 0.0;  -- Phase shift (degrees) for CLKOUT3 (0.0 to 360.0)
    C_CLKOUT4_DIVIDE        : integer := 1;  -- Division factor for CLKOUT4 (1 to 128)
    C_CLKOUT4_DUTY_CYCLE    : real    := 0.5;  -- Duty cycle for CLKOUT4 (0.01 to 0.99)
    C_CLKOUT4_PHASE         : real    := 0.0;  -- Phase shift (degrees) for CLKOUT4 (0.0 to 360.0)
    C_CLKOUT5_DIVIDE        : integer := 1;  -- Division factor for CLKOUT5 (1 to 128)
    C_CLKOUT5_DUTY_CYCLE    : real    := 0.5;  -- Duty cycle for CLKOUT5 (0.01 to 0.99)
    C_CLKOUT5_PHASE         : real    := 0.0;  -- Phase shift (degrees) for CLKOUT5 (0.0 to 360.0)
    C_COMPENSATION          : string  := "SYSTEM_SYNCHRONOUS";  -- "SYSTEM_SYNCHRNOUS", "SOURCE_SYNCHRNOUS", "
                                        -- INTERNAL", "EXTERNAL", "DCM2PLL", "PLL2DCM"
    C_DIVCLK_DIVIDE         : integer := 1;  -- Division factor for all clocks (1 to 52)
    -- C_EN_REL                : boolean := false;  -- Enable release (PMCD mode only)
    -- C_PLL_PMCD_MODE         : boolean := false;  -- PMCD Mode, TRUE/FASLE
    C_REF_JITTER            : real    := 0.100;  -- Input reference jitter (0.000 to 0.999 UI%)
    C_RESET_ON_LOSS_OF_LOCK : boolean := false;  -- Auto reset when LOCK is lost, TRUE/FALSE
    C_RST_DEASSERT_CLK      : string  := "CLKIN1";  -- In PMCD mode, clock to synchronize RST relea

    C_CLKOUT0_DESKEW_ADJUST : string  := "NONE";  -- "NONE" for PPC core and crossbar
                                        -- clocks,"PPC" for all others
    C_CLKOUT1_DESKEW_ADJUST : string  := "NONE";  
    C_CLKOUT2_DESKEW_ADJUST : string  := "PPC"; 
    C_CLKOUT3_DESKEW_ADJUST : string  := "PPC"; 
    C_CLKOUT4_DESKEW_ADJUST : string  := "PPC"; 
    C_CLKOUT5_DESKEW_ADJUST : string  := "PPC"; 
    C_CLKFBOUT_DESKEW_ADJUST : string  := "PPC"; 
    -- parameters for pcore
    C_CLKIN1_BUF            : boolean := false;
    -- C_CLKIN2_BUF          : boolean := false;
    C_CLKFBOUT_BUF          : boolean := false;
    C_CLKOUT0_BUF           : boolean := false;
    C_CLKOUT1_BUF           : boolean := false;
    C_CLKOUT2_BUF           : boolean := false;
    C_CLKOUT3_BUF           : boolean := false;
    C_CLKOUT4_BUF           : boolean := false;
    C_CLKOUT5_BUF           : boolean := false;

    C_EXT_RESET_HIGH :     integer := 1;
    C_FAMILY         :     string  := "virtex5"
    );
  port (
    CLKFBDCM         : out std_logic;
    CLKFBOUT         : out std_logic;
    CLKOUT0          : out std_logic;
    CLKOUT1          : out std_logic;
    CLKOUT2          : out std_logic;
    CLKOUT3          : out std_logic;
    CLKOUT4          : out std_logic;
    CLKOUT5          : out std_logic;
    CLKOUTDCM0       : out std_logic;
    CLKOUTDCM1       : out std_logic;
    CLKOUTDCM2       : out std_logic;
    CLKOUTDCM3       : out std_logic;
    CLKOUTDCM4       : out std_logic;
    CLKOUTDCM5       : out std_logic;
    -- DO               : out std_logic_vector (15 downto 0);
    -- DRDY             : out std_logic;
    LOCKED           : out std_logic;
    CLKFBIN          : in  std_logic;
    CLKIN1           : in  std_logic;
    -- CLKIN2           : in  std_logic;
    -- CLKINSEL         : in  std_logic;
    -- DADDR            : in  std_logic_vector (4 downto 0);
    -- DCLK             : in  std_logic;
    -- DEN              : in  std_logic;
    -- DI               : in  std_logic_vector (15 downto 0);
    -- DWE              : in  std_logic;
    -- REL              : in  std_logic;
    RST              : in  std_logic
    );
end pll_module;

architecture STRUCT of pll_module is

  signal rsti : std_logic;

  signal CLKIN1_BUF   : std_logic;
  signal CLKIN2_BUF   : std_logic;
  signal CLKFBOUT_BUF : std_logic;
  signal CLKOUT0_BUF  : std_logic;
  signal CLKOUT1_BUF  : std_logic;
  signal CLKOUT2_BUF  : std_logic;
  signal CLKOUT3_BUF  : std_logic;
  signal CLKOUT4_BUF  : std_logic;
  signal CLKOUT5_BUF  : std_logic;


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
    variable res               : string(s'range);
  begin  -- function LoweerCase_String
    for I in s'range loop
      res(I) := UpperCase_Char(s(I));
    end loop;  -- I
    return res;
  end function UpperCase_String;

  -- Returns true if case insensitive string comparison determines that
  -- str1 and str2 are equal
  function equalString( str1, str2 : string ) return boolean is
    constant len1                  : integer := str1'length;
    constant len2                  : integer := str2'length;
    variable equal                 : boolean := true;
  begin
    if not (len1 = len2) then
      equal                                  := false;
    else
      for i in str1'range loop
        if not (UpperCase_Char(str1(i)) = UpperCase_Char(str2(i))) then
          equal                              := false;
        end if;
      end loop;
    end if;

    return equal;
  end equalString;

  -- Must use equalString otherwise:
  -- "Size of operands are different : result is <false>"
  constant Virtex5_Based : boolean := equalString(C_FAMILY, "VIRTEX5") or equalString(C_FAMILY, "QVIRTEX5") or equalString(C_FAMILY, "QRVIRTEX5");
  constant Spartan6_Based : boolean := equalString(C_FAMILY, "SPARTAN6") or equalString(C_FAMILY, "SPARTAN6L") or equalString(C_FAMILY, "SPARTAN6T") or equalString(C_FAMILY, "ASPARTAN6") or equalString(C_FAMILY, "ASPARTAN6L") or equalString(C_FAMILY, "ASPARTAN6T") or equalString(C_FAMILY, "QSPARTAN6") or equalString(C_FAMILY, "QSPARTAN6L") or equalString(C_FAMILY, "QSPARTAN6T");


begin

  -----------------------------------------------------------------------------
  -- handle the reset
  -----------------------------------------------------------------------------
  Rst_is_Active_High : if (C_EXT_RESET_HIGH = 1) generate
    rsti <= RST;
  end generate Rst_is_Active_High;

  Rst_is_Active_Low : if (C_EXT_RESET_HIGH /= 1) generate
    rsti <= not RST;
  end generate Rst_is_Active_Low;




  Using_PLL_ADV  : if (Virtex5_Based or Spartan6_Based) generate
    PLL_ADV_inst : PLL_ADV
      generic map (
        BANDWIDTH             => UpperCase_String(C_BANDWIDTH),
        CLKFBOUT_MULT         => C_CLKFBOUT_MULT,
        CLKFBOUT_PHASE        => C_CLKFBOUT_PHASE,
        CLKIN1_PERIOD         => C_CLKIN1_PERIOD,
        CLKIN2_PERIOD         => C_CLKIN1_PERIOD,
        CLKOUT0_DIVIDE        => C_CLKOUT0_DIVIDE,
        CLKOUT0_DUTY_CYCLE    => C_CLKOUT0_DUTY_CYCLE,
        CLKOUT0_PHASE         => C_CLKOUT0_PHASE,
        CLKOUT1_DIVIDE        => C_CLKOUT1_DIVIDE,
        CLKOUT1_DUTY_CYCLE    => C_CLKOUT1_DUTY_CYCLE,
        CLKOUT1_PHASE         => C_CLKOUT1_PHASE,
        CLKOUT2_DIVIDE        => C_CLKOUT2_DIVIDE,
        CLKOUT2_DUTY_CYCLE    => C_CLKOUT2_DUTY_CYCLE,
        CLKOUT2_PHASE         => C_CLKOUT2_PHASE,
        CLKOUT3_DIVIDE        => C_CLKOUT3_DIVIDE,
        CLKOUT3_DUTY_CYCLE    => C_CLKOUT3_DUTY_CYCLE,
        CLKOUT3_PHASE         => C_CLKOUT3_PHASE,
        CLKOUT4_DIVIDE        => C_CLKOUT4_DIVIDE,
        CLKOUT4_DUTY_CYCLE    => C_CLKOUT4_DUTY_CYCLE,
        CLKOUT4_PHASE         => C_CLKOUT4_PHASE,
        CLKOUT5_DIVIDE        => C_CLKOUT5_DIVIDE,
        CLKOUT5_DUTY_CYCLE    => C_CLKOUT5_DUTY_CYCLE,
        CLKOUT5_PHASE         => C_CLKOUT5_PHASE,
        COMPENSATION          => UpperCase_String(C_COMPENSATION),
        DIVCLK_DIVIDE         => C_DIVCLK_DIVIDE,
        EN_REL                => false,
        PLL_PMCD_MODE         => false,
        REF_JITTER            => C_REF_JITTER,
        RESET_ON_LOSS_OF_LOCK => C_RESET_ON_LOSS_OF_LOCK,
        RST_DEASSERT_CLK      => UpperCase_String(C_RST_DEASSERT_CLK),
        CLKOUT0_DESKEW_ADJUST => UpperCase_String(C_CLKOUT0_DESKEW_ADJUST),
        CLKOUT1_DESKEW_ADJUST => UpperCase_String(C_CLKOUT1_DESKEW_ADJUST),
        CLKOUT2_DESKEW_ADJUST => UpperCase_String(C_CLKOUT2_DESKEW_ADJUST),
        CLKOUT3_DESKEW_ADJUST => UpperCase_String(C_CLKOUT3_DESKEW_ADJUST),
        CLKOUT4_DESKEW_ADJUST => UpperCase_String(C_CLKOUT4_DESKEW_ADJUST),
        CLKOUT5_DESKEW_ADJUST => UpperCase_String(C_CLKOUT5_DESKEW_ADJUST),
        CLKFBOUT_DESKEW_ADJUST => UpperCase_String(C_CLKFBOUT_DESKEW_ADJUST)
        )
      port map (
        CLKFBDCM              => CLKFBDCM,
        CLKFBOUT              => CLKFBOUT_BUF,
        CLKOUT0               => CLKOUT0_BUF,
        CLKOUT1               => CLKOUT1_BUF,
        CLKOUT2               => CLKOUT2_BUF,
        CLKOUT3               => CLKOUT3_BUF,
        CLKOUT4               => CLKOUT4_BUF,
        CLKOUT5               => CLKOUT5_BUF,
        CLKOUTDCM0            => CLKOUTDCM0,
        CLKOUTDCM1            => CLKOUTDCM1,
        CLKOUTDCM2            => CLKOUTDCM2,
        CLKOUTDCM3            => CLKOUTDCM3,
        CLKOUTDCM4            => CLKOUTDCM4,
        CLKOUTDCM5            => CLKOUTDCM5,
        DO                    => open,
        DRDY                  => open,
        LOCKED                => LOCKED,
        CLKFBIN               => CLKFBIN,
        CLKIN1                => CLKIN1_BUF,
        CLKIN2                => '0', 
        CLKINSEL              => '1', -- 1 selects CLKIN1, and 0 selects CLKIN2
        DADDR                 => "00000",
        DCLK                  => '0',
        DEN                   => '0',
        DI                    => "0000000000000000",
        DWE                   => '0',
        REL                   => '0',
        RST                   => rsti    -- Asynchronous PLL reset
        );
  end generate Using_PLL_ADV;

  -----------------------------------------------------------------------------
  -- Clkin1 and Clkin2
  -----------------------------------------------------------------------------
  Using_BUFG_for_CLKIN1 : if (C_CLKIN1_BUF) generate
    CLKIN1_BUFG_INST    : BUFG
      port map (
        I => CLKIN1,
        O => CLKIN1_BUF);
  end generate Using_BUFG_for_CLKIN1;

  No_BUFG_for_CLKIN1 : if (not C_CLKIN1_BUF) generate
    CLKIN1_BUF <= CLKIN1;
  end generate No_BUFG_for_CLKIN1;

-- Using_BUFG_for_CLKIN2 : if (C_CLKIN2_BUF) generate
-- CLKIN2_BUFG_INST : BUFG
-- port map (
-- I => CLKIN2,
-- O => CLKIN2_BUF);
-- end generate Using_BUFG_for_CLKIN2;
--
-- No_BUFG_for_CLKIN2 : if (not C_CLKIN2_BUF) generate
-- CLKIN2_BUF <= CLKIN2;
-- end generate No_BUFG_for_CLKIN2;

  -----------------------------------------------------------------------------
  -- Clkfb
  -----------------------------------------------------------------------------
  Using_BUFG_for_CLKFBOUT : if (C_CLKFBOUT_BUF) generate
    CLKFB_BUFG_INST       : BUFG
      port map (
        I => CLKFBOUT_BUF,
        O => CLKFBOUT);
  end generate Using_BUFG_for_CLKFBOUT;

  No_BUFG_for_CLKFBOUT : if (not C_CLKFBOUT_BUF) generate
    CLKFBOUT <= CLKFBOUT_BUF;
  end generate No_BUFG_for_CLKFBOUT;

  -----------------------------------------------------------------------------
  -- ClkOut0
  -----------------------------------------------------------------------------
  Using_BUFG_for_CLKOUT0 : if (C_CLKOUT0_BUF) generate

    CLKOUT0_BUFG_INST : BUFG
      port map (
        I => CLKOUT0_BUF,
        O => CLKOUT0);
  end generate Using_BUFG_for_CLKOUT0;

  No_BUFG_for_CLKOUT0 : if (not C_CLKOUT0_BUF) generate
    CLKOUT0 <= CLKOUT0_BUF;
  end generate No_BUFG_for_CLKOUT0;

  -----------------------------------------------------------------------------
  -- ClkOut1
  -----------------------------------------------------------------------------
  Using_BUFG_for_CLKOUT1 : if (C_CLKOUT1_BUF) generate

    CLKOUT1_BUFG_INST : BUFG
      port map (
        I => CLKOUT1_BUF,
        O => CLKOUT1);
  end generate Using_BUFG_for_CLKOUT1;

  No_BUFG_for_CLKOUT1 : if (not C_CLKOUT1_BUF) generate
    CLKOUT1 <= CLKOUT1_BUF;
  end generate No_BUFG_for_CLKOUT1;

  -----------------------------------------------------------------------------
  -- ClkOut2
  -----------------------------------------------------------------------------
  Using_BUFG_for_CLKOUT2 : if (C_CLKOUT2_BUF) generate

    CLKOUT2_BUFG_INST : BUFG
      port map (
        I => CLKOUT2_BUF,
        O => CLKOUT2);
  end generate Using_BUFG_for_CLKOUT2;

  No_BUFG_for_CLKOUT2 : if (not C_CLKOUT2_BUF) generate
    CLKOUT2 <= CLKOUT2_BUF;
  end generate No_BUFG_for_CLKOUT2;

  -----------------------------------------------------------------------------
  -- ClkOut3
  -----------------------------------------------------------------------------
  Using_BUFG_for_CLKOUT3 : if (C_CLKOUT3_BUF) generate

    CLKOUT3_BUFG_INST : BUFG
      port map (
        I => CLKOUT3_BUF,
        O => CLKOUT3);
  end generate Using_BUFG_for_CLKOUT3;

  No_BUFG_for_CLKOUT3    : if (not C_CLKOUT3_BUF) generate
    CLKOUT3 <= CLKOUT3_BUF;
  end generate No_BUFG_for_CLKOUT3;
  -----------------------------------------------------------------------------
  -- ClkOut4
  -----------------------------------------------------------------------------
  Using_BUFG_for_CLKOUT4 : if (C_CLKOUT4_BUF) generate

    CLKOUT4_BUFG_INST : BUFG
      port map (
        I => CLKOUT4_BUF,
        O => CLKOUT4);
  end generate Using_BUFG_for_CLKOUT4;

  No_BUFG_for_CLKOUT4 : if (not C_CLKOUT4_BUF) generate
    CLKOUT4 <= CLKOUT4_BUF;
  end generate No_BUFG_for_CLKOUT4;

  -----------------------------------------------------------------------------
  -- ClkOut5
  -----------------------------------------------------------------------------
  Using_BUFG_for_CLKOUT5 : if (C_CLKOUT5_BUF) generate

    CLKOUT5_BUFG_INST : BUFG
      port map (
        I => CLKOUT5_BUF,
        O => CLKOUT5);
  end generate Using_BUFG_for_CLKOUT5;

  No_BUFG_for_CLKOUT5 : if (not C_CLKOUT5_BUF) generate
    CLKOUT5 <= CLKOUT5_BUF;
  end generate No_BUFG_for_CLKOUT5;

end STRUCT;

-------------------------------------------------------------------------------
-- dcm module wrapper for clock generator
-------------------------------------------------------------------------------

