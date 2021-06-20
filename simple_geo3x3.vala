/// valac simple_geo3x3.vala geo3x3.vala -X -lm -o simple_geo3x3
/// ./simple_geo3x3
void main (string[] args) {
    string code = Geo3x3.encode(35.65858, 139.745433, 14);
    stdout.printf ("%s\n",code);
    double[] res = Geo3x3.decode("E9139659937288");
    stdout.printf ("%.16f %.16f %.16f %.16f\n", res[0], res[1], res[2], res[3]);
}
