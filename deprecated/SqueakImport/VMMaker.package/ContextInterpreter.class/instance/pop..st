contexts
pop: nItems
	"Note: May be called by translated primitive code."

	stackPointer := stackPointer - (nItems * objectMemory bytesPerWord).