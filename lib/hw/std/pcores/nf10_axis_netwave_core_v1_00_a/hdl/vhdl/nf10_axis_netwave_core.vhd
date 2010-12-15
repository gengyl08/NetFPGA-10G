-- Xilinx, Inc. - Proprietary.  Use pursuant to Company instructions.
---------------------------------------------------------------------------------
-- Michaela Blott
-- 
-- Description:
-- Hardware component that wraps HLS generated blocks into AXI stream
--
-- Dec 2010
---------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity nf10_axis_netwave_core is
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
end nf10_axis_netwave_core;

architecture structural of nf10_axis_netwave_core is

	
begin

M_AXIS_TVALID <= S_AXIS_TVALID;
M_AXIS_TDATA  <= S_AXIS_TDATA;
M_AXIS_TLAST  <= S_AXIS_TLAST;
M_AXIS_TSTRB  <= S_AXIS_TSTRB;
S_AXIS_TREADY <= M_AXIS_TTREADY;

end structural;
