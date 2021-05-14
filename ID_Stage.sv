`timescale 1ns/1ns
module ID_Stage(
        input clk, reset,
        //from IF stage
        input[31:0] Instruction,
        //from WB stage
        input[31:0] WB_Value, 
        input WB_WB_En,
        input [3:0] WB_Dest,
        //from hazard detect module
        input hazard,
        //from Status Register
        input[3:0] SR,
        //to next stage
        output WB_EN,MEM_R_EN,MEM_W_EN,B,S,
        output[3:0] EXE_CMD,
        output[31:0] Val_Rn,Val_Rm,
        output imm,
        output[11:0] Shift_operand,
        output[23:0] Signed_imm_24,
        output[3:0] Dest,
        //to hazard detect module
        output[3:0] src1,src2,
        output Two_src
        );
        
        assign imm = Instruction[25];
        assign Shift_operand = Instruction[11:0];
        assign Signed_imm_24 = Instruction[23:0];
        assign Dest = Instruction[15:12];
        assign src1 = Instruction[19:16];
        
      
        wire s_out,mem_read,mem_write,wb_en,branch,condRes;
        wire [3:0] exe_cmd,regFileSrc2;
        wire signal_sel;
        wire [8:0] controll_signals;
        
        
        
        ControllerUnit ControllerUnit(
                .mode(Instruction[27:26]),
                .opcode(Instruction[24:21]),
                .s_in(Instruction[20]),
                
                .s_out(s_out),
                .exe_cmd(exe_cmd),  
                .mem_read(mem_read),
                .mem_write(mem_write),
                .WB_en(WB_en),
                .branch(branch)
        );
        
         ConditionCheck conditionCheck(
                .cond(Instruction[31:28]),
                .statusRegister(SR),
                .condRes(condRes)
        );
        
        assign signal_sel = hazard | ~condRes;
        
        MUX2to1_9bit controll_signals_Mux(
                .a({WB_en,mem_read,mem_write,exe_cmd,branch,s_out}),
                .b({9'b0}),
                .sel(signal_sel),
                .out(controll_signals)
        );
        
        assign {WB_EN,MEM_R_EN,MEM_W_EN,EXE_CMD,B,S} = controll_signals;
        assign Two_src = ~imm || MEM_W_EN;
        
        MUX2to1_32bit registerFileMux(
                .a(Instruction[3:0]),
                .b(Instruction[15:12]),
                .sel(mem_write),
                .out(regFileSrc2)
        );
        
        assign src2 = regFileSrc2;
        
        RegisterFile registerFile(
                .clk(clk), .reset(reset),
                .src1(Instruction[19:16]), .src2(regFileSrc2),
                .Dest_wb(WB_Dest),
                .Result_WB(WB_Value),
                .wirteBackEn(WB_WB_En),

                .reg1(Val_Rn), .reg2(Val_Rm)
        );
        
       
        
endmodule
