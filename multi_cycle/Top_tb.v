//~ `New testbench
`timescale  1ns / 1ns

module tb_Top;

// Top Parameters
parameter PERIOD  = 10;

// Top Inputs
reg   CLK                                  = 0 ;
reg   reset                                = 0 ;
// Top Outputs
// wire  [3:0]  state_out                     ;    
// wire  [5:0]  opcode                        ;
// wire  [5:0]  func                          ;
// wire  [4:0]  rs                            ;
// wire  [4:0]  rt                            ;
// wire  [4:0]  rd                            ;
// wire  [31:0]  ins31_0                      ;
// wire  [31:0]  A_OUT                            ;
// wire  [31:0]  B                            ;
// wire  [31:0]  result                       ;
// wire  [0:0]  ALUSrcA_OUT                       ;
// wire  [1:0]  ALUSrcB                       ;
// wire  [0:0]  RegWr                         ;
// wire  [1:0]  PCSrc                         ;
// wire  [3:0]  ALUOp                         ;
// wire  [31:0]  R_data1                         ;
// wire [31:0] Addr;
// wire  [31:0] PC_OUT;//
//     wire [0:0] MemWr;
// wire [0:0] MemRd;


initial
begin
    forever #(PERIOD/2)  CLK=~CLK;
end


initial
begin
    // #(PERIOD*2) reset  =  1;
    // #(PERIOD*1) reset  = 1;
    #(PERIOD*1) reset  = 1;
end




Top  u_Top (
    .CLK                     ( CLK               ),
        .reset                     (reset)
    // .state_out               ( state_out  [3:0]  ),
    // .opcode                  ( opcode     [5:0]  ),
    // .func                    ( func       [5:0]  ),
    // .rs                      ( rs         [4:0]  ),
    // .rt                      ( rt         [4:0]  ),
    // .rd                      ( rd         [4:0]  ),
    // .ins31_0                 ( ins31_0    [31:0] ),
    // .A_OUT                       ( A_OUT          [31:0] ),
    // .B                       ( B          [31:0] ),
    // .result                  ( result     [31:0] ),
    // .ALUSrcA_OUT                 ( ALUSrcA_OUT    [0:0]  ),
    // .ALUSrcB                 ( ALUSrcB    [1:0]  ),
    // .RegWr                   ( RegWr      [0:0]  ),
    // .PCSrc                   ( PCSrc      [1:0]  ),
    // .ALUOp                   ( ALUOp      [3:0]  ),
    // .R_data1                   ( R_data1       [31:0]  ),
    // .Addr                     (Addr [31:0]),
    // .PC_OUT                      (PC_OUT [31:0]),
    // .MemWr(MemWr[0:0]),
    // .MemRd(MemRd[0:0])
    

);

// initial
// begin

//     $finish;
// end

endmodule