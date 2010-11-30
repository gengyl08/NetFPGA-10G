#------------------------------------------------------------------------
#--
#--  NETFPGA10G www.netfpga.org
#--
#--  Module:
#--     trace_gen.py
#--
#--  Description:
#--     This script is used to generate Ethernet pcap trace with packet 
#--     decriptor informaiton (PDI) in UDP payload
#--     The Ethernet frame size is the min 64byte, 
#--     UDP data=64-14(Ehter Header)-20(IPheader)-8(UDP header)=22byte
#--                 
#--  Revision history:
#--     Dec 2012 Qi Zhang initial rev
#--
#--
#------------------------------------------------------------------------
 

#for accept input parameters
import sys, string               

#import the libs from scapy which include Ether, IP, UDP, wrpcap, PcapWriter
from scapy.all import *    
 

#open the data file for PDI informaiton  path:  /usr/.. for linux
openfile=open('C:/myfile_3.txt', 'r') 


#write packet with pcap format 
writer=PcapWriter("c:/t_3.pcap")


#build fundamental packet compose of Ether header, IP header, and UDP header
b=Ether(dst="ff:ff:ff:ff:ff:ff")/IP()/UDP(sport=50813, dport=3702)
#b=Ether(dst="00:24:E8:9F:49:4F")/IP()/UDP(sport=50813, dport=3702)

#set initialization values
b.time=0

#packet rate = 1/time_interval pps or you can read time sequence from txt file
time_interval=0.000001

#padding length
padding_length=44

#read PDI file line by line
for line in openfile:

#(28(padding)+16(PDI))/2=22 byte padding and remove new line \n
	flowid='0000000000000000000000000000'+line.rstrip('\n') 	 
	#print flowid	
	
#decode the HEX string for writing into UDP payload, guarantee the length of 22byte 
	flowdecode=flowid[0:padding_length].decode('hex')  
	
#add the decode PDI information to UDP payload
	b[UDP].payload=flowdecode
	#b[UDP].payload.show()  
	
#write Ethernet frame to pcap file                
	writer.write(b)        
	
# set packet arrival time for next frame	                
	b.time=b.time+time_interval             
	
# after loop, close file
openfile.close()






