`timescale 1ns / 1ps
module Extend (input [15:0] Inst15_0,
               output reg [31:0] out);
always @(Inst15_0) begin
        out <= {{16{Inst15_0[15]}}, Inst15_0[15:0]};
end
endmodule //extend

