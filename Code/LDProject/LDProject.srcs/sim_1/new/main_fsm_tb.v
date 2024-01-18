`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/18/2024 07:23:40 PM
// Design Name: 
// Module Name: main_fsm_tb
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


module main_fsm_tb;
        // Inputs
        reg clk;
        reg rst;
        reg btn1;
        reg btn2;
        reg btn3;
    
        // Outputs
        wire [4:0] led;
    
        // Instantiate the module to be tested
        main_fsm uut (
            .clk(clk),
            .rst(rst),
            .btn1(btn1),
            .btn2(btn2),
            .btn3(btn3),
            .led(led)
        );
        
        
        
        initial begin
//          $display("Time: %0d:%0d:%0d", uut.hour1, uut.hour0, uut.min1, uut.min0, uut.sec1, uut.sec0);
          $monitor("Time: %0d:%0d:%0d", uut.hour1, uut.hour0, uut.min1, uut.min0, uut.sec1, uut.sec0);
        end
    
        // Initial block for testbench initialization
        initial begin
            // Initialize inputs
            clk = 0;
            rst = 1; // Active-low reset
            btn1 = 0;
            btn2 = 0;
            btn3 = 0;
    
            // Apply reset and wait for a few clock cycles
            #5 rst = 0;
            #200;
            
            #10 btn1 = 1;
    
            // Apply your test sequence
            btn2 = 1; #10; btn2 = 0; #10;  // 1
            btn2 = 1; #10; btn2 = 0; #10;  // 2
            btn2 = 1; #10; btn2 = 0; #10;  // 3
            btn2 = 1; #10; btn2 = 0; #10;  // 4
    
            btn3 = 1; #10; btn3 = 0; #10;  // Press btn3
    
            btn2 = 1; #10; btn2 = 0; #10;  // 5
            btn2 = 1; #10; btn2 = 0; #10;  // 6
            btn2 = 1; #10; btn2 = 0; #10;  // 7
            btn2 = 1; #10; btn2 = 0; #10;  // 8
            btn2 = 1; #10; btn2 = 0; #10;  // 9
            btn2 = 1; #10; btn2 = 0; #10;  // 10
            btn2 = 1; #10; btn2 = 0; #10;  // 11
            btn2 = 1; #10; btn2 = 0; #10;  // 12
    
            btn3 = 1; #10; btn3 = 0; #10;  // Press btn3
            btn3 = 1; #10; btn3 = 0; #10;  // Press btn3
    
            btn2 = 1; #10; btn2 = 0; #10;  // 15
            btn2 = 1; #10; btn2 = 0; #10;  // 16
            btn2 = 1; #10; btn2 = 0; #10;  // 17
            btn2 = 1; #10; btn2 = 0; #10;  // 18
            btn2 = 1; #10; btn2 = 0; #10;  // 19
            
            # 10 btn1 = 1;
    
            // End simulation after a delay
            #10 $stop;
        end
    
        // Clock generation
        always #5 clk = ~clk; 
        


          
    endmodule

