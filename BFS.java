import java.util.*;

public class BFS{

	static int[][] M;
	static int root = 0;
	static int node;

	static boolean[] visited;

	BFS(int N){
		M = new int[N][N];
		node = N;
		visited = new boolean[N];
	} 

public void bfs(){
	Queue<Integer> q = new LinkedList<Integer>();

	q.add(root);
	visited[root] = true;

	while(!q.isEmpty()){
		int n, child;
		child = 0;
		n = (q.peek()).intValue();
		
		for(int i=0; i<node; i++){
			if(M[n][i] > 0){
				if(!visited[i]){
					child = i;
				}
			}
		}
		
		if(child != -1){
			visited[child] = true;
			q.add(child);
		}else{
			q.remove();
		}
	}
	for(int i=0; i<node;i++){
		visited[i] = false;
	}
}

public static void main(String[] args){
	int[][] input = {{ 0, 1, 0, 1, 0, 0, 0, 0, 1 },
					 { 1, 0, 0, 0, 0, 0, 0, 1, 0 },  // 1
					 { 0, 0, 1, 1, 0, 1, 0, 1, 0 },  // 2
					 { 1, 0, 1, 0, 1, 0, 0, 0, 0 },  // 3
					 { 0, 0, 0, 1, 0, 0, 0, 0, 1 },  // 4
					 { 0, 0, 1, 0, 0, 0, 1, 0, 0 },  // 5
					 { 0, 0, 0, 0, 0, 1, 0, 0, 0 },  // 6
					 { 0, 1, 1, 0, 0, 0, 0, 0, 0 },  // 7
					 { 1, 0, 0, 0, 1, 0, 0, 0, 0 }};

	int i,j; 

	node = M.length;
	M = new int[node][node];
	visited = new boolean[node];

	for(i=0;i<node;i++){
		for(j=0;j<node;j++){
			M[i][j] = input[i][j];
		}
	}
}

}