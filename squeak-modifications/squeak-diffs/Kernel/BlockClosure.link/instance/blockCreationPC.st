scanning
blockCreationPC
	"Answer the pc for the bytecode that created the receuver."
	| method |
	method := self method.
	^method encoderClass
		pcOfBlockCreationBytecodeForBlockStartingAt: startpc
		in: method

