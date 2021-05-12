`timescale 1ns / 1ps


module test_main();

reg [7:0] a, b;
reg start = 0, clk = 0, rst = 0;
wire [11:0] result;
wire busy;

hypotenuse math_main(
    .clk(clk),
    .rst(rst),
    .start(start),
    .a(a),
    .b(b),
    .busy(busy),
    .y(result)
);
initial begin
        a = 8'd255; b = 8'd255; clk=1; start=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        $display("%d should be 360", result); //hex 168
        
        a = 8'd128; b = 8'd255; clk=1; start=1; #3  // 128^2 + 128^2
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        clk=1; #3
        $display("%d should be 285", result); //hex 11d
    end
    
always @(clk) begin
    if(clk == 1) clk <= 0;
end
always @(rst) begin
    if(rst == 1) rst <= 0;
end
always @(start) begin
    if(start == 1) start <= 0;
end
endmodule
