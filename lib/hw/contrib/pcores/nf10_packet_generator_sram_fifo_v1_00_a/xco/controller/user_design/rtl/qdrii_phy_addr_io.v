//*****************************************************************************
// DISCLAIMER OF LIABILITY
//
// This file contains proprietary and confidential information of
// Xilinx, Inc. ("Xilinx"), that is distributed under a license
// from Xilinx, and may be used, copied and/or disclosed only
// pursuant to the terms of a valid license agreement with Xilinx.
//
// XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION
// ("MATERIALS") "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
// EXPRESSED, IMPLIED, OR STATUTORY, INCLUDING WITHOUT
// LIMITATION, ANY WARRANTY WITH RESPECT TO NONINFRINGEMENT,
// MERCHANTABILITY OR FITNESS FOR ANY PARTICULAR PURPOSE. Xilinx
// does not warrant that functions included in the Materials will
// meet the requirements of Licensee, or that the operation of the
// Materials will be uninterrupted or error-free, or that defects
// in the Materials will be corrected. Furthermore, Xilinx does
// not warrant or make any representations regarding use, or the
// results of the use, of the Materials in terms of correctness,
// accuracy, reliability or otherwise.
//
// Xilinx products are not designed or intended to be fail-safe,
// or for use in any application requiring fail-safe performance,
// such as life-support or safety devices or systems, Class III
// medical devices, nuclear facilities, applications related to
// the deployment of airbags, or any other applications that could
// lead to death, personal injury or severe property or
// environmental damage (individually and collectively, "critical
// applications"). Customer assumes the sole risk and liability
// of any use of Xilinx products in critical applications,
// subject only to applicable laws and regulations governing
// limitations on product liability.
//
// Copyright 2006, 2007, 2008 Xilinx, Inc.
// All rights reserved.
//
// This disclaimer and copyright notice must be retained as part
// of this file at all times.
//*****************************************************************************
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor             : Xilinx
// \   \   \/     Version            : 3.6.1
//  \   \         Application        : MIG
//  /   /         Filename           : qdrii_phy_addr_io.v
// /___/   /\     Timestamp          : 15 May 2006
// \   \  /  \    Date Last Modified : $Date: 2010/11/26 18:26:06 $
//  \___\/\___\
//
//Device: Virtex-5
//Design: QDRII
//
//Purpose:
//    This module
//  1. Instantiates the I/O module for generating the addresses to the memory
//
//Revision History:
//
//*****************************************************************************

