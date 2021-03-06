*SqClasses-instance variables
instVarIndexFor: instVarName ifAbsent: aBlock
	"Answer the index of the named instance variable."

	| index |
	index := self instVarNames
		ifNil: [ 0 ]
		ifNotNil: [ self instVarNames indexOf: instVarName ].
	index = 0 ifTrue: [
		^ superClass
			ifNil: [ aBlock value ]
			ifNotNil: [ superClass instVarIndexFor: instVarName ifAbsent: aBlock ] ].
	^ superClass
		ifNil: [ index ]
		ifNotNil: [ index + superClass instSize ]
