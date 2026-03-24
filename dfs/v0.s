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

# Skip to main
j main

# Function to call DFS, pass a0 as index
dfs:    
    addi sp, sp, -16 # allocate 16 bytes
    sw ra, 12(sp) # return address
    sw s0, 8(sp) # frame ptr
    sw s1, 4(sp) # save `i`
    sw a0, 0(sp) # Save current node
    
    #####
    li a7, 1
    ecall    
    lw a0, 0(sp)    
    #####
       
       
    # Mark as visited
    la t1, visited
    add t1, t1, a0
    
    # visited[a0] = 1
    li t0, 1
    sb t0, 0(t1) 
    
    # i = s1
    li s1, 0 
    
    FOR: # check, use, increment
        la t1, nodes_count
        lw t1, 0(t1)
        
        bge s1, t1, FOR_EXIT
        
        # Calculate offset into adj, save address in t2
        # (a0 * MAX_NODES + s1) * WORD_SIZE
        li t2, MAX_NODES
        mul t2, a0, t2
        add t2, t2, s1
        slli t2, t2, 2 # ASSUMES WORD_SIZE IS 4
        
        # Load adj[a0][i] into t5
        la t4, adj
        add t4, t4, t2
        lw t5, 0(t4)
        
        # adj[a0][i] == 1
        li t6, 1
        bne t5, t6, CONTINUE
        
        # visited[i] != 0 : continue
        la t4, visited
        add t4, t4, s1
        lb t5, 0(t4)

        bne t5, zero, CONTINUE
                
        # dfs(i)
        mv a0, s1
        jal ra, dfs
        lw a0, 0(sp)
        
        CONTINUE:
        addi s1, s1, 1
        j FOR

    FOR_EXIT:
         # Restore stack
        lw ra, 12(sp)
        lw s0, 8(sp)
        lw s1, 4(sp)
        addi sp, sp, 16
        ret
    
.globl main
main:
    # 1. Initialize nodes_count = 5
    la t0, nodes_count
    li t1, 5
    sw t1, 0(t0)

    la t0, adj      # Base address of adjacency matrix
    li t1, 1        # Value to represent an edge

    # 2. Populate Edges
    sw t1, 4(t0)    # Edge 0 -> 1
    sw t1, 8(t0)    # Edge 0 -> 2
    sw t1, 52(t0)   # Edge 1 -> 3
    sw t1, 56(t0)   # Edge 1 -> 4
    sw t1, 96(t0)   # Edge 2 -> 4

    # 3. Call DFS starting at node 0
    li a0, 0
    jal ra, dfs

    # 4. Exit
    li a7, 93
    li a0, 0
    ecall











