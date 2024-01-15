`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/14/2024 10:07:01 PM
// Design Name: 
// Module Name: devider
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


module devider(
    input clk, rst,
    output clk_1s
    );
    reg [29:0] counter = 0;
    reg clk_tmp;
    
     always @(posedge clk or posedge rst)
        begin
        if(rst) 
        begin
            counter <= 0;
            clk_tmp <= 0;
        end
        else begin
            counter <= counter + 1;
        if(counter <= 3) 
            clk_tmp <= 0;
        else if (counter >= 6) begin
            clk_tmp <= 1;
            counter <= 1;
        end
        else
            clk_tmp <= 1;
        end
        end
              
        assign clk_1s = clk_tmp;

endmodule
