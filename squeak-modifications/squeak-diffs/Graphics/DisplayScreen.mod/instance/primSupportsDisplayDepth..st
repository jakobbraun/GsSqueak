other
primSupportsDisplayDepth: pixelDepth
	"Return true if this pixel depth is supported on the current host platform.
	Primitive. Optional."

	^ pixelDepth = 32 "GsSqueak only supports 32bit"
