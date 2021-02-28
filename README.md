Geo3x3 ver 1.04
======

## What is Geo3x3
Geo3x3 is a simple geo-coding system for WGS84  
Geo3x3はシンプルなWGS84向けジオコーディングです  

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

## Sample app
https://taisukef.github.io/Geo3x3/  

## Supported Languages
40 programming languages supported now  
現在40のプログラミング言語対応しています  
([JavaScript](#in-JavaScript-HTML) / [TypeScript](#in-TypeScript-Deno) / [C](#in-C) / [C++](#in-C-1) / [C#](#in-C-2) / [Swift](#in-Swift) / [Java](#in-Java) / [Python](#in-Python) / [Ruby](#in-Ruby) / [PHP](#in-PHP) / [Go](#in-Go) / [Kotlin](#in-Kotlin) / [Dart](#in-Dart) / [Rust](#in-Rust) / [Haskell](#in-haskell-ghc-84x-or-later) / [OpenVBS](#in-OpenVBS) / [Scala](#in-Scala) / [R](#in-R) / [GAS](#in-GAS-Google-App-Script) / [Nim](#in-Nim) / [Lua](#in-Lua) / [Perl](#in-Perl) / [Elixir](#in-Elixir) / [Groovy](#in-Groovy) / [D](#in-D) / [Julia](#in-Julia) / [Racket](#in-Racket) / [OCaml](#in-OCaml) / [Erlang](#in-Erlang) / [Clojure](#in-Clojure) / [F#](#in-F) / [Haxe](#in-Haxe) / [Scheme](#in-Scheme-R6RS) / [Common Lisp](#in-Common-Lisp) / [Elm](#in-Elm) / [Hack](#in-Hack) / [PureScript](#in-PureScript) / [CoffeeScript](#in-CoffeeScript) / [Objective-C](#in-Objective-C) / [Frege](#in-Frege))
https://taisukef.github.io/Geo3x3/langlist.html  

## Sample code

| level | location | Geo3x3 |
|-------|----------|--------|
| 3     | 日本 | E37 |  
| 5     | 中部 | E3792 |  
| 6     | 福井県 | E37924 |  
| 8     | 福井県鯖江市 | E3792198 |  
| 10    | 鯖江市西山公園 | E379219883 |  
| 13    | 鯖江市西山公園のトイレ | E379219883294 |  

※範囲が狭くなるほどコードが長くなり、範囲が含まれるかどうか前方一致で分かります

## Licence
These codes are licensed under CC0 (Public Domain)  
ライセンスはCC0（パブリックドメイン）です  
[![CC0](http://i.creativecommons.org/p/zero/1.0/88x31.png "CC0")](http://creativecommons.org/publicdomain/zero/1.0/deed.ja)  


## How to use (encode / decode)

### in JavaScript (HTML)
[Geo3x3.mjs](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.mjs),
[simple_geo3x3.html](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.html)
```html
<script type=module>
import { Geo3x3 } from "https://taisukef.github.io/Geo3x3/Geo3x3.mjs";
console.log(Geo3x3.decode("W28644"));
</script>
```

### in JavaScript (Deno)
[Geo3x3.mjs](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.mjs),
[simple_geo3x3.mjs](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.mjs)
```mjs
import { Geo3x3 } from "https://taisukef.github.io/Geo3x3/Geo3x3.mjs";
console.log(Geo3x3.decode("W28644"));
```

to run:

```bash
$ deno run -A simple_geo3x3.mjs
```

### in JavaScript (Node.js)
[Geo3x3.mjs](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.mjs),
[simple_geo3x3.mjs](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.mjs)
```js
import { Geo3x3 } from "./Geo3x3.mjs";
console.log(Geo3x3.decode("W28644"));
```

to run:

```bash
$ node simple_geo3x3.mjs
```

### in TypeScript (Deno)
[Geo3x3.ts](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.ts),
[simple_geo3x3.ts](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.ts)
```ts
import { Geo3x3 } from "https://taisukef.github.io/Geo3x3/Geo3x3.ts";
console.log(Geo3x3.decode("W28644"));
```

to run:

```bash
$ deno run simple_geo3x3.ts
```

### in Python
[geo3x3.py](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.py),
[simple_geo3x3.py](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.py)
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
[geo3x3.rb](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.rb),
[simple_geo3x3.rb](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.rb)
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
[geo3x3.h](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.h),
[simple_geo3x3.c](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.c)
```c
#include <stdio.h> /**< printf */
#include <stdlib.h> /**< exit */
#include "geo3x3.h"

int main() {
    enum GEO3X3_RES err;

    char enc_buf[16];
    struct geo3x3_wgs84 res;

    if ((err = geo3x3_from_wgs84_str(35.36053512254623, 138.72724901129274, 9, enc_buf, sizeof(enc_buf)))) {
      // handle errors
      exit(1);
    }
    
    printf("geo3x3: %s\n", enc_buf); // geo3x3: E37935738

    if ((err = geo3x3_to_wgs84_str(enc_buf, &res))) {
      // handle errors
      exit(1);
    }

    // wgs84: 35.363512 138.724280 9 0.027435
    printf(" wgs84: %f %f %u %f\n", res.lat, res.lng, res.level, res.unit);

    return 0;
}
```

to run:

```bash
$ cc simple_geo3x3.c; ./a.out
```

### in C++
[geo3x3.r.hpp](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.r.hpp),
[simple_geo3x3.r.cpp](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.r.cpp)
```c++
#include <stdio.h>
#include "geo3x3.r.hpp"

int main() {
    Geo3x3::Encoder<14> enc(35.65858, 139.745433);
    printf("%s\n", (const char*)enc);

    Geo3x3::Decoder dec("E3793653391822");
    printf("%f %f (%d)\n", dec.lat(), dec.lng(), dec.level());

    return 0;
}
```

to run:

```bash
$ g++ simple_geo3x3.cpp
```

### in C#
[Geo3x3.cs](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.cs),
[simple_geo3x3.cs](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.cs)
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
[Geo3x3.php](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.php),
[simple_geo3x3.php](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.php)
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
[Geo3x3.swift](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.swift),
[simple_geo3x3.swift](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.swift)
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

### in Go
[Geo3x3.go](https://github.com/taisukef/Geo3x3/blob/master/geo3x3/Geo3x3.go),
[simple_geo3x3.go](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.go)

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
[Geo3x3.kt](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.kt),
[simple_geo3x3.kt](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.kt)

```kotlin
fun main() {
  val code = Geo3x3.encode(35.65858, 139.745433, 14)
  println(code)
  val res = Geo3x3.decode("E3793653391822")
  println("${res[0]} ${res[1]} ${res[2]} ${res[3]}")
}
```

to run:

```bash
$ kotlinc simple_geo3x3.kt Geo3x3.kt -include-runtime -d simple_geo3x3.jar
$ kotlin simple_geo3x3.jar
```

### in Dart
[Geo3x3.dart](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.dart),
[simple_geo3x3.dart](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.dart)
```dart
import "./Geo3x3.dart";

main() {
  final code = Geo3x3.encode(35.65858, 139.745433, 14);
  print(code);
  final res = Geo3x3.decode("E3793653391822");
  print("${res[0]} ${res[1]} ${res[2]} ${res[3]}");
}
```

to run:

```bash
$ dart simple_geo3x3.dart
```

### in Rust
[geo3x3.rs](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.rs),
[simple_geo3x3.rs](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.rs)
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
$ rustc simple_geo3x3.rs; ./simple_geo3x3
```

### in Haskell (GHC 8.4.x or later)
[Geo3x3.hs](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.hs),
[simple_geo3x3.hs](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.hs)
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
```bash
$ runghc simple_geo3x3.hs
```

### in OpenVBS
[Geo3x3.obs](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.obs),
```vbs
WScript.Echo Geo3x3_encode(35.65858, 139.745433, 14)
WScript.Echo Geo3x3_decode("E3793653391822")
```
to run:
```bash
$ oscript Geo3x3.obs
```

### in Scala
[Geo3x3.scala](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.scala),
[simple_geo3x3.scala](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.scala)
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

### in R
[Geo3x3.R](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.R),
[simple_geo3x3.R](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.R)
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

### in GAS (Google App Script)
[Geo3x3.gs](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.gs),
[simple_geo3x3.gs](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.gs)
```js
function myFunction() {
  Logger.log(Geo3x3.encode(35.65858, 139.745433, 14));
  Logger.log(Geo3x3.decode("E3793653391822"));
}
```

### in Nim
[geo3x3.nim](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.nim),
[simple_geo3x3.nim](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.nim)
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
[geo3x3.ex](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.ex),
[simple_geo3x3.exs](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.exs)
```elixir
Code.require_file("geo3x3.ex")

Geo3x3.encode(35.65858, 139.745433, 14) |> IO.inspect()
Geo3x3.decode("E3793653391822") |> IO.inspect() 
```

to run:
```bash
$ elixir simple_geo3x3.exs
```

### in Lua
[geo3x3.lua](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.lua),
[simple_geo3x3.lua](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.lua)
```lua
local geo3x3 = require("geo3x3")

print(geo3x3.encode(35.65858, 139.745433, 14))

pos = geo3x3.decode("E3793653391822")
print(pos[1], pos[2], pos[3], pos[4])
```
to run:
```
$ lua simple_geo3x3.lua
```

### in Perl
[geo3x3.pm](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.pm),
[simple_geo3x3.pl](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.pl)
```perl
#!/usr/bin/perl
 
use lib qw(./);
use geo3x3;

my $code = geo3x3::encode(35.65858, 139.745433, 14);
print $code . "\n";

my ($lat, $lng, $level, $unit) = geo3x3::decode("E3793653391822");
print $lat . " " . $lng . " " . $level . " " . $unit . "\n";
```
to run:
```bash
$ perl simple_geo3x3.pl
```

### in Groovy
[Geo3x3.groovy](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.groovy),
[simple_geo3x3.groovy](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.groovy)
```groovy
final code = Geo3x3.encode(35.65858, 139.745433, 14)
println code

final res = Geo3x3.decode("E3793653391822")
println(res[0] + " " + res[1] + " " + res[2] + " " + res[3])
```
to run:
```bash
$ groovy simple_geo3x3.groovy
```

### in D
[Geo3x3.d](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.d),
[simple_geo3x3.d](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.d)
```D
import std.stdio;
import Geo3x3;

void main() {
    // get Geo3x3 code from latitude / longitude / level
    char[14] code;
    if (Geo3x3.encode(35.65858, 139.745433, 14, code)) {
        writeln(code);
    }

    // get location from Geo3x3 code
    auto pos = Geo3x3.decode("E3793653391822");
    writeln(pos);
}
```
setup:
```bash
$ brew install dmd
```
to run:
```bash
$ dmd simple_geo3x3.d Geo3x3.d
$ ./simple_geo3x3
```

### in Julia
[Geo3x3.jl](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.jl),
[simple_geo3x3.jl](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.jl)
```Julia
include("Geo3x3.jl")

code = Geo3x3.encode(35.65858, 139.745433, 14)
println(code)

pos = Geo3x3.decode("E3793653391822")
println(pos)
```
setup:
```bash
$ brew install julia
```
to run:
```bash
$ julia simple_geo3x3.jl
```

### in Racket
[geo3x3.rkt](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.rkt),
[simple_geo3x3.rkt](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.rkt)
```racket
#lang racket

(require "geo3x3.rkt")
(encode 35.65858 139.745433 14)
(decode "E3793653391822")

;"E3793653391822"
;'(35.658633790016204 139.7454656302393 14 0.00011290058538953525)
```
setup:
```bash
$ brew install racket
```
to run:
```bash
$ racket simple_geo3x3.rkt
```

### in OCaml
[geo3x3.ml](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.ml),
[simple_geo3x3.ml](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.ml)
```OCaml
open String;;

let code = Geo3x3.encode 35.65858 139.745433 14;;
print_endline code;;

let (lat, lng, level, unit) = Geo3x3.decode "E3793653391822";;
print_endline (String.concat " " [string_of_float lat; string_of_float lng; string_of_int level; string_of_float unit]);;
```
setup:
```bash
$ brew install ocaml
```
to run:
```bash
$ ocamlopt -c geo3x3.ml; ocamlopt -c simple_geo3x3.ml; ocamlopt -o a.out geo3x3.cmx simple_geo3x3.cmx; ./a.out
```

### in Erlang
[geo3x3.erl](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.erl),
[simple_geo3x3.erl](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.erl)
```Erlang
-module(simple_geo3x3).
-export([main/0]).

main() ->
    io:format("~s~n", [geo3x3:encode(35.65858, 139.745433, 14)]),
    {Lat, Lng, Level, Unit} = geo3x3:decode("E3793653391822"),
    io:format("~w ~w ~w ~w~n", [Lat, Lng, Level, Unit]).
```
setup:
```bash
$ brew install erlang
```
to run:
```bash
$ erlc simple_geo3x3.erl geo3x3.erl; erl -noshell -noinput -s simple_geo3x3 main -s init stop
```

### in Clojure
[geo3x3.clj](https://github.com/taisukef/Geo3x3/blob/master/src/geo3x3.clj),
[simple_geo3x3.clj](https://github.com/taisukef/Geo3x3/blob/master/src/simple_geo3x3.clj)
```Clojure
(ns simple_geo3x3
  (:require [geo3x3])
)
(defn -main []
  (println (geo3x3/encode 35.65858 139.745433 14))
  (println (geo3x3/decode "E3793653391822"))
)
```
setup:
```bash
$ brew install leiningen
```
to run:
```bash
$ lein run
```

### in F#
[Geo3x3.fs](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.fs),
[simple_geo3x3.fs](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.fs)
```F#
module simple_geo3x3
open Geo3x3

let code = Geo3x3.encode 35.65858 139.745433 14
printfn "%s" code

let (lat, lng, level, unit) = Geo3x3.decode "E3793653391822"
printfn "%f %f %d %f" lat lng level unit
```
to run:
```
$ dotnet fsi Geo3x3.fs simple_geo3x3.fs
```

### in Haxe
[Geo3x3.hx](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.hx),
[Simple_geo3x3.hx](https://github.com/taisukef/Geo3x3/blob/master/Simple_geo3x3.hx)
```Haxe
class Simple_geo3x3 {
    static public function main(): Void {
        final code = Geo3x3.encode(35.65858, 139.745433, 14);
        Sys.println(code);
        final pos = Geo3x3.decode("E3793653391822");
        Sys.println(pos);
    }
}
```
setup:
```bash
$ brew install haxe
```
to run:
```bash
$ haxe -main Simple_geo3x3.hx --interp
```

### in Scheme (R6RS)
[geo3x3.sls](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.sls),
[simple_geo3x3.scm](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.scm)
```Scheme
#!r6rs
(import (rnrs)
        (geo3x3))

(write (encode 35.65858 139.745433 14))
(newline)

(let-values ((result (decode "E3793653391822")))
  (write result))
(newline)
```
setup:
```bash
$ brew install chezscheme
```
to run:
```
$ chez --program simple_geo3x3.scm
```

### in Common Lisp
[geo3x3.lisp](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.lisp),
[simple_geo3x3.lisp](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.lisp)
```Lisp
(load "geo3x3.lisp")

(defun main ()
  (progn
    (print (geo3x3::encode 35.65858 139.745433 14))
    (print (geo3x3::decode "E3793653391822"))
  )
)
```
setup:
```bash
$ brew install roswell
```
to run:
```
$ ros simple_geo3x3.lisp
```

### in Elm
[Geo3x3.elm](https://github.com/taisukef/Geo3x3/blob/master/elm/src/Geo3x3.elm),
[Mail.elm](https://github.com/taisukef/Geo3x3/blob/master/elm/src/Main.elm)
```Elm
module Main exposing (main)

import Geo3x3 exposing (decode, encode)
import Html exposing (Html, div, text)

main : Html msg
main =
    div []
        [
            div [] [ text (encode 35.65858 139.745433 14) ],
            div [] [ text (
                let
                    pos = decode "E3793653391822"
                in
                (String.fromFloat pos.lat ++ " " ++ String.fromFloat pos.lng ++ " " ++ String.fromInt pos.level)
            )]
        ]
```
setup:
```
$ brew install elm
```
to run:
```
$ cd elm
$ elm make src/Main.elm 
$ open index.html
```

### in Hack
[Geo3x3.hack](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.hack),
[simple_geo3x3.hack](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.hack)
```Elm
<<__EntryPoint>>
function main(): void {
  require('Geo3x3.hack');
  
  $code = Geo3x3::encode(35.65858, 139.745433, 14);
  echo $code . "\n";

  $pos = Geo3x3::decode('E3793653391822');
  echo $pos[0] . " " . $pos[1] . " " . $pos[2] . " " . $pos[3] . "\n";
}
```
setup:
```
$ brew tap hhvm/hhvm
$ brew install hhvm
```
to run:
```
$ hhvm simple_geo3x3.hack
```

### in PureScript
[Geo3x3.purs](https://github.com/taisukef/Geo3x3/blob/master/purs/src/Geo3x3.purs),
[Main.purs](https://github.com/taisukef/Geo3x3/blob/master/purs/src/Main.purs)
```PureScript
module Main where

import Prelude
import Effect (Effect)
import Effect.Console (log)

import Geo3x3 as Geo3x3

main :: Effect Unit
main = do
  log (Geo3x3.encode 35.65858 139.745433 14)
  log (show (Geo3x3.decode "E3793653391822"))
```
setup:
```
$ spago install integers
$ spago install strings
```
to run:
```
$ cd purs
$ spago run
```

### in CoffeeScript
[Geo3x3.coffee](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.coffee),
[simple_geo3x3.coffee](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.coffee)
```CoffeeScript
import { Geo3x3 } from "./Geo3x3.js"

console.log Geo3x3.encode(35.65858, 139.745433, 14)
console.log Geo3x3.decode("E3793653391822")
```
setup:
```
$ npm install --global coffeescript
```
to run:
```
$ coffee -o out/ -c simple_geo3x3.coffee Geo3x3.coffee
$ deno run -A out/simple_geo3x3.js
```

### in Objective-C
[Geo3x3.objc.h](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.objc.h),
[Geo3x3.m](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.m),
[simple_geo3x3.m](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.m)
```Objective-C
#import <Foundation/Foundation.h>
#import "Geo3x3.objc.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"%@", [Geo3x3 Encode:35.65858 lng:139.745433 level:14]);

        NSArray* res = [Geo3x3 Decode:@"E3793653391822"];
        for (NSNumber* num in res) {
            NSLog(@"%f", num.doubleValue);
        }
    }
    return 0;
}
```
setup:
```
$ brew install llvm
```
to run:
```
$ clang -framework Foundation simple_geo3x3.m Geo3x3.m -o a.out; ./a.out
```

### in Frege
[Geo3x3.fr](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.fr),
[simple_geo3x3.fr](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.fr)
```Frege
import Geo3x3

main _ = do putStrLn $ encode 35.65858 139.745433 14
            let (lat,lng,level,unit) = decode "E3793653391822"
            print lat   >> print '\n'
            print lng   >> print '\n'
            print level >> print '\n'
            print unit  >> print '\n'
```
setup:
```
$ mkdir frege
$ curl https://github.com/Frege/frege/releases/download/3.24public/frege3.24.405.jar -L --output frege/frege.jar
```
to run:
```
$ java -Xss1m -jar frege/frege.jar -d frege/build Geo3x3.fr simple_geo3x3.fr
$ java -Xss1m -cp frege/build:frege/frege.jar Main
```


## History
ver 1.04 2021.2.22 fixed WGS84  
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
