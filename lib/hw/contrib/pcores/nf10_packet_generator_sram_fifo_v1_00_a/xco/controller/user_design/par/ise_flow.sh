./rem_files.sh

#Following coregen commands to be uncommented  when the parameter DEBUG_EN is changed from 0 to 1 in controller.v/.vhd file.
#coregen -b makeproj.sh
#coregen -p . -b icon_coregen.xco
#coregen -p . -b vio_coregen.xco

#rm *.ncf
echo Synthesis Tool: XST

mkdir "../synth/__projnav" > ise_flow_results.txt
mkdir "../synth/xst" >> ise_flow_results.txt
mkdir "../synth/xst/work" >> ise_flow_results.txt

xst -ifn xst_run.txt -ofn controller.syr -intstyle ise >> ise_flow_results.txt
ngdbuild -intstyle ise -dd ../synth/_ngo -nt timestamp -uc controller.ucf -p xc5vtx240t-ff1759-2 controller.ngc controller.ngd >> ise_flow_results.txt

map -intstyle ise -w -logic_opt off -ol high -t 1 -cm area -pr off -o controller_map.ncd controller.ngd controller.pcf >> ise_flow_results.txt
par -w -intstyle ise -ol high controller_map.ncd controller.ncd controller.pcf >> ise_flow_results.txt
trce -intstyle ise -e 3 -l 3 -s -2 -xml controller controller.ncd -o controller.twr controller.pcf >> ise_flow_results.txt
bitgen -intstyle ise -f mem_interface_top.ut controller.ncd >> ise_flow_results.txt

echo done!
