------------------------------------------------------------------------------
--
--  NetFPGA-10G http://www.netfpga.org
--
--  File:
--        nf10_axi_sim_transactor.vhd
--
--  Library:
--        hw/std/pcores/nf10_axi_sim_transactor_v1_00_a
--
--  Author:
--        David J. Miller
--
--  Description:
--        Drives an AXI Stream slave using stimuli from an AXI grammar
--        formatted text file.
--
--  Copyright notice:
--        Copyright (C) 2010, 2011 David J. Miller
--
--  Licence:
--        This file is part of the NetFPGA 10G development base package.
--
--        This file is free code: you can redistribute it and/or modify it under
--        the terms of the GNU Lesser General Public License version 2.1 as
--        published by the Free Software Foundation.
--
--        This package is distributed in the hope that it will be useful, but
--        WITHOUT ANY WARRANTY; without even the implied warranty of
--        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
--        Lesser General Public License for more details.
--
--        You should have received a copy of the GNU Lesser General Public
--        License along with the NetFPGA source package.  If not, see
--        http://www.gnu.org/licenses/.
--
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity nf10_axi_sim_transactor is
    generic (
        stim_file             : string  := "../../reg_stim.axi";
        log_file              : string  := "../../reg_stim.log"
        );
    port (
        M_AXI_ACLK               : in  std_logic;
        M_AXI_ARESETN            : in  std_logic;

        -- AXI Lite interface
        --
        -- AXI Write address channel
        M_AXI_AWADDR             : out std_logic_vector(31 downto 0);
        M_AXI_AWVALID            : out std_logic;
        M_AXI_AWREADY            : in  std_logic;
        -- AXI Write data channel
        M_AXI_WDATA              : out std_logic_vector(31 downto 0);
        M_AXI_WSTRB              : out std_logic_vector( 3 downto 0);
        M_AXI_WVALID             : out std_logic;
        M_AXI_WREADY             : in  std_logic;
        -- AXI Write response channel
        M_AXI_BRESP              : in  std_logic_vector( 1 downto 0);
        M_AXI_BVALID             : in  std_logic;
        M_AXI_BREADY             : out std_logic;
        -- AXI Read address channel
        M_AXI_ARADDR             : out std_logic_vector(31 downto 0);
        M_AXI_ARVALID            : out std_logic;
        M_AXI_ARREADY            : in  std_logic;
        -- AXI Read data & response channel
        M_AXI_RDATA              : in  std_logic_vector(31 downto 0);
        M_AXI_RRESP              : in  std_logic_vector( 1 downto 0);
        M_AXI_RVALID             : in  std_logic;
        M_AXI_RREADY             : out std_logic
        );
end;


architecture rtl of nf10_axi_sim_transactor is
begin
    -- Quiescent master
    M_AXI_AWADDR  <= (others => '0');
    M_AXI_AWVALID <= '0';

    M_AXI_WDATA   <= (others => '0');
    M_AXI_WSTRB   <= (others => '0');
    M_AXI_WVALID  <= '0';

    M_AXI_BREADY  <= '1';

    M_AXI_ARADDR  <= (others => '0');
    M_AXI_ARVALID <= '0';

    M_AXI_RREADY  <= '1';
end;
