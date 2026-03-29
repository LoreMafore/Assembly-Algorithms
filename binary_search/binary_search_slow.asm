.data
arr:    .word   2, 5, 8, 12, 16, 23, 38, 56, 72, 91
msg:    .string "Index: "

.text
.globl main

main:
    la   a0, arr        # a0 = base address
    li   a1, 10         # a1 = length
    li   a2, 23         # a2 = target value
    
    jal  ra, binarySearch
    
    mv   t0, a0         # Save result in t0
    li   a7, 10         # Ripes/Venus Syscall 10: Exit
    ecall

binarySearch:
    li   t0, 0          # t0 = low = 0
    addi t1, a1, -1     # t1 = high = len - 1

loop:
    bgt  t0, t1, not_found  # if low > high, exit loop
    
    # Calculate Mid: mid = (low + high) / 2
    add  t2, t0, t1     # t2 = low + high
    srai t2, t2, 1      # t2 = (low + high) >> 1 (integer division)
    
    # Load arr[mid]
    slli t3, t2, 2      # t3 = mid * 4 (offset)
    add  t3, a0, t3     # t3 = base + offset
    lw   t4, 0(t3)      # t4 = arr[mid]
    
    # Compare target (a2) with arr[mid] (t4)
    beq  a2, t4, found      # if target == arr[mid]
    blt  a2, t4, go_left    # if target < arr[mid]
    
    # Target is in right half: low = mid + 1
    addi t0, t2, 1
    j    loop

go_left:
    # Target is in left half: high = mid - 1
    addi t1, t2, -1
    j    loop

found:
    mv   a0, t2         # Return mid
    ret

not_found:
    li   a0, -1         # Return -1
    ret
