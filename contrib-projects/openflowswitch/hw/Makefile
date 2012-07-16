################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  File:
#        Makefile
#
#  Project:
#        openflowswitch
#
#  Author:
#        Tatsuya Yabe
#
#  Copyright notice:
#        Copyright (C) 2010, 2011, 2012 The Board of Trustees of The Leland
#                                 Stanford Junior University
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

include system_incl.make

ifeq "$(shell uname -o)" "Cygwin"
SIM_CMD := $(subst ./, cmd /c , $(SIM_CMD))
endif

#NF10_NGC_FILES := implementation/nf10_oped_0_wrapper.ngc \
#				  implementation/axi_interconnect_0_wrapper.ngc

#NF10_SCR_FILES := nf10/nf10_oped_0_wrapper_xst.scr \
#				  nf10/axi_interconnect_0_wrapper_xst.scr

NF10_NGC_FILES := implementation/axi_interconnect_0_wrapper.ngc

NF10_SCR_FILES := nf10/axi_interconnect_0_wrapper_xst.scr

#################################################################
# PHONY TARGETS
#################################################################
.PHONY: dummy
.PHONY: netlistclean
.PHONY: bitsclean
.PHONY: simclean
.PHONY: exporttosdk

#################################################################
# EXTERNAL TARGETS
#################################################################
all:
	@echo "Makefile to build a Microprocessor system :"
	@echo "Run make with any of the following targets"
	@echo " "
	@echo "  netlist  : Generates the netlist for the given MHS "
	@echo "  bits     : Runs Implementation tools to generate the bitstream"
	@echo "  exporttosdk: Export files to SDK"
	@echo " "
	@echo "  init_bram: Initializes bitstream with BRAM data"
	@echo "  ace      : Generate ace file from bitstream and elf"
	@echo "  download : Downloads the bitstream onto the board"
	@echo " "
	@echo "  sim      : Generates HDL simulation models and runs simulator for chosen simulation mode"
	@echo "  simmodel : Generates HDL simulation models for chosen simulation mode"
	@echo " "
	@echo "  netlistclean: Deletes netlist"
	@echo "  bitsclean: Deletes bit, ncd, bmm files"
	@echo "  hwclean  : Deletes implementation dir"
	@echo "  simclean : Deletes simulation dir"
	@echo "  clean    : Deletes all generated files/directories"
	@echo " "

bits: $(SYSTEM_BIT)

ace: $(SYSTEM_ACE)

