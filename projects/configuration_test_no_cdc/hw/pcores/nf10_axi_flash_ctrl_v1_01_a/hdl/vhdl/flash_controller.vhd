------------------------------------------------------------------------------
--
--  NetFPGA-10G http://www.netfpga.org
--
--  File:
--        flash_controller.vhd
--
--  Library:
--        library dependencies
--
--  Project:
--        configuration_test_no_cdc
--
--  Author:
--        Stephanie Friederich
--
--  Description:
--        Stephanie Friederich - A state machine for various Platform Flash operations
--        Mark Grindell- Tbe changes in this edition are to bring "execute" out as
--                       an inout signal to make sure that we can see WHEN a command
--                       has been completed.
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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity flash_controller is
port (
	CPLD_CLK        : in std_logic;                         -- clock
	reboot          : out std_logic;
	A        	: out std_logic_vector(23 downto 0);	-- adr input
	Data_out 	: out std_logic_vector(15 downto 0);	-- data io
	Data_in  	: in std_logic_vector(15 downto 0);	-- data io
	E_N      	: out std_logic;			-- chip enable active low
	G_N      	: out std_logic;		        -- output enable active low
	clk      	: in std_logic;				-- clock
	RP_N     	: out std_logic;			-- reset active low
	W_N     	: out std_logic;			-- write enable active low
	L_N		: out std_logic;			-- latch enable active low
	-- signal from ChipScope
	command		: in std_logic_vector(3 downto 0);
	address		: in std_logic_vector(23 downto 0);
	data		: in std_logic_vector(15 downto 0);
	execute_order	: in std_logic;
	-- Control signals for ChipScope
	control		: out std_logic_vector(3 downto 0);
	counter		: out std_logic_vector(15 downto 0);
	check		: out std_logic;
	data_register   : out std_logic_vector(15 downto 0);
	hw_wr_ack       : out std_logic;
        execute         : inout std_logic) ;

end flash_controller;

architecture Behavioral of flash_controller is

	signal check_flash : std_logic;
	signal ctl_sm_i    : std_logic_Vector(15 downto 0) := x"0000";
	signal flash_a_i   : std_logic_vector(23 downto 0);
	signal flash_d_i   : std_logic_Vector(15 downto 0);
	signal flash_e_b_i : std_logic;
	signal flash_g_b_i : std_logic;
	signal flash_w_b_i : std_logic;
	signal flash_l_b_i : std_logic;
	signal dat_reg     : std_logic_vector(15 downto 0) := x"0000";
--MG	signal execute     : std_logic;
	signal state	   : std_logic_vector(3 downto 0);
	signal count       : integer range 0 to 10;

begin

	A		<= flash_a_i;
	Data_out	<= flash_d_i;
	E_N		<= flash_e_b_i;
	G_N		<= flash_g_b_i;
	W_N		<= flash_w_b_i;
	L_N		<= flash_l_b_i;
	state		<= command;

	counter		<= ctl_sm_i;
	check		<= check_flash;
	data_register	<= dat_reg;



