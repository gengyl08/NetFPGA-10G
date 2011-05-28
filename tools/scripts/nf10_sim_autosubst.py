#!/usr/bin/env python

###########################################################################
#
#  NETFPGA10G www.netfpga.org
#
#  Module:
#       nf10_sim_autosubst.py
#
#  Description:
#       Automatically substitute specific pcores with instances of the AXI
#       Stream simulation cores nf10_axis_sim_stim and nf10_axis_sim_record.
#
#

from __future__ import with_statement

import cStringIO
import itertools
import operator
import optparse
import os
import re
import sys

DEFAULT_TARGETS = [ 'nf10_10g_interface',
                    'nf10_1g_interface',
                    ]

DISABLED_FLAG = '#!'
df_re     = re.compile( '^\s*#\s*!(.*)' ) # disabled flag

clk_re    = re.compile( '\w*aclk', re.IGNORECASE )
rst_re    = re.compile( '\w*(?:axi_|a)reset_?n', re.IGNORECASE )
m_axis_re = re.compile( 'M_AXIS\w*' )
s_axis_re = re.compile( 'S_AXIS\w*' )

RECORDER_VER = '1.00.a'
STIM_VER     = '1.00.a'

class Entity(object):
    """
    Storage class for objects within an MHS file.
    """

    def __init__( self, line ):
        self.disabled_flag = False
        self._kw           = None
        self.args          = []
        self.comment       = None

        # Handle disabled (commented) core instances
        disabled = df_re.match( line )
        if disabled:
            self.disabled_flag = True
            line = disabled.group(1)

        # Handle ordinary comments
        try:
            # Look to see if a comment is present.  If not, index() will throw
            # an exception, and we skip this section.
            hash_index = line.index( '#' )
        except ValueError:
            pass
        else:
            self.comment = line[hash_index + 1:].rstrip('\r\n')
            line = line[:hash_index]

        # Tokenise a keyword line
        kwargs = line.strip().split( None, 1 )
        if len(kwargs) > 0:
            self._kw = kwargs[0]
        if len(kwargs) > 1:
            self.args = [tuple(elt.strip() for elt in av.split('=',1))           # tuples of (a,v)
                                               for av in kwargs[1].split(',')    # list of 'a=v'
                        ]                                                        # [(a,v),...]

    def __str__( self ):
        s = ''
        if self.disabled_flag:
            s += DISABLED_FLAG
        if self._kw is not None:
            args = ', '.join( ' = '.join( av ) for av in self.args )
            s += '%s%s%s' % (self._kw, ' ' if args else '', args)
        if self.comment is not None:
            s += '%s#%s' % ('\t' if s else '', self.comment)
        return s

    def is_begin( self ):
        """
        Check for BEGIN keyword
        """
        return self.kw() == 'BEGIN'

    def is_end( self ):
        """
        Check for END keyword
        """
        return self.kw() == 'END'

    def is_comment( self ):
        """
        Returns True when this object is an ordinary comment
        """
        return self.comment is not None

    def kw( self ):
        """
        Returns keyword (as uppercase) if present, otherwise empty string
        """
        return ('' if self._kw is None else self._kw.upper())

    def core_name( self ):
        """
        Returns the name of the core instance represented by this record, or
        None if not a core instance.
        """
        if self.is_begin():
            return self.args[0][0]


def parse_mhs( fh, lno_gen = None ):
    """
    Parses an MHS file.  Returns a list of Entity instances representing the
    entities in the MHS file.

    NB: BEGIN Entites include the additional attribute `inst_ents`, which is
        itself a list of Entity objects representing the lines that belong to
        that core instance.
    """
    if lno_gen is None:
        lno_gen = itertools.count(1)

    for lno, line in itertools.izip(lno_gen, fh):
        ent = Entity( line )
        if ent.is_begin():
            ent.inst_ents = list(parse_mhs( fh, lno_gen ))
        yield ent
        if ent.is_end():
            return


