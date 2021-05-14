`timescale 1ns/1ns
module EX_Stage(input clk,reset,
input [3:0] EXE_CMD,
input MEM_R_EN,MEM_W_EN,
input [31:0]PC,
input[31:0] VAL_RN,VAL_RM,
input imm,
input[11:0] Shift_operand,
input[23:0] Signed_imm_24,
input C_in,

output[31:0] ALU_result,Br_addr,
output[3:0] status);

wire Z,N,V,C_out;
wire [31:0] signed_EX_imm_24; 
wire [31:0] Val2;
assign status = {C_out,V,N,Z};
wire LDR_OR_STR;
assign LDR_OR_STR = MEM_R_EN | MEM_W_EN;


ALU ALU(.C_in(C_in),.exe_cmd(EXE_CMD),.Val1(VAL_RN),.Val2(Val2),.Alu_result(ALU_result),.Z(Z),.N(N),.V(V),.C_out(C_out));

assign signed_EX_imm_24 = {{8{Signed_imm_24[23]}},Signed_imm_24}<<2;

Adder adder(.a(PC),.b(signed_EX_imm_24),.result(Br_addr));

Val2_generator val2_generator(
  .Val_Rm(VAL_RM),
  .shift_operand(Shift_operand),
  .imm(imm),.LDR_OR_STR(LDR_OR_STR),
  .Val2(Val2)
);
               
endmodule




