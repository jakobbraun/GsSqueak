accessing
byteAt: index put: value
	
	self at: index put: value asCharacter.
	^value
