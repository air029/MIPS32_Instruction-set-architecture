module MUX2_5(input [4:0]zero_in,one_in,
              input  signal,
              output [4:0] MUX2_5_result);
assign MUX2_5_result = signal==0?zero_in:one_in;

endmodule
