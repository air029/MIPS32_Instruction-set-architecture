//IR
`timescale 1ns / 1ps

module IR (input clk,
           IRWr,
           input wire [31:0] R_data,
           output reg [5:0] ins31_26,
           output reg [15:0]ins15_0,
           output reg [4:0]ins20_16,
           output reg [4:0]ins25_21,
           output reg [4:0] ins15_11,
           output reg [5:0] ins5_0,
           output reg [31:0] ins31_0
           );
    
    always @(posedge clk) begin
        if (IRWr == 1'b1) begin
            ins25_21 = R_data[25:21];
            ins20_16 = R_data[20:16];
            ins15_0  = R_data[15:0];
            ins31_26 = R_data[31:26];
            ins15_11 = R_data[15:11];
            ins5_0   = R_data[5:0];
            ins31_0  = R_data[31:0];


        end
    end
    
endmodule
