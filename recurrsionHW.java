public class recurrsionHW{

	private void function(int n){
		if(n == 1) return;

		System.out.println("Hello Wrold" + (n/3));
		function(n/3);
		function(n/3);
		function(n/3);
	}

	public static void main(String[] args){
		int n = 30;
		recurrsionHW q = new recurrsionHW();
		q.function(n);

	}
}