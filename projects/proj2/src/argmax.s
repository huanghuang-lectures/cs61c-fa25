.globl argmax

.text
# =================================================================
# FUNCTION: Given a int array, return the index of the largest
#   element. If there are multiple, return the one
#   with the smallest index.
# Arguments:
#   a0 (int*) is the pointer to the start of the array
#   a1 (int)  is the # of elements in the array
# Returns:
#   a0 (int)  is the first index of the largest element
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
# =================================================================
argmax:
    # Check if array length < 1
    li t0, 1
    blt a1, t0, exit_bad_len

    # Prologue
    addi sp, sp, -12
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)

    # Initialize variables
    mv s0, a0          # s0 = array pointer (current position)
    mv s1, a1          # s1 = array length (counter)
    li t0, 0           # s2 = max index (init to 0)
    lw t1, 0(s0)       # t1 = max value (init to array[0])
    
    # Move to next element
    addi s0, s0, 4
    addi s1, s1, -1

loop_start:
    # Initialize variables
    mv s0, a0          # s0 = array pointer (current position)
    mv s1, a1          # s1 = array length (counter)
    li t0, 0           # s2 = max index (init to 0)
    lw t1, 0(s0)       # t1 = max value (init to array[0])
    
    # Move to next element
    addi s0, s0, 4
    addi s1, s1, -1


loop_continue:
    beq s1, zero, loop_end
    lw t2, 0(s0)
    ble t2, t1, skip_element   # if current value <= max value, skip

    # Update max index and value
    sub t3, a1, s1     # t3 = original_length - remaining = current index
    mv t0, t3          # update max index
    mv t1, t2          # update max value
    
skip_element:
    addi s0, s0, 4     # increment pointer by 4 bytes (int size)
    addi s1, s1, -1    # decrement counter
    j loop_continue

loop_end:
    # Epilogue
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    addi sp, sp, 12

    mv a0, t0
    jr ra

exit_bad_len:
    li a0, 36
    j exit

