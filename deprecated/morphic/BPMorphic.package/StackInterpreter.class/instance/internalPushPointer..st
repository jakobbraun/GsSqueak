internal interpreter access
internalPushPointer: pointerValue 
	"In the StackInterpreter stacks grow down."
	nativeSP := (self nativeStackPointerIn: localFP)
				- objectMemory bytesPerOop.
	self nativeStackPointerIn: localFP put: nativeSP.
	"In the StackInterpreter stacks grow down."
	stackPages pointerAtPointer: nativeSP - 1 put: pointerValue