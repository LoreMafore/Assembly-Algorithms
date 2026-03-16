.equ MAX_NODES, 10
.equ WORD_SIZE, 4
    
.bss
.align 2
adj:
    .zero (MAX_NODES * MAX_NODES * WORD_SIZE)
visited:
    .zero MAX_NODES # u8[]
nodes_count:
    .word 0
.text

dfs:
    # a0 ; Arg 0
    
    addi sp, sp, -16 # allocate 16 bytes
    sw ra, 12(sp) # return address
    sw s0, 8(sp) # frame ptr
    sw s1, 4(sp) # save `i`
    

    # visited[a0] = 1
    la t1, visited
    add t1, t1, a0
    li t0, 1
    sb t0, 0(t1)

        
    # t0 = i, t2 = nodes_count
    li s1, 0
    lw t1, nodes_count
    lw t2, 0(t1)
    
    FOR: # check, use, increment
        addi t0, t0, 1
        bge t0, t2, FOR_EXIT

        
        # push i onto stack prior to dfs()
        # push a0 onto the stack
        # push ra onto the stack

    FOR_EXIT:
    

main:
    
