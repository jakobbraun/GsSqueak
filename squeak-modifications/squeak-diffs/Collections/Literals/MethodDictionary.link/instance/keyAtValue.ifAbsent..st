accessing
keyAtValue: value ifAbsent: exceptionBlock
	"Answer the key whose value equals the argument, value. If there is
	none, answer the result of evaluating exceptionBlock."
	
	  self _env0
	    keysAndValuesDo: [ :aKey :aValue | 
	      anObject = aValue
		ifTrue: [ ^ aKey ] ].
	  ^ aBlock value
