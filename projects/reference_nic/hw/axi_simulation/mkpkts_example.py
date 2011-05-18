#!/usr/bin/env python26

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

import sys
sys.path.append('../../../../tools/scripts/axitools')

# NB: axitools import must preceed any scapy imports
import axitools

from scapy.layers.all import Ether, IP, TCP


pkts=[]
f0 = open("stream_data_in_0.axi", "w")
f1 = open("stream_data_in_1.axi", "w")
f2 = open("stream_data_in_2.axi", "w")
f3 = open("stream_data_in_3.axi", "w")
f4 = open("stream_data_in_4.axi", "w")

# A simple TCP/IP packet embedded in an Ethernet II frame
pkts.append( Ether(src='11:22:33:44:55:66', dst='77:88:99:aa:bb:cc') /
             IP(src='192.168.1.1', dst='192.168.1.2')                /
             TCP()
             )

# scapy doesn't pad packets for us, so we must do so manually.
pkts[-1] = pkts[-1] / ('\0' * (60 - len(pkts[-1])))

# Write out to console
axitools.axis_dump( pkts, f0, 64, 1/200e6 )
axitools.axis_dump( pkts, f1, 64, 1/200e6 )
axitools.axis_dump( pkts, f2, 64, 1/200e6 )
axitools.axis_dump( pkts, f3, 64, 1/200e6 )
axitools.axis_dump( pkts, f4, 32, 1/200e6 )
