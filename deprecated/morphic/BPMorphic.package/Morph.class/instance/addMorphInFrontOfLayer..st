WiW support
addMorphInFrontOfLayer: aMorph 
	| targetLayer |
	targetLayer := aMorph morphicLayerNumberWithin: self.
	submorphs
		do: [:each | 
			| layerHere |
			each == aMorph
				ifTrue: [^ self].
			layerHere := each morphicLayerNumberWithin: self.
			"the <= is the difference - it insures we go to the front of our
			layer "
			targetLayer <= layerHere
				ifTrue: [^ self addMorph: aMorph inFrontOf: each]].
	self addMorphBack: aMorph