stack pages
allOnesAsCharStar
	^ self
		cCoerceSimple: (objectMemory wordSize = 8
				ifTrue: [-1 signedIntToLong64]
				ifFalse: [-1 signedIntToLong])
		to: #'char *'