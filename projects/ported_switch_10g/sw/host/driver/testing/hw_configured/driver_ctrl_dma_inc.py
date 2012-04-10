#!/usr/bin/python

#///////////////////////////////////////////////////////////////////////
#
#   Description:
#       Use driver_ctrl to DMA strings of incrementally increasing size
#       into the hardware, then grab them back out and check that it's
#       the same string.
#
#   Expected System State:
#       - Driver not loaded.
#       - All Ethernet ports looped back (in any arrangement).
# 
#   Revision history:
#       2011/07/26 Jonathan Ellithorpe: Initial check-in
#
#///////////////////////////////////////////////////////////////////////

import re
import sys
import random
import string
import subprocess

def usage(f = sys.stdout):
    print >> f, """
Usage: %(progname)s bufsize_start bufsize_end
    bufsize_start   - Starting buffer size
    bufsize_end     - Ending buffer size
""" % {
    "progname": sys.argv[0],
}

if __name__ == "__main__":
    if(len(sys.argv) != 3):
        usage()
        sys.exit()

    bufsize_start = int(sys.argv[1])
    bufsize_end = int(sys.argv[2])

    error = False

    # Insert the driver.
    subprocess.call("sudo insmod ../../bin/nf10_eth_driver.ko", shell=True)

    # Disable NAPI so that packets are not automatically picked up by
    # the driver and sent to the linux networking stack.
    subprocess.call("../../bin/driver_ctrl napi_disable", shell=True)

    msg_pattern = re.compile('msg:\s+(\w+)', re.DOTALL);

    for bufsize in range(bufsize_start, bufsize_end+1):
        random_string = "".join(random.choice(string.letters + string.digits) for i in xrange(bufsize-1)) 
        random_opcode = 2**(2*random.randint(1,4)-1) 
 
        subprocess.call("../../bin/driver_ctrl dma_tx " + random_string + " " + str(random_opcode), shell=True) 
        output = subprocess.check_output("../../bin/driver_ctrl dma_rx", shell=True)
        msg_match = msg_pattern.search(output)
        if msg_match:
            output = msg_match.group(1)
        else:
            error = True
            print "ERROR: for bufsize: " + str(bufsize) + " got output: " + output
            continue

        output = output.strip()

        if(random_string != output):
            error = True
            print "ERROR: bufsize: " + str(bufsize) 
            continue

    if(error):
        print "DMA test failed."

    # Remove the driver.
    subprocess.call("sudo rmmod nf10_eth_driver", shell=True);
