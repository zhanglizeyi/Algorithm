#include <stdio.h>
#include <stdlib.h>

struct init{

	int size = 10;
	static int middle;
};

int main(){
	int arrSize = init.size;

	int arr[arrSize] = {5, 7, 8, 9 , 20, 21, 54, 67, 89, 93};

	binary_search(arr,0,arrSize,20);
}

int binary_search(int arr[], int low, int high, int elemt){
	if(low > high) return -1;
	middle  = (low + high)/2;
	if (arr[middle] == elemt) return middle;
	else if(arr[middle] < elemt){
		return binary_search(arr, middle+1, high, elemt);
	}else{
		return binary_search(arr,low,middle-1,elemt);
	}
}