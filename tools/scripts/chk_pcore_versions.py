#!/usr/bin/env python

###########################################################################
#
#  NETFPGA10G www.netfpga.org
#
#  Module:
#       chk_pcore_versions.py
#
#  Description:
#       Automatically check for duplicate, missing and use of out-of-date
#       pcores.  No command line arguments required.
#
#

from __future__ import with_statement

import mhstools
import os
import sys


# Define location of HW library and projects, relative to location of this script
hw_lib_dir   = os.path.join( os.path.dirname(sys.argv[0]), '..', '..', 'lib', 'hw' )
projects_dir = os.path.join( os.path.dirname(sys.argv[0]), '..', '..', 'projects' )


def scan_pcores( hw_library ):
    """
    Returns a dict (indexed by pcore name) of dicts (indexed by version) of
    lists of core locations, built from the pcores found under `hw_library`.
    """
    pcores = {}
    for root, dirs, files in os.walk( hw_library ):
        if os.path.basename(root) == 'pcores':
            # keep locations tidy: only path components below hw_library
            root = root[len(hw_library)+1:]
            for dir in dirs:
                # each directory is of the form 'my_cool_pcore_v1_23_c'
                ver_elts = dir.rsplit('_', 3)
                # exclude non-pcore directories, or at least, those that don't fit
                if len(ver_elts) != 4:
                    print '%s: bad pcore name %s' % (prog_name, dir)
                    continue
                pcore = ver_elts[0]
                # reassemble version, without leading 'v'
                ver   = '.'.join( ver_elts[1:] )[1:]
                pcores.setdefault( pcore, {} ).setdefault( ver, [] ).append( root )
            del dirs[:]
    return pcores


def print_duplicate_pcores( pcores ):
    """
    Print duplicate pcores (those (of a given version) found in more than one
    location).
    """
    print 'Duplicate pcore report:'
    for pcore in pcores:
        for ver, locs in pcores[pcore].iteritems():
            if len(locs) != 1:
                print '\t%-40s%-10s%s' % (pcore, ver, ', '.join( pcores[pcore][ver] ))
    print


def check_pcore_versions( mhs, pcores ):
    """
    Checks the instantiated version of each pcore used against the list of all
    known pcores, and reports any that are not up-to-date or missing
    """
    errors = []
    for ent in mhstools.instances(mhs):
        pcore = ent.core_name()
        ver   = mhstools.get_parameter( ent, 'HW_VER' )

        # check that any versions are present
        if pcore not in pcores:
            errors.append( '%-40sno versions found' % (pcore) )
            continue
        # check that the nominated version is present
        if ver not in pcores[pcore]:
            errors.append( '%-40s%s not found' % (pcore, ver) )
            continue
        # check that the nominated version is the latest.  The latest will be
        # the last of the sorted list of versions.
        # XXX: this simple text-sort probably won't work with major versions
        #      > 9.
        latest = sorted(pcores[pcore])[-1]
        if ver != latest:
            errors.append( '%-40s%s < %s' % (pcore, ver, latest) )
            continue
    return errors


def print_project_pcore_version_report( projects_dir, pcores ):
    """
    Finds project directories (those containing exactly one MHS file), parses
    the MHS file, and checks versions.
    """
    for root, dirs, files in os.walk( projects_dir ):
        project = root[len(projects_dir)+1:]
        mhs_files = filter( lambda x: x.endswith( '.mhs' ), files )
        if len( mhs_files ) == 0:
            continue
        if len( mhs_files ) > 1:
            print '%s: project %s contains more than one MHS file!  Aborting.' % (prog_name, project)
            sys.exit(1)

        with open( os.path.join( root, mhs_files[0] ) ) as mhs_fh:
            mhs = mhstools.parse_mhs( mhs_fh )
        errors = check_pcore_versions( mhs, pcores )
        if errors:
            print "Project '%s': pcore version error report:\n\t%s\n" % (project, '\n\t'.join(errors) )


def main():
    pcores = scan_pcores( hw_lib_dir )
    print_duplicate_pcores( pcores )
    print_project_pcore_version_report( projects_dir, pcores )


prog_name = os.path.basename(sys.argv[0])
if __name__ == '__main__':
    main()
