`timescale 1ns / 1ps

module DataMemory(
    input clk,
    input [31:0] DAddr,
    input [31:0] DataIn,
    input RD,    // �����ƣ�1��Ч
    input WR,    // д���ƣ�1��Ч
    output [31:0] DataOut    // ����32λ����
    );
    
    reg [7:0] RAM [0:63];    // ÿ���ڴ浥ԪΪ8λ����һ���ֽ�
    
    /* �� */
    assign DataOut[7:0]   = (RD==1) ? RAM[DAddr+3] : 8'bz;
    assign DataOut[15:8]  = (RD==1) ? RAM[DAddr+2] : 8'bz;
    assign DataOut[23:16] = (RD==1) ? RAM[DAddr+1] : 8'bz;
    assign DataOut[31:24] = (RD==1) ? RAM[DAddr+0] : 8'bz;
    
    /* д */
    always @(negedge clk) begin
        if(WR == 1) begin
            RAM[DAddr+0] <= DataIn[31:24];
            RAM[DAddr+1] <= DataIn[23:16];
            RAM[DAddr+2] <= DataIn[15:8];
            RAM[DAddr+3] <= DataIn[7:0];
        end
    end
endmodule
