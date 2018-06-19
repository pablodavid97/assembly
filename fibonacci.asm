# Pablo Llanes
# 00133203 
# 23/03/2018

# Proyecto 1: Fibonacci

.data
	prompt: .asciiz "Enter n: "
	message: .asciiz "th fibonacci number is: "

.text
.globl main

main:
	# ajusta el return adress y el stack 
	addi $sp, $sp, -4
    sw $ra, 0($sp)
	
	# pide al usuario ingresar un valor
	li $v0, 4
	la $a0, prompt
	syscall
	
	# obtiene el valor ingresado por el usuario y lo almacena
	li $v0, 5
	syscall
	add $a1, $v0, $zero
	
	# llama a la funcion fibonacci 
	add $a0, $a1, $zero
	jal fib
	add $a2, $v0, $zero
	
	# imprime el valor ingresado por el usuario 
	li $v0, 1
	add $a0, $a1, $zero
	syscall
	
	# imprime el mensaje 
	li $v0, 4
	la $a0, message
	syscall
	
	# imprime el n-esimo termino de la serie de fibonacci
	li $v0, 1
	add $a0, $a2, $zero
	syscall
	
	lw $ra, 0($sp)
    addi $sp, $sp, 4
	
	jr $ra 

fib: 
    addi $sp, $sp, -12 # ajusta el stack para 3 elementos 
    sw $s0, 0($sp) # guarda n - 1
    sw $s1, 4($sp) # guarda n - 2
    sw $ra, 8($sp) # guarda address de retorno

	slti $t0, $a0, 3 # verifica si n < 3
    beq $t0, $zero, RL # si n >= 3 se hace la parte recursiva

    addi $v0, $zero, 1 # return 1
    addi $sp, $sp, 12 # elimina 3 elementos del stack 

    jr $ra # se regresa a la funcion que llamo a fib 

RL: 
	# realiza el proceso recursivo para n-1
    add $s0, $a0, $zero
    addi $a0, $a0, -1
	jal fib
	
	# realiza el proceso recursivo para n-2
    add $s1, $v0, $zero
    addi $a0, $s0, -2
    jal fib
	
	# determina el valor de fibonacci 
	add $v0, $s1, $v0
	
	# restablece los valores
	lw $s0, 0($sp)
    lw $s1, 4($sp)
    lw $ra, 8($sp)
	addi $sp, $sp, 12 # elimina 3 elementos 
	
	# devuelve el control a la funcion que llamo a fib
	jr $ra 