-----------------------------------------------------------------------
-- RLDRAM stress test
-- Michaela Blott
-- May 2010
--
-----------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity stress_test_bench is 
generic (
   SIMULATION_ONLY : std_logic := '1'
);
Port (
   clk           : in  STD_LOGIC;
   rst           : in  STD_LOGIC;
   init_done     : in std_logic;
   -- add if
   ap_adr        : out std_logic_vector(25 downto 0);
   ap_valid      : out std_logic;
   ap_full       : in std_logic;
   ap_empty      : in std_logic;
   app_almost_full : in std_logic;
   write_data    : out std_logic_vector(143 downto 0); --apWriteData,
   write_valid   : out std_logic;                    -- apWriteDValid, // write data valid
   write_full    : in std_logic;                     ---rlWdfFull,  // write data ffo full
   write_empty   : in std_logic;
   write_almost_full : in std_logic;
   read_data     : in std_logic_vector(143 downto 0);  --rldReadData,
   read_valid    : in std_logic;
   read_empty    : in std_logic;
   apRdfRdEn     : out std_logic;           -- read from read data fifo
   PASS_FAIL     : out std_logic_vector(2 downto 0);
   write_cnt     : in std_logic_vector(12 downto 0);
   write_word_cnt: in std_logic_vector(12 downto 0);
   app_cnt       : in std_logic_vector(12 downto 0);
   app_word_cnt  : in std_logic_vector(12 downto 0);

   -- hardwired
   apConfWrD         : out std_logic_vector(7 downto 0);
   apConfRd          : out std_logic;
   apConfWr          : out std_logic;
   apWriteDM         : out std_logic_vector(3 downto 0);
   issueMRS          : out std_logic;
   issueCalibration  : out std_logic
   );
end stress_test_bench;


architecture Behavioral of stress_test_bench is

signal sm             : std_logic_Vector(25 downto 0);
signal adr_cnt        : std_logic_vector(22 downto 0);
signal rd             : std_logic;
signal data_reg       : std_logic_vector(143 downto 0);
signal data_reg_old   : std_logic_vector(143 downto 0);
signal data_ok        : std_logic;
signal data_ok_sticky : std_logic;
signal data_reg_valid : std_logic;
signal compare_data   : std_logic;
signal compare_result : std_logic;
signal result_1       : std_logic_Vector(15 downto 0);
signal result_2       : std_logic;
signal init_data_reg  : std_logic;
signal write_valid_i  : std_logic;
signal write_data_i   : std_logic_Vector(143 downto 0);
signal ap_valid_i     : std_logic;
signal ap_adr_i       : std_logic_vector(25 downto 0);
signal app_afull      : std_logic;
signal write_afull    : std_logic;

-- James: register the time consuming signals!
signal write_almost_full_r : std_logic;
signal app_almost_full_r   : std_logic;
signal read_empty_r        : std_logic;
signal ap_empty_r          : std_logic;
signal write_empty_r       : std_logic;

begin

write_data  <= write_data_i;
write_valid <= write_valid_i;

-- hardwired signals (taken over by old RLDRAM testbench)
apConfWrD <= x"00";
apConfRd <= '0';
apConfWr <= '0';
apWriteDM <= "0000";
issueMRS    <= '0';
issueCalibration <= '0';
ap_adr      <= ap_adr_i;
ap_valid    <= ap_valid_i;

--ila_data(255 downto 243) <= app_cnt;
--ila_data(242 downto 230) <= app_word_cnt;
--ila_data(155 downto 143) <= write_cnt;
--ila_data(142 downto 130) <= write_word_cnt;

