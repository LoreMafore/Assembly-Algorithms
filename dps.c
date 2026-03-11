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
    nodesCount = 5;

    adj[0][1] = 1; adj[1][0] = 1;
    adj[0][2] = 1; adj[2][0] = 1;
    adj[1][3] = 1; adj[3][1] = 1;
    adj[1][4] = 1; adj[4][1] = 1;

    for (int i = 0; i < nodesCount; i++) {
        visited[i] = false;
    }

    printf("Starting DFS from vertex 0:\n");
    dfs(0);

    return 0;
}
