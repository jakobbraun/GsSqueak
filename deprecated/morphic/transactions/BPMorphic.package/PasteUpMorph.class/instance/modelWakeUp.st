user interface
modelWakeUp
	"I am the model of a SystemWindow, that has just been activated"
	owner isNil
		ifTrue: [^ self].
	"Not in Morphic world"
	(owner isKindOf: TransformMorph)
		ifTrue: [^ self viewBox: self fullBounds].
	self containingWindow
		ifNotNil: [:aWindow | self viewBox = aWindow panelRect
				ifFalse: [self viewBox: aWindow panelRect]]