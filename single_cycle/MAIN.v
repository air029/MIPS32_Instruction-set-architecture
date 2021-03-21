

`timescale 1ns / 1ps


module MAIN(Clk,Reset,Addr,Inst,Qa,Qb,R,Result,D);
input Clk,Reset;
output [31:0] Inst,Result,R,Qb,Qa,Addr,D;

wire [31:0]Result,PCadd4,EXTIMM,InstL2,EXTIMML2,D,Y,Dout,mux4x32_2,R;
wire Z,Regrt,Se,Wreg,Aluqb,Reg2reg,Cout,Wmem,Rmem;
//wire Z,Regrt,Se,Wreg,Aluqa,Aluqb,Reg2reg,Cout,Wmem;
wire [1:0]Pcsrc;
wire [3:0]Aluc;
wire [4:0]Wr;
wire type_load;
PC pc(Clk,Reset,Result,Addr);
PCadd4 pcadd4(Addr,PCadd4);
INSTMEM instmem(Addr,Inst);

CONUNIT conunit(Inst[31:26],Inst[5:0],Z,Regrt,Se,Wreg,Aluqb,Aluc,Wmem,Pcsrc,Reg2reg,type_load,Rmem);
//CONUNIT conunit(Inst[31:26],Inst[5:0],Z,Regrt,Se,Wreg,Aluqa,Aluqb,Aluc,Wmem,Pcsrc,Reg2reg);
MUX2X5 mux2x5(Inst[15:11],Inst[20:16],Regrt,Wr);
EXT16T32 ext16t32(Inst[15:0],Se,EXTIMM);
SHIFTER_COMBINATION shifter1(Inst[26:0],PCadd4,InstL2);
SHIFTER32_L2 shifter2(EXTIMM,EXTIMML2);
REGFILE regfile(Inst[25:21],Inst[20:16],D,Wr,Wreg,Clk,Reset,Qa,Qb);
MUX2X32 mux2x321(EXTIMM,Qb,Aluqb,Y);
//
//MUX2X32 mux2xyiwei(EXTIMM,Qa,Aluqa,X);
ALU alu(Qa,Y,Aluc,R,Z);
//ALU alu(X ,Y,Aluc,R,Z);
DATAMEM datamem(R,Qb,Clk,Wmem,Dout, type_load,Rmem);
MUX2X32 mux2x322(Dout,R,Reg2reg,D);
CLA_32 cla_32(PCadd4,EXTIMML2,0,mux4x32_2, Cout);
MUX4X32 mux4x32(PCadd4,0,mux4x32_2,InstL2,Pcsrc,Result);
assign NEXTADDR=Result;
assign ALU_R=R;
endmodule
//module CONUNIT(Op,Func,Z,Regrt,Se,Wreg,Aluqa,Aluqb,Aluc,Wmem,Pcsrc,Reg2reg);
module CONUNIT(Op,Func,Z,Regrt,Se,Wreg,Aluqb,Aluc,Wmem,Pcsrc,Reg2reg,type_load,Rmem);
input[5:0]Op,Func;
input Z;
output Regrt,Se,Wreg,Aluqb,Wmem,Reg2reg,Rmem;
output type_load;
//output Regrt,Se,Wreg,Aluqa,Aluqb,Wmem,Reg2reg;
output[1:0]Pcsrc;
output[3:0]Aluc;
//wire R_type=~|Op;
//wire I_add=R_type&Func[5]&~Func[4]&~Func[3]&~Func[2]&~Func[1]&~Func[0];
//wire I_sub=R_type&Func[5]&~Func[4]&~Func[3]&~Func[2]&Func[1]&~Func[0];
//wire I_and=R_type&Func[5]&~Func[4]&~Func[3]&Func[2]&~Func[1]&~Func[0];
//wire I_or=R_type&Func[5]&~Func[4]&~Func[3]&Func[2]&~Func[1]&Func[0];
wire I_add=~Op[5]&~Op[4]&~Op[3]&~Op[2]&~Op[1]&~Op[0]&Func[5]&~Func[4]&~Func[3]&~Func[2]&~Func[1]&~Func[0];
wire I_sub=~Op[5]&~Op[4]&~Op[3]&~Op[2]&~Op[1]&~Op[0]&Func[5]&~Func[4]&~Func[3]&~Func[2]&Func[1]&~Func[0];
wire I_and=~Op[5]&~Op[4]&~Op[3]&~Op[2]&~Op[1]&~Op[0]&Func[5]&~Func[4]&~Func[3]&Func[2]&~Func[1]&~Func[0];
wire I_or=~Op[5]&~Op[4]&~Op[3]&~Op[2]&~Op[1]&~Op[0]&Func[5]&~Func[4]&~Func[3]&Func[2]&~Func[1]&Func[0];

wire I_mul=~Op[5]&Op[4]&Op[3]&Op[2]&~Op[1]&~Op[0]&~Func[5]&~Func[4]&~Func[3]&~Func[2]&Func[1]&~Func[0];

wire I_sllvr=~Op[5]&~Op[4]&~Op[3]&~Op[2]&~Op[1]&~Op[0]&~Func[5]&~Func[4]&~Func[3]&Func[2]&~Func[1]&~Func[0];//左移
wire I_slt=~Op[5]&~Op[4]&~Op[3]&~Op[2]&~Op[1]&~Op[0]&Func[5]&~Func[4]&Func[3]&~Func[2]&Func[1]&~Func[0];//不带符号数比较
wire I_sltu=~Op[5]&~Op[4]&~Op[3]&~Op[2]&~Op[1]&~Op[0]&Func[5]&~Func[4]&Func[3]&~Func[2]&Func[1]&Func[0];//带符号数比较
wire I_xor=~Op[5]&~Op[4]&~Op[3]&~Op[2]&~Op[1]&~Op[0]&Func[5]&~Func[4]&~Func[3]&Func[2]&Func[1]&~Func[0];//xor
wire I_nor=~Op[5]&~Op[4]&~Op[3]&~Op[2]&~Op[1]&~Op[0]&Func[5]&~Func[4]&~Func[3]&Func[2]&Func[1]&Func[0];//nor
wire I_slti = ~Op[5]&~Op[4]&Op[3]&~Op[2]&Op[1]&~Op[0];
//wire I_xor=~Op[5]&~Op[4]&~Op[3]&~Op[2]&~Op[1]&~Op[0]&Func[5]&~Func[4]&~Func[3]&~Func[2]&~Func[1]&Func[0];//添加
wire I_addi=~Op[5]&~Op[4]&Op[3]&~Op[2]&~Op[1]&~Op[0];
wire I_andi=~Op[5]&~Op[4]&Op[3]&Op[2]&~Op[1]&~Op[0];

wire I_xori=~Op[5]&~Op[4]&Op[3]&Op[2]&Op[1]&~Op[0];//

wire I_lui=~Op[5]&~Op[4]&Op[3]&Op[2]&Op[1]&Op[0];

wire I_ori=~Op[5]&~Op[4]&Op[3]&Op[2]&~Op[1]&Op[0];

wire I_blez = ~Op[5]&~Op[4]&~Op[3]&Op[2]&Op[1]&~Op[0];

wire I_sra=~Op[5]&~Op[4]&~Op[3]&~Op[2]&~Op[1]&~Op[0]&~Func[5]&~Func[4]&~Func[3]&~Func[2]&Func[1]&Func[0];//算数右移
wire I_addu=~Op[5]&~Op[4]&~Op[3]&~Op[2]&~Op[1]&~Op[0]&Func[5]&~Func[4]&~Func[3]&~Func[2]&~Func[1]&Func[0];//无溢出的加法
wire I_subu=~Op[5]&~Op[4]&~Op[3]&~Op[2]&~Op[1]&~Op[0]&Func[5]&~Func[4]&~Func[3]&~Func[2]&Func[1]&Func[0];//无溢出的减法
wire I_lw=Op[5]&~Op[4]&~Op[3]&~Op[2]&Op[1]&Op[0];
wire I_sw=Op[5]&~Op[4]&Op[3]&~Op[2]&Op[1]&Op[0];
wire I_sh=Op[5]&~Op[4]&Op[3]&~Op[2]&~Op[1]&Op[0];//加载半字
wire I_beq=~Op[5]&~Op[4]&~Op[3]&Op[2]&~Op[1]&~Op[0];
wire I_bne=~Op[5]&~Op[4]&~Op[3]&Op[2]&~Op[1]&Op[0];
wire I_J=~Op[5]&~Op[4]&~Op[3]&~Op[2]&Op[1]&~Op[0];
//I_sllvr|I_slt|I_sltu|I_xor
assign Regrt=I_addi|I_andi|I_ori|I_lw|I_sw|I_beq|I_bne|I_J|I_xori|I_lui|I_slti|I_blez|I_sh;
assign Se=I_addi|I_lw|I_sw|I_beq|I_bne|I_blez|I_sh;
assign Wreg=I_add|I_sub|I_and|I_or|I_addi|I_andi|I_ori|I_lw|I_sllvr|I_slt|I_sltu|I_xor|I_nor|I_addu|I_mul|I_subu;
//assign Aluqa=1;
assign Aluqb=I_add|I_sub|I_and|I_or|I_beq|I_bne|I_J|I_sllvr|I_slt|I_sltu|I_xor|I_nor|I_blez|I_addu|I_mul|I_subu;
assign Aluc[3]=I_lui|I_nor|I_blez|I_sra|I_addu|I_mul|I_subu;
assign Aluc[2]=I_sllvr|I_slt|I_sltu|I_xor|I_xori|I_slti|I_addu|I_mul;
assign Aluc[1]=I_and|I_or|I_andi|I_ori|I_sltu|I_xor|I_xori|I_blez|I_sra|I_subu;
assign Aluc[0]=I_sub|I_or|I_ori|I_beq|I_bne|I_slt|I_xor|I_xori|I_nor|I_slti|I_sra|I_mul|I_subu;
assign Wmem=I_sw|I_sh;
assign Rmem=I_lw;
assign Pcsrc[1]=I_beq&Z|I_bne&~Z|I_J|I_blez&Z;
assign Pcsrc[0]=I_J;
assign Reg2reg=I_add|I_sub|I_and|I_or|I_addi|I_andi|I_ori|I_sw|I_beq|I_bne|I_J|I_sllvr|I_slt|I_sltu|I_xor|I_xori|I_lui|I_nor|I_slti|I_addu|I_mul|I_subu;
assign type_load  = I_sh;
endmodule