# Part 3
# Define an array and state its size in a separate variable as you have done in Part 1.
# Find minimum, maximum, and average value of the array elements. Use integer arithmetic.
# Deniz Semih Özal
	.text
	.globl __start
__start:
	la $a0, prompt 
	li $v0, 4
	syscall
	
	la $t0, array # t0 = base address of array
	addi $s0, $zero, 0 # i = 0
	lw $s1, arrsize
	addi $s2, $s1, -1 # arrsize - 1
	
	addi $t3, $zero, -10000 # max
	addi $t4, $zero, 10000 # min
	addi $s3, $zero, 0 # sum
	
loop:
	slt $t1, $s0, $s1 # i < arrsize
	beq $t1, $0, done # if not then done
	sll $t1, $s0, 2 # $t1 = i * 4
	add $t1, $t1, $t0 # address of array[i]	
	li  $v0, 34 
	add $a0, $zero, $t1
	syscall
	
	la $a0, space_tab 
	li $v0, 4
	syscall
	
	
	lw  $t2, 0($t1) # $t2 = array[i]
	la $a0, ($t2)
	li $v0, 1
	syscall
	
	la $a0, endl
	li $v0, 4
	syscall
	
	add $s3, $s3, $t2 # sum = sum + array[i]

	blt $t2, $t4, min_value # array[i] < min then jump to min
	back1:
	bgt $t2, $t3, max_value # array[i] > max then jump to max
	back2:
	
	addi $s0, $s0, 1
	
	j 	loop
	
min_value: 	move $t4, $t2	# min = $t2
		j 	back1

		
max_value:	move $t3, $t2 # max = $t2
		j 	back2
		
done:	
	la $a0, average
	li $v0, 4
	syscall 
	
	div $s3, $s1
	mflo $a0
	li $v0, 1
	syscall
	
	la $a0, endl
	li $v0, 4
	syscall 
	
	la $a0, max
	li $v0, 4
	syscall 
	
	la $a0, ($t3)
	li $v0, 1
	syscall
	
	la $a0, endl
	li $v0, 4
	syscall 
	
	la $a0, min
	li $v0, 4
	syscall 
	
	la $a0, ($t4)
	li $v0, 1
	syscall
	
	.data
array: .word 2, -9, 0, -8, 9, -7, -2, -9
arrsize: .word 8
prompt: .asciiz "Memory Address\t Array Element\nPosition(hex)\t Value(int)\n-------------\t-------------\n-----------\t-------------\n"
space_tab: .asciiz "	"
endl: .asciiz "\n"
average: .asciiz "Average: " 
max: .asciiz "Max: "
min: .asciiz "Min: "
