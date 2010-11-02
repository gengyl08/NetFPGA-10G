-- cpld test image for synthesis and simulation of
-- the configuration circuit of the NetFPGA10G board
-- M.Blott
-- 9th Feb 2010

-- for simulation FLASH_X_RW need to be assigned to '1'


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity cpld is 
        port ( 
            CPLD_100MHZ      : in std_logic; 
            PGOOD2V5         : in std_logic; 
            PGOOD1V0         : in std_logic;
            PGOOD3V3         : in std_logic;
            PGOOD1V8         : in std_logic;            
            PGOOD1V5         : in std_logic;
            PERST            : in std_logic;
            LED              : out std_logic_vector(8 downto 5);
            DONE             : in std_logic;
            FPGA_CCLK        : out std_logic;
            INIT             : inout std_logic;
            PROG             : out std_logic;
            FPGA_RS          : out std_logic_vector(1 downto 0);
            FPGA_A           : out std_logic_vector(23 downto 0); 
            FPGA_DQ          : out std_logic_vector(15 downto 0); 
            FPGA_IOL9P       : out std_logic; 
            FPGA_FWE         : out std_logic;
            FPGA_FOE         : out std_logic;
            FPGA_FCS         : out std_logic;
            --NEW_PROG_REQST_Z : out std_logic;  --> FPGA_RST
            --PROM_RELOAD_Z    : out std_logic;  --> FPGA_CLK
            FPGA_CLK         : out std_logic;
            FPGA_RST         : out std_logic;            
            FLASH_A          : out std_logic_vector(23 downto 0);
            FLASH_A_DQ       : inout std_logic_vector(15 downto 0);
            FLASH_A_E_B      : out std_logic;
            FLASH_A_G_B      : out std_logic;
            FLASH_A_K        : out std_logic;
            FLASH_A_RP_B     : out std_logic;
            FLASH_A_WP_B     : out std_logic;
            FLASH_A_W_B      : out std_logic;
            FLASH_A_L_B      : out std_logic;
            FLASH_A_RW       : inout std_logic;        
            FLASH_B_DQ       : inout std_logic_vector(15 downto 0);
            FLASH_B_E_B      : out std_logic;
            FLASH_B_G_B      : out std_logic;
            FLASH_B_K        : out std_logic;
            FLASH_B_RP_B     : out std_logic;
            FLASH_B_WP_B     : out std_logic;
            FLASH_B_W_B      : out std_logic;
            FLASH_B_L_B      : out std_logic;
            FLASH_B_RW       : inout std_logic
        ) ;
end cpld;

architecture structural of cpld is 

    -- check signals
    signal check_pwr_rst_i : std_logic;
    signal check_clk_i : std_logic;
    signal check_flash : std_logic;
    -- synchronous resets
    signal rst100_i : std_logic;
    signal rst50_i : std_logic;
    signal rst25_i : std_logic;
    -- clocks
    signal clk100_i : std_logic := '0';
    signal clk50_i : std_logic := '0';
    signal clk25_i : std_logic;
    -- misc
    signal clk_cnt_i : std_logic_vector(24 downto 0) := "0000000000000000000000000";
    signal fpga_sr_i : std_logic_vector(42 downto 0);
    -- flash i/f
    signal ctl_sm_i : std_logic_Vector(15 downto 0) := x"0000";
    signal flash_a_i : std_logic_vector(23 downto 0);
    signal flash_d_i : std_logic_Vector(15 downto 0);
    signal flash_e_b_i : std_logic;
    signal flash_g_b_i : std_logic;
    signal flash_w_b_i : std_logic;
    signal flash_l_b_i : std_logic;
    signal dat_reg : std_logic_vector(31 downto 0);
    
    attribute PULLUP: string;
    attribute PULLUP of PGOOD1V0: signal is "YES";
    attribute PULLUP of PGOOD1V5: signal is "YES";
    attribute PULLUP of PGOOD1V8: signal is "YES";
    attribute PULLUP of PGOOD2V5: signal is "YES";
    attribute PULLUP of PGOOD3V3: signal is "YES";	 
	 
    begin




    -- test signals
    LED(5) <= check_pwr_rst_i and check_clk_i; -- should flash
    LED(6) <= check_flash;              --on
    LED(7) <= DONE;                     --on once FPGA is programmed
    LED(8) <= PERST;                    -- =PERST

    -- FPGA config
    FPGA_CCLK <= 'Z';
    PROG <= 'Z';

--------------------------- clock generation --------------------------------------------

   clk50_i <= clk_cnt_i(0);
   clk25_i <= clk_cnt_i(1);
   clk100_i <= CPLD_100MHZ;

--------------------------- CLOCK CHECK -------------------------------------------------

   check_clk_i <= clk_cnt_i(24);
   clk_chk_p: process(clk100_i)
   begin
      if clk100_i'event and clk100_i='1' then
         clk_cnt_i <= clk_cnt_i + 1;
      end if;
   end process;
    
--------------------------- internal reset generation -----------------------------------

   rst100_p: process(clk100_i)
   begin
      if clk100_i'event and clk100_i='1' then
         rst100_i <= PGOOD1V0 and PGOOD1V5 and PGOOD1V8 and PGOOD2V5 and PGOOD3V3;-- and PERST;
      end if;
   end process;

   rst50_p: process(clk50_i)
   begin
      if clk50_i'event and clk50_i='1' then
         rst50_i <= PGOOD1V0 and PGOOD1V5 and PGOOD1V8 and PGOOD2V5 and PGOOD3V3;-- and PERST;
      end if;
   end process;

   rst25_p: process(clk25_i)
   begin
      if clk25_i'event and clk25_i='1' then
         rst25_i <= PGOOD1V0 and PGOOD1V5 and PGOOD1V8 and PGOOD2V5 and PGOOD3V3;-- and PERST;
      end if;
   end process;

