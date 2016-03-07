public class fordfulkersonDFS
{

/**
 * Creates the graph contained in the written exam of 31/05/12
 * and run the max-flow algorithm over it, printing the value
 * of the max-flow.
 */
public static void main(String[] args)
{
	
	// Create a graph with 6 nodes, represented through a matrix
  	int n=5;
	int[][] C = new int[n][];
	for (int i=0; i < n; i++) {
		C[i] = new int[n];
	}

	// Create an empty flow
	int[][] F = new int[n][];
	for (int i=0; i < n; i++) {
		F[i] = new int[n];
	}
	
	// Read the "numero di matricola"
	int[] x = new int[6];
	for (int i=0; i < 6; i++) {
		//x[i] = Integer.parseInt(args[0].substring(i,i+1));
	}
  
	// Adds capacities to edges
	C =   { {0, 2, 1, 0, 0, 0},
         	{0, 0, 0, 2, 0, 0},
         	{0, 0, 0, 0, 1, 0},
         	{0, 0, 0, 0, 0, 2},
         	{0, 0, 0, 0, 0, 2},
         	{0, 0, 0, 0, 0, 0}};

	// Run the flow algorithm
	flow(C,0,3,F);

	// Compute the total flow going out from the source and print it
	int tot = 0;
	for (int i=0; i < n; i++) {
		tot += F[0][i];
	}
	System.out.println(tot);
}

/**
 * Compute the max-flow using the Ford-Fulkerson algorithm and stores it in the matrix F.
 * @param C the capacity matrix
 * @param s the source node
 * @param t the sink node
 * @param F the flow matrix to be computed
 */
private static void flow(int[][] C, int s, int t, int[][] F)
{	
  // Visited array to perform DFS, initially empty
	boolean[] visited = new boolean[C.length];

	// Repeat until there is no path
	int count = 0;	
	while (dfs(C,F,s,t, visited, Integer.MAX_VALUE)>0) {
		count++;
		System.out.println(count);
		for (int i=0; i < C.length; i++){ 
			System.out.println("int i -> " + i);
			visited[i] = false;
		}
	}
	
}

/*
 * Performs a DFS starting from node i and trying to reach node t. Nodes already visited are
 * stored in the boolean vector visited.
 *  
 * @param C the capacity matrix; if capacity[x][y]>0, there is a directed edge between x and y
 * @param F the flow matrix to be computed
 * @param i the current node
 * @param t the sink node
 * @param visited the boolean set containing the nodes that have been visited
 * @param the smallest capacity found so far.
 * @returns the value of the additional flow found during this DFS, or 0 if there the sink
 * is not reachable from the source.
 */
private static int dfs(int[][] C, int[][] F, int i, int t, boolean[] visited, int min)
{
	// If sink has been reached, terminate
	if (i==t) {
		return min;
	}
	
	visited[i] = true;
	for (int j=0; j < C.length; j++) {
		if (C[i][j] > 0 && !visited[j]) {
			// For each adjacent node j that has not been visited...
			
			// Recursively perform the DFS, using the capacity of edge [i,j] if smaller than the
			// min found so far.
			int v = dfs(C, F, j, t, visited, Math.min(min, C[i][j]));
			
			// If v>0, we have found the sink, and v is the maximum value of the flow along the
			// path connecting the source and sink. We update both the capacities and the flow
			// accordingly.
			if (v > 0) {
				C[i][j] = C[i][j]-v;
				F[i][j] = F[i][j]+v;
				C[j][i] = C[j][i]+v;
				F[j][i] = F[j][i]-v;
				return v;
			}
		}
	}	
	// The sink has not been found.
	return 0;
}

}