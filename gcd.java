/******************************
*ZE LI 						  *
*							  *
*Greatest Common Divisor	  *
*******************************/

import java.util.Scanner;
import static java.lang.System.*;

public class gcd{

	private static int gcd(int a, int b){
		int d;
		int r;

		if(a == 0 || b ==0){
			return a+b;
		}else{
			return gcd(b, a%b); 
		}
	}

	public static void main(String[] args){
		
		out.println("Enter a: ");
		Scanner input1 = new Scanner(System.in);
		int a = input1.nextInt();
		
		out.println("\nEnter b:");
		Scanner input2 = new Scanner(System.in);
		int b = input2.nextInt();
		gcd(a, b);


		out.println("The gcd is -> " + gcd(a,b));

	}
}