###########################################################################
#
#  NETFPGA10G www.netfpga.org
#
#  Module:
#       axitools.py
#
#  Description:
#       A python module for manipulating AXI grammar formatted text.
#

import sys

def axis_dump( packets, f, bus_width, period ):
    """
    Dumps the list of packets to an AXI Stream-grammar formatted text file.
    """
    if bus_width % 8 != 0:
        print "bus_width must be a multiple of 8!"
        return

    bus_width = bus_width / 8
    last_ts   = None
    period    = int(period * 1e9)

    for packet in packets:
        # Output delay parameter
        if last_ts is not None:
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

            if i + bus_width >= len(packet):
                terminal = '.'
            else:
                terminal = ','

            f.write( '%s, %02x%s\t\t\n' % (
                    ''.join( '%02x' % x for x in word ),        # TDATA
                    ((-1 << padding) & 0xff),                   # TSTRB
                    terminal ) )                                # TLAST

            # one clock tick
            last_ts += period
        f.write( '\n' )

# under cygwin, there is no hardware support - so suppress hardware initialisation
if sys.platform.startswith('cygwin'):
        import scapy.config
        scapy.config.conf.iface = ''
