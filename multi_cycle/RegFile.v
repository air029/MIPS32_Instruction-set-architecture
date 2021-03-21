//regfile

`timescale 1ns / 1ps

module RegFile (input [4:0] R_Reg1,
                R_Reg2,
                W_Reg,
                input CLK,
                RegWr,
                input [31:0] W_data,
                output reg [31:0] R_data1,
                R_data2);

//reg [4:0] temp;
reg [31:0] register [0:31];
//赋初
integer i;
initial begin
    register[0] = 0;
    for (i = 1; i < 32; i = i + 1) begin
        //register[i] = 0;
        register[i] = {$random} % 16;
    end
end

always @(R_Reg1 or R_Reg2) begin
    assign  R_data1 = register[R_Reg1];
    assign  R_data2 = register[R_Reg2];
end


always @(posedge CLK or RegWr) begin//nege CLK
    if ((RegWr == 1))//(W_Reg != 0)&&
    begin
        register[W_Reg] = W_data;
        //register[W_Reg] = W_data;
    end
end

endmodule
