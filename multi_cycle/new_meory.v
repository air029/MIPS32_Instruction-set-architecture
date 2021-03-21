`timescale 1ns / 1ps

module Memory_new (input
               MemWr,
               MemRd,
               input [31:0] Addr,
               W_data,
               output [31:0] R_data);
    
    reg [31:0] data;//将四个八位数据拼接成三十二位数据
    reg [7:0] mem [0:127];
    integer i;

    initial begin
        // $readmemb("C:/Users/mjh12/Desktop/multicycle/code/my_mem.txt",mem);
        $readmemh("C:/Users/mjh12/Desktop/mul/instruction/FINAL_load_store.txt",mem);
        for (i = 64; i < 128; i = i+1) begin
            mem[i] = {$random} % 16;
        end
    end
    
    // always @(negedge clk) begin
    //     if (MemRd == 1'b1) begin
    //         data[31:24] = mem[Addr];
    //         data[23:16] = mem[Addr+1];
    //         data[15:8]  = mem[Addr+2];
    //         data[7:0]   = mem[Addr+3];
    //         R_data      = data;
    //     end
    //     else if (MemWr == 1'b1) begin
    //         mem[Addr]   = W_data[31:24];
    //         mem[Addr+1] = W_data[23:16];
    //         mem[Addr+2] = W_data[15:8];
    //         mem[Addr+3] = W_data[7:0];
    //     end
    //         end
    //assign R_data = data; 

    always @(MemRd or Addr) begin
    if (MemRd == 1) begin
        data[31:24] = mem[Addr];
        data[23:16] = mem[Addr+1];
        data[15:8]  = mem[Addr+2];
        data[7:0]   = mem[Addr+3];
        // R_data[31:0] = data[31:0];
    end
    // else if(MemWr) begin
    //     mem[Addr]   = W_data[31:24];
    //     mem[Addr+1] = W_data[23:16];
    //     mem[Addr+2] = W_data[15:8];
    //     mem[Addr+3] = W_data[7:0];      
    // end
    end      
    // always @(posedge clk) begin
    //     if (MemRd) begin
    //      R_data <= data;
    //     end
    // end
            
    always @(MemWr or W_data or Addr) begin
        if(MemWr)begin
            mem[Addr]   = W_data[31:24];
            mem[Addr+1] = W_data[23:16];
            mem[Addr+2] = W_data[15:8];
            mem[Addr+3] = W_data[7:0];  
        end
    end

    assign R_data = data;
endmodule //Memory
