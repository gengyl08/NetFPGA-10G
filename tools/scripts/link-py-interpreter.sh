#!/usr/bin/env bash

################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  File:
#        link-py-interpreter.sh
#
#  Author:
#        David J. Miller
#
#  Description:
#        Locate and create a link to a suitable python interpreter.
#
#        Mostly, this is to accommodate older distributions like CentOS,
#        which do provide sufficiently recent installations of python - but
#        not with the standard name, 'python'.
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

target=$(dirname $0)/python-nf

# Do nothing if link already exists
if [ -x $target ]; then
    echo $target exists: leaving alone.
    exit 0
fi

# Find and link suitable interpreter
for py in python27 python2.7 python26 python2.6 python25 python2.5 python; do
    if py=$(which $py 2>/dev/null); then
        echo Found python interpreter: $py
        if ! $py -c "import sys; sys.exit( sys.version_info[:2] < (2,5) )"; then
            echo $py: too old
        else
            echo ln -s $py $target
            ln -s $py $target
            exit 0
        fi
    fi
done

echo
echo 'No python interpreter >= 2.5 found.'
exit 1
