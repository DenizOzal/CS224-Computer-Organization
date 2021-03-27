# Part 2
# Deniz Semih Özal
	.text
	.globl main
main:
	do:
		la $a0, prompt
		li $v0, 4
		syscall
		
		la $a0, dividend
		li $v0, 4
		syscall
	
		li $v0, 5
		syscall
		
		addi $t0, $v0, 0 # dividend
		
		la $a0, divisor
		li $v0, 4
		syscall
		
		li $v0, 5
		syscall
		
		addi $t1, $v0, 0 # divisor
		
		addi $a0, $t0, 0 # $a0 = dividend
		addi $a1, $t1, 0 # $a1 = divisor
		  
		jal recursiveDivision
		
		addi $t2, $v0, 0
				
		la $a0, result
		li $v0, 4
		syscall
	
		
		la $a0, ($t2)
		li $v0, 1
		syscall
		
		la $a0, endl
		li $v0, 4
		syscall
		
		la $a0, continue
		li $v0, 4
		syscall
		
		li $v0, 5
		syscall
		
		addi $t3, $v0, 0# getting answer
		
		while:
			beq $t3, 1, do # 1 to continue
			beq $t3, 0, exit # 0 to exit
	exit:
		li $v0, 10
		syscall
			

recursiveDivision:
	addi $sp, $sp, -12 # make room for 3 items
	sw $ra, 8($sp) # push $ra
	sw $s0, 4($sp) # push $s0
	sw $a0, 0($sp) # push $a0
	
	if: 
		slt $s0, $a0, $a1 # if dividend < divisor
		beq $s0, $0, else # no: go to else
		addi $v0, $0 0 # yes: return 0	
		addi $sp, $sp, 12 # restore $sp
		jr 	$ra # return
	else:
		sub $a0, $a0, $a1 # $a0 = dividend - divisor
		jal 	recursiveDivision # recursive call recursiveDivision
		
		lw $a0, 0($sp) # pop $a0
		addi $v0, $v0, 1 # 1 + (dividend - division)
		lw $s0, 4($sp) # pop $s0
		lw $ra, 8($sp) # pop $ra
		addi $sp, $sp, 12 # restore $sp
		jr 	$ra # return 
	
	.data
prompt: .asciiz "************************\nWelcome to DivisionCalculator...Please enter dividend and divisor respectively\n"
dividend: .asciiz "Dividend: "
divisor: .asciiz "Divisor: "
result: .asciiz "Result: "
endl: .asciiz "\n"
continue: .asciiz "Do you want to keep continue? (Press 1 to continue, 0 to exit) "
space: .asciiz " "
