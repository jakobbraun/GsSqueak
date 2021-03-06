primitive support
maybeMapPrimitiveFunctionPointerBackToSomethingEvaluable
	"In the real VM primitiveFunctionPointer is either an index (for quick
	primitives) or a proper function pointer to a primitive. In the simulator
	it may be a small
	index (corresponding to a quick primitive index), a symbol
	(corresponding to
	a function pointer) or an index into the externalPrimitiveTable, or an
	invalid address that references an evaluable in the
	simulatedTrampolines dictionary
	of the Cogit. The simulator expects dispatchFunctionPointer to be
	called with
	primitiveFunctionPointer being a symbol only for internal primitives.
	External primitives must have their funciton pointer mapped back to
	an index. This
	method does the reverse mapping."
	(self isExternalPrimitiveCall: newMethod)
		ifTrue: [| pfp index externalIndex |
			"External prims must be evaluated by the right plugin..."
			pfp := primitiveFunctionPointer.
			index := self mappedPluginEntries
						findFirst: [:entry | entry second == primitiveFunctionPointer].
			self assert: index ~= 0.
			externalIndex := 1000
						+ (externalPrimitiveTable object
								indexOf: index
								ifAbsent: [self error: 'entry not found']).
			self
				assert: ((self pluginEntryFor: externalIndex) notNil
						and: [(self pluginEntryFor: externalIndex) second == primitiveFunctionPointer]).
			primitiveFunctionPointer := externalIndex]