###########################################################################
#
#  NETFPGA10G www.netfpga.org
#
#  Module:
#       axitools.py
#
#  Author:
#       David J. Miller
#
#  Description:
#       A python module for manipulating AXI grammar formatted text.
#

import math
import sys

# under cygwin, there is no hardware support - so suppress hardware initialisation
if sys.platform.startswith('cygwin'):
        import scapy.config
        scapy.config.conf.iface = ''

from scapy.layers.all import Ether


class BadAXIDataException( Exception ):
    """
    AXI file format exceptions.
    """
    def __init__( self, filename, lineno, msg ):
        self.filename = filename
        self.lineno   = lineno
        self.msg      = msg

    def __str__( self ):
        return '%s: %d: bad AXI data: %s' % (self.filename, self.lineno, self.msg)


def axis_dump( packets, f, bus_width, period,
               sport = None, dport = None, tuser_width = 128 ):
    """
    Dumps the list of packets to an AXI Stream-grammar formatted text file.
    Optionally set SPORT/DPORT fields in TUSER.
    """
    if bus_width % 8 != 0:
        print "bus_width must be a multiple of 8!"
        return

    bus_width = bus_width / 8
    strb_mask = (1 << bus_width) - 1
    last_ts   = None
    period    = int(period * 1e9)

    for packet in packets:
        # Output delay parameter
        if last_ts is not None:
            if (int(packet.time * 1e9)-last_ts) > 0 :
                f.write( '+ %d\n' % (int(packet.time * 1e9)-last_ts) )
        last_ts = int(packet.time * 1e9)

        # Turn into a list of bytes
        packet = [ord(x) for x in str(packet)]

        # Dump word-by-word
        for i in range(0, len(packet), bus_width):
            if len(packet)-i < bus_width:
                padding = bus_width - (len(packet)-i)
                word = packet[i:] + [0] * padding
            else:
                padding = 0
                word = packet[i:i+bus_width]
            word.reverse()                            # TDATA is little-endian

            if i + bus_width >= len(packet):
                terminal = '.'
            else:
                terminal = ','

            tuser = [0] * (tuser_width/8)
            if i == 0:
                if dport is not None:
                    tuser[3] = dport
                if sport is not None:
                    tuser[2] = sport
                tuser[1] = len(packet) >> 8
                tuser[0] = len(packet) & 0xff
                tuser.reverse()                        # Make index 0 LSB

            f.write( '%s, %s, %s%s\n' % (
                    ''.join( '%02x' % x for x in word ),                # TDATA
                    ('%x' % (strb_mask >> padding)).zfill(bus_width/4), # TSTRB
                    ''.join( '%02x' % x for x in tuser ),               # TUSER
                    terminal ) )                                        # TLAST

            # one clock tick
            last_ts += period
        f.write( '\n' )


def axis_load( f, bus_width, period ):
    """
    Loads packets from an AXI Stream-grammar formatted text file as a list of
    Scapy packet instances.
    """
    def as_bytes(x):
        """
        Splits hex string X into list of bytes.
        """
        return [int(x[i:i+2],16) for i in range(0,len(x),2)]

    if bus_width % 8 != 0:
        print "bus_width must be a multiple of 8!"
        return

    time = 0
    pkt_data = []
    pkts = []
    for lno, line in enumerate(f):
        lno += 1
        try:
            # Look to see if a comment is present.  If not, index() will throw
            # an exception, and we skip this section.
            hash_index = line.index( '#' )
        except ValueError:
            pass
        else:
            line = line[:hash_index]
        line = line.strip()
        if not line:
            continue

        # Handle delay specs
        if   line[0] == '@':
            time = int(line[1:])/1e9
        elif line[0] == '+':
            time += int(line[1:])/1e9
        elif line[0] == '*':
            time += period * int(line[1:])
        else: # treat as data
            terminal = line[-1]
            line     = line[:-1]
            if terminal not in [',', '.']:
                raise BadAXIDataException( f.name, lno, 'unknown terminal %s' % terminal )
            line = [x.strip() for x in line.split(',')]
            if len(line) != 3:
                raise BadAXIDataException( f.name, lno, 'invalid data (expected 3 fields, got %d)' %len(line) )

            # handle start of packet
            if not pkt_data:
                tuser = as_bytes( line[2] ) # store TUSER (only valid on first cycle)
                tuser.reverse()
                SoP_time = time
            # accumulate packet data
            pkt_data += reversed( as_bytes( line[0].zfill( bus_width/4 ) ) )
            # handle end of packet
            if terminal == '.':
                valid_bytes = int( math.log( int(line[1], 16)+1, 2 ) )
                if valid_bytes < bus_width/8: # trim off any padding
                    del pkt_data[valid_bytes-bus_width/8:]
                pkts.append( Ether( ''.join( [chr(x) for x in pkt_data] ) ) )
                pkts[-1].time = SoP_time
                pkt_data = []
                meta_len = tuser[1] << 8 | tuser[0]
                if len(pkts[-1]) != meta_len:
                    print '%s: %d: #%d: warning: meta length (%d) disagrees with actual length (%d)' % (f.name, lno, len(pkts), meta_len, len(pkts[-1]))
            time += period
    return pkts
