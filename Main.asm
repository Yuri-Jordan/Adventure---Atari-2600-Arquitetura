.include "mapas.asm"
.text
	li $t0,0
	lui $t1,0x1001
	lui $t2,0xffff
	li $t6,1 #  Armazena qual fase a ser desenhada
	j loop
##################################### Mapas ###################################
# $t5 recebe o Char do vetor e pula pra pintar o pixel
mapa1:
	lw $t5,labirinto1($t0)
	j cont
mapa4:
	lw $t5,casteloPreto($t0)
	j cont
mapa5:
	lw $t5,($t0)
	j cont
mapa6:
	lw $t5,labirinto6($t0)
	j cont
mapa8:
	lw $t5,labirinto8($t0)
	j cont
mapa9:
	lw $t5,verdeDragaoAmarelo($t0)
	j cont
mapa10:
	lw $t5,acimaCastAmarelo($t0)
	j cont
mapa11:
	lw $t5,casteloAmarelo($t0)
	j cont
mapa12:
	lw $t5,abaixoCastelo($t0)
	j cont
mapa13:
	lw $t5,ptVerdeLinhaPreta($t0)
	j cont
mapa14:
	lw $t5,laranjaDragaoVerde($t0)
	j cont
########################################## Desenha Mapas ###################################
loop:
	beq $t0,2048,desenharPlayer
	beq $t6,1,mapa1
	beq $t6,4,mapa4
	beq $t6,5,mapa5
	beq $t6,6,mapa6
	beq $t6,8,mapa8
	beq $t6,9,mapa9
	beq $t6,11,mapa11
	beq $t6,12,mapa12
	beq $t6,13,mapa13
	beq $t6,14,mapa14
	cont:	
	beq $t5,120,pintarAmarelo
	beq $t5,66,pintarAzul
	beq $t5,65,pintarCinza
	beq $t5,56,pintarCinzaFase8
	beq $t5,57,pintarCinzaFase9
	beq $t5,58,pintarCinzaFase11
	beq $t5,59,pintarCinzaFase12
	beq $t5,60,pintarCinzaFase13
	beq $t5,61,pintarCinzaFase14
	beq $t5,71,pintarVerde
	beq $t5,76,pintarLaranja
	beq $t5,80,pintarPreto
	beq $t5,66,pintarBranco
	# Não pintar 
	jal incrementar
	j loop
##################################### Carregar Mapas ############################
carregarMapa1:
	li $t6,1
	j zerar
carregarMapa4:
	li $t6,4
	j zerar
carregarMapa5:
	li $t6,5
	j zerar
carregarMapa8:
	li $t6,8
	j zerar
carregarMapa9:
	li $t6,9
	j zerar
carregarMapa11:
	li $t6,11
	j zerar
carregarMapa12:
	li $t6,12
	j zerar
carregarMapa13:
	li $t6,13
	j zerar
carregarMapa14:
	li $t6,14
	j zerar
#################################### Zera iteradores ##############################
zerar:
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
	beq $t4,16766720,aguardaInput # = amarelo
	beq $t4,255,aguardaInput
	beq $t4,0x00FF7F,aguardaInput # = verde	
	beq $t4,0xFFA500,aguardaInput # = laranja
	beq $t4,0,aguardaInput # = preto
	li $t5,11119017
	sw $t5,0($t1)
	addi $t1,$t1,-4 
	li $t5,255
	sw $t5,0($t1)
	beq $t4,11119016,carregarMapa12
	beq $t4,11119013,carregarMapa9
	j aguardaInput
direita:
	lw $t4,4($t1)# Colisão
	
	beq $t4,16766720,aguardaInput
	beq $t4,255,aguardaInput
	beq $t4,0x00FF7F,aguardaInput
	beq $t4,0xFFA500,aguardaInput
	beq $t4,0,aguardaInput
	li $t5,11119017
	sw $t5,0($t1)
	addi $t1,$t1,4
	li $t5,255
	sw $t5,0($t1)
	beq $t4,11119016,carregarMapa12
	beq $t4,11119014,carregarMapa13
	j aguardaInput
baixo:
	lw $t4,128($t1)# Colisão
	beq $t4,16766720,aguardaInput
	beq $t4,255,aguardaInput
	beq $t4,0x00FF7F,aguardaInput
	beq $t4,0xFFA500,aguardaInput
	beq $t4,0,aguardaInput
	li $t5,11119017 # cinza em decimal
	sw $t5,0($t1)
	addi $t1,$t1,128
	li $t5,255
	sw $t5,0($t1)
	beq $t4,11119013,carregarMapa9
	beq $t4,11119016,carregarMapa12
	beq $t4,11119015,carregarMapa14 # Verifica se o person. passou dos limites da fase
	j aguardaInput
cima:
	lw $t4,-128($t1)# Colisão
	li $v0,1
	move $a0,$t4
	syscall
	beq $t4,16766720,aguardaInput
	beq $t4,255,aguardaInput
	beq $t4,0x00FF7F,aguardaInput
	beq $t4,0xFFA500,aguardaInput
	beq $t4,0,aguardaInput
	beq $t4,0xf0ffff,aguardaInput # = branco
	li $t5,11119017
	sw $t5,0($t1)
	addi $t1,$t1,-128
	li $t5,255
	sw $t5,0($t1)
	beq $t4,11119011,carregarMapa8
	beq $t4,11119014,carregarMapa13
	beq $t4,11119012,carregarMapa11
	j aguardaInput
########################################### Pintoras ###########################################
pintarAzul:
	li $t5,255 # Cor zul em decimal
	sw $t5,0($t1)
	jal incrementar
	j loop
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
pintarLaranja:
	li $t5,0xFFA500
	sw $t5,0($t1)
	jal incrementar
	j loop
pintarBranco:
	li $t5,0xf0ffff
	sw $t5,0($t1)
	jal incrementar
	j loop
############################ PINTA OS SOLOS DE CINZA INDICANDO QUAL O PROX. MAPA A SER DESENHADO ####################
pintarCinzaFase8:
	li $t5,11119011
	sw $t5,0($t1)
	jal incrementar
	j loop
pintarCinzaFase9:
	li $t5,11119013
	sw $t5,0($t1)
	jal incrementar
	j loop
pintarCinzaFase11:
	li $t5,11119012
	sw $t5,0($t1)
	jal incrementar
	j loop
pintarCinzaFase12:
	li $t5,11119016
	sw $t5,0($t1)
	jal incrementar
	j loop
pintarCinzaFase13:
	li $t5,11119014
	sw $t5,0($t1)
	jal incrementar
	j loop
pintarCinzaFase14:
	li $t5,11119015
	sw $t5,0($t1)
	jal incrementar
	j loop
####################################################################################
fim:
	li $v0,10
	syscall
