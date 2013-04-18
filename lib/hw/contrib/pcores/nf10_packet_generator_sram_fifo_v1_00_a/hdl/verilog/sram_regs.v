/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        encap_header_lookup.v
 *
 *  Library:
 *        hw/contrib/pcores/nf10_encap_v1_00_a
 *
 *  Module:
 *        nf10_encap
 *
 *  Author:
 *        Yilong Geng
 *
 *  Description:
 *        Add additional Ethernet and IP header if needed.
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

module sram_regs
  #(
    // Master AXI Lite Data Width
    parameter DATA_WIDTH=32,
    parameter ADDR_WIDTH=32
    )
   (

    output reg [18:0] base_addr_0,
    output reg [18:0] base_addr_1,
    output reg [18:0] base_addr_2,
    output reg [18:0] base_addr_3,
    output reg [18:0] bound_addr_0,
    output reg [18:0] bound_addr_1,
    output reg [18:0] bound_addr_2,
    output reg [18:0] bound_addr_3,
    input [18:0] tail_addr_0,
    input [18:0] tail_addr_1,
    input [18:0] tail_addr_2,
    input [18:0] tail_addr_3,
    output reg [31:0] replay_times, 
    output reg replay_begin,
    output reg host_reset,

    input                        ACLK,
    input                        ARESETN,
    
    input [ADDR_WIDTH-1: 0]      AWADDR,
    input                        AWVALID,
    output reg                   AWREADY,
    
    input [DATA_WIDTH-1: 0]      WDATA,
    input [DATA_WIDTH/8-1: 0]    WSTRB,
    input                        WVALID,
    output reg                   WREADY,
    
    output reg [1:0]             BRESP,
    output reg                   BVALID,
    input                        BREADY,
    
    input [ADDR_WIDTH-1: 0]      ARADDR,
    input                        ARVALID,
    output reg                   ARREADY,
    
    output reg [DATA_WIDTH-1: 0] RDATA, 
    output reg [1:0]             RRESP,
    output reg                   RVALID,
    input                        RREADY
    );

   localparam AXI_RESP_OK = 2'b00;
   localparam AXI_RESP_SLVERR = 2'b10;
   
   localparam WRITE_IDLE = 0;
   localparam WRITE_RESPONSE = 1;
   localparam WRITE_DATA = 2;

   localparam READ_IDLE = 0;
   localparam READ_RESPONSE = 1;

   localparam BASE_ADDR_0 = 8'h00;
   localparam BASE_ADDR_1 = 8'h01;
   localparam BASE_ADDR_2 = 8'h02;
   localparam BASE_ADDR_3 = 8'h03;

   localparam BOUND_ADDR_0 = 8'h10;
   localparam BOUND_ADDR_1 = 8'h11;
   localparam BOUND_ADDR_2 = 8'h12;
   localparam BOUND_ADDR_3 = 8'h13;

   localparam TAIL_ADDR_0 = 8'h20;
   localparam TAIL_ADDR_1 = 8'h21;
   localparam TAIL_ADDR_2 = 8'h22;
   localparam TAIL_ADDR_3 = 8'h23;

   localparam REPLAY_TIMES = 8'h30;
   localparam REPLAY_BEGIN = 8'h31;
   localparam HOST_RESET = 8'h32;

   reg [1:0]                     write_state, write_state_next;
   reg [1:0]                     read_state, read_state_next;
   reg [ADDR_WIDTH-1:0]          read_addr, read_addr_next;
   reg [ADDR_WIDTH-1:0]          write_addr, write_addr_next;
   reg [1:0]                     BRESP_next;

   reg [18:0] base_addr_next_0;
   reg [18:0] base_addr_next_1;
   reg [18:0] base_addr_next_2;
   reg [18:0] base_addr_next_3;
   reg [18:0] bound_addr_next_0;
   reg [18:0] bound_addr_next_1;
   reg [18:0] bound_addr_next_2;
   reg [18:0] bound_addr_next_3;
   reg [31:0] replay_times_next;
   reg replay_begin_next;
   reg host_reset_next;
   
   always @(*) begin
      read_state_next = read_state;   
      ARREADY = 1'b1;
      read_addr_next = read_addr;
      RDATA = 0; 
      RRESP = AXI_RESP_OK;
      RVALID = 1'b0;
      
      case(read_state)
        READ_IDLE: begin
           if(ARVALID) begin
              read_addr_next = ARADDR;
              read_state_next = READ_RESPONSE;
           end
        end        
        
        READ_RESPONSE: begin
           RVALID = 1'b1;
           ARREADY = 1'b0;

           if(read_addr[7:0] == BASE_ADDR_0) begin
              RDATA[18:0] = base_addr_0;
              RDATA[31:19] = 0;
           end
           else if(read_addr[7:0] == BASE_ADDR_1) begin
              RDATA[18:0] = base_addr_1;
              RDATA[31:19] = 0;
           end
           else if(read_addr[7:0] == BASE_ADDR_2) begin
              RDATA[18:0] = base_addr_2;
              RDATA[31:19] = 0;
           end
           else if(read_addr[7:0] == BASE_ADDR_3) begin
              RDATA[18:0] = base_addr_3;
              RDATA[31:19] = 0;
           end

           else if(read_addr[7:0] == BOUND_ADDR_0) begin
              RDATA[18:0] = bound_addr_0;
              RDATA[31:19] = 0;
           end
           else if(read_addr[7:0] == BOUND_ADDR_1) begin
              RDATA[18:0] = bound_addr_1;
              RDATA[31:19] = 0;
           end
           else if(read_addr[7:0] == BOUND_ADDR_2) begin
              RDATA[18:0] = bound_addr_2;
              RDATA[31:19] = 0;
           end
           else if(read_addr[7:0] == BOUND_ADDR_3) begin
              RDATA[18:0] = bound_addr_3;
              RDATA[31:19] = 0;
           end

           else if(read_addr[7:0] ==TAIL_ADDR_0) begin
              RDATA[18:0] = tail_addr_0;
              RDATA[31:19] = 0;
           end
           else if(read_addr[7:0] ==TAIL_ADDR_1) begin
              RDATA[18:0] = tail_addr_1;
              RDATA[31:19] = 0;
           end
           else if(read_addr[7:0] ==TAIL_ADDR_2) begin
              RDATA[18:0] = tail_addr_2;
              RDATA[31:19] = 0;
           end
           else if(read_addr[7:0] ==TAIL_ADDR_3) begin
              RDATA[18:0] = tail_addr_3;
              RDATA[31:19] = 0;
           end

           else if(read_addr[7:0] ==REPLAY_TIMES) begin
              RDATA[18:0] = replay_times;
           end

           else if(read_addr[7:0] ==REPLAY_BEGIN) begin
              RDATA[0] = replay_begin;
              RDATA[31:1] = 0;
           end

           else if(read_addr[7:0] ==HOST_RESET) begin
              RDATA[0] = host_reset;
              RDATA[31:1] = 0;
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

      AWREADY = 1'b1;
      WREADY = 1'b0;
      BVALID = 1'b0;  
      BRESP_next = BRESP;

      base_addr_next_0 = base_addr_0;
      base_addr_next_1 = base_addr_1;
      base_addr_next_2 = base_addr_2;
      base_addr_next_3 = base_addr_3;
      bound_addr_next_0 = bound_addr_0;
      bound_addr_next_1 = bound_addr_1;
      bound_addr_next_2 = bound_addr_2;
      bound_addr_next_3 = bound_addr_3;
      replay_times_next = replay_times;
      replay_begin_next = replay_begin;
      host_reset_next = host_reset;

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
              if(write_addr[7:0] == BASE_ADDR_0) begin
                 base_addr_next_0 = WDATA[18:0];
                 BRESP_next = AXI_RESP_OK;
              end
              else if(write_addr[7:0] == BASE_ADDR_1) begin
                 base_addr_next_1 = WDATA[18:0];
                 BRESP_next = AXI_RESP_OK;
              end
              else if(write_addr[7:0] == BASE_ADDR_2) begin
                 base_addr_next_2 = WDATA[18:0];
                 BRESP_next = AXI_RESP_OK;
              end
              else if(write_addr[7:0] == BASE_ADDR_3) begin
                 base_addr_next_3 = WDATA[18:0];
                 BRESP_next = AXI_RESP_OK;
              end

              else if(write_addr[7:0] == BOUND_ADDR_0) begin
                 base_addr_next_0 = WDATA[18:0];
                 BRESP_next = AXI_RESP_OK;
              end
              else if(write_addr[7:0] == BOUND_ADDR_1) begin
                 base_addr_next_1 = WDATA[18:0];
                 BRESP_next = AXI_RESP_OK;
              end
              else if(write_addr[7:0] == BOUND_ADDR_2) begin
                 base_addr_next_2 = WDATA[18:0];
                 BRESP_next = AXI_RESP_OK;
              end
              else if(write_addr[7:0] == BOUND_ADDR_3) begin
                 base_addr_next_3 = WDATA[18:0];
                 BRESP_next = AXI_RESP_OK;
              end

              else if(write_addr[7:0] == REPLAY_TIMES) begin
                 replay_times_next = WDATA;
                 BRESP_next = AXI_RESP_OK;
              end
              
              else if(write_addr[7:0] == REPLAY_BEGIN) begin
                 replay_begin_next = WDATA[0];
                 BRESP_next = AXI_RESP_OK;
              end

              else if(write_addr[7:0] == HOST_RESET) begin
                 host_reset_next = WDATA[0];
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

         base_addr_0 <= {2'd00, 17'b0};
         base_addr_1 <= {2'd01, 17'b0};
         base_addr_2 <= {2'd02, 17'b0};
         base_addr_3 <= {2'd03, 17'b0};

         bound_addr_0 <= {2'd01, 17'b0};
         bound_addr_1 <= {2'd02, 17'b0};
         bound_addr_2 <= {2'd03, 17'b0};
         bound_addr_3 <= {2'd00, 17'b0};

         replay_times <= 0;
         replay_begin <= 0;
         host_reset <= 0;

      end
      else begin
         write_state <= write_state_next;
         read_state <= read_state_next;
         read_addr <= read_addr_next;
         write_addr <= write_addr_next;
         BRESP <= BRESP_next;

         base_addr_0 <= base_addr_next_0;
         base_addr_1 <= base_addr_next_1;
         base_addr_2 <= base_addr_next_2;
         base_addr_3 <= base_addr_next_3;
         bound_addr_0 <= bound_addr_next_0;
         bound_addr_1 <= bound_addr_next_1;
         bound_addr_2 <= bound_addr_next_2;
         bound_addr_3 <= bound_addr_next_3;
         replay_times <= replay_times_next;
         replay_begin <= replay_begin_next;
         host_reset <= host_reset_next;

      end
   end

endmodule
