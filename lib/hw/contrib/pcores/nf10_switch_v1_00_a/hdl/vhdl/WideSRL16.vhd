--################################################################################
--#
--#  NetFPGA-10G http://www.netfpga.org
--#
--#  File:
--#        WideSRL16.vhd
--#
--#  Library:
--#        hw/std/pcores/nf10_switch_v1_00_a
--#
--#  Author:
--#        Xilinx, Michaela Blott
--#
--#  Description:
--#        basic shift register implementation for a datapth with valid signal (taken from nf10_shell)
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
use IEEE.std_logic_unsigned.all;use IEEE.std_logic_arith.CONV_STD_LOGIC_VECTOR;
library UNISIM;
use UNISIM.VComponents.all;
entity WideSRL16 is
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
   end WideSRL16;

architecture Behavioral of WideSRL16 is

   signal enable : std_logic;
   signal readin_i : std_logic;
   signal validout_i : std_logic;
   signal A : std_logic_vector(3 downto 0);

begin

   enable   <= readin_i;
   validout <= validout_i;
   readin_i <= readout or not validout_i;
   readin   <= readin_i;

   A <= CONV_STD_LOGIC_VECTOR(DEPTH, 4);

   I_SRL_valid : SRL16E
   generic map (INIT => X"0000")
      port map (
         Q   => validout_i,
         CE  => enable,
         A0  => A(0),
         A1  => A(1),
         A2  => A(2),
         A3  => A(3),
         clk => clk,
         D   => validin   );


   I_SRLn:
   for I in 0 to WIDTH-1 generate
   begin
      I_SRL : SRL16E
      generic map (INIT => X"0000")
         port map (
         Q   => dataout(I),
         CE  => enable,
         A0  => A(0),
         A1  => A(1),
         A2  => A(2),
         A3  => A(3),
         clk => clk,
         D   => datain(I)
      );
   end generate;

end Behavioral;
