//top
`include "ALU.v"
`include "DataLate.v"
// `include "new_meory.v"
`include "IR.v"
// `include "Mux_2.v"
`include "Mux_4.v"
`include "PC.v"
`include "PCsignal.v"
`include "SHL2.v"
`include "RegFile.v"
`include "SigExt.v"
`include "ControlUnit.v"
`include "Jumpaddr.v"

`timescale 1ns / 1ps

module Top(input CLK,
           input reset
          //  output wire [3:0] state_out,
          //  output wire [5:0] opcode,
          //  output wire [5:0] func,
          //  output wire [4:0] rs,
          //  rt,
          //  rd,
          //  output wire [31:0] ins31_0,
          //  A_OUT,
          //  B,
          //  result,
          //  output wire [0:0] ALUSrcA_OUT,
          //  output wire [1:0] ALUSrcB,
          //  output wire [0:0] RegWr,
          //  output wire [1:0]  PCSrc,
          //  output wire [3:0] ALUOp,
          //  output wire [31:0] R_data1,
          //  output wire [31:0] Addr,
          //  output wire [31:0] PC_OUT,//
          //  output wire [0:0] MemWr,
          //  output wire [0:0] MemRd 
           );
    /////////////////////new
    wire [3:0] state_out;
    wire [5:0] opcode;
    wire [5:0] func;
    wire [4:0] rs, rt, rd;
    wire [31:0] ins31_0, B, result;
    wire [1:0] ALUSrcB;
    wire [0:0] RegWr;
    wire [1:0] PCSrc;
    wire [3:0] ALUOp;
    wire [31:0] R_data1, Addr;
    wire [0:0] MemWr, MemRd;

    wire [31:0] R_data;
    wire [31:0] Q_MDR;

    //扩展shamt移位
    wire [31:0] sigext_5_32;
    wire [31:0] A_out;
    //


    ///////////////////////////////////////////////////////
    wire IorD,IRWr,InsMemRW,RegDst,MemtoReg;
    wire [31:0] PC0,ALUout2,W_data,R_data2,A_1,B_1,imm_extend,imm_extend_shl2,PC,A;
    wire [4:0] ins20_16,ins25_21,ins15_11,W_Reg;
    wire [15:0] ins15_0;
    wire [5:0] ins5_0,ins31_26;
    wire [31:0] jaddr;
    wire [0:0] Overflow;
    wire [0:0] zero,PCWrCond,PCWr,PCcontrol,ALUSrcA;
////////////////////////////////////////////////////////////////////////////////
  /*  wire CLk,reset,IorD,MemWr,MemRd,IRWr,InsMemRW,RegDst,RegWr,MemtoReg,AlUSrcA;
    wire [31:0] PC0,PC,ALUout2,Addr,W_data,R_data1,R_data2,A_1,B_1,imm_extend,imm_extend_shl2,ins31_0;
    wire [4:0] ins20_16,ins25_21,ins15_11,W_Reg;
    wire [15:0] ins15_0;
    wire [5:0] ins5_0,ins31_26;
    wire [31:0] A,B,result,jaddr;
    wire [1:0] ALUSrcB,PCSrc;
    wire [3:0] ALUOp;
    wire Overflow;
    wire zero,PCWrCond,PCWr,PCcontrol;*/
 //////////////////////////////////////////////////////////////////////////////   
    assign opcode = ins31_0[31:26];
    assign rs     = ins31_0[25:21];
    assign rt     = ins31_0[20:16];
    assign rd     = ins31_0[15:11];
    assign func   = ins31_0[5:0];
    // assign PC_OUT = PC;
    // assign ALUSrcA_OUT = ALUSrcA;
    // assign A_OUT = A;
    
    // 数据通路
   // wire [31:0] j_addr,  i_IR, extendData, LateOut1,ins_1, LateOut2;//, DataOut;out1, out2, result1,
   // wire zero, Overflow;
    
    // 控制信号
    //wire [3:0] ALUOp;
   // wire [1:0] ExtSel, RegOut;// PCSrc;
    //wire PCWre, IRWre, InsMemRW, DataMemRW;//ALUSrcA, ALUSrcB, RegWre, , ALUM2Reg,WrRegData, 
    
    
    pcsignal pcsignal_1(zero, PCWrCond,PCWr,PCcontrol);
  //  wire zero,PCWrCond,PCWr,PCcontrol;
    PC pc(CLK, reset, PCcontrol,PC0,PC);
  //  wire CLk,IorD,MemWr,MemRd,IRWr,InsMemRW,RegDst,RegWr,MemtoReg,AlUSrcA;
  //  wire [31:0] PC0,PC,ALUout2,Addr,W_data,R_data1,R_data2,A_1,B_1,imm_extend,imm_extend_shl2;
  //  wire [4:0] ins20_16,ins25_21,ins15_11,W_Reg;
  //  wire [15:0] ins15_0;
  //  wire [5:0] ins5_0,ins31_26;
  //  wire [31:0] A,B,result,jaddr;
  //  wire [1:0] ALUSrcB;
  //  wire [3:0] ALUOp;
  //  wire zero,Overflow;
    Mux_2 PCDATA(PC,ALUout2,IorD,Addr);

    Memory_new insdata(MemWr,MemRd,Addr,B_1,R_data);//sw,lw修改B_1

    DataLate  regDatalate(CLK,R_data,Q_MDR);//MDR

    IR  ir(CLK,IRWr,R_data,ins31_26,ins15_0,ins20_16,ins25_21,ins15_11,ins5_0,ins31_0);

    MUX2_5 regchoice(ins20_16,ins15_11,RegDst,W_Reg);// 55口输入5口输出regset

    RegFile  RF(ins25_21,ins20_16,W_Reg,CLK,RegWr,W_data,R_data1,R_data2);

    DataLate INS1(CLK, R_data1, A_1);
    DataLate INS2(CLK, R_data2, B_1);

    Mux_2 toRF(ALUout2,Q_MDR,MemtoReg,W_data);//memtoreg

    Extend extend16_32(ins15_0,imm_extend);//下sigext16/32
    EXT5T32 extend5_32(ins31_0[10:6], sigext_5_32);//增加shamt移位
    SHL2  shl2(imm_extend,imm_extend_shl2);//下shl2

    Mux_2 A_choice(PC,A_1,ALUSrcA,A);//改A_1为PC//alusrcA
    Mux_ALUCtrl ALUCtrl_choice(sigext_5_32,A,ALUOp,A_out);
    Mux_4 B_choice(B_1,4,imm_extend,imm_extend_shl2,ALUSrcB,B);//alusrcB

    ALU_CPU2  alu(A_out,B,ALUOp,zero,Overflow,result);

    DataLate alulate(CLK,result,ALUout2);

    jumpaddr pcjump(ins15_0,ins20_16,ins25_21,PC,jaddr);

    Mux_4 pcchoice(result,ALUout2,jaddr,32'hxxxxxxxx,PCSrc,PC0);//PCSrc

    

    ///cu换
    controlUnit controlunit(opcode, func, zero, Overflow,CLK, IorD, IRWr, PCWr, PCWrCond, RegDst,RegWr, ALUSrcA, MemWr, MemRd, MemtoReg, PCSrc, ALUSrcB, ALUOp, state_out);
    
endmodule
