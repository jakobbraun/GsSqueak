memory access
uint32AtPointer: pointer put: value 
	"This gets implemented by Macros in C, where its types will also be
	checked. pointer is a raw address, and the result is an 32 bit integer."
	^ self longAt: pointer put: value