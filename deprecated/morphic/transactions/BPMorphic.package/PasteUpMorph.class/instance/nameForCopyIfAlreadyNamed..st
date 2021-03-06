misc
nameForCopyIfAlreadyNamed: aMorph 
	"Answer a name to set for a copy of aMorph if aMorph itself is named,
	else nil"
	| usedNames |
	^ aMorph knownName
		ifNotNil: [:aName | 
			usedNames := self allKnownNames.
			Utilities
				keyLike: aName
				satisfying: [:f | (usedNames includes: f) not]]