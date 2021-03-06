*VMMaker-translation
initializeCodeGenerator: cg
	"Load a code generator with classes in a manner suitable for generating
	code for this class."

	| cls |
	cls := self.
	[cls == Object]
		whileFalse:
			[cg addClass: cls.
			cls := cls superclass].
	cg uncheckedAbstractMethods addAll: self uncheckedAbstractSelectors.
	^cg
