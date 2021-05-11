`timescale 1ns/1ns
module MEM_Stage(
  input clk,reset,MEMread,MEMwrite,
  input[31:0]address,data,
  
  output[31:0] MEM_result
                );
              
  
  Data_Mem memmory(.Address(address) , .Write_data(data),
                    .Mem_Read(MEMread),.Mem_Write(MEMwrite),
                    .clk(clk),.reset(reset),.Read_Data(MEM_result));
    
endmodule