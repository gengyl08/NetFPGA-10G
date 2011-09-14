#!/usr/bin/env bash

###########################################################################
#
#  NETFPGA10G www.netfpga.org
#
#  Module:
#       link-py-interpreter.sh
#
#  Author:
#       David J. Miller
#
#  Description:
#       Locate and create a link to a suitable python interpreter.
#
#       Mostly, this is to accommodate older distributions like CentOS,
#       which do provide sufficiently recent installations of python - but
#       not with the standard name, 'python'.
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
