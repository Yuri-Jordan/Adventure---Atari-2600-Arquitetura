.include "mapas.asm"
.text
	li $t0,0
	lui $t1,0x1001
	lui $t2,0xffff
	li $t6,2 #  Armazena qual fase a ser desenhada
	li $t8,255 # responsável pela mudança de cor do Cálice
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
dragaoP:
	lw $t5,dragao($t0)
	j cont
caliceP:
	lw $t5,calice($t0)
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
	beq $t6,15,dragaoP
	beq $t6,16,caliceP
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
	jal zerar
	j loop
carregarMapa2:
	li $t6,2
	jal zerar
	j loop
carregarMapa3:
	li $t6,3
	jal zerar
	j loop
carregarMapa4:
	li $t6,4
	jal zerar
	j loop
carregarMapa5:
	li $t6,5
	jal zerar
	j loop
carregarMapa6:
	li $t6,6
	jal zerar
	j loop
carregarMapa7:
	li $t6,7
	jal zerar
	j loop
carregarMapa8:
	li $t6,8
	jal zerar
	j loop
carregarMapa9:
	li $t6,9
	jal zerar
	j loop
carregarMapa10:
	li $t6,10
	jal zerar
	j loop
carregarMapa11:
	li $t6,11
	jal zerar
	j loop
carregarMapa12:
	li $t6,12
	jal zerar
	j loop
carregarMapa13:
	li $t6,13
	jal zerar
	j loop
carregarMapa14:
	li $t6,14
	jal zerar
	j loop
carregarDragão:
	li $t6,15
	jal zerar
	j loop
carregarCalice:
	li $t6,16
	jal zerar
	j loop
############################# PAUSE #############################
carregarPause:
	li $v0,31
	addi $a0,$zero,80 # passo
	addi $a1,$zero,250 # duração
	addi $a2,$zero,47 # insturmento
	addi $a3,$zero,127 # volume	
	syscall	
	jal zerar
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
	li $v0,31
	addi $a0,$zero,73 # passo
	addi $a1,$zero,250 # duração
	addi $a2,$zero,47 # insturmento
	addi $a3,$zero,127 # volume	
	syscall	
	jal zerar
	j loop
#################################### Zera iteradores ##############################
zerar:
	li $t0,0
	lui $t1,0x1001
	jr $ra
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
	beq $t6,9,carregarDragão
	beq $t6,2,carregarCalice
	aguardaInput:
		lw $t3,0($t2)
		beq $t3,1,movimentar
		beq $t6,16,zerarPcalice
		j aguardaInput
zerarPcalice:
	jal zerar
	j attCalice
attCalice:
	jal incrementar
	beq $t0,2048,aguardaInput
	lw $t5,calice($t0)
	beq $t5,66,corCalice	
	j attCalice	
		
movimentar:
	lw $t3,4($t2)
	beq $t3,97,esquerda
	beq $t3,100,direita
	beq $t3,119,cima
	beq $t3,115,baixo
	beq $t3,27,zerarSair # esc
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
corCalice:
	sw $t8,0($t1)
	addi $t8,$t8,250
	j attCalice
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
pintarFimV:
	li $t5,0xFF0000 # Cor vermelha em hexadecimal
	sw $t5,0($t1)
	jal incrementar
	j loopSair
pintarFimP:
	li $t5,0 # Cor vermelha em hexadecimal
	sw $t5,0($t1)
	jal incrementar
	j loopSair
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
################################################# FIM ###################################
zerarSair:
	jal zerar
	j loopSair
loopSair:
	beq $t0,2048,fim
	lw $t5,TelaFim($t0)
	beq $t5,80,pintarFimP
	beq $t5,45,pintarFimV
	jal incrementar
	j loopSair
fim:
	li $v0,10
	syscall
