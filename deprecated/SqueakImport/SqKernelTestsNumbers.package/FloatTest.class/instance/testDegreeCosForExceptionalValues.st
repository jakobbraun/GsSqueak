tests - mathematical functions
testDegreeCosForExceptionalValues
	self assert: Float nan degreeCos isNaN.
	self assert: Float infinity degreeCos isNaN.
	self assert: Float negativeInfinity degreeCos isNaN.