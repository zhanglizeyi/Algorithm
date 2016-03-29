import java.util.*;

public class maxSumList{

	public static int msl(int[] a,int size, int startIndex, int endIndex){

		//pass a to a new array list with new starting index and ending index
		//find the largest number in the list and restore to new list 
		//find second 
		//sum them up
		int sum = 0;
		if(size > (endIndex-startIndex)){
			System.out.println("in");
			return 0;
		}
		int maxIndex = endIndex - startIndex;
		int[] newArr = new int[endIndex - startIndex];
		for(int i=startIndex, j=0; i<endIndex,j<maxIndex; j++,i++){
			newArr[j] = a[i];
			System.out.println(newArr[j]);
		}

		int tempSum = 0;

		for(int i=0; i<maxIndex; i++){		
			for(int j=startIndex; j<size; j++){
				tempSum += a[j];
				System.out.println(tempSum);
			}
			if(tempSum > sum)
				sum = tempSum;
			System.out.println();
		}
		return sum;
	}

	public static void main(String[] args){
		int[] arr = {1,2,3,4,5,6,7,8,9,0,10};
		System.out.println(msl(arr,2,4,8));

	}
}