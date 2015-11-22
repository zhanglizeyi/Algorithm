import java.util.Scanner;

public class check_Prime{
	private int variable=0; 

	private int Intprime(int input){
		if(input == 2){
			return 2;
		}else if(input < 2){
			return 0;
		}else{
			for(int i=2; i<input; i++){
				variable = input%i; 
				if(variable == 0){
					return variable;
				}
			}
			return variable;
		}
	}
	

	private boolean prime(int x){
		for(int i=2;i<x; i++){
			if(x%i == 0){
				return false;
			}
		}
		return true;
	}

	public static void main(String[] args){

		Scanner readIn = new Scanner(System.in);
		System.out.println("Enter a number: ");
		int input = readIn.nextInt();

		check_Prime new_Class = new check_Prime();

		System.out.println(new_Class.Intprime(input));
		System.out.println(new_Class.prime(input));
	}
}