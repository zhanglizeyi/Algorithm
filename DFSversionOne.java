//undirected graph run DFS


/*
	set all node visited false
	pick a vertex v from graph

dfs(v)
	set v as visited 
	while()
		if(v has adjcent vertex && adjcent vertex is unvisited):
			dfs(adjcent vertex)


//without using recursion 
	dfs(){
		pick a node x ...
		push(x)
		visited[x] = true;

		while(stack != empty){
			n = node at stack top(peek only);

			nextNode = an unvisited node adj to n;

			if(nextNode exist){
				visited[nextNode] = true;
				push(nextNode)
			}else{
				pop();
			}
		}
	}		
*/

import java.util.*;

public class DFSversionOne{
	private static int[][] adj;
	private static int root;
	private static int ndoe;
	private static boolean[] visited;

	DFSversionOne(int n){
		ndoe 	= n;
		adj 	= new int[n][n];
		visited = new boolean[n];
	}

	//input of where should it start 
	public static void dfs(int i){
		visited[i] = true;  //set first one as true then print
		System.out.println(i);
		//check if adjcent vertices, if they do just call recursion function
		for (int j=0; j<visited.length;j++ ) {
			if(adj[i][j]>0 && visited[j] == false){
				dfs(j);
			}
		}
	}

	public static void main(String args[]){
		int[][] input = {{ 0, 1, 0, 1, 0, 0, 0, 0, 1 },
 						 { 1, 0, 0, 0, 0, 0, 0, 1, 0 },  // 1
						 { 0, 0, 1, 1, 0, 1, 0, 1, 0 },  // 2
						 { 1, 0, 1, 0, 1, 0, 0, 0, 0 },  // 3
						 { 0, 0, 0, 1, 0, 0, 0, 0, 1 },  // 4
						 { 0, 0, 1, 0, 0, 0, 1, 0, 0 },  // 5
						 { 0, 0, 0, 0, 0, 1, 0, 0, 0 },  // 6
						 { 0, 1, 1, 0, 0, 0, 0, 0, 0 },  // 7
						 { 1, 0, 0, 0, 1, 0, 0, 0, 0 }};

		//put the size into adjcent 
		int size = input.length;
		adj 	 = new int[size][size];
		visited  = new boolean[size];

		for(int i=0; i<size; i++){
			for(int j=0;j<size;j++){
				adj[i][j] = input[i][j];
				System.out.print(adj[i][j]);
			}
			System.out.println(" ");
		}

		for(int i=0; i<size; i++){
			visited[i] = false;
		}

		dfs(0);

	}
}