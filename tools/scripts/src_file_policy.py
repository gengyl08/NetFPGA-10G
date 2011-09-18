#!/usr/bin/env python-nf

###########################################################################
#
#  NETFPGA10G www.netfpga.org
#
#  Module:
#       src_file_policy.py
#
#  Author:
#       David J. Miller
#
#  Description:
#       Check and enforce source file policy.  Current policies include:
#             - Interpreter hack:
#                       + present or not (per type policy)
#                       + If present, uses /usr/bin/env
#                       + Name: python-nf for python, bash for sh
#             - NetFPGA header present and contains:
#                       + NetFPGA project name banner
#                       + Module name
#                       + Author
#                       + Description
#                       + Copyright and licence statements
#             - Header does NOT include change history
#             - EOL is Unix style (ie, not \r\n)
#
#

from __future__ import with_statement

import optparse
import os
import re
import sys
import string
import time

# Log names
SUCCESS_LOG = os.path.expanduser( '~/pol_success.log' )
IGNORED_LOG = os.path.expanduser( '~/pol_ignored.log' )
NOHDR_LOG   = os.path.expanduser( '~/pol_no_header.log' )
WARN_LOG    = os.path.expanduser( '~/pol_warning.log' )
FAIL_LOG    = os.path.expanduser( '~/pol_failure.log' )
FORBID_LOG  = os.path.expanduser( '~/pol_forbidden.log' )

# TYPE_INFO: a tuple of (comment_str, interp_required, interpreter).
#       comment_str: tuple of (single, begin, middle, end)
#                    eg, for C: ('//', '/*', ' *', '*/')
#       interp_required: None = forbidden, False = optional, True = mandatory
#       interpreter: if present, should be this value
COM_STYLES = { 'C'   : ('//', '/*', ' *', '*/'),
               'sh'  : ('#', None, None, None),
               'vhdl': ('--', None, None, None),
               }
TYPE_INFO = { '.axi'    : (COM_STYLES['sh'],   None, ''),
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
              '.ucf'    : (COM_STYLES['sh'],   None, ''),
              '.xcf'    : (COM_STYLES['sh'],   None, ''),
              '.xco'    : (COM_STYLES['sh'],   None, ''),
              'README'  : (COM_STYLES['sh'],   None, ''),
              'Makefile': (COM_STYLES['sh'],   None, ''),
              }
# Extensions to ignore
IGNORE    = [ '.bbd', '.bit', '.bmp', '.cdc', '.cdf', '.cip', '.cproject',
              '.diff', '.do', '.dtd', '.docx', '.edn', '.gise', '.gitignore',
              '.jed', '.jpg', '.mhs', '.mui', '.ngc', '.pdf', '.png', '.prod_test_cfg',
              '.script', '.xml', '.xmp',
              'LICENSE', 'python-nf' ]

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
              ]

AC        = 'Adam Covington'
DM        = 'David J. Miller'
JE        = 'Jonathan Ellithorpe'
JH        = 'James Hongyi Zeng'
MB        = 'Michaela Blott'
SF        = 'Stephanie Friederich'
SS        = 'Shep Siegel'

