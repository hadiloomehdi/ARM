`timescale 1ns/1ns
module Status_register(input clk,reset,C_in,V_in,N_in,Z_in,S, output SR);
  
  reg C_out,V_out,N_out,Z_out;
  
  always@(negedge clk,posedge reset)
  begin
    if(reset)
      begin
        {C_out,V_out,N_out,Z_out} <= 4'b0;
      end
  else if(S)
    begin
      C_out <= C_in;
      V_out <= V_in;
      N_out <= N_in;
      Z_out <= Z_in;
    
    end
  end
  
  assign SR = {C_out,V_out,N_out,Z_out};
endmodule