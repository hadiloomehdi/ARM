`timescale 1ns/1ns
module Data_Mem(input[31:0] Address ,Write_data, input Mem_Read,Mem_Write,input clk,reset,output[31:0] Read_Data);
  
reg[31:0] Data [0:63];

assign Read_Data = Data[(Address-1024)>>2];
  
  always@(posedge clk)
  begin
    Data[(Address-1024)>>2] <= Mem_Write ? Write_data : Data[(Address-1024)>>2];
  end
  
endmodule
