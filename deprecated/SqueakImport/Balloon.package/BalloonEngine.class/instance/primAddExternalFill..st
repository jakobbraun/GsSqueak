primitives-adding
primAddExternalFill: index
	
	(self canProceedAfter: self primGetFailureReason) ifTrue:[
		^self primAddExternalFill: index
	].
	^ 0