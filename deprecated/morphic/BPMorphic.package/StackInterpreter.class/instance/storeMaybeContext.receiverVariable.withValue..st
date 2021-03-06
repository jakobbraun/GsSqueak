stack bytecodes
storeMaybeContext: obj receiverVariable: fieldIndex withValue: anOop 
	"Must trap accesses to married and widowed contexts.
	But don't want to check on all inst var accesses. This
	method is only used by the long-form bytecodes, evading the cost."
	((self isWriteMediatedContextInstVarIndex: fieldIndex)
			and: [(objectMemory isContextNonImm: obj)
					and: [(self isMarriedOrWidowedContext: obj)
							or: [self is: fieldIndex methodAssignmentToContextWithMachineCodePC: anOop]]])
		ifTrue: [self
				instVar: fieldIndex
				ofContext: obj
				put: anOop]
		ifFalse: [objectMemory
				storePointerImmutabilityCheck: fieldIndex
				ofObject: obj
				withValue: anOop]