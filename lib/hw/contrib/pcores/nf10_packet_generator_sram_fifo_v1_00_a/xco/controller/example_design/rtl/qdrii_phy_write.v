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
//  /   /         Filename           : qdrii_phy_write.v
// /___/   /\     Timestamp          : 15 May 2006
// \   \  /  \    Date Last Modified : $Date: 2010/11/26 18:26:07 $
//  \___\/\___\
//
//Device: Virtex-5
//Design: QDRII
//
//Purpose:
//    This module
//  1. Is the top level module for write data and commands
//  2. Instantiates the I/O modules for the memory write data, as well as
//     for the write command.
//
//Revision History:
//
//*****************************************************************************

`timescale 1ns/1ps

module qdrii_phy_write #
  (
   // Following parameters are for 72-bit design (for ML561 Reference board
   // design). Actual values may be different. Actual parameters values are
   // passed from design top module controller module. Please refer to the
   // controller module for actual values.
   parameter BURST_LENGTH = 4,
   parameter BW_WIDTH     = 8,
   parameter DATA_WIDTH   = 72
   )
  (
   input                       clk0,
   input                       clk180,
   input                       clk270,
   input                       user_rst_0,
   input                       user_rst_180,
   input                       user_rst_270,
   input [BW_WIDTH-1:0]        fifo_bw_h,
   input [BW_WIDTH-1:0]        fifo_bw_l,
   input [DATA_WIDTH-1:0]      fifo_dwh,
   input [DATA_WIDTH-1:0]      fifo_dwl,
   input [1:0]                 dummy_wr,
   input                       wr_init_n,
   output                      wr_init2_n,
   output [BW_WIDTH-1:0]       qdr_bw_n,
   output [DATA_WIDTH-1:0]     qdr_d,
   output                      qdr_w_n,
   output reg [DATA_WIDTH-1:0] dummy_wrl,
   output reg [DATA_WIDTH-1:0] dummy_wrh,
   output reg                  dummy_wren
   );

   localparam [5:0] IDLE    = 6'b000001,
                    WR_1    = 6'b000010,
                    WR_2    = 6'b000100,
                    WR_3    = 6'b001000,
                    WR_4    = 6'b010000,
                    WR_DONE = 6'b100000;

   localparam [8:0] PATTERN_A = 9'h1FF,
                    PATTERN_B = 9'h000,
                    PATTERN_C = 9'h155,
                    PATTERN_D = 9'h0AA;

   reg                  d_wr_en;
   reg [5:0]            Next_datagen_st;
   reg [BW_WIDTH-1:0]   bwl_int;
   reg [BW_WIDTH-1:0]   bwh_int;
   reg [DATA_WIDTH-1:0] dwl_int;
   reg [DATA_WIDTH-1:0] dwh_int;
   reg [DATA_WIDTH-1:0] dummy_write_l/* synthesis syn_preserve=1 */;
   reg [DATA_WIDTH-1:0] dummy_write_h/* synthesis syn_preserve=1 */;

   wire wr_init_delay_n;
   wire wr_init_delay2_n;
   wire wr_init_delay3_n;
   wire qdr_w_n_int;
   wire wr_cmd_in;
   wire wr_fifo_rden_1;
   wire wr_fifo_rden_2;
   wire wr_init2_n_1;

   // For Calibration purpose, a sequence of pattern datas are written in to
   // Write Data FIFOs.
   // For BL4, a pattern of F-0, F-0, F-0, A-5 are written into Write Data FIFOs.
   // For BL2, a pattern of F-0, F-0, A-5 are written into Write Data FIFOs.
   always @ (posedge clk0)
     begin
        if (user_rst_0) begin
           dummy_write_h   <= {DATA_WIDTH{1'b0}};
           dummy_write_l   <= {DATA_WIDTH{1'b0}};
           d_wr_en         <= 1'b0;
           Next_datagen_st <= IDLE;
        end else begin
           case (Next_datagen_st)
             IDLE : begin
                dummy_write_h   <= {DATA_WIDTH{1'b0}};
                dummy_write_l   <= {DATA_WIDTH{1'b0}};
                d_wr_en         <= 1'b0;
                Next_datagen_st <= WR_1;
             end

             WR_1 : begin
                dummy_write_h   <= {BW_WIDTH{PATTERN_A}};
                dummy_write_l   <= {BW_WIDTH{PATTERN_B}};
                d_wr_en         <= 1'b1;
                if(BURST_LENGTH == 2)
                  Next_datagen_st <= WR_3;
                else if(BURST_LENGTH == 4)
                  Next_datagen_st <= WR_2;
             end

             WR_2 : begin
                dummy_write_h   <= {BW_WIDTH{PATTERN_A}};
                dummy_write_l   <= {BW_WIDTH{PATTERN_B}};
                d_wr_en         <= 1'b0;
                Next_datagen_st <= WR_3;
             end

             WR_3 : begin
                dummy_write_h   <= {BW_WIDTH{PATTERN_A}};
                dummy_write_l   <= {BW_WIDTH{PATTERN_B}};
                d_wr_en         <= 1'b1;
                Next_datagen_st <= WR_4;
             end

             WR_4 : begin
                dummy_write_h   <= {BW_WIDTH{PATTERN_C}};
                dummy_write_l   <= {BW_WIDTH{PATTERN_D}};
                if(BURST_LENGTH == 2)
                  d_wr_en       <= 1'b1;
                else if(BURST_LENGTH == 4)
                  d_wr_en       <= 1'b0;
                Next_datagen_st <= WR_DONE;
             end

             WR_DONE : begin
                dummy_write_h   <= {DATA_WIDTH{1'b0}};
                dummy_write_l   <= {DATA_WIDTH{1'b0}};
                d_wr_en         <= 1'b0;
                Next_datagen_st <= WR_DONE;
             end
           endcase
        end
     end

    always @ (posedge clk0)
     begin
        dummy_wrl  <= dummy_write_l;
        dummy_wrh  <= dummy_write_h;
        dummy_wren <= d_wr_en;
     end

   // Generate Byte Write Logic
   always @ (posedge clk270)
     begin
        if(!wr_init2_n_1)begin
           bwh_int <= fifo_bw_h;
           bwl_int <= fifo_bw_l;
        end else begin
           bwh_int <= 'b0;
           bwl_int <= 'b0;
        end
     end

   genvar bw_i;
   generate
      for(bw_i= 0; bw_i < BW_WIDTH ; bw_i = bw_i+1)
        begin:BW_INST
           qdrii_phy_bw_io U_QDRII_PHY_BW_IO
             (
              .clk270   ( clk270 ),
              .bwl      ( bwl_int[bw_i] ),
              .bwh      ( bwh_int[bw_i] ),
              .qdr_bw_n ( qdr_bw_n[bw_i] )
              );
        end
   endgenerate

   assign wr_cmd_in = ~(~wr_init_n || dummy_wr[1] || dummy_wr[0] ) ;

   // Generate Write Burst Logic
   always @(posedge clk270 )
     begin
        if(!wr_init2_n_1) begin
           dwh_int <= fifo_dwh;
           dwl_int <= fifo_dwl;
        end else begin
           dwl_int <= 'b0;
           dwh_int <= 'b0;
        end
     end

   /////////////////////////////////////////////////////////////////////////////
   // QDR D IO instantiations
   /////////////////////////////////////////////////////////////////////////////

   genvar d_i;
   generate
      for(d_i= 0; d_i < DATA_WIDTH ; d_i = d_i+1)
        begin:D_INST
           qdrii_phy_d_io U_QDRII_PHY_D_IO
             (
              .clk270 ( clk270 ),
              .dwl    ( dwl_int[d_i] ),
              .dwh    ( dwh_int[d_i] ),
              .qdr_d  ( qdr_d[d_i] )
              );
        end
   endgenerate


   // Generate write data fifo rden
   FDRSE #
     (
      .INIT(1'b1)
      )
     WR_FIFO_RDEN_FF1
       (
        .Q  ( wr_fifo_rden_1 ),
        .C  ( clk270 ),
        .CE ( 1'b1 ),
        .D  ( wr_cmd_in ),
        .R  ( 1'b0 ),
        .S  ( 1'b0 )
        );

   FDRSE #
     (
      .INIT(1'b1)
      )
     WR_FIFO_RDEN_FF2
       (
        .Q  ( wr_fifo_rden_2 ),
        .C  ( clk270 ),
        .CE ( 1'b1 ),
        .D  ( wr_fifo_rden_1 ),
        .R  ( 1'b0 ),
        .S  ( 1'b0 )
        );

   // A single Write Command is expanded for two clock cycles for BL4, so that
   // two sets of Write Datas can be read from Write Data FIFOs. For BL2 only
   // one set of Write Datas can be read form Write Data FIFOs.
   assign wr_init2_n = (BURST_LENGTH == 4) ? (wr_fifo_rden_1 & wr_fifo_rden_2 ) :
                                              wr_fifo_rden_1;

   FDRSE #
     (
      .INIT(1'b0)
      )
     WR_INIT2_N_FF
       (
        .Q  ( wr_init2_n_1 ),
        .C  ( clk270 ),
        .CE ( 1'b1 ),
        .D  ( wr_init2_n ),
        .R  ( 1'b0 ),
        .S  ( 1'b0 )
        );

   // Generate QDR_W_n logic
   FDRSE #
     (
      .INIT(1'b1)
      )
     WR_INIT_FF1
       (
        .Q  ( wr_init_delay_n ),
        .C  ( clk270 ),
        .CE ( 1'b1 ),
        .D  ( wr_cmd_in ),
        .R  ( 1'b0 ),
        .S  ( 1'b0 )
        );

   FDRSE #
     (
      .INIT(1'b1)
      )
     WR_INIT_FF2
       (
        .Q  ( wr_init_delay2_n ),
        .C  ( clk180 ),
        .CE ( 1'b1 ),
        .D  ( wr_init_delay_n ),
        .R  ( 1'b0 ),
        .S  ( 1'b0 )
        );

   generate
     if(BURST_LENGTH == 4) begin : BL4_INST
       (* IOB = "FORCE" *) FDCPE #
         (
          .INIT(1'b1)
          )
         WR_INIT_FF3
           (
            .Q   ( qdr_w_n_int ),
            .C   ( clk180 ),
            .CE  ( 1'b1 ),
            .D   ( wr_init_delay2_n ),
            .CLR ( 1'b0 ),
            .PRE ( user_rst_180 )
            )/* synthesis syn_useioff = 1 */;
     end
     else begin : BL2_INST
       FDRSE #
         (
          .INIT(1'b1)
          )
         WR_INIT_FF3
           (
            .Q  ( wr_init_delay3_n ),
            .C  ( clk180 ),
            .CE ( 1'b1 ),
            .D  ( wr_init_delay2_n ),
            .R  ( 1'b0 ),
            .S  ( 1'b0 )
            );

       (* IOB = "FORCE" *) FDCPE #
         (
          .INIT(1'b1)
          )
         WR_INIT_FF4
           (
            .Q   ( qdr_w_n_int ),
            .C   ( clk180 ),
            .CE  ( 1'b1 ),
            .D   ( wr_init_delay3_n ),
            .CLR ( 1'b0 ),
            .PRE ( user_rst_180 )
            )/* synthesis syn_useioff = 1 */;

     end
   endgenerate

   OBUF qdr_w_n_obuf
     (
      .I ( qdr_w_n_int ),
      .O ( qdr_w_n )
      );

endmodule