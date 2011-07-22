#!/usr/bin/env python

###########################################################################
#
#  NETFPGA10G www.netfpga.org
#
#  Module:
#       mkpkts_example.py
#
#  Description:
#       An example of how to use scapy to build packets.  The packet in
#       this example is then output to the console as an AXI Stream
#       transaction file.
#
#       Important: For the sake of portability (especially for Cygwin
#                  environments), specify all addresses.
#
#                  Scapy will attempt to retrieve any missing information
#                  from the operating system, which may fail in some
#                  execution environments (notably Cygwin).
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
