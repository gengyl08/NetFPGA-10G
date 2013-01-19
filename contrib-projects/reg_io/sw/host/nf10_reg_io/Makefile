
all:	nf10_reg_io

nf10_reg_io:
	gcc -march=core2 nf10_reg_io.c ../include/libsrc/nf10_reg_io_v1_00_a/src/nf10_reg_io_lib.c reg_lib.c -I . -I ../include/libsrc/nf10_reg_io_v1_00_a/src -I ../include -o nf10_reg_io

clean:
	rm -rf nf10_reg_io

