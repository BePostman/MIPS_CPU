`timescale 1ns / 1ps

module ClockDivisor(
    input clk,
    output reg clk_20ms
    );

    reg [24:0] counter = 0;

    always @(posedge clk) begin
        if (counter == 249_999) begin
            counter <= 0;
            clk_20ms <= ~clk_20ms;
        end else begin
            counter <= counter + 1;
        end
    end

endmodule