#Shahbaz: Generate Register Tree
exporttosdk: $(SYSTEM_HW_HANDOFF_DEP)
	appguru -hw $(SDK_EXPORT_DIR)/$(SYSTEM).xml -app empty_application $(PROJECT_SEARCHPATHOPT)../sw/ -od $(SDK_EXPORT_DIR)/../empty_application
	@mkdir -p $(SDK_EXPORT_DIR)/../libs
	libgen -mhs $(MHSFILE) -p $(DEVICE) $(PROJECT_SEARCHPATHOPT) $(PROJECT_SEARCHPATHOPT)../sw/ -lib -od $(SDK_EXPORT_DIR)/../libs $(SDK_EXPORT_DIR)/../empty_application/$(SYSTEM).mss
	@mkdir -p $(SDK_EXPORT_DIR)/../../../host/include/
	@cp -rf $(SDK_EXPORT_DIR)/../libs/microblaze_0/include/* $(SDK_EXPORT_DIR)/../../../host/include/
	@cp -rf $(SDK_EXPORT_DIR)/../libs/microblaze_0/libsrc $(SDK_EXPORT_DIR)/../../../host/include/
	@rm -rf $(SDK_EXPORT_DIR)/../empty_application
	@rm -rf $(SDK_EXPORT_DIR)/../libs

netlist: $(POSTSYN_NETLIST)

download: $(DOWNLOAD_BIT) dummy
	@echo "*********************************************"
	@echo "Downloading Bitstream onto the target board"
	@echo "*********************************************"
	impact -batch etc/download.cmd

init_bram: $(DOWNLOAD_BIT)

#James: Copy the simulation testbench
sim: $(DEFAULT_SIM_SCRIPT)
	cd simulation/behavioral ; \
	cp ../../nf10/system_tb.v .; \
	sh system_fuse.sh;
	cd simulation/behavioral ; \
	$(SIM_CMD) -gui -tclbatch system_setup.tcl &

simmodel: $(DEFAULT_SIM_SCRIPT)

behavioral_model: $(BEHAVIORAL_SIM_SCRIPT)

structural_model: $(STRUCTURAL_SIM_SCRIPT)

clean: hwclean regsclean simclean
	rm -f _impact.cmd
	rm -rf __xps
	rm -rf blockdiagram
	rm -rf etc
	rm -f *.opt
	rm -f *.log
	rm -f *.make
	rm -f system.mss
	
hwclean: netlistclean bitsclean
	rm -rf implementation synthesis xst hdl
	rm -rf xst.srp $(SYSTEM).srp
	rm -f __xps/ise/_xmsgs/bitinit.xmsgs

netlistclean:
	rm -f $(POSTSYN_NETLIST)
	rm -f platgen.log
	rm -f __xps/ise/_xmsgs/platgen.xmsgs
	rm -f $(BMM_FILE)

bitsclean:
	rm -f $(SYSTEM_BIT)
	rm -f implementation/$(SYSTEM).ncd
	rm -f implementation/$(SYSTEM)_bd.bmm 
	rm -f implementation/$(SYSTEM)_map.ncd 
	rm -f implementation/download.bit 
	rm -f __xps/$(SYSTEM)_routed

## Shahbaz: to clean register system generated files
regsclean:
	rm -rf $(SDK_EXPORT_DIR)/../../../host/include/

simclean: 
	rm -rf simulation/behavioral
	rm -rf axi_simulation/simulation/behavioral
	rm -rf axi_simulation/*.axi
	rm -f simgen.log
	rm -f __xps/ise/_xmsgs/simgen.xmsgs

#################################################################
# BOOTLOOP ELF FILES
#################################################################


$(MICROBLAZE_0_BOOTLOOP): $(MICROBLAZE_BOOTLOOP_LE)
	@mkdir -p $(BOOTLOOP_DIR)
	cp -f $(MICROBLAZE_BOOTLOOP_LE) $(MICROBLAZE_0_BOOTLOOP)

#################################################################
# HARDWARE IMPLEMENTATION FLOW
#################################################################


$(BMM_FILE) \
$(WRAPPER_NGC_FILES): $(MHSFILE) __xps/platgen.opt \
                      $(CORE_STATE_DEVELOPMENT_FILES)
	@echo "****************************************************"
	@echo "Creating system netlist for hardware specification.."
	@echo "****************************************************"
	platgen $(PLATGEN_OPTIONS) $(MHSFILE)

#James: Platgen cannot accept special xst switch. This is a dirty workaround.
$(NF10_NGC_FILES): $(NF10_SCR_FILES)
	@echo "Running NetFPGA-10G specific synthesis..."
	cd synthesis ; for scr in $(NF10_SCR_FILES); do \
		xst -ifn ../$$scr; \
	done;

$(POSTSYN_NETLIST): $(WRAPPER_NGC_FILES) $(NF10_NGC_FILES)
	@echo "Running synthesis..."
	cd synthesis; xst -ifn "system_xst.scr"

#James: Use multi-core map and par. Parameters in nf10/xflow.opt
__xps/$(SYSTEM)_routed: $(FPGA_IMP_DEPENDENCY)
	@echo "*********************************************"
	@echo "Running Xilinx Implementation tools.."
	@echo "*********************************************"
	@cp -f $(UCF_FILE) implementation/$(SYSTEM).ucf
	@cp -f nf10/xflow.opt implementation/xflow.opt
	xflow -wd implementation -p $(DEVICE) -implement xflow.opt $(SYSTEM).ngc
	touch __xps/$(SYSTEM)_routed

$(SYSTEM_BIT): __xps/$(SYSTEM)_routed $(BITGEN_UT_FILE)
	xilperl $(XILINX_EDK_DIR)/data/fpga_impl/observe_par.pl $(OBSERVE_PAR_OPTIONS) implementation/$(SYSTEM).par
	@echo "*********************************************"
	@echo "Running Bitgen.."
	@echo "*********************************************"
	@cp -f $(BITGEN_UT_FILE) implementation/bitgen.ut
	cd implementation ; bitgen -w -f bitgen.ut $(SYSTEM) ; cd ..

$(DOWNLOAD_BIT): $(SYSTEM_BIT) $(BRAMINIT_ELF_IMP_FILES) __xps/bitinit.opt
	@cp -f implementation/$(SYSTEM)_bd.bmm .
	@echo "*********************************************"
	@echo "Initializing BRAM contents of the bitstream"
	@echo "*********************************************"
	bitinit -p $(DEVICE) $(MHSFILE) $(SEARCHPATHOPT) $(BRAMINIT_ELF_IMP_FILE_ARGS) \
	-bt $(SYSTEM_BIT) -o $(DOWNLOAD_BIT)
	@rm -f $(SYSTEM)_bd.bmm

$(SYSTEM_ACE):
	@echo "In order to generate ace file, you must have:-"
	@echo "- exactly one processor."
	@echo "- opb_mdm, if using microblaze."

#################################################################
# EXPORT_TO_SDK FLOW
#################################################################

$(SYSTEM_HW_HANDOFF): $(MHSFILE) __xps/platgen.opt
	@mkdir -p $(SDK_EXPORT_DIR)
	psf2Edward -inp $(SYSTEM).xmp -exit_on_error -edwver 1.2 -xml $(SDK_EXPORT_DIR)/$(SYSTEM).xml $(GLOBAL_SEARCHPATHOPT)
	xdsgen -inp $(SYSTEM).xmp -report $(SDK_EXPORT_DIR)/$(SYSTEM).html $(GLOBAL_SEARCHPATHOPT) -make_docs_local

$(SYSTEM_HW_HANDOFF_BIT): $(SYSTEM_BIT)
	@rm -rf $(SYSTEM_HW_HANDOFF_BIT)
	@cp -f $(SYSTEM_BIT) $(SDK_EXPORT_DIR)

$(SYSTEM_HW_HANDOFF_BMM): implementation/$(SYSTEM)_bd.bmm
	@rm -rf $(SYSTEM_HW_HANDOFF_BMM)
	@cp -f implementation/$(SYSTEM)_bd.bmm $(SDK_EXPORT_DIR)

#################################################################
# SIMULATION FLOW
#################################################################


################## BEHAVIORAL SIMULATION ##################

$(BEHAVIORAL_SIM_SCRIPT): $(MHSFILE) __xps/simgen.opt \
                          $(BRAMINIT_ELF_SIM_FILES)
	@echo "*********************************************"
	@echo "Creating behavioral simulation models..."
	@echo "*********************************************"
	simgen $(SIMGEN_OPTIONS) -m behavioral $(MHSFILE)

################## STRUCTURAL SIMULATION ##################

$(STRUCTURAL_SIM_SCRIPT): $(WRAPPER_NGC_FILES) __xps/simgen.opt \
                          $(BRAMINIT_ELF_SIM_FILES)
	@echo "*********************************************"
	@echo "Creating structural simulation models..."
	@echo "*********************************************"
	simgen $(SIMGEN_OPTIONS) -sd implementation -m structural $(MHSFILE)


################## TIMING SIMULATION ##################

implementation/$(SYSTEM).ncd: __xps/$(SYSTEM)_routed

$(TIMING_SIM_SCRIPT): implementation/$(SYSTEM).ncd __xps/simgen.opt \
                      $(BRAMINIT_ELF_SIM_FILES)
	@echo "*********************************************"
	@echo "Creating timing simulation models..."
	@echo "*********************************************"
	simgen $(SIMGEN_OPTIONS) -sd implementation -m timing $(MHSFILE)

dummy:
	@echo ""
	
################## AXI SIMULATION ##################

axi_model: axi_simulation/$(MHSFILE) __xps/simgen.opt \
           $(BRAMINIT_ELF_SIM_FILES)
	@echo "*********************************************"
	@echo "Creating AXI simulation models..."
	@echo "*********************************************"
	simgen $(SIMGEN_OPTIONS) -m behavioral axi_simulation/$(MHSFILE) -od axi_simulation/ -lp ../

axisim: axi_model
	./axi_simulation/simulation/make_pkts.py ; \
	cd axi_simulation/simulation/behavioral ; \
	cp ../../system_tb.v .; \
	sh system_fuse.sh;
	cd axi_simulation/simulation/behavioral ; \
	$(SIM_CMD) -gui -tclbatch system_setup.tcl &

# James: workaround chicken'n'egg problem thanks to David Miller	
system_incl.make: Makefile
	@echo exit|xps -nw system.xmp
