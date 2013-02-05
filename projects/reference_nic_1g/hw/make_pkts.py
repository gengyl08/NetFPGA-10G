#!/usr/bin/env python-nf

################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  File:
#        make_pkts.py
#
#  Project:
#        nic
#
#  Module:
#        mkpkts_example.py
#
#  Author:
#        James Hongyi Zeng, Gianni Antichi
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

from __future__ import with_statement

import os
import sys

script_dir = os.path.dirname( sys.argv[0] )
# Add path *relative to this script's location* of axitools module
sys.path.append( os.path.join( script_dir, '..','..','..','tools','scripts' ) )

# NB: axitools import must preceed any scapy imports
import axitools

from scapy.layers.all import Ether, IP, TCP


pkts=[]
# A simple TCP/IP packet embedded in an Ethernet II frame
for i in range(8):
    pkt = (Ether(src='11:22:33:44:55:66', dst='77:88:99:aa:bb:cc')/
           IP(src='192.168.1.1', dst='192.168.1.2')/
           TCP()/
           'Hello, NetFPGA-10G!')
    pkt.time        = i*(1e-8)
    # Set source network interface for DMA stream
    pkt.tuser_sport = 1 << (i%4*2 + 1) # PCI ports are odd-numbered
    pkts.append(pkt)

# PCI interface
with open( os.path.join( script_dir, 'dma_0_stim.axi' ), 'w' ) as f:
    axitools.axis_dump( pkts, f, 256, 1e-9 )
with open( os.path.join( script_dir, 'dma_0_expected.axi' ), 'w' ) as f:
    axitools.axis_dump( pkts*4, f, 256, 1e-9 )
# 10g interfaces
for i in range(4):
    # replace source port
    for pkt in pkts:
        pkt.tuser_sport = 1 << (i*2) # physical ports are even-numbered
    with open( os.path.join( script_dir, 'nf10_1g_interface_%d_stim.axi' % i ), 'w' ) as f:
        axitools.axis_dump( pkts, f, 256, 1e-9 )
    with open( os.path.join( script_dir, 'nf10_1g_interface_%d_expected.axi' % i ), 'w' ) as f:
        axitools.axis_dump( pkts[0:2], f, 256, 1e-9 )
