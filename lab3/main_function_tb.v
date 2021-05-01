`timescale 1ns / 1ps


module main_function_tb();
    reg clk;
    reg rst;
    reg [7:0] a;
    reg [7:0] b;
    reg start;
    

    wire [1:0] busy;
    wire [7:0] result;
    
    main_function main (
        .clk_i(clk),
        .rst_i(rst),
        .a_bi(a),
        .b_bi(b),
        .start_i(start),
        .busy_o(busy),
        .result_bo(result)
    );
     
    initial begin
        clk=1; rst=1; #1 clk=0; rst=0; #1
        a=8'd4; b=8'd3; clk=1; start=1; #1
        clk=0; #1 clk=1; start=0; #1 #1
        while(busy != 0) begin
            #1 clk=0;
            #1 clk=1;
        end
        if(result != 5) begin 
            $display("error is %d, %d => %d", a, b, result);
            $stop;
        end else $display("test passed(%d, %d => %d)", a, b, result);
        
        //clk=1; rst=1; #1 clk=0; rst=0; #1
        clk=1; #1 clk=0; #1
        a=8'd7; b=8'd5; clk=1; start=1; #1
        clk=0; #1 clk=1; start=0; #1 #1
        while(busy != 0) begin
            #1 clk=0;
            #1 clk=1;
        end
        if(result != 8) begin 
            $display("error is %d, %d => %d", a, b, result);
            $stop;
        end else $display("test passed(%d, %d => %d)", a, b, result);

        $display("all test passed");
        $stop;
    end
endmodule