#!/usr/bin/env python-nf

################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  File:
#        src_file_policy.py
#
#  Author:
#        David J. Miller
#
#  Description:
#        Check and enforce source file policy.  Current policies include:
#              - Interpreter hack:
#                        + present or not (per type policy)
#                        + If present, uses /usr/bin/env
#                        + Name: python-nf for python, bash for sh
#              - NetFPGA header present and contains:
#                        + NetFPGA project name banner
#                        + Module name
#                        + Author
#                        + Description
#                        + Copyright and licence statements
#              - Header does NOT include change history
#              - EOL is Unix style (ie, not \r\n)
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

import optparse
import os
import re
import sys
import string
import time

# Log names (relative to base_pkg)
SUCCESS_LOG = '../pol_success.log'
IGNORED_LOG = '../pol_ignored.log'
NOHDR_LOG   = '../pol_no_header.log'
WARN_LOG    = '../pol_warning.log'
FAIL_LOG    = '../pol_failure.log'
FORBID_LOG  = '../pol_forbidden.log'

# TYPE_INFO: a tuple of (comment_str, interp_required, interpreter).
#       comment_str: tuple of (single, begin, middle, end)
#                    eg, for C: ('//', '/*', ' *', ' */')
#       interp_required: None = forbidden, False = optional, True = mandatory
#       interpreter: if present, should be this value
COM_STYLES = { 'C'   : ('//', '/*', ' *', ' */'),
               'sh'  : ('#', None, None, None),
               'vhdl': ('--', None, None, None),
               }
TYPE_INFO = { '.axi'    : (COM_STYLES['sh'],   None, ''),
              '.bsv'    : (COM_STYLES['C'],    None, ''),
              '.c'      : (COM_STYLES['C'],    None, ''),
              '.cpp'    : (COM_STYLES['C'],    None, ''),
              '.cxx'    : (COM_STYLES['C'],    None, ''),
              '.h'      : (COM_STYLES['C'],    None, ''),
              '.mpd'    : (COM_STYLES['sh'],   None, ''),
              '.v'      : (COM_STYLES['C'],    None, ''),
              '.vhd'    : (COM_STYLES['vhdl'], None, ''),
              '.opt'    : (COM_STYLES['sh'],   None, ''),
              '.pao'    : (COM_STYLES['sh'],   None, ''),
              '.py'     : (COM_STYLES['sh'],   False, 'python-nf'),
              '.sh'     : (COM_STYLES['sh'],   True,  'bash'),
              '.scr'    : (COM_STYLES['sh'],   None, ''),
              '.tcl'    : (COM_STYLES['sh'],   None, ''),
              '.txt'    : (COM_STYLES['sh'],   None, ''),
              '.ucf'    : (COM_STYLES['sh'],   None, ''),
              '.xcf'    : (COM_STYLES['sh'],   None, ''),
              '.xco'    : (COM_STYLES['sh'],   None, ''),
              'README'  : (COM_STYLES['sh'],   None, ''),
              'Makefile': (COM_STYLES['sh'],   None, ''),
              }
# Extensions to ignore
IGNORE    = [ '.bbd', '.bit', '.bmp', '.cdc', '.cdf', '.cip', '.cproject',
              '.diff', '.do', '.doc', '.docx', '.dtd', '.edn', '.gise', '.gitignore',
              '.jed', '.jpg', '.mhs', '.mui', '.ngc', '.pdf', '.png', '.prj',
               '.prod_test_cfg', '.script', '.xml', '.xmp', '.xise',
              '.0', '.1', '.2', '.3', '.4', '.5', '.6', '.7', '.8', '.9',
              'NOTICE', 'LICENSE', 'COPYING', 'python-nf', ]

IGNORE_PATH = [ 'archive',
                'lib/hw/xilinx',
                'projects/reference_nic/sw/host/driver/lib/libnl-3.0',
                'projects/stresstest',
                ]

SECTIONS  = [ 'author',
              'description',
              'file',
              'known issues',
              'module',
              'name',
              'project',
              'revision history',
              'structure',
              'library',
              'copyright notice',
              'licence',
              'original header',
              ]

#
# Header banner
#
hdr_indent1 = 2
hdr_indent2 = 8
hdr_prolog = """\

NetFPGA-10G http://www.netfpga.org

""".splitlines()
#
# Copyright statements
#
cambridge_copyright = """\
Copyright (C) 2010, 2011 University of Cambridge""".splitlines()
DM_copyright = """\
Copyright (C) 2010, 2011 David J. Miller""".splitlines()
oped_copyright = """\
Portions copyright (C) 2010, 2011 Atomic Rules LLC
Portions copyright (C) 2010, 2011 The Board of Trustees of The Leland Stanford
                                  Junior University""".splitlines()
