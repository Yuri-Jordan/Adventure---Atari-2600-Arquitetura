.include "mapas.asm"
.text
	li $t0,0
	lui $t1,0x1001
	lui $t2,0xffff
	li $t6,2 #  Armazena qual fase a ser desenhada
	j loop
##################################### Mapas ###################################
# $t5 recebe o Char do vetor e pula pra pintar o pixel
mapa1:
	lw $t5,labirinto1($t0)
	j cont
mapa2:
	lw $t5,roxo2($t0)
	j cont
mapa3:
	lw $t5,laranjaMorcego($t0)
	j cont
mapa4:
	lw $t5,casteloPreto($t0)
	j cont
mapa5:
	lw $t5,labirinto5($t0)
	j cont
mapa6:
	lw $t5,labirinto6($t0)
	j cont
mapa7:
	lw $t5,labirinto7($t0)
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
Pause:
	lw $t5,pause($t0)
	j cont
########################################## Desenha Mapas ###################################
loop:
beq $t0,2048,desenharPlayer
	beq $t6,1,mapa1
	beq $t6,2,mapa2
	beq $t6,3,mapa3
	beq $t6,4,mapa4
	beq $t6,5,mapa5
	beq $t6,6,mapa6
	beq $t6,7,mapa7
	beq $t6,8,mapa8
	beq $t6,9,mapa9
	beq $t6,10,mapa10
	beq $t6,11,mapa11
	beq $t6,12,mapa12
	beq $t6,13,mapa13
	beq $t6,14,mapa14
	cont:	
	beq $t5,120,pintarAmarelo
	beq $t5,66,pintarAzul
	beq $t5,82,pintarRoxo
	beq $t5,71,pintarVerde
	beq $t5,76,pintarLaranja
	beq $t5,80,pintarPreto
	beq $t5,65,pintarCinza
	beq $t5,112,pintarVermelho
	# Colocar "ID" dos proxs. mapas no mapa atualmente pintado
	beq $t5,50,pintarCinzaFase2
	beq $t5,51,pintarCinzaFase3
	beq $t5,52,pintarCinzaFase4
	beq $t5,53,pintarCinzaFase5
	beq $t5,54,pintarCinzaFase6
	beq $t5,55,pintarCinzaFase7
	beq $t5,56,pintarCinzaFase8
	beq $t5,57,pintarCinzaFase9
	beq $t5,62,pintarCinzaFase11
	beq $t5,59,pintarCinzaFase12
	beq $t5,60,pintarCinzaFase13
	beq $t5,61,pintarCinzaFase14
	
	# Não pintar 
	jal incrementar
	j loop
##################################### Carregar Mapas ############################
carregarMapa1:
	li $t6,1
	j zerar
carregarMapa2:
	li $t6,2
	j zerar
carregarMapa3:
	li $t6,3
	j zerar
carregarMapa4:
	li $t6,4
	j zerar
carregarMapa5:
	li $t6,5
	j zerar
carregarMapa6:
	li $t6,6
	j zerar
carregarMapa7:
	li $t6,7
	j zerar
carregarMapa8:
	li $t6,8
	j zerar
carregarMapa9:
	li $t6,9
	j zerar
carregarMapa10:
	li $t6,10
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
############################# PAUSE #############################
carregarPause:
	li $v0,31
	addi $a0,$zero,80 # passo
	addi $a1,$zero,250 # duração
	addi $a2,$zero,47 # insturmento
	addi $a3,$zero,127 # volume	
	syscall	
	li $t0,0
	lui $t1,0x1001
	j desenharPause
desenharPause:
	beq $t0,2048,esperarDespause
	lw $t5,pause($t0)
	beq $t5,112,pintarVermelho
	jal incrementar
	j desenharPause
esperarDespause:
	lw $t3,0($t2)
	beq $t3,1,verificar
	j esperarDespause
verificar:
	lw $t3,4($t2)
	beq $t3,112,somDespause
	j esperarDespause
