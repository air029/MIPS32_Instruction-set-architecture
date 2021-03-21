//datalate

`timescale 1ns / 1ps
module DataLate (input clk,
input [31:0] data_in,                 
                 output reg [31:0] data_out);

always @(posedge clk) begin
    data_out <= data_in;
end
endmodule //datalate
