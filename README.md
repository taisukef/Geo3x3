Geo3x3 ver 1.03
======

## What is Geo3x3
geo zone encoding  
(JavaScript / TypeScript / C / C++ / C# / Swift / Java / Python / Ruby / PHP/ Go / Kotlin / Dart / Rust)  

## Sample app
https://taisukef.github.io/Geo3x3/  

## Creator
Taisuke Fukuno  
http://twitter.com/taisukef  
http://fukuno.jig.jp/139  
http://fukuno.jig.jp/205  
https://fukuno.jig.jp/3131  

## Licence
CC0  
https://creativecommons.jp/sciencecommons/aboutcc0/  

## Doc
recursive divisiton 3x3(9th)  
			East  West  
	North 1 2 3 1 2 3  
			4 5 6 4 5 6  
	South 7 8 9 7 8 9  
	(0 = dummy)  
	origin = lat 90, lng 0 -> lat -90, lng 90(E) -90(W)  
divide the earth to two (West or East)  
	W5555555 = level 8  
	E1384700 = level 6  
	longer is more in detail  

## How to use

### in HTML
```
<script type=module>
import { Geo3x3 } from "https://taisukef.github.io/Geo3x3/Geo3x3.mjs";
console.log(Geo3x3.decode("W28644"));
</script>
```

### in JavaScript (Deno)
```
import { Geo3x3 } from "https://taisukef.github.io/Geo3x3/Geo3x3.mjs";
console.log(Geo3x3.decode("W28644"));
```
to run (JavaScript)
```
deno run -A simple_geo3x3.mjs
```

### in JavaScript (Node.js)
```
import { Geo3x3 } from "./Geo3x3.mjs";
console.log(Geo3x3.decode("W28644"));
```
to run (TypeScript)
```
node simple_geo3x3.mjs
```

### in TypeScript (Deno)
```
import { Geo3x3 } from "https://taisukef.github.io/Geo3x3/Geo3x3.ts";
console.log(Geo3x3.decode("W28644"));
```
to run (TypeScript)
```
deno run simple_geo3x3.ts
```

### in Python
```
import geo3x3
## get Geo3x3 code from latitude / longitude / level
code = geo3x3.encode(35.65858, 139.745433, 14)
print(code) # E3793653391822

## get location from Geo3x3 code
pos = geo3x3.decode('E3793653391822')
print(pos) # (35.658633790016204, 139.74546563023935, 14, 0.00011290058538953522)
```
to run (Python)
```
python3 simple_geo3x3.py
```

### in Ruby
```
require "./geo3x3"
code = Geo3x3.encode(35.65858, 139.745433, 14)
p code # "E3793653391822"

pos = Geo3x3.decode('E3793653391822')
p pos # [35.658633790016204, 139.74546563023935, 14, 0.00011290058538953522]
```
to run (Ruby)
```
ruby simple_geo3x3.rb
```

### in Java
```
public class simple_geo3x3 {
    public static void main(String[] args) {
        String code = Geo3x3.encode(35.65858, 139.745433, 14);
        System.out.println(code);
        double[] res = Geo3x3.decode("E3793653391822");
        System.out.println(res[0] + " " + res[1] + " " + res[2] + " " + res[3]);
    }
}
```
to run (Java)
```
javac simple_geo3x3.java Geo3x3.java
java simple_geo3x3
```

### in C/C++
```
#include <stdio.h>
#include "geo3x3.h"

int main() {
    char buf[30];
    Geo3x3_encode(35.65858, 139.745433, 14, buf);
    printf("%s\n", buf); // E3793653391822

    double res[4];
    Geo3x3_decode("E3793653391822", res);
    printf("%f %f %f %f\n", res[0], res[1], res[2], res[3]); // 35.658634 139.745466 14.000000 0.000113
    return 0;
}
```
to run (C)
```
cc simple_geo3x3.c; ./a.out
```

### in C#
```
using System;

public class HelloWorld {
    static public void Main() {
        String code = Geo3x3.encode(35.65858, 139.745433, 14);
        Console.WriteLine(code);
        double[] res = Geo3x3.decode("E3793653391822");
        Console.WriteLine(res[0] + " " + res[1] + " " + res[2] + " " + res[3]);
    }
}
```
to run (C#)
```
mcs simple_geo3x3.cs Geo3x3.cs
mono ./simple_geo3x3.exe
```

### in PHP
```
<?php
require('Geo3x3.php');

$code = Geo3x3::encode(35.65858, 139.745433, 14);
echo $code . "\n";

$pos = Geo3x3::decode('E3793653391822');
echo $pos[0] . " " . $pos[1] . " " . $pos[2] . " " . $pos[3] . "\n";
?>
```
to run (PHP)
```
php simple_geo3x3.php
```

### in Swift
```
import Geo3x3

let code = Geo3x3.encode(lat: 35.65858, lng: 139.745433, level: 14)
print(code)
let pos = Geo3x3.decode(code: "E3793653391822")
print(pos)
```
to run (Swift)
```
swiftc -emit-module -parse-as-library Geo3x3.swift -module-name Geo3x3
swiftc -emit-object -parse-as-library Geo3x3.swift -module-name Geo3x3
swiftc simple_geo3x3.swift Geo3x3.o -I .
./main
```

## in Go
```
package main

import "fmt"
import "./geo3x3"

func main() {
    code := geo3x3.Encode(35.65858, 139.745433, 14)
    fmt.Printf("%s\n", code) // E3793653391822
    
    pos := geo3x3.Decode("E3793653391822")
    fmt.Printf("%f %f %f %f\n", pos[0], pos[1], pos[2], pos[3]); // 35.658634 139.745466 14.000000 0.000113
}
```
to run
```
go build simple_geo3x3.go
./simple_geo3x3
```

kotlinc simple_geo3x3.kt -include-runtime -d simple_geo3x3.jar
kotlin simple_geo3x3.jar

### in Kotlin
```
fun main(args: Array<String>) { 
  var code = Geo3x3.encode(35.65858, 139.745433, 14)
  println(code)
  var res = Geo3x3.decode("E3793653391822")
  println("${res[0]} ${res[1]} ${res[2]} ${res[3]}")
}
```
to run
```
kotlinc simple_geo3x3.kt Geo3x3.kt -include-runtime -d simple_geo3x3.jar
kotlin simple_geo3x3.jar
```

## in Dart
```
import "./Geo3x3.dart";

main() {
  var code = Geo3x3.encode(35.65858, 139.745433, 14);
  print(code);
  var res = Geo3x3.decode("E3793653391822");
  print("${res[0]} ${res[1]} ${res[2]} ${res[3]}");
}
```
to run
```
dart simple_geo3x3.dart
```

## in Rust
```
mod geo3x3;

fn main() {
    let res = geo3x3::encode(35.65858, 139.745433, 14);
    println!("{}", res);

    let pos = geo3x3::decode("E3793653391822".to_string());
    println!("{} {} {} {}", pos.0, pos.1, pos.2, pos.3); // 35.658634 139.745466 14.000000 0.000113
}
```
to run
```
rustc simple_geo3x3.rs
./simple_geo3x3
```

## History
ver 1.03 2021.2.20 support int encoded, license CC BY -> CC0 (Public Domain)  
ver 1.02 2013.2.18 write in Java, lincense CC BY-ND -> CC BY  
ver 1.01 2012.1.15 change coding  
ver 1.00 2012.1.15 first release  
