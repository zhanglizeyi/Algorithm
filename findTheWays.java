import java.util.*;


public class findTheWays{


	public static int findWays(int v, int ci){
		
		//m(v,ci) = m(v-ci, ci) + m(v,ci-1)

		// if (ci.length ==0){
		// 	return 1;
		// }

		// int temp[] = new int[10];
		// int count = 0; 
		// for(int i=ci.length-1; i>=0; i--){
		// 	while(ci[i] < v && temp != v){
		// 		temp[i] += ci[i];
		// 	}

		// 	if(temp[i] == v){
		// 		count++;
		// 	}
		// }	
		int temp = findWays(v-ci,ci) + findWays(v,ci-1);

		return temp;
	}


	public static void main(String[] args){

		int[] c = {1,2};
		int V = 5;
		for(int i=c.length-1; i>=0; i++){		
			findWays(5,c[i]);
		}
	}
}