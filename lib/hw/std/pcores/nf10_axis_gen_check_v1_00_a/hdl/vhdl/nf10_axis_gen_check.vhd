------------------------------------------------------------------------
--
--  NETFPGA-10G www.netfpga.org
--
--  Module:
--          nf10_axis_gen_check.vhd
--
--  Description:
--          Hardware component that generates and checks packets
--                 
--  Revision history:
--          Dec 2010 M.Blott initial version
--
--  Known issues:
--          none
--
--  Library: 
--          none beyond the standard
------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity nf10_axis_gen_check is
generic (
   C_S_AXI_DATA_WIDTH  : integer range 32 to 32 := 32;
   C_S_AXI_ADDR_WIDTH  : integer                := 32;
   C_BASEADDR          : std_logic_vector(31 downto 0) := x"00000000";
   C_HIGHADDR          : std_logic_vector(31 downto 0) := x"00000002";
   C_M_AXIS_DATA_WIDTH : integer := 64; -- max 256bit supported
   C_S_AXIS_DATA_WIDTH : integer := 64; -- max 256bit supported
   GEN_PKT_SIZE        : integer := 10; -- in words; pkt_size + ifg_size < 65k=number of provisioned states  
   CHECK_PKT_SIZE      : integer := 8; -- in words; pkt_size + ifg_size < 65k=number of provisioned states
   IFG_SIZE            : integer := 5 -- in words irrespective of backpressure
);
port (
   ACLK               : in  std_logic;
   ARESETN            : in  std_logic;
   -- axi streaming data interface
   M_AXIS_TDATA       : out std_logic_vector (C_M_AXIS_DATA_WIDTH-1 downto 0);
   M_AXIS_TSTRB       : out std_logic_vector (C_M_AXIS_DATA_WIDTH/8-1 downto 0);
   M_AXIS_TVALID      : out std_logic;
   M_AXIS_TREADY      : in  std_logic;
   M_AXIS_TLAST       : out std_logic;
   S_AXIS_TDATA       : in  std_logic_vector (C_S_AXIS_DATA_WIDTH-1 downto 0);
   S_AXIS_TSTRB       : in  std_logic_vector (C_S_AXIS_DATA_WIDTH/8-1 downto 0);
   S_AXIS_TVALID      : in  std_logic;
   S_AXIS_TREADY      : out std_logic;
   S_AXIS_TLAST       : in  std_logic;
   -- axi lite control/status interface
   S_AXI_AWADDR       : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
   S_AXI_AWVALID      : in  std_logic;
   S_AXI_AWREADY      : out std_logic;
   S_AXI_WDATA        : in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
   S_AXI_WSTRB        : in  std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
   S_AXI_WVALID       : in  std_logic;
   S_AXI_WREADY       : out std_logic;
   S_AXI_BRESP        : out std_logic_vector(1 downto 0);
   S_AXI_BVALID       : out std_logic;
   S_AXI_BREADY       : in  std_logic;
   S_AXI_ARADDR       : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
   S_AXI_ARVALID      : in  std_logic;
   S_AXI_ARREADY      : out std_logic;
   S_AXI_RDATA        : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
   S_AXI_RRESP        : out std_logic_vector(1 downto 0);
   S_AXI_RVALID       : out std_logic;
   S_AXI_RREADY       : in  std_logic	
);
end nf10_axis_gen_check;


