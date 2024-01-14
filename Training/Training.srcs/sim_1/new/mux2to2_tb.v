`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/14/2024 04:46:42 PM
// Design Name: 
// Module Name: mux2to2_tb
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


module mux2to2_tb();
    reg in0, in1, select;
    wire out;
    
    mux2to1 mux(.in0(in0),.in1(in1),.select(select),.out(out));
    
    
    initial
    begin
        in0 <= 0;
        in1 <= 0;
        select <= 0;
    end
    
    initial
    begin
        #10
        in0 = 1;
        in1 = 0;
        
        #10
        in0 = 0;
        in1 = 1;
        
        #10
        in0 = 1;
        in1 = 1;
        
        #10
        select = 1;
        in0 <= 0;
        in1 <= 0;
                
        #10
        in0 = 1;
        in1 = 0;
        
        #10
        in0 = 0;
        in1 = 1;
        
        #10
        in0 = 1;
        in1 = 1;
        
        #20 $finish;
    end
    
endmodule
