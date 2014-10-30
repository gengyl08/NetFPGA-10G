################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  Author:
#        Yilong Geng
#
#  Description:
#        Helper functions
#
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

import os
from fcntl import *
from struct import *

SIOCDEVPRIVATE = 35312
NF10_IOCTL_CMD_READ_STAT = SIOCDEVPRIVATE + 0
NF10_IOCTL_CMD_READ_REG = SIOCDEVPRIVATE + 2
NF10_IOCTL_CMD_WRITE_REG_PY = SIOCDEVPRIVATE + 1

def rdaxi(addr):

    f = open("/dev/nf10", "r+")
    arg = pack("q", int(addr, 16))
    value = ioctl(f, NF10_IOCTL_CMD_READ_REG, arg)
    value = unpack("q", value)
    value = value[0]
    value = hex(value & int("0xffffffff", 16))
    f.close()
    return value

def wraxi(addr, value):

    f = open("/dev/nf10", "r+")
    arg = (int(addr, 16) << 32) + int(value, 16)
    arg = pack("q", arg)
    ioctl(f, NF10_IOCTL_CMD_WRITE_REG_PY, arg)
    f.close()

def get_base_addr(module_name, path="../../../hw/system.mhs"):

    in_module = False
    with open(path, 'r') as f:
        for line in f:
            if(line.find("INSTANCE") != -1 and line.find(module_name) != -1):
                in_module = True
            if(in_module and line.find("END") != -1):
                in_module = False
                break
            if(in_module and line.find("C_BASEADDR") != -1):
                return line[line.find("0x"):-1]
    return ""

def add_hex(hex1, hex2):

    return hex(int(hex1, 16) + int(hex2, 16))

def hex2ip(hex1):
    hex1 = hex(int(hex1, 16) & int("0xffffffff", 16))
    ip = ""
    for i in range(4):
        ip = ip + '.' + str((int(hex1, 16)>>((3-i)*8)) & int("0xff", 16))
    ip = ip[1:]
    return ip

def ip2hex(ip):
    hex1 = 0
    for tok in ip.split('.'):
        hex1 = (hex1 << 8) + int(tok)
    return hex(hex1 & int("0xffffffff", 16))

# get one bit of value, both int
def get_bit(value, bit):
    return ((value & (2**bit)) >> bit)

def set_bit(value, bit):
    return (value | (2**bit))

def clear_bit(value, bit):
    return (value & (int("0xffffffff", 16) - 2**bit))