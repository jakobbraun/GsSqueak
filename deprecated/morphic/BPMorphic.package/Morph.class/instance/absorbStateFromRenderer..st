menus
absorbStateFromRenderer: aRenderer 
	"Transfer knownName, actorState, visible, and player info over from
	aRenderer, which was formerly imposed above me as a transformation
	shell but is now going away."
	| current |
	(current := aRenderer actorStateOrNil)
		ifNotNil: [self actorState: current.
			aRenderer actorState: nil].
	(current := aRenderer knownName)
		ifNotNil: [self setNameTo: current.
			aRenderer setNameTo: nil].
	(current := aRenderer player)
		ifNotNil: [self player: current.
			current rawCostume: self.
			aRenderer player: nil].
	self visible: aRenderer visible