submorphs-add/remove
deleteUnlessHasFocus
	"Runs on a step timer because we cannot be guaranteed to get focus change events."
	(ActiveHand keyboardFocus ~= self and: [ self isInWorld ]) ifTrue:
		[ self
			 stopSteppingSelector: #deleteUnlessHasFocus ;
			 delete ]