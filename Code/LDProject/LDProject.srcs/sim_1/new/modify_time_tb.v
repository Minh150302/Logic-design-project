`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/17/2024 06:09:29 PM
// Design Name: 
// Module Name: modify_time_tb
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


module modify_time_tb;
   // Inputs
   reg clk;
   reg mode_enb;
   reg btn2;
   reg btn3;
   
   


   // Outputs
   wire save;
   wire [1:0] hour1;
   wire [3:0] hour0;
   wire [3:0] min1;
   wire [3:0] min0;

   // Instantiate the module under test
   modify_time uut (
      .clk(clk),
      .mode_enb(mode_enb),
      .btn2(btn2),
      .btn3(btn3),
      .save(save),
      .hour1(hour1),
//      .hour1(initial_hour1),
      .hour0(hour0),
//      .hour0(initial_hour0),
      .min1(min1),
//      .min1(initial_min1),
      .min0(min0)
//      .min0(initial_min0)
   );

   // Clock generation
   initial begin
      clk = 0;
      forever #5 clk = ~clk;
   end


   reg [1:0] initial_hour1;
   reg [3:0] initial_hour0;
   reg [3:0] initial_min1;
   reg [3:0] initial_min0;
   
   
   assign hour1 = (mode_enb)? initial_hour1 : 1'bz;
   assign hour0 = (mode_enb)? initial_hour0 : 1'bz;
   assign min1 = (mode_enb)? initial_min1: 1'bz;
   assign min0 = (mode_enb)? initial_min0 : 1'bz;

   // Initial conditions
   initial begin
      // Set initial values
      mode_enb = 1; // Enable mode
      initial_hour1 = 4;
      initial_hour0 = 5;
      initial_min1 = 5;
      initial_min0 = 0;
      // Set initial time to 4:50



      // Display headers
      $display("Time\t\tHour1\tHour0\tMin1\tMin0\tSave");

      // Apply modifications
      // Press btn2 4 times
      btn2 = 1; #10; btn2 = 0; #10;  // 1
      btn2 = 1; #10; btn2 = 0; #10;  // 2
      btn2 = 1; #10; btn2 = 0; #10;  // 3
      btn2 = 1; #10; btn2 = 0; #10;  // 4

      // Press btn3
      btn3 = 1; #10; btn3 = 0; #10;

      // Press btn2 8 times
      btn2 = 1; #10; btn2 = 0; #10;  // 5
      btn2 = 1; #10; btn2 = 0; #10;  // 6
      btn2 = 1; #10; btn2 = 0; #10;  // 7
      btn2 = 1; #10; btn2 = 0; #10;  // 8
      btn2 = 1; #10; btn2 = 0; #10;  // 9
      btn2 = 1; #10; btn2 = 0; #10;  // 10
      btn2 = 1; #10; btn2 = 0; #10;  // 11
      btn2 = 1; #10; btn2 = 0; #10;  // 12

      // Press btn3 2 times
      btn3 = 1; #10; btn3 = 0; #10;  // 13
      btn3 = 1; #10; btn3 = 0; #10;  // 14

      // Press btn2 5 times
      btn2 = 1; #10; btn2 = 0; #10;  // 15
      btn2 = 1; #10; btn2 = 0; #10;  // 16
      btn2 = 1; #10; btn2 = 0; #10;  // 17
      btn2 = 1; #10; btn2 = 0; #10;  // 18
      btn2 = 1; #10; btn2 = 0; #10;  // 19

      // Simulation end
      #10 $stop;
   end

//    Monitor display
   always @* begin
      $monitor("%d:%d\t%d\t%d\t%d\t%d\t%d", hour1, hour0, min1, min0, save);
   end


endmodule
