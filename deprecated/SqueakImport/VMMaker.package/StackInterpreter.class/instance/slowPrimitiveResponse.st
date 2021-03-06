primitive support
slowPrimitiveResponse
	"Called under the assumption that primFunctionPtr has been preloaded"
	| nArgs savedFramePointer savedStackPointer |
	<inline: true>
	<asmLabel: false>
	<var: #savedFramePointer type: #'char *'>
	<var: #savedStackPointer type: #'char *'>
	FailImbalancedPrimitives ifTrue:
		[nArgs := argumentCount.
		 savedStackPointer := stackPointer.
		 savedFramePointer := framePointer].
	self initPrimCall.
	self dispatchFunctionPointer: primitiveFunctionPointer.
	(FailImbalancedPrimitives
	and: [self successful
	and: [framePointer = savedFramePointer]]) ifTrue:"Don't fail if primitive has done something radical, e.g. perform:"
		[stackPointer ~= (savedStackPointer + (nArgs * objectMemory bytesPerWord)) ifTrue:
			[self flag: 'Would be nice to make this a message send of e.g. unbalancedPrimitive to the current process or context'.
			 "This is necessary but insufficient; the result may still have been written to the stack.
			   At least we'll know something is wrong."
			 stackPointer := savedStackPointer.
			 self failUnbalancedPrimitive]].
	"If we are profiling, take accurate primitive measures"
	nextProfileTick > 0 ifTrue:
		[self checkProfileTick: newMethod].
	^self successful