//-----------------------------------------------------------------------------
// nf10_tb.v
//-----------------------------------------------------------------------------

`timescale 1 ns / 1ps

`uselib lib=unisims_ver

// START USER CODE (Do not remove this line)

// User: Put your directives here. Code in this
//       section will not be overwritten.

// END USER CODE (Do not remove this line)

module nf10_tb
  (
  );

  // START USER CODE (Do not remove this line)

  // User: Put your signals here. Code in this
  //       section will not be overwritten.
  integer             i;
  
  // END USER CODE (Do not remove this line)


  reg RESET;
  wire RS232_Uart_1_sout;
  reg RS232_Uart_1_sin;
  reg CLK;
  wire MDIO;
  wire MDC;
  wire PHY_RST_N;

  nf10
    dut (
      .RESET ( RESET ),
      .RS232_Uart_1_sout ( RS232_Uart_1_sout ),
      .RS232_Uart_1_sin ( RS232_Uart_1_sin ),
      .CLK ( CLK ),
      .MDIO ( MDIO ),
      .MDC ( MDC ),
      .PHY_RST_N ( PHY_RST_N )
    );

  // START USER CODE (Do not remove this line)

  // User: Put your stimulus here. Code in this
  //       section will not be overwritten.
  initial begin
      RS232_Uart_1_sin = 1'b0;
      CLK   = 1'b0;
  
      $display("[%t] : System Reset Asserted...", $realtime);
      RESET = 1'b1;
      for (i = 0; i < 50; i = i + 1) begin
                 @(posedge CLK);
      end
      $display("[%t] : System Reset De-asserted...", $realtime);
      RESET = 1'b0;
  end
  
  always #5  CLK = ~CLK;      // 100MHz

  // END USER CODE (Do not remove this line)

endmodule

