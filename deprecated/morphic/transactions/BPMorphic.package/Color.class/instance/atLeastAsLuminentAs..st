transformations
atLeastAsLuminentAs: aFloat 
	| _gsSqueakTemp_revisedColor |
	_gsSqueakTemp_revisedColor := self.
	[_gsSqueakTemp_revisedColor luminance < aFloat]
		whileTrue: [_gsSqueakTemp_revisedColor := _gsSqueakTemp_revisedColor slightlyLighter].
	^ _gsSqueakTemp_revisedColor