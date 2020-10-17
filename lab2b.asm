.text
	
		#prompt the user to enter size
		li $v0, 4
		la $a0, sizeprompt
		syscall
	
		#get the array size
		li $v0,5
		syscall
	
		#store the size in to s1
		move $s1,$v0
		
		#prompt the user to enter location to calc freq
		li $v0, 4
		la $a0, freqprompt
		syscall
	
		#get the location
		li $v0,5
		syscall
	
		#store the location in to s3
		move $a2,$v0
		
		
		
		jal createPopulateArray
		jal printarray
		
		#mul $t1,$s1,4
		#sub $sp, $sp, $t1
		#move $a0,$s0
		
	
		jal countFrequency
		
		jal checkdPalinrome
		
		#print number
		li $v0,1
		move $a0,$s5
		syscall
		
		j exit
		
createPopulateArray:

		# Dynamic Storage Allocation
		mul $a0,$s1,4
		li    $v0, 9
		syscall
		move $s0,$v0
		
		

	getthenumbers:
	
		#display message 
		li $v0,4
		la $a0,message
		syscall
	
		#get the number
		li $v0,5
		syscall
		
		bne $s2,$a2,continueloop
		move $s4,$v0
	
		continueloop:
		
		#add number to array
		sw $v0, 0($s0)
	
		#Intex +4
		addi $s0,$s0,4
	
		addi $s2,$s2,1
		
		#loop for take array inputs
		bne $s2,$s1,getthenumbers
		
	
	li $v0,4
	la $a0,arrayprompt
	syscall
	
	mul $s2,$s1,4
	sub $s0,$s0,$s2
	li $s2,0

	jr $ra
	
printarray:	
		#get the number from array
		lw $s3, 0($s0)
		
		#print number
		li $v0,1
		move $a0,$s3
		syscall
			
		#display the space 
		li $v0,4
		la $a0,space
		syscall
	
		#Intex +4
		addi $s0,$s0,4
		
		addi $s2,$s2,1	
		
		bne $s1,$s2,printarray
		
		mul $s2,$s1,4
		sub $s0,$s0,$s2
		
		li $s2,0
		
		jr $ra
		
countFrequency:
		cq:
		#get the number from array
		lw $s3, 0($s0)
		
		
		#Intex +4
		addi $s0,$0,4
		
		addi $s2,$s2,1	
		
		bne $s1,$s2,cq
		
		mul $s2,$s1,4
		sub $s0,$s0,$s2
		
		li $s2,0
		
		jr $ra

		
	        	
checkdPalinrome:
		subi $s2,$s0,4
		mul $s3,$s1,4
		sub $s0,$s0,$s3
		
		
check:
		
		lw $s3, 0($s0)
		lw $s4, 0($s2)
			
		bne $s3,$s4,notpalind
		
		subi $s2,$s2,4
		addi $s0,$s0,4
		
		addi $s5,$s5,1
		bne $s5,$s1,check
		
palind:
		li $v0,4
		la $a0,polin
		syscall
		
		jr $ra
		
notpalind:
		li $v0,4
		la $a0,notpolindrome
		syscall
		
		jr $ra
	
	
	
exit:
	# Stop execution   
    	li    $v0, 10
    	syscall
    
    	
    
    
    
 .data
    	sizeprompt: .asciiz "Enter Array Size: "
    	freqprompt: .asciiz "Enter freq: "
    	message: .asciiz "\nThe Number is: "
    	arrayprompt: .asciiz "\nArray numbers are: "
	newLine:    .asciiz    "\n"
	space: .asciiz "   "
	
	notpolindrome: .asciiz "\nNot Polindrome"
	polin: .asciiz "\nPolindrome"
