#!/usr/bin/python

#///////////////////////////////////////////////////////////////////////
#
#  Description:
#          This python script orchestrates the software end of the 
#          production test by invoking various other programs.
#
#  Revision history:
#          2010/11/04 Jonathan Ellithorpe: Initial check-in
#
#///////////////////////////////////////////////////////////////////////

import os
import re
import sys
import commands
from datetime import datetime

# Production Test Version.
VERSION		= "1.0"

# If an output file is specified, then write the report to the file instead of stdout.
if len(sys.argv) == 2:
	# hehe
	os.system("./production_test.py > ../output/reports/" + sys.argv[1])
	sys.exit()

os.system("clear")

print "NetFPGA-10G Production Test\nVersion: " + VERSION + "\nTime: " + str(datetime.now())
print ""
print "Running UART test..."

which_minicom_status, which_minicom_output = commands.getstatusoutput("which minicom")
if not os.WIFEXITED(which_minicom_status) or not os.WEXITSTATUS(which_minicom_status) == 0:
	print "ERROR: UART test requires minicom to be installed"
	print "Skipping UART test..."
elif not os.path.exists("/dev/ttyUSB0"):
	print "ERROR: Expecting UART on /dev/ttyUSB0"
	print "Skipping UART test..."
else: # OK fine, run the UART test.
	# Minicom needs its configuration file to be in /etc/.
	os.system("cp ../config/minirc.prod_test_cfg /etc/")
	# Get rid of previous output for good measure.
	os.system("rm -f ../output/minicom/minicom_output.txt")
	commands.getoutput("runscript minicom.script | minicom prod_test_cfg -C ../output/minicom/minicom_output.txt")
	# Clean up our mini-mess.
	os.system("rm -f /etc/minirc.prod_test_cfg")
	minicom_output_pattern = re.compile('Test started')
	minicom_output_file = open('../output/minicom/minicom_output.txt', 'r')
	minicom_output_match = minicom_output_pattern.search(minicom_output_file.readline())
	print "UART test finished!"
	print "---------- UART Test Report ----------"
	if minicom_output_match:
		print "UART Test Result: PASS"
	else:
		print "UART Test Result: FAIL"

print ""

# Set number of FPGA size buffers.
NFPGABUFS	= 4
# Set number of host-side buffers.
NCPUBUFS	= 8
# Set the size of the buffers in bytes on both FPGA and host.
BUFSIZE		= 2048
# Set the number of seconds to run the DMA test.
RUNTIME		= 10
# Set the number of seconds for a DMA timeout.
TIMEOUT		= 5

print "Running PCIe DMA test... (will take " + str(RUNTIME) + " seconds)..."

# Get the bar0 address of the PCIe core on the FPGA.
lspci_pattern = re.compile('RAM memory: Xilinx Corporation.*?Memory at (\w{8})', re.DOTALL)
lspci_output = commands.getoutput("lspci -vx")
lspci_match = lspci_pattern.search(lspci_output)
if lspci_match :
	bar0_addr = lspci_match.group(1)
else:
	print "ERROR: Couldn't find board using lspci"
	sys.exit()

# Get the host-side DMA base address and size.
memmap_pattern = re.compile('.*memmap=(\w+)M\$0x(\w{8})', re.DOTALL)
kernel_options = commands.getoutput("cat /proc/cmdline")
memmap_match = memmap_pattern.search(kernel_options)
if memmap_match:
	dma_size = int(memmap_match.group(1)) * 1024 * 1024
	dma_addr = memmap_match.group(2)
else:
	print "ERROR: Couldn't find a proper memmap kernel boot option in /proc/cmdline"
	sys.exit()

# Run the DMA test C program.
dma_test_output = commands.getoutput("../bin/dma_test 0x" + bar0_addr + " 0x" + dma_addr + " " + str(dma_size) + " " + str(NFPGABUFS) + " " + str(NCPUBUFS) + " " + str(BUFSIZE) + " " + str(RUNTIME) + " " + str(TIMEOUT))

print "PCIe DMA test finished!"
print "---------- PCIe DMA Test Report ----------"
print dma_test_output
print ""

print "Checking FPGA system status registers..."

# Run the register report C program.
reg_report_output = commands.getoutput("../bin/reg_report 0x" + bar0_addr)

print "---------- FPGA System Report ----------"
print reg_report_output
print ""

print "Production test finished."