AUTHORS   = [ ('lib/hw/netwave/pcores/nf10_axis_netwave_core',            MB),
              ('lib/hw/netwave/pcores/nf10_axis_netwave_gen_check',       MB),
              ('lib/hw/netwave/pcores/nf10_axis_netwave_l2switch',        MB),
              ('lib/hw/std/pcores/nf10_10g_interface',                    JH),
              ('lib/hw/std/pcores/nf10_1g_interface',                     JH),
              ('lib/hw/std/pcores/nf10_axis_converter',                   JH),
              ('lib/hw/std/pcores/nf10_axis_gen_check',                   MB),
              ('lib/hw/std/pcores/nf10_axis_sim_pkg',                     DM),
              ('lib/hw/std/pcores/nf10_axis_sim_record',                  DM),
              ('lib/hw/std/pcores/nf10_axis_sim_stim',                    DM),
              ('lib/hw/std/pcores/nf10_axi_flash_ctrl',                   SF),
              ('lib/hw/std/pcores/nf10_axi_sim_transactor',               DM),
              ('lib/hw/std/pcores/nf10_bram_output_queues',               JH),
              ('lib/hw/std/pcores/nf10_input_arbiter',                    JH),
              ('lib/hw/std/pcores/nf10_nic_output_port_lookup',           JH),
              ('lib/hw/std/pcores/nf10_oped',                             SS),
              ('lib/hw/std/pcores/nf10_sram',                             JH),
              ('configuration_test',                                      SF),
              ('configuration_test_no_cdc',                               SF),
              ('loopback_test',                                           JH),
              ('loopback_test_1g',                                        JH),
              ('memory_test',                                             JH),
              ('netwave',                                                 MB),
              ('oped_test',                                               SS),
              ('production_test',                                         MB),
              ('reference_nic',                                           JH),
              ('reference_nic_1g',                                        JH),
              ('stresstest',                                              MB),
              ]


hdr_indent1 = 2
hdr_indent2 = 8
hdr_prolog = """\

NetFPGA-10G http://www.netfpga.org

""".splitlines()
hdr_epilog = """\

Copyright (C) 2010,2011 The Board of Trustees of The Leland Stanford
                        Junior University

This file is part of the NetFPGA 10G development package.

This package is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This package is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with the NetFPGA source package.  If not, see
http://www.gnu.org/licenses/.

""".splitlines()

