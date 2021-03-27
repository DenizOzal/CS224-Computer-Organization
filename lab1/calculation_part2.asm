# Part 2
# Calculating an arithmetic expression in MIPS: Write a program to evaluate the following expression given below (all numbers are integers):
# x = a * (b - c) % d
# Deniz Semih Özal
	.text
	.globl __start
__start:
	la $a0, input
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	add $t0, $0, $v0 # $t0 = a
	
	li $v0, 5
	syscall
	add $t1, $0, $v0 # t1 = b
	
	li $v0, 5
	syscall
	add $t2, $0, $v0 # t2 = c
	
	li $v0, 5
	syscall
	add $t3, $0, $v0 #  t3 = d
	
	sub $s1, $t1, $t2 # $s1 = b - c
	mult $t0, $s1 # a * (b - c)
	mfhi $t4
	mflo $t5
	div $t4, $t3 # [a * (b - c)] % d -> high
	mfhi $s2 # x (high)
	div $t5, $t3 # [a * (b - c)] % d -> low
	mfhi $s3 # x (low)

	la $a0, open 
	li $v0, 4
	syscall
	
	la $a0, ($s2)
	li $v0, 1
	syscall
	
	la $a0, comma
	li $v0, 4
	syscall
	
	la $a0, ($s3)
	li $v0, 1
	syscall
	
	la $a0, close
	li $v0, 4
	syscall
	
	.data
input: .asciiz "Please enter a,b,c,d respectively:\n"
open: .asciiz "{"
comma: .asciiz ","
close: .asciiz "}"
