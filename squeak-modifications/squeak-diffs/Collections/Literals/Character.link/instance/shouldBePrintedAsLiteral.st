testing
shouldBePrintedAsLiteral

	| integerValue |
	(integerValue := self asInteger) < 33 ifTrue: [ ^false ].
	255 < integerValue ifTrue: [ ^false ].
	^integerValue ~= 127
