`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/14/2024 10:04:28 PM
// Design Name: 
// Module Name: digital_clock
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


module digital_clock(clk, rst, h_1, h_0, m_1, m_0, s_1,s_0);
    input wire clk, rst;  
    output wire [1:0] h_1; //display 2 to 0 
    output wire [4:0] h_0; //display 9 to 0 
    output wire [4:0] m_1; //display 5 to 0 
    output wire [4:0] m_0; //display 9 to 0 
    output wire [4:0] s_1; //display 5 to 0 
    output wire [4:0] s_0; //display 9 to 0 
    
    reg [5:0] tmp_hour, tmp_min, tmp_sec;
    reg counter;
    
    always
    begin
    tmp_hour = h_1*10 + h_0;
    tmp_min  = m_1*10 + m_0;
    tmp_sec  = s_1*10 + s_0;
    end
    
    always @(posedge clk_1s or posedge rst)
    begin
        if(rst)
        begin
            tmp_hour = 0;
            tmp_min  = 0;
            tmp_sec  = 0;
        end
        else
        begin
            tmp_sec = tmp_sec + 1;
            if(tmp_sec >= 60)
            begin
                tmp_sec = 0;
                tmp_min = tmp_min + 1;
            end
            if(tmp_min >= 60)
            begin
                tmp_min = 0;
                tmp_hour = tmp_hour + 1;
            end
            if(tmp_hour >= 24)
                tmp = 0;
        end
    end
    
    
    
    display ()
    
    
    alway @
    
    
    divider uut_divider(clk oclk1 oclk2)
    
    currenttime(oclk1)
    
           
endmodule
