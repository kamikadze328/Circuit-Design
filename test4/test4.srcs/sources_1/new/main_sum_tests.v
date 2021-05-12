`timescale 1ns / 1ps

module main_sum_tests();
reg clk;
reg [7:0] a;
reg [7:0] b;
reg start;
 
wire busy;
wire [7:0] result;
wire result_p;
    
main_sum main (
        .clk(clk),
        .a(a),
        .b(b),
        .start(start),
        .busy(busy),
        .y(result),
        .p(result_p)
);    
    initial begin
        a = 8'd8;
        b = 8'd50;
        start = 1; clk = 1; #1;
        while(busy != 0) begin
            clk = 1; #1;
        end 
        $display("%d should be 58", {result_p, result});   
        
        a = 8'd255;
        b = 8'd255;
        start = 1; clk = 1; #1;
        while(busy != 0) begin
            clk = 1; #1;
        end 
        $display("%d should be 510", {result_p, result});  
        
        a = 8'd128;
        b = 8'd255;
        start = 1; clk = 1; #1;
        while(busy != 0) begin
            clk = 1; #1;
        end 
        $display("%d should be 383", {result_p, result});         
    end
    
    
    always @(start) begin
        if(start == 1) start <= 0;
     end
    always @(clk) begin
        if(clk == 1) clk <= 0;
    end
        
endmodule
