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
//  \   \         Filename: rld_phy_calib.v
//  /   /         Timestamp: 24 August 2007
// /___/   /\     
// \   \  /  \
//  \___\/\___\
//
//
//	Device:  Virtex-4 and Virtex-5
//	Purpose: This module creates dummy read and write data for phy calibration  
// 		by writing data to FIFOs for processing by the controller.
//		It supports BL=2 & BL=4.
// Revision History:
//   Rev 1.0 - initial release
//   Rev 1.1 - Registered some of the FIFO control signals for better timing,
//             fixed issue with Config3/BL4 not producing back-to-back reads
//
//  Definition of "apAddr[25:0]" the user application address interface
//    [25]    [24]    [23]     [22:3]  [2:0]
//  user_ref, W-/R, reserved, address,  ba
//
//  bit[25]    user_ref  (0=disable user refresh i.e. automatic AREF; 1=enable user refresh)
//  bit[24]    W-/R      (0=write command; 1=read command)
//  bit[23]    reserved  (1'b0)
//  bit[22:3]  address   (fixed 20-bit memory address)
//  bit[2:0]   ba        (3-bit memory bank address)
//
//*****************************************************************************

`timescale 1ns/100ps

module  rld_phy_calib #(
  // public parameters -- adjustable
  parameter RL_DQ_WIDTH     = 36,
  parameter DEV_DQ_WIDTH    = 18,  // data width of the memory device
  parameter NUM_OF_DEVS     = RL_DQ_WIDTH/DEV_DQ_WIDTH,  // number of memory devices
  parameter NUM_OF_DKS      = (DEV_DQ_WIDTH == 36) ? 2*NUM_OF_DEVS : NUM_OF_DEVS,
  parameter DEV_AD_WIDTH    = 20,  // address width of the memory device
  parameter DEV_BA_WIDTH    = 3,   // bank address width of the memory device
  parameter APP_AD_WIDTH    = 1+1+1+DEV_AD_WIDTH+DEV_BA_WIDTH,
  parameter DUPLICATE_CONTROLS = 1'b0,  // Duplicate the ports for A, BA, WE# and REF#
  parameter BITS_PER_BYTE   = 9,   // Micron offers 9-bit byte for RL2
  //parameter BITS_PER_BYTE   = 8,   // Micron offers 9-bit byte for RL2
  //
  parameter RL_CK_PERIOD  = 16'd3003,     // CK clock period of the RLDRAM in ps
  // MRS (Mode Register Set command) parameters   
  //    please check Micron RLDRAM-II datasheet for definitions of these parameters
  parameter RL_MRS_CONF            = 3'b001, // config 1
  parameter RL_MRS_BURST_LENGTH    = 2'b00,  // BL2
  parameter RL_MRS_ADDR_MUX        = 1'b0,   // non-muxed address
  parameter RL_MRS_DLL_RESET       = 1'b0,   //
  parameter RL_MRS_IMPEDANCE_MATCH = 1'b1,   // internal 50ohms output buffer impedance
  parameter RL_MRS_ODT             = 1'b0,   // disabled termination
  //
  // specific to FPGA/memory devices and capture method
  parameter RL_IO_TYPE     = 2'b00,    // CIO=2'b00  SIO_CIO_HYBRID=2'b01  SIO=2'b10
  parameter DEVICE_ARCH    = 2'b00,    // Virtex4=2'b00  Virtex5=2'b01
  parameter CAPTURE_METHOD = 2'b00,     // Direct Clocking=2'b00  SerDes=2'b01
  // specific to calibration scheme
  parameter CAL_ADDRESS   = {DEV_AD_WIDTH{1'b0}} //saved location to perform calibration
  // end of public parameters
)
(
   input       clk,
   input       rstHard,

   input [3:0] confBL,          // BL2=4'h2, BL4=4'h4, BL8=4'h8 (in hex)
   input       start,           
   input       first_sel_done,  // from phy, first calibration stage complete
   input       sel_done,        // calibration done
   input       refresh_cmd,     // for BL2 wait for refresh before aligning QVLD
   input       issueCalibration,

   input       rlWdfFull,       // write data fifo full
   input       rlWdfEmpty,      // write data fifo empty
   input       rlafFull,        // write address fifo full
   input       rlafAlmostEmpty, // write address fifo almost full
   input       rlafEmpty,       // write address fifo empty

   output reg                     second_cal_out, // signal physical layer to begin 2nd phase cal
   output reg                     qvld_cal_out,   // signal physical layer to align QVLD
   output reg                     cal_done,       // calibration complete
   output reg                     apValid,        // write enable to write address fifo
   output reg [APP_AD_WIDTH-1:0]  apAddr,         // address to be written to write address fifo
   output reg                     apWriteDValid,  // write enable to write data fifo
   output reg [2*RL_DQ_WIDTH-1:0] apWriteData,    // data to be written to write data fifo
   output reg [2*NUM_OF_DEVS-1:0] apWriteDM,      // data mask to be written to write data fifo
   
   inout  [1023:0] cs_io  // chipscope debug ports
);

// private parameters -- do not change
// parameterize the pattern to be used for write data
parameter data1 = 9'hFFF;   // 9'h1FF  is  1_1111_1111
parameter data2 = 9'h000;   // 9'h000  is  0_0000_0000
parameter data3 = 9'h0AA;   // 9'h0AA  is  0_1010_1010
parameter data4 = 9'h155;   // 9'h155  is  1_0101_0101

parameter data_mask = {2*NUM_OF_DEVS{1'b0}};
parameter reserved  = 1'b0;
parameter user_ref  = 1'b0;
// end of private parameters


   reg [4:0] count;
   reg [4:0] count_2;
   reg [4:0] qvld_wait_cnt;
   reg [3:0] write_count;
   reg [2:0] read_count;
   reg       rlWdfEmpty_r;
   reg       rlafEmpty_r;

   wire [2*RL_DQ_WIDTH-1:0] first_write_data, second_write_data;

   // concatonate data to make up full datawidth
   assign first_write_data  = { {RL_DQ_WIDTH/BITS_PER_BYTE{data1}}, {RL_DQ_WIDTH/BITS_PER_BYTE{data2}} };
   assign second_write_data = { {RL_DQ_WIDTH/BITS_PER_BYTE{data3}}, {RL_DQ_WIDTH/BITS_PER_BYTE{data4}} };

   // State Variables (using 1-hot encoding)
   // Reset, Start, Write1, Write2, Read, Rd_en, Rd_en2, Done
   reg [6:0] cs, ns; 
   
   // private parameters -- do not change
   parameter [6:0] Reset      = 7'b000_0000,
                   Start      = 7'b000_0001,
                   Write      = 7'b000_0010,
                   Read       = 7'b000_0100,
                   Wait       = 7'b000_1000,
                   Rd_En      = 7'b001_0000,
                   Rd_En2     = 7'b010_0000,
                   Done       = 7'b100_0000;

   reg first_sel_done_r;
   reg second_cal;
   reg sel_done_delay;
   reg cal_done_r0;
   reg qvld_en;
   reg refresh_cmd_r;
   
   wire rst;

   assign rst = rstHard || issueCalibration;
   
   wire [3:0] burst_length;
   assign burst_length = confBL;

// -----------------------------------------------------------------------------
// Three stages required for Phy Calibration, keep the controller issuing back-to-back reads
// 1st Stage: align QK in DQ window for correct capture using Strobe
// 2nd Stage: align QK/DQ to FPGA clock domain for transfter
// 3rd Stage: align QVLD for all the bytes be performing one last read
//    Note: BL2 needs two read commands that must be back-to-back
//          wait for refresh then issue two read commands
// -----------------------------------------------------------------------------

   //update the current state
   always @ ( posedge clk )
   begin
      if ( rst )      // sync reset
         cs <= Reset;
      else
         cs <= ns;
   end

   // next state generation
   always @*
   begin
      case ( cs )

         Reset : begin
            ns <= Start; end
        
         Start : begin
            if ( start && rlafEmpty )
               ns <= Write;
            else
               ns <= Start; end

         Write : begin
            // write to FIFO, different banks to swamp bus with data
           if ( burst_length != 4'h4 && write_count == 4'b0111 )
              ns <= Read;
           else if ( burst_length == 4'h4 && write_count == 4'b1111 )
              ns <= Read;
           else
              ns <= Write; end

         Read : begin
            // wait in the read state until calibration finish
            if ( (first_sel_done && !first_sel_done_r) && !sel_done)
              ns <= Start;
            else if ( first_sel_done_r && sel_done )
               if ( burst_length == 4'h2 ) //only need to wait for BL2 operation
                  ns <= Wait;
               else
                  ns <= Rd_En;
            else
               ns <= Read; end
               
         Wait : begin
          //for BL2 only, wait here till FIFO empty and refresh occurs
          //need to ensure back-to-back data read for QVLD alignment
            if ( rlafEmpty && qvld_wait_cnt == 5'b11111 )
              ns <= Rd_En;
            else
              ns <= Wait;
         end
               
         Rd_En : begin
            // Perform one last read to align QVLD
            // for BL2 need one extra read so go to Rd_En2 (BL4/8 only need 1 read command)
            if ( rlafEmpty )
              if ( burst_length == 4'h2)
                ns <= Rd_En2;
              else
                ns <= Done;
            else
              ns <= Rd_En;  end
         
         Rd_En2 : begin
              ns <= Done;  end

         Done : begin
            // only a reset can force a state change
            ns <= Done; end

         default : begin
            ns <= Reset; end
      endcase
   end

   // output generation
   always @ ( posedge clk )
   begin
      case ( cs )

         Reset :  begin
            apWriteDValid <= 1'b0;
            apWriteData   <= {2*RL_DQ_WIDTH{1'b0}};
            apWriteDM     <= {2*NUM_OF_DEVS{1'b0}};

            apValid <= 1'b0;
            apAddr  <= {APP_AD_WIDTH{1'b0}};
            
            write_count <= 4'b0;
            read_count <= 3'b0;
            second_cal <= 1'b0;
            sel_done_delay <= 1'b0;
            qvld_en <= 1'b0;
         end

         Start :  begin
            apWriteDValid <= 1'b0;
            apWriteData   <= {2*RL_DQ_WIDTH{1'b0}};
            apWriteDM     <= {2*NUM_OF_DEVS{1'b0}};

            apValid <= 1'b0;
            apAddr  <= {APP_AD_WIDTH{1'b0}};
            
            write_count <= 4'b0;
            read_count <= 3'b0;
            second_cal <= 1'b0;
            sel_done_delay <= 1'b0;
            qvld_en <= 1'b0;
         end

         Write :  begin 
         // -----------------------------------------------------------------------------
         // write to different bank location to ensure databus full of read data
         // FIFO is filled with commands depending on burst length
         // -----------------------------------------------------------------------------
            apWriteDValid <= 1'b1;
            apWriteDM     <= data_mask;
            if (first_sel_done && first_sel_done_r)
              second_cal <= 1'b1;
            else
              second_cal <= 1'b0;
            
            case (write_count[2:0])
              3'b000: begin
                  apWriteData   <= first_write_data;
                  if (burst_length == 4'h2)
                    apValid <= 1'b1;
                  else
                    apValid <= 1'b0;
                end
              3'b001: begin
                  apWriteData   <= (first_sel_done) ? second_write_data : first_write_data;
                  if (burst_length == 4'h2 || burst_length == 4'h4)
                    apValid <= 1'b1;
                  else
                    apValid <= 1'b0;
                end
              3'b010: begin
                  apWriteData   <= first_write_data;
                  if (burst_length == 4'h2)
                    apValid <= 1'b1;
                  else
                    apValid <= 1'b0;
                end
              3'b011: begin
                  apWriteData   <= (first_sel_done) ? second_write_data : first_write_data;
                  apValid <= 1'b1;
                end
              3'b100: begin
                  apWriteData   <= first_write_data;
                  if (burst_length == 4'h2)
                    apValid <= 1'b1;
                  else
                    apValid <= 1'b0;
                end
              3'b101: begin
                  apWriteData   <= (first_sel_done) ? second_write_data : first_write_data;
                  if (burst_length == 4'h2 || burst_length == 4'h4)
                    apValid <= 1'b1;
                  else
                    apValid <= 1'b0;
                end
              3'b110: begin
                  apWriteData   <= first_write_data;
                  if (burst_length == 4'h2)
                    apValid <= 1'b1;
                  else
                    apValid <= 1'b0;
                end
              3'b111: begin
                  apWriteData   <= (first_sel_done) ? second_write_data : first_write_data;
                  apValid       <= 1'b1;
                end
              default: begin
                  apWriteData   <= {2*RL_DQ_WIDTH{1'b0}};
                  apValid       <= 1'b0;
                end
              endcase
            
            //only increment write count if FIFOs not full
            if ( ~rlWdfFull && ~rlafFull )
              write_count <= write_count + 1;
            
            if (burst_length == 4'h2)
              apAddr  <= {user_ref, 1'b0, reserved, CAL_ADDRESS, write_count[2:0]};    // write command (BL2)
            else if (burst_length == 4'h4)
              apAddr  <= {user_ref, 1'b0, reserved, CAL_ADDRESS, write_count[3:1]};    // write command (BL4)
            else
              apAddr  <= {user_ref, 1'b0, reserved, CAL_ADDRESS, write_count[3:1]>>1}; // write command (BL8)
         end

         Read : begin
         // -----------------------------------------------------------------------------
         // read from different bank locations to ensure databus full of read data
         // FIFO is filled with commands depending on burst length
         // -----------------------------------------------------------------------------
            apWriteDValid <= 1'b0;
            apWriteData   <= {2*RL_DQ_WIDTH{1'b0}};
            apWriteDM     <= {2*NUM_OF_DEVS{1'b0}};
            second_cal <= second_cal;
            
            if ( rlafAlmostEmpty )
            begin
               read_count <= read_count + 1;
               apValid <= 1'b1;
               
               if ( burst_length == 4'h2 || burst_length == 4'h4 )
                  apAddr  <= {user_ref, 1'b1, reserved, CAL_ADDRESS, read_count};              // read command (BL2 & BL4)
               else
                  apAddr  <= {user_ref, 1'b1, reserved, CAL_ADDRESS, {read_count & 3'b001} };  // read command (BL8)

            end else
            begin
               read_count <= read_count;
               apValid <= 1'b0;
               apAddr  <= {APP_AD_WIDTH{1'b0}};
            end
         end
         
         Wait : begin
            
            if ( !refresh_cmd && refresh_cmd_r)
              qvld_en <= 1'b1;
            else
              qvld_en <= qvld_en;
            
            apWriteDValid <= 1'b0;
            apWriteData   <= {2*RL_DQ_WIDTH{1'b0}};
            apWriteDM     <= {2*NUM_OF_DEVS{1'b0}};

            apValid <= 1'b0;
            apAddr  <= {APP_AD_WIDTH{1'b0}};
         end
         
         Rd_En : begin
            //Perform one last read for QVLD alignment
            if ( rlafEmpty ) begin
              apValid <= 1'b1;
              apAddr  <= {user_ref, 1'b1, reserved, CAL_ADDRESS, 3'b0};
            end else begin
              apValid <= 1'b0;
              apAddr  <= {APP_AD_WIDTH{1'b0}};
            end
         end
         
         Rd_En2 : begin
            // this state only reached for BL2 to perform 1 extra read for QVLD alignment
            // Bank address changed from previous state to ensure no gap in read
              apValid <= 1'b1;
              apAddr  <= {user_ref, 1'b1, reserved, CAL_ADDRESS, 3'b1};
         end
         
         Done :   begin
            apWriteDValid <= 1'b0;
            apWriteData   <= {2*RL_DQ_WIDTH{1'b0}};
            apWriteDM     <= {2*NUM_OF_DEVS{1'b0}};

            apValid <= 1'b0;
            apAddr  <= {APP_AD_WIDTH{1'b0}};
            sel_done_delay <= 1'b1;
         end

         default : begin
            apWriteDValid <= 1'b0;
            apWriteData   <= {2*RL_DQ_WIDTH{1'b0}};
            apWriteDM     <= {2*NUM_OF_DEVS{1'b0}};

            apValid <= 1'b0;
            apAddr  <= {APP_AD_WIDTH{1'b0}};
            write_count <= 4'b0;
            read_count <= 3'b0;
            qvld_en <= 1'b0;
         end
      endcase
   end

// -----------------------------------------------------------------------------
// Generate delayed calibration_done signal to ensure calibration data is not written to FIFOs.
// Wait until calibration finishes and there is still data coming in
// -----------------------------------------------------------------------------
   always @ ( posedge clk )
   begin
      if ( rst ) begin
         rlWdfEmpty_r <= 1'b0;
         rlafEmpty_r  <= 1'b0;
      end else begin
         rlWdfEmpty_r <= rlWdfEmpty;
         rlafEmpty_r  <= rlafEmpty;
      end
   
      if ( rst )
         count <= 5'b00000;
      else if ( sel_done_delay && rlWdfEmpty_r && rlafEmpty_r && count != 5'b11111 )  // make sure all FIFOs empty before proceeding
         count <= count + 1;
      else
         count <= count;
   end

   always @ ( posedge clk )
   begin
      if ( rst )
         cal_done_r0 <= 1'b0;
      else
         if ( count == 5'b11111 )
            cal_done_r0 <= 1'b1;  
            
      if ( rst )
         cal_done <= 1'b0;
      else
         cal_done <= cal_done_r0; // output delayed signal
   end
   
   always @ (posedge clk)
   begin
    if (rst)
      first_sel_done_r <= 1'b0;
    else
      first_sel_done_r <= first_sel_done;
   end

// -----------------------------------------------------------------------------   
// Counter used to delay when calibration starts looking for 2nd stage data
// -----------------------------------------------------------------------------
   always @ (posedge clk)
   begin
    if (rst)
      count_2 <= 5'b0;
    else if ( second_cal && count_2 != 5'b11111)
      count_2 <= count_2 + 1;
   end
   
// -----------------------------------------------------------------------------   
// output flag to indicate data belongs to 2nd part of calibration
// Phy needs to know when to start looking for 2nd stage data
// -----------------------------------------------------------------------------
   always @ (posedge clk)
   begin
    if (rst)
      second_cal_out <= 1'b0;
    else if (count_2 == 5'b11111)
      second_cal_out <= 1'b1;
    else
      second_cal_out <= 1'b0;
   end
   
// -----------------------------------------------------------------------------   
// output flag to indicate ready for QVLD calibration (BL2 needs this
// to ensure the correct pattern is checked if refresh occurs).
// -----------------------------------------------------------------------------
   always @ (posedge clk)
   begin
    if (rst)
      qvld_wait_cnt <= 5'b0;
    else if (qvld_en && qvld_wait_cnt != 5'b11111)
      qvld_wait_cnt <= qvld_wait_cnt + 1;
    else
      qvld_wait_cnt <= qvld_wait_cnt;
   end
   
   always @ (posedge clk)
   begin
    if (rst)
      refresh_cmd_r <= 1'b0;
    else
      refresh_cmd_r <= refresh_cmd;
   end
   
   always @ (posedge clk)
   begin
    if (rst)
      qvld_cal_out <= 1'b0;
    else
      qvld_cal_out <= sel_done_delay;
   end
   
// -----------------------------------------------------------------------------
// Simulation only
// -----------------------------------------------------------------------------
always @ (posedge clk)
begin
  if ( cs == Start && start && !first_sel_done) begin
      $display(" Starting Dummy Writes/Reads   \t\tTime: %t", $time);
   end else if ( first_sel_done && !first_sel_done_r ) begin
      $display(" First Stage Calibration Complete \t\tTime: %t", $time);
   end else if ( count ==5'b11110 ) begin
      $display("--------------- Calibration Done! --------------- Time: %t", $time);
   end
end

endmodule
