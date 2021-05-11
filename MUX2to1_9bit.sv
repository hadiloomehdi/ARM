`timescale 1ns/1ns
module MUX2to1_9bit(input [8:0] a, b, input sel,output [8:0] out);
   assign out = sel ? b : a;       
endmodule



