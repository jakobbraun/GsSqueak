*SqCollectionLiterals-*SqCollectionLiterals-*SqCollectionLiterals-*SqByteArray-platform independent access
signedByteAt: index put: anInteger
	"Store an 8-bit signed integer quantity at the given byte index."
	
	anInteger >= 0 ifTrue: [ ^self at: index put: anInteger ].
	self at: index put: anInteger + 16r100.
	^anInteger
