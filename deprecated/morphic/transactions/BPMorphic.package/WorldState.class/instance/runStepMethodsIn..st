stepping
runStepMethodsIn: aWorld 
	"Perform periodic activity inbetween event cycles"
	"Limit processing of deferredUIMessages to a max. amount of time"
	| queue msg limit stamp |
	limit := self class deferredExecutionTimeLimit.
	stamp := Time millisecondClockValue.
	queue := self class deferredUIMessages.
	[(Time millisecondsSince: stamp)
			>= limit
		or: [(msg := queue nextOrNil) == nil]]
		whileFalse: [msg value].
	self runLocalStepMethodsIn: aWorld