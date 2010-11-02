/*
* Author: Jonathan Ellithorpe <jdellit@stanford.edu>
* Description: Example OpenCPI worker to which you can read and write
*					registers over WCI. Based on the example biasWorker.v
*					module written by Shepard Siegel.
* Date: 2010/09/30
*/

module mkWCIExample4B(	wci_Clk,
								wci_MReset_n,
								wci_MCmd,
								wci_MAddrSpace,
								wci_MByteEn,
								wci_MAddr,
								wci_MData,
								wci_SResp,
								wci_SData,
								wci_SThreadBusy,
								wci_SFlag,
								wci_MFlag,
								
								hw_version,
								clk_ok,
								sram_status,
								pwr_ok,
								cpld_status,
								dram_status,
								xaui_ok_0,
								tx_count_0,
								rx_count_0,
								err_count_0,
								xaui_ok_1,
								tx_count_1,
								rx_count_1,
								err_count_1,
								xaui_ok_2,
								tx_count_2,
								rx_count_2,
								err_count_2,
								xaui_ok_3,
								tx_count_3,
								rx_count_3,
								err_count_3,
								aurora_err_count_0,
								aurora_link_0,
								aurora_err_count_1,
								aurora_link_1,
								led							
								);
								
	// Input and output declarations			 
	input						wci_Clk;
	input  					wci_MReset_n;
	input  		[2 : 0] 	wci_MCmd;
	input  					wci_MAddrSpace;
	input  		[3 : 0] 	wci_MByteEn;
	input  		[19 : 0] wci_MAddr;
	input  		[31 : 0] wci_MData;
	output reg 	[1 : 0] 	wci_SResp;
	output reg 	[31 : 0] wci_SData;
	output reg 				wci_SThreadBusy;
	output reg 	[1 : 0] 	wci_SFlag;
	input  		[1 : 0] 	wci_MFlag;
	
	input  		[31 : 0] hw_version;
	input  		[31 : 0] clk_ok;
	input  		[31 : 0] sram_status;
	input  		[31 : 0] pwr_ok;
	input  		[31 : 0] cpld_status;
	input  		[31 : 0] dram_status;
	input  		[31 : 0] xaui_ok_0;
	input  		[31 : 0] tx_count_0;
	input  		[31 : 0] rx_count_0;
	input  		[31 : 0] err_count_0;
	input  		[31 : 0] xaui_ok_1;
	input  		[31 : 0] tx_count_1;
	input  		[31 : 0] rx_count_1;
	input  		[31 : 0] err_count_1;
	input  		[31 : 0] xaui_ok_2;
	input  		[31 : 0] tx_count_2;
	input  		[31 : 0] rx_count_2;
	input  		[31 : 0] err_count_2;
	input  		[31 : 0] xaui_ok_3;
	input  		[31 : 0] tx_count_3;
	input  		[31 : 0] rx_count_3;
	input  		[31 : 0] err_count_3;
	input  		[31 : 0] aurora_err_count_0;
	input  		[31 : 0] aurora_link_0;
	input  		[31 : 0] aurora_err_count_1;
	input  		[31 : 0] aurora_link_1;
	input  		[31 : 0] led;		

	// Wires and registers
	wire 				wci_write, wci_read;

	// General wire assignment
	assign wci_write = (wci_MCmd==3'h1 && wci_MAddrSpace==1'b1);
	assign wci_read  = (wci_MCmd==3'h2 && wci_MAddrSpace==1'b1);

	// Inferred RAM by XST
	reg	[31:0]	mem[0:127];
	reg	[31:0]	mem_r[0:127];
	
	// Main logic
	always@(posedge wci_Clk) begin
		wci_SThreadBusy	<= 1'b0;                 
		wci_SResp			<= 2'b0;
		wci_SFlag			<= 2'h0;
		
		if (wci_MReset_n==1'b0) begin 
			wci_SThreadBusy 	<= 2'b1;
		end else begin 
			if (wci_write==1'b1) begin
				//mem[wci_MAddr[8:2]] 	<= wci_MData;
				wci_SResp 				<= 2'h1;
			end
			
			if (wci_read==1'b1) begin
				wci_SData				<= mem[wci_MAddr[8:2]];
				wci_SResp 				<= 2'h1;
			end
		end  // end of not reset clause
	end
	
	integer i;
	always@(posedge wci_Clk) begin
       mem_r[0] <= hw_version;
       mem_r[1] <= clk_ok;
       mem_r[2] <= sram_status;
       mem_r[3] <= pwr_ok;
       mem_r[4] <= cpld_status;
       mem_r[5] <= dram_status;
       mem_r[6] <= xaui_ok_0;
       mem_r[7] <= tx_count_0;
       mem_r[8] <= rx_count_0;
       mem_r[9] <= err_count_0;
       mem_r[10] <= xaui_ok_1;
       mem_r[11] <= tx_count_1;
       mem_r[12] <= rx_count_1;
       mem_r[13] <= err_count_1;
       mem_r[14] <= xaui_ok_2;
       mem_r[15] <= tx_count_2;
       mem_r[16] <= rx_count_2;
       mem_r[17] <= err_count_2;
       mem_r[18] <= xaui_ok_3;
       mem_r[19] <= tx_count_3;
       mem_r[20] <= rx_count_3;
       mem_r[21] <= err_count_3;
       mem_r[22] <= aurora_err_count_0;
       mem_r[23] <= aurora_link_0;
       mem_r[24] <= aurora_err_count_1;
       mem_r[25] <= aurora_link_1;
       mem_r[26] <= led;
       
       for(i = 0; i <= 26; i = i+1) begin
           mem[i] <= mem_r[i];
       end
    end		
    
    // synthesis attribute ASYNC_REG of mem_r[0] is TRUE	
    // synthesis attribute ASYNC_REG of mem_r[1] is TRUE	
    // synthesis attribute ASYNC_REG of mem_r[2] is TRUE	
    // synthesis attribute ASYNC_REG of mem_r[3] is TRUE	
    // synthesis attribute ASYNC_REG of mem_r[4] is TRUE	
    // synthesis attribute ASYNC_REG of mem_r[5] is TRUE	
    // synthesis attribute ASYNC_REG of mem_r[6] is TRUE	
    // synthesis attribute ASYNC_REG of mem_r[7] is TRUE	
    // synthesis attribute ASYNC_REG of mem_r[8] is TRUE	
    // synthesis attribute ASYNC_REG of mem_r[9] is TRUE	
    // synthesis attribute ASYNC_REG of mem_r[10] is TRUE	
    // synthesis attribute ASYNC_REG of mem_r[11] is TRUE	
    // synthesis attribute ASYNC_REG of mem_r[12] is TRUE	
    // synthesis attribute ASYNC_REG of mem_r[13] is TRUE	
    // synthesis attribute ASYNC_REG of mem_r[14] is TRUE	
    // synthesis attribute ASYNC_REG of mem_r[15] is TRUE	
    // synthesis attribute ASYNC_REG of mem_r[16] is TRUE	
    // synthesis attribute ASYNC_REG of mem_r[17] is TRUE	
    // synthesis attribute ASYNC_REG of mem_r[18] is TRUE	
    // synthesis attribute ASYNC_REG of mem_r[19] is TRUE	
    // synthesis attribute ASYNC_REG of mem_r[20] is TRUE	
    // synthesis attribute ASYNC_REG of mem_r[21] is TRUE	
    // synthesis attribute ASYNC_REG of mem_r[22] is TRUE	
    // synthesis attribute ASYNC_REG of mem_r[23] is TRUE	
    // synthesis attribute ASYNC_REG of mem_r[24] is TRUE	
    // synthesis attribute ASYNC_REG of mem_r[25] is TRUE	
    // synthesis attribute ASYNC_REG of mem_r[26] is TRUE	
    
	
endmodule  // mkWCIExample4B

