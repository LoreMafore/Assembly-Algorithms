#include <stdio.h>
#include <stdbool.h>

#define MAX_NODES 10

int adj[MAX_NODES][MAX_NODES];
bool visited[MAX_NODES];
int nodesCount;

void dfs(int vertex) {
    visited[vertex] = true;
    printf("Visited %d\n", vertex);

    for (int i = 0; i < nodesCount; i++)
    {
        if (adj[vertex][i] == 1 && !visited[i]) {
            dfs(i);
        }
    }
}

int main() {
    nodesCount = MAX_NODES;

    adj[0][1] = 1; adj[1][0] = 1;
    adj[0][2] = 1; adj[2][0] = 1;
    adj[1][3] = 1; adj[3][1] = 1;
    adj[1][4] = 1; adj[4][1] = 1;
    adj[2][5] = 1; adj[5][2] = 1;
    adj[5][6] = 1; adj[6][5] = 1;
    adj[4][6] = 1; adj[6][4] = 1;
    adj[3][7] = 1; adj[7][3] = 1;
    adj[6][8] = 1; adj[8][6] = 1;
    adj[8][9] = 1; adj[9][8] = 1;

    for (int i = 0; i < nodesCount; i++) {
        visited[i] = false;
    }

    printf("Starting DFS from vertex 0:\n");
    dfs(0);

    return 0;
}



/* 
 This looks like this:

      (0)
     /   \
   (1)---(2)
   / \     \
 (3) (4)---(5)
  |    \   /
 (7)    (6)
         |
        (8)
         |
        (9)


result =:

0,1,3,7,4,6,5,2,8,9
 * */

