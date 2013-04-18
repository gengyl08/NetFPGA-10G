./rem_files.sh

#Following coregen commands to be uncommented  when the parameter DEBUG_EN is changed from 0 to 1 in controller.v/.vhd file.
#coregen -b makeproj.sh
#coregen -p . -b icon_coregen.xco
#coregen -p . -b vio_coregen.xco

#rm *.ncf
xtclsh set_ise_prop.tcl
