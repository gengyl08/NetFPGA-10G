module mac_addr_lookup
(
   input [31:0] ip_addr,
   output reg [47:0] mac_addr,
   output reg lookup_success
);

   reg [31:0] ip_table = 32'h33333333;
   reg success = 0;
   always @(*) begin
      lookup_success = 0;
      if(ip_addr==ip_table) begin
         lookup_success = 1;
         mac_addr = 48'h444444444444;
      end
   end
endmodule
