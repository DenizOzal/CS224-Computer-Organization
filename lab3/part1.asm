# Part 1
# Deniz Semih Özal
	.text
	.globl main
	
L1: la $a0, 0x00400010 # first instruction address
L2: la $a1, 0x004000fc # last Instruction address

main:  
	# some random operations
	add $t0, $0, $0
	lw $t1, two 
	lw $t2, one
	la $t3, ($a0)
	la $t4, ($a1)
	
	la $a2, main # assign base address of main to $a2
	jal subProgram # jump and link to subProgram
	
	addi $t0, $v0, 0 # return $v0
	addi $t1, $v1, 0 # return $v1
	
	la $a0, addNumber
	li $v0, 4
	syscall
	
	la $a0, ($t0)
	li $v0, 1
	syscall
	
	la $a0, endl
	li $v0, 4
	syscall
	
	la $a0, lwNumber
	li $v0, 4
	syscall

	la $a0, ($t1)
	li $v0, 1
	syscall
	
	la $a0, endl
	li $v0, 4
	syscall
	
	la $a0, ($t3)
	la $a1, ($t4)
	
	la $a2, subProgram # assign base address of subProgram to $a2
	jal subProgram
	
	addi $t0, $v0, 0
	addi $t1, $v1, 0
	
	la $a0, addNumberSub
	li $v0, 4
	syscall
	
	la $a0, ($t0)
	li $v0, 1
	syscall
	
	la $a0, endl
	li $v0, 4
	syscall
	
	la $a0, lwNumberSub
	li $v0, 4
	syscall

	la $a0, ($t1)
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	

subProgram: 
	addi $sp, $sp, -36 # make room for 9 items
	sw $ra, 32($sp) # push $ra
	sw $s7, 28($sp) # push $s7
	sw $s6, 24($sp) # push $s6
	sw $s5, 20($sp) # push $s5
	sw $s4, 16($sp) # push s4
	sw $s3, 12($sp) # push s3
	sw $s2, 8($sp) # push s2
	sw $s1, 4($sp) # push s1
	sw $s0, 0($sp) # push s0
	
	la $s0, ($a2) #  instruction address of start
	la $s2, ($a0) # $s2 = first inst address
	la $s3, ($a1) # $s3 = last inst address
	sub $s3, $s3, $s2 # $s2 = last - first
	srl $s3, $s3, 2
	addi $s2, $zero, 0
	addi $s5, $zero, 0 
	loop: 
		slt $s1, $s2, $s3 # first < last
		beq $s1, $0, done
		sll $s1, $s2, 2 # i * 4
		add $s1, $s1, $s0 # address starts from main
		lw  $s1, 0($s1) # getting instruction
		move $s4, $s1 # copying $s1
		addCheck:
			move $s5, $s4
			move $a2, $s4
			srl $a2, $a2, 26 # first 6 bits
			sll $s5, $s5, 26
			srl $s5, $s5, 26 # last 6 bits
			add $s5, $s5, $a2 # first 6 bits + last 6 bits
			beq $s5, 32, addCounter # if total is 32 then go to addCounter
			j 	lwCheck
		lwCheck:
			move $s5, $s4
			srl $s5, $s5, 26 # first 6 bits
			beq $s5, 35, lwCounter # if first 6 bits equal to 35 rhen go to lwCounter
			j 	back
		back:
			addi  $s2, $s2, 1 # i = i + 1
			j 	loop
		done:
			addi $v0, $s6, 0 # return add number
			addi $v1, $s7, 0 # return lw number
			lw $ra, 32($sp) # pop $ra
 			lw $s7, 28($sp) # pop $s7
			lw $s6, 24($sp) # pop $s6
			lw $s5, 20($sp) # pop $s5
			lw $s4, 16($sp) # pop $s4
 			lw $s3, 12($sp) # pop $s3
			lw $s2, 8($sp) # pop $s2
			lw $s1, 4($sp) # pop $s1
			lw $s0, 0($sp) # pop $s0
			addi $sp, $sp, 36 # restore 9 items
			jr 	$ra
		addCounter:
			addi $s6, $s6, 1 # add = add + 1
			j 	lwCheck
			
		lwCounter:
			addi $s7, $s7, 1 # lw = lw + 1
			j	back
	.data 
endl: .asciiz "\n"
addNumber: .asciiz "The number of add instruction in main: "
lwNumber: .asciiz "The number of lw instruction in main: "
addNumberSub: .asciiz "The number of add instruction in sub: "
lwNumberSub: .asciiz "The number of lw instruction in sub: "
one: .word 1
two: .word 2
three: .word 3	
	
	
	


	
