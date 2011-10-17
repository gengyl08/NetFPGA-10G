/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        reg_report.cxx
 *
 *  Project:
 *        production_test
 *
 *  Author:
 *        Michaela Blott
 *
 *  Description:
 *        This program is a modified work from code originally written
 *        by Jim Kulp and Shepard Siegel at Atomic Rules. The program
 *        now reads various registers via the OpenCPI based DMA engine
 *        in the production test design for NetFPGA-10G.
 *
 *  Copyright notice:
 *        Copyright (C) 2010, 2011 Xilinx, Inc.
 *
 *  Licence:
 *        This file is part of the NetFPGA 10G development base package.
 *
 *        This file is free code: you can redistribute it and/or modify it under
 *        the terms of the GNU Lesser General Public License version 2.1 as
 *        published by the Free Software Foundation.
 *
 *        This package is distributed in the hope that it will be useful, but
 *        WITHOUT ANY WARRANTY; without even the implied warranty of
 *        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *        Lesser General Public License for more details.
 *
 *        You should have received a copy of the GNU Lesser General Public
 *        License along with the NetFPGA source package.  If not, see
 *        http://www.gnu.org/licenses/.
 *
 */

#include <fcntl.h>
#include <assert.h>
#include <stdio.h>
#include <sys/mman.h>
#include <errno.h>
#include <stdlib.h>
#include "OCCP.h"
#include "OCDP.h"

#define WORKER_STAT (1)

/* Control operations on workers. */
static void
  reset(volatile CPI::RPL::OccpWorkerRegisters *, unsigned);

uint32_t stat_reg_num = 27;
char *stat_reg_names[] = { "HW Version",
			   "CLOCK ok",
			   "QDRII ok",
			   "PWR ok",
			   "CPLD/Flash ok",
			   "HIDDEN", /* "RLDRAMII ok" */
			   "10G if 0 link",
			   "HIDDEN", /* "10G if 0 tx count" */
			   "HIDDEN", /* "10G if 0 rx count" */
			   "10G if 0 er count",
			   "10G if 1 link",
			   "HIDDEN", /* "10G if 1 tx count" */
			   "HIDDEN", /* "10G if 1 rx count" */
			   "10G if 1 er count",
			   "10G if 2 link",
			   "HIDDEN", /* "10G if 2 tx count" */
			   "HIDDEN", /* "10G if 2 rx count" */
			   "10G if 2 er count",
			   "10G if 3 link",
			   "HIDDEN", /* "10G if 3 tx count" */
			   "HIDDEN", /* "10G if 3 rx count" */
			   "10G if 3 er count",
			   "HIDDEN", /* "Samtec 0 error count" */
			   "Samtec 0 link",
			   "HIDDEN", /* "Samtec 1 error count" */
			   "Samtec 1 link",
			   "HIDDEN", /* "LEDs" */
 };

