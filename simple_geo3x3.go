package main

import "fmt"
import "./geo3x3"

func main() {
    code := geo3x3.Encode(35.65858, 139.745433, 14)
    fmt.Printf("%s\n", code)
    
    pos := geo3x3.Decode("E9139659937288")
    fmt.Printf("%f %f %f %f\n", pos[0], pos[1], pos[2], pos[3]);
}
