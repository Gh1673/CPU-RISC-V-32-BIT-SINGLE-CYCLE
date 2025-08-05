`timescale 1ns / 1ps
module Data_Memory(
		   input wire 	      clk, WE,
		   input wire [31:0]  A, WD,
		   output wire [31:0] RD
		   );

   reg [31:0] 			      RAM[63:0];

   assign RD = RAM[A[31:2]]; // word aligned
initial begin
   RAM[0]  = 32'hFACEFACE;
   RAM[1]  = 32'h00000002; 
   RAM[2]  = 32'h00000003; 
   
   RAM[63] = 32'h000000063;  
end

   always @(posedge clk)
     if (WE)
       RAM[A[31:2]] <= WD;

endmodule
