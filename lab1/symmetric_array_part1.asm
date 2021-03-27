# Part 1
# Define an array and state its size in a separate variable and test if it is a symmetric array. Di
# Display array elements and print a message such as "The above array is symmetric". 
# If not symmetric "The above array is not symmetric". For array declaration and for declaring its size you may use lines similar to the following.
# By changing these declarations you may use your program with different arrays.
# Deniz Semih Özal
	.text
	.globl __start
__start:
	la	$t0, array # base adress of an array
	addi 	$s2, $0, 0 # i = 0
	lw	$s1, arrsize
	addi 	$s1, $s1, -1 # arrsize - 1
	
for:
	slt 	$t1, $s2, $s1 # i <  arrsize - 1
	beq 	$t1, $0, symmetric # jumps if symmetric
	sll 	$t1, $s2, 2 # $t1 = i * 4
	add 	$t1, $t1, $t0 # address of array[i]
	lw 	$t2, 0($t1)# $ t2 = array[i]
	sll 	$t3, $s1, 2 # t3 = (arrsize - 1) * 4
	add 	$t3, $t3, $t0 # adress of array[arrsize - 1]
	lw 	$t4, 0($t3) # $t4 = array[arrsize - 1]
	bne 	$t2, $t4, not_symmetric # jumps if notsymmetric
	addi 	$s2, $s2, 1 # i = i + 1
	addi 	$s1, $s1, -1 # arrsize = arrsize - 1
	j 	for
symmetric:
	la 	$a0, array_sym
	li 	$v0, 4
	syscall
	li 	$v0, 10
	syscall
not_symmetric:
	la 	$a0, array_nsym
	li 	$v0, 4
	syscall
	li 	$v0, 10
	syscall	
	
	.data
arrsize: .word 3
array:	.word	10, 20, 10
array_sym: .asciiz "The above array is symmetric"
array_nsym: .asciiz "The above array is not symmetric" 
