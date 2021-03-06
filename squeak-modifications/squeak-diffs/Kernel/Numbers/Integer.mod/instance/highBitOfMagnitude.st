bit manipulation
highBitOfMagnitude
	"Answer the index of the high order bit of the magnitude of the  
	receiver, or zero if the receiver is zero.  
	This method is used for LargeNegativeIntegers as well,  
	since Squeak's LargeIntegers are sign/magnitude."
	| realLength lastDigit |
	realLength := self digitLength.
	[(lastDigit := self digitAt: realLength) = 0]
		whileTrue: [(realLength := realLength - 1) = 0 ifTrue: [^ 0]].
	^ lastDigit highBitOfByte + (8 * (realLength - 1))