`timescale 1ns/1ns
module EX_Stage_Reg(
  input clk,reset,WB_EN_IN,MEM_R_EN_IN,MEM_W_EN_IN,
  input[31:0] ALU_result_in,Val_Rm_IN,
  input[3:0] Dest_in,
  input SRAM_Freeze,
  
  output reg WB_EN,MEM_R_EN,MEM_W_EN,
  output reg[31:0] ALU_result,Val_Rm,
  output reg[3:0] Dest);
                
  always@(posedge clk,posedge reset)
    begin
      if(reset)
        begin
          {WB_EN,MEM_R_EN,MEM_W_EN} = 3'b0;
          Dest = 4'b0;
          ALU_result = 32'b0;
          Val_Rm = 32'b0;
        end
      else
        if(~SRAM_Freeze)
          begin
            WB_EN <= WB_EN_IN;
            MEM_R_EN <= MEM_R_EN_IN;
            MEM_W_EN <= MEM_W_EN_IN;
            Dest <= Dest_in;
            Val_Rm <= Val_Rm_IN;
            ALU_result <= ALU_result_in;
          end
        else
          begin
            WB_EN <= WB_EN;
            MEM_R_EN <= MEM_R_EN;
            MEM_W_EN <= MEM_W_EN;
            Dest <= Dest;
            Val_Rm <= Val_Rm;
            ALU_result <= ALU_result;
          end
    end
                
endmodule


