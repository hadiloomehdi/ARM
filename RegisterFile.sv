`timescale 1ns/1ns
module RegisterFile(
  input clk,reset,
  input [3:0] src1, src2, Dest_wb,
  input [31:0] Result_WB,
  input wirteBackEn,
  output [31:0] reg1,reg2
  );

  reg [31:0] Data[0:14];

  always @(negedge clk, posedge reset)
   begin
    if(reset)
     begin
      for (integer i = 0; i < 15; i=i+1)
      begin
         Data[i] <= i;
      end
     end
    else 
      begin
        if(wirteBackEn) 
          begin
            Data[Dest_wb] <= Result_WB;
          end
        else
          begin
             Data[Dest_wb] <= Data[Dest_wb];
          end
      end
  end
  
  assign reg1 = (src1== 4'b1111) ? 0 : Data[src1];
  assign reg2 = Data[src2];
  

endmodule  