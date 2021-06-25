`timescale 1ns/1ns
module Cache (
    input clk, rst, write_en, read_en , invoke_en,
    input [16:0] address,
    input [63:0] write_data,

    output hit,
    output [31:0] read_data
    
);

    reg [31:0] data_set_0 [0:1][0:63];
    reg [31:0] data_set_1 [0:1][0:63];

    reg [9:0] tag_set_0 [0:63];
    reg [9:0] tag_set_1 [0:63];

    reg  [0:63] valid_set_0, valid_set_1;

    reg  [0:63] lru;

    wire set_hit_result_0, set_hit_result_1 ;


    assign set_hit_result_0 = (tag_set_0[address[6:1]] == address[16:7]) && valid_set_0[address[6:1]];
    assign set_hit_result_1 = (tag_set_1[address[6:1]] == address[16:7]) && valid_set_1[address[6:1]];
    assign hit = set_hit_result_0 || set_hit_result_1;

    always @(posedge clk) begin


        if (write_en) begin
        
            if (lru[address[6:1]] == 1'b1) begin
                data_set_0[1][address[6:1]] <= write_data[63:32];
                data_set_0[0][address[6:1]] <= write_data[31:0];
                tag_set_0[address[6:1]] <= address[16:7];
                valid_set_0[address[6:1]] <= 1'b1;
                lru[address[6:1]] <= 1'b0;
            end
            
            else if (lru[address[6:1]] == 1'b0) begin
                data_set_1[1][address[6:1]] <= write_data[63:32];
                data_set_1[0][address[6:1]] <= write_data[31:0];
                tag_set_1[address[6:1]] <= address[16:7];
                valid_set_1[address[6:1]] <= 1'b1;
                lru[address[6:1]] <= 1'b1;
            end

        end

        if (invoke_en && hit) begin
            if (set_hit_result_0 == 1'b1) begin
                valid_set_0[address[6:1]] <= 1'b0;
                lru[address[6:1]] <= 1'b1;
            end
            else if(set_hit_result_1 == 1'b1) begin
                valid_set_1[address[6:1]] <= 1'b0;
                lru[address[6:1]] <= 1'b0;
            end
        end

        if (read_en && set_hit_result_0) begin
            lru[address[6:1]] <= 1'b0;
        end

        else if (read_en && set_hit_result_1) begin
            lru[address[6:1]] <= 1'b1;
        end

        else begin
            lru[address[6:1]] <= lru[address[6:1]];
        end
    
    end
    

endmodule