def set_disabled_flag( ent, val ):
    """
    Set the entity's disabled flag to the specified value.  If the entity is a
    core instance, set all subordinate entities to the same value.
    """
    ent.disabled_flag = val
    if ent.is_begin():
        for inst_ent in ent.inst_ents:
            set_disabled_flag( inst_ent, val )


def get_parameter( ents, name ):
    """
    Attempt to find the instance PARAMETER by `name`.  Returns None if not
    found.  `ents` should be a list of Entity instances in which to search.
    """
    params = [x.args for x in filter( lambda x: x.kw() == 'PARAMETER', ents )]
    params = filter( lambda x: x[0].upper() == name.upper(), reduce( operator.add, params, [] ) )
    return (params[0][1] if params else None)


def insert_recorder( mhs, index, comment, inst_name, ver, axi_file, net, clock ):
    """
    Inserts an nf10_axis_sim core with provided arguments.
    """
    mhs[index:index] = list( parse_mhs( cStringIO.StringIO( """\
#
# %s
BEGIN nf10_axis_sim_record
PARAMETER INSTANCE = %s
PARAMETER HW_VER = %s
PARAMETER output_file = %s
BUS_INTERFACE S_AXIS = %s
PORT aclk = %s
END
""" % (comment, inst_name, ver, axi_file, net, clock) ) ) )


def insert_stimulator( mhs, index, comment, inst_name, ver, axi_file, net, clock, reset ):
    """
    Inserts an nf10_axis_sim core with provided arguments.
    """
    mhs[index:index] = list( parse_mhs( cStringIO.StringIO( """\
#
# %s
BEGIN nf10_axis_sim_stim
PARAMETER INSTANCE = %s
PARAMETER HW_VER = %s
PARAMETER input_file = %s
BUS_INTERFACE M_AXIS = %s
PORT aclk = %s
PORT aresetn = %s
END
""" % (comment, inst_name, ver, axi_file, net, clock, reset) ) ) )


def subst_mhs( mhs, targets, opts ):
    """
    Perform AXI Stream source/sink substitutions
    """
    for index, ent in enumerate(mhs):
        if not ent.is_begin() or ent.core_name() not in targets:
            continue

        core_name = ent.core_name()
        core_inst = get_parameter( ent.inst_ents, 'INSTANCE' )
        set_disabled_flag( ent, True )
        print 'Replacing pcore %s (instance %s):' % (core_name, core_inst)

        # Attempt to infer the correct clock and reset nets
        ports = [x.args for x in filter( lambda x: x.kw() == 'PORT', ent.inst_ents )]
        ports = reduce( operator.add, ports, [] )

        clocks = filter( lambda x: clk_re.match(x[0]), ports )
        if len(clocks) == 0:
            print '\terror: failed to infer clock - no candidates found'
            return False
        if len(clocks) > 1:
            print '\terror: failed to infer clock - ambiguous possibilities:'
            print '\t\t%s' % '\n\t\t'.join( ['%s (net %s)' % x for x in clocks] )
            return False
        clock_net = clocks[0][1]
        print '\tinferred clock net: %s' % clock_net

        resets = filter( lambda x: rst_re.match(x[0]), ports )
        if len(resets) > 1:
            print '\terror: failed to infer reset - ambiguous possibilities:'
            print '\t\t%s' % '\n\t\t'.join( ['%s (net %s)' % x for x in resets] )
            return False
        if len(resets) == 0:
            if opts.default_reset is None:
                print '\terror: failed to infer reset: no candidates found, and no default specified'
                return False
            else:
                print '\tno candidate reset found: using default (net %s)' % opts.default_reset
                reset_net = opts.default_reset
        else: # len(resets) == 1
            reset_net = resets[0][1]
            print '\tinferred reset net: %s' % reset_net

        # Find any AXI Stream ports, and what they're attached to
        bus_ints = [x.args for x in filter( lambda x: x.kw() == 'BUS_INTERFACE', ent.inst_ents )]
        bus_args = reduce( operator.add, bus_ints, [] )
        s_axis_nets = [net for cls, net in filter( lambda av: s_axis_re.match( av[0] ), bus_args )]
        m_axis_nets = [net for cls, net in filter( lambda av: m_axis_re.match( av[0] ), bus_args )]

        # Insert stimulator and recorder cores for AXI Stream nets attached to this entity
        if not s_axis_nets and not m_axis_nets:
            print '\twarning: no AXI Stream nets found, even though core is a candidate\n'
            continue
        if s_axis_nets:
            print '\tnf10_axis_sim_record instance(s) on AXI Stream master net(s):'
            for net in s_axis_nets:
                inst_name = 'record_%s' % net
                axi_file  = '%s/%s_out.axi' % (opts.axi_path, net)
                insert_recorder( mhs, index+1,
                                 'Replacing core %s (instance %s)' % (core_name, core_inst),
                                 inst_name, RECORDER_VER, axi_file, net, clock_net )
                print '\t\t%s (%s)' % (net, axi_file)
        if m_axis_nets:
            print '\tnf10_axis_sim_stim instance(s) on AXI Stream slave net(s):'
            for net in m_axis_nets:
                inst_name = 'stim_%s' % net
                axi_file  = '%s/%s_in.axi' % (opts.axi_path, net)
                insert_stimulator( mhs, index+1,
                                   'Replacing core %s (instance %s)' % (core_name, core_inst),
                                   inst_name, STIM_VER, axi_file, net, clock_net, reset_net )
                print '\t\t%s (%s)' % (net, axi_file)
        print

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

        # Delete sim cores, and enable disabled cores
        if ent.is_begin():
            if ent.disabled_flag:
                set_disabled_flag( ent, False )
            if ent.core_name() in ['nf10_axis_sim_stim', 'nf10_axis_sim_record']:
                del mhs[index]
                del_comments = True


