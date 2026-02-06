.globl read_matrix

.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is a pointer to an integer, we will set it to the number of rows
#   a2 (int*)  is a pointer to an integer, we will set it to the number of columns
# Returns:
#   a0 (int*)  is the pointer to the matrix in memory
# Exceptions:
#   - If malloc returns an error,
#     this function terminates the program with error code 26
#   - If you receive an fopen error or eof,
#     this function terminates the program with error code 27
#   - If you receive an fclose error or eof,
#     this function terminates the program with error code 28
#   - If you receive an fread error or eof,
#     this function terminates the program with error code 29
# ==============================================================================
read_matrix:

    # Prologue
    addi sp, sp, -28
    sw ra, 0(sp)
    sw s0, 4(sp)   # The pointer to string representing the filename.
    sw s1, 8(sp)   # The pointer to the number of rows.
    sw s2, 12(sp)  # The pointer to the number of columns.
    sw s3, 16(sp)  # The file descriptor of the file.
    sw s4, 20(sp)  # The matrix size in bytes (row * column * 4).
    sw s5, 24(sp)  # The pointer to the pointer to the matrix in memory.

    mv s0, a0
    mv s1, a1
    mv s2, a2

# Open the file with read permissions.
open_file:
    mv a0, s0
    li a1, 0

    # Call fopen.
    jal ra, fopen

    # Check if fopen error.
    li t0, -1
    beq a0, t0, exit_fopen_error

    # Save the file descriptor in register s3.
    mv s3, a0

# Read the number of rows and columns from the file 
# (remember: these are the first two integers in the file). 
read_dimension:
    # Read row number (first 4 bytes).
    mv a0, s3
    mv a1, s1
    li a2, 4
    jal ra, fread
    li t0, 4
    bne a0, t0, exit_fread_error

    # Read column number (next 4 bytes).
    mv a0, s3
    mv a1, s2
    li a2, 4
    jal ra, fread
    li t0, 4
    bne a0, t0, exit_fread_error

    # Calculate matrix size: rows * columns * 4.
    lw t0, 0(s1)
    lw t1, 0(s2)
    mul s4, t0, t1
    slli s4, s4, 2

# Allocate space on the heap to store the matrix.
alloc_memory_for_matrix:
    mv a0, s4
    jal ra, malloc
    
    # Check if malloc failed.
    beq a0, zero, exit_malloc_error

    mv s5, a0

# Read the matrix from the file to the memory.
read_matrix_from_file:
    mv a0, s3
    mv a1, s5
    mv a2, s4

    # Call fread.
    jal ra, fread

    bne a0, s4, exit_fread_error

close_file:
    mv a0, s3

    # Call fclose.
    jal ra, fclose

    bne a0, zero, exit_fclose_error

read_matrix_end:
    mv a0, s5

    # Epilogue
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s4, 20(sp)
    lw s5, 24(sp)
    addi sp, sp, 28

    jr ra

exit_malloc_error:
    li a0, 26
    j cleanup_and_exit

exit_fopen_error:
    li a0, 27
    j cleanup_and_exit

exit_fclose_error:
    li a0, 28
    j cleanup_and_exit

exit_fread_error:
    li a0, 29
    j cleanup_and_exit

cleanup_and_exit:
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s4, 20(sp)
    lw s5, 24(sp)
    addi sp, sp, 28
    
    j exit
