#----------------------------------------------------------------------
# File: Makefile
# Date: Sun Apr 29 18:03:40 PDT 2007
# Author: Martin Casado
#
#----------------------------------------------------------------------

all: common rkd

HEADERS  = rtable.hh arptable.hh nf10_mon.hh iflist.hh
CXXFLAGS = -g -Wall -ansi

common:
	ln -s ../scone/nf10 common

rkd : rkd.cc linux_proc_net.o nf10_mon.o common/nf10util.o $(HEADERS)
	g++ -g -Wall -o rkd rkd.cc nf10_mon.o common/nf10util.o linux_proc_net.o

clean:
	rm -f *.o rkd common/*.o

install:
