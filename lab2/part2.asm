# Part 2
# Write a subprogram that receives a decimal number (in $a0) and 
# reverses the order of its bits and returns it as its result (in $v0).
# Deniz Semih Özal
	.text
	.globl __main
__main:
	jal reverseBitNumber
	
	addi $t0, $v0, 0
	
	la $a0, reverseBinary
	li $v0, 4
	syscall
	
	addi $v0, $t0, 0
	la $a0, ($v0)
	li $v0, 35
	syscall
	
	la $a0, endl
	li $v0, 4
	syscall
	
	la $a0, reverseHexa
	li $v0, 4
	syscall
	
	addi $v0, $t0, 0
	la $a0, ($v0)
	li $v0, 34
	syscall
	
	li $v0, 10
	syscall
	
	
reverseBitNumber:
	addi $sp, $sp, -28
	sw $s6, 24($sp)
	sw $s5, 20($sp)
	sw $s4, 16($sp)
	sw $s3, 12($sp)
	sw $s2, 8($sp)
	sw $s1, 4($sp)
	sw $s0, 0($sp)
	
	la $a0, decimal
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	move $s0, $v0 # our number
	
	la $a0, decimalNumber
	li $v0, 4
	syscall
	
	la $a0, ($s0)
	li $v0, 1
	syscall
	
	la $a0, endl
	li $v0, 4
	syscall
	
	la $a0, binary
	li $v0, 4
	syscall
	
	la $a0, ($s0)
	li $v0, 35
	syscall
	
	la $a0, endl
	li $v0, 4
	syscall
	
	la $a0, hexa
	li $v0, 4
	syscall
	
	la $a0, ($s0)
	li $v0, 34
	syscall
	
	addi $s7, $0, 0 # counter for quoteient
	addi $s1, $0, 2 # division by 2
	addi $s2, $0, 0
	addi $s5, $0, 31 # shift left starts from 31
	addi $s6, $0, 0  #register for reverse version of binary
	
	la $a0, endl
	li $v0, 4
	syscall

	loop:
		div $s0, $s1
		mflo $s0 #quotient
		mfhi $s4 #remainder
		or $s4, $s4, $s2 
		sllv  $s4, $s4, $s5
		addi $s4, $s4, 0
		add $s6, $s6, $s4
		addi $s5, $s5, -1
		beq $s0, 0, done
		j 	loop
	
	done:
		add $v0, $0, $s6
		addi $sp, $sp, 28
		lw $s6, 24($sp)
		lw $s5, 20($sp)
		lw $s4, 16($sp)
		lw $s3, 12($sp)
		lw $s2, 8($sp)
		lw $s1, 4($sp)
		lw $s0, 0($sp)
		jr  $ra
	.data
decimal: .asciiz "Plese enter decimal number:" 
endl: .asciiz "\n"
decimalNumber: .asciiz "Here is your decimal number: "
hexa: "Here is your hexa number: "
binary: .asciiz "Here is your binary conversion: "
reverseBinary: .asciiz "Here is your reverse binary conversion: "
reverseHexa: .asciiz "Here is your reverse hexa number: "
