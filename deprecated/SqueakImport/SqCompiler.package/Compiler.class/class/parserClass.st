accessing
parserClass
	"Answer a parser class to use for parsing methods compiled by instances of the receiver."

	^ GemstoneSmalltalk _env0 classNamed: 'SqParser'
