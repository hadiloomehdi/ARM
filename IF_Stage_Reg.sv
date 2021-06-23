`timescale 1ns/1ns
module IF_Stage_Reg(input clk,reset,Freeze,Flush,
                    input SRAM_Freeze,
                    input[31:0] PC_in,Instruction_in,
                    output reg [31:0] PC,Instruction);  
                
  wire freeze;
  assign freeze = Freeze | SRAM_Freeze;
                
  always@(posedge clk,posedge reset)
    begin
      if(reset)
        begin
          PC <= 32'b0;
          Instruction <= 32'b0;
        end
      else
        begin
          if(freeze == 0)
            begin
              if(Flush)
                begin
                  Instruction <= 32'b0;
                  PC <= 32'b0;
                end
              else
                begin
                  Instruction <= Instruction_in;
                  PC <= PC_in;
                end
            end
          else
            begin
              Instruction <= Instruction;
              PC <= PC;
            end
        end
    end
endmodule