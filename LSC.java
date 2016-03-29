import java.util.*;
import java.lang.Math;
import java.util.Scanner;

public class LSC{

	public static void main(String[] args){
		String x = "bcabd";
		String y = "bdcba";
		int M = x.length();
		int N = y.length();
		
		System.out.println("M length " + x.length() + " N length " + y.length());

		//opt[i][j] = length of LCS of x[i...M] and y[i...N]

		int[][] opt = new int[M+1][N+1];

		for(int i=M-1; i>=0; i--){
			for(int j=N-1; j>=0; j--){
				//System.out.print(opt[i][j]);
			}
			//System.out.println();
		}


		//compute length of LCS and all subproblems via dynamic programming
		for(int i=1; i<M; i++){
			for(int j=1; j<N; j++){
				if(x.charAt(i) == y.charAt(j)){
					opt[i][j] = opt[i-1][j-1]+1;
					
				}else{
					opt[i][j] = Math.max(opt[i-1][j], opt[i][j-1]);
				}
				//System.out.print(opt[i][j]);
			}
			//System.out.println();
		}

		for(int i=0; i<M; i++){
			for(int j=0; j<N; j++){
				System.out.print(opt[i][j]);
			}
			System.out.println();
		}

		//LCS itself and print it to standard output
		int i=0,j=0;
		while(i < M && j < N){
			if(x.charAt(i) == y.charAt(j)){
				System.out.print(x.charAt(i));
				i++;
				j++;
			}else if(opt[i+1][j] >= opt[i][j+1]){
				i++;
			}else{
				j++;
			}
		}
		System.out.println();
	}
}