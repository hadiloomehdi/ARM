`timescale 1ns/1ns
module WB_Stage(
  input[31:0] ALU_result,MEM_result,
  input MEM_R_en,

  output [31:0] out);
  
   MUX2to1_32bit wb_mux(.a(ALU_result),.b(MEM_result),.sel(MEM_R_en),.out(out));
                
endmodule