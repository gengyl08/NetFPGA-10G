#!/bin/bash

# NB: For modelsim.  Expects local copies of the following pcores under
#     lib/hw/xilinx:
#               proc_common_v3_00_a
#               axi_bram_ctrl_v1_02_a

set -e

vlib proc_common_v3_00_a
for each in $(cat ../../../../../xilinx/pcores/proc_common_v3_00_a/data/proc_common_v2_1_0.pao |cut -f 3 -d \ ); do
    vcom -work proc_common_v3_00_a ../../../../../xilinx/pcores/proc_common_v3_00_a/hdl/vhdl/$each.vhd;
done

vlib axi_bram_ctrl_v1_02_a
for each in $(grep ^lib ../../../../../xilinx/pcores/axi_bram_ctrl_v1_02_a/data/axi_bram_ctrl_v2_1_0.pao |cut -f 3 -d \ ); do
    vcom -work axi_bram_ctrl_v1_02_a ../../../../../xilinx/pcores/axi_bram_ctrl_v1_02_a/hdl/vhdl/$each;
done

vlib nf10_axis_sim_pkg_v1_00_a
vcom -work nf10_axis_sim_pkg_v1_00_a ../../../nf10_axis_sim_pkg_v1_00_a/simhdl/vhdl/nf10_axis_sim_pkg.vhd 

vlib nf10_axi_sim_transactor_v1_00_a
vcom -work nf10_axi_sim_transactor_v1_00_a transactor_fifos.vhd
vcom -work nf10_axi_sim_transactor_v1_00_a nf10_axi_sim_transactor.vhd

vlib work
vcom tb.vhd
