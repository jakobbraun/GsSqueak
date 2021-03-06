*SqClasses-compiling
compile: code environment: anEnvironment notifying: requestor trailer: bytes ifFail: failBlock
	"Compile code in another Environment without logging the source in the changes file"

	| methodNode |
	methodNode  := self newCompiler
				compile: code
				in: self
				environment: anEnvironment
				notifying: requestor
				ifFail: failBlock.
	^ CompiledMethodWithNode generateMethodFromNode: methodNode trailer: bytes.
