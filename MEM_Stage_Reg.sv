`timescale 1ns/1ns
module MEM_Stage_Reg(input clk,reset,WB_EN_IN,MEM_R_EN_IN,
  input[31:0] ALU_result_in,Mem_read_value_in,
  input[3:0] Dest_in,
  input SRAM_Freeze,
  
  output reg WB_en,MEM_R_en,
  output reg [31:0] ALU_result,Mem_read_value,
  output reg [3:0] Dest
               );
                
  always@(posedge clk,posedge reset)
    begin
      if(reset)
        begin
          {WB_en,MEM_R_en} <= 2'b0;
          ALU_result <= 32'b0;
          Mem_read_value <= 32'b0;
          Dest <= 4'b0;
        end
      else 
        begin
          if(SRAM_Freeze)
            begin
              WB_en <= WB_en;
              MEM_R_en <= MEM_R_en ;
              ALU_result <= ALU_result;
              Mem_read_value <= Mem_read_value ;
              Dest <= Dest;
            end
          else
            begin
              WB_en <= WB_EN_IN;
              MEM_R_en <= MEM_R_EN_IN ;
              ALU_result <= ALU_result_in;
              Mem_read_value <= Mem_read_value_in ;
              Dest <= Dest_in;
          end
        
        end
    end
    
endmodule