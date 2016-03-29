/***********************************
 * ZE LI						   *
 *								   *
 * Greatest Common Divisor		   *
************************************/
#include <iostream>

using std::cin;
using std::cout;
using std::endl;

int gcd(int a, int b){
	return b == 0 ? a : gcd(b, a%b);
}

int main(){
	int x,y;

	cout<<"Enter first number: ";
	cin>> x;

	cout<<endl;
	cout<<"Enter second number: ";
	cin>>y;

	cout<<"The result is: "<< gcd(x,y)<<endl;

	return 0;
}