callback support
callbackLeave: cbID
	"Leave from a previous callback"
	<export: true>

	"For now, do not allow a callback unless we're in a primitiveResponse"
	primitiveIndex = 0 ifTrue:[^false].

	"Check if this is the top-level callback"
	cbID = jmpDepth ifFalse:[^false].
	cbID < 1 ifTrue:[^false].
	"This is ugly but necessary, or otherwise the Mac will not build"
	self long: (jmpBuf at: jmpDepth) jmp: 1.
