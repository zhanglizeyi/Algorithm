import java.util.*;

public class LCS{
	private int[][] L;

	public static int LCS(int[] X, int[] Y, int m, int n){



		if((m==0) || (n==0)){
			//System.out.print(0);
			return 0;
		}else if(X[m-1] == Y[n-1]){ 
			//System.out.print(1+LCS(X,Y,m-1,n-1));
			return 1+LCS(X,Y,m-1,n-1);
			
		}else{
			//System.out.print(Math.max(LCS(X,Y,m-1,n),LCS(X,Y,m,n-1)));
			return Math.max(LCS(X,Y,m-1,n),LCS(X,Y,m,n-1));
		}
	}

	public static void main(String[] args){

		int[] a = {1,2,4,3,5,8};
		int[] b = {12,3,4,1,2,4,3,8};

		System.out.println(LCS(a,b,a.length,b.length));
	}
}