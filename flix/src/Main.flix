def main(_args: Array[String]): Int32 & Impure =
    println(Geo3x3.encode(35.65858, 139.745433, 14));
    println(Geo3x3.decode("E9139659937288"));
    0
