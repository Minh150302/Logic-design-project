`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/12/2024 09:25:56 PM
// Design Name: 
// Module Name: button_tb
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


module button_tb;
    reg [3:0] buttons;          // Input buttons
    wire [3:0] button_press;    // Output indicating which button was pressed

    // Instantiate the button_module
    button uut(
        .buttons(buttons),
        .button_press(button_press)
    );

    // Stimulus generation
    initial begin
        // Simulate pressing button 0 after 50 time units
        buttons = 4'b0001;
        #50;

        // Simulate pressing button 2 after 100 time units
        buttons = 4'b0100;
        #50;

        // Simulate pressing multiple buttons at the same time after 150 time units
        buttons = 4'b1011;
        #50;

        // Stop simulation
        $stop;
    end

    // Monitor display output
    always @(posedge buttons)
        $display("buttons = %b, button_press = %b", buttons, button_press);

endmodule
