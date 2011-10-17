/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        dma_test.cxx
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
 *        now tests and profiles the OpenCPI based DMA engine in the
 *        production test design for NetFPGA-10G.
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

#include <unistd.h>
#include <fcntl.h>
#include <assert.h>
#include <stdio.h>
#include <sys/mman.h>
#include <errno.h>
#include <time.h>
#include <pthread.h>
#include <string.h>
#include <stdlib.h>
#include <stdint.h>
#include "OCCP.h"
#include "OCDP.h"

#define WORKER_DP0 (13)
#define WORKER_DP1 (14)
#define WORKER_SMA0 (2)
#define WORKER_BIAS (3)
#define WORKER_SMA1 (4)
#define OCDP_OFFSET_DP0 (32*1024)
#define OCDP_OFFSET_DP1 0

/* Control operations on workers. */
static void
  reset(volatile CPI::RPL::OccpWorkerRegisters *, unsigned),
  init(volatile CPI::RPL::OccpWorkerRegisters *),
  start(volatile CPI::RPL::OccpWorkerRegisters *);

/* Packet of arguments required to process a stream endpoint on the cpu side. */
struct Stream {
  unsigned bufSize, nBufs;
  volatile uint8_t *buffers;
  volatile CPI::RPL::OcdpMetadata *metadata;
  volatile uint32_t *flags;
  volatile uint32_t *doorbell;
};

struct testStats {
  uint64_t num_tx_bufs;
  uint64_t num_tx_bytes;
  uint64_t num_rx_bufs;
  uint64_t num_rx_bytes;
  uint64_t num_rx_buf_errors;
  time_t   tx_start;
  time_t   rx_end;
  uint8_t  tx_buffer_timeout_hit;
  uint8_t  rx_buffer_timeout_hit;
  uint8_t  rx_gen_timeout_hit;
};

struct testStats tStats;

static int
  validate_buffer(void* buf, uint32_t size);

struct doRead_args {
  Stream* s;
  uint32_t runTime;
  uint32_t timeOut;
};

struct doWrite_args {
  Stream* s;
  uint32_t runTime;
  uint32_t timeOut;
};

static void
  *doRead(void *args),
  *doWrite(void *args),
  fill_buffer(void* buf, uint32_t size),
  setupStream(Stream *s, volatile CPI::RPL::OcdpProperties *p, bool isToCpu,
	      unsigned nCpuBufs, unsigned nFpgaBufs, unsigned bufSize,
	      uint8_t *cpuBase, unsigned long long dmaBase, uint32_t *offset);

