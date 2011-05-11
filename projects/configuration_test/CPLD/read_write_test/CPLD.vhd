------------------------------------------------------------------------
--
-- Project: NET FPGA Configuration
-- Date: April 2011
-- Designer: S. Friederich
--
------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity CPLD is 
    port ( 
		CPLD_100MHZ      : in std_logic;  -- clock from oszillator
		-- FPGA Signals
      DONE             : in std_logic; 
      INIT_B           : inout std_logic; 
      Program_B        : out std_logic;
      FPGA_CCLK        : out std_logic;  -- clock for configuration
      reboot           : in std_logic;  
		FPGA_clock       : out std_logic;  -- clock to the FPGA
		FPGA_A           : in std_logic_vector(22 downto 0); 
		FPGA_data		  : inout std_logic_vector (15 downto 0);
		FPGA_G			  : in std_logic;	-- Active low output enable. Disables the Platform Flash data output.
		FPGA_W			  : in std_logic;	-- Active low write enable.Diables the Platform Flash write function.
		FPGA_E			  : in std_logic;	-- Active low chip enable. Disables the Platform Flash.
		FPGA_L			  : in std_logic;	-- Active low address latch enable. Disables the Platform Flash address latch.
		FPGA_RP		  	  : in std_logic;	-- Reset           
		-- Flash Signals            
		FLASH_A_A        : out std_logic_vector(23 downto 0);
      FLASH_A_DQ       : inout std_logic_vector(15 downto 0);
      FLASH_A_E	     : out std_logic;
      FLASH_A_G	     : out std_logic;
      FLASH_A_K        : out std_logic;  -- clock to the Flash
      FLASH_A_RP	     : out std_logic;
      FLASH_A_WP	     : out std_logic;
      FLASH_A_W	     : out std_logic;
      FLASH_A_L	     : out std_logic;
      FLASH_A_RW       : inout std_logic;
		
		FLASH_B_A        : out std_logic_vector(23 downto 0);
      FLASH_B_DQ       : inout std_logic_vector(15 downto 0);
      FLASH_B_E	     : out std_logic;
      FLASH_B_G	     : out std_logic;
      FLASH_B_K        : out std_logic;  -- clock to the Flash
      FLASH_B_RP	     : out std_logic;
      FLASH_B_WP	     : out std_logic;
      FLASH_B_W	     : out std_logic;
      FLASH_B_L	     : out std_logic;
      FLASH_B_RW       : inout std_logic;
		LEDs 				  : out std_logic_vector(3 downto 0)
	) ;
end CPLD;

architecture structural of CPLD is 


	signal FLASH_A_DQ_buffered  : std_logic_vector (15 downto 0);
	signal FPGA_data_buffered   : std_logic_vector (15 downto 0);
	signal Flash_A_G_buffered   : std_logic;
	signal Flash_A_G_buffered_2 : std_logic;
    -- clocks
   signal clk100_i  : std_logic := '0';
   signal clk50_i   : std_logic := '0';
   signal clk25_i   : std_logic;	
   signal clk_cnt_i : std_logic_vector(24 downto 0) := "0000000000000000000000000";	
	
	signal config_cnt   : std_logic_vector (1 downto 0);
	signal start_config : std_logic;	
	
begin


--------------------------- clock generation --------------------------------------------

   clk50_i <= clk_cnt_i(0);
   clk25_i <= clk_cnt_i(1);
   clk100_i <= CPLD_100MHZ;

   clk_chk_p: process(clk100_i)
   begin
      if clk100_i'event and clk100_i='1' then
         clk_cnt_i <= clk_cnt_i + 1;
      end if;
   end process;


	FPGA_clock      <= clk25_i;
	FLASH_A_K		 <= clk25_i;	   

  FLASH_A_A(23)    <= '0';


  LEDs(0) <= config_cnt(0);
  LEDs(1) <= config_cnt(1);
  LEDs(2) <= '1';
  LEDs(3) <= reboot;



--------------------------- flash signals --------------------------------------------
  flash_chk_p: process(clk25_i, config_cnt)
  begin
		if clk25_i'event and clk25_i='1' then
	     FLASH_A_L              <= FPGA_L; 
		  FLASH_A_WP		       <= '1';    -- Write potect
	     FLASH_A_A(22 downto 0) <= FPGA_A;
	     FLASH_A_E		          <= FPGA_E;
	     FLASH_A_G		          <= FPGA_G;
	     FLASH_A_RP	       	 <= FPGA_RP;
	     FLASH_A_W		          <= FPGA_W;
		  FLASH_A_DQ_buffered	 <= FLASH_A_DQ;
		  FPGA_data_buffered 	 <= FPGA_data;
		  Flash_A_G_buffered 	 <= FPGA_G;
		  Flash_A_G_buffered_2   <= Flash_A_G_buffered;
		  FLASH_A_RW             <= '1';
		  config_cnt             <= "00";
        Program_B              <= '1';
        start_config           <= '1';		  
	 end if;
  end process;

--
--  data_p: process(Flash_A_G_buffered, FLASH_A_DQ_buffered, FPGA_data_buffered)
--  begin
--      if Flash_A_G_buffered = '0' then
--		  FPGA_data    <= FLASH_A_DQ_buffered;
--		else
--		  FPGA_data    <= (others => 'Z');
--		end if;
--		if Flash_A_G_buffered = '1' then  
--		  FLASH_A_DQ   <= FPGA_data_buffered; 
--		else 
--		  FLASH_A_DQ   <= (others => 'Z');
--		end if;
--  end process data_p; 

  FPGA_data <= FLASH_A_DQ_buffered when (Flash_A_G_buffered='0') else (others => 'Z'); -- Flash sending data
  FLASH_A_DQ <= FPGA_data_buffered when (Flash_A_G_buffered='1') else (others => 'Z'); -- FPGA sending data   
 
 
end structural;
