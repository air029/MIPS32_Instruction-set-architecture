`timescale 1ns / 1ps
module jumpaddr(
    input [15:0]ins15_0,
    input [4:0]ins20_16,
    input [4:0]ins25_21,
    input [31:0] pc,
    output reg [31:0] jaddr
               );
    parameter z=2'b00;
    always @(*)
    begin
      jaddr = { pc[31:28],ins25_21[4:0],ins20_16[4:0],ins15_0[15:0],z };
    end
        

endmodule