#!/usr/bin/env bash

################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  File:
#        pci_save_restore.sh
#
#  Author:
#        David J. Miller
#
#  Description:
#        Save and restore PCI configuration data.  Permits hot loading
#        FPGA images without having to reboot operating system.
#
#        NB: depending on chipset and PCIe link activity, the link may not
#            retrain correctly - in which case, a reboot will be required.
#
#        Multiple NetFPGAs are supported, but you must manually determine
#        the logical PCI bus ID.  Use lspci -d 10ee: to identify bus IDs.
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

sbp=/sys/bus/pci          # sysfs PCI subtree
sf=/tmp/pci-config-save   # PCI config space save file base name
vid=0x10ee                # nf10 PCI vendor ID
pid=0x4243                # nf10 PCI product ID

help () {
        echo 'syntax: save|restore [target_bus_id]'
        exit 0
}


# get parameters
op=$1
config=$2

[ -z "$op" -o "$op" == "-h" -o "$op" == "--help" ] && help

# sanity check sysfs
if [ ! -d $sbp ]; then
        echo "sysfs apparently not mounted: $sbp doesn't exist!"
        exit 1
fi

# elaborate path to PCI config space
if [ -z "$config" ]; then
        # automatically detect - find first NF10 card
        for each in $sbp/devices/0000\:*\:00.0; do
                if [ $(($(cat $each/vendor))) -eq $(($vid)) -a \
                   $(($(cat $each/device))) -eq $(($pid)) ]; then
                        config=$each
                fi
        done
        if [ -z "$config" ]; then
                echo "no netfpga found!"
                exit 1
        fi
else
        config=$sbp/devices/0000:$(printf "%02x" $config):00.0
fi
sf=$sf-$(echo $config|cut -f2- -d:)
config=$config/config

# sanity check access
if [ ! -f $config ]; then
        echo "can't access $config"
        exit 1
fi

case $op in
        s*)
        cp -v $config $sf
        ;;
        r*)
        cp -v $sf $config
        ;;
        *)
        help
        ;;
esac
