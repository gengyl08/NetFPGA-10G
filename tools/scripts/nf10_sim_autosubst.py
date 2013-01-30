#!/usr/bin/env python-nf

################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  File:
#        nf10_sim_autosubst.py
#
#  Author:
#        David J. Miller, Gianni Antichi
#
#  Description:
#        Automatically substitute specific pcores with instances of the AXI
#        Stream simulation cores nf10_axis_sim_stim and nf10_axis_sim_record.
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

import cStringIO
import mhstools
import optparse
import os
import re
import sys

DEFAULT_TARGETS = [ 'nf10_10g_interface',
                    'nf10_1g_interface',
                    'nf10_oped',
		    'dma',
                    ]

clk_re    = re.compile( '(s_axis_|axi_)aclk', re.IGNORECASE )
rst_re    = re.compile( '\w*(?:axi_|a|\w*)reset_?n', re.IGNORECASE )
m_axis_re = re.compile( 'M_AXIS\w*' )
s_axis_re = re.compile( 'S_AXIS\w*' )

RECORDER_VER = '1.00.a'
STIM_VER     = '1.00.a'


def insert_recorder( mhs, index, comment, inst_name, ver, axi_file, width, net, clock ):
    """
    Inserts an nf10_axis_sim core with provided arguments.
    """
    if width is None:
        width = ''
    else:
        width = 'PARAMETER C_S_AXIS_DATA_WIDTH = %s\n' % width
    mhs[index:index] = mhstools.parse_mhs( cStringIO.StringIO( """\
#
# %s
BEGIN nf10_axis_sim_record
PARAMETER INSTANCE = %s
PARAMETER HW_VER = %s
PARAMETER output_file = %s
%s\
BUS_INTERFACE S_AXIS = %s
PORT aclk = %s
END
""" % (comment,
       inst_name, ver, axi_file, width, net, clock) ) )


def insert_stimulator( mhs, index, comment, inst_name, ver, axi_file, width, net, clock, reset ):
    """
    Inserts an nf10_axis_sim core with provided arguments.
    """
    if width is None:
        width = ''
    else:
        width = 'PARAMETER C_M_AXIS_DATA_WIDTH = %s\n' % width
    mhs[index:index] = mhstools.parse_mhs( cStringIO.StringIO( """\
#
# %s
BEGIN nf10_axis_sim_stim
PARAMETER INSTANCE = %s
PARAMETER HW_VER = %s
PARAMETER input_file = %s
%s\
BUS_INTERFACE M_AXIS = %s
PORT aclk = %s
PORT aresetn = %s
END
""" % (comment, inst_name, ver, axi_file, width, net, clock, reset) ) )


