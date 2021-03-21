//mux_4
`timescale 1ns / 1ps
module Mux_4 (input [31:0] zero_in,
              one_in,
              two_in,
              three_in,
              input [1:0] signal,
              output reg [31:0] mux_out);

always @(signal or zero_in or one_in or two_in or three_in) begin
    case (signal)
    2'b00: mux_out = zero_in;
    2'b01: mux_out = one_in;
    2'b10: mux_out = two_in;
    2'b11: mux_out = three_in;
    endcase
end
  
endmodule //mux_2
