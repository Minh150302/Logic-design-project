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




module minh(
    input in,
    output out
);

endmodule

module main_fsm(
    input clk,
    input rst,
    input btn1,
    input btn2,
    input btn3,
    
    output [4:0] led
    );
    
	
	//button
    reg rst_btn ;
    reg btn1_tmp, btn2_tmp, btn3_tmp;
    
    
    //th?i gian l?u tr? - th?i gian th?c
    reg [1:0] Hour1; 
    reg [3:0] Hour0;
    reg [3:0] Min1;
    reg [3:0] Min0;
    reg [3:0] Sec1;
    reg [3:0] Sec0;
    
    
	reg [5:0]tmp_hour, tmp_min, tmp_sec, a_tmp_hour, a_tmp_min;
    
    
    //th?i gian báo th?c
	reg [1:0] a_hour1; 
	reg [3:0] a_hour0;
	reg [3:0] a_min1;
	reg [3:0] a_min0; 
	reg Alarm;  // output báo thức
	
	
	//flag
	reg enb_ALARM; // dg cài báo th?c
	reg flag_chg; // c? cho s? thay ?ôi cho ??ng h?
	
	reg CURR_flag;		//in normal mode (clock)
    reg CHAG_flag;            //modify time
    reg ALARM_flag;           //set alarm - turn on alarm 
    reg STOP_flag;      //stopwatch mode
	
	
	
	reg [2:0]MODE;
	
	// Define FSM states
    parameter INIT = 3'b000;			//initial
    parameter CURR = 3'b001;			//in normal mode (clock)
    parameter CHAG = 3'b111;			//modify time
    parameter ALARM = 3'b010;			//set alarm - turn on alarm 
	parameter STOP = 3'b100;			//stopwatch mode
    
    reg [1:0] current_state, next_state;
	
	
    
    
//    function  btn_regconize; //debounce
//    input button;
//    begin
    
//    end
//    endfunction
    
    
//    always @(*)
//    begin
//    rst_btn <= btn_regconize(rst);
//    btn1_tmp <= btn_regconize(btn1);
////    btn2_tmp <= btn_regconize(btn2);
////    btn3_tmp <= btn_regconize(btn3);
//    end
    
	
	
	
digital_clock MODE1(.clk(clk), .rst(!CURR_flag), .flag_chg(flag_chg), .H_out1(Hour1), .H_out0(Hour0), .M_out1(Min1), .M_out0(Min0), .S_out1(Sec1), .S_out0(Sec0));
modify_time MODE2(.clk(clk), .mode_enb(CHAG_flag), .btn2(btn2) ,.btn3(btn3), .save(flag_chg), .hour1(Hour1), .hour0(Hour0), .min1(Min1), .min0(Min0));
    
    
    always
    
    
    
    initial
    begin
    current_state = INIT;
    #5 next_state = CURR;
    end

    // Default assignments
    always @(posedge clk or posedge btn1) begin
        if (btn1) begin
            // Change state when btn1 is pressed
            case (current_state)
                INIT: next_state = CURR;
                CURR: next_state = CHAG;
                CHAG: next_state = CURR;

//                CURR: next_state = ALARM;
//                ALARM: next_state = STOP;
//                STOP: next_state = CHAG;
//				CHAG: next_state = CURR;
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
            tmp_hour <= 0;
            tmp_min <= 0;
            tmp_sec <= 0;

            			
            Hour0 <= 0;
			Hour1 <= 0;
			Min0  <= 0;
			Min1  <= 0;
			Sec0  <= 0;
            Sec1  <= 0;     
			
			A_Hour0 <= 0;
			A_Hour1 <= 7;
			A_Min0  <= 0;
			A_Min1  <= 0;
			enb_ALARM <=0;  
			
			CURR_flag = 0;
			ALARM_flag = 0;
			STOP_flag = 0;
			CHAG_flag = 0;
            end
            
            CURR:
			begin
