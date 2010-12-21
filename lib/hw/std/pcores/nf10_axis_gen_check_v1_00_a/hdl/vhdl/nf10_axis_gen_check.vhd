------------------------------------------------------------------------
--
--  NetFPGA-10G http://www.netfpga.org
--
--  Module:
--          nf10_axis_gen_check.vhd
--
--  Description:
--          Hardware component that generates and checks packets
--                 
--  Revision history:
--          2010/12/1  M.Blott  Initial version
--          2010/12/15 hyzeng   Fixed last signal, AXI4-Lite
--
------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity nf10_axis_gen_check is
generic (
   C_BASEADDR          : std_logic_vector(31 downto 0) := x"00000000";
   C_HIGHADDR          : std_logic_vector(31 downto 0) := x"00000002";
   C_M_AXIS_DATA_WIDTH : integer := 64; -- max 256bit supported
   C_S_AXIS_DATA_WIDTH : integer := 64; -- max 256bit supported
   C_GEN_PKT_SIZE      : integer := 16; -- in words;
   C_CHECK_PKT_SIZE    : integer := 16; -- in words;
   C_IFG_SIZE          : integer := 5;  -- in words irrespective of backpressure
   C_S_AXI_ADDR_WIDTH  : integer := 32;
   C_S_AXI_DATA_WIDTH  : integer := 32
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
   S_AXI_ACLK         : in  std_logic;
   S_AXI_ARESETN      : in  std_logic;
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
end entity;



architecture structural of nf10_axis_gen_check is

component axi4_lite_regs
generic (
   ADDR_WIDTH  : integer := 32;
   DATA_WIDTH  : integer := 32
);
port (
   tx_count     : in std_logic_vector(31 downto 0);
   rx_count     : in std_logic_vector(31 downto 0);
   err_count    : in std_logic_vector(31 downto 0);
   count_reset  : out std_logic;
   AXIS_ACLK    : in std_logic;

   -- axi lite control/status interface
   ACLK         : in  std_logic;
   ARESETN      : in  std_logic;
   AWADDR       : in  std_logic_vector(ADDR_WIDTH-1 downto 0);
   AWVALID      : in  std_logic;
   AWREADY      : out std_logic;
   WDATA        : in  std_logic_vector(DATA_WIDTH-1 downto 0);
   WSTRB        : in  std_logic_vector((DATA_WIDTH/8)-1 downto 0);
   WVALID       : in  std_logic;
   WREADY       : out std_logic;
   BRESP        : out std_logic_vector(1 downto 0);
   BVALID       : out std_logic;
   BREADY       : in  std_logic;
   ARADDR       : in  std_logic_vector(ADDR_WIDTH-1 downto 0);
   ARVALID      : in  std_logic;
   ARREADY      : out std_logic;
   RDATA        : out std_logic_vector(DATA_WIDTH-1 downto 0);
   RRESP        : out std_logic_vector(1 downto 0);
   RVALID       : out std_logic;
   RREADY       : in  std_logic	
);
end component;
   
                              
   -- ROM should be inferred as BRAM during XST  
   constant CHECK_IDLE           : std_logic_vector(1 downto 0) := "00";
   constant CHECK_FINISH         : std_logic_vector(1 downto 0) := "01";
   constant CHECK_COMPARE        : std_logic_vector(1 downto 0) := "11";
   constant CHECK_WAIT_LAST      : std_logic_vector(1 downto 0) := "10";

   constant GEN_PKT              : std_logic_vector(1 downto 0) := "00";
   constant GEN_IFG              : std_logic_vector(1 downto 0) := "01";
   constant GEN_FINISH           : std_logic_vector(1 downto 0) := "11";
	
   signal gen_word_num       : std_logic_vector(15 downto 0);
   signal gen_state          : std_logic_vector(1  downto 0);
   signal check_state        : std_logic_vector(1  downto 0);
   signal check_word_num     : std_logic_vector(15 downto 0);
   signal tx_count           : std_logic_vector(31 downto 0);
   signal rx_count           : std_logic_vector(31 downto 0);
   signal err_count          : std_logic_vector(31 downto 0);
   signal count_reset        : std_logic;
   signal ok                 : std_logic;	
   signal pkt_tx_buf         : std_logic_vector(C_M_AXIS_DATA_WIDTH-1 downto 0);
   signal pkt_rx_buf         : std_logic_vector(C_S_AXIS_DATA_WIDTH-1 downto 0);
   signal seed               : std_logic_vector(255 downto 0);
	
begin

   seed <= x"CAFEBEEFCAFEBEEFCAFEBEEFCAFEBEEFCAFEBEEFCAFEBEEFCAFEBEEFCAFEBEEF";

   regs : axi4_lite_regs
     generic map 
        (
        ADDR_WIDTH       => C_S_AXI_ADDR_WIDTH,  
        DATA_WIDTH       => C_S_AXI_DATA_WIDTH                     
        )
     
     port map 
        (
        tx_count  => tx_count,
        rx_count  => rx_count,
        err_count => err_count,
        count_reset => count_reset,
        AXIS_ACLK => ACLK,
           
        ACLK => S_AXI_ACLK,
        ARESETN => S_AXI_ARESETN,
        AWADDR => S_AXI_AWADDR,
        AWVALID => S_AXI_AWVALID,
        AWREADY => S_AXI_AWREADY,
        WDATA => S_AXI_WDATA,
        WSTRB => S_AXI_WSTRB,
        WVALID => S_AXI_WVALID,
        WREADY => S_AXI_WREADY,
        BRESP => S_AXI_BRESP,
        BVALID => S_AXI_BVALID,
        BREADY => S_AXI_BREADY,
        ARADDR => S_AXI_ARADDR,
        ARVALID => S_AXI_ARVALID,
        ARREADY => S_AXI_ARREADY,
        RDATA => S_AXI_RDATA,
        RRESP => S_AXI_RRESP,
        RVALID => S_AXI_RVALID,
        RREADY => S_AXI_RREADY
        );


gen_p: process(ACLK, ARESETN)
begin
   if (ARESETN='0') then
      gen_word_num <= (others => '0');
      tx_count <= (others => '0');
      pkt_tx_buf <= seed(C_S_AXIS_DATA_WIDTH -1 downto 0);
      gen_state <= GEN_PKT;
   elsif (ACLK = '1' and ACLK'event) then
      if gen_state = GEN_PKT then 
		 M_AXIS_TSTRB <= (others => '1');
         M_AXIS_TVALID <= '1';
         M_AXIS_TLAST <= '0';
         if (M_AXIS_TREADY='1') then
            gen_word_num <= gen_word_num + 1;
            if (gen_word_num = C_GEN_PKT_SIZE - 1) then
                M_AXIS_TSTRB <= (others => '0');
         		M_AXIS_TVALID <= '0';
         		M_AXIS_TLAST <= '1';
         		tx_count <= tx_count + 1;	
         		gen_state <= GEN_IFG;
            else
                pkt_tx_buf <= pkt_tx_buf(0) & pkt_tx_buf(C_M_AXIS_DATA_WIDTH -1 downto 1);
                M_AXIS_TDATA <= pkt_tx_buf(0) & pkt_tx_buf(C_M_AXIS_DATA_WIDTH -1 downto 1);
            end if;
         end if;	
      elsif gen_state = GEN_IFG then
         M_AXIS_TSTRB <= (others => '0');
         M_AXIS_TVALID <= '0';
         if (M_AXIS_TREADY='1') then
             M_AXIS_TLAST <= '0';
             gen_word_num <= gen_word_num + 1;
             if gen_word_num = C_GEN_PKT_SIZE+C_IFG_SIZE-1 then
                 if(count_reset = '1') then
          			gen_state <= GEN_IFG; -- Hold state at GEN_IFG gently...
          			tx_count <= (others => '0');
          		 else
          		    gen_state <= GEN_FINISH;
      			 end if;
             end if;
         end if;	      		
      elsif gen_state = GEN_FINISH then
         M_AXIS_TSTRB <= (others => '1');
         M_AXIS_TVALID <= '1';			
         M_AXIS_TLAST <= '0';
         M_AXIS_TDATA <= seed(C_M_AXIS_DATA_WIDTH -1 downto 0);
         pkt_tx_buf <= seed(C_M_AXIS_DATA_WIDTH -1 downto 0);
         gen_word_num <= (others => '0');	
         gen_state <= GEN_PKT;
      end if;
   end if;
end process;

S_AXIS_TREADY <= '1';
check_p: process(ACLK, ARESETN)
begin
   if (ARESETN='0') then
        check_state <= (others => '0');
        rx_count <= (others => '0');
        err_count <= (others => '0');
        ok <= '1';
		check_word_num <= (others => '0');
   elsif (ACLK = '1' and ACLK'event) then
      if check_state = CHECK_IDLE then
         -- waiting for a pkt
         if S_AXIS_TVALID = '1' then
            ok <= '1';
            pkt_rx_buf <= S_AXIS_TDATA(0) & S_AXIS_TDATA(C_S_AXIS_DATA_WIDTH -1 downto 1);
            check_word_num <= (others => '0');
            check_state <= CHECK_COMPARE;
         end if;
      elsif check_state = CHECK_COMPARE then
		 -- checking the packet
         -- check packet size and last
         if (S_AXIS_TVALID = '1') then	
             pkt_rx_buf <= pkt_rx_buf(0) & pkt_rx_buf(C_S_AXIS_DATA_WIDTH -1 downto 1);
             check_word_num <= check_word_num + 1;
             
             if( S_AXIS_TDATA = pkt_rx_buf ) then
                 ok <= ok;
             else
                 ok <= '0';
             end if;		     
		     if (check_word_num = C_CHECK_PKT_SIZE -2) then
		          if (S_AXIS_TLAST='1') then
		              check_state <= CHECK_FINISH; -- finish up
		          else
		              check_state <= CHECK_WAIT_LAST; -- Wait for last
		          end if;
             end if;
		 end if;	
      elsif check_state = CHECK_FINISH then
         -- finish up
         if (ok='1') then
			rx_count <= rx_count + 1;
		 else
			err_count <= err_count + 1;
		 end if;
		 check_state <= CHECK_IDLE; 
		 ok <='1';
      elsif check_state = CHECK_WAIT_LAST then
         -- Wait for last
         if (S_AXIS_TVALID = '1') then  -- No more words!
			ok <= '0';
	     end if;
	     if (S_AXIS_TLAST='1') then
		    check_state <= CHECK_FINISH; 
		 end if;
      end if;
      
      if(count_reset = '1') then -- Don't touch check state machine..
          rx_count <= (others => '0');	
          err_count <= (others => '0');	
      end if;
   end if;
end process;

end structural;
