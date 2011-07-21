onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb/axi_aclk
add wave -noupdate -format Logic /tb/axi_aresetn
add wave -noupdate -format Logic /tb/nf10_axi_sim_transactor_1/reset
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Literal /tb/nf10_axi_sim_transactor_1/w_req_addr
add wave -noupdate -format Literal /tb/nf10_axi_sim_transactor_1/w_req_data
add wave -noupdate -format Literal /tb/nf10_axi_sim_transactor_1/w_req_strb
add wave -noupdate -format Logic /tb/nf10_axi_sim_transactor_1/w_req_valid
add wave -noupdate -format Logic /tb/nf10_axi_sim_transactor_1/w_req_ready
add wave -noupdate -format Literal /tb/axi_awaddr
add wave -noupdate -format Logic /tb/axi_awvalid
add wave -noupdate -format Logic /tb/axi_awready
add wave -noupdate -format Literal /tb/axi_wdata
add wave -noupdate -format Literal /tb/axi_wstrb
add wave -noupdate -format Logic /tb/axi_wvalid
add wave -noupdate -format Logic /tb/axi_wready
add wave -noupdate -format Literal /tb/axi_bresp
add wave -noupdate -format Logic /tb/axi_bvalid
add wave -noupdate -format Logic /tb/axi_bready
add wave -noupdate -format Literal /tb/nf10_axi_sim_transactor_1/w_rsp_addr
add wave -noupdate -format Literal /tb/nf10_axi_sim_transactor_1/w_rsp_rsp
add wave -noupdate -format Logic /tb/nf10_axi_sim_transactor_1/w_rsp_valid
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Literal /tb/nf10_axi_sim_transactor_1/r_req_addr
add wave -noupdate -format Logic /tb/nf10_axi_sim_transactor_1/r_req_valid
add wave -noupdate -format Logic /tb/nf10_axi_sim_transactor_1/r_req_ready
add wave -noupdate -format Literal /tb/axi_araddr
add wave -noupdate -format Logic /tb/axi_arvalid
add wave -noupdate -format Logic /tb/axi_arready
add wave -noupdate -format Literal /tb/axi_rdata
add wave -noupdate -format Literal /tb/axi_rresp
add wave -noupdate -format Logic /tb/axi_rvalid
add wave -noupdate -format Logic /tb/axi_rready
add wave -noupdate -format Literal /tb/nf10_axi_sim_transactor_1/r_rsp_addr
add wave -noupdate -format Literal /tb/nf10_axi_sim_transactor_1/r_rsp_data
add wave -noupdate -format Literal /tb/nf10_axi_sim_transactor_1/r_rsp_rsp
add wave -noupdate -format Logic /tb/nf10_axi_sim_transactor_1/r_rsp_valid
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1998563 ps} 0}
configure wave -namecolwidth 335
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {200858 ps}
