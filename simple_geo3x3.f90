program main
  use geo3x3
  implicit none
  real pos(4)

  print *, geo3x3_encode(35.65858, 139.745433, 14)
  
  pos = geo3x3_decode("E9139659937288")
  print *, pos(1), pos(2), pos(3), pos(4)
end
