class Simple_geo3x3 {
    static public function main(): Void {
        final code = Geo3x3.encode(35.65858, 139.745433, 14);
        Sys.println(code);
        final pos = Geo3x3.decode("E3793653391822");
        Sys.println(pos);
    }
}