`timescale 1ns/1ps

module qdrii_phy_addr_io #
  (
   // Following parameters are for 72-bit design (for ML561 Reference board
   // design). Actual values may be different. Actual parameters values are
   // passed from design top module controller module. Please refer to the
   // controller module for actual values.
   parameter ADDR_WIDTH   = 19,
   parameter BURST_LENGTH = 4
   )
  (
   input                   clk180,
   input                   clk270,
   input                   user_rst_180,
   input                   user_rst_270,
   input                   wr_init_n,
   input                   rd_init_n,
   input [ADDR_WIDTH-1:0]  fifo_ad_wr,
   input [ADDR_WIDTH-1:0]  fifo_ad_rd,
   input [1:0]             dummy_write,
   input [1:0]             dummy_read,
   input                   cal_done,
   input                   rd_init_delay_n,
   output [ADDR_WIDTH-1:0] qdr_sa
   );

   reg [ADDR_WIDTH-1:0] address_int_ff;
   reg [ADDR_WIDTH-1:0] fifo_ad_wr_r;
   reg [ADDR_WIDTH-1:0] fifo_ad_rd_r;
   reg [ADDR_WIDTH-1:0] fifo_ad_wr_2r;
   reg [ADDR_WIDTH-1:0] fifo_ad_rd_2r;
   reg [ADDR_WIDTH-1:0] fifo_ad_wr_3r;
   reg [ADDR_WIDTH-1:0] fifo_ad_rd_3r;
   reg                  wr_init_n_r;
   reg                  rd_init_n_r;
   reg [1:0]            dummy_write_r;
   reg [1:0]            dummy_read_r;

   wire [ADDR_WIDTH-1:0] qdr_sa_int;

   always @ (posedge clk270)
   begin
     fifo_ad_wr_r <= fifo_ad_wr;
     fifo_ad_rd_r <= fifo_ad_rd;
   end

   generate
     // For BL4 address is SDR
     if(BURST_LENGTH == 4) begin : BL4_INST
       always @ (posedge clk270)
         begin
//            if (user_rst_270 ||~cal_done )
            if (~cal_done )
              address_int_ff <= 'b0;
            else if (rd_init_delay_n)
              address_int_ff <= fifo_ad_wr_r;
            else
              address_int_ff <= fifo_ad_rd_r;
         end
     end else begin : BL2_INST
     // For BL2 address is DDR. A read command by the controller is associated
     // with read address bits and write command by the controller is associated
     // with write address bits on to the IO bus. Absence of any commands is
     // associated with address bits on IO bus tied to logic 0.
//       always @ (posedge clk270)
//       begin
//         if(user_rst_270)begin
//           wr_init_n_r <= 'b0;
//           rd_init_n_r <= 'b0;
//         end else begin
//           wr_init_n_r <= wr_init_n;
//           rd_init_n_r <= rd_init_n;
//         end
//       end

       always @ (posedge clk270)
       begin
         wr_init_n_r <= wr_init_n;
         rd_init_n_r <= rd_init_n;
       end

       always @ (posedge clk270)
       begin
         dummy_write_r <= dummy_write;
         dummy_read_r  <= dummy_read;
       end

       always @ (posedge clk270)
       begin
         if((BURST_LENGTH == 2) && (dummy_write_r == 2'b11))
           fifo_ad_wr_2r <= {{ADDR_WIDTH-1{1'b0}}, 1'b1};
         else if((BURST_LENGTH == 2) && (dummy_read_r == 2'b10))
           fifo_ad_rd_2r <= {{ADDR_WIDTH-1{1'b0}}, 1'b1};
         else if (!wr_init_n_r | !rd_init_n_r)begin
           fifo_ad_wr_2r <= fifo_ad_wr_r;
           fifo_ad_rd_2r <= fifo_ad_rd_r;
         end else begin
           fifo_ad_wr_2r <= 'b0;
           fifo_ad_rd_2r <= 'b0;
         end
       end

       always @ (posedge clk270)
       begin
         fifo_ad_rd_3r  <= fifo_ad_rd_2r;
         fifo_ad_wr_3r  <= fifo_ad_wr_2r;
       end
     end
   endgenerate

   genvar aw_i;
   generate
      // For BL2 address is DDR. write address is associated with falling edge
      // of K clock. Read address is associated with rising edge of K clock.
      if(BURST_LENGTH == 2) begin : BL2_IOB_INST
        for(aw_i=0; aw_i < ADDR_WIDTH; aw_i=aw_i+1) begin : ADDR_INST
          ODDR #
            (
             .DDR_CLK_EDGE ( "SAME_EDGE" )
             )
            ODDR_QDR_SA
              (
               .Q  (qdr_sa_int[aw_i]),
               .C  (clk270),
               .CE (1'b1),
               .D1 (fifo_ad_rd_3r[aw_i]),
               .D2 (fifo_ad_wr_3r[aw_i]),
               .R  (1'b0),
               .S  (1'b0)
               );
        end
      end else begin : BL4_IOB_INST
        // For BL4 address is SDR. Read or Write address is always associated
        // with rising edge of K clock.
        for(aw_i=0; aw_i < ADDR_WIDTH; aw_i=aw_i+1) begin : ADDR_INST
          (* IOB = "FORCE" *) FDRSE #
            (
             .INIT(1'b0)
             )
            ADDRESS_FF
              (
               .Q  ( qdr_sa_int[aw_i] ),
               .C  ( clk180 ),
               .CE ( 1'b1 ),
               .D  ( address_int_ff[aw_i] ),
               .R  ( 1'b0 ),
               .S  ( 1'b0 )
               )/* synthesis syn_useioff = 1 */;
        end
      end
   endgenerate

   genvar aw_ii;
   generate
      for(aw_ii=0; aw_ii < ADDR_WIDTH; aw_ii=aw_ii+1) begin : OBUF_INST
        // output buffers for SA bus
        OBUF IO_FF
          (
           .I ( qdr_sa_int[aw_ii] ),
           .O ( qdr_sa[aw_ii] )
           );
      end
   endgenerate

endmodule