/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        axi4_lite_regs.v
 *
 *  Library:
 *        hw/std/pcores/nf10_axis_gen_check_v1_00_a
 *
 *  Author:
 *        Michaela Blott
 *
 *  Description:
 *        AXI4-Lite for registers
 *
 *  Copyright notice:
 *        Copyright (C) 2010, 2011 Xilinx, Inc.
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

module axi4_lite_regs
#(
    // Master AXI Stream Data Width
    parameter DATA_WIDTH=32,
    parameter ADDR_WIDTH=32
)
(
   input  ACLK,
   input  ARESETN,

   input  [ADDR_WIDTH-1: 0] AWADDR,
   input  AWVALID,
   output reg AWREADY,

   input  [DATA_WIDTH-1: 0]   WDATA,
   input  [DATA_WIDTH/8-1: 0] WSTRB,
   input  WVALID,
   output reg WREADY,

   output reg [1:0] BRESP,
   output reg BVALID,
   input  BREADY,

   input  [ADDR_WIDTH-1: 0] ARADDR,
   input  ARVALID,
   output reg ARREADY,

   output reg [DATA_WIDTH-1: 0] RDATA,
   output reg [1:0] RRESP,
   output reg RVALID,
   input  RREADY,

   input  [31:0] tx_count,
   input  [31:0] rx_count,
   input  [31:0] err_count,
   output reg       count_reset,
   input         AXIS_ACLK
);

    localparam AXI_RESP_OK = 2'b00;
    localparam AXI_RESP_SLVERR = 2'b10;

    localparam WRITE_IDLE = 0;
    localparam WRITE_RESPONSE = 1;
    localparam WRITE_DATA = 2;

    localparam READ_IDLE = 0;
    localparam READ_RESPONSE = 1;
    localparam READ_WAIT = 2;

    localparam REG_TX_COUNT = 2'h0;
    localparam REG_RX_COUNT = 2'h1;
    localparam REG_ERR_COUNT = 2'h2;
    localparam REG_COUNT_RESET = 2'h3;

    reg [31:0] tx_count_r_2, tx_count_r;
    reg [31:0] rx_count_r_2, rx_count_r;
    reg [31:0] err_count_r_2, err_count_r;
    reg        count_reset_control_next, count_reset_control;
    reg        count_reset_r_2, count_reset_r;
    // synthesis attribute ASYNC_REG of tx_count_r is "TRUE";
    // synthesis attribute ASYNC_REG of rx_count_r is "TRUE";
    // synthesis attribute ASYNC_REG of err_count_r is "TRUE";
    // synthesis attribute ASYNC_REG of count_reset_r_2 is "TRUE";

    reg [1:0] write_state, write_state_next;
    reg [1:0] read_state, read_state_next;
    reg [ADDR_WIDTH-1:0] read_addr, read_addr_next;
    reg [ADDR_WIDTH-1:0] write_addr, write_addr_next;
    reg [2:0] counter, counter_next;
    reg [1:0] BRESP_next;
    localparam WAIT_COUNT = 2;

    always @(*) begin
        read_state_next = read_state;
        ARREADY = 1'b1;
        read_addr_next = read_addr;
        counter_next = counter;
        RDATA = 0;
        RRESP = AXI_RESP_OK;
        RVALID = 1'b0;

        case(read_state)
            READ_IDLE: begin
                counter_next = 0;
                if(ARVALID) begin
                    read_addr_next = ARADDR;
                    read_state_next = READ_WAIT;
                end
            end

            READ_WAIT: begin
                counter_next = counter + 1;
                ARREADY = 1'b0;
                if(counter == WAIT_COUNT)
                    read_state_next = READ_RESPONSE;
            end

            READ_RESPONSE: begin
                RVALID = 1'b1;
                ARREADY = 1'b0;

                if(read_addr[1:0] == REG_TX_COUNT) begin
                    RDATA = tx_count_r_2;
                end
                else if(read_addr[1:0] == REG_RX_COUNT) begin
                    RDATA = rx_count_r_2;
                end
                else if(read_addr[1:0] == REG_ERR_COUNT) begin
                    RDATA = err_count_r_2;
                end
                else begin
                    RRESP = AXI_RESP_SLVERR;
                end
                if(RREADY) begin
                    read_state_next = READ_IDLE;
                end
            end
        endcase
    end

    always @(*) begin
        write_state_next = write_state;
        write_addr_next = write_addr;
        count_reset_control_next = count_reset_control;
        AWREADY = 1'b1;
        WREADY = 1'b0;
        BVALID = 1'b0;
        BRESP_next = BRESP;

        case(write_state)
            WRITE_IDLE: begin
                write_addr_next = AWADDR;
                if(AWVALID) begin
                    write_state_next = WRITE_DATA;
                end
            end
            WRITE_DATA: begin
                AWREADY = 1'b0;
                WREADY = 1'b1;
                if(WVALID) begin
                    if (write_addr[1:0] == REG_COUNT_RESET) begin
                        count_reset_control_next = WDATA;
                        BRESP_next = AXI_RESP_OK;
                    end
                    else begin
                        BRESP_next = AXI_RESP_SLVERR;
                    end
                    write_state_next = WRITE_RESPONSE;
                end
            end
            WRITE_RESPONSE: begin
                AWREADY = 1'b0;
                BVALID = 1'b1;
                if(BREADY) begin
                    write_state_next = WRITE_IDLE;
                end
            end
        endcase
    end

    always @(posedge ACLK) begin
        if(~ARESETN) begin
            write_state <= WRITE_IDLE;
            read_state <= READ_IDLE;
            read_addr <= 0;
            write_addr <= 0;
            BRESP <= AXI_RESP_OK;
            count_reset_control <= 0;
        end
        else begin
            write_state <= write_state_next;
            read_state <= read_state_next;
            read_addr <= read_addr_next;
            write_addr <= write_addr_next;
            BRESP <= BRESP_next;
            count_reset_control <= count_reset_control_next;
        end

        rx_count_r_2 <= rx_count_r;
        tx_count_r_2 <= tx_count_r;
        err_count_r_2 <= err_count_r;
        count_reset_r <= count_reset_control;

        rx_count_r <= rx_count;
        tx_count_r <= tx_count;
        err_count_r <= err_count;

        counter <= counter_next;
    end

    always @(AXIS_ACLK) begin
        count_reset <= count_reset_r_2;
        count_reset_r_2 <= count_reset_r;
    end

endmodule
