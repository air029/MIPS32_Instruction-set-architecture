`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/28 21:32:01
// Design Name: 
// Module Name: EXT16T32
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

module EXT16T32 (X, Se, Y);
input [15:0] X;
input Se;
output [31:0] Y;
wire [31:0] E0, E1;
wire [15:0] e = {16{X[15]}};
parameter z = 16'b0;
assign E0 = {z, X};
assign E1 = {e, X};
MUX2X32 i(E0, E1, Se, Y);
endmodule 


//移位数扩展
module EXT5T32 ( X, Y);
input [4:0] X;
output [31:0] Y;
parameter z = 27'b0;
assign Y = {z, X};
endmodule
