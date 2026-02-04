.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int arrays
# Arguments:
#   a0 (int*) is the pointer to the start of arr0
#   a1 (int*) is the pointer to the start of arr1
#   a2 (int)  is the number of elements to use
#   a3 (int)  is the stride of arr0
#   a4 (int)  is the stride of arr1
# Returns:
#   a0 (int)  is the dot product of arr0 and arr1
# Exceptions:
#   - If the number of elements to use is less than 1,
#     this function terminates the program with error code 36
#   - If the stride of either array is less than 1,
#     this function terminates the program with error code 37
# =======================================================
dot:
    # Check if array length < 1
    li t0, 1
    blt a2, t0, exit_bad_len

    # Check if stride of array is less than 1
    li t0, 1
    blt a3, t0, exit_bad_stride
    blt a4, t0, exit_bad_stride

    # Prologue
    addi sp, sp, -28
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)
    sw s3, 16(sp)
    sw s4, 20(sp)
    sw s5, 24(sp)

loop_start:
    mv s0, a0  
    mv s1, a1
    mv s2, a2
    mv s3, a3
    mv s4, a4
    li s5, 0  # init result value

loop_continue:
    beq s2, zero, loop_end
    lw t0, 0(s0)
    lw t1, 0(s1)
    mul t0, t0, t1
    add s5, s5, t0

    slli t0, s3, 2
    slli t1, s4, 2

    add s0, s0, t0
    add s1, s1, t1
    addi s2, s2, -1
    j loop_continue


loop_end:
    # Save result before restoring registers
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

exit_bad_len:
    li a0, 36
    j exit

exit_bad_stride:
    li a0, 37
    j exit