//datalate

`timescale 1ns / 1ps
/////////////////////////////////////////////////////////////////
module ALU_CPU2 (
            input [31:0] 
            A,
            B,
            input [3:0] ALUOp,
            output reg zero,
            output reg Overflow,
            output reg [31:0] result);

initial begin
    result = 0;
end

reg [0:0] ZR;
reg [0:0] OF;


always @( A or B or ALUOp) begin
    case (ALUOp)
        // 3'b000: result   = A + B;//A+B
        // 3'b001: result   = A - B;//A-B
        // 3'b010: result   = ((A < B)?1:0);//A B compare
        // 3'b011: result   = A >> B;//right move
        // 3'b100: result   = A << B;//left move
        // 3'b101: result   = A | B;//or
        // 3'b110: result   = A & B;//and
        // 3'b111: result   = (~A & B) |  (A & ~B);//xor
        // default : result = 0;

        // 4'b0000: result = A & B;
        // 4'b0001: result = A | B;
        // 4'b0010: result = (~A & B) |  (A & ~B);
        // 4'b0011: result = ~(A | B);
        // 4'b0100: result = A + B;
        // 4'b0101: result = A + B;
        // 4'b0110: result = A - B;
        // 4'b0111: result = A - B;
        // 4'b1000: result = ((A < B)?1:0);
               
        4'b0000: result = A & B;
        4'b0001: result = A | B;
        4'b0010: result = (~A & B) |  (A & ~B);
        4'b0011: result = ~(A | B);
        4'b0100: begin 
                    result = A + B;
                    if (A[31] == 1'b0 && B[31] == 1'b0 && result[31] == 1'b1) begin
                        OF = 1'b1;
                    end
                    else if (A[31] == 1'b1 && B[31] == 1'b1 && result[31] == 1'b0) begin
                        OF = 1'b1;
                    end
                    else begin
                        OF = 1'b0;
                    end
                 end
        4'b0101: result = A + B;
        4'b0110: begin 
                    result = A - B;
                    if (A[31] == 1'b0 && B[31] == 1'b0 && result[31] == 1'b1) begin
                        OF = 1'b1;
                    end
                    else if (A[31] == 1'b1 && B[31] == 1'b1 && result[31] == 1'b0) begin
                        OF = 1'b1;
                    end
                    else begin
                        OF = 1'b0;
                    end
                 end
        4'b0111: result = A - B;
        4'b1000: result = ((A < B)?1:0);
        4'b1001: result = B << 16;
        4'b1010: result = B << A;
        4'b1011: result = B >> A;

        4'b1100: begin 
                    result = A - B;
                    ZR = (result == 0);
                 end
        4'b1101: begin 
                    result = A;
                    ZR = (result > 0);
                 end
        4'b1110: begin 
                    result = A;
                    ZR = (result <= 0);
                 end

        4'b1111: begin
                    result = A - B;
                    ZR = (result != 0);
                 end
        default:result = 0;
    endcase
    zero = ((ALUOp == 4'b1100 && ZR) ||(ALUOp == 4'b1101 && ZR) ||(ALUOp == 4'b1110 && ZR)||(ALUOp == 4'b1111 && ZR))?1:0;
    Overflow = (((ALUOp == 4'b0100 && OF)||(ALUOp == 4'b0110 && OF)))?1:0;

end
endmodule