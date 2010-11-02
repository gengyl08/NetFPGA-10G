///////////////////////////////////////////////////////////////////////////////
// (c) Copyright 2008 Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// 
///////////////////////////////////////////////////////////////////////////////
//
//  ERR_DETECT_4BYTE_GTX
//
//
//  Description : The ERR_DETECT module monitors the GTX to detect hard errors.
//                It accumulates the Soft errors according to the leaky bucket
//                algorithm described in the Aurora Specification to detect Hard
//                errors.  All errors are reported to the Global Logic Interface.
//

`timescale 1 ns / 1 ps

module aurora_ERR_DETECT_4BYTE
(
    // Lane Init SM Interface
    ENABLE_ERR_DETECT,

    HARD_ERR_RESET,


    // Global Logic Interface
    SOFT_ERR,
    HARD_ERR,


    // GTX Interface
    RX_BUF_ERR,
    RX_DISP_ERR,
    RX_NOT_IN_TABLE,
    TX_BUF_ERR,
    RX_REALIGN,

    // System Interface
    USER_CLK

);

`define DLY #1

//***********************************Port Declarations*******************************

    // Lane Init SM Interface
    input           ENABLE_ERR_DETECT;

    output          HARD_ERR_RESET;


    // Global Logic Interface
    output  [0:1]   SOFT_ERR;
    output          HARD_ERR;


    // GTX Interface
    input           RX_BUF_ERR;
    input   [3:0]   RX_DISP_ERR;
    input   [3:0]   RX_NOT_IN_TABLE;
    input           TX_BUF_ERR;
    input           RX_REALIGN;

    // System Interface
    input           USER_CLK;

//**************************External Register Declarations****************************

    reg     [0:1]   SOFT_ERR;
    reg             HARD_ERR;


//**************************Internal Register Declarations****************************

    reg     [0:1]   count_0_r;
    reg     [0:1]   count_1_r;
    reg             bucket_full_0_r;
    reg             bucket_full_1_r;
    reg     [0:3]   soft_err_r;
    reg     [0:1]   good_count_0_r;
    reg     [0:1]   good_count_1_r;


    
