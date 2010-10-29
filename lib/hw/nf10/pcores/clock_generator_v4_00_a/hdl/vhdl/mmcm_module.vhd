-------------------------------------------------------------------------------
-- $Id: mmcm_module.vhd,v 1.1.2.4 2010/01/04 20:00:18 xic Exp $
-------------------------------------------------------------------------------
-- mmcm_module.vhd - Entity and architecture
--
--  ***************************************************************************
--  **  Copyright(C) 2009 by Xilinx, Inc. All rights reserved.               **
--  **                                                                       **
--  ***************************************************************************
--
-------------------------------------------------------------------------------
-- Filename:        mmcm_module.vhd
--
-- Description:     
--                  
-- VHDL-Standard:   VHDL'93
-------------------------------------------------------------------------------
-- Structure:   
--              mmcm_module.vhd
--
-------------------------------------------------------------------------------
-- Revision:        $Revision: 1.1.2.4 $
-- Date:            $Date: 2010/01/04 20:00:18 $
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

entity mmcm_module is
  generic (
    -- base pll_adv parameters
    C_BANDWIDTH             : string  := "OPTIMIZED"; 
    C_CLKFBOUT_MULT_F       : real := 1.0;  -- Multiplication factor for all output clocks
    C_CLKFBOUT_PHASE        : real    := 0.0;  -- Phase shift (degrees) of all output clocks
    C_CLKFBOUT_USE_FINE_PS  : boolean := false;
    C_CLKIN1_PERIOD         : real    := 0.000;  -- Clock period (ns) of input clock on CLKIN1
    C_CLKOUT0_DIVIDE_F      : real := 1.0;  -- Division factor for CLKOUT0
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
    C_CLKOUT4_CASCADE       : boolean := false;
    C_CLKOUT5_DIVIDE        : integer := 1;  -- Division factor for CLKOUT5 (1 to 128)
    C_CLKOUT5_DUTY_CYCLE    : real    := 0.5;  -- Duty cycle for CLKOUT5 (0.01 to 0.99)
    C_CLKOUT5_PHASE         : real    := 0.0;  -- Phase shift (degrees) for CLKOUT5 (0.0 to 360.0)
    C_CLKOUT6_DIVIDE        : integer := 1;  -- Division factor for CLKOUT5 (1 to 128)
    C_CLKOUT6_DUTY_CYCLE    : real    := 0.5;  -- Duty cycle for CLKOUT5 (0.01 to 0.99)
    C_CLKOUT6_PHASE         : real    := 0.0;  -- Phase shift (degrees) for CLKOUT5 (0.0 to 360.0)
    C_CLKOUT0_USE_FINE_PS   : boolean := false;
    C_CLKOUT1_USE_FINE_PS   : boolean := false;
    C_CLKOUT2_USE_FINE_PS   : boolean := false;
    C_CLKOUT3_USE_FINE_PS   : boolean := false;
    C_CLKOUT4_USE_FINE_PS   : boolean := false;
    C_CLKOUT5_USE_FINE_PS   : boolean := false;
    C_CLKOUT6_USE_FINE_PS   : boolean := false;
    C_COMPENSATION          : string  := "ZHOLD";  
    C_DIVCLK_DIVIDE         : integer := 1;  -- Division factor for all clocks (1 to 52)
    C_REF_JITTER1           : real    := 0.010;  -- Input reference jitter
    C_CLKIN1_BUF            : boolean := false;
    C_CLKFBOUT_BUF          : boolean := false;
    C_CLKOUT0_BUF           : boolean := false;
    C_CLKOUT1_BUF           : boolean := false;
    C_CLKOUT2_BUF           : boolean := false;
    C_CLKOUT3_BUF           : boolean := false;
    C_CLKOUT4_BUF           : boolean := false;
    C_CLKOUT5_BUF           : boolean := false;
    C_CLKOUT6_BUF           : boolean := false;
    C_CLOCK_HOLD            : boolean := false;
    C_STARTUP_WAIT          : boolean := false;
    C_EXT_RESET_HIGH        : integer := 1;
    C_FAMILY                : string  := "virtex6"
    );
  port (
    CLKFBOUT         : out std_logic;
    CLKFBOUTB        : out std_logic;
    CLKOUT0          : out std_logic;
    CLKOUT1          : out std_logic;
    CLKOUT2          : out std_logic;
    CLKOUT3          : out std_logic;
    CLKOUT4          : out std_logic;
    CLKOUT5          : out std_logic;
    CLKOUT6          : out std_logic;
    CLKOUT0B         : out std_logic;
    CLKOUT1B         : out std_logic;
    CLKOUT2B         : out std_logic;
    CLKOUT3B         : out std_logic;
    LOCKED           : out std_logic;
    CLKFBSTOPPED     : out std_logic;
    CLKINSTOPPED     : out std_logic;
    PSDONE           : out std_logic;
    CLKFBIN          : in  std_logic;
    CLKIN1           : in  std_logic;
    PWRDWN           : in  std_logic;
    PSCLK            : in  std_logic;
    PSEN             : in  std_logic;
    PSINCDEC         : in  std_logic;
    RST              : in  std_logic
    );
