################################################################################
# NetFPGA-10G
# James Hongyi Zeng (hyzeng_at_stanford.edu)
#
# Makefile to build BRAM initialized bitstream
# This Makefile works ONLY after you complete the steps in README.
################################################################################

DOWNLOAD_BIT = download.bit 
SYSTEM_BIT = system.bit 
USER_APP_DIR = ./SDK_Workspace/hello_world_0/Debug/
BSP_DIR = ./SDK_Workspace/bsp/
HW_DIR = ./SDK_Workspace/hw/
SYSTEM_BD = ./SDK_Workspace/hw/system_bd.bmm
SYSTEM_BIT = ./SDK_Workspace/hw/system.bit
ELF = ./$(USER_APP_DIR)/hello_world_0.elf

# All Target
all: bit

clean:
	rm -f $(DOWNLOAD_BIT)
	cd $(BSP_DIR) && $(MAKE) clean
	cd $(USER_APP_DIR) && $(MAKE) clean

bsp:
	cd $(BSP_DIR) && $(MAKE)
    
user_app:
	cd $(USER_APP_DIR) && $(MAKE)
    
bit: bsp user_app
	data2mem -bm $(SYSTEM_BD) \
		-bt $(SYSTEM_BIT) \
		-bd $(ELF)\
		tag microblaze_0 \
		-o b $(DOWNLOAD_BIT)
