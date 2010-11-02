-- cpld if test
-- M.Blott
-- 9th Feb 2010

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
library UNISIM;
use UNISIM.Vcomponents.all;


entity cpld_test is
        port (
            -- config i/f on bank 0 mimicked in misc_gen
            FPGA_RS          : in std_logic_vector(1 downto 0);   -- pwrok and PERST
            FPGA_A           : in std_logic_vector(23 downto 0);
            FPGA_DQ          : in std_logic_vector(15 downto 0);
            FPGA_IOL9P       : in std_logic;
            FPGA_FWE         : in std_logic;
            FPGA_FOE         : in std_logic;
            FPGA_FCS         : in std_logic;
            --NEW_PROG_REQST_Z : in std_logic;  --> FPGA_RST
            --PROM_RELOAD_Z    : in std_logic;  --> FPGA_CLK
            FPGA_CLK         : in std_logic;
            FPGA_RST         : in std_logic;
            CPLD_IF_OK       : out std_logic;
            CPLD_PWR_OK      : out std_logic;
				CPLD_FLASH_OK    : out std_logic
        ) ;
end cpld_test;

architecture structural of cpld_test is

    component bufg
      port (
        I : in std_logic;
        O : out std_logic
       );
    end component;

    -- misc
    signal check_cpld_io_i : std_logic;
    signal rst_i : std_logic;
    signal clk_i : std_logic;
    signal cpld_io_reg1_i : std_logic_vector(42 downto 0);
    signal cpld_io_reg2_i : std_logic_vector(42 downto 0);

begin

-------------------------- test outputs ---------------------------------------
   CPLD_IF_OK <= check_cpld_io_i;
   CPLD_PWR_OK <= FPGA_RS(1);
	CPLD_FLASH_OK <= FPGA_IOL9P;
	clk_i <= FPGA_CLK;
    
-------------------------- latch rst for meta stability --------------------------------
   rst_p: process(clk_i)
   begin
      if clk_i'event and clk_i='1' then
         rst_i <= FPGA_RST;
      end if;
   end process;

--------------------------- global clock buffer -------------------------

   -- buf_i : bufg
   --   port map (
   --     I => FPGA_CLK,
   --     O => clk_i
   --   );
    
--------------------------- CHECK CPLD IO --------------------------------------------

   -- latch all inputs and check that they shift every cycle
   cpld_p: process(clk_i)
   begin
      if clk_i'event and clk_i='1' then
         -- latch once for meta stability
         cpld_io_reg1_i <= FPGA_A & FPGA_DQ & FPGA_FWE & FPGA_FOE & FPGA_FCS;-- & NEW_PROG_REQST_Z & PROM_RELOAD_Z;
         -- latch again to compare
         cpld_io_reg2_i <= cpld_io_reg1_i;
         -- check
         if cpld_io_reg1_i = cpld_io_reg2_i(41 downto 0) & cpld_io_reg2_i(42) then
            check_cpld_io_i <= '1';
         else
            check_cpld_io_i <= '0';
         end if;
      end if;
   end process;


end structural;
