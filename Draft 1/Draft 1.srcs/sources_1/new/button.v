`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/12/2024 09:25:38 PM
// Design Name: 
// Module Name: button
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


module button(
    input [3:0] buttons,       // Input for the 4 buttons
    output reg [3:0] button_press // Output indicating which button was pressed
);

    reg [3:0] button_state, button_prev;
    reg [3:0] debounce_count;

    parameter DEBOUNCE_THRESHOLD = 10; // Adjust this value based on your requirements

    always @(posedge buttons) begin
        button_prev <= button_state; // Store previous button state
        button_state <= buttons;     // Update current button state

        // Debounce mechanism
        if (buttons != button_state)
            debounce_count <= 0;
        else if (debounce_count < DEBOUNCE_THRESHOLD)
            debounce_count <= debounce_count + 1;

        // Detect rising edge on any button after debounce
        if (debounce_count == DEBOUNCE_THRESHOLD)
            button_press = (buttons & ~button_prev);
        else
            button_press = 4'b0000;
    end

endmodule


