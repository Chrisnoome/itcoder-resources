package greeter;

// Greets a pupil and adds up three marks.
public class Greeter {

  // Adds up three marks.
  // aFirst  - the first mark
  // aSecond - the second mark
  // aThird  - the third mark
  // Gives back: the sum of the three
  public static int total(int aFirst, int aSecond, int aThird) {
    return aFirst + aSecond + aThird;
  } // total

  public static void main(String[] args) {
    String name = "Thabo";
    System.out.println("Hello, " + name);
    System.out.println("Total: " + total(67, 72, 58));
  } // main
} // class Greeter
