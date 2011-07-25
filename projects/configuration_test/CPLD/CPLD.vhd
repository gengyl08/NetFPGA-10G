------------------------------------------------------------------------
--
-- Project: NET FPGA Configuration
-- Date: April 2011
-- Designer: S. Friederich
--
------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity CPLD is 
  port (CPLD_100MHZ  : in    std_logic;  -- clock from oszillator
     -- FPGA Signals
        DONE         : in    std_logic; 
        INIT_B       : in    std_logic; 
        Program_B    : inout std_logic;
        FPGA_CCLK    : out   std_logic;  -- clock for configuration
        reboot       : in    std_logic;  
        FPGA_clock   : out   std_logic;  -- clock to the FPGA
        FPGA_A       : in    std_logic_vector (23 downto 0);
        FPGA_data    : inout std_logic_vector (15 downto 0);
        FPGA_G       : in    std_logic;	-- Active low output enable. Disables the Platform Flash data output.
        FPGA_W       : in    std_logic;	-- Active low write enable.Diables the Platform Flash write function.
        FPGA_E       : in    std_logic;	-- Active low chip enable. Disables the Platform Flash.
        FPGA_L       : in    std_logic;	-- Active low address latch enable. Disables the Platform Flash address latch.
     --   FPGA_RP      : in    std_logic;	-- Reset           
     -- Flash Signals            
        FLASH_A_A    : out   std_logic_vector(23 downto 0);
        FLASH_A_DQ   : inout std_logic_vector(15 downto 0);
        FLASH_A_E    : out   std_logic;
        FLASH_A_G    : out   std_logic;
        FLASH_A_K    : out   std_logic;  -- clock to the Flash
        FLASH_A_RP   : out   std_logic;
        FLASH_A_WP   : out   std_logic;
        FLASH_A_W    : out   std_logic;
        FLASH_A_L    : out   std_logic;
        FLASH_A_RW   : inout std_logic;
	 	
--        FLASH_B_A    : out   std_logic_vector(23 downto 0);
        FLASH_B_DQ   : inout std_logic_vector(15 downto 0);
        FLASH_B_E    : out   std_logic;
        FLASH_B_G    : out   std_logic;
        FLASH_B_K    : out   std_logic;  -- clock to the Flash
        FLASH_B_RP   : out   std_logic;
        FLASH_B_WP   : out   std_logic;
        FLASH_B_W    : out   std_logic;
        FLASH_B_L    : out   std_logic;
        FLASH_B_RW   : inout std_logic; 
        LEDs         : out   std_logic_vector(3 downto 0)) ;
end CPLD;

architecture structural of CPLD is 
  signal Prog_B_Reg : std_logic;
  signal Init_b_Reg : std_logic;
  signal FPGAData             : std_logic_vector (15 downto 0);
  signal FLASH_A_DQ_buffered  : std_logic_vector (15 downto 0);
  signal FPGA_data_buffered   : std_logic_vector (15 downto 0);
  signal Flash_A_G_buffered   : std_logic;
  signal Flash_A_G_buffered_2 : std_logic;

    -- clocks
  signal clk100_i : std_logic := '0';
  signal clk50_i  : std_logic := '0';
  signal clk25_i  : std_logic;	
  signal clk125_i : std_logic;	
	
  signal clk_cnt_i  : std_logic_vector(24 downto 0) := "0000000000000000000000000";	
	
  signal config_cnt : std_logic_vector (1 downto 0);
--
--  attribute PULLUP : string;
--  attribute PULLUP of FLASH_A_RW : signal is "YES";

  signal ConfProceed     : std_logic;
  signal PrevConfProceed : std_logic;
  signal PrevInit_B      : std_logic;
  signal Top16Bits       : std_logic;
  signal CCLK            : std_logic;
  signal PrevCCLK        : std_logic;
  signal AlternateCycle  : std_logic;
  signal FlashAddress    : unsigned (23 downto 0);
  signal SendAddress     : std_logic;
  signal pause           : unsigned (19 downto 0);
  signal DelayedPause    : std_logic;
  signal FLASH_AK        : std_logic;
  signal BootSelect      : std_logic := '0';
  signal clk : std_logic;
  signal BootCount       : unsigned (19 downto 0);
  signal OldBoot         : std_logic;
  signal GotReboot       : std_logic := '0';
  signal WasDone         : unsigned (15 downto 0) := (others => '0');
