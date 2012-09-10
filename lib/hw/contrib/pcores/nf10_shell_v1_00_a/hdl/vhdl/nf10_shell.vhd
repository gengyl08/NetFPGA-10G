--################################################################################
--#
--#  NetFPGA-10G http://www.netfpga.org
--#
--#  File:
--#        nf10_shell.vhd
--#
--#  Library:
--#        hw/std/pcores/nf10_shell_v1_00_a
--#
--#  Author:
--#        Xilinx, Michaela Blott
--#
--#  Description:
--#        This file illustrates a fundamental way on how to implement AXI stream pipelines
--#        On module boundaries all flow control must come from registers, hence the minimum 
--#        "register slice" is required (involving 2 registers, forming a basic FIFO.) 
--#        (Within a module flow control can be "bypass"multiple pipeline stages)
--#        This can be achieved via instantiations of small coregen FIFOs. This
--#        example directly isntantiates the necessary primitives
--#
--#  Copyright notice:
--#        Copyright (C) 2010, 2011 The Board of Trustees of The Leland Stanford
--#                                 Junior University
--#
--#  Licence:
--#        This file is part of the NetFPGA 10G development base package.
--#
--#        This file is free code: you can redistribute it and/or modify it under
--#        the terms of the GNU Lesser General Public License version 2.1 as
--#        published by the Free Software Foundation.
--#
--#        This package is distributed in the hope that it will be useful, but
--#        WITHOUT ANY WARRANTY; without even the implied warranty of
--#        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
--#        Lesser General Public License for more details.
--#
--#        You should have received a copy of the GNU Lesser General Public
--#        License along with the NetFPGA source package.  If not, see
--#        http://www.gnu.org/licenses/.
--#
--#

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity nf10_shell is
generic(
    C_M_AXIS_DATA_WIDTH  : integer := 256;
    C_S_AXIS_DATA_WIDTH  : integer := 256;
    C_M_AXIS_TUSER_WIDTH : integer := 128;
    C_S_AXIS_TUSER_WIDTH : integer := 128;
    SRC_PORT_POS         : integer := 16;
    DST_PORT_POS         : integer := 24
);
 port (
    axi_aclk      : in std_logic;
    axi_resetn    : in std_logic;
    m_axis_tdata  : out std_logic_vector(C_M_AXIS_DATA_WIDTH-1 downto 0);
    m_axis_tstrb  : out std_logic_vectOR(C_M_AXIS_DATA_WIDTH/8-1 downto 0);
    m_axis_tuser  : out std_logic_vector(C_M_AXIS_TUSER_WIDTH-1 downto 0);
    m_axis_tvalid : out std_logic;
    m_axis_tready : in std_logic;
    m_axis_tlast  : out std_logic;
	 
    s_axis_tdata  : in std_logic_vector(C_S_AXIS_DATA_WIDTH-1 downto 0);
    s_axis_tstrb  : in std_logic_vectOR(C_S_AXIS_DATA_WIDTH/8-1 downto 0);
    s_axis_tuser  : in std_logic_vector(C_S_AXIS_TUSER_WIDTH-1 downto 0);
    s_axis_tvalid : in std_logic;
    s_axis_tready : out std_logic;
    s_axis_tlast  : in std_logic
);
END nf10_shell;

ARCHITECTURE rtl OF nf10_shell IS

component slice 
generic (
   D_WIDTH     : integer := C_M_AXIS_DATA_WIDTH;
   U_WIDTH     : integer := C_M_AXIS_TUSER_WIDTH;
   DELAY_DEPTH : integer := 2
);
port ( 
    clk : in  std_logic;
    rst : in  std_logic;
    m_axis_tdata  : out std_logic_vector(C_M_AXIS_DATA_WIDTH-1 downto 0);
    m_axis_tstrb  : out std_logic_vectOR(C_M_AXIS_DATA_WIDTH/8-1 downto 0);
    m_axis_tuser  : out std_logic_vector(C_M_AXIS_TUSER_WIDTH-1 downto 0);
    m_axis_tvalid : out std_logic;
    m_axis_tready : in std_logic;
    m_axis_tlast  : out std_logic;
	 
    s_axis_tdata  : in std_logic_vector(C_M_AXIS_DATA_WIDTH-1 downto 0);
    s_axis_tstrb  : in std_logic_vectOR(C_M_AXIS_DATA_WIDTH/8-1 downto 0);
    s_axis_tuser  : in std_logic_vector(C_M_AXIS_TUSER_WIDTH-1 downto 0);
    s_axis_tvalid : in std_logic;
    s_axis_tready : out std_logic;
    s_axis_tlast  : in std_logic);
end component;  
   
signal version        : std_logic_vector(7 downto 0);


BEGIN

version <= x"01";

slice_i : slice
generic map (
   D_WIDTH     => C_M_AXIS_DATA_WIDTH,
   U_WIDTH     => C_M_AXIS_TUSER_WIDTH,
   DELAY_DEPTH => 2
)
port map (
    clk           => axi_aclk,
    rst           => axi_resetn,
    m_axis_tdata  => m_axis_tdata,
    m_axis_tstrb  => m_axis_tstrb,
    m_axis_tuser  => m_axis_tuser,
    m_axis_tvalid => m_axis_tvalid,
    m_axis_tready => m_axis_tready,
    m_axis_tlast  => m_axis_tlast,
    s_axis_tdata  => s_axis_tdata,
    s_axis_tstrb  => s_axis_tstrb,
    s_axis_tuser  => s_axis_tuser,
    s_axis_tvalid => s_axis_tvalid,
    s_axis_tready => s_axis_tready,
    s_axis_tlast  => s_axis_tlast);	
	


end rtl;
