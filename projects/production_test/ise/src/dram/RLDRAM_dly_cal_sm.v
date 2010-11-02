//*****************************************************************************
// DISCLAIMER OF LIABILITY
// 
// This text/file contains proprietary, confidential
// information of Xilinx, Inc., is distributed under license
// from Xilinx, Inc., and may be used, copied and/or
// disclosed only pursuant to the terms of a valid license
// agreement with Xilinx, Inc. Xilinx hereby grants you a 
// license to use this text/file solely for design, simulation, 
// implementation and creation of design files limited 
// to Xilinx devices or technologies. Use with non-Xilinx 
// devices or technologies is expressly prohibited and 
// immediately terminates your license unless covered by
// a separate agreement.
//
// Xilinx is providing this design, code, or information 
// "as-is" solely for use in developing programs and 
// solutions for Xilinx devices, with no obligation on the 
// part of Xilinx to provide support. By providing this design, 
// code, or information as one possible implementation of 
// this feature, application or standard, Xilinx is making no 
// representation that this implementation is free from any 
// claims of infringement. You are responsible for 
// obtaining any rights you may require for your implementation. 
// Xilinx expressly disclaims any warranty whatsoever with 
// respect to the adequacy of the implementation, including 
// but not limited to any warranties or representations that this
// implementation is free from claims of infringement, implied 
// warranties of merchantability or fitness for a particular 
// purpose.
//
// Xilinx products are not intended for use in life support
// appliances, devices, or systems. Use in such applications is
// expressly prohibited.
//
// Any modifications that are made to the Source Code are 
// done at the user's sole risk and will be unsupported.
//
// Copyright (c) 2006-2007 Xilinx, Inc. All rights reserved.
//
// This copyright and support notice must be retained as part 
// of this text at all times. 
//*****************************************************************************
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: 1.1
//  \   \         Filename: rld_dly_cal_sm.v
//  /   /         Timestamp: 24 August 2007
// /___/   /\     
// \   \  /  \
//  \___\/\___\
//
//
//	Device:  Virtex-5
//	Purpose: Calibrates the IDELAY tap values for the DQ and QK inputs to allow 
//		capture of the read data into the FPGA clock domain and determines
//		when data is valid using the read enable provided by the memory.
// Revision History:
//   Rev 1.0 - initial release
//   Rev 1.1 - added RL_CK_PERIOD parameter, change to allow more taps for 
//             2nd stage calibration. Paramaterized read data signals to allow
//             clock to data ratios of 1:9 or 1:18, added the X_CORE synthesis 
//             attribute
//*****************************************************************************

