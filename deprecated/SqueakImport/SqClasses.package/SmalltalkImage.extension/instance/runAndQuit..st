*SqClasses-*SqClasses-*SqClasses-command line
runAndQuit: aBlock 
	self
		run: aBlock
		snapshotAs: nil
		andQuit: true
