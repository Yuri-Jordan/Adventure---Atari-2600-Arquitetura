.include "mapas.asm"
.text
	li $t0,0
	lui $t1,0x1001
	lui $t2,0xffff
loop:
	beq $t0,2048,desenharPlayer
	lw $t5,casteloAmarelo($t0) # $t5 recebe a string do vetor e pula pra pintar o pixel
	beq $t5,120,pintarAmarelo
	beq $t5,65,pintarCinza
	beq $t5,80,pintarPreto
	# Não pintar 
	addi $t0,$t0,4
	addi $t1,$t1,4
	j loop	
############################################# PLAYER ###################################
desenharPlayer:
	li $t5,255
	addi $t1,$t1,-196
	sw $t5,0($t1)
	aguardaInput:
		lw $t3,0($t2)
		beq $t3,1,movimentar	
	j aguardaInput	
movimentar:
	lw $t3,4($t2)
	beq $t3,97,esquerda
	beq $t3,100,direita
	beq $t3,119,cima
	beq $t3,115,baixo
	j aguardaInput
esquerda:
	addi $t1,$t1,-4
	sw $t5,0($t1)
	addi $t1,$t1,4
	li $t5,11119017
	sw $t5,0($t1)
	li $t5,255
	addi $t1,$t1,-4
	j aguardaInput
direita:
	addi $t1,$t1,4
	sw $t5,0($t1)
	addi $t1,$t1,-4
	li $t5,11119017
	sw $t5,0($t1)
	li $t5,255
	addi $t1,$t1,4
	j aguardaInput
baixo:
	addi $t1,$t1,128
	sw $t5,0($t1)
	addi $t1,$t1,-128
	li $t5,11119017
	sw $t5,0($t1)
	li $t5,255
	addi $t1,$t1,128
	j aguardaInput
cima:
	addi $t1,$t1,-128
	sw $t5,0($t1)
	addi $t1,$t1,128
	li $t5,11119017
	sw $t5,0($t1)
	li $t5,255
	addi $t1,$t1,-128
	j aguardaInput
######################################################################################
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
pintarPreto:
	li $t5,0
	sw $t5,0($t1)
	addi $t1,$t1,4
	addi $t0,$t0,4
	j loop
fim:
	li $v0,10
	syscall
