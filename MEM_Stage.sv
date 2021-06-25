`timescale 1ns/1ns
module MEM_Stage(
  input clk,reset,MEMread,MEMwrite,
  input[31:0]address,data,
  
  output[31:0] MEM_result,
  
  output SRAM_ready,
  
  inout [63:0] SRAM_DQ,
  output [16:0] SRAM_ADDR,
  output SRAM_WE_N
  );

  wire cache_SRAM_ready, sram_w_en, sram_r_en;
  wire [31:0] sram_address, sram_w_data;

  
  wire cache_w_en, cache_r_en, cache_invoke, cache_hit ;
  wire [16:0] cache_address;
  wire [31:0] read_data;

  /*
  Data_Mem memmory(.Address(address) , .Write_data(data),
                    .Mem_Read(MEMread),.Mem_Write(MEMwrite),
                    .clk(clk),.reset(reset),.Read_Data(MEM_result));
  */
  
   SRAM_Controller SRAM_Controller(
         .clk(clk),.reset(reset),
         .write_en(MEMwrite),.read_en(sram_w_en),
         .address(sram_address),
         
         .writeData(sram_w_data),
         .readData(MEM_result),

         .SRAM_ready(cache_SRAM_ready),

         .SRAM_DQ(SRAM_DQ),

         .SRAM_ADDR(SRAM_ADDR),
         .SRAM_WE_N(SRAM_WE_N)
    );

    Cache_Controller Cache_Controller(
     .clk(clk), .rst(rst),

    //mem 
    .address(address), .wdata(data),  
    .MEM_R_EN(MEMread), .MEM_W_EN(MEMwrite),
    
    .rdata(MEM_result),
    .ready(SRAM_ready),

    //Sram contrl
    .sram_ready(cache_SRAM_ready),
    .sram_rdata(SRAM_DQ),
    
    .sram_address(sram_address), .sram_wdata(sram_w_data),
    .sram_w_en(sram_w_en), .sram_r_en(sram_r_en),


    //cache
    .cache_read_data(read_data), .cache_hit(cache_hit),
    
    .cache_address(cache_address),
    .cache_w_en(cache_w_en), .cache_r_en(cache_r_en), .cache_invoke(cache_invoke)

);



Cache Cache(
    .clk(clk), .rst(clk), .write_en(cache_w_en), .read_en(cache_r_en), .invoke_en(cache_invoke),
    .address(cache_address),
    .write_data(SRAM_DQ),

     .hit(cache_hit),
    .read_data(read_data)
);

    
endmodule