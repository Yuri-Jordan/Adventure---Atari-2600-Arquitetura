.data 
	#mapa: .word 0xF0FFFF

.text
	li $t0,0
	lui $t1,0x1001
	lui $t7,0x1001
	addi $t7,$t7-4
	li $t3,0
	li $t6,0x0000CD
	li $t5,0xF0FFFF
inicializar:
	beq $t3,4,loop
	sw $t5,0($t1)
	addi $t1,$t1,4
	addi $t3,$t3,1
	j inicializar
loop:
	
	sw $t6,0($t1)
	sw $t5,0($t1)
	addi $t1,$t1,-4
	beq $t7,$t1,carrearAzul
	j loop
carrearAzul:
	addi $t1,$t1,20
	j loop