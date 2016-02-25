import java.util.*;

public class findOption{

	public static void main(String[] args){
		int[] finishTime = {13,7,8,5,10,14,12,2,16,17};
		int[] startTime  = {11,2,6,3,4,9,8,1,12,15};
		int[] option = new int[startTime.length];
		for(int i=0; i<finishTime.length; i++){
			for(int j=0; j< startTime.length; j++){
				if(finishTime[i]< startTime[j]){
					option[i]++;
				}
			}
		}


		for(int i=0;i<option.length; i++){
			System.out.println("This is the option " + i + " " + option[i]);
		}

	}

}