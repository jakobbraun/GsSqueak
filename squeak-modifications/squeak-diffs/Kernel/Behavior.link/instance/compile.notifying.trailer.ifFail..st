compiling
compile: code notifying: requestor trailer: bytes ifFail: failBlock
	"Compile code without logging the source in the changes file"

	| methodNode |
	methodNode  := self newCompiler
				compile: code
				in: self
				notifying: requestor
				ifFail: failBlock.
	^ CompiledMethodWithNode generateMethodFromNode: methodNode trailer: bytes.
