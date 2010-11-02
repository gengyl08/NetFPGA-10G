//-----------------------------------------------------------------------
//-- RLDRAM memory controller top level
//-- instantiates 2 RLDRAM i/f
//-- Michaela Blott
//-- May 2010
//-----------------------------------------------------------------------
`timescale 1ns/100ps

module  rldram_if  (
   IDLY_CLK,
   RLDRAM_CLK,
   PB01,
   status,
   RLD2_A_CK_P,
   RLD2_A_CK_N,
   RLD2_A_DK_P,
   RLD2_A_DK_N,
   RLD2_A_QK_P,
   RLD2_A_QK_N,
   RLD2_A_A,
   RLD2_A_BA,
   RLD2_A_CS_N,
   RLD2_A_WE_N,
   RLD2_A_REF_N,
   RLD2_A_DQ,
   RLD2_A_QVLD,
   RLD2_B_CK_P,
   RLD2_B_CK_N,
   RLD2_B_DK_P,
   RLD2_B_DK_N,
   RLD2_B_QK_P,
   RLD2_B_QK_N,
   RLD2_B_A,
   RLD2_B_BA,
   RLD2_B_CS_N,
   RLD2_B_WE_N,
   RLD2_B_REF_N,
   RLD2_B_DQ,
   RLD2_B_QVLD
);
parameter SIMULATION_ONLY = 1'b0;
parameter RL_DQ_WIDTH     = 72;
parameter DEV_DQ_WIDTH    = 36;
parameter NUM_OF_DEVS     = RL_DQ_WIDTH/DEV_DQ_WIDTH;
parameter NUM_OF_DKS      = (DEV_DQ_WIDTH == 36) ? 2*NUM_OF_DEVS : NUM_OF_DEVS;
parameter DEV_AD_WIDTH    = 20;
parameter DEV_BA_WIDTH    = 3;
parameter APP_AD_WIDTH    = 1+1+1+DEV_AD_WIDTH+DEV_BA_WIDTH;
parameter DUPLICATE_CONTROLS = 1'b0;
parameter RL_CK_PERIOD  = 16'd5003; // James : VERY IMPORTANT
parameter RL_MRS_CONF            = 3'b011;
parameter RL_MRS_BURST_LENGTH    = 2'b01;
parameter RL_MRS_ADDR_MUX        = 1'b0;
parameter RL_MRS_DLL_RESET       = 1'b1;
parameter RL_MRS_IMPEDANCE_MATCH = 1'b1;
parameter RL_MRS_ODT             = 1'b0;
parameter RL_IO_TYPE     = 2'b00;
parameter DEVICE_ARCH    = 2'b01;
parameter CAPTURE_METHOD = 2'b01;

   input  IDLY_CLK;
   input  RLDRAM_CLK;
   output [9:0] status;
   input  PB01;
   output [NUM_OF_DEVS-1:0]    RLD2_A_CK_P;
   output [NUM_OF_DEVS-1:0]    RLD2_A_CK_N;
   output [NUM_OF_DKS-1:0]     RLD2_A_DK_P;
   output [NUM_OF_DKS-1:0]     RLD2_A_DK_N;
   input  [2*NUM_OF_DEVS-1:0]  RLD2_A_QK_P;
   input  [2*NUM_OF_DEVS-1:0]  RLD2_A_QK_N;
   output [DEV_AD_WIDTH-1:0]   RLD2_A_A;
   output [DEV_BA_WIDTH-1:0]   RLD2_A_BA;
   output [NUM_OF_DEVS-1:0]    RLD2_A_CS_N;
   output                      RLD2_A_WE_N;
   output                      RLD2_A_REF_N;
   inout  [63:0]    	          RLD2_A_DQ;		//By James. Use 64bit data width
   input  [NUM_OF_DEVS-1:0]    RLD2_A_QVLD;
   output [NUM_OF_DEVS-1:0]    RLD2_B_CK_P;
   output [NUM_OF_DEVS-1:0]    RLD2_B_CK_N;
   output [NUM_OF_DKS-1:0]     RLD2_B_DK_P;
   output [NUM_OF_DKS-1:0]     RLD2_B_DK_N;
   input  [2*NUM_OF_DEVS-1:0]  RLD2_B_QK_P;
   input  [2*NUM_OF_DEVS-1:0]  RLD2_B_QK_N;
   output [DEV_AD_WIDTH-1:0]   RLD2_B_A;
   output [DEV_BA_WIDTH-1:0]   RLD2_B_BA;
   output [NUM_OF_DEVS-1:0]    RLD2_B_CS_N;
   output                      RLD2_B_WE_N;
   output                      RLD2_B_REF_N;
   inout  [63:0]    	          RLD2_B_DQ;		//By James. Use 64bit data width
   input  [NUM_OF_DEVS-1:0]    RLD2_B_QVLD;

  rld_mem_interface_top  #(
      .SIMULATION_ONLY        (SIMULATION_ONLY),
      .RL_DQ_WIDTH            (RL_DQ_WIDTH),
      .DEV_DQ_WIDTH           (DEV_DQ_WIDTH),
      .DEV_AD_WIDTH           (DEV_AD_WIDTH),
      .DEV_BA_WIDTH           (DEV_BA_WIDTH),
      .DUPLICATE_CONTROLS     (DUPLICATE_CONTROLS),
      .RL_CK_PERIOD           (RL_CK_PERIOD),
      .RL_MRS_CONF            (RL_MRS_CONF),
      .RL_MRS_BURST_LENGTH    (RL_MRS_BURST_LENGTH),
      .RL_MRS_ADDR_MUX        (RL_MRS_ADDR_MUX),
      .RL_MRS_DLL_RESET       (RL_MRS_DLL_RESET),
      .RL_MRS_IMPEDANCE_MATCH (RL_MRS_IMPEDANCE_MATCH),
      .RL_MRS_ODT             (RL_MRS_ODT ),
      .RL_IO_TYPE             (RL_IO_TYPE),
      .DEVICE_ARCH            (DEVICE_ARCH),
      .CAPTURE_METHOD         (CAPTURE_METHOD)
   )
   i1_rld_mem_interface_top  (
      .IDLY_CLK     (IDLY_CLK),
      .RLDRAM_CLK   (RLDRAM_CLK),
      .PB01         (PB01),
      .status       (status[4:0]),
      .RLD2_CK_P    (RLD2_A_CK_P),
      .RLD2_CK_N    (RLD2_A_CK_N),
      .RLD2_CS_N    (RLD2_A_CS_N),
      .RLD2_REF_N   (RLD2_A_REF_N),
      .RLD2_WE_N    (RLD2_A_WE_N),
      .RLD2_A       (RLD2_A_A),
      .RLD2_BA      (RLD2_A_BA),
      .RLD2_QK_P    (RLD2_A_QK_P),
      .RLD2_QK_N    (RLD2_A_QK_N),
      .RLD2_DK_P    (RLD2_A_DK_P),
      .RLD2_DK_N    (RLD2_A_DK_N),
      .RLD2_QVLD    (RLD2_A_QVLD),
      .RLD2_DQ      (RLD2_A_DQ)
);

  rld_mem_interface_top  #(
      .SIMULATION_ONLY        (SIMULATION_ONLY),
      .RL_DQ_WIDTH            (RL_DQ_WIDTH),
      .DEV_DQ_WIDTH           (DEV_DQ_WIDTH),
      .DEV_AD_WIDTH           (DEV_AD_WIDTH),
      .DEV_BA_WIDTH           (DEV_BA_WIDTH),
      .DUPLICATE_CONTROLS     (DUPLICATE_CONTROLS),
      .RL_CK_PERIOD           (RL_CK_PERIOD),
      .RL_MRS_CONF            (RL_MRS_CONF),
      .RL_MRS_BURST_LENGTH    (RL_MRS_BURST_LENGTH),
      .RL_MRS_ADDR_MUX        (RL_MRS_ADDR_MUX),
      .RL_MRS_DLL_RESET       (RL_MRS_DLL_RESET),
      .RL_MRS_IMPEDANCE_MATCH (RL_MRS_IMPEDANCE_MATCH),
      .RL_MRS_ODT             (RL_MRS_ODT ),
      .RL_IO_TYPE             (RL_IO_TYPE),
      .DEVICE_ARCH            (DEVICE_ARCH),
      .CAPTURE_METHOD         (CAPTURE_METHOD)
   )
   i2_rld_mem_interface_top  (
      .IDLY_CLK     (IDLY_CLK),
      .RLDRAM_CLK   (RLDRAM_CLK),
      .PB01         (PB01),
      .status       (status[9:5]),
      .RLD2_CK_P    (RLD2_B_CK_P),
      .RLD2_CK_N    (RLD2_B_CK_N),
      .RLD2_CS_N    (RLD2_B_CS_N),
      .RLD2_REF_N   (RLD2_B_REF_N),
      .RLD2_WE_N    (RLD2_B_WE_N),
      .RLD2_A       (RLD2_B_A),
      .RLD2_BA      (RLD2_B_BA),
      .RLD2_QK_P    (RLD2_B_QK_P),
      .RLD2_QK_N    (RLD2_B_QK_N),
      .RLD2_DK_P    (RLD2_B_DK_P),
      .RLD2_DK_N    (RLD2_B_DK_N),
      .RLD2_QVLD    (RLD2_B_QVLD),
      .RLD2_DQ      (RLD2_B_DQ)
);


endmodule

