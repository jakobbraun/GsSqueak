analyzing
cgForPixelValue: pv orNot: not 
	"Return the center of gravity for all pixels of value pv.
	Note: If orNot is true, then produce the center of gravity for all pixels
	that are DIFFERENT from the supplied (background) value"
	| xAndY |
	xAndY := (Array
				with: (self xTallyPixelValue: pv orNot: not)
				with: (self yTallyPixelValue: pv orNot: not))
				collect: [:profile | 
					| pixCount weighted |
					"For both x and y profiles..."
					pixCount := 0.
					weighted := 0.
					profile
						doWithIndex: [:t :i | 
							pixCount := pixCount + t.
							weighted := weighted + (t * i)].
					pixCount = 0
						ifTrue: ["Produce average of nPixels weighted by
							coordinate "
							0.0]
						ifFalse: [weighted asFloat / pixCount asFloat - 1.0]].
	^ xAndY first @ xAndY last"
	| f cg |
	[Sensor anyButtonPressed] whileFalse:
	[f := Form fromDisplay: (Sensor cursorPoint extent: 50@50).
	cg := f cgForPixelValue: (Color black pixelValueForDepth: f depth)
	orNot: false.
	f displayAt: 0@0.
	Display fill: (cg extent: 2@2) fillColor: Color red].
	ScheduledControllers restor
	"