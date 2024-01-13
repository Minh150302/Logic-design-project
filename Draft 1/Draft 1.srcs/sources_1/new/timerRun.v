`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/12/2024 08:59:41 PM
// Design Name: 
// Module Name: timerRun
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module timerRun(
    input clk_in,
    output reg clk_out
    );

    reg [25:0] counter = 0;
    
    always@(posedge clk_in)
    begin
        counter = counter + 1;
        if (counter > 50_000_000)
        begin
            counter = 0;
            clk_out = ~ clk_out;
        end
    end
endmodule
