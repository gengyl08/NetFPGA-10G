all:
	gcc -lnl -lnl-genl -lnf10reg read_bitstream_py.c      -o read_bitstream_py
	gcc -lnl -lnl-genl -lnf10reg read_2nd_bitstream_py.c  -o read_2nd_bitstream_py
	gcc -lnl -lnl-genl -lnf10reg write_bitstream_py.c     -o write_bitstream_py
	gcc -lnl -lnl-genl -lnf10reg write_2nd_bitstream_py.c -o write_2nd_bitstream_py

clean:
	rm -rf read_bitstream_py
	rm -rf read_2nd_bitstream_py
	rm -rf write_bitstream_py
	rm -rf write_2nd_bitstream_py
