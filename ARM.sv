`timescale 1ns/1ns
module ARM(input clk,reset);
  
  wire Flush,Branch_Taken;
  
  Controller My_Controller(.Flush(Flush),.Branch_Taken(Branch_Taken));  
  Datapath My_Datapath(.clk(clk),.reset(reset),.Flush(Flush),.Branch_Taken(Branch_Taken));


  
endmodule