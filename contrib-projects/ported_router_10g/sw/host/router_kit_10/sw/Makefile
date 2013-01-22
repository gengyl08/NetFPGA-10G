#----------------------------------------------------------------------
# File: Makefile
# Date: Tue Nov 06 14:48:22 PDT 2012
# Author: Gianni Antichi
#
#----------------------------------------------------------------------

all: rkd

HEADERS  = rtable.hh arptable.hh nf10_mon.hh iflist.hh def_router.h
CXXFLAGS = -g -Wall -ansi -lnl -lnl-genl -lnf10reg

rkd : rkd.cc linux_proc_net.o nf10_mon.o $(HEADERS)
	g++ -g -Wall -lnl -lnl-genl -lnf10reg -o rkd rkd.cc nf10_mon.o linux_proc_net.o

clean:
	rm -f *.o rkd 

install:
