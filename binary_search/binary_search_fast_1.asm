.data
array: .word 2,5,8,12,16,23,38,45,67,91  #data[] = {2,5,8,12,16,23,38,45,67,91}
size: .word 10                           #size that we will pass into binary search

.text
main: 
    #la = load address
    la a0, array    #a0 = #data[]
    lw a1, size     #a1 = size
    li a2, 23       #a2 = 23 -> target = 23 
    call binary_search
    li a7, 10 
    ecall 

#int binary_search(int* array, int size, int target)
binary_search:
    #removed the stack
    mv t4, a0       #int* base = array
    li t0, 0        # int low = 0
    addi t1, a1, -1 #int  high = size -1 
    mv t5, a2       #int target = target

#while loop
loop:
    blt t1, t0, not_found   #if (high < low) -> not found
    add t2, t0, t1          #int mid = low + high
    srai t2, t2, 1          #mid = mid/2
    slli t3, t2, 2 
    add t3, t4, t3 
    lw t3, 0(t3)            #int val = array[mid]
    beq t3, t5, found       #if(val == target) -> found
    blt t3, t5, add_right   #if(val < target) -> add_right

minus_left:             # else (val < target)
    addi t1, t2, -1     # low = mid + 1
    j loop              

add_right:              #val > target
    addi t0, t2, 1      #low = mid - 1 
    j loop              

found: 
    mv a0, t2
    ret

not_found:
    li a0, -1
    ret
