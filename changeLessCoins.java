import java.util.*;



public class changeLessCoins{

	public static int count(int S[], int m, int n){
		int i, j, x, y;

	    int table[][] = new int[n+1][m];

	    for (i=0; i<m; i++)
	        table[0][i] = 1;
	    for (i = 1; i < n+1; i++)
	    {
	        for (j = 0; j < m; j++)
	        {
	      
	            x = (i-S[j] >= 0) ? table[i - S[j]][j]: 0;

	            y = (j >= 1) ? table[i][j-1]: 0;

	            table[i][j] = x + y;
	        	System.out.print(table[i][j]);
	        }
	        System.out.println();
	    }
	    return table[n][m-1];

	}

	public static void main(String[] args){
		int arr[] = {1,3,4,5};
		

		// System.out.println(k);
		int m = arr.length;
		int n = 10;

		System.out.println(" answer " + count(arr,4,n));
	}

}