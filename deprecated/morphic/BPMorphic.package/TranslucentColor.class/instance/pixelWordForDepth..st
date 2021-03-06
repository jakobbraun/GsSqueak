conversions
pixelWordForDepth: depth 
	"Return the pixel value for this color at the given depth. Translucency
	only works in RGB; this color will appear either opaque or transparent
	at all other depths."
	| _gsSqueakTemp_basicPixelWord |
	alpha = 0
		ifTrue: [^ 0].
	_gsSqueakTemp_basicPixelWord := super pixelWordForDepth: depth.
	depth < 32
		ifTrue: [^ _gsSqueakTemp_basicPixelWord]
		ifFalse: [^ (_gsSqueakTemp_basicPixelWord bitAnd: 16777215)
				bitOr: (alpha bitShift: 24)]