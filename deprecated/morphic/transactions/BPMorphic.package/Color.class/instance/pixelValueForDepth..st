conversions
pixelValueForDepth: d 
	"Answers an integer representing the bits that appear in a single pixel
	of this color in a Form of the given depth.
	The depth must be one of 1, 2, 4, 8, 16, or 32. Contrast with
	pixelWordForDepth: and bitPatternForDepth:, which
	answer either a 32-bit word packed with the given pixel value or a
	multiple-word Bitmap containing a pattern.
	The inverse is the class message colorFromPixelValue:depth:"
	"Details:
	For depths of 8 or less, the result is a colorMap index.
	For depths of 16 and 32, it is a direct color value with 5 or 8 bits per
	color component."
	"Transparency:
	The pixel value zero is reserved for transparent.
	For depths greater than 8, black maps to the darkest possible blue."
	| _gsSqueakTemp_val |
	d > 8
		ifTrue: ["most common case"
			d = 32
				ifTrue: ["eight bits per component; top 8 bits set to all ones
					(opaque alpha)"
					"this subexpression is a SmallInteger in both 32- and
					64-bits. "
					_gsSqueakTemp_val := ((rgb bitShift: -6)
								bitAnd: 16711680)
								bitOr: (((rgb bitShift: -4)
										bitAnd: 65280)
										bitOr: ((rgb bitShift: -2)
												bitAnd: 255)).
					"16rFF000000 & 16rFF000001 are LargeIntegers in
					32-bits, SmallIntegers in 64-bits."
					^ _gsSqueakTemp_val = 0
						ifTrue: [4278190081]
						ifFalse: [4278190080 + _gsSqueakTemp_val]].
			d = 16
				ifTrue: ["five bits per component; top bits ignored"
					_gsSqueakTemp_val := (((rgb bitShift: -15)
								bitAnd: 31744)
								bitOr: ((rgb bitShift: -10)
										bitAnd: 992))
								bitOr: ((rgb bitShift: -5)
										bitAnd: 31).
					^ _gsSqueakTemp_val = 0
						ifTrue: [1]
						ifFalse: [_gsSqueakTemp_val]].
			d = 12
				ifTrue: ["for indexing a color map with 4 bits per color
					component "
					_gsSqueakTemp_val := (((rgb bitShift: -18)
								bitAnd: 3840)
								bitOr: ((rgb bitShift: -12)
										bitAnd: 240))
								bitOr: ((rgb bitShift: -6)
										bitAnd: 15).
					^ _gsSqueakTemp_val = 0
						ifTrue: [1]
						ifFalse: [_gsSqueakTemp_val]].
			d = 9
				ifTrue: ["for indexing a color map with 3 bits per color
					component "
					_gsSqueakTemp_val := (((rgb bitShift: -21)
								bitAnd: 448)
								bitOr: ((rgb bitShift: -14)
										bitAnd: 56))
								bitOr: ((rgb bitShift: -7)
										bitAnd: 7).
					^ _gsSqueakTemp_val = 0
						ifTrue: [1]
						ifFalse: [_gsSqueakTemp_val]]].
	d = 8
		ifTrue: [^ self closestPixelValue8].
	d = 4
		ifTrue: [^ self closestPixelValue4].
	d = 2
		ifTrue: [^ self closestPixelValue2].
	d = 1
		ifTrue: [^ self closestPixelValue1].
	self error: 'unknown pixel depth: ' , d printString