begin

--------------------------- clock generation --------------------------------------------

--  FLASH_B_DQ <= (others => '0');
--  FLASH_B_A  <= (others => '0');
--  FLASH_B_E <= '1';
--  FLASH_B_G <= '1';
--  FLASH_B_K <= '1';
--  FLASH_B_L <= '1';
--  FLASH_B_W <= '1';
--  FLASH_B_RP <= '0';
--  FLASH_B_RW <= '1';
--  FLASH_B_WP <= '1';
--  FPGA_clock <= '0';
  

  clk50_i <= clk_cnt_i(0);
  clk25_i <= clk_cnt_i(1);
  clk125_i <= clk_cnt_i(2);
--clk125_i <= FPGA_CCLK;
  clk100_i <= CPLD_100MHZ;

  clk <= clk25_i when done = '1' else clk100_i;

  clk_chk_p: process(clk100_i)
    begin 
      if clk100_i'event and clk100_i='1'
      then
        clk_cnt_i <= clk_cnt_i + 1;
      end if;
    end process;

--  clk_chk_p: process(clk125_i)
--    begin
--      if clk125_i'event and clk125_i='1' then
--        clk_cnt_i <= clk_cnt_i + 1;

--    end if;
--  end process;

--	FPGA_CCLK       <= not clk125_i;
--	FPGA_clock      <= clk125_i;
--	FLASH_A_K		 <= clk100_i;--clk125_i;	   

-- FLASH_A_A(23)    <= '0';

-- FPGA_W <= '0';

  LEDs(0) <= Program_B;
  LEDs(1) <= INIT_B;
  LEDs(2) <= Reboot;
  LEDs(3) <= BootSelect;--ConfProceed;--ByteSelect(0);--FPGA_E;--STATECOUNT(0);--FLASH_A_DQ(0);

  FPGA_CCLK  <= not clk or not ConfProceed;-- and not done;
  FPGA_clock <=     clk;
  
--------------------------- flash signals --------------------------------------------

  data_p: process (clk,
                   --reboot,
						 Init_B,
						 PrevInit_B,
						 Flash_A_G_buffered, 
						 FLASH_A_DQ_buffered, 
						 FPGA_data_buffered, 
						 FLASH_A_DQ,
						 FLASH_B_DQ,
             WasDone)
  begin
--    Program_B     <= 'Z';--1
    if clk'event and clk='1'
    then
      Init_b_Reg <= Init_b;
      Prog_b_reg <= Program_b;
      OldBoot <= Reboot;
      if (OldBoot = '1') and (reboot = '0') and (done = '1')
	    then
		    BootCount <= x"cf000";
        Program_B <= '0';
      else
        if BootCount /= conv_unsigned (0, 20)
        then
          BootCount <= BootCount - conv_unsigned (1, 20);
        else
          Program_B <= 'Z';
        end if;
      end if;
		
      if Done = '1'
      then
        if WasDone (15) = '0'
        then
          WasDone <= WasDone + conv_unsigned (1, 16);
        end if;
      end if;
	 
      if (OldBoot = '1') and 
         (reboot = '0') and 
         (WasDone (15) = '1')
      then
        BootSelect <= '1';
      end if;

	   if done = '1'
     then
	     FLASH_A_L              <= FPGA_L; 
	     FLASH_B_L              <= FPGA_L; 
		   FLASH_A_WP		       <= '1';    -- Write potect
		   FLASH_B_WP		       <= '1';    -- Write potect
	     FLASH_A_A(23 downto 0) <= FPGA_A;
       FLASH_A_A(23)          <= '0';
	     FLASH_A_E		          <= FPGA_E or FPGA_A (23);
	     FLASH_B_E		          <= FPGA_E or not FPGA_A (23);
	     FLASH_A_G		          <= FPGA_G;
	     FLASH_B_G		          <= FPGA_G;
	     FLASH_A_RP	       	 <= '1';--FPGA_RP;
	     FLASH_B_RP	       	 <= '1';--FPGA_RP;
	     FLASH_A_W		          <= FPGA_W;
	     FLASH_B_W		          <= FPGA_W;
       if FPGA_A (23) = '0'
		   then
         FLASH_A_DQ_buffered	 <= FLASH_A_DQ;
       else
         FLASH_A_DQ_buffered	 <= FLASH_B_DQ;
       end if;
       FPGA_data_buffered 	 <= FPGA_data;
       Flash_A_G_buffered 	 <= FPGA_G;
       Flash_A_G_buffered_2   <= Flash_A_G_buffered;
       FLASH_A_RW             <= '1';
       FLASH_B_RW             <= '1';
       config_cnt             <= "00";
        --Program_B              <= '1';
        --start_config           <= '1';
     else
       FLASH_A_E  <= '0';
       FLASH_A_G  <= '0';
       FLASH_A_W  <= '1';
       FLASH_A_L  <= '0'; 		
       FLASH_A_WP <= '1';    -- Write potect 		  
       FLASH_A_RW <= '1';
         
       FLASH_B_E  <= '0';
       FLASH_B_G  <= '0';
       FLASH_B_W  <= '1';
       FLASH_B_L  <= '0'; 		
       FLASH_B_WP <= '1';    -- Write potect 		  
       FLASH_B_RW <= '1';
         
       PrevConfProceed <= ConfProceed;

       PrevInit_B <= Init_B;
		 
       if (Init_b_Reg = '1') and (Prog_b_Reg = '1')
       then
         DelayedPause <= '1';
         ConfProceed  <= '1';
       else
		     DelayedPause <= '0';
         ConfProceed  <= '0';
       end if;
		 