all_styles = re.compile( '^[%s]+' % ''.join([cs[0] for (cs, _, _, _) in COM_STYLES.values()]) )
def replace_header( tree, really, successes, ignored, noheader, failures, warnings, forbidden, filename ):
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

    # Get file type and associated information.  Handle ignored and forbidden
    # (ie, unknown) file types.
    rel_filename = filename[len(tree)+1:]
    extn = os.path.splitext( filename )[1]
    if not extn:
        # No extension, so use whole filename
        extn = os.path.basename( filename )
    if extn in IGNORE:
        ignored.setdefault( extn, [] ).append( rel_filename )
        return 0
    if extn not in TYPE_INFO:
        forbidden.append( rel_filename )
        return 0
    ((cmt_single, cmt_start, cmt_mid, cmt_end), interp_required, interpreter) = TYPE_INFO[extn]
    cmt_mid_strip = cmt_mid and cmt_mid.strip() # might have leading spaces

    # Analyse file
    header = {}
    fail_flags = []
    warn_flags = []
    text = []
    section = ''
    nf10g_banner_seen = False
    tab_in_hdr_seen   = False
    with open( filename ) as f:
        # Get interpreter (which must be 1st line of file), if any, and check
        # against policy requirements
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

        # Parse existing header, if any
        for line in f:
            cmt_line = get_hdr_line( line )
            if cmt_line is None: # then end of header
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

        #
        # Clean up collected data
        #

        # No NetFPGA banner means either the header was mangled, or missing
        # altogether, in which case 'author' will also be missing.  Either way
        # it should be left alone.
        if not nf10g_banner_seen:
            noheader.append( filename )
            return 0
        # `section` is still set to the last section seen.  The epilog, if any,
        # will be appended there.
        epi_found = False
        epi_start = 0
        i         = 0
        j         = 0
        while i < len(header[section]):
            if header[section][i].endswith( hdr_epilog[j] ):
                if not epi_found:
                    epi_start = i
                    epi_found = True
                j += 1
                if j == len(hdr_epilog):
                    # Whole of epilog found
                    i += 2 # allow for extra trailing empty lines
                    del header[section][epi_start:i]
                    break
                i += 1
            else:
                if epi_found:
                    j = 0
                    epi_found = False
                else:
                    i += 1
        # Try to guess the author based on AUTHORS table, if not already present
        if 'author' not in header:
            for f, a in AUTHORS:
                if rel_filename.startswith( f ):
                    header['author'] = a
                    break
        # The presence of tabs in the header indicate that left justification
        # of the comment might be screwed up.
        if tab_in_hdr_seen:
            warn_flags.append( 'tab_in_hdr' )
        # Set filename appropriately
        header['file'] = [os.path.basename( filename )]
        # Set section project or library, based on file path
        rel_elts = rel_filename.split( os.path.sep )
        if rel_elts[0] == 'projects':
            header['project'] = [rel_elts[1]]
        if rel_elts[0] == 'lib':
            header['library'] = [os.path.join( *rel_elts[1:5] )]
        # Delete module section if it's the same as the filename
        if 'module' in header and header['module'][0].find( header['file'][0] ) != -1:
            del header['module']
        # Delete any leading or trailing whitespace around all sections
        # (other than description, which needs its leading whitespace)
        for section in ['library', 'project', 'module', 'author']:
            if section in header:
                header[section] = [x.strip() for x in header[section]]

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
        else:
             if len(header['author']) != 1:
                 warn_flags.append( 'multi_author' )
        # Description may be multiline, but needs leading whitespace to be
        # cleaned up.  Absence is a failure, because we can't guess this.
        if 'description' not in header:
            fail_flags.append( 'no_desc' )
        else:
            # Find left-most line in description, and remove that much leading
            # space from all lines.
            common_margin = 1000
            for line in header['description']:
                if not line:
                    continue
                margin = len(line)-len(line.lstrip())
                if margin < common_margin:
                    common_margin = margin
            header['description'] = [x[common_margin:] for x in header['description']]

        #
        # Insert standardised header
        #

        # Gather comment characters
        cmt_start = cmt_start or cmt_single
        cmt_mid   = cmt_mid   or cmt_single
        cmt_end   = cmt_end   or cmt_single
        cmt_hbar  = cmt_mid.strip()*(80-len(cmt_mid.strip())-len(cmt_mid))
        # Add prolog
        text.append( '%s%s' % (cmt_start, cmt_hbar) )
        for line in hdr_prolog:
            text.append( ('%s%s%s' % (cmt_mid, ' '*hdr_indent1, line)).rstrip() )
        # Add section data
        for section in ['file', 'library', 'project', 'module', 'author', 'description']:
            if section in header:
                while header[section] and not header[section][0]:
                    del header[section][0]
                while header[section] and not header[section][-1]:
                    del header[section][-1]
                text.append( '%s%s%s:' % (cmt_mid, ' '*hdr_indent1, section.capitalize() ) )
                for sect_info in header[section]:
                    text.append( ('%s%s%s' % (cmt_mid, ' '*hdr_indent2, sect_info )).rstrip() )
                text.append( cmt_mid )
        # Add epilog
        text.append( '%s%s' % (cmt_mid, cmt_hbar) )
        for line in hdr_epilog:
            text.append( ('%s%s%s' % (cmt_mid, ' '*hdr_indent1, line)).rstrip() )
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
    if really:
        with open( filename, 'w' ) as f:
            f.writelines( '%s\n' % line for line in text )
    return 1


def replace_all_in_tree( tree, really, successes, ignored, noheader, failures, warnings, forbidden ):
    """
    Walk entire tree, replacing headers in all files found (but only if)
    really sure.
    """
    count = 0
    for root, dirs, files in os.walk(tree):
        # Don't recurse into the .git directory
        try:
            del dirs[dirs.index( '.git' )]
        except ValueError:
            pass

        for file in files:
            count += replace_header( tree, really, successes, ignored, noheader, failures, warnings, forbidden,
                            os.path.join( root, file ) )
    return count


