process primitives
primitiveLongRunningPrimitiveSemaphore
	"Primitive. Install the semaphore to be used for collecting long-running primitives, 
	 or nil if no semaphore should be used."
	| sema |
	<export: true>
	sema := self stackValue: 0.
	((objectMemory isIntegerObject: sema)
	or: [self methodArgumentCount ~= 1]) ifTrue:
		[^self primitiveFail].
	sema = objectMemory nilObject
		ifTrue:
			[longRunningPrimitiveCheckSemaphore := nil]
		ifFalse:
			[(objectMemory fetchClassOfNonInt: sema) = (objectMemory splObj: ClassSemaphore) ifFalse:
				[^self primitiveFail].
			 longRunningPrimitiveCheckSemaphore := sema].
	self voidLongRunningPrimitive: 'install'.
	self pop: 1