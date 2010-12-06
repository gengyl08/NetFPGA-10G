-- Xilinx, Inc. - Proprietary.  Use pursuant to Company instructions.
---------------------------------------------------------------------------------
-- Michaela Blott
-- 
-- Description:
-- Hardware component that generates and checks packets
-- 64bit only when tx,rx of hardcoded packet
--
-- May 2010
---------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity nf10_axis_gen_check is
generic (
   C_M_AXIS_DATA_WIDTH : integer := 64; -- max 64bit supported
   C_S_AXIS_DATA_WIDTH : integer := 64; -- max 64bit supported
   PKT_SIZE            : integer := 10; -- in 64bit words; pkt_size + ifg_size < 65k=number of provisioned states  
   IFG_SIZE            : integer := 50 -- in 64bit words irrespective of backpressure
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

   type rom_type is array (0 to PKT_SIZE-1) of std_logic_vector (C_S_AXIS_DATA_WIDTH-1 downto 0);
   constant gen_ROM, check_ROM : rom_type :=
	                          (x"0002cfbddde50005",x"9a3c780008004500",
                              x"0040874c40008006",x"450dac10e80ad02b",
                              x"ca1705d90050c5e3",x"75ce00000000b002",
                              x"ffffc68d00000204",x"04ec010303020101",
                              x"080a000000000000",x"0000010104020000");     
   --0002cfbddde50005 9a3c780008004500
   --0040874c40008006 450dac10e80ad02b
   --ca1705d90050c5e3 75ce00000000b002
   --ffffc68d00000204 04ec010303020101
   --080a000000000000 000001010402 
   -- ROM should be inferred as BRAM during XST
	
   signal gen_state          : std_logic_vector(15 downto 0);
   signal check_state        : std_logic_vector(15 downto 0);
   signal tx_count           : std_logic_vector(31 downto 0);
   signal rx_count           : std_logic_vector(31 downto 0);
   signal err_count          : std_logic_vector(31 downto 0);
   signal ok                 : std_logic;
   signal last_data_plus_one : std_logic_vector(3 downto 0);	
   signal gen_rom_addr       : std_logic_vector(15 downto 0);
   signal check_rom_addr     : std_logic_vector(15 downto 0);
	signal pkt_data_buf       : std_logic_vector(C_S_AXIS_DATA_WIDTH-1 downto 0);
	
begin


gen_p: process(ACLK)
begin
   if (ARESETN='0') then
      gen_state <= (others => '0');
      tx_count <= (others => '0');
      gen_rom_addr <= (others => '0');
   elsif (ACLK = '1' and ACLK'event) then
      gen_rom_addr <= gen_state; -- addr needs to be gen_state -1- so always 1 tick behind  
      if gen_state = x"0000" then
         M_AXIS_TDATA <= (others => '0');
         M_AXIS_TSTRB <= (others => '0');
         M_AXIS_TVALID <= '0';
         M_AXIS_TLAST <= '0';
         if (M_AXIS_TREADY='1') then
            gen_state <= gen_state + 1;
         end if;
      elsif gen_state < PKT_SIZE then 
         for i in 0 to C_M_AXIS_DATA_WIDTH-1 loop
			   M_AXIS_TDATA(i) <= gen_ROM(conv_integer(gen_rom_addr))(i);
         end loop;
			M_AXIS_TSTRB <= (others => '1');
         M_AXIS_TVALID <= '1';
         M_AXIS_TLAST <= '0';
         if (M_AXIS_TREADY='1') then
            gen_state <= gen_state + 1;
         end if;	
      elsif gen_state = PKT_SIZE then
         for i in 0 to C_M_AXIS_DATA_WIDTH-1 loop
			   M_AXIS_TDATA(i) <= gen_ROM(conv_integer(gen_rom_addr))(i);
         end loop;
         M_AXIS_TSTRB <= (others => '1');
         M_AXIS_TVALID <= '1';
         M_AXIS_TLAST <= '1';
         if (M_AXIS_TREADY='1') then
            tx_count <= tx_count + 1;	
            gen_state <= gen_state + 1;
         end if;	
      elsif gen_state < PKT_SIZE+IFG_SIZE-1 then
         M_AXIS_TDATA <= (others => '0');
         M_AXIS_TSTRB <= (others => '0');
         M_AXIS_TVALID <= '0';
         M_AXIS_TLAST <= '0';
         gen_state <= gen_state + 1;		      		
      else
         M_AXIS_TDATA <= (others => '0');
         M_AXIS_TSTRB <= (others => '0');
         M_AXIS_TVALID <= '0';			
         M_AXIS_TLAST <= '0';
         gen_state <= (others => '0');	
      end if;	
   end if;
end process;

S_AXIS_TREADY <= '1';
check_p: process(ACLK)
begin
   if (ARESETN='0') then
      check_state <= (others => '0');
      rx_count <= (others => '0');
		err_count <= (others => '0');
      ok <= '1';
		check_rom_addr <= x"0000"; 
		pkt_data_buf <= (others => '0');
   elsif (ACLK = '1' and ACLK'event) then
	   pkt_data_buf <= S_AXIS_TDATA;
      if check_state = x"0000" then
         -- waiting for a pkt
         if S_AXIS_TVALID = '1' then
            ok <= '1';
            check_rom_addr <= x"0000"; 
            check_state <= check_state + 1;
         end if;
      elsif check_state = x"0001" then
		   -- checking the packet against ROM
         for i in 0 to C_M_AXIS_DATA_WIDTH-1 loop
            if pkt_data_buf(i) = check_ROM(conv_integer(check_rom_addr))(i) then
               ok <= ok;
            else
               ok <= '0';
            end if; 
		   end loop;
			check_rom_addr <= check_rom_addr + 1;			
         if S_AXIS_TVALID = '1' and S_AXIS_TLAST = '1' then
            check_state <= check_state + 1;
          end if;		    
      elsif check_state = x"0002" then
         if (ok='1') then
			   rx_count <= rx_count + 1;
			else
			   err_count <= err_count + 1;
			end if;
         check_state <= (others => '0'); 			
      end if;
   end if;
end process;

end structural;