def write_mhs( fh, mhs ):
    for ent in mhs:
        fh.write( '%s\n' % ent )
        if ent.is_begin():
            write_mhs( fh, ent.inst_ents )


def main():
    # Hackish but simple fix to optparser's annoying default behaviour of
    # stripping newlines from the epilog.
    optparse.OptionParser.format_epilog = lambda self, formatter: self.epilog

    # Build and parse options
    parser = optparse.OptionParser(
        usage  = '%prog [options] -m <input.mhs> [target_pcores ...]',
        version= '1.0',
        epilog = """
Current list of default target pcores:
        %s
""" % '\n\t'.join( DEFAULT_TARGETS )
        )
    parser.add_option(
        '--undo', action='store_true', default=False,
        help='Undo any previous substitution')
    parser.add_option(
        '-m', '--mhs-file', type='string', metavar='FILE',
        help='Input MHS file')
    parser.add_option(
        '-r', '--default-reset', type='string', metavar='NET',
        help='Default reset net for targets otherwise lacking an explicit reset')
    parser.add_option(
        '-a', '--axi-path', type='string', metavar='PATH', default='../..',
        help='Path to AXI files (default: ../../ which, from the simulator, means the project directory)')
    parser.add_option(
        '--no-default-targets', action='store_true', default=False,
        help='Disable default list of target pcores for substitution')

    opts, targets = parser.parse_args()
    if opts.mhs_file is None:
        raise parser.error( 'name of input MHS required' )
    if not opts.no_default_targets:
        targets += DEFAULT_TARGETS

    # read and parse MHS file
    with open( opts.mhs_file ) as mhs_fh:
        mhs = list(parse_mhs( mhs_fh ))

    # perform (or undo) substitutions
    if opts.undo:
        unsubst_mhs( mhs )
    else:
        if not subst_mhs( mhs, targets, opts ):
            return 1

    # rename and write out MHS file
    os.rename( opts.mhs_file, os.path.splitext(opts.mhs_file)[0] + '.bk' )
    with open( opts.mhs_file, 'w' ) as mhs_fh:
        write_mhs( mhs_fh, mhs )

    return 0


prog_name = os.path.basename( sys.argv[0] )

if __name__ == '__main__':
    sys.exit(main())
