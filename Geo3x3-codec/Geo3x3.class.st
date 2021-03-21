"
https://code4sabae.github.io/geo3x3-map/
"
Class {
	#name : #Geo3x3,
	#superclass : #Object,
	#category : #'Geo3x3-codec'
}

{ #category : #decoding }
Geo3x3 class >> coords: code [
	| pos x y u2 |
	pos := self decode: code.
	x := pos first.
	y := pos second.
	u2 := pos fourth / 2.
	^ {y - u2. x - u2. y - u2. x + u2. y + u2. x + u2. y + u2. x - u2}
]

{ #category : #decoding }
Geo3x3 class >> decode: codeIntOrStr [
	| code firstChar isW unit lat lng level |
	code := nil.
	(codeIntOrStr isKindOf: Integer)
		ifTrue: [code := codeIntOrStr < 0
			ifTrue: ['W', codeIntOrStr negated] 
			ifFalse: ['E', codeIntOrStr]
		].
	((codeIntOrStr isKindOf: String) and: [codeIntOrStr notEmpty])
		ifTrue: [code := codeIntOrStr].
	code ifNil: [^ self error: 'invalid code'].

	firstChar := code first.
	isW := '-W' includes: firstChar.
	(isW or: ['+E' includes: firstChar]) ifTrue: [code := code allButFirst].

	unit := 180.0.
	lat := 0.0.
	lng := 0.0.
	level := 1.

	[:exit | code do: [:digitChar |
		| n |
		n := digitChar digitValue.
		n = 0 ifTrue: [exit value].

		unit := unit / 3.
		n := n - 1.
		lng := lng + (n \\ 3 * unit).
		lat := lat + (n // 3 * unit).
		level := level + 1
	]] valueWithExit.

	lat := lat + (unit / 2).
	lng := lng + (unit / 2).
	lat := lat - 90.
	isW ifTrue: [lng := lng - 180.0].

	^ {lat. lng. level. unit}

]

{ #category : #encoding }
Geo3x3 class >> encodeLatitude: latNum andLongitude: lngNum withLevel: level [
	| lat lng |
	level < 1 ifTrue: [^''].
	lat := latNum asFloat.
	lng := lngNum asFloat.

	^String streamContents: [:ss |
		| unit |
		ss nextPut: (lng >= 0 ifTrue: [$E] ifFalse: [lng := lng + 180. $W]).
		lat := lat + 90.
		unit := 180.0.
		level - 1 timesRepeat: [
			| x y |
			unit := unit / 3.
			x := (lng / unit) truncated.
			y := (lat / unit) truncated.
			x + (y * 3) + 1 printOn: ss.
			lng := lng - (x * unit).
			lat := lat - (y * unit)
		]
	]
]

{ #category : #encoding }
Geo3x3 class >> encodeToIntFromLatitude: lat andLongitude: lng withLevel: level [
	| code result |
	code := self encodeLatitude: lat andLongitude: lng withLevel: level.
	result := code allButFirst asInteger.
	code first == $W ifTrue: [result := result negated].
	^ result
]
