conversions
pixelWordForDepth: depth 
	"Return to a 32-bit word that concatenates enough copies of the
	receiver's pixel value to fill the word (i.e., 32/depth copies). Depth
	should be one of 1, 2, 4, 8, 16, or 32. The pixel value should be an
	integer in 0..2^depth-1."
	| _gsSqueakTemp_pixelValue |
	_gsSqueakTemp_pixelValue := self pixelValueForDepth: depth.
	^ self pixelWordFor: depth filledWith: _gsSqueakTemp_pixelValue