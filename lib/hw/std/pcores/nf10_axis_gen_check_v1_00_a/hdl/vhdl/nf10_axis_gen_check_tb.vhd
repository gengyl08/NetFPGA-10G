------------------------------------------------------------------------
--
--  NetFPGA-10G www.netfpga.org
--
--  Module:
--          nf10_axis_gen_check_tb.vhd
--
--  Description:
--          Simple testbed for axis generator/checker
--                 
--  Revision history:
--          Dec 2010 M.Blott initial version
------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL ;
USE IEEE.std_logic_arith.ALL;
USE IEEE.std_logic_unsigned.ALL;
USE IEEE.STD_LOGIC_TEXTIO.all;

LIBRARY STD;
USE STD.TEXTIO.ALL;

entity testbed is 
end testbed;

architecture rtl of testbed is 					

component nf10_axis_gen_check
port(
   ACLK               : in  std_logic;
   ARESETN            : in  std_logic;
   M_AXIS_TDATA       : out std_logic_vector (63 downto 0);
   M_AXIS_TSTRB       : out std_logic_vector (7 downto 0);
   M_AXIS_TVALID      : out std_logic;
   M_AXIS_TREADY      : in  std_logic;
   M_AXIS_TLAST       : out std_logic;
   S_AXIS_TDATA       : in  std_logic_vector (63 downto 0);
   S_AXIS_TSTRB       : in  std_logic_vector (7 downto 0);
   S_AXIS_TVALID      : in  std_logic;
   S_AXIS_TREADY      : out std_logic;
   S_AXIS_TLAST       : in  std_logic;
	    
   -- axi lite control/status interface
   S_AXI_ACLK         : in  std_logic;
   S_AXI_ARESETN      : in  std_logic;
   S_AXI_AWADDR       : in  std_logic_vector(32-1 downto 0);
   S_AXI_AWVALID      : in  std_logic;
   S_AXI_AWREADY      : out std_logic;
   S_AXI_WDATA        : in  std_logic_vector(32-1 downto 0);
   S_AXI_WSTRB        : in  std_logic_vector((32/8)-1 downto 0);
   S_AXI_WVALID       : in  std_logic;
   S_AXI_WREADY       : out std_logic;
   S_AXI_BRESP        : out std_logic_vector(1 downto 0);
   S_AXI_BVALID       : out std_logic;
   S_AXI_BREADY       : in  std_logic;
   S_AXI_ARADDR       : in  std_logic_vector(32-1 downto 0);
   S_AXI_ARVALID      : in  std_logic;
   S_AXI_ARREADY      : out std_logic;
   S_AXI_RDATA        : out std_logic_vector(32-1 downto 0);
   S_AXI_RRESP        : out std_logic_vector(1 downto 0);
   S_AXI_RVALID       : out std_logic;
   S_AXI_RREADY       : in  std_logic			
);
end component ;

signal  aclk    : std_logic;
signal  aresetn : std_logic;
signal  tdata   : std_logic_vector (63 downto 0);
signal  tstrb   : std_logic_vector (7 downto 0);
signal  tvalid  : std_logic;
signal  tready  : std_logic;
signal  tlast   : std_logic;

begin

gen_check_u : nf10_axis_gen_check 
port map 
(	
   ACLK            => aclk,
   ARESETN         => aresetn,
   M_AXIS_TDATA    => tdata,
   M_AXIS_TSTRB    => tstrb,
   M_AXIS_TVALID   => tvalid,
   M_AXIS_TREADY   => tready,
   M_AXIS_TLAST    => tlast,
   S_AXIS_TDATA    => tdata,
   S_AXIS_TSTRB    => tstrb,
   S_AXIS_TVALID   => tvalid,
   S_AXIS_TREADY   => tready,
   S_AXIS_TLAST    => tlast,		    
   S_AXI_ACLK      => aclk,
   S_AXI_ARESETN   => aresetn,
   S_AXI_AWADDR    => (others => '0'),
   S_AXI_AWVALID   => '1',
   S_AXI_AWREADY   => open,
   S_AXI_WDATA     => (others => '0'),
   S_AXI_WSTRB     => (others => '0'),
   S_AXI_WVALID    => '1',
   S_AXI_WREADY    => open,
   S_AXI_BRESP     => open,
   S_AXI_BVALID    => open,
   S_AXI_BREADY    => '1',
   S_AXI_ARADDR    => (others => '0'),
   S_AXI_ARVALID   => '1',
   S_AXI_ARREADY   => open,
   S_AXI_RDATA     => open,
   S_AXI_RRESP     => open,
   S_AXI_RVALID    => open,
   S_AXI_RREADY    => '1'
);

clk_gen_p: process
begin
	aclk <= '1';
	wait for 10ns;
	aclk <= '0';
	wait for 10ns;
end process;

rst_gen_p: process
begin
	aresetn <= '0';
	wait for 100ns;
	aresetn <= '1';
	wait for 10000*10000ns;
end process;


end rtl;    