ila_p : process(clk)
begin
   if (clk'event and clk='1') then
      PASS_FAIL <= (rst or (not init_done)) & (data_ok_sticky and not (rst or (not init_done)))& (not data_ok_sticky and not (rst or (not init_done)));
--		ila_data(0) <= init_done;
--		ila_data(1) <= data_ok;
--		ila_data(29 downto 2) <= sm(27 downto 0);
--		ila_data(101 downto 39) <= write_data_i(62 downto 0);
--		ila_data(102) <= write_valid_i;
--		ila_data(128 downto 103) <= ap_adr_i;
--		ila_data(129) <= ap_valid_i;
--		ila_data(201 downto 130) <= data_reg(71 downto 0);
--		ila_data(217 downto 202) <= result_1;
--		ila_data(218) <= result_2;
--		ila_data(219) <= compare_result;
--		ila_data(220) <= compare_data;
--		ila_data(221) <= rst;
--		ila_data(30) <= app_afull;
--		ila_data(31) <= write_afull;
--		ila_data(32) <= app_almost_full;
--		ila_data(33) <= write_almost_full;
--		ila_data(34) <= ap_empty;
--		ila_data(35) <= write_empty;
--		ila_data(36) <= read_empty;
--		ila_data(37) <= ap_full;
--		ila_data(38) <= write_full;
        write_almost_full_r <= write_almost_full;
        app_almost_full_r   <= app_almost_full;
        read_empty_r        <= read_empty;
        write_empty_r       <= write_empty;
        ap_empty_r          <= ap_empty;
   end if;
end process;



sm_p : process(clk)
begin
   if (clk'event and clk='1') then
      if (rst='1' or init_done='0') then
         sm <= "11" & x"000000";--(others => '0'); Go into IDLE state for a while
         write_data_i <= (others => '0');
         write_valid_i <= '0';
         ap_valid_i <= '0';
         init_data_reg <= '0';
         ap_adr_i <= (others => '0');
      else
         init_data_reg <= '0';
         if (sm(25 downto 24) = "00") then -- & x"000000") then
            -- first write the whole memory area
            ap_adr_i <= "000" & sm(23 downto 1);
            write_data_i(71 downto 0) <= '0' & sm(7 downto 0) & '0' & sm(7 downto 0) & '0' & sm(7 downto 0) & '0' & sm(7 downto 0) & '0' & sm(7 downto 0) & '0' & sm(7 downto 0) & '0' & sm(7 downto 0) & '0' & sm(7 downto 0);
            write_data_i(143 downto 72) <= '0' & sm(7 downto 0) & '0' & sm(7 downto 0) & '0' & sm(7 downto 0) & '0' & sm(7 downto 0) & '0' & sm(7 downto 0) & '0' & sm(7 downto 0) & '0' & sm(7 downto 0) & '0' & sm(7 downto 0);
            write_valid_i <= (not app_almost_full_r) and (not write_almost_full_r);
            ap_valid_i <= sm(0) and (not app_almost_full_r) and (not write_almost_full_r); -- write every second tick
            if (app_almost_full_r='1' or write_almost_full_r='1') then
               sm <= sm;
            else
               sm <= sm + 1;
            end if;
         elsif (sm(25 downto 24) = "01" and sm(9 downto 0) < x"200") then -- (sm < "01" & x"000200") then
            -- pause until all clear
            ap_adr_i <= ap_adr_i;--"000" & sm(23 downto 1);
            if (ap_empty_r='0' or write_empty_r='0' or read_empty_r='0') then
               sm <= sm;
            elsif (sm = "01" & x"0001FF") then
               sm <= "10" & x"000000";
            else
               sm <= sm + 1;
            end if;
            write_valid_i <= '0';
            ap_valid_i <= '0';
         elsif (sm(25 downto 24) = "10") then -- (sm < "11" & x"000000") then
            -- now read the whole lot back
            ap_adr_i <= "010" & sm(23 downto 1);
            write_valid_i <= '0';
            ap_valid_i <= sm(0) and (not app_almost_full_r) and (not write_almost_full_r); -- write every second tick
            if (app_almost_full_r='1' or write_almost_full_r='1') then
               sm <= sm;
            else
               sm <= sm + 1;
            end if;
         elsif (sm(25 downto 24) = "11" and sm(9 downto 0) < x"200") then --  (sm < "11" & x"000200") then
            -- pause until all clear
            ap_adr_i <= ap_adr_i;--"010" & sm(23 downto 1);
            if (ap_empty_r='0' or write_empty_r='0' or read_empty_r='0') then
               sm <= sm;
            elsif (sm = "11" & x"0001FF") then
               sm <= "00" & x"000000";
            else
               sm <= sm + 1;
            end if;
            write_valid_i <= '0';
            ap_valid_i <= '0';
         else
            ap_adr_i <= ap_adr_i;--"000" & sm(23 downto 1);
            write_valid_i <= '0';
            ap_valid_i <= '0';
            init_data_reg <= '1';
            sm <= "00" & x"000000";
         end if;
      end if;
   end if;
end process;


chk_p : process(clk)
begin
   if (clk'event and clk='1') then
      if (rst='1' or init_done='0') then
         apRdfRdEn <= '0';
         compare_data <= '0';
         compare_result <= '0';
         result_1(15 downto 0) <= x"FFFF";
         result_2 <= '1';
         data_ok <= '1';
         data_ok_sticky <= '1';
         data_reg_old <= '0' & x"FF" & '0' & x"FF" &'0' & x"FF" &'0' & x"FF" &'0' & x"FF" &'0' & x"FF" &'0' & x"FF" &'0' & x"FF" &
         '0' & x"FF" &'0' & x"FF" &'0' & x"FF" &'0' & x"FF" &'0' & x"FF" &'0' & x"FF" &'0' & x"FF" &'0' & x"FF";
      else
         if (init_data_reg = '1') then
            data_reg_old <= '0' & x"FF" & '0' & x"FF" &'0' & x"FF" &'0' & x"FF" &'0' & x"FF" &'0' & x"FF" &'0' & x"FF" &'0' & x"FF" &
                        '0' & x"FF" &'0' & x"FF" &'0' & x"FF" &'0' & x"FF" &'0' & x"FF" &'0' & x"FF" &'0' & x"FF" &'0' & x"FF";
         end if;
         apRdfRdEn <=not read_empty;
         compare_data <= read_valid;
         if (read_valid='1') then
            data_reg(143 downto 72) <= '0' & read_data(142 downto 135) & '0' & read_data(133 downto 126) & '0' & read_data(124 downto 117) & '0' & read_data(115 downto 108)
            & '0' & read_data(106 downto 99) & '0' & read_data(97 downto 90) & '0' & read_data(88 downto 81) & '0' & read_data(79 downto 72);
            data_reg(71 downto 0) <= '0' & read_data(70 downto 63) & '0' & read_data(61 downto 54) & '0' & read_data(52 downto 45) & '0' & read_data(43 downto 36)
            & '0' & read_data(34 downto 27) & '0' & read_data(25 downto 18) & '0' & read_data(16 downto 9) & '0' & read_data(7 downto 0);
         end if;
         if (compare_data='1') then
            data_reg_old <= data_reg;
            for i in 0 to 15 loop
               if (data_reg(i*9+7 downto i*9) = data_reg_old(i*9+7 downto i*9) + 1) then
                  result_1(i) <= '1';
               else
                  result_1(i) <= '0';
               end if;
            end loop;
         end if;
         compare_result <= compare_data;
         if (compare_result='1') then
            if (result_1(15 downto 0)=x"FFFF") then
               data_ok <= '1';
					data_ok_sticky <= data_ok_sticky;
            else
               data_ok <= '0';
					data_ok_sticky <= '0';
            end if;
         end if;
     end if;
     end if;
end process;

end Behavioral;




