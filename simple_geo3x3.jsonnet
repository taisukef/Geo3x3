local geo3x3 = (import "geo3x3.libsonnet");
{
  enc: geo3x3.encode(35.65858, 139.745433, 14),
  dec: geo3x3.decode("E9139659937288")
}
