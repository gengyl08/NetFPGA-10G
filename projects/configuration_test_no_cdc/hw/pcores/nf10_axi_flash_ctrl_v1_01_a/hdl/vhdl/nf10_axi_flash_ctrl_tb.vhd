------------------------------------------------------------------------------
--
--  NetFPGA-10G http://www.netfpga.org
--
--  File:
--        nf10_axi_flash_ctrl_tb.vhd
--
--  Library:
--        library dependencies
--
--  Project:
--        configuration_test_no_cdc
--
--  Module:
--        Flashtest.vhd
--
--  Author:
--        Stephanie Friederich
--
--  Description:
--        This is a testbench to test the state machine that is in the
--        FPGA, driving the Platform flash XCF128XFTG64C control signals and address
--        and data buses. Three commands are suported, Read Electronic Signature,
--        Read Flash, and Write to Flash. The testbench includes no real timing
--        information and just checks out the basic functionality.
--
--  Copyright notice:
--        Copyright (C) 2010,2011 The Board of Trustees of The Leland Stanford
--                                Junior University
--
--  Licence:
--        This file is part of the NetFPGA 10G development base package.
--
--        This package is free software: you can redistribute it and/or modify
--        it under the terms of the GNU Lesser General Public License as
--        published by the Free Software Foundation, either version 3 of the
--        License, or (at your option) any later version.
--
--        This package is distributed in the hope that it will be useful, but
--        WITHOUT ANY WARRANTY; without even the implied warranty of
--        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
--        Lesser General Public License for more details.
--
--        You should have received a copy of the GNU Lesser General Public
--        License along with the NetFPGA source package.  If not, see
--        http://www.gnu.org/licenses/.
--
--

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE behavior OF testbench IS

    -- Component Declaration for the Unit Under Test (UUT)

  COMPONENT flash_controller
    PORT (CPLD_CLK : IN  std_logic;
          reboot : OUT  std_logic;
          A : OUT  std_logic_vector(23 downto 0);
          Data_out : OUT  std_logic_vector(15 downto 0);
          Data_in : IN  std_logic_vector(15 downto 0);
          E_N : OUT  std_logic;
          G_N : OUT  std_logic;
          clk : IN  std_logic;
          RP_N : OUT  std_logic;
          W_N : OUT  std_logic;
          L_N : OUT  std_logic;
          command : IN  std_logic_vector(3 downto 0);
          address : IN  std_logic_vector(23 downto 0);
          data : IN  std_logic_vector(15 downto 0);
          execute_order : IN  std_logic;
          control : OUT  std_logic_vector(3 downto 0);
          counter : OUT  std_logic_vector(15 downto 0);
          check : OUT  std_logic;
          data_register : OUT  std_logic_vector(15 downto 0);
          hw_wr_ack : OUT  std_logic;
          execute : INOUT  std_logic);
  END COMPONENT;

  component FlashEmulator is
    Port (A  : in    STD_LOGIC_VECTOR (23 downto 0);
          DQ : inout STD_LOGIC_VECTOR (15 downto 0);
          E  : in    STD_LOGIC;
          G  : in    STD_LOGIC;
          W  : in    STD_LOGIC;
          WP : in    STD_LOGIC;
          K  : in    STD_LOGIC;
          L  : in    STD_LOGIC;
          RW : in    STD_LOGIC);
  end component;

   --Inputs
   signal CPLD_CLK      : std_logic := '0';
   signal Data_in       : std_logic_vector(15 downto 0) := (others => '0');
   signal clk           : std_logic := '0';
   signal command       : std_logic_vector(3 downto 0) := (others => '0');
   signal address       : std_logic_vector(23 downto 0) := (others => '0');
   signal data          : std_logic_vector(15 downto 0) := (others => '0');
   signal execute_order : std_logic := '0';

	--BiDirs
   signal execute : std_logic;

 	--Outputs
   signal reboot : std_logic;
   signal A : std_logic_vector(23 downto 0);
   signal Data_out : std_logic_vector(15 downto 0);
   signal Data_DQ : std_logic_vector (15 downto 0);
   signal E_N : std_logic;
   signal G_N : std_logic;
   signal RP_N : std_logic;
   signal W_N : std_logic;
   signal W_K : std_logic;
   signal W_L : std_logic;
   signal W_RW : std_logic;
   signal L_N : std_logic;
   signal control : std_logic_vector(3 downto 0);
   signal counter : std_logic_vector(15 downto 0);
   signal check : std_logic;
   signal data_register : std_logic_vector(15 downto 0);
   signal hw_wr_ack : std_logic;

   -- Clock period definitions
   constant CPLD_CLK_period : time := 10 ns;
   constant clk_period : time := 10 ns;

   constant ReadElectronicSignature : std_logic_vector (3 downto 0) := "0001";
   constant ReadStatusRegister      : std_logic_vector (3 downto 0) := "1010";
   constant ClearStatusRegister     : std_logic_vector (3 downto 0) := "1011";
   constant BlockUnlock             : std_logic_vector (3 downto 0) := "1100";
   constant BlockErase              : std_logic_vector (3 downto 0) := "0010";
   constant BlankCheck              : std_logic_vector (3 downto 0) := "0011";
   constant WriteData               : std_logic_vector (3 downto 0) := "0100";
   constant SingleReadData          : std_logic_vector (3 downto 0) := "0101";
   constant SetRebootRegister       : std_logic_vector (3 downto 0) := "0111";
   constant ResetRebootRegister     : std_logic_vector (3 downto 0) := "1000";
   constant Reset                   : std_logic_vector (3 downto 0) := "1111";
   constant Idle                    : std_logic_vector (3 downto 0) := "0000";

