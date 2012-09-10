--################################################################################
--#
--#  NetFPGA-10G http://www.netfpga.org
---#
--#  File:
--#        slice.vhd
--#
--#  Library:
--#        hw/std/pcores/nf10_swicth_v1_00_a
--#
--#  Author:
--#        Xilinx, Michaela Blott
--#
--#  Description:
--#        Basic (minimal) slice in an AXI stream implementation
--#        requires 2 registers implemented as FIFO (taken from nf10_shell)
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

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity slice is
generic (
   D_WIDTH     : integer := 32;
   U_WIDTH     : integer := 32;
   DELAY_DEPTH : integer := 30
);
port ( 
   clk : in  std_logic;
   rst : in  std_logic;

   -- slave
   s_axis_tvalid : in std_logic;
   s_axis_tready : out std_logic;
   s_axis_tlast  : in std_logic;  
   s_axis_tuser  : in std_logic_vector (U_WIDTH-1 downto 0); 
   s_axis_tstrb  : in std_logic_vectOR (D_WIDTH/8-1 downto 0);	
   s_axis_tdata  : in std_logic_vector (D_WIDTH-1 downto 0); 

   -- master
   m_axis_tvalid : out std_logic;
   m_axis_tready : in std_logic;
   m_axis_tlast  : out std_logic;  
   m_axis_tuser  : out std_logic_vector (U_WIDTH-1 downto 0);    
   m_axis_tstrb  : out std_logic_vector (D_WIDTH/8-1  downto 0);	
   m_axis_tdata  : out std_logic_vector (D_WIDTH-1 downto 0));
end slice;   
   
   
architecture structural of slice is

component WideSRL16
   generic (
      WIDTH  : integer := 2;
      DEPTH  : integer := 4
      );
   port (
      clk      : in  std_logic;
      datain   : in  std_logic_vector(WIDTH-1 downto 0);
      dataout  : out std_logic_vector(WIDTH-1 downto 0);
      readin   : out std_logic;
      readout  : in  std_logic;
      rst      : in  std_logic;
      validin  : in  std_logic;
      validout : out std_logic);
   end component;
	
signal din, dout : std_logic_vector(D_WIDTH+U_WIDTH+D_WIDTH/8 downto 0);

begin
 
   din <= s_axis_tstrb & s_axis_tlast & s_axis_tuser & s_axis_tdata;
	m_axis_tstrb <= dout(D_WIDTH+U_WIDTH+D_WIDTH/8 downto D_WIDTH+U_WIDTH+1);
   m_axis_tlast <= dout(D_WIDTH+U_WIDTH);
   m_axis_tuser <= dout(D_WIDTH+U_WIDTH-1 downto D_WIDTH);
   m_axis_tdata <= dout(D_WIDTH-1 downto 0);

   slice_i : WideSRL16
   generic map (
      WIDTH  => D_WIDTH+U_WIDTH+1+D_WIDTH/8,
      DEPTH  => DELAY_DEPTH
   )
   port map (
      clk      => clk,
      rst      => rst,
      datain   => din,
      validin  => s_axis_tvalid,
      readin   => s_axis_tready,
      dataout  => dout,
      validout => m_axis_tvalid,
      readout  => m_axis_tready
   );


end structural;
