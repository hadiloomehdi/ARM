`timescale 1ns/1ns
module MEM_Stage(
  input clk,reset,MEMread,MEMwrite,
  input[31:0]address,data,
  
  output[31:0] MEM_result,
  
  output SRAM_ready,
  
  inout [31:0] SRAM_DQ,
  output [16:0] SRAM_ADDR,
  output SRAM_WE_N
  );
    
  /*
  Data_Mem memmory(.Address(address) , .Write_data(data),
                    .Mem_Read(MEMread),.Mem_Write(MEMwrite),
                    .clk(clk),.reset(reset),.Read_Data(MEM_result));
  */
  
   SRAM_Controller SRAM_Controller(
         .clk(clk),.reset(reset),
         .write_en(MEMwrite),.read_en(MEMread),
         .address(address),
         
         .writeData(data),
         .readData(MEM_result),

         .SRAM_ready(SRAM_ready),

         .SRAM_DQ(SRAM_DQ),

         .SRAM_ADDR(SRAM_ADDR),
         .SRAM_WE_N(SRAM_WE_N)
);

    
endmodule