stanford_copyright = """\
Copyright (C) 2010, 2011 The Board of Trustees of The Leland Stanford
                         Junior University""".splitlines()
xilinx_copyright = """\
Copyright (C) 2010, 2011 Xilinx, Inc.""".splitlines()
#
# Licences
#
lgpl21_licence = """\
This file is part of the NetFPGA 10G development base package.

This file is free code: you can redistribute it and/or modify it under
the terms of the GNU Lesser General Public License version 2.1 as
published by the Free Software Foundation.

This package is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with the NetFPGA source package.  If not, see
http://www.gnu.org/licenses/.""".splitlines()

lgpl30_licence = """\
This file is part of the NetFPGA 10G development base package.

This file is free code: you can redistribute it and/or modify it under
the terms of the GNU Lesser General Public License version 3.0 as
published by the Free Software Foundation.

This package is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with the NetFPGA source package.  If not, see
http://www.gnu.org/licenses/.""".splitlines()

AC        = 'Adam Covington'
DM        = 'David J. Miller'
JE        = 'Jonathan Ellithorpe'
JH        = 'James Hongyi Zeng'
MB        = 'Michaela Blott'
MS        = 'Muhammad Shahbaz'
SF        = 'Stephanie Friederich'
SS        = 'Shep Siegel'

AUTHORS   = [ ('lib/hw/netwave/pcores/nf10_axis_netwave_core',            [MB],    xilinx_copyright, lgpl21_licence),
              ('lib/hw/netwave/pcores/nf10_axis_netwave_gen_check',       [MB],    xilinx_copyright, lgpl21_licence),
              ('lib/hw/netwave/pcores/nf10_axis_netwave_l2switch',        [MB],    xilinx_copyright, lgpl21_licence),
              ('lib/hw/std/pcores/nf10_10g_interface',                    [JH],  stanford_copyright, lgpl21_licence),
              ('lib/hw/std/pcores/nf10_1g_interface',                     [AC],  stanford_copyright, lgpl21_licence),
              ('lib/hw/std/pcores/nf10_axis_converter',                   [JH],  stanford_copyright, lgpl21_licence),
              ('lib/hw/std/pcores/nf10_axis_gen_check',                   [MB],    xilinx_copyright, lgpl21_licence),
              ('lib/hw/std/pcores/nf10_axis_sim_pkg',                     [DM],        DM_copyright, lgpl21_licence),
              ('lib/hw/std/pcores/nf10_axis_sim_record',                  [DM],        DM_copyright, lgpl21_licence),
              ('lib/hw/std/pcores/nf10_axis_sim_stim',                    [DM],        DM_copyright, lgpl21_licence),
              ('lib/hw/std/pcores/nf10_axi_flash_ctrl',                   [SF],    xilinx_copyright, lgpl21_licence),
              ('lib/hw/std/pcores/nf10_axi_sim_transactor',               [DM],        DM_copyright, lgpl21_licence),
              ('lib/hw/std/pcores/nf10_bram_output_queues',               [JH],  stanford_copyright, lgpl21_licence),
              ('lib/hw/std/pcores/nf10_input_arbiter',                    [AC],  stanford_copyright, lgpl21_licence),
              ('lib/hw/std/pcores/nf10_nic_output_port_lookup',           [AC],  stanford_copyright, lgpl21_licence),
              ('lib/hw/std/pcores/nf10_oped',                             [SS,
                                                                           JH],      oped_copyright, lgpl30_licence),
              ('lib/hw/std/pcores/nf10_sram',                             [JH],  stanford_copyright, lgpl21_licence),
              ('projects/configuration',                                  [MS], cambridge_copyright, lgpl21_licence),
              ('projects/configuration_test',                             [SF],    xilinx_copyright, lgpl21_licence),
              ('projects/configuration_test_no_cdc',                      [SF],    xilinx_copyright, lgpl21_licence),
              ('projects/loopback_test',                                  [JH],  stanford_copyright, lgpl21_licence),
              ('projects/loopback_test_1g',                               [JH],  stanford_copyright, lgpl21_licence),
              ('projects/memory_test',                                    [JH],  stanford_copyright, lgpl21_licence),
              ('projects/netwave',                                        [MB],    xilinx_copyright, lgpl21_licence),
              ('projects/oped_test',                                      [JH],  stanford_copyright, lgpl21_licence),
              ('projects/production_test',                                [MB],    xilinx_copyright, lgpl21_licence),
              ('projects/reference_nic/sw/host',                          [JE],  stanford_copyright, lgpl21_licence),
              ('projects/reference_nic',                                  [JH],  stanford_copyright, lgpl21_licence),
              ('projects/reference_nic_1g/sw/host',                       [JE],  stanford_copyright, lgpl21_licence),
              ('projects/reference_nic_1g',                               [AC],  stanford_copyright, lgpl21_licence),
              ('projects/stresstest',                                     [MB],    xilinx_copyright, lgpl21_licence),
              ]


