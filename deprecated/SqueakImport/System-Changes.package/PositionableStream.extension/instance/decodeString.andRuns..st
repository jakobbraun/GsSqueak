*System-Changes-fileIn/Out
decodeString: string andRuns: runsRaw

	| strm runLength runValues newString index |
	strm := runsRaw readStream.
	(strm peekFor: $( ) ifFalse: [^ nil].
	runLength := OrderedCollection new.
	[strm skipSeparators.
	 strm peekFor: $)] whileFalse: 
		[runLength add: (Number readFrom: strm)].

	runValues := OrderedCollection new.
	[strm atEnd not] whileTrue: 
		[runValues add: (Number readFrom: strm).
		strm next.].

	newString := WideString new: string size.
	index := 1.
	runLength with: runValues do: [:length :leadingChar |
		index to: index + length - 1 do: [:pos |
			newString at: pos put: (Character leadingChar: leadingChar code: (string at: pos) charCode).
		].
		index := index + length.
	].

	^ newString.
