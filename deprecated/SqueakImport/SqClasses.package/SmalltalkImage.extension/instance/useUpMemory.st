*SqClasses-*SqClasses-*SqClasses-memory space
useUpMemory
	"For testing the low space handler..."
	"Smalltalk installLowSpaceWatcher; useUpMemory"

	| lst |
	lst := nil.
	[ lst := Link nextLink: lst ] repeat
