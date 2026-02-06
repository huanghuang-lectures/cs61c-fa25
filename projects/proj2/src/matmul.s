.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
#   d = matmul(m0, m1)
# Arguments:
#   a0 (int*)  is the pointer to the start of m0
#   a1 (int)   is the # of rows (height) of m0
#   a2 (int)   is the # of columns (width) of m0
#   a3 (int*)  is the pointer to the start of m1
#   a4 (int)   is the # of rows (height) of m1
#   a5 (int)   is the # of columns (width) of m1
#   a6 (int*)  is the pointer to the the start of d
# Returns:
#   None (void), sets d = matmul(m0, m1)
# Exceptions:
#   Make sure to check in top to bottom order!
#   - If the dimensions of m0 do not make sense,
#     this function terminates the program with exit code 38
#   - If the dimensions of m1 do not make sense,
#     this function terminates the program with exit code 38
#   - If the dimensions of m0 and m1 don't match,
#     this function terminates the program with exit code 38
# =======================================================
matmul:
    # Error checks #
    # Check if dimension < 1
    li t0, 1
    blt a1, t0, exit_bad_width_or_height
    blt a2, t0, exit_bad_width_or_height
    blt a4, t0, exit_bad_width_or_height
    blt a5, t0, exit_bad_width_or_height

    # Check if dimension not match
    bne a2, a4, exit_dimen_not_match

    # Prologue
    addi sp, sp, -40
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)
    sw s3, 16(sp)
    sw s4, 20(sp)
    sw s5, 24(sp)
    sw s6, 28(sp)
    sw s7, 32(sp)   # Store outer loop index i.
    sw s8, 36(sp)   # Store inner loop index j.

    # Store arguments to saved registers.
    mv s0, a0
    mv s1, a1
    mv s2, a2
    mv s3, a3
    mv s4, a4
    mv s5, a5
    mv s6, a6

# Outer loop should iterate rows over m0.
# i = 0; i < s1; i++ 
# address = s0 + i * a2 * 4
outer_loop_start:
    li s7, 0    # Init index i = 0

outer_loop_continue:
    beq s7, s1, outer_loop_end  # Check if i < s1

    # Calculate address of m0[i]
    # &m0[i] = &m0[0] + i * m0.width * 4
    # t0 = s0 + s7 * s2 * 4
    mul t0, s7, s2
    slli t0, t0, 4
    add t0, s0, t0

# Inner loop should iterate columns over m1.
# j = 0; j < s5; j++
# address = s3 + j * 1 * 4
inner_loop_start:
    li s8, 0    # Init index j = 0

inner_loop_continue:
    beq s8, s5, inner_loop_end  # Check if j < s5

    # Calculate address of m1[j]
    # &m1[j] = &m1[0] + j * 1 * 4
    # t1 = s3 + s8 * 1 * 4
    slli t1, s8, 2
    add t1, s3, t1

    # Call dot function: dot(&m0[i], &m1[j], s2(s4), 1, s5).
    mv a0, t0
    mv a1, t1
    mv a2, s2
    li a3, 1
    mv a4, s5

    # Call dot.
    jal ra, dot

    # Store value in d[i][j]
    # &d[i][0] = s6 + s7 * s5 * 4
    # &d[i][j] = s6 + s7 * s5 * 4 + s8 * 4
    mul t0, s7, s5
    slli t0, t0, 2
    slli t1, s8, 2
    add t0, s6, t0
    add t0, t0, t1
    sw a0, 0(t0)

    # Update inner loop index j.
    addi s8, s8, 1
    j inner_loop_continue


inner_loop_end:
    # Update outer loop index i.
    addi s7, s7, 1
    j outer_loop_continue


outer_loop_end:
    # Epilogue
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

    jr ra

exit_bad_width_or_height:
    li a0, 38
    j exit

exit_dimen_not_match:
    li a0, 38
    j exit