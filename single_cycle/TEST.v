module TEST;
reg Clk;
reg Reset;
wire [31:0] Addr,Inst,Qa,Qb,R,Result,D;
MAIN uut(
.Clk(Clk),
.Reset(Reset),
.Addr(Addr),
.Inst(Inst),
.Qa(Qa),
.Qb(Qb),
.R(R),
.Result(Result),
.D(D)
);

initial begin
Clk=0;Reset=0;
#10;
Clk=1;Reset=0;
#10;
Reset=1;
Clk=0;
forever #20 Clk=~Clk;
end
endmodule
