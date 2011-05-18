------------------------------------------------------------------------
--
-- NetFPGA-10G www.netfpga.org
--
-- Module:
-- nf10_axis_cdc.vhd
--
-- Description:
-- handles clock domain crossings on AXI stream interfaces
-- 
-- Revision history:
-- March 2011 M.Blott initial version
-- May 2011 S.Siegel add TUSER
------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity nf10_axis_cdc is
generic (
   C_M_AXIS_DATA_WIDTH  : integer := 64;
   C_S_AXIS_DATA_WIDTH  : integer := 64;
   C_M_AXIS_TUSER_WIDTH : integer := 128;
   C_S_AXIS_TUSER_WIDTH : integer :=128 
);
port (
   M_AXIS_ACLK : in std_logic;
   S_AXIS_ACLK : in std_logic;
   ARESETN : in std_logic;
   M_AXIS_TDATA : out std_logic_vector (C_M_AXIS_DATA_WIDTH-1 downto 0);
   M_AXIS_TUSER : out std_logic_vector (C_M_AXIS_USER_WIDTH-1 downto 0);
   M_AXIS_TSTRB : out std_logic_vector (C_M_AXIS_DATA_WIDTH/8-1 downto 0);
   M_AXIS_TVALID : out std_logic;
   M_AXIS_TREADY : in std_logic;
   M_AXIS_TLAST : out std_logic;
   S_AXIS_TDATA : in std_logic_vector (C_S_AXIS_DATA_WIDTH-1 downto 0);
   S_AXIS_TUSER : in std_logic_vector (C_S_AXIS_USER_WIDTH-1 downto 0);
   S_AXIS_TSTRB : in std_logic_vector (C_S_AXIS_DATA_WIDTH/8-1 downto 0);
   S_AXIS_TVALID : in std_logic;
   S_AXIS_TREADY : out std_logic;
   S_AXIS_TLAST : in std_logic
);
end nf10_axis_cdc;

architecture structural of nf10_axis_cdc is

component async_fifo_138
port (
rst : IN std_logic;
wr_clk : IN std_logic;
rd_clk : IN std_logic;
din : IN std_logic_VECTOR(137 downto 0);
wr_en : IN std_logic;
rd_en : IN std_logic;
dout : OUT std_logic_VECTOR(137 downto 0);
full : OUT std_logic;
empty : OUT std_logic);
end component;

component async_fifo_165
port (
rst : IN std_logic;
wr_clk : IN std_logic;
rd_clk : IN std_logic;
din : IN std_logic_VECTOR(164 downto 0);
wr_en : IN std_logic;
rd_en : IN std_logic;
dout : OUT std_logic_VECTOR(164 downto 0);
full : OUT std_logic;
empty : OUT std_logic);
end component;

component async_fifo_198
port (
rst : IN std_logic;
wr_clk : IN std_logic;
rd_clk : IN std_logic;
din : IN std_logic_VECTOR(197 downto 0);
wr_en : IN std_logic;
rd_en : IN std_logic;
dout : OUT std_logic_VECTOR(197 downto 0);
full : OUT std_logic;
empty : OUT std_logic);
end component;

component async_fifo_417
port (
rst : IN std_logic;
wr_clk : IN std_logic;
rd_clk : IN std_logic;
din : IN std_logic_VECTOR(416 downto 0);
wr_en : IN std_logic;
rd_en : IN std_logic;
dout : OUT std_logic_VECTOR(416 downto 0);
full : OUT std_logic;
empty : OUT std_logic);
end component;

signal rst   : std_logic;
signal wr_en : std_logic;
signal rd_en : std_logic;
signal din   : std_logic_vector(C_S_AXIS_TUSER_DATA_WIDTH+C_S_AXIS_DATA_WIDTH+C_S_AXIS_DATA_WIDTH/8 downto 0);
signal dout  : std_logic_vector(C_M_AXIS_TUSER_DATA_WIDTH+C_M_AXIS_DATA_WIDTH+C_M_AXIS_DATA_WIDTH/8 downto 0);

begin


rst   <= not ARESETN;
din   <= S_AXIS_TUSER & S_AXIS_TLAST & S_AXIS_TSTRB & S_AXIS_TDATA;
wr_en <= S_AXIS_TVALID;
rd_en <= M_AXIS_TREADY;
M_AXIS_TDATA <= dout(C_M_AXIS_DATA_WIDTH-1 downto 0);
M_AXIS_TSTRB <= dout(C_M_AXIS_DATA_WIDTH+C_M_AXIS_DATA_WIDTH/8-1 downto C_M_AXIS_DATA_WIDTH);
M_AXIS_TLAST <= dout(C_M_AXIS_DATA_WIDTH+C_M_AXIS_DATA_WIDTH/8);
M_AXIS_TUSER <= dout(C_M_AXIS_TUSER_DATA_WIDTH+C_M_AXIS_DATA_WIDTH/8+C_M_AXIS_DATA_WIDTH-1 downto C_M_AXIS_DATA_WIDTH/8+C_M_AXIS_DATA_WIDTH+1);


fifo8_i : IF ( C_M_AXIS_DATA_WIDTH = 8) GENERATE
BEGIN
   fifo_i : async_fifo_138
port map (
rst => rst,
wr_clk => S_AXIS_ACLK,
rd_clk => M_AXIS_ACLK,
din => din,
wr_en => wr_en,
rd_en => rd_en,
dout => dout,
full => S_AXIS_TREADY,
empty => M_AXIS_TVALID);
END GENERATE fifo8_i;

fifo32_i : IF ( C_M_AXIS_DATA_WIDTH = 32) GENERATE
BEGIN
   fifo_i : async_fifo_165
port map (
rst => rst,
wr_clk => S_AXIS_ACLK,
rd_clk => M_AXIS_ACLK,
din => din,
wr_en => wr_en,
rd_en => rd_en,
dout => dout,
full => S_AXIS_TREADY,
empty => M_AXIS_TVALID);
END GENERATE fifo32_i;

fifo64_i : IF ( C_M_AXIS_DATA_WIDTH = 64) GENERATE
BEGIN
   fifo_i : async_fifo_198
port map (
rst => rst,
wr_clk => S_AXIS_ACLK,
rd_clk => M_AXIS_ACLK,
din => din,
wr_en => wr_en,
rd_en => rd_en,
dout => dout,
full => S_AXIS_TREADY,
empty => M_AXIS_TVALID);
END GENERATE fifo64_i;

fifo256_i : IF ( C_M_AXIS_DATA_WIDTH = 256) GENERATE
BEGIN
   fifo_i : async_fifo_417
port map (
rst => rst,
wr_clk => S_AXIS_ACLK,
rd_clk => M_AXIS_ACLK,
din => din,
wr_en => wr_en,
rd_en => rd_en,
dout => dout,
full => S_AXIS_TREADY,
empty => M_AXIS_TVALID);
END GENERATE fifo256_i;


end structural;
