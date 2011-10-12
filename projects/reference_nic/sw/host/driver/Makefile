SRC			= src
BUILD		= build
BIN			= bin
ROOT		:= $(shell pwd)
DATE		:= $(shell date +%Y%m%d_%H%M)

# NOTE: Do not enable both GHOST and LOOPB at the same time.
DRIVER_DEBUG    = n
DRIVER_GHOST	= n
DRIVER_LOOPB	= n
export DRIVER_DEBUG
export DRIVER_GHOST
export DRIVER_LOOPB

all:
	cp -r $(SRC)/ $(BUILD)/$(DATE)
	$(MAKE) -C $(BUILD)/$(DATE)
	cp $(BUILD)/$(DATE)/nf10_eth_driver.ko $(BIN)/
	cp $(BUILD)/$(DATE)/driver_ctrl $(BIN)/
	cp $(BUILD)/$(DATE)/libnf10reg.so.1.0 $(BIN)/

nf10_eth_driver:
	cp -r $(SRC)/ $(BUILD)/$(DATE)
	$(MAKE) nf10_eth_driver -C $(BUILD)/$(DATE)
	cp $(BUILD)/$(DATE)/nf10_eth_driver.ko $(BIN)/

driver_ctrl:
	cp -r $(SRC)/ $(BUILD)/$(DATE)
	$(MAKE) driver_ctrl -C $(BUILD)/$(DATE)
	cp $(BUILD)/$(DATE)/driver_ctrl $(BIN)/

nf10_reg_lib:
	cp -r $(SRC)/ $(BUILD)/$(DATE)
	$(MAKE) nf10_reg_lib -C $(BUILD)/$(DATE)
	cp $(BUILD)/$(DATE)/libnf10reg.so.1.0 $(BIN)/
	
install_nf10_reg_lib:
	cp $(BIN)/libnf10reg.so.1.0 /usr/local/lib
	ln -sf /usr/local/lib/libnf10reg.so.1.0 /usr/local/lib/libnf10reg.so
	ln -sf /usr/local/lib/libnf10reg.so.1.0 /usr/local/lib/libnf10reg.so.1

clean:
	rm -rf $(BUILD)/* $(BIN)/*

