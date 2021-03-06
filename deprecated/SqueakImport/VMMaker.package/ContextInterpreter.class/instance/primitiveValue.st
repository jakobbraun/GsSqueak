control primitives
primitiveValue
	| blockContext blockArgumentCount initialIP |
	blockContext := self stackValue: argumentCount.
	blockArgumentCount := self argumentCountOfBlock: blockContext.
	self success: (argumentCount = blockArgumentCount
			and: [(objectMemory fetchPointer: CallerIndex ofObject: blockContext) = objectMemory getNilObj]).
	self successful
		ifTrue: [self transfer: argumentCount
				fromIndex: self stackPointerIndex - argumentCount + 1
				ofObject: activeContext
				toIndex: TempFrameStart
				ofObject: blockContext.

			"Assume: The call to transfer:... makes blockContext a root if necessary,
			 allowing use to use unchecked stored in the following code."
			self pop: argumentCount + 1.
			initialIP := objectMemory fetchPointer: InitialIPIndex	ofObject: blockContext.
			objectMemory storePointerUnchecked: InstructionPointerIndex ofObject: blockContext withValue: initialIP.
			self storeStackPointerValue: argumentCount inContext: blockContext.
			objectMemory storePointerUnchecked: CallerIndex ofObject: blockContext withValue: activeContext.
			self newActiveContext: blockContext]