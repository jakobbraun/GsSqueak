debug printing
printUnbalancedStackFromNamedPrimitive
	| lit |
	<inline: false>
	self print: 'Stack unbalanced after '.
	self successful 
		ifTrue:[self print:'successful '] 
		ifFalse:[self print: 'failed '].
	lit := self literal: 0 ofMethod: newMethod.
	self printStringOf: (objectMemory fetchPointer: 1 ofObject: lit).
	self print:' in '.
	self printStringOf: (objectMemory fetchPointer: 0 ofObject: lit).
	self cr.
		