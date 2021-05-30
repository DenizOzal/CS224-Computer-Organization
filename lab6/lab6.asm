# Matrix Problem
	.text
	.globl __main
__main:
	la $a0, matrixSize # Ask matrix size to the user
	li $v0, 4
	syscall
	
	li $v0, 5 # Getting dimension N from the user
	syscall
	addi $a2, $v0, 0 # $a2 = Dimension
	
	beq $v0, $0, end # if dimension is 0 exit from program
	
	mul $t1, $a2, $a2 # Matrix size = N x N
	mflo $t1
	
	la $a0, ($t1) # Base address of matrix
	li $v0, 9 # Allocating desired memory in the heap
	syscall
	addi $a1, $v0, 0 # $a1 = Base address

	
	addi $t3, $0, 1 # Counter for value begins from 1
	addi $t2, $0, 0 # Counter for loop begins fom 0
	loop_main:
		slt $t4, $t2, $t1 # i < matrix size
		beq $t4, $0, done_main
		sll $t4, $t2, 2 # i * 4
		add $t4, $t4, $a1 # base address + offset
		sw  $t3, 0($t4) # Counter from 1 to matrix size
		addi $t2, $t2, 1 # i++
		addi $t3, $t3, 1 # value++
		j 	loop_main
	done_main:
	#jal     displayValue  # Displaying the spesicified value
	
	#la $a0, space
	#li $v0, 4
	#syscall
	
	#jal 	rowAverage    # Displaying row average
	
	#la $a0, space
	#li $v0, 4
	#syscall
	
	jal	columnAverage # Displaying column average
	
	li $v0, 10 # Program end
		syscall
	end:
		la $a0, error
		li $v0, 4
		syscall
		
		li $v0, 10 # Program end
		syscall
	
	
displayValue:
	addi $sp, $sp , -24 # make room for 2 items
	sw $ra, 20($sp)
	sw $s4, 16($sp)
	sw $s3, 12($sp) 
	sw $s2, 8($sp)
	sw $s1, 4($sp) 
	sw $s0, 0($sp)
	
	la $a0, row # Asking row to user
	li $v0, 4
	syscall
	
	li $v0, 5 # Read row from user
	syscall
	addi $s0, $v0, 0 # $s0 = row (i)
	move $s3, $s0 # $s3 = row (i)
	
	la $a0, col # Asking column to user
	li $v0, 4
	syscall
	
	li $v0, 5 # Read column from user
	syscall
	addi $s1, $v0, 0 # $s1 = column (j)
	move $s4, $s1 # $s4 = column (j)
	
	addi $s0, $s0, -1 # i - 1
	mul $s0, $s0, $a2 # (i - 1) x N
	mflo $s0
	sll $s0, $s0, 2 # (i - 1) x N x 4
	
	addi $s1, $s1, -1 # j - 1
	sll $s1, $s1, 2 # (j - 1) x 4
	
	add $s2, $s0, $s1 # (i - 1) x N x 4 + (j - 1) x 4
	
	add $s2, $s2, $a1 # address of desired element
	lw  $s2, ($s2) # loading desired element
	
	la $a0, spesicifiedValue
	li $v0, 4
	syscall 
	
	la $a0, open
	li $v0, 4
	syscall 
	
	la $a0, ($s3)
	li $v0, 1
	syscall
	
	la $a0, comma
	li $v0, 4
	syscall
	
	la $a0, ($s4)
	li $v0, 1
	syscall
	
	la $a0, close
	li $v0, 4
	syscall

	la $a0, ($s2) # Printing value in desired element
	li $v0, 1
	syscall
	
	lw $s0, 0($sp)
	lw $s1, 4($sp) 
	lw $s2, 8($sp)
	lw $s3, 12($sp) 
	lw $s4, 16($sp)
	lw $ra, 20($sp)
	addi $sp, $sp , 24 
	jr	$ra
