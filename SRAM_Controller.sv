`timescale 1ns/1ns
module SRAM_Controller(
input clk,reset,
input write_en,read_en,
input [31:0] address,writeData,

output [31:0] readData,

output SRAM_ready,

inout [31:0] SRAM_DQ,

output [16:0] SRAM_ADDR,
output SRAM_WE_N
);

wire[16:0] s_address ;
assign s_address = address[19:2]-256;


reg [2:0] counter,counter_plus;

reg [1:0] present_state,next_state;
parameter SRAM_Start = 2'b00 , SRAM_Read=2'b01 , SRAM_Write=2'b10;



always @(posedge clk,posedge reset)
begin
  if(reset) present_state <= 0;
  else present_state <= next_state;
end

assign next_state = (present_state == SRAM_Start && write_en)        ? SRAM_Write:
                    (present_state == SRAM_Start && read_en)         ? SRAM_Read :
                    (present_state == SRAM_Read  && counter < 3'd6) ? SRAM_Read :
                    (present_state == SRAM_Write && counter < 3'd6) ? SRAM_Write:
                     SRAM_Start;
                
                
                     
always @(posedge clk,posedge reset)
begin
  if(reset) counter <= 0;
  else counter <= counter_plus;
end

  assign counter_plus = (present_state == SRAM_Write && counter < 3'd6) ? counter+1:
                        (present_state == SRAM_Read  && counter < 3'd6) ? counter+1:
                        3'b0;
                     
                     
                   
                     
  assign  SRAM_ready = (present_state == SRAM_Write  && counter < 3'd6)     ? 1'b0 :
                       (present_state == SRAM_Read   && counter < 3'd6)     ? 1'b0 :
                       (present_state == SRAM_Start) && (write_en | read_en) ? 1'b0 :
                       1'b1;           
  
  assign  SRAM_DQ   = (present_state == SRAM_Write  && counter < 3'd6) ? writeData  : 32'bz ;
 
  assign  SRAM_ADDR = s_address;
 
  assign  SRAM_WE_N = (present_state == SRAM_Write  && counter < 3'd6) ? 1'b0 : 1'b1  ;

  assign  readData  = SRAM_DQ;

endmodule
