converting
withBlanksTrimmed
	"Return a copy of the receiver from which leading and trailing blanks have been trimmed."

	| first last |
	first := string indexOfAnyOf: CharacterSet nonSeparators startingAt: 1.
	first = 0 ifTrue: [ ^'' ].  "no non-separator character"
	last := string lastIndexOfAnyOf: CharacterSet nonSeparators startingAt: self size ifAbsent: [self size].
	(first = 1 and: [ last = self size ]) ifTrue: [ ^self copy ].
	^self
		copyFrom: first
		to: last