all_styles = re.compile( '^[%s]+' % ''.join( x.strip()[0] for x in filter( lambda x: x is not None,
                                                                           sum( ([s,m] for s, _, m, _ in COM_STYLES.values()), [] ) ) ) )
def replace_header( opts, base_pkg, rel_filename, successes, ignored, noheader, failures, warnings, forbidden ):
    """
    Parse and replace header of a single file, but only if really sure.
    """
    def get_hdr_line( line ):
        """
        Return the rstrip()ed text of a header comment (ie a line containing no
        code and only a comment.)  If the line contains code, returns None.
        """
        line_strip = line.strip()
        # Ignore empty lines (ie, no comment, no code)
        if not line_strip:
            return ''
        # Get comment text, if line contains only a comment
        if cmt_single and line_strip.startswith( cmt_single ):
            return all_styles.sub( '', line_strip[len(cmt_single):] )
        if cmt_start and line_strip.startswith( cmt_start ):
            return all_styles.sub( '', line_strip[len(cmt_start):] )
        if cmt_mid and line_strip.startswith( cmt_mid_strip ):
            return all_styles.sub( '', line_strip[len(cmt_mid_strip):] )
        # is not a header comment: flag by returning None
        return None

    def strip_common_leading_whitespace( lines ):
        """
        Strips from every line the maximum amount of white space that is common
        to ALL lines
        """
        # Find left-most line in description, and remove that much leading
        # space from all lines.
        common_margin = 1000
        for line in lines:
            if not line:
                continue
            margin = len(line)-len(line.lstrip())
            if margin < common_margin:
                common_margin = margin
        return [line[common_margin:] for line in lines]


    # Ignore ignored paths
    for path in IGNORE_PATH:
        if rel_filename.startswith( path ):
            return 0
    # Get file type and associated information.  Handle ignored and forbidden
    # (ie, unknown) file types.
    extn = os.path.splitext( rel_filename )[1]
    if not extn:
        # No extension, so use whole filename
        extn = os.path.basename( rel_filename )
    if extn in IGNORE:
        ignored.setdefault( extn, [] ).append( rel_filename )
        return 0
    if extn not in TYPE_INFO:
        forbidden.append( rel_filename )
        return 0
    ((cmt_single, cmt_start, cmt_mid, cmt_end), interp_required, interpreter) = TYPE_INFO[extn]
    cmt_mid_strip = cmt_mid and cmt_mid.strip() # might have leading spaces

    # Analyse file
    header            = {}
    original_header   = []
    fail_flags        = []
    warn_flags        = []
    text              = []
    section           = ''
    blk_cmt_end_seen  = False
    nf10g_banner_seen = False
    tab_in_hdr_seen   = False
    with open( os.path.join( base_pkg, rel_filename ) ) as f:
        #
        # Get interpreter (which must be 1st line of file), if any, and check
        # against policy requirements
        #
        try:
            line_strip = f.next().strip()
        except StopIteration:
            # File is empty
            line_strip = ''
        if interp_required is True and not line_strip.startswith( '#!' ):
            # Interpreter required, and is missing
            fail_flags.append( 'interp_missing' )
            f.seek( 0 )
        if interp_required is None and line_strip.startswith( '#!' ):
            # Interpreter forbidden, and is present
            fail_flags.append( 'interp_forbidden' )
        if line_strip.startswith( '#!' ):
            # Interpreter is either required, or optional, and is present.
            # Get rid of any space between ! and /
            # Check interpreter: should call /usr/bin/env, and have specified name
            elts = line_strip[2:].split()
            if elts[0] != '/usr/bin/env':
                warn_flags.append( 'interp_ne_env' )
                elts[1:1] = os.path.basename( elts[0] )
                elts[0] = '/usr/bin/env'
            elif len(elts) < 2 or elts[1] != interpreter:
                warn_flags.append( 'interp_name' )
            text.append( '#!' + ' '.join( elts ) )
            text.append( '' )
        else: # not an interpreter hack line
            f.seek( 0 )

        #
        # Parse existing header, if any
        #
        text_first_line = ''
        for line in f:
            cmt_line = get_hdr_line( line )
            if not line.strip():
                # An empty line (no code, and no comment) after the nf10g
                # banner has been seen indicates the end of the header block
                # comment.
                if nf10g_banner_seen:
                    blk_cmt_end_seen = True
            elif blk_cmt_end_seen or cmt_line is None: # and also non-empty line
                # The first non-empty line after the end of the header block
                # comment, whether code or comment, indicates the end of header
                # processing.  A comment line of None (indicating code)
                # likewise indicates the end of the header.
                text_first_line = line.rstrip()
                break
            # else must be header line: look for header information.
            cmt_strip = cmt_line.lstrip()

            # Look for NetFPGA banner
            nf10g_banner_seen |= cmt_line.find( 'netfpga.org' ) != -1
            # Look for stray tabs
            tab_in_hdr_seen   |= cmt_line.find( '\t' ) != -1
            # Gather header data: test for presence of section heading
            elts = cmt_strip.split( ':', 1 )
            if len(elts) == 2:
                # A section heading is a (stripped) single word ending with a ':'.
                possible_section = elts[0].lower()
                if possible_section in SECTIONS:
                    section = possible_section
                    # Might have section data appended to section heading line
                    cmt_line = elts[1]
            # Anything else is section data
            header.setdefault( section, [] ).append( cmt_line )
            # Put verbatim copy of original header under 'original header'
            original_header.append( cmt_line )

        #
        # Clean up collected data
        #

        if not nf10g_banner_seen:
            if opts.force_header:
                # Forcing headers when absent: Preserve original header.
                header['original header'] = original_header
            else:
                # No NetFPGA banner means either the header was mangled, or
                # missing altogether (and --force-header not specified) so bail
                # on this file.
                noheader.append( rel_filename )
                return 0
        # Look up authors, copyrights and licence by relative path
        for base, authors, copyrights, licence in AUTHORS:
            if rel_filename.startswith( base ):
                break
        else: # None found
            authors    = None
            copyrights = stanford_copyright
            licence    = lgpl21_licence
        # Check author, copyright and licence sections
        if authors    is not None and (opts.force_author    or 'author'           not in header):
            header['author'] = authors
        if copyrights is not None and (opts.force_copyright or 'copyright notice' not in header):
            header['copyright notice'] = copyrights
        if licence    is not None and (opts.force_licence   or 'licence'          not in header):
            header['licence'] = licence
        # The presence of tabs in the header indicate that left justification
        # of the comment might be screwed up.
        if tab_in_hdr_seen:
            warn_flags.append( 'tab_in_hdr' )
        # Set filename appropriately
        header['file'] = [os.path.basename( rel_filename )]
        # Set section project or library, based on file path
        rel_elts = rel_filename.split( os.path.sep )
        if rel_elts[0] == 'projects':
            header['project'] = [rel_elts[1]]
        if rel_elts[0] == 'lib':
            header['library'] = [os.path.join( *rel_elts[1:5] )]
        # Delete any leading or trailing empty lines from each section
        for section in header:
            while header[section] and not header[section][0]:
                del header[section][0]
            while header[section] and not header[section][-1]:
                del header[section][-1]
        # Delete module section if it's the same as the filename
        if 'module' in header and header['module'][0].find( header['file'][0] ) != -1:
            del header['module']
        # Delete 'original header' if empty
        if 'original header' in header and not header['original header']:
            del header['original header']
        # Delete *all* leading or trailing whitespace in the following sections
        for section in ['library', 'project', 'module', 'author']:
            if section in header:
                header[section] = [x.strip() for x in header[section]]
        # Delete *common* leading whitespace in the following sections
        for section in ['description', 'copyright notice', 'licence', 'original header']:
            if section in header:
                header[section] = strip_common_leading_whitespace( header[section] )

        #
        # Check header for required data
        #
        if 'module' in header:
            # If it is present, then there should be exactly one of them
            if len(header['module']) != 1:
                warn_flags.append( 'multi_module' )
        # At least at the moment, there should be only one author per module.
        # Missing author tag is a critical fail, because we can't guess this.
        if 'author' not in header:
            fail_flags.append( 'no_author' )
        # Description may be multiline, but needs leading whitespace to be
        # cleaned up.  Absence is a failure, because we can't guess this.
        if 'description' not in header:
            fail_flags.append( 'no_desc' )

        #
        # Insert standardised header
        #

        # Gather comment characters
        cmt_start = cmt_start or cmt_single
        cmt_mid   = cmt_mid   or cmt_single
        cmt_end   = cmt_end   or cmt_single
        cmt_hbar  = cmt_mid.strip()*(80/len(cmt_mid.strip())-len(cmt_mid))
        # Add prolog
        text.append( '%s%s' % (cmt_start, cmt_hbar) )
        for line in hdr_prolog:
            text.append( ('%s%s%s' % (cmt_mid, ' '*hdr_indent1, line)).rstrip() )
        # Add section data
        for section in ['file', 'library', 'project', 'module', 'author', 'description',
                        'copyright notice', 'licence', 'original header']:
            if section in header:
                text.append( '%s%s%s:' % (cmt_mid, ' '*hdr_indent1, section.capitalize() ) )
                for sect_info in header[section]:
                    text.append( ('%s%s%s' % (cmt_mid, ' '*hdr_indent2, sect_info )).rstrip() )
                text.append( cmt_mid )
        text.append( cmt_end )
        text.append( '' )
        # Rest of file.
        text.append( text_first_line )
        # get rest of source text
        for line in f:
            text.append( line.rstrip() )

    if warn_flags:
        warnings.append( (rel_filename, warn_flags) )
    if fail_flags:
        failures.append( (rel_filename, fail_flags) )
    else:
        successes.setdefault( extn, [] ).append( rel_filename )
    # Write file back out, if not dry-run
    if opts.really:
        with open( os.path.join( base_pkg, rel_filename ), 'w' ) as f:
            f.writelines( '%s\n' % line for line in text )
    return 1


