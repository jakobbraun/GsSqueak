image save/restore
writeImageFileIO: numberOfBytesToWrite
	"Actually emit the first numberOfBytesToWrite object memory bytes onto the snapshot."

	| headerSize file |
	objectMemory bytesPerWord = 4 ifFalse: [self error: 'Not rewritten for 64 bits yet'].
	headerSize := 64.

	[
		file := (FileStream fileNamed: imageName) binary.
		file == nil ifTrue: [^nil].
	
		{
			self imageFormatVersion.
			headerSize.
			numberOfBytesToWrite.
			objectMemory startOfMemory.
			(objectMemory getSpecialObjectsOop).
			(objectMemory getLastHash).
			self ioScreenSize.
			fullScreenFlag.
			extraVMMemory
		}
			do: [:long | self putLong: long toFile: file].

		{	desiredNumStackPages. 	self unknownShortOrCodeSizeInKs } do:
			[:short| self putShort: short toFile: file].

		self putLong: desiredEdenBytes toFile: file.

		{	maxExtSemTabSizeSet ifTrue: [self ioGetMaxExtSemTableSize] ifFalse: [0]. 0 } do:
			[:short| self putShort: short toFile: file].

		"Pad the rest of the header."
		4 timesRepeat: [self putLong: 0 toFile: file].
	
		"Position the file after the header."
		file position: headerSize.
	
		"Write the object memory."
		objectMemory startOfMemory // 4 + 1
			to: numberOfBytesToWrite // 4
			do: [:index |
				self
					putLong: (objectMemory getMemory at: index)
					toFile: file].
	
		self success: true
	]
		ensure: [file close]