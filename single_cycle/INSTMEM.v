`timescale 1ns / 1ps


module INSTMEM(Addr,Inst);//ָ��洢��
input[31:0]Addr;
//input InsMemRW;//״̬Ϊ'0'��дָ��Ĵ���������Ϊ��ָ��Ĵ���
output[31:0]Inst;
wire[31:0]Rom[31:0];
assign Rom[5'h00]=32'h20010008;//addi $1,$0,8 $1=8
assign Rom[5'h01]=32'h3402000C;//ori $2,$0,12 $2=12
assign Rom[5'h02]=32'h00221820;//add $3,$1,$2 $3=20
assign Rom[5'h03]=32'h00412022;//sub $4,$2,$1 $4=4
assign Rom[5'h04]=32'h00222824;//and $5,$1,$2
assign Rom[5'h05]=32'h00223025;//or $6,$1,$2
assign Rom[5'h06]=32'h14220001;//bne $1,$2,1
assign Rom[5'h07]=32'hXXXXXXXX;
assign Rom[5'h08]=32'b01110000001000100111100000000010;//mul $1,$2
assign Rom[5'h09]=32'h10220002;// beq $1,$2,2(添加地址)
assign Rom[5'h0A]=32'h0800000c;// J 0c 
assign Rom[5'h0B]=32'hXXXXXXXX;
assign Rom[5'h0C]=32'b00000000001000101000000000100011;//无符号减法 subu $15,$1,$2
assign Rom[5'h0D]=32'hAD02000A;// sw $2 10($8) memory[$8+10]=12
assign Rom[5'h0E]=32'h8D04000A;//lw $4 10($8) $4=12
assign Rom[5'h0F]=32'h10440002;//beq $2,$4,2
assign Rom[5'h10]=32'hXXXXXXXX;
assign Rom[5'h11]=32'hXXXXXXXX;
assign Rom[5'h12]=32'b10100100000100000000000000001100;//memory[$0+12]=$15加载半字
assign Rom[5'h13]=32'h30470009;//andi $2,9,$7
assign Rom[5'h14]=32'b00000000100000100011100000000100;//sllv  $4,$2,$7
assign Rom[5'h15]=32'b00000000001000100100000000101010;//sltu  $1,$2,$8
assign Rom[5'h16]=32'b00000000001000100100100000101010;//slt  $1,$2,$9
assign Rom[5'h17]=32'b00000000011000100101000000100110;//xor $3,$2,$10
assign Rom[5'h18]=32'b00111000010010110000000000111111;//xori $2.$11,b'111111
assign Rom[5'h19]=32'b00111100000011000000000000001111;// lui $12,32
assign Rom[5'h1A]=32'b00000001100010100110100000100111;//nor $12,$10,$13
assign Rom[5'h1B]=32'b00101000001011100000000000010000;//slti  $1 $14 32
assign Rom[5'h1C]=32'b00011000000000010000000000000001;//大于0，跳转$1>0
assign Rom[5'h1D]=32'h44444444;
assign Rom[5'h1E]=32'b00000000010001110111100000100001;//addu  $2, $7,$15
assign Rom[5'h1F]=32'hXXXXXXXX;
//00000000010000010011100000000100

assign Inst=Rom[Addr[6:2]];
endmodule
