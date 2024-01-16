`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/15/2024 03:02:50 PM
// Design Name: 
// Module Name: main_fsm
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


module main_fsm(
    input clk,
    input rst,
    input btn1,
    input btn2,
    input btn3,
    
    output [4:0] led
    );
    
    reg MODE ;
    reg rst_btn ;
    reg btn1_tmp, btn2_tmp, btn3_tmp;
    
    reg time_h; 
    
    
    function  btn_regconize; //debounce
    input button;
    begin
    
    end
    endfunction
    
    
    always @(*)
    begin
    rst_btn <= btn_regconize(rst);
    btn1_tmp <= btn_regconize(btn1);
//    btn2_tmp <= btn_regconize(btn2);
//    btn3_tmp <= btn_regconize(btn3);
    end
    
    initial
    MODE = 0;
    
    always @(posedge clk or posedge MODE)
    begin
        if(MODE >=5)
        MODE <= 1;
    end
    
    
    always @(posedge clk or posedge rst_btn or btn1_tmp)
    if(rst)
    begin
        MODE = 0;
        #10 MODE = 1;
    end
    else if (btn1_tmp)
    begin
        btn1_tmp <= 0;
        MODE = MODE + 1;
    end
    
    
    
endmodule
