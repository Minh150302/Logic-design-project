`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/15/2024 12:11:59 PM
// Design Name: 
// Module Name: digital_clock_tb
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

module digital_clock_tb;

    reg clk, rst, flag_chg;
    wire [1:0] H_out1;
    wire [3:0] H_out0, M_out1, M_out0, S_out1, S_out0;

    // Instantiate the digital_clock module
    digital_clock uut (
        .clk(clk),
        .rst(rst),
        .flag_chg(flag_chg),
        .H_out1(H_out1),
        .H_out0(H_out0),
        .M_out1(M_out1),
        .M_out0(M_out0),
        .S_out1(S_out1),
        .S_out0(S_out0)
    );
    
    
    initial
    begin
    flag_chg = 0;
    end
        
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

     //Reset generation
    initial begin
        rst = 1;
        #10 rst = 0; // Assert reset for 10 time units
        #100
        rst = 1;
        #10
        rst = 0;
        
        
    end
    
    
//    initial 
//    #5000 $finish;

    // Add your test scenarios here

endmodule

