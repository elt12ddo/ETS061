package task1;

import java.util.Random;

public class Test {
	static Random slump = new Random();

	public static void main(String[] args) {
		int c = 0;
		for(int k = 0; k < 20; k++){
			System.out.println((-2.1)*Math.log(1.0-slump.nextDouble()));//ankomsttider skumma?
		}
	}

}
