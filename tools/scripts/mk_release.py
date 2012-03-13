#!/usr/bin/env python-nf

################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  File:
#        mk_release.py
#
#  Author:
#        David J. Miller
#        Matthew P. Grosvenor
#
#  Description:
#        Make a release tarball from the nominated git treeish (branch, tag or
#        commit SHA1).  Only the files and paths nominated in STATIC_PATHLIST
#        and related pcores are included.
#
#        NB: Although the tarball is created directly from the repository (ie
#            uncommitted files and changes won't be included), the script still
#            needs to checkout the specified treeish so that it can parse the
#            projects to find what libraries are required.
#
#        NB: The script operates on the copy of -dev repo which contains the
#            instance of mk_release.py you execute, and ignores the current
#            working directory.
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

import chk_pcore_versions as chk_pcores
import mhstools
import os
import subprocess
import sys

# TAR_PREFIX: the base directory of files within the tarball.  (ie everything
#             will unpack into this directory.)
TAR_PREFIX   = 'netfpga'

# TARBALL_NAME: the filename of the tarball.  %s will be expanded to the
#               nominated treeish.
TARBALL_NAME = 'netfpga-10g-%s.tar.gz'

# STATIC_PATHLIST: paths to include in the tarball.  The simulation pcores have
#                  to be explicitly included because nothing normally
#                  references them.
STATIC_PATHLIST = ['LGPL-2.1',
                   'NOTICE',
                   'README',
                   'RELEASE_NOTES',
                   'Makefile',
                   'tools/bin',
                   'tools/scripts',
                   'tools/src',
                   'tools/README',
                   'projects/flash_configuration',
                   'projects/loopback_test',
                   'projects/loopback_test_1g',
                   'projects/reference_nic',
                   'projects/reference_nic_1g',
                   'projects/production_test/sw',
                   'projects/production_test/bitfiles',
                   'lib/sw',
                   'lib/hw/std/pcores/nf10_axi_sim_transactor_v1_00_a',
                   'lib/hw/std/pcores/nf10_axis_sim_pkg_v1_00_a',
                   'lib/hw/std/pcores/nf10_axis_sim_record_v1_00_a',
                   'lib/hw/std/pcores/nf10_axis_sim_stim_v1_00_a',
                   ]


def main(argv):
    # Get treeish
    if len(argv) != 2:
        print """\
usage: %s <treeish>

where <treeish> is a valid git branch or tag (eg release_1.1.0).""" % (prog_name)
        sys.exit(1)
    treeish = argv[1]

    # Determine root of repo (this repo) on which to operate
    try:
        # First try from cwd
        root, _ = chk_pcores.get_base_pkg( os.getcwd() )
    except ValueError:
        # None found, so use package this script is a part of
        root = os.path.abspath( os.path.join( os.path.dirname(__file__), '..', '..' ) )
    # Add base path to hw_lib_dir and projects_dir

    # Prepare tree
    print '+ cd %s' % root
    os.chdir( root )
    print
    cmd = 'git checkout %s' % treeish
    print '+ %s' % cmd
    if 0 != subprocess.call( cmd.split() ):
        sys.exit(1)
    print

    # Make path list
    pcores_avail  = chk_pcores.scan_pcores( os.path.join( 'lib', 'hw' ) )
    pcores_needed = set()
    for project, mhs in chk_pcores.scan_projects( 'projects' ):
        # Include pcores for each project whose hardware directory is included.
        # `project` is of the form <project>/hw, so take off the 'hw' and
        # prepend 'project' to match against STATIC_PATHLIST.
        if os.path.join( 'projects', os.path.dirname( project ) ) not in STATIC_PATHLIST:
            continue
        for inst in mhstools.instances(mhs):
            paths, errors = chk_pcores.resolve_pcore( pcores_avail, inst.core_name(),
                                                      mhstools.get_parameter( inst, 'HW_VER' ) )
            pcores_needed = pcores_needed.union( paths )
    pathlist = STATIC_PATHLIST + list( pcores_needed )

    # Create tarball
    tarball = os.path.join( '..', TARBALL_NAME % treeish.replace('/','_') )
    gzip = subprocess.Popen( ['gzip'], stdin=subprocess.PIPE, stdout=open( tarball, 'w' ) )
    try:
        cmd = 'git archive --prefix=%s/ %s' % (TAR_PREFIX, treeish)
        print '+ %s (paths) | gzip > %s' % (cmd, tarball)
        rc = subprocess.call( cmd.split() + pathlist, stdout=gzip.stdin )
    except OSError, e:
        if e.errno == os.errno.E2BIG:
            print """\
%s: list of paths (%d in %d bytes) to include in tarball is
%s: too large for this platform (max %d bytes)""" % (prog_name, len(pathlist), len(' '.join(pathlist)),
                                                     prog_name, os.sysconf('SC_ARG_MAX'))
            sys.exit(1)
        else:
            raise e
    print
    if rc == 0:
        print '%s: %s created.' % (prog_name, os.path.abspath( os.path.join( root, tarball ) ))
    else:
        print '%s: error creating archive.' % prog_name


prog_name = os.path.basename(sys.argv[0])
if __name__ == '__main__':
    main(sys.argv)
