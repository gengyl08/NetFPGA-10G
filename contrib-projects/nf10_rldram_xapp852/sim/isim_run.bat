echo Simulation Tool: ISIM
fuse work.ext_test_bench work.glbl -prj isim_files.prj -L unisims_ver -L secureip -o isim_test.exe
./isim_test.exe -gui -tclbatch isim_options.tcl -wdb isim_database.wdb
echo done