somDespause:
	addi $a0,$zero,73 # passo
	addi $a1,$zero,250 # duração
	addi $a2,$zero,47 # insturmento
	addi $a3,$zero,127 # volume	
	syscall	
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
####################################### Movimentação PLAYER ###################################
desenharPlayer:
	li $t5,0xf0ffff
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
	beq $t3,112,carregarPause # Pause
	j aguardaInput
esquerda:
	lw $t4,-4($t1)# Colisão
	beq $t4,16766720,aguardaInput # = amarelo
	beq $t4,255,aguardaInput
	beq $t4,0x00FF7F,aguardaInput # = verde	
	beq $t4,0xFFA500,aguardaInput # = laranja
	beq $t4,0x8A2BE2,aguardaInput # = roxo
	beq $t4,0,aguardaInput # = preto
	li $t5,11119017
	sw $t5,0($t1)
	addi $t1,$t1,-4 
	li $t5,0xf0ffff
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
	beq $t4,0x8A2BE2,aguardaInput
	beq $t4,0,aguardaInput
	li $t5,11119017
	sw $t5,0($t1)
	addi $t1,$t1,4
	li $t5,0xf0ffff
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
	beq $t4,0x8A2BE2,aguardaInput
	beq $t4,0,aguardaInput
	li $t5,11119017 # cinza em decimal
	sw $t5,0($t1)
	addi $t1,$t1,128
	li $t5,0xf0ffff
	sw $t5,0($t1)
	beq $t4,11119018,carregarMapa3
	beq $t4,11119020,carregarMapa4
	beq $t4,11119021,carregarMapa5
	beq $t4,11119022,carregarMapa6
	beq $t4,11119023,carregarMapa7
	beq $t4,11119013,carregarMapa9
	beq $t4,11119010,carregarMapa11
	beq $t4,11119016,carregarMapa12
	beq $t4,11119015,carregarMapa14 # Verifica se o person. passou dos limites da fase
	j aguardaInput
cima:
	lw $t4,-128($t1)# Colisão
	beq $t4,16766720,aguardaInput
	beq $t4,255,aguardaInput
	beq $t4,0x00FF7F,aguardaInput
	beq $t4,0xFFA500,aguardaInput
	beq $t4,0,aguardaInput
	beq $t4,0x8A2BE2,aguardaInput
	beq $t4,0xf0ffff,aguardaInput # = branco
	li $t5,11119017
	sw $t5,0($t1)
	addi $t1,$t1,-128
	li $t5,0xf0ffff
	sw $t5,0($t1)
	beq $t4,11119019,carregarMapa2
	beq $t4,11119020,carregarMapa4
	beq $t4,11119021,carregarMapa5
	beq $t4,11119022,carregarMapa6
	beq $t4,11119011,carregarMapa8
	beq $t4,11119014,carregarMapa13
	beq $t4,11119010,carregarMapa11
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
pintarRoxo:
	li $t5,0x8A2BE2
	sw $t5,0($t1)
	jal incrementar
	j loop
pintarVermelho:
	li $t5,0xFF0000 # Cor vermelha em hexadecimal
	sw $t5,0($t1)
	jal incrementar
	j desenharPause
############################ PINTA OS SOLOS DE CINZA INDICANDO QUAL O PROX. MAPA A SER DESENHADO ####################
pintarCinzaFase2:
	li $t5,11119019
	sw $t5,0($t1)
	jal incrementar
	j loop
pintarCinzaFase3:
	li $t5,11119018
	sw $t5,0($t1)
	jal incrementar
	j loop
pintarCinzaFase4:
	li $t5,11119020
	sw $t5,0($t1)
	jal incrementar
	j loop
pintarCinzaFase5:
	li $t5,11119021
	sw $t5,0($t1)
	jal incrementar
	j loop
pintarCinzaFase6:
	li $t5,11119022
	sw $t5,0($t1)
	jal incrementar
	j loop
pintarCinzaFase7:
	li $t5,11119023
	sw $t5,0($t1)
	jal incrementar
	j loop
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
	li $t5,11119010
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
