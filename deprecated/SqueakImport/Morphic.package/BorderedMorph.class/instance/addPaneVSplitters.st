resize handling
addPaneVSplitters

	| remaining targetX sameX |
	remaining := self paneMorphs reject: [:each |
		each layoutFrame rightFraction = 1
			or: [each layoutFrame hasFixedWidth]].
	[remaining notEmpty] whileTrue:
		[targetX := remaining first layoutFrame rightFraction.
		sameX := self paneMorphs select: [:each | each layoutFrame rightFraction = targetX].
		self addPaneVSplitterBetween: remaining first and: sameX.
		remaining := remaining copyWithoutAll: sameX]