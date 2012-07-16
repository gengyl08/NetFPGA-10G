/*******************************************************************************
 *
 *  NetFPGA-10G http://www.netfpga.org
 *
 *  File:
 *        aximemorycontroller.v
 *
 *  Library:
 *        hw/std/pcores/nf10_sram_fifo
 *
 *  Module:
 *        nf10_sram_fifo
 *
 *  Author:
 *        Sam D'Amico
 *
 *  Description:
 *        AXI4-Stream SRAM FIFO Top Module
 *
 *  Copyright notice:
 *        Copyright (C) 2010,2011 The Board of Trustees of The Leland Stanford
 *                                Junior University
 *
 *  Licence:
 *        This file is part of the NetFPGA 10G development base package.
 *
 *        This package is free software: you can redistribute it and/or modify
 *        it under the terms of the GNU Lesser General Public License as
 *        published by the Free Software Foundation, either version 3 of the
 *        License, or (at your option) any later version.
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


module nf10_sram_fifo
#(
///////////////////////////////////////////////////////////////////////////////
// Parameter Definitions
///////////////////////////////////////////////////////////////////////////////
  parameter integer C_S_AXIS_DATA_WIDTH = 256,
  parameter integer C_M_AXIS_DATA_WIDTH = 256,
  parameter integer C_S_AXIS_TUSER_WIDTH = 128,
  parameter integer C_M_AXIS_TUSER_WIDTH = 128,
  parameter integer MASTERBANK_PIN_WIDTH = 3,
  // Width of AXI data bus in bytes
  parameter integer TDATA_WIDTH        = C_M_AXIS_DATA_WIDTH/8,
  parameter integer CROPPED_TDATA_WIDTH        = (((C_M_AXIS_DATA_WIDTH/8) > 24) ? 24 : (C_M_AXIS_DATA_WIDTH/8)),
  // Width of TUSER in bits
  parameter integer TUSER_WIDTH        = C_M_AXIS_TUSER_WIDTH,
  parameter integer NUM_QUEUES         = 4,
  parameter integer QUEUE_ID_WIDTH     = 2,
  parameter integer NUM_MEM_CHIPS      = 3,
  parameter integer NUM_MEM_INPUTS     = 6,
  parameter integer MEM_WIDTH          = 36,
  parameter integer MEM_ADDR_WIDTH     = 19,
  parameter integer MEM_CQ_WIDTH       = 1,
  parameter integer MEM_CLK_WIDTH      = 1,
  parameter integer MEM_BW_WIDTH       = 4,
  parameter integer TID_WIDTH          = 4, 
  parameter integer TDEST_WIDTH        = 4,
  parameter integer NUM_MEMORY_CHIPS   = 3

)
(
    input                           aclk,
    input                           aresetn,
    input                           memclk,
    input                           memclk_270,
    input                           memclk_200,
    
    // Slave (input) Stream Ports
    input [C_S_AXIS_DATA_WIDTH - 1:0] s_axis_0_tdata,
    input [((C_S_AXIS_DATA_WIDTH / 8)) - 1:0] s_axis_0_tstrb,
    input [C_S_AXIS_TUSER_WIDTH-1:0] s_axis_0_tuser,
    input  s_axis_0_tvalid,
    output s_axis_0_tready,
    input  s_axis_0_tlast,
    
    input [C_S_AXIS_DATA_WIDTH - 1:0] s_axis_1_tdata,
    input [((C_S_AXIS_DATA_WIDTH / 8)) - 1:0] s_axis_1_tstrb,
    input [C_S_AXIS_TUSER_WIDTH-1:0] s_axis_1_tuser,
    input  s_axis_1_tvalid,
    output s_axis_1_tready,
    input  s_axis_1_tlast,

    input [C_S_AXIS_DATA_WIDTH - 1:0] s_axis_2_tdata,
    input [((C_S_AXIS_DATA_WIDTH / 8)) - 1:0] s_axis_2_tstrb,
    input [C_S_AXIS_TUSER_WIDTH-1:0] s_axis_2_tuser,
    input  s_axis_2_tvalid,
    output s_axis_2_tready,
    input  s_axis_2_tlast,

    input [C_S_AXIS_DATA_WIDTH - 1:0] s_axis_3_tdata,
    input [((C_S_AXIS_DATA_WIDTH / 8)) - 1:0] s_axis_3_tstrb,
    input [C_S_AXIS_TUSER_WIDTH-1:0] s_axis_3_tuser,
    input  s_axis_3_tvalid,
    output s_axis_3_tready,
    input  s_axis_3_tlast,

    // Master (output) Stream Ports
    output [C_M_AXIS_DATA_WIDTH - 1:0] m_axis_0_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0] m_axis_0_tstrb,
    output [C_M_AXIS_TUSER_WIDTH-1:0] m_axis_0_tuser,
    output m_axis_0_tvalid,
    input  m_axis_0_tready,
    output m_axis_0_tlast,

    output [C_M_AXIS_DATA_WIDTH - 1:0] m_axis_1_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0] m_axis_1_tstrb,
    output [C_M_AXIS_TUSER_WIDTH-1:0] m_axis_1_tuser,
    output m_axis_1_tvalid,
    input  m_axis_1_tready,
    output m_axis_1_tlast,

    output [C_M_AXIS_DATA_WIDTH - 1:0] m_axis_2_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0] m_axis_2_tstrb,
    output [C_M_AXIS_TUSER_WIDTH-1:0] m_axis_2_tuser,
    output m_axis_2_tvalid,
    input  m_axis_2_tready,
    output m_axis_2_tlast,

    output [C_M_AXIS_DATA_WIDTH - 1:0] m_axis_3_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0] m_axis_3_tstrb,
    output [C_M_AXIS_TUSER_WIDTH-1:0] m_axis_3_tuser,
    output m_axis_3_tvalid,
    input  m_axis_3_tready,
    output m_axis_3_tlast,

    // memory interface
    input [(MEM_WIDTH)-1:0]  qdr_q_0,
    input [MEM_CQ_WIDTH-1:0]    qdr_cq_0,
    input [MEM_CQ_WIDTH-1:0]    qdr_cq_n_0,
    output [MEM_CLK_WIDTH-1:0]  qdr_c_0,
    output [MEM_CLK_WIDTH-1:0]  qdr_c_n_0,
    output             qdr_dll_off_n_0,
    output [MEM_CLK_WIDTH-1:0]  qdr_k_0,
    output [MEM_CLK_WIDTH-1:0]  qdr_k_n_0,
    output [MEM_ADDR_WIDTH-1:0] qdr_sa_0,
    output [(MEM_BW_WIDTH)-1:0]   qdr_bw_n_0,
    output             qdr_w_n_0,
    output [(MEM_WIDTH)-1:0]  qdr_d_0,
    output             qdr_r_n_0,

    input [(MEM_WIDTH)-1:0]  qdr_q_1,
    input [MEM_CQ_WIDTH-1:0]    qdr_cq_1,
    input [MEM_CQ_WIDTH-1:0]    qdr_cq_n_1,
    output [MEM_CLK_WIDTH-1:0]  qdr_c_1,
    output [MEM_CLK_WIDTH-1:0]  qdr_c_n_1,
    output             qdr_dll_off_n_1,
    output [MEM_CLK_WIDTH-1:0]  qdr_k_1,
    output [MEM_CLK_WIDTH-1:0]  qdr_k_n_1,
    output [MEM_ADDR_WIDTH-1:0] qdr_sa_1,
    output [(MEM_BW_WIDTH)-1:0]   qdr_bw_n_1,
    output             qdr_w_n_1,
    output [(MEM_WIDTH)-1:0]  qdr_d_1,
    output             qdr_r_n_1,

    input [(MEM_WIDTH)-1:0]  qdr_q_2,
    input [MEM_CQ_WIDTH-1:0]    qdr_cq_2,
    input [MEM_CQ_WIDTH-1:0]    qdr_cq_n_2,
    output [MEM_CLK_WIDTH-1:0]  qdr_c_2,
    output [MEM_CLK_WIDTH-1:0]  qdr_c_n_2,
    output             qdr_dll_off_n_2,
    output [MEM_CLK_WIDTH-1:0]  qdr_k_2,
    output [MEM_CLK_WIDTH-1:0]  qdr_k_n_2,
    output [MEM_ADDR_WIDTH-1:0] qdr_sa_2,
    output [(MEM_BW_WIDTH)-1:0]   qdr_bw_n_2,
    output             qdr_w_n_2,
    output [(MEM_WIDTH)-1:0]  qdr_d_2,
    output             qdr_r_n_2,

    /*synthesis syn_keep = 1 */(* S = "TRUE" *)
    input  [MASTERBANK_PIN_WIDTH-1:0]  masterbank_sel_pin,

    input		locked,

    output [(MEM_WIDTH*NUM_MEM_INPUTS-1):0] debug_mem_controller_dout,
    output [(MEM_ADDR_WIDTH-1):0]  debug_mem_controller_dout_addr,
    output debug_mem_controller_dout_ready,
    output [NUM_MEM_CHIPS-1:0] debug_calibration,
    output [63:0] mem_dbg,
    output [63:0] fifo_dbg

);

    wire clk = aclk;
    wire reset = ~aresetn;
    // Assign signals to array of signals to allow for use of generate statements later on
    wire [(NUM_QUEUES-1):0]        tvalid_in = {s_axis_3_tvalid, s_axis_2_tvalid, s_axis_1_tvalid, s_axis_0_tvalid};
    wire [(NUM_QUEUES-1):0]       tready_in;
    assign {s_axis_3_tready, s_axis_2_tready, s_axis_1_tready, s_axis_0_tready} = tready_in;
    wire [((8*TDATA_WIDTH*NUM_QUEUES) - 1):0] tdata_in = {s_axis_3_tdata, s_axis_2_tdata, s_axis_1_tdata, s_axis_0_tdata};
    wire [(NUM_QUEUES-1):0]        tlast_in = {s_axis_3_tlast, s_axis_2_tlast, s_axis_1_tlast, s_axis_0_tlast};
    wire [((TDATA_WIDTH*NUM_QUEUES) - 1):0] tstrb_in = {s_axis_3_tstrb, s_axis_2_tstrb, s_axis_1_tstrb, s_axis_0_tstrb};

    wire [(TID_WIDTH*NUM_QUEUES-1):0]         tid_in;
    wire [(TDEST_WIDTH*NUM_QUEUES-1):0]       tdest_in;
    wire [(TUSER_WIDTH*NUM_QUEUES-1):0]       tuser_in = {s_axis_3_tuser, s_axis_2_tuser, s_axis_1_tuser, s_axis_0_tuser};

    wire [(NUM_QUEUES-1):0]         tvalid_out;
    assign {m_axis_3_tvalid, m_axis_2_tvalid, m_axis_1_tvalid, m_axis_0_tvalid} = tvalid_out;
    wire [(NUM_QUEUES-1):0]     tready_out = {m_axis_3_tready, m_axis_2_tready, m_axis_1_tready, m_axis_0_tready};
    wire [((8*TDATA_WIDTH*NUM_QUEUES) - 1):0] tdata_out;
    assign {m_axis_3_tdata, m_axis_2_tdata, m_axis_1_tdata, m_axis_0_tdata} = tdata_out;
    wire [(NUM_QUEUES-1):0]                   tlast_out;
    assign {m_axis_3_tlast, m_axis_2_tlast, m_axis_1_tlast, m_axis_0_tlast} = tlast_out;
    wire [((TDATA_WIDTH*NUM_QUEUES) - 1):0] tstrb_out;
    assign {m_axis_3_tstrb, m_axis_2_tstrb, m_axis_1_tstrb, m_axis_0_tstrb} = tstrb_out;
    wire [(TID_WIDTH*NUM_QUEUES-1):0]         tid_out;
    wire [(TDEST_WIDTH*NUM_QUEUES-1):0]       tdest_out;
    wire [(TUSER_WIDTH*NUM_QUEUES-1):0]       tuser_out;
    assign {m_axis_3_tuser, m_axis_2_tuser, m_axis_1_tuser, m_axis_0_tuser} = tuser_out;

    wire [NUM_MEM_CHIPS*(MEM_WIDTH)-1:0]  qdr_q = {qdr_q_2,qdr_q_1,qdr_q_0};
    wire [NUM_MEM_CHIPS*MEM_CQ_WIDTH-1:0]    qdr_cq = {qdr_cq_2,qdr_cq_1,qdr_cq_0};
    wire [NUM_MEM_CHIPS*MEM_CQ_WIDTH-1:0]    qdr_cq_n = {qdr_cq_n_2,qdr_cq_n_1,qdr_cq_n_0};
    wire [NUM_MEM_CHIPS*MEM_CLK_WIDTH-1:0]  qdr_c;
    assign qdr_c_2 = qdr_c[3*MEM_CLK_WIDTH-1:2*MEM_CLK_WIDTH];
    assign qdr_c_1 = qdr_c[2*MEM_CLK_WIDTH-1:1*MEM_CLK_WIDTH];
    assign qdr_c_0 = qdr_c[1*MEM_CLK_WIDTH-1:0];
    wire [NUM_MEM_CHIPS*MEM_CLK_WIDTH-1:0]  qdr_c_n;
    assign qdr_c_n_2 = qdr_c_n[3*MEM_CLK_WIDTH-1:2*MEM_CLK_WIDTH];
    assign qdr_c_n_1 = qdr_c_n[2*MEM_CLK_WIDTH-1:1*MEM_CLK_WIDTH];
    assign qdr_c_n_0 = qdr_c_n[1*MEM_CLK_WIDTH-1:0];
    wire [NUM_MEM_CHIPS-1:0]            qdr_dll_off_n;
    assign qdr_dll_off_n_2 = qdr_dll_off_n[2];
    assign qdr_dll_off_n_1 = qdr_dll_off_n[1];
    assign qdr_dll_off_n_0 = qdr_dll_off_n[0];
    //assign {qdr_dl_off_n_2, qdr_dl_off_n_1, qdr_dl_off_n_0} = qdr_dll_off_n;
    wire [NUM_MEM_CHIPS*MEM_CLK_WIDTH-1:0]  qdr_k;
    assign qdr_k_2 = qdr_k[3*MEM_CLK_WIDTH-1:2*MEM_CLK_WIDTH];
    assign qdr_k_1 = qdr_k[2*MEM_CLK_WIDTH-1:1*MEM_CLK_WIDTH];
    assign qdr_k_0 = qdr_k[1*MEM_CLK_WIDTH-1:0];
    wire [NUM_MEM_CHIPS*MEM_CLK_WIDTH-1:0]  qdr_k_n;
    assign qdr_k_n_2 = qdr_k_n[3*MEM_CLK_WIDTH-1:2*MEM_CLK_WIDTH];
    assign qdr_k_n_1 = qdr_k_n[2*MEM_CLK_WIDTH-1:1*MEM_CLK_WIDTH];
    assign qdr_k_n_0 = qdr_k_n[1*MEM_CLK_WIDTH-1:0];
    wire [NUM_MEM_CHIPS*MEM_ADDR_WIDTH-1:0] qdr_sa;

    assign qdr_sa_2 = qdr_sa[3*MEM_ADDR_WIDTH-1:2*MEM_ADDR_WIDTH]; 
    assign qdr_sa_1 = qdr_sa[2*MEM_ADDR_WIDTH-1:1*MEM_ADDR_WIDTH]; 
    assign qdr_sa_0 = qdr_sa[1*MEM_ADDR_WIDTH-1:0*MEM_ADDR_WIDTH];
   
    wire [NUM_MEM_CHIPS*(MEM_BW_WIDTH)-1:0]   qdr_bw_n;
    assign qdr_bw_n_2 = qdr_bw_n[3*MEM_BW_WIDTH-1:2*MEM_BW_WIDTH];
    assign qdr_bw_n_1 = qdr_bw_n[2*MEM_BW_WIDTH-1:1*MEM_BW_WIDTH];
    assign qdr_bw_n_0 = qdr_bw_n[1*MEM_BW_WIDTH-1:0];
    wire [NUM_MEM_CHIPS-1:0]            qdr_w_n;
    assign qdr_w_n_2 = qdr_w_n[2];
    assign qdr_w_n_1 = qdr_w_n[1];
    assign qdr_w_n_0 = qdr_w_n[0];

    wire [NUM_MEM_CHIPS*(MEM_WIDTH)-1:0]  qdr_d;
    assign qdr_d_2 = qdr_d[3*MEM_WIDTH-1:2*MEM_WIDTH];
    assign qdr_d_1 = qdr_d[2*MEM_WIDTH-1:1*MEM_WIDTH];
    assign qdr_d_0 = qdr_d[1*MEM_WIDTH-1:0*MEM_WIDTH];

    wire [NUM_MEM_CHIPS-1:0]            qdr_r_n;
    assign qdr_r_n_2 = qdr_r_n[2];
    assign qdr_r_n_1 = qdr_r_n[1];
    assign qdr_r_n_0 = qdr_r_n[0];

    // Local wires to connect modules together
    wire [(NUM_QUEUES-1):0] rinc_in;
    wire [(NUM_QUEUES-1):0] rempty_in;
    wire [(NUM_QUEUES-1):0] r_almost_empty_in;
    wire [(NUM_QUEUES-1):0] dout_valid_in;
    wire [((NUM_QUEUES*(CROPPED_TDATA_WIDTH*8+9))-1):0] dout_in;
    wire [(NUM_QUEUES-1):0] din_valid_out;
    wire [((NUM_QUEUES*(CROPPED_TDATA_WIDTH*8+9))-1):0] din_out;
    wire [(NUM_QUEUES-1):0] w_almost_full_out;
    wire [(NUM_QUEUES-1):0] wfull_out;
    wire [(NUM_QUEUES-1):0] winc_out;

    wire [((CROPPED_TDATA_WIDTH*8+9)-1):0] mem_din;
    wire [((CROPPED_TDATA_WIDTH*8+9)-1):0] mem_dout;

    wire mem_dout_valid;
    wire mem_din_valid;
    wire [(NUM_QUEUES-1):0] mem_rempty;
    wire [(NUM_QUEUES-1):0] mem_rfull;
    wire [(NUM_QUEUES-1):0] mem_wfull;
    wire [(QUEUE_ID_WIDTH-1):0] mem_queue_id_read;
    wire [(QUEUE_ID_WIDTH-1):0] mem_queue_id_write;
    wire [(QUEUE_ID_WIDTH-1):0] mem_din_queue_id;
    wire [(MEM_WIDTH*NUM_MEM_INPUTS-1):0] mem_controller_din;
    wire [(MEM_ADDR_WIDTH-1):0]  mem_controller_din_addr;
    wire mem_controller_din_ready;
    wire [(MEM_WIDTH*NUM_MEM_INPUTS-1):0] mem_controller_dout;
    wire [(MEM_ADDR_WIDTH-1):0]  mem_controller_dout_addr;
    wire mem_controller_dout_ready;
    wire [NUM_MEM_CHIPS-1:0] mem_controller_din_valid;
    
    wire memclk_180;
    wire memreset, memreset_180, memreset_270, memreset_200;
    wire [NUM_MEM_CHIPS-1:0] next_cal_done;
    reg [NUM_MEM_CHIPS-1:0] cal_done_interm;
    reg [NUM_MEM_CHIPS-1:0] cal_done;

    wire read_burst, write_burst;

    wire [2:0] mem_controller_read_ready;
    wire [2:0] mem_controller_write_ready;

    wire [127:0] input_fifo_cnt;
    wire [127:0] output_fifo_cnt;
    wire [NUM_QUEUES-1:0] output_inc;
    assign mem_dbg = 0;
    assign fifo_dbg = 0;//{output_fifo_cnt[31:0], input_fifo_cnt[31:0]};
    assign debug_calibration = cal_done;
    genvar i;
    generate
    for(i=0;i<NUM_QUEUES;i=i+1)
    begin : aximasterslave
        AxiToFifo #(.TDATA_WIDTH(TDATA_WIDTH),
                    .CROPPED_TDATA_WIDTH(CROPPED_TDATA_WIDTH),
                    .TUSER_WIDTH(TUSER_WIDTH),
                    .TID_WIDTH(TID_WIDTH), 
                    .TDEST_WIDTH(TDEST_WIDTH), 
                    .NUM_QUEUES(NUM_QUEUES), 
                    .QUEUE_ID_WIDTH(QUEUE_ID_WIDTH)) 
                  axififo(
                          .clk(clk),
                          .reset(reset),
                          .tvalid(tvalid_in[i]),
                          .tready(tready_in[i]),
                          .tdata(tdata_in[((i+1)*TDATA_WIDTH*8-1):(i*TDATA_WIDTH*8)]),
                          .tstrb(tstrb_in[((i+1)*TDATA_WIDTH-1):(i*TDATA_WIDTH)]),
                          .tlast(tlast_in[i]),
                          .tid(tid_in[((i+1)*TID_WIDTH-1):(i*TID_WIDTH)]),
                          .tdest(tdest_in[((i+1)*TDEST_WIDTH-1):(i*TDEST_WIDTH)]),
                          .tuser(tuser_in[((i+1)*TUSER_WIDTH-1):(i*TUSER_WIDTH)]),
                          .memclk(memclk),
                          .memreset(memreset),
                          .rinc(rinc_in[i]),
                          .rempty(rempty_in[i]),
                          .r_almost_empty(r_almost_empty_in[i]),
                          .dout_valid(dout_valid_in[i]),
                          .dout(dout_in[((i+1)*(8*CROPPED_TDATA_WIDTH+9)-1):(i*(8*CROPPED_TDATA_WIDTH+9))]), 
                          .cal_done(&cal_done),
                          .output_inc(output_inc[i]),
                          .input_fifo_cnt(input_fifo_cnt[(32*i+31):(32*i)])
                          );


        FifoToAxi #(.TDATA_WIDTH(TDATA_WIDTH),
                    .CROPPED_TDATA_WIDTH(CROPPED_TDATA_WIDTH),
                    .TUSER_WIDTH(TUSER_WIDTH),
                    .TID_WIDTH(TID_WIDTH), 
                    .TDEST_WIDTH(TDEST_WIDTH), 
                    .NUM_QUEUES(NUM_QUEUES), 
                    .QUEUE_ID_WIDTH(QUEUE_ID_WIDTH)) 
                  fifoaxi(
                          .clk(clk),
                          .reset(reset),
                          .tvalid(tvalid_out[i]),
                          .tready(tready_out[i]),
                          .tdata(tdata_out[((i+1)*TDATA_WIDTH*8-1):(i*TDATA_WIDTH*8)]),
                          .tstrb(tstrb_out[((i+1)*TDATA_WIDTH-1):(i*TDATA_WIDTH)]),
                          .tlast(tlast_out[i]),
                          .tid(tid_out[((i+1)*TID_WIDTH-1):(i*TID_WIDTH)]),
                          .tdest(tdest_out[((i+1)*TDEST_WIDTH-1):(i*TDEST_WIDTH)]),
                          .tuser(tuser_out[((i+1)*TUSER_WIDTH-1):(i*TUSER_WIDTH)]),
                          .memclk(memclk),
                          .memreset(memreset),
                          .din_valid(din_valid_out[i]),
                          .din(din_out[(((i+1)*(8*CROPPED_TDATA_WIDTH+9))-1):(i*(8*CROPPED_TDATA_WIDTH+9))]),
                          .w_almost_full(w_almost_full_out[i]),
                          .wfull(wfull_out[i]), 
                          .cal_done(&cal_done),
                          .rinc(output_inc[i]),
                          .output_fifo_cnt(output_fifo_cnt[(32*i+31):(32*i)])

                          );
    end
    endgenerate

    AxiFifoArbiter #(.TDATA_WIDTH(CROPPED_TDATA_WIDTH),
                     .TUSER_WIDTH(TUSER_WIDTH),
                     .NUM_QUEUES(NUM_QUEUES), 
                     .QUEUE_ID_WIDTH(QUEUE_ID_WIDTH)) 
                  inarb(
                          .clk(clk),
                          .reset(memreset),
                          .memclk(memclk),
                          .inc(rinc_in),
                          .empty(rempty_in), // used to be almost_empty
                          .write_burst(write_burst),
                          .din_valid(dout_valid_in),
                          .din(dout_in),
                          // TODO: maybe remove this comment - not sure if
                          // related to data loss at all
                          .mem_queue_full(mem_wfull/* | (|mem_controller_write_ready)*/),
                          .queue_id(mem_queue_id_write),
                          .dout(mem_dout),
                          .dout_valid(mem_dout_valid)
                       );

    FifoMem       #(.TDATA_WIDTH(CROPPED_TDATA_WIDTH),
                    .TUSER_WIDTH(TUSER_WIDTH),
                    .NUM_QUEUES(NUM_QUEUES), 
                    .QUEUE_ID_WIDTH(QUEUE_ID_WIDTH),
                    .NUM_MEM_INPUTS(NUM_MEM_INPUTS),
                    .NUM_MEM_CHIPS(NUM_MEM_CHIPS),
                    .MEM_WIDTH(MEM_WIDTH),
                    .MEM_ADDR_WIDTH(MEM_ADDR_WIDTH)) 
                  fifomem(
                          .clk(memclk),
                          .reset(memreset),
                          .read_queue_id(mem_queue_id_read),
                          .read_data_queue_id(mem_din_queue_id),
                          .read_data_ready(winc_out[mem_queue_id_read]),
                          .read_data(mem_din),
                          .read_data_valid(mem_din_valid),
                          .read_empty(mem_rempty),
                          .read_burst_state(read_burst), 
                          .write_queue_id(mem_queue_id_write), 
                          .write_data(mem_dout),
                          .write_data_valid(mem_dout_valid),
                          .write_full(mem_wfull), 
                          .next_write_burst_state(write_burst),
// TODO: use standard naming scheme
                          .dout(mem_controller_dout), 
                          .dout_addr(mem_controller_dout_addr),
                          .dout_burst_ready(mem_controller_dout_ready),
                          .din(mem_controller_din), 
                          .din_valid(mem_controller_din_valid),
                          .din_addr(mem_controller_din_addr),
                          .din_ready(mem_controller_din_ready),
                          .sram_write_full(|mem_controller_write_ready),
                          .sram_read_full(|mem_controller_read_ready)
                          );

    localparam IODELAY_GRP = "IODELAY_MIG";
    wire idelay_ctrl_rdy;

    generate
    for(i=0;i<NUM_MEMORY_CHIPS;i=i+1)
    begin : qdrcontrollers
        qdrii_top #(
                .ADDR_WIDTH(MEM_ADDR_WIDTH),
                .BURST_LENGTH(4),
                .BW_WIDTH(MEM_BW_WIDTH),
                .CLK_PERIOD(4000),
                //.CLK_FREQ(160),
                .CLK_WIDTH(MEM_CLK_WIDTH),
                .CQ_WIDTH(MEM_CQ_WIDTH),
                .DATA_WIDTH(MEM_WIDTH),
                .DEBUG_EN(0),
                .HIGH_PERFORMANCE_MODE("TRUE"),
                .IODELAY_GRP(IODELAY_GRP),
                .MEMORY_WIDTH(36),
                .SIM_ONLY(0)) 
               qdrii_controller
               (
                .clk0(memclk),
                .clk180(memclk_180),
                .clk270(memclk_270),
                .user_rst_0(memreset),
                .user_rst_180(memreset_180),
                .user_rst_270(memreset_270),
                .user_ad_w_n(~mem_controller_dout_ready),
                .user_d_w_n(~mem_controller_dout_ready),
                .user_ad_wr(mem_controller_dout_addr),
                .user_bwh_n(4'b0/*{(MEM_BW_WIDTH){~mem_controller_dout_ready}}*/),
                .user_bwl_n(4'b0/*{(MEM_BW_WIDTH){~mem_controller_dout_ready}}*/),
                .user_dwl(mem_controller_dout[((MEM_WIDTH*2*i)+MEM_WIDTH-1):(MEM_WIDTH*2*i)]),
                .user_dwh(mem_controller_dout[((MEM_WIDTH*2)*(i+1)-1):((MEM_WIDTH*2*i)+MEM_WIDTH)]),
                .user_r_n(~mem_controller_din_ready),
                .user_ad_rd(mem_controller_din_addr),         
                .user_wr_full(mem_controller_write_ready[i]),
                .user_rd_full(mem_controller_read_ready[i]),
                .user_qrl(mem_controller_din[((MEM_WIDTH*2*i)+MEM_WIDTH-1):((MEM_WIDTH*2*i))]),
                .user_qrh(mem_controller_din[((MEM_WIDTH*2)*(i+1)-1):((MEM_WIDTH*2*i)+MEM_WIDTH)]),
                .user_qr_valid(mem_controller_din_valid[i]),
                .idelay_ctrl_rdy(idelay_ctrl_rdy),
                .qdr_q(qdr_q[((MEM_WIDTH)*(i+1)-1):((MEM_WIDTH)*i)]), 
                .qdr_cq(qdr_cq[(MEM_CQ_WIDTH*(i+1)-1):(MEM_CQ_WIDTH*i)]), 
                .qdr_cq_n(qdr_cq_n[(MEM_CQ_WIDTH*(i+1)-1):(MEM_CQ_WIDTH*i)]), 
                .qdr_c(qdr_c[(MEM_CLK_WIDTH*(i+1)-1):(MEM_CLK_WIDTH*i)]),
                .qdr_c_n(qdr_c_n[(MEM_CLK_WIDTH*(i+1)-1):(MEM_CLK_WIDTH*i)]),
                .qdr_dll_off_n(qdr_dll_off_n[i]),
                .qdr_k(qdr_k[(MEM_CLK_WIDTH*(i+1)-1):(MEM_CLK_WIDTH*i)]),
                .qdr_k_n(qdr_k_n[(MEM_CLK_WIDTH*(i+1)-1):(MEM_CLK_WIDTH*i)]),
                .qdr_sa(qdr_sa[(MEM_ADDR_WIDTH*(i+1)-1):(MEM_ADDR_WIDTH*i)]),
                .qdr_bw_n(qdr_bw_n[((MEM_BW_WIDTH)*(i+1)-1):((MEM_BW_WIDTH)*i)]),
                .qdr_w_n(qdr_w_n[i]),
                .qdr_d(qdr_d[((MEM_WIDTH)*(i+1)-1):((MEM_WIDTH)*i)]),
                .qdr_r_n(qdr_r_n[i]),
                .cal_done(),//next_cal_done[i]),
                .dbg_idel_up_all        (1'b0),
                .dbg_idel_down_all      (1'b0),
                .dbg_idel_up_q_cq       (1'b0),
                .dbg_idel_down_q_cq     (1'b0),
                .dbg_idel_up_q_cq_n     (1'b0),
                .dbg_idel_down_q_cq_n   (1'b0),
                .dbg_idel_up_cq         (1'b0),
                .dbg_idel_down_cq       (1'b0),
                .dbg_idel_up_cq_n       (1'b0),
                .dbg_idel_down_cq_n     (1'b0),
                .dbg_sel_idel_q_cq      ({MEM_CQ_WIDTH{1'b0}}),
                .dbg_sel_all_idel_q_cq  (1'b0),
                .dbg_sel_idel_q_cq_n    ({MEM_CQ_WIDTH{1'b0}}),
                .dbg_sel_all_idel_q_cq_n  (1'b0),
                .dbg_sel_idel_cq        ({MEM_CQ_WIDTH{1'b0}}),
                .dbg_sel_all_idel_cq    (1'b0),
                .dbg_sel_idel_cq_n      ({MEM_CQ_WIDTH{1'b0}}),
                .dbg_sel_all_idel_cq_n  (1'b0)

);
    end
    endgenerate 

    // TODO: re-add cal done - don't overuse with fanout - only use to get out
    // of an initial state
    always @(posedge memclk)
    begin
        if(memreset)
        begin
            cal_done_interm <= 3'b0;
        end
        else
        begin
            cal_done_interm <= 3'b111;//next_cal_done;
        end
    end

    always @(posedge clk)
    begin
        if(reset)
        begin
            cal_done <= 3'b0;
        end
        else
        begin
            cal_done <= 3'b111;//cal_done_interm;
        end
    end

(* KEEP = "TRUE" *) wire [MASTERBANK_PIN_WIDTH-1:0] masterbank_sel_pin_out/*synthesis syn_keep = 1 */;

  genvar dpw_i;
  generate
    for(dpw_i = 0; dpw_i < MASTERBANK_PIN_WIDTH; dpw_i=dpw_i+1)begin : DUMMY_INST1
      MUXCY DUMMY_INST2
        (
         .O  (masterbank_sel_pin_out[dpw_i]),
         .CI (masterbank_sel_pin[dpw_i]),
         .DI (1'b0),
         .S  (1'b1)
         )/* synthesis syn_noprune = 1 */;
    end
  endgenerate
  


    qdrii_infrastructure #
    (
    )
    u_qdrii_infrastructure
    (
     .sys_rst_n              (!reset),
     .locked                 (locked),
     .user_rst_0             (memreset),
     .user_rst_180           (memreset_180),
     .user_rst_270           (memreset_270),
     .user_rst_200           (memreset_200),
     .idelay_ctrl_rdy        (idelay_ctrl_rdy),
     .clk0                   (memclk),
     .clk180                 (memclk_180),
     .clk270                 (memclk_270),
     .clk200                 (memclk_200)
    );


    qdrii_idelay_ctrl #(.IODELAY_GRP(IODELAY_GRP)) u_qdrii_idelay_ctrl
    (
     .user_rst_200(memreset_200),
     .idelay_ctrl_rdy(idelay_ctrl_rdy),
     .clk200(memclk_200)
    );


    FifoAxiArbiter #(.TDATA_WIDTH(CROPPED_TDATA_WIDTH),
                     .TUSER_WIDTH(TUSER_WIDTH),
                     .NUM_QUEUES(NUM_QUEUES), 
                     .QUEUE_ID_WIDTH(QUEUE_ID_WIDTH)) 
                  outarb(
                          .clk(clk),
                          .reset(memreset),
                          .memclk(memclk),
                          .burst_inc(winc_out), 
                          .full(w_almost_full_out), 
                          .read_burst(read_burst),
                          .din_valid(mem_din_valid),
                          .din(mem_din),
                          .din_queue_id(mem_din_queue_id),
                          .mem_queue_empty(mem_rempty /*| (|mem_controller_read_ready)*/),
                          .queue_id(mem_queue_id_read),
                          .dout(din_out),
                          .dout_valid(din_valid_out)
                          );

endmodule
