/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        nf10_bram_output_queues.v
 *
 *  Library:
 *        hw/std/pcores/nf10_axis_sim_record_v1_00_a
 *
 *  Author:
 *        James Hongyi Zeng
 *        David J. Miller
 *
 *  Description:
 *        Records traffic received from an AXI Stream master to an
 *        AXI grammar formatted text file.
 *
 *  Copyright notice:
 *        Copyright (C) 2010, 2011 The Board of Trustees of The Leland Stanford
 *                                 Junior University
 *
 *  Licence:
 *        This file is part of the NetFPGA 10G development base package.
 *
 *        This file is free code: you can redistribute it and/or modify it under
 *        the terms of the GNU Lesser General Public License version 2.1 as
 *        published by the Free Software Foundation.
 *
 *        This package is distributed in the hope that it will be useful, but
 *        WITHOUT ANY WARRANTY; without even the implied warranty of
 *        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *        Lesser General Public License for more details.
 *
 *        You should have received a copy of the GNU Lesser General Public
 *        License along with the NetFPGA source package.  If not, see
 *        http://www.gnu.org/licenses/.
 *
 */

module nf10_axis_sim_record
#(
    // Master AXI Stream Data Width
    parameter C_S_AXIS_DATA_WIDTH=256,
    parameter C_S_AXIS_TUSER_WIDTH=128,
    parameter output_file="../../stream_data_out.axi"
)
(
    // Part 1: System side signals
    // Global Ports
    input aclk,

    // Slave Stream Ports (interface to data path)
    input [C_S_AXIS_DATA_WIDTH - 1:0] s_axis_tdata,
    input [((C_S_AXIS_DATA_WIDTH / 8)) - 1:0] s_axis_tstrb,
    input [C_S_AXIS_TUSER_WIDTH-1:0] s_axis_tuser,
    input s_axis_tvalid,
    output s_axis_tready,
    input s_axis_tlast
);

    integer f;
    integer bubble_count = 0;
    integer result;
    reg [8*2-1:0] terminal_flag;
    
    assign s_axis_tready = 1;
    
    initial begin
        f = $fopen(output_file, "w");
    end

    always @(posedge aclk) begin
        if (s_axis_tvalid == 1'b1) begin
            if (bubble_count != 0) begin
                $fwrite(f, "*%0d\n", bubble_count);
                bubble_count <= 0;
            end
            if (s_axis_tlast == 1'b1) begin
                terminal_flag = ".";
            end
            else begin
                terminal_flag = ",";
            end
            
            $fwrite(f, "%x, %x, %x%0s # %0d ns\n",
                              s_axis_tdata,
                              s_axis_tstrb,
                              s_axis_tuser,
                              terminal_flag,
                              $time
                              ); 
        end
        else begin
            bubble_count <= bubble_count + 1;
        end
    end
endmodule
