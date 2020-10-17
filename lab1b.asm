.text
	
	jal input
	
	
	#print the result
	move $a0,$v0
	li $v0,1
	syscall
	
	
	
	#end of the code
	li	$v0, 10
 	syscall
 	
calculate:

	#transfer parametres to temp registers
	lw $t0,a
	lw $t1,b
	lw $t2,c
	lw $t3,d
	
	
	#calculations
	sub $t4,$t1,$t2
	mul $t5,$t0,$t4
	div $t6,$t5,$t3
	
	mfhi $v0
	
	#if remaining is negative turn it to positive
	bltz $v0,makeitpositive
	
	jr $ra
	
makeitpositive:
	add $v0,$v0,$t3
	jr $ra
	
input:

	#get the user inputs
	li $v0,4
	la $a0,numbera
	syscall
	
	
	li $v0,5
	syscall
	sw $v0, a
	
	#get the user inputs
	li $v0,4
	la $a0,numberb
	syscall
	
	li $v0,5
	syscall
	sw $v0, b
	
	#get the user inputs
	li $v0,4
	la $a0,numberc
	syscall
	
	li $v0,5
	syscall
	sw $v0, c
	
	#get the user inputs
	li $v0,4
	la $a0,numberd
	syscall
	
	li $v0,5
	syscall
	sw $v0, d

	#jump calculation function
	j calculate

.data
a: .word 0
b: .word 0
c: .word 0
d: .word 0

numbera: .asciiz "\The number a is: "
numberb: .asciiz "\The number b is: "
numberc: .asciiz "\The number c is: "
numberd: .asciiz "\The number d is: "