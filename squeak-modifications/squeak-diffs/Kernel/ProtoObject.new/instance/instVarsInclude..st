system primitives
instVarsInclude: anObject
"Answers true if anObject is among my named or indexed instance variables, and false otherwise"

	1 to: self class instSize do:
		[:i | (self instVarAt: i) == anObject ifTrue: [^ true]].
	1 to: self basicSize do:
		[:i | (self basicAt: i) == anObject ifTrue: [^ true]].
	^ false
