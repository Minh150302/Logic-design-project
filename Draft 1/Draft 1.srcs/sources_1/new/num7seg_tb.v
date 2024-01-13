`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/11/2024 05:33:04 PM
// Design Name: 
// Module Name: num7seg_tb
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


module tb_num7seg;
    reg [3:0] num;          // Input for the number
    wire [6:0] seg;         // Output for the segments

    // Instantiate the num7seg module
    num7seg uut(
        .num(num),
        .seg(seg)
    );

    // Clock generation
    reg clk;
    always #5 clk = ~clk;
    
    integer k =0; 

    // Stimulus generation
    initial begin
        clk = 0;
        num = 4'b0000; // Test with number 0
        #10;

        num = 4'b0101; // Test with number 5
        #10;

        num = 4'b1001; // Test with number 9
        #10;
        for (k = 0; k<11; k=k+1)
        #10 num = k;

        // Add more test cases as needed

        $stop; // Stop simulation
    end

    // Monitor display output
    always @(posedge clk)
        $display("num = %b, seg = %b", num, seg);

endmodule
