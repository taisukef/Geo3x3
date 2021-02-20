using System;

public class HelloWorld {
    static public void Main() {
        String code = Geo3x3.encode(35.65858, 139.745433, 14);
        Console.WriteLine(code);
        double[] res = Geo3x3.decode("E3793653391822");
        Console.WriteLine(res[0] + " " + res[1] + " " + res[2] + " " + res[3]);
    }
}
