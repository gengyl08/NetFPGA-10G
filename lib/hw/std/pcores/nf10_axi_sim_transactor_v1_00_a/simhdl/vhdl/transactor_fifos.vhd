------------------------------------------------------------------------------
--
--  NetFPGA-10G http://www.netfpga.org
--
--  File:
--        transactor_fifos.vhd
--
--  Library:
--        hw/std/pcores/nf10_axi_sim_transactor_v1_00_a
--
--  Module:
--        nf10_axi_sim_transactor.vhd
--
--  Author:
--        David J. Miller
--
--  Description:
--        AXI4 Lite I/O FIFOs
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

use std.textio.all;

library proc_common_v3_00_a;

entity transactor_fifos is
    port (
        clk                      : in  std_logic;
        reset                    : in  std_logic;

        --
        -- Transactor interface
        --
        w_req_addr               : in  std_logic_vector(31 downto 0);
        w_req_data               : in  std_logic_vector(31 downto 0);
        w_req_strb               : in  std_logic_vector( 3 downto 0);
        w_req_valid              : in  std_logic;
        w_req_ready              : out std_logic;

        w_rsp_addr               : out std_logic_vector(31 downto 0);
        w_rsp_data               : out std_logic_vector(31 downto 0);
        w_rsp_rsp                : out std_logic_vector( 1 downto 0);
        w_rsp_valid              : out std_logic;
        --
        r_req_addr               : in  std_logic_vector(31 downto 0);
        r_req_valid              : in  std_logic;
        r_req_ready              : out std_logic;

        r_rsp_addr               : out std_logic_vector(31 downto 0);
        r_rsp_data               : out std_logic_vector(31 downto 0);
        r_rsp_rsp                : out std_logic_vector( 1 downto 0);
        r_rsp_valid              : out std_logic;

        --
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


architecture rtl of transactor_fifos is
    signal w_req_we                      : std_logic;
    signal int_w_addr_full               : std_logic;
    signal int_w_addr_empty              : std_logic;
    signal w_req_addr_data               : std_logic_vector(w_rsp_addr'length+w_req_data'length-1 downto 0);
    signal w_rsp_addr_data               : std_logic_vector(w_rsp_addr'length+w_req_data'length-1 downto 0);

    signal axi_w_addr_full               : std_logic;
    signal axi_w_addr_empty              : std_logic;

    signal w_req_data_strb_full          : std_logic;
    signal w_req_data_strb_empty         : std_logic;
    signal w_req_data_strb               : std_logic_vector(w_req_strb'length+w_req_data'length-1 downto 0);
    signal w_axi_data_strb               : std_logic_vector(w_req_strb'length+w_req_data'length-1 downto 0);

    signal r_req_we                      : std_logic;
    signal int_r_addr_full               : std_logic;
    signal int_r_addr_empty              : std_logic;
    signal r_rsp_addr_i                  : std_logic_vector(r_rsp_addr'range);

    signal axi_r_addr_full               : std_logic;
    signal axi_r_addr_empty              : std_logic;
begin
    ---------------------------------------------------------------------------
    -- AXI Write
    ---------------------------------------------------------------------------

    w_req_ready <= not int_w_addr_full and not axi_w_addr_full and not w_req_data_strb_full;
    w_req_we    <= not int_w_addr_full and not axi_w_addr_full and not w_req_data_strb_full and w_req_valid;

    w_req_addr_data <= w_req_addr & w_req_data;
    w_req_data_strb <= w_req_strb & w_req_data;

    int_w_addr: entity proc_common_v3_00_a.srl_fifo_f
        generic map (
            C_DWIDTH => w_req_addr_data'length,
            C_DEPTH  => 16)
        port map (
            Clk        => clk,
            Reset      => reset,

            FIFO_Write => w_req_we,
            Data_In    => w_req_addr_data,
            FIFO_Full  => int_w_addr_full,

            FIFO_Read  => M_AXI_BVALID,
            Data_Out   => w_rsp_addr_data,
            FIFO_Empty => int_w_addr_empty,
            Addr       => open);

    axi_w_addr: entity proc_common_v3_00_a.srl_fifo_f
        generic map (
            C_DWIDTH => w_req_addr'length,
            C_DEPTH  => 16)
        port map (
            Clk        => clk,
            Reset      => reset,

            FIFO_Write => w_req_we,
            Data_In    => w_req_addr,
            FIFO_Full  => axi_w_addr_full,

            FIFO_Read  => M_AXI_AWREADY,
            Data_Out   => M_AXI_AWADDR,
            FIFO_Empty => axi_w_addr_empty,
            Addr       => open);

    axi_w_data: entity proc_common_v3_00_a.srl_fifo_f
        generic map (
            C_DWIDTH => w_req_data_strb'length,
            C_DEPTH  => 16)
        port map (
            Clk        => clk,
            Reset      => reset,

            FIFO_Write => w_req_we,
            Data_In    => w_req_data_strb,
            FIFO_Full  => w_req_data_strb_full,

            FIFO_Read  => M_AXI_WREADY,
            Data_Out   => w_axi_data_strb,
            FIFO_Empty => w_req_data_strb_empty,
            Addr       => open);

    M_AXI_AWVALID <= not axi_w_addr_empty;

    M_AXI_WDATA  <= w_axi_data_strb(M_AXI_WDATA'range);
    M_AXI_WSTRB  <= w_axi_data_strb(w_axi_data_strb'high downto w_axi_data_strb'high-M_AXI_WSTRB'length+1);
    M_AXI_WVALID <= not w_req_data_strb_empty;

    w_rsp_addr   <= w_rsp_addr_data(w_rsp_addr_data'high downto w_rsp_addr_data'high-w_req_addr'length+1)
                                        when int_w_addr_empty = '0' else (others => '-');
    w_rsp_data   <= w_rsp_addr_data(w_req_data'length - 1 downto 0)
                                        when int_w_addr_empty = '0' else (others => '-');
    w_rsp_rsp    <= M_AXI_BRESP  when M_AXI_BVALID = '1'     else (others => '-');
    w_rsp_valid  <= M_AXI_BVALID;
    M_AXI_BREADY <= '1';

    ---------------------------------------------------------------------------
    -- AXI Read
    ---------------------------------------------------------------------------

    r_req_ready <= not int_r_addr_full and not axi_r_addr_full;
    r_req_we    <= not int_r_addr_full and not axi_r_addr_full and r_req_valid;

    int_r_addr: entity proc_common_v3_00_a.srl_fifo_f
        generic map (
            C_DWIDTH => r_req_addr'length,
            C_DEPTH  => 16)
        port map (
            Clk        => clk,
            Reset      => reset,

            FIFO_Write => r_req_we,
            Data_In    => r_req_addr,
            FIFO_Full  => int_r_addr_full,

            FIFO_Read  => M_AXI_RVALID,
            Data_Out   => r_rsp_addr_i,
            FIFO_Empty => int_r_addr_empty,
            Addr       => open);

    axi_r_addr: entity proc_common_v3_00_a.srl_fifo_f
        generic map (
            C_DWIDTH => r_req_addr'length,
            C_DEPTH  => 16)
        port map (
            Clk        => clk,
            Reset      => reset,

            FIFO_Write => r_req_we,
            Data_In    => r_req_addr,
            FIFO_Full  => axi_r_addr_full,

            FIFO_Read  => M_AXI_ARREADY,
            Data_Out   => M_AXI_ARADDR,
            FIFO_Empty => axi_r_addr_empty,
            Addr       => open);

    M_AXI_ARVALID <= not axi_r_addr_empty;

    r_rsp_addr   <= r_rsp_addr_i when int_r_addr_empty = '0' else (others => '-');
    r_rsp_data   <= M_AXI_RDATA  when M_AXI_RVALID = '1'     else (others => '-');
    r_rsp_rsp    <= M_AXI_RRESP  when M_AXI_RVALID = '1'     else (others => '-');
    r_rsp_valid  <= M_AXI_RVALID;
    M_AXI_RREADY <= '1';
end;
