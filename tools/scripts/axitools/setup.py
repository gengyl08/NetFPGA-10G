#!/usr/bin/env python

###########################################################################
#
#  NETFPGA10G www.netfpga.org
#
#  Module:
#       setup.py
#
#  Description:
#       distutils installer for axitools module.
#

import sys
from distutils.core import setup, Extension

def do_setup( cmd = ['build'] ):
    setup( script_args = cmd,
           name = 'axitools',
           version = '1.0',
           description = 'Python support for reading and writing AXI grammar formatted text files',
           py_modules=['axitools'],
           scripts=['pcap2axis.py',]
           )

if __name__ == '__main__':
    do_setup( sys.argv[1:] )

