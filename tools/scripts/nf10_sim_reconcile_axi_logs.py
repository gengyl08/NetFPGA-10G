#!/usr/bin/env python-nf

################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  File:
#        nf10_sim_reconcile_axi_logs.py
#
#  Author:
#        David J. Miller
#
#  Description:
#        Reconciles *_log.axi with *_expected.axi.
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

from __future__ import with_statement

import axitools
import glob
import os
import sys

EXPECTED_AXI = '_expected.axi'
LOG_AXI      = '_log.axi'

def reconcile_axi( log_pkts, exp_pkts ):
    """
    Reconcile list of logged AXI packets with list of expected packets.
    """
    if log_pkts == exp_pkts:
        print '\tPASS (%d packets expected, %d packets received)' % (len(exp_pkts), len(log_pkts))
        return False
    else:
        print '\tFAIL (%d packets expected, %d packets received)' % (len(exp_pkts), len(log_pkts))
        return True


def main():
    fail = False
    for expected_axi in glob.glob( '*%s' % EXPECTED_AXI ):
        # Find log/expected pairs
        log_axi = '%s%s' % (expected_axi[:-len(EXPECTED_AXI)], LOG_AXI)
        if not os.path.isfile( log_axi ):
            continue
        print 'Reconciliation of %s with %s' % (log_axi, expected_axi)
        # Load packets (time is ignored, so period=1e-9 is hard-coded)
        with open( log_axi ) as f:
            log_pkts = axitools.axis_load( f, 1e-9 )
        with open( expected_axi ) as f:
            exp_pkts = axitools.axis_load( f, 1e-9 )
        fail |= reconcile_axi( log_pkts, exp_pkts )
        print
    sys.exit( fail )

if __name__ == '__main__':
    main()
