.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
#   a0 (int*) is the pointer to the array
#   a1 (int)  is the # of elements in the array
# Returns:
#   None
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
# ==============================================================================
relu:
    # Check if array length < 1
    li t0, 1
    blt a1, t0, exit_bad_len
    
    # Prologue: save preserved registers
    addi sp, sp, -12
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    
    # Save array pointer and length in preserved registers
    mv s0, a0          # s0 = array pointer
    mv s1, a1          # s1 = array length

loop_start:
    beq s1, zero, loop_end
    
    # Load current element value to check if negative
    lw t0, 0(s0)
    bge t0, zero, skip_element  # if >= 0, skip (already correct)
    
    # If negative, set to 0
    sw zero, 0(s0)
    
skip_element:
    # Move to next element
    addi s0, s0, 4     # increment pointer by 4 bytes (int size)
    addi s1, s1, -1    # decrement counter
    j loop_start

loop_end:
    # Epilogue: restore preserved registers
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    addi sp, sp, 12
    
    jr ra

exit_bad_len:
    li a0, 36
    j exit
