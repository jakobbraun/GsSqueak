C code generation
emitCCodeAsPointerDereferenceOn: aStream level: level generator: aCodeGen
	"If appropriate, translate this message send as a pointer dereference"

	(self isStructSend: aCodeGen) ifFalse:
		[^false].

	aStream nextPut: $(.
	receiver  emitCCodeAsExpressionOn: aStream level: 0 generator: aCodeGen.
	aStream nextPut: $-; nextPut: $>.
	aStream nextPutAll: (aCodeGen cFunctionNameFor: selector).
	arguments isEmpty ifFalse:
		[self assert: arguments size = 1.
		 aStream nextPutAll: ' = '.
		 arguments first emitCCodeAsExpressionOn: aStream level: level generator: aCodeGen].
	aStream nextPut: $).
	^true