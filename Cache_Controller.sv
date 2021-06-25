`timescale 1ns/1ns
module Cache_Controller(
    input clk, rst,

    //mem 
    input [31:0] address, wdata,  
    input MEM_R_EN, MEM_W_EN,
    
    output [31:0] rdata,
    output ready,

    //Sram contrl
    input sram_ready,
    input [63:0] sram_rdata,
    
    output [31:0] sram_address, sram_wdata,
    output sram_w_en, sram_r_en,


    //cache
    input  cache_hit,
    input [31:0]cache_read_data,
    output [16:0] cache_address,
    output cache_w_en, cache_r_en, cache_invoke

);  
    wire index;
  
    wire [31:0] address_1024;
    assign address_1024 = address - 1024;
    assign cache_address = address_1024[18:2];
    assign index = address_1024[2];
    
    reg [1:0] present_state,next_state;
    parameter idle = 2'b00 , SR_CW = 2'b01 , SRAM_Write = 2'b10;

    always @(posedge clk,posedge rst)
    begin
    if(rst) present_state <= 0;
    else present_state <= next_state;
    end

  assign ns = (present_state == idle && MEM_R_EN && ~cache_hit) ? SR_CW :
              (present_state == idle && MEM_W_EN) ? SRAM_Write :
              (present_state == SR_CW && sram_ready) ? idle :
              (present_state == SRAM_Write && sram_ready) ? idle :
              present_state; 
              
  assign rdata = (present_state == idle && cache_hit) ? cache_read_data :
                 (present_state == SR_CW && sram_ready) ? (index ? sram_rdata[63:32] : sram_rdata[31:0]) :
                 32'bz;
                 
  assign ready = (ns == idle);
  
  assign sram_address = (present_state == SR_CW || present_state == SRAM_Write ) ? address : 64'bz;
  
  assign sram_write_data = (present_state == SRAM_Write) ? wdata : 64'bz;
  
  assign sram_w_en = (present_state == SRAM_Write);
                         
  assign sram_r_en = (present_state == SR_CW);
  
  assign cache_r_en = (present_state == idle);
  
  assign cache_w_en = (present_state == SR_CW && sram_ready);
  
  assign cache_invoke = (present_state == idle && ns == SRAM_Write);

endmodule