#include <stdio.h>
#include <stdlib.h>
#include <string.h>



int compare(char *a, char *b){

	printf("this is a  %s %s %s %s\n", a, b, &a, &b);
	while(*a && (*a==*b)){
		a++,b++;
	}
	return (*a-*b);
}

int main(){
	printf("return -> %d \n", compare("hello","hello0"));
	return 0;
}