.text

	li $v0,4
	la $a0,chooseprogram
	syscall
	
	li $v0,5
	syscall
	
	beq $v0,1,program1
	j program2
	
	
	program1:
	
	# a0 input to search
	# a1 key to search
	# a2 n
	
		# take input n
		li $v0,4
		la $a0, nprompt
		syscall
		
		li $v0,5
		syscall
		move $a2,$v0
		
		#take input key
		li $v0,4
		la $a0, searchpromt
		syscall
		
		li $v0,5
		syscall
		
		
		addi $a0,$0,10000111101101000101000101101000
		
		li $v0,35
		move $a0,$a1
		syscall

	
	
	program2:
		
		# print n prompt
		li $v0,4
		la $a0, nprompt
		syscall
		
		#take input n
		li $v0,5
		syscall
		
		#move n to a0
		move $a0,$v0
		
		#load a0 = 0 #my sum
		li $a1,0
		
		jal calculateSum
		
		#move return value to a0 and print it
		move $a0,$v0
		li $v0,1
		syscall
		
		
		li $v0,10
		syscall
		
		
		calculateSum:
			beq $a0,$zero,done
			addi $sp,$sp,-4
			sw $ra,0($sp)
				
			add $a1,$a1,$a0
			subi $a0,$a0,1
					
			jal calculateSum	
		done:
			move $v0,$a1
			
			lw $ra,0($sp)
			addi $sp,$sp,4
			jr $ra
			
		
								
	
	
	
	
	

.data
	
	chooseprogram: .asciiz "Choose which program you want to run (1 for program-1 ,2 for program-2): "
	nprompt:       .asciiz "\n Give n: "
	searchpromt:   .asciiz "\n Give key to count: "	
