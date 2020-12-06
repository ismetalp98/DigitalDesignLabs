	.text
# CS224 Fall 2020, Program to be used in Lab3
# October 20, 2020
main:
	li $v0,4
	la $a0,chooseprogram
	syscall
	
	li $v0,5
	syscall
	
	beq $v0,3,program3
	beq $v0,4,program4
	j program5
	
asktouser:
	
	li $v0,4
	la $a0,askusertocont
	syscall
	li $v0,5
	syscall
		
	bne $v0,0,main
	
	li $v0,10
	syscall



createLinkedList:
# $a0: No. of nodes to be created
# $v0: returns list head
# Node 1 contains 4 in the data field, node i contains the value 4*i in the data field.
# By 4*i inserting a data value like this
# when we print linked list we can differentiate the node content from the node sequence no (1, 2, ...).
	addi	$sp, $sp, -24
	sw	$s0, 20($sp)
	sw	$s1, 16($sp)
	sw	$s2, 12($sp)
	sw	$s3, 8($sp)
	sw	$s4, 4($sp)
	sw	$ra, 0($sp) 	# Save $ra just in case we may want to call a subprogram
	
	move	$s0, $a0	# $s0: no. of nodes to be created.
	li	$s1, 1		# $s1: Node counter
# Create the first node: header.
# Each node is 8 bytes: link filed thendata field.
	li	$a0, 8
	li	$v0, 9
	syscall
# OK now we have the list head. Save list head pointer 
	move	$s2, $v0	# $s2 points to the first and last node of the linked list.
	move	$s3, $v0	# $s3 now points to the list head.
	
	li $v0,4
	la $a0,elementprompt
	syscall
	li $v0,5
	syscall	
# sll: So that node 1 data value will be 4, node i data value will be 4*i
	sw	$v0, 4($s2)	# Store the data value.
	
addNode:
# Are we done?
# No. of nodes created compared with the number of nodes to be created.
	beq	$s1, $s0, allDone
	addi	$s1, $s1, 1	# Increment node counter.
	li	$a0, 8 		# Remember: Node size is 8 bytes.
	li	$v0, 9
	syscall
# Connect the this node to the lst node pointed by $s2.
	sw	$v0, 0($s2)
# Now make $s2 pointing to the newly created node.
	move	$s2, $v0	# $s2 now points to the new node.
	
	li $v0,4
	la $a0,elementprompt
	syscall
	li $v0,5
	syscall		
# sll: So that node 1 data value will be 4, node i data value will be 4*i
	sw	$v0, 4($s2)	# Store the data value.
	j	addNode
allDone:
# Make sure that the link field of the last node cotains 0.
# The last node is pointed by $s2.
	sw	$zero, 0($s2)
	move	$v0, $s3	# Now $v0 points to the list head ($s3).
	
# Restore the register values
	lw	$ra, 0($sp)
	lw	$s4, 4($sp)
	lw	$s3, 8($sp)
	lw	$s2, 12($sp)
	lw	$s1, 16($sp)
	lw	$s0, 20($sp)
	addi	$sp, $sp, 24
	
	jr	$ra
	
	
	
	
	
printLinkedList:
# Print linked list nodes in the following format
# --------------------------------------
# Node No: xxxx (dec)
# Address of Current Node: xxxx (hex)
# Address of Next Node: xxxx (hex)
# Data Value of Current Node: xxx (dec)
# --------------------------------------

# Save $s registers used
	addi	$sp, $sp, -20
	sw	$s0, 16($sp)
	sw	$s1, 12($sp)
	sw	$s2, 8($sp)
	sw	$s3, 4($sp)
	sw	$ra, 0($sp) 	# Save $ra just in case we may want to call a subprogram

# $v0: points to the linked list.
# $s0: Address of current
# s1: Address of next
# $2: Data of current
# $s3: Node counter: 1, 2, ...
	move $s0, $a0	# $s0: points to the current node.
	li   $s3, 0
