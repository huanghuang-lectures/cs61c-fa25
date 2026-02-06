.globl write_matrix

.text
# ==============================================================================
# FUNCTION: Writes a matrix of integers into a binary file
# FILE FORMAT:
#   The first 8 bytes of the file will be two 4 byte ints representing the
#   numbers of rows and columns respectively. Every 4 bytes thereafter is an
#   element of the matrix in row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is the pointer to the start of the matrix in memory
#   a2 (int)   is the number of rows in the matrix
#   a3 (int)   is the number of columns in the matrix
# Returns:
#   None
# Exceptions:
#   - If you receive an fopen error or eof,
#     this function terminates the program with error code 27
#   - If you receive an fclose error or eof,
#     this function terminates the program with error code 28
#   - If you receive an fwrite error or eof,
#     this function terminates the program with error code 30
# ==============================================================================
write_matrix:

    # Prologue
    addi sp, sp, -24
    sw ra, 0(sp)
    sw s0, 4(sp)    
    sw s1, 8(sp)    
    sw s2, 12(sp)   
    sw s3, 16(sp)   
    sw s4, 20(sp)   

    # Save arguments
    mv s0, a0   # The pointer to string representing the filename.
    mv s1, a1   # The pointer to the start of the matrix in memory.
    mv s2, a2   # The number of rows in the matrix.
    mv s3, a3   # The number of columns in the matrix.

# Open the file with write permissions.
open_file:
    mv a0, s0
    li a1, 1
    
    # Call fopen.
    jal ra, fopen

    # Check if fopen error.
    li t0, -1
    beq a0, t0, exit_fopen_error

    # Save the file descriptor in register s4.
    mv s4, a0

# Write the number of rows and columns to the file.
write_dimension:
    # Save row number on stack.
    addi sp, sp, -4
    sw s2, 0(sp)
    # Write row number (first 4 bytes).
    mv a0, s4
    mv a1, sp
    li a2, 1
    li a3, 4
    jal ra, fwrite
    addi sp, sp, 4
    li t0, 1
    bne a0, t0, exit_fwrite_error

    # Save column number on stack.
    addi sp, sp, -4
    sw s3, 0(sp)
    # Write column number (next 4 bytes).
    mv a0, s4
    mv a1, sp
    li a2, 1
    li a3, 4
    jal ra, fwrite
    addi sp, sp, 4
    li t0, 1
    bne a0, t0, exit_fwrite_error

# Write the data to the file.
write_matrix_to_file:
    mv a0, s4
    mv a1, s1
    mul a2, s2, s3
    li a3, 4
    jal ra, fwrite
    
    mul t0, s2, s3
    bne a0, t0, exit_fwrite_error


close_file:
    mv a0, s4

    jal ra, fclose

    bne a0, zero, exit_fclose_error

write_matrix_end:
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s4, 20(sp)
    addi sp, sp, 24

    jr ra


exit_fopen_error:
    li a0, 27
    j cleanup_and_exit

exit_fwrite_error:  
    li a0, 30
    j cleanup_and_exit

exit_fclose_error:
    li a0, 28
    j cleanup_and_exit

cleanup_and_exit:
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s4, 20(sp)
    addi sp, sp, 24

    j exit