primitives-adding
primAddOvalFrom: start to: end fillIndex: fillIndex borderWidth: width borderColor: pixelValue32
	
	(self canProceedAfter: self primGetFailureReason) ifTrue:[
		^self primAddOvalFrom: start to: end fillIndex: fillIndex borderWidth: width borderColor: pixelValue32
	].
	^ 0