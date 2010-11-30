#------------------------------------------------------------------------
#--
#--  NETFPGA10G www.netfpga.org
#--
#--  Module:
#--     trace_gen.py
#--
#--  Description:
#--     This script is used to generate Ethernet pcap trace with 
#--     packet decriptor informaiton (PDI) in UDP payload
#--     The Ethernet frame size is the min 64byte, 
#--     UDP data=64-14(Ehter Header)-20(IPheader)-8(UDP header)=22byte
#--                 
#--  Revision history:
#--     Dec 2012 Qi Zhang initial rev
#--
#--
#------------------------------------------------------------------------

#for accept input parameters e.g. set input pcap file as parameter
import sys, string               

#import the libs from scapy which include Ether, IP, UDP, wrpcap, PcapWriter
from scapy.all import *    
#change the file name/directory for your need
sendp(rdpcap("c:/udp_pdi_paddding.cap"))