def subst_mhs( mhs, targets, opts ):
    """
    Perform AXI Stream source/sink substitutions
    """
    def get_override( overrides, name, inst ):
        """
        Returns override by instance if one exists, failing which, by core,
        failing which, by default, failing which, None.
        """
        if inst in overrides: return overrides[inst]
        if name in overrides: return overrides[name]
        if ''   in overrides: return overrides['']
        return None

    def do_subst( index, ent ):
        """
        Perform substitution with nf10_axis_sim_{record,stim}.
        """
        core_name = ent.core_name()
        core_inst = mhstools.get_parameter( ent, 'INSTANCE' )
        m_width   = mhstools.get_parameter( ent, 'C_M_AXIS_DATA_WIDTH' )
        s_width   = mhstools.get_parameter( ent, 'C_S_AXIS_DATA_WIDTH' )
        mhstools.set_disabled_flag( ent, True )
        print 'Replacing pcore %s (instance %s):' % (core_name, core_inst)

        # Attempt to infer the correct clock and reset nets
        ports = mhstools.get_ents_by_kw( ent, 'PORT' )

        clock_net = get_override( opts.clocks, core_name, core_inst )
        if clock_net is None:
            clocks = filter( lambda x: clk_re.match(x[0]), ports )
            if len(clocks) == 0:
                print '\terror: failed to infer clock - no candidates found'
                return False
            if len(clocks) > 1:
                print '\terror: failed to infer clock - ambiguous possibilities:'
                print '\t\t%s' % '\n\t\t'.join( ['%s (net %s)' % x for x in clocks] )
                return False
            clock_net = clocks[0][1]
            if clock_net in opts.xlate:
                clock_net = opts.xlate[clock_net]
            print '\tinferred clock net: %s' % clock_net
        else:
            print '\tusing clock net override: %s' % clock_net

        reset_net = get_override( opts.resets, core_name, core_inst )
        if reset_net is None:
            resets = filter( lambda x: rst_re.match(x[0]), ports )
            if len(resets) == 0:
                print '\terror: failed to infer reset - no candidates found'
                return False
            if len(resets) > 1:
                print '\terror: failed to infer reset - ambiguous possibilities:'
                print '\t\t%s' % '\n\t\t'.join( ['%s (net %s)' % x for x in resets] )
                return False
            reset_net = resets[0][1]
            if reset_net in opts.xlate:
                reset_net = opts.xlate[reset_net]
            print '\tinferred reset net: %s' % reset_net
        else:
            print '\tusing reset net override: %s' % reset_net

        # Find any AXI Stream ports, and what they're attached to
        bus_args = mhstools.get_ents_by_kw( ent, 'BUS_INTERFACE' )
        s_axis_nets = [net for cls, net in filter( lambda av: s_axis_re.match( av[0] ), bus_args )]
        s_axis_nets.sort()
        m_axis_nets = [net for cls, net in filter( lambda av: m_axis_re.match( av[0] ), bus_args )]
        m_axis_nets.sort()

        # Insert stimulator and recorder cores for AXI Stream nets attached to this entity
        if not s_axis_nets and not m_axis_nets:
            print '\twarning: no AXI Stream nets found, even though core is a candidate\n'
            return True
        if s_axis_nets:
            print '\tnf10_axis_sim_record instance(s) on AXI Stream master net(s):'
            for netno, net in enumerate(s_axis_nets):
                # Attempt to infer correct width parameter
                try:
                    other = mhstools.get_other_inst( mhs, ent, net )
                except mhstools.TooManyError, e:
                    print 'error: more than one other instance attached to net %s.' % net
                    print '       instance name (core name) found:'
                    print '\t\t%s' % '\n\t\t'.join( ['%s (%s)' % (
                                                    mhstools.get_parameter( x, 'INSTANCE'),
                                                    x.core_name()) for x in e.ents] )
                    return False
                if not other:
                    print '\twarning: nothing else attached to net %s' % net
                    return True
                other_width = mhstools.get_parameter( other, 'C_M_AXIS_DATA_WIDTH' )
                if other_width is not None and s_width is not None and other_width != s_width:
                    print 'error: width of attached instance\'s port disagrees with this instance'
                    print '       net %s' % net
                    print '       this inst = %s, inst %s = %s' % (s_width,
                                                                   mhstools.get_parameter(other, 'INSTANCE'),
                                                                   other_width)
                    return False
                width = (s_width if other_width is None else other_width)

                # Perform substitution
                inst_name = 'record_%s' % net
                axi_file  = os.path.join( opts.axi_path, '%s%s_log.axi' % (core_inst,
                                                  '_%d' % netno if len(m_axis_nets) != 1 else '' ) )
                insert_recorder( mhs, index+1,
                                 'Replacing core %s (instance %s)' % (core_name, core_inst),
                                 inst_name, RECORDER_VER, axi_file, width, net, clock_net )
                print '\t\t%s (%s)' % (net, axi_file)
        if m_axis_nets:
            print '\tnf10_axis_sim_stim instance(s) on AXI Stream slave net(s):'
            for netno, net in enumerate(m_axis_nets):
                # Attempt to infer correct width parameter
                try:
                    other = mhstools.get_other_inst( mhs, ent, net )
                except mhstools.TooManyError, e:
                    print 'error: more than one other instance attached to net %s.' % net
                    print '       instance name (core name) found:'
                    print '\t\t%s' % '\n\t\t'.join( ['%s (%s)' % (
                                                    mhstools.get_parameter( x, 'INSTANCE'),
                                                    x.core_name()) for x in e.ents] )
                    return False
                if not other:
                    print '\twarning: nothing else attached to net %s' % net
                    return True
                other_width = mhstools.get_parameter( other, 'C_S_AXIS_DATA_WIDTH' )
                if other_width is not None and m_width is not None and other_width != m_width:
                    print 'error: width of attached instance\'s port disagrees with this instance'
                    print '       net %s' % net
                    print '       this inst = %s, inst %s = %s' % (m_width,
                                                                   mhstools.get_parameter(other, 'INSTANCE'),
                                                                   other_width)
                    return False
                width = (m_width if other_width is None else other_width)

                # Perform substitution
                inst_name = 'stim_%s' % net
                axi_file  = os.path.join( opts.axi_path, '%s%s_stim.axi' % (core_inst,
                                                  '_%d' % netno if len(m_axis_nets) != 1 else '' ) )
                insert_stimulator( mhs, index+1,
                                   'Replacing core %s (instance %s)' % (core_name, core_inst),
                                   inst_name, STIM_VER, axi_file, width, net, clock_net, reset_net )
                print '\t\t%s (%s)' % (net, axi_file)
        print
        return True

    def do_overrides( index, ent ):
        """
        Perform reset and clock overrides on the specified entity, if required.
        The original instance is retained - but disabled - in the MHS file.  A
        special comment marker flags to UNDO to remove such overriden
        instances.
        """
        core_name = ent.core_name()
        core_inst = mhstools.get_parameter( ent, 'INSTANCE' )
        subst_required = False
        new_inst = ent.copy()
        for inst_ent in new_inst.inst_ents:
            if inst_ent.kw() != 'PORT':
                continue
            for args_index in range(len(inst_ent.args)):
                port, net = inst_ent.args[args_index]
                if net in opts.xlate:
                    inst_ent.args[args_index] = (port, opts.xlate[net])
                    subst_required = True
        if subst_required:
            print 'Performing overrides on pcore %s' % core_name
            print '                    (instance %s)' % core_inst
            mhstools.set_disabled_flag( ent, True )
            ent.comment = mhstools.DISABLED_FLAG
            mhs.insert( index+1, new_inst )
            print

        return True

    for index in reversed(xrange(len(mhs))):
        ent = mhs[index]
        if not ent.is_begin():
            continue

        if ent.core_name() in targets:
            cont_flag = do_subst( index, ent )
        else:
            cont_flag = do_overrides( index, ent )
        if not cont_flag:
            return False
    return True     # Success


