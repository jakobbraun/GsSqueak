*SqClasses-scripting
evaluateUnloggedForSelf: aCodeString

	^Compiler evaluate:
		aCodeString
		for: self
