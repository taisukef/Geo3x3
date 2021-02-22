Geo3x3 ver 1.03
======

## What is Geo3x3
Geo3x3 is a simple geo-coding system  
Geo3x3はシンプルなジオコーディングです  

divide the earth to two (West or East), recursive divisiton 3x3(9th). longer is more in detail.  
地球を東(E)と西(W)に分け、再帰的に3x3の9エリアで分割します。長いほど精度が上がります。  

|       |  | East | | |  West | |  
|-------|--|:----:|-|-|:-----:|-|  
| North | 1 | 2 | 3 | 1 | 2 | 3 |  
|       | 4 | 5 | 6 | 4 | 5 | 6 |  
| South | 7 | 8 | 9 | 7 | 8 | 9 |  

	W5555555 = level 8  
	E1384700 = level 6 (postfix 0 = dummy)  
	* origin = lat 90, lng 0 -> lat -90, lng 90(E) -90(W)  

20 programming languages supported now  
現在20のプログラミング言語対応しています  
(JavaScript / TypeScript / C / C++ / C# / Swift / Java / Python / Ruby / PHP / Go / Kotlin / Dart / Rust / Haskell / OpenVBS / Scala / R / GAS / Nim)  

## Sample code

| 場所 | Geo3x3 |
|-----|--------|
| 日本 | E37 |  
| 中部 | E3792 |  
| 福井県 | E37924 |  
| 福井県鯖江市 | E3792198 |  
| 鯖江市西山公園 | E379219883 |  
| 鯖江市西山公園のトイレ | E379219883294 |  

※範囲が狭くなるほどコードが長くなり、範囲が含まれるかどうか前方一致で分かります

## Sample app
https://taisukef.github.io/Geo3x3/  

## Licence
These codes are licensed under CC0 (Public Domain)  
ライセンスはCC0（パブリックドメイン）です  
[![CC0](http://i.creativecommons.org/p/zero/1.0/88x31.png "CC0")](http://creativecommons.org/publicdomain/zero/1.0/deed.ja)  


## How to use (encode / decode)

### in JavaScript (HTML)
```html
<script type=module>
import { Geo3x3 } from "https://taisukef.github.io/Geo3x3/Geo3x3.mjs";
console.log(Geo3x3.decode("W28644"));
</script>
```

### in JavaScript (Deno)
```mjs
import { Geo3x3 } from "https://taisukef.github.io/Geo3x3/Geo3x3.mjs";
console.log(Geo3x3.decode("W28644"));
```

to run:

```bash
$ deno run -A simple_geo3x3.mjs
```

### in JavaScript (Node.js)
```js
import { Geo3x3 } from "./Geo3x3.mjs";
console.log(Geo3x3.decode("W28644"));
```

to run:

```bash
$ node simple_geo3x3.mjs
```

### in TypeScript (Deno)
```ts
import { Geo3x3 } from "https://taisukef.github.io/Geo3x3/Geo3x3.ts";
console.log(Geo3x3.decode("W28644"));
```

to run:

```bash
$ deno run simple_geo3x3.ts
```

### in Python
```py
import geo3x3
## get Geo3x3 code from latitude / longitude / level
code = geo3x3.encode(35.65858, 139.745433, 14)
print(code) # E3793653391822

## get location from Geo3x3 code
pos = geo3x3.decode('E3793653391822')
print(pos) # (35.658633790016204, 139.74546563023935, 14, 0.00011290058538953522)
```

to run:

```bash
$ python3 simple_geo3x3.py
```

### in Ruby
```ruby
require "./geo3x3"
code = Geo3x3.encode(35.65858, 139.745433, 14)
p code # "E3793653391822"

pos = Geo3x3.decode('E3793653391822')
p pos # [35.658633790016204, 139.74546563023935, 14, 0.00011290058538953522]
```

to run:

```bash
$ ruby simple_geo3x3.rb
```

### in Java
```java
public class simple_geo3x3 {
    public static void main(String[] args) {
        String code = Geo3x3.encode(35.65858, 139.745433, 14);
        System.out.println(code);
        double[] res = Geo3x3.decode("E3793653391822");
        System.out.println(res[0] + " " + res[1] + " " + res[2] + " " + res[3]);
    }
}
```

to run:

```bash
$ javac simple_geo3x3.java Geo3x3.java
$ java simple_geo3x3
```

### in C
```c
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

to run:

```bash
$ cc simple_geo3x3.c; ./a.out
```

### in C++
```c++
#include <iostream>
#include "geo3x3.h"
using namespace std;

int main() {
    char buf[30];
    Geo3x3_encode(35.65858, 139.745433, 14, buf);
    cout << buf << endl;

    double res[4];
    Geo3x3_decode("E3793653391822", res);
    cout << res[0] << " " << res[1] << " " << res[2] << " " << res[3] << endl;
    return 0;
}
```
to run:
```bash
$ g++ simple_geo3x3.cpp
```

### in C#
```c#
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

to run:

```bash
$ mcs simple_geo3x3.cs Geo3x3.cs
$ mono ./simple_geo3x3.exe
```

### in PHP
```php
<?php
require('Geo3x3.php');

$code = Geo3x3::encode(35.65858, 139.745433, 14);
echo $code . "\n";

$pos = Geo3x3::decode('E3793653391822');
echo $pos[0] . " " . $pos[1] . " " . $pos[2] . " " . $pos[3] . "\n";
?>
```

to run:

```bash
$ php simple_geo3x3.php
```

### in Swift
```swift
import Geo3x3

let code = Geo3x3.encode(lat: 35.65858, lng: 139.745433, level: 14)
print(code)
let pos = Geo3x3.decode(code: "E3793653391822")
print(pos)
```

to run: (Swift)

```bash
$ swiftc -emit-module -parse-as-library Geo3x3.swift -module-name Geo3x3
$ swiftc -emit-object -parse-as-library Geo3x3.swift -module-name Geo3x3
$ swiftc simple_geo3x3.swift Geo3x3.o -I .
$ ./main
```

## in Go

```go
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

to run:

```bash
$ go build simple_geo3x3.go
$ ./simple_geo3x3
```

### in Kotlin

```kotlin
fun main(args: Array<String>) { 
  var code = Geo3x3.encode(35.65858, 139.745433, 14)
  println(code)
  var res = Geo3x3.decode("E3793653391822")
  println("${res[0]} ${res[1]} ${res[2]} ${res[3]}")
}
```

to run:

```bash
$ kotlinc simple_geo3x3.kt Geo3x3.kt -include-runtime -d simple_geo3x3.jar
$ kotlin simple_geo3x3.jar
```

## in Dart

```dart
import "./Geo3x3.dart";

main() {
  var code = Geo3x3.encode(35.65858, 139.745433, 14);
  print(code);
  var res = Geo3x3.decode("E3793653391822");
  print("${res[0]} ${res[1]} ${res[2]} ${res[3]}");
}
```

to run:

```bash
$ dart simple_geo3x3.dart
```

## in Rust
```rust
mod geo3x3;

fn main() {
    let res = geo3x3::encode(35.65858, 139.745433, 14);
    println!("{}", res);

    let pos = geo3x3::decode("E3793653391822".to_string());
    println!("{} {} {} {}", pos.0, pos.1, pos.2, pos.3); // 35.658634 139.745466 14.000000 0.000113
}
```

to run:

```bash
$ rustc simple_geo3x3.rs
$ ./simple_geo3x3
```

## in Haskell (GHC 8.4.x or later)
```haskell
import Geo3x3

main :: IO ()
main = do
  let code = Geo3x3.encode 35.65858 139.745433 14
  putStrLn code
  let res = Geo3x3.decode "E3793653391822"
  print res
```
to run:
```
runghc simple_geo3x3.hs
```

## in OpenVBS
```vbs
WScript.Echo Geo3x3_encode(35.65858, 139.745433, 14)
WScript.Echo Geo3x3_decode("E3793653391822")
```
to run:
```bash
$ oscript Geo3x3.obs
```

## in Scala
```scala
def main(args: Array[String]): Unit = {
	val code = encode(35.65858, 139.745433, 14)
	println(code)
	val (lat, lng, level, unit) = decode("E3793653391822")
	println(s"${lat} ${lng} ${level} ${unit}")
}
```
to run:
```bash
$ scala Geo3x3.scala
```

## in R
```R
source("Geo3x3.R")

code <- Geo3x3_encode(35.65858, 139.745433, 14)
print(code)

pos <- Geo3x3_decode("E3793653391822")
print(pos)
```
to run:
```bash
$ r --no-save < simple_geo3x3.R
```

## in GAS (Google App Script)
```js
function myFunction() {
  Logger.log(Geo3x3.encode(35.65858, 139.745433, 14));
  Logger.log(Geo3x3.decode("E3793653391822"));
}
```

## in Nim
```nim
import geo3x3

echo geo3x3.encode(35.65858, 139.745433, 14)
echo geo3x3.decode("E3793653391822")
```
to run:
```bash
$ nim r simple_geo3x3.nim
```

## in Elixir
```elixir
Code.require_file("geo3x3.ex")

Geo3x3.encode(35.65858, 139.745433, 14) |> IO.inspect()
Geo3x3.decode("E3793653391822") |> IO.inspect() 
```

to run:
```bash
$ elixir simple_geo3x3.exs
```

## History
ver 1.03 2021.2.20 support int encoded, license CC BY -> CC0 (Public Domain)  
ver 1.02 2013.2.18 write in Java, lincense CC BY-ND -> CC BY  
ver 1.01 2012.1.15 change coding  
ver 1.00 2012.1.15 first release  

## Creator
Taisuke Fukuno  
https://twitter.com/taisukef  
https://fukuno.jig.jp/139  
https://fukuno.jig.jp/205  
https://fukuno.jig.jp/3131  
