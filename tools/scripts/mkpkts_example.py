#!/usr/bin/env python-nf

################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  File:
#        mkpkts_example.py
#
#  Author:
#        David J. Miller
#
#  Description:
#        An example of how to use scapy to build packets.  The packet in
#        this example is then output to the console as an AXI Stream
#        transaction file.
#
#        Important: For the sake of portability (especially for Cygwin
#                   environments), specify all addresses.
#
#                   Scapy will attempt to retrieve any missing information
#                   from the operating system, which may fail in some
#                   execution environments (notably Cygwin).
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

import os
import sys

script_dir = os.path.dirname( sys.argv[0] )
# Add path *relative to this script's location* of axitools module
sys.path.append( os.path.join( script_dir, '.' ) )

# NB: axitools import must preceed any scapy imports
import axitools

from scapy.layers.all import Ether, IP, TCP


pkts=[]

# A simple TCP/IP packet embedded in an Ethernet II frame
pkts.append( Ether(src='11:22:33:44:55:66', dst='77:88:99:aa:bb:cc') /
             IP(src='192.168.1.1', dst='192.168.1.2')                /
             TCP()
             )

# scapy doesn't pad packets for us, so we must do so manually.
pkts[-1] = pkts[-1] / ('\0' * (60 - len(pkts[-1])))

# Write out to console
axitools.axis_dump( pkts, sys.stdout, 64, 1/200e6 )
