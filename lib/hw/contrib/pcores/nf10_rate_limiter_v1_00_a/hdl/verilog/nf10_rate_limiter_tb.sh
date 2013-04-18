cd $(dirname $0)
rm -rf unittest_build
mkdir  unittest_build
cd     unittest_build
fuse -incremental -prj ../nf10_rate_limiter_tb.prj -o nf10_rate_limiter_tb.exe testbench
./nf10_rate_limiter_tb.exe -gui
