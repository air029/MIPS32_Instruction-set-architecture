add $1, $30, $30
addu $2, $30, $30
addi $3, $30, 1
addiu $4, $30, 1
sub $5, $1, $3
subu $6, $1 ,$3
lui $7, 1
and $8, $30, $30
or $9,$30,$30
not $10, $30
xor $11, $30, $30
nor $12, $30, $30
andi $13, $30, 1
ori $14, $30, 1
xori $15, $30, 1
sll $16,$1,1
srl $17, $1 ,1
slt $18, $16, $17
j flag1
add $19, $30,$30
flag1:beq $30,$30,flag2
add $19, $30,$30
flag2:bgtz $30, flag3
add $19, $30,$30
flag3:blez $30, flag4
add $20, $30,$30
flag4:bne $30,$1,flag5
add $19, $30,$30
flag5:lw $21,1($30)
sw $22, 9($30)

