transformations
* aNumberOrArray 
	"Answer this color with its RGB multiplied by the given number, or
	multiply this color's RGB values by the corresponding entries in the
	given array."
	"(Color brown * 2) display"
	"(Color brown * #(1 0 1)) display"
	| _gsSqueakTemp_multipliers |
	_gsSqueakTemp_multipliers := aNumberOrArray isCollection
				ifTrue: [aNumberOrArray]
				ifFalse: [Array
						with: aNumberOrArray
						with: aNumberOrArray
						with: aNumberOrArray].
	^ Color basicNew
		setPrivateRed: (self privateRed * _gsSqueakTemp_multipliers first) asInteger
		green: (self privateGreen * _gsSqueakTemp_multipliers second) asInteger
		blue: (self privateBlue * _gsSqueakTemp_multipliers third) asInteger