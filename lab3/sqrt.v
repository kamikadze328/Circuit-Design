`timescale 1ns / 1ps

module sqrt(
    input clk,
    input rst,
    input start,
    input [23:0] x_b,
    output busy,
    output reg [11:0] y_b
);

localparam IDLE = 2'b00;
localparam WORK_1 = 2'b01;
localparam WORK_2 = 2'b11;
 
localparam start_m = 1 << (24 - 2);

reg [1:0] state = IDLE;
reg [23:0] x, b, y, part_result;
reg [22:0] m;

assign finished = (m == 0);
assign busy = (state != IDLE);
assign x_above_b = (x >= b);

always @(posedge clk)
    if (rst) begin
        y_b <= 0;
        b <= 0;
        state <= IDLE;
        part_result <= 'b0;
        m <= start_m;
    end else begin
        case (state)
            IDLE: begin
                m <= start_m;
                b <= 0;
                part_result <= 'b0;

                if (start) begin
                    state <= WORK_1;
                    x <= x_b;
                    y_b <= 0;
                end
            end
            WORK_1: begin
                if (finished) begin
				    y_b <= part_result[23:0];    
					state <= IDLE;
                end else begin
					b <= part_result | m;
					part_result <= part_result >> 1;
					state <= WORK_2; 
                end     
            end
            WORK_2: begin
                if(x_above_b) begin
                    x <= x - b;
                    part_result = part_result | m;
                end
                    m <= m >> 2;
                    state <= WORK_1;
                end    
        endcase
    end    
endmodule
