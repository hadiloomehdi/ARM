`timescale 1ns/1ns
module IF_Stage(input clk,reset,Freeze,Branch_Taken,
                input SRAM_Freeze,
                input[31:0] Branch_Addres,
                output reg [31:0] PC,Instruction);  
                
wire[31:0] pc,Address,Next_pc,instruction;
wire[31:0] Four = {32'd4};
wire freeze;

assign freeze = Freeze | SRAM_Freeze;
                       
MUX2to1_32bit My_MUX2to1_32bit(.a(Next_pc),.b(Branch_Addres),.sel(Branch_Taken),.out(pc));  
PC My_PC(.clk(clk) ,.reset(reset),.pc(pc),.Freeze(freeze),.Address(Address));  
Adder My_Adder(.a(Four),.b(Address),.result(Next_pc));     
Instruction_Mem My_Instruction_Mem(.Address(Address),.Instruction(instruction));       

assign PC = Next_pc;
assign  Instruction = instruction;
                
                    
endmodule
