import java.util.*;

public class findCellAndTower{

	public static void find(int[][] graph){

		int[][] rGraph = new int[graph.length][graph.length];
		for(int i=0; i<graph.length; i++){
			for(int j=0; j<graph.length; j++){
				rGraph[i][j] = 0;
			}
		}
		int countSize = 0;
		for(int i=0; i<graph.length; i++){
			for(int j=0; j<graph.length; j++){
				if(graph[i][j] <= 2){
					rGraph[i][j] = graph[i][j];
					countSize++;
				}
				System.out.print(rGraph[i][j]);
			}
			System.out.println();
		}
		int[] cell = new int[countSize];
		int[] tower = new int[countSize];
		for(int i=0; i<rGraph.length; i++){
			for(int j=0; j<rGraph.length; j++){
				if(rGraph[i][j] > 0){
					cell[i] = i+1;
					tower[i] = j+1;
					System.out.print(rGraph[i][j] + " index -> " + (i+1) +  " i "+ (j+1) + " j ");
					// System.out.println("this is cell " + cell[i] + " tower "+ tower[i]);
				}	
			}
			System.out.println();
		}

	}

	public static void main(String[] args){
		int[][] d = {{1,2,3,4,7},
					 {4,1,1,5,12},
					 {5,7,2,1,11},
					 {4,3,6,1,1},
					 {1,21,8,9,13}};
		find(d);
		}
}