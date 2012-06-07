/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        openflow_cam.v
 *
 *  Module:
 *        openflow_datapath
 *
 *  Author:
 *        Tatsuya Yabe
 *
 *  Description:
 *        It creates specified width and depth of TCAM
 *        and oupputs unencoded hit addresses.
 *        If multiple row has been hit, it presents all the
 *        hit positions.
 *        It consumes two clock sycles.
 *
 *  Copyright notice:
 *        Copyright (C) 2010, 2011, 2012 The Board of Trustees of The Leland
 *                                 Stanford Junior University
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

`timescale 1 ns / 1ps
`include "registers.v"

module openflow_cam
#(
   parameter OPENFLOW_WILDCARD_TABLE_SIZE = 32, // Num of entries
   parameter OPENFLOW_MATCH_SIZE = 256,
   parameter LUT_DEPTH_BITS = 5
)
(
   output busy,
   output match,
   output [OPENFLOW_WILDCARD_TABLE_SIZE-1:0] match_addr,

   input [OPENFLOW_MATCH_SIZE-1:0] din,
   input [OPENFLOW_MATCH_SIZE-1:0] data_mask,

   input [OPENFLOW_MATCH_SIZE-1:0] cmp_din,
   input [OPENFLOW_MATCH_SIZE-1:0] cmp_data_mask,

   input [LUT_DEPTH_BITS-1:0] wr_addr,
   input we,

   input aresetn,
   input clk
);

   //-------------------- Internal Parameters ------------------------

   localparam WILDCARD_NUM_DATA_WORDS_USED = 32; //Data width per cam
   localparam WILDCARD_NUM_CMP_WORDS_USED  =
              OPENFLOW_MATCH_SIZE/WILDCARD_NUM_DATA_WORDS_USED;

   //---------------------- Wires and regs----------------------------

   wire [WILDCARD_NUM_CMP_WORDS_USED-1:0] busy_ind;
   wire [WILDCARD_NUM_CMP_WORDS_USED-1:0]
      match_addr_ind[OPENFLOW_WILDCARD_TABLE_SIZE-1:0];
   wire [WILDCARD_NUM_DATA_WORDS_USED-1:0] cmp_din_ind[WILDCARD_NUM_CMP_WORDS_USED-1:0];
   wire [WILDCARD_NUM_DATA_WORDS_USED-1:0] cmp_data_mask_ind[WILDCARD_NUM_CMP_WORDS_USED-1:0];
   wire [WILDCARD_NUM_DATA_WORDS_USED-1:0] din_ind[WILDCARD_NUM_CMP_WORDS_USED-1:0];
   wire [WILDCARD_NUM_DATA_WORDS_USED-1:0] data_mask_ind[WILDCARD_NUM_CMP_WORDS_USED-1:0];
   //-------------------------- Logic --------------------------------

   /* Split up the CAM into multiple smaller CAMs to improve timing */

   generate
      genvar ii,j;
      for (ii=0; ii<WILDCARD_NUM_CMP_WORDS_USED; ii=ii+1) begin:gen_cams
         wire [OPENFLOW_WILDCARD_TABLE_SIZE-1:0] match_addr_temp;
         cam cam_primitive // Datawidth 32, Depth 32
           (
            // Outputs
            .BUSY                             (busy_ind[ii]),
            .MATCH                            (),
            .MATCH_ADDR                       (match_addr_temp),
            // Inputs
            .CLK                              (clk),
            .CMP_DIN                          (cmp_din_ind[ii]),
            .DIN                              (din_ind[ii]),
            .CMP_DATA_MASK                    (cmp_data_mask_ind[ii]),
            .DATA_MASK                        (data_mask_ind[ii]),
            .WE                               (we),
            .WR_ADDR                          (wr_addr)
            );
         if (ii < WILDCARD_NUM_CMP_WORDS_USED - 1) begin
            assign cmp_din_ind[ii] = cmp_din[WILDCARD_NUM_DATA_WORDS_USED*ii + (WILDCARD_NUM_DATA_WORDS_USED-1): WILDCARD_NUM_DATA_WORDS_USED*ii];
            assign din_ind[ii] = din[WILDCARD_NUM_DATA_WORDS_USED*ii + (WILDCARD_NUM_DATA_WORDS_USED-1): WILDCARD_NUM_DATA_WORDS_USED*ii];
            assign cmp_data_mask_ind[ii] = cmp_data_mask[WILDCARD_NUM_DATA_WORDS_USED*ii + (WILDCARD_NUM_DATA_WORDS_USED-1): WILDCARD_NUM_DATA_WORDS_USED*ii];
            assign data_mask_ind[ii] = data_mask[WILDCARD_NUM_DATA_WORDS_USED*ii + (WILDCARD_NUM_DATA_WORDS_USED-1): WILDCARD_NUM_DATA_WORDS_USED*ii];
         end
         else begin
            assign cmp_din_ind[ii] = cmp_din[OPENFLOW_MATCH_SIZE-1: WILDCARD_NUM_DATA_WORDS_USED*ii];
            assign din_ind[ii] = din[OPENFLOW_MATCH_SIZE-1: WILDCARD_NUM_DATA_WORDS_USED*ii];
            assign cmp_data_mask_ind[ii] =
                      cmp_data_mask[OPENFLOW_MATCH_SIZE-1: WILDCARD_NUM_DATA_WORDS_USED*ii];
            assign data_mask_ind[ii] =
                      data_mask[OPENFLOW_MATCH_SIZE-1: WILDCARD_NUM_DATA_WORDS_USED*ii];
         end // else: !if (ii < WILDCARD_NUM_CMP_WORDS_USED - 1)
         for (j=0; j<OPENFLOW_WILDCARD_TABLE_SIZE; j=j+1) begin:gen_addr_mem
            assign match_addr_ind[j][ii] = match_addr_temp[j];
         end

      end // block: gen_cams
      for (ii=0; ii<OPENFLOW_WILDCARD_TABLE_SIZE; ii=ii+1) begin:gen_addr
         assign match_addr[ii] = &match_addr_ind[ii];
      end
   endgenerate

   assign busy  = |busy_ind;
   assign match = |match_addr;

endmodule // openflow_cam
