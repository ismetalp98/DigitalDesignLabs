.text
	
	jal input
	jal print
	
	#end of the code
	li $v0, 10
 	syscall
 	
calculate:

	#transfer parametres to temp registers
	lw $t0,b
	lw $t1,c
	lw $t2,d
			
			
	mul $t3,$t0,$t1 #B*C
	sub $t4,$t2,$t1 #C-D
	div $t4,$t0
	
	mfhi $t4
	
	
	bgtz $t4,cont #if mode result positive continue
	bltz $t0,minmod  #if mod negative

	add $t4,$t4,$t0 #if mod result negative
	j cont
	
	minmod:
	sub $t4,$t4,$t0
	j cont
	
	cont:
	div $t4,$t4,$t1
	mfhi $t5
	add $t3,$t3,$t4
	
	jr $ra
		
input:

	
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

print:

	#print the result
	move $a0,$t3
	li $v0,1
	syscall

	#if reminde zero dont print and if reminder less than zero adjust somethings
	#beqz $t5,dontprint
	#bltz $t1,printnegative
	
	
	#li $v0,4
	#la $a0,addition
	#syscall
	

	#print the reminder
	#move $a0,$t5
	#li $v0,1
	#syscall
	
	#li $v0,4
	#la $a0,division
	#syscall
	
	#print the divider
	#move $a0,$t1
	#li $v0,1
	#syscall
	
	jr $ra
	
dontprint:
	jr $ra
	
printnegative:	

	li $v0,4
	la $a0,substruction
	syscall
	
	#print the reminder
	move $a0,$t5
	li $v0,1
	syscall
	
	li $v0,4
	la $a0,division
	syscall
	
	#make divider positive
	sub $t2,$t1,$t1
	sub $t2,$t2,$t1
	
	#print the reminder
	move $a0,$t2
	li $v0,1
	syscall
	
	jr $ra

.data
a: .word 0
b: .word 0
c: .word 0
d: .word 0

numberb: .asciiz "\The number b is: "
numberc: .asciiz "\The number c is: "
numberd: .asciiz "\The number d is: "
division: .asciiz "/"
addition: .asciiz " + "
substruction: .asciiz " - "
