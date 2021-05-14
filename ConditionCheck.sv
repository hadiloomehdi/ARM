`timescale 1ns/1ns

module ConditionCheck(
  input [3:0] cond, statusRegister,
  output reg condRes
  );
  wire z,c,n,v;
  assign {c,v, n, z} = statusRegister;

  always @(*) begin
    case(cond)

      4'b0000 : condRes <= z; //EQ = 
      4'b0001 : condRes <= ~z; //NE !=
      4'b0010 : condRes <= c; // CH/HS 
      4'b0011 : condRes <= ~c; // CC/LO
      4'b0100 : condRes <= n; // MI
      4'b0101 : condRes <= ~n; // PL
      4'b0110 : condRes <= v; //VS overflow
      4'b0111 : condRes <= ~v; // VC not VS
      4'b1000 : condRes <= c & ~z; // HI
      4'b1001 : condRes <= ~c & z; // LS
      4'b1010 : condRes <= (n & v) | (~n & ~v); // GE
      4'b1011 : condRes <= (n & ~v) | (~n & v); // LT
      4'b1100 : condRes <= (~z & ( (n & v) | (~n & ~v) ) ); //GT
      4'b1101 : condRes <= (z | ( (~v & n) | (v & ~n) ) ); //LE
      4'b1110 : condRes <= 1; //AL
      4'b1111 : condRes <= 1;
      default: condRes <= 1;
    
    endcase
    
  end

endmodule 