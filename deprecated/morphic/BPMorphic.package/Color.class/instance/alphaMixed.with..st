transformations
alphaMixed: proportion with: aColor 
	"Answer this color mixed with the given color. The proportion, a
	number 
	between 0.0 and 1.0, determines what what fraction of the receiver
	to 
	use in the mix. For example, 0.9 would yield a color close to the 
	receiver. This method uses RGB interpolation; HSV interpolation can
	lead 
	to surprises. Mixes the alphas (for transparency) also."
	| _gsSqueakTemp_frac1 _gsSqueakTemp_frac2 |
	_gsSqueakTemp_frac1 := proportion asFloat min: 1.0 max: 0.0.
	_gsSqueakTemp_frac2 := 1.0 - _gsSqueakTemp_frac1.
	^ Color
		r: self red * _gsSqueakTemp_frac1 + (aColor red * _gsSqueakTemp_frac2)
		g: self green * _gsSqueakTemp_frac1 + (aColor green * _gsSqueakTemp_frac2)
		b: self blue * _gsSqueakTemp_frac1 + (aColor blue * _gsSqueakTemp_frac2)
		alpha: self alpha * _gsSqueakTemp_frac1 + (aColor alpha * _gsSqueakTemp_frac2)