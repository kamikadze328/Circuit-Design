`timescale 1ns / 1ps
//////////////////////////////////////////////
// Engineer: FPGA-Mechanic
//
// Design Name: Prototype Project
// Module Name: M_Nexys4_DISP
// Project Name: MCH_Nexys4_Test
// Target Devices: XC7A100 FPGA / Nexys4 Digilent Board
// Tool versions: Xilinx DS 14.4
// Description: 7-Segment Display Signal Generator
//
//////////////////////////////////////////////
module M_Nexys4_DISP(
    input CLK,
    input RST,
    input [11:0] HEX_IN,
    output CA,
    output CB,
    output CC,
    output CD,
    output CE,
    output CF,
    output CG,
    output reg DP,
    output [7:0] AN,
    input [7:0] DP_IN
    );
// Internal signals declaration:
//------------------------------------------
 reg CEO_DIV_H, CEO_DIV_L;
 reg [1:0] DIGIT_CNT;
 reg [3:0] I_CODE;
 wire O_SEG_A, O_SEG_B, O_SEG_C, O_SEG_D, O_SEG_E, O_SEG_F, O_SEG_G;
 reg [7:0] ANODE_DC;
 
 reg [19:0] clk_counter = 0;
 localparam MAX_clk_counter = 20'd400000;

//------------------------------------------
// Display Digit Counter:
 always @ (posedge CLK) begin
    if(RST) begin 
        DIGIT_CNT <= 'b0;
        clk_counter <= 'b0;
    end    
    else if(clk_counter == MAX_clk_counter) begin
        DIGIT_CNT <= ((DIGIT_CNT + 1'b1) == 2'b11) ? 2'b00 : (DIGIT_CNT + 1'b1);
        clk_counter <= 'b0;
    end
    clk_counter <= clk_counter + 1'b1;
end
//------------------------------------------
// Display Digit Multiplexer:
 always @ (DIGIT_CNT)
    case(DIGIT_CNT)
        2'b00:
           begin
               I_CODE = HEX_IN[3:0];
               DP = ~DP_IN[0];
               ANODE_DC = 8'd1;
           end
        2'b01:
           begin
               I_CODE = HEX_IN[7:4];
               DP = ~DP_IN[1];
               ANODE_DC = 8'd2;
           end
        2'b10:
           begin
               I_CODE = HEX_IN[11:8];
               DP = ~DP_IN[2];
               ANODE_DC = 8'd4;
           end
        /*2'b11:
           begin
               I_CODE = 4'h0;
               DP = ~DP_IN[3];
               ANODE_DC = 8'd8;
           end*/
        default: 
            begin
               I_CODE = 0;
               DP = 1'b1;
               ANODE_DC = 8'b11111111;
            end
        /*3'd4:
           begin
               I_CODE <= HEX_IN[19:16];
               DP <= ~DP_IN[4];
               ANODE_DC <= 8'd16;
           end
        3'd5:
           begin
               I_CODE <= HEX_IN[23:20];
               DP <= ~DP_IN[5];
               ANODE_DC <= 8'd32;
           end
        3'd6:
           begin
               I_CODE <= HEX_IN[27:24];
               DP <= ~DP_IN[6];
               ANODE_DC <= 8'd64;
           end*/
        /*default:
            begin
                I_CODE <= HEX_IN[31:28];
                DP <= ~DP_IN[7];
                ANODE_DC <= 8'd128;
            end*/
        endcase
//------------------------------------------
// 7-Segment Decoder:
 M_7SEG_DECODER_V10 DISP_DEC (
    .I_CODE(I_CODE),
    .O_SEG_A(O_SEG_A),
    .O_SEG_B(O_SEG_B),
    .O_SEG_C(O_SEG_C),
    .O_SEG_D(O_SEG_D),
    .O_SEG_E(O_SEG_E),
    .O_SEG_F(O_SEG_F),
    .O_SEG_G(O_SEG_G)
);
//------------------------------------------
 assign AN = ~ANODE_DC | {8{RST}};
 assign CA = ~O_SEG_A;
 assign CB = ~O_SEG_B;
 assign CC = ~O_SEG_C;
 assign CD = ~O_SEG_D;
 assign CE = ~O_SEG_E;
 assign CF = ~O_SEG_F;
 assign CG = ~O_SEG_G;
//------------------------------------------
endmodule