#!/bin/bash

########################################################################
#
#  NETFPGA-10G www.netfpga.org
#
#  Module:
#          reboot_fpga.sh
#
#  Description:
#          For the Flash Controller Project. A sheel script file for reloading
#          the FPGA (from the (B) flash); Save the PCIe status then restores 
#          it after the FPGA is re-loaded.
#                 
#  Revision history:
#          08/07/2011 Mark Grindell Initial Revision.
#          date author description
#          date author description
#
#  Known issues:
#          None
#
#  Library: Needs pci_save_restore.sh
#
###########################################################################

./pci_save_restore.sh save
./set_reboot
./reset_reboot
sleep 2
./pci_save_restore.sh restore

