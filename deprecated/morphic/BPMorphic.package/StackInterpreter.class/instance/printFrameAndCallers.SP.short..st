debug printing
printFrameAndCallers: theFP SP: theSP short: printShort 
	(stackPages couldBeFramePointer: theFP)
		ifFalse: [^ nil].
	(self isBaseFrame: theFP)
		ifFalse: [self
				printFrameAndCallers: (self frameCallerFP: theFP)
				SP: (self frameCallerSP: theFP)
				short: printShort].
	printShort
		ifTrue: [self shortPrintFrame: theFP.
			^ nil].
	self cr.
	self printFrame: theFP WithSP: theSP