*SqClasses-*SqClasses-*SqClasses-miscellaneous
handleUserInterrupt
	Preferences cmdDotEnabled ifTrue:
		[[Project current interruptName: 'User Interrupt'] fork]
