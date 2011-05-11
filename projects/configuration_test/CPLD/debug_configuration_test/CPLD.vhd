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

entity CPLD is 
    port ( 
		CPLD_100MHZ      : in std_logic;  -- clock from oszillator
		-- FPGA Signals
      DONE             : in std_logic; 
      INIT_B           : inout std_logic; 
      Program_B        : inout std_logic;
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

    -- clocks
   signal clk100_i  : std_logic := '0';
   signal clk50_i   : std_logic := '0';
   signal clk25_i   : std_logic;	
   signal clk125_i   : std_logic;	
	
   signal clk_cnt_i : std_logic_vector(24 downto 0) := "0000000000000000000000000";	
	
	signal config_cnt   : std_logic_vector (3 downto 0);
--
--  attribute PULLUP : string;
--  attribute PULLUP of FLASH_A_RW : signal is "YES";

	
begin


--------------------------- clock generation --------------------------------------------

   clk50_i <= clk_cnt_i(0);
   clk25_i <= clk_cnt_i(1);
	clk125_i <= clk_cnt_i(2);
   clk100_i <= CPLD_100MHZ;

   clk_chk_p: process(clk100_i)
   begin
      if clk100_i'event and clk100_i='1' then
         clk_cnt_i <= clk_cnt_i + 1;
      end if;
   end process;

	FPGA_CCLK       <= clk125_i;
	FPGA_clock      <= clk125_i;
	FLASH_A_K		 <= clk125_i;	   

  FLASH_A_A(23)    <= '0';


  LEDs(0) <= Program_B;
  LEDs(1) <= INIT_B;
  LEDs(2) <= FPGA_E;
  LEDs(3) <= FLASH_A_DQ(0);




--------------------------- flash signals --------------------------------------------


  init_p : process(reboot,FLASH_A_RW,INIT_B) 
  begin 
--     if reboot = '0' then
--	     FLASH_A_RW <= '1'; 
--  		  INIT_B     <= 'Z';  
--     else
	     if (INIT_B='0') then   -- the FPGA need more time to reset than the Flash
	        FLASH_A_RW <= '0';  -- Ready_Wait = 0 that the flash waits till the FPGA is ready
        else
	        FLASH_A_RW <= '1'; -- 1
        end if;
		  
--        if (FLASH_A_RW='0') then		  
--           INIT_B <= '0';
--        else
--           INIT_B <= 'Z';
--        end if;			  
--     end if;
  end process;

  flash_chk_p: process(clk125_i)
  begin
    if clk125_i'event and clk125_i='1' then
		
--		if reboot = '0' then 
--	     FLASH_A_E		          <= FPGA_E;
--	     FLASH_A_G		          <= FPGA_G;
--	     FLASH_A_W		          <= FPGA_W;
--        FLASH_A_L              <= FPGA_L; 		
--		  FLASH_A_RP	       	 <= FPGA_RP;
--		  FLASH_A_WP		       <= '1';    -- Write potect
--	     FLASH_A_A(22 downto 0) <= FPGA_A;
--		  FLASH_A_DQ_buffered	 <= FLASH_A_DQ;
--		  FPGA_data_buffered 	 <= FPGA_data;
--		  Flash_A_G_buffered 	 <= FPGA_G;  
--		  config_cnt             <= "0000";	  	  
--		  LEDs(2)                <= '0';	 
--      elsif reboot = '1' then 	


    if Program_B='0' then
	     config_cnt             <= "0000";	
	     FLASH_A_E		          <= FPGA_E;
	     FLASH_A_G		          <= 'Z';
	     FLASH_A_W		          <= 'Z';
        FLASH_A_L              <= 'Z'; 		
		  FLASH_A_WP		       <= '1';    -- Write potect 		  
        FLASH_A_A(22 downto 0) <= (others => '0');		
		  FLASH_A_RP             <= '0';
	 else
	     FLASH_A_E		          <= FPGA_E;
	     FLASH_A_G		          <= 'Z';
	     FLASH_A_W		          <= 'Z';
        FLASH_A_L              <= 'Z'; 		
		  FLASH_A_WP		       <= '1';    -- Write potect 		  
        FLASH_A_A(22 downto 0) <= (others => '0');
        
--		  if (config_cnt < "1111") then
--		     config_cnt             <= config_cnt + 1 ;
--		  end if;
--		
--        if config_cnt(3 downto 0) < "0101" then
--				 Program_B     <= '0';  -- could also be connected to an external push button
--												-- to allow manual initiation of the reconfiguration process
--				 FLASH_A_RP    <= '0';
--				 LEDs(2)       <= '1';				
--		  else
				 Program_B     <= 'Z';--1
				 FLASH_A_RP    <= '1';	
--        end if;
		end if;	--reboot/prog
    end if; -- clk
  end process;


  data_p: process(clk125_i,reboot,Flash_A_G_buffered, FLASH_A_DQ_buffered, FPGA_data_buffered, FLASH_A_DQ)
  begin
    if clk125_i'event and clk125_i='1' then
--    if reboot = '0' then
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
--    elsif reboot = '1' then
	   FLASH_A_DQ   <= (others => 'Z');


---------------------------------------------
--	Bit width detection successful 

--		FPGA_data  <= FLASH_A_DQ;


--		  FPGA_data(15)  <= FLASH_A_DQ(0);
--		  FPGA_data(14)  <= FLASH_A_DQ(1);
--		  FPGA_data(13)  <= FLASH_A_DQ(2);
--		  FPGA_data(12)  <= FLASH_A_DQ(3);
--		  FPGA_data(11)  <= FLASH_A_DQ(4);
--		  FPGA_data(10)  <= FLASH_A_DQ(5);
--		  FPGA_data(9)   <= FLASH_A_DQ(6);
--		  FPGA_data(8)   <= FLASH_A_DQ(7);
--		  
--		  FPGA_data(7)  <= FLASH_A_DQ(8);
--		  FPGA_data(6)  <= FLASH_A_DQ(9);
--		  FPGA_data(5)  <= FLASH_A_DQ(10);
--		  FPGA_data(4)  <= FLASH_A_DQ(11);
--		  FPGA_data(3)  <= FLASH_A_DQ(12);
--		  FPGA_data(2)  <= FLASH_A_DQ(13);
--		  FPGA_data(1)  <= FLASH_A_DQ(14);
--		  FPGA_data(0)  <= FLASH_A_DQ(15);	 
----------------------------------------------
	 
--	 
--		  FPGA_data(15)  <= FLASH_A_DQ(8);
--		  FPGA_data(14)  <= FLASH_A_DQ(9);
--		  FPGA_data(13)  <= FLASH_A_DQ(10);
--		  FPGA_data(12)  <= FLASH_A_DQ(11);
--		  FPGA_data(11)  <= FLASH_A_DQ(12);
--		  FPGA_data(10)  <= FLASH_A_DQ(13);
--		  FPGA_data(9)   <= FLASH_A_DQ(14);
--		  FPGA_data(8)   <= FLASH_A_DQ(15);
		  
--		  FPGA_data(7)  <= FLASH_A_DQ(0);
--		  FPGA_data(6)  <= FLASH_A_DQ(1);
--		  FPGA_data(5)  <= FLASH_A_DQ(2);
--		  FPGA_data(4)  <= FLASH_A_DQ(3);
--		  FPGA_data(3)  <= FLASH_A_DQ(4);
--		  FPGA_data(2)  <= FLASH_A_DQ(5);
--		  FPGA_data(1)  <= FLASH_A_DQ(6);
--		  FPGA_data(0)  <= FLASH_A_DQ(7);

		  FPGA_data(15)  <= FLASH_A_DQ(7);
		  FPGA_data(14)  <= FLASH_A_DQ(6);
		  FPGA_data(13)  <= FLASH_A_DQ(5);
		  FPGA_data(12)  <= FLASH_A_DQ(4);
		  FPGA_data(11)  <= FLASH_A_DQ(3);
		  FPGA_data(10)  <= FLASH_A_DQ(2);
		  FPGA_data(9)   <= FLASH_A_DQ(1);
		  FPGA_data(8)   <= FLASH_A_DQ(0);
		  
		  FPGA_data(7)  <= FLASH_A_DQ(15);
		  FPGA_data(6)  <= FLASH_A_DQ(14);
		  FPGA_data(5)  <= FLASH_A_DQ(13);
		  FPGA_data(4)  <= FLASH_A_DQ(12);
		  FPGA_data(3)  <= FLASH_A_DQ(11);
		  FPGA_data(2)  <= FLASH_A_DQ(10);
		  FPGA_data(1)  <= FLASH_A_DQ(9);
		  FPGA_data(0)  <= FLASH_A_DQ(8);


    end if;
--    end if;		
  end process data_p; 

 
end structural;
