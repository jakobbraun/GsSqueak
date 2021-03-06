*SqCollectionLiterals-*SqCollectionLiterals-*SqCollectionLiterals-*SqByteArray-platform independent access
unsignedLongAt: index put: value bigEndian: bigEndian
	"Store a 32-bit unsigned integer quantity starting from the given byte index"
	
	value isLarge
		ifTrue: [
			bigEndian ifFalse: [
				self
					replaceFrom: index
					to: index + 3
					with: value
					startingAt: 1.
				^value ].
			self
				at: index put: (value digitAt: 4);
				at: index + 1 put: (value digitAt: 3);
				at: index + 2 put: (value digitAt: 2);
				at: index +3 put: (value digitAt: 1) ]
		ifFalse: [
			bigEndian ifFalse: [
				self 
					at: index put: (value bitAnd: 16rFF);
					at: index + 1 put: ((value bitShift: -8) bitAnd: 16rFF);
					at: index + 2 put: ((value bitShift: -16) bitAnd: 16rFF);
					at: index + 3 put: (value bitShift: -24).
				^value ].
			self 
				at: index put: (value bitShift: -24);
				at: index + 1 put: ((value bitShift: -16) bitAnd: 16rFF);
				at: index + 2 put: ((value bitShift: -8) bitAnd: 16rFF);
				at: index + 3 put: (value bitAnd: 16rFF) ].
	^value
