menus
transferStateToRenderer: aRenderer 
	"Transfer knownName, actorState, visible, and player info over to
	aRenderer, which is being imposed above me as a transformation
	shell "
	| current |
	(current := self actorStateOrNil)
		ifNotNil: [aRenderer actorState: current.
			self actorState: nil].
	(current := self knownName)
		ifNotNil: [aRenderer setNameTo: current.
			self setNameTo: nil].
	(current := self player)
		ifNotNil: [aRenderer player: current.
			self player rawCostume: aRenderer].
	aRenderer simplySetVisible: self visible