int main(int argc, array(string)argv) {
    write("%s\n", .Geo3x3.encode(35.65858, 139.745433, 14));

    array(float) pos = .Geo3x3.decode("E9139659937288");
    write("%f %f %f %f\n", pos[0], pos[1], pos[2], pos[3]);
    return 0;
}
