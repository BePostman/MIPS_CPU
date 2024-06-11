`timescale 1ns / 1ps

module Button_Debounce( 
    input clk, 
    input btn_in, 
    output btn_out 
    ); 
    reg [2:0] btn=0; 
    wire clk_20ms; 
    
    always @(posedge clk_20ms) begin 
    btn[0]<=btn_in; 
    btn[1]<=btn[0]; 
    btn[2]<=btn[1]; 
    end 
    assign btn_out=(btn[2]&btn[1]&btn[0])|(~btn[2]&btn[1]&btn[0]); 
    
    ClockDivisor ClockDivisor(
    .clk(clk),
    .clk_20ms(clk_20ms)
    );
endmodule
