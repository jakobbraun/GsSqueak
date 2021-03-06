fileIn/out
updateFromResource
	| pathName newMorph f |
	(pathName := self valueOfProperty: #resourceFilePath)
		ifNil: [^ self].
	(pathName asLowercase endsWith: '.morph')
		ifTrue: [newMorph := (FileStream readOnlyFileNamed: pathName) fileInObjectAndCode.
			newMorph isMorph
				ifFalse: [^ self error: 'Resource not a single morph']]
		ifFalse: [f := Form fromFileNamed: pathName.
			f
				ifNil: [^ self error: 'unrecognized image file format'].
			newMorph := World drawingClass withForm: f].
	newMorph setProperty: #resourceFilePath toValue: pathName.
	self owner replaceSubmorph: self by: newMorph