################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  Author:
#        Yilong Geng
#
#  Description:
#        Code to config delay modules and rate limiters
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
from axi import *
from time import sleep
from math import ceil

DATAPATH_FREQUENCY = 160000000

REORDER_OUTPUT_QUEUES_BASE_ADDR = "0x74400000"

DELAY_BASE_ADDR = {0 : "0x79c80000",
                   1 : "0x79c60000",
                   2 : "0x79c40000",
                   3 : "0x79c20000",
                   4 : "0x79c00000"}

"""
RATE_LIMITER_BASE_ADDR = {0 : "0x77e80000",
                          1 : "0x77e60000",
                          2 : "0x77e40000",
                          3 : "0x77e20000",
                          4 : "0x77e00000"}
"""
class ReorderOutputQueues:

    def __init__(self):
        self.module_base_addr = REORDER_OUTPUT_QUEUES_BASE_ADDR
        self.queues_num_reg_offset = "0x00"
        self.reset_drop_counts_reg_offset = "0x01"
        self.drop_counts_reg_offset = ["0x10", "0x11", "0x12", "0x13", "0x14"]

        self.queues_num = 0
        self.reset_drop_counts = False
        self.drop_counts = [0, 0, 0, 0, 0]

        self.get_queues_num()
        self.get_reset_drop_counts()
        self.get_drop_counts()

    def get_queues_num(self):
        queues_num = rdaxi(self.reg_addr(self.queues_num_reg_offset))
        self.queues_num = int(queues_num, 16)

    def set_queues_num(self, queues_num):
        wraxi(self.reg_addr(self.queues_num_reg_offset), hex(queues_num))
        self.get_queues_num()

    def get_reset_drop_counts(self):
        value = rdaxi(self.reg_addr(self.reset_drop_counts_reg_offset))
        value = int(value, 16)
        if value == 0:
            self.reset_drop_counts = False
        else:
            self.reset_drop_counts = True

    def set_reset_drop_counts(self, reset):
        if reset:
            value = 1
        else:
            value = 0
        wraxi(self.reg_addr(self.reset_drop_counts_reg_offset), hex(value))
        self.get_reset_drop_counts()
        self.get_drop_counts()

    def get_drop_counts(self):
        for i in range(5):
            drop_count = rdaxi(self.reg_addr(self.drop_counts_reg_offset[i]))
            self.drop_counts[i] = int(drop_count, 16)

    def reg_addr(self, offset):
        return add_hex(self.module_base_addr, offset)

    def print_status(self):
        print "Queue Num Max: " + str(self.queues_num)
        print "Reset Drop Counts: " + str(self.reset_drop_counts)
        for i in range(5):
            print "Queue " + str(i) + " Drop Count: " + str(self.drop_counts[i])

"""
class RateLimiter:

    def __init__(self, queue):
        self.queue = queue
        self.module_base_addr = RATE_LIMITER_BASE_ADDR[queue]
        self.rate_reg_offset = "0x0"
        self.enable_reg_offset = "0x1"
        self.reset_reg_offset = "0x2"

        self.rate = 0
        self.enable = False
        self.reset = False

        self.get_rate()
        self.get_enable()
        self.get_reset()

    # rate is stored as an integer value
    def get_rate(self):
        rate = rdaxi(self.reg_addr(self.rate_reg_offset))
        self.rate = int(rate, 16)

    def to_string(self, average_pkt_len, average_word_cnt):
        rate = float(1)/((1<<self.rate)+1)*(average_pkt_len + 4)*8*DATAPATH_FREQUENCY/average_word_cnt
        rate_max = float(10000000000)*(average_pkt_len*8+32)/(average_pkt_len*8+32+96+64)
        rate = float(min(rate_max, rate))
        percentage = float(rate)/rate_max*100
        percentage = '{0:.4f}'.format(percentage)+'%'
        if rate >= 1000000000:
            rate = rate/1000000000
            return '{0:.2f}'.format(rate)+'Gbps '+percentage
        elif rate >= 1000000:
            rate = rate/1000000
            return '{0:.2f}'.format(rate)+'Mbps '+percentage
        elif rate >= 1000:
            rate = rate/1000
            return '{0:.2f}'.format(rate)+'Kbps '+percentage
        else:
            return '{0:.2f}'.format(rate)+'bps '+percentage

    # rate is an interger value
    def set_rate(self, rate):
        wraxi(self.reg_addr(self.rate_reg_offset), hex(rate))
        self.get_rate()

    def get_enable(self):
        value = rdaxi(self.reg_addr(self.enable_reg_offset))
        value = int(value, 16)
        if value == 0:
            self.enable = False
        else:
            self.enable = True

    def set_enable(self, enable):
        if enable:
            value = 1
        else:
            value = 0
        wraxi(self.reg_addr(self.enable_reg_offset), hex(value))
        self.get_enable()

    def get_reset(self):
        value = rdaxi(self.reg_addr(self.reset_reg_offset))
        value = int(value, 16)
        if value == 0:
            self.reset = False;
        else:
            self.reset = True;

    def set_reset(self, reset):
        if reset:
            value = 1
            self.set_rate(0)
            self.set_enable(False)
        else:
            value = 0
        wraxi(self.reg_addr(self.reset_reg_offset), hex(value))
        self.get_reset()


    def reg_addr(self, offset):
        return add_hex(self.module_base_addr, offset)

    def print_status(self):
        print 'queue: '+str(self.queue)+' rate: '+str(self.rate)+' enable: '+str(self.enable)+' reset: '+str(self.reset)
"""


class Delay:

    def __init__(self, queue):
        self.queue = queue
        self.module_base_addr = DELAY_BASE_ADDR[queue]
        self.delay_reg_offset = "0x0"

        # The internal delay_length is in ticks (integer)
        self.delay = 0
        self.get_delay()

    # delay is stored as an integer value
    def get_delay(self):
        delay = rdaxi(self.reg_addr(self.delay_reg_offset))
        self.delay = int(delay, 16)

    def to_string(self):
        return '{:,}'.format(int(self.delay*1000000000/DATAPATH_FREQUENCY))+'ns'

    # delay is an interger value in nano second
    def set_delay(self, delay):
        wraxi(self.reg_addr(self.delay_reg_offset), hex(delay))
        self.get_delay()

    def reg_addr(self, offset):
        return add_hex(self.module_base_addr, offset)

    def print_status(self):
        print 'queue: '+str(self.queue)+' delay: '+str(self.delay)



if __name__=="__main__":
    #print "begin"
    #rateLimiters = {}
    delays = {}

    reorderOutputQueues = ReorderOutputQueues()
    
    # instantiate rate limiters and delay modules for 4 interfaces
    for i in range(5):
        # add rate limiter for that interface
        #rateLimiters.update({i : RateLimiter(i)})
        # add delay module for that interface
        delays.update({i : Delay(i)})

    """
    # configure rate limiters
    for iface, rl in rateLimiters.iteritems():
        rl.set_rate(0)
        rl.set_enable(False)
        rl.print_status()
    """

    reorderOutputQueues.print_status()

    # configure delay modules
    for iface, d in delays.iteritems():
        d.set_delay(0)
        d.print_status()
        