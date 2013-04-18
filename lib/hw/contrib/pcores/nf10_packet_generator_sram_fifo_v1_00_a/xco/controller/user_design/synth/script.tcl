project -new
#add_file options
add_file -verilog "../rtl/controller.v"
add_file -verilog "../rtl/qdrii_chipscope.v"
add_file -verilog "../rtl/qdrii_idelay_ctrl.v"
add_file -verilog "../rtl/qdrii_infrastructure.v"
add_file -verilog "../rtl/qdrii_phy_addr_io.v"
add_file -verilog "../rtl/qdrii_phy_bw_io.v"
add_file -verilog "../rtl/qdrii_phy_clk_io.v"
add_file -verilog "../rtl/qdrii_phy_cq_io.v"
add_file -verilog "../rtl/qdrii_phy_d_io.v"
add_file -verilog "../rtl/qdrii_phy_dly_cal_sm.v"
add_file -verilog "../rtl/qdrii_phy_en.v"
add_file -verilog "../rtl/qdrii_phy_init_sm.v"
add_file -verilog "../rtl/qdrii_phy_q_io.v"
add_file -verilog "../rtl/qdrii_phy_read.v"
add_file -verilog "../rtl/qdrii_phy_v5_q_io.v"
add_file -verilog "../rtl/qdrii_phy_write.v"
add_file -verilog "../rtl/qdrii_top.v"
add_file -verilog "../rtl/qdrii_top_ctrl_sm.v"
add_file -verilog "../rtl/qdrii_top_phy.v"
add_file -verilog "../rtl/qdrii_top_rd_addr_interface.v"
add_file -verilog "../rtl/qdrii_top_rd_interface.v"
add_file -verilog "../rtl/qdrii_top_user_interface.v"
add_file -verilog "../rtl/qdrii_top_wr_addr_interface.v"
add_file -verilog "../rtl/qdrii_top_wr_data_interface.v"
add_file -verilog "../rtl/qdrii_top_wr_interface.v"
add_file -verilog "../rtl/qdrii_top_wrdata_bw_fifo.v"
add_file -verilog "../rtl/qdrii_top_wrdata_fifo.v"
add_file -constraint "../synth/mem_interface_top.sdc"
#implementation: "synth"
impl -add ../synth
#device options
set_option -technology virtex5
set_option -part xc5vtx240t
set_option -package ff1759
set_option -speed_grade -2
#compilation/mapping options
set_option -default_enum_encoding default
set_option -symbolic_fsm_compiler 1
set_option -resource_sharing 1
set_option -use_fsm_explorer 0
set_option -top_module "controller"
#map options
set_option -frequency 200
set_option -run_prop_extract 1
set_option -fanout_limit 10000
set_option -disable_io_insertion 0
set_option -pipe 1
set_option -update_models_cp 0
set_option -verification_mode 0
set_option -fixgatedclocks 0
set_option -modular 0
set_option -retiming 0
set_option -no_sequential_opt 0
#simulation options
set_option -write_verilog 0
set_option -write_vhdl 0
#VIF options
set_option -write_vif 1
#automatic place and route (vendor) options
set_option -write_apr_constraint 1
#set result format/file last
project -result_file "controller.edf"
#implementation attributes
set_option -vlog_std v2001
set_option -num_critical_paths 100
set_option -num_startend_points 100
set_option -dup 0
set_option -project_relative_includes 1
#par_1 attributes
set_option -job par_1 -add par
set_option -job par_1 -option run_backannotation 0
impl -active "synth"
project -run hdl_info_gen 
project -run
project -save
