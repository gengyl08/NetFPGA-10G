cd $(dirname $0)
rm -rf unittest_build
mkdir  unittest_build
cd     unittest_build
fuse -incremental -prj ../nf10_axis_gen_check_tb.prj -o nf10_axis_gen_check_tb.exe work.testbed 
./nf10_axis_gen_check_tb.exe -tclbatch ../nf10_axis_gen_check_tb.tcl
