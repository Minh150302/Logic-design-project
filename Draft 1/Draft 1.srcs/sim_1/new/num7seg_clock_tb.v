`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/12/2024 08:44:37 PM
// Design Name: 
// Module Name: num7seg_clock_tb
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

module num7seg_clock_tb;
    reg [3:0] num;          // Input for the number
    wire [6:0] seg;         // Output for the segments

    // Instantiate the num7seg module
    num7seg uut(
        .num(num),
        .seg(seg)
    );

    // Clock generation
    reg clk;
    reg rst;

    // Clock generation with a 10ns period
    initial begin
        clk = 0;
        rst = 0;

        // Toggle the clock every 5ns
        forever #5 clk =~clk;
    end

    // Reset generation
    always #20 rst =~rst;

    // Stimulus generation
    initial begin
        // Apply reset
        rst = 1;
        #50;
        rst = 0;

        // Apply other inputs
        num = 4'b0000; // Test with number 0
        #100;

        num = 4'b0101; // Test with number 5
        #100;

        num = 4'b1001; // Test with number 9
        #100;

        // Add more test cases as needed

        // Continue simulation for a while
        #500;

        $stop; // Stop simulation
    end

    // Monitor display output
    always @(posedge clk) begin
        $display("num = %b, seg = %b", num, seg);
    end

endmodule

