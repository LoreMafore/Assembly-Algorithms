.data
array: .word 2,5,8,12,16,23,38,45,67,91
size: .word 10

.text
main: 
    la a0, array        # a0 = array
    lw a1, size         # a1 = size
    li a2, 23           # ← moved here to FILL the load-use stall slot after lw a1
    call binary_search
    li a7, 10 
    ecall 

binary_search:
    addi sp, sp, -16
    sw ra, 12(sp)
    sw s0, 8(sp)
    sw s1, 4(sp)
    sw s2, 0(sp)
    mv s2, a0           # base = array
    li s0, 0            # low = 0
    addi s1, a1, -1     # high = size - 1
    mv t0, a2           # target = a2

loop:
    add t1, s0, s1      # ← moved ABOVE branch: compute mid early (independent of branch)
    blt s1, s0, not_found
    srai t1, t1, 1      # mid = (low+high)/2 - ready since computed before branch
    slli t2, t1, 2      # mid * 4 (byte offset)
    add t2, s2, t2      # address = base + offset
    lw t3, 0(t2)        # load array[mid] EARLY
    addi t4, t1, 1      # ← pre-compute mid+1 (for add_right) while waiting on lw
    beq t3, t0, found   # t3 now has had 1 instruction to load - reduced stall
    addi t5, t1, -1     # ← pre-compute mid-1 (for minus_left) fills stall slot
    blt t3, t0, add_right

minus_left:
    mv s1, t5           # high = mid - 1 (already computed above!)
    j loop              

add_right:
    mv s0, t4           # low = mid + 1 (already computed above!)
    j loop              

found: 
    mv a0, t1
    j restore

not_found:
    li a0, -1

restore:
    lw ra, 12(sp)
    lw s0, 8(sp)        # ← moved load earlier, stagger them to pipeline
    lw s1, 4(sp)
    lw s2, 0(sp)
    addi sp, sp, 16
    ret
