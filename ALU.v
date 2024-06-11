`timescale 1ns / 1ps

module ALU(
    input [2:0] ALUOp,
    input [31:0] A,
    input [31:0] B,
    output reg [31:0] result,
    output zero,    // ����Ƿ�Ϊ0����Ϊ1����Ϊ0
    output sign    // ����Ƿ�Ϊ������Ϊ1����Ϊ0
    );
    
    assign zero = (result == 0) ? 1 : 0;
    assign sign = result[31];
    
    always @(ALUOp or A or B) begin
        case(ALUOp)
            3'b000: result = A + B;
            3'b001: result = A - B;
            3'b010: result = B << A;
            3'b011: result = A | B;
            3'b100: result = A & B;
            3'b101: result = (A < B) ? 1 : 0; // 5: �Ƚ��޷�����
            3'b110: begin                     // 6: �Ƚϴ�������
                        if((A[31] == B[31]) && (A < B)) result = 1;
                        else if(A[31]==1 && B[31]==0) result = 1;
                        else result = 0;
                    end
            3'b111: result = A ^ B;
        endcase
    end
endmodule
