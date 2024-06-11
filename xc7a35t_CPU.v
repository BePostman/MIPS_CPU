`timescale 1ns / 1ps

module xc7a35t_CPU(
    input xc7a35t_clock,
    input reset_sw,
    input [1:0] SW_in,
    input next_button,
    output [3:0] enable,
    output [7:0] dispcode
    );
    
    wire [31:0] currentIAddr, nextIAddr;
    wire [4:0] rs, rt;
    wire [31:0] ReadData1, ReadData2;
    wire [31:0] ALU_result, DataBus;
    
    wire next_signal;    // ��������ֶ������ź�
    wire [15:0] DisplayData;
    
    top_CPU top_CPU(
        .clk(next_signal),    // ȡ����ʹ�ð��°�ť�ṩ�͵�ƽ���ɿ���PC�ŵ���
        .Reset(reset_sw),
        .currentIAddr(currentIAddr), .nextIAddr(nextIAddr),
        .rs(rs), .rt(rt),
        .ReadData1(ReadData1), .ReadData2(ReadData2),
        .ALU_result(ALU_result), .DataBus(DataBus)
    );
        
    Four_LED Four_LED(
        .clock(xc7a35t_clock),
        .reset(reset_sw),
        .hex3(DisplayData[15:12]),
        .hex2(DisplayData[11:8]),
        .hex1(DisplayData[7:4]),
        .hex0(DisplayData[3:0]),
        .enable(enable),
        .dispcode(dispcode)
    );
    
    Mux4_16bits Mux4_16bits(
        .choice(SW_in),
        .in0({currentIAddr[7:0], nextIAddr[7:0]}),
        .in1({3'b000, rs, ReadData1[7:0]}),
        .in2({3'b000, rt, ReadData2[7:0]}),
        .in3({ALU_result[7:0], DataBus[7:0]}),
        .out(DisplayData)
    );
    
    Button_Debounce Button_Debounce(
        .clk(xc7a35t_clock),
        .btn_in(next_button),
        .btn_out(next_signal)
    );
endmodule
