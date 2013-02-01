#!/usr/bin/python

#///////////////////////////////////////////////////////////////////////
#
#   Description:
#       Send packets one by one through the Ethernet interfaces
#       {nf0,nf1,nf2,nf3} via raw sockets and check that the received
#       packets are exactly the ones we sent in, and that we received
#       the packet on the expected interface according to the cabling
#       setup. The user specifies as arguments to this test the cabling
#       arrangement, as well as min and max packet size, and the desired
#       number of packets to send through the card in each direction for
#       each connection. 
#
#   Expected System State:
#       - Driver not loaded.
#       - All Ethernet ports looped back (in any arrangement).
#
#   Revision history:
#       2011/07/25 Jonathan Ellithorpe: Initial check-in
#
#///////////////////////////////////////////////////////////////////////

import re
import sys
import random
import string
import struct
import subprocess
import socket
import time

def usage(f = sys.stdout):
    print >> f, """
Usage: %(progname)s pair1 pair2 pktsize_min pktsize_max num_pkts
    pair1       - 2 digit #. Each digit represents a port.
    pair2       - 2 digit #. Each digit represents a port.
    pktsize_min - Minimum packet size (bytes).
    pktsize_max - Maximum packet size (bytes).
    num_pkts    - Number of packets to send for each connection and direction.

Example:
    %(progname)s 01 23
        Means 0<->1, and 2<->3
""" % {
    "progname": sys.argv[0],
}

if __name__ == "__main__":
    if(len(sys.argv) != 6):
        usage()
        sys.exit()

    pair1_1 = int(sys.argv[1][0])
    pair1_2 = int(sys.argv[1][1])
    pair2_1 = int(sys.argv[2][0])
    pair2_2 = int(sys.argv[2][1])
 
    pairs = ((pair1_1, pair1_2), (pair2_1, pair2_2))

    pktsize_min = int(sys.argv[3])
    pktsize_max = int(sys.argv[4])

    num_pkts = int(sys.argv[5])

    # Insert the driver.
    subprocess.call("sudo insmod ../../bin/nf10_eth_driver.ko", shell=True)

    # Bring up the interfaces
    subprocess.call("for i in 0 1 2 3; do sudo ifconfig nf$i 10.0.$i.1/24; done", shell=True)

    # Use random proto number in the Ethernet packets.
    proto = 0x1234

    # Create the raw sockets.
    nf0_sock = socket.socket(socket.AF_PACKET, socket.SOCK_RAW, proto)
    nf0_sock.bind(("nf0",proto))
    nf1_sock = socket.socket(socket.AF_PACKET, socket.SOCK_RAW, proto)
    nf1_sock.bind(("nf1",proto))
    nf2_sock = socket.socket(socket.AF_PACKET, socket.SOCK_RAW, proto)
    nf2_sock.bind(("nf2",proto))
    nf3_sock = socket.socket(socket.AF_PACKET, socket.SOCK_RAW, proto)
    nf3_sock.bind(("nf3",proto))

    socks = (nf0_sock, nf1_sock, nf2_sock, nf3_sock)

    # Write down the MAC addresses
    nf0_mac = nf0_sock.getsockname()[4]
    nf1_mac = nf1_sock.getsockname()[4]
    nf2_mac = nf2_sock.getsockname()[4]
    nf3_mac = nf3_sock.getsockname()[4]

    macs = (nf0_mac, nf1_mac, nf2_mac, nf3_mac)

    error = False

    # For each pair
    for i in range(0, len(pairs)):
        # For each direction
        for j in range(0, 2):
            src_iface = pairs[i][j%2]
            dst_iface = pairs[i][(j+1)%2]
            
            print "Testing %d->%d with %d packets..."%(src_iface,dst_iface,num_pkts)
            
            # Generate the Ethernet header
            tx_eth_hdr = struct.pack("!6s6sh", macs[src_iface], macs[dst_iface], proto)
            
            for k in range(0, num_pkts):
                # Generate random payload
                payload_len = random.randint(pktsize_min-len(tx_eth_hdr), pktsize_max-len(tx_eth_hdr))
                tx_eth_payload = "".join(random.choice(string.letters + string.digits) for i in xrange(payload_len)) 
            
                # Put the two together...
                tx_eth_pkt = tx_eth_hdr + tx_eth_payload

                # Send
                socks[src_iface].send(tx_eth_pkt)

                # Receive
                rx_eth_pkt = socks[dst_iface].recv(pktsize_max)
                
                # If len(tx_eth_pkt) < 60 then it's a special case
                # Hardware MAC extends pkts to min len 60 with 0 pad
                # so do the same here in software before error checking
                if(len(tx_eth_pkt) < 60):
                    tx_eth_pkt += "".join("\0" for i in xrange(60-len(tx_eth_pkt)))

                if(tx_eth_pkt != rx_eth_pkt):
                    error = True
                    print "ERROR: src: %d dst: %d pkt_num: %d --"%(src_iface,dst_iface,k)
                    print "Tx[%d]: "%len(tx_eth_pkt) + string.join(["%02x"%ord(b) for b in tx_eth_pkt]," ")
                    print "Rx[%d]: "%len(rx_eth_pkt) + string.join(["%02x"%ord(b) for b in rx_eth_pkt]," ")
                
    if(error):
        print "Raw socket loopback test failed."

    for i in range(0, len(socks)):
        socks[i].close()
    
    # Remove the driver.
    subprocess.call("sudo rmmod nf10_eth_driver", shell=True);


