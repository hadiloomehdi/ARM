`timescale 1ns/1ns
module ControllerUnit(
    input [1 : 0] mode,
    input [3 : 0] opcode,
    input s_in,
    output s_out,
    output reg [3 : 0] exe_cmd,
    output reg mem_read, mem_write, WB_en, branch
    );
    
    assign s_out = s_in;
    
    always @(mode, opcode,s_in) begin
    {mem_read, mem_write, WB_en, branch, exe_cmd} = 8'b0;
      case(mode)
        2'b00: 
        begin
          case(opcode)  
            //MOV
            4'b1101: 
            begin 
              exe_cmd <= 4'b0001;
              WB_en <= 1;
            end
            
            //MVN
            4'b1111: 
            begin 
              exe_cmd <= 4'b1001;
              WB_en <= 1;
            end
            
            //ADD
            4'b0100: 
            begin 
              exe_cmd <= 4'b0010;
              WB_en <= 1;
            end
            
            //ADC
            4'b0101: 
            begin 
              exe_cmd <= 4'b0011;
              WB_en <= 1;
            end
            
            //SUB
            4'b0010: 
            begin 
              exe_cmd <= 4'b0100;
              WB_en = 1;
            end
            
            //SBC
            4'b0110: 
            begin 
              exe_cmd <= 4'b0101;
              WB_en <= 1;
            end
            
            //AND
            4'b0000: 
            begin 
              exe_cmd <= 4'b0110;
              WB_en <= 1;
            end
            
            //ORR
            4'b1100: 
            begin 
              exe_cmd <= 4'b0111;
              WB_en <= 1;
            end
            
            //EOR
            4'b0001:
             begin 
              exe_cmd <= 4'b1000;
              WB_en <= 1;
             end
            //CMP
            4'b1010:
             begin 
              exe_cmd <= 4'b0100;
             end
            
            //TST
            4'b1000:
             begin 
              exe_cmd <= 4'b0110;
             end
            default: 
            begin
              exe_cmd <= 4'b000;
            end
          endcase
        end
        2'b01:
        begin
          if(s_in==1)
          begin //LDR
            mem_read <= 1;
            WB_en <= 1;
            exe_cmd <= 4'b0010;
          end
          else
          begin //STR
            mem_write <= 1;
            exe_cmd <= 4'b0010;
          end
        end
        2'b10:
        begin
          branch <= 1;
        end
      endcase
    end
    
    
    
    
    /*
  reg update;

  always @* 
  begin
    
    if (mode == 2'b00 ) begin
        case(opcode) 
          4'b1000: begin
            assign update = 1;
          end

          //NOP
          4'b0000: begin
            assign update = 0;
          end

          //CMP
          4'b1010: begin
            assign update = 1;
          end
          //TST
          default: begin
            assign update = s_in;
          end
        endcase
    end
      else //LDR, STR, BR
        assign update = s_in;           

  end

  assign out = update; 
  */
  
endmodule 
    
