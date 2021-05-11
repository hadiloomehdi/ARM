`timescale 1ns/1ns
module ALU(input C_in,input [3:0] exe_cmd, input [31:0] Val1,Val2,output reg [31:0] Alu_result,output Z,N,output reg V,C_out);
  
  always@(Val1,Val2,exe_cmd)
    begin
       {V,C_out} = 2'b0;
      case(exe_cmd)
        4'b0001 ://MOV
        begin
          Alu_result <= Val2;
        end
        4'b1001 ://MVN
        begin
          Alu_result <= ~Val2;
        end 
        4'b0010 ://ADD
        begin
          {C_out,Alu_result} <= Val1 + Val2;
          V <= (Val1[31] & Val2[31] & !Alu_result[31]) || (!Val1[31] & !Val2[31] & Alu_result[31]);
        end
        4'b0011 : //ADDC
        begin
          {C_out,Alu_result} <= Val1 + Val2 + C_in;
           V <= (Val1[31] & Val2[31] & !Alu_result[31]) || (!Val1[31] & !Val2[31] & Alu_result[31]);
        end
        4'b0100 ://SUB
        begin
          {C_out,Alu_result} <= Val1 - Val2;
           V <= (!Val1[31] & Val2[31] & Alu_result[31]) || (Val1[31] & !Val2[31] & Alu_result[31]);
        end
        4'b0101 ://SUBC
        begin
          {C_out,Alu_result} <= Val1 - Val2 - C_in;
           V <= (!Val1[31] & Val2[31] & Alu_result[31]) || (Val1[31] & !Val2[31] & Alu_result[31]);
        end
        4'b0110 ://AND,LDR,STR
        begin
          Alu_result <= Val1 & Val2;
        end
        4'b0111 ://ORR
        begin
           Alu_result <= Val1 | Val2;
        end
        4'b1000 : //EOR
        begin
           Alu_result <= Val1 ^ Val2;
        end
        4'b0100 : //CMP
        begin
          Alu_result <= Val1 - Val2;
        end
        4'b0110 : //TST
        begin
           Alu_result <= Val1 & Val2;
        end
        default: Alu_result <= Alu_result;
      endcase
    end
    
    assign N = Alu_result[31];
    assign Z = (Alu_result == 0) ? 1 : 0;
    
      
endmodule



