
all:	nf10_configure

nf10_configure:
	gcc -lnl -lnl-genl -lnf10reg nf10_configure.c nf10_flash_lib.c -o nf10_configure

clean:
	rm -rf nf10_configure

