.data 
	array: .space 80
	sizeprompt: .asciiz "Enter Array Size:"
	message: .asciiz "\nThe Number is:"
	arrayprompt: .asciiz "\nArray numbers are: "
	space: .asciiz "   "
	notpolindrome: .asciiz "\nNot Polindrome"
	polin: .asciiz "\nPolindrome"
	
.text

	li $t1,0 #index to keep location of loop
	li $t2,0 # memory adress for add to array

	#prompt the user to enter size
	li $v0, 4
	la $a0, sizeprompt
	syscall
	
	#get the array size
	li $v0,5
	syscall
	
	#store the size in to s1
	move $s1,$v0
	
	#limit the array size if user give more than 20
	bgt $s1,20,notlimited
	li $s1,20
	
	notlimited:	
		mul $t1,$s1,4
	
	loop:
		#loop for take array inputs
		beq $t2,$t1,done
	
	
		#display message 
		li $v0,4
		la $a0,message
		syscall
	
		#get the number
		li $v0,5
		syscall
	
		#add number to array
		sw $v0, array($t2)
	
		#Intex +4
		addi $t2,$t2,4
	
		#terminate the loop
		j loop
	
	#else do nothing
	done:
	
	
	#reset the index for printing
	li $t2,0
	
	
	#display the aaryprompt
	li $v0,4
	la $a0,arrayprompt
	syscall
	
	while:
		beq $t2,$t1,done1
	
		#get the number from array
		lw $t3, array($t2)
		
		#print number
		li $v0,1
		move $a0,$t3
		syscall
			
		#display the space 
		li $v0,4
		la $a0,space
		syscall
		
		#increase location
		addi $t2,$t2,4
	
		#terminate the loop
		j while
	
	
	#else do nothing
	done1:
	
	#prepare for palindrome
	sub $t1,$t1,4
	li $t4,0
			
	
	while1:
	
		#end condition
		beq $t4,$t1,done2
		slt $t0,$t4,$t1
		beq $t0,$0,done2
		
		
		#first and last element of array
		lw $t5, array($t4)
		lw $t6, array($t1)
		
		
		#if first != last
		bne $t5,$t6,notpolind
		
		
		#adjust locations
		addi $t4,$t4,4
		sub $t1,$t1,4
		
		
		j while1
	
	notpolind:
		li $v0,4
		la $a0,notpolindrome
		syscall
		li $v0, 10
		syscall
	
	
	done2:
		li $v0,4
		la $a0,polin
		syscall
		li $v0, 10
		syscall
