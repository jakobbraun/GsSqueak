instance creation
colorFromPixelValue: p depth: d 
	"Convert a pixel value for the given display depth into a color."
	"Details: For depths of 8 or less, the pixel value is simply looked up in a
	table. For greater depths, the color components are extracted and
	converted into a color."
	| _gsSqueakTemp_r _gsSqueakTemp_g _gsSqueakTemp_b _gsSqueakTemp_alpha |
	d = 8
		ifTrue: [^ IndexedColors at: (p bitAnd: 255)
					+ 1].
	d = 4
		ifTrue: [^ IndexedColors at: (p bitAnd: 15)
					+ 1].
	d = 2
		ifTrue: [^ IndexedColors at: (p bitAnd: 3)
					+ 1].
	d = 1
		ifTrue: [^ IndexedColors at: (p bitAnd: 1)
					+ 1].
	d = 16 | (d = 15)
		ifTrue: ["five bits per component"
			_gsSqueakTemp_r := (p bitShift: -10)
						bitAnd: 31.
			_gsSqueakTemp_g := (p bitShift: -5)
						bitAnd: 31.
			_gsSqueakTemp_b := p bitAnd: 31.
			(_gsSqueakTemp_r = 0
					and: [_gsSqueakTemp_g = 0])
				ifTrue: [_gsSqueakTemp_b = 0
						ifTrue: [^ Color transparent].
					_gsSqueakTemp_b = 1
						ifTrue: [^ Color black]].
			^ Color
				r: _gsSqueakTemp_r
				g: _gsSqueakTemp_g
				b: _gsSqueakTemp_b
				range: 31].
	d = 32
		ifTrue: ["eight bits per component; 8 bits of alpha"
			_gsSqueakTemp_r := (p bitShift: -16)
						bitAnd: 255.
			_gsSqueakTemp_g := (p bitShift: -8)
						bitAnd: 255.
			_gsSqueakTemp_b := p bitAnd: 255.
			_gsSqueakTemp_alpha := p bitShift: -24.
			_gsSqueakTemp_alpha = 0
				ifTrue: [^ Color transparent].
			(_gsSqueakTemp_r = 0
					and: [_gsSqueakTemp_g = 0
							and: [_gsSqueakTemp_b = 0]])
				ifTrue: [^ Color transparent].
			_gsSqueakTemp_alpha < 255
				ifTrue: [^ (Color
						r: _gsSqueakTemp_r
						g: _gsSqueakTemp_g
						b: _gsSqueakTemp_b
						range: 255)
						alpha: _gsSqueakTemp_alpha asFloat / 255.0]
				ifFalse: [^ Color
						r: _gsSqueakTemp_r
						g: _gsSqueakTemp_g
						b: _gsSqueakTemp_b
						range: 255]].
	d = 12
		ifTrue: ["four bits per component"
			_gsSqueakTemp_r := (p bitShift: -8)
						bitAnd: 15.
			_gsSqueakTemp_g := (p bitShift: -4)
						bitAnd: 15.
			_gsSqueakTemp_b := p bitAnd: 15.
			^ Color
				r: _gsSqueakTemp_r
				g: _gsSqueakTemp_g
				b: _gsSqueakTemp_b
				range: 15].
	d = 9
		ifTrue: ["three bits per component"
			_gsSqueakTemp_r := (p bitShift: -6)
						bitAnd: 7.
			_gsSqueakTemp_g := (p bitShift: -3)
						bitAnd: 7.
			_gsSqueakTemp_b := p bitAnd: 7.
			^ Color
				r: _gsSqueakTemp_r
				g: _gsSqueakTemp_g
				b: _gsSqueakTemp_b
				range: 7].
	self error: 'unknown pixel depth: ' , d printString