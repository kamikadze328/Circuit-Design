`timescale 1ns / 1ps


module root(
    input clk_i,
    input rst_i,
	
    input start_i,
    input [15:0] x_bi,
	
    output reg [7:0] y_bo,
    output [1:0] busy_o
);

    localparam IDLE = 2'h0;
    localparam WORK_1 = 2'h1;
    localparam WORK_2 = 2'h2;
	
    reg [7:0] x;
    reg [7:0] part_result;
    reg [7:0] b;
    reg [6:0] m;
    reg [1:0] state;
	
    wire end_step; 
    wire x_above_b;
	
    assign end_step = (m == 0);
    assign x_above_b = (x >= b);
    assign busy_o = state;
	
    always @(posedge clk_i)
        if (rst_i) begin
            y_bo <= 0;
            b <= 0;
            state <= IDLE;
        end else begin
            case (state)
                IDLE:
                    if (start_i) begin
                        state <= WORK_1;
                        part_result <= 0;
                        x <= x_bi;
                        m <= 7'b1000000;
                    end else begin
                        y_bo <= 0;
                        b <= 0;
                    end
                WORK_1:
                    begin
                        if (end_step) begin
							y_bo <= part_result[3:0];    
							state <= IDLE;
                        end else begin
							b <= part_result | m;
							part_result <= part_result >> 1;
							state <= WORK_2; 
                        end     
                    end
                WORK_2:
                    begin
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
