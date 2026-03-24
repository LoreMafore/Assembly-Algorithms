
= Version 0 (`v0.s`)
This version contains a lot of data hazards.
There are a lot of easy performance optimizations that can be made.
During the FOR loop, there are redundant loads to `t1` from `nodes_count` and `0(t1)`, these could be optimized outside of the loop boundary.
Likewise `la t4, adj` and `la t4, visited` are called in the loop but could be moved outside the loop.
An obvious data hazard is the load of `nodes_count` and the immediate bge, resulting in a stall.
The use of the mul instruction is also not optimal.

At the moment, debug code for printing also exists, so removing this should increase performance.

This early version takes 745 cycles, with an IPC of 0.765.