memory access
long64AtPointer: pointer put: longValue 
	"This gets implemented by Macros in C, where its types will also be
	checked. pointer is a raw address, and longValue is the width of a
	machine word."
	^ self halt