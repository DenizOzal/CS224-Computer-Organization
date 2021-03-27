# Part 4
# Write a subprogram to count the number of occurrences of the bit pattern stored in $a0 in $a1. 
# The bit pattern to be searched is stored in the least significant bit positions of $a0, 
# the bit pattern length is given in $a2.
# Deniz Semih Özal
	.text
	.globl __main
__main:
	jal countBitPattern
	
	addi $t0, $v0, 0 # number of occurences
	
	la $a0, firstNumberHexa
	li $v0, 4
	syscall
	
	lw $a0, firstNumber
	li $v0, 34
	syscall
	
	la $a0, endl
	li $v0, 4
	syscall
	
	la $a0, secondNumberHexa
	li $v0, 4
	syscall
	
	lw $a0, secondNumber
	li $v0, 34
	syscall
	
	la $a0, endl
	li $v0, 4
	syscall
	
	la $a0, bitLengthPrompt
	li $v0, 4
	syscall
	
	lw $a0, bitLength
	li $v0, 1
	syscall
	
	la $a0, endl
	li $v0, 4
	syscall
	
	
	la $a0, prompt
	li $v0, 4
	syscall
	
	la $a0, ($t0)
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	
countBitPattern:
	addi $sp, $sp , -36 # make room for 2 items
	sw $ra, 32($sp) 
	sw $s7, 28($sp)
	sw $s6, 24($sp)
	sw $s5, 20($sp)
	sw $s4, 16($sp)
	sw $s3, 12($sp) 
	sw $s2, 8($sp) 
	sw $s1, 4($sp) 
	sw $s0, 0($sp) 
	
	lw $a0, firstNumber # firstNumber 
	lw $a1, secondNumber # secondNumber
	lw $a2, bitLength # bit Length

	
	add $s0, $a0, $0 # firstNumber 
	add $s1, $a1, $0 # secondNumber
	add $s2, $a2, $0 # bit Length
	addi $s5, $0, 0 # i = 0
	
	add $s4, $a2, $a2

	add $a0, $zero, $s4 # The byte size of the memory location to be allocated
	li $v0, 9 # used for dynamic storage allocation
	syscall 
	
	add $a0, $zero, $v0 # $s1 points the beginning of the array
	
	la $s6, 0($a0) # base address of an array1
	
	sll $s4, $a2, 2
	add $a1, $s4, $a0
	
	la $s3, 0($a1) # base address of an array2
	addi $s5,$s5, 1
	
	loop1:
		addi $s4, $s0, 0 # firstNumber
		sll $s4, $s4, 31 # left shift 31 
		srl $s4, $s4, 31 # right shift 31 
		sw $s4, 0($s6) # store into array1
		la $s6, ($s6) # base address of an array1
		addi $s6, $s6, 4 # address of array1[i]
		slt $s7, $s5, $s2 #i < bit length 
		beq $s7, $0, done
		srl $s0, $s0, 1 # right shift 1 first number
		addi $s5, $s5, 1 # i = i + 1
		j 	loop1
	
	done:
		addi $s0, $0, 0
		addi $s5, $0, 0 # initialize i to 0
		addi $s4, $0, 0 # initialize $s4 to 1 counter
		add $s6, $0, $s2
		loop2:
			addi $s0, $s1, 0 # secondNumber
			sll $s0, $s0, 31# left shift 31
			srl $s0, $s0, 31 # right shift 31
			sw $s0, 0($s3) # store into array2
			la $s3, ($s3) # base address of an array2 
			addi $s3, $s3, 4 # address of array2[i]
			slt $s7, $s5, $s2 # i < bit length
			beq $s7, 0, exit 
			srl $s1, $s1, 1 # right shift 1 second number
			addi $s5, $s5, 1 # i = i + 1
			j 	loop2
		exit:
		
			addi $s0, $0, 0 # j = 0
			loop3:
				slt $s7, $s0, $s6 # j < bit length
				beq $s7, $0, quit0
				sll $s7, $s0, 2 # j * 4
				add $a2, $s7, $a0 # address of array1[j]
				lw $a2, 0($a2) # array[j]
				add $a3, $s7, $a1 # address of array2[j]
				lw $a3, 0($a3) # array[j]
				bne $a2, $a3, escape
				addi $s0, $s0, 1 # j = j + 1
				j 	loop3
			quit0:
				addi $s4, $s4, 1 # counter++
				la $s3, 0($a1) # base address of an array2
				addi $s5, $s2, 0 # i = bytesize
				addi $s5, $s5, 1
				lw $s7, bitLength
				add $s2, $s7, $s2 # byteseize = byteseize + byteseize
				bgt $s2, 33, quit1
				j 	loop2
			escape:
				la $s3, 0($a1) # base address of an array2
				addi $s5, $s2, 0 # i = bytesize
				addi $s5, $s5, 1
				lw $s7, bitLength
				add $s2, $s7, $s2 # byteseize = byteseize + byteseize
				bgt $s2, 33, quit1
				j 	loop2
				addi $v0, $s4, 0
				addi $sp, $sp, 36
				lw $ra, 32($sp) 
				lw $s7, 28($sp)
				lw $s6, 24($sp)
				lw $s5, 20($sp)
				lw $s4, 16($sp)
				lw $s3, 12($sp) 
				lw $s2, 8($sp) 
				lw $s1, 4($sp) 
				lw $s0, 0($sp) 
				jr 	$ra
			quit1:
				addi $v0, $s4, 0
				addi $sp, $sp, 36
				lw $ra, 32($sp) 
				lw $s7, 28($sp)
				lw $s6, 24($sp)
				lw $s5, 20($sp)
				lw $s4, 16($sp)
				lw $s3, 12($sp) 
				lw $s2, 8($sp) 
				lw $s1, 4($sp) 
				lw $s0, 0($sp) 
				jr 	$ra
	.data
firstNumber: .word 255
secondNumber: .word -1
bitLength: .word 8
endl: .asciiz "\n"
prompt: .asciiz "Number of occurences is: "
firstNumberHexa: "Hexa version of first number: "
secondNumberHexa: "Hexa version of second number: "
bitLengthPrompt: "Bit Length: "
