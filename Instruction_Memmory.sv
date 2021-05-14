`timescale 1ns/1ns
module Instruction_Mem(input [31:0] Address,output reg [31:0] Instruction);
  
  reg [31:0] ins [0:50];
	assign Instruction = ins[Address>>2];
	
	  initial
	   begin
	    ins[0] = {  32'b1110_00_1_1101_0_0000_0000_000000010100}; //MOV    R0 ,#20              //R0 = 20

      ins[1] = {  32'b1110_00_1_1101_0_0000_0001_101000000001}; //MOV    R1 ,#4096		       //R1 = 4096

      ins[2] = {  32'b1110_00_1_1101_0_0000_0010_000100000011}; //MOV    R2 ,#0xC0000000      //R2 = -1073741824 

      ins[3] = {  32'b1110_00_0_0100_1_0010_0011_000000000010}; //ADDS   R3 ,R2,R2			   //R3 = -2147483648
 
      ins[4] = {  32'b1110_00_0_0101_0_0000_0100_000000000000}; //ADC    R4 ,R0,R0      	   //R4 = 41

      ins[5] = {  32'b1110_00_0_0010_0_0100_0101_000100000100}; //SUB    R5 ,R4,R4,LSL #2     //R5 = -123

      ins[6] = {  32'b1110_00_0_0110_0_0000_0110_000010100000}; //SBC    R6 ,R0,R0,LSR #1     //R6 = 10

      ins[7] = {  32'b1110_00_0_1100_0_0101_0111_000101000010}; //ORR    R7 ,R5,R2,ASR #2     //R7 = -123

      ins[8] = {  32'b1110_00_0_0000_0_0111_1000_000000000011}; //AND    R8 ,R7,R3			   //R8 = -2147483648 

      ins[9]  = { 32'b1110_00_0_1111_0_0000_1001_000000000110}; //MVN    R9 ,R6			   //R9 = -11

      ins[10]  = { 32'b1110_00_0_0001_0_0100_1010_000000000101}; //EOR    R10,R4,R5			   //R10 = -84

      ins[11] = {32'b1110_00_0_1010_1_1000_0000_000000000110}; //CMP    R8 ,R6				
/*
      ins[12] = {32'b0001_00_0_0100_0_0001_0001_000000000001}; //ADDNE  R1 ,R1,R1 		   //R1 = 8192

      ins[13] = {32'b1110_00_0_1000_1_1001_0000_000000001000}; //TST    R9 ,R8

      ins[14] = { 32'b0000_00_0_0100_0_0010_0010_000000000010}; //ADDEQ  R2 ,R2,R2            //R2 = -1073741824

      ins[15] = { 32'b1110_00_1_1101_0_0000_0000_101100000001}; //MOV    R0 ,#1024			   //R0 = 1024

      ins[16] = { 32'b1110_01_0_0100_0_0000_0001_000000000000}; //STR    R1 ,[R0],#0  		   //MEM[1024] = 8192

      ins[17] = { 32'b1110_01_0_0100_1_0000_1011_000000000000}; //LDR    R11,[R0],#0    	   //R11 = 8192

      ins[18] = { 32'b1110_01_0_0100_0_0000_0010_000000000100}; //STR    R2 ,[R0],#4     	   //MEM[1028] = -1073741824

      ins[19] = { 32'b1110_01_0_0100_0_0000_0011_000000001000}; //STR    R3 ,[R0],#8  		   //MEM[1032] = -2147483648

      ins[20] = { 32'b1110_01_0_0100_0_0000_0100_000000001101}; //STR    R4 ,[R0],#13	       //MEM[1036] = 41

      ins[21] = { 32'b1110_01_0_0100_0_0000_0101_000000010000}; //STR    R5 ,[R0],#16 		   //MEM[1040] = -123

      ins[22] = { 32'b1110_01_0_0100_0_0000_0110_000000010100}; //STR    R6 ,[R0],#20		   //MEM[1044] = 10

      ins[23] = { 32'b1110_01_0_0100_1_0000_1010_000000000100}; //LDR    R10,[R0],#4          //R10 = -1073741824

      ins[24] = { 32'b1110_01_0_0100_0_0000_0111_000000011000}; //STR    R7 ,[R0],#24         //MEM[1048] = -123

      ins[25] = { 32'b1110_00_1_1101_0_0000_0001_000000000100}; //MOV    R1 ,#4               //R1=4

      ins[26] = { 32'b1110_00_1_1101_0_0000_0010_000000000000}; //MOV    R2 ,#0			   //R2=0

      ins[27] = { 32'b1110_00_1_1101_0_0000_0011_000000000000}; //MOV    R3 ,#0		       //R3=0
      ins[28] = { 32'b1110_00_0_0100_0_0000_0100_000100000011}; //ADD    R4 ,R0,R3,LSL #2

      ins[29] = { 32'b1110_01_0_0100_1_0100_0101_000000000000}; //LDR    R5 ,[R4],#0

      ins[30] = { 32'b1110_01_0_0100_1_0100_0110_000000000100}; //LDR    R6 ,[R4],#4

      ins[31] = { 32'b1110_00_0_1010_1_0101_0000_000000000110}; //CMP    R5 ,R6

      ins[32] = { 32'b1100_01_0_0100_0_0100_0110_000000000000}; //STRGT  R6 ,[R4],#0

      ins[33] = { 32'b1100_01_0_0100_0_0100_0101_000000000100}; //STRGT  R5 ,[R4],#4

      ins[34] = { 32'b1110_00_1_0100_0_0011_0011_000000000001}; //ADD    R3 ,R3,#1

      ins[35] = { 32'b1110_00_1_1010_1_0011_0000_000000000011}; //CMP    R3 ,#3

      ins[36] = { 32'b1011_10_1_0_111111111111111111110111} ; //BLT      9-#

      ins[37] = { 32'b1110_00_1_0100_0_0010_0010_000000000001}; //ADD    R2 ,R2,#1

      ins[38] = { 32'b1110_00_0_1010_1_0010_0000_000000000001}; //CMP    R2 ,R1   

      ins[39] = { 32'b1011_10_1_0_111111111111111111110011} ;   //BLT      13-#

      ins[40] = { 32'b1110_01_0_0100_1_0000_0001_000000000000}; //LDR    R1 ,[R0],#0          //R1 = -2147483648 

      ins[41] = { 32'b1110_01_0_0100_1_0000_0010_000000000100}; //LDR    R2 ,[R0],#4          //R2 = -1073741824 

      ins[42] = { 32'b1110_01_0_0100_1_0000_0011_000000001000}; //STR    R3 ,[R0],#8          //R3 = 41

      ins[43] = { 32'b1110_01_0_0100_1_0000_0100_000000001100}; //STR    R4 ,[R0],#12         //R4 = 8192

      ins[44] = { 32'b1110_01_0_0100_1_0000_0101_000000010000}; //STR    R5 ,[R0],#16         //R5 = -123 

      ins[45] = { 32'b1110_01_0_0100_1_0000_0110_000000010100}; //STR    R6 ,[R0],#20         //R4 = 10

      ins[46] = { 32'b1110_10_1_0_111111111111111111111111 };   //B        1-#
*/
	   end
endmodule

