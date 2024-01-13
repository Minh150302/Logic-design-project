`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2022 12:23:48 PM
// Design Name: 
// Module Name: full_adder_simu
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


module full_adder_simu;
 
  reg A = 0;
  reg B = 0;
  reg Cin = 0;
  wire SUM;
  wire Cout;
   
  full_adder full_adder_inst
    (
     .a(A),
     .b(B),
     .c_in(Cin),
     .sum(SUM),
     .c_out(Cout)
     );
 
  initial
    begin
       A = 0;
       B = 0;
       Cin = 0;
       #10;
       A = 0;
       B = 0;
       Cin = 1;
       #10;  
       A = 0;
       B = 1;
       Cin = 0;
       #10;
       A = 0;
       B = 1;
       Cin = 1;
       #10;
       A = 1;
       B = 0;
       Cin = 0;
       #10;
       A = 1;
       B = 0;
       Cin = 1;
       #10;
       A = 1;
       B = 1;
       Cin = 0;
       #10;  
       A = 1;
       B = 1;
       Cin = 1;
       #10;  
    end 
 
endmodule
