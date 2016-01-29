import java.util.*;

public class DFS{

	int [][] adj;
	int 	 rootNode = 0;
	int 	 nnode;

	boolean[] visited;

	DFS(int n){
		nnode = n; //input 
		adj = new int[n][n];
		visited = new boolean[n];

	}

	DFS(int[][] m){
		nnode 	= m.length;
		System.out.println("length -> "+ nnode);
		adj 	= new int[nnode][nnode];
		visited = new boolean[nnode];


		for(int i=0;i<nnode;i++){
			for(int j=0;j<nnode;j++){
				adj[i][j] = m[i][j];
			}
		}
	}

	public void dfs(int i){
		visited[i] = true;
		System.out.println(i);
		for(int j=0;j<visited.length;j++){
			if(adj[i][j] >0 && !visited[j]){
				dfs(j);
			}
		}
	}

	public void clearVisited(){
		for(int i=0;i<visited.length;i++){
			visited[i] = false;
		}
	}

public static void main(String[] args){

		int[][] conn = {{ 0, 1, 0, 1, 0, 0, 0, 0, 1 },
 						{ 1, 0, 0, 0, 0, 0, 0, 1, 0 },  // 1
						{ 0, 0, 0, 1, 0, 1, 0, 1, 0 },  // 2
						{ 1, 0, 1, 0, 1, 0, 0, 0, 0 },  // 3
						{ 0, 0, 0, 1, 0, 0, 0, 0, 1 },  // 4
						{ 0, 0, 1, 0, 0, 0, 1, 0, 0 },  // 5
						{ 0, 0, 0, 0, 0, 1, 0, 0, 0 },  // 6
						{ 0, 1, 1, 0, 0, 0, 0, 0, 0 },  // 7
						{ 1, 0, 0, 0, 1, 0, 0, 0, 0 }};

		DFS g = new DFS(conn);
		g.clearVisited();
		g.dfs(2);
	}
}