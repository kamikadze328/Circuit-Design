`timescale 1ns / 1ps

module hypotenuse(
    input clk,
    input rst,
    input start,
    input [7:0] a,
    input [7:0] b,
    output wire busy,
    output reg [11:0] y
);

localparam IDLE = 2'b00;
localparam WORK_MUL = 2'b01;
localparam WORK_SQRT = 2'b10;

reg [1:0] state = IDLE;

reg rst_mult0, rst_mult1, rst_sqrt;
wire [15:0] a_square_wire, b_square_wire;
wire mul_a_busy, mul_b_busy, sqrt_busy;
 
reg [23:0] square_sum;
wire [11:0] result_wire;

reg start_mult0 = 0, start_mult1 = 0;
reg start_sqrt = 0;

mult a_square_calc( 
    .clk(clk), .rst(rst_mult0), .start(start_mult0), 
    .a(a), .b(a), .busy(mul_a_busy), .y(a_square_wire)
);

mult b_square_calc( 
    .clk(clk), .rst(rst_mult1), .start(start_mult1), 
    .a(b), .b(b), .busy(mul_b_busy), .y(b_square_wire)
);

sqrt sqrt_calc( 
    .clk(clk), .rst(rst_sqrt), .start(start_sqrt), 
    .x_b(square_sum), .busy(sqrt_busy), .y_b(result_wire)
);

assign busy = (state != IDLE);

always @(posedge clk)
    if (rst) begin
        state <= IDLE;
        y <= 0;
        start_mult0 <= 0;
        start_mult1 <= 0;
        start_sqrt <= 0;
        rst_mult0 <= 1;
        rst_mult1 <= 1;
        
        rst_sqrt <= 1;
        square_sum <= 0;
    end else begin
        case (state)
            IDLE: begin
                square_sum <= 0;
                if (start) begin
                    y <= 0;
                    start_mult0 <= 1;
                    start_mult1 <= 1;
                    state <= WORK_MUL;
                end
            end
            WORK_MUL:
                begin
                   if (start_mult0 || start_mult1) begin
                        start_mult0 = 0;
                        start_mult1 = 0;
                   end else if (!mul_a_busy && !mul_b_busy) begin
                        square_sum <= a_square_wire + b_square_wire;
                        start_sqrt <= 1;
                        state <= WORK_SQRT;
                    end
                end
            WORK_SQRT:
                begin
                    if (start_sqrt) begin
                        start_sqrt <= 0;
                    end else if (!sqrt_busy) begin
                        y <= result_wire;
                        state <= IDLE;
                    end
                end
        endcase
    end
    
always @(rst_sqrt) begin
    if(rst_sqrt == 1) rst_sqrt <= 0;
end
always @(rst_mult0, rst_mult1) begin
    if(rst_mult1 == 1) rst_mult1 <= 0;
    if(rst_mult0 == 1) rst_mult0 <= 0;
end
/*always @(start_mult) begin
    if(start_mult == 1) start_mult <= 0;
end*/
/*always @(start_sqrt) begin
    if(start_sqrt == 1) start_sqrt <= 0;
end*/
endmodule
