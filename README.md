Geo3x3 ver 1.03
======

## what is Geo3x3
geo zone encoding

## creator
Taisuke Fukuno  
http://twitter.com/taisukef  
http://fukuno.jig.jp/205  
http://fukuno.jig.jp/2012/geo3x3  

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

in Deno / Node.js
```
import { Geo3x3 } from "https://taisukef.github.io/Geo3x3/Geo3x3.mjs";
console.log(Geo3x3.decode("W28644"));
```


## history
ver 1.03 2021.2.20 support int encoded, license CC BY -> CC0 (Public Domain)  
ver 1.02 2013.2.18 write in Java, lincense CC BY-ND -> CC BY  
ver 1.01 2012.1.15 change coding  
ver 1.00 2012.1.15 first release  
