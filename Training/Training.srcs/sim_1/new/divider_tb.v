`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/15/2024 12:31:07 PM
// Design Name: 
// Module Name: divider_tb
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


module divider_tb;
    reg clk;          // Input clock
    reg rst;          // Reset signal
    wire clk_1s;      // Output clock

    // Instantiate the divider module
    devider uut(
        .clk(clk),
        .rst(rst),
        .clk_1s(clk_1s)
    );

    // Clock generation
    
    initial #0 clk <= 0;

    always #5 clk = !clk; // Generate a clock with a period of 10 time units
         
        
    // Stimulus generation
    initial begin
        #0 rst = 1;
        #50;    // Wait for a while with reset asserted
        
    
        
        
        // Release reset after 50 time units
        rst = 0;
        #50;

        // Stop simulation after 200 time units
        #200;
        $stop;
    end
    
    

    // Monitor display output
    always @(posedge clk)
        $display("clk = %b, rst = %b, clk_1s = %b", clk, rst, clk_1s);

endmodule
