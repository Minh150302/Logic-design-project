`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/18/2024 09:13:43 PM
// Design Name: 
// Module Name: debounce
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


module debounce (
    input wire clk,  // System clock
    input wire reset,  // System reset
    input wire button_in,  // Raw button input
    output reg button_out  // Debounced button output
);

    localparam DEBOUNCE_TIME = 10;  // Debounce time in clock cycles
    reg [3:0] counter;  // counter

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            button_out <= 0;
        end else if (button_in != button_out) begin
            counter <= counter + 1;
            if (counter >= DEBOUNCE_TIME) begin
                counter <= 0;
                button_out <= button_in;
            end
        end else begin
            counter <= 0;
        end
    end

endmodule


//module debounce(
//    input wire clk,
//    input wire reset,
//    input wire button_in,
//    output reg button_out
//);

//    parameter DEBOUNCE_TIME = 5; // Debounce time in clock cycles

//    reg [31:0] counter = 0;
//    reg last_button_state = 0; // Assume button is initially not pressed

//    always @(posedge clk) begin
//        if (button_in != last_button_state) begin
//            counter <= DEBOUNCE_TIME - 1;
//        end else if (counter > 0) begin
//            counter <= counter - 1;
//        end else begin
//            button_out <= button_in;
//        end
//        last_button_state <= button_in;
//    end

//endmodule