/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        s_counter.v
 *
 *  Module:
 *        openflow_datapath
 *
 *  Author:
 *        Tatsuya Yabe
 *
 *  Description:
 *        Outputs us, ms and sec
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

`timescale 1ns / 1ps
`include "registers.v"

module s_counter
#(
    // asclk frequency
    parameter CLOCK_CYCLE_MHZ=160
)
(
   // AXI ports
   input  asclk,
   input  aresetn,

   output reg [`OPENFLOW_LAST_SEEN_WIDTH-1:0] s_counter,
   output reg [9:0] ms_counter,
   output reg [9:0] us_counter
);

   //------------------------ Wires/Regs -----------------------------

   reg [9:0] mhz_counter;

   //--------------------------- Logic -------------------------------

   always @(posedge asclk) begin
      if (~aresetn) begin
         mhz_counter <= 0;
         us_counter <= 0;
         ms_counter <= 0;
         s_counter <= 0;
      end
      else begin
         if (mhz_counter >= CLOCK_CYCLE_MHZ -1) begin
            mhz_counter <= 0;
            if (us_counter >= 999) begin
               us_counter <= 0;
               if (ms_counter >= 999) begin
                  ms_counter <= 0;
                  if (s_counter >=
                      (1'b1 << (`OPENFLOW_LAST_SEEN_WIDTH+1)) - 1) begin
                     s_counter <= 0;
                  end
                  else begin
                     s_counter <= s_counter + 1;
                  end
               end
               else begin
                  ms_counter <= ms_counter + 1;
               end
            end
            else begin
               us_counter <= us_counter + 1;
            end
         end
         else begin
            mhz_counter <= mhz_counter + 1;
         end
      end
   end

endmodule