printNextNode:
	beq	$s0, $zero, printedAll
			
	                 	# $s0: Address of current node
	lw	$s1, 0($s0)	# $s1: Address of  next node
	lw	$s2, 4($s0)	# $s2: Data of current node
	addi	$s3, $s3, 1
# $s0: address of current node: print in hex.
# $s1: address of next node: print in hex.
# $s2: data field value of current node: print in decimal.
	la	$a0, line
	li	$v0, 4
	syscall		# Print line seperator
	
	la	$a0, nodeNumberLabel
	li	$v0, 4
	syscall
	
	move	$a0, $s3	# $s0: Node number (position) of current node
	li	$v0, 1
	syscall
	
	la	$a0, addressOfCurrentNodeLabel
	li	$v0, 4
	syscall
	
	move	$a0, $s0	# $s0: Address of current node
	li	$v0, 34
	syscall

	la	$a0, addressOfNextNodeLabel
	li	$v0, 4
	syscall
	move	$a0, $s1	# $s0: Address of next node
	li	$v0, 34
	syscall	
	
	la	$a0, dataValueOfCurrentNode
	li	$v0, 4
	syscall
		
	move	$a0, $s2	# $s2: Data of current node
	li	$v0, 1		
	syscall	

# Now consider next node.
	move $s0,$s1	# Consider next node.
	j	printNextNode
printedAll:
# Restore the register values
	lw	$ra, 0($sp)
	lw	$s3, 4($sp)
	lw	$s2, 8($sp)
	lw	$s1, 12($sp)
	lw	$s0, 16($sp)
	addi	$sp, $sp, 20
	jr	$ra
	
	
	
	
	
	
	
	
	
	
#-------------------------- Program-3----------------------------#	

program3:

	li $v0,4
	la $a0,sizeprompt
	syscall
	li $v0,5
	syscall
	
	move	$a0, $v0
	jal	createLinkedList
	
	move $a0,$v0
	jal printLinkedListReverse  #-------------------------- breakpoint----------------------------#
	
	j asktouser
	

	
#=========================================================
printLinkedListReverse:
# Print linked list nodes in the following format
# --------------------------------------
# Node No: xxxx (dec)
# Address of Current Node: xxxx (hex)
# Address of Next Node: xxxx (hex)
# Data Value of Current Node: xxx (dec)
# --------------------------------------

# Save $s registers used
	addi	$sp, $sp, -24
	sw	$s4, 20($sp)
	sw	$s0, 16($sp)
	sw	$s1, 12($sp)
	sw	$s2, 8($sp)
	sw	$s3, 4($sp)
	sw	$ra, 0($sp) 	# Save $ra just in case we may want to call a subprogram

# $v0: points to the linked list.
# $s0: Address of current
# s1: Address of next
# $2: Data of current
# $s3: Node counter: 1, 2, ...
	move 	$s0, $a0	# $s0: points to the current node.
	move	$s1, $s0
	move	$s4, $s0
	li   $s3, 0
	
	
	
printPrevNode:
	addi	$sp, $sp, -20
	sw	$s0, 16($sp)
	sw	$s1, 12($sp)
	sw	$s2, 8($sp)
	sw	$s3, 4($sp)
	sw	$ra, 0($sp)
	 
	
	move 	$s0,$s1
	addi	$s3, $s3, 1
	
	lw	$s2, 4($s0)	        # $s0: Address of current node
	lw	$s1, 0($s0)		# $s1: Address of  next node
	beq	$s1, $zero, printRecursion		# $s2: Data of current node
	
	jal	printPrevNode
