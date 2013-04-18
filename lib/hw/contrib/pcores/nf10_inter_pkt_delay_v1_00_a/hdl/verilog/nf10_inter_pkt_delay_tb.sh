cd $(dirname $0)
rm -rf unittest_build
mkdir  unittest_build
cd     unittest_build
fuse -incremental -prj ../nf10_inter_pkt_delay_tb.prj -o nf10_inter_pkt_delay_tb.exe testbench
./nf10_inter_pkt_delay_tb.exe -gui
