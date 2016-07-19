############################### CÓPIA ##################################
.include "mapas.asm"
.text
	li $t0,0
	lui $t1,0x1001
	lui $t2,0xffff
	li $t6,11 #  Armazena qual fase a ser desenhada
	j loop
mapa4:
	lw $t5,casteloPreto($t0)
	j cont
mapa10:
	lw $t5,acimaCastAmarelo($t0)
	j cont
mapa11:
	# $t5 recebe o Char do vetor e pula pra pintar o pixel
	lw $t5,casteloAmarelo($t0)
	j cont
mapa12:
	# $t5 recebe o Char do vetor e pula pra pintar o pixel
	lw $t5,abaixoCastelo($t0)
	j cont
loop:
	beq $t0,2048,desenharPlayer
	beq $t6,4,mapa4
	beq $t6,11,mapa11
	beq $t6,12,mapa12
	cont:	
	#beq $t5,60,pintarPreto
	beq $t5,120,pintarAmarelo
	beq $t5,65,pintarCinza
	beq $t5,71,pintarVerde
	beq $t5,80,pintarPreto
	beq $t5,66,pintarBranco
	# Não pintar 
	jal incrementar
	j loop
qualMapaEstouB:
	beq $t6,11,carregarMapa12
##################################### Carregar Mapas ############################
carregarMapa12:
	li $t6,12
	j zera
#################################### Zera iteradores ##############################
zera:
	li $t0,0
	lui $t1,0x1001
	j loop
# Incrementa tanto o índice do vetor quanto o pixel no bitmap
incrementar:
	addi $t0,$t0,4
	addi $t1,$t1,4
	jr $ra	
####################################### PLAYER ###################################
desenharPlayer:
	li $t5,255
	addi $t1,$t1,-324
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
	lw $t4,-4($t1)# Colisão
	beq $t4,16766720,aguardaInput
	beq $t4,0x00FF7F,aguardaInput
	beq $t4,0,aguardaInput
	li $t5,11119017
	sw $t5,0($t1)
	addi $t1,$t1,-4
	li $t5,255
	sw $t5,0($t1)
	j aguardaInput
direita:
	lw $t4,4($t1)# Colisão
	beq $t4,16766720,aguardaInput
	beq $t4,0x00FF7F,aguardaInput
	beq $t4,0,aguardaInput
	li $t5,11119017
	sw $t5,0($t1)
	addi $t1,$t1,4
	li $t5,255
	sw $t5,0($t1)
	j aguardaInput
baixo:
	lw $t4,128($t1)# Colisão
	beq $t4,16766720,aguardaInput
	beq $t4,0x00FF7F,aguardaInput
	beq $t4,0,aguardaInput
	li $t5,11119017 # cinza em decimal
	sw $t5,0($t1)
	beq $t4,120,qualMapaEstouB # Verifica se o person. passou dos limites da fase
	addi $t1,$t1,128
	li $t5,255
	sw $t5,0($t1)
	j aguardaInput
cima:
	lw $t4,-128($t1)# Colisão
	beq $t4,16766720,aguardaInput
	beq $t4,0x00FF7F,aguardaInput
	beq $t4,0,aguardaInput
	beq $t4,0xf0ffff,aguardaInput
	li $t5,11119017
	sw $t5,0($t1)
	addi $t1,$t1,-128
	li $t5,255
	sw $t5,0($t1)
	j aguardaInput
########################################### Pintoras ###########################################
pintarAmarelo:
	li $t5,16766720 # Cor amarela em decimal
	sw $t5,0($t1)
	jal incrementar
	j loop
pintarCinza:
	li $t5,11119017 
	sw $t5,0($t1)
	jal incrementar
	j loop
pintarVerde:
	li $t5,0x00FF7F # Cor verde em hexadecimal
	sw $t5,0($t1)
	jal incrementar
	j loop
pintarPreto:
	li $t5,0
	sw $t5,0($t1)
	jal incrementar
	j loop
pintarBranco:
	li $t5,0xf0ffff
	sw $t5,0($t1)
	jal incrementar
	j loop
fim:
	li $v0,10
	syscall
