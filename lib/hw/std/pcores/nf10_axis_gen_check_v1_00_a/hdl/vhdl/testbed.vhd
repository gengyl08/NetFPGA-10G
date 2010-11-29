
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
		ACLK                   : in  std_logic;
		ARESETN                : in  std_logic;
		M_AXIS_TDATA       : out std_logic_vector (63 downto 0);
		M_AXIS_TSTRB       : out std_logic_vector (7 downto 0);
		M_AXIS_TVALID      : out std_logic;
		M_AXIS_TREADY      : in  std_logic;
	    M_AXIS_TLAST       : out std_logic;
		S_AXIS_TDATA       : in  std_logic_vector (63 downto 0);
		S_AXIS_TSTRB       : in  std_logic_vector (7 downto 0);
		S_AXIS_TVALID      : in  std_logic;
		S_AXIS_TREADY      : out std_logic;
	    S_AXIS_TLAST       : in  std_logic		
		);
end component ;

signal  aclk    : std_logic;
signal  aresetn : std_logic;
signal	tdata   : std_logic_vector (63 downto 0);
signal	tstrb   : std_logic_vector (7 downto 0);
signal	tvalid  : std_logic;
signal	tready  : std_logic;
signal	tlast   : std_logic;


begin

gen_check_u : nf10_axis_gen_check 
port map 
(	
		ACLK                => aclk,
		ARESETN             => aresetn,
		M_AXIS_TDATA    => tdata,
		M_AXIS_TSTRB    => tstrb,
		M_AXIS_TVALID   => tvalid,
		M_AXIS_TREADY   => tready,
	    M_AXIS_TLAST   => tlast,
		S_AXIS_TDATA    => tdata,
		S_AXIS_TSTRB    => tstrb,
		S_AXIS_TVALID   => tvalid,
		S_AXIS_TREADY   => tready,
	    S_AXIS_TLAST   => tlast		
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

