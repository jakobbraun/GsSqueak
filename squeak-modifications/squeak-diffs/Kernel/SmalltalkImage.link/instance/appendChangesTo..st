sources, changes log
appendChangesTo: sourcesName

	"Condense changes to the end of the given sources file.
	If the file is the same as Smalltalk sourcesName, then just append
	the changes. If the file is different, then copy the sources file and
	append the changes afterwards."

	"Smalltalk appendChangesTo: 'test123.sources'"

	"To verify correctness of the operation run the following code:
	[	| sourceMap |
		sourceMap := Dictionary new.

		(CompiledMethod allInstances select:[:cm| cm isInstalled]) do:[:cm|
			sourceMap at: cm methodReference put: 
				(cm getSourceFor: cm selector in: cm methodClass)].
		Smalltalk allClassesAndTraitsDo:[:aClass|
			sourceMap at: aClass put: aClass comment].

		Smalltalk appendChangesTo: 'verify.sources'.

		(CompiledMethod allInstances select:[:cm| cm isInstalled]) do:[:cm|
			self assert: (sourceMap at: cm methodReference) =
				(cm getSourceFor: cm selector in: cm methodClass)].
		Smalltalk allClassesAndTraitsDo:[:aClass|
			self assert: (sourceMap at: aClass) = aClass comment].
	]"

	| fullName sourcesFile |
	fullName := FileDirectory default fullNameFor: sourcesName.
	(fullName endsWith: '.sources') ifFalse: [ fullName := fullName , '.sources' ].
	fullName = Smalltalk sourcesName ifFalse:[
		"Copy sources file; change file name accordingly"
		FileStream forceNewFileNamed: fullName do: [ :newFile |
			sourcesFile := (SourceFiles at: 1) readOnlyCopy.
			FileDirectory default copyFile: sourcesFile toFile: newFile.
			sourcesFile position: 0 ].
		self setMacFileInfoOn: fullName.
		"Change to the new sources file and reopen"
		self 
			closeSourceFiles ;
			sourceFileVersionString: ((FileDirectory localNameFor: fullName) allButLast: '.sources' size) ;
			openSourceFiles.
	].

	"We've copied the old to the new sources file; reopen the sources file read/write"
	sourcesFile := SourceFiles at: 1.
	sourcesFile close; open: sourcesFile fullName forWrite: true. "should be openReadWrite"
	sourcesFile setToEnd; timeStamp "remember when we did this".

	"Copy method sources from changes to sources"
	CompiledMethod allInstances do:[:method|
		(method isInstalled and:[method fileIndex = 2]) ifTrue:[
			| class selector category preamble changeList index chgRec string source |
			class := method methodClass.
			selector := method selector.
			source := class sourceCodeAt: selector.
			category := class organization categoryOfElement: selector.
			preamble := class name, ' methodsFor: ', category asString printString,
							' stamp: ', method timeStamp printString.

			"Find the last version in the sources file; link up the prior: version"
			changeList := ChangeSet scanVersionsOf: method 
				class: class meta: class isMeta category: category  selector: selector.
			index := changeList findLast:[:any| any fileIndex = 1].
			index > 0 ifTrue:[
				chgRec := changeList at: index.
				preamble := preamble, ' prior: ', (SourceFiles 
					sourcePointerFromFileIndex: chgRec fileIndex 
					andPosition: chgRec position) printString].

			"append to sources file"
			sourcesFile setToEnd; cr; nextPut: $!; nextChunkPut: preamble; cr.
			string := RemoteString newString: source onFileNumber: 1 toFile: sourcesFile.
			sourcesFile nextChunkPut: ' '.
			method setSourcePosition: string position inFile: 1
		].
	] displayingProgress: 'Moving changes...'.

	"Copy class comments from changes to sources"
	self  allClassesAndTraitsDo: [:classOrTrait | 
		classOrTrait moveClassCommentTo: sourcesFile fileIndex: 1.
	].

	"We've moved everything; reopen the source files"
	self closeSourceFiles; openSourceFiles.

	"Former changes are now in .sources, no need for them in .changes.  Condense them."
	self condenseChanges
