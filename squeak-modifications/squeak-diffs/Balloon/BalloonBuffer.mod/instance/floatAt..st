accessing
floatAt: index
	"For simulation only"
	
	^Float fromIEEE32Bit: (self basicAt: index)