architecture structural of nf10_axis_gen_check is

   type gen_rom_type is array (0 to GEN_PKT_SIZE-1) of std_logic_vector (255 downto 0);--256bit maximum
   type check_rom_type is array (0 to CHECK_PKT_SIZE-1) of std_logic_vector (255 downto 0);--256bit maximum
   -- in this example transmitted and received packets are identical
   constant gen_ROM, check_ROM : gen_rom_type :=
	                          (x"0000000000000000000000000000000000000000000000000002cfbddde50005",
                               x"0000000000000000000000000000000000000000000000009a3c780008004500",
                               x"0000000000000000000000000000000000000000000000000040874c40008006",
                               x"000000000000000000000000000000000000000000000000450dac10e80ad02b",
                               x"000000000000000000000000000000000000000000000000ca1705d90050c5e3",
                               x"00000000000000000000000000000000000000000000000075ce00000000b002",
                               x"000000000000000000000000000000000000000000000000ffffc68d00000204",
                               x"00000000000000000000000000000000000000000000000004ec010303020101",
                               x"000000000000000000000000000000000000000000000000080a000000000000",
                               x"0000000000000000000000000000000000000000000000000000010104020000");     
   -- ROM should be inferred as BRAM during XST

   constant AXI_RESP_OK          : std_logic_vector(1 downto 0) := "00";
   constant AXI_RESP_SLVERR      : std_logic_vector(1 downto 0) := "10";
   constant AXI_RESP_DECERR      : std_logic_vector(1 downto 0) := "11";
	
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
   signal pkt_valid_buf      : std_logic;
   signal pkt_last_buf       : std_logic;	
   signal pkt_strb_buf       : std_logic_vector(C_S_AXIS_DATA_WIDTH/8-1 downto 0);
   signal last_seen          : std_logic;
   signal local_adr          : std_logic_vector(31 downto 0);
	
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
      elsif gen_state < GEN_PKT_SIZE then 
         for i in 0 to C_M_AXIS_DATA_WIDTH-1 loop
			   M_AXIS_TDATA(i) <= gen_ROM(conv_integer(gen_rom_addr))(i);
         end loop;
			M_AXIS_TSTRB <= (others => '1');
         M_AXIS_TVALID <= '1';
         M_AXIS_TLAST <= '0';
         if (M_AXIS_TREADY='1') then
            gen_state <= gen_state + 1;
         end if;	
      elsif gen_state = GEN_PKT_SIZE then
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
      elsif gen_state < GEN_PKT_SIZE+IFG_SIZE-1 then
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
      pkt_valid_buf <= '0';
		pkt_last_buf <= '0';
		pkt_strb_buf <= (others => '0');
      last_seen <= '0';
   elsif (ACLK = '1' and ACLK'event) then
	   pkt_data_buf <= S_AXIS_TDATA;
		pkt_valid_buf <= S_AXIS_TVALID;
		pkt_last_buf <= S_AXIS_TLAST;
		pkt_strb_buf <= S_AXIS_TSTRB;
      if check_state = x"0000" then
         -- waiting for a pkt
         if S_AXIS_TVALID = '1' then
            ok <= '1';
            check_rom_addr <= x"0000"; 
            check_state <= check_state + 1;
         end if;
			last_seen <= '0';
      elsif check_state = x"0001" then
		  -- strb checking needs to be added
		   -- checking the packet against ROM
         for i in 0 to C_M_AXIS_DATA_WIDTH-1 loop   
           if (pkt_data_buf(i) = check_ROM(conv_integer(check_rom_addr))(i) and pkt_strb_buf(i/8) = '1') then
               ok <= ok;
            elsif (pkt_valid_buf = '1' and pkt_strb_buf(i/8) = '1') then
               ok <= '0';
            end if; 
         end loop;
         -- check packet size and last
         if (check_rom_addr = CHECK_PKT_SIZE -1 and pkt_last_buf= '1') then
			   last_seen <= '1';
		      check_state <= check_state + 1;
			elsif (check_rom_addr = CHECK_PKT_SIZE -1 and pkt_last_buf = '0') then
			   last_seen <= '0';
		      check_state <= check_state + 1;
		   elsif (check_rom_addr < CHECK_PKT_SIZE -1 and pkt_last_buf = '1') then
            check_state <= check_state + 1;
         end if;		    
		   check_rom_addr <= check_rom_addr + 1;	
      elsif check_state = x"0002" then
          -- finish up
         if (ok='1' and (last_seen='1' or pkt_last_buf='1')) then
			   rx_count <= rx_count + 1;
				check_state <= (others => '0'); 	
			else
			   err_count <= err_count + 1;
				check_state <= (others => '0'); 	
			end if;
      end if;
   end if;
end process;

axi_lite_if_p: process(ACLK)
begin
   if (ARESETN='0') then
      S_AXI_ARREADY <= '0';
      S_AXI_AWREADY <= '0';
      S_AXI_RVALID <= '0';
      S_AXI_RRESP <= AXI_RESP_OK;
      S_AXI_RDATA <= (others => '0');
      S_AXI_WREADY <= '0';
      S_AXI_BRESP <= AXI_RESP_OK;
      S_AXI_BVALID <= '0';
   elsif (ACLK'event and ACLK='1') then
      -- defaults
      S_AXI_ARREADY <= '0';
      S_AXI_AWREADY <= '0';
      S_AXI_RVALID <= '0';
      S_AXI_RRESP <= AXI_RESP_OK;
      S_AXI_RDATA <= (others => '0');
      S_AXI_WREADY <= '0';
      S_AXI_BRESP <= AXI_RESP_OK;
      S_AXI_BVALID <= '0';
      -- get read address and acknowledge
      if S_AXI_ARVALID = '1' then
         local_adr <= S_AXI_ARADDR; 
         S_AXI_ARREADY <= '1';
      end if;
      -- read response channel
      if S_AXI_RREADY = '1' then
         S_AXI_RVALID <= '1';
      end if;
      if S_AXI_RREADY = '1' and local_adr = C_BASEADDR then
         S_AXI_RDATA <= tx_count;
         S_AXI_RRESP <= AXI_RESP_OK;
      elsif S_AXI_RREADY = '1' and local_adr = C_BASEADDR+1 then
         S_AXI_RDATA <= rx_count;
         S_AXI_RRESP <= AXI_RESP_OK;
      elsif S_AXI_RREADY = '1' and local_adr = C_BASEADDR+2 then
         S_AXI_RDATA <= err_count;
         S_AXI_RRESP <= AXI_RESP_OK;
      elsif S_AXI_RREADY = '1' then
         -- address out of range
         S_AXI_RRESP <= AXI_RESP_SLVERR; -- right error type?
      end if;
      -- write address - no write supported, just ignore inputs but ack
      if S_AXI_AWVALID = '1' then
         S_AXI_AWREADY <= '1';
      end if;
      -- write data channel -- ignore data and strobes
      if S_AXI_WVALID = '1' then
         S_AXI_WREADY <= '1';
      end if;
      -- write response channel -- send error back
      if S_AXI_BREADY = '1' then
         S_AXI_BRESP <= AXI_RESP_SLVERR;
         S_AXI_BVALID <= '1';
      end if;
   end if;
end process;


end structural;
