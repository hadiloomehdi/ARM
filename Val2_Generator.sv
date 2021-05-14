`timescale 1ns/1ns
module Val2_generator(
  input[31:0] Val_Rm,
  input [11:0] shift_operand,
  input imm,LDR_OR_STR,
  output reg[31:0] Val2
);
reg [31:0] imm_32bit;
always@(*)
  begin
    if(LDR_OR_STR)
      begin
        Val2 <= { {20{shift_operand[11]}},shift_operand };
      end
    else if(imm)
      begin
        imm_32bit = {24'b0,shift_operand[7:0]};
        for (integer i =0;i<2*shift_operand[11:8];i=i+1)
        begin 
          imm_32bit = {imm_32bit[0],imm_32bit[31:1]};
        end
        Val2 <= imm_32bit;
      end
    else
      begin
        case(shift_operand[6:5])
          2'b00: Val2 <= Val_Rm << shift_operand[11:7];//Left
          2'b01: Val2 <= Val_Rm >> shift_operand[11:7];//Right
          2'b10: Val2 <= Val_Rm >>> shift_operand[11:7];//Ar Right
          2'b11://Rotate R
          begin
            Val2 = Val_Rm;
            for(integer i = 0 ; i < shift_operand[11:7] ; i = i+1)
            begin
              Val2 = {Val2[0],Val2[31:1]};
            end
          end
        endcase
      end
  
  end


endmodule