end mmcm_module;

architecture STRUCT of mmcm_module is

  signal rsti : std_logic;
  signal CLKIN1_BUF   : std_logic;
  signal CLKFBOUT_BUF : std_logic;
  signal CLKFBOUTB_BUF : std_logic;
  signal CLKOUT0_BUF  : std_logic;
  signal CLKOUT1_BUF  : std_logic;
  signal CLKOUT2_BUF  : std_logic;
  signal CLKOUT3_BUF  : std_logic;
  signal CLKOUT4_BUF  : std_logic;
  signal CLKOUT5_BUF  : std_logic;
  signal CLKOUT6_BUF  : std_logic;
  signal CLKOUT0B_BUF  : std_logic;
  signal CLKOUT1B_BUF  : std_logic;
  signal CLKOUT2B_BUF  : std_logic;
  signal CLKOUT3B_BUF  : std_logic;

----- component MMCM_ADV -----
  component MMCM_ADV
    generic (
       BANDWIDTH : string := "OPTIMIZED";
       CLKFBOUT_MULT_F : real := 1.0;
       CLKFBOUT_PHASE : real := 0.0;
       CLKFBOUT_USE_FINE_PS : boolean := FALSE;
       CLKIN1_PERIOD : real := 0.0;
       CLKIN2_PERIOD : real := 0.0;
       CLKOUT0_DIVIDE_F : real := 1.0;
       CLKOUT0_DUTY_CYCLE : real := 0.5;
       CLKOUT0_PHASE : real := 0.0;
       CLKOUT0_USE_FINE_PS : boolean := FALSE;
       CLKOUT1_DIVIDE : integer := 1;
       CLKOUT1_DUTY_CYCLE : real := 0.5;
       CLKOUT1_PHASE : real := 0.0;
       CLKOUT1_USE_FINE_PS : boolean := FALSE;
       CLKOUT2_DIVIDE : integer := 1;
       CLKOUT2_DUTY_CYCLE : real := 0.5;
       CLKOUT2_PHASE : real := 0.0;
       CLKOUT2_USE_FINE_PS : boolean := FALSE;
       CLKOUT3_DIVIDE : integer := 1;
       CLKOUT3_DUTY_CYCLE : real := 0.5;
       CLKOUT3_PHASE : real := 0.0;
       CLKOUT3_USE_FINE_PS : boolean := FALSE;
       CLKOUT4_CASCADE : boolean := FALSE;
       CLKOUT4_DIVIDE : integer := 1;
       CLKOUT4_DUTY_CYCLE : real := 0.5;
       CLKOUT4_PHASE : real := 0.0;
       CLKOUT4_USE_FINE_PS : boolean := FALSE;
       CLKOUT5_DIVIDE : integer := 1;
       CLKOUT5_DUTY_CYCLE : real := 0.5;
       CLKOUT5_PHASE : real := 0.0;
       CLKOUT5_USE_FINE_PS : boolean := FALSE;
       CLKOUT6_DIVIDE : integer := 1;
       CLKOUT6_DUTY_CYCLE : real := 0.5;
       CLKOUT6_PHASE : real := 0.0;
       CLKOUT6_USE_FINE_PS : boolean := FALSE;
       CLOCK_HOLD : boolean := FALSE;
       COMPENSATION : string := "ZHOLD";
       DIVCLK_DIVIDE : integer := 1;
       REF_JITTER1 : real := 0.0;
       REF_JITTER2 : real := 0.0;
       STARTUP_WAIT : boolean := FALSE
    );
    port (
       CLKFBOUT : out std_ulogic := '0';
       CLKFBOUTB : out std_ulogic := '0';
       CLKFBSTOPPED : out std_ulogic := '0';
       CLKINSTOPPED : out std_ulogic := '0';
       CLKOUT0 : out std_ulogic := '0';
       CLKOUT0B : out std_ulogic := '0';
       CLKOUT1 : out std_ulogic := '0';
       CLKOUT1B : out std_ulogic := '0';
       CLKOUT2 : out std_ulogic := '0';
       CLKOUT2B : out std_ulogic := '0';
       CLKOUT3 : out std_ulogic := '0';
       CLKOUT3B : out std_ulogic := '0';
       CLKOUT4 : out std_ulogic := '0';
       CLKOUT5 : out std_ulogic := '0';
       CLKOUT6 : out std_ulogic := '0';
       DO : out std_logic_vector (15 downto 0);
       DRDY : out std_ulogic := '0';
       LOCKED : out std_ulogic := '0';
       PSDONE : out std_ulogic := '0';
       CLKFBIN : in std_ulogic;
       CLKIN1 : in std_ulogic;
       CLKIN2 : in std_ulogic;
       CLKINSEL : in std_ulogic;
       DADDR : in std_logic_vector(6 downto 0);
       DCLK : in std_ulogic;
       DEN : in std_ulogic;
       DI : in std_logic_vector(15 downto 0);
       DWE : in std_ulogic;
       PSCLK : in std_ulogic;
       PSEN : in std_ulogic;
       PSINCDEC : in std_ulogic;
       PWRDWN : in std_ulogic;
       RST : in std_ulogic
    );
  end component;

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
  begin 
    for I in s'range loop
      res(I) := UpperCase_Char(s(I));
    end loop;  -- I
    return res;
  end function UpperCase_String;

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

    MMCM_ADV_inst : MMCM_ADV
      generic map (
        BANDWIDTH             => UpperCase_String(C_BANDWIDTH),
        CLKFBOUT_MULT_F         => C_CLKFBOUT_MULT_F,
        CLKFBOUT_PHASE        => C_CLKFBOUT_PHASE,
        CLKFBOUT_USE_FINE_PS => C_CLKFBOUT_USE_FINE_PS,
        CLKIN1_PERIOD         => C_CLKIN1_PERIOD,
        CLKIN2_PERIOD         => C_CLKIN1_PERIOD,
        CLKOUT0_DIVIDE_F        => C_CLKOUT0_DIVIDE_F,
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
        CLKOUT4_CASCADE => C_CLKOUT4_CASCADE,
        CLKOUT5_DIVIDE        => C_CLKOUT5_DIVIDE,
        CLKOUT5_DUTY_CYCLE    => C_CLKOUT5_DUTY_CYCLE,
        CLKOUT5_PHASE         => C_CLKOUT5_PHASE,
        CLKOUT6_DIVIDE        => C_CLKOUT6_DIVIDE,
        CLKOUT6_DUTY_CYCLE    => C_CLKOUT6_DUTY_CYCLE,
        CLKOUT6_PHASE         => C_CLKOUT6_PHASE,
        CLKOUT0_USE_FINE_PS => C_CLKOUT0_USE_FINE_PS,
        CLKOUT1_USE_FINE_PS => C_CLKOUT1_USE_FINE_PS,
        CLKOUT2_USE_FINE_PS => C_CLKOUT2_USE_FINE_PS,
        CLKOUT3_USE_FINE_PS => C_CLKOUT3_USE_FINE_PS,
        CLKOUT4_USE_FINE_PS => C_CLKOUT4_USE_FINE_PS,
        CLKOUT5_USE_FINE_PS => C_CLKOUT5_USE_FINE_PS,
        CLKOUT6_USE_FINE_PS => C_CLKOUT6_USE_FINE_PS,
        COMPENSATION          => UpperCase_String(C_COMPENSATION),
        DIVCLK_DIVIDE         => C_DIVCLK_DIVIDE,
        REF_JITTER1            => C_REF_JITTER1,
        REF_JITTER2            => C_REF_JITTER1,
        CLOCK_HOLD => C_CLOCK_HOLD,
        STARTUP_WAIT => C_STARTUP_WAIT
        )
      port map (
        CLKFBOUT              => CLKFBOUT_BUF,
        CLKFBOUTB              => CLKFBOUTB_BUF,
        CLKOUT0               => CLKOUT0_BUF,
        CLKOUT1               => CLKOUT1_BUF,
        CLKOUT2               => CLKOUT2_BUF,
        CLKOUT3               => CLKOUT3_BUF,
        CLKOUT4               => CLKOUT4_BUF,
        CLKOUT5               => CLKOUT5_BUF,
        CLKOUT6               => CLKOUT6_BUF,
        CLKOUT0B               => CLKOUT0B_BUF,
        CLKOUT1B               => CLKOUT1B_BUF,
        CLKOUT2B               => CLKOUT2B_BUF,
        CLKOUT3B               => CLKOUT3B_BUF,
        LOCKED                => LOCKED,
        CLKFBSTOPPED => CLKFBSTOPPED,
        CLKINSTOPPED => CLKINSTOPPED,
        PSDONE => PSDONE,
        CLKFBIN               => CLKFBIN,
        CLKIN1                => CLKIN1_BUF,
        CLKIN2                => '0', 
        CLKINSEL              => '1', -- selects CLKIN1
        PWRDWN => PWRDWN,
        PSCLK => PSCLK,
        PSEN => PSEN,
        PSINCDEC => PSINCDEC,
        DADDR                 => "0000000",
        DCLK                  => '0',
        DEN                   => '0',
        DI                    => "0000000000000000",
        DWE                   => '0',
        RST                   => rsti    -- Asynchronous PLL reset
        );

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

  -----------------------------------------------------------------------------
  -- Clkfb
  -----------------------------------------------------------------------------
  Using_BUFG_for_CLKFBOUT : if (C_CLKFBOUT_BUF) generate
    CLKFBOUT_BUFG_INST       : BUFG
      port map (
        I => CLKFBOUT_BUF,
        O => CLKFBOUT);
    CLKFBOUTB_BUFG_INST       : BUFG
      port map (
        I => CLKFBOUTB_BUF,
        O => CLKFBOUTB);
  end generate Using_BUFG_for_CLKFBOUT;

  No_BUFG_for_CLKFBOUT : if (not C_CLKFBOUT_BUF) generate
    CLKFBOUT <= CLKFBOUT_BUF;
    CLKFBOUTB <= CLKFBOUTB_BUF;
  end generate No_BUFG_for_CLKFBOUT;

  -----------------------------------------------------------------------------
  -- ClkOut0
  -----------------------------------------------------------------------------
  Using_BUFG_for_CLKOUT0 : if (C_CLKOUT0_BUF) generate

    CLKOUT0_BUFG_INST : BUFG
      port map (
        I => CLKOUT0_BUF,
        O => CLKOUT0);
    CLKOUT0B_BUFG_INST : BUFG
      port map (
        I => CLKOUT0B_BUF,
        O => CLKOUT0B);
  end generate Using_BUFG_for_CLKOUT0;

  No_BUFG_for_CLKOUT0 : if (not C_CLKOUT0_BUF) generate
    CLKOUT0 <= CLKOUT0_BUF;
    CLKOUT0B <= CLKOUT0B_BUF;
  end generate No_BUFG_for_CLKOUT0;

  -----------------------------------------------------------------------------
  -- ClkOut1
  -----------------------------------------------------------------------------
  Using_BUFG_for_CLKOUT1 : if (C_CLKOUT1_BUF) generate

    CLKOUT1_BUFG_INST : BUFG
      port map (
        I => CLKOUT1_BUF,
        O => CLKOUT1);
    CLKOUT1B_BUFG_INST : BUFG
      port map (
        I => CLKOUT1B_BUF,
        O => CLKOUT1B);
  end generate Using_BUFG_for_CLKOUT1;

  No_BUFG_for_CLKOUT1 : if (not C_CLKOUT1_BUF) generate
    CLKOUT1 <= CLKOUT1_BUF;
    CLKOUT1B <= CLKOUT1B_BUF;
  end generate No_BUFG_for_CLKOUT1;

  -----------------------------------------------------------------------------
  -- ClkOut2
  -----------------------------------------------------------------------------
  Using_BUFG_for_CLKOUT2 : if (C_CLKOUT2_BUF) generate

    CLKOUT2_BUFG_INST : BUFG
      port map (
        I => CLKOUT2_BUF,
        O => CLKOUT2);
    CLKOUT2B_BUFG_INST : BUFG
      port map (
        I => CLKOUT2B_BUF,
        O => CLKOUT2B);
  end generate Using_BUFG_for_CLKOUT2;

  No_BUFG_for_CLKOUT2 : if (not C_CLKOUT2_BUF) generate
    CLKOUT2 <= CLKOUT2_BUF;
    CLKOUT2B <= CLKOUT2B_BUF;
  end generate No_BUFG_for_CLKOUT2;

  -----------------------------------------------------------------------------
  -- ClkOut3
  -----------------------------------------------------------------------------
  Using_BUFG_for_CLKOUT3 : if (C_CLKOUT3_BUF) generate

    CLKOUT3_BUFG_INST : BUFG
      port map (
        I => CLKOUT3_BUF,
        O => CLKOUT3);
    CLKOUT3B_BUFG_INST : BUFG
      port map (
        I => CLKOUT3B_BUF,
        O => CLKOUT3B);
  end generate Using_BUFG_for_CLKOUT3;

  No_BUFG_for_CLKOUT3    : if (not C_CLKOUT3_BUF) generate
    CLKOUT3 <= CLKOUT3_BUF;
    CLKOUT3B <= CLKOUT3B_BUF;
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

  -----------------------------------------------------------------------------
  -- ClkOut6
  -----------------------------------------------------------------------------
  Using_BUFG_for_CLKOUT6 : if (C_CLKOUT6_BUF) generate

    CLKOUT6_BUFG_INST : BUFG
      port map (
        I => CLKOUT6_BUF,
        O => CLKOUT6);
  end generate Using_BUFG_for_CLKOUT6;

  No_BUFG_for_CLKOUT6 : if (not C_CLKOUT6_BUF) generate
    CLKOUT6 <= CLKOUT6_BUF;
  end generate No_BUFG_for_CLKOUT6;

end STRUCT;

