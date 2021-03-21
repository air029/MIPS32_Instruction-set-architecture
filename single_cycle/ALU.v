`timescale 1ns / 1ps


/*

module ALU(X,Y,Aluc,R,Z);//ALU����
input [31:0]X,Y;
input [1:0]Aluc;
output [31:0]R;
output Z;
wire[31:0]d_as,d_and,d_or,d_and_or;
ADDSUB_32 as(X,Y,Aluc[0],d_as);
assign d_and=X&Y;
assign d_or=X|Y;
MUX2X32 select1(d_and,d_or,Aluc[0],d_and_or);
MUX2X32 seleted(d_as,d_and_or,Aluc[1],R);
assign Z=~|R;
endmodule

*/



module MUX2X32(A0,A1,S,Y);
input [31:0] A0,A1;
input S;
output [31:0] Y;
function [31:0] select;
input [31:0] A0,A1;
input S;
case(S)
0:select=A0;
1:select=A1;
endcase
endfunction
assign Y=select(A0,A1,S);
endmodule

module ALU(    
      input [31:0] rega,  
      input [31:0] regb,  
      input [3:0] ALUopcode,
      output reg [31:0] result,  
      output zero  
      );  
     initial  
      begin  
         result = 0;  
    end  
     assign zero = (result==0)?1:0;  
     wire[31:0]  result_addu,result_subu;
     ADDSUB_32 as(rega,regb,ALUopcode[0],result_addu);
     ADDSUB_32 ssub(rega,regb,ALUopcode[0],result_subu);
     always @( ALUopcode or rega or regb ) begin  
         case (ALUopcode)  
             4'b0000 : result = rega + regb;  
             4'b0001 : result = rega - regb;  
             4'b0010 : result = rega & regb;   
             4'b0011 : result = rega | regb;  
             4'b0100 : result = regb << rega;  
             4'b0101 : result = (rega < regb)?1:0; // 不带符号比较  
             4'b0110 : begin // 带符号比较  
                 if(rega < regb && (rega[31] == regb[31]))result = 1;  
                 else if (rega[31] == 1 && regb[31] == 0) result = 1;  
                 else result = 0;  
                 end  
             4'b0111 : result = rega ^ regb;  
             4'b1000 : begin
               result = regb << 16;
             end
             4'b1001 :result = ~ (rega|regb);
             4'b1010 :begin
               if(regb > 0  )result = 0;
               else result = 1; 
             end
             4'b1100:
               result = result_addu;
             4'b1101:
               result  = rega * regb;
             4'b1011://subu
               result = result_subu;
              

         //    4'b1100 :
          /*   begin                
                 wire cout,cin;
                  cin =  0; 
                 ADDSUB_32  addu_1(rega,regb,cin,result,cout);
             end
          */   
            // 4'b1100：
             //default : begin  
             //    result = 32'h00000000;  
             //   $display (" no match");  
             //    end   assign Sh={X[29:0],z};
 
         endcase  
    end
    assign zero=~|result  ;
 endmodule  