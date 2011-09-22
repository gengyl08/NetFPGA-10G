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
#        configuration_test
#
#  Author:
#        Stephanie Friederich
#
#  Description:
#        For the Flash Controller Project. A sheel script file for reloading
#        the FPGA (from the (B) flash); Save the PCIe status then restores
#        it after the FPGA is re-loaded.
#
#  Copyright notice:
#        Copyright (C) 2010,2011 The Board of Trustees of The Leland Stanford
#                                Junior University
#
#  Licence:
#        This file is part of the NetFPGA 10G development base package.
#
#        This package is free software: you can redistribute it and/or modify
#        it under the terms of the GNU Lesser General Public License as
#        published by the Free Software Foundation, either version 3 of the
#        License, or (at your option) any later version.
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

