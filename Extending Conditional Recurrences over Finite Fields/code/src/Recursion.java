/**
 * 
 */

/**
 * @author Robert
 *
 */
public class Recursion {

	int[] ics;
	int[][] coefs;
	int field;

	public Recursion(int[] ic, int[][] coefs, int field) {
		this.ics = ic;
		this.coefs = coefs;
		this.field = field;
	}
	
	public Recursion(int[] ic, int[][] coefs) {
		this.ics = ic;
		this.coefs = coefs;
		this.field = Integer.MAX_VALUE;
	}

    public long R(int n) {
        int sum = 0;
    	if (n < this.ics.length) {
        	sum += ics[n]; // return the initial condition at n
    	} else {
    		
    		// we need to find out what n is mod i
    		for (int i=0; i!=this.coefs.length; i++) { 
    			if (n%this.coefs.length==i) {
    				// n is equivalent to i
    				// now we just take the sum over the recursive terms
    				int coef; long rterm;
    				for (int j=0; j!=this.coefs[i].length; j++){
    					coef  = this.coefs[i][j];
    					rterm = R(n-1-j);
    					sum += coef*rterm;
    				}
	        	}
	        }
    	}
    	int modSum=sum%field;
    	return modSum;
    }
    
    public static void A068911() {
		int[] A068911_ics = new int [] {1,2,4};
		int[][] A068911_coefs = new int [][] {{1,1,0},{1,1,1}};
		Recursion A068911 = new Recursion(A068911_ics, A068911_coefs);
		for (int i=0; i!=25; i++){
			System.out.println(A068911.R(i));
		}
    }
    
    public static void A068911_fixed() {
		int[] A068911_ics = new int [] {1,2};
		int[][] A068911_coefs = new int [][] {{2,0},{1,1}};
		Recursion A068911 = new Recursion(A068911_ics, A068911_coefs);
		System.out.println("A068911_fixed -- 1,2");
		System.out.print(String.format("Field=%s:\t", "R"));
		for (int i=0; i!=25; i++){
			System.out.print(A068911.R(i));
			System.out.print("\t");
		} System.out.print("\n");
    }
	
	private static void fibpeltri() {
		int[] fibpeltri_ics = new int [] {0,1,2};
		int[][] fibpeltri_coefs = new int [][] {{1,1,1},{1,1,0},{2,1,0}};
		Recursion fibpeltri = new Recursion(fibpeltri_ics, fibpeltri_coefs);
		System.out.println("Fibonacci-Pell-Tribonacci -- 0,1,2");
		System.out.print(String.format("Field=-:\t"));
		for (int i=0; i!=25; i++){
			System.out.print(fibpeltri.R(i));
			System.out.print("\t");
		} System.out.print("\n");
	}
    
	private static void A111() {
		int[] A111_ics = new int [] {0,1,2};
		int[][] A111_coefs = new int [][] {{1,0,1},{0,1,1},{0,0,1}};
		Recursion A111 = new Recursion(A111_ics, A111_coefs);
		System.out.println("A111 -- 0,1,2");
		System.out.print(String.format("Field=-:\t"));
		for (int i=0; i!=25; i++){
			System.out.print(A111.R(i));
			System.out.print("\t");
		} System.out.print("\n");
	}
	
	private static void R(int[] ics, int[][] coefs, String name) {
		int[] fields = new int[] {2,3,4,5,7,8,9,11,13,16,17,19,23,25,27,29};
		System.out.println(String.format("%s", name));
		for (int f = 0; f != fields.length; f++) {
			int field = fields[f];
			System.out.print(String.format("Field=%s:\t", Integer.toString(field)));
			for (int i=0; i!=25; i++){
				Recursion A111 = new Recursion(ics, coefs, field);
				System.out.print(A111.R(i));
				System.out.print("\t");
			} System.out.print("\n");
		}
	}
	
	private static void print_n() {
		System.out.print(String.format("Term #:\t\t", "-"));
		for (int i=0; i!=25; i++){
			System.out.print(i);
			System.out.print("\t");
		} System.out.print("\n");
	}
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {

//		A111();		
//		

		
		print_n();
		
		// Fibonacci - Pell - Tribonacci
		fibpeltri();
		
		// A068911_fixed Field
//		A068911();
		R(new int[] {1,2}, new int[][] {{2,0},{1,1}}, "A068911_fixed Field");
		
		// A111 Field
		R(new int[] {0,1,2}, new int [][] {{1,0,1},{0,1,1},{0,0,1}}, "A111");
	}
}
