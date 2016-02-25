import java.util.*;

public class Graph{

	private static int infinite = -9999;

	int[][] LinkCost;
	int NNode; 



	//set the graph of all the verteices as infinity...
	Graph(int[][] mat){
		NNode = mat.length; 

		LinkCost = new int[NNode][NNode];

		for(int i=0; i<NNode;i++){
			for(int j=0; j<NNode; j++){
				LinkCost[i][j] = mat[i][j];

				if(LinkCost[i][j] == 0){
					LinkCost[i][j] = infinite;
				}
			}
		}

		for(int i=0; i<NNode; i++){
			for(int j=0; j<NNode; j++){
				if(LinkCost[i][j] < infinite){
					System.out.print(" "+LinkCost[i][j]+" ");
				}else{
					System.out.print(" * ");
				}
			}
			System.out.println();
		}
	}

	public int unReached(boolean[] r){
		boolean done = true;
		for(int i=0; i<r.length; i++)
			if(r[i] == false){
				return i;
			}	
		return -1;
	}

	public void Prim(){
		int i, j, k, x, y;

		boolean[] Reached = new boolean[NNode]; 
		int[] predNode = new int[NNode];

		//Start at a vertex, I picked the start node = 0

		Reached[0] = true;
		//other verticed are not reached

		for(k=1; k<NNode; k++){
			Reached[k] = false;
		}

		predNode[0] = 0;  //no edge for node 0

		x=y=0;
	
		for(i=0; i<NNode; i++){
			for(j=0;j<NNode;j++){
				if(Reached[i] && !Reached[j] && LinkCost[i][j]>LinkCost[x][y]){
					x = i;
					y = j;
				}
			}

			System.out.println("Min cost edge:( " + x + "," + y + ")" + "cost =" + LinkCost[x][y]);
		}

		predNode[y] = x; //record the min cost link
		Reached[y] = true;
	}

}