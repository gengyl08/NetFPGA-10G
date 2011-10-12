cd $(dirname $0)
rm -rf unittest_build
mkdir  unittest_build
cd     unittest_build
fuse -incremental -prj ../nf10_nic_output_port_lookup_tb.prj -o nf10_nic_output_port_lookup_tb.exe testbench
./nf10_nic_output_port_lookup_tb.exe -tclbatch ../nf10_nic_output_port_lookup_tb.tcl
