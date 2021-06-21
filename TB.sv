`timescale 1ns/1ns
module TB();
  reg reset,clk = 0;
  reg Forward_en = 0;
  ARM UUT(clk,reset,Forward_en);

  always
   #100 clk=~clk;
  initial begin
    reset=1;
    #200
    reset=0;
    #100000;
    $stop;
  end
endmodule 