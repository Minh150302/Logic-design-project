`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2022 12:09:58 PM
// Design Name: 
// Module Name: full_adder
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


module full_adder (
    input  a,
    input  b,
    input  c_in,
    output sum,
    output c_out
   );
 
  wire   WIRE_1;
  wire   WIRE_2;
  wire   WIRE_3;
      
  assign WIRE_1 = a ^ b;
  assign WIRE_2 = WIRE_1 & c_in;
  assign WIRE_3 = a & b;
 
  assign sum   = WIRE_1 ^ c_in;
  assign c_out = WIRE_2 | WIRE_3;
 
 
endmodule
