`timescale 1ns/1ns
module TB();
  reg reset,clk = 0;
  reg Forward_en = 0;
  reg SRAM_clk = 0;
  
  wire SRAM_WE_N;
  wire [16:0] SRAM_ADDR;
  wire [31:0] SRAM_DQ;
  
  ARM ARM_UUT(.clk(clk),.reset(reset),.Forward_en(Forward_en),
          .SRAM_WE_N(SRAM_WE_N),
          .SRAM_ADDR(SRAM_ADDR),.SRAM_DQ(SRAM_DQ));
              
  SRAM SRAM_UUT(.clk(SRAM_clk),.reset(reset),
                .SRAM_WE_N(SRAM_WE_N),
                .SRAM_ADDR(SRAM_ADDR),.SRAM_DQ(SRAM_DQ));

  always #10 clk=~clk;
  always #20 SRAM_clk = ~SRAM_clk;
  
  initial begin
    reset=1;
    #200
    reset=0;
    #13000;
    $stop;
  end
endmodule 