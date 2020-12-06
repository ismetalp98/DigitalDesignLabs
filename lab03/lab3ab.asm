.text

main:
	li $v0,4
	la $a0,chooseprogram
	syscall
	
	li $v0,5
	syscall
	
	beq $v0,1,program1
	j program2
	
asktouser:
	
	li $v0,4
	la $a0,askusertocont
	syscall
	li $v0,5
	syscall
		
	bne $v0,0,main
	
	li $v0,10
	syscall
	
	
	
#-------------------------------Program-1-----------------------------------#
	
	
	
program1:
	
	li $v0,4
	la $a0,inputprompt
	syscall
	li $v0,5
	syscall
	
	move $a1,$v0 #input to search
	
	#print input
	li $v0,35
	move $a0,$a1
	syscall
	
	#take key to search
	li $v0,4
	la $a0,keyprompt
	syscall
	li $v0,5
	syscall
	
	#print key
	move $a3,$v0
	li $v0,35
	move $a0,$a3
	syscall

	#take n and print it
	li $v0,4
	la $a0,npromptprogram1
	syscall
	li $v0,5
	syscall
	
	move $a2,$v0 # n
	move $a0,$a3 # key
			# a1 is input 
	
	jal calculate
	
	move $a0,$v0
	li $v0,1
	syscall
	
	j asktouser
	
	
	calculate:
		addi $sp,$sp,-28
		sw $s0,0($sp)
		sw $s1,4($sp)
		sw $s2,8($sp)
		sw $s3,12($sp)
		sw $s4,16($sp)
		sw $s5,20($sp)
		sw $s6,24($sp)
		
		move $s0,$a0 #key
		move $s1,$a1 #number
		move $s2,$a2 #n
		
		li $s4,0 #counter to count matches
		
		li $s6,1
		sllv $s6,$s6,$s2 #2^n to take n bit 
		
		#number of seperated parts (32/n)
		li $s3,32
		div $s3,$s3,$s2
		
		
		iterate:
			beq $s3,$zero,doneprogram1
		
			addi $s3,$s3,-1
		
			#take n bit
			div $s1,$s6
			mfhi $s5
			
			#print first n bit
			li $v0,35
			move $a0,$s5
			syscall
			
			
			bne $s5,$s0,dontincrement #if key and window not matching
			addi $s4,$s4,1
			
			li $v0,4
			la $a0,matches
			syscall
			
			li $v0,4
			la $a0,newline
			syscall
			
			srlv $s1,$s1,$s2 # shift input n bit
			j iterate
			
			
		dontincrement:
			li $v0,4
			la $a0,notmatches
			syscall
			
			li $v0,4
			la $a0,newline
			syscall
			srlv $s1,$s1,$s2
			j iterate
			
		
		doneprogram1:
		
			#print the counter
			li $v0,4
			la $a0,numberofmatches
			syscall
		
			
			move $v0,$s4
			
		
			lw $s0,0($sp)
			lw $s1,4($sp)
			lw $s2,8($sp)
			lw $s3,12($sp)
			lw $s4,16($sp)
			lw $s5,20($sp)
			lw $s6,24($sp)
			addi $sp,$sp,28
			
			jr $ra
	



#--------------------------------Program-2--------------------------------#

	
	
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
		
		jal calculateHelper
		
		#move return value to a0 and print it
		move $a0,$v0
		li $v0,1
		syscall
		
		
		j asktouser
		
		calculateHelper:
			addi $sp,$sp,-12
			sw $ra,0($sp)
			sw $s0,4($sp)
			sw $s1,8($sp)
			
		
			move $s0,$a0
			li $s1,0
		
			calculateSum:
				addi $sp,$sp,-8
				sw $s0,4($sp)
				sw $ra,0($sp)
			
				subi $s0,$s0,1
			
				beq $s0,1,done	
					
				jal calculateSum	
			done:
				add $s1,$s1,$s0
				
				lw $ra,0($sp)
				lw $s0,4($sp)
				addi $sp,$sp,8
				beq $s0,$a0,doneca
				jr $ra
			
		doneca:
			add $s1,$s1,$s0
			
			move $v0,$s1
			
			lw $ra,0($sp)
			lw $s0,4($sp)
			lw $s1,8($sp)
			addi $sp,$sp,12
			jr $ra
			
		
								
	
	
	
	
	

.data

	askusertocont: .asciiz "\nDo you want to continue? Enter 0 to stop."
	newline: .asciiz "\n"
	matches: .asciiz "   -matches"
	notmatches: .asciiz "   -not matches"
	numberofmatches: .asciiz "\n number of matches: "
	
	#program 2 texts
	chooseprogram: .asciiz "Choose which program you want to run (1 for program-1 ,2 for program-2): "
	nprompt:       .asciiz "\n Give n: "
	searchpromt:   .asciiz "\n Give key to count: "	
	
	#program 1 texts
	inputprompt: .asciiz "Give input to search: "
	keyprompt: .asciiz "\nGive key to search: "
	npromptprogram1: .asciiz "\nGive n to divide input: "
	
