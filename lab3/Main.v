`timescale 1ns / 1ps

module Main(
    input clk,
    input rst,
    input start,
    input [7:0] a,
    input [7:0] b,
    output wire busy,
    output [6:0] seg, // DISP Segments
    output dp, // DISP Dots
    output [7:0] an//, // DISP Anodes
   );
   
wire [11:0] y;   

hypotenuse math_module(
    .clk(clk),
    .rst(rst),
    .start(start),
    .a(a),
    .b(b),
    .busy(busy),
    .y(y)
);

M_Nexys4_DISP DISP_7_MODULE (
    .CLK(clk),
    .RST(rst),
    //.HEX_IN(12'hAF1),
    .HEX_IN(y),
    .DP_IN(8'h11),
    .CA(seg[0]),
    .CB(seg[1]),
    .CC(seg[2]),
    .CD(seg[3]),
    .CE(seg[4]),
    .CF(seg[5]),
    .CG(seg[6]),
    .DP(dp),
    .AN(an)
);

endmodule