int main(int argc, char *argv[])
{
  errno = 0;
  unsigned long long
    bar0Base = strtoull(argv[1], NULL, 0);    /* Bar0 base address for PCIe endpoint */

  assert(errno == 0);
  int fd = open("/dev/mem", O_RDWR|O_SYNC);
  assert(fd >= 0);

  /* Memory map the whole config and control space for workers and dataplanes. */
  CPI::RPL::OccpSpace *occp =
    (CPI::RPL::OccpSpace *)mmap(NULL, sizeof(CPI::RPL::OccpSpace),
				PROT_READ|PROT_WRITE, MAP_SHARED, fd, bar0Base);
  assert(occp != (CPI::RPL::OccpSpace*)-1);

  volatile uint32_t
    *statProps = (uint32_t*)occp->config[WORKER_STAT];

  /* Setup pointers to specifically control spaces for workers and dataplanes. */
  volatile CPI::RPL::OccpWorkerRegisters
    *stat = &occp->worker[WORKER_STAT].control;

  /* Reset workers and dataplanes. */
  reset(stat,  0);

  uint32_t i;

  printf("%-9s%-25s%-11s\n", "Address", "Name", "Value");
  for( i = 0; i < stat_reg_num; i++ ) {
    if( stat_reg_names[i] != "HIDDEN" ) {
      printf("0x%05x: %-25s0x%08x\t", i*4, stat_reg_names[i], statProps[i]);

      /* Decode the register values. */
      if( stat_reg_names[i] == "HW Version") {
        if( (statProps[i] & 0xFF) >= 4 )
          printf("PASS: Detected Supported Board Revision");
        else {
          printf("FAIL\n");
	  printf("===================================\n");
	  printf("Detected Unsupported Board Revision\n");
	  printf("===================================");
	}
      } else if ( stat_reg_names[i] == "CLOCK ok" ) {
        if( statProps[i] == 0x7 )
          printf("PASS");
        else
          printf("FAIL");
      } else if ( stat_reg_names[i] == "QDRII ok" ) {
	if( statProps[i] == 0x15 )
	  printf("PASS");
	else
	  printf("FAIL");
      } else if ( stat_reg_names[i] == "PWR ok" ) {
	if( statProps[i] == 0x1 )
	  printf("PASS");
	else
	  printf("FAIL");
      } else if ( stat_reg_names[i] == "CPLD/Flash ok" ) {
	if( statProps[i] == 0x7 )
	  printf("PASS");
	else
	  printf("FAIL");
      } else if ( stat_reg_names[i] == "RLDRAMII ok" ) {
	if( statProps[i] == 0x35A )
	  printf("PASS");
	else
	  printf("FAIL");
      } else if ( stat_reg_names[i] == "10G if 0 link" ) {
	if( statProps[i] == 0x1 )
	  printf("PASS");
	else
	  printf("FAIL");
      } else if ( stat_reg_names[i] == "10G if 0 er count" ) {
	if( statProps[i] == 0x0 )
	  printf("PASS");
	else
	  printf("FAIL");
      } else if ( stat_reg_names[i] == "10G if 1 link" ) {
	if( statProps[i] == 0x1 )
	  printf("PASS");
	else
	  printf("FAIL");
      } else if ( stat_reg_names[i] == "10G if 1 er count" ) {
	if( statProps[i] == 0x0 )
	  printf("PASS");
	else
	  printf("FAIL");
      } else if ( stat_reg_names[i] == "10G if 2 link" ) {
	if( statProps[i] == 0x1 )
	  printf("PASS");
	else
	  printf("FAIL");
      } else if ( stat_reg_names[i] == "10G if 2 er count" ) {
	if( statProps[i] == 0x0 )
	  printf("PASS");
	else
	  printf("FAIL");
      } else if ( stat_reg_names[i] == "10G if 3 link" ) {
	if( statProps[i] == 0x1 )
	  printf("PASS");
	else
	  printf("FAIL");
      } else if ( stat_reg_names[i] == "10G if 3 er count" ) {
	if( statProps[i] == 0x0 )
	  printf("PASS");
	else
	  printf("FAIL");
      } else if ( stat_reg_names[i] == "Samtec 0 error count" ) {
	if( statProps[i] == 0x0 )
	  printf("PASS");
	else
	  printf("FAIL");
      } else if ( stat_reg_names[i] == "Samtec 0 link" ) {
	if( statProps[i] == 0x1 )
	  printf("PASS");
	else
	  printf("FAIL");
      } else if ( stat_reg_names[i] == "Samtec 1 error count" ) {
	if( statProps[i] == 0x0 )
	  printf("PASS");
	else
	  printf("FAIL");
      } else if ( stat_reg_names[i] == "Samtec 1 link" ) {
	if( statProps[i] == 0x1 )
	  printf("PASS");
	else
	  printf("FAIL");
      }

      printf("\n");
    }
  }

  return 0;
}

/* Reset a worker. */
static void
reset(volatile CPI::RPL::OccpWorkerRegisters *w, unsigned timeout) {
   /* Compute log-2 timeout value. */
   if (!timeout)
     timeout = 16;
   unsigned logTimeout = 31;
   for (uint32_t u = 1 << logTimeout; !(u & timeout);
	u >>= 1, logTimeout--)
     ;
   /* Assert Reset. */
   w->control =  logTimeout;
   /* Take out of reset. */
   w->control = OCCP_CONTROL_ENABLE | logTimeout ;
}
