`timescale 1ns / 1ps

module sum(
    input [1:0] a,
    input [1:0] b,
    input prev_p,
    
    output reg [1:0] y,
    output reg p
);

always @(a, b, prev_p) 
    {p, y} = a + b + prev_p;
 
endmodule
