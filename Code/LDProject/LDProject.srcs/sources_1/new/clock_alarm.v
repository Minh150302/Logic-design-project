module clock_alarm(clk, rst, mode_enb, btn2, btn3, hour1, hour0, min1, min0, sec1, sec0, Alarm);
    input wire clk;
    input wire rst;
    input wire mode_enb;
    input wire btn2;
    input wire btn3;
    inout wire [1:0] hour1;
    inout wire [3:0] hour0, min1, min0, sec1, sec0;
    
    output Alarm;
    
    reg Alarm = 0;
    reg [1:0] a_hour1;
    reg [3:0] a_hour0, a_min1, a_min0;
    reg [5:0] a_tmp_hour, a_tmp_min, tmp_hour, tmp_min, tmp_sec;
    reg state;
    reg tmp_1s;
    reg clk_1s;
    
    function [3:0] mod_10;
    input [5:0] number;
        begin
            mod_10 = (number >=50) ? 5 : ((number >= 40)? 4 :((number >= 30)? 3 :((number >= 20)? 2 :((number >= 10)? 1 :0))));
        end
    endfunction
    
    initial begin
        tmp_hour <= 9;
        tmp_min <= 30;
        state = 0;
    end
    
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            tmp_1s <= 0;
            clk_1s <= 0;
        end
        else begin
            tmp_1s <= tmp_1s + 1;
            if(tmp_1s <= 5) clk_1s <= 0;
            else if (tmp_1s >= 10) begin
                clk_1s <= 1;
                tmp_1s <= 1;
            end
            else clk_1s <= 1;
        end
    end
    
    always @(posedge mode_enb) begin
        if (mode_enb) begin
            case (state)
                2'b00: begin
                    if (btn2) a_tmp_min <= a_tmp_min + 1;
                    if (btn3) state <= 2'b01;
                end
                2'b01: begin
                    if (btn2) a_tmp_hour <= a_tmp_hour + 1;
                    if (btn3) state <= 2'b00;
                end
                default: state <= 2'b00;
            endcase
        end
    end
    
    always @* begin
        a_hour1 <= mod_10(a_tmp_hour);
        a_hour0 <= a_tmp_hour - mod_10(a_tmp_hour);
        a_min1 <= mod_10(a_tmp_min);
        a_min0 <= a_tmp_hour - mod_10(a_tmp_min);
        tmp_hour = hour1*10 + hour0;
        tmp_min = min1*10 + min0;
        tmp_sec = sec1*10 + sec0;
    end
    
    always @(posedge clk_1s or posedge rst) begin
        if (rst) begin
            a_tmp_hour <= 0;
            a_tmp_min <= 0;
        end
        else if (clk_1s) begin
            tmp_sec <= tmp_sec + 1;
            if (tmp_sec == 60) begin
                tmp_sec = 0;
                tmp_min <= tmp_min + 1;
                if (tmp_min == 60) begin
                    tmp_min <= 0;
                    tmp_hour <= tmp_hour + 1;
                    if (tmp_hour == 24) tmp_hour <= 0;
                end
            end
        end
        if (a_tmp_hour == tmp_hour && a_tmp_min == tmp_min) 
            Alarm <= 1;
    end
    
endmodule
