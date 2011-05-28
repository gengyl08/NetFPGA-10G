----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:10:11 05/04/2011 
-- Design Name: 
-- Module Name:    cpld_tb - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cpld_tb is
end cpld_tb;

architecture Behavioral of cpld_tb is




component CPLD
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

		LEDs 				  : out std_logic_vector(3 downto 0)
	) ;
end component;





signal clk              : std_logic := '1'; 
signal DONE             : std_logic; 
signal INIT_B           : std_logic; 
signal Program_B        : std_logic;
signal FPGA_CCLK        : std_logic;  -- clock for configuration
signal reboot           : std_logic := '0';  
signal FPGA_clock       : std_logic;  -- clock to the FPGA
signal FPGA_A           : std_logic_vector(22 downto 0); 
signal FPGA_data		   : std_logic_vector (15 downto 0);
signal FPGA_G			   : std_logic;	-- Active low output enable. Disables the Platform Flash data output.
signal FPGA_W			   : std_logic;	-- Active low write enable.Diables the Platform Flash write function.
signal FPGA_E			   : std_logic;	-- Active low chip enable. Disables the Platform Flash.
signal FPGA_L			   : std_logic;	-- Active low address latch enable. Disables the Platform Flash address latch.
signal FPGA_RP		  	   : std_logic;	-- Reset                      
signal FLASH_A_A        : std_logic_vector(23 downto 0);
signal FLASH_A_DQ       : std_logic_vector(15 downto 0);
signal FLASH_A_E	      : std_logic;
signal FLASH_A_G	      : std_logic;
signal FLASH_A_K        : std_logic;  -- clock to the Flash
signal FLASH_A_RP	      : std_logic;
signal FLASH_A_WP	      : std_logic;
signal FLASH_A_W	      : std_logic;
signal FLASH_A_L	      : std_logic;
signal FLASH_A_RW       : std_logic;
signal LEDs 				: std_logic_vector(3 downto 0);


begin

 clk <= not clk after 20ns;

CPLD1 : CPLD
	port map ( 
		CPLD_100MHZ      => clk,
      DONE             => DONE,
      INIT_B           => INIT_B,
      Program_B        => Program_B,
      FPGA_CCLK        => FPGA_CCLK,
      reboot           => reboot,
		FPGA_clock       => FPGA_clock,
		FPGA_A           => FPGA_A,
		FPGA_data		  => FPGA_data,
		FPGA_G			  => FPGA_G,
		FPGA_W			  => FPGA_W,
		FPGA_E			  => FPGA_E,
		FPGA_L			  => FPGA_L,
		FPGA_RP		  	  => FPGA_RP,             
		FLASH_A_A        => FLASH_A_A,
      FLASH_A_DQ       => FLASH_A_DQ,
      FLASH_A_E	     => FLASH_A_E,
      FLASH_A_G	     => FLASH_A_G,
      FLASH_A_K        => FLASH_A_K,
      FLASH_A_RP	     => FLASH_A_RP,
      FLASH_A_WP	     => FLASH_A_WP,
      FLASH_A_W	     => FLASH_A_W,
      FLASH_A_L	     => FLASH_A_L,
      FLASH_A_RW       => FLASH_A_RW,
		LEDs 				  => LEDs
	);



  fpga_p : process(clk)
  begin
    reboot <= not reboot after 20000ns;
    INIT_B <= '1';
  end process;


end Behavioral;

