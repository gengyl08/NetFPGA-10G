SRC		= src
BUILD		= build
BIN		= bin
ROOT		:= $(shell pwd)
DATE		:= $(shell date +%Y%m%d_%H%M)

all:
	cp -r $(SRC)/ $(BUILD)/$(DATE)
	$(MAKE) -C $(BUILD)/$(DATE)
	cp $(BUILD)/$(DATE)/nf10_configure $(BIN)/

clean:
	rm -rf $(BUILD)/* $(BIN)/*
