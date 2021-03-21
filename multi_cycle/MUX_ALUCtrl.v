module Mux_ALUCtrl (input [31:0] zero_in,
              one_in,
              input [3:0]signal,
              output [31:0] mux_out);

assign mux_out = (signal == 'b1010 || signal == 'b1011)?zero_in:one_in;
endmodule //mux_2
