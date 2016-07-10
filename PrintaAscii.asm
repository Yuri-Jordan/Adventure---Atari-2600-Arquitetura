.data
pula: .byte '\n'
.text
lui $t0,0xffff
loop:
	lw $t1,0($t0)
	beq $t1,1,print
	j loop
print:
	li $v0,4
	la $a0,pula
	syscall
	li $v0,1
	lw $a0,4($t0)
	syscall
	j loop
