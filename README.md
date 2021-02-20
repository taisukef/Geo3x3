Geo3x3 ver 1.03
======

## what is Geo3x3
geo zone encoding  
(JavaScript / Java / Python / Ruby / C / C++)  

## sample app
https://taisukef.github.io/Geo3x3/  

## creator
Taisuke Fukuno  
http://twitter.com/taisukef  
http://fukuno.jig.jp/139  
http://fukuno.jig.jp/205  
https://fukuno.jig.jp/3131  

## licence
CC0  
https://creativecommons.jp/sciencecommons/aboutcc0/  

## doc
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

## how to use

in HTML
```
<script type=module>
import { Geo3x3 } from "https://taisukef.github.io/Geo3x3/Geo3x3.mjs";
console.log(Geo3x3.decode("W28644"));
</script>
```

in Deno
```
import { Geo3x3 } from "https://taisukef.github.io/Geo3x3/Geo3x3.mjs";
console.log(Geo3x3.decode("W28644"));
```

in Node.js
```
import { Geo3x3 } from "./Geo3x3.mjs";
console.log(Geo3x3.decode("W28644"));
```

in Python
```
import geo3x3
## get Geo3x3 code from latitude / longitude / level
code = geo3x3.encode(35.65858, 139.745433, 14)
print(code) # E3793653391822

## get location from Geo3x3 code
pos = geo3x3.decode('E3793653391822')
print(pos) # (35.658633790016204, 139.74546563023935, 14, 0.00011290058538953522)
```

in Ruby
```
require "./geo3x3"
code = Geo3x3.encode(35.65858, 139.745433, 14)
p code # "E3793653391822"

pos = Geo3x3.decode('E3793653391822')
p pos # [35.658633790016204, 139.74546563023935, 14, 0.00011290058538953522]
```

in Java
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

in C/C++
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

## history
ver 1.03 2021.2.20 support int encoded, license CC BY -> CC0 (Public Domain)  
ver 1.02 2013.2.18 write in Java, lincense CC BY-ND -> CC BY  
ver 1.01 2012.1.15 change coding  
ver 1.00 2012.1.15 first release  
