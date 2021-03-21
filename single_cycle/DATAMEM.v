`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/28 21:28:05
// Design Name: 
// Module Name: DATAMEM
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

module DATAMEM(Addr,Din,Clk,We,Dout, type_load,Re);
input[31:0]Addr,Din;
input Clk,We,Re;
input type_load;
output[31:0]Dout;
reg[31:0]Ram[31:0];
assign Dout=Ram[Addr[6:2]];
always@(posedge Clk)begin
if(We)
if(type_load == 0)
Ram[Addr[6:2]]<=Din;
else if(type_load == 1)
Ram[Addr[6:2]][15:0]<=Din[15:0];
end
integer i;
initial begin
for(i=0;i<32;i=i+1)
Ram[i]=0;
end
endmodule


/*module DATAMEM(Addr,Din,Clk,We,Dout, type_load,Re);
input[31:0]Addr,Din;
input Clk,We,Re;
input type_load;
output[31:0]Dout;
reg[31:0]Ram[31:0];
reg [31:0] whichtoshow;
initial
    begin
    whichtoshow=32'b0 ;
    end

always@(posedge Clk)
begin
    if(We)
    begin 
    if(type_load == 0)
        Ram[Addr[6:2]]<=Din;
    if(type_load == 1)
        Ram[Addr[6:2]][15:0]<=Din[15:0];
    end
    if(Re)
    whichtoshow =Ram[Addr[6:2]];
end
assign Dout=whichtoshow;
integer i;
initial begin
for(i=0;i<32;i=i+1)
Ram[i]=0;
end
endmodule
*/

