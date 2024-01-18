`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/12/2024 04:07:23 PM
// Design Name: 
// Module Name: displayDriver
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


module display_7seg(
    input clk,
    input [3:0] in3,
    input [3:0] in2,
    input [3:0] in1,
    input [3:0] in0,
    output reg [3:0] anode_select,
    output reg [7:0] seven_seg
    );
    
    // Refresh the Seven segment at this rate: 65 Mhz / 2^16 = 992 Hz
	
	localparam N = 18;
	
	// internal signals
	reg [N-1:0] refresh_rate;
	wire [N-1:0] refresh_next;
	reg [3:0] out;
	localparam dot = 4'b1011;
	reg sseg_dot;
	
	// counter register 
	always @(posedge clk)
              refresh_rate <= refresh_next; 
	
	// next state logic 
	assign refresh_next = refresh_rate + 1;
	
	// 2 MSBs control 4-to-1 multiplexing (active low)
	always @*
	   case (refresh_rate[N-1:N-2])
            2'b00:
	           begin 
		           anode_select = 4'b1110;
                   out = in0;
		           sseg_dot = dot[0];
                end
				
            2'b01:
                begin 
		           anode_select = 4'b1101;
                   out = in1;
		           sseg_dot = dot[1];
                end
				
            2'b10:
                begin 
		           anode_select = 4'b1011;
                   out = in2;
		           sseg_dot = dot[2];
                end	

            2'b11:				
                begin 
                  anode_select = 4'b0111;
                  out = in3;
                  sseg_dot = dot[3];
                end	
        
            default:
                begin 
                    anode_select = 4'b1111;
                    sseg_dot = 1'b1;
                end
        endcase 			
	
	// display values using the seven segment 
	always @*
        begin 
         case(out)
	       4'h0: seven_seg[6:0] = 7'b0000001;
	       4'h1: seven_seg[6:0] = 7'b1001111;
	       4'h2: seven_seg[6:0] = 7'b0010010;
	       4'h3: seven_seg[6:0] = 7'b0000110;
	       4'h4: seven_seg[6:0] = 7'b1001100;
	       4'h5: seven_seg[6:0] = 7'b0100100;
	       4'h6: seven_seg[6:0] = 7'b0100000;
	       4'h7: seven_seg[6:0] = 7'b0001111;
	       4'h8: seven_seg[6:0] = 7'b0000000;
	       4'h9: seven_seg[6:0] = 7'b0000100;
	       4'ha: seven_seg[6:0] = 7'b0001000;
	       4'hb: seven_seg[6:0] = 7'b1100000;
	       4'hc: seven_seg[6:0] = 7'b0110001;
	       4'hd: seven_seg[6:0] = 7'b1000010;
	       4'he: seven_seg[6:0] = 7'b0110000;
	       default: seven_seg[6:0] = 7'b0111000; // 4'hf
        endcase 
        seven_seg[7] = sseg_dot;
        end
endmodule
