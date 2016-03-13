import java.util.*;

public class Zdfs{

	public static void dfs(int[][] graph, int s){
		int countV=0;
		//stack 
		Stack<Integer> stack = new Stack<Integer>();
		boolean[] visited = new boolean[graph.length];
		visited[s] = true;
		stack.push(s);

		while(!stack.isEmpty()){
			int temp = stack.peek(); //take the first vertice
			int j=0;

			for(j=0; j<graph.length; j++){
				if(graph[temp][j]>0 && visited[j]==false){
					visited[j] = true;//visited is true
					stack.push(j);//put into stack
					System.out.println("the index "+j+" graph "+ graph[temp][j]);
					break; //after visited jump out the loop
				}
			}
			System.out.println();
			if(j == graph.length){
				stack.pop();
			}
		} 
	}

	public static void dfsRec(int[][] graph, int s){
		System.out.println("source -> \n" + s);
		boolean[] visited = new boolean[graph.length];
		visited[s] = true;

		for(int i=0; i<graph.length; i++){
			if(graph[s][i]>0 && visited[i]==false){
				System.out.println("the row " + i + " graph " + graph[s][i]);
				dfsRec(graph, i);
			}
		}
	}

	public static void main(String[] args){
						//s a b c d e f 
		int[][] input = {{0,1,4,0,0,0,0},
						 {0,0,0,2,0,0,0},
						 {0,0,0,0,0,0,0},
						 {0,0,0,0,3,0,0},
						 {0,0,0,0,0,5,0},
						 {0,0,0,0,0,0,6},
						 {0,0,0,0,0,0,0}};

		System.out.println("length -> " + input.length);
		dfs(input, 0);
		//dfsRec(input,0);
	}
}







