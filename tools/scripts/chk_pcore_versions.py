#!/usr/bin/env python-nf

################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  File:
#        chk_pcore_versions.py
#
#  Author:
#        David J. Miller
#
#  Description:
#        Automatically check for duplicate, missing and use of out-of-date
#        pcores.  No command line arguments required.
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

import mhstools
import os
import sys


# Define location of HW library and projects, relative to the path of the base
# package
hw_lib_dir   = os.path.join( 'lib', 'hw' )
projects_dir = os.path.join( 'projects' )

PCORE_MANIFEST = '~/pcore_manifest.log'

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


def split_pcore_name( pcore_dirname ):
    """
    Split pcore directory name (eg 'my_cool_pcore_v1_23_c') into (pcore_name,
    version_number) (ie, the leading 'v' is stripped).
    """
    # each directory is of the form my_cool_pcore_v1_23_c
    ver_elts = pcore_dirname.rsplit('_', 3)
    # Catch invalid pcore directory names
    if len(ver_elts) != 4:
        raise RuntimeError( '%s: bad pcore name %s' % (prog_name, pcore_dirname) )
    pcore_name = ver_elts[0]
    ver        = '.'.join(ver_elts[1:])
    ver        = ver[1:] # strip leading 'v'
    return (pcore_name, ver)


def get_pcore_deps( pcore_path ):
    """
    Scan the given pcore for any dependencies outside of that pcore.
    """
    pcore_dirname = os.path.basename( pcore_path )
    pao_filename  = '%s_v2_1_0.pao' % split_pcore_name( pcore_dirname )[0]
    pao_filepath  = os.path.join( pcore_path, 'data', pao_filename )
    if not os.path.isfile( pao_filepath ):
        return []
    deps = set()
    with open( pao_filepath ) as f:
        for line in f:
            line = line.strip()
            try:
                line = line[:line.index('#')].strip()
            except ValueError:
                pass
            if line:
                elts = line.split()
                if elts[1] != pcore_dirname:
                    deps.add( split_pcore_name( elts[1] ) )
    return deps


def scan_pcores( hw_library ):
    """
    Scans all pcores and returns dicts all_pcores[pcore_name][pcore_version] =
    [(core_location, [pcore_dependencies])], where core_locations are the
    directories holding pcores (eg std/pcores), and pcore_dependencies are
    (pcore_name, pcore_version), built from the pcores found under
    `hw_library`.
    """
    pcores = {}
    for root, dirs, files in os.walk( hw_library ):
        if os.path.basename(root) == 'pcores':
            # keep locations tidy: only path components below hw_library
            rel_root = root[len(hw_library)+1:]
            for dir in dirs:
                pcore, ver = split_pcore_name( dir )
                deps       = get_pcore_deps( os.path.join( root, dir ) )
                pcores.setdefault( pcore, {} ).setdefault( ver, [] ).append( (rel_root, deps) )
            del dirs[:]
    return pcores


def scan_projects( projects_dir ):
    """
    Generator function that walks projects directory and, for each project,
    yields a tuple: (project_path, mhs)
    """
    for root, dirs, files in os.walk( projects_dir ):
        project = root[len(projects_dir)+1:]
        # Get MHS file name, if any.  There must be either exactly zero or one
        # MHS file per project directory.
        mhs_files = filter( lambda x: x.endswith( '.mhs' ), files )
        if len( mhs_files ) == 0:
            continue
        if len( mhs_files ) > 1:
            raise RuntimeError( (project, 'ambiguous (more than one) MHS files' ) )
        # Parse and return MHS entities
        with open( os.path.join( root, mhs_files[0] ) ) as mhs_fh:
            mhs = mhstools.parse_mhs( mhs_fh )
        yield (project, mhs)


