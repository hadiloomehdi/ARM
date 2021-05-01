`timescale 1ns/1ns
module EX_Stage_Reg(input clk,reset,
                input [31:0] PC_in,
                output reg [31:0] PC);
                
  always@(posedge clk,posedge reset)
    begin
      if(reset)
        begin
          PC <= 32'b0;
        end
      else
        begin
          PC <= PC_in;
        end
    end
                
endmodule


