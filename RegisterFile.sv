`timescale 1ns/1ns
module RegisterFile(
  input clk,rst,
  input [3:0] src1, src2, Dest_wb,
  input [31:0] Result_wb,
  input wirteBackEn,
  output [31:0] reg1,reg2
  );

  reg [31:0] data[0:15];


  assign reg1 = data[src1];
  assign reg2 = data[src2];

  integer i=0;
  always @(negedge clk, posedge rst) begin
    if(rst) begin
      for (i = 0; i < 16; i=i+1)
         data[i] <= i;
    end
    else if(wirteBackEn) begin
      data[Dest_wb] <= Result_wb;
    end
  end
  

endmodule  