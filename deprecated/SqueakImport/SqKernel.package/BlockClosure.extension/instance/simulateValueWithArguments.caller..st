*SqKernel-system simulation
simulateValueWithArguments: anArray caller: aContext
	"Simulate the valueWithArguments: primitive. Fail if anArray is not an array of the right arity."
	| newContext sz |
	newContext := (Context newForMethod: outerContext method)
						setSender: aContext
						receiver: outerContext receiver
						method: outerContext method
						closure: self
						startpc: startpc.
	((newContext objectClass: anArray) ~~ Array
	 or: [self numArgs ~= anArray size]) ifTrue:
		[^Context primitiveFailTokenFor: nil].
	sz := self basicSize.
	newContext stackp: sz + self numArgs.
	1 to: self numArgs do:
		[:i| newContext at: i put: (anArray at: i)].
	1 to: sz do:
		[:i| newContext at: i + self numArgs put: (self at: i)].
	^newContext

