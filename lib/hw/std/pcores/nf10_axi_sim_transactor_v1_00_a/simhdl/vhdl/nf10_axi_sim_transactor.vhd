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
use ieee.std_logic_textio.all;

use std.textio.all;

library nf10_axis_sim_pkg_v1_00_a;
use nf10_axis_sim_pkg_v1_00_a.nf10_axis_sim_pkg.all;

library nf10_axi_sim_transactor_v1_00_a;

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
    signal reset                         : std_logic;

    file stim: text open  read_mode is stim_file;
    file log : text open write_mode is log_file;

    signal w_req_addr                    : std_logic_vector(31 downto 0);
    signal w_req_data                    : std_logic_vector(31 downto 0);
    signal w_req_strb                    : std_logic_vector( 3 downto 0);
    signal w_req_valid                   : std_logic;
    signal w_req_ready                   : std_logic;

    signal w_rsp_addr                    : std_logic_vector(31 downto 0);
    signal w_rsp_data                    : std_logic_vector(31 downto 0);
    signal w_rsp_rsp                     : std_logic_vector( 1 downto 0);
    signal w_rsp_valid                   : std_logic;

    signal r_req_addr                    : std_logic_vector(31 downto 0);
    signal r_req_valid                   : std_logic;
    signal r_req_ready                   : std_logic;

    signal r_rsp_addr                    : std_logic_vector(31 downto 0);
    signal r_rsp_data                    : std_logic_vector(31 downto 0);
    signal r_rsp_rsp                     : std_logic_vector( 1 downto 0);
    signal r_rsp_valid                   : std_logic;
