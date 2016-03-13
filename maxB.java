import java.util.*;

public class maxB{

	private static int matchL[]; // 
	private static int matchR[]; 
	private static boolean seen[];
	private static boolean[][] graph;

	public static int maximumMatch(int m, int n){

		for(int i=0; i<m; i++){
			matchL[i] = -1;
		}
		for(int j=0; j<n; j++){
			matchR[j] = -1;
		}

		int count=0;
		for(int i=0; i<m; i++){
			seen[i] = false;
			if(bpm(i)){count++;}
		}
		return count;
	}

	public static boolean bpm(int a){
		for(int i=0; i<5; i++){
			if(!graph[a][i] || seen[i]){
				seen[i] = false;
			}
			if(matchR[i]==-1 || bpm(matchR[i])){
				matchL[a] = i;
				matchR[i] = a; // assign them -> <- both side 
				return true;
			}
		}
		return false;
	}

	public static void main(String[] args){
		int m = 5;
		int n = 5;
		System.out.println(maximumMatch(m,n));
	}

}