access
allSymbols
	"Answer all interned symbols"
	
	^Array
		new: self gemstoneSymbolTable size
		streamContents:[ :stream |
			stream nextPutAll: self gemstoneSymbolTable ]
