halos and balloon help
showBalloon: msgString
	"Pop up a balloon containing the given string."

	self isInWorld ifFalse: [^ self].
	(msgString isNil or: [msgString isEmpty]) ifTrue: [^ self].
	
	(self balloonMorphClass
		string: msgString
		for: self balloonHelpAligner)
			popUp.