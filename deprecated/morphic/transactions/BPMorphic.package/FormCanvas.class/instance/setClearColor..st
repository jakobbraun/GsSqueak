private
setClearColor: aColor 
	"Install a new clear color - e.g., a color is used for clearing the
	background "
	| _gsSqueakTemp_clearColor |
	_gsSqueakTemp_clearColor := aColor
				ifNil: [Color transparent].
	_gsSqueakTemp_clearColor isColor
		ifFalse: [(_gsSqueakTemp_clearColor isKindOf: InfiniteForm)
				ifFalse: [^ self error: 'Cannot install color'].
			^ port fillPattern: _gsSqueakTemp_clearColor;
				 combinationRule: Form over].
	"Okay, so clearColor really *is* a color"
	port sourceForm: nil.
	port combinationRule: Form over.
	port fillPattern: _gsSqueakTemp_clearColor.
	self depth = 8
		ifTrue: ["Use a stipple pattern"
			port
				fillColor: (form balancedPatternFor: _gsSqueakTemp_clearColor)]