-----------------------------------------------------------------------
-- Self test design - clock checker
-- Michaela Blott
-- May 2010
-----------------------------------------------------------------------
library ieee;
library unisim;
use ieee.std_logic_1164.all;
use unisim.vcomponents.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity clk_test is
port ( 
   sysclk     : in  std_logic;
   clk25      : in  std_logic;
   osc1       : in  std_logic;
   osc2       : in  std_logic;
   supr       : in  std_logic;
   clk25_ok   : out std_logic;
   osc1_ok    : out std_logic; 
   osc2_ok    : out std_logic; 
   supr_ok    : out std_logic;
   led_sysclk : out std_logic);
end clk_test;

architecture BEHAVIORAL of clk_test is

signal cnt1s, cnt_osc1, cnt_osc2, cnt_spr, cnt_25 : std_logic_vector(27 downto 0);
signal count : std_logic;
signal count25_sr, countosc1_sr, countosc2_sr, countsupr_sr : std_logic_vector(2 downto 0);

begin

-- LED flashes on for 1sec/off for 1sec to check sysclk ok
led_sysclk <= count;

p1 : process(sysclk)
begin
   if (sysclk'event and sysclk='1') then
      if (cnt1s < x"5F5E0FF") then
         cnt1s <= cnt1s + 1;
      else
         count <= not count;
         cnt1s <= (others => '0');
      end if;
   end if;
end process;

-- always count ticks for 1s
p2 : process(clk25)
begin
if (clk25'event and clk25='1') then
	count25_sr(2 downto 0) <= count25_sr(1 downto 0) & count; -- sync CDC
	if (count25_sr(2)='0') then
		cnt_25 <= (others => '0');
	else
		cnt_25 <= cnt_25 +1;
	end if;
   if (count25_sr(2 downto 1)= "10") then
	   if (cnt_25 > x"17C0000" and cnt_25 < x"17EFFFF") then
		   -- 17D7800
		   clk25_ok <= '1';		
		else
		   clk25_ok <= '0';
		end if;
	end if;
end if;
end process;

p3 : process(osc1)
begin
if (osc1'event and osc1='1') then
	countosc1_sr(2 downto 0) <= countosc1_sr(1 downto 0) & count; -- sync CDC
	if (countosc1_sr(2)='0') then
		cnt_osc1 <= (others => '0');
	else
		cnt_osc1 <= cnt_osc1 +1;
	end if;
   if (countosc1_sr(2 downto 1)= "10") then
	   if (cnt_osc1 > x"5F5E000" and cnt_osc1 < x"5F5EFFF") then
		   -- 5F5E100
		   osc1_ok <= '1';		
		else
		   osc1_ok <= '0';
		end if;
	end if;
end if;
end process;

p4 : process(osc2)
begin
if (osc2'event and osc2='1') then
	countosc2_sr(2 downto 0) <= countosc2_sr(1 downto 0) & count; -- sync CDC
	if (countosc2_sr(2)='0') then
		cnt_osc2 <= (others => '0');
	else
		cnt_osc2 <= cnt_osc2 +1;
	end if;
   if (countosc2_sr(2 downto 1)= "10") then
	   if (cnt_osc2 > x"5F5E000" and cnt_osc2 < x"5F5EFFF") then
		   -- 5F5E100
		   osc2_ok <= '1';		
		else
		   osc2_ok <= '0';
		end if;
	end if;
end if;
end process;


p5 : process(supr)
begin
if (supr'event and supr='1') then
	countsupr_sr(2 downto 0) <= countsupr_sr(1 downto 0) & count; -- sync CDC
	if (countsupr_sr(2)='0') then
		cnt_spr <= (others => '0');
	else
		cnt_spr <= cnt_spr +1;
	end if;
   if (countsupr_sr(2 downto 1)= "10") then
	   if (cnt_spr > x"5F5E000" and cnt_spr < x"5F5EFFF") then
		   -- 5F5E100
		   supr_ok <= '1';		
		else
		   supr_ok <= '0';
		end if;
	end if;
end if;
end process;

 
end BEHAVIORAL;