//*********************************Main Body of Code**********************************


    //____________________________ Error Processing _________________________________



    // Detect Soft Errors.  The lane is divided into 2 2-byte sublanes for this purpose.
    always @(posedge USER_CLK)
    begin
        // Sublane 0
        soft_err_r[0] <=  `DLY   ENABLE_ERR_DETECT & (RX_DISP_ERR[3]|RX_NOT_IN_TABLE[3]);
        soft_err_r[1] <=  `DLY   ENABLE_ERR_DETECT & (RX_DISP_ERR[2]|RX_NOT_IN_TABLE[2]);

        // Sublane 1
        soft_err_r[2] <=  `DLY   ENABLE_ERR_DETECT & (RX_DISP_ERR[1]|RX_NOT_IN_TABLE[1]);
        soft_err_r[3] <=  `DLY   ENABLE_ERR_DETECT & (RX_DISP_ERR[0]|RX_NOT_IN_TABLE[0]);
    end


    always @(posedge USER_CLK)
    begin
        // Sublane 0
        SOFT_ERR[0]  <=  `DLY    |soft_err_r[0:1];

        // Sublane 1
        SOFT_ERR[1]  <=  `DLY    |soft_err_r[2:3];
    end
    

    // Detect Hard Errors
    always @(posedge USER_CLK)
        if(ENABLE_ERR_DETECT)
            HARD_ERR  <=  `DLY    (RX_BUF_ERR | TX_BUF_ERR | RX_REALIGN
                                    | bucket_full_0_r | bucket_full_1_r);
        else
            HARD_ERR  <=  `DLY    1'b0;


    // Assert hard error reset when there is a hard error.  This assignment
    // just renames the two fanout branches of the hard error signal.
    assign HARD_ERR_RESET =   HARD_ERR;



    //_______________________________Leaky Bucket Sublane 0 ________________________


    // Good cycle counter: it takes 2 consecutive good cycles to remove a demerit from
    // the leaky bucket

    always @(posedge USER_CLK)
        if(!ENABLE_ERR_DETECT)    good_count_0_r    <=  `DLY    2'b00;
        else if ((soft_err_r[0:1] == 2'b00) & (good_count_0_r == 2'b00) )
                        good_count_0_r <= `DLY 2'b10 ;
              

        else if ((soft_err_r[0:1] == 2'b00) & (good_count_0_r == 2'b01) )
                        good_count_0_r <= `DLY 2'b11 ;
              

        else if ((soft_err_r[0:1] == 2'b00) & (good_count_0_r == 2'b10) ) 
                        good_count_0_r <=`DLY 2'b00 ;
             

        else if ((soft_err_r[0:1] == 2'b00) & (good_count_0_r == 2'b11) )
                        good_count_0_r <=`DLY 2'b01 ;
              

        else if (soft_err_r[1] == 1'b1)
                        good_count_0_r <=`DLY 2'b00 ;
              

        else if (soft_err_r[0:1] == 2'b10) 
                        good_count_0_r <=`DLY 2'b01 ;

        else 
                        good_count_0_r <= `DLY good_count_0_r ;
       



    // Perform the leaky bucket algorithm using an up/down counter.  A drop is
    // added to the bucket whenever a soft error occurs and is allowed to leak
    // out whenever the good cycles counter reaches 2.  Once the bucket fills
    // (3 drops) it stays full until it is reset by disabling and   enabling
    // the error detection circuit.

    always @(posedge USER_CLK)
            if(!ENABLE_ERR_DETECT)    count_0_r <=  `DLY    2'b00;
       
            else if ((soft_err_r[0:1] == 2'b00) & (good_count_0_r[0] == 1'b0) ) 
                        count_0_r <= `DLY count_0_r ;
                

            else if ((soft_err_r[0:1] == 2'b00) & (good_count_0_r[0] == 1'b1)  & (count_0_r == 2'b00)) 
                        count_0_r <=`DLY 2'b00 ;
               

            else if ((soft_err_r[0:1] == 2'b00) & (good_count_0_r[0] == 1'b1)  & (count_0_r == 2'b01)) 
                        count_0_r <= `DLY 2'b00 ;
                

            else if ((soft_err_r[0:1] == 2'b00) & (good_count_0_r[0] == 1'b1)  & (count_0_r == 2'b10)) 
                        count_0_r <= `DLY 2'b01 ;
                

            else if ((soft_err_r[0:1] == 2'b00) & (good_count_0_r[0] == 1'b1)  & (count_0_r == 2'b11)) 
                        count_0_r <= `DLY 2'b10 ;
                

            else if ((soft_err_r[0:1] == 2'b01) & (good_count_0_r == 2'b00) & (count_0_r == 2'b00)) 
                        count_0_r <= `DLY 2'b01 ;
                

            else if ((soft_err_r[0:1] == 2'b01) & (good_count_0_r == 2'b01)  & (count_0_r == 2'b00)) 
                        count_0_r <= `DLY 2'b01 ;
                

            else if ((soft_err_r[0:1] == 2'b01) & (good_count_0_r == 2'b10)  & (count_0_r == 2'b00)) 
                        count_0_r <= `DLY 2'b01 ;
                

            else if ((soft_err_r[0:1] == 2'b01) & (good_count_0_r == 2'b11)  & (count_0_r == 2'b00)) 
                        count_0_r <= `DLY 2'b00 ;
                

            else if ((soft_err_r[0:1] == 2'b01) & (good_count_0_r == 2'b00)  & (count_0_r == 2'b01)) 
                        count_0_r <= `DLY 2'b10 ;
                
		
            else if ((soft_err_r[0:1] == 2'b01) & (good_count_0_r == 2'b01)  & (count_0_r == 2'b01))
                        count_0_r <= `DLY 2'b10 ;
                

            else if ((soft_err_r[0:1] == 2'b01) & (good_count_0_r == 2'b10)  & (count_0_r == 2'b01)) 
                        count_0_r <= `DLY 2'b10 ;
                

            else if ((soft_err_r[0:1] == 2'b01) & (good_count_0_r == 2'b11)  & (count_0_r == 2'b01)) 
                        count_0_r <= `DLY 2'b01 ;
                

            else if ((soft_err_r[0:1] == 2'b01) & (good_count_0_r == 2'b00)  & (count_0_r == 2'b10)) 
                        count_0_r <=  `DLY 2'b11 ;
                

            else if ((soft_err_r[0:1] == 2'b01) & (good_count_0_r == 2'b01)  & (count_0_r == 2'b10)) 
                        count_0_r <= `DLY 2'b11 ;
                

            else if ((soft_err_r[0:1] == 2'b01) & (good_count_0_r == 2'b10)  & (count_0_r == 2'b10)) 
                        count_0_r <= `DLY 2'b11 ;
                

            else if ((soft_err_r[0:1] == 2'b01) & (good_count_0_r == 2'b11)  & (count_0_r == 2'b10)) 
                        count_0_r <= `DLY 2'b10 ;
                

            else if ((soft_err_r[0:1] == 2'b01) & (count_0_r == 2'b11)) 
                        count_0_r <= `DLY 2'b11 ;
                

            else if ((soft_err_r[0:1] == 2'b10) & (count_0_r == 2'b00)) 
                        count_0_r <= `DLY 2'b01 ;
               

            else if ((soft_err_r[0:1] == 2'b10) & (count_0_r == 2'b01)) 
                        count_0_r <= `DLY 2'b10 ;
                

            else if ((soft_err_r[0:1] == 2'b10) & (count_0_r == 2'b10)) 
                        count_0_r <= `DLY 2'b11 ;
                

            else if ((soft_err_r[0:1] == 2'b10) & (count_0_r == 2'b11)) 
                        count_0_r <= `DLY 2'b11 ;
                

            else if ((soft_err_r[0:1] == 2'b11) & (count_0_r == 2'b00)) 
                        count_0_r <= `DLY 2'b10 ;
                

            else if ((soft_err_r[0:1] == 2'b11) & (count_0_r == 2'b01)) 
                        count_0_r <= `DLY 2'b11 ;
                

            else if ((soft_err_r[0:1] == 2'b11) & (count_0_r == 2'b10)) 
                        count_0_r <= `DLY 2'b11 ;
                

            else if ((soft_err_r[0:1] == 2'b11) & (count_0_r == 2'b11)) 
                        count_0_r <= `DLY 2'b11 ;
            else 
                        count_0_r <=`DLY count_0_r ;
        

    always @(posedge USER_CLK)
           if(!ENABLE_ERR_DETECT)    bucket_full_0_r    <=  `DLY    1'b0;
        
           else if ((soft_err_r[0:1] == 2'b01) & (good_count_0_r  == 2'b00) & (count_0_r == 2'b11))  
                    bucket_full_0_r <= `DLY 1'b1;
             

           else if ((soft_err_r[0:1] == 2'b01) & (good_count_0_r  == 2'b01) & (count_0_r == 2'b11))  
                    bucket_full_0_r <= `DLY 1'b1;
             

           else if ((soft_err_r[0:1] == 2'b01) & (good_count_0_r  == 2'b10) & (count_0_r == 2'b11))  
                    bucket_full_0_r <= `DLY 1'b1;
             

           else if ((soft_err_r[0:1] == 2'b01) & (count_0_r == 2'b11))  
                    bucket_full_0_r <= `DLY 1'b1;
             

           else if ((soft_err_r[0:1] == 2'b11) & (count_0_r[0] == 1'b1))  
                    bucket_full_0_r <= `DLY 1'b1;
           else 
                    bucket_full_0_r <= `DLY 1'b0;




    //_______________________________Leaky Bucket Sublane 1 ________________________


       // Good cycle counter: it takes 2 consecutive good cycles to remove a demerit from
    // the leaky bucket

    always @(posedge USER_CLK)
        if(!ENABLE_ERR_DETECT)    good_count_1_r    <=  `DLY    2'b00;
        else if ((soft_err_r[2:3] == 2'b00) & (good_count_1_r == 2'b00) )
                        good_count_1_r <= `DLY 2'b10 ;
              

        else if ((soft_err_r[2:3] == 2'b00) & (good_count_1_r == 2'b01) )
                        good_count_1_r <= `DLY 2'b11 ;
              

        else if ((soft_err_r[2:3] == 2'b00) & (good_count_1_r == 2'b10) ) 
                        good_count_1_r <=`DLY 2'b00 ;
             

        else if ((soft_err_r[2:3] == 2'b00) & (good_count_1_r == 2'b11) )
                        good_count_1_r <=`DLY 2'b01 ;
              

        else if (soft_err_r[1] == 1'b1)
                        good_count_1_r <=`DLY 2'b00 ;
              

        else if (soft_err_r[2:3] == 2'b10) 
                        good_count_1_r <=`DLY 2'b01 ;

        else 
                        good_count_1_r <= `DLY good_count_1_r ;
       



    // Perform the leaky bucket algorithm using an up/down counter.  A drop is
    // added to the bucket whenever a soft error occurs and is allowed to leak
    // out whenever the good cycles counter reaches 2.  Once the bucket fills
    // (3 drops) it stays full until it is reset by disabling and   enabling
    // the error detection circuit.
    always @(posedge USER_CLK)
            if(!ENABLE_ERR_DETECT)    count_1_r <=  `DLY    2'b00;
       
            else if ((soft_err_r[2:3] == 2'b00) & (good_count_1_r[0] == 1'b0) ) 
                        count_1_r <= `DLY count_1_r ;
                

            else if ((soft_err_r[2:3] == 2'b00) & (good_count_1_r[0] == 1'b1)  & (count_1_r == 2'b00)) 
                        count_1_r <=`DLY 2'b00 ;
               

            else if ((soft_err_r[2:3] == 2'b00) & (good_count_1_r[0] == 1'b1)  & (count_1_r == 2'b01)) 
                        count_1_r <= `DLY 2'b00 ;
                

            else if ((soft_err_r[2:3] == 2'b00) & (good_count_1_r[0] == 1'b1)  & (count_1_r == 2'b10)) 
                        count_1_r <= `DLY 2'b01 ;
                

            else if ((soft_err_r[2:3] == 2'b00) & (good_count_1_r[0] == 1'b1)  & (count_1_r == 2'b11)) 
                        count_1_r <= `DLY 2'b10 ;
                

            else if ((soft_err_r[2:3] == 2'b01) & (good_count_1_r == 2'b00) & (count_1_r == 2'b00)) 
                        count_1_r <= `DLY 2'b01 ;
                

            else if ((soft_err_r[2:3] == 2'b01) & (good_count_1_r == 2'b01)  & (count_1_r == 2'b00)) 
                        count_1_r <= `DLY 2'b01 ;
                

            else if ((soft_err_r[2:3] == 2'b01) & (good_count_1_r == 2'b10)  & (count_1_r == 2'b00)) 
                        count_1_r <= `DLY 2'b01 ;
                

            else if ((soft_err_r[2:3] == 2'b01) & (good_count_1_r == 2'b11)  & (count_1_r == 2'b00)) 
                        count_1_r <= `DLY 2'b00 ;
                

            else if ((soft_err_r[2:3] == 2'b01) & (good_count_1_r == 2'b00)  & (count_1_r == 2'b01)) 
                        count_1_r <= `DLY 2'b10 ;
                
		
            else if ((soft_err_r[2:3] == 2'b01) & (good_count_1_r == 2'b01)  & (count_1_r == 2'b01))
                        count_1_r <= `DLY 2'b10 ;
                

            else if ((soft_err_r[2:3] == 2'b01) & (good_count_1_r == 2'b10)  & (count_1_r == 2'b01)) 
                        count_1_r <= `DLY 2'b10 ;
                

            else if ((soft_err_r[2:3] == 2'b01) & (good_count_1_r == 2'b11)  & (count_1_r == 2'b01)) 
                        count_1_r <= `DLY 2'b01 ;
                

            else if ((soft_err_r[2:3] == 2'b01) & (good_count_1_r == 2'b00)  & (count_1_r == 2'b10)) 
                        count_1_r <=  `DLY 2'b11 ;
                

            else if ((soft_err_r[2:3] == 2'b01) & (good_count_1_r == 2'b01)  & (count_1_r == 2'b10)) 
                        count_1_r <= `DLY 2'b11 ;
                

            else if ((soft_err_r[2:3] == 2'b01) & (good_count_1_r == 2'b10)  & (count_1_r == 2'b10)) 
                        count_1_r <= `DLY 2'b11 ;
                

            else if ((soft_err_r[2:3] == 2'b01) & (good_count_1_r == 2'b11)  & (count_1_r == 2'b10)) 
                        count_1_r <= `DLY 2'b10 ;
                

            else if ((soft_err_r[2:3] == 2'b01) & (count_1_r == 2'b11)) 
                        count_1_r <= `DLY 2'b11 ;
                

            else if ((soft_err_r[2:3] == 2'b10) & (count_1_r == 2'b00)) 
                        count_1_r <= `DLY 2'b01 ;
               

            else if ((soft_err_r[2:3] == 2'b10) & (count_1_r == 2'b01)) 
                        count_1_r <= `DLY 2'b10 ;
                

            else if ((soft_err_r[2:3] == 2'b10) & (count_1_r == 2'b10)) 
                        count_1_r <= `DLY 2'b11 ;
                

            else if ((soft_err_r[2:3] == 2'b10) & (count_1_r == 2'b11)) 
                        count_1_r <= `DLY 2'b11 ;
                

            else if ((soft_err_r[2:3] == 2'b11) & (count_1_r == 2'b00)) 
                        count_1_r <= `DLY 2'b10 ;
                

            else if ((soft_err_r[2:3] == 2'b11) & (count_1_r == 2'b01)) 
                        count_1_r <= `DLY 2'b11 ;
                

            else if ((soft_err_r[2:3] == 2'b11) & (count_1_r == 2'b10)) 
                        count_1_r <= `DLY 2'b11 ;
                

            else if ((soft_err_r[2:3] == 2'b11) & (count_1_r == 2'b11)) 
                        count_1_r <= `DLY 2'b11 ;
            else 
                        count_1_r <=`DLY count_1_r ;
        

    always @(posedge USER_CLK)
           if(!ENABLE_ERR_DETECT)    bucket_full_1_r    <=  `DLY    1'b0;
        
           else if ((soft_err_r[2:3] == 2'b01) & (good_count_1_r  == 2'b00) & (count_1_r == 2'b11))  
                    bucket_full_1_r <= `DLY 1'b1;
             

           else if ((soft_err_r[2:3] == 2'b01) & (good_count_1_r  == 2'b01) & (count_1_r == 2'b11))  
                    bucket_full_1_r <= `DLY 1'b1;
             

           else if ((soft_err_r[2:3] == 2'b01) & (good_count_1_r  == 2'b10) & (count_1_r == 2'b11))  
                    bucket_full_1_r <= `DLY 1'b1;
             

           else if ((soft_err_r[2:3] == 2'b01) & (count_1_r == 2'b11))  
                    bucket_full_1_r <= `DLY 1'b1;
             

           else if ((soft_err_r[2:3] == 2'b11) & (count_1_r[0] == 1'b1))  
                    bucket_full_1_r <= `DLY 1'b1;
           else 
                    bucket_full_1_r <= `DLY 1'b0;

endmodule
