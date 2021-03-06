`timescale 1ns/1ns
module Hazard_Detection_Unit(
    input [3:0] src1,src2,Exe_Dest,Mem_Dest,
    input Exe_WB_En,Mem_WB_En,two_src,Mem_Read_Exe,
    input Forward_en,
    output reg Hazard_Detected 
);
  
   always@(*)
    begin
      if(~Forward_en)//Without Forwarding
        begin
          if(
            (src1 == Exe_Dest &&  Exe_WB_En == 1 ) ||
            (src1 == Mem_Dest &&  Mem_WB_En == 1 ) ||
            (src2 == Exe_Dest &&  Exe_WB_En == 1 && two_src == 1) ||
            (src2 == Mem_Dest &&  Mem_WB_En == 1 && two_src == 1)
           )
            begin
              Hazard_Detected <= 1;
            end
          else
            begin
              Hazard_Detected <= 0;
            end
        end
      else//With Forwardin
        begin
          
          if(Mem_Read_Exe)
            begin
              
              if(
                (src1 == Exe_Dest &&  Exe_WB_En == 1 ) ||
                (src2 == Exe_Dest &&  Exe_WB_En == 1 && two_src == 1)
              )
              begin
                Hazard_Detected <= 1;
              end
            else 
              begin
                Hazard_Detected <= 0;
              end
            end
          else
            begin
             Hazard_Detected <= 0;
           end
         end 
        end
    
endmodule
