# Part 4
# Write a program that prompts the user for one or more integer input values, reads these values from the keyboard,
# and computes a mathematical formula such as (a different formula may be given by your TA): A= (B * C + D / B - C ) % B
# Deniz Semih Özal
	.text
	.globl __main
__main:
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
	mflo $t4 # b * c -> low
	
	div $t2, $t0 # d / b
	mflo $t5 # d / b (quotient)
	
	add $s0, $t4, $t5 # b*c + d/b (only $t4 is used since operation is on 32 bits)
	sub $s0, $s0, $t1 # b*c + d/b - c
	
	div $t3, $t0 # (b*c + d/b - c) % b -> high 
	mfhi $t3
	
	div $s0, $t0 # (b*c + d/b - c) % b -> low
	mfhi $s0
	
	la $a0, explain
	li $v0, 4
	syscall
	
	la $a0, open
	li $v0, 4
	syscall
	
	la $a0, ($t3)
	li $v0, 1
	syscall 
	
	la $a0, comma
	li $v0, 4
	syscall
	
	la $a0, ($s0)
	li $v0, 1
	syscall
	
	la $a0, close
	li $v0, 4
	syscall
	
	.data
prompt: .asciiz "Please enter b, c, d respectively\n"
explain: .asciiz "The formula is result = (b*c+d/b-c)%b and step by step firstly 32 bit b and c are multiplied,\n then 64 bit number is divided high and low, secondly d/b is calculated and quotient is used by mflo,\n then adding and subtration is applied, finally the modulo operator used to find the remainder\n"
open: .asciiz "Result: {"
comma: .asciiz ","
close: .asciiz "}"
