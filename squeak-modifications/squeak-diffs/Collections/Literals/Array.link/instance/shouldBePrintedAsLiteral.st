testing
shouldBePrintedAsLiteral

	^self class == Array
	  and: [self shouldBePrintedAsLiteralVisiting: (IdentitySet new: 8)]
