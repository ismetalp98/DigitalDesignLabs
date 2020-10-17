.text

	
main:

	#crete array
	jal createPopulateArray	
	
	#transfer array to a1
	move $a1,$v0
	move $a2,$v1
	
	jal printarray
	
	add $sp,$sp,-8
	
	sw $ra,0($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	
	li $v0,4
	la $a0,deltelower
	syscall
	
	li $v0,5
	syscall
	move $s0,$v0
	
	li $v0,4
	la $a0,delteupper
	syscall
	
	li $v0,5
	syscall
	move $s1,$v0
	
	move $a0,$a1
	move $a1,$a2
	move $a2,$s0
	move $a3,$s1
	
	jal compressArray
	
	lw $ra,0($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	add $sp,$sp,8
	
	move $a1,$v0
	move $a2,$v1

	jal printarray

	li $v0,10
	syscall

createPopulateArray:
	
	add $sp,$sp,-24
	
	sw $ra,0($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)
	sw $s3,16($sp)
	sw $a0,20($sp)
	sw $a1,24($sp)

	
	#idle
	li $s2,0
	
	li $v0,4
	la $a0,sizeprompt
	syscall
	
	li $v0,5
	syscall
	move $s1,$v0
	
	mul $a0,$s1,4
	li $v0,9
	syscall
	
	move $s0, $v0
	
	populatearray:
		beq $s1,$s2,finishpopulating
		li $v0,4
		la $a0,message
		syscall
		
		li $v0,5
		syscall
		
		sw $v0,0($s0)	
		add $s0,$s0,4
		add $s2,$s2,1
		j populatearray
		
	finishpopulating:
		mul $s2,$s1,4
		sub $s0,$s0,$s2
		move $v0,$s0
		move $v1,$s1
		
		lw $ra,0($sp)
		lw $s0,4($sp)
		lw $s1,8($sp)
		lw $s2,12($sp)
		lw $s3,16($sp)
		sw $a0,20($sp)
		lw $a1,24($sp)
		
		addi $sp,$sp,24
		
		jr $ra
		
printarray:

	add $sp,$sp,-24
	
	sw $ra,0($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)
	sw $a1,16($sp)
	sw $a2,20($sp)
	sw $a0,24($sp)

	#idle
	li $s2,0
	
	move $s0,$a1
	move $s1,$a2
	
	
	li $v0,4
	la $a0,arrayprompt
	syscall
	
	getthenumbers:
		beq $s2,$s1,finishprinting
		
		lw $a0, 0($s0)
		li $v0,1
		syscall
		
		li $v0,4
		la $a0,space
		syscall
		
		add $s0,$s0,4
		add $s2,$s2,1
		j getthenumbers
		
	finishprinting:
	
		lw $ra,0($sp)
		lw $s0,4($sp)
		lw $s1,8($sp)
		lw $s2,12($sp)
		lw $a1,16($sp)
		lw $a2,20($sp)
		lw $a0,24($sp)
		
		addi $sp,$sp,24
	
		jr $ra
		
		
compressArray:

	add $sp,$sp,-52
	
	sw $ra,0($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)
	sw $s3,16($sp)
	sw $s4,20($sp)
	sw $s5,24($sp)
	sw $s5,28($sp)
	sw $s6,32($sp)
	sw $s7,36($sp)
	sw $a0,40($sp)
	sw $a1,44($sp)
	sw $a2,48($sp)
	sw $a3,52($sp)
	
	move $s0,$a0
	move $s1,$a1
	move $s2,$a2
	move $s3,$a3
	
	mul $a0,$s1,4
	li $v0,9
	syscall
	move $s6,$v0
	
	li $s4,0
	li $s7,0
	
	looptodelete:
		beq $s4,$s1,endloop
		lw $s5,0($s0)
		

		bgt $s5,$s3,addtoarray
		blt $s5,$s2,addtoarray
		
		
		addi $s4,$s4,1
		addi $s0,$s0,4
		j looptodelete	
		
	addtoarray:
		sw $s5,0($s6)
		addi $s7,$s7,1
		addi $s6,$s6,4
		addi $s4,$s4,1
		addi $s0,$s0,4
		j looptodelete	
	
	endloop:
		mul $s1,$s7,4
		sub $s6,$s6,$s1
		move $v0,$s6
		move $v1,$s7
	
		lw $ra,0($sp)
		lw $s0,4($sp)
		lw $s1,8($sp)
		lw $s2,12($sp)
		lw $s3,16($sp)
		lw $s4,20($sp)
		lw $s5,24($sp)
		lw $s5,28($sp)
		lw $s6,32($sp)
		lw $s7,36($sp)
		lw $a0,40($sp)
		lw $a1,44($sp)
		lw $a2,48($sp)
		lw $a3,52($sp)
		add $sp,$sp,52
		jr $ra


.data
    	sizeprompt: .asciiz "\nEnter Array Size: "
    	deltelower: .asciiz "\Enter the beginig of interval: "
    	delteupper: .asciiz "\Enter the end of interval: "
    	message: .asciiz "\nThe Number is: "
    	arrayprompt: .asciiz "\nArray numbers are: "
	newLine:    .asciiz    "\n"
	space: .asciiz "   "
	
