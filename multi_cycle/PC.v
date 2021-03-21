//pc
`timescale 1ns / 1ps
module PC(
          input CLK,
          input Reset,
          input PCcontrol,
          input [31:0] PC0,
          output [31:0] PC
         );
  reg [31:0]  PC_TEMP;  
  initial 
  begin
    PC_TEMP = 0;
  end

// always @(PCcontrol or Reset)
//     begin
//         if (Reset == 0)
//            PC_TEMP  = 0;
//         else if(PCcontrol == 1'b1)
//         begin
//            PC_TEMP = PC0;
//         end
//     end

always @(posedge CLK) begin
  if(PCcontrol)begin
    PC_TEMP = PC0;
  end
end

assign PC = PC_TEMP;
endmodule