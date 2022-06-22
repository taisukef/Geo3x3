import geo3x3

fun main()
  geo3x3_encode(35.65858, 139.745433, 14).println
  val (lat,lng,level,unit) = geo3x3_decode("E9139659937288")
  lat.print; " ".print; lng.print; " ".print; level.print; " ".print; unit.print; " ".println;

