*SqCollectionLiterals-*SqCollectionLiterals-accessing
at: index put: aCharacter
	"Primitive. Store the Character in the field of the receiver indicated by
	the index. Fail if the index is not an Integer or is out of bounds, or if
	the argument is not a Character. Essential. See Object documentation
	whatIsAPrimitive."

	<primitive: 293> "GemStone primitive"
	aCharacter isCharacter 
		ifFalse:[^self errorImproperStore].
	aCharacter isOctetCharacter ifFalse:[
		"Convert to WideString"
		self _env0 _convertToQuadByte.
		^self at: index put: aCharacter.
	].
	index isInteger
		ifTrue: [self errorSubscriptBounds: index]
		ifFalse: [self errorNonIntegerIndex]
