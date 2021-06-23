`timescale 1ns/1ns
module ARM(input clk,reset,Forward_en,
           output [16:0] SRAM_ADDR,inout [31:0] SRAM_DQ,
           output SRAM_WE_N
            );

  wire Freeze,Flush;
  wire [31:0] Branch_Addres;
  wire [31:0] PC,Instruction;
  wire [31:0] IF_Reg_PC,IF_Reg_Instruction;
  
  wire [31:0] WB_Value;
  wire WB_WB_En;
  wire [3:0] WB_Dest;
  wire [3:0] SR;
  wire WB_EN_ID,MEM_R_EN_ID,MEM_W_EN_ID,Branch_Taken_ID,ST_ID;
  wire [3:0] EXE_CMD_ID;
  wire [31:0] Val_Rn_ID,Val_Rm_ID;
  wire imm_ID;
  wire [11:0] Shift_operand_ID;
  wire [23:0] Signed_imm_24_ID;
  wire [3:0]Dest_ID;
  wire Two_src;
  wire [3:0] src1,src2;
  
  wire WB_EN_EXE,MEM_R_EN_EXE,MEM_W_EN_EXE,ST_EXE;
  wire [3:0] EXE_CMD_EXE;
  wire [31:0] EXE_PC;
  wire [31:0] Val1,Val_Rm_EXE;
  wire imm_EXE;
  wire [3:0]Dest_EXE;
  wire [11:0] Shift_operand_EXE;
  wire [23:0] Signed_imm_24_EXE;
  wire C_EXE;
  
  wire [3:0] SR_EXE;
  
  wire [31:0] Alu_result;
  
  wire WB_EN_MEM,MEM_R_EN_MEM,MEM_W_EN_MEM;
  
  wire [31:0] Alu_result_MEM,Val_Rm_MEM;
  
  wire [3:0] Dest_MEM;
  
  wire [31:0] MEM_Result;
  
  wire MEM_R_EN_WB;
  
  wire [31:0] Alu_result_WB,MEM_Result_WB;
  
  wire C_in,V_in,N_in,Z_in;

  wire [1:0] sel_src1,sel_src2;
  
  wire [3:0] EXE_src1,EXE_src2;
  
  wire SRAM_ready;

 IF_Stage My_IF_Stage(.clk(clk),.reset(reset),.Freeze(Freeze),.Branch_Taken(Flush),
                      .SRAM_Freeze(~SRAM_ready),
                      .Branch_Addres(Branch_Addres),
                      .PC(PC),.Instruction(Instruction));
  
 IF_Stage_Reg My_IF_Stage_Reg(.clk(clk),.reset(reset),.Freeze(Freeze),.Flush(Flush),
                              .SRAM_Freeze(~SRAM_ready),
                              .PC_in(PC),.Instruction_in(Instruction),
                              .PC(IF_Reg_PC),.Instruction(IF_Reg_Instruction));
                
 ID_Stage MY_ID_Stage(
        .clk(clk), .reset(reset),
        .Instruction(IF_Reg_Instruction),
        //from WB stage
        .WB_Value(WB_Value), 
        .WB_WB_En(WB_WB_En),
        .WB_Dest(WB_Dest),
        //from hazard detect module
        .hazard(Freeze),
        //from Status Register
        .SR(SR),
        //to next stage
        .WB_EN(WB_EN_ID),.MEM_R_EN(MEM_R_EN_ID),.MEM_W_EN(MEM_W_EN_ID),.B(Branch_Taken_ID),.S(ST_ID),
        .EXE_CMD(EXE_CMD_ID),
        .Val_Rn(Val_Rn_ID),.Val_Rm(Val_Rm_ID),
        .imm(imm_ID),
        .Shift_operand(Shift_operand_ID),
        .Signed_imm_24(Signed_imm_24_ID),
        .Dest(Dest_ID),
        //to hazard detect module
        .src1(src1),.src2(src2),
        .Two_src(Two_src)
        );

ID_Stage_Reg My_ID_Stage_Reg(
        .clk(clk),.reset(reset),.flush(Flush),
        .Wb_EN_IN(WB_EN_ID),.MEM_R_EN_IN(MEM_R_EN_ID),.MEM_W_EN_IN(MEM_W_EN_ID),
        .B_IN(Branch_Taken_ID),.S_IN(ST_ID),
        .EXE_CMD_IN(EXE_CMD_ID),
        .PC_IN(IF_Reg_PC),
        .Val_Rn_IN(Val_Rn_ID),.Val_Rm_IN(Val_Rm_ID),
        .imm_IN(imm_ID),
        .Shift_operand_IN(Shift_operand_ID),
        .Signed_imm_24_IN(Signed_imm_24_ID),
        .Dest_IN(Dest_ID),
        .C_in(SR[3]),
        .ID_src1(src1),.ID_src2(src2),
        .SRAM_Freeze(~SRAM_ready),
  
        .Wb_EN(WB_EN_EXE),.MEM_R_EN(MEM_R_EN_EXE),.MEM_W_EN(MEM_W_EN_EXE),.B(Flush),.S(ST_EXE),
        .EXE_CMD(EXE_CMD_EXE),
        .PC(EXE_PC),
        .Val_Rn(Val1),.Val_Rm(Val_Rm_EXE),
        .imm(imm_EXE),
        .Shift_operand(Shift_operand_EXE),
        .Signed_imm_24(Signed_imm_24_EXE),
        .Dest(Dest_EXE),
        .C_out(C_EXE),
        .EXE_src1(EXE_src1),.EXE_src2(EXE_src2)          
        );
wire[31:0] Val_Rm_Exe;
  
EX_Stage My_EX_Stage(
      .clk(clk),.reset(reset),
      .EXE_CMD(EXE_CMD_EXE),
      .MEM_R_EN(MEM_R_EN_EXE),.MEM_W_EN(MEM_W_EN_EXE),
      .PC(EXE_PC),
      .VAL_RN(Val1),.VAL_RM(Val_Rm_EXE),
      .imm(imm_EXE),
      .Shift_operand(Shift_operand_EXE),
      .Signed_imm_24(Signed_imm_24_EXE),
      .C_in(C_EXE),
      .Alu_result_MEM(Alu_result_MEM),
      .WB_Value(WB_Value),
      .sel_src1(sel_src1),.sel_src2(sel_src2),
      
      .Val_Rm_Exe(Val_Rm_Exe),
      .ALU_result(Alu_result),.Br_addr(Branch_Addres),
      .status(SR_EXE)
      );
      
      
EX_Stage_Reg My_EX_Stage_Reg(
      .clk(clk),.reset(reset),.WB_EN_IN(WB_EN_EXE),.MEM_R_EN_IN(MEM_R_EN_EXE),.MEM_W_EN_IN(MEM_W_EN_EXE),
      .ALU_result_in(Alu_result),.Val_Rm_IN(Val_Rm_Exe),
      .Dest_in(Dest_EXE),
      .SRAM_Freeze(~SRAM_ready),
      
      .WB_EN(WB_EN_MEM),.MEM_R_EN(MEM_R_EN_MEM),.MEM_W_EN(MEM_W_EN_MEM),
      .ALU_result(Alu_result_MEM),.Val_Rm(Val_Rm_MEM),
      .Dest(Dest_MEM)
      );
      
MEM_Stage My_MEM_Stage(
      .clk(clk),.reset(reset),.MEMread(MEM_R_EN_MEM),.MEMwrite(MEM_W_EN_MEM),
      .address(Alu_result_MEM),.data(Val_Rm_MEM),
  
      .MEM_result(MEM_Result),
      
      .SRAM_ready(SRAM_ready),
      
      .SRAM_DQ(SRAM_DQ),
      .SRAM_ADDR(SRAM_ADDR),
      .SRAM_WE_N(SRAM_WE_N)
      );
      
MEM_Stage_Reg My_MEM_Stage_Reg(
      .clk(clk),.reset(reset),.WB_EN_IN(WB_EN_MEM),.MEM_R_EN_IN(MEM_R_EN_MEM),
      .ALU_result_in(Alu_result_MEM),.Mem_read_value_in(MEM_Result),
      .Dest_in(Dest_MEM),
      .SRAM_Freeze(~SRAM_ready),
  
      .WB_en(WB_WB_En),.MEM_R_en(MEM_R_EN_WB),
      .ALU_result(Alu_result_WB),.Mem_read_value(MEM_Result_WB),
      .Dest(WB_Dest)
      );
      
WB_Stage My_WB_Stage(
      .ALU_result(Alu_result_WB),.MEM_result(MEM_Result_WB),
      .MEM_R_en(MEM_R_EN_WB),

      .out(WB_Value)
      );

Hazard_Detection_Unit My_Hazard_Detection_Unit(
    .src1(src1),.src2(src2),.Exe_Dest(Dest_EXE),.Mem_Dest(Dest_MEM),
    .Exe_WB_En(WB_EN_EXE),.Mem_WB_En(WB_EN_MEM),.two_src(Two_src),.Mem_Read_Exe(MEM_R_EN_EXE),
    .Forward_en(Forward_en),
    .Hazard_Detected (Freeze)
    );

assign {C_in,V_in,N_in,Z_in} = SR_EXE;

Status_register My_Status_register(
    .clk(clk),.reset(reset),
    .C_in(C_in),.V_in(V_in),.N_in(N_in),.Z_in(Z_in),.S(ST_EXE),
    .SR(SR)
    );

ForwardingUnit My_ForwardingUnit(
      .WB_EN_MEM(WB_EN_MEM),.WB_WB_En(WB_WB_En),.Forward_en(Forward_en),
      .Dest_MEM(Dest_MEM),.WB_Dest(WB_Dest),
      .src1(EXE_src1),.src2(EXE_src2),

      .sel_src1(sel_src1),.sel_src2(sel_src2)
);

  
endmodule