--        if (Init_B = '1') and (PrevInit_B = '0')
--        then
--          DelayedPause <= '0';
--          ConfProceed <= '1';
--        elsif Program_B = '0'
--        then
--          DelayedPause <= '0';
--          ConfProceed <= '0';
--        end if;               -- sequence has ended!

       if ConfProceed = '1'   -- and only do ANYTHING until the reset
       then
--          if pause /= conv_unsigned (0, 20)
--          then
--            FLASH_A_RP <= '0';--Program_B;
--            FLASH_B_RP <= '0';--Program_B;
--            DelayedPause <= '1';
--            pause <= pause - conv_unsigned (1, 20);
--          else
--            delayedPause <= '0';
--            pause <= x"00000"; 
         FLASH_A_RP <= '1';--Program_B;
         FLASH_B_RP <= '1';--Program_B;
--          end if;
       else
         FLASH_A_RP <= '0';--Program_B;
         FLASH_B_RP <= '0';--Program_B;
--           pause <= x"fffff";
--          DelayedPause <= '1';
       end if;


       if ConfProceed = '0'--DelayedPause = '1'
       then
         FLASH_A_DQ_buffered <= x"ffff";
         FPGAData           <= x"ffff";
         FlashAddress(23 downto 0) <= (others => '0'); -- reset to zero
         AlternateCycle <= '0';                        -- as the first act
         SendAddress <= '0';
       else
         AlternateCycle <= not AlternateCycle;
	   
         if AlternateCycle = '0'
         then
           for i in 7 downto 0 loop
             FPGAData (i) <= FLASH_A_DQ_buffered (7 - i);
           end loop;
           FLASH_AK <= '0';
         else
           for i in 7 downto 0 loop
             FPGAData (i) <= FLASH_A_DQ_buffered (15 - i);
           end loop;
           if BootSelect = '0'
           then
             for i in 15 downto 0 loop
                FLASH_A_DQ_buffered (i) <= FLASH_A_DQ (i);
              end loop;
            else
              for i in 15 downto 0 loop
                FLASH_A_DQ_buffered (i) <= FLASH_B_DQ (i);
              end loop;
            end if;
            FLASH_AK <= '1';
          end if;
        end if;
      end if;
    end if;
  end process data_p;

  FLASH_A_K <= FLASH_AK when (done = '0')
                 else
               clk;

  FLASH_B_K <= FLASH_AK when (done = '0')
                 else
               clk;

  FPGA_data <= FPGAData            when (done = '0')
                 else
               FLASH_A_DQ_buffered when (Flash_A_G_buffered='0') 
                 else
					(others => 'Z'); -- Flash sending data
					
  FLASH_A_DQ <= (others => 'Z')    when (done = '0')
                  else
                FPGA_data_buffered when (Flash_A_G_buffered='1')
					   else
                (others => 'Z'); -- FPGA sending data   

  FLASH_B_DQ <= (others => 'Z')    when (done = '0')
                  else
                FPGA_data_buffered when (Flash_A_G_buffered='1')
					   else
                (others => 'Z'); -- FPGA sending data   

end structural;
 