# $s0: address of current node: print in hex.
# $s1: address of next node: print in hex.
# $s2: data field value of current node: print in decimal.
	printRecursion:
	la	$a0, line
	li	$v0, 4
	syscall		# Print line seperator
	
	la	$a0, nodeNumberLabel
	li	$v0, 4
	syscall
	
	move	$a0, $s3	# $s0: Node number (position) of current node
	li	$v0, 1
	syscall
	
	la	$a0, addressOfCurrentNodeLabel
	li	$v0, 4
	syscall
	
	move	$a0, $s0	# $s0: Address of current node
	li	$v0, 34
	syscall

	la	$a0, addressOfNextNodeLabel
	li	$v0, 4
	syscall
	move	$a0, $s1	# $s0: Address of next node
	li	$v0, 34
	syscall	
	
	la	$a0, dataValueOfCurrentNode
	li	$v0, 4
	syscall
		
	move	$a0, $s2	# $s2: Data of current node
	li	$v0, 1		
	syscall	

	lw	$ra, 0($sp)
	lw	$s3, 4($sp)
	lw	$s2, 8($sp)
	lw	$s1, 12($sp)
	lw	$s0, 16($sp)
	addi	$sp, $sp, 20
	beq     $s4,$s1,doneReversePrinting
	jr	$ra
	
	doneReversePrinting:
		lw	$ra, 0($sp)
		lw	$s3, 4($sp)
		lw	$s2, 8($sp)
		lw	$s1, 12($sp)
		lw	$s0, 16($sp)
		lw   	$s4, 20($sp)
		addi	$sp, $sp, 24
		jr	$ra

	
	
	
	
	
	
#----------------------------Program-4--------------------------#

program4:


	li $v0,4
	la $a0,sizeprompt
	syscall
	li $v0,5
	syscall
	
	move	$a0, $v0
	move	$a1,$v0
	jal	createLinkedList

	move $a0,$v0
	move $a2,$v0
	jal printLinkedList
	
	li $v0,4
	la $a0,newlist
	syscall
	
	move $a0,$a2
	jal copyLinkedListIterative
	
	move $a0,$v0
	
	jal printLinkedList
	
	j asktouser
	
copyLinkedListIterative:
	
	addi	$sp, $sp, -24
	sw	$s0, 20($sp)
	sw	$s1, 16($sp)
	sw	$s2, 12($sp)
	sw	$s3, 8($sp)
	sw	$s4, 4($sp)
	sw	$ra, 0($sp) 	
	
	move	$s0, $a0	# $s0: original array
	li	$s1, 1		# $s1: Node counter
# Create the first node: header.
# Each node is 8 bytes: link filed thendata field.
	li	$a0, 8
	li	$v0, 9
	syscall


	move	$s2, $v0	
	move	$s3, $v0

	lw      $s4,4($s0)  #copy first data
	sw	$s4, 4($s2)	
	
copyNodeIterative:
	beq	$s1, $a1, doneCopyIterative
	
	addi	$s1, $s1, 1	# Increment node counter.
	li	$a0, 8 		# Remember: Node size is 8 bytes.
	li	$v0, 9
	syscall
# Connect the this node to the lst node pointed by $s2.
	sw	$v0, 0($s2)
# Now make $s2 pointing to the newly created node.
	move	$s2, $v0	# $s2 now points to the new node.
	
	#copy data
	lw      $s0,0($s0)
	lw      $s4,4($s0)
		
	sw	$s4, 4($s2)	# Store the data value.
	j	copyNodeIterative
doneCopyIterative:
# Make sure that the link field of the last node cotains 0.
# The last node is pointed by $s2.
	sw	$zero, 0($s2)
	move	$v0, $s3	# Now $v0 points to the list head ($s3).
	
# Restore the register values
	lw	$ra, 0($sp)
	lw	$s4, 4($sp)
	lw	$s3, 8($sp)
	lw	$s2, 12($sp)
	lw	$s1, 16($sp)
	lw	$s0, 20($sp)
	addi	$sp, $sp, 24
	
	jr	$ra	
	
	
	
	

#------------------------------Program-5---------------------------#