def get_base_pkg( path ):
    """
    Attempts to split the given path into base_pkg (path of the NetFPGA base
    package) and subdir (any residual path) by first looking for
    'netfpga-10g-dev', then 'netfpga'.
    """
    elts = path.split( os.path.sep )
    elts[0] = os.path.sep
    for root in ['netfpga-10g-dev', 'netfpga']:
        try:
            nfroot_idx = elts.index( root )
        except ValueError:
            pass
        else:
            break
    else:
        raise ValueError( 'no NetFPGA base package found in %s' % path )
    base_pkg = os.path.join( *elts[:nfroot_idx+1] )
    subdir = elts[nfroot_idx+1:]
    if subdir:
        subdir = os.path.join( *subdir )
    else:
        subdir = ''
    return (base_pkg, subdir)


def main( argv ):
    """
    Parse and replace all source headers.
    """

    #
    # Parse options
    #

    # Configure parser
    parser = optparse.OptionParser(
        usage  = '%prog [-h|--help] [options] [file [...]]',
        version= '1.0',
        epilog = """\
If no files are specified, walk the entire development tree containing
this script, and perform replacement on all sources found.

CAUTION: *no* backup of input is made before it is rewritten.
         Use on a tree containing local changes at your own risk!
"""
        )
    parser.add_option(
        '--really', action='store_true', default=False,
        help='Really write out changes.  Otherwise dry-run.')
    parser.add_option(
        '--force-header', action='store_true', default=False,
        help='Force write of new NetFPGA 10G header, where none was present before.')
    parser.add_option(
        '--force-author', action='store_true', default=False,
        help='Force rewrite of *every* NetFPGA 10G Author section.')
    parser.add_option(
        '--force-licence', action='store_true', default=False,
        help='Force rewrite of *every* NetFPGA 10G header licence.')
    parser.add_option(
        '--force-copyright', action='store_true', default=False,
        help='Force rewrite of *every* NetFPGA 10G header copyright notice.')


    # Parse & check options
    opts, file_args = parser.parse_args()
    if (opts.force_author or opts.force_licence or opts.force_copyright) and not file_args:
        parser.error( '--force flags require explicit list of targets' )

    successes = {}
    ignored   = {}
    noheader  = []
    failures  = []
    warnings  = []
    forbidden = []
    count     = 0
    if not file_args:
        # No files/directories specified, so attempt to work out which tree to
        # work on.  First try to find a tree in the current wd.
        try:
            base_pkg, _ = get_base_pkg( os.getcwd() )
        except ValueError:
            # None found, so use package this script is a part of
            base_pkg = os.path.dirname( os.path.dirname( os.path.dirname(__file__ ) ) )
        file_args = [base_pkg]
    # Process list of targets
    for file in file_args:
        base_pkg, tail = get_base_pkg( os.path.abspath( file ) )
        file = os.path.join( base_pkg, tail )
        if os.path.isdir( file ):
            for root, dirs, files in os.walk( file ):
                # Don't recurse into the .git directory
                try:
                    del dirs[dirs.index( '.git' )]
                except ValueError:
                    pass

                for file in files:
                    rel_filename = os.path.join( root, file )[len(base_pkg)+1:]
                    count += replace_header( opts, base_pkg, rel_filename,
                                             successes, ignored, noheader, failures, warnings, forbidden )
        else:
            rel_filename = file[len(base_pkg)+1:]
            count += replace_header( opts, base_pkg, rel_filename,
                                     successes, ignored, noheader, failures, warnings, forbidden )

    # Write logs
    log_header = """\
# %s: detailed report: %s
# tree: %s
# date: %s
"""
    time_now = time.asctime()
    with open( os.path.join( base_pkg, SUCCESS_LOG ), 'w' ) as log:
        log.write( log_header % (prog_name, 'files successfully processed, without warnings',
                                 base_pkg, time_now ) )
        log.writelines( ['%s\n' % f for f in sorted( sum(successes.itervalues(), []) )] or '# (none)\n' )
    with open( os.path.join( base_pkg, IGNORED_LOG ), 'w' ) as log:
        log.write( log_header % (prog_name,
                                 'files ignored by policy', base_pkg, time_now ) )
        log.writelines( ['%s, %s\n' % (e, f) for e, f in sorted((e,f) for e,l in ignored.iteritems() for f in l )] or '# (none)\n' )
    with open( os.path.join( base_pkg, NOHDR_LOG ), 'w' ) as log:
        log.write( log_header % (prog_name, 'files missing NetFPGA header',
                                 base_pkg, time_now ) )
        log.writelines( ['%s\n' % f for f in sorted( noheader )] or '# (none)\n' )
    with open( os.path.join( base_pkg, WARN_LOG ), 'w' ) as log:
        log.write( log_header % (prog_name, 'files successfully processed, but with warnings',
                                 base_pkg, time_now ) )
        log.writelines( ['%s; %s\n' % (', '.join(w), f) for f, w in sorted( warnings )] or '# (none)\n' )
    with open( os.path.join( base_pkg, FAIL_LOG ), 'w' ) as log:
        log.write( log_header % (prog_name, 'files with policy failures',
                                 base_pkg, time_now ) )
        log.writelines( ['%s; %s\n' % (', '.join(w), f) for f, w in sorted( failures )] or '# (none)\n' )
    with open( os.path.join( base_pkg, FORBID_LOG ), 'w' ) as log:
        log.write( log_header % (prog_name, 'files forbidden (or/and unknown)',
                                 base_pkg, time_now ) )
        log.writelines( ['%s\n' % f for f in sorted( forbidden )] or '# (none)\n' )

    # Report to console
    print """\
%s: summary report (%s modifying %s files) in tree:
\t%s

Files successfully processed, count by extension:
\t%s

Files ignored by policy, count by extension:
\t%s

Files missing NetFPGA header                                      : %s
Files successfully processed, but with policy warnings            : %s
Files with policy failures, requiring attention                   : %s
Forbidden files (those either unexpected, or shouldn't be present): %s

Wrote out logs:
\t%s
""" % (prog_name, opts.really and '*REALLY*' or 'NOT', count,
       base_pkg,
       '\n\t'.join(['%-20s%4s' % (k, len(v)) for k, v in sorted(successes.iteritems())]) or '(none)',
       '\n\t'.join(['%-20s%4s' % (k, len(v)) for k, v in sorted(  ignored.iteritems())]) or '(none)',
       len( noheader ),
       len( warnings ),
       len( failures ),
       len( forbidden ),
       '\n\t'.join(os.path.abspath(os.path.join( base_pkg, x ))
                   for x in [SUCCESS_LOG, IGNORED_LOG, NOHDR_LOG, WARN_LOG, FAIL_LOG, FORBID_LOG]),
       )


prog_name = os.path.basename( sys.argv[0] )
if __name__ == '__main__':
    main( sys.argv )
