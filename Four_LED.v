`timescale 1ns / 1ps

module Four_LED(
    input clock,
    input reset,
    input [3:0] hex0,
    input [3:0] hex1,
    input [3:0] hex2,
    input [3:0] hex3,
    output reg [3:0] enable,
    output [7:0] dispcode // �߶�����ܵ�����
    );
    
    wire clk_sys;
    wire [1:0] count;
    wire [3:0] hex_num;
    
    clk_div clk_div(
        .clk(clock),
        .clk_sys(clk_sys)
    );
    Counter4 Counter4(
        .clk(clk_sys),
        .count(count)
    );
    Hex_To_7Seg Hex_To_7Seg(
        .hex(hex_num),
        .dispcode(dispcode)
    );
    Mux4_4bits Mux4_4bits(
        .choice(count),
        .in0(hex0), .in1(hex1), .in2(hex2), .in3(hex3),
        .out(hex_num)
    );
    
    always @(count) begin
        case(count)
            2'b00: enable = 4'b1110;
            2'b01: enable = 4'b1101;
            2'b10: enable = 4'b1011;
            2'b11: enable = 4'b0111;
        endcase
    end
    
endmodule
