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


module digital_clock(clk, rst, flag_chg, H_out1, H_out0, M_out1, M_out0, S_out1, S_out0);
    input wire clk, rst;  
    input wire flag_chg; //flag when regconize the modify time
//    input wire Change_time;
    
    inout wire [1:0] H_out1; // Display 2 to 0 
    inout wire [3:0] H_out0; // Display 9 to 0 
    inout wire [3:0] M_out1; // Display 5 to 0 
    inout wire [3:0] M_out0; // Display 9 to 0 
    
    
    // for testting, would not use in final
    output wire [3:0] S_out1; // Display 5 to 0 
    output wire [3:0] S_out0;  // Display 9 to 0 
    
    
    
    reg [5:0] tmp_hour, tmp_min, tmp_sec;
    reg [28:0] counter = 1; //for clk_1s
    reg clk_1s = 1;
    reg [1:0] hour_1;
    reg [3:0] hour_0, min_1, min_0, sec_1, sec_0;
    
    reg flag_modify;
    reg flag_rst;
    
    initial
    begin
    flag_modify <= flag_chg;
    flag_rst<=rst;
    end
    
    
    // take the second digit x in xy
    function [3:0] take_10;
    input [5:0] number;
    begin
    take_10 = (number >=50) ? 5 : ((number >= 40)? 4 :((number >= 30)? 3 :((number >= 20)? 2 :((number >= 10)? 1 :0))));
    end
    endfunction
    
    
    
    
    //Get new hour and min if 
    always @(*)
    begin
        if(flag_modify)
        begin
        tmp_hour <= H_out1*10 + H_out0;
        tmp_min  <= M_out1*10 + M_out0;
        tmp_sec  <= 0;
        counter <= 0;
        
        flag_modify = 0;
    end
    end

    always @(posedge clk or posedge rst)
    begin
        if(counter >= 2)
        begin
            counter <= 1;
            clk_1s = ~clk_1s;
        end
        else if(rst)
        begin
            counter <= 1;
            clk_1s <= 1;
        end
        else
            counter = counter + 1;
    end
    
    // bo dem tinh chinh
    
    
//     always @(posedge clk or posedge rst)
//        begin
//        if(rst) 
//        begin
//        counter <= 0;
//        clk_1s <= 0;
//        end
//        else begin
//        counter <= counter + 1;
//        if(counter <= 2) 
//        clk_1s <= 0;
//        else if (counter >= 4) begin
//        clk_1s <= 1;
//        counter <= 1;
//        end
//        else
//        clk_1s <= 1;
//        end
//        end
    
    
    
    
    
    always @(posedge clk_1s or posedge rst)
    begin
        // initial
        if(rst)
        begin
            tmp_hour <= 23;
            tmp_min  <= 40;
            tmp_sec  <= 31;
        end
        else
        begin
            tmp_sec <= tmp_sec + 1;
            if(tmp_sec >= 60)
            begin
                tmp_sec <= 0;
                tmp_min = tmp_min + 1;
            end
            if(tmp_min >= 60)
            begin
                tmp_min <= 0;
                tmp_hour = tmp_hour + 1;
            end
            if(tmp_hour >= 24)
                tmp_hour <= 0;
        end
    end
    
     always @(*) 
     begin
     hour_1 = take_10(tmp_hour);
     hour_0 = tmp_hour - hour_1*10; 
     min_1 = take_10(tmp_min); 
     min_0 = tmp_min - min_1*10;
     sec_1 = take_10(tmp_sec);
     sec_0 = tmp_sec - sec_1*10; 
    end
    
    assign H_out1 = hour_1; // the most significant hour digit of the clock
    assign H_out0 = hour_0; // the least significant hour digit of the clock
    assign M_out1 = min_1; // the most significant minute digit of the clock
    assign M_out0 = min_0; // the least significant minute digit of the clock
    assign S_out1 = sec_1; // the most significant second digit of the clock
    assign S_out0 = sec_0; // the least significant second digit of the clock 
    
           
endmodule
