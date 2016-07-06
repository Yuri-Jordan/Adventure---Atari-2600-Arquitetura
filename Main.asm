.include "mapas.asm"
.text
	li $t0,0
	lui $t1,0x1001
loop:
	beq $t0,2048,fim
	lw $t5,casteloAmarelo($t0) # $t5 recebe a string do vetor e pula pra pintar o pixel
	beq $t5,120,pintarAmarelo
	beq $t5,65,pintarCinza
	# Não pintar 
	addi $t0,$t0,4
	addi $t1,$t1,4
	j loop	
pintarAmarelo:
	li $t5,16766720 # Cor amarela em decimal
	sw $t5,0($t1)
	addi $t1,$t1,4
	addi $t0,$t0,4
	j loop
pintarCinza:
	li $t5,11119017 # Cor cinza em hexadecimal
	sw $t5,0($t1)
	addi $t1,$t1,4
	addi $t0,$t0,4
	j loop
fim:
	li $v0,10
	syscall