--------------------------- POWER AND RESET CHECK ---------------------------------------

   check_pwr_rst_i <= PGOOD1V0 and PGOOD1V5 and PGOOD1V8 and PGOOD2V5 and PGOOD3V3;--
    --and PERST;
   FPGA_RS(1) <= check_pwr_rst_i;
   FPGA_RS(0) <= PERST;

--------------------------- FPGA I/F ----------------------------------------------------

   -- pass rst and clk over to FPGA for synchonously ruynning circuit
   FPGA_CLK <= clk100_i;
   FPGA_RST <= rst100_i;
   
   -- implement shifters in CPLD which are connected in parallel over all IOs to FPGA
   -- and implement a check circuit inside the FPGA which checks
   -- that new values are +1 from previously latched value

   FPGA_A           <= fpga_sr_i(42 downto 19);
   FPGA_DQ          <= fpga_sr_i(18 downto 3);
   FPGA_FWE         <= fpga_sr_i(2);
   FPGA_FOE         <= fpga_sr_i(1);
   FPGA_FCS         <= fpga_sr_i(0);
    
   -- for flash debug
--   FPGA_A(23 downto 0) <= flash_a_i(23 downto 0);
--   FPGA_DQ             <= ctl_sm_i(15 downto 0);
--   FPGA_FCS            <= flash_e_b_i;
    
   fpga_chk_p: process(clk100_i)
   begin
      if clk100_i'event and clk100_i='1' then
         if (rst100_i = '0') then
            fpga_sr_i(42 downto 0) <= x"00000000" & "00000000001";
         else
            fpga_sr_i(42 downto 0) <= fpga_sr_i(41 downto 0) & fpga_sr_i(42);
         end if;
      end if;
   end process;
   
--------------------------- FLASH I/F ----------------------------------------------------

   FPGA_IOL9P  <= check_flash;

   FLASH_A(23) <= 'Z';                  -- NC
   FLASH_A(22 downto 0) <= flash_a_i(22 downto 0);  -- 22:19 bank sel

   FLASH_A_K <= clk50_i;
   FLASH_A_WP_B <= '1';                 -- write protect
   FLASH_A_DQ <= flash_d_i;
   FLASH_A_E_B <= flash_e_b_i;
   FLASH_A_G_B <= flash_g_b_i;
   FLASH_A_W_B <= flash_w_b_i;
   FLASH_A_L_B <= flash_l_b_i;
   FLASH_A_RW <= 'Z';                   -- external pullup, for sim use '1'
    
   FLASH_B_K <= clk50_i;
   FLASH_B_WP_B <= '1';                 -- write protect
   FLASH_B_DQ <= flash_d_i;
   FLASH_B_E_B <= flash_e_b_i;
   FLASH_B_G_B <= flash_g_b_i;
   FLASH_B_W_B <= flash_w_b_i;
   FLASH_B_L_B <= flash_l_b_i;
   FLASH_B_RW <= 'Z';                   -- external pullup, for sim use '1'
    
   flash_chk_p: process(clk50_i)
   begin
      if clk50_i'event and clk50_i='1' then

        -- control state machine
        ctl_sm_i <= ctl_sm_i + 1; 

        -- defaults
        flash_a_i(23 downto 19) <= '0' & x"F";  --bank
        flash_a_i(18 downto 16) <= "000";  --block
        flash_a_i(15 downto 3) <= "0000000000000";
        -- selects register offset
        flash_a_i(2 downto 0) <= ctl_sm_i(9 downto 7);
        flash_d_i <= (others => 'Z');        
        flash_e_b_i <= '1';
        flash_g_b_i <= '1';
        flash_w_b_i <= '1';
        flash_l_b_i <= '1';
        FLASH_A_RP_B <= '0';
        FLASH_B_RP_B <= '0';
        -- between 0 and FF inactive for start-up/reset
        -- flash is reset periodically for self test
        if ctl_sm_i > x"03FF" then
          FLASH_A_RP_B <= '1';
          FLASH_B_RP_B <= '1';
           -- each 64 cycles change bank
           -- bank select is address 22:19
           -- 15=bank0, 0=bank15 :o)
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
           elsif ctl_sm_i(6 downto 0) = "000" & x"2" then
               flash_d_i <= x"0090";
               flash_e_b_i <= '1';
               flash_g_b_i <= '1';
               flash_w_b_i <= '1';
               flash_l_b_i <= '1';
           elsif ctl_sm_i(6 downto 0) = "000" & x"3" then
               flash_d_i <= x"0090"; 
               flash_e_b_i <= '0';
               flash_g_b_i <= '0';
               flash_w_b_i <= '1';
               flash_l_b_i <= '0';              
           elsif ctl_sm_i(6 downto 0) > "0000011" and ctl_sm_i(6 downto 0) < "0111111" then
               flash_e_b_i <= '0';
               flash_g_b_i <= '0';
               flash_w_b_i <= '1';
               flash_l_b_i <= '1';              
           elsif ctl_sm_i(6 downto 0) = "0111111" then
               dat_reg <= FLASH_A_DQ & FLASH_B_DQ;
           elsif ctl_sm_i(6 downto 0) = "1000000" then
               if ctl_sm_i(9 downto 7) = "000" then
                 if dat_reg = x"00490049"  then
                -- if dat_reg = x"00200020" then  -- sim value
                     check_flash <= '1';
                 else
                     check_flash <= '0';
                 end if;
               end if;
           end if;
        end if;
      end if;
   end process;
        
end structural;
