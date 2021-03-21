`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/28 22:00:56
// Design Name: 
// Module Name: PC
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


module PC(Clk,Reset,Result,Address);  
input Clk;//ʱ��
input Reset;//�Ƿ����õ�ַ��0-��ʼ��PC����������µ�ַ       
input[31:0] Result;
output reg[31:0] Address;
//reg[31:0] Address;
initial begin
Address  <= 0;
end
always @(posedge Clk or negedge Reset)  //��ʱ���źŵ������غͿ����ź�Reset��Ϊ���б�����ʹ��pc�������ص�ʱ�����ı�����á�
begin  
if (!Reset) //���Ϊ0���ʼ��PC����������µ�ַ
begin  
Address <= 0;  
end  
else   
begin
Address =  Result;  
end  
end  
endmodule

module PCadd4(PC_o,PCadd4);
input [31:0] PC_o;//ƫ����
output [31:0] PCadd4;//��ָ���ַ
CLA_32 cla32(PC_o,4,0, PCadd4, Cout);

endmodule

