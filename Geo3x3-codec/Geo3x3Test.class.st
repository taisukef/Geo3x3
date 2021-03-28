Class {
	#name : #Geo3x3Test,
	#superclass : #TestCase,
	#category : #'Geo3x3-codec'
}

{ #category : #tests }
Geo3x3Test >> testDecode [
	self
		assert: #(-40.0 -86.2962962962963 6 0.7407407407407408)
		equals: (Geo3x3 decode: 'W28644').
	self
		assert: #(-11.111111111111114 105.55555555555556 5.0 2.2222222222222223)
		equals: (Geo3x3 decode: 'E5379').
	self
		assert: #(-40.0 93.7037037037037 6 0.7407407407407408)
		equals: (Geo3x3 decode: 'E28644').
	self
		assert: #(35.6586337900162 139.74546563023935 14 0.00011290058538953522)
		equals: (Geo3x3 decode: 'E9139659937288')

]

{ #category : #tests }
Geo3x3Test >> testEncode [
	| accepts |
	accepts := #((W W2 W28 W286 W2864 W28644 W286445 W2864455 W28644555)).
	#((-40.0 -86.2962962962963)) doWithIndex: [:params :i |
		1 to: 9 do: [:level |
			self
				assert: ((accepts at: i) at: level)
				equals: (Geo3x3 encodeLatitude: params first andLongitude: params second withLevel: level)
		]
	]
]
