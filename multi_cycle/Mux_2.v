//mux_2
`timescale 1ns / 1ps
module Mux_2 (input [31:0] zero_in,
              one_in,
              input signal,
              output [31:0] mux_out);

assign mux_out = (signal == 0)?zero_in:one_in;
endmodule //mux_2
