//pc
`timescale 1ns / 1ps

module SHL2 (input [31:0] data_in,
             output reg [31:0] data_out);
always @(data_in) begin
    data_out = data_in << 2;
end
endmodule //extend