int main(int argc, char *argv[])
{
  errno = 0;
  unsigned long long
    bar0Base = strtoull(argv[1], NULL, 0),    /* Bar0 base address for PCIe endpoint. */
    dmaBase  = strtoull(argv[2], NULL, 0),    /* Host's DMA memory base address. */
    dmaSize  = strtoull(argv[3], NULL, 0),    /* Host's DMA memory size. */
    nFpgaBufs = strtoull(argv[4], NULL, 0),   /* How many buffers on FPGA side. */
    nCpuBufs = strtoull(argv[5], NULL, 0),    /* How many buffers on Host side. */
    bufSize  = strtoull(argv[6], NULL, 0),    /* Size of FPGA and Host buffers. */
    runTime  = strtoull(argv[7], NULL, 0),    /* How long to run this test, in seconds. */
    timeOut  = strtoull(argv[8], NULL, 0);    /* Timeout value, in seconds, for reader and writer in case they get stuck. */

  assert(errno == 0);
  int fd = open("/dev/mem", O_RDWR|O_SYNC);
  assert(fd >= 0);

  /* Memory map the whole config and control space for workers and dataplanes. */
  CPI::RPL::OccpSpace *occp =
    (CPI::RPL::OccpSpace *)mmap(NULL, sizeof(CPI::RPL::OccpSpace),
				PROT_READ|PROT_WRITE, MAP_SHARED, fd, bar0Base);
  assert(occp != (CPI::RPL::OccpSpace*)-1);

  /* Memory map host side DMA buffer memory. */
  uint8_t *cpuBase =
    (uint8_t*)mmap(NULL, dmaSize, PROT_READ|PROT_WRITE, MAP_SHARED, fd, dmaBase);
  assert(cpuBase != (uint8_t*)-1);

  /* Setup pointers to specifically config spaces for workers and dataplanes. */
  volatile CPI::RPL::OcdpProperties
    *dp0Props = (CPI::RPL::OcdpProperties*)occp->config[WORKER_DP0],
    *dp1Props = (CPI::RPL::OcdpProperties*)occp->config[WORKER_DP1];

  volatile uint32_t
    *sma0Props = (uint32_t*)occp->config[WORKER_SMA0],
    *sma1Props = (uint32_t*)occp->config[WORKER_SMA1],
    *biasProps = (uint32_t*)occp->config[WORKER_BIAS];

  /* Setup pointers to specifically control spaces for workers and dataplanes. */
  volatile CPI::RPL::OccpWorkerRegisters
    *dp0 = &occp->worker[WORKER_DP0].control,
    *dp1 = &occp->worker[WORKER_DP1].control,
    *sma0 = &occp->worker[WORKER_SMA0].control,
    *sma1 = &occp->worker[WORKER_SMA1].control,
    *bias = &occp->worker[WORKER_BIAS].control;

  /* Reset workers and dataplanes. */
  reset(sma0,  0);
  reset(sma1,  0);
  reset(bias,  0);
  reset(dp0,  0);
  reset(dp1,  0);

  /* Initialize workers and dataplanes. */
  init(sma0);
  init(sma1);
  init(bias);
  init(dp0);
  init(dp1);

  /* Configure workers. */
  *sma0Props = 1; /* WMI input to WSI output. */
  *biasProps = 0;
  *sma1Props = 2; /* WSI input to WMI output. */

  /* Configure streams, SW side and HW side. */
  Stream fromCpu, toCpu;
  uint32_t dmaOffset = 0; /* This is our "dma buffer allocation" pointer... */
  setupStream(&fromCpu, dp0Props, false,
	      nCpuBufs, nFpgaBufs, bufSize, cpuBase, dmaBase, &dmaOffset);
  setupStream(&toCpu, dp1Props, true,
	      nCpuBufs, nFpgaBufs, bufSize, cpuBase, dmaBase, &dmaOffset);

  /* Start workers. */
  start(dp0);
  start(dp1);
  start(sma0);
  start(bias);
  start(sma1);

  /* Fork a thread to continuously read and validate the toCpu stream. */
  pthread_t readThread;
  struct doRead_args dRargs;
  dRargs.s = &toCpu;
  dRargs.runTime = runTime;
  dRargs.timeOut = timeOut;
  int r = pthread_create(&readThread, NULL, doRead, &dRargs);
  assert(r == 0);

  /* Fork a thread to write to the fromCpu stream for runTime seconds. */
  pthread_t writeThread;
  struct doWrite_args dWargs;
  dWargs.s = &fromCpu;
  dWargs.runTime = runTime;
  dWargs.timeOut = timeOut;
  r = pthread_create(&writeThread, NULL, doWrite, &dWargs);
  assert(r == 0);

  /* Rendezvous with the writer thread. */
  r = pthread_join(writeThread, NULL);
  assert(r == 0);

  /* Rendezvous with the reader thread. */
  r = pthread_join(readThread, NULL);
  assert(r == 0);

  /* Print DMA test report to stdout. */
  printf("%-30s", "DMA Test Result:");
  if( (tStats.num_rx_buf_errors > 0) || (tStats.num_tx_bufs != tStats.num_rx_bufs) || (tStats.num_tx_bytes != tStats.num_rx_bytes) || tStats.tx_buffer_timeout_hit || tStats.rx_buffer_timeout_hit || tStats.rx_gen_timeout_hit) {
    printf("FAIL\n");
    printf("%-30s%lld\n", "DMA Transmitted Buffers:", tStats.num_tx_bufs);
    printf("%-30s%lld\n", "DMA Received Buffers:", tStats.num_rx_bufs);
    printf("%-30s%lld\n", "DMA Transmitted Bytes:", tStats.num_tx_bytes);
    printf("%-30s%lld\n", "DMA Received Bytes:", tStats.num_rx_bytes);
    printf("%-30s%lld\n", "DMA Buffer Transfer Errors:", tStats.num_rx_buf_errors);
    printf("%-30s%s\n", "DMA TX Timeout:", tStats.tx_buffer_timeout_hit ? "yes" : "no");
    printf("%-30s%s\n", "DMA RX Timeout:", tStats.rx_buffer_timeout_hit ? "yes" : "no");
    printf("%-30s%s\n", "DMA RX Overrun:", tStats.rx_gen_timeout_hit ? "yes" : "no");
  } else {
    printf("PASS\n");
    printf("%-30s%lld totaling %.2f MB\n", "DMA Transfers:", tStats.num_rx_bufs, tStats.num_rx_bytes/1000000.0);
    /*
    if( tStats.rx_end - tStats.tx_start > 0 )
      printf("%-30s%.2f MB/s\n", "DMA Avg. Bandwidth:", (tStats.num_rx_bytes/1000000.0)/(tStats.rx_end - tStats.tx_start));
    */
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

/* Check a control operation return code. */
static void
check(uint32_t val) {
  assert(val == OCCP_SUCCESS_RESULT);
}

/* Initialize a worker. */
static void
init(volatile CPI::RPL::OccpWorkerRegisters *w) {
  check(w->initialize);
}

/* Start a worker. */
static void
start(volatile CPI::RPL::OccpWorkerRegisters *w) {
  check(w->start);
}

static int
validate_buffer(void* buf, uint32_t size) {
  static uint32_t counter = 0x0;
  uint32_t i;
  int r = 0;

  for( i = 0; i < (size/sizeof(uint32_t)); i++ ) {
    if( ((uint32_t*)buf)[i] != counter )
      r = 1;
    else
      counter++;
  }

  return r;
}

static void
fill_buffer(void* buf, uint32_t size) {
  static uint32_t counter = 0x0;
  uint32_t i;

  for( i = 0; i < (size/sizeof(uint32_t)); i++ )
    ((uint32_t*)buf)[i] = counter++;
}

/* Continuously read and validate rx data. */
static void *
doRead(void *args) {
  struct doRead_args* dRargs = (doRead_args*)args;
  Stream *s = dRargs->s;
  uint32_t runTime = dRargs->runTime;
  uint32_t timeOut = dRargs->timeOut;
  unsigned bufIdx = 0, nwrite;
  void *buf = malloc(s->bufSize); /* Just here because linux can't read/write to/from dma memory. */
  time_t gen_timeout_start, gen_timeout_end;        /* General timeout, for overall timeout of this thread. */
  time_t buffer_timeout_start, buffer_timeout_end;  /* Buffer timeout, for waiting on receiving a buffer. */

  /* Initialize our part of the testStats structure. */
  tStats.num_rx_bufs = 0;
  tStats.num_rx_bytes = 0;
  tStats.num_rx_buf_errors = 0;
  tStats.rx_gen_timeout_hit = 0;
  tStats.rx_buffer_timeout_hit = 0;

  time(&gen_timeout_start);

  do {
    /* If we've exceeded runTime + timeOut and still haven't received a
     * zero length buffer, then terminate */
    time(&gen_timeout_end);
    if( (uint32_t)(gen_timeout_end-gen_timeout_start) > runTime + timeOut ) {
      tStats.rx_gen_timeout_hit = 1;
      return 0;
    }

    /* Wait for buffer to be full, so we can empty it. */
    time(&buffer_timeout_start);
    while (s->flags[bufIdx] == 0) {
      /* Check to see if we have been waiting too long for a full buffer. */
      time(&buffer_timeout_end);
      if( (uint32_t)(buffer_timeout_end-buffer_timeout_start) > timeOut ) {
        tStats.rx_buffer_timeout_hit = 1;
        return 0;
      }
    }

    nwrite = s->metadata[bufIdx].length;

    if (nwrite != 0) {
      memcpy(buf, (void*)&s->buffers[bufIdx * s->bufSize], nwrite);

      if ( validate_buffer(buf, nwrite) != 0 )
	tStats.num_rx_buf_errors++;

      tStats.num_rx_bufs++;
      tStats.num_rx_bytes += nwrite;
    } else {
      /* Record end time. */
      time(&tStats.rx_end);
    }

    /* Mark the buffer empty. FPGA will set it to 1 when it fills it (ready to use). */
    s->flags[bufIdx] = 0;
    /* Tell hardware we have emptied it. */
    *s->doorbell = 1;

    if (++bufIdx == s->nBufs)
      bufIdx = 0;

  } while (nwrite != 0);



  return 0;
}

/* Transmit data to the hardware for runTime seconds */
static void *
doWrite(void *args) {
  struct doWrite_args* dWargs = (doWrite_args*)args;
  Stream *s = dWargs->s;
  uint32_t runTime = dWargs->runTime;
  uint32_t timeOut = dWargs->timeOut;
  unsigned bufIdx = 0;
  void *buf = malloc(s->bufSize);
  time_t end;
  time_t buffer_timeout_start;  /* Buffer timeout, for waiting on a buffer to be free to fill. */

  /* Initialize our part of the testStats structure. */
  tStats.num_tx_bufs = 0;
  tStats.num_tx_bytes = 0;
  time(&tStats.tx_start);
  tStats.tx_buffer_timeout_hit = 0;

  do {
    /* Wait for buffer to be empty, so we can fill it. */
    time(&buffer_timeout_start);
    while (s->flags[bufIdx] == 0) {
      /* Check to see if we have been waiting too long for a free buffer. */
      time(&end);
      if( (uint32_t)(end-buffer_timeout_start) > timeOut ) {
        tStats.tx_buffer_timeout_hit = 1;
        return 0;
      }
    }

    time(&end);

    /* If we haven't exceeded runTime, fill the buffer. */
    if( (uint32_t)(end-tStats.tx_start) < runTime ) {
      fill_buffer(buf, s->bufSize);
      memcpy((void *)&s->buffers[bufIdx * s->bufSize], buf, s->bufSize);
      s->metadata[bufIdx].length = s->bufSize;

      tStats.num_tx_bufs++;
      tStats.num_tx_bytes += s->metadata[bufIdx].length;
    }
    /* Otherwise, send an empty buffer. Reader uses empty buffer as exit signal. */
    else {
      s->metadata[bufIdx].length = 0;
    }

    /* Set it full. FPGA will set it to 1 (empty/ready to use). */
    s->flags[bufIdx] = 0;
    /* Tell hardware we have filled it. */
    *s->doorbell = 1;

    if (++bufIdx == s->nBufs)
      bufIdx = 0;

  } while ((uint32_t)(end-tStats.tx_start) < runTime);

  return 0;
}

static void
setupStream(Stream *s, volatile CPI::RPL::OcdpProperties *p, bool isToCpu,
	    unsigned nCpuBufs, unsigned nFpgaBufs, unsigned bufSize,
	    uint8_t *cpuBase, unsigned long long dmaBase, uint32_t *offset)
{
  s->nBufs = nCpuBufs;
  s->bufSize = bufSize;
  s->buffers = cpuBase + *offset;
  s->metadata = (CPI::RPL::OcdpMetadata *)(s->buffers + nCpuBufs * bufSize);
  s->flags = (uint32_t *)(s->metadata + nCpuBufs);
  s->doorbell = &p->nRemoteDone;
  *offset += (uint8_t *)(s->flags + nCpuBufs) - s->buffers;
  memset((void *)s->flags, isToCpu ? 0 : 1, bufSize * sizeof(uint32_t));
  p->nLocalBuffers = nFpgaBufs;
  p->nRemoteBuffers = nCpuBufs;
  p->localBufferBase = 0;
  p->localMetadataBase = nFpgaBufs * bufSize; /* Above 4 x 2k buffers. */
  p->localBufferSize = bufSize;
  p->localMetadataSize = sizeof(CPI::RPL::OcdpMetadata);
  p->memoryBytes = 32*1024;
  p->remoteBufferBase = dmaBase + (s->buffers - cpuBase);
  p->remoteMetadataBase = dmaBase + ((uint8_t*)s->metadata - cpuBase);
  p->remoteBufferSize = bufSize;
  p->remoteMetadataSize = sizeof(CPI::RPL::OcdpMetadata);
  p->remoteFlagBase = dmaBase + ((uint8_t*)s->flags - cpuBase);
  p->remoteFlagPitch = sizeof(uint32_t);
  p->control = OCDP_CONTROL(isToCpu ? OCDP_CONTROL_PRODUCER : OCDP_CONTROL_CONSUMER,
			    CPI::RPL::OCDP_ACTIVE_MESSAGE);
 }
