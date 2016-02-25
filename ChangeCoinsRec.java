import java.util.Scanner;
import java.util.*;

public class ChangeCoinsRec {

	public static void count(int moneny, int[] c){
		int min[] = new int[moneny];

		for(int i=0; i<moneny; i++){
			min[i] = 9999;
		}

		min[0] = 0;

		for(int i=0; i<moneny;i++){

			for(int j=0; j<c.length; j++){
				if(c[j] <= i && min[i-c[j]]+1 < min[i]){
					min[i] = min[i-c[j]]+1;
				}
			}
		}
		for(int i=0;i<min.length; i++){
			System.out.println(i + " " +min[i]);
		}
	}

   	public static void main(String[] args){
   		int coins[] = {1,3,5,8}; 

   		count(100,coins); 
   	}

}