def unsubst_mhs( mhs ):
    """
    Undo previous substitutions (delete nf10_axis_sim_* instances, and
    uncomment original cores)
    """
    del_comments = False
    for index in reversed(xrange(len(mhs))):
        ent = mhs[index]

        # All comments after sim cores (in the reversed list) get deleted until
        # next non-comment
        if del_comments and ent.is_comment():
            del mhs[index]
        else:
            del_comments = False

        # Delete sim cores and cores with substituted nets, and enable disabled cores
        if ent.is_begin():
            if ent.disabled_flag:
                mhstools.set_disabled_flag( ent, False )
                if ent.comment == mhstools.DISABLED_FLAG:
                    ent.comment = None
                    del mhs[index+1]
            if ent.core_name() in ['nf10_axis_sim_stim', 'nf10_axis_sim_record']:
                del mhs[index]
                del_comments = True


def net_override_cb( opt, opt_str, value, parser, lblank_allowed ):
    """
    Callback for processing net override arguments.
    """
    try:
        lval, rval = [x.strip() for x in value.split( '=', 1 )]
    except ValueError:
        raise optparse.OptionValueError( '%s: bad spec %s' % (opt_str, value) )
    if not rval:
        raise optparse.OptionValueError( '%s: null rvalue %s' % (opt_str, value) )
    if not lblank_allowed and not lval:
        raise optparse.OptionValueError( '%s: null lvalue %s' % (opt_str, value) )
    getattr( parser.values, opt.dest )[lval] = rval


def main():
    # Hackish but simple fix to optparser's annoying default behaviour of
    # stripping newlines from the epilog.
    optparse.OptionParser.format_epilog = lambda self, formatter: self.epilog

    # Build and parse options
    parser = optparse.OptionParser(
        usage  = '%prog [options] -m <input.mhs> [target_pcores ...]',
        version= '1.0',
        epilog = """
NB: A clock or reset net override not constrained to a specific instance or
    type of pcore (eg -r =my_reset) forces respective net on ALL target
    instances.

NB: if --mhs-out not specified, input MHS file will be substituted in-place.

Current list of default target pcores:
        %s
""" % '\n\t'.join( DEFAULT_TARGETS )
        )
    parser.add_option(
        '--undo', action='store_true', default=False,
        help='Undo any previous substitution')
    parser.add_option(
        '-i', '--mhs-in', type='string', metavar='FILE',
        help='Input MHS file')
    parser.add_option(
        '-o', '--mhs-out', type='string', metavar='FILE',
        help='Output MHS file')
    parser.add_option(
        '-r', '--reset', type='string', metavar='[INST|CORE]=NET', dest='resets', default={},
        action='callback', callback=net_override_cb, nargs=1, callback_args=(True,),
        help='Override reset net for targets')
    parser.add_option(
        '-c', '--clock', type='string', metavar='[INST|CORE]=NET', dest='clocks', default={},
        action='callback', callback=net_override_cb, nargs=1, callback_args=(True,),
        help='Override clock net for targets')
    parser.add_option(
        '-x', '--xlate', type='string', metavar='NET=NET', dest='xlate', default={},
        action='callback', callback=net_override_cb, nargs=1, callback_args=(False,),
        help='Translate net names')
    parser.add_option(
        '-a', '--axi-path', type='string', metavar='PATH', default='../..',
        help='Path to AXI files (default: ../../ which, from the simulator, means the project directory)')
    parser.add_option(
        '--no-default-targets', action='store_true', default=False,
        help='Disable default list of target pcores for substitution')

    opts, targets = parser.parse_args()
    if opts.mhs_in is None:
        raise parser.error( 'name of input MHS required' )
    if not opts.no_default_targets:
        targets += DEFAULT_TARGETS

    # read and parse MHS file
    with open( opts.mhs_in ) as mhs_fh:
        mhs = mhstools.parse_mhs( mhs_fh )

    # perform (or undo) substitutions
    if opts.undo:
        unsubst_mhs( mhs )
    else:
        if not subst_mhs( mhs, targets, opts ):
            return 1

    # write out MHS file
    if opts.mhs_out is None:
        os.rename( opts.mhs_in, os.path.splitext(opts.mhs_in)[0] + '.bk' )
        opts.mhs_out = opts.mhs_in
    with open( opts.mhs_out, 'w' ) as mhs_fh:
        mhstools.write_mhs( mhs_fh, mhs )

    return 0


prog_name = os.path.basename( sys.argv[0] )

if __name__ == '__main__':
    sys.exit(main())