begin
    reset <= not M_AXI_ARESETN;

    stimulation: process
        -----------------------------------------------------------------------
        -- quiescent()
        --
        --      Quiesce outputs.
        procedure quiescent is
        begin
            w_req_addr <= (others => '0');
            w_req_data <= (others => '0');
            w_req_strb <= (others => '0');
            w_req_valid <= '0';

            r_req_addr <= (others => '0');
            r_req_valid <= '0';
        end procedure;
        -----------------------------------------------------------------------
        -- wait_cycle()
        --
        --      Wait for N cycles (1 by default).
        procedure wait_cycle( n: natural := 1 ) is
            variable lp: natural := n;
        begin
            while lp /= 0 loop
                wait until rising_edge(M_AXI_ACLK);
                lp := lp - 1;
            end loop;
        end procedure;
        -----------------------------------------------------------------------
        variable l: line;
        variable i: integer;
        variable c: character;
        variable ok, dontcare: boolean;
        variable w_pending, r_pending: std_logic;
    begin
        quiescent;                      -- sane initial outputs

        -- Wait for a couple cycles in case reset is not asserted straight
        -- away.
        --
        -- NB: Reset is ignored except at the beginning of simulation.
        wait_cycle( 10 );
        while reset = '1' loop          -- wait until reset goes away
            wait_cycle;
        end loop;

        -- begin reading stimuli
        while not endfile( stim ) loop
            -- Main dispatch: Get and parse input
            readline( stim, l );
            lookahead_char( l, c, ok );
            next when not ok;

            -- operator *(N): wait for N cycles
            if c = '*' then             -- wait n cycles
                read_char( l, c );      -- discard operator
                parse_int( l, i );
                quiescent;
                wait_cycle( i );

            -- operator @(N): wait until absolute time N ns
            elsif c = '@' then          -- wait until absolute time (ns)
                read_char( l, c );      -- discard operator
                parse_int( l, i );
                assert now < (1 * 1 ns)
                    report stim_file & ": ignoring absolute wait for time that has already passed: " & integer'image(i) & " ns"
                    severity warning;
                if now < (i * 1 ns) then -- ignore absolute times that have
                                         -- already passed
                    quiescent;
                    wait for (i * 1 ns) - now;
                    wait_cycle;
                end if;

            -- operator +(N): wait for N ns
            elsif c = '+' then          -- wait for relative time (ns)
                read_char( l, c );      -- discard operator
                parse_int( l, i );
                quiescent;
                wait for (i * 1 ns);
                wait_cycle;

            -- data transfer: a cycle containing active data
            else
                -- parse out each component of the stimulus
                parse_slv( l, w_req_addr, dontcare );
                w_pending := sl( not dontcare );
                w_req_valid <= w_pending;
                read_char( l, c );      -- discard ','

                parse_slv( l, w_req_data, dontcare );
                if w_pending = '1' then
                    assert not dontcare
                        report stim_file & ": malformed write request: missing data"
                        severity warning;
                end if;
                read_char( l, c );      -- discard ','

                parse_slv( l, w_req_strb, dontcare );
                if w_pending = '1' then
                    assert not dontcare
                        report stim_file & ": malformed write request: missing byte lane strobe"
                        severity warning;
                end if;
                read_char( l, c );      -- discard ','

                parse_slv( l, r_req_addr, dontcare );
                r_pending := sl( not dontcare );
                r_req_valid <= r_pending;
                wait_cycle;

                -- block until accepted
                while ((w_pending and not w_req_ready) or (r_pending and not r_req_ready)) = '1' loop
                    wait_cycle;
                end loop;
                w_req_valid <= '0';
                r_req_valid <= '0';

                -- wait for transactions to return, as required
                read_char( l, c );      -- read terminal wait flag
                if c = '.' then         -- '.' == wait for result
                    while (w_pending or r_pending) = '1' loop
                        wait_cycle;
                        if w_rsp_valid = '1' and w_rsp_addr = w_req_addr then
                            w_pending := '0';
                        end if;
                        if r_rsp_valid = '1' and r_rsp_addr = r_req_addr then
                            r_pending := '0';
                        end if;
                    end loop;
                elsif c = ',' then      -- continue immediately
                else
                    assert false
                        report stim_file & ": bad input: expected terminal ',' or '.'"
                        severity failure;
                end if;
            end if;

            deallocate(l);              -- finished with input line
        end loop;

        -- End of stimuli.
        quiescent;
        write( l, string'("") );
        writeline( output, l );
        write( l, stim_file & string'(": end of stimuli @ ")  &
                  integer'image(now / 1 ns) & string'(" ns.") );
        writeline( output, l );
        wait;
    end process;

    logging: process( M_AXI_ACLK )
        function result_str( res: std_logic_vector(1 downto 0) ) return string is
        begin
            case res is
                when "00"   => return "OKAY";
                when "01"   => return "EXOKAY";
                when "10"   => return "SLVERR";
                when "11"   => return "DECERR";
                when others => return "INVALID_RESP";
            end case;
        end function;

        variable l: line;
    begin
        if rising_edge( M_AXI_ACLK ) then
            if w_rsp_valid = '1' then
                hwrite( l, w_rsp_addr, RIGHT, w_rsp_addr'length/4 );
                write( l, string'(" <- ") );
                hwrite( l, w_rsp_data, RIGHT, w_rsp_data'length/4 );
                write( l, string'(" (" & result_str( w_rsp_rsp ) & ")") &
                          ht & ht & string'("# ") & integer'image(now / 1 ns) & string'(" ns") );
                writeline( log, l );
            end if;
            if r_rsp_valid = '1' then
                hwrite( l, r_rsp_addr, RIGHT, r_rsp_addr'length/4 );
                write( l, string'(" -> ") );
                hwrite( l, r_rsp_data, RIGHT, r_rsp_data'length/4 );
                write( l, string'(" (" & result_str( r_rsp_rsp ) & ")") &
                           ht & ht & string'("# ") & integer'image(now / 1 ns) & string'(" ns") );
                writeline( log, l );
            end if;
        end if;
    end process;

    fifos: entity nf10_axi_sim_transactor_v1_00_a.transactor_fifos
        port map (
            clk           => M_AXI_ACLK,
            reset         => reset,
            --
            w_req_addr    => w_req_addr,
            w_req_data    => w_req_data,
            w_req_strb    => w_req_strb,
            w_req_valid   => w_req_valid,
            w_req_ready   => w_req_ready,

            w_rsp_addr    => w_rsp_addr,
            w_rsp_data    => w_rsp_data,
            w_rsp_rsp     => w_rsp_rsp,
            w_rsp_valid   => w_rsp_valid,
            --
            r_req_addr    => r_req_addr,
            r_req_valid   => r_req_valid,
            r_req_ready   => r_req_ready,

            r_rsp_addr    => r_rsp_addr,
            r_rsp_data    => r_rsp_data,
            r_rsp_rsp     => r_rsp_rsp,
            r_rsp_valid   => r_rsp_valid,
            --
            M_AXI_AWADDR  => M_AXI_AWADDR,
            M_AXI_AWVALID => M_AXI_AWVALID,
            M_AXI_AWREADY => M_AXI_AWREADY,
            M_AXI_WDATA   => M_AXI_WDATA,
            M_AXI_WSTRB   => M_AXI_WSTRB,
            M_AXI_WVALID  => M_AXI_WVALID,
            M_AXI_WREADY  => M_AXI_WREADY,
            M_AXI_BRESP   => M_AXI_BRESP,
            M_AXI_BVALID  => M_AXI_BVALID,
            M_AXI_BREADY  => M_AXI_BREADY,
            M_AXI_ARADDR  => M_AXI_ARADDR,
            M_AXI_ARVALID => M_AXI_ARVALID,
            M_AXI_ARREADY => M_AXI_ARREADY,
            M_AXI_RDATA   => M_AXI_RDATA,
            M_AXI_RRESP   => M_AXI_RRESP,
            M_AXI_RVALID  => M_AXI_RVALID,
            M_AXI_RREADY  => M_AXI_RREADY);
end;
