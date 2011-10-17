################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  File:
#        Makefile
#
#  Project:
#        reference_nic_1g
#
#  Author:
#        James Hongyi Zeng
#
#  Description:
#        make all : Make BRAM initialized bitfile to result/
#
#        For more information about how Xilinx EDK works, please visit
#        http://www.xilinx.com/support/documentation/dt_edk.htm
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

include Make.include

.PHONY: clean

# All Target
all: $(DOWNLOAD_BIT)

clean:
	rm -rf $(RESULT_DIR)
	rm -rf $(HW_DIR)/*
	$(MAKE) -C $(BSP_DIR) clean

$(RESULT_DIR):
	mkdir -p $(RESULT_DIR)

${PROCESSOR}/lib/libxil.a: $(RESULT_DIR) $(SYSTEM_BIT) $(HWSPEC)
	libgen -hw ${HWSPEC}\
	       ${REPOSITORIES}\
	       -pe ${PROCESSOR} \
	       -log libgen.log \
	       $(MSS) \
	       -od $(RESULT_DIR)

$(RESULT_DIR)/%.o: $(USER_APP_DIR)/src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MicroBlaze gcc compiler'
	mb-gcc -Wall -O0 -g3 -I $(RESULT_DIR)/${PROCESSOR}/include -c -fmessage-length=0 -mlittle-endian -mxl-barrel-shift -mxl-pattern-compare -mcpu=v8.00.a -mxl-soft-mul -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o"$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

$(ELF): $(OBJS) $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: MicroBlaze gcc linker'
	mb-gcc -L$(RESULT_DIR)/${PROCESSOR}/lib -Wl,-T -Wl,$(USER_APP_DIR)/src/lscript.ld -mlittle-endian -mxl-barrel-shift -mxl-pattern-compare -mcpu=v8.00.a -mxl-soft-mul -o $(ELF) $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

$(DOWNLOAD_BIT): ${PROCESSOR}/lib/libxil.a $(ELF) $(SYSTEM_BD) $(SYSTEM_BIT)
	data2mem -bm $(SYSTEM_BD) \
		-bt $(SYSTEM_BIT) \
		-bd $(ELF)\
		tag microblaze_0 \
		-o b $(DOWNLOAD_BIT)

$(SYSTEM_BIT) $(HWSPEC):
	$(MAKE) -C ../../hw exporttosdk

