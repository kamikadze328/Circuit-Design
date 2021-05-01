`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2021 02:33:48 PM
// Design Name: 
// Module Name: hardware_top
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


module hardware_top(
    input [15:0] SW,
    output reg [15:0] LED
    );
   always@(SW) begin 
    LED = SW;
   end 
endmodule