def resolve_pcore( all_pcores, pcore, ver ):
    """
    Resolves the nominated pcore and version against the list of all known
    pcores, returning the resolved path of it and any dependent pcores, along
    with a list of any missing, ambiguous or out-of-date pcores found during
    resolution.
    """
    all_paths  = []
    all_errors = []
    # check whether any versions are present
    if pcore not in all_pcores:
        all_errors.append( '%-40sno versions found' % (pcore) )
        return ( all_paths, all_errors )
    # check that the nominated version is present
    if ver not in all_pcores[pcore]:
        all_errors.append( '%-40s%s not found' % (pcore, ver) )
        return ( all_paths, all_errors )
    # get location(s) and dependencies of this pcore/version
    loc_deps = all_pcores[pcore][ver]
    if len(loc_deps) != 1:
        # more than one location of this pcore and version: try to disambiguate
        all_errors.append( '%-40s%-10sambiguous locations: %s' % (pcore, ver,
                                                                  ', '.join(x[0] for x in loc_deps)) )
        # try to find the one in 'std', as that's probably the right one to use
        loc_deps_in_std = filter( lambda x: x[0].find('std') != -1, loc_deps )
        if len(loc_deps_in_std) == 1:
            loc_deps = loc_deps_in_std[0]
        if len(loc_deps_in_std) == 0:
            all_errors.append( '%-40s%-10sno candidate in "std"' % (pcore, ver) )
        if len(loc_deps_in_std) >  1:
            all_errors.append( '%-40s%-10smore than one "std"??' % (pcore, ver) )
    # we've narrowed it down to one possibility, or otherwise can't work out
    # which is the right one.  In either case, we can only use the first entry
    # in the list.
    loc, deps = loc_deps[0]
    # Resolve any dependencies of this pcore
    for dep in deps:
        paths, errors = resolve_pcore( all_pcores, *dep )
        all_paths  += paths
        all_errors += errors
    # check that the nominated version is the latest.  The latest will be
    # the last of the sorted list of versions.
    # XXX: this simple text-sort probably won't work with major versions
    #      > 9.
    latest = sorted(all_pcores[pcore])[-1]
    if ver != latest:
        all_errors.append( '%-40s%s < %s' % (pcore, ver, latest) )
    # Return the paths and errors for this and dependent pcores
    all_paths.append( os.path.join( 'lib', 'hw', loc, '%s_v%s' % (pcore, ver.replace( '.', '_' )) ) )
    return (all_paths, all_errors)


def print_duplicate_pcores( pcores ):
    """
    Print duplicate pcores (those (of a given version) found in more than one
    location).
    """
    print '1.  Duplicate pcore report:'
    dupes = 0
    for pcore in pcores:
        for ver, loc_deps in pcores[pcore].iteritems():
            if len(loc_deps) != 1:
                print '\t%-40s%-10s%s' % (pcore, ver, ', '.join( x[0] for x in loc_deps ))
                dupes += 1
    if dupes:
        print '\tTotal dupes: %d' % dupes
    else:
        print '\t(no dupes found)'
    print


def print_project_pcore_version_report( projects_dir, pcores ):
    """
    Scan all projects, resolve pcore instances, and print reports: missing pcores, out-of-date pcores;
    Also writes out list of pcores used.
    """
    # Collect data
    errors = {}
    cores_used = {}
    for project, mhs in scan_projects( projects_dir ):
        for inst in mhstools.instances(mhs):
            inst.paths, inst.errors = resolve_pcore( pcores, inst.core_name(),
                                                     mhstools.get_parameter( inst, 'HW_VER' ) )
        cores_used[project] = set( sum( (inst.paths  for inst in mhstools.instances(mhs)), [] ) )
        errors[project]     =      sum( (inst.errors for inst in mhstools.instances(mhs)), [] )
    # Print reports
    print '2.  Project missing and out-of-date pcore report:'
    for project, errors in errors.iteritems():
        if errors:
                print "\tProject '%s':\n\t\t%s\n" % (project, '\n\t\t'.join(errors) )
    print '3.  Project pcore use report: written to %s' % PCORE_MANIFEST
    with open( os.path.expanduser( PCORE_MANIFEST ), 'w' ) as f:
        print >>f, '\n'.join( '%s,%s' % (project, pcore) for project in cores_used for pcore in cores_used[project] )


def main():
    # Determine base package
    try:
        # First try from cwd
        base_pkg, _ = get_base_pkg( os.getcwd() )
    except ValueError:
        # None found, so use package this script is a part of
        base_pkg = os.path.dirname( os.path.dirname( os.path.dirname( __file__ ) ) )
    # Add base path to hw_lib_dir and projects_dir
    pcores = scan_pcores( os.path.join( base_pkg, hw_lib_dir ) )
    print_duplicate_pcores( pcores )
    print_project_pcore_version_report( os.path.join( base_pkg, projects_dir ), pcores )


prog_name = os.path.basename(sys.argv[0])
if __name__ == '__main__':
    main()
