*SqClasses-debugging-haltOnce
haltOnce: aString 
	"Halt unless we have already done it once."
	self haltOnceEnabled
		ifTrue: [self clearHaltOnce.
			^ self halt: aString]
