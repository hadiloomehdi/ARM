`timescale 1ns/1ns
module Instruction_Mem(input [31:0] Address,output reg [31:0] Instruction);
  
  reg [31:0] ins [1000:0];
  parameter integer l = 1000;
	assign Instruction = ins[Address];
	
	  initial
	   begin
		  for (int i = 0; i < l; i = i + 1) begin
		  	ins[i] = 32'b0;
		 end

	  ins[0]  = {6'b0 , 5'b00001 , 5'b00010 , 5'b0    , 11'b0};           
 	  ins[4]  = {6'b0 , 5'b00011 , 5'b00100 , 5'b0    , 11'b0};          
    ins[8]  = {6'b0 , 5'b00101 , 5'b00110 , 5'b0    , 11'b0};          
    ins[12] = {6'b0 , 5'b00111 , 5'b01000 , 5'b0010 , 11'b0};              
	  ins[16] = {6'b0 , 5'b01001 , 5'b01010 , 5'b0011 , 11'b0};      
	  ins[20] = {6'b0 , 5'b01011 , 5'b01100 , 5'b0    , 11'b0};
	  ins[24] = {6'b0 , 5'b01101 , 5'b01110 , 5'b0    , 11'b0};
      
	end
endmodule

