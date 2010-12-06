################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  Module:
#          Project embedded software Makefile
#
#  Description:
#          make all : Make BRAM initialized bitfile to result/
#
#          For more information about how Xilinx EDK works, please visit
#          http://www.xilinx.com/support/documentation/dt_edk.htm
#                 
#  Revision history:
#          2010/12/1 hyzeng: Initial check-in
#
################################################################################

include Make.include 

.PHONY: clean

# All Target
all: $(DOWNLOAD_BIT)

clean:
	rm -rf $(RESULT_DIR)
	rm -rf $(HW_DIR)/*
	
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
	cd ../../hw && $(MAKE) exporttosdk

