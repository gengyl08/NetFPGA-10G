
all:	nf10_flash_prog

nf10_flash_prog:
	gcc -lnl -lnl-genl -lnf10reg nf10_flash_prog.c nf10_flash_lib.c -o nf10_flash_prog

clean:
	rm -rf nf10_flash_prog

