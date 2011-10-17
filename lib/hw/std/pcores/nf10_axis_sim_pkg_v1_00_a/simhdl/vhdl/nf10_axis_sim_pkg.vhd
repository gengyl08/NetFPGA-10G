------------------------------------------------------------------------------
--
--  NetFPGA-10G http://www.netfpga.org
--
--  File:
--        nf10_axis_sim_pkg.vhd
--
--  Library:
--        hw/std/pcores/nf10_axis_sim_pkg_v1_00_a
--
--  Author:
--        David J. Miller
--
--  Description:
--        Stream simulation I/O support package.
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
use ieee.std_logic_textio.all;

package nf10_axis_sim_pkg is
    ----------------------------------------------------------------------
    -- (make) Standard Logic
    --
    --  Return a standard logic from a boolean
    function sl( b: boolean ) return std_logic;

    -----------------------------------------------------------------------
    -- lookahead_char()
    --
    --  Non-destructively parse line for first non-whitespace character.
    --  Also discards comments marked with '#'.  Caller should check 'ok'
    --  to ensure 'c' has valid data.
    procedure lookahead_char( l: inout line; c: out character; ok: out boolean );

    -----------------------------------------------------------------------
    -- read_char()
    --
    --  Read (as a variable) first non-whitespace character.
    procedure read_char( l: inout line; c: out character );

    -----------------------------------------------------------------------
    -- parse_int()
    --
    --  Read (as a variable) an integer from the text line.
    procedure parse_int( l: inout line; i: out integer );

    -----------------------------------------------------------------------
    -- parse_slv()
    --
    --  Read (and drive, as a signal) a standard logic vector from the
    --  text line.  Caller should check 'dontcare' to see whether 'slv'
    --  contains valid data or not.
    procedure parse_slv( l: inout line;
                         signal slv: out std_logic_vector;
                         dontcare: out boolean );

end;

package body nf10_axis_sim_pkg is
    ----------------------------------------------------------------------
    -- (make) Standard Logic
    --
    --  Return a standard logic from a boolean
    function sl( b: boolean ) return std_logic is
    begin
        if b then
            return '1';
        else
            return '0';
        end if;
    end;

    -----------------------------------------------------------------------
    -- lookahead_char()
    --
    --  Non-destructively parse line for first non-whitespace character.
    --  Also discards comments marked with '#'.  Caller should check 'ok'
    --  to ensure 'c' has valid data.
    procedure lookahead_char( l: inout line; c: out character; ok: out boolean ) is
        variable i: natural;
    begin
        for i in 1 to l.all'length loop
            -- Ignore comments
            if l(i) = '#' then
                deallocate(l);          -- no non-comment chars left - discard
                l := new string'("");   -- and replace with empty string
                ok := false;
                return;
            end if;
            -- Return first non-whitespace
            if l(i) /= ' ' and l(i) /= ht and l(i) /= cr then
                c := l(i);
                ok := true;
                return;
            end if;
        end loop;
        ok := false;                    -- no result
    end procedure;

    -----------------------------------------------------------------------
    -- read_char()
    --
    --  Read (as a variable) first non-whitespace character.
    procedure read_char( l: inout line; c: out character ) is
        variable tmp: character;
    begin
        while l.all /= "" loop
            read( l, tmp );             -- destructively read a space from
                                        -- the line
            if tmp /= ' ' and tmp /= ht then
                c := tmp;
                exit;
            end if;
        end loop;
    end procedure;

    -----------------------------------------------------------------------
    -- parse_int()
    --
    --  Read (as a variable) an integer from the text line.
    procedure parse_int( l: inout line; i: out integer ) is
        variable good: boolean;
    begin
        read( l, i, good );
        assert good
            report "bad input: expected an integer: " & l(l'left to l'right)
            severity failure;
    end procedure;

    -----------------------------------------------------------------------
    -- parse_slv()
    --
    --  Read (and drive, as a signal) a standard logic vector from the
    --  text line.  Caller should check 'dontcare' to see whether 'slv'
    --  contains valid data or not.
    procedure parse_slv( l: inout line;
                         signal slv: out std_logic_vector;
                         dontcare: out boolean ) is
        variable val: std_logic_vector(slv'range);
        variable c: character;
        variable good: boolean;
    begin
        -- catch "don't care"s
        lookahead_char( l, c, good );
        assert good
            report "bad input: expected a hex string"
            severity failure;
        if c = '-' then
            read_char( l, c );          -- discard '-'
            dontcare := true;
            return;
        end if;

        -- Not a "don't care" - parse hex string
        hread( l, val, good );
        assert good
            report "bad input: expected a hex string: " & l(l'left to l'right)
            severity failure;
        slv <= val;
        dontcare := false;
    end procedure;

end;
