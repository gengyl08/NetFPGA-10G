/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        mem_to_fifo.v
 *
 *  Library:
 *        hw/osnt/pcores/nf10_pcap_replay_uengine_v1_00_a
 *
 *  Module:
 *        mem_to_fifo
 *
 *  Author:
 *        Muhammad Shahbaz
 *
 *  Description:
 *
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

module mem_to_fifo
#(
    parameter NUM_QUEUES           = 4,
    parameter NUM_QUEUES_BITS      = log2(NUM_QUEUES),
    parameter FIFO_DATA_WIDTH      = 144,
    parameter MEM_ADDR_WIDTH       = 19,
    parameter MEM_DATA_WIDTH       = 36,
    parameter MEM_BW_WIDTH         = 4,
    parameter MEM_BURST_LENGTH     = 2,
    parameter MEM_ADDR_LOW         = 0,
    parameter MEM_ADDR_HIGH        = MEM_ADDR_LOW+(2**MEM_ADDR_WIDTH),
    parameter REPLAY_COUNT_WIDTH   = 32,
    parameter SIM_ONLY             = 0      
)
(
    // Global Ports
    input                             clk,
    input                              rst,

    
    // Memory Ports
    output reg                         mem_r_n,
    input                              mem_rd_full,
    output reg [MEM_ADDR_WIDTH-1:0]   mem_ad_rd,
    
    input [QDR_NUM_CHIPS-1:0]         mem_qr_valid,
    input [MEM_DATA_WIDTH-1:0]        mem_qrl,
    input [MEM_DATA_WIDTH-1:0]        mem_qrh,

    // FIFO Ports
    output reg                        q0_fifo_wr_en,
    output reg [FIFO_DATA_WIDTH-1:0]  q0_fifo_data,
    input                             q0_fifo_full,
    input                             q0_fifo_prog_full,
    
    output reg                        q1_fifo_wr_en,
    output reg [FIFO_DATA_WIDTH-1:0]  q1_fifo_data,
    input                             q1_fifo_full,
    input                             q1_fifo_prog_full,
    
    output reg                        q2_fifo_wr_en,
    output reg [FIFO_DATA_WIDTH-1:0]  q2_fifo_data,
    input                             q2_fifo_full,
    input                             q2_fifo_prog_full,
    
    output reg                        q3_fifo_wr_en,
    output reg [FIFO_DATA_WIDTH-1:0]  q3_fifo_data,
    input                             q3_fifo_full,
    input                             q3_fifo_prog_full,

    // Misc
    output reg [MEM_ADDR_WIDTH-3:0]       q0_addr_head,
    input [MEM_ADDR_WIDTH-3:0]        q0_addr_tail,
    output reg [MEM_ADDR_WIDTH-3:0]       q1_addr_head,
    input [MEM_ADDR_WIDTH-3:0]        q1_addr_tail,
    output reg [MEM_ADDR_WIDTH-3:0]       q2_addr_head,
    input [MEM_ADDR_WIDTH-3:0]        q2_addr_tail,
    output reg [MEM_ADDR_WIDTH-3:0]       q3_addr_head,
    input [MEM_ADDR_WIDTH-3:0]        q3_addr_tail,

    input                              cal_done
);

  // -- Local Functions
  function integer log2;
    input integer number;
    begin
       log2=0;
       while(2**log2<number) begin
          log2=log2+1;
       end
    end
  endfunction

  // -- Internal Parameters
  localparam QID_STATE_0 = 0;
  localparam QID_STATE_1 = 1;
  
  // -- Signals  
  reg                            q0_fifo_wr_en_r0;
  reg [FIFO_DATA_WIDTH-1:0]      q0_fifo_data_r0;
  reg                            q0_fifo_wr_en_r1;
  reg [FIFO_DATA_WIDTH-1:0]      q0_fifo_data_r1;  
  reg                            q1_fifo_wr_en_r0;
  reg [FIFO_DATA_WIDTH-1:0]      q1_fifo_data_r0;
  reg                            q1_fifo_wr_en_r1;
  reg [FIFO_DATA_WIDTH-1:0]      q1_fifo_data_r1;  
  reg                            q2_fifo_wr_en_r0;
  reg [FIFO_DATA_WIDTH-1:0]      q2_fifo_data_r0;
  reg                            q2_fifo_wr_en_r1;
  reg [FIFO_DATA_WIDTH-1:0]      q2_fifo_data_r1;  
  reg                            q3_fifo_wr_en_r0;
  reg [FIFO_DATA_WIDTH-1:0]      q3_fifo_data_r0;
  reg                            q3_fifo_wr_en_r1;
  reg [FIFO_DATA_WIDTH-1:0]      q3_fifo_data_r1;
  
  reg [1:0]                     qid_state, qid_state_nxt;
  reg [NUM_QUEUES_BITS:0]        cur_qid, cur_qid_nxt;

  reg [MEM_ADDR_WIDTH-3:0]      q0_addr_head_next;
  reg [MEM_ADDR_WIDTH-3:0]      q1_addr_head_next;
  reg [MEM_ADDR_WIDTH-3:0]      q2_addr_head_next;
  reg [MEM_ADDR_WIDTH-3:0]      q3_addr_head_next;
  
  reg                           fifo_wr_en;
  reg                           fifo_rd_en;
  reg  [NUM_QUEUES_BITS-1:0]     fifo_din_qid;
  wire [NUM_QUEUES_BITS-1:0]     fifo_dout_qid;
  wire                          fifo_empty_qid;
  wire                          fifo_full_qid;
  wire [71:0]                   fifo_dout_data_0;
  wire                          fifo_empty_data_0;
  wire                          fifo_full_data_0;
  wire [71:0]                   fifo_dout_data_1;
  wire                          fifo_empty_data_1;
  wire                          fifo_full_data_1;

  // -- Assignments
  
  // -- Modules and Logic
  
  // --- Arbitration logic
  
  // Note: the prog_full signal is asserted when there are ~16 locations left in the FIFO. This is based on the assumption that after seeing the prog_full the max number of read requests in flight would be no more than 14.

  // The code actually made the assumption that the qid fifo will never be full and mem_rd_full will never be asserted.
                  
  assign oq0_enable = !q0_fifo_prog_full && (q0_addr_head != q0_addr_tail);
  assign oq1_enable = !q1_fifo_prog_full && (q1_addr_head != q1_addr_tail);
  assign oq2_enable = !q2_fifo_prog_full && (q2_addr_head != q2_addr_tail);
  assign oq3_enable = !q3_fifo_prog_full && (q3_addr_head != q3_addr_tail);

  always @ * begin
    cur_qid_nxt = cur_qid;
    qid_state_nxt = qid_state;

    mem_r_n = 1;
    mem_ad_rd = 0;

    fifo_din_qid = -1;
    fifo_wr_en = 0;

    q0_addr_head_next = q0_addr_head;
    q1_addr_head_next = q1_addr_head;
    q2_addr_head_next = q2_addr_head;
    q3_addr_head_next = q3_addr_head;

    case (qid_state)
      QID_STATE_0: begin
        case (cur_qid)
          'd0: begin
                  if (oq1_enable) cur_qid_nxt = 1; 
             else if (oq2_enable) cur_qid_nxt = 2; 
             else if (oq3_enable) cur_qid_nxt = 3; 
             else if (oq0_enable) cur_qid_nxt = 0;
             else                 cur_qid_nxt = -1;

             fifo_din_qid = 0;
             fifo_wr_en = 1;
          end                               
          'd1: begin                        
                  if (oq2_enable) cur_qid_nxt = 2; 
             else if (oq3_enable) cur_qid_nxt = 3; 
             else if (oq0_enable) cur_qid_nxt = 0;
             else if (oq1_enable) cur_qid_nxt = 1;
             else                 cur_qid_nxt = -1;

             fifo_din_qid = 1;
             fifo_wr_en = 1;
          end                               
          'd2: begin                        
                  if (oq3_enable) cur_qid_nxt = 3;
             else if (oq0_enable) cur_qid_nxt = 0;
             else if (oq1_enable) cur_qid_nxt = 1; 
             else if (oq2_enable) cur_qid_nxt = 2;
             else                 cur_qid_nxt = -1;

             fifo_din_qid = 2;
             fifo_wr_en = 1;
          end                               
          'd3: begin                        
                  if (oq0_enable) cur_qid_nxt = 0;
             else if (oq1_enable) cur_qid_nxt = 1; 
             else if (oq2_enable) cur_qid_nxt = 2; 
             else if (oq3_enable) cur_qid_nxt = 3; 
             else                 cur_qid_nxt = -1;

             fifo_din_qid = 3;
             fifo_wr_en = 1;
          end
          default: begin                        
                  if (oq0_enable) cur_qid_nxt = 0;
             else if (oq1_enable) cur_qid_nxt = 1; 
             else if (oq2_enable) cur_qid_nxt = 2; 
             else if (oq3_enable) cur_qid_nxt = 3; 
             else                 cur_qid_nxt = -1;
          end
        endcase
        qid_state_nxt = QID_STATE_1;
      end

      QID_STATE_1: begin
        if(cur_qid == -1) begin
          qid_state_nxt = QID_STATE_0;
        end
        else begin
          if(!fifo_full_qid && !mem_rd_full) begin
            case(cur_qid)
              'd0: begin
                mem_r_n = 0;
                mem_ad_rd = {2'b00, q0_addr_head};
                q0_addr_head_next = q0_addr_head + 1;

                fifo_din_qid = 0;
                fifo_wr_en = 1;
              end
              'd1: begin
                mem_r_n = 0;
                mem_ad_rd = {2'b01, q1_addr_head};
                q1_addr_head_next = q1_addr_head + 1;

                fifo_din_qid = 1;
                fifo_wr_en = 1;
              end
              'd2: begin
                mem_r_n = 0;
                mem_ad_rd = {2'b10, q2_addr_head};
                q2_addr_head_next = q2_addr_head + 1;

                fifo_din_qid = 2;
                fifo_wr_en = 1;
              end
              'd3: begin
                mem_r_n = 0;
                mem_ad_rd = {2'b11, q3_addr_head};
                q3_addr_head_next = q3_addr_head + 1;

                fifo_din_qid = 3;
                fifo_wr_en = 1;
              end
            endcase
            qid_state_nxt = QID_STATE_0;
          end
        end
      end
    endcase

  end
  
  // Address generation logic
  
  always @ (posedge clk) begin
    if(rst | ~cal_done) begin

      cur_qid <= -1;
      qid_state <= QID_STATE_0;

      q0_addr_head <= 0;
      q1_addr_head <= 0;
      q2_addr_head <= 0;
      q3_addr_head <= 0;
      
    end
    else begin

      cur_qid <= cur_qid_nxt;
      qid_state <= qid_state_nxt;

      q0_addr_head <= q0_addr_head_next;
      q1_addr_head <= q1_addr_head_next;
      q2_addr_head <= q2_addr_head_next;
      q3_addr_head <= q3_addr_head_next;
    end
  end

  // --- QID FIFO (Depth of 16 for worst case delay (i.e., 14 cycles) between the read request and qrl_valid)
  fallthrough_small_fifo #(.WIDTH(NUM_QUEUES_BITS), .MAX_DEPTH_BITS(4))
    qid_fifo_inst
      ( .din         (fifo_din_qid),
        .wr_en       (fifo_wr_en),
        .rd_en       (fifo_rd_en),
        .dout        (fifo_dout_qid),
        .full        (),
        .prog_full   (),
        .nearly_full (fifo_full_qid),
        .empty       (fifo_empty_qid),
        .reset       (rst | ~cal_done),
        .clk         (clk)
      );

  fallthrough_small_fifo #(.WIDTH(72), .MAX_DEPTH_BITS(4))
    data_fifo_inst_0
      ( .din         ({mem_qrh[35:0], mem_qrl[35:0]}),
        .wr_en       (mem_qr_valid[0]),
        .rd_en       (fifo_rd_en),
        .dout        (fifo_dout_data_0),
        .full        (),
        .prog_full   (),
        .nearly_full (fifo_full_data_0),
        .empty       (fifo_empty_data_0),
        .reset       (rst | ~cal_done),
        .clk         (clk)
      );

  fallthrough_small_fifo #(.WIDTH(72), .MAX_DEPTH_BITS(4))
    data_fifo_inst_1
      ( .din         ({mem_qrh[71:36], mem_qrl[71:36]}),
        .wr_en       (mem_qr_valid[1]),
        .rd_en       (fifo_rd_en),
        .dout        (fifo_dout_data_1),
        .full        (),
        .prog_full   (),
        .nearly_full (fifo_full_data_1),
        .empty       (fifo_empty_data_1),
        .reset       (rst | ~cal_done),
        .clk         (clk)
      );
  
  // --- Data logic
  always @ * begin
    fifo_rd_en = !fifo_empty_qid & !fifo_empty_data_0 & !fifo_empty_data_1;
    
    // Note: based on the assumptions that:
    // (1) We always have an entry for a given read data in the FIFO, so it will never be empty.
    // (2) The output FIFOs will have always have space to store the read data. The prog_full is used in the 
    //     round-robin arbiter above to ensure that we don't overwrite.
  end
  
  always @ (posedge clk) begin
    if(rst) begin
      q0_fifo_wr_en_r0 <= 0;
      q0_fifo_data_r0  <= {FIFO_DATA_WIDTH{1'b0}};
      
      q1_fifo_wr_en_r0 <= 0;
      q1_fifo_data_r0  <= {FIFO_DATA_WIDTH{1'b0}};
      
      q2_fifo_wr_en_r0 <= 0;
      q2_fifo_data_r0  <= {FIFO_DATA_WIDTH{1'b0}};
      
      q3_fifo_wr_en_r0 <= 0;
      q3_fifo_data_r0  <= {FIFO_DATA_WIDTH{1'b0}};
    end
    else begin
      q0_fifo_wr_en_r0 <= 0;
      q1_fifo_wr_en_r0 <= 0;
      q2_fifo_wr_en_r0 <= 0;
      q3_fifo_wr_en_r0 <= 0;
      
      if (!fifo_empty_qid & !fifo_empty_data_0 & !fifo_empty_data_1) begin
        case (fifo_dout_qid) 
          'd0: begin
            q0_fifo_wr_en_r0 <= 1;
            q0_fifo_data_r0  <= {fifo_dout_data_1[71:36], fifo_dout_data_0[71:36], fifo_dout_data_1[35:0], fifo_dout_data_0[35:0]};
          end
          'd1: begin
            q1_fifo_wr_en_r0 <= 1;
            q1_fifo_data_r0  <= {fifo_dout_data_1[71:36], fifo_dout_data_0[71:36], fifo_dout_data_1[35:0], fifo_dout_data_0[35:0]};
          end
          'd2: begin
            q2_fifo_wr_en_r0 <= 1;
            q2_fifo_data_r0  <= {fifo_dout_data_1[71:36], fifo_dout_data_0[71:36], fifo_dout_data_1[35:0], fifo_dout_data_0[35:0]};
          end
          'd3: begin
            q3_fifo_wr_en_r0 <= 1;
            q3_fifo_data_r0  <= {fifo_dout_data_1[71:36], fifo_dout_data_0[71:36], fifo_dout_data_1[35:0], fifo_dout_data_0[35:0]};
          end
          default: begin
            q0_fifo_wr_en_r0 <= 0;
            q1_fifo_wr_en_r0 <= 0;
            q2_fifo_wr_en_r0 <= 0;
            q3_fifo_wr_en_r0 <= 0;
          end
        endcase
      end
    end
  end
  
  always @ (posedge clk) begin
    q0_fifo_wr_en_r1 <= q0_fifo_wr_en_r0;
    q0_fifo_data_r1  <= q0_fifo_data_r0;
    q0_fifo_wr_en    <= q0_fifo_wr_en_r1;
    q0_fifo_data     <= q0_fifo_data_r1;
    
    q1_fifo_wr_en_r1 <= q1_fifo_wr_en_r0;
    q1_fifo_data_r1  <= q1_fifo_data_r0;
    q1_fifo_wr_en    <= q1_fifo_wr_en_r1;
    q1_fifo_data     <= q1_fifo_data_r1;
    
    q2_fifo_wr_en_r1 <= q2_fifo_wr_en_r0;
    q2_fifo_data_r1  <= q2_fifo_data_r0;
    q2_fifo_wr_en    <= q2_fifo_wr_en_r1;
    q2_fifo_data     <= q2_fifo_data_r1;
    
    q3_fifo_wr_en_r1 <= q3_fifo_wr_en_r0;
    q3_fifo_data_r1  <= q3_fifo_data_r0;
    q3_fifo_wr_en    <= q3_fifo_wr_en_r1;
    q3_fifo_data     <= q3_fifo_data_r1;
  end
  
endmodule

