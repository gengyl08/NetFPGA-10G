------------------------------------------------------------------------------
--
--  NetFPGA-10G http://www.netfpga.org
--
--  File:
--        nf10_axis_sim_stim.vhd
--
--  Library:
--        hw/std/pcores/nf10_axis_sim_stim_v1_00_a
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

use std.textio.all;

library nf10_axis_sim_pkg_v1_00_a;
use nf10_axis_sim_pkg_v1_00_a.nf10_axis_sim_pkg.all;

entity nf10_axis_sim_stim is
    generic (
        C_M_AXIS_DATA_WIDTH : integer := 256;
        C_M_AXIS_TUSER_WIDTH: integer := 128;
        input_file          : string  := "../../stream_data_in.axi"
        );
    port (
        ACLK          : in std_logic;
        ARESETN       : in std_logic;

        -- axi streaming data interface
        M_AXIS_TDATA  : out std_logic_vector( C_M_AXIS_DATA_WIDTH-1 downto 0 );
        M_AXIS_TSTRB  : out std_logic_vector( C_M_AXIS_DATA_WIDTH/8-1 downto 0 );
        M_AXIS_TUSER  : out std_logic_vector( C_M_AXIS_TUSER_WIDTH-1 downto 0 );
        M_AXIS_TVALID : out std_logic;
        M_AXIS_TREADY : in  std_logic;
        M_AXIS_TLAST  : out std_logic
        );
end;


architecture rtl of nf10_axis_sim_stim is
    file f: text open read_mode is input_file;
begin
    process
        -----------------------------------------------------------------------
        -- quiescent()
        --
        --      Quiesce outputs.
        procedure quiescent is
        begin
            M_AXIS_TDATA <= (others => '0');
            M_AXIS_TSTRB <= (others => '0');
            M_AXIS_TUSER <= (others => '0');
            M_AXIS_TLAST <= '0';
            M_AXIS_TVALID <= '0';
        end procedure;
        -----------------------------------------------------------------------
        -- wait_cycle()
        --
        --      Wait for N cycles (1 by default).
        procedure wait_cycle( n: natural := 1 ) is
            variable lp: natural := n;
        begin
            while lp /= 0 loop
                wait until rising_edge(ACLK);
                lp := lp - 1;
            end loop;
        end procedure;
        -----------------------------------------------------------------------
        variable l: line;
        variable i: integer;
        variable c: character;
        variable ok, dontcare: boolean;
    begin
        quiescent;                      -- sane initial outputs

        -- Wait for a couple cycles in case reset is not asserted straight
        -- away.
        --
        -- NB: Reset is ignored except at the beginning of simulation.
        wait_cycle( 10 );
        while ARESETN = '0' loop        -- wait until reset goes away
            wait_cycle;
        end loop;

        -- begin reading stimuli
        while not endfile( f ) loop
            -- Main dispatch: Get and parse input
            readline( f, l );
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
                    report input_file & ": ignoring absolute wait for time that has already passed: " & integer'image(i) & " ns"
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
                M_AXIS_TVALID <= '1';

                -- parse out each component of the stimulus
                parse_slv( l, M_AXIS_TDATA, dontcare );
                assert not dontcare
                    report input_file & ": bad input: nf10_axis_sim_stim doesn't accept 'don't-cares'"
                    severity failure;
                read_char( l, c );      -- discard ','
                parse_slv( l, M_AXIS_TSTRB, dontcare );
                assert not dontcare
                    report input_file & ": bad input: nf10_axis_sim_stim doesn't accept 'don't-cares'"
                    severity failure;
                read_char( l, c );      -- discard ','
                parse_slv( l, M_AXIS_TUSER, dontcare );
                assert not dontcare
                    report input_file & ": bad input: nf10_axis_sim_stim doesn't accept 'don't-cares'"
                    severity failure;
                read_char( l, c );      -- read terminal flag for TLAST...
                if c = '.' then         -- '.' == end of packet
                    M_AXIS_TLAST <= '1';
                elsif c = ',' then      -- ',' == more pkt data to follow
                    M_AXIS_TLAST <= '0';
                else
                    assert false
                        report input_file & ": bad input: expected terminal ',' or '.'"
                        severity failure;
                end if;
                wait_cycle;

                -- block until target ready
                while M_AXIS_TREADY /= '1' loop
                    wait_cycle;
                end loop;
            end if;

            deallocate(l);              -- finished with input line
        end loop;

        -- End of stimuli.
        quiescent;
        write( l, string'("") );
        writeline( output, l );
        write( l, input_file & string'(": end of stimuli @ ") &
                  integer'image(now / 1 ns) & string'(" ns.") );
        writeline( output, l );
        wait;
    end process;
end;