`timescale 1ns/100ps

module  rld_dly_cal_sm  (
      clk,              // clock270
      rst,              // rst or Issue calibration signal
      start_cal,        // flag to indicate I can start calibration
      second_stage,     // look for 2nd stage data calibration
      qvld_cal,         // align the QVLD when active high
      wait_for_refresh, // wait while refresh occurs
      rd_data_rise,     // read data rise from ISERDES
      rd_data_fall,     // read data fall from ISERDES
      rd_data_valid,    // QVLD from ISERDES
      rd_data_valid_r,  // QVLD registered 1 clock cycle

      dq_dly_rst,       // Data (DQ) IDELAY controls
      dq_dly_ce,     
      dq_dly_inc,
   
      qk_dly_rst,       // Strobe (QK) IDELAY controls
      qk_dly_ce,
      qk_dly_inc,
   
      first_cal_done,   // first stage of calibration is done
      dly_cal_done,     // calibration is done
      delay_select,     //this indicates data early, aligned, or late with respect to QVLD

      QK_tap_count,     // tap count output of Strobe
      DQ_tap_count,     // tap count output of Data
      test_cal          // Debug port
);

// public parameters -- adjustable
parameter DEV_DQ_WIDTH    = 18;           // data width of the memory device
parameter RL_CK_PERIOD    = 16'd3003;     // CK clock period of the RLDRAM in ps
parameter QK_DATA_WIDTH   = (DEV_DQ_WIDTH == 9)  ?  DEV_DQ_WIDTH : DEV_DQ_WIDTH/2;
// end of public parameters

   input                      clk;              // clock270
   input                      rst;              // rst or Issue calibration signal
   input                      start_cal;        // flag to indicate I can start calibration
   input                      second_stage;     // look for 2nd stage data calibration
   input                      qvld_cal;         // align the QVLD when active high
   input                      wait_for_refresh; // wait while refresh occurs
   input  [QK_DATA_WIDTH-1:0] rd_data_rise;     // read data rise from ISERDES
   input  [QK_DATA_WIDTH-1:0] rd_data_fall;     // read data fall from ISERDES
   input                      rd_data_valid;    // QVLD from ISERDES
   input                      rd_data_valid_r;  // QVLD registered 1 clock cycle

   output                     dq_dly_rst;       // Data (DQ) IDELAY controls
   output                     dq_dly_ce;     
   output                     dq_dly_inc;
   
   output                     qk_dly_rst;       // Strobe (QK) IDELAY controls
   output                     qk_dly_ce;
   output                     qk_dly_inc;
   
   output reg                 first_cal_done;   // first stage of calibration is done
   output reg                 dly_cal_done;     // calibration is done
   output reg [1:0]           delay_select;     //this indicates data early, aligned, or late with respect to QVLD

   output reg [5:0]           QK_tap_count;     // tap count output of Strobe
   output reg [5:0]           DQ_tap_count;     // tap count output of Data
   output    [127:0]          test_cal;         // Debug port

// PRIVATE Parameters -- Do not change
parameter DQ_TAP_END  = 6'd60;
parameter QK_TAP_END  = 6'd63;
parameter WINDOW_SIZE = 6'd12;
parameter WINDOW_SIZE2 = ( RL_CK_PERIOD < 16'd4000 ) ? 6'd15 : 6'd20;
parameter WINDOW_SIZE3 = 6'd20;

parameter ALIGNED = 2'b00;
parameter EARLY   = 2'b01;
parameter LATE    = 2'b10;

// patterns used for write data -- PRIVATE
parameter data1 = 9'hFFF;   // 9'h1FF  is  1_1111_1111
parameter data2 = 9'h000;   // 9'h000  is  0_0000_0000
parameter data3 = 9'h0AA;   // 9'h0AA  is  0_1010_1010
parameter data4 = 9'h155;   // 9'h155  is  1_0101_0101

// First write data  : { data1, data2 } = { 1_1111_1111, 0_0000_0000 } = "3FE00" 
// Second write data : { data3, data4 } = { 0_1010_1010, 1_0101_0101 } = "15555"  

//  XCORE Synthesis attribute 
//  synthesis attribute X_CORE_INFO of rld_dly_cal_sm is "rld_dly_cal_sm, V5_rldram2_phy_verilog";

reg dly_rst;
reg dly_inc;
reg dly_ce;

reg       cal_begin;
reg [5:0] start_cal_r;

reg       qk_flag;
reg       dq_flag;

reg [1:0] tap_cmd;

reg       tap_wait_en;
reg [2:0] tap_wait_cnt;

reg dq_error;
reg dq_error2;

reg first_edge_found;
reg second_edge_found;
reg rst_flags;
reg rst_flags_r;
reg [2:0] set_center;

reg dly_rst_r;
reg end_of_taps;
reg DQ_bigger;
reg DQ_bigger_r;
reg QK_bigger;
reg QK_bigger_r;
reg valid_found;

reg DQ_centered;
reg QK_centered;
reg DQ_centered_r;
reg QK_centered_r;

reg first_edge_detect, first_edge_detect_r;
reg second_edge_detect, second_edge_detect_r;

reg [5:0]   QK_tap_left;
reg [5:0]   QK_tap_window;
reg [5:0]   QK_tap_center;

reg [5:0]   DQ_tap_left;
reg [5:0]   DQ_tap_window;
reg [5:0]   DQ_tap_center;

reg [5:0]   tap_center;
reg [5:0]   tap_range;

reg inc_up;
reg inc_up2;

//Working Registers
reg [5:0]   QK_tap_center_WORK;
reg [5:0]   DQ_tap_center_WORK;
reg [5:0]   QK_tap_center_WORK_r;
reg [5:0]   DQ_tap_center_WORK_r;

reg [5:0] QK_tap_count_r;
reg [5:0] DQ_tap_count_r;

wire [5:0]  tap_range_center; //not registered, just shifted
wire        dly_rst_w;
wire [2*QK_DATA_WIDTH-1:0] rd_data;
wire [2*QK_DATA_WIDTH-1:0] first_check_data;
wire [2*QK_DATA_WIDTH-1:0] second_check_data;
wire        dq_error3;

// State machine parameters -- PRIVATE
parameter [3:0]
  IDLE     = 4'b0000,   // 000
  TAP_INC  = 4'b0001,   // 001
  TAP_DEC  = 4'b0010,   // 002
  TAP_RST  = 4'b0100,   // 004
  TAP_WAIT = 4'b1000;   // 008

parameter [11:0]
  Reset   = 12'b0000_0000_0000, //000
  QK_INC  = 12'b0000_0000_0001, //001
  QK_RST  = 12'b0000_0000_0010, //002
  DQ_INC  = 12'b0000_0000_0100, //004
  DQ_RST  = 12'b0000_0000_1000, //008
  Center  = 12'b0000_0001_0000, //010
  F_Done  = 12'b0000_0010_0000, //020
  Both_INC= 12'b0000_0100_0000, //040
  Both_DEC= 12'b0000_1000_0000, //080
  DQ_DEC  = 12'b0001_0000_0000, //100
  DQ_INC2 = 12'b0010_0000_0000, //200
  DQ_CENT = 12'b0100_0000_0000, //400
  S_Done  = 12'b1000_0000_0000; //800
// End of PRIVATE state machine variables

// Command Parameters -- PRIVATE
parameter [1:0]
  TAP_CMD_NOP  = 2'b00,
  TAP_CMD_RST  = 2'b01,
  TAP_CMD_DEC  = 2'b10,
  TAP_CMD_INC  = 2'b11;

//IDELAY state variables
reg  [3:0]    id_cs;
reg  [3:0]    id_ns;

//First SM state variables
reg  [11:0]    f_cs;
reg  [11:0]    f_ns;

//assign outputs for IDELAY based on flags
assign qk_dly_rst = ( qk_flag ) ? dly_rst_w : 1'b0;
assign qk_dly_ce  = ( qk_flag ) ? dly_ce    : 1'b0;
assign qk_dly_inc = ( qk_flag ) ? dly_inc   : 1'b0;

assign dq_dly_rst = ( dq_flag ) ? dly_rst_w : 1'b0;
assign dq_dly_ce  = ( dq_flag ) ? dly_ce    : 1'b0;
assign dq_dly_inc = ( dq_flag ) ? dly_inc   : 1'b0;

   wire [2*QK_DATA_WIDTH-1:0] rd_data_orig, first_check_data_orig, second_check_data_orig;
   // -----------------------------------------------------------------------------
   // Concatenate read data { QK_DATA_WIDTH-bit RISE : QK_DATA_WIDTH-bit FALL } before comparing with patterns
   // -----------------------------------------------------------------------------
   assign rd_data_orig = {rd_data_rise, rd_data_fall};  // read data
   
   //Concatonate the Data for checking
   assign first_check_data_orig  = { {QK_DATA_WIDTH/9{data1}}, {QK_DATA_WIDTH/9{data2}} };
   assign second_check_data_orig = { {QK_DATA_WIDTH/9{data3}}, {QK_DATA_WIDTH/9{data4}} };

   //Don't care bit 9. Only last 8 bit considered
   assign rd_data = {1'b0, rd_data_orig[34-:8],
		     1'b0, rd_data_orig[25-:8],
		     1'b0, rd_data_orig[16-:8],
		     1'b0, rd_data_orig[ 7-:8]
		    };

   assign first_check_data = {1'b0, first_check_data_orig[34-:8],
		     	      1'b0, first_check_data_orig[25-:8],
		     	      1'b0, first_check_data_orig[16-:8],
		     	      1'b0, first_check_data_orig[ 7-:8]
		    	     };

   assign second_check_data = {1'b0, second_check_data_orig[34-:8],
		     	       1'b0, second_check_data_orig[25-:8],
		     	       1'b0, second_check_data_orig[16-:8],
		     	       1'b0, second_check_data_orig[ 7-:8]
		    	      };
                           
   // -----------------------------------------------------------------------------
   // Test Signals used for debugging
   // -----------------------------------------------------------------------------
   //assign test_cal[127:0] = { 128'b0 };
   assign test_cal[127:0] = { 128'b0,
                              //valid_found,                                              // 73
                              //QK_tap_center, DQ_tap_center,                                 // [72:67], [66:61]
                              12'b0,
                              //QK_tap_left, DQ_tap_left,                                     // [60:55], [54:49]
                              12'b0,
                              QK_tap_count, DQ_tap_count,                                   // [48:43], [42:37]
                              first_cal_done, second_stage, dly_cal_done,                   // 36, 35, 34
                              rst_flags, first_edge_detect, second_edge_detect, end_of_taps,// 33, 32, 31, 30
                              wait_for_refresh, dq_error3, dq_error2, dq_error,              // 29, 28, 27, 26
                              //delay_select, dq_error3, dq_error2, dq_error,              // 29, 28, 27, 26
                              //tap_cmd, f_ns, f_cs                                           // [25:24], [23:12], [11:0]
                              2'b0, 12'b0, f_cs                                           // [25:24], [23:12], [11:0]
                            };


   // -----------------------------------------------------------------------------
   // Hold the IDELAY reset signal one extra clock cycle
   // -----------------------------------------------------------------------------
   always @( posedge clk )
   begin
      if ( rst )
         dly_rst_r <= 1'b0;
      else
         dly_rst_r <= dly_rst;
   end 
   
   assign dly_rst_w = dly_rst | dly_rst_r;

   // -----------------------------------------------------------------------------
   // Delay the start signal
   // -----------------------------------------------------------------------------
   always @( posedge clk )
   begin
      if ( rst )
      begin
         start_cal_r[0]  <= 1'b0;
         start_cal_r[1]  <= 1'b0;
         start_cal_r[2]  <= 1'b0;
         start_cal_r[3]  <= 1'b0;
         start_cal_r[4]  <= 1'b0;
         start_cal_r[5]  <= 1'b0;
      end
      else
      begin
         start_cal_r[0]  <= start_cal;
         start_cal_r[1]  <= start_cal_r[0];
         start_cal_r[2]  <= start_cal_r[1];
         start_cal_r[3]  <= start_cal_r[2];
         start_cal_r[4]  <= start_cal_r[3];
         start_cal_r[5]  <= start_cal_r[4];
      end
   end


   always @( posedge clk )
   begin
      if ( rst )
        cal_begin <= 1'b0;
      else if ( start_cal_r[4] && !start_cal_r[5] )
        cal_begin <= 1'b1;
      else if ( dly_inc )
        cal_begin <= 1'b0;
      else 
        cal_begin <= cal_begin;
   end 

  // -----------------------------------------------------------------------------
  // Determine how the data lines up with the QVLD
  // -----------------------------------------------------------------------------
  always @ (posedge clk)
  begin
    if ( rst ) begin
      delay_select  <= ALIGNED;
      valid_found   <= 1'b0;
    end else if ( !valid_found && qvld_cal && rd_data_valid && !rd_data_valid_r) begin
      valid_found <= 1'b1;
      if ( rd_data == first_check_data )
        delay_select <= ALIGNED;
      else if ( rd_data == second_check_data )
        delay_select <= EARLY;
      else
        delay_select <= LATE;
    end else begin
      delay_select <= delay_select;
      valid_found <= valid_found;
    end
  end 

   // -----------------------------------------------------------------------------
   // Update the Error signal when data is valid
   // Check the 1st SDR data for error
   // -----------------------------------------------------------------------------
   always @ ( posedge clk )
   begin
      if ( rst )
         dq_error <= 1'b0;
      else if ( tap_wait_cnt >=3'b110 && !wait_for_refresh) //only check data when IDLE to ensure settled
        if ( rd_data == first_check_data )
          dq_error <= 1'b0;
        else
          dq_error <= 1'b1;
      else
        dq_error <= dq_error;
   end 

   // -----------------------------------------------------------------------------
   // Check the 2nd SDR data for error
   // -----------------------------------------------------------------------------
   always @ ( posedge clk )
   begin
     if ( rst )
        dq_error2 <= 1'b0;
     else if ( tap_wait_cnt >=3'b110 && !wait_for_refresh ) begin
        if ( rd_data == second_check_data )
          dq_error2 <= 1'b0;
        else
          dq_error2 <= 1'b1;
      end else
          dq_error2 <= dq_error2;  // hold the previous value
   end 
   
   assign dq_error3 = (second_stage) ? dq_error && dq_error2 : dq_error;  //TESTING

   // -----------------------------------------------------------------------------
   // State machine (registers)
   // -----------------------------------------------------------------------------
   always @( posedge clk )
   begin
      if ( rst )
         id_cs <= TAP_RST;  // reset tap count, works for system reset and re-calibration
      else
         id_cs <= id_ns;
   end

   // -----------------------------------------------------------------------------
   // State machine (combinatorial logic)
   // -----------------------------------------------------------------------------
   always @ *
   begin
      dly_rst     <= 1'b0;
      dly_ce      <= 1'b0;
      dly_inc     <= 1'b0;
      tap_wait_en <= 1'b0;
   
      case ( id_cs )
      // ----------------------------------------------------------------
         IDLE : //000
      // ----------------------------------------------------------------
         begin
            dly_rst     <= 1'b0;
            dly_ce      <= 1'b0;
            dly_inc     <= 1'b0;
            tap_wait_en <= 1'b0;
             
            if ( tap_cmd == TAP_CMD_RST )
              id_ns  <= TAP_RST;
            else if ( tap_cmd == TAP_CMD_INC )
              id_ns <= TAP_INC;
            else if ( tap_cmd == TAP_CMD_DEC )
              id_ns <= TAP_DEC;
            else
              id_ns  <= IDLE;
            
         end
      // ----------------------------------------------------------------
         TAP_INC :  //001
      // ----------------------------------------------------------------
         begin
            dly_rst     <= 1'b0;
            dly_ce      <= 1'b1;
            dly_inc     <= 1'b1;
            tap_wait_en <= 1'b1;
   
            id_ns  <= TAP_WAIT;
         end    
      // ----------------------------------------------------------------
         TAP_DEC :  //002
      // ----------------------------------------------------------------
         begin
            dly_rst     <= 1'b0;
            dly_ce      <= 1'b1;
            dly_inc     <= 1'b0;
            tap_wait_en <= 1'b1;
   
            id_ns  <= TAP_WAIT;
         end
      // ----------------------------------------------------------------
         TAP_RST :  //004
      // ----------------------------------------------------------------
         begin
            dly_rst     <= 1'b1;
            dly_ce      <= 1'b0;
            dly_inc     <= 1'b0;
            tap_wait_en <= 1'b1;
   
            id_ns  <= TAP_WAIT;
         end
      // ----------------------------------------------------------------
         TAP_WAIT : //008
      // ----------------------------------------------------------------
         begin
            dly_rst     <= 1'b0;
            dly_ce      <= 1'b0;
            dly_inc     <= 1'b0;
            tap_wait_en <= 1'b0;
   
            if ( tap_wait_cnt == 3'b111 )
               id_ns <= IDLE;
            else
               id_ns <= TAP_WAIT;
         end
      // ----------------------------------------------------------------
         default :
      // ----------------------------------------------------------------
            id_ns <= IDLE;
      endcase
   end

   // -----------------------------------------------------------------------------
   // Wait counter used to allow IDELAY settling time 
   // -----------------------------------------------------------------------------
   always @( posedge clk )
   begin
      if ( rst || !start_cal_r[5] )
        tap_wait_cnt <= 3'b000;
      else if ( (tap_wait_cnt != 3'b111) || (tap_wait_en) )
        tap_wait_cnt <= tap_wait_cnt + 1;
      else
        tap_wait_cnt <= tap_wait_cnt;
   end

   // -----------------------------------------------------------------------------
   // State machine (registers)
   // -----------------------------------------------------------------------------
   always @( posedge clk )
   begin
      if ( rst )
         f_cs <= Reset; //want to start out in RST
      else
         f_cs <= f_ns;
   end

   always @ *
   begin
      case ( f_cs )
      // ----------------------------------------------------------------
         Reset :  //000
      // ----------------------------------------------------------------
         begin
            if ( cal_begin && tap_wait_cnt >= 3'b110)
              f_ns <= QK_INC;
            else
              f_ns  <= Reset;
         end
      // ----------------------------------------------------------------
         QK_INC : //001
      // ----------------------------------------------------------------
      // Increment QK to determine taps till edge of data valid window & save results
         begin
            if ( first_edge_found && second_edge_found )
              f_ns  <= QK_RST;
            else
              f_ns  <= QK_INC;
         end  
       // ----------------------------------------------------------------
         QK_RST : //002
      // ----------------------------------------------------------------
      // Decrement QK back down to 0
         begin
            //Decrement Down to Zero instead of relying on RST
            if ( QK_tap_count == 6'b0 )
              f_ns  <= DQ_INC;
            else
              f_ns  <= QK_RST;
         end        
      // ----------------------------------------------------------------
         DQ_INC : //004
      // ----------------------------------------------------------------
      // Increment DQ to determine taps till edge of data valid window & save results
         begin
            if ( first_edge_found && second_edge_found )
              f_ns  <= DQ_RST;
            else
              f_ns  <= DQ_INC;
         end
       // ----------------------------------------------------------------
         DQ_RST : //008
      // ----------------------------------------------------------------
      // Decrement DQ back down to 0
         begin
            //Decrement Down to Zero instead of relying on RST
            if ( DQ_tap_count == 6'b0 )
              f_ns  <= Center;
            else
              f_ns  <= DQ_RST;
         end    
      // ----------------------------------------------------------------
         Center : //010
      // ----------------------------------------------------------------
      // Center QK in the DQ data valid window
         begin
            
           if ( DQ_bigger && !DQ_centered_r )    //increment DQ
                f_ns  <= Center;
           else if ( QK_bigger && !QK_centered_r )    //increment DQ
                f_ns  <= Center;
           else  
              f_ns  <= F_Done;         //windows are the same, centered already
   
         end
      // ----------------------------------------------------------------
         F_Done : //020
      // ----------------------------------------------------------------
      // 1st stage calibration complete, wait for 2nd stage to begin
         begin
            if ( second_stage )
              f_ns <= Both_INC;
            else
              f_ns <= F_Done;
         end
      // ----------------------------------------------------------------
         Both_INC : //040
      // ----------------------------------------------------------------
      // Increment both QK/DQ to determine relation to FPGA clock (transfer clock domains)
         begin
          if ( first_edge_found && second_edge_found )
            f_ns <= Both_DEC;
          else
            f_ns <= Both_INC;
         end   
      // ----------------------------------------------------------------
         Both_DEC : //080
      // ----------------------------------------------------------------
      // Center QK/DQ together to transfer clock domains to FPGA clock
         begin
          if ( QK_centered_r )
            f_ns <= S_Done;
          else
            f_ns <= Both_DEC;
         end
      // ----------------------------------------------------------------
         DQ_DEC : //100
      // ----------------------------------------------------------------
      // Decrement DQ till 0 or error to move DQ around QK one last time
      // Later this can be changed to Per-Bit Calibration if needed
         begin
          if ( DQ_tap_count == 6'b0 || dq_error3 )
            f_ns <= DQ_INC2;
          else
            f_ns <= DQ_DEC;
         end
      // ----------------------------------------------------------------
         DQ_INC2 : //200
      // ----------------------------------------------------------------
      // Increment DQ until window found
         begin
           if ( first_edge_found && second_edge_found && tap_range >= WINDOW_SIZE)
              f_ns <= DQ_CENT;
           else
              f_ns <= DQ_INC2;
         end         
      // ----------------------------------------------------------------
         DQ_CENT : //400
      // ----------------------------------------------------------------
      // Center DQ in the data valid window
         begin
          if ( DQ_centered_r )
            f_ns <= S_Done;
          else
            f_ns <= DQ_CENT;
         end            
      // ----------------------------------------------------------------
         S_Done : //800
      // ----------------------------------------------------------------
      // Calibration Done, wait here till reset.
         begin
          if ( rst )
            f_ns <= Reset;
          else
            f_ns <= S_Done; 
         end
      // ----------------------------------------------------------------
         default :
      // ----------------------------------------------------------------
              f_ns <= Reset;
      endcase
   end
   
   //output generation
   always @ (posedge clk)
   begin
      case ( f_cs )
      // ----------------------------------------------------------------
         Reset :  //000
      // ----------------------------------------------------------------
         begin
            first_cal_done <= 1'b0; dly_cal_done <= 1'b0;
            rst_flags <= 1'b1;                  //reset the edge detection flags
            qk_flag <= 1'b1;  dq_flag <= 1'b1;  //determine who gets a signal (one or both)
            
            tap_cmd <= TAP_CMD_RST;

            QK_tap_left   <= 6'b0;   DQ_tap_left   <= 6'b0;
            QK_tap_window  <= 6'b0;  DQ_tap_window  <= 6'b0;
            QK_tap_center  <= 6'b0;  DQ_tap_center  <= 6'b0;
            
            first_edge_found <= 1'b0;
            second_edge_found <= 1'b0;
            
            tap_center <= 6'b0;
            
            set_center <= 3'b0;
         end
      // ----------------------------------------------------------------
         QK_INC : //001
      // ----------------------------------------------------------------
         begin
            first_cal_done <= 1'b0; dly_cal_done <= 1'b0;
            rst_flags <= 1'b0;
            qk_flag <= 1'b1;  dq_flag <= 1'b0;
            
            if (QK_tap_count >= 6'd10 && !first_edge_detect ) begin
              first_edge_found <= 1'b1;
              second_edge_found <= 1'b1;
            end else if (first_edge_detect && !first_edge_detect_r) begin
              QK_tap_left <= QK_tap_count;
              first_edge_found <= 1'b1;
            end else if ( second_edge_detect && !second_edge_detect_r) begin
              QK_tap_window <= tap_range;
              second_edge_found <= 1'b1;
            end 
            
            if (wait_for_refresh) 
            begin
              tap_cmd <= TAP_CMD_NOP;
            end else begin
              tap_cmd <= TAP_CMD_INC;
            end
         end    
      // ----------------------------------------------------------------
         QK_RST : //002
      // ----------------------------------------------------------------
         begin
            first_cal_done <= 1'b0; dly_cal_done <= 1'b0;
            rst_flags <= 1'b1;            
            qk_flag <= 1'b1;  dq_flag <= 1'b0;

            first_edge_found  <= 1'b0;
            second_edge_found <= 1'b0;
            
            tap_cmd <= TAP_CMD_DEC;
         end      
      // ----------------------------------------------------------------
         DQ_INC : //004
      // ----------------------------------------------------------------
         begin
            first_cal_done <= 1'b0; dly_cal_done <= 1'b0;
            rst_flags <= 1'b0;
            qk_flag <= 1'b0;  dq_flag <= 1'b1;
            
            if (first_edge_detect && !first_edge_detect_r) begin
              DQ_tap_left <= DQ_tap_count;
              first_edge_found <= 1'b1;
            end else if ( second_edge_detect && !second_edge_detect_r) begin
              DQ_tap_window <= tap_range;
              tap_center <= (tap_range + QK_tap_window) >> 1;
              
              if ( tap_range < (WINDOW_SIZE>>1) && !end_of_taps) begin //check for at least small window
                second_edge_found <= 1'b0;
                rst_flags <= 1'b1;
              end else begin
                second_edge_found <= 1'b1;
                rst_flags <= 1'b0;
              end
            end 

            if (wait_for_refresh) 
            begin
              tap_cmd <= TAP_CMD_NOP;
            end else begin
              tap_cmd <= TAP_CMD_INC;
            end
         end
      // ----------------------------------------------------------------
         DQ_RST : //008
      // ----------------------------------------------------------------
         begin
            first_cal_done <= 1'b0; dly_cal_done <= 1'b0;
            rst_flags <= 1'b1;            
            qk_flag <= 1'b0;  dq_flag <= 1'b1;

            first_edge_found  <= 1'b0;
            second_edge_found <= 1'b0;
            
            if (set_center!=3'b111)
              set_center <= set_center + 1;
              
            if ( set_center == 3'b100 ) begin
                //DQ_tap_center <= DQ_tap_center_WORK;
                //QK_tap_center <= QK_tap_center_WORK;
                DQ_tap_center <= DQ_tap_center_WORK_r;
                QK_tap_center <= QK_tap_center_WORK_r;
            end

            tap_cmd <= TAP_CMD_DEC;
         end   
      // ----------------------------------------------------------------
         Center : //010
      // ----------------------------------------------------------------
         begin
            first_cal_done <= 1'b0; dly_cal_done <= 1'b0;
            rst_flags <= 1'b1; 
            
            if ( DQ_bigger_r ) begin //increment DQ
              qk_flag <= 1'b0;  dq_flag <= 1'b1;
              tap_cmd <= TAP_CMD_INC;
            end else if ( QK_bigger_r ) begin //increment QK
              qk_flag <= 1'b1;  dq_flag <= 1'b0;
              tap_cmd <= TAP_CMD_INC;
            end else begin  //windows are the same, centered already
              qk_flag <= 1'b0;  dq_flag <= 1'b0;
              tap_cmd <= TAP_CMD_NOP;
            end
         end
      // ----------------------------------------------------------------
         F_Done : //020
      // ----------------------------------------------------------------
      //First stage of calibration is done, QK placed in center of DQ
         begin
            first_cal_done <= 1'b1; dly_cal_done <= 1'b0;
            rst_flags <= 1'b1; 
            qk_flag <= 1'b0;  dq_flag <= 1'b0;
            
            //need to set this as a default value
            //need to ensure the algorithm doesn't think it is centered right away
            QK_tap_center <= 6'd63;  
            
            tap_cmd <= TAP_CMD_NOP;
         end
      // ----------------------------------------------------------------
         Both_INC : //040
      // ----------------------------------------------------------------
         begin
            first_cal_done <= 1'b1; dly_cal_done <= 1'b0;
            rst_flags <= 1'b0; 
            qk_flag <= 1'b1;  dq_flag <= 1'b1;
            
            if (first_edge_detect && !first_edge_detect_r) begin
              QK_tap_left <= QK_tap_count;
              DQ_tap_left <= DQ_tap_count;
              first_edge_found <= 1'b1;
            end else if ( second_edge_detect && !second_edge_detect_r) begin
               second_edge_found <= 1'b1;
               if ( ~inc_up2 )
                  QK_tap_center <= QK_tap_count - WINDOW_SIZE3;  //decrement farther away from edge
               else if ( inc_up )
                  QK_tap_center <= QK_tap_count + WINDOW_SIZE2;  //increment away from edge
               else
                  QK_tap_center <= QK_tap_count - WINDOW_SIZE2;  //decrement away from edge
            end
            
            if (wait_for_refresh)  begin
              tap_cmd <= TAP_CMD_NOP;
            end else begin
              tap_cmd <= TAP_CMD_INC;
            end
         end
      // ----------------------------------------------------------------
         Both_DEC : //080
      // ----------------------------------------------------------------
         begin
          first_cal_done <= 1'b1; dly_cal_done <= 1'b0;
          rst_flags <= 1'b0;          
          qk_flag <= 1'b1;  dq_flag <= 1'b1;
          
          if (QK_tap_center < QK_tap_count ) //want to inc or decrement away from edge
            tap_cmd <= TAP_CMD_DEC;      
          else
            tap_cmd <= TAP_CMD_INC;
         end
      // ----------------------------------------------------------------
         DQ_DEC : //100
      // ----------------------------------------------------------------
         begin
          first_cal_done <= 1'b1; dly_cal_done <= 1'b0;
          rst_flags <= 1'b1; 
          qk_flag <= 1'b0;  dq_flag <= 1'b1;
          
          first_edge_found <= 1'b0;
          second_edge_found <= 1'b0;
          
          if ( wait_for_refresh )
            tap_cmd <= TAP_CMD_NOP;
          else
            tap_cmd <= TAP_CMD_DEC;                     
         end
      // ----------------------------------------------------------------
         DQ_INC2 : //200
      // ----------------------------------------------------------------
         begin
            first_cal_done <= 1'b1; dly_cal_done <= 1'b0;
            rst_flags <= 1'b0;
            qk_flag <= 1'b0;  dq_flag <= 1'b1;
            
            if (first_edge_detect && !first_edge_detect_r) begin
              DQ_tap_left <= DQ_tap_count;
              first_edge_found <= 1'b1;
            end else if ( second_edge_detect && !second_edge_detect_r) begin
              DQ_tap_window <= tap_range;
              DQ_tap_center <= DQ_tap_left + tap_range_center;
              second_edge_found <= 1'b1;
            end if ( second_edge_detect && tap_range < WINDOW_SIZE) begin
              rst_flags <= 1'b1;
              first_edge_found <= 1'b0;
              second_edge_found <= 1'b0;
            end 
            
            if (wait_for_refresh) 
            begin
              tap_cmd <= TAP_CMD_NOP;
            end else begin
              tap_cmd <= TAP_CMD_INC;
            end
         end         
      // ----------------------------------------------------------------
         DQ_CENT : //400
      // ----------------------------------------------------------------
         begin
          first_cal_done <= 1'b1; dly_cal_done <= 1'b0;
          rst_flags <= 1'b0; 
          qk_flag <= 1'b0;  dq_flag <= 1'b1;
          
          tap_cmd <= TAP_CMD_DEC;                  
         end            
      // ----------------------------------------------------------------
         S_Done : //800
      // ----------------------------------------------------------------
         begin

          first_cal_done <= 1'b1; dly_cal_done <= 1'b1;
          rst_flags <= 1'b0; 
          qk_flag <= 1'b0;  dq_flag <= 1'b0;
          
          tap_cmd <= TAP_CMD_NOP;
         end        
      // ----------------------------------------------------------------
         default :
      // ----------------------------------------------------------------
         begin
            first_cal_done <= 1'b0; dly_cal_done <= 1'b0;
            rst_flags <= 1'b1;                  //reset the edge detection flags
            qk_flag <= 1'b1;  dq_flag <= 1'b1;  //determine who gets a signal (one or both)
            
            tap_cmd <= TAP_CMD_RST;

            QK_tap_left   <= 6'b0;   DQ_tap_left   <= 6'b0;
            QK_tap_window  <= 6'b0;  DQ_tap_window  <= 6'b0;
            QK_tap_center  <= 6'b0;  DQ_tap_center  <= 6'b0;
            
            first_edge_found <= 1'b0;
            second_edge_found <= 1'b0;
            
            tap_center <= 6'b0;
            
            set_center <= 3'b0;
         end
      endcase
   end
   
   // -----------------------------------------------------------------------------
   // First edge of the data valid window found
   // -----------------------------------------------------------------------------
   always @( posedge clk )
   begin
      if ( rst || rst_flags_r )
         first_edge_detect <= 1'b0;
      else if ( (!dq_error3 && tap_wait_cnt ==3'b111 && !wait_for_refresh) || end_of_taps)
         first_edge_detect <= 1'b1;
      else
         first_edge_detect <= first_edge_detect;
   end 

   // -----------------------------------------------------------------------------
   // Second Edge of the data valid window found
   // -----------------------------------------------------------------------------
   always @( posedge clk )
   begin
      if ( rst || rst_flags_r )
         second_edge_detect <= 1'b0;
      else if ( (dq_error3 && first_edge_detect && !wait_for_refresh) || end_of_taps )
         second_edge_detect <= 1'b1;
      else
         second_edge_detect <= second_edge_detect;
   end 

   always @( posedge clk )
   begin
      if ( rst || rst_flags_r )
      begin
         first_edge_detect_r  <= 1'b0;
         second_edge_detect_r <= 1'b0;
      end
      else
      begin
         first_edge_detect_r  <= first_edge_detect;
         second_edge_detect_r <= second_edge_detect;
       end
   end 

   // -----------------------------------------------------------------------------
   // Separate tap counts for Strobe since is incremented seperatly from data
   // -----------------------------------------------------------------------------
   always @( posedge clk )
   begin
      if ( qk_dly_rst )
        QK_tap_count <= 6'b000000;
      else if ( qk_dly_ce && qk_dly_inc )
        QK_tap_count <= QK_tap_count + 1;
      else if ( qk_dly_ce && !qk_dly_inc )
        QK_tap_count <= QK_tap_count - 1;
      else
        QK_tap_count <= QK_tap_count;
   end

   always @( posedge clk )
   begin
      if ( dq_dly_rst )
        DQ_tap_count <= 6'b000000;
      else if ( dq_dly_ce && dq_dly_inc )
        DQ_tap_count <= DQ_tap_count + 1;
      else if ( dq_dly_ce && !dq_dly_inc )
        DQ_tap_count <= DQ_tap_count - 1;
      else
        DQ_tap_count <= DQ_tap_count;
   end

   // -----------------------------------------------------------------------------
   // End of taps flag used to ensure we do not increment taps too much
   // way to avoid tap jitter on data lines (clocks do not have pattern jitter)
   // -----------------------------------------------------------------------------
   always @( posedge clk )
   begin
      if ( rst || rst_flags_r )
         end_of_taps <= 1'b0;
      else if ( DQ_tap_count >= DQ_TAP_END || QK_tap_count >= QK_TAP_END )
         end_of_taps <= 1'b1;
      else
         end_of_taps <= end_of_taps;
   end 

   always @( posedge clk )
   begin
      if ( rst_flags_r )
         tap_range <= 6'b0;
      else if ( dly_inc && first_edge_detect && !second_edge_detect )
         tap_range <= tap_range + 1;
   end

   assign tap_range_center = tap_range >> 1;  // divide the count by 2, get the center value
   
   // -----------------------------------------------------------------------------
   // Want to Register Comparisons for better timing
   // -----------------------------------------------------------------------------
  always @ (posedge clk)
  begin
    if ( DQ_tap_window > QK_tap_window ) begin
      DQ_bigger <= 1'b1;
      QK_bigger <= 1'b0;
    end else if ( DQ_tap_window < QK_tap_window ) begin
      DQ_bigger <= 1'b0;
      QK_bigger <= 1'b1;
    end else begin
      DQ_bigger <= 1'b0;
      QK_bigger <= 1'b0;
    end
  end
  
  always @ (posedge clk)
  begin
      DQ_bigger_r <= DQ_bigger;
      QK_bigger_r <= QK_bigger;
  end
  
  always @ (posedge clk)
  begin
    if ( DQ_tap_count == DQ_tap_center )
      DQ_centered <= 1'b1;
    else
      DQ_centered <= 1'b0;
  end
  
  always @ (posedge clk)
  begin
    if ( QK_tap_count == QK_tap_center )
      QK_centered <= 1'b1;
    else
      QK_centered <= 1'b0;
  end
  
  always @ (posedge clk)
  begin
      DQ_centered_r <= DQ_centered;
      QK_centered_r <= QK_centered;
      rst_flags_r <= rst_flags;
  end
  
  //working registers perform temp calcs
  always @ (posedge clk)
  begin
      DQ_tap_center_WORK_r <= DQ_tap_center_WORK;
      QK_tap_center_WORK_r <= QK_tap_center_WORK;
    if (set_center == 3'b001) begin
      DQ_tap_center_WORK <= DQ_tap_window - tap_center;
      QK_tap_center_WORK <= QK_tap_window - tap_center;
    end else if ( set_center == 3'b010 ) begin
      DQ_tap_center_WORK <= DQ_tap_center_WORK + DQ_tap_left;
      QK_tap_center_WORK <= QK_tap_center_WORK + QK_tap_left;
    end else begin
      DQ_tap_center_WORK <= DQ_tap_center_WORK;
      QK_tap_center_WORK <= QK_tap_center_WORK;
    end
  end

  always @ (posedge clk)
  begin
      QK_tap_count_r <= QK_tap_count;
      DQ_tap_count_r <= DQ_tap_count;
  end
  
  //determine if we increment up or down when we find an edge for the 2nd stage transfer
  always @ (posedge clk)
  begin
   if ( QK_bigger_r ) begin
      if ( DQ_tap_count_r < (DQ_tap_left + WINDOW_SIZE2) )
         inc_up <= 1'b1;
      else
         inc_up <= 1'b0;
   end else begin //DQ has more taps then QK
      if ( QK_tap_count_r < (QK_tap_left + WINDOW_SIZE2) )
         inc_up <= 1'b1;
      else
         inc_up <= 1'b0;
   end
  end 
  
  //Want to check if we can decrement away even more than the minimum for better margin for 2nd stage
  always @ (posedge clk)
  begin
   if ( QK_bigger_r ) begin
      if ( DQ_tap_count_r < (DQ_tap_left + WINDOW_SIZE3) )
         inc_up2 <= 1'b1;
      else
         inc_up2 <= 1'b0;
   end else begin //DQ has more taps then QK
      if ( QK_tap_count_r < (QK_tap_left + WINDOW_SIZE3) )
         inc_up2 <= 1'b1;
      else
         inc_up2 <= 1'b0;
   end
  end

endmodule