//			digital_clock MODE1(.clk(clk), .rst(rst_btn), .flag_chg(flag_chg), .H_out1(Hour1), .H_out0(Hour0), .M_out1(Min1), .M_out0(Min0), .S_out1(Sec1), .S_out0(Sec0));			
			CURR_flag = 1;
            ALARM_flag = 0;
            STOP_flag = 0;
            CHAG_flag = 0;
			end
			
----------------------------------------------------------------------------------------------------------------------------
			
            CHAG: 
			begin
			
			// Expressions
            tmp_hour = hour1 * 10 + hour0;
            tmp_min = min1 * 10 + min0;
            state = (mode_enb) ? ((state == 2'b00 && btn3) ? 2'b01 : (state == 2'b01 && btn3) ? 2'b00 : state) : state;
            
            // State transitions
            case(state)
              2'b00: // Minute mode
                tmp_min = (mode_enb && btn2) ? (tmp_min + 1) : tmp_min;
              2'b01: // Hour mode
                tmp_hour = (mode_enb && btn2) ? (tmp_hour + 1) : tmp_hour;
            endcase
            
            // Value decomposition
            hour_1 = (tmp_hour >= 50) ? 5 : ((tmp_hour >= 40) ? 4 : ((tmp_hour >= 30) ? 3 : ((tmp_hour >= 20) ? 2 : ((tmp_hour >= 10) ? 1 : 0))));
            hour_0 = tmp_hour - hour_1 * 10;
            min_1 = (tmp_min >= 50) ? 5 : ((tmp_min >= 40) ? 4 : ((tmp_min >= 30) ? 3 : ((tmp_min >= 20) ? 2 : ((tmp_min >= 10) ? 1 : 0))));
            min_0 = tmp_min - min_1 * 10;
            
            // Output assignments
            hour1 = hour_1;
            hour0 = hour_0;
            min1 = min_1;
            min0 = min_0;
            
            // Save condition
            save = (mode_enb && btn2) ? 1 : 0;

			end
			
-------------------------------------------------------------------------------------------------------------------------			
			
			
			
			
			
			
			
            ALARM: 
            begin
            	tmp_hour = hour1 * 10 + hour0;
		tmp_min = min1 * 10 + min0;
		state = (mode_enb) ? ((state == 2'b00 && btn3) ? 2'b01 : (state == 2'b01 && btn3) ? 2'b00 : state) : state;
            
		case (state)
			2'b00: a_tmp_min = (mode_enb && btn2) ? (a_tmp_min + 1) : a_tmp_min;
			2'b01: a_tmp_hour = (mode_enb && btn2) ? (a_tmp_hour + 1) : a_tmp_hour;
		endcase

		a_hour1 = (a_tmp_hour >= 50) ? 5 : ((a_tmp_hour >= 40) ? 4 : ((a_tmp_hour >= 30) ? 3 : ((a_tmp_hour >= 20) ? 2 : ((a_tmp_hour >= 10) ? 1 : 0))));
		a_hour0 = a_tmp_hour - a_hour1 * 10;
		a_min1 = (a_tmp_min >= 50) ? 5 : ((a_tmp_min >= 40) ? 4 : ((a_tmp_min >= 30) ? 3 : ((a_tmp_min >= 20) ? 2 : ((a_tmp_min >= 10) ? 1 : 0))));
		a_min0 = a_tmp_min - a_min1 * 10;

		Alarm = rst ? 0 : ((a_hour1 == Hour1) && (a_hour0 == Hour0) && (a_min1 == Min1) && (a_min0 == Min0)) ? 1 : 0;

		    
            CURR_flag = 0;
            ALARM_flag = 1;
            STOP_flag = 0;
            CHAG_flag = 0;
            end





-------------------------------------------------------------------------------------------------------------------------		
            STOP: 
            begin
            
            CURR_flag = 0;
            ALARM_flag = 0;
            STOP_flag = 1;
            CHAG_flag = 0;
            end
            default: current_state = INIT;
        endcase
    end
    
    
        assign hour1 = hour_1; // the most significant hour digit of the clock
    assign hour0 = hour_0; // the least significant hour digit of the clock
    assign min1 = min_1; // the most significant minute digit of the clock
    assign min0 = min_0; // the least significant minute digit of the clock
    
    
    
    
	

endmodule
