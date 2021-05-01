`timescale 1ns/1ns
module MUX2to1_32bit(input [31:0] a, b, input sel,output [31:0] out);
   assign out = sel ? b : a;       
endmodule


