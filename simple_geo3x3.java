public class simple_geo3x3 {
    public static void main(String[] args) {
        String code = Geo3x3.encode(35.65858, 139.745433, 14);
        System.out.println(code);
        double[] res = Geo3x3.decode("E9139659937288");
        System.out.println(res[0] + " " + res[1] + " " + res[2] + " " + res[3]);
    }
}
