# Part 3
# The main program receives the array beginning address and array size, respectively, 
# in $v0 and $v1 and invokes CheckSymmetric, FindMinMax and outputs their results with proper output messages.
# Provide a simple user interface where appropriate.
# Deniz Semih Özal
	.text
	.globl __start
__start:
	
	jal getArray
	
	add $t0, $zero, $v0 #base address
	add $t1, $zero, $v1 #array size
	
	la $a0, endl
	li $v0, 4
	syscall
	
	
	la $a0, symmetricOrNot
	li $v0, 4
	syscall
	
	add $v0, $zero, $t0 #base address
	add $v1, $zero, $t1 #array size
	
	jal checkSymmetric
		
	la $a0, ($v0)
	li $v0, 1
	syscall
	
	la $a0, endl
	li $v0, 4
	syscall
	
	add $v0, $zero, $t0 #base address
	add $v1, $zero, $t1 #array size
	
	jal findMinMax
	
	add $t0, $zero, $v0 #min
	add $t1, $zero, $v1 #max
	
	la $a0, minimum
	li $v0, 4
	syscall
	
	add $v0, $zero, $t0 #min
	
	la $a0, ($v0)
	li $v0, 1
	syscall
	
	la $a0, endl
	li $v0, 4
	syscall
	
	la $a0, maximum
	li $v0, 4
	syscall
	
	add $v1, $zero, $t1 #max
	
	la $a0, ($v1)
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	
getArray:
	addi $sp, $sp , -16 # make room for 2 items
	sw $s3, 12($sp) # push $s
	sw $s2, 8($sp) # push $s
	sw $s1, 4($sp) # push $s
	sw $s0, 0($sp) # push $
	
	la $a0, getArraySize
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	move $s0, $v0 # $s0 = arraysize
	sll $s1, $s0, 2 # $s1 = arraysize * 4
	add $a0, $zero, $s1 # The byte size of the memory location to be allocated
	li $v0, 9 # used for dynamic storage allocation
	syscall 
	
	add $s1, $zero, $v0 # $s1 points the beginning of the array
	
	la $a0, getArrayElements
	li $v0, 4
	syscall
	
	addi $s2, $zero, 0
	
	loop3:
		slt $s3, $s2, $s0 # i < arraysize
		beq $s3, $zero, quit
		sll $s3, $s2, 2 # i * 4
		add $s3, $s3, $s1 # base address + offset
		li $v0, 5
		syscall # getting element
		sw $v0, 0($s3) # store element into the array
		addi $s2, $s2, 1 # i = i + 1
		j 	loop3
	quit:
		add $v0, $zero, $s1 # v0 = base address
		add $v1, $zero, $s0 # v1 = arraysize
		addi $sp, $sp , 16 # make room for 2 items
		lw $s3, 12($sp) # push $s
		lw $s2, 8($sp) # push $s
		lw $s1, 4($sp) # push $s
		lw $s0, 0($sp) # push $
		addi $sp, $sp , 4 # make room for 2 items
		sw $ra, 0($sp)
		jal 	printArray
		lw $ra, 0($sp)
		addi $sp, $sp , -4 # make room for 2 items
		jr	$ra
		
	
printArray:
	la $a0, ($v0) # base address of an array
	add $a1, $zero, $v1 # arraysize
	addi $sp, $sp , -20 # make room for 2 item
	sw $s0, 16($sp)
	sw $s1, 12($sp) # push $s0
	sw $s2, 8($sp) # push $s1
	sw $s3, 4($sp) # push $s2
	sw $s4, 0($sp) # push $s3
	addi $s0, $zero, 0
	addi $s1, $a1, 0
	la $s4, ($a0)
	la $a0, arrayContent
	li $v0, 4
	syscall
	loop:
		slt $s2, $s0, $a1
		beq $s2, $0, done
		sll $s2, $s0, 2
		add $s2, $s2, $s4
		lw $s3, 0($s2)
		
		
		la $a0 ($s3)
		li $v0, 1
		syscall
		
		la $a0, space
		li $v0, 4
		syscall 
		
		addi $s0, $s0, 1
		j 	loop
	done:
		move $v0, $s4
		addi $sp, $sp , 20 # make room for 2 items
		lw $s0, 16($sp)
		lw $s1, 12($sp) # push $s1
		lw $s2, 8($sp) # push $s2
		lw $s3, 4($sp) # push $s3
		lw $s4, 0($sp) # push $s4
		jr $ra
		
