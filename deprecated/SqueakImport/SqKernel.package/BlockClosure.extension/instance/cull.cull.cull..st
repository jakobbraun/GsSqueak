*SqKernel-evaluating
cull: firstArg cull: secondArg cull: thirdArg
	"Activate the receiver, with three or less arguments."
	
	self numArgs >= 2 ifTrue: [ 
		self numArgs >= 3 ifTrue: [ ^self value: firstArg value: secondArg value: thirdArg ].
		^self value: firstArg value: secondArg ].
	self numArgs = 1 ifTrue: [ ^self value: firstArg ].
	^self value

