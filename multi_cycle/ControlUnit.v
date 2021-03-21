//ControlUnit
//lw,sw,add,sub,addu,and,or,slt,beq,j

`timescale 1ns / 1ns

module controlUnit (input [5:0] 
                    opcode, 
                    func,
                    input 
                    zero,
                    Overflow,
                    clk,
                    output reg [0:0]
                    IorD,
                    IRWr,
                    PCWr,
                    PCWrCond,
                    RegDst,
                    RegWr,
                    ALUSrcA,
                    MemWr,
                    MemRd,
                    MemtoReg, 
                    output reg [1:0] 
                    PCSrc,
                    ALUSrcB,
                    output reg [3:0] 
                    ALUOp,
                    state_out);

//define 4'b_state
parameter [3:0] 
state0  = 4'b0000,
state1  = 4'b0001,
state2  = 4'b0010,
state3  = 4'b0011,
state4  = 4'b0100,
state5  = 4'b0101,
state6  = 4'b0110,
state7  = 4'b0111,
state8  = 4'b1000,
state9  = 4'b1001,
state10 = 4'b1010;

//define func
parameter [5:0]
add   = 6'b100000,
addu  = 6'b100001,
sub   = 6'b100010,
subu  = 6'b100011,
And   = 6'b100100,
Or    = 6'b100101,
Xor   = 6'b100110,
Nor   = 6'b100111,
slt   = 6'b101010,
sll   = 6'b000000,
srl   = 6'b000010,
sra   = 6'b000011;

//define 6'b_opcode
parameter [5:0] 
R     = 6'b000000,
beq   = 6'b000100,//=0 branch
bgtz  = 6'b000111,//>0 branch
blez  = 6'b000110,//<=0 branch
bne   = 6'b000101,//!=0 branch


j     = 6'b000010,
lw    = 6'b100011,
sw    = 6'b101011,
halt  = 6'b111111,

addi  = 6'b001000,
addiu = 6'b001001,

Andi  = 6'b001100,
Ori   = 6'b001101,
Xori  = 6'b001110,
lui   = 6'b001111;


reg [3:0] state, next_state;

//signal and state
//inistial-begin----------------------------------------------
initial begin
    IorD = 1'b0;
    IRWr = 1'b1;
    PCWr = 1'b1;
    PCWrCond = 1'b0;
    RegDst = 1'b0;
    RegWr = 1'b1;
    ALUSrcA = 1'b0;
    MemWr = 1'b0;
    MemRd = 1'b1;
    MemtoReg = 1'b0;
    PCSrc = 2'b00;
    ALUSrcB = 2'b01;
    ALUOp = 4'b0100;
    state     = state0;
    state_out = state;
end
//inistial-end----------------------------------------------

//decide-when-go-to-next-state
//clk-posedge-begin----------------------------------------------
// always @(posedge clk) begin
//     begin
//         state <= next_state;
//         state_out = state;
//     end
// end
//clk-posedge-begin----------------------------------------------

//decide-next-state
//state-ins-begin----------------------------------------------
always @(posedge clk) begin//state or func or opcode or 
    case (state)
        state0: next_state = state1;
        state1: begin
            case (opcode)
                R: next_state         = state6;
                addi:next_state       = state2;
                addiu:next_state      = state2;
                Andi:next_state       = state2;
                Xori:next_state       = state2;
                Ori:next_state        = state2;
                Xor:next_state        = state6;
                lui:next_state        = state2;
                beq: next_state       = state8;
                bgtz: next_state      = state8;
                blez: next_state      = state8;
                bne:next_state        = state8;
                j: next_state         = state9;
                lw : next_state       = state2;
                sw : next_state       = state2;
                default : next_state  = state0;
            endcase
        end
        state2: begin 
            case (opcode)
            lw:next_state         = state3;
            sw:next_state         = state5;
            addi:next_state       = state10;
            addiu:next_state      = state10;
            Andi:next_state       = state10;
            Xori:next_state       = state10;
            Ori:next_state        = state10;
            lui:next_state        = state10;            
            endcase
        end
        state3: next_state  = state4;
        state4: next_state  = state0;
        state5: next_state  = state0;
        state6: next_state  = state7;
        state7: next_state  = state0;
        state8: next_state  = state0;
        state9: next_state  = state0;
        state10:next_state  = state0;
        default :next_state = state0;

    endcase
    state = next_state;
    state_out = state;
         
end
//state-ins-end----------------------------------------------


//decide-signal
//state-change-begin----------------------------------------------
always @(state or posedge clk) begin

    if (state == state0) begin
        // MemRd = 1'b1;
        // ALUSrcA = 1'b0;
        // IorD = 1'b0;
        // IRWr = 1'b1;
        // ALUSrcB = 2'b01;
        // ALUOp = 4'b0100;
        // PCWr = 1'b1;
        // PCSrc = 2'b00;
        PCWr = 1;
        PCWrCond = 0;
        IorD = 0;
        MemRd = 1;
        MemWr = 0;
        IRWr = 1;
        MemtoReg = 0;
        PCSrc = 'b00;
        ALUOp = 'b0100;
        ALUSrcA = 0;
        ALUSrcB = 'b01;
        RegWr = 0;
        RegDst = 0;
    end

    
    if(state == state1) begin
        PCWr = 0;
        PCWrCond = 0;
        IorD = 0;
        MemRd = 0;
        MemWr = 0;
        IRWr = 0;
        MemtoReg = 0;
        PCSrc = 'b00;
        ALUOp = 'b0100;
        ALUSrcA = 0;
        ALUSrcB = 'b11;
        RegWr = 0;
        RegDst = 0;
    end

    
    if (state == state2) begin
        PCWr = 0;
        PCWrCond = 0;
        IorD = 0;
        MemRd = 0;
        MemWr = 0;
        IRWr = 0;
        MemtoReg = 0;
        PCSrc = 'b00;
        case (opcode)
            addi:ALUOp  = 4'b0100;
            addiu:ALUOp = 4'b0101;
            Andi:ALUOp  = 4'b0000;
            Ori:ALUOp   = 4'b0001;
            Xori:ALUOp  = 4'b0010;
            lui:ALUOp   = 4'b1001;
            lw:ALUOp    = 'b0100;
            sw:ALUOp    = 'b0100;
        endcase        
        ALUSrcA = 1;
        ALUSrcB = 'b10;
        RegWr = 0;
        RegDst = 0;
    end


        
    if (state == state3) begin
        //MemRd = 1'b1;
        //IorD = 1'b1;
        PCWr = 0;
        PCWrCond = 0;
        IorD = 1;
        MemRd = 1;
        MemWr = 0;
        IRWr = 0;
        MemtoReg = 0;
        PCSrc = 'b00;
        ALUOp = 'b0000;
        ALUSrcA = 0;
        ALUSrcB = 'b00;
        RegWr = 0;
        RegDst = 0;
    end
    
    if (state == state4) begin
        //RegDst = 1'b0;
        //RegWr = 1'b1;
        //MemtoReg = 1'b1;
        PCWr = 0;
        PCWrCond = 0;
        IorD = 0;
        MemRd = 0;
        MemWr = 0;
        IRWr = 0;
        MemtoReg = 1;
        PCSrc = 'b00;
        ALUOp = 'b0000;
        ALUSrcA = 0;
        ALUSrcB = 'b00;
        RegWr = 1;
        RegDst = 0;
    end
    
    if (state == state5) begin
        //MemWr = 1'b1;
        //IorD = 1'b1;
        PCWr = 0;
        PCWrCond = 0;
        IorD = 1;
        MemRd = 0;
        MemWr = 1;
        IRWr = 0;
        MemtoReg = 0;
        PCSrc = 'b00;
        ALUOp = 'b0000;
        ALUSrcA = 0;
        ALUSrcB = 'b00;
        RegWr = 0;
        RegDst = 0;
    end
    
    if (state == state6) begin
        //ALUSrcA = 1'b1;
        //ALUSrcB = 2'b00;
        PCWr = 0;
        PCWrCond = 0;
        IorD = 0;
        MemRd = 0;
        MemWr = 0;
        IRWr = 0;
        MemtoReg = 0;
        PCSrc = 'b00;
        ALUOp = 'b0000;
        ALUSrcA = 1;
        ALUSrcB = 'b00;
        RegWr = 0;
        RegDst = 0;
        case (opcode) 
        R:  case (func)
            add:ALUOp = 4'b0100;
            addu:ALUOp =4'b0101;
            sub:ALUOp=4'b0110;
            subu:ALUOp=4'b0111;
            And:ALUOp=4'b0000;
            Or:ALUOp=4'b0001;
            Xor:ALUOp=4'b0010;
            Nor:ALUOp=4'b0011;
            slt:ALUOp=4'b1000;
            sll:ALUOp=4'b1010;
            srl:ALUOp=4'b1011;
            //sra:ALUOp=4'b
            endcase
        endcase
    end
    
    if (state == state7) begin
        //RegDst = 1'b1;
        //RegWr = 1'b1;
        //MemtoReg = 1'b0;
        PCWr = 0;
        PCWrCond = 0;
        IorD = 0;
        MemRd = 0;
        MemWr = 0;
        IRWr = 0;
        MemtoReg = 0;
        PCSrc = 'b00;
        ALUOp = 'b0000;
        ALUSrcA = 0;
        ALUSrcB = 'b00;
        RegWr = 1;
        RegDst = 1;
    end

    
    if (state == state8) begin
        //ALUSrcA = 1'b1;
       // ALUSrcB = 2'b00;
        //ALUOp = 4'b1100;
        //PCWrCond = 1'b1;
        //PCSrc = 2'b01;
        PCWr = 0;
        PCWrCond = 1;
        IorD = 0;
        MemRd = 0;
        MemWr = 0;
        IRWr = 0;
        MemtoReg = 0;
        PCSrc = 'b01;
        ALUOp = 'b1100;
        ALUSrcA = 1;
        ALUSrcB = 'b00;
        RegWr = 0;
        RegDst = 0;
    end
    
    if (state == state9) begin
        //PCWr = 1'b1;
        //PCSrc = 2'b10;
        PCWr = 1;
        PCWrCond = 0;
        IorD = 0;
        MemRd = 0;
        MemWr = 0;
        IRWr = 0;
        MemtoReg = 0;
        PCSrc = 'b10;
        ALUOp = 'b0000;
        ALUSrcA = 0;
        ALUSrcB = 'b00;
        RegWr = 0;
        RegDst = 0;
    end
    if (state == state10) begin
        //RegDst = 1'b1;
        //RegWr = 1'b1;
        //MemtoReg = 1'b0;
        PCWr = 0;
        PCWrCond = 0;
        IorD = 0;
        MemRd = 0;
        MemWr = 0;
        IRWr = 0;
        MemtoReg = 0;
        PCSrc = 'b00;
        ALUOp = 'b0000;
        ALUSrcA = 0;
        ALUSrcB = 'b00;
        RegWr = 1;
        RegDst = 0;
    end

end
//state-change-end----------------------------------------------



endmodule //controlunit