subtype FourBits is std_logic_vector (3 downto 0);
subtype EightBits is std_logic_vector (7 downto 0);

function CharacterValue (c : character) return FourBits is
begin
  case c is
    when '0'    => return conv_std_logic_vector (0, 4);
    when '1'    => return conv_std_logic_vector (1, 4);
    when '2'    => return conv_std_logic_vector (2, 4);
    when '3'    => return conv_std_logic_vector (3, 4);
    when '4'    => return conv_std_logic_vector (4, 4);
    when '5'    => return conv_std_logic_vector (5, 4);
    when '6'    => return conv_std_logic_vector (6, 4);
    when '7'    => return conv_std_logic_vector (7, 4);
    when '8'    => return conv_std_logic_vector (8, 4);
    when '9'    => return conv_std_logic_vector (9, 4);
    when 'a'    => return conv_std_logic_vector (10, 4);
    when 'b'    => return conv_std_logic_vector (11, 4);
    when 'c'    => return conv_std_logic_vector (12, 4);
    when 'd'    => return conv_std_logic_vector (13, 4);
    when 'e'    => return conv_std_logic_vector (14, 4);
    when others => return conv_std_logic_vector (15, 4);
  end case;
end;

function HexCharacter (v : Fourbits) return character is
begin
  case v is
    when "0000" => return '0';
    when "0001" => return '1';
    when "0010" => return '2';
    when "0011" => return '3';
    when "0100" => return '4';
    when "0101" => return '5';
    when "0110" => return '6';
    when "0111" => return '7';
    when "1000" => return '8';
    when "1001" => return '9';
    when "1010" => return 'a';
    when "1011" => return 'b';
    when "1100" => return 'c';
    when "1101" => return 'd';
    when "1110" => return 'e';
	 when others => return 'f';
  end case;
end;

function HexString (v : EightBits) return string is
begin
  return HexCharacter (v (7 downto 4)) & HexCharacter (v (3 downto 0));
end;


BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut: flash_controller PORT MAP (CPLD_CLK      => CPLD_CLK,
                                   reboot        => reboot,
                                   A             => A,
                                   Data_out      => Data_out,
                                   Data_in       => Data_in,
                                   E_N           => E_N,
                                   G_N           => G_N,
                                   clk           => clk,
                                   RP_N          => RP_N,
                                   W_N           => W_N,
                                   L_N           => L_N,
                                   command       => command,
                                   address       => address,
                                   data          => data,
                                   execute_order => execute_order,
                                   control       => control,
                                   counter       => counter,
                                   check         => check,
                                   data_register => data_register,
                                   hw_wr_ack     => hw_wr_ack,
                                   execute       => execute);

  flash : FlashEmulator Port map (A  => A,
                                  DQ => Data_DQ,
                                  E  => E_N,
                                  G  => G_N,
                                  W  => W_N,
                                  WP => '1',
                                  K  => CPLD_CLK,
                                  L  => L_N,
                                  RW => W_RW);



 -- Clock process definitions
   CPLD_CLK_process :process
   begin
		CPLD_CLK <= '0';
		wait for CPLD_CLK_period/2;
		CPLD_CLK <= '1';
		wait for CPLD_CLK_period/2;
   end process;

   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;

   DataDQ_process :process
   begin
     if G_N = '1'
     then
       Data_DQ <= Data_out;
     else
       Data_DQ <= (others => 'Z');
     end if;

     if G_N = '0'
     then
       Data_in <= Data_DQ;
     end if;
		 wait for clk_period/2;
   end process;


   -- Stimulus process
   stim_proc: process
      variable ReportString : string (1 to 200);
    begin
      -- hold reset state for 100 ns.
      wait for 100 ns;

      wait for CPLD_CLK_period*10;

      -- insert stimulus here
      command <= ReadElectronicSignature;
      execute_order <= '1';
      wait for 10 ns;
      execute_order <= '0';
      while execute = '1' loop
        wait for 10 ns;
      end loop;

      ReportString := "Electronic signature is 0x" &
                        HexString (data_register (15 downto 8)) &
                        HexString (data_register (7 downto 0));

      report ReportString
      severity note;

      command <= WriteData;
      address <= x"ABCDEF";
      data    <= x"1234";
      execute_order <= '1';
      wait for 10 ns;
      execute_order <= '0';
      while execute = '1' loop
        wait for 10 ns;
      end loop;

      ReportString := "Written 0x" &
                        HexString (data (15 downto 8)) &
                        HexString (data (7 downto 0)) &
                      " to address 0x" &
                        HexCharacter (address (19 downto 16)) &
                        HexString (address (15 downto 8)) &
                        HexString (address (7 downto 0));

      report ReportString
      severity note;

      command <= WriteData;
      address <= x"ABCDF0";
      data    <= x"5432";
      execute_order <= '1';
      wait for 10 ns;
      execute_order <= '0';
      while execute = '1' loop
        wait for 10 ns;
      end loop;

      ReportString := "Written 0x" &
                        HexString (data (15 downto 8)) &
                        HexString (data (7 downto 0)) &
                      " to address 0x" &
                        HexCharacter (address (19 downto 16)) &
                        HexString (address (15 downto 8)) &
                        HexString (address (7 downto 0));

      report ReportString
      severity note;

      command <= SingleReadData;
      address <= x"ABCDEF";
      execute_order <= '1';
      wait for 10 ns;
      execute_order <= '0';
      while execute = '1' loop
        wait for 10 ns;
      end loop;

      ReportString := "Read0x" &
                        HexString (data_register (15 downto 8)) &
                        HexString (data_register (7 downto 0)) &
                      " from address 0x" &
                        HexCharacter (address (19 downto 16)) &
                        HexString (address (15 downto 8)) &
                        HexString (address (7 downto 0)) & "  ";

      report ReportString
      severity note;

      command <= SingleReadData;
      address <= x"ABCDF0";
      execute_order <= '1';
      wait for 10 ns;
      execute_order <= '0';
      while execute = '1' loop
        wait for 10 ns;
      end loop;

      ReportString := "Read0x" &
                        HexString (data_register (15 downto 8)) &
                        HexString (data_register (7 downto 0)) &
                      " from address 0x" &
                        HexCharacter (address (19 downto 16)) &
                        HexString (address (15 downto 8)) &
                        HexString (address (7 downto 0)) & "  ";

      report ReportString
      severity note;

      wait;
   end process;

END;
