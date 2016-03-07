import java.util.*;
import java.util.LinkedList;
import java.util.Queue;

public class fordFulkersonBFS {
	public static int V = 6;

	//recieve a 2D graph and source point and sink point
	//directed graph 
	//source node
	//sink node
	//max flow
	public static int fordFulkersonBFS(int graph[][], int s, int t){
		int rGraph[][] = new int[V][V];
		for(int i=0; i<V; i++){
			for(int j=0; j<V; j++){
				rGraph[i][j] = graph[i][j];
			}
		}

		int MaxFlow = 0;
		int parent[] = new int[V];
		while(bfs(rGraph, s, t, parent)){
			int minflow = Integer.MAX_VALUE;

			for(int v=t; v!=s; v=parent[v]){
				int u = parent[v];
				minflow = Math.min(minflow,rGraph[u][v]);
			}

			for(int v=t; v!=s; v=parent[v]){
				int u = parent[v];
				rGraph[u][v] -= minflow;
				rGraph[v][u] += minflow;
			}
			MaxFlow += minflow;
		}
		return MaxFlow;
	}	

	public static boolean bfs(int[][] graph, int s, int t, int[] parent){
		boolean visited[] = new boolean[V];
		Queue<Integer> queue = new LinkedList<Integer>();
		queue.add(s);
		visited[s] = true;

		while(queue.size() > 0){
			int top = queue.poll();
			for(int i=0; i<V; i++){
				if(!visited[i] && graph[top][i]>0){
					queue.add(i);
					visited[i] = true;
					parent[i] = top;
				}
			}
		}
		return visited[t] == true;
	}

	public static void main(String[] args){
         int graph[][]={{0, 2, 1, 0, 0, 0},
         				{0, 0, 0, 2, 0, 0},
			         	{0, 0, 0, 0, 1, 0},
			         	{0, 0, 0, 0, 0, 2},
			         	{0, 0, 0, 0, 0, 1},
			         	{0, 0, 0, 0, 0, 0}};   
         int V = graph.length;
         System.out.println(fordFulkersonBFS(graph, 0, 5)); 

	}
}