program5:


	li $v0,4
	la $a0,sizeprompt
	syscall
	li $v0,5
	syscall
	
	move	$a0, $v0
	move	$a1,$v0
	jal	createLinkedList
	
	move $a0,$v0
	move $a2,$v0
	jal printLinkedList
	
	li $v0,4
	la $a0,newlist
	syscall
	
	move $a0,$a2
	jal copyLinkedListRecursive
	
	move $a0,$v0
	jal printLinkedList
	
	j asktouser

copyLinkedListRecursive:
	
	addi	$sp, $sp, -24
	sw	$s0, 20($sp)
	sw	$s1, 16($sp)
	sw	$s2, 12($sp)
	sw	$s3, 8($sp)
	sw	$s4, 4($sp)
	sw	$ra, 0($sp) 	
	
	move	$s0, $a0	# $s0: original array
	li	$s1, 1		# $s1: Node counter
# Create the first node: header.
# Each node is 8 bytes: link filed thendata field.
	li	$a0, 8
	li	$v0, 9
	syscall


	move	$s2, $v0	
	move	$s3, $v0

	lw      $s4,4($s0)  #copy first data
	sw	$s4, 4($s2)
	
copyNodeRecursive:
	addi	$sp, $sp, -20
	sw	$s0, 16($sp)
	sw	$s1, 12($sp)
	sw	$s2, 8($sp)
	sw	$s4, 4($sp)
	sw	$ra, 0($sp) 
	
	
	beq	$s1, $a1, doneCopyRecursive
	
	addi	$s1, $s1, 1	# Increment node counter.
	li	$a0, 8 		# Remember: Node size is 8 bytes.
	li	$v0, 9
	syscall
# Connect the this node to the lst node pointed by $s2.
	sw	$v0, 0($s2)
# Now make $s2 pointing to the newly created node.
	move	$s2, $v0	# $s2 now points to the new node.
	
	#copy data
	lw      $s0,0($s0)
	lw      $s4,4($s0)
		
	
	jal	copyNodeRecursive
	
doneCopyRecursive:
	bne	$s1, $a1, finish
	sw	$zero, 0($s2)
	move	$v0, $s3
finish:
	sw	$s4, 4($s2)	# Store the data value.
	
	lw	$ra, 0($sp)
	lw	$s4, 4($sp)
	lw	$s2, 8($sp)
	lw	$s1, 12($sp)
	lw	$s0, 16($sp)
	addi	$sp, $sp, 20
	beq	$s1, 1, done
	jr	$ra	
done:
# Make sure that the link field of the last node cotains 0.
# The last node is pointed by $s2.
		# Now $v0 points to the list head ($s3).
	
# Restore the register values
	lw	$ra, 0($sp)
	lw	$s4, 4($sp)
	lw	$s3, 8($sp)
	lw	$s2, 12($sp)
	lw	$s1, 16($sp)
	lw	$s0, 20($sp)
	addi	$sp, $sp, 24
	
	jr	$ra		
	
	
	
	
	
	
	
	
	
#=========================================================		
	.data
line:	.asciiz "\n -------------------------------------- "

nodeNumberLabel:
	.asciiz	"\n Node No.: "
	
addressOfCurrentNodeLabel:
	.asciiz	"\n Address of Current Node: "
	
addressOfNextNodeLabel:
	.asciiz	"\n Address of Next Node: "
	
dataValueOfCurrentNode:
	.asciiz	"\n Data Value of Current Node: "
	
sizeprompt: .asciiz "\nEnter the size of list: "

elementprompt: .asciiz "\nEnter the new element: "

askusertocont: .asciiz "\n\nDo you want to continue? Enter 0 to stop.: "

chooseprogram: .asciiz "\nChoose which program you want to run (3 for program-3 ,4 for program-4 ,5 for program-5): "

originallist: .asciiz "\nOriginal list is: \n"

newlist: .asciiz "\n\nNew list is: \n"
