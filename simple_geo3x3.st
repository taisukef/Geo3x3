FileStream fileIn: 'Geo3x3.st'

(Geo3x3 encodeLatitude:35.65858 andLongitude:139.745433 withLevel:14) printNl.
anArray := Geo3x3 decode:'E9139659937288'.
(anArray at: 1) printNl.
(anArray at: 2) printNl.
(anArray at: 3) printNl.
(anArray at: 4) printNl.
