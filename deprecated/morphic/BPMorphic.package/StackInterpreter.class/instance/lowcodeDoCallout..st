inline primitive ffi abi
lowcodeDoCallout: functionPointer 
	self undoFetchNextBytecode.
	self externalizeIPandSP.
	self lowcodeCalloutState: lowcodeCalloutState callFunction: functionPointer.
	self internalizeIPandSP.
	self reloadLowcodeStateAfterCallout.
	self fetchNextBytecode.
	^ self lowcodeCalloutStateFetchResultFloat32: lowcodeCalloutState