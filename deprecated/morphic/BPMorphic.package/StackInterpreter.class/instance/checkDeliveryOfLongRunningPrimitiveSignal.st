primitive support
checkDeliveryOfLongRunningPrimitiveSignal
	"Check for a hit of the longRunningPrimitive probe and if so attempt to
	signal the
	longRunningPrimitiveCheckSemaphore. Answer if a process switch
	occurred as a result."
	(longRunningPrimitiveStopUsecs > longRunningPrimitiveStartUsecs
			and: ["a hit"
				longRunningPrimitiveCheckSemaphore notNil
					and: ["deliverable"
						longRunningPrimitiveSignalUndelivered]])
		ifTrue: ["but not yet delivered"
			longRunningPrimitiveSignalUndelivered := false.
			longRunningPrimitiveGCUsecs := (objectMemory gcStartUsecs < longRunningPrimitiveStopUsecs
							and: [objectMemory statGCEndUsecs > longRunningPrimitiveStartUsecs])
						ifTrue: [objectMemory statGCEndUsecs - objectMemory gcStartUsecs]
						ifFalse: [0].
			"Signal the LRP check semaphore if it is present"
			^ self synchronousSignal: longRunningPrimitiveCheckSemaphore].
	^ false