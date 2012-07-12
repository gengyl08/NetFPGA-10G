
all:	nf10_configure

nf10_configure:
	gcc -march=core2 nf10_configure.c ../include/libsrc/emc_v4_00_a/src/emc_flash_lib.c reg_lib.c -I . -I ../include/libsrc/emc_v4_00_a/src -I ../include -o nf10_configure

clean:
	rm -rf nf10_configure

