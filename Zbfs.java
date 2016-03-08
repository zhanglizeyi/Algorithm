import java.util.*;

public class Zbfs{



			//create queue Q and add v to it 
		//create an array A to keep track of checkec vertices

		//while Q is not empty 
			// remove vertex V from the queue
			// for every child C connected to parent vertex 
				//if the child has not been checked
					//connect child C to parent V
					//Mark C as checked
					//add child C to Q

	public static int bfs(int[][] graph, int s){
		//create an array where keep track of parent-child connection 
		boolean visited[] = new boolean[graph.length];//defined check visited
		int countVertices = 0;
		
		Queue<Integer> q = new LinkedList<Integer>();
		visited[s] = true;
		q.add(s); 

		while(!q.isEmpty()){
			int temp = q.poll();
			for(int j=0; j<graph.length; j++){
				if(graph[temp][j] > 0 && visited[j] == false){
					System.out.println("this is the graph "+ graph[temp][j]);
					q.add(j);
					visited[j] = true;
					countVertices += graph[temp][j];
				}
			}
			System.out.println("each layer " + temp);
		}
		return countVertices;
	}


	public static void main(String[] args){
						//a b c d e f 
 		int[][] input = {{0,3,2,0,0,0},
						 {0,0,0,1,0,0},
						 {0,0,0,0,2,0},
						 {0,0,0,0,0,3},
						 {0,0,0,0,0,5},
						 {0,0,0,0,0,0}};
		//System.out.println(input.length);

		System.out.println(bfs(input,0));	
	}

}