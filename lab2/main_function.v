`timescale 1ns / 1ps


    module main_function(
    input clk_i,
	
    input [7:0] a_bi,
    input [7:0] b_bi,
    
	input start_i,
    input rst_i,
    
	output reg [7:0] result_bo,
    output [1:0] busy_o
);
    localparam IDLE = 2'h0;
    localparam WORK_1 = 2'h1;
    localparam WORK_2 = 2'h2;

	
    reg [7:0] a;
    reg [7:0] b;
    reg [15:0] part_result;
	
    reg [1:0] state;
    reg start_root;
	reg start_mul_a;
	reg start_mul_b;

	
    wire [15:0] mul_a_result;
	wire [15:0] mul_b_result;
    wire [7:0] root_result;

	wire mul_a_busy;
    wire mul_b_busy;
    wire [1:0] root_busy;
    wire done;
	
    mult mult_a(
        .clk_i(clk_i),
        .rst_i(rst_i),
		
        .a_bi(a),
		.b_bi(a),
        .start_i(start_mul_a),
		
        .busy_o(mul_a_busy),
        .y_bo(mul_a_result)
    );
	
	mult mult_b(
        .clk_i(clk_i),
        .rst_i(rst_i),
		
        .a_bi(b),
		.b_bi(b),
        .start_i(start_mul_b),
		
        .busy_o(mul_b_busy),
        .y_bo(mul_b_result)
    );
	
    root root1 (
        .clk_i(clk_i),
        .rst_i(rst_i),
		
        .start_i(start_root),
        .x_bi(part_result),
		
        .busy_o(root_busy),
        .y_bo(root_result)
    );
    
    assign busy_o = state;
	assign work1_done = mul_a_busy == 0 && mul_b_busy == 0 && mul_b_result != 0 && mul_a_result != 0;
    assign done = root_busy == 0 && root_result != 0;
	
	always @(posedge clk_i)
        if(rst_i) begin
            state = IDLE;
            result_bo = 0;
            
        end else begin
            case(state)
                IDLE:
                    begin
                    if(start_i) begin
                        part_result = 0;
                        a = a_bi;
                        b = b_bi;
                        state = WORK_1;
                        start_mul_a = 1;
                        start_mul_b = 1;
                    end else begin 

                    end
                    end
                WORK_1:
                    begin
                        $display("WORK_1 busy[%b, %b], mult[%d, %d] (%b)", mul_a_busy, mul_b_busy, mul_a_result, mul_b_result, state);
            
                        if(work1_done) begin
                            $display("WORK_1 (%b)", state);
                            state = WORK_2;
						    //$display("WORK_1 (%b)", state);
							start_root = 1;

                            part_result = mul_a_result + mul_b_result;
                            //$display("WORK_1 result is %d+%d=%d (%b)", mul_a_result, mul_b_result, part_result, state);
                        end 
                        
                    end  
				WORK_2:
                    begin
                        $display("WORK_2");
                        if(done) begin
                            state = IDLE;
                            result_bo = root_result;
                        end 
                    end  					
            endcase
        end
	
    always@(mul_a_busy) begin
        if(mul_a_busy != 0) start_mul_a <= 0;
    end
    always@(mul_b_busy) begin
        if(mul_b_busy != 0) start_mul_b <= 0;
    end
    always@(root_busy) begin
        if(root_busy != 0) start_root <= 0;
    end
    //always@(state) begin
    //    if(state == 0) rst_i = 1
endmodule