flash_ctrl_p: process(CPLD_CLK, execute_order)
begin
  if (CPLD_CLK'event and CPLD_CLK='1')
  then
    if execute_order = '1'
    then
      execute  <= '1';
      RP_N     <= '1';
      ctl_sm_i <= x"0000";
    else
      ctl_sm_i <= std_logic_vector(unsigned(ctl_sm_i) + 1) ;
    end if;

---------------------------------------------------------------------------------------------------------------------------
--  Read electronic signature
---------------------------------------------------------------------------------------------------------------------------
		if (state = "0001") and (execute = '1') then
			control <= "0001";
			flash_a_i(23 downto 3) <= address(23 downto 3);
			flash_a_i(2 downto 0) <= ctl_sm_i(9 downto 7);
			-- between 0 and FF inactive for start-up/reset
			if ctl_sm_i > x"03FF" then
				if ctl_sm_i(6 downto 0) = "000" & x"0" then
					flash_d_i <= x"0090";
					flash_e_b_i <= '1';
					flash_g_b_i <= '1';
					flash_w_b_i <= '1';
					flash_l_b_i <= '1';
				elsif ctl_sm_i(6 downto 0) = "000" & x"1" then
					flash_d_i <= x"0090";
					flash_e_b_i <= '0';
					flash_g_b_i <= '1';
					flash_w_b_i <= '0';
					flash_l_b_i <= '0';
				elsif ctl_sm_i(6 downto 0) = "000" & x"3" then
					flash_d_i <= x"0090";
					flash_e_b_i <= '1';
					flash_g_b_i <= '1';
					flash_w_b_i <= '1';
					flash_l_b_i <= '1';
			   elsif ctl_sm_i(6 downto 0) = "000" & x"4" then
				   flash_e_b_i <= '0';
				   flash_g_b_i <= '0';
				   flash_w_b_i <= '1';
				   flash_l_b_i <= '0';
			   elsif ctl_sm_i(6 downto 0) = "000" & x"6" then
				   flash_e_b_i <= '0';
				   flash_g_b_i <= '0';
				   flash_w_b_i <= '1';
				   flash_l_b_i <= '1';
			   elsif ctl_sm_i(6 downto 0) = "0010000" then
				   dat_reg <= Data_in;
				   if Data_in = x"0049"  then -- Electronic Signature Codes see table 9 in ds617
				     check_flash <= '1';
				   else
					 check_flash <= '0';
				   end if;
			   elsif ctl_sm_i(9 downto 7) > "010" then -- read el signature till address 7
					execute <= '0';
				end if;
			end if;

---------------------------------------------------------------------------------------------------------------------------
--  Read Status Register
---------------------------------------------------------------------------------------------------------------------------
		elsif (state = "1010" ) and (execute = '1') then
			control <= "1010";
			flash_a_i <= address;
			if ctl_sm_i(6 downto 0) = "000" & x"0" then
				flash_d_i <= x"0070";
				flash_e_b_i <= '0';
				flash_g_b_i <= '1';
				flash_w_b_i <= '0';
				flash_l_b_i <= '0';
			elsif ctl_sm_i(6 downto 0) = "000" & x"1" then
				flash_e_b_i <= '1';
				flash_g_b_i <= '1';
				flash_w_b_i <= '1';
				flash_l_b_i <= '1';
			elsif ctl_sm_i(6 downto 0) = "000" & x"2" then
				flash_e_b_i <= '0';
				flash_g_b_i <= '0';
				flash_w_b_i <= '1';
				flash_l_b_i <= '0';
			elsif ctl_sm_i(6 downto 0) > "0011111" then
				execute <= '0';
			end if;


---------------------------------------------------------------------------------------------------------------------------
-- Clear Status Register
---------------------------------------------------------------------------------------------------------------------------
		elsif (state = "1011" ) and (execute = '1') then
			control <= "1011";
			if ctl_sm_i(6 downto 0) = "000" & x"0" then
				flash_d_i <= x"0050";
				flash_e_b_i <= '0';
				flash_g_b_i <= '1';
				flash_w_b_i <= '0';
				flash_l_b_i <= '0';
			elsif ctl_sm_i(6 downto 0) > "0011111" then
				execute <= '0';
			end if;


---------------------------------------------------------------------------------------------------------------------------
--  Block Unlock
---------------------------------------------------------------------------------------------------------------------------
		elsif (state = "1100" ) and (execute = '1') then
			control <= "1100";
			flash_a_i <= address;
			if ctl_sm_i(6 downto 0) = "000" & x"0" then
				flash_d_i <= x"0060";
				flash_e_b_i <= '0';
				flash_g_b_i <= '1';
				flash_w_b_i <= '0';
				flash_l_b_i <= '0';
			elsif ctl_sm_i(6 downto 0) = "000" & x"1" then
				flash_e_b_i <= '1';
				flash_g_b_i <= '1';
				flash_w_b_i <= '1';
				flash_l_b_i <= '1';
			elsif ctl_sm_i(6 downto 0) = "000" & x"2" then
				flash_d_i <= x"00D0";
				flash_e_b_i <= '0';
				flash_g_b_i <= '1';
				flash_w_b_i <= '0';
				flash_l_b_i <= '0';
			elsif ctl_sm_i(6 downto 0) > "0001111" then
				execute <= '0';
			end if;


---------------------------------------------------------------------------------------------------------------------------
--  Block Erase Command
---------------------------------------------------------------------------------------------------------------------------
		elsif (state = "0010" ) and (execute = '1') then
			control <= "0010";
			flash_a_i <= address;
			if ctl_sm_i(6 downto 0) = "000" & x"0" then
				flash_d_i <= x"0020";
				flash_e_b_i <= '0';
				flash_g_b_i <= '1';
				flash_w_b_i <= '0';
				flash_l_b_i <= '0';
			elsif ctl_sm_i(6 downto 0) = "000" & x"1" then
				flash_e_b_i <= '1';
				flash_g_b_i <= '1';
				flash_w_b_i <= '1';
				flash_l_b_i <= '1';
			elsif ctl_sm_i(6 downto 0) = "000" & x"2" then
				flash_d_i <= x"00D0";
				flash_e_b_i <= '0';
				flash_g_b_i <= '1';
				flash_w_b_i <= '0';
				flash_l_b_i <= '0';
			elsif ctl_sm_i(6 downto 0) = "000" & x"3" then
				flash_e_b_i <= '1';
				flash_g_b_i <= '1';
				flash_w_b_i <= '1';
				flash_l_b_i <= '1';
			elsif ctl_sm_i(6 downto 0) = "000" & x"4" then
				flash_e_b_i <= '0';
				flash_g_b_i <= '0';
				flash_w_b_i <= '1';
				flash_l_b_i <= '0';
			elsif ctl_sm_i(6 downto 0) > "0011111" then
				execute <= '0';
			end if;


---------------------------------------------------------------------------------------------------------------------------
--  Blank Check Command
---------------------------------------------------------------------------------------------------------------------------
		elsif (state = "0011" ) and (execute = '1') then
			control <= "0011";
			flash_a_i <= address;
			if ctl_sm_i(6 downto 0) = "000" & x"0" then
				flash_d_i <= x"00BC";
				flash_e_b_i <= '0';
				flash_g_b_i <= '1';
				flash_w_b_i <= '0';
				flash_l_b_i <= '0';
			elsif ctl_sm_i(6 downto 0) = "000" & x"1" then
				flash_e_b_i <= '1';
				flash_g_b_i <= '1';
				flash_w_b_i <= '1';
				flash_l_b_i <= '1';
			elsif ctl_sm_i(6 downto 0) = "000" & x"2" then
				flash_d_i <= x"00CB";
				flash_e_b_i <= '0';
				flash_g_b_i <= '1';
				flash_w_b_i <= '0';
				flash_l_b_i <= '0';
			elsif ctl_sm_i(6 downto 0) = "000" & x"3" then
				flash_e_b_i <= '1';
				flash_g_b_i <= '1';
				flash_w_b_i <= '1';
				flash_l_b_i <= '1';
			elsif ctl_sm_i(6 downto 0) = "000" & x"4" then
				flash_e_b_i <= '0';
				flash_g_b_i <= '0';
				flash_w_b_i <= '1';
				flash_l_b_i <= '0';
			elsif ctl_sm_i(6 downto 0) > "0011111" then
				execute <= '0';
			end if;


---------------------------------------------------------------------------------------------------------------------------
--  Write Data
---------------------------------------------------------------------------------------------------------------------------
		elsif (state = "0100") and (execute = '1') then
			control <= "0100";
			flash_a_i <= address;
			if ctl_sm_i(6 downto 0) = "000" & x"0" then
				flash_d_i <= x"0040";
				flash_e_b_i <= '0';
				flash_g_b_i <= '1';
				flash_w_b_i <= '0';
				flash_l_b_i <= '0';
			elsif ctl_sm_i(6 downto 0) = "000" & x"1" then
				flash_e_b_i <= '1';
				flash_g_b_i <= '1';
				flash_w_b_i <= '1';
				flash_l_b_i <= '1';
			elsif ctl_sm_i(6 downto 0) = "000" & x"2" then
				flash_d_i <= data;
				flash_e_b_i <= '0';
				flash_g_b_i <= '1';
				flash_w_b_i <= '0';
				flash_l_b_i <= '0';
			elsif ctl_sm_i(6 downto 0) = "000" & x"3" then
				flash_e_b_i <= '1';
				flash_g_b_i <= '1';
				flash_w_b_i <= '1';
				flash_l_b_i <= '1';
			elsif ctl_sm_i(6 downto 0) = "000" & x"4" then
				flash_e_b_i <= '0';
				flash_g_b_i <= '0';
				flash_w_b_i <= '1';
				flash_l_b_i <= '0';
			elsif ctl_sm_i(6 downto 0) = "0011111" then
				execute <= '0';
			end if;


---------------------------------------------------------------------------------------------------------------------------
--  Single Read Data
---------------------------------------------------------------------------------------------------------------------------
		elsif (state = "0101") and (execute = '1') then
			control <= "0101";
			flash_a_i <= address;
			if ctl_sm_i(6 downto 0) = "000" & x"0" then
				flash_d_i <= x"00FF";
				flash_e_b_i <= '0';
				flash_g_b_i <= '1';
				flash_w_b_i <= '0';
				flash_l_b_i <= '0';
			elsif ctl_sm_i(6 downto 0) = "000" & x"1" then
				flash_e_b_i <= '1';
				flash_g_b_i <= '1';
				flash_w_b_i <= '1';
				flash_l_b_i <= '1';
			elsif ctl_sm_i(6 downto 0) = "000" & x"2" then
				flash_e_b_i <= '0';
				flash_g_b_i <= '0';
				flash_w_b_i <= '1';
				flash_l_b_i <= '0';
			elsif ctl_sm_i(6 downto 0) = "000" & x"3" then
				flash_e_b_i <= '0';
				flash_g_b_i <= '0';
				flash_w_b_i <= '1';
				flash_l_b_i <= '1';
			elsif ctl_sm_i(6 downto 0) = "0001101" then
				dat_reg <= Data_in;
				hw_wr_ack <= '1';
			elsif ctl_sm_i(6 downto 0) = "1111111" then
				execute <= '0';
			end if;

---------------------------------------------------------------------------------------------------------------------------
--  Set Reboot Register
---------------------------------------------------------------------------------------------------------------------------
		elsif (state = "0111") and (execute = '1')then
		  control <= "0111";
          reboot  <= '1';
		  execute <= '0';
---------------------------------------------------------------------------------------------------------------------------
--  Reset Reboot Register
---------------------------------------------------------------------------------------------------------------------------
		elsif (state = "1000") and (execute = '1')then
		  control <= "1000";
          reboot  <= '0';
		  execute <= '0';

---------------------------------------------------------------------------------------------------------------------------
--  Reset
---------------------------------------------------------------------------------------------------------------------------
		elsif (state = "1111") and (execute = '1')then
			control <= "1111";
			-- defaults
			flash_d_i	<= (others => '0');
			RP_N 		<= '0';
			execute		<= '0';
			check_flash <= '0';

---------------------------------------------------------------------------------------------------------------------------
--  Idle
---------------------------------------------------------------------------------------------------------------------------
		else
			control <= "0000";
			flash_e_b_i <= '1';
			flash_g_b_i <= '1';
			flash_w_b_i <= '1';
			flash_l_b_i <= '1';
			RP_N 		<= '1';
			hw_wr_ack <= '0';
			flash_d_i	<= (others => '0');
		end if;

		end if;
end process;



end Behavioral;

