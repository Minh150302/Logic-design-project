`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/14/2024 04:58:08 PM
// Design Name: 
// Module Name: dec1to2_tb
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


module dec1to2_tb;
    reg x1;
    wire [1:0]y1;
    
    dec1to2 uut(x1,y1[1],y1[0]);
    
    initial
    $monitor("x1=%b, y1=%b",x1,y1);
    
    initial
    #0 x1 = 0;
    
    initial
    begin
//        while (x1 <= 3)
//        begin
//            #10 x1 = x1 + 2'b1;
//        end
        #20 x1 = 1;
        #40 x1 = 2;
//        #60 x1 = 3;
//        #80 x1 = 4;
        
        
        #100 $finish;
    end
endmodule
