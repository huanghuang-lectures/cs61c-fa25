.globl classify

.text
# =====================================
# COMMAND LINE ARGUMENTS
# =====================================
# Args:
#   a0 (int)        argc
#   a1 (char**)     argv
#   a1[1] (char*)   pointer to the filepath string of m0
#   a1[2] (char*)   pointer to the filepath string of m1
#   a1[3] (char*)   pointer to the filepath string of input matrix
#   a1[4] (char*)   pointer to the filepath string of output file
#   a2 (int)        silent mode, if this is 1, you should not print
#                   anything. Otherwise, you should print the
#                   classification and a newline.
# Returns:
#   a0 (int)        Classification
# Exceptions:
#   - If there are an incorrect number of command line args,
#     this function terminates the program with exit code 31
#   - If malloc fails, this function terminates the program with exit code 26
#
# Usage:
#   main.s <M0_PATH> <M1_PATH> <INPUT_PATH> <OUTPUT_PATH>
classify:
    # Check argc (should be 5: program name + 4 arguments).
    li t0, 5
    bne a0, t0, exit_argument_error

    # Prologue
    addi sp, sp, -40
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)
    sw s3, 16(sp)  # m0 pointer
    sw s4, 20(sp)  # m1 pointer
    sw s5, 24(sp)  # input file pointer
    sw s6, 28(sp)  # h pointer
    sw s7, 32(sp)  # o pointer
    sw s8, 36(sp)  # argmax(o)

    # Save arguments
    mv s0, a0   # argc
    mv s1, a1   # argv
    mv s2, a2   # slient mode

# Read three matrices m0, m1, and input from files.
read_matrices:
    # Store all dimensions on stack.
    addi sp, sp, -24

    # Read pretrained m0
    lw a0, 4(s1)    # argv[1]
    addi a1, sp, 0  # m0 rows
    addi a2, sp, 4  # m0 columns
    jal ra, read_matrix
    mv s3, a0

    # Read pretrained m1
    lw a0, 8(s1)    # argv[2]
    addi a1, sp, 8  # m1 rows
    addi a2, sp, 12 # m1 columns
    jal ra, read_matrix
    mv s4, a0

    # Read input matrix
    lw a0, 12(s1)    # argv[3]
    addi a1, sp, 16   # input rows
    addi a2, sp, 20  # input columns
    jal ra, read_matrix
    mv s5, a0

compute:
    # The matmul function takes in two integer matrices A (dimension n × m)
    # and B (dimension m × k) and outputs an integer matrix C (dimension n × k).
    #
    # Allocate space for h (m0 rows * input columns)
    lw t0, 0(sp)   # m0 rows
    lw t1, 20(sp)  # input columns
    mul t0, t0, t1
    slli a0, t0, 2
    jal ra, malloc
    beq a0, zero, exit_malloc_error
    mv s6, a0

    # Compute h = matmul(m0, input)
    mv a0, s3       # m0 start pointer
    lw a1, 0(sp)    # m0 rows
    lw a2, 4(sp)    # m0 columns
    mv a3, s5       # input matrix start pointer
    lw a4, 16(sp)   # input rows
    lw a5, 20(sp)   # input columns
    mv a6, s6       # h start pointer
    jal ra, matmul

    # Compute h = relu(h)
    mv a0, s6      # h start pointer
    lw t0, 0(sp)   # m0 rows
    lw t1, 20(sp)  # input columns
    mul a1, t0, t1
    jal ra, relu

    # Allocate space for o (m1_rows * h_columns)
    lw t0, 8(sp)    # m1 rows
    lw t1, 20(sp)   # h columns/input columns
    mul t0, t0, t1
    slli a0, t0, 2
    jal ra, malloc
    beq a0, zero, exit_malloc_error
    mv s7, a0

    # Compute o = matmul(m1, h)
    mv a0, s4       # m1 start pointer
    lw a1, 8(sp)    # m1 rows
    lw a2, 12(sp)   # m1 columns
    mv a3, s6       # h pointer
    lw a4, 0(sp)    # h rows/m0 rows
    lw a5, 20(sp)   # h columns/input columns
    mv a6, s7       # o start pointer
    jal ra, matmul

    # Write output matrix o
    lw a0, 16(s1)   # argv[4]
    mv a1, s7       # o start pointer
    lw a2, 8(sp)
    lw a3, 20(sp)
    jal ra, write_matrix

    # Compute and return argmax(o)
    mv a0, s7   # o start pointer
    lw t0, 8(sp)
    lw t1, 20(sp)
    mul a1, t0, t1
    jal ra, argmax
    mv s8, a0

# If the print argument is set to 0,
# then also print out argmax(o) and a newline character.
print_argmax:
    # If enabled, print argmax(o) and newline
    li t0, 1
    beq s2, t0, free_space  # skip to end when slient mode.

    # Print out argmax(o).
    mv a0, s8
    jal print_int

    # Print out newline character.
    li a0, '\n'
    jal print_char

# Free any data you allocated with malloc.
free_space:
    # Free m0.
    mv a0, s3
    jal ra, free

    # Free m1.
    mv a0, s4
    jal ra, free

    # Free input matrix.
    mv a0, s5
    jal ra, free

    # Free h.
    mv a0, s6
    jal ra, free

    # Free o.
    mv a0, s7
    jal ra, free

    mv t0, s8

    # Epilogue
    addi sp, sp, 24
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s4, 20(sp)
    lw s5, 24(sp)
    lw s6, 28(sp)
    lw s7, 32(sp)
    lw s8, 36(sp)
    addi sp, sp, 40

    mv a0, t0   # 返回值 = classification
    jr ra


exit_malloc_error:
    li a0, 26
    j cleanup_and_exit

exit_argument_error:
    li a0, 31
    j exit

cleanup_and_exit:
    # Epilogue
    # Remove dimensions on stack.
    addi sp, sp, 24

    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s4, 20(sp)
    lw s5, 24(sp)
    lw s6, 28(sp)
    lw s7, 32(sp)
    lw s8, 36(sp)
    addi sp, sp, 40

    j exit
