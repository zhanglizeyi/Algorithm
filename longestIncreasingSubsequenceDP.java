import java.util.*;

public class longestIncreasingSubsequenceDP{


	//give a whtever the list[]
	//make a number to take the max Longest incres sub
	//loop from i and loop from i+1
	//check 0 and 0+1 step to find if [0] < [0+1]
	//then len will increase by 1 
	//otherwise stay pervious step 

	public static int LIS(int list[]){
		
		int a[] = new int[list.length];
		int maxL = 1;
	
		for(int i=0; i<list.length; i++){
			a[i] = 1; //initial if no bigger increasing num then 1
			for(int j=0; j<i; j++){
				//condition here
				//check the num from 0 to j less than i 
				//System.out.println("list[j] " +list[j]+ " <= " + " list[i] " +list[i] );
				//System.out.println("a[j]+1 " +(a[j]+1) + " > " + "list[i] " +a[i] );
				if(list[j] <= list[i] && a[j]+1 > a[i]){
					a[i] = a[j]+1;
				}

			}
			if(a[i] > maxL){
				maxL = a[i];
			}
			System.out.println(maxL);
		}
		return maxL;
	}

	public static void main(String[] args){

		int l[] = {0,8,2,12,4,10,6,14,1,9,5,13,3,11,7,15};

		System.out.println(LIS(l));
	}

}