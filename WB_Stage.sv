`timescale 1ns/1ns
module WB_Stage(input clk,reset,
                input [31:0] PC_in,
                output [31:0] PC);
                
        assign  PC = PC_in;
                
endmodule