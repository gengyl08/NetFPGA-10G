#!/usr/bin/env python-nf

################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  File:
#        pcap2axis.py
#
#  Author:
#        David J. Miller
#
#  Description:
#        A command-line tool for translating a pcap trace to an AXI Stream
#        text file.
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

import optparse
import sys
import time

# NB: axitools import must preceed any scapy imports
import axitools
import scapy.layers.all
import scapy.utils

def main():
    """
    Mainline.
    """

    #
    # Parse options
    #

    # Configure parser
    parser = optparse.OptionParser(
        usage  = '%prog <flags> <in_file.pcap> <outfile.axi>',
        version= '1.0',
        )
    parser.add_option(
        '-w', '--width', type='int',
        help='AXI bus width')
    parser.add_option(
        '-b', '--begin-time', type='string',
        help='AXI bus width')
    parser.add_option(
        '-f', '--clk-freq', type='int', default=200,
        help='Data path clock frequency, in MHz (default: 200 MHz)')

    # Parse & check options
    opts, file_args = parser.parse_args()

    if opts.width is None:
        parser.error( 'bus_width argument is required' )
    if opts.begin_time is None:
        parser.error( 'begin_time argument is required' )
    if len(file_args) != 2:
        parser.error( 'exactly two filename arguments required' )

    pcap_file, axi_file = file_args

    # translate time units
    try:
        if opts.begin_time.endswith( 'us' ):
            opts.begin_time = int( opts.begin_time[:-2] ) * 1000
        elif opts.begin_time.endswith( 'ns' ):
            opts.begin_time = int( opts.begin_time[:-2] )
        else:
            opts.begin_time = int( opts.begin_time )
    except ValueError, e:
        parser.error( 'invalid begin_time: ' + opts.begin_time )

    # find period
    opts.period = 1/opts.clk_freq

    # prepare output file
    try:
        f = open( axi_file, 'w' )
    except IOError, e:
        print "couldn't open output file '%s'" % (axi_file)
        sys.exit(1)
    f.write( """\
# AXI4 Stream packets translated from '%s'
# %s

@ %d
""" % (pcap_file, time.asctime(), opts.begin_time) )

    # read packets
    packets = scapy.utils.rdpcap( pcap_file )

    # dump packets
    axitools.axis_dump( packets, f, opts.width, opts.period )



if __name__ == '__main__':
        main()
