-- Xilinx, Inc. - Proprietary.  Use pursuant to Company instructions.
---------------------------------------------------------------------------------
-- Michaela Blott
-- 
-- Description:
-- Hardware component that generates and checks packets
--
-- May 2010
---------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity nf10_axis_gen_check is
generic (
   C_M_AXIS_DATA_WIDTH : integer := 64;
   C_S_AXIS_DATA_WIDTH : integer := 64   
);
port (
   ACLK               : in  std_logic;
   ARESETN            : in  std_logic;
   M_AXIS_TDATA       : out std_logic_vector (C_M_AXIS_DATA_WIDTH-1 downto 0);
   M_AXIS_TSTRB       : out std_logic_vector (C_M_AXIS_DATA_WIDTH/8-1 downto 0);
   M_AXIS_TVALID      : out std_logic;
   M_AXIS_TREADY      : in  std_logic;
   M_AXIS_TLAST       : out std_logic;
   S_AXIS_TDATA       : in  std_logic_vector (C_S_AXIS_DATA_WIDTH-1 downto 0);
   S_AXIS_TSTRB       : in  std_logic_vector (C_S_AXIS_DATA_WIDTH/8-1 downto 0);
   S_AXIS_TVALID      : in  std_logic;
   S_AXIS_TREADY      : out std_logic;
   S_AXIS_TLAST       : in  std_logic		
);
end nf10_axis_gen_check;

architecture structural of nf10_axis_gen_check is

   signal gen_state          : std_logic_vector(15 downto 0);
   signal check_state        : std_logic_vector(15 downto 0);
   signal tx_count           : std_logic_vector(31 downto 0);
   signal rx_count           : std_logic_vector(31 downto 0);
   signal err_count          : std_logic_vector(31 downto 0);
   signal ok                 : std_logic;
   signal last_data_plus_one : std_logic_vector(3 downto 0);	
   
begin

gen_p: process(ACLK)
begin
   if (ARESETN='0') then
      gen_state <= (others => '0');
      tx_count <= (others => '0');
   elsif (ACLK = '1' and ACLK'event) then
      case gen_state is
      when x"0000" =>
         M_AXIS_TDATA <= (others => '0');
			M_AXIS_TSTRB <= (others => '0');
			M_AXIS_TVALID <= '0';
			M_AXIS_TLAST <= '0';
         if (M_AXIS_TREADY='1') then
            gen_state <= gen_state + 1;
         end if;
      when x"0001"|x"0002"|x"0003"|x"0004"|x"0005"|x"0006"|x"0007"|x"0008" =>
         for i in 0 to C_M_AXIS_DATA_WIDTH/8 -1 loop
            M_AXIS_TDATA(i+7 downto i) <= gen_state(3 downto 0) & gen_state(3 downto 0);
         end loop;
         M_AXIS_TSTRB <= (others => '1');
         M_AXIS_TVALID <= '1';
         M_AXIS_TLAST <= '0';
         if (M_AXIS_TREADY='1') then
            gen_state <= gen_state + 1;
         end if;	
      when x"0009" =>
         for i in 0 to C_M_AXIS_DATA_WIDTH/8 -1 loop
            M_AXIS_TDATA(i+7 downto i) <= gen_state(3 downto 0) & gen_state(3 downto 0);
         end loop;
         M_AXIS_TSTRB <= (others => '1');
         M_AXIS_TVALID <= '1';
         M_AXIS_TLAST <= '1';
         if (M_AXIS_TREADY='1') then
            tx_count <= tx_count + 1;	
            gen_state <= gen_state + 1;
         end if;	
      when x"000F" =>
         M_AXIS_TDATA <= (others => '0');
         M_AXIS_TSTRB <= (others => '0');
         M_AXIS_TVALID <= '0';
         M_AXIS_TLAST <= '0';
         gen_state <= (others => '0');		      		
      when others =>
         M_AXIS_TDATA <= x"0000000000000000";
         M_AXIS_TSTRB <= x"00";
         M_AXIS_TVALID <= '0';
         M_AXIS_TLAST <= '0';
         gen_state <= gen_state + 1;	
      end case;	
   end if;
end process;

S_AXIS_TREADY <= '1';
check_p: process(ACLK)
begin
   if (ARESETN='0') then
      check_state <= (others => '0');
      rx_count <= (others => '0');
      ok <= '1';
   elsif (ACLK = '1' and ACLK'event) then
      case check_state is
      when x"0000" =>
         if S_AXIS_TVALID = '1' then
            last_data_plus_one <= x"1";
            ok <= '1';
            check_state <= check_state + 1;
         end if;
      when x"0001" =>
         for i in 0 to C_M_AXIS_DATA_WIDTH/8 -1 loop
            if S_AXIS_TDATA(i+7 downto i) = last_data_plus_one & last_data_plus_one then
               ok <= ok;
            else
               ok <= '0';
            end if; 
         end loop;         
         if S_AXIS_TVALID = '1' and S_AXIS_TLAST = '1' then
            check_state <= check_state + 1;
            last_data_plus_one <= last_data_plus_one + 1;
          end if;		    
      when x"0002" =>
         rx_count <= rx_count + 1;
         check_state <= (others => '0'); 			
      when others =>
      end case;
   end if;
end process;



end structural;
