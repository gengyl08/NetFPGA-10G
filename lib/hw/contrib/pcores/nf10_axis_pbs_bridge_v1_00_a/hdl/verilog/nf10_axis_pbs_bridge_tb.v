/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        nf10_axis_pbs_bridge_tb.v
 *
 *  Library:
 *        hw/contrib/pcores/nf10_axis_pbs_bridge_v1_00_a
 *
 *  Module:
 *        testbench
 *
 *  Author:
 *        Gianni Antichi, Muhammad Shahbaz
 *
 *  Description:
 *        Testbench 
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

`timescale 1 ns / 1ps
module testbench();

    reg clk, reset;
    reg [63:0]   tdata;
    reg [7:0]    tstrb;
    reg          tvalid;
    reg          tlast;
    wire         tready;
    wire [127:0] tuser = 128'hCAFEBEEFDEADCAFE;

    integer i;

// AXIS to PBS test

    wire [63:0] header_word_0 = 64'hEFBEFECAFECAFECA; // Destination MAC
    wire [63:0] header_word_1 = 64'h00000008EFBEEFBE; // Source MAC + EtherType

    localparam HEADER_0 = 0;
    localparam HEADER_1 = 1;
    localparam PAYLOAD  = 2;
    localparam DEAD     = 3;

    reg [2:0] state, state_next;
    reg [7:0] counter, counter_next;

    always @(*) begin
        state_next = state;
        tdata = 64'b0;
        tstrb = 8'hFF;
        tlast = 1'b0;
        tvalid = 1'b0;
        counter_next = counter;
        
        case(state)
            HEADER_0: begin
                tvalid = 1'b1;
                tdata = header_word_0;
                tstrb = 8'hFF;
                if(tready) begin
                    state_next = HEADER_1;
                end
            end
            HEADER_1: begin
                tvalid = 1'b1;
                tdata = header_word_1;
                tstrb = 8'hFF;
                if(tready) begin
                    state_next = PAYLOAD;
                end
            end
            PAYLOAD: begin
	        tvalid = 1'b1;
                tdata = {8{counter}};
                tstrb = 8'hFF;
                if(tready) begin
                    counter_next = counter + 1'b1;
                    if(counter == 8'hD) begin
                        tstrb = 8'hFF;
                        state_next = DEAD;
                        counter_next = 8'b0;
                        tlast = 1'b1;
                    end
                end
            end

            DEAD: begin
                counter_next = counter + 1'b1;
                tlast = 1'b0;
                if(counter[7]==1'b1) begin
                    counter_next = 8'b0;
                    state_next = HEADER_0;
                end
            end
        endcase
    end

    always @(posedge clk) begin
        if(reset) begin
            state <= HEADER_0;
            counter <= 8'b0;
        end
        else begin
            state <= state_next;
            counter <= counter_next;
        end
    end


// PBS to AXIS test

    reg [63:0]   pdata;
    reg [7:0]    pctrl;
    reg          pwr;
    wire         prdy;

    wire [63:0] pheader_word_0 = 64'hCAFEBEEFDEADCAFE;
    wire [63:0] pheader_word_1 = 64'hEFBEFECAFECAFECA; // Destination MAC
    wire [63:0] pheader_word_2 = 64'h00000008EFBEEFBE; // Source MAC + EtherType

    localparam PHEADER_0 = 0;
    localparam PHEADER_1 = 1;
    localparam PHEADER_2 = 2;
    localparam PPAYLOAD  = 3;
    localparam PDEAD     = 4;

    reg [2:0] pstate, pstate_next;
    reg [7:0] pcounter, pcounter_next;

    always @(*) begin
        pstate_next = pstate;
        pdata = 64'b0;
        pctrl = 8'h00;
        pwr = 1'b0;
        pcounter_next = pcounter;
        
        case(pstate)
            PHEADER_0: begin
                if (prdy) begin
                   pwr = 1'b1;
                   pdata = pheader_word_0;
                   pctrl = 8'hFF;
                   pstate_next = PHEADER_1;
                end
            end
            PHEADER_1: begin
                if (prdy) begin
                   pwr = 1'b1;
                   pdata = pheader_word_1;
                   pctrl = 8'h00;
                   pstate_next = PHEADER_2;
                end
            end
	    PHEADER_2: begin
                if (prdy) begin
                   pwr = 1'b1;
                   pdata = pheader_word_2;
                   pctrl = 8'h00;
                   pstate_next = PPAYLOAD;
                end
            end
            PPAYLOAD: begin
                if (prdy) begin
	           pwr = 1'b1;
                   pdata = {8{pcounter}};
                   pctrl = 8'h00;
                   pcounter_next = pcounter + 1'b1;
                   
                   if(pcounter == 8'hD) begin
                       pctrl = 8'h01;
                       pstate_next = PDEAD;
                       pcounter_next = 8'b0;
                   end
                end
            end

            PDEAD: begin
                pcounter_next = pcounter + 1'b1;
                if(pcounter[7]==1'b1) begin
                    pcounter_next = 8'b0;
                    pstate_next = PHEADER_0;
                end
            end
        endcase
    end

    always @(posedge clk) begin
        if(reset) begin
            pstate <= PHEADER_0;
            pcounter <= 8'b0;
        end
        else begin
            pstate <= pstate_next;
            pcounter <= pcounter_next;
        end
    end

// Clock and Reset
    
  initial begin
      clk   = 1'b0;

      $display("[%t] : System Reset Asserted...", $realtime);
      reset = 1'b1;
      for (i = 0; i < 50; i = i + 1) begin
                 @(posedge clk);
      end
      $display("[%t] : System Reset De-asserted...", $realtime);
      reset = 1'b0;
  end

  always #2.5  clk = ~clk;      // 200MHz


nf10_axis_pbs_bridge
#(
      .C_S_AXIS_TDATA_WIDTH ( 64 ),
      .C_M_AXIS_TDATA_WIDTH ( 64 ),
      .C_M_AXIS_TUSER_WIDTH ( 128 ),
      .C_S_AXIS_TUSER_WIDTH ( 128 ),
      .C_S_PBS_DATA_WIDTH   ( 64  ),
      .C_M_PBS_DATA_WIDTH   ( 64  )
) DUT
(
      .ACLK                 (clk),
      .ARESETN              (~reset),
      
      .M_AXIS_TSTRB         (),
      .M_AXIS_TUSER         (),
      .S_AXIS_TSTRB         (tstrb),
      .S_AXIS_TUSER         (tuser),
      
      .S_AXIS_TREADY        (tready),
      .S_AXIS_TDATA         (tdata),
      .S_AXIS_TLAST         (tlast),
      .S_AXIS_TVALID        (tvalid),
      
      .M_AXIS_TVALID        (),
      .M_AXIS_TDATA         (),
      .M_AXIS_TLAST         (),
      .M_AXIS_TREADY        (1'b1),
      
      .M_PBS_DATA           (),
      .M_PBS_CTRL           (),
      .M_PBS_WR             (),	
      .M_PBS_RDY            (1'b1),
      
      .S_PBS_DATA           (pdata),
      .S_PBS_CTRL           (pctrl),
      .S_PBS_WR             (pwr),
      .S_PBS_RDY            (prdy)
);

endmodule
