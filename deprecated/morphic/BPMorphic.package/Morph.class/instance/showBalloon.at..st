halos and balloon help
showBalloon: msgString at: point 
	"Pop up a balloon containing the given string."
	self isInWorld
		ifFalse: [^ self].
	(msgString isNil
			or: [msgString isEmpty])
		ifTrue: [^ self].
	(self balloonMorphClass string: msgString for: self balloonHelpAligner)
		popUpAt: point