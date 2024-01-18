`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/17/2024 05:10:49 PM
// Design Name: 
// Module Name: modify_time
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


module modify_time(clk, mode_enb, btn2 ,btn3, save, hour1, hour0, min1, min0);
    input wire mode_enb; // only work when in this mode(1), if change to other(0), save the lastest modification.
    input wire clk;
    
    input wire btn2;
    input wire btn3;
    
    inout wire [1:0]hour1;
    inout wire [3:0]hour0;
    inout wire [3:0]min1;
    inout wire [3:0]min0;
    
    output wire save;


    reg [5:0] tmp_hour, tmp_min;
    reg state; // 0: Min change; 1: Hour change
    
    reg save_tmp;
    
    reg [1:0] hour_1;
    reg [3:0] hour_0, min_1, min_0;
    
    
    
    
    function [3:0] take_10;
    input [5:0] number;
    begin
        take_10 = (number >=50) ? 5 : ((number >= 40)? 4 :((number >= 30)? 3 :((number >= 20)? 2 :((number >= 10)? 1 :0))));
    end
    endfunction

    //take value
    initial
    begin
        tmp_hour = hour1*10 + hour0;
        tmp_min = min1*10 + min0;
        state = 0;
        save_tmp = 0;
    end
    
    
    //for testbench
    initial 
    begin
        tmp_hour <= 12;
        tmp_min <= 34;
    end

    
    
    //validation
    always @(*)
    begin
        if(tmp_min >= 60)
        begin
            tmp_min <= 0;
            tmp_hour <= tmp_hour + 1;
        end
        if(tmp_hour >= 24)
            tmp_hour <= 0;
    end
    
    
    always @(posedge mode_enb or posedge btn2 or posedge btn3)
    begin
        if(mode_enb)
        begin
        case(state)
            2'b00: // Minute mode
                begin
                if (btn2) tmp_min <= tmp_min + 1;
                if (btn3) state <= 2'b01; // Switch to Hour mode
                end
            2'b01: // Hour mode
                begin
                if (btn2) tmp_hour <= tmp_hour + 1;
                if (btn3) state <= 2'b00; // Switch to Minute mode
                end
            default: // Unexpected state
                state <= 2'b00; // Default to Minute mode
        endcase
        end
    end
    
    
    always @(posedge mode_enb)
    begin
    if(btn2) save_tmp = 1;
    end
    
    always @(*) 
     begin
     hour_1 <= take_10(tmp_hour);
     hour_0 <= tmp_hour - hour_1*10; 
     min_1 <= take_10(tmp_min); 
     min_0 <= tmp_min - min_1*10;
    end
    
    
    // for testbench save = 0 since mode_enb is SET in 1st time
    assign save = save_tmp;
    
    assign hour1 = hour_1; // the most significant hour digit of the clock
    assign hour0 = hour_0; // the least significant hour digit of the clock
    assign min1 = min_1; // the most significant minute digit of the clock
    assign min0 = min_0; // the least significant minute digit of the clock

endmodule
