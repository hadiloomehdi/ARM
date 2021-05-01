`timescale 1ns/1ns
module Datapath(input clk,reset,Flush,Branch_Taken);
  
  assign Freeze = 1'b0;
  wire [31:0] Branch_Addres;
  wire [31:0] PC,Instruction;
  wire [31:0] IF_Reg_PC,IF_Reg_Instruction;
  
  wire [31:0] ID_PC,ID_Reg_PC;
  wire [31:0] EX_PC,EX_Reg_PC;
  wire [31:0] MEM_PC,MEM_Reg_PC;
  wire [31:0] WB_PC,WB_Reg_PC;  

 IF_Stage My_IF_Stage(.clk(clk),.reset(reset),.Freeze(Freeze),.Branch_Taken(Branch_Taken),
                .Branch_Addres(Branch_Addres),
                .PC(PC),.Instruction(Instruction));
  
 IF_Stage_Reg My_IF_Stage_Reg(.clk(clk),.reset(reset),.Freeze(Freeze),.Flush(Flush),
                .PC_in(PC),.Instruction_in(Instruction),
                .PC(IF_Reg_PC),.Instruction(IF_Reg_Instruction));
  
 ID_Stage  My_ID_Stage(.clk(clk),.reset(reset),.PC_in(IF_Reg_PC),.PC(ID_PC));
 
 ID_Stage_Reg My_ID_Stage_Reg(.clk(clk),.reset(reset),.PC_in(ID_PC),.PC(ID_Reg_PC));
 
 EX_Stage  My_EX_Stage(.clk(clk),.reset(reset),.PC_in(ID_Reg_PC),.PC(EX_PC));
 
 EX_Stage_Reg My_EX_Stage_Reg(.clk(clk),.reset(reset),.PC_in(EX_PC),.PC(EX_Reg_PC));
 
 MEM_Stage My_MEM_Stage(.clk(clk),.reset(reset),.PC_in(EX_Reg_PC),.PC(MEM_PC));
 
 MEM_Stage_Reg My_MEM_Stage_Reg(.clk(clk),.reset(reset),.PC_in(MEM_PC),.PC(MEM_Reg_PC));
 
 WB_Stage  My_WB_Stage(.clk(clk),.reset(reset),.PC_in(MEM_Reg_PC),.PC(WB_PC));
 
 WB_Stage_Reg My_WB_Stage_Reg(.clk(clk),.reset(reset),.PC_in(WB_PC),.PC(WB_Reg_PC));
                
  
endmodule