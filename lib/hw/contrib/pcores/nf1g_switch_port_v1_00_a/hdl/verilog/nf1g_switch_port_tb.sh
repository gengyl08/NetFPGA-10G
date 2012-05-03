################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  File:
#        nf1g_switch_port_tb.sh
#
#  Library:
#        hw/contrib/pcores/nf1g_switch_port_v1_00_a
#
#  Module:
#        nf1g_switch_port_tb.sh
#
#  Author:
#        Gianni Anitchi
#
#  Description:
#        Mark Grindell- batch file to compile the test bench for the
#                       module, and to check it's basic functionality
#
#  Copyright notice:
#        Copyright (C) 2010, 2011 The Board of Trustees of The Leland Stanford
#                                 Junior University
#
#  Licence:
#        This file is part of the NetFPGA 10G development base package.
#
#        This file is free code: you can redistribute it and/or modify it under
#        the terms of the GNU Lesser General Public License version 2.1 as
#        published by the Free Software Foundation.
#
#        This package is distributed in the hope that it will be useful, but
#        WITHOUT ANY WARRANTY; without even the implied warranty of
#        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#        Lesser General Public License for more details.
#
#        You should have received a copy of the GNU Lesser General Public
#        License along with the NetFPGA source package.  If not, see
#        http://www.gnu.org/licenses/.
#
#

cd $(dirname $0)
rm -rf unittest_build
mkdir  unittest_build
cd     unittest_build
fuse -incremental work.glbl -prj ../nf1g_switch_port_tb.prj  -L unisims_ver -L nf10_axis_converter_v1_00_a -L unimacro_ver -L xilinxcorelib_ver -L nf10_proc_common_v1_00_a -L nf10_axis_pbs_bridge_v1_00_a -L nf10_axilite_rbs_bridge_v1_00_a -o nf1g_switch_port_tb.exe testbench
./nf1g_switch_port_tb.exe -tclbatch ../nf1g_switch_port_tb.tcl