rowAverage:
	addi $sp, $sp , -24
	sw $ra, 20($sp)
	sw $s4, 16($sp)
	sw $s3, 12($sp) 
	sw $s2, 8($sp)
	sw $s1, 4($sp) 
	sw $s0, 0($sp)
	
	la $a0, row_Average # Displaying row average
	li $v0, 4
	syscall
	
	mul $s0, $a2, $a2 # N X N = matrix size
	mflo $s0
	addi $s3, $0, 0 # counter
	addi $s4, $0, 0 # sum
	loop_row:
		sle $s2, $s1, $s0 # i < matrix size
		beq $s2, $0, done_row
		sll $s2, $s1, 2 # i * 4
		add $s2, $s2, $a1 # base address + offset
		if: 	beq $s3, $a2, exit # if counter == column number
			lw  $s2, ($s2) # loading value
			add $s4, $s4, $s2 # sum += value
			addi $s3, $s3, 1 # counter++
		addi $s1, $s1, 1 # i++
		j 	loop_row
		
	exit: 
		div  $s4, $a2 # sum / column number
		mflo $s4 #quotient
		
		#la $a0, space
		#li $v0, 4
		#syscall
		
		addi $s3, $0, 0 # set counter to 0
		add $a3, $a3, $s4
		addi $s4, $0, 0 # set sum to 0
		j	loop_row
	done_row:
		div  $a3, $a2 # sum / column number
		mflo $a3 #quotient
		la $a0, ($a3) # print row average
		li $v0, 1
		syscall
		lw $s0, 0($sp)
		lw $s1, 4($sp) 
		lw $s2, 8($sp)
		lw $s3, 12($sp) 
		lw $s4, 16($sp)
		lw $ra, 20($sp)
		addi $sp, $sp , 24
		jr 	$ra
columnAverage:
	addi $sp, $sp, -36
	sw $ra, 32($sp)
	sw $s7, 28($sp)
	sw $s6, 24($sp)
	sw $s5, 20($sp)
	sw $s4, 16($sp)
	sw $s3, 12($sp) 
	sw $s2, 8($sp)
	sw $s1, 4($sp) 
	sw $s0, 0($sp)
	
	la $a0, col_Average # Displaying row average
	li $v0, 4
	syscall
	
	mul $s0, $a2, $a2 # N X N = matrix size
	mflo $s0
	addi $s3, $0, 0 # counter
	addi $s4, $0, 0 # sum
	addi $s7, $0, 4 # offset
	mul $s7, $s7, $a2 # offset x dimension
	mflo $s7
	outer_loop:
		slt $s2, $s1, $a2 # i < column number
		beq $s2, $0, done_outer
		sll $s2, $s1, 2 # i * 4
		add $s2, $s2, $a1 # base address + offset
		inner_loop:
			slt $s5, $s6, $a2 # j < row number
			beq $s5, $0, done_inner
			mul $s5, $s6, $s7 # j * ( offset x dimension)
			mflo $s5
			add $s5, $s5, $s2 # base address + offset
			lw  $s5, ($s5) # loading value
			add $s4, $s4, $s5 # sum += value
			addi $s6, $s6, 1 # j++
			j	inner_loop
		done_inner:
		div  $s4, $s4, $a2 # sum / row number
		mflo $s4 # quotient
		
		
		#syscall
		
		#la $a0, space
		#li $v0, 4
		#syscall
		
		addi $s1, $s1, 1 # i++
		add $a3, $a3, $s4
		addi $s4, $0, 0 # set sum to 0
		addi $s6, $0 , 0 # set j to 0
		j 	outer_loop
	done_outer:
		div  $a3, $a3, $a2 # sum / row number
		mflo $a3 # quotient
		la $a0, ($a3)
		li $v0, 1
		syscall
		sw $s0, 0($sp)
		sw $s1, 4($sp) 
		sw $s2, 8($sp)
		sw $s3, 12($sp) 
		sw $s4, 16($sp)
		sw $s5, 20($sp)
		sw $s6, 24($sp)
		sw $s7, 28($sp)
		sw $ra, 32($sp)
		addi $sp, $sp, 36
		jr 	$ra
	.data
error: .asciiz "Error...Dimension must be greater than 0! "
matrixSize: .asciiz "Please enter the dimension of matrix: "
spesicifiedValue: .asciiz "Value at "
open: .asciiz "("
close: .asciiz "): "
comma: .asciiz ","
row: .asciiz "Enter row number please: "
col: .asciiz "Enter column number please: "
row_Average: .asciiz "\nAverage of matrix row by row: "
col_Average: .asciiz "\nAverage of matrix col by col: "
endl: .asciiz "\n"
space: .asciiz " "

	
