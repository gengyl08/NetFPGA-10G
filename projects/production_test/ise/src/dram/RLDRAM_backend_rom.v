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
// Copyright (c) 2006 Xilinx, Inc. All rights reserved.
//
// This copyright and support notice must be retained as part 
// of this text at all times. 
//*****************************************************************************
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: 1.1
//  \   \         Filename: backend_rom.v
//  /   /         Timestamp: 24 August 2007
// /___/   /\     
// \   \  /  \
//  \___\/\___\
//
//
//	Device:  Virtex-4 and Virtex-5
//	Purpose: This module generates the Write Address enable, Write Data 
//                    enable and Read Address enable signals, along with the Write Data
//                    and Write and Read addresses themselves.
//                    It also provides comparison data to the data checker to be 
//                    compared with the data that is read via the Read FIFO.
// Revision History:
//   Rev 1.0 - initial release
//   Rev 1.1 - Added the RL_DQ_WIDTH parameter, generate write data for different widths
//*****************************************************************************

`timescale 1 ps / 1ps

`define idle_first_data    2'b00
`define second_data        2'b01
`define third_data         2'b10
`define fourth_data        2'b11

`define idle_first_data_90 2'b00
`define second_data_90     2'b01
`define third_data_90      2'b10
`define fourth_data_90     2'b11

module backend_rom (
   clk,
   rst,
   rst90,
   clk90,
   bkend_data_en,
   bkend_wraddr_en,
   bkend_rdaddr_en,
   apRdfRdEn,
   burst_length,
   
   app_Waf_addr, 
   app_Waf_WrEn,
   apWriteData,
   app_compare_data, 
   apWriteDValid,
   app_Raf_addr,
   app_Raf_WrEn,
   
   cs_io
);

// parameter definitions
parameter RL_DQ_WIDTH     = 36;
// end of parameter definitions

input         clk;
input         rst;
input         rst90;
input         clk90;
input         bkend_data_en;
input         bkend_wraddr_en;
input         bkend_rdaddr_en;
input         apRdfRdEn;
input [1:0]   burst_length;
   
output [25:0] app_Waf_addr;
output        app_Waf_WrEn;
output [(2*RL_DQ_WIDTH)-1:0] apWriteData;
output [(2*RL_DQ_WIDTH)-1:0] app_compare_data;
output        apWriteDValid;
output [25:0] app_Raf_addr;
output        app_Raf_WrEn;

inout [1023:0] cs_io;


reg [(2*RL_DQ_WIDTH)-1:0]   apWriteData;
reg [8:0]     wr_rd_addr;
reg           wr_rd_addr_en;
reg [4:0]     addr_count;
reg [1:0]     state;
reg [1:0]     state_90;
reg [8:0]    data_pattern;
reg [8:0]    data_pattern_90;
reg  [25:0]    app_Waf_addr_1;
reg [25:0]    app_Raf_addr_1;
reg 	      app_Waf_WrEn;
reg 	      app_Raf_WrEn;
reg 	      apWriteDValid;
reg 	      apWriteDValid_a1;

   
wire [25:0]    app_Waf_addr;
wire [25:0]    app_Raf_addr;
wire [8:0]    rising_edge_data;
wire [8:0]    falling_edge_data;
wire [8:0]    rising_edge_data_90;
wire [8:0]    falling_edge_data_90;
wire [31:0]    unused_data_in;
wire [3:0]     unused_data_in_p;
wire           gnd, vcc;
wire [31:0]    addr_out;
wire [(2*RL_DQ_WIDTH)-1:0]   apWriteData_a1;

wire capture_rst, dly_capture_rst, dly2_capture_rst, init_BRAM_dout, bram_sinit;  // create pulse to re-init BRAM dout after reset

//assign cs_io[190:173] = {20'b0, addr_count, wr_rd_addr_en};

// ADDED, RCHIU
wire [15:0]    ramb36_addra;
reg  [15:0]    fixed_bits;

assign unused_data_in   = 32'h00000000;
assign unused_data_in_p = 4'h0;

assign gnd = 1'b0;
assign vcc = 1'b1;

//ADDRESS generation for Write and Read Address FIFOs

//ROM with address patterns

// The address patterns below in INIT strings support ((8 Writes & 8 Reads) + another (8 Writes & 8 Reads)).
// New INIT values -hence new Read/Write address locations- can be added if desired.

defparam
	wr_rd_addr_lookup.INIT_00 = 256'h0100000000000007000000060000000500000004000000030000000200000001,
	wr_rd_addr_lookup.INIT_01 = 256'h0000000801000007010000060100000501000004010000030100000201000001,
	wr_rd_addr_lookup.INIT_02 = 256'h010000080000000F0000000E0000000D0000000C0000000B0000000A00000009,
	wr_rd_addr_lookup.INIT_03 = 256'h000000000100000F0100000E0100000D0100000C0100000B0100000A01000009;	   

//        7654 3210
// [0x07] 0100 0000  31(0) 30 (0) 29(0) 28(0) 27(0) 26(0) 25(0) 24(1)...
// [0x06] 0000 0007 
// [0x05] 0000 0006 
// [0x04] 0000 0005 
// [0x03] 0000 0004 
// [0x02] 0000 0003 
// [0x01] 0000 0002 
// [0x00] 0000 0001 
// 
// [0x0F] 0000 0008 
// [0x0E] 0100 0007 
// [0x0D] 0100 0006 
// [0x0C] 0100 0005 
// [0x0B] 0100 0004 
// [0x0A] 0100 0003 
// [0x09] 0100 0002 
// [0x08] 0100 0001
// 
// [0x17] 0100 0008 
// [0x16] 0000 000F 
// [0x15] 0000 000E 
// [0x14] 0000 000D 
// [0x13] 0000 000C 
// [0x12] 0000 000B 
// [0x11] 0000 000A 
// [0x10] 0000 0009
// 
// [0x1F] 0000 0000 
// [0x1E] 0100 000F 
// [0x1D] 0100 000E 
// [0x1C] 0100 000D 
// [0x1B] 0100 000C 
// [0x1A] 0100 000B 
// [0x19] 0100 000A 
// [0x18] 0100 0009

/* 
RAMB16_S36 wr_rd_addr_lookup (
   .DO   ( addr_out[31:0]        ), 
   .DOP  (                       ), 
   .ADDR ( wr_rd_addr[8:0]       ), 
   .CLK  ( clk                   ), 
   .DI   ( unused_data_in[31:0]  ), 
   .DIP  ( unused_data_in_p[3:0] ), 
   .EN   ( wr_rd_addr_en         ), 
   .SSR  ( bram_sinit            ),
   .WE   ( gnd                   )
);
*/

// ADDED, RCHIU
RAMB36 wr_rd_addr_lookup (
                 .CASCADEOUTLATA(), 
                 .CASCADEOUTLATB(),
                 .CASCADEOUTREGA(),
                 .CASCADEOUTREGB(),
                 .DOA(addr_out[31:0]), 
                 .DOB(),
                 .DOPA(), 
                 .DOPB(),
                 .ADDRA(ramb36_addra),
                 .ADDRB(16'h0000), 
                 .CASCADEINLATA(), 
                 .CASCADEINLATB(), 
                 .CASCADEINREGA(), 
                 .CASCADEINREGB(), 
                 .CLKA(clk), 
                 .CLKB(clk), 
                 .DIA(32'b0), 
                 .DIB(32'b0), 
                 .DIPA(4'b0), 
                 .DIPB(4'b0), 
					  .ENA(wr_rd_addr_en), 
                 .ENB(1'b1), 
                 .REGCEA(), 
                 .REGCEB(), 
                 .SSRA(bram_sinit), 
                 .SSRB(bram_sinit), 
                 .WEA(4'b0000), 
                 .WEB(4'b0000)
                 );
defparam wr_rd_addr_lookup.READ_WIDTH_A = 36;
defparam wr_rd_addr_lookup.READ_WIDTH_B = 36;      

   // must pulse the BRAM SINIT upon reset to get correct DOUT value
   FD  TEST_fd_bram_sinit  (
      .C ( clk ),
      .D ( init_BRAM_dout ),
      .Q ( bram_sinit )
   );




//enable for ROM with address patterns
   
always @ (posedge clk)
begin
   if (rst)
   begin
      wr_rd_addr_en   <= 1'b0;
      apWriteDValid_a1 <= 1'b0;
   end 
   else
   begin 
      apWriteDValid_a1 <= bkend_data_en;      
      wr_rd_addr_en   <= bkend_wraddr_en  | bkend_rdaddr_en | init_BRAM_dout;  // use delayed reset pulse to get BRAM's dout re-initialized
   end
end 
   
   FD  fd_capture_rst  (    // capture the reset
      .C ( clk ),
      .D ( rst ),
      .Q ( capture_rst )
   );

   SRL16  delayed_capture_rst  (    // delay the captured reset
      .Q   ( dly_capture_rst ), 
      .A0  ( gnd ), 
      .A1  ( vcc ), 
      .A2  ( vcc ), 
      .A3  ( vcc ), 
      .CLK ( clk ), 
      .D   ( capture_rst )
   );

   FD  fd_delayed_capture_rst  (     // one more delay
      .C ( clk ),
      .D ( dly_capture_rst ),
      .Q ( dly2_capture_rst )
   );
   FD  fd_init_BRAM_dout  (    // generate pulse on falling edge
      .C ( clk ),
      .D ( ~dly_capture_rst & dly2_capture_rst ),  // capture falling edge
      .Q ( init_BRAM_dout )
   );



   
// delay signals
    
always @ (posedge clk)
begin
   if (rst)
   begin
      apWriteData <= {2*RL_DQ_WIDTH{1'b0}};
      apWriteDValid <= 1'b0;  
   end 
   else
   begin
      apWriteData <= apWriteData_a1;
      apWriteDValid <= apWriteDValid_a1;
   end 
end 



//output read and write enables and addresses	 



always @ (posedge clk)
begin
   if (rst)
   begin
      app_Waf_addr_1  <= 26'b00000000000000000000000000;
      app_Waf_WrEn    <= 1'b0;
      app_Raf_WrEn    <= 1'b0;
      app_Raf_addr_1    <= 26'b00000000000000000000000000;
   end
   else
   begin
      app_Waf_addr_1 <= addr_out[25:0];
      app_Waf_WrEn   <= bkend_wraddr_en;
      app_Raf_WrEn   <= bkend_rdaddr_en;
      app_Raf_addr_1   <= addr_out[25:0];
   end
end   



assign  app_Waf_addr = (burst_length == 2'b00) ?  addr_out : app_Waf_addr_1 ; 

assign  app_Raf_addr = (burst_length == 2'b00) ?  addr_out : app_Raf_addr_1 ;

   
// address locations in ROM
   
always @ (posedge clk)
begin
   if (rst)
   begin
      addr_count[4:0] <= 5'b00000;
      wr_rd_addr[8:0] <= 9'h000;
   end
   else if (bkend_wraddr_en || bkend_rdaddr_en)
   begin
      addr_count[4:0] <= addr_count[4:0] + 1;
// ADDED, RCHIU, 03/15/06 - force all bits of wr_rd_addr to be "nonconstant"
//      wr_rd_addr[8:0] <= {4'b0000,addr_count[4:0]};
      wr_rd_addr[8:0] <= {fixed_bits[13:10],addr_count[4:0]};
   end
   else
   begin
      addr_count[4:0] <= addr_count[4:0];
      wr_rd_addr[8:0] <= wr_rd_addr[8:0];
   end
end

// ADDED, RCHIU, get around RAMB36 initialization bug
// RAMB36 doesn't initialize when upper bits of address are fixed to 0
assign ramb36_addra = {fixed_bits[15:14], wr_rd_addr, 5'b00000};
always @ (posedge clk) begin
  if (rst) begin
	 // just a hack to try and get around synthesis optimizing this out
    fixed_bits <= 16'hFFFF;
  end else begin
    fixed_bits <= 16'h0000;
  end
end


// DATA generation for write data fifos	

always @ (posedge clk) 
begin
   if (rst) 
   begin
      data_pattern <= 9'h000;
      state        <= `idle_first_data;
   end 
   else   
   begin
      case (state)
       
     `idle_first_data :
      begin
	 if (bkend_data_en == 1'b1) 
         begin
            data_pattern <= 9'h1EE;
            state        <= `second_data;
         end
         else
         begin
            state <= `idle_first_data;
         end
      end
                        
     `second_data :
      begin
         if (bkend_data_en == 1'b1)
	 begin
            data_pattern <= 9'h1AA ;
            state        <= `third_data;
	 end   
      end

//Added by James                        
     `third_data :
      begin
         if (bkend_data_en == 1'b1)
	 begin
            data_pattern <= 9'h111 ;
            state        <= `idle_first_data;
	 end   
      end
                      
      endcase
   end
end 


   
// data generation for read data compare
   
always @ (posedge clk)                      // data read from memory is in clkGlob domain
begin
   if (rst) 
   begin
      data_pattern_90 <= 9'h000;
      state_90        <= `idle_first_data_90;
   end 
   else   
   begin
      case (state_90) 
 
     `idle_first_data_90 :
      begin
	 
         if (apRdfRdEn == 1'b1)
         begin
            data_pattern_90 <= 9'h1EE;
            state_90        <= `second_data_90;
         end
         else
         begin 
            state_90 <= `idle_first_data_90;
	 end
      end 
                        
     `second_data_90 :
      begin
	 if (apRdfRdEn == 1'b1)
         begin
            data_pattern_90 <= 9'h1AA ;
            state_90        <= `third_data_90;
         end
      end

//Added by James                        
     `third_data_90 :
      begin
	 if (apRdfRdEn == 1'b1)
         begin
            data_pattern_90 <= 9'h111 ;
            state_90        <= `idle_first_data_90;
         end
      end
      
      endcase
   end
end 


assign rising_edge_data  =  data_pattern;
assign falling_edge_data = ~data_pattern;

assign rising_edge_data_90  =  data_pattern_90;
assign falling_edge_data_90 = ~data_pattern_90;

   generate
      if ( RL_DQ_WIDTH == 18 )  begin : back_rom_18
         // data to write data fifos during write
         assign apWriteData_a1 = {   rising_edge_data
                                    , rising_edge_data
                                    , falling_edge_data
                                    , falling_edge_data
                                  };  // 2x same 18-bit data

         // data to compare circuit during read
         assign app_compare_data = {   rising_edge_data_90
                                     , rising_edge_data_90
                                     , falling_edge_data_90
                                     , falling_edge_data_90
                                  };  // 2x same 18-bit data

      end
      else if ( RL_DQ_WIDTH == 36 )  begin : back_rom_36
         // data to write data fifos during write
         assign apWriteData_a1 = {   rising_edge_data
                                    , rising_edge_data
                                    , rising_edge_data
                                    , rising_edge_data
                                    , falling_edge_data
                                    , falling_edge_data
                                    , falling_edge_data
                                    , falling_edge_data
                                  };  // 4x same 18-bit data

         // data to compare circuit during read
         assign app_compare_data = {   rising_edge_data_90
                                     , rising_edge_data_90
                                     , rising_edge_data_90
                                     , rising_edge_data_90
                                     , falling_edge_data_90
                                     , falling_edge_data_90
                                     , falling_edge_data_90
                                     , falling_edge_data_90
                                   };  // 4x same 18-bit data
      end
      else begin : back_rom_72
         // data to write data fifos during write
         assign apWriteData_a1 = {   rising_edge_data
                                    , rising_edge_data
                                    , rising_edge_data
                                    , rising_edge_data
                                    , rising_edge_data
                                    , rising_edge_data
                                    , rising_edge_data
                                    , rising_edge_data
                                    , falling_edge_data
                                    , falling_edge_data
                                    , falling_edge_data
                                    , falling_edge_data
                                    , falling_edge_data
                                    , falling_edge_data
                                    , falling_edge_data
                                    , falling_edge_data
                                  };  // 8x same 18-bit data

         // data to compare circuit during read
         assign app_compare_data = {   rising_edge_data_90
                                     , rising_edge_data_90
                                     , rising_edge_data_90
                                     , rising_edge_data_90
                                     , rising_edge_data_90
                                     , rising_edge_data_90
                                     , rising_edge_data_90
                                     , rising_edge_data_90
                                     , falling_edge_data_90
                                     , falling_edge_data_90
                                     , falling_edge_data_90
                                     , falling_edge_data_90
                                     , falling_edge_data_90
                                     , falling_edge_data_90
                                     , falling_edge_data_90
                                     , falling_edge_data_90
                                   };  // 8x same 18-bit data
      end
   endgenerate

endmodule