def main( argv ):
    """
    Parse and replace all source headers.
    """

    #
    # Parse options
    #

    # Configure parser
    parser = optparse.OptionParser(
        usage  = '%prog [-h|--help] [--really] [file [...]]',
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


    # Parse & check options
    opts, file_args = parser.parse_args()

    successes = {}
    ignored   = {}
    noheader  = []
    failures  = []
    warnings  = []
    forbidden = []
    if file_args:
        count = 0
        cwd_elts = os.getcwd().split( os.path.sep )
        cwd_elts[0] = os.path.sep
        try:
            nfroot_idx = cwd_elts.index( 'netfpga-10g-dev' )
        except ValueError:
            print '%s: error: working tree %s doesn\'t appear to be a netfpga-10g-dev tree.' % (prog_name, os.getcwd())
            sys.exit(1)
        tree = os.path.join( *cwd_elts[:nfroot_idx+1] )
        subdir = cwd_elts[nfroot_idx+1:]
        if subdir:
            subdir = os.path.join( *subdir )
        else:
            subdir = ''
        for file in file_args:
            if os.path.isdir( file ):
                print '%s: %s: is directory' % (prog_name, file)
                print '%s: recursion into explicit targets not supported' % prog_name
                continue
            count += replace_header( tree, opts.really, successes, ignored, noheader, failures, warnings, forbidden,
                            os.path.join( tree, subdir, file ) )
    else:
        tree  = os.path.dirname( os.path.dirname( os.path.dirname( os.path.abspath( argv[0] ) ) ) )
        count = replace_all_in_tree( tree, opts.really, successes, ignored, noheader, failures, warnings, forbidden )

    # Write logs
    log_header = """\
# %s: detailed report: %s
# tree: %s
# date: %s
"""
    time_now = time.asctime()
    with open( SUCCESS_LOG, 'w' ) as log:
        log.write( log_header % (prog_name, 'files successfully processed, without warnings',
                                 tree, time_now ) )
        log.writelines( ['%s\n' % f for f in sorted( sum(successes.itervalues(), []) )] or '# (none)\n' )
    with open( IGNORED_LOG, 'w' ) as log:
        log.write( log_header % (prog_name,
                                 'files ignored by policy', tree, time_now ) )
        log.writelines( ['%s, %s\n' % (e, f) for e, f in sorted((e,f) for e,l in ignored.iteritems() for f in l )] or '# (none)\n' )
    with open( NOHDR_LOG, 'w' ) as log:
        log.write( log_header % (prog_name, 'files missing NetFPGA header',
                                 tree, time_now ) )
        log.writelines( ['%s\n' % f for f in sorted( noheader )] or '# (none)\n' )
    with open( WARN_LOG, 'w' ) as log:
        log.write( log_header % (prog_name, 'files successfully processed, but with warnings',
                                 tree, time_now ) )
        log.writelines( ['%s; %s\n' % (', '.join(w), f) for f, w in sorted( warnings )] or '# (none)\n' )
    with open( FAIL_LOG, 'w' ) as log:
        log.write( log_header % (prog_name, 'files with policy failures',
                                 tree, time_now ) )
        log.writelines( ['%s; %s\n' % (', '.join(w), f) for f, w in sorted( failures )] or '# (none)\n' )
    with open( FORBID_LOG, 'w' ) as log:
        log.write( log_header % (prog_name, 'files forbidden (or/and unknown)',
                                 tree, time_now ) )
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
       tree,
       '\n\t'.join(['%-20s%4s' % (k, len(v)) for k, v in sorted( successes.iteritems())]) or '(none)',
       '\n\t'.join(['%-20s%4s' % (k, len(v)) for k, v in sorted(   ignored.iteritems())]) or '(none)',
       len( noheader ),
       len( warnings ),
       len( failures ),
       len( forbidden ),
       '\n\t'.join([SUCCESS_LOG, IGNORED_LOG, NOHDR_LOG, WARN_LOG, FAIL_LOG, FORBID_LOG]),
       )


prog_name = os.path.basename( sys.argv[0] )
if __name__ == '__main__':
    main( sys.argv )
