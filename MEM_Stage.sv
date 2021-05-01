`timescale 1ns/1ns
module MEM_Stage(input clk,reset,
                input [31:0] PC_in,
                output [31:0] PC);
                
        assign  PC = PC_in;
                
endmodule