*SqClasses-enumerating
allInstancesDo: aBlock
	"There should be only one"
	destClass class == self ifTrue:[^aBlock value: destClass].
	^super allInstancesDo: aBlock
