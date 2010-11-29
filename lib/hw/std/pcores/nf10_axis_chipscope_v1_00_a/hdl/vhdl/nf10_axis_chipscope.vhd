-- Xilinx, Inc. - Proprietary.  Use pursuant to Company instructions.
---------------------------------------------------------------------------------
-- Michaela Blott
-- 
-- Description:
-- Hardware component that inserts a chipscope probe into AXI stream
--
-- May 2010
---------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity nf10_axis_chipscope is
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
end nf10_axis_chipscope;

architecture structural of nf10_axis_chipscope is

component cs_axi_icon
port (
    CONTROL0 : inout STD_LOGIC_VECTOR ( 35 downto 0 ) 
);
end component;

component cs_axi_ila
port (
    CLK : in STD_LOGIC := 'X'; 
    CONTROL : inout STD_LOGIC_VECTOR ( 35 downto 0 ); 
    TRIG0 : in STD_LOGIC_VECTOR ( 63 downto 0 ); 
    TRIG1 : in STD_LOGIC_VECTOR ( 255 downto 0 ) 
);
end component;
	
signal ila_trig0    : std_logic_vector(63 downto 0);
signal ila_trig1    : std_logic_vector(255 downto 0);
signal ila_control0 : std_logic_vector(35 downto 0);
   
begin

M_AXIS_TDATA <= S_AXIS_TDATA;
M_AXIS_TSTRB <= S_AXIS_TSTRB;
M_AXIS_TVALID <= S_AXIS_TVALID;
M_AXIS_TLAST <= S_AXIS_TLAST;
S_AXIS_TREADY <= M_AXIS_TREADY;

ila_trig1(C_M_AXIS_DATA_WIDTH-1 downto 0)  <= S_AXIS_TDATA(C_M_AXIS_DATA_WIDTH-1 downto 0);
ila_trig0(2+(C_M_AXIS_DATA_WIDTH/8) downto 3) <= S_AXIS_TSTRB(C_M_AXIS_DATA_WIDTH/8-1 downto 0);
ila_trig0(0)            <= S_AXIS_TVALID;
ila_trig0(1)            <= S_AXIS_TLAST;
ila_trig0(2)            <= M_AXIS_TREADY;
	  
i1_icon : cs_axi_icon
port map(
   CONTROL0  => ila_control0
);

i1_ila : cs_axi_ila
port map(
   CLK     => ACLK,
   CONTROL => ila_control0,
   TRIG0   => ila_trig0,
   TRIG1   => ila_trig1
);


end structural;
