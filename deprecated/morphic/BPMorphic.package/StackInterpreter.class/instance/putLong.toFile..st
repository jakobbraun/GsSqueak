image save/restore
putLong: aLong toFile: aFile 
	"Append aLong to aFile in this platform's 'natural' byte order. aLong is
	either 32 or 64 bits,
	depending on ObjectMemory. (Bytes will be swapped, if necessary,
	when the image is read
	on a different platform.) Set successFlag to false if the write fails."
	| _gsSqueakTemp_objectsWritten |
	_gsSqueakTemp_objectsWritten := self
				cCode: [self
						sq: (self addressOf: aLong)
						Image: (self sizeof: #sqInt)
						File: 1
						Write: aFile]
				inSmalltalk: [| value |
					value := aLong.
					objectMemory wordSize
						timesRepeat: [aFile
								nextPut: (value bitAnd: 255).
							value := value >> 8].
					1].
	self success: _gsSqueakTemp_objectsWritten = 1