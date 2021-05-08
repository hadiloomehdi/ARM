`timescale 1ns/1ns
module ID_Stage(
        input clk, reset, WB_WB_EN,
        input [31:0] PC_in, instruction, WB_Value,
        input [3:0] WB_Dest, status_register, 
        

        output [31:0] PC, reg_file_out1, reg_file_out2
                
);
                
        wire status_out, mem_read, mem_write, WB_en, branch, hazard, condRes;

        wire [3:0] regFileSrc2;


        ControllerUnit controllerUnit(
                .mode(instruction[27:26]),
                .opcode(instruction[24;21]),
                .s(instruction[20]),

                .status_out(status_out),  
                .mem_read(mem_read),
                .mem_write(mem_write),
                .WB_en(WB_en),
                .branch(branch),
                .hazard(hazard)
        );

        Mux2 registerFileMux(
                .first(Instruction[15:12]),
                .second(Instruction[3:0]),
                .selector(mem_write),
                
                .out(regFileSrc2)
        );

        RegisterFile registerFile(
                .clk(clk), .rst(rst),
                .src1(Instruction[19:16]), .src2(regFileSrc2),
                .Dest_wb(WB_Dest),
                .Result_wb(WB_Value),
                .wirteBackEn(WB_WB_EN),

                .reg1(reg_file_out1), .reg2(reg_file_out2)
        );

        ConditionCheck conditionCheck(
                .cond(Instruction[31:28]),
                .statusRegister(status_register),
               
                .condRes(condRes)
        );





        assign  PC = PC_in;
        
        
endmodule
