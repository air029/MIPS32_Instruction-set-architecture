//~ `New testbench
`timescale  1ns / 1ps

module tb_Memory;

// Memory Parameters
parameter PERIOD  = 10;


// Memory Inputs
// reg   clk                                  = 0 ;
reg   MemWr                                = 0 ;
reg   MemRd                                = 1 ;
reg   [31:0]  Addr                         = 0 ;
reg   [31:0]  W_data                       = 32'hxxxxxxxx ;

// Memory Outputs
wire  [31:0]  R_data                       ;


initial
begin
    // forever #(PERIOD/2)  clk=~clk;
    Addr = 0;
    MemRd = 1;
    MemWr = 0;
    #10
    Addr = 64;
    MemWr = 1;
    MemRd = 0;
    W_data = 10;
    #10
    $stop;
end


Memory_new  u_Memory (
    // .clk                     ( clk            ),
    .MemWr                   ( MemWr          ),
    .MemRd                   ( MemRd          ),
    .Addr                    ( Addr    [31:0] ),
    .W_data                  ( W_data  [31:0] ),
    .R_data                  ( R_data  [31:0] )
);



endmodule