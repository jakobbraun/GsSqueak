image save/restore
dumpImage: fileName
	"Dump the entire image out to the given file. Intended for debugging only."
	| f dataSize result |
	<export: true>
	<var: #fileName type: 'char *'>
	<var: #f type: 'sqImageFile'>

	f := self cCode: 'sqImageFileOpen(fileName, "wb")'.
	f = nil ifTrue: [^-1].
	dataSize := objectMemory getEndOfMemory - objectMemory startOfMemory.
	result := self cCode: 'sqImageFileWrite(pointerForOop(memory), sizeof(unsigned char), dataSize, f)'.
	self cCode: 'sqImageFileClose(f)'.
	^result
