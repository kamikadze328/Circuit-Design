`timescale 1ns / 1ps

module main_sum(
    input [7:0] a,
    input [7:0] b,
    input clk,
    input start,
    
    output busy,
    output reg [7:0] y,
    output reg p
);
wire [1:0] sum_2bit;
wire p_2bit;

localparam IDLE = 1'b0;
localparam WORK = 1'b1;


reg [1:0] a_2bit, b_2bit;
reg p_2bit_prev = 0;
reg state = IDLE;
reg [3:0] i = 0;


sum mudule_sum(
 .a(a_2bit),
 .b(b_2bit),
 .prev_p(p_2bit_prev),
 .y(sum_2bit),
 .p(p_2bit)
);


assign busy = state;

always @(posedge clk) begin
    case(state)
       IDLE:
            if(start) begin 
                i <= 0;
                y <= 0;
                p <= 0;
                p_2bit_prev = 0;
                state <= WORK;
                a_2bit = {a[1], a[0]};    
                b_2bit = {b[1], b[0]};
            end
        WORK: begin      
            y[i] <= sum_2bit[0];
            y[i + 1] <= sum_2bit[1];

            if(i != 6) begin
                p_2bit_prev <= p_2bit;
                a_2bit <= {a[i + 3], a[i + 2]};    
                b_2bit <= {b[i + 3], b[i + 2]};
                i <= i + 2;
            end else begin
                p <= p_2bit;
                state <= IDLE;
            end
        end  
    endcase          
end
endmodule
