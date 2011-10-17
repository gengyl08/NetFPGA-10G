#!/usr/bin/env b a s h

################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  File:
#        reboot_fpga.sh
#
#  Library:
#        Needs pci_save_restore.sh
#
#  Project:
#        configuration_test_no_cdc
#
#  Author:
#        Muhammad Shahbaz
#
#  Description:
#        For the Flash Controller Project. A sheel script file for reloading
#        the FPGA (from the (B) flash); Save the PCIe status then restores
#        it after the FPGA is re-loaded.
#
#  Copyright notice:
#        Copyright (C) 2010, 2011 University of Cambridge
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

./pci_save_restore.sh save
./set_reboot
./reset_reboot
sleep 2
./pci_save_restore.sh restore

