query assembly
codeReferencingClassNamed: aSymbol

	^ '({1} classNamed: {2})' format: {
			self codeReferencingMe.
			aSymbol storeString}