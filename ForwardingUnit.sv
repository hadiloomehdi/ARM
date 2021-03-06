`timescale 1ns/1ns
module ForwardingUnit(
    input WB_EN_MEM,WB_WB_En,Forward_en,
    input [3:0] Dest_MEM,WB_Dest,src1,src2,
    
    output [1:0] sel_src1,sel_src2
);

    assign sel_src1 = (~Forward_en) ? 2'b00 :
                      ((Dest_MEM == src1) && WB_EN_MEM) ? 2'b01 :
                      ((WB_Dest  == src1) && WB_WB_En)  ? 2'b10 :
                       2'b00;
    
    assign sel_src2 = (~Forward_en) ? 2'b00 :
                      ((Dest_MEM == src2) && WB_EN_MEM)  ? 2'b01 :
                      ((WB_Dest  == src2)  && WB_WB_En)  ? 2'b10 :
                       2'b00;
endmodule