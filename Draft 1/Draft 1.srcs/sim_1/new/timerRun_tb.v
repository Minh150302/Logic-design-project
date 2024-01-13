`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/12/2024 09:07:15 PM
// Design Name: 
// Module Name: timerRun_tb
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


module timerRun_tb;
    reg clk_in;         // Input clock
    wire clk_out = 0;       // Output clock

    // Instantiate the timerRun module
    timerRun uut(
        .clk_in(clk_in),
        .clk_out(clk_out)
    );

    // Clock generation
    reg tb_clk = 0;
    always #5 tb_clk = ~tb_clk; // Generate a clock with a period of 10 time units

    // Stimulus generation
    initial begin
        clk_in = 0; // Initialize the input clock
        #500;      // Wait for a while

        // Apply clock for 100 cycles
        repeat (500_000_000) #10 clk_in = tb_clk;

        // Stop simulation
        $stop;
    end

    // Monitor display output
    always @(posedge tb_clk)
        $display("clk_in = %b, clk_out = %b", clk_in, clk_out);

endmodule
