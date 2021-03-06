color mapping
colormapToARGB
	"Return a ColorMap mapping from the receiver into canonical ARGB
	space. "
	self hasNonStandardPalette
		ifTrue: [^ self colormapFromARGB inverseMap].
	self depth <= 8
		ifTrue: [^ ColorMap
				shifts: #(0 0 0 0 )
				masks: #(16711680 65280 255 4278190080 )
				colors: (Color colorMapIfNeededFrom: self depth to: 32)].
	self depth = 16
		ifTrue: [^ ColorMap shifts: #(9 6 3 0 ) masks: #(31744 992 31 0 )].
	self depth = 32
		ifTrue: [^ ColorMap shifts: #(0 0 0 0 ) masks: #(16711680 65280 255 4278190080 )].
	self error: 'Bad depth'