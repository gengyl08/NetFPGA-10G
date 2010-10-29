//-----------------------------------------------------------------------------
// pselect_f.vhd - entity/architecture pair
//-----------------------------------------------------------------------------
//
// *************************************************************************
// **                                                                     **
// ** DISCLAIMER OF LIABILITY                                             **
// **                                                                     **
// ** This text/file contains proprietary, confidential                   **
// ** information of Xilinx, Inc., is distributed under                   **
// ** license from Xilinx, Inc., and may be used, copied                  **
// ** and/or disclosed only pursuant to the terms of a valid              **
// ** license agreement with Xilinx, Inc. Xilinx hereby                   **
// ** grants you a license to use this text/file solely for               **
// ** design, simulation, implementation and creation of                  **
// ** design files limited to Xilinx devices or technologies.             **
// ** Use with non-Xilinx devices or technologies is expressly            **
// ** prohibited and immediately terminates your license unless           **
// ** covered by a separate agreement.                                    **
// **                                                                     **
// ** Xilinx is providing this design, code, or information               **
// ** "as-is" solely for use in developing programs and                   **
// ** solutions for Xilinx devices, with no obligation on the             **
// ** part of Xilinx to provide support. By providing this design,        **
// ** code, or information as one possible implementation of              **
// ** this feature, application or standard, Xilinx is making no          **
// ** representation that this implementation is free from any            **
// ** claims of infringement. You are responsible for obtaining           **
// ** any rights you may require for your implementation.                 **
// ** Xilinx expressly disclaims any warranty whatsoever with             **
// ** respect to the adequacy of the implementation, including            **
// ** but not limited to any warranties or representations that this      **
// ** implementation is free from claims of infringement, implied         **
// ** warranties of merchantability or fitness for a particular           **
// ** purpose.                                                            **
// **                                                                     **
// ** Xilinx products are not intended for use in life support            **
// ** appliances, devices, or systems. Use in such applications is        **
// ** expressly prohibited.                                               **
// **                                                                     **
// ** Any modifications that are made to the Source Code are              **
// ** done at the users sole risk and will be unsupported.               **
// ** The Xilinx Support Hotline does not have access to source           **
// ** code and therefore cannot answer specific questions related         **
// ** to source HDL. The Xilinx Hotline support of original source        **
// ** code IP shall only address issues and questions related             **
// ** to the standard Netlist version of the core (and thus               **
// ** indirectly, the original core source).                              **
// **                                                                     **
// ** Copyright (c) 2010 Xilinx, Inc. All rights reserved.                **
// **                                                                     **
// ** This copyright and support notice must be retained as part          **
// ** of this text at all times.                                          **
// **                                                                     **
// *************************************************************************
//
//-----------------------------------------------------------------------------
// Filename:        pselect_f.v
//
// Description:
//                  (Note: At least as early as I.31, XST implements a carry-
//                   chain structure for most decoders when these are coded in
//                   inferrable VHLD. An example of such code can be seen
//                   below in the "INFERRED_GEN" Generate Statement.
//
//                   ->  New code should not need to instantiate pselect-type
//                       components.
//
//                   ->  Existing code can be ported to Virtex5 and later by
//                       replacing pselect instances by pselect_f instances.
//                       As long as the C_FAMILY parameter is not included
//                       in the Generic Map, an inferred implementation
//                       will result.
//
//                   ->  If the designer wishes to force an explicit carry-
//                       chain implementation, pselect_f can be used with
//                       the C_FAMILY parameter set to the target
//                       Xilinx FPGA family.
//                  )
//
//                  Parameterizeable peripheral select (address decode).
//                  AValid qualifier comes in on Carry In at bottom
//                  of carry chain.
//
//
//-----------------------------------------------------------------------------
// Structure:   This section shows the hierarchical structure of axi_lite_ipif.
//
//              --axi_lite_ipif.v
//                    --slave_attachment.v
//                       --address_decoder.v
//                       --pselect_f.v
//                    --counter_f.v
//-----------------------------------------------------------------------------
// Author:      BSB
//
// History:
//
//  BSB      05/20/10      -- First version
// ~~~~~~
//  - Created the first version v1.00.a
// ^^^^^^
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// Naming Conventions:
//      active low signals:                     "*_n"
//      clock signals:                          "clk", "clk_div#", "clk_#x"
//      reset signals:                          "rst", "rst_n"
//      generics:                               "C_*"
//      user defined types:                     "*_TYPE"
//      state machine next state:               "*_ns"
//      state machine current state:            "*_cs"
//      combinatorial signals:                  "*_com"
//      pipelined or register delay signals:    "*_d#"
//      counter signals:                        "*cnt*"
//      clock enable signals:                   "*_ce"
//      internal version of output port         "*_i"
//      device pins:                            "*_pin"
//      ports:                                  - Names begin with Uppercase
//      processes:                              "*_PROCESS"
//      component instantiations:               "<ENTITY_>I_<#|FUNC>
//-----------------------------------------------------------------------------
//---------------------------------------------------------------------------
// Entity section
//---------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// Definition of Generics:
//          C_AB            -- number of address bits to decode
//          C_AW            -- width of address bus
//          C_BAR           -- base address of peripheral (peripheral select
//                             is asserted when the C_AB most significant
//                             address bits match the C_AB most significant
//                             C_BAR bits
// Definition of Ports:
//          A               -- address input
//          AValid          -- address qualifier
//          CS              -- peripheral select
//-----------------------------------------------------------------------------
module pselect_f (A, AValid, CS);

parameter C_AB  = 9;
parameter C_AW  = 32;
parameter [0:C_AW - 1] C_BAR =  'bz;
parameter C_FAMILY  = "nofamily";
input[0:C_AW-1] A; 
input AValid; 
output CS; 
wire CS;
parameter [0:C_AB-1]BAR = C_BAR[0:C_AB-1];

//----------------------------------------------------------------------------
// Build a behavioral decoder
//----------------------------------------------------------------------------
generate
if (C_AB > 0) begin : XST_WA
assign CS = (A[0:C_AB - 1] == BAR[0:C_AB - 1]) ? AValid : 1'b0 ;
end
endgenerate;

generate
if (C_AB == 0) begin : PASS_ON_GEN
assign CS = AValid ;
end
endgenerate;
endmodule
