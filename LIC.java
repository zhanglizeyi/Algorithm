import java.util.*;


public class LIC{


	public static int LIC(int[] array){

		int count = 0;
		int max = 0;

		int n = array.length;
		int[] L = new int[n];

		for(int i=0;i<n; i++){
			max = 1;
			for(int j=0; j<i; j++){
				//System.out.println("array[j] " + array[j] + " array[i] "+ array[i]);
				if(array[j] < array[i]){
					if(max < L[j]+1){
						max = L[j]+1;
						//System.out.println(max);
					}
				}
			}
			System.out.println();
			System.out.println(max);
			L[i] = max;
		}
		return max;
	}

	public static void main(String[] args){
		int[] list = {0,8,2,12,4,10,6,14,1,9,5,13,3,11,7,15};
		//0 2 4 6 9 11 15

		System.out.print(LIC(list));
	}


}