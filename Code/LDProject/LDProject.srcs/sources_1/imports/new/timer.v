`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/13/2024 03:39:58 PM
// Design Name: 
// Module Name: refreshcounter
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


module timer(
    input clk,
    input reset,
    input pause,
    output reg [3:0] sec1,
    output reg [3:0] sec0,
    output reg [3:0] subsec1,
    output reg [3:0] subsec0

    );
    localparam [28:0] oneHz_const = 28'd100000000;
    reg oneHz_enable;
    reg [28:0] oneHz_counter = oneHz_const;
    reg count;
    
    always@(posedge clk) begin
        if (reset) begin
            oneHz_counter=oneHz_const;

            count = 1;
        end
        
        else begin
            if (pause) begin
                if (count) count = 0;
                else count = 1;
            end
            
            if (count) begin
                oneHz_counter = oneHz_counter - 1;
                oneHz_enable = (oneHz_counter == 0);
                if (!oneHz_counter) oneHz_counter = oneHz_const;
            end
        end
    end
    
    always@(posedge oneHz_enable, posedge reset) begin
        if (reset) begin
            sec1 = 4'd0;
            sec0 = 4'd0;
            subsec1 = 4'd0;
            subsec0 = 4'd0;
        end
        else begin
            if (subsec0<4'd9) subsec0 = subsec0 + 1;
            else begin
                if (subsec1<4'd9) begin
                    subsec1 = subsec1 + 1;
                    subsec0 = 0;
                end
                else begin
                    if (sec0<4'd9) begin
                        sec0 = sec0 + 1;
                        subsec1 = 0;
                    end
                    else begin
                        if (sec1<4'd9) begin
                            sec1 = sec1 + 1;
                            sec0 = 0;
                        end
                        else sec1 = 0;
                    end
                end
            end
        end
    end
endmodule
