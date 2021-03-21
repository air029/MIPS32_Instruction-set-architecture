`timescale 1ns / 1ps
module pcsignal(input zero, 
                      PCWrCond,
                      PCWr,
                output reg PCControl  
                    );
always@(*)
begin
    assign PCControl = ( (zero && PCWrCond) | PCWr );
end    
endmodule                 