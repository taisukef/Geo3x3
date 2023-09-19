Geo3x3
======
![Geo3x3 Logo](https://taisukef.github.io/Geo3x3/Geo3x3_WhiteBack.png)  
[Logo](https://taisukef.github.io/Geo3x3/Geo3x3_WhiteBack.png) created by [mizuno](https://github.com/macoto1655) [(transparent ver.)](https://taisukef.github.io/Geo3x3/Geo3x3.png)  

## What is Geo3x3
Geo3x3 is a simple geo-coding system for WGS84  
Geo3x3はシンプルなWGS84向けジオコーディングです  
divide the earth to two (West or East), recursive divisiton 3x3(9th). longer is more in detail.  
地球を東(E)と西(W)に分け、再帰的に3x3の9エリアで分割します。長いほど精度が上がります。  

|       || East |||  West ||  
|-------|--|:----:|-|-|:-----:|-|  
| North | 7 | 8 | 9 | 7 | 8 | 9 |  
|       | 4 | 5 | 6 | 4 | 5 | 6 |  
| South | 1 | 2 | 3 | 1 | 2 | 3 |  

W5555555 = level 8  
E1384700 = level 6 (postfix 0 = dummy)  
* origin = lat -90, lng 0 -> lat 90, lng -90(W) 90(E)  

## Sample code

| level | location | Geo3x3 | lat,lng |
|-------|----------|--------|---------|
| 3     | 日本 (Japan) | E91 | 40,130 | 
| 5     | 中部 (Chubu region) | E9138 | 35.555555,136.666666 |
| 6     | 福井県 (Fukui pref) | E91384 | 35.555555,135.925925 |
| 8     | 福井県鯖江市 (Sabae city) | E9138732 | 35.967078,136.172839 |
| 10    | 鯖江市西山公園 (Nishiyama park) | E913873229 | 35.948788,136.181984 |
| 13    | 鯖江市西山公園のトイレ | E9138732298349 | 35.950933,136.182774 |
| 16    | 鯖江市西山公園のトイレの入り口 | E913873229834833 | 35.950883,136.182712 |

the narrower the range, the longer the code, and the forward matching will tell you if the range is included or not.  
範囲が狭くなるほどコードが長くなり、範囲が含まれるかどうか前方一致で分かります  

## Applications
[Geo3x3 map](https://code4sabae.github.io/geo3x3-map/) [(src)](https://github.com/code4sabae/geo3x3-map/)  
[GC Wizard](https://gcwizard.net/) [(src)](https://github.com/S-Man42/GCWizard)  

## Supported Languages

103 languages supported  

([JavaScript](#in-JavaScript-HTML) / [TypeScript](#in-TypeScript-Deno) / [Zen](#in-Zen) / [C](#in-C) / [C++](#in-C-1) / [C#](#in-C-2) / [Swift](#in-Swift) / [Java](#in-Java) / [Python](#in-Python) / [Ruby](#in-Ruby) / [PHP](#in-PHP) / [Go](#in-Go) / [Kotlin](#in-Kotlin) / [Dart](#in-Dart) / [Rust](#in-Rust) / [Haskell](#in-haskell-ghc-84x-or-later) / [OpenVBS](#in-OpenVBS) / [VBScript](#in-VBScript) / [Visual Basic](#in-Visual-Basic) / [Scala](#in-Scala) / [R](#in-R) / [GAS](#in-GAS-Google-App-Script) / [Nim](#in-Nim) / [Lua](#in-Lua) / [Perl](#in-Perl) / [Elixir](#in-Elixir) / [Groovy](#in-Groovy) / [D](#in-D) / [Julia](#in-Julia) / [Racket](#in-Racket) / [OCaml](#in-OCaml) / [Erlang](#in-Erlang) / [Clojure](#in-Clojure) / [F#](#in-F) / [Haxe](#in-Haxe) / [Scheme](#in-Scheme-R6RS) / [Common Lisp](#in-Common-Lisp) / [Elm](#in-Elm) / [Hack](#in-Hack) / [PureScript](#in-PureScript) / [CoffeeScript](#in-CoffeeScript) / [Objective-C](#in-Objective-C) / [Frege](#in-Frege) / [Eiffel](#in-Eiffel) / [Ada](#in-Ada) / [Free Pascal](#in-Free-Pascal) / [Crystal](#in-Crystal) / [Forth](#in-Forth) / [Bash](#in-Bash) / [AWK](#in-AWK) / [Vim script](#in-Vim-script) / [Vim9 script](#in-Vim9-script) / [IchigoJam BASIC](#in-IchigoJam-BASIC) / [GnuCOBOL](#in-GnuCOBOL) / [MoonScript](#in-MoonScript) / [Octave](#in-Octave) / [Emacs Lisp](#in-Emacs-Lisp) / [Fortran 90](#in-Fortran-90) / [MariaDB SQL/PSM](#in-MariaDB-SQL) / [PL/pgSQL](#in-PLpgSQL) / [Tcl](#in-Tcl) / [V](#in-V) / [Pike](#in-Pike) / [Io](#in-Io) / [Wren](#in-Wren) / [GNU Smalltalk](#in-GNU-Smalltalk) / [JScript](#in-JScript) / [Pharo](#in-Pharo) / [Scratch](#in-Scratch) / [Standard ML](#in-Standard-ML) / [なでしこ](#in-なでしこ) / [Kuin](#in-Kuin) / [ClojureScript](#in-ClojureScript) / [HSP](#in-HSP) / [Reason](#in-Reason) / [THPL](#in-THPL) / [Janet](#in-Janet) / [Phel](#in-Phel) / [Raku](#in-Raku) / [文言](#in-文言) / [Vala](#in-Vala) / [SmileBASIC](#in-SmileBASIC) / [Small Basic](#in-Small-Basic) / [Flix](#in-Flix) / [PowerShell](#in-PowerShell) / [Koka](#in-Koka) / [Zig](#in-Zig) / [BanchaScript](#in-BanchaScript) / [AssemblyScript](#in-AssemblyScript) / [Clawn](#in-Clawn) / [FORTRAN 77](#in-FORTRAN-77) / [orelang](#in-orelang) / [Laze](#in-Laze) / [WebAssembly](#in-WebAssembly) / [Nelua](#in-Nelua) / [Roland](#in-Roland) / [ReScript](#in-ReScript) / [Effekt](#in-Effekt) / [Ceylon](#in-Ceylon) / [Mochi](#in-Mochi) / [Neko](#in-Neko) / [NekoML](#in-NekoML) / [LLVM IR](#in-LLVM-IR))

supported languages list / サポート言語一覧  
https://github.com/taisukef/Geo3x3/blob/master/langlist.csv  
https://taisukef.github.io/Geo3x3/langlist.html  
https://taisukef.github.io/Geo3x3/langlist.csv  

## Licence
These codes are licensed under CC0 (Public Domain)  
ライセンスはCC0（パブリックドメイン）です  
[![CC0](http://i.creativecommons.org/p/zero/1.0/88x31.png "CC0")](http://creativecommons.org/publicdomain/zero/1.0/deed.ja)  


## How to use (encode / decode)

### in JavaScript (HTML)
[Geo3x3.js](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.js),
[simple_geo3x3.html](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.html)
```html
<script type="module">
import { Geo3x3 } from "https://taisukef.github.io/Geo3x3/Geo3x3.js";
console.log(Geo3x3.encode(35.65858, 139.745433, 14));
console.log(Geo3x3.decode("E9139659937288"));
</script>
```

### in JavaScript (Deno)
[Deno](https://deno.land)  
[Geo3x3.js](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.js),
[simple_geo3x3.js](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.js)
```js
import { Geo3x3 } from "https://taisukef.github.io/Geo3x3/Geo3x3.js";
console.log(Geo3x3.encode(35.65858, 139.745433, 14));
console.log(Geo3x3.decode("E9139659937288"));
```
setup:
```
$ brew install deno
```
to run:
```bash
$ deno run -A simple_geo3x3.js
```
test:
```bash
$ deno test
```

### in JavaScript (Node.js)
[Node.js](https://nodejs.org/)  
[Geo3x3.mjs](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.mjs),
[simple_geo3x3.mjs](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.mjs)
```js
import { Geo3x3 } from "./Geo3x3.mjs";
console.log(Geo3x3.encode(35.65858, 139.745433, 14));
console.log(Geo3x3.decode("E9139659937288"));
```

to run:
```bash
$ node simple_geo3x3.mjs
```

### in JavaScript (Bun)
[Bun](https://bun.sh/)  
[Geo3x3.mjs](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.mjs),
[simple_geo3x3.mjs](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.mjs)
```js
import { Geo3x3 } from "./Geo3x3.mjs";
console.log(Geo3x3.encode(35.65858, 139.745433, 14));
console.log(Geo3x3.decode("E9139659937288"));
```

setup:
```bash
curl https://bun.sh/install | bash
```
to run:
```bash
$ bun simple_geo3x3.mjs
```

### in TypeScript (Deno)
[Deno](https://deno.land)  
[Geo3x3.ts](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.ts),
[simple_geo3x3.ts](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.ts)
```ts
import { Geo3x3 } from "https://taisukef.github.io/Geo3x3/Geo3x3.ts";
console.log(Geo3x3.encode(35.65858, 139.745433, 14));
console.log(Geo3x3.decode("E9139659937288"));
```

to run:

```bash
$ deno run simple_geo3x3.ts
```

### in Python
[Python](https://www.python.org/)  
[geo3x3.py](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.py),
[simple_geo3x3.py](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.py)
```py
import geo3x3
## get Geo3x3 code from latitude / longitude / level
code = geo3x3.encode(35.65858, 139.745433, 14)
print(code) # E9139659937288

## get location from Geo3x3 code
pos = geo3x3.decode('E9139659937288')
print(pos) # (35.658633790016204, 139.74546563023935, 14, 0.00011290058538953522)
```

to run:

```bash
$ python3 simple_geo3x3.py
```

### in Ruby
[Ruby](https://www.ruby-lang.org/)  
[geo3x3.rb](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.rb),
[simple_geo3x3.rb](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.rb)
```ruby
require "./geo3x3"
code = Geo3x3.encode(35.65858, 139.745433, 14)
p code # "E9139659937288"

pos = Geo3x3.decode('E9139659937288')
p pos # [35.658633790016204, 139.74546563023935, 14, 0.00011290058538953522]
```

to run:

```bash
$ ruby simple_geo3x3.rb
```

### in Java
[Java](https://www.java.com/)  
[Geo3x3.java](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.java),
[simple_geo3x3.java](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.java)
```java
public class simple_geo3x3 {
    public static void main(String[] args) {
        String code = Geo3x3.encode(35.65858, 139.745433, 14);
        System.out.println(code);
        double[] res = Geo3x3.decode("E9139659937288");
        System.out.println(res[0] + " " + res[1] + " " + res[2] + " " + res[3]);
    }
}
```

to run:

```bash
$ javac simple_geo3x3.java Geo3x3.java
$ java simple_geo3x3
```
### in Zen
[Zen](https://zen-lang.org/)  
[geo3x3.zen](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.zen),
[simple_geo3x3.zen](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.zen)
```zen
const std = @import("std");
const Geo3x3 = @import("geo3x3.zen").Geo3x3;

pub fn main() !void {
  var data = [_]u8{0}**14;

  // encode
  const res_encode = try Geo3x3.encode_from_wgs84(35.65858, 139.745433, 14, &mut data);
  std.debug.warn("geo3x3: {}\n", .{ res_encode }); //geo3x3: E9139659937288

  // decode
  const res_decode = try Geo3x3.decode_to_wgs84("E9139659937288");
  std.debug.warn("wgs84: {}\n", .{ res_decode });
  //wgs84: Result{ .level = 14, .lat = 3.56586337900162e+01, .lng = 1.3974546563023935e+02, .unit = 1.1290058538953522e-04 }
}
```

to run:

```bash
$ zen run simple_geo3x3.zen
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

    Geo3x3::Decoder dec("E9139659937288");
    printf("%f %f (%d)\n", dec.lat(), dec.lng(), dec.level());

    return 0;
}
```

to run:

```bash
$ g++ simple_geo3x3.cpp; ./a.out
```

### in C#
[C#](https://docs.microsoft.com/en-us/dotnet/csharp/)  
[Geo3x3.cs](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.cs),
[simple_geo3x3.cs](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.cs)
```c#
using System;

public class simple_geo3x3 {
    static public void Main() {
        String code = Geo3x3.encode(35.65858, 139.745433, 14);
        Console.WriteLine(code);
        double[] res = Geo3x3.decode("E9139659937288");
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
[PHP](https://www.php.net/)  
[Geo3x3.php](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.php),
[simple_geo3x3.php](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.php)
```php
<?php
require('Geo3x3.php');

$code = Geo3x3::encode(35.65858, 139.745433, 14);
echo $code . "\n";

$pos = Geo3x3::decode('E9139659937288');
echo $pos[0] . " " . $pos[1] . " " . $pos[2] . " " . $pos[3] . "\n";
?>
```

to run:

```bash
$ php simple_geo3x3.php
```

### in Swift
[Swift](https://www.apple.com/swift/)  
[Geo3x3.swift](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.swift),
[simple_geo3x3.swift](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.swift)
```swift
import Geo3x3

let code = Geo3x3.encode(lat: 35.65858, lng: 139.745433, level: 14)
print(code)
let pos = Geo3x3.decode(code: "E9139659937288")
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
import "simple_geo3x3/geo3x3"

func main() {
    code := geo3x3.Encode(35.65858, 139.745433, 14)
    fmt.Printf("%s\n", code) // E9139659937288
    
    pos := geo3x3.Decode("E9139659937288")
    fmt.Printf("%f %f %f %f\n", pos[0], pos[1], pos[2], pos[3]); // 35.658634 139.745466 14.000000 0.000113
}
```

setup:

```bash
$ brew install go
```

to run:

```bash
$ go mod init simple_geo3x3
$ go run simple_geo3x3.go
```

### in Kotlin
[Geo3x3.kt](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.kt),
[simple_geo3x3.kt](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.kt)

```kotlin
fun main() {
  val code = Geo3x3.encode(35.65858, 139.745433, 14)
  println(code)
  val res = Geo3x3.decode("E9139659937288")
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
  final res = Geo3x3.decode("E9139659937288");
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

    let pos = geo3x3::decode("E9139659937288".to_string());
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
  let res = Geo3x3.decode "E9139659937288"
  print res
```
to run:
```bash
$ runghc simple_geo3x3.hs
```

### in OpenVBS
[Geo3x3.obs](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.obs)
```vbs
WScript.Echo Geo3x3_encode(35.65858, 139.745433, 14)
WScript.Echo Join(Geo3x3_decode("E9139659937288"))
```
setup:  
Download src [OpenVBS - The Script Engine for the BASIC-2020 -](https://p.na-s.jp/openvbs.html)  
```
$ nmake -f makefile.osx
```
to run:
```bash
$ oscript Geo3x3.obs
```

### in VBScript
[Geo3x3.vbs](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.vbs)
```vbs
WScript.Echo Geo3x3_encode(35.65858, 139.745433, 14)
WScript.Echo Join(Geo3x3_decode("E9139659937288"))
```
to run: (Windows)
```bash
$ cscript Geo3x3.vbs
```

### in Visual Basic
[geo3x3.vb](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.vb),
[simple_geo3x3.vb](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.vb)
```VB.net
Module VBModule
    Sub Main()
        Console.WriteLine(Geo3x3.Encode(35.65858, 139.745433, 14))

        Dim res(4) as Double
        res = Geo3x3.Decode("E9139659937288")
        Console.WriteLine(res(0))
        Console.WriteLine(res(1))
        Console.WriteLine(res(2))
        Console.WriteLine(res(3))
    End Sub
End Module
```
setup:  
Download [Mono](https://www.mono-project.com/download/stable/)  
to run:
```bash
$ vbnc simple_geo3x3.vb geo3x3.vb
$ mono simple_geo3x3.exe
```

### in Scala
[Scala](https://www.scala-lang.org/)  
[Geo3x3.scala](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.scala),
[simple_geo3x3.scala](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.scala)
```scala
def main(args: Array[String]): Unit = {
    val code = encode(35.65858, 139.745433, 14)
    println(code)
    val (lat, lng, level, unit) = decode("E9139659937288")
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

pos <- Geo3x3_decode("E9139659937288")
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
  Logger.log(Geo3x3.decode("E9139659937288"));
}
```

### in Nim
[geo3x3.nim](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.nim),
[simple_geo3x3.nim](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.nim)
```nim
import geo3x3

echo geo3x3.encode(35.65858, 139.745433, 14)
echo geo3x3.decode("E9139659937288")
```
to run:
```bash
$ nim r simple_geo3x3.nim
```

### in Elixir
[Elixir](https://elixir-lang.jp/)  
[geo3x3.ex](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.ex),
[simple_geo3x3.exs](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.exs)
```elixir
Code.require_file("geo3x3.ex")

Geo3x3.encode(35.65858, 139.745433, 14) |> IO.inspect()
Geo3x3.decode("E9139659937288") |> IO.inspect() 
```

to run:
```bash
$ elixir simple_geo3x3.exs
```

### in Lua
[Lua](https://www.lua.org/)  
[geo3x3.lua](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.lua),
[simple_geo3x3.lua](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.lua)
```lua
local geo3x3 = require("geo3x3")

print(geo3x3.encode(35.65858, 139.745433, 14))

pos = geo3x3.decode("E9139659937288")
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
use lib qw(./);
use geo3x3;

my $code = geo3x3::encode(35.65858, 139.745433, 14);
print $code . "\n";

my ($lat, $lng, $level, $unit) = geo3x3::decode("E9139659937288");
print $lat . " " . $lng . " " . $level . " " . $unit . "\n";
```
to run:
```bash
$ perl simple_geo3x3.pl
```

### in Groovy
[Groovy](https://groovy-lang.org/)  
[Geo3x3.groovy](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.groovy),
[simple_geo3x3.groovy](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.groovy)
```groovy
final code = Geo3x3.encode(35.65858, 139.745433, 14)
println code

final res = Geo3x3.decode("E9139659937288")
println(res[0] + " " + res[1] + " " + res[2] + " " + res[3])
```
to run:
```bash
$ groovy simple_geo3x3.groovy
```

### in D
[D](https://dlang.org/)  
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
    auto pos = Geo3x3.decode("E9139659937288");
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

pos = Geo3x3.decode("E9139659937288")
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
(decode "E9139659937288")

;"E9139659937288"
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

let (lat, lng, level, unit) = Geo3x3.decode "E9139659937288";;
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
    {Lat, Lng, Level, Unit} = geo3x3:decode("E9139659937288"),
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
[Clojure](https://clojure.org/) [src GitHub](https://github.com/clojure/clojure)  
[geo3x3.clj](https://github.com/taisukef/Geo3x3/blob/master/src/geo3x3.clj),
[simple_geo3x3.clj](https://github.com/taisukef/Geo3x3/blob/master/src/simple_geo3x3.clj)
```Clojure
(ns simple_geo3x3
  (:require [geo3x3])
)
(defn -main []
  (println (geo3x3/encode 35.65858 139.745433 14))
  (println (geo3x3/decode "E9139659937288"))
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
[Geo3x3.fs](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.fs),
[simple_geo3x3.fs](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.fs)
```F#
module simple_geo3x3
open Geo3x3

let code = Geo3x3.encode 35.65858 139.745433 14
printfn "%s" code

let (lat, lng, level, unit) = Geo3x3.decode "E9139659937288"
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
        final pos = Geo3x3.decode("E9139659937288");
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

(let-values ((result (decode "E9139659937288")))
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
    (print (geo3x3::decode "E9139659937288"))
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
                    pos = decode "E9139659937288"
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

  $pos = Geo3x3::decode('E9139659937288');
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
  log (show (Geo3x3.decode "E9139659937288"))
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
console.log Geo3x3.decode("E9139659937288")
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
[Geo3x3.mm](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.mm),
[simple_geo3x3.mm](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.mm)
```Objective-C
#import <Foundation/Foundation.h>
#import "Geo3x3.objc.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"%@", [Geo3x3 Encode:35.65858 lng:139.745433 level:14]);

        NSArray* res = [Geo3x3 Decode:@"E9139659937288"];
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
$ clang -framework Foundation simple_geo3x3.mm Geo3x3.mm -o a.out; ./a.out
```

### in Frege
[Geo3x3.fr](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.fr),
[simple_geo3x3.fr](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.fr)
```Frege
import Geo3x3

main _ = do
  putStrLn $ encode 35.65858 139.745433 14
  let (lat,lng,level,unit) = decode "E9139659937288"
  print lat >> print ' '
  print lng >> print ' '
  print level >> print ' '
  print unit  >> print ' ' >> print '\n'
```
setup:
```
$ mkdir frege
$ curl https://github.com/Frege/frege/releases/download/3.24public/frege3.24.405.jar -L --output frege/frege.jar
```
to run:
```
$ mkdir frege/build
$ java -Xss1m -jar frege/frege.jar -d frege/build Geo3x3.fr
$ java -Xss1m -jar frege/frege.jar -d frege/build simple_geo3x3.fr
$ java -Xss1m -cp frege/build:frege/frege.jar Main
```

### in Eiffel
[geo3x3.e](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.e),
[simple_geo3x3.e](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.e)
```Eiffel
class
    SIMPLE_GEO3X3

create
    make

feature
    make
        local
            t: TUPLE[lat: DOUBLE; lng: DOUBLE; level:INTEGER; unit:DOUBLE]
            geo3x3: GEO3X3
        do
            create geo3x3
            print (geo3x3.encode (35.65858, 139.745433, 14) + "%N")
            t := geo3x3.decode ("E9139659937288")
            print (t.lat.out + " " + t.lng.out + " " + t.level.out + " " + t.unit.out + "%N")
        end
end
```
setup:
```
$ brew install eiffelstudio
```
to run:
```
$ ec simple_geo3x3.e
$ chmod +x simple_geo3x3
$ ./simple_geo3x3
```

### in Ada
[geo3x3.ads](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.ads),
[geo3x3.adb](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.adb),
[simple_geo3x3.adb](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.adb)
```Ada
with Geo3x3; use Geo3x3;
with Ada.Text_IO; use Ada.Text_IO;

procedure Simple_Geo3x3 is
   T: WGS84;
begin
   Put_Line(Encode(35.65858, 139.745433, 14));
   T := Decode("E9139659937288");
   Put_Line (Long_Float'Image(T.Lat) & " " & Long_Float'Image(T.Lng) & " " & Integer'Image(T.Level) & " " & Long_Float'Image(T.Unit));
end Simple_Geo3x3;
```
setup:  
access [download page of AdaCore](https://www.adacore.com/download), and set PATH  
to run:
```
$ gnatmake simple_geo3x3.adb
$ ./simple_geo3x3
```

### in Free Pascal
[geo3x3.pas](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.pas),
[simple_geo3x3.pas](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.pas)
```Pascal
{$mode objfpc}
program simple_geo3x3;

uses
  geo3x3;

var
  res: latlnglevelunit;
begin
  writeln(Geo3x3_encode(35.65858, 139.745433, 14));
  res := Geo3x3_decode('E9139659937288');
  writeln(res[0], res[1], res[2], res[3]);
end.
```
setup:
```bash
$ brew install fpc
$ cat <<EOF > ~/.fpc.cfg
-FD/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin
-XR/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk
EOF
```
to run:
```
$ fpc simple_geo3x3.pas
$ ./simple_geo3x3
```

### in Crystal
[Crystal](https://crystal-lang.org/)  
[Geo3x3.cr](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.cr),
[simple_geo3x3.cr](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.cr)
```Crystal
require "./Geo3x3"

## get Geo3x3 code from latitude / longitude / level
code = Geo3x3.encode(35.65858, 139.745433, 14)
puts code

## get location from Geo3x3 code
pos = Geo3x3.decode("E9139659937288")
puts pos
```
setup:
```bash
$ brew install crystal
```
to run:
```bash
$ crystal simple_geo3x3.cr
```

### in Forth
[geo3x3.fth](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.fth),
[simple_geo3x3.fth](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.fth)
```Forth
INCLUDE geo3x3.fth

35.65858e 139.745433e 14 GEO3X3_ENCODE TYPE CR
s" E9139659937288" GEO3X3_DECODE  f. f. . f. CR
```
setup:
```bash
$ brew install gforth 
```
to run:
```bash
$ gforth simple_geo3x3.fth -e bye
```

### in Bash
[geo3x3.sh](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.sh),
[simple_geo3x3.sh](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.sh)
```bash
code=`bash geo3x3.sh encode 35.65858 139.745433 14`
echo $code

ll=`bash geo3x3.sh decode E9139659937288`
echo $ll
```
to run:
```bash
$ bash simple_geo3x3.sh
```

### in AWK
[geo3x3.awk](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.awk),
[simple_geo3x3.awk](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.awk)
```AWK
@include "geo3x3.awk"

BEGIN {
    print geo3x3_encode(35.65858, 139.745433, 14)
    print geo3x3_decode("E9139659937288")
}
```
setup:
```bash
$ brew install gawk
```
to run:
```bash
$ gawk simple_geo3x3.awk
```

### in Vim script
[geo3x3.vim](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.vim),
[simple_geo3x3.vim](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.vim)
```Vimscript
source geo3x3.vim
echo Geo3x3_encode(35.65858, 139.745433, 14)
echo Geo3x3_decode("E9139659937288")
```
setup:
```bash
$ brew install vim
```
to run:
```bash
$ vim
:source simple_geo3x3.vim
```

### in Vim9 script
[geo3x3.vim9.vim](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.vim9.vim),
[simple_geo3x3.vim9.vim](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.vim9.vim)
```Vimscript
vim9script
source geo3x3.vim9.vim
echo Geo3x3_encode(35.65858, 139.745433, 14)
echo Geo3x3_decode("E9139659937288")
```
setup:  
[download : vim online](https://www.vim.org/download.php)からダウンロード
```bash
$ make
$ make install
```
to run:
```bash
$ vim
:source simple_geo3x3.vim9.vim
```

### in IchigoJam BASIC
[IchigoJam BASIC](https://ichigojam.net)  
[geo3x3_encode.bas](https://github.com/taisukef/Geo3x3/blob/master/geo3x3_encode.bas),
[geo3x3_decode.bas](https://github.com/taisukef/Geo3x3/blob/master/geo3x3_decode.bas)
```IchigoJam
LOAD
1 'GEO3x3 encode
10 CLV:N=20:L=14
20 LET[20],0,3,5,6,5,8,5,8
25 LET[40],1,3,9,7,4,5,4,3,3
RUN

LOAD
1 'GEO3x3 decode
10 CLV:N=20
12 S="E9139659937288"
RUN
```
setup:  
access [IchigoJam web](https://fukuno.jig.jp/app/IchigoJam/) or launch the [IchigoJam](https://ichigojam.net/)  

### in GnuCOBOL
[geo3x3_encode.cbl](https://github.com/taisukef/Geo3x3/blob/master/geo3x3_encode.cbl),
[geo3x3_decode.cbl](https://github.com/taisukef/Geo3x3/blob/master/geo3x3_decode.cbl),
[simple_geo3x3.cbl](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.cbl)
```COBOL
       IDENTIFICATION  DIVISION.
       PROGRAM-ID.     geo3x3_test.
       DATA            DIVISION.
       WORKING-STORAGE SECTION.
       01  WK-AREA.
         03  LAT       PIC S9(03)V9(6).
         03  LNG       PIC S9(03)V9(6).
         03  UNT       PIC S9(03)V9(6).
         03  LEVEL     PIC  9(02).
       01  RES         PIC  X(31).
       01  COD         PIC  X(31).
       PROCEDURE       DIVISION.
       MAIN-01.
           MOVE   14           TO  LEVEL.
           MOVE   35.65858     TO  LAT.
           MOVE  139.745433    TO  LNG.
           MOVE    SPACE       TO  RES.
           DISPLAY "LAT  = " LAT.
           DISPLAY "LNG  = " LNG.
           DISPLAY "LEVEL= " LEVEL.
           CALL    "geo3x3_encode" USING   BY  REFERENCE   LAT
                                           BY  REFERENCE   LNG
                                           BY  REFERENCE   LEVEL
                                           BY  REFERENCE   RES
           END-CALL.
           DISPLAY "RES = " RES.
      *
           MOVE    RES         TO  COD.
           INITIALIZE              WK-AREA.
           CALL    "geo3x3_decode" USING   BY  REFERENCE   COD
                                           BY  REFERENCE   LAT
                                           BY  REFERENCE   LNG
                                           BY  REFERENCE   LEVEL
                                           BY  REFERENCE   UNT
           END-CALL.
           DISPLAY "LAT  = " LAT.
           DISPLAY "LNG  = " LNG.
           DISPLAY "LEVEL= " LEVEL.
           DISPLAY "UNIT = " UNT.
      *
           MOVE    SPACE       TO  RES.
           CALL    "geo3x3_encode" USING   BY  REFERENCE   LAT
                                           BY  REFERENCE   LNG
                                           BY  REFERENCE   LEVEL
                                           BY  REFERENCE   RES
           END-CALL.
           DISPLAY "RES = " RES.
       MAIN-99.
           STOP RUN.
       END PROGRAM     geo3x3_test.
```
setup:
```bash
$ brew install gnu-cobol
```
to run:
```bash
$ cobc -x simple_geo3x3.cbl geo3x3_encode.cbl geo3x3_decode.cbl
$ ./simple_geo3x3
```

### in MoonScript
[MoonScript](https://moonscript.org/)  
[geo3x3.moon](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.moon),
[simple_geo3x3.moon](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.moon)
```MoonScript
geo3x3 = require "geo3x3"

print geo3x3.encode 35.65858, 139.745433, 14

pos = geo3x3.decode "E9139659937288"
print pos[1], pos[2], pos[3], pos[4]
```
setup:
```bash
$ brew install luarocks
$ luarocks install https://luarocks.org/manifests/leafo/moonscript-dev-1.rockspec
```
to run:
```bash
$ moon simple_geo3x3.moon
```

### in Octave
[geo3x3_encode.m](https://github.com/taisukef/Geo3x3/blob/master/geo3x3_encode.m),
[geo3x3_encode.m](https://github.com/taisukef/Geo3x3/blob/master/geo3x3_decode.m),
[simple_geo3x3.m](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.m)
```Octave
disp(geo3x3_encode(35.65858, 139.745433, 14));

[lat, lng, level, unit] = geo3x3_decode("E9139659937288");
printf("%f %f %d %f", lat, lng, level, unit)
```
setup:
```bash
$ brew install octave
```
to run:
```bash
$ octave simple_geo3x3.m
```

### in Emacs Lisp
[geo3x3.el](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.el),
[simple_geo3x3.el](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.el)
```Lisp
(setq load-path nil)
(load "geo3x3")

(message (geo3x3_encode 35.65858 139.745433 14))

(setq pos (geo3x3_decode "E9139659937288"))
(message (number-to-string (nth 0 pos)))
(message (number-to-string (nth 1 pos)))
(message (number-to-string (nth 2 pos)))
(message (number-to-string (nth 3 pos)))
```
setup:
```bash
$ brew install emacs
```
to run:
```bash
$ emacs --script simple_geo3x3.el
```

### in Fortran 90
[geo3x3.f90](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.f90),
[simple_geo3x3.f90](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.f90)
```Fortran
program main
  use geo3x3
  implicit none
  real pos(4)

  print *, geo3x3_encode(35.65858, 139.745433, 14)
  
  pos = geo3x3_decode("E9139659937288")
  print *, pos(1), pos(2), pos(3), pos(4)
end
```
setup:
```bash
$ brew install gfortran
```
to run:
```bash
$ gfortran geo3x3.f90 simple_geo3x3.f90
```

### in MariaDB SQL
[geo3x3.my.sql](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.my.sql),
[simple_geo3x3.my.sql](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.my.sql)
```SQL
source geo3x3.my.sql;
select Geo3x3_encode(35.65858, 139.745433, 14);

call Geo3x3_decode("E913965993728", @lat, @lng, @level, @unit);
select @lat, @lng, @level, @unit;
```
setup:
```bash
$ brew install mariadb
```
to run:
```
$ mysql
> create database geo3x3
> use geo3x3
> source simple_geo3x3.my.sql
```

### in PL/pgSQL
[geo3x3.plpg.sql](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.plpg.sql),
[simple_geo3x3.plpg.sql](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.plpg.sql)
```SQL
\i geo3x3.plpg.sql;
select Geo3x3_encode(35.65858, 139.745433, 14);

select * from Geo3x3_decode('E913965993728');
```
setup:
```bash
$ brew install postgresql
create database geo3x3
```
to run:
```
$ psql geo3x3
> \i simple_geo3x3.plpg.sql
```

### in Tcl
[geo3x3.tcl](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.tcl),
[simple_geo3x3.tcl](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.tcl)
```Tcl
source "geo3x3.tcl"

puts [geo3x3_encode 35.65858 139.745433 14]
puts [geo3x3_decode "E9139659937288"]
```
setup:
```bash
$ brew install tcl
```
to run:
```bash
$ tclsh simple_geo3x3.tcl
```

### in V
[geo3x3.v](https://github.com/taisukef/Geo3x3/blob/master/geo3x3/geo3x3.v),
[simple_geo3x3.v](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.v)
```V
import geo3x3

fn main() {
    code := geo3x3.encode(35.65858, 139.745433, 14)
    println(code)
    
    lat, lng, level, unit := geo3x3.decode("E9139659937288")
    println('$lat $lng $level $unit')
}
```
setup:  
Download [The V Programming Language](https://vlang.io/), and set PATH  
to run:
```bash
$ v run simple_geo3x3.v
```

### in Pike
[Geo3x3.pmod](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.pmod),
[simple_geo3x3.pike](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.pike)
```Pike
int main(int argc, array(string)argv) {
    write("%s\n", .Geo3x3.encode(35.65858, 139.745433, 14));

    array(float) pos = .Geo3x3.decode("E9139659937288");
    write("%f %f %f %f\n", pos[0], pos[1], pos[2], pos[3]);
    return 0;
}
```
setup:  
```
$ brew install pike
```
to run:
```bash
$ pike simple_geo3x3.pike
```

### in Io
[geo3x3.io](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.io),
[simple_geo3x3.io](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.io)
```Io
doFile("geo3x3.io")

geo3x3_encode(35.65858, 139.745433, 14) println
geo3x3_decode("E9139659937288") println
```
setup:  
```
$ brew install io
```
to run:
```bash
$ io simple_geo3x3.io
```

### in Wren
[geo3x3.wren](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.wren),
[simple_geo3x3.wren](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.wren)
```Wren
import "./geo3x3" for Geo3x3

System.print(Geo3x3.encode(35.65858, 139.745433, 14))
System.print(Geo3x3.decode("E9139659937288"))
```
setup:  
Download or Build [wren-cli](https://github.com/wren-lang/wren-cli/releases)  
to run:
```bash
$ wren_cli simple_geo3x3.wren
```

### in GNU Smalltalk
[Geo3x3.st](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.st),
[simple_geo3x3.st](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.st)
```Smalltalk
FileStream fileIn: 'Geo3x3.st'

(Geo3x3 encodeLatitude:35.65858 andLongitude:139.745433 withLevel:14) printNl.
anArray := Geo3x3 decode:'E9139659937288'.
(anArray at: 1) printNl.
(anArray at: 2) printNl.
(anArray at: 3) printNl.
(anArray at: 4) printNl.
```
setup:
```
$ brew install gnu-smalltalk
```
to run:
```
$ gst simple_geo3x3.st
```

### in JScript
[geo3x3.jscript.js](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.jscript.js)
```JavaScript
WScript.Echo(geo3x3_encode(35.65858, 139.745433, 14));
WScript.Echo(gex3x3_decode("E9139659937288"));
```
to run: (Windows)
```
$ cscript geo3x3.jscript.js
```

### in Pharo
[Geo3x3.class.st](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3-codec/Geo3x3.class.st)
```Smalltalk
Transcript show: (Geo3x3 encodeLatitude: 35.65858 andLongitude: 139.745433 withLevel: 14); cr.
Transcript show: (Geo3x3 decode: 'E9139659937288'); cr.
```
setup:  
Download [Pharo](https://pharo.org/)  
to run:  
Start an image, and open Playground, write the code.  

### in Scratch
[Geo3x3.sb3](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.sb3),
[Geo3x3_encode.sb3.png](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3_encode.sb3.png),
[Geo3x3_decode.sb3.png](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3_decode.sb3.png)

to run:  
Open [Geo3x3 encode / decode on Scratch](https://scratch.mit.edu/projects/504883656/), and start the program, touch "encode" or "decode"  

### in Standard ML
[geo3x3.sml](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.sml),
[simple_geo3x3.sml](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.sml)
```SML
val _ = use "geo3x3.sml";
geo3x3_encode 35.65858 139.745433 14;
geo3x3_decode "E9139659937288";
```
setup:
```bash
$ brew install smlnj
$ export PATH=/usr/local/smlnj/bin:"$PATH"
```
to run:
```bash
$ sml < simple_geo3x3.sml
```

### in なでしこ
[なでしこ](https://nadesi.com/top/)  
[geo3x3.nako3](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.nako3)
```なでしこ
35.65858と139.745433を14でGeo3x3エンコードして表示
"E9139659937288"をGeo3x3デコードして表示
```
setup:
```bash
$ npm -g install nadesiko3
```
to run:
```bash
$ cnako3 geo3x3.nako3
```

### in Kuin
[Kuin](https://kuina.ch/kuin)  
[geo3x3.kn](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.kn),
[simple_geo3x3.kn](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.kn)
```
func main()
    
    {get Geo3x3 code from latitude / longitude / level}
    var code: []char :: \geo3x3@encode(35.65858, 139.745433, 14)
    do cui@print("\{code}\n")
    
    {get location from Geo3x3 code}
    var pos: []float :: \geo3x3@decode("E9139659937288")
    do cui@print("\{pos[0].toStr()}, \{pos[1].toStr()}, \{pos[2].toStr()}, \{pos[3].toStr()}\n")
end func
```
setup:  
access [download page of Kuin](https://kuina.ch/kuin/download)  
to run(Windows):  
```
> kuincl.exe -i simple_geo3x3.kn
> out.exe
```

### in ClojureScript
[ClojureScript](https://clojurescript.org/) [src on GitHub](https://github.com/clojure/clojurescript)  
[geo3x3.cljs](https://github.com/taisukef/Geo3x3/blob/master/cljs/geo3x3.cljs),
[simple_geo3x3.cljs](https://github.com/taisukef/Geo3x3/blob/master/cljs/simple_geo3x3.cljs)
```
(ns cljs.simple_geo3x3
    (:require [cljs.geo3x3 :as geo3x3])
)

(println (geo3x3/encode 35.65858 139.745433 14))
(println (geo3x3/decode "E9139659937288"))
```
setup:  
```bash
$ npm install -g lumo-cljs
```
to run:
```bash
$ lumo cljs/simple_geo3x3.cljs 
```

### in HSP
[HSP](https://hsp.tv/)  
[geo3x3.hsp](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.hsp),
[simple_geo3x3.hsp](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.hsp)
```HSP
    goto *main

#include "geo3x3.hsp"

*main
    mes gex3x3_encode(35.65858, 139.745433, 14)
    
    ddim res, 4
    gex3x3_decode "E9139659937288", res
    mes "" + res(0) + " " + res(1) + " " + res(2) + " " + res(3)
```
setup(Windows):  
Download [HSP3.5](https://hsp.tv/make/hsp3.html), and Run  
to run:  
press the 'F5' key  

### in Reason
[Reason](https://reasonml.github.io/en/)  
[geo3x3.re](https://github.com/taisukef/Geo3x3/blob/master/reason/geo3x3.re),
[simple_geo3x3.re](https://github.com/taisukef/Geo3x3/blob/master/reason/simple_geo3x3.re)
```re
open Geo3x3

Js.log(encode(35.65858, 139.745433, 14))
Js.log(decode("E9139659937288"))
```
setup:
```bash
$ cd reason
$ yarn install
$ yarn bsb -make-world
```
to run:
```bash
$ node lib/js/simple_geo3x3.js
```

### in THPL
[The HTML Programming Language (THPL)](https://github.com/uhyo/the-html-programming-language)  
[Geo3x3.thpl.html](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.thpl.html)
```html
<p><output><abbr title="encode">35.65858<br/>139.745433<br/>14</abbr><wbr></output></p>
<p><abbr title="decode">E9139659937288</abbr></p>
```
to run:
```bash
$ open Geo3x3.thpl.html
```

### in Janet
[Janet](https://janet-lang.org/) [src on GitHub](https://github.com/janet-lang/janet)  
[geo3x3.janet](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.janet),
[simple_geo3x3.janet](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.janet)
```janet
(import ./geo3x3)

(print (geo3x3/encode 35.65858 139.745433 14))

(def pos (geo3x3/decode "E9139659937288"))
(print (0 pos) " " (1 pos) " " (2 pos) " " (3 pos))
```
setup:  
```bash
$ brew install janet
```
to run:
```bash
$ janet simple_geo3x3.janet
```

### in Phel
[Phel](https://phel-lang.org/) [src on  GitHub](https://github.com/phel-lang/phel-lang)  
[geo3x3.phel](https://github.com/taisukef/Geo3x3/blob/master/phel/src/geo3x3.phel),
[simpleGeo3x3.phel](https://github.com/taisukef/Geo3x3/blob/master/phel/src/simpleGeo3x3.phel)
```phel
(ns geo3x3\simpleGeo3x3
  (:require geo3x3\geo3x3))

(println (geo3x3/encode 35.65858 139.745433 14))
(println (geo3x3/decode "E9139659937288"))
```
setup:  
```bash
$ brew install php@7.4
```
setup [Composer](https://getcomposer.org/)
```
to run:
```bash
$ cd phel
$ composer install
$ ./vendor/bin/phel run geo3x3\\\\simpleGeo3x3
```

### in Raku
[Raku](https://raku.org/)  
[geo3x3.rakumod](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.rakumod),
[simpleGeo3x3.raku](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.raku)
```raku
use geo3x3;

say encode(35.65858, 139.745433, 14);
say decode("E9139659937288");
```
setup:  
```bash
$ brew install rakudo
```
to run:
```bash
$ raku -I . simple_geo3x3.raku
```

### in 文言
[文言](https://wy-lang.org/), [src on GitHub](https://github.com/wenyan-lang/wenyan)  
[Geo3x3_encode.wy](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3_encode.wy)
[(image)](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3_encode.wy.svg),
[Geo3x3_decode.wy](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3_decode.wy)
[(image)](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3_decode.wy.svg)
```文言
噫。施「编码」於三十五又六分五釐八毫五絲八忽。於一百三十九又七分四釐五毫四絲三忽二微。於一十四。
名之曰「酉辰」。
吾有一物。曰「酉辰」。
書之。

噫。施「解码」於「「E9139659937288」」。
名之曰「午辛」。
吾有一物。曰「午辛」。
書之。
```
setup:
```bash
$ npm install -g @wenyan/cli
```
to run:
```bash
$ wenyan Geo3x3_encode.wy
$ wenyan Geo3x3_decode.wy
```

### in Vala
[Vala](https://wiki.gnome.org/Projects/Vala)  
[geo3x3.vala](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.vala),
[simple_geo3x3.vala](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.vala)
```vala
void main (string[] args) {
    string code = Geo3x3.encode(35.65858, 139.745433, 14);
    stdout.printf ("%s\n",code);
    double[] res = Geo3x3.decode("E9139659937288");
    stdout.printf ("%.16f %.16f %.16f %.16f\n", res[0], res[1], res[2], res[3]);
}
```
setup:  
```bash
$ brew install vala
```
to run:
```bash
$ valac simple_geo3x3.vala geo3x3.vala -X -lm -o simple_geo3x3
$ ./simple_geo3x3
```

### in SmileBASIC
[SmileBASIC](https://www.petc4.smilebasic.com/)  
[geo3x3.prg](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.prg),
[simple_geo3x3.prg](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.prg)
```
?GEO3X3_ENCODE(35.65858,139.745433,14)
DIM RES[4]
GEO3X3_DECODE "E9139659937288",RES
?RES[0],RES[1],RES[2],RES[3]
```
setup:  
[プチコン3号](http://smilebasic.com/) or [プチコン4](https://www.petc4.smilebasic.com/)  
to run:  
download by 公開キー: 7BE333DJ  

## in Small Basic
[Small Basic](https://smallbasic-publicwebsite.azurewebsites.net/)  
[geo3x3.smallbasic](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.smallbasic)
```
lat = 35.65858
lng = 139.745433
level = 14
Geo3x3_encode()
TextWindow.WriteLine(res)

code = "E9139659937288"
Geo3x3_decode()
TextWindow.WriteLine(lat)
TextWindow.WriteLine(lng)
TextWindow.WriteLine(level)
TextWindow.WriteLine(unit)
```
setup:  
download [Small Basic](https://smallbasic-publicwebsite.azurewebsites.net/) or access [Small Basic](https://superbasic-v2.azurewebsites.net/)  
to run:
F5  
click "Run"  

## in Flix
[Flix](https://flix.dev/)  
[geo3x3.flix](https://github.com/taisukef/Geo3x3/blob/master/flix/src/Geo3x3.flix)
```
def main(_args: Array[String]): Int32 & Impure =
    println(Geo3x3.encode(35.65858, 139.745433, 14));
    println(Geo3x3.decode("E9139659937288"));
    0
```
setup:  
Setup JDK and download flix.jar from [https://github.com/flix/flix/releases/latest](https://github.com/flix/flix/releases/latest) and put filx/  
to run:
```
$ cd flix
$ java -jar flix.jar run
```

## in PowerShell
[PowerShell](https://docs.microsoft.com/ja-jp/powershell/)  
[geo3x3.psm1](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.psm1)  
[simple_geo3x3.ps1](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.ps1)
```
Import-Module -Name ./ -Verbose
$code = Encode-Geo3x3 35.65858 139.745433 14
Write-Output $code

$pos = Decode-Geo3x3 "E9139659937288"
Write-Output $pos
```
Setup(Not required on Windows):  
Setup(for Mac):  
```
$ brew install powershell
```
[How to setup](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7.2)  
to run:  
```
> ./simple_geo3x3.ps1
```
(for Mac)
```
$ pwsh
> ./simple_geo3x3.ps1
```

### in Koka
[Koka](https://koka-lang.github.io)  
[geo3x3.kk](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.kk),
[simple_geo3x3.kk](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.kk)
```
import geo3x3

fun main()
  geo3x3_encode(35.65858, 139.745433, 14).println
  val (lat,lng,level,unit) = geo3x3_decode("E9139659937288")
  lat.print; " ".print; lng.print; " ".print; level.print; " ".print; unit.print; " ".println;

```
setup:
```bash
$ brew install koka
```
to run:
```bash
$ koka -e simple_geo3x3.kk
```

### in Zig
[Zig](https://ziglang.org)  
[geo3x3.zig](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.zig),
[simple_geo3x3.zig](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.zig)
```
const geo3x3 = @import("geo3x3.zig");
const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    var enc = [_]u8{0}**14;
    try geo3x3.encode(35.65858, 139.745433, 14, &enc);
    try stdout.print("{s}\n",.{enc});

    var dec = [_]f64{0}**4;
    try geo3x3.decode("E9139659937288", &dec);
    try stdout.print("{} {} {d:.0} {}\n",.{dec[0],dec[1],dec[2],dec[3]});
}
```
setup:
```bash
$ brew install zig
```
to run:
```bash
$ zig run simple_geo3x3.zig
```

### in BanchaScript
[BanchaScript](https://github.com/taisukef/BanchaScript/)  
[Geo3x3.bancha](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.bancha),
[simple_geo3x3.bancha](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.bancha)
```
log(encode(35.65858, 139.745433, 14));
log(decode("E9139659937288"));
```
to run:
```bash
$ deno run -A https://taisukef.github.io/BanchaScript/bancha.js Geo3x3.bancha simple_geo3x3.bancha
```

### in AssemblyScript
[AssemblyScript](https://www.assemblyscript.org/)  
[assembly/index.ts](https://github.com/taisukef/Geo3x3/blob/master/asc/assembly/index.ts),
[simple_geo3x3.js](https://github.com/taisukef/Geo3x3/blob/master/asc/simple_geo3x3.js)
```
import * as Geo3x3 from "./build/release.js";

console.log(Geo3x3.encode(35.65858, 139.745433, 14));
console.log(Geo3x3.decode("E9139659937288"));
```
setup:
```bash
$ cd asc
$ npm install
$ npm run ascbuild
```
to run:
```bash
$ npm run simple
```


### in Clawn
[Clawn](https://github.com/Naotonosato/Clawn)  
[simple_geo3x3.clawn](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.clawn)
```
print(Geo3x3_encode(35.65858, 139.745433, 14))
res = Geo3x3_decode("E9139659937288")
print(float_to_str(res[0]) + ", " + float_to_str(res[1]) + ", " + float_to_str(res[2]) + ", " + float_to_str(res[3]))
```
setup: [Clawn#Installation](https://github.com/Naotonosato/Clawn#Installation)  
to run:
```bash
$ ./clawn simple_geo3x3.clawn
```
### in FORTRAN 77
[geo3x3_encode.for](https://github.com/taisukef/Geo3x3/blob/master/fortran77/geo3x3_decode.for)
```fortran77
      PROGRAM MAIN
      CHARACTER(50) GEO3X3_ENCODE
      PRINT*, GEO3X3_ENCODE(35.65858,139.745433,14)
      END PROGRAM MAIN
```
[geo3x3_decode.for](https://github.com/taisukef/Geo3x3/blob/master/fortran77/geo3x3_decode.for)
```fortran77
      PROGRAM MAIN
        IMPLICIT NONE
        CHARACTER(50) GEO3X3_DECODE
        PRINT*,GEO3X3_DECODE('E9139659937288')
      END PROGRAM MAIN
```
setup(APT):
```bash
$ apt install gfortran -y
```
to run:
```bash
$ cd fortran77
$ gfortran geo3x3_encode.for
$ ./a.out
$ gfortran geo3x3_decode.for
$ ./a.out
```

### in orelang
[orelang](https://github.com/code4fukui/orelang)  
[geo3x3.orelang](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.orelang)
[simple_geo3x3.orelang](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.orelang)
```
["step",
  ["call", "./geo3x3.orelang"],
  ["print", ["call", "geo3x3_encode", 35.65858, 139.745433, 14]],
  ["print", ["call", "geo3x3_decode", "E9139659937288"]]
]
```
to run:
```bash
$ deno run -A https://code4fukui.github.io/orelang/ore.js ./simple_geo3x3.orelang
```

### in Laze
[Laze](https://laze.ddns.net/)  
[simple_geo3x3.laze](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.laze)
```
関数: 実行() => (){
	表示(エンコード(35.65858, 139.745433, 14));
	配列<実数>: 結果 = デコード("E9139659937288");
	表示(結果.取得(0));
	表示(結果.取得(1));
	表示(結果.取得(2));
	表示(結果.取得(3));
}
```
to run: [Laze エディタ](https://laze.ddns.net/ja/editor)

### in WebAssembly
[WebAssembly](https://webassembly.org/)  
[geo3x3.wat](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.wat)
```
  (func (export "main")
    (f32.const 35.65858)
    (f32.const 139.745433)
    (i32.const 14)
    (call $encode)
    (call $log (i32.const 0) (i32.const 14))

    (call $decode)
    (call $log_f32 (f32.load (i32.const 0)))
    (call $log_f32 (f32.load (i32.const 4)))
    (call $log_f32 (f32.load (i32.const 8)))
    (call $log_f32 (f32.load (i32.const 12)))
  )
```
to run:
```bash
$ deno run -A https://code4fukui.github.io/WABT-es/wata.js geo3x3.wat --run
```

### in Nelua
[Nelua](https://nelua.io/)  
[geo3x3.nelua](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.nelua),
[simple_geo3x3.nelua](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.nelua)
```
require "geo3x3"

print(encode(35.65858, 139.745433, 14))

local pos = decode("E9139659937288")
print(pos[0], pos[1], pos[2], pos[3])
```
setup:
```bash
$ git clone https://github.com/edubart/nelua-lang.git && cd nelua-lang
$ make
$ sudo make install
```
to run:
```bash
$ nelua simple_geo3x3.nelua
```

### in Roland
[Roland](https://www.brick.codes/roland/)  
[geo3x3.rol](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.rol),
[simple_geo3x3.rol](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.rol)
```
import "geo3x3.rol";

proc main() {
  let code = encode(35.65858, 139.745433, 14);
  println(code);

  let res = decode("E9139659937288");
  println(f32_to_string(res[0]));
  println(f32_to_string(res[1]));
  println(f32_to_string(res[2]));
  println(f32_to_string(res[3]));
}
```  
setup:
```bash
$ git clone https://github.com/DenialAdams/roland.git
$ cd roland
$ cargo build --release
```
to run:
```bash
$ rolandc_cli simple_geo3x3.rol
$ wasmtime simple_geo3x3.wat
```

### in ReScript
[ReScript](https://rescript-lang.org/)  
[Geo3x3.res](https://github.com/taisukef/Geo3x3/blob/master/rescript/src/Geo3x3.res)
```
Js.log(Geo3x3.encode(35.65858, 139.745433, 14))
Js.log(Geo3x3.decode("E9139659937288"))
```  
setup:
```bash
$ npm i rescript
```
to run:
```bash
$ ./node_modules/rescript/rescript
$ node lib/es6/src/Geo3x3.bs.js
```

### in Effekt
[Effekt](https://effekt-lang.org/)  
[geo3x3.effekt](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.effekt),
[simple_geo3x3.effekt](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.effekt)
```
import geo3x3

def main() = {
  println(encode(35.65858, 139.745433, 14))
  println(decode("E9139659937288"))
}
```
setup:
```bash
$ npm install -g https://github.com/effekt-lang/effekt/releases/latest/download/effekt.tgz
```
to run:
```bash
$ effekt simple_geo3x3.effekt
```

### in Ceylon
[Ceylon](https://ceylon-lang.org/)  
[geo3x3.ceylon](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.ceylon)
```
shared void main() { 
  print(encode(35.65858, 139.745433, 14));
  print(decode("E9139659937288"));
}
```
setup:  
downlaod [Command line tools - Ceylon](https://ceylon-lang.org/download/)  
to run:
```bash
$ ceylon compile-js --source ./ Geo3x3.ceylon
$ ceylon run-js --run main default
```

### in Mochi
[Mochi](https://github.com/code4fukui/Mochi/)  
[geo3x3.mochi.js](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.mochi.js),
[simple_geo3x3_mochi_wasm.js](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3_mochi_wasm.js),
[simple_geo3x3_mochi_js.js](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3_mochi_js.js)
```
import { importWASM } from "https://code4fukui.github.io/Mochi/wasmutil.js";
const { i_encode, i_decode, memory } = await importWASM("./geo3x3.wasm");

const pccode = 0;
const res = i_encode(35.65858, 139.745433, 14, pccode);
const pccodemem = new Uint8Array(memory.buffer, 0, 14);
const code = new TextDecoder().decode(pccodemem);
console.log(res, code);

const pfres = 16;
const res2 = i_decode(pccode, pfres);
const geo2 = new Float32Array(memory.buffer, pfres, 4);
console.log(res2, geo2);
```
setup:  
install [Deno](https://deno.land/)  
to run:
```bash
$ deno run -A https://code4fukui.github.io/Mochi/mochic.js geo3x3.mochi.js --wasm
$ deno run -A simple_geo3x3_mochi_wasm.js
```

also run as JavaScript!
```bash
deno run -A simple_geo3x3_mochi_js.js
```

### in Neko
[Neko](https://nekovm.org)  
[geo3x3.neko](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.neko),
[simple_geo3x3.neko](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.neko)
```
var geo3x3 = $loader.loadmodule("geo3x3",$loader);

$print(geo3x3.encode(35.65858, 139.745433, 14) + "\n");
var res = geo3x3.decode("E9139659937288");
$print(res.lat + " " + res.lng + " " + res.level + " " + res.unit + "\n");
```
setup:
```bash
$ brew install neko
```
to run:
```bash
$ nekoc geo3x3.neko
$ nekoc simple_geo3x3.neko
$ neko simple_geo3x3.n
```

### in NekoML
[NekoML](https://nekovm.org/)  
[Geo3x3.nml](https://github.com/taisukef/Geo3x3/blob/master/Geo3x3.nml),
[Simple_geo3x3.nml](https://github.com/taisukef/Geo3x3/blob/master/Simple_geo3x3.nml)
```
print (Geo3x3.encode(35.65858, 139.745433, 14) + "\n");
var lat, lng, level, unit = Geo3x3.decode("E9139659937288");
print (lat + " " + lng + " " + level + " " + unit + "\n");
```
setup:
```bash
$ brew install neko
```
to run:
```bash
$ nekoml Geo3x3.nml
$ nekoml simple_geo3x3.nml
$ neko simple_geo3x3.n
```

### in LLVM IR
[LLVM IR](https://llvm.org/docs/LangRef.html) (LLVM/Xcode 15.x or later)  
[geo3x3.ll](https://github.com/taisukef/Geo3x3/blob/master/geo3x3.ll),
[simple_geo3x3.ll](https://github.com/taisukef/Geo3x3/blob/master/simple_geo3x3.ll)
```
  ;; call encode
  %buff = alloca [32 x i8]
  call i32 @encode(double 35.65858, double 139.745433, i8 14, ptr %buff, i64 32)
  call i32 (ptr, ...) @printf(ptr @.format.encode, ptr %buff)

  ;; call decode
  %plat = alloca double
  %plng = alloca double
  %plevel = alloca i8
  %punit = alloca double
  call i32 @decode(ptr @.str.code,
                   double* %plat, double* %plng, i8* %plevel, double* %punit)
  %lat = load double, double* %plat
  %lng = load double, double* %plng
  %level = load i8, i8* %plevel
  %level.32 = zext i8 %level to i32 ;solution for windows
  %unit = load double, double* %punit
  call i32 (ptr, ...) @printf(ptr @.format.decode,
                              double %lat, double %lng, i32 %level.32, double %unit)
```
setup:
```bash
$ brew install llvm
```
to run:
```bash
$ clang geo3x3.ll simple_geo3x3.ll
$ ./a.out
```

## How to contribute
1. add a lang
2. add a lang section in [README.md](README.md) (ex. [Neko](#in-Neko))
3. increment the number of languages at [Supported Languages](#supported-languages) section in [README.md](README.md)
4. add a link to the lang at [Supported Languages](#supported-languages) section in [README.md](README.md)
5. add a line in [langlist.csv](langlist.csv)
    - name: lang name
    - ext: src extension
    - struct: a structure of language (blacket, indent, end ...)
    - variable: how to describe variables
    - const: how to describe constants
    - type: language type (AltJS, compile ...)
    - sample: link to the src of geo3x3

## History
ver 1.05 2021-03-01 change coding (origin lat:90 lng:0 → lat:-90 lng:0)  
ver 1.04 2021-02-22 fixed WGS84  
ver 1.03 2021-02-20 support int encoded, license CC BY -> CC0 (Public Domain)  
ver 1.02 2013-02-18 write in Java, license CC BY-ND -> CC BY  
ver 1.01 2012-01-15 change coding  
ver 1.00 2012-01-15 first release  

## Creator
Taisuke Fukuno  
https://twitter.com/taisukef  
https://fukuno.jig.jp/139  
https://fukuno.jig.jp/205  
https://fukuno.jig.jp/3131  
