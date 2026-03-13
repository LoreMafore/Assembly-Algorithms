
.data
array: .word 2,5,8,12,16,23,38,45,67,91  #data[] = {2,5,8,12,16,23,38,45,67,91}
size: .word 10 #size that we will pass into binary search

main: 
    #la = load address
    la a0, array #a0 = #data[]
    lw a1, size #a1 = size
    li a2, 23 #a2 = 23 -> target = 23 
    call binary_search
    #exit()
    li a7, 10 
    ecall 

#int binary_search(int* array, int size, int target)
binary_search:
    addi sp, sp -16
    sw ra, 12(sp) #return address
    sw s0, 8(sp)
    sw s1, 4(sp)
    sw s2, 0(sp)
    mv s2, a0 #int* base = array
    li s0, 0 # int low = 0
    addi s1, a1, -1 #int  high = size -1 
    mv t0, a2 #int target = target

#while loop
loop:
    blt s1, s0, not_found #if (high < low) -> not found
    add t1, s0, s1 








not_found:
    li a0, -1
    
