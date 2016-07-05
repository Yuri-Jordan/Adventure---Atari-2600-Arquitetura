.data
	tela1: .space 2048
	corAmarela: .word 0xFFD700
	corCinza: .word 0xC0C0C0	
.text
	lui $t0,0x1001 # Carrega tela
	lw $t2,corAmarela
	lw $t6,corCinza
	li $t3,512 # Iterador com quantidade de pixels da tela
	li $t7,0
lerArray:
	lw $a0,tela1($t7)
	add $t7,$t7,4
	sw $a0,0($t0)
	add $a0,$a0,4
	j lerArray
loop:
	beq $t3,$zero,fim
	lw $t1,0xffff0004 # Carrega keyboard
	beq $t1,97,pintarAmarelo
	beq $t1,99,pintarCinza
	beq $t1,0,loop
	j loop
pintarAmarelo:
	sw $zero,0xffff0004
	sw $t2,0($t0)
	addi $t0,$t0,4
	addi $t3,$t3,-1
	sw $t2,tela1($t7)
	addi $t7,$t7,4
	j loop
pintarCinza:
	sw $zero,0xffff0004
	sw $t6,0($t0)
	addi $t0,$t0,4
	addi $t3,$t3,-1
	sw $t6,tela1($t7)
	addi $t7,$t7,4
	j loop
fim:
	li $v0,10
	syscall	
