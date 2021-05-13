`timescale 1ns/1ns
module TB();
  reg reset,clk = 0;
  ARM UUT(clk,reset);

  always
   #100 clk=~clk;
  initial begin
    reset=1;
    #200
    reset=0;
    #8000;
    $stop;
  end
endmodule 