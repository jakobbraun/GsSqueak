memory access
longAt: byteAddress put: a32BitValue
	"Note: Adjusted for Smalltalk's 1-based array indexing."
	<doNotGenerate>
	self assert: (byteAddress bitAnd: self bytesPerWord - 1) == 0.
	^stackMemory at: byteAddress // self bytesPerWord + indexOffset put: a32BitValue