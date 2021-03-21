Class {
	#name : #Geo3x3Simple,
	#superclass : #Object,
	#category : #'Geo3x3-codec'
}

{ #category : #tests }
Geo3x3Simple >> main [
    Transcript show: (Geo3x3 encodeLatitude: 35.65858 andLongitude: 139.745433 withLevel: 14); cr.
    Transcript show: (Geo3x3 decode: 'E9139659937288'); cr.
]
