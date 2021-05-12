`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2021 10:57:21 AM
// Design Name: 
// Module Name: test_sqrt
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test_sqrt();

    reg clk = 0;
    reg rst = 0;
    reg [23:0] x;
    reg start;
    

    wire busy;
    wire [8:0] result;

    sqrt sqrt_module (
        .clk(clk),
        .rst(rst),
        .x_b(x),
        .start(start),
        .busy(busy),
        .y_b(result)
    );
     
    initial begin
    
        x=24'd130050; clk=1; start=1; #3 //x = 255^2 + 255^2
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
        
        x=24'd32768; clk=1; start=1; #3  // 128^2 + 128^2
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
        $display("%d should be 181", result); //hex b5
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
