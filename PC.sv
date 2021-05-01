`timescale 1ns/1ns
module PC(input clk ,reset,input [31:0] pc,input Freeze,output reg [31:0] Address);
  
  always@(posedge clk,posedge reset)
    begin
      if(reset)
        Address <= 32'b0;
      else
        begin
          if(Freeze)
            begin
             Address <= Address;
            end
          else
           begin
            Address <= pc;
           end
        end
    end
    
endmodule
  


