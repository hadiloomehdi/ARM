`timescale 1ns/1ns
module MUX2to1_4bit(input [3:0] a, b, input sel,output [3:0] out);
   assign out = sel ? b : a;       
endmodule




