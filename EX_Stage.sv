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
input [31:0] Alu_result_MEM,WB_Value,
input [1 : 0] sel_src1,sel_src2,

output[31:0] ALU_result,Br_addr,
output[3:0] status);

wire Z,N,V,C_out;
wire [31:0] signed_EX_imm_24; 
wire [31:0] Val2;
assign status = {C_out,V,N,Z};
wire LDR_OR_STR;
assign LDR_OR_STR = MEM_R_EN | MEM_W_EN;


wire [31:0] val1, val_generator;

MUX3to1 mux_val_one(
    .a(VAL_RN), .b(Alu_result_MEM), .c(WB_Value),
    .sel(sel_src1),

    .out(val1)
);

MUX3to1 mux_val_two(
    .a(VAL_RM), .b(Alu_result_MEM), .c(WB_Value),
    .sel(sel_src2),

    .out(val_generator)
);

ALU ALU(.C_in(C_in),.exe_cmd(EXE_CMD),.Val1(val1),.Val2(Val2),.Alu_result(ALU_result),.Z(Z),.N(N),.V(V),.C_out(C_out));

assign signed_EX_imm_24 = {{8{Signed_imm_24[23]}},Signed_imm_24}<<2;

Adder adder(.a(PC),.b(signed_EX_imm_24),.result(Br_addr));

Val2_generator val2_generator(
  .Val_Rm(val_generator),
  .shift_operand(Shift_operand),
  .imm(imm),.LDR_OR_STR(LDR_OR_STR),
  .Val2(Val2)
);
               
endmodule




