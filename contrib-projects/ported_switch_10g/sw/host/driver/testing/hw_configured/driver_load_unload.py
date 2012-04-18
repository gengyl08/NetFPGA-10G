#!/usr/bin/python

#///////////////////////////////////////////////////////////////////////
#
#   Description:
#       Load and unload the driver several times.
#
#   Expected System State:
#       Driver is not loaded.
# 
#   Revision history:
#       2011/07/22 Jonathan Ellithorpe: Initial check-in
#
#///////////////////////////////////////////////////////////////////////

import os
import sys

def usage(f = sys.stdout):
    print >> f, """
Usage: %(progname)s iterations
Loads and unloads the driver from the kernel iterations times.
""" % {
    "progname": sys.argv[0],
}

if __name__ == "__main__":
    if(len(sys.argv) != 2):
        usage()
        sys.exit()

    for i in range(int(sys.argv[1])):
        os.system("sudo insmod ../../bin/nf10_eth_driver.ko")
        os.system("sudo rmmod nf10_eth_driver");
