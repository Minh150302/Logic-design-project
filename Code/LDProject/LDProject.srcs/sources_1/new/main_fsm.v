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
    
    
    //th?i gian l?u tr? - th?i gian th?c
    reg [1:0] Hour1; 
    reg [3:0] Hour0;
    reg [3:0] Min1;
    reg [3:0] Min0;
    
    
    //th?i gian báo th?c
    reg [1:0] A_Hour1; 
    reg [3:0] A_Hour0;
    reg [3:0] A_Min1;
    reg [3:0] A_Min0; 
	
	
	
	reg [2:0]MODE;
	
	// Define FSM states
    parameter INIT = 2'b000;			//initial
    parameter CURR = 2'b001;			//in normal mode (clock)
    parameter CHAG = 2'b111;			//modify time
    parameter ALARM = 2'b010;			//set alarm - turn on alarm 
	parameter STOP = 2'b100;			//stopwatch mode
    
	
	
    
    
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
    
	
	reg [1:0] current_state, next_state;

    // Default assignments
    always @(posedge clk or posedge btn1) begin
        if (btn1) begin
            // Change state when btn1 is pressed
            case (current_state)
                INIT: next_state = CURR;
                CURR: next_state = CHAG;
                CHAG: next_state = ALARM;
                ALARM: next_state = STOP;
				STOP: next_state = CURR;
                default: next_state = INIT;
            endcase
        end else begin
            // Stay in the current state if btn1 is not pressed
            next_state = current_state;
        end
    end

    // Update current state
    always @(posedge clk) begin
        current_state <= next_state;
    end

    // Output mode based on current state
    always @* begin
        case (current_state)
            INIT:
            begin
            //initial value hour, min			
            Hour0 <= 0;
			Hour1 <= 0;
			Min0  <= 0;
			Min1  <= 0;
			
			
            
            end
            CURR: mode = 2'b01;
            CHAG: mode = 2'b10;
            ALARM: mode = 2'b11;
            default: mode = 2'b00;
        endcase
    end
	

	
	
	
    // initial
    // MODE = 0;
    
    // always @(posedge clk or posedge MODE)
    // begin
        // if(MODE >=5)
        // MODE <= 1;
    // end
    
    
    // always @(posedge clk or posedge rst_btn or btn1_tmp)
    // if(rst)
    // begin
        // MODE = 0;
        // #10 MODE = 1;
    // end
    // else if (btn1_tmp)
    // begin
        // btn1_tmp <= 0;
        // MODE = MODE + 1;
        // digital_clock dgital(asdfasdfasdf);
    // end
    
    
    
endmodule
