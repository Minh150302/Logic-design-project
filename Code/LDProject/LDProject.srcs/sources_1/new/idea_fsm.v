module ModeFSM(
    input btn1,
    input clk,
    output reg [1:0] mode
);

    // Define FSM states
    parameter IDLE = 2'b00;
    parameter MODE_1 = 2'b01;
    parameter MODE_2 = 2'b10;
    parameter MODE_3 = 2'b11;

    // Define FSM register
    reg [1:0] current_state, next_state;

    // Default assignments
    always @(posedge clk or posedge btn1) begin
        if (btn1) begin
            // Change state when btn1 is pressed
            case (current_state)
                IDLE: next_state = MODE_1;
                MODE_1: next_state = MODE_2;
                MODE_2: next_state = MODE_3;
                MODE_3: next_state = IDLE;
                default: next_state = IDLE;
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
            IDLE: mode = 2'b00;
            MODE_1: mode = 2'b01;
            MODE_2: mode = 2'b10;
            MODE_3: mode = 2'b11;
            default: mode = 2'b00;
        endcase
    end

endmodule
