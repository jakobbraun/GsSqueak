testing
atEnd
	"Primitive. Answer whether the receiver can access any more objects.
	Optional. See Object documentation whatIsAPrimitive."

	^ position >= readLimit
