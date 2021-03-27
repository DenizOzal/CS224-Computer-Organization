# Part 5
# Modified version of previous calculation
# A = (B * C) / D + (D - C) % B
# Deniz Semih Özal

	.text
	.globl ___start
___start: 
	la $a0, prompt
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	add $t0, $zero, $v0 # $t0 = b
	
	li $v0, 5
	syscall
	add $t1, $zero, $v0 # $t1 = c
	
	li $v0, 5
	syscall
	add $t2, $zero, $v0 # $t2 = d
	
	mult $t0, $t1 # b * c
	mflo $s1 # b * c -> low
	
	div $s1, $t2 # (b * c) / d
	mflo $s1 #quotient
	
	sub $s2, $t2, $t1 # d - c
	div $s2, $t0 # (d - c) % b
	mfhi $s3
	
	add $s4, $s1, $s3 # (b * c) / d + (d - c) % b
	
	la $a0, result
	li $v0, 4 
	syscall
	
	la $a0, ($s4)
	li $v0, 1
	syscall
	
	
	.data
prompt: .asciiz "Please enter b, c, and d recpectively\n"
result: .asciiz "Result: "