checkSymmetric:
	la $a0, ($v0) # base address of an array
	add $a1, $zero, $v1 # arraysize
	
	addi $sp, $sp, -24
	sw $s0, 20($sp)
	sw $s1, 16($sp)
	sw $s2, 12($sp)
	sw $s3, 8($sp)
	sw $s4, 4($sp)
	sw $s5, 0($sp)
	

	addi $s0, $a1, -1 # arraysize - 1
	la $s1, ($a0)  # copy base address
	addi $s3, $zero, 0 # i = 0
	sra $s5, $a1, 1 # arraysize / 2
	
	loop1:
		slt $s2, $s3, $s5 # i < arraysize
		beq $s2, $zero, symmetric
		sll $s2, $s3, 2 # i * 4
		add $s2, $s2, $s1 # address of array[i]
		lw  $s2, 0($s2) # $s2 = array[i]
		sll $s4, $s0, 2 # (arrsize - 1) * 4
		add $s4, $s4, $s1 # address of array[arraysize-1]
		lw $s4, 0($s4) # $s4 = array[arraysize - 1]
		bne $s2, $s4, not_symmetric
		addi $s3, $s3, 1 # i = i +1
		addi $s0, $s0, -1 # arraysize = arraysize - 1
		j	loop1
	symmetric:
		addi $v0, $zero, 1
		lw $s0, 20($sp)
		lw $s1, 16($sp)
		lw $s2, 12($sp)
		lw $s3, 8($sp)
		lw $s4, 4($sp)
		lw $s5, 0($sp)
		addi $sp, $sp, 24
		jr $ra
	not_symmetric:
		addi $v0, $zero, 0
		lw $s0, 20($sp)
		lw $s1, 16($sp)
		lw $s2, 12($sp)
		lw $s3, 8($sp)
		lw $s4, 4($sp)
		lw $s5, 0($sp)
		addi $sp, $sp, 24
		jr $ra

findMinMax:
	la $a0, ($v0) # base address of an array
	add $a1, $zero, $v1 # arraysize
	
	addi $sp, $sp, -20
	sw $ra, 16($sp)
	sw $s0, 12($sp)
	sw $s1, 8($sp)
	sw $s2, 4($sp)
	sw $s3, 0($sp)
	lw $s0, 0($a0) # min = arr[0] 
	lw $s1, 0($a0) # max = arr[1]
	addi $s2, $zero, 0 # i = 0
	loop2:
		slt $s3, $s2, $a1 # i < arraysize
		beq $s3, $zero, exit
		sll $s3, $s2, 2 # i * 4
		add $s3, $s3, $a0 # address of array[i]
		lw $s3, 0($s3)# $s3 = array[i]
		
		blt $s3, $s0, min # if ( arr[i] < min)
	back1:
		bgt $s3, $s1, max # if ( arr[i] > max)
	back2:
		addi $s2, $s2, 1
		j 	loop2
		
		
	min:	
		move $s0, $s3 # min = arr[i]
		j 	back1
		
	max: 	
		move $s1, $s3 # max = arr[i]
		j 	back2
	exit:	
		add $v0, $zero, $s0 # return min
		add $v1, $zero, $s1 # return max
		sw $ra, 16($sp)
		sw $s0, 12($sp)
		sw $s1, 8($sp)
		sw $s2, 4($sp)
		sw $s3, 0($sp)
		addi $sp, $sp, 20
		jr 	$ra
	.data
array: .word 10, 20, 30
arrsize: .word 3
getArraySize: .asciiz "Please enter the size of an array\n"
getArrayElements: .asciiz "Please enter the elements of an array respectively\n"
arrayContent: .asciiz "Array: "
symmetricOrNot: .asciiz "If symmetric 1, else 0: "
minimum: .asciiz "Minimum: "
maximum: .asciiz "Maximum: "
space: .asciiz " "
endl: .asciiz "\n"
