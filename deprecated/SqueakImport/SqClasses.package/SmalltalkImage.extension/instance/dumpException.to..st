*SqClasses-*SqClasses-*SqClasses-miscellaneous
dumpException: ex to: aFilename

	self 
		logError: ex description 
		inContext: ex signalerContext
		to: aFilename
