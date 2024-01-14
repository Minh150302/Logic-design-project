`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/14/2024 04:45:39 PM
// Design Name: 
// Module Name: mux2to1
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


module mux2to1(
    input in0, in1, select,
    output out
    );
    
wire and_out0, and_out1;
wire dec_out0, dec_out1;

dec1to2 dec0(dec_out0,dec_out1,select);
and and0(and_out0,in0,dec_out0);
and and1(and_out1,in1,dec_out1);
or or0(out,and_out0,and_out1);

endmodule
