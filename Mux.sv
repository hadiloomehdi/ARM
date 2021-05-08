`timescale 1ns/1ns
module mux2 #(parameter Length = 32)(
    input [ Length - 1 : 0 ] first,
    input [ Length - 1 : 0 ] second,
    input selector,
    output [ Length - 1 : 0 ] out
);

	assign out = selector ? second :first; 

endmodule
