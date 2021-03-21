module  EXT5T32 ( X, Y);
input [4:0] X;
output [31:0] Y;
parameter z = 27'b0;
assign Y = {z, X};
endmodule
