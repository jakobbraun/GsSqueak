*SqClasses-accessing method dictionary
selectorsAndMethodsDo: selectorAndMethodBlock
	"Evaluate the two argument selectorAndMethodBlock for all the selector/method pairs in my method dictionary."

	^ self methodDict keysAndValuesDo: selectorAndMethodBlock
