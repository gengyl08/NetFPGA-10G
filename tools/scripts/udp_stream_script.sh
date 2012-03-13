#!/bin/sh

################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  File:
#        udp_stream_script.sh
#
#  Author:
#        Muhammad Shahbaz
#
#  Description:
#        UDP performance test script.
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

if [ $# -gt 4 ]; then
  echo "try again, correctly -> udp_stream_script hostname [CPU] [-Tx,x] [I]"
  exit 1
fi

if [ $# -eq 0 ]; then
  echo "try again, correctly -> udp_stream_script hostname [CPU]"
  exit 1
fi

# where the programs are

NETHOME=/usr/local/bin
#NETHOME="/opt/netperf"
#NETHOME="."

# at what port will netserver be waiting? If you decide to run
# netserver at a differnet port than the default of 12865, then set
# the value of PORT apropriately
#PORT="-p some_other_portnum"
PORT=""

# The test length in seconds
TEST_TIME=10

# How accurate we want the estimate of performance: 
#      maximum and minimum test iterations (-i)
#      confidence level (99 or 95) and interval (percent)

STATS_STUFF="-i 10,2 -I 99,10"

# The socket sizes that we will be testing. This should be a list of
# integers separated by spaces

SOCKET_SIZES="32768 4M"

# The send sizes that we will be using. Using send sizes that result
# in UDP packets which are larger than link size can be a bad thing to do.
# for FDDI, you can tack-on a 4096 data point

SEND_SIZES="64 1024 1472"

# if there are two parms, parm one it the hostname and parm two will
# be a CPU indicator. actually, anything as a second parm will cause
# the CPU to be measured, but we will "advertise" it should be "CPU"

if [ $# -eq 4 ]; then
  REM_HOST=$1
  LOC_CPU=""
  REM_CPU=""
  AFFINITY=""
  STREAM="UDP_STREAM"

case $2 in
\CPU) LOC_CPU="-c";REM_CPU="-C";;
\I) STREAM="UDP_MAERTS";;
*) AFFINITY=$2
esac

case $3 in
\CPU) LOC_CPU="-c";REM_CPU="-C";;
\I) STREAM="UDP_MAERTS";;
*) AFFINITY=$3
esac

case $4 in
\CPU) LOC_CPU="-c";REM_CPU="-C";;
\I) STREAM="UDP_MAERTS";;
*) AFFINITY=$4
esac
fi

if [ $# -eq 3 ]; then
  REM_HOST=$1
  LOC_CPU=""
  REM_CPU=""
  AFFINITY=""
  STREAM="UDP_STREAM"

case $2 in
\CPU) LOC_CPU="-c";REM_CPU="-C";;
\I) STREAM="UDP_MAERTS";;
*) AFFINITY=$2
esac

case $3 in
\CPU) LOC_CPU="-c";REM_CPU="-C";;
\I) STREAM="UDP_MAERTS";;
*) AFFINITY=$3
esac
fi

if [ $# -eq 2 ]; then
  REM_HOST=$1
  LOC_CPU=""
  REM_CPU=""
  AFFINITY=""
  STREAM="UDP_STREAM"

case $2 in
\CPU) LOC_CPU="-c";REM_CPU="-C";;
\I) STREAM="UDP_MAERTS";;
*) AFFINITY=$2
esac
fi

if [ $# -eq 1 ]; then
  REM_HOST=$1
  LOC_CPU=""
  REM_CPU=""
  AFFINITY=""
  STREAM="UDP_STREAM"
fi

# If we are measuring CPU utilization, then we can save beaucoup
# time by saving the results of the CPU calibration and passing
# them in during the real tests. So, we execute the new CPU "tests"
# of netperf and put the values into shell vars.
case $LOC_CPU in
\-c) LOC_RATE=`$NETHOME/netperf $PORT -t LOC_CPU`;;
*) LOC_RATE=""
esac

case $REM_CPU in
\-C) REM_RATE=`$NETHOME/netperf $PORT -t REM_CPU -H $REM_HOST`;;
*) REM_RATE=""
esac

# This will tell netperf that headers are not to be displayed
NO_HDR="-P 0"

for SOCKET_SIZE in $SOCKET_SIZES
do
  for SEND_SIZE in $SEND_SIZES
  do
    echo
    echo ------------------------------------------------------
    echo Testing with the following command line:
    echo $NETHOME/netperf $PORT -l $TEST_TIME -H $REM_HOST $STATS_STUFF \
           $LOC_CPU $LOC_RATE $REM_CPU $REM_RATE -t $STREAM -- \
           -m $SEND_SIZE -s $SOCKET_SIZE -S $SOCKET_SIZE $AFFINITY

    $NETHOME/netperf $PORT -l $TEST_TIME -H $REM_HOST $STATS_STUFF \
      $LOC_CPU $LOC_RATE $REM_CPU $REM_RATE -t $STREAM -- \
      -m $SEND_SIZE -s $SOCKET_SIZE -S $SOCKET_SIZE $AFFINITY

  done
done
echo
