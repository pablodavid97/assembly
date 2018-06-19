# Pablo Llanes
# 00133203 
# 23/03/2018

# Proyecto 1: Torres de Hanoi

.data
	prompt: .asciiz "Enter the number of disks n: "
	m1: .asciiz "\nMove disk from rod "
	m2: .asciiz " to rod "

.text
.globl main

main:
	
	# pide al usuario ingresar un valor
	li $v0, 4
	la $a0, prompt
	syscall
	
	# obtiene el valor ingresado por el usuario y lo almacena
	li $v0, 5
	syscall
	add $t0, $v0, $zero
	
	# llama a la funcion de hanoi 
	move $a0, $t0
	addi $a1, $zero, 1
	addi $a2, $zero, 3
	addi $a3, $zero, 2
	jal hanoi

	jr $ra 

hanoi: 
    addi $sp, $sp, -20 # ajusta el stack para 5 elementos 
    sw $a0, 0($sp) # almacena n 
    sw $a1, 4($sp) # almacena 1
    sw $a2, 8($sp) # almacena 3
	sw $a3, 12($sp) # almacena 2
	sw $ra, 16($sp) # almacena return address
		
	slti $t1, $a0, 2 # verifica si n < 2
    beq $t1, $zero, RL # si n >= 2 se hace la parte recursiva

	# almacena $a0 en variable temporal
	addi $t2, $a0, 0
	
	#imprime la secuencia de movimientos 
	li $v0, 4
	la $a0, m1
	syscall
	
	li $v0, 1
	move $a0, $a1
	syscall
	
	li $v0, 4
	la $a0, m2
	syscall
	
	li $v0, 1
	move $a0, $a2
	syscall
	
	addi $a0, $t2, 0 # se restaura el valor de $a0
	
	addi $sp, $sp, 20 # elimina 5 elementos del stack 
	
    jr $ra # se regresa a la funcion que llamo a hanoi 
	
RL:
	addi $a0, $a0, -1 # se hace linea recursiva para n - 1
	addi $t3, $a3, 0 # se intercambian valores		
    addi $a3, $a2, 0 		
    addi $a2, $t3, 0		
	
	jal hanoi # llamada recursiva
	
	# almacena y restaura valores originales 
	lw $a0, 0($sp) 
    lw $a1, 4($sp) 
    lw $a2, 8($sp) 
	lw $a3, 12($sp) 
	lw $ra, 16($sp)
	
	# almacena $a0 en variable temporal
	addi $t4, $a0, 0
	
	# imprime el mensaje con secuencias de movimientos
	li $v0, 4
	la $a0, m1
	syscall
	
	li $v0, 1
	move $a0, $a1
	syscall
	
	li $v0, 4
	la $a0, m2
	syscall
	
	li $v0, 1
	move $a0, $a2
	syscall
	
	addi $a0, $t4, 0 # restaura los valores de a
	
	addi $a0, $a0, -1 # se hace linea recursiva para n - 1
	addi $t5, $a3, 0 # se intercambian valores	
    addi $a3, $a1, 0		
    addi $a1, $t5, 0		
	
	jal hanoi # segunda llamada recursiva
	
	lw $ra, 16($sp) # se restaura el valor del return address
	
	addi $sp, $sp, 20 # elimina 5 elementos del stack 
	
	jr $ra # devuelve el control a la funcion que llamo a hanoi