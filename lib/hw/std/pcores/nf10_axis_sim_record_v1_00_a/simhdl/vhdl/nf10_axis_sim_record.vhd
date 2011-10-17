------------------------------------------------------------------------------
--
--  NetFPGA-10G http://www.netfpga.org
--
--  File:
--        nf10_axis_sim_record.vhd
--
--  Library:
--        hw/std/pcores/nf10_axis_sim_record_v1_00_a
--
--  Author:
--        David J. Miller
--
--  Description:
--        Records traffic received from an AXI Stream master to an
--        AXI grammar formatted text file.
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

entity nf10_axis_sim_record is
    generic (
        C_S_AXIS_DATA_WIDTH : integer := 256;
        C_S_AXIS_TUSER_WIDTH: integer := 128;
        output_file         : string  := "../../stream_data_out.axi"
        );
    port (
        ACLK          : in std_logic;

        -- axi streaming data interface
        S_AXIS_TDATA  : in  std_logic_vector( C_S_AXIS_DATA_WIDTH-1 downto 0 );
        S_AXIS_TSTRB  : in  std_logic_vector( C_S_AXIS_DATA_WIDTH/8-1 downto 0 );
        S_AXIS_TUSER  : in  std_logic_vector( C_S_AXIS_TUSER_WIDTH-1 downto 0 );
        S_AXIS_TVALID : in  std_logic;
        S_AXIS_TREADY : out std_logic;
        S_AXIS_TLAST  : in  std_logic
        );
end;


architecture rtl of nf10_axis_sim_record is
    file f: text open write_mode is output_file;
begin
    -- Always ready to record data
    S_AXIS_TREADY <= '1';

    process(ACLK)
        variable l: line;
        variable bubble_count: natural := 0;
    begin
        if rising_edge( ACLK ) then
            if S_AXIS_TVALID = '1' then
                -- handle non-bubble cycle
                if bubble_count /= 0 then
                    -- write out any elapsed
                    write( l, string'("*") );
                    write( l, bubble_count );
                    writeline( f, l );
                    bubble_count := 0;
                end if;

                -- Write out data
                hwrite( l, S_AXIS_TDATA, RIGHT, S_AXIS_TDATA'length/4 );
                write( l, string'(", ") );
                hwrite( l, S_AXIS_TSTRB, RIGHT, S_AXIS_TSTRB'length/4 );
                write( l, string'(", ") );
                hwrite( l, S_AXIS_TUSER, RIGHT, S_AXIS_TUSER'length/4 );

                -- Write out terminal flag
                if S_AXIS_TLAST = '1' then
                    write( l, string'(".") );
                else
                    write( l, string'(",") );
                end if;

                -- Write out timestamp
                write( l, ht & ht & string'("# ") & integer'image(now / 1 ns) & string'(" ns") );
                writeline( f, l );
            else                        -- S_AXIS_TVALID = '0'
                -- record bubble
                bubble_count := bubble_count + 1;
            end if;
        end if;